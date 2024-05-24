Return-Path: <linux-kernel+bounces-188494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAA88CE2B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E017AB21958
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DC12A14B;
	Fri, 24 May 2024 08:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E5m6I8de"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFC7129A77
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541065; cv=none; b=ojHPHArpZq4kEqvp9d/9YrwBiRvyzJ1VBT92rndCD/aPz/f4AcKEFACGPhQTNfG8REase+DQd4Hmn7vil6/JgMqIPl7dCUYf85PmPSWHt0GgFy1uCTJUGz5m3Z73oI0ktnsRucPojP79m0GEEnGNNtiVyIJ0G68p+MwBYHktblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541065; c=relaxed/simple;
	bh=1G8p4ukUYdMOk654nZZJtD5LJSaJbjnQHPtspc5amuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eu5jCUqbmmvvKQBc1IRZc2ZzzvdWyTqgMoAPMWiHrXMRT/nuXm1x+9zL0VcYaTe8YK9wsDTYWfmBgsFGWO3mvvuf7JSY4g36S+uI6JfCDXv/9UPyNhRnuT5thjaQ1myjDaeTXKwrDz9HKQ0ARA1PQXFqcpdO2Az7xNmcK+79Bfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E5m6I8de; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716541060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrbgcBme4gf384UGODzdSyOVXcWHfhExwH5eqJcgItc=;
	b=E5m6I8deIoqw6vq/84vM96nA3u/7CWXC5h8vgVpVwMJUh9OwqPhQXgVDBobdnZCcRDd2Gc
	B5HXL/d0UK9N+vBSADHhJzUu5BnEttIHr756vbu3OZuMvZ340tmEvLOGgNm72mD3NyGRsH
	zGXnHf/1q761IrZcj6NTN3l/RrrjkK0=
X-Envelope-To: hughd@google.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: shr@devkernel.io
X-Envelope-To: david@redhat.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Fri, 24 May 2024 16:56:51 +0800
Subject: [PATCH 2/4] mm/ksm: don't waste time searching stable tree for
 fast changing page
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-b4-ksm-scan-optimize-v1-2-053b31bd7ab4@linux.dev>
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
In-Reply-To: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541051; l=2614;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=1G8p4ukUYdMOk654nZZJtD5LJSaJbjnQHPtspc5amuo=;
 b=CYjqK00M2lLdR7+WKq2pN5yhtp9lGVF60p4EeSzgxNV31x3wCoi5EIyOTEKvBZMWRWTvsRgmg
 N2x1EYuvlGYA6VQKuU6yVelvTy0n7Rt4HTLV50/OImvqxM243FfBbNl
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

The code flow in cmp_and_merge_page() is suboptimal for handling the
ksm page and non-ksm page at the same time. For example:

- ksm page
 1. Mostly just return if this ksm page is not migrated and this rmap_item
    has been on the rmap hlist. Or we have to fix this rmap_item mapping.
 2. But we absolutely don't need to checksum for this ksm page, since it
    can't change.

- non-ksm page
 1. First don't need to waste time searching stable tree if fast changing.
 2. Should try to merge with zero page before search the stable tree.
 3. Then search stable tree to find mergeable ksm page.

This patch optimizes the code flow so the handling differences between
ksm page and non-ksm page become clearer and more efficient too.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index cbd4ba7ea974..2424081f386e 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2366,6 +2366,23 @@ static noinline void cmp_and_merge_page(struct page *page, struct ksm_rmap_item
 		 */
 		if (!is_page_sharing_candidate(stable_node))
 			max_page_sharing_bypass = true;
+	} else {
+		remove_rmap_item_from_tree(rmap_item);
+
+		/*
+		 * If the hash value of the page has changed from the last time
+		 * we calculated it, this page is changing frequently: therefore we
+		 * don't want to insert it in the unstable tree, and we don't want
+		 * to waste our time searching for something identical to it there.
+		 */
+		checksum = calc_checksum(page);
+		if (rmap_item->oldchecksum != checksum) {
+			rmap_item->oldchecksum = checksum;
+			return;
+		}
+
+		if (!try_to_merge_with_zero_page(rmap_item, page))
+			return;
 	}
 
 	/* We first start with searching the page inside the stable tree */
@@ -2396,21 +2413,6 @@ static noinline void cmp_and_merge_page(struct page *page, struct ksm_rmap_item
 		return;
 	}
 
-	/*
-	 * If the hash value of the page has changed from the last time
-	 * we calculated it, this page is changing frequently: therefore we
-	 * don't want to insert it in the unstable tree, and we don't want
-	 * to waste our time searching for something identical to it there.
-	 */
-	checksum = calc_checksum(page);
-	if (rmap_item->oldchecksum != checksum) {
-		rmap_item->oldchecksum = checksum;
-		return;
-	}
-
-	if (!try_to_merge_with_zero_page(rmap_item, page))
-		return;
-
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {

-- 
2.45.1


