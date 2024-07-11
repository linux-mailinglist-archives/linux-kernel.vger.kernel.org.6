Return-Path: <linux-kernel+bounces-249110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB592E6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2401F27D64
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BABA155A52;
	Thu, 11 Jul 2024 11:32:42 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C65502A9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697562; cv=none; b=JvhaZ+jAJQUu1HPfFBcyYb04jgeIVQ1TIJLf6ZecKjfZPeTpf4p2La7rYotcHHJcmTj6nOpQs29qss2wHj9zwiN05QQrbZbiESNaL9uu8rWm4S5RWO+kCOt2paW/Hmla6aRND3r++2SJhI9V9eei4p+NzjusSFC/tkX3Z41nPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697562; c=relaxed/simple;
	bh=0JwR7lEGUDpJ/jwrkFfRyuMt3+odb34udPxer4bnFv8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iob/Bl+zZ3JJVDnsk+UNIXdbMLh1KW/9JBaRr6n2txbW3rGFYGx1faDd5L2dUI2MP1AgW4JKDvJDqhEmAizdacZcdjOaztnqrNNJC71hTvKPZB9mKfZCfnTMaJJN0/rmcxgwGXNWzjqb7M4FDyCxbODuLCIsHrS223Iy4rhxoq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3f0dd2003f7911ef93f4611109254879-20240711
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7e923a69-7783-4b3c-8c14-1eab052d89ce,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:0ca1cc0f3b7f0a80bcdb1949449e7252,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:1
	1|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 3f0dd2003f7911ef93f4611109254879-20240711
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <jianghaoran@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1737779477; Thu, 11 Jul 2024 19:32:25 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 2855A16002097;
	Thu, 11 Jul 2024 19:32:25 +0800 (CST)
X-ns-mid: postfix-668FC2C9-10389610098
Received: from [172.30.60.215] (unknown [172.30.60.215])
	by node4.com.cn (NSMail) with ESMTPA id 32A6E16002096;
	Thu, 11 Jul 2024 11:32:24 +0000 (UTC)
Message-ID: <e913863b2d54d69a19cb278e4c25377fabeb1963.camel@kylinos.cn>
Subject: Re: [PATCH] mm/mmap: Align the length parameter of munmap with
 hugepage size
From: Haoran Jiang <jianghaoran@kylinos.cn>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org
Date: Thu, 11 Jul 2024 19:32:23 +0800
In-Reply-To: <96c9fe70-f787-42e2-b2e7-4ccad0d2e805@lucifer.local>
References: <20240710054558.1959243-1-jianghaoran@kylinos.cn>
	 <96c9fe70-f787-42e2-b2e7-4ccad0d2e805@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-10 at 09:24 +0100, Lorenzo Stoakes wrote:
> On Wed, Jul 10, 2024 at 01:45:58PM GMT, Haoran Jang wrote:
> > From: Haoran Jiang <jianghaoran@kylinos.cn>
> >=20
> > munmap hugepge mappings, if the length of the range to munmap
> > is not aligned with hugepage size,munmap will fail.
> > In the hugetlb_vm_op_split function, an error will be returned
> > if startaddr+len is not hugepage size aligned.
> >=20
> > before this patch:
> > in "tools/testing/selftests/mm/hugepage-mremap.c"
> > modify DEFAULT_LENGTH_MB to 3M,compile and run,
> > the following error message is displayed
> >=20
> > -------------------------
> > running ./hugepage-mremap
> > -------------------------
> > TAP version 13
> > 1..1
> > Map haddr: Returned address is 0x7eaa40000000
> > Map daddr: Returned address is 0x7daa40000000
> > Map vaddr: Returned address is 0x7faa40000000
> > Address returned by mmap() =3D 0x7cb34b000000
> > Mremap: Returned address is 0x7faa40000000
> > First hex is 0
> > First hex is 3020100
> > Bail out! mremap: Expected failure, but call succeeded
> >=20
> > Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> > ---
> > =C2=A0mm/mmap.c | 10 +++++++++-
> > =C2=A01 file changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 83b4682ec85c..0b3a60bf9b6f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2733,7 +2733,15 @@ int do_vmi_munmap(struct vma_iterator *vmi,
> > struct mm_struct *mm,
> > =C2=A0	if ((offset_in_page(start)) || start > TASK_SIZE || len >
> > TASK_SIZE-start)
> > =C2=A0		return -EINVAL;
> >=20
> > -	end =3D start + PAGE_ALIGN(len);
> > +	vma =3D find_vma(mm, start);
> > +	if (!vma) {
> > +		if (unlock)
> > +			mmap_write_unlock(mm);
> > +		return 0;
> > +	}
>=20
> I really don't like this, firstly we're duplicating the VMA lookup
> (we
> vma_find() below), and we fail to use the iterator here, and also we
> are
> duplicating the unlock logic.
>=20
> Also the semantics seem wrong, we are looking for a VMA that ends at
> or
> after start, so you're just checking to see if start is past the last
> VMA
> in the mm aren't you?
>=20
> This doesn't seem to be accomplishing anything too useful, unless I'm
> missing something?
>=20
> > +
> > +	end =3D start + ALIGN(len, vma_kernel_pagesize(vma));
> > +
>=20
> This seems to be the 'action' part of the change, but I'm concerned
> this is
> completely broken, because you're using the result of find_vma()
> passed
> into vma_kernel_pagesize() which could find a VMA _after_ the input
> range,
> and end up unmapping a far wider range...
>=20
> I'm also wondering if we should be doing some hugetlb-specific logic
> here,
> or whether that belongs elsewhere?
>=20
> Liam can chime in on that.
>=20
> > =C2=A0	if (end =3D=3D start)
> > =C2=A0		return -EINVAL;
> >=20
> > --
> > 2.43.0
> >=20
1, While performing an MMAP operation,The length aligned with hugepage
size.

unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
			      unsigned long prot, unsigned long flags,
			      unsigned long fd, unsigned long pgoff)
{
    ...
    if (is_file_hugepages(file)) {
	len =3D ALIGN(len, huge_page_size(hstate_file(file)));
    ...
}

2,During the munmap, do_vmi_align_munmap->__split_vma(vmi, next, end,
0)->hugetlb_vm_op_split.It will determine whether the end address is
aligned with  hugepage size, and if the end address is not aligned,=20
return fail. Is there expect the application to align the length?

 hugetlb_vm_op_split(struct vm_area_struct *vma, unsigned long addr)
 {
 	if (addr & ~(huge_page_mask(hstate_vma(vma))))
		return -EINVAL;
=20
 }

3,Or after the vma_find (vmi, end), recalculate the end address ?

ex:
vma =3D vma_find(vmi, end);
...
if (is_vm_hugetlb_page(vma))
{
	hugepage_size =3D huge_page_size(hstate_vma(vma));
	end =3D start + ALIGN(len, hugepage_size);
}

