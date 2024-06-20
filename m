Return-Path: <linux-kernel+bounces-222022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF1790FBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50C51C2100B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E61EB31;
	Thu, 20 Jun 2024 03:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eIkBD3Xk"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CC639
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855130; cv=none; b=Sqc6Ytu0qTkkUTpLKn3EbSWnyGs8wx0FLEaCakPf7oBq7yYE9Xclp7wvNj97YQkCFVzFbmRGbJ3TOUgtj5pi3iHRmahJeQKTe6tiBzK3xqA5LUHBVvcP7EXIkS34bmhbI5CrEUx4y3LPUBrGZ6cnyt+Tz3+EfeGZWP+5LHQJtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855130; c=relaxed/simple;
	bh=0M+f2H/7owHSPHu7mffG+5PM2CKw1r/ky+uoA82l34U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=SnECeuFXIP6nyEPNPQ+JXqlw3xAnouNUnD546jdYNxYJeBOwMxEbm32L5pGjtYgjHzvG5x/blZnq9BwmZEL8mkTlmOKYuX7kigYj+xgTh1fCuDiBkDIxxVJ4VCjwck6aedoeFoDnqBWLl0G/Wfl6w+A+W7Yqnbg1757buWhwjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eIkBD3Xk; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240620034524epoutp024e34f68427a3220005cd868f9bb33448~amaDq8UJX0938509385epoutp02H
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:45:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240620034524epoutp024e34f68427a3220005cd868f9bb33448~amaDq8UJX0938509385epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718855124;
	bh=HvsAluwdPqThGUg7iHM9fAe/anvaR/AsVbVKYvQakRI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=eIkBD3Xkhhn7fQQbeK1d9UnwNfpzrM2FRyquZa1OwHHeADow68adjWfX9sJm/dkPV
	 Aeb7AdLnP6beQg2HCs+3AHdNPoNMB7GnkEz+tdOFN9NMSkv2gL0oF8xVGNAm593BJf
	 drkeiW9U7V0sWFwZuFAaJcrFQ68oJfJYFMfVRJh0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240620034523epcas1p1d6aa70da15d83ab201bf40e0fcdd0c7c~amaDaSCmm2845328453epcas1p1H;
	Thu, 20 Jun 2024 03:45:23 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.133]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4W4RGB6nL2z4x9Pq; Thu, 20 Jun
	2024 03:45:22 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.99.09522.2D5A3766; Thu, 20 Jun 2024 12:45:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240620034522epcas1p1f653b2abfce1ece21facc1d6496f39a3~amaCJK7AR2387223872epcas1p16;
	Thu, 20 Jun 2024 03:45:22 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240620034522epsmtrp2f1f7a9f5e8eba71f859981a2887f5b39~amaCIkMb61629616296epsmtrp2X;
	Thu, 20 Jun 2024 03:45:22 +0000 (GMT)
X-AuditID: b6c32a35-8d63ca8000002532-ad-6673a5d2355f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.04.18846.2D5A3766; Thu, 20 Jun 2024 12:45:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.111.45]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240620034522epsmtip1325d959f387b08cfcb7dda9b8edeaa33~amaB6lXLI3042530425epsmtip1s;
	Thu, 20 Jun 2024 03:45:22 +0000 (GMT)
From: Sung-hun Kim <sfoon.kim@samsung.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: sungguk.na@samsung.com, sw0312.kim@samsung.com, sebuns@gmail.com,
	Sung-hun Kim <sfoon.kim@samsung.com>
Subject: [PATCH] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
Date: Thu, 20 Jun 2024 12:45:14 +0900
Message-Id: <20240620034514.244236-1-sfoon.kim@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmvu6lpcVpBqfumFjMWb+GzeLyrjls
	FvfW/Ge1aL7wktGicdpydosd8w4yWsyY/JLNgd1j56y77B6bPk1i9zgx4zeLR9+WVYwenzfJ
	BbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2h
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUq
	TMjOePNrFlvBPPGK6e3bWBsYNwl3MXJySAiYSMyb2sPcxcjFISSwg1Hi9ISZTBDOJ0aJk8e+
	McI5796eZYdpubFgK1TVTkaJe/tes0M4nxklmrtOMIFUsQloSWzbf4kRxBYRCJS4uPArK4jN
	LJAjseX7RDBbWCBBYuGEQ2A1LAKqEsc+72cGsXkFrCXO3H3MBLFNXmLmpe/sEHFBiZMzn7BA
	zJGXaN46G+xwCYFT7BIb3v5ghmhwkXi26ThUs7DEq+NboM6Wkvj8bi9bFyMHkF0tMfU5N0Rv
	C6PEv5f7WSFqjCX2L53MBFLDLKApsX6XPsQuPol3X3tYIVp5JTrahCCqlSUeH2xmgbAlJb7u
	u84EUeIhcfljPkhYSCBW4tTjxWwTGOVmIXlgFpIHZiHsWsDIvIpRLLWgODc9tdiwwBAekcn5
	uZsYwalPy3QH48S3H/QOMTJxMB5ilOBgVhLhfd5VlCbEm5JYWZValB9fVJqTWnyI0RQYpBOZ
	pUST84HJN68k3tDE0sDEzMjYxMLQzFBJnPfMlbJUIYH0xJLU7NTUgtQimD4mDk6pBqYcD7OP
	67+f5lA7EB1htK/Ofk3aDaFGiXfvZxS3H9381lTdxYH3ws7nshoFHlX7lv+MPvahbUr1wbY/
	Dkr++5X5zl5rfM5kVbzVpYTvMvPKwrxOBdv9Lv1tqxvvtDnl3Hf6+kLjp6KH7P25u7rn+Xmq
	mqdomjg/s75TkHFZ87Wx5q2aczJf2fxeu83m/jdv5bxnnMUB5Vua/3ikiLu2uBhf38CocllH
	LpZ138cs0by12f9n970LihMpsvgp+d7p6J8V7na+4aH73aYc2e7xa9vmmXLWE+7vqn+yP2v+
	ouJ7tVoRacFqclWL1G0YjidEN2my2Zk4znFawBWcc22vsmz1rrxnhvdffba/elWoTImlOCPR
	UIu5qDgRAGWH/28GBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSnO6lpcVpBrs+SFvMWb+GzeLyrjls
	FvfW/Ge1aL7wktGicdpydosd8w4yWsyY/JLNgd1j56y77B6bPk1i9zgx4zeLR9+WVYwenzfJ
	BbBGcdmkpOZklqUW6dslcGW8+TWLrWCeeMX09m2sDYybhLsYOTkkBEwkbizYytTFyMUhJLCd
	UWLh690sEAlJiTnrFjB2MXIA2cIShw8XQ9R8ZJS4s305I0gNm4CWxLb9l8BsEYFgiVub/jCD
	2MwCBRKr9m0Bs4UF4iT61k1iArFZBFQljn3eDxbnFbCWOHP3MRPELnmJmZe+s0PEBSVOznzC
	AjFHXqJ562zmCYx8s5CkZiFJLWBkWsUomlpQnJuem1xgqFecmFtcmpeul5yfu4kRHJxaQTsY
	l63/q3eIkYmD8RCjBAezkgjv866iNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6Ykl
	qdmpqQWpRTBZJg5OqQamhOc3t2rs3b+3/3HgvlWh2/M2zy7dL/2sd2pW1MLfoZe6me+WPfX5
	KmXnwGbxSfwcl6/IqcOKJTwn9qyde2N1qsSLWPXZYTzrMtjb9/t2LT4a92mevnnnobdlrbPV
	uNx4pp26W1Iq9vmW1Cax+WtXvY1smrxqrkrx2Z2R1lOV16o+zVzE8qEk6D33NL3disvzj2y+
	Lim6NIrp6/Wnfwr3/Lhw7vvigtbbz24s/D6Vqet+UGbset8kvmm7y7kLWtTuX/4XmRd9ScJ5
	qtlE3Xib0N8lKc472/s4TQ+dbfJmq7RoiZ6bf2njfAFG1ZhCvz6Lm73LKlQ992+6EnDrZMU1
	jkebunY+PrDL9lOucM7bOUosxRmJhlrMRcWJAJWMwEa9AgAA
X-CMS-MailID: 20240620034522epcas1p1f653b2abfce1ece21facc1d6496f39a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620034522epcas1p1f653b2abfce1ece21facc1d6496f39a3
References: <CGME20240620034522epcas1p1f653b2abfce1ece21facc1d6496f39a3@epcas1p1.samsung.com>

The current version of KSM does not take into account the number of
used ksm_mm_slot. Therefore, when users want to obtain profits of
KSM, KSM omits the memory used for allocating ksm_mm_slots.

This patch introduces a new variable to keep track of the number of
allocated ksm_mm_slots. By doing so, KSM will be able to provide a
more accurate number of the gains made.

Signed-off-by: Sung-hun Kim <sfoon.kim@samsung.com>
---
 mm/ksm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 34c4820e0d3d..139e8f0724e1 100644
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
+		sizeof(struct ksm_mm_slot);
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


