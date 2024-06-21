Return-Path: <linux-kernel+bounces-224157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A1A911DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E341F23113
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF117C7CB;
	Fri, 21 Jun 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mfzx4/5U"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C816EC17
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956514; cv=none; b=WXy1ZMpFudIiAZ82RMWjr57teqkAA8I1TfoeNLJR8NnPeXIpFLODw4ESV+rSUHMqIQ7sb5MqQwR5LlDFzVO233HnJEqcBx4bV2eHysYLiihjFviBrIyhogQyCZ2ltiKXwWjkdfpHBGullP+S55BEBCSkG7zLmsK9w1b7tCaH7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956514; c=relaxed/simple;
	bh=XgUEfBzhfRP/ORf+1yxH34MeMyVcyA4uQSa5dx7WhmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EbvTcFu/sm9JILWS+s1dzoSjAz33RzGk96ml+TNzUMuBILjoZD6qhtalaIfV7T0ZgEmWWJRtIZC8qYnG2ki/zkpxSjL/PVjOhvJyw4hHWU2lVRF37VdF1U2ynU+f2oNV76Iw20DYg2yRMO+u2gkRv46KDnquoLuj0U5AnH1vLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mfzx4/5U; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: david@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718956509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cj0RSXpfKb2TCjjea56ybQ9iCdzPc+7EtlYBpcmbVzc=;
	b=Mfzx4/5UkS4NcNG3exq4rh84KtS2OLmQAWPu7S7npdQtUGhQ/0Sbc21MlcdaIMZPVTwjMD
	ae2xHB0aTBiqDZZiONUhHFm/5RbR4jEIxq+9BDmuPoMzSoxYN+Dx1iX5S9/F7uyiQm/qLv
	AjVuWvtAwVyDuDnkwUXGouq15SeK+fU=
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
Date: Fri, 21 Jun 2024 15:54:29 +0800
Subject: [PATCH v2 1/3] mm/ksm: refactor out try_to_merge_with_zero_page()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-b4-ksm-scan-optimize-v2-1-1c328aa9e30b@linux.dev>
References: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
In-Reply-To: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com, 
 aarcange@redhat.com, hughd@google.com, shr@devkernel.io
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718956503; l=3224;
 i=chengming.zhou@linux.dev; s=20240617; h=from:subject:message-id;
 bh=XgUEfBzhfRP/ORf+1yxH34MeMyVcyA4uQSa5dx7WhmQ=;
 b=MeI/7pIXiWUSInmK68RxchUNLgqfVLCS2dSmEoaOE6psxVMHnvFbf/CCP6m1r9tkrbULcrm3S
 jcdjyQiAELQCDtQuG372QdBsbsz+DlLVK2VBPccqx3FDGVC5Ymv55y3
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=/XPhIutBo+zyUeQyf4Ni5JYk/PEIWxIeUQqy2DYjmhI=
X-Migadu-Flow: FLOW_OUT

In preparation for later changes, refactor out a new function called
try_to_merge_with_zero_page(), which tries to merge with zero page.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/ksm.c | 70 ++++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 34c4820e0d3d..1427abd18627 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1531,6 +1531,44 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 	return err;
 }
 
+/*
+ * This function returns 0 if the pages were merged or if they are
+ * no longer merging candidates (e.g., VMA stale), -EFAULT otherwise.
+ */
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
@@ -2306,7 +2344,6 @@ static void stable_tree_append(struct ksm_rmap_item *rmap_item,
  */
 static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_item)
 {
-	struct mm_struct *mm = rmap_item->mm;
 	struct ksm_rmap_item *tree_rmap_item;
 	struct page *tree_page = NULL;
 	struct ksm_stable_node *stable_node;
@@ -2375,36 +2412,9 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
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
2.45.2


