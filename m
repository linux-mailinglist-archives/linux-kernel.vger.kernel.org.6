Return-Path: <linux-kernel+bounces-428066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A359E0C7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE88B2C515
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189781D9A6E;
	Mon,  2 Dec 2024 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="uGmTf8eK";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b="eneajlAA"
Received: from mail136-20.atl41.mandrillapp.com (mail136-20.atl41.mandrillapp.com [198.2.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1E1B6D0A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733160109; cv=none; b=PbWGVHfcJ/Y3k14R8+8vgv8q96CDx6ol25/EeK8FyQaSKqJ3RpJY/DW26Lx1fAYiYcFjcCsu/CcKIjEPXPN2TYJR9ZzqA3e3VZy3CDjpNOHEvfJd7QcXZGek2QncoZyc+zpoOF4181YVlo4M7QBuiRfj64UIsBxO3SyipWL055U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733160109; c=relaxed/simple;
	bh=15c4NQmMhX7O/lLntNh05+5nyQLyX5I/hV8b4lOLUA4=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=aIGP8TxiOorPzFGCHwFWR9MNgBaPRgkRYkLbeOkzouKO4P3BkedGSUuCzM2HCc7GerETb88i8JBSh3Z91qu3wIB0gViSSxYsttbboqZ6n/8vDGovi8TkHd9IKYbO1hAfYrSFiUlb5znMfAE0X6AVG2I/MdvhxMb0F7F1VJ8Zq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=uGmTf8eK; dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b=eneajlAA; arc=none smtp.client-ip=198.2.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1733160106; x=1733420606;
	bh=IauL8Qp0YWYvkAARRtO9cDCFO2BMI77KcbI4z8abZFI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=uGmTf8eKEB0ya91Nhpdsdc/kxZFw6YdRbg4zGUeJOI5Ik8gGA4UZu4O3ai0//ZOCL
	 GgRSdhbnSXm/xu7IaJ+Ax9SAopcj4+gpyJtnJxmI8FLfQE6kp4M1v/uEIHK7fHO2/M
	 b3N6IhfTTpKCmOgElKsavKAVue/UUgrbla7G8/cJUeo4SIZoDyRl9OMXFBZzD3wFnm
	 uvgwDmRyfmd7R+bGt1elklguomFiZyT92S6ENeHYKE2OXSHYVjLZ2X+Ibhk15o8KbP
	 KoVo0IDyILuF5eiT1uDq8ZTxpkCdzTaqblmDcEQMDF+nQkjF9MDRk1Wmgmag2hIS3Y
	 T0Q6lcMgI6QrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1733160106; x=1733420606; i=thierry.escande@vates.tech;
	bh=IauL8Qp0YWYvkAARRtO9cDCFO2BMI77KcbI4z8abZFI=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=eneajlAA+CpZ9HWBcYC0PxTvY7QqiI5GUJotvchefxLlpJNcIxjHrX49JTUi5ensd
	 jDb2FA4WqRItJEpVjPaGyctDoqqDpSfLb4UhU2NbzqeHL4/o4W5TZ1TASv6ujk5c67
	 q25zQ/3qW/B2cjlshinKknhBlo+Ils1C2NCZZJqDUVNb24TOPEMFGNwOX+gLjZRfuL
	 BnntXNu5CW++dcX5526SNfTlslzge1O4WvKxcQW88qn0EqLBNcg/D+RcdI+FI3aFBe
	 RUlAPtwMCfy60XDk8J0smBCCODbisch023/4hMf+lM/TGHt2mLWckNIaA4UvO3K2X9
	 PLlIJRmAXuYmA==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail136-20.atl41.mandrillapp.com (Mailchimp) with ESMTP id 4Y29Z220p9zCf9MRP
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:21:46 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v2=201/2]=20xen/swiotlb:=20add=20alignment=20check=20for=20dma=20buffers?=
Received: from [37.26.189.201] by mandrillapp.com id 4f573f9b8c264e469c27d2f3335d98f2; Mon, 02 Dec 2024 17:21:46 +0000
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1733160104462
Message-Id: <c9eca3df-d1ba-46f8-95c2-2da0b8c25803@vates.tech>
To: =?utf-8?Q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, xen-devel@lists.xenproject.org, jbeulich@suse.com
References: <20240916064748.18071-1-jgross@suse.com> <20240916064748.18071-2-jgross@suse.com> <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech> <2d4fd45a-2461-441e-a116-3b6cff18ee9e@suse.com>
In-Reply-To: <2d4fd45a-2461-441e-a116-3b6cff18ee9e@suse.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.4f573f9b8c264e469c27d2f3335d98f2?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20241202:md
Date: Mon, 02 Dec 2024 17:21:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 02/12/2024 09:27, J=C3=BCrgen Gro=C3=9F wrote:
> On 29.11.24 18:36, Thierry Escande wrote:
>> Hi,
>>
>> On 16/09/2024 08:47, Juergen Gross wrote:
>>> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
>>> index 35155258a7e2..ddf5b1df632e 100644
>>> --- a/drivers/xen/swiotlb-xen.c
>>> +++ b/drivers/xen/swiotlb-xen.c
>>> @@ -78,9 +78,15 @@ static inline int
>>> range_straddles_page_boundary(phys_addr_t p, size_t size)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long next_bfn, xen_pfn =3D XEN_=
PFN_DOWN(p);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i, nr_pages =3D XEN_PFN_UP(=
xen_offset_in_page(p) +
>>> size);
>>> +=C2=A0=C2=A0=C2=A0 phys_addr_t algn =3D 1ULL << (get_order(size) + PAG=
E_SHIFT);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_bfn =3D pfn_to_bfn(xen_pfn);
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* If buffer is physically aligned, ensure D=
MA alignment. */
>>> +=C2=A0=C2=A0=C2=A0 if (IS_ALIGNED(p, algn) &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !IS_ALIGNED(next_bfn << XEN=
_PAGE_SHIFT, algn))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>
>> There is a regression in the mpt3sas driver because of this change.
>> When, in a dom0, this driver creates its DMA pool at probe time and
>> calls dma_pool_zalloc() (see [1]), the call to
>> range_straddles_page_boundary() (from xen_swiotlb_alloc_coherent())
>> returns 1 because of the alignment checks added by this patch. Then the
>> call to xen_create_contiguous_region() in xen_swiotlb_alloc_coherent()
>> fails because the passed size order is too big (> MAX_CONTIG_ORDER).
>> This driver sets the pool allocation block size to 2.3+ MBytes.
>>
>> =C2=A0From previous discussions on the v1 patch, these checks are not
>> necessary from xen_swiotlb_alloc_coherent() that already ensures
>> alignment, right?
> 
> It ensures alignment regarding guest physical memory, but it doesn't do
> so for machine memory.
> 
> For DMA machine memory proper alignment might be needed, too, so the
> check is required. As an example, some crypto drivers seem to rely on
> proper machine memory alignment, which was the reason for those checks
> to be added.
> 
> Possible solutions include:
> 
> - rising the MAX_CONTIG_ORDER limit (to which value?)

Looks like the quick and easy solution. Bumping MAX_CONTIG_ORDER to 10
would allow 4MB pools, enough for this particular driver. I'll send a
patch if that sounds reasonable.

Regards,
Thierry

> - adding a way to allocate large DMA buffers with relaxed alignment
> =C2=A0 requirements (this will impact the whole DMA infrastructure plus
> =C2=A0 drivers like mp3sas which would need to use the new interface)
> - modify the mpt3sas driver to stay within the current limits
> - only guarantee proper machine memory alignment up to MAX_CONTIG_ORDER
> =C2=A0 (risking to introduce hard to diagnose bugs for the rare use cases=
 of
> =C2=A0 such large buffers)
> 
> 
> Juergen


