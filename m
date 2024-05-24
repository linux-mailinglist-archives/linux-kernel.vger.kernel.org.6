Return-Path: <linux-kernel+bounces-188496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7396A8CE2B2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A337A1C219DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201A12AAC6;
	Fri, 24 May 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hYgIUtR+"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3712A16B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541069; cv=none; b=WRcCWMVR0n6qu9tmBCkYow3Wsveb2VMf6BS6RP5en60FYGH8MT8aYiU5VNeT1xXbj4UsxuhWywzFJXMSrlMLw+eYghjLmG+LTppBxY8HTdP2CNjrs8JF5PQFZHjPTAaM1ddalFJ0WxSqid2EjVsAVR+cVfgfQqNNLKnNozclMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541069; c=relaxed/simple;
	bh=smYx6vKdhJOj0qp5JFWbHhMVKDAu8/fdVq+SRWlUWTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XNDqGqSux4AyVb+mF4hv5hAMBueSHK0/2XcmhCEWEkOb556my1tqj92aQRYei/IcYuQ+k0PK9iLDCgdPo6sioQG5+6fSmm2UdzUjSRL8vAht15FU1IYuLfc297YOktW0qleIhXdvLgGoMoSKFGEiEgQfLXO7pv6UGxl6WeUc/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hYgIUtR+; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716541066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYG4t/EaNB7EWepqtfFni8zXj5gK0Ak5wPBBilgzMF4=;
	b=hYgIUtR+IGQiW5SYzAi6hn187p+6dLSPfSc5qCAwXfrCx9zJofdC5SRZC9uNmtLVNrr//S
	K35K1A3BY7lW01HjC1Jo6/eGc5/+mcoy71lAOeeLqpOAoODxFEmBtTCscyOa9YL6GanUCE
	SRBiSiD3MN3ajReabx4U2DoEUf+9QpQ=
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
Date: Fri, 24 May 2024 16:56:53 +0800
Subject: [PATCH 4/4] mm/ksm: use ksm page itself if no another ksm page is
 found on stable tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-b4-ksm-scan-optimize-v1-4-053b31bd7ab4@linux.dev>
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
In-Reply-To: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541051; l=2490;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=smYx6vKdhJOj0qp5JFWbHhMVKDAu8/fdVq+SRWlUWTA=;
 b=Uk5bDGiklVu1N1UJwFk4FaByr6X04WBgoDgj5019z6tb87qoXKOdmsjtjRjcvjab0iuVGGhhe
 RoMjv/9K6JPCH5inyUAKr53usGvYwINzGTYbvuRTf/CObYXOBS7Atoe
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

It's interesting that a mapped ksm page also need to stable_tree_search(),
instead of using stable_tree_insert() directly. The reason is that we have
a minor optimization for migrated ksm page that has only one mapcount, in
which case we can find another ksm page that already on the stable tree
to replace it.

But what if we can't find another shareable candidate on the stable tree?
Obviously, we should just return the ksm page itself if it has been
inserted on the tree. And we shouldn't return NULL if no another ksm page
is found on the tree, since we will still map on this ksm page but the
rmap_item will be removed out to insert on the unstable tree if we return
NULL in this case.

We can ignore the is_page_sharing_candidate() check in this case, since
max_page_sharing_bypass is set to true in cmp_and_merge_page().

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f923699452ed..6dea83998258 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1940,11 +1940,8 @@ static struct page *stable_tree_search(struct page *page)
 	rb_link_node(&page_node->node, parent, new);
 	rb_insert_color(&page_node->node, root);
 out:
-	if (is_page_sharing_candidate(page_node)) {
-		folio_get(folio);
-		return &folio->page;
-	} else
-		return NULL;
+	folio_get(folio);
+	return &folio->page;
 
 replace:
 	/*
@@ -1966,10 +1963,7 @@ static struct page *stable_tree_search(struct page *page)
 			rb_replace_node(&stable_node_dup->node,
 					&page_node->node,
 					root);
-			if (is_page_sharing_candidate(page_node))
-				folio_get(folio);
-			else
-				folio = NULL;
+			folio_get(folio);
 		} else {
 			rb_erase(&stable_node_dup->node, root);
 			folio = NULL;
@@ -1982,10 +1976,7 @@ static struct page *stable_tree_search(struct page *page)
 			list_del(&page_node->list);
 			DO_NUMA(page_node->nid = nid);
 			stable_node_chain_add_dup(page_node, stable_node);
-			if (is_page_sharing_candidate(page_node))
-				folio_get(folio);
-			else
-				folio = NULL;
+			folio_get(folio);
 		} else {
 			folio = NULL;
 		}
@@ -2009,7 +2000,7 @@ static struct page *stable_tree_search(struct page *page)
 		stable_node = alloc_stable_node_chain(stable_node_dup,
 						      root);
 		if (!stable_node)
-			return NULL;
+			goto out;
 	}
 	/*
 	 * Add this stable_node dup that was

-- 
2.45.1


