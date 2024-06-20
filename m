Return-Path: <linux-kernel+bounces-222044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A55790FBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32ECA1C22D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4442745D;
	Thu, 20 Jun 2024 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iu7x2imo"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA91722095
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718858368; cv=none; b=ZSb7kw3BHXWEnNEHoPr3udZ8aCjSgda+z9CNvfzxRtA6UgKjeY/TFsDlO4GV/TQQLKGdV24oFKtVggiC5eE3iQVz58Pq1UFriT3i5BIJqzg0Bq9FS/txZcjsceIKRX0DvLZL4UBZ9dmWDNOPTPMuZhy83K51YVvZP/f9plZ4u1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718858368; c=relaxed/simple;
	bh=JXXhB/feBOJ0o0tgvMkW4+H3iYuHUnk0cc4wNY87b3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=IZ/DxYnffVf+i+U04OUbtQpd8NS5MHmeQEpK80lzTHqp30zSob+LXmQfPnq2zNrMdcxvwDI5powxFxZsQcYwyPbTIYERSkuP2MOtxOsk/zX0dfSAvyjEa0IC9roJa+R3iGbARDZHSYi5fgnKTMIMXDsOqsHbz48nXQm+90YUKhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iu7x2imo; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240620043922epoutp0335d1d179cbdbbe939e9cef1a8892cbe8~anJLlkcSv2966629666epoutp03a
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 04:39:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240620043922epoutp0335d1d179cbdbbe939e9cef1a8892cbe8~anJLlkcSv2966629666epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718858362;
	bh=CSUudlip9Vu0/VD7Ao8r5qsubjjl3lKW3KeE+ma8usg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=iu7x2imo8oWipQ052gUk9RR6wanPOcn8VjMklguUOOroQpa8DIhBWdSCYl8FF95c4
	 QREvXKZURZ7ahCvfaR+5EmPeZU+wRnfVrV9iZsBhkLB5CUWcneAanFCS4UyMYU7kOT
	 Wc4aSH9hb+FjiLLIVbBuiRaFE01wdNfo/1I4jAh4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240620043921epcas1p42f94b1137c0046596b7341cf784cc334~anJK2lcYv0713107131epcas1p4f;
	Thu, 20 Jun 2024 04:39:21 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.38.233]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W4SSS5Td7z4x9Q5; Thu, 20 Jun
	2024 04:39:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.E2.09847.872B3766; Thu, 20 Jun 2024 13:39:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244~anJJRvjcV2075520755epcas1p1P;
	Thu, 20 Jun 2024 04:39:20 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240620043920epsmtrp25c2610d0f9fa9b649d81f8065ccc1ad6~anJJRFfMg1486114861epsmtrp22;
	Thu, 20 Jun 2024 04:39:20 +0000 (GMT)
X-AuditID: b6c32a36-60dff70000002677-70-6673b27887ab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.CA.19057.772B3766; Thu, 20 Jun 2024 13:39:19 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.45]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240620043919epsmtip13d55b576ec751cf51711cd170ca8be48~anJJA9xwC3203132031epsmtip1q;
	Thu, 20 Jun 2024 04:39:19 +0000 (GMT)
From: Sung-hun Kim <sfoon.kim@samsung.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sungguk.na@samsung.com, sw0312.kim@samsung.com, sebuns@gmail.com,
	Sung-hun Kim <sfoon.kim@samsung.com>
Subject: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
Date: Thu, 20 Jun 2024 13:39:14 +0900
Message-Id: <20240620043914.249768-1-sfoon.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmnm7FpuI0g02tEhZz1q9hs7i8aw6b
	xb01/1ktmi+8ZLRonLac3WLHvIOMFjMmv2RzYPfYOesuu8emT5PYPU7M+M3i0bdlFaPH501y
	AaxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QGco
	KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMC/SKE3OLS/PS9fJSS6wMDQyMTIEK
	E7Iztl8IL9gpUXG9aRZTA+NWkS5GTg4JAROJB6vPsnQxcnEICexglPjRdYYRwvnEKPF0+ldm
	COcbo0TL22+MMC3/nz5jh0jsZZRo3HKHCcL5zChxomM2C0gVm4CWxLb9l8A6RAQCJS4u/MoK
	YjML5Ehs+T4RzBYWSJbo7GsBq2ERUJVYeLuRGcTmFbCWuLhnEdQ2eYmZl76zQ8QFJU7OfMIC
	MUdeonnrbLDzJAROsUs8vr+YCaLBReLrlAVsELawxKvjW9ghbCmJz+/2AsU5gOxqianPuSF6
	Wxgl/r3czwpRYyyxf+lkJpAaZgFNifW79CF28Um8+9rDCtHKK9HRJgRRrSzx+GAzC4QtKfF1
	33WoCzwkmn5vB7OFBGIlvq/5wDiBUW4Wkg9mIflgFsKyBYzMqxjFUguKc9NTiw0LjOARmZyf
	u4kRnPq0zHYwTnr7Qe8QIxMH4yFGCQ5mJRHe511FaUK8KYmVValF+fFFpTmpxYcYTYFhOpFZ
	SjQ5H5h880riDU0sDUzMjIxNLAzNDJXEec9cKUsVEkhPLEnNTk0tSC2C6WPi4JRqYLJPmvvi
	/t7fRUvy/Y5fEs/I2de/fNo1wSfl6XcWb6u/X6oWlhPd4nR3SdGERfdvtioHWy7wOf1cjKXw
	WIBEw3YelhkTZ066/qPkn9qKZ6tzwv7P38bD05D/0nP1lOL9HFNm3WeRPHwlv/Ls3QmbvLyP
	//y39ObnK3U5k9YbzC3j3nLKeLdx/ru6F55+LlrfH25jbRXwNz/6oDfWdP30+ssXZ1kvtuvx
	kSrnS5yS11V/5GvQNb8btb9lhF769K/eKqFwRG/ytHU66bVyVia3J8n8Enm+8M9adQ7rk7du
	nRF2DG91mHf7jHyg07czbWFzAu36GfifXto2N7W77bSg6mX/B+fOTH6lwFyWbHhS/VOjEktx
	RqKhFnNRcSIAGdmrTQYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLLMWRmVeSWpSXmKPExsWy7bCSnG75puI0gy/LzCzmrF/DZnF51xw2
	i3tr/rNaNF94yWjROG05u8WOeQcZLWZMfsnmwO6xc9Zddo9Nnyaxe5yY8ZvFo2/LKkaPz5vk
	AlijuGxSUnMyy1KL9O0SuDK2Xwgv2ClRcb1pFlMD41aRLkZODgkBE4n/T5+xdzFycQgJ7GaU
	6HgylxkiISkxZ90Cxi5GDiBbWOLw4WKImo+MEhNn/GcDqWET0JLYtv8SI4gtIhAscWvTH7Be
	ZoECiVX7toDZwgKJEruf3AKrZxFQlVh4uxEszitgLXFxzyJGiF3yEjMvfWeHiAtKnJz5hAVi
	jrxE89bZzBMY+WYhSc1CklrAyLSKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4RLW0
	djDuWfVB7xAjEwfjIUYJDmYlEd7nXUVpQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJI
	TyxJzU5NLUgtgskycXBKNTBN6egpln8ryy78RvWtwbzU5iqlKUoiWn4fWHhsC5eeEK2fcp21
	OjzRmVvi57HKBc8jTWpX2Xiaxxn6s5tcczNVC3txoLLt26Pn34ycbA7HfS38kc909fbthXc3
	LF1/MJKjOXD1c973s1+yuS+WKLTdfvk4x55oVfYH1lHeOX5OFzl/fJ54OqrlXuXy5Kzi8s8V
	9e7Np1lnGe708vVQko2cmXhMtEVkktT3+If+AUapa7+WnHJds2ylUlzzCus1nOv1mJdGVbDu
	VnAOYjQufHaG3+cp+/wrx850r1aVunlA+NBGH19NPh7Nnaa2tV6Li6zyQtKlxWq6St6FxRiE
	tDmnLf+YMaWzPbX6R8NqJZbijERDLeai4kQAPhYIfMACAAA=
X-CMS-MailID: 20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>

The current version of KSM does not take into account the number of
used ksm_mm_slot. Therefore, when users want to obtain profits of
KSM, KSM omits the memory used for allocating ksm_mm_slots.

This patch introduces a new variable to keep track of the number of
allocated ksm_mm_slots. By doing so, KSM will be able to provide a
more accurate number of the gains made.

Signed-off-by: Sung-hun Kim <sfoon.kim@samsung.com>
---
Changelog in V2:
- Add an MMF_VM_MERGEABLE flag check in ksm_process_profit for
untracked processes
---
 mm/ksm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 34c4820e0d3d..c8ced991ccda 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -267,6 +267,9 @@ static unsigned long ksm_pages_unshared;
 /* The number of rmap_items in use: to calculate pages_volatile */
 static unsigned long ksm_rmap_items;
 
+/* The number of ksm_mm_slot in use */
+static atomic_long_t ksm_mm_slots = ATOMIC_LONG_INIT(0);
+
 /* The number of stable_node chains */
 static unsigned long ksm_stable_node_chains;
 
@@ -1245,6 +1248,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 			spin_unlock(&ksm_mmlist_lock);
 
 			mm_slot_free(mm_slot_cache, mm_slot);
+			atomic_long_dec(&ksm_mm_slots);
 			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 			mmdrop(mm);
@@ -2717,6 +2721,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 		spin_unlock(&ksm_mmlist_lock);
 
 		mm_slot_free(mm_slot_cache, mm_slot);
+		atomic_long_dec(&ksm_mm_slots);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		mmap_read_unlock(mm);
@@ -3000,6 +3005,7 @@ int __ksm_enter(struct mm_struct *mm)
 		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
 	spin_unlock(&ksm_mmlist_lock);
 
+	atomic_long_inc(&ksm_mm_slots);
 	set_bit(MMF_VM_MERGEABLE, &mm->flags);
 	mmgrab(mm);
 
@@ -3042,6 +3048,7 @@ void __ksm_exit(struct mm_struct *mm)
 
 	if (easy_to_free) {
 		mm_slot_free(mm_slot_cache, mm_slot);
+		atomic_long_dec(&ksm_mm_slots);
 		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
 		mmdrop(mm);
@@ -3374,7 +3381,8 @@ static void wait_while_offlining(void)
 long ksm_process_profit(struct mm_struct *mm)
 {
 	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
-		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
+		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item) -
+		(test_bit(MMF_VM_MERGEABLE, &mm->flags) ? sizeof(struct ksm_mm_slot) : 0);
 }
 #endif /* CONFIG_PROC_FS */
 
@@ -3672,7 +3680,8 @@ static ssize_t general_profit_show(struct kobject *kobj,
 	long general_profit;
 
 	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
-				ksm_rmap_items * sizeof(struct ksm_rmap_item);
+				ksm_rmap_items * sizeof(struct ksm_rmap_item) -
+				atomic_long_read(&ksm_mm_slots) * sizeof(struct ksm_mm_slot);
 
 	return sysfs_emit(buf, "%ld\n", general_profit);
 }
-- 
2.25.1


