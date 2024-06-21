Return-Path: <linux-kernel+bounces-224158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEEE911DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C67B233F7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1778517D895;
	Fri, 21 Jun 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UsFO+6jv"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5213616EC19
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956516; cv=none; b=ksapy2kp2k7yZmjH55ClAEYiivB17y5xB0Eu9beMuyIZ5XCY9udgVZllOb6pYP3NTytyelAmXqmKO3ACWzOLX/sbdWDAtOG+/arRyLciWpcSVdQ1YYki3PidrgHFL5LHBTvWZe0BK4Umj8IpcD9fpIn4tvAr5caX0lGk6uDv0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956516; c=relaxed/simple;
	bh=CNJoKmOJG8f4fgj5rPkIJlw0KkteLIjSIgyHyFopqbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJ5SOge0wbgGcESLT/5IJWRgQ8pOXhek0RLjZGdWDe3zcvHAAlDueAbtEj6jbFpz+YKolEwv3+g3PtUFdBHbeRptkOJlr+pLweyPnOVAcSJsI+iXhDlwDPtCh1FM02HDqgCsW4DKgs01hlLgtFIXKdOrV6Hpsy+XHiXSqZopgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UsFO+6jv; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718956512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Sw5yRtWHNEncebzoxSE8G3qpCoVdCgLAzOgxBxk0ok=;
	b=UsFO+6jvoTUIca3cM8LE6Q/FLwwPh2O7GrjHMbrKFS456cQzZL2wll0WrqklJKIbpOcaSh
	Od4d/qgiEbIfG4KtxQUenDjLLejLnjX7OCF5iw6KSalGLSin40c+pRTS6KtuLwPcNe4IRB
	MOoc6qc2MR7WB2d7s1utSWzdz6ivOHU=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hughd@google.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: aarcange@redhat.com
X-Envelope-To: shr@devkernel.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Fri, 21 Jun 2024 15:54:30 +0800
Subject: [PATCH v2 2/3] mm/ksm: don't waste time searching stable tree for
 fast changing page
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-b4-ksm-scan-optimize-v2-2-1c328aa9e30b@linux.dev>
References: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
In-Reply-To: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718956503; l=2616;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=CNJoKmOJG8f4fgj5rPkIJlw0KkteLIjSIgyHyFopqbI=;
 b=pKzOj1vYEVS8cLcJdoc/uLdiP+G/dkr/63SxIyokg2j6ABqeJkQHe1BneY9VkMaHaMJbezD2Y
 UKiUVY+NP24AbVV8kQrFJvtlLG8q10a1K7l3UEu74G5jaVQWrvAxiQR
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
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
index 1427abd18627..2cf836fb1367 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2370,6 +2370,23 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
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
@@ -2400,21 +2417,6 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
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
2.45.2


