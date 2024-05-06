Return-Path: <linux-kernel+bounces-170092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1498BD1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D45A2829FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746F815572A;
	Mon,  6 May 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="ECcH26Kd"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E78002A
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010486; cv=none; b=T7On46viCpssd3MO2Uybw5hRNHRv5lQ875AcCudbYhu6rPSot5aSLjj/oOQHJaEIKQGxSueAipQIkWEkuOk9YEvUUHBlL0oAEaZck0Wg889d2LCYyuFKu5ZVaFgygPX15V2BxLl9B4b1nOmQmYOUhVL5KsES0aaou1QbGDt9FVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010486; c=relaxed/simple;
	bh=6qMZ1v62YZiw5evT9b8AIft+BueNe2bcLh/OM4zv/Og=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1akL5TVb2qQQIB5zRE8sHLU5LzJVjAZznnr4MlPc4CMTAYW61QUvmFqKNJ3703SleTWG/qMwduPKNNKfC5GinUFB/FBcKYo1JqHpUVHL9twpcYigVRGuGSt8+xjE71tqwUSLa6KPcsZbQgF5Rmh+05VdHPbRcx1rWIcSsu0pYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=ECcH26Kd; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 47CBA1BCF87;
	Mon,  6 May 2024 17:48:01 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1715010481; bh=srKPK1Kv8jhLdWZU61PvI/zI+CBs9Hz1Jinnh4TWed0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ECcH26Kdga6BoqJP6f+Wr+EsWEcynNVu+MHNOUyx0ZeT1iuDJEzAAL7byUxVrwX1M
	 UExDmtTSdATmlM+3jKvFhbWmH05siHZcrDSPyu7vTSesVho3ko0xZvWv3cNZ1UER4k
	 aBpoT8yMJqZXisepfMjMbeC2fxdN1P15ao5K71IT1OPdOydZtC7mmi4r42Zvd+fK5A
	 15SxAgr7mippmhpjnBqZWIjY58fcg228e/mSsR25JZy9DK7uRcA5jQkwGWR9kCFsP1
	 yXD42vVTQnYkoTfVLxJmu6PYVWR9KwXyCOSWpkWTXcnlKecTFtXhvPRPV7q4SoO/+g
	 AUzlzM0tRqd6Q==
Date: Mon, 6 May 2024 17:48:00 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: mhkelley58@gmail.com
Cc: mhklinux@outlook.com, robin.murphy@arm.com, joro@8bytes.org,
 will@kernel.org, jgross@suse.com, sstabellini@kernel.org,
 oleksandr_tyshchenko@epam.com, hch@lst.de, m.szyprowski@samsung.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 xen-devel@lists.xenproject.org, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH 2/2] iommu/dma: Fix zero'ing of bounce buffer padding
 used by untrusted devices
Message-ID: <20240506174800.74ce570b@meshulam.tesarici.cz>
In-Reply-To: <20240408041142.665563-2-mhklinux@outlook.com>
References: <20240408041142.665563-1-mhklinux@outlook.com>
	<20240408041142.665563-2-mhklinux@outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

V Sun,  7 Apr 2024 21:11:42 -0700
mhkelley58@gmail.com naps=C3=A1no:

> From: Michael Kelley <mhklinux@outlook.com>
>=20
> iommu_dma_map_page() allocates swiotlb memory as a bounce buffer when
> an untrusted device wants to map only part of the memory in an
> granule. The goal is to disallow the untrusted device having
> DMA access to unrelated kernel data that may be sharing the granule.
> To meet this goal, the bounce buffer itself is zero'ed, and any
> additional swiotlb memory up to alloc_size after the bounce buffer
> end (i.e., "post-padding") is also zero'ed.
>=20
> However, as of commit 901c7280ca0d ("Reinstate some of "swiotlb: rework
> "fix info leak with DMA_FROM_DEVICE"""), swiotlb_tbl_map_single()
> always initializes the contents of the bounce buffer to the original
> memory. Zero'ing the bounce buffer is redundant and probably wrong per
> the discussion in that commit. Only the post-padding needs to be
> zero'ed.
>=20
> Also, when the DMA min_align_mask is non-zero, the allocated bounce
> buffer space may not start on a granule boundary. The swiotlb memory
> from the granule boundary to the start of the allocated bounce buffer
> might belong to some unrelated bounce buffer. So as described in the
> "second issue" in [1], it can't be zero'ed to protect against untrusted
> devices. But as of commit XXXXXXXXXXXX ("swiotlb: extend buffer
> pre-padding to alloc_align_mask if necessary"), swiotlb_tbl_map_single()

This is now commit af133562d5af.

> allocates pre-padding slots when necessary to meet min_align_mask
> requirements, making it possible to zero the pre-padding area as well.
>=20
> Finally, iommu_dma_map_page() uses the swiotlb for untrusted devices
> and also for certain kmalloc() memory. Current code does the zero'ing
> for both cases, but it is needed only for the untrusted device case.
>=20
> Fix all of this by updating iommu_dma_map_page() to zero both the
> pre-padding and post-padding areas, but not the actual bounce buffer.
> Do this only in the case where the bounce buffer is used because
> of an untrusted device.
>=20
> [1] https://lore.kernel.org/all/20210929023300.335969-1-stevensd@google.c=
om/
>=20
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> I've wondered if this code for zero'ing the pre- and post-padding
> should go in swiotlb_tbl_map_single(). The bounce buffer proper is
> already being initialized there. But swiotlb_tbl_map_single()
> would need to test for an untrusted device (or have a "zero the
> padding" flag passed in as part of the "attrs" argument), which
> adds complexity. Thoughts?

Historically, swiotlb has never cared about exposing data from a
previous user of a bounce buffer. I assume that's because it was
pointless to make an attempt at protecting system memory from a
malicious device that can do DMA to any address anyway. The situation
has changed with hardware IOMMUs, and that could be why the zeroing is
only done in the IOMMU path.

In short, if anybody can explain the value of concealing potentially
sensitive data from devices that are not behind an IOMMU, let's move
the zeroing to swiotlb. Otherwise, let's keep what we have.

Other than that (and the missing commit id), the patch looks good to me.

Reviewed-by: Petr Tesarik <petr@tesarici.cz>

Petr T

>=20
> The commit ID of Petr's patch is X'ed out above because Petr's patch
> hasn't gone into Linus' tree yet. We can add the real commit ID once
> this patch is ready to go in.
>=20
> Also I've haven't used any "Fixes:" tags. This patch really should
> be backported only if all the other recent swiotlb fixes get
> backported, and I'm unclear on whether that will happen.
>=20
>  drivers/iommu/dma-iommu.c | 29 ++++++++++++++++-------------
>  include/linux/iova.h      |  5 +++++
>  2 files changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c21ef1388499..ecac39b3190d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1154,9 +1154,6 @@ static dma_addr_t iommu_dma_map_page(struct device =
*dev, struct page *page,
>  	 */
>  	if (dev_use_swiotlb(dev, size, dir) &&
>  	    iova_offset(iovad, phys | size)) {
> -		void *padding_start;
> -		size_t padding_size, aligned_size;
> -
>  		if (!is_swiotlb_active(dev)) {
>  			dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map un=
aligned transaction.\n");
>  			return DMA_MAPPING_ERROR;
> @@ -1164,24 +1161,30 @@ static dma_addr_t iommu_dma_map_page(struct devic=
e *dev, struct page *page,
> =20
>  		trace_swiotlb_bounced(dev, phys, size);
> =20
> -		aligned_size =3D iova_align(iovad, size);
>  		phys =3D swiotlb_tbl_map_single(dev, phys, size,
>  					      iova_mask(iovad), dir, attrs);
> =20
>  		if (phys =3D=3D DMA_MAPPING_ERROR)
>  			return DMA_MAPPING_ERROR;
> =20
> -		/* Cleanup the padding area. */
> -		padding_start =3D phys_to_virt(phys);
> -		padding_size =3D aligned_size;
> +		/*
> +		 * Untrusted devices should not see padding areas with random
> +		 * leftover kernel data, so zero the pre- and post-padding.
> +		 * swiotlb_tbl_map_single() has initialized the bounce buffer
> +		 * proper to the contents of the original memory buffer.
> +		 */
> +		if (dev_is_untrusted(dev)) {
> +			size_t start, virt =3D (size_t)phys_to_virt(phys);
> =20
> -		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
> -		    (dir =3D=3D DMA_TO_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL)) {
> -			padding_start +=3D size;
> -			padding_size -=3D size;
> -		}
> +			/* Pre-padding */
> +			start =3D iova_align_down(iovad, virt);
> +			memset((void *)start, 0, virt - start);
> =20
> -		memset(padding_start, 0, padding_size);
> +			/* Post-padding */
> +			start =3D virt + size;
> +			memset((void *)start, 0,
> +			       iova_align(iovad, start) - start);
> +		}
>  	}
> =20
>  	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 83c00fac2acb..d2c4fd923efa 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -65,6 +65,11 @@ static inline size_t iova_align(struct iova_domain *io=
vad, size_t size)
>  	return ALIGN(size, iovad->granule);
>  }
> =20
> +static inline size_t iova_align_down(struct iova_domain *iovad, size_t s=
ize)
> +{
> +	return ALIGN_DOWN(size, iovad->granule);
> +}
> +
>  static inline dma_addr_t iova_dma_addr(struct iova_domain *iovad, struct=
 iova *iova)
>  {
>  	return (dma_addr_t)iova->pfn_lo << iova_shift(iovad);


