Return-Path: <linux-kernel+bounces-200005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A2D8FA91E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 06:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD84F1C2429F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 04:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E0D13DB9F;
	Tue,  4 Jun 2024 04:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AguJvBU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDB13D8B1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 04:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474895; cv=none; b=B+whFYKsRAMGyc/Q0h5OkE0YWrnCvINJQp/WdIx5PAYAi6LycDMCv3C5pK1klFT3n35ueyL65fczFru82VPlsehdweq5a84ORLkCghRKiPX8khvvqaR4g/jPVVzihSaccVCFC+1cIt5f8MQOJBrWdhZNRrer50kURYG7/7xFfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474895; c=relaxed/simple;
	bh=occLtpiGpNG6/OrTWQS6BvyTS0mi9to3RbiYlw3PrkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlT5qkAqyR+7Ap+oFRtZxvnv9Jxl/LUbYjfTf1eUunAKt0+joMs89VZqlUbXTWjU5LfCsjbiJ8DCaIOHuBghEx24XZTpigMzYMHzvd06mu7T/DDnG39EAXJiHQt1TwWHBROWiMCZcVH6DlI50q5HKeDrZIg+IK1KImohUHDJIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AguJvBU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71FAC3277B;
	Tue,  4 Jun 2024 04:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717474895;
	bh=occLtpiGpNG6/OrTWQS6BvyTS0mi9to3RbiYlw3PrkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AguJvBU0+LLRweQOatueW/u5AH06TbIns2J0lyV0b25QR80ATqmiQBTyEWut9FC7m
	 L8V1+t+hIkHS1njzCmejNwswpulFnR5Li3oPulT/Ye88s41xidUgi5DWxEknMybnYs
	 SrQrv4Pmisbv32VKHqIeHL9Ellc0qaqvI+uP3XI6QVmtr/L+ifE9aXqzuarObMzY8O
	 xED9gD2pIUppXTXXqcVvaC4r497TaeSpG9V8R7EKpBSq8/F+KSdxZfOVDe5cK94jq5
	 KfEM5HmCAV0abs8mRLCcl6FBU8N4o2oFmv4dCKLRSJ11rNxKDFAzZ9ZEx2mDsZMfYO
	 hnt1ztORdDlgw==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [PATCH 01/10] mm/ksm: reduce the flush action for ksm merging page
Date: Tue,  4 Jun 2024 12:24:43 +0800
Message-ID: <20240604042454.2012091-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604042454.2012091-1-alexs@kernel.org>
References: <20240604042454.2012091-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

We can put off the flush action util a merging is realy coming. That
could reduce some unmerge page flushing.
BTW, flushing only do at arm, mips and few other archs.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f5138f43f0d2..97e5b41f8c4b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -783,10 +783,7 @@ static struct page *get_mergeable_page(struct ksm_rmap_item *rmap_item)
 		goto out;
 	if (is_zone_device_page(page))
 		goto out_putpage;
-	if (PageAnon(page)) {
-		flush_anon_page(vma, page, addr);
-		flush_dcache_page(page);
-	} else {
+	if (!PageAnon(page)) {
 out_putpage:
 		put_page(page);
 out:
@@ -1473,8 +1470,8 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
  *
  * This function returns 0 if the pages were merged, -EFAULT otherwise.
  */
-static int try_to_merge_one_page(struct vm_area_struct *vma,
-				 struct page *page, struct page *kpage)
+static int try_to_merge_one_page(struct vm_area_struct *vma, struct page *page,
+				 struct ksm_rmap_item *rmap_item, struct page *kpage)
 {
 	pte_t orig_pte = __pte(0);
 	int err = -EFAULT;
@@ -1500,6 +1497,9 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			goto out_unlock;
 	}
 
+	flush_anon_page(vma, page, rmap_item->address);
+	flush_dcache_page(page);
+
 	/*
 	 * If this anonymous page is mapped only here, its pte may need
 	 * to be write-protected.  If it's mapped elsewhere, all of its
@@ -1550,7 +1550,7 @@ static int try_to_merge_with_ksm_page(struct ksm_rmap_item *rmap_item,
 	if (!vma)
 		goto out;
 
-	err = try_to_merge_one_page(vma, page, kpage);
+	err = try_to_merge_one_page(vma, page, rmap_item, kpage);
 	if (err)
 		goto out;
 
@@ -2385,7 +2385,7 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 		mmap_read_lock(mm);
 		vma = find_mergeable_vma(mm, rmap_item->address);
 		if (vma) {
-			err = try_to_merge_one_page(vma, page,
+			err = try_to_merge_one_page(vma, page, rmap_item,
 					ZERO_PAGE(rmap_item->address));
 			trace_ksm_merge_one_page(
 				page_to_pfn(ZERO_PAGE(rmap_item->address)),
@@ -2663,8 +2663,6 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			if (is_zone_device_page(*page))
 				goto next_page;
 			if (PageAnon(*page)) {
-				flush_anon_page(vma, *page, ksm_scan.address);
-				flush_dcache_page(*page);
 				rmap_item = get_next_rmap_item(mm_slot,
 					ksm_scan.rmap_list, ksm_scan.address);
 				if (rmap_item) {
-- 
2.43.0


