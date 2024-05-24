Return-Path: <linux-kernel+bounces-188493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F378CE2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09B4C1F21FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09187129A93;
	Fri, 24 May 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KzK2wgoY"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF437381D1
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541062; cv=none; b=SzmTwJvSmHhTvx3bJ5dkbWpLXNn3mpQRwnY5sSyUsrj+RotXORue4MbI5sGl/XM2XearG3Zpw6tZa3xe12pNVjXR9QBQFj5CN1QZFVIX72XFFvIV5jgO5pa9s3REOwPBWnIR3PuCHd0kY5I10uucW72xeFY46wMxwkGQNkVN5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541062; c=relaxed/simple;
	bh=JxsnAPdpaUy+vf0sl0PZjYU5lyGNxjQTcWpShsy4QXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GlJTAHtmSaZ3VE0/hgeBVvNGWl1FDXZ93cA7y0fmyHl+6w/aGnSukifrJmid+/ijtzqETnVdN+H/ooEII80YwLKq41pexBiD/czUygNVR0rjdDa0v6VE8ZOZFI/hJvVeW308evd2g91tDJbQWhJwHytpYoctiPLZ8LOa2Ca06Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KzK2wgoY; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716541057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHfQsO4NVTRNBD9ihuMdP3lZwpfoz/pqOUOarvdBcXM=;
	b=KzK2wgoYer0vn4GzZWGWDfZ/tEhEAAuly8IRy9wsz+ICAhFVcu1u7w0U2xgEzapA1beUxr
	Cg2RxMRwAs8u8ZeUyZCjq5yDfqpMWfTtf7foWhd11ZGZBNVmSH3cwAsudxn5P3p1OhqWa2
	1T//kN+DQM8ZtlnL6O0rW8oo4QuAuMg=
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
Date: Fri, 24 May 2024 16:56:50 +0800
Subject: [PATCH 1/4] mm/ksm: refactor out try_to_merge_with_zero_page()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240524-b4-ksm-scan-optimize-v1-1-053b31bd7ab4@linux.dev>
References: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
In-Reply-To: <20240524-b4-ksm-scan-optimize-v1-0-053b31bd7ab4@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716541051; l=3157;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=JxsnAPdpaUy+vf0sl0PZjYU5lyGNxjQTcWpShsy4QXs=;
 b=+IclB6lAEN9i9mpmGfuCQ9JjgV8dqoL221kOWpl1/LyLcUwK7iGdiv9V31dGtFNFcnBd483w1
 oZJ5Bw1PSUwBuBpDWFbZ8IR5pOHuMwXOhMQ8PA7CAvcviaO3yj6FgCI
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

In preparation for later changes, refactor out a new function called
try_to_merge_with_zero_page(), which tries to merge with zero page.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 67 +++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4dc707d175fa..cbd4ba7ea974 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1531,6 +1531,41 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 	return err;
 }
 
+/* This function returns 0 if the pages were merged, -EFAULT otherwise. */
+static int try_to_merge_with_zero_page(struct ksm_rmap_item *rmap_item,
+				       struct page *page)
+{
+	struct mm_struct *mm = rmap_item->mm;
+	int err = -EFAULT;
+
+	/*
+	 * Same checksum as an empty page. We attempt to merge it with the
+	 * appropriate zero page if the user enabled this via sysfs.
+	 */
+	if (ksm_use_zero_pages && (rmap_item->oldchecksum == zero_checksum)) {
+		struct vm_area_struct *vma;
+
+		mmap_read_lock(mm);
+		vma = find_mergeable_vma(mm, rmap_item->address);
+		if (vma) {
+			err = try_to_merge_one_page(vma, page,
+					ZERO_PAGE(rmap_item->address));
+			trace_ksm_merge_one_page(
+				page_to_pfn(ZERO_PAGE(rmap_item->address)),
+				rmap_item, mm, err);
+		} else {
+			/*
+			 * If the vma is out of date, we do not need to
+			 * continue.
+			 */
+			err = 0;
+		}
+		mmap_read_unlock(mm);
+	}
+
+	return err;
+}
+
 /*
  * try_to_merge_with_ksm_page - like try_to_merge_two_pages,
  * but no new kernel page is allocated: kpage must already be a ksm page.
@@ -2305,7 +2340,6 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
  */
 static noinline void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
 {
-	struct mm_struct *mm = rmap_item->mm;
 	struct ksm_rmap_item *tree_rmap_item;
 	struct page *tree_page = NULL;
 	struct ksm_stable_node *stable_node;
@@ -2374,36 +2408,9 @@ static noinline void cmp_and_merge_page(struct page *page, struct ksm_rmap_item
 		return;
 	}
 
-	/*
-	 * Same checksum as an empty page. We attempt to merge it with the
-	 * appropriate zero page if the user enabled this via sysfs.
-	 */
-	if (ksm_use_zero_pages && (checksum == zero_checksum)) {
-		struct vm_area_struct *vma;
+	if (!try_to_merge_with_zero_page(rmap_item, page))
+		return;
 
-		mmap_read_lock(mm);
-		vma = find_mergeable_vma(mm, rmap_item->address);
-		if (vma) {
-			err = try_to_merge_one_page(vma, page,
-					ZERO_PAGE(rmap_item->address));
-			trace_ksm_merge_one_page(
-				page_to_pfn(ZERO_PAGE(rmap_item->address)),
-				rmap_item, mm, err);
-		} else {
-			/*
-			 * If the vma is out of date, we do not need to
-			 * continue.
-			 */
-			err = 0;
-		}
-		mmap_read_unlock(mm);
-		/*
-		 * In case of failure, the page was not really empty, so we
-		 * need to continue. Otherwise we're done.
-		 */
-		if (!err)
-			return;
-	}
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {

-- 
2.45.1


