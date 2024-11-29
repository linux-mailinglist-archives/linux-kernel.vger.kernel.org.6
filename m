Return-Path: <linux-kernel+bounces-425845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B7D9DEBCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763AC281F9B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81A19DF60;
	Fri, 29 Nov 2024 17:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="n+purXCC";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b="pM1PdLas"
Received: from mail136-20.atl41.mandrillapp.com (mail136-20.atl41.mandrillapp.com [198.2.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D02314B077
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732901804; cv=none; b=I1RQpT8re2wS9+Vr83Tre+Ce5VpIPu/OqjoMqmbOMWOtjNGsAo5EiB+WWa7/W78wgPJDKHd9QoecyTXQOqScSXdKg1uwGQVtvKhyGfNs8EZ+lhcHHorY7MV6HFNcvbVih7yB+3g5Mu1f9V/STSFj7K2a3Rz1yPt3OzQKj3I+uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732901804; c=relaxed/simple;
	bh=5zCWXC9TUj94GjK/21Ix29jy73icDrRa/bMqvLhV2Ko=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=WqSw0FKCI9fp2ClFywBt4igJ+j3zbdOn+5BZQCE6kRcTKHXGVXJJ6P4I36FNVck7uTKKvExsHKHCou50n0e6rpwFzy89/GwfUQbL6HtqmtB7RlGGuRVJj4TA8q9lZ+Vn2xKuJ2sBOw993c1CE7W+nGFw2+WpK/rlHN0VwD0FfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=n+purXCC; dkim=pass (2048-bit key) header.d=vates.tech header.i=thierry.escande@vates.tech header.b=pM1PdLas; arc=none smtp.client-ip=198.2.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1732901801; x=1733162301;
	bh=2DFaOg6NuCFtrE/G4yKsOhsAMmOaVP7yOxEacPXZjy8=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=n+purXCCvPT7Mh6jL/Hofbk4MNnlQvWPYMGBZkdJb1p3vJUurufsCIswJsIECGh4i
	 rO5BY3LHzeBbPLNb5gcEM54x0g0nLCGPqzm267ErHEyi4dqWLT7JaHPwkbRVLqXzk1
	 ceszh/rIhomYi04yhrqd5Z4jmKK4Nfj8zAfIcXy9bwBNvezbXVc2SOeDJjEnVZKVY4
	 WKlwLygfREYurDH101VCh5Af5aOtq3lpQySJhs/GOq5Jcyr0bJhnZxSprmdkjTZFB5
	 P7FUAkT++nbC7oIhUBIdPew1ckJu3SAg9t2NQ1neJhKhSFGlott/g/8tueZkz5kGIa
	 6vTSgMUsDHLfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1732901801; x=1733162301; i=thierry.escande@vates.tech;
	bh=2DFaOg6NuCFtrE/G4yKsOhsAMmOaVP7yOxEacPXZjy8=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=pM1PdLasCaDY9qGJFRDrpduvkkNtPlKq9Mmq3ABo0BwJSRz/Y/DC8kZrCJ1fGT8gq
	 j69VTLooXWwMq550umE8JAQO7de2+VlhUEIDVqYljuJmxLIakpmnGdQQ6PngX9Y8mh
	 k56hmwQH0wXAQBzCajnBKfnDCjOKY7R1UdAv5F6qqyddx9uKERM1RDCBCQrg3uCy8T
	 JLhbxW3zJ6Z0p5ZmgcsyDgoZksYbhqLaGtyz6kxPjfJUKtI9nZKF74ty7PbR+fkhJX
	 yDm5GOjpsSxQK8bV+IkiewPIXfOrbYm1x3eEUFLfunMtWuz57MZ8MBkZvMnKbD82hr
	 i1tYoRtZ/SNGQ==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
	by mail136-20.atl41.mandrillapp.com (Mailchimp) with ESMTP id 4Y0L2d4WzBzCf9Nc1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:36:41 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v2=201/2]=20xen/swiotlb:=20add=20alignment=20check=20for=20dma=20buffers?=
Received: from [37.26.189.201] by mandrillapp.com id 8c81f47df04449da8fe38b771be48ac9; Fri, 29 Nov 2024 17:36:41 +0000
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1732901799832
Message-Id: <e6ceb22d-3fa7-430c-9410-3c5ffd9ded2d@vates.tech>
To: "Juergen Gross" <jgross@suse.com>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: "Stefano Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>, xen-devel@lists.xenproject.org, jbeulich@suse.com
References: <20240916064748.18071-1-jgross@suse.com> <20240916064748.18071-2-jgross@suse.com>
In-Reply-To: <20240916064748.18071-2-jgross@suse.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.8c81f47df04449da8fe38b771be48ac9?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20241129:md
Date: Fri, 29 Nov 2024 17:36:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,

On 16/09/2024 08:47, Juergen Gross wrote:
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 35155258a7e2..ddf5b1df632e 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -78,9 +78,15 @@ static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
>  {
>  	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
>  	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
> +	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
>  
>  	next_bfn = pfn_to_bfn(xen_pfn);
>  
> +	/* If buffer is physically aligned, ensure DMA alignment. */
> +	if (IS_ALIGNED(p, algn) &&
> +	    !IS_ALIGNED(next_bfn << XEN_PAGE_SHIFT, algn))
> +		return 1;

There is a regression in the mpt3sas driver because of this change.
When, in a dom0, this driver creates its DMA pool at probe time and
calls dma_pool_zalloc() (see [1]), the call to
range_straddles_page_boundary() (from xen_swiotlb_alloc_coherent())
returns 1 because of the alignment checks added by this patch. Then the
call to xen_create_contiguous_region() in xen_swiotlb_alloc_coherent()
fails because the passed size order is too big (> MAX_CONTIG_ORDER).
This driver sets the pool allocation block size to 2.3+ MBytes.

From previous discussions on the v1 patch, these checks are not
necessary from xen_swiotlb_alloc_coherent() that already ensures
alignment, right?

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/scsi/mpt3sas/mpt3sas_base.c?h=v6.12.1#n6227

Regards,
Thierry

