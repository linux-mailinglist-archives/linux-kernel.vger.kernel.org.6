Return-Path: <linux-kernel+bounces-248591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03CE92DF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549511F2273C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5405821A;
	Thu, 11 Jul 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BZlrQIN+"
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BBC1C3D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720675190; cv=none; b=SF/BhXkoOlAGEnRfJTsxd7VzZFMqMaAewEvcUMWOV73CCBwDJGrGWc7Eqxmn/mkngVgHuo/aour3eEHkoFVASF2kLOdw2P6AnZ1xAzvTDtg4aMaZo1hW35CPhD7qrtyty7cxwXo9Q9X0ynFxhJfet0GERx69/vlMRlSSbySW4o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720675190; c=relaxed/simple;
	bh=zXANq2ty6zFHjX5qfTffhY7FXpVnwL/CRnXKrdcn/zE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=PdMnRXHDSDC2s4NgU3aHLJl8LOnQvmXa4i/uUtPyCwP4Bj+/6mzvlxP01f9xJHsjexpAnvOYur1yhCz0VwiL+2vsqIJ/nWxQb5mPD92O3pQUFlOV+ZlwzdFnBpOP5eP4j9udVN2zFoZV2dRs5F4paAvrIbsS4S7Uq1hrN8WYHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BZlrQIN+; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240711051944epoutp02d6a650e89255bbf8d4e82760ecce4f4d~hEPbLWDl22388523885epoutp02w
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:19:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240711051944epoutp02d6a650e89255bbf8d4e82760ecce4f4d~hEPbLWDl22388523885epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720675184;
	bh=FaXfwVv7F7bstL5whS5p0F9Y3saXeyxNh9uAI5iTpxI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=BZlrQIN+KGtaHaQ7I8rOJh6cQIlR5lu0dMPEpyaVzjmZYwkY28jrPgjPc1PBDJwAP
	 B/uZ73eYOnK9itG64+p4aapIbhCKFJweEYUTsC4oJkYZ3DYBmLFxeLzq0PsjQgZ+ie
	 4J5TkHiP4wc/rpc4LfkYf1WyZ9XcOKwQzfPpY2aw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240711051944epcas1p4401afdc67e3cb7b1decbbfd934b53356~hEPaqW1cN3104931049epcas1p4D;
	Thu, 11 Jul 2024 05:19:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.132]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WKNMM1XXPz4x9QC; Thu, 11 Jul
	2024 05:19:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.C9.09622.E6B6F866; Thu, 11 Jul 2024 14:19:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20240711051942epcas1p4d8db4336ff88378f42d15de09d938786~hEPZRBBfB0125401254epcas1p4j;
	Thu, 11 Jul 2024 05:19:42 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240711051942epsmtrp154598df129129cc6689c791e960aa6f9~hEPZQXqd71474114741epsmtrp19;
	Thu, 11 Jul 2024 05:19:42 +0000 (GMT)
X-AuditID: b6c32a37-e17ff70000002596-83-668f6b6e2639
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.1E.19057.E6B6F866; Thu, 11 Jul 2024 14:19:42 +0900 (KST)
Received: from sfoonkim02 (unknown [10.113.222.42]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240711051942epsmtip20b38b9ccfdcbc77b5028134ea39fd4ae~hEPY7x47q2123921239epsmtip2B;
	Thu, 11 Jul 2024 05:19:42 +0000 (GMT)
From: "Sung-hun Kim" <sfoon.kim@samsung.com>
To: "'David Hildenbrand'" <david@redhat.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Cc: <sungguk.na@samsung.com>, <sw0312.kim@samsung.com>, <sebuns@gmail.com>,
	"'Chengming Zhou'" <chengming.zhou@linux.dev>, <akpm@linux-foundation.org>
In-Reply-To: <254bf3e0-0056-4593-94ee-8431a1bfc430@redhat.com>
Subject: RE: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the
 general_profit calculation
Date: Thu, 11 Jul 2024 14:19:42 +0900
Message-ID: <0fe501dad351$ef692cb0$ce3b8610$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGcuK2mUct4l8vOyf6OuFEls7CcWwIwXU5MAZluS6iyTt558A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmgW5+dn+awYNWJos569ewWWw884nV
	4uv6X8wWl3fNYbO4t+Y/q0XzhZeMFjvmHWS0mDH5JZsDh8fOWXfZPTZ9msTucWLGbxaPhQ1T
	mT3e77vK5tG3ZRWjx+dNcgHsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koK
	eYm5qbZKLj4Bum6ZOUBXKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAv0ihNz
	i0vz0vXyUkusDA0MjEyBChOyMx4cfspScE27Yt+lG0wNjPOUuxg5OCQETCRuzkzrYuTiEBLY
	wSgx891SZgjnE6PE2qOnoZxvjBLTj55k72LkBOton9HCCJHYyyhxas5CqKoXjBKLmy4xg1Sx
	CehILPuxCswWEUiRWNh0ih2kiFlgBqPE3GndrCAJTgE7iSnPDoHZwgLpEgu3bwNbwSKgKnH5
	+m0wm1fAUuLYgYlMELagxMmZT1hAbGYBeYntb+cwQ5ykIPHz6TJWkIdEBJwkpt+2gigRkZjd
	2QZ2nITAWg6J7hOHWSHqXSRetV1jgrCFJV4d3wL1mpTEy/42dkjAVEtMfc4N0dvCKPHv5X6o
	XmOJ/UsnM4HUMAtoSqzfpQ+xi0/i3dceVohWXomONiGIamWJxwebWSBsSYmv+65DbfWQaPq9
	nWkCo+IsJI/NQvLYLCQfzEJYtoCRZRWjWGpBcW56arFhgTE8spPzczcxghOslvkOxmlvP+gd
	YmTiYDzEKMHBrCTCO/9Gd5oQb0piZVVqUX58UWlOavEhRlNgUE9klhJNzgem+LySeEMTSwMT
	MyNjEwtDM0Mlcd4zV8pShQTSE0tSs1NTC1KLYPqYODilGpiCF6xfo781ylfs+xwbJvufjlp2
	bHk8QnVGTB2OYUYiyS9P/I1enBVpIK7JmLx4ltlEXv8XnS8yTp9a5GVzsFFU4LyW5r8HFqVd
	3M8sS9ceu7Mvx5dZq7FgzxRV33OXsp1TVKM4lnXfePV2EkOsxpxgdhuTAzu930YGrXv6KD/4
	XqNDpOm6Tee5mQsyvUI+qk9hfFAXFvupbu9unxfRBypPpVZMSc62Os/OrHLs+BQ27e18oeFr
	kq54XZJk3Zj3Kac76+ye407MHK7LZyot2R+93Mvp7cySp5ZMqiuDZkw5pDGV//GyP5PlKq43
	h+1q1uc72TX3z6b0hnkyizmEvdyWT1Y/0rV5evcJs+Sb3UosxRmJhlrMRcWJAMZpmtg5BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvG5edn+awbzZChZz1q9hs9h45hOr
	xdf1v5gtLu+aw2Zxb81/VovmCy8ZLXbMO8hoMWPySzYHDo+ds+6ye2z6NInd48SM3yweCxum
	Mnu833eVzaNvyypGj8+b5ALYo7hsUlJzMstSi/TtErgyHhx+ylJwTbti36UbTA2M85S7GDk5
	JARMJNpntDB2MXJxCAnsZpT4/nMuE0RCUmLOugVACQ4gW1ji8OFiiJpnjBJLlp1mAalhE9CR
	WPZjFTOILSKQJrFu1gpWEJtZYB6jxNSlYhAN+xklDsy/CjaUU8BOYsqzQ6wgQ4UFUiWuT/YE
	CbMIqEpcvn6bHcTmFbCUOHZgIhOELShxcuYTFoiZ2hK9D1sZIWx5ie1v5zBD3Kkg8fPpMrCR
	IgJOEtNvW0GUiEjM7mxjnsAoPAvJpFlIJs1CMmkWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoT
	c4tL89L1kvNzNzGCI01LawfjnlUf9A4xMnEwHmKU4GBWEuGdf6M7TYg3JbGyKrUoP76oNCe1
	+BCjNAeLkjjvt9e9KUIC6YklqdmpqQWpRTBZJg5OqQYma/vUo3p3Tm3ap+bWmZa5kX3uxpvn
	Gecxeu535/vzXbNYSe/0j7nrzrrKOLZPWOOlHcW3feviP/eb7fW+NjHpTKndo7DgzDuFRxOu
	fOFb19lcpaE0i83U4VPAi9x171f1fLvTwqPGIdgldGpzLcPRI9kTXs0z+WfoxTHpPOefuOqu
	u16bfpfM5G29yPv/5m8lXSnZhffTJvDcMXLbYjFJ7vyj2CcaHMsv6n5e1uD3+GzN3EfSz0X3
	xrHXBnLVKiz+zCJ9tL4lu4n9eK//+p+X1WvlVh83i1vd+lt/No/e6vkyXaf+ubF5F+xUbP20
	8Z2/6M9tUtYG0/c8XqR83Duz6MPfB9/c2KO0BdefYdw+W4mlOCPRUIu5qDgRAJYtdTgjAwAA
X-CMS-MailID: 20240711051942epcas1p4d8db4336ff88378f42d15de09d938786
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244
References: <CGME20240620043920epcas1p1b57dce789304aa96fd83e5b2b194d244@epcas1p1.samsung.com>
	<20240620043914.249768-1-sfoon.kim@samsung.com>
	<254bf3e0-0056-4593-94ee-8431a1bfc430@redhat.com>

Hello,
I'm sorry for late reply, because there was an issue in the mail system of my company.

In my humble opinion, this problem can be considered due to the objective of the value 
that can be gotten through general_profit.
I think that there is no problem in getting the more accurate value through general_profit
because it involves only negligible overhead due to the accounting of allocated metadata.
Even the difference is small, it could affect the decision in the use of KSM on the 
memory-restricted device.
Since KSM only wastes the CPU time to find identical pages if the gain is small, so more
accurate information is needed to decide whether KSM is used or not.
Even though ksm_mm_slot and ksm_stable_node occupy few pages (or tens of pages), if KSM
found small amount of pages_sharing, it can affect the gained profit.
Because of that, I think that including other metadata in general_profit calculation is
not a big problem if tracking such metadata causes negligible overhead.

It's my mistake in omitting the consideration of ksm_stable_node. The patch should include
the calculation of the amount of ksm_stable_node.

Best regards,
Sung-hun Kim

> -----Original Message-----
> From: David Hildenbrand <david@redhat.com>
> Sent: Friday, June 21, 2024 4:38 AM
> To: Sung-hun Kim <sfoon.kim@samsung.com>; akpm@linux-foundation.org; linux-mm@kvack.org; linux-
> kernel@vger.kernel.org
> Cc: sungguk.na@samsung.com; sw0312.kim@samsung.com; sebuns@gmail.com
> Subject: Re: [PATCH v2] mm: ksm: Consider the number of ksm_mm_slot in the general_profit calculation
> 
> On 20.06.24 06:39, Sung-hun Kim wrote:
> > The current version of KSM does not take into account the number of
> > used ksm_mm_slot. Therefore, when users want to obtain profits of KSM,
> > KSM omits the memory used for allocating ksm_mm_slots.
> >
> > This patch introduces a new variable to keep track of the number of
> > allocated ksm_mm_slots. By doing so, KSM will be able to provide a
> > more accurate number of the gains made.
> 
> If you take a look at the calculation explained in Documentation/admin-guide/mm/ksm.rst, we only care
> about rmap_items, which can grow rather substantially in size.
> 
> We also don't consider other metadata, such as the size of the stable nodes etc. So why should the
> ksm_mm_slots matter that much that we should track them and account them?
> 
> Any real life examples where this is relevant / a problem.
> 
> >
> > Signed-off-by: Sung-hun Kim <sfoon.kim@samsung.com>
> > ---
> > Changelog in V2:
> > - Add an MMF_VM_MERGEABLE flag check in ksm_process_profit for
> > untracked processes
> > ---
> >   mm/ksm.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index 34c4820e0d3d..c8ced991ccda 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -267,6 +267,9 @@ static unsigned long ksm_pages_unshared;
> >   /* The number of rmap_items in use: to calculate pages_volatile */
> >   static unsigned long ksm_rmap_items;
> >
> > +/* The number of ksm_mm_slot in use */ static atomic_long_t
> > +ksm_mm_slots = ATOMIC_LONG_INIT(0);
> > +
> >   /* The number of stable_node chains */
> >   static unsigned long ksm_stable_node_chains;
> >
> > @@ -1245,6 +1248,7 @@ static int unmerge_and_remove_all_rmap_items(void)
> >   			spin_unlock(&ksm_mmlist_lock);
> >
> >   			mm_slot_free(mm_slot_cache, mm_slot);
> > +			atomic_long_dec(&ksm_mm_slots);
> >   			clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> >   			clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> >   			mmdrop(mm);
> > @@ -2717,6 +2721,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
> >   		spin_unlock(&ksm_mmlist_lock);
> >
> >   		mm_slot_free(mm_slot_cache, mm_slot);
> > +		atomic_long_dec(&ksm_mm_slots);
> >   		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> >   		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> >   		mmap_read_unlock(mm);
> > @@ -3000,6 +3005,7 @@ int __ksm_enter(struct mm_struct *mm)
> >   		list_add_tail(&slot->mm_node, &ksm_scan.mm_slot->slot.mm_node);
> >   	spin_unlock(&ksm_mmlist_lock);
> >
> > +	atomic_long_inc(&ksm_mm_slots);
> >   	set_bit(MMF_VM_MERGEABLE, &mm->flags);
> >   	mmgrab(mm);
> >
> > @@ -3042,6 +3048,7 @@ void __ksm_exit(struct mm_struct *mm)
> >
> >   	if (easy_to_free) {
> >   		mm_slot_free(mm_slot_cache, mm_slot);
> > +		atomic_long_dec(&ksm_mm_slots);
> >   		clear_bit(MMF_VM_MERGE_ANY, &mm->flags);
> >   		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
> >   		mmdrop(mm);
> > @@ -3374,7 +3381,8 @@ static void wait_while_offlining(void)
> >   long ksm_process_profit(struct mm_struct *mm)
> >   {
> >   	return (long)(mm->ksm_merging_pages + mm_ksm_zero_pages(mm)) * PAGE_SIZE -
> > -		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item);
> > +		mm->ksm_rmap_items * sizeof(struct ksm_rmap_item) -
> > +		(test_bit(MMF_VM_MERGEABLE, &mm->flags) ? sizeof(struct
> > +ksm_mm_slot) : 0);
> >   }
> >   #endif /* CONFIG_PROC_FS */
> >
> > @@ -3672,7 +3680,8 @@ static ssize_t general_profit_show(struct kobject *kobj,
> >   	long general_profit;
> >
> >   	general_profit = (ksm_pages_sharing + atomic_long_read(&ksm_zero_pages)) * PAGE_SIZE -
> > -				ksm_rmap_items * sizeof(struct ksm_rmap_item);
> > +				ksm_rmap_items * sizeof(struct ksm_rmap_item) -
> > +				atomic_long_read(&ksm_mm_slots) * sizeof(struct ksm_mm_slot);
> >
> >   	return sysfs_emit(buf, "%ld\n", general_profit);
> >   }
> 
> --
> Cheers,
> 
> David / dhildenb



