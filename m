Return-Path: <linux-kernel+bounces-303967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DB09617BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85B81F2530B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8FB1D2F59;
	Tue, 27 Aug 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+Q8vB44"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB871D2F45
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785763; cv=none; b=S2AaF9rjJyWM6ZOVvYgE2Kl8Ofs55Y2AnwHKxA2DPG2z/exiYfcmFgL5MwwnDq3wcintFOSFgNQRuNnXC/Def5aH12gk4w6qXRAPcuZDSdZDOnD78uYgfkgGUoHmTGD4/DKB0CakGs1CtUSIxpeT1Bdq/JBxKqebq0umeJ2wBco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785763; c=relaxed/simple;
	bh=8vzddTF96IIqex5XKCSOlgyLRaodIyhLOQDfmbptYiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKvCM3QLcxCpTwBBsv6dS/037wbYorcMEdmWoslUoJgDTgAOPCrLz5Vvp/lkzVg4AdiVH3mN10qC+otgVHZZHrWt5vc+Er+ceBQUq5OR2Sk80ZvhSH7SJ6mDccPaUwUwnDLYok9islh7v5ZK+H+MKE052Y2jFIvy8Szb+yKUadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+Q8vB44; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533463f6b16so6803641e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724785760; x=1725390560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BfcLggzto3BVfKz7eDsjOiDX7mNAoTj53MKi/5GWSlk=;
        b=A+Q8vB44MXK92pvr7PoJ1ig/BWAIjL7+jCAHztowaQMxVlaC3QDsY9zaav8gzyaBq2
         nprjLHkP5r016r1W9jTvyhd1Qh26bLoJbC/eY3wHJ41fXFXuUf+untqAu/1bbzSe90A0
         YxchjKa5HtOOwMrz/hcsf6CoPtpSHeLmbaRbw8L/WccWRgym7mI65Kk2XfUGqpJec4Ya
         PGE6v4a4sLcTqAnKr8PVbTqNDSIZrOAHTC/rtYZNqb5z4R8RJJzCOFzCNWJPIsZr+UwW
         QXu3KBqtqEbY94VqAqVr0O7owWSrey2taHYLpV3E+doICIe4gogoMkwyl0Ehjo8hXw9Y
         G3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785760; x=1725390560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfcLggzto3BVfKz7eDsjOiDX7mNAoTj53MKi/5GWSlk=;
        b=Ls+JOcThXg1QN7G58sqkifjGLKhIMvDOgX7QtftxNdIYwaiyTDhw4hxWABEupQI3LA
         QMFUQYiIRg7dGxjFcw//lU9qsyT+j5WJQKteK46narIbWMvVpFG7E4QZ7cMUdFgh8sAz
         t8+ImP1PQmebtxpkkCw8ItED3Udb6DmNrmkoQmYHTRpv1jYbar4+pvno6OFO1kUJflwL
         KUV0C/lXcrqPyc7GkovSL0ncr4O43Fq2FLlk8qhc2Xwts5B1cjKK95itHfmJppYw5LBD
         QmomLf7glk01qch/fEt6Igk5xqbNgx5OXMUg2Aw8lnw5C2hpQA6dqq7u93CVJuRn2Mlt
         IGOg==
X-Gm-Message-State: AOJu0YxQ0BhOpp50tpDDYcQLawoMRWZVWDfgQ78y+MNPlhhZ1NwQevC1
	jBGD96Jut+RjtmQzbZPa7CQyXfxUM7xvpXZZZ/786WDlFmBbOAz+
X-Google-Smtp-Source: AGHT+IGYHgWH1+SAc5cajBEXxjQgStoeA6xgPw5ISmOw+UXTYmPswXwdBMwM3U4JjNbmGnQ+2ztPSw==
X-Received: by 2002:a05:6512:3e0d:b0:52c:812b:6e72 with SMTP id 2adb3069b0e04-5343876c25dmr7676576e87.1.1724785759199;
        Tue, 27 Aug 2024 12:09:19 -0700 (PDT)
Received: from pc638.lan (84-217-131-213.customers.ownit.se. [84.217.131.213])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea3630bsm1878284e87.68.2024.08.27.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:09:17 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH] mm: vmalloc: Refactor vm_area_alloc_pages() function
Date: Tue, 27 Aug 2024 21:09:16 +0200
Message-Id: <20240827190916.34242-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aim is to simplify and making the vm_area_alloc_pages()
function less confusing as it became more clogged nowadays:

- eliminate a "bulk_gfp" variable and do not overwrite a gfp
  flag for bulk allocator;
- drop __GFP_NOFAIL flag for high-order-page requests on upper
  layer. It becomes less spread between levels when it comes to
  __GFP_NOFAIL allocations;
- add a comment about a fallback path if high-order attempt is
  unsuccessful because for such cases __GFP_NOFAIL is dropped;
- fix a typo in a commit message.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3f9b6bd707d2..57862865e808 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3531,8 +3531,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		unsigned int order, unsigned int nr_pages, struct page **pages)
 {
 	unsigned int nr_allocated = 0;
-	gfp_t alloc_gfp = gfp;
-	bool nofail = gfp & __GFP_NOFAIL;
 	struct page *page;
 	int i;
 
@@ -3543,9 +3541,6 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	 * more permissive.
 	 */
 	if (!order) {
-		/* bulk allocator doesn't support nofail req. officially */
-		gfp_t bulk_gfp = gfp & ~__GFP_NOFAIL;
-
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
 
@@ -3563,12 +3558,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			 * but mempolicy wants to alloc memory by interleaving.
 			 */
 			if (IS_ENABLED(CONFIG_NUMA) && nid == NUMA_NO_NODE)
-				nr = alloc_pages_bulk_array_mempolicy_noprof(bulk_gfp,
+				nr = alloc_pages_bulk_array_mempolicy_noprof(gfp,
 							nr_pages_request,
 							pages + nr_allocated);
-
 			else
-				nr = alloc_pages_bulk_array_node_noprof(bulk_gfp, nid,
+				nr = alloc_pages_bulk_array_node_noprof(gfp, nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
@@ -3582,30 +3576,24 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			if (nr != nr_pages_request)
 				break;
 		}
-	} else if (gfp & __GFP_NOFAIL) {
-		/*
-		 * Higher order nofail allocations are really expensive and
-		 * potentially dangerous (pre-mature OOM, disruptive reclaim
-		 * and compaction etc.
-		 */
-		alloc_gfp &= ~__GFP_NOFAIL;
 	}
 
 	/* High-order pages or fallback path if "bulk" fails. */
 	while (nr_allocated < nr_pages) {
-		if (!nofail && fatal_signal_pending(current))
+		if (!(gfp & __GFP_NOFAIL) && fatal_signal_pending(current))
 			break;
 
 		if (nid == NUMA_NO_NODE)
-			page = alloc_pages_noprof(alloc_gfp, order);
+			page = alloc_pages_noprof(gfp, order);
 		else
-			page = alloc_pages_node_noprof(nid, alloc_gfp, order);
+			page = alloc_pages_node_noprof(nid, gfp, order);
+
 		if (unlikely(!page))
 			break;
 
 		/*
 		 * Higher order allocations must be able to be treated as
-		 * indepdenent small pages by callers (as they can with
+		 * independent small pages by callers (as they can with
 		 * small-page vmallocs). Some drivers do their own refcounting
 		 * on vmalloc_to_page() pages, some use page->mapping,
 		 * page->lru, etc.
@@ -3666,7 +3654,16 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
 	page_order = vm_area_page_order(area);
 
-	area->nr_pages = vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
+	/*
+	 * Higher order nofail allocations are really expensive and
+	 * potentially dangerous (pre-mature OOM, disruptive reclaim
+	 * and compaction etc.
+	 *
+	 * Please note, the __vmalloc_node_range_noprof() falls-back
+	 * to order-0 pages if high-order attempt is unsuccessful.
+	 */
+	area->nr_pages = vm_area_alloc_pages((page_order ?
+		gfp_mask & ~__GFP_NOFAIL : gfp_mask) | __GFP_NOWARN,
 		node, page_order, nr_small_pages, area->pages);
 
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
-- 
2.39.2


