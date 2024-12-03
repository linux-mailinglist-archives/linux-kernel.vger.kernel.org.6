Return-Path: <linux-kernel+bounces-429980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA31A9E2A3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A959A1643CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C2F1FC0FD;
	Tue,  3 Dec 2024 18:04:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B534B1F75B7
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249066; cv=none; b=Ixt0W/FfF1v83QmC4BpSDyADWOYPvzaOqxeqq0ngqM/6bFFNPt38DIusM5GQGu3ZAYVI5RN5V2bjtPDvJCNRC+4+RK0flp10u764aqGIewL+r3NmnA08hNF+DL4s7cAdeAEgwW0DHCf4o1FwwOD6bcMhPXR8h5b/sHYcyqAaVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249066; c=relaxed/simple;
	bh=n5SCwpRi1FMg9fPmeI65RSlLT7dQDJAtyLfM0kBY5QQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RG86K61pEG1n3MYK7fXMPsnX+lUV7QwcoswWkZzi5HJbZtoXaJnwHp1L9QhNOXfSflWRmLqnk686adPetPplGuOcXFLbxRaMohJPsdaGLPMb+mQcoHuSViHk7ZkLjck6UsI2G00Pkyihjd9IjDuhRSCV/qMTM4v3DbV42t5jy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tIXFy-0007Zv-TO; Tue, 03 Dec 2024 19:04:18 +0100
Message-ID: <bb0610b61e2f728554f035e25e5530e1a10fd36d.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] drm/etnaviv: Preallocate STLB according to CPU
 PAGE_SIZE
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Russell King
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 2024 19:04:18 +0100
In-Reply-To: <20241108143658.2229786-1-sui.jingfeng@linux.dev>
References: <20241108143658.2229786-1-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Am Freitag, dem 08.11.2024 um 22:36 +0800 schrieb Sui Jingfeng:
> The dma_direct_alloc() allocate one page at minmium, which size is the CP=
U
> PAGE_SIZE. while the etnaviv_iommuv2_ensure_stlb() only ask for 4KiB. The
> rest memory space that beyond 4KiB gets wasted on bigger page size system=
s.
> For example, on 16KiB CPU page size systems, we will waste the rest 12KiB=
.
> On 64KiB CPU page size systems, we will waste the rest 60KiB.
>=20
> Since addresses within one page are always contiguous, the rest memory ca=
n
> be used to store adjacent slave TLB entries. Then, when the neighbourhood=
s
> TLB is being hit on the next time, we don't have to ask another one page
> from the system. Saving both memorys and times overhead because of that.
>=20
While this isn't adding a lot of code to etnaviv, I wonder if this
couldn't be handled by using a dma_pool for the pagetable allocations.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c | 64 +++++++++++++++++++---
>  1 file changed, 56 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c b/drivers/gpu/drm=
/etnaviv/etnaviv_iommu_v2.c
> index d664ae29ae20..fa6eed1ae1be 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_iommu_v2.c
> @@ -44,19 +44,66 @@ to_v2_context(struct etnaviv_iommu_context *context)
>  	return container_of(context, struct etnaviv_iommuv2_context, base);
>  }
> =20
> +static int etnaviv_iommuv2_stlb_free(struct etnaviv_iommuv2_context *con=
text)
> +{
> +	struct device *dev =3D context->base.global->dev;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < MMUv2_MAX_STLB_ENTRIES; ++i) {
> +		u32 *vaddr =3D context->stlb_cpu[i];
> +
> +		if (!vaddr)
> +			continue;
> +
> +		context->stlb_cpu[i] =3D NULL;
> +
> +		if (i % (PAGE_SIZE / SZ_4K))
> +			continue;
> +
> +		dma_free_wc(dev, PAGE_SIZE, vaddr, context->stlb_dma[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +etnaviv_iommuv2_ensure_stlb_new(struct etnaviv_iommuv2_context *context,
> +				unsigned int stlb)
> +{
> +	struct device *dev =3D context->base.global->dev;
> +	void *vaddr;
> +	dma_addr_t daddr;
> +	unsigned int i;
> +
> +	if (context->stlb_cpu[stlb])
> +		return 0;
> +
> +	vaddr =3D dma_alloc_wc(dev, PAGE_SIZE, &daddr, GFP_KERNEL);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> +	memset32(vaddr, MMUv2_PTE_EXCEPTION, PAGE_SIZE / sizeof(u32));
> +
> +	stlb &=3D ~(PAGE_SIZE / SZ_4K - 1);
> +
> +	for (i =3D 0; i < PAGE_SIZE / SZ_4K; ++i) {
> +		context->stlb_cpu[stlb + i] =3D vaddr;
> +		context->stlb_dma[stlb + i] =3D daddr;
> +		context->mtlb_cpu[stlb + i] =3D daddr | MMUv2_PTE_PRESENT;
> +		vaddr +=3D SZ_4K;
> +		daddr +=3D SZ_4K;
> +	}
> +
> +	return 0;
> +}
> +
>  static void etnaviv_iommuv2_free(struct etnaviv_iommu_context *context)
>  {
>  	struct etnaviv_iommuv2_context *v2_context =3D to_v2_context(context);
> -	int i;
> =20
>  	drm_mm_takedown(&context->mm);
> =20
> -	for (i =3D 0; i < MMUv2_MAX_STLB_ENTRIES; i++) {
> -		if (v2_context->stlb_cpu[i])
> -			dma_free_wc(context->global->dev, SZ_4K,
> -				    v2_context->stlb_cpu[i],
> -				    v2_context->stlb_dma[i]);
> -	}
> +	etnaviv_iommuv2_stlb_free(v2_context);
> =20
>  	dma_free_wc(context->global->dev, SZ_4K, v2_context->mtlb_cpu,
>  		    v2_context->mtlb_dma);
> @@ -65,6 +112,7 @@ static void etnaviv_iommuv2_free(struct etnaviv_iommu_=
context *context)
> =20
>  	vfree(v2_context);
>  }
> +
>  static int
>  etnaviv_iommuv2_ensure_stlb(struct etnaviv_iommuv2_context *v2_context,
>  			    int stlb)
> @@ -109,7 +157,7 @@ static int etnaviv_iommuv2_map(struct etnaviv_iommu_c=
ontext *context,
>  	mtlb_entry =3D (iova & MMUv2_MTLB_MASK) >> MMUv2_MTLB_SHIFT;
>  	stlb_entry =3D (iova & MMUv2_STLB_MASK) >> MMUv2_STLB_SHIFT;
> =20
> -	ret =3D etnaviv_iommuv2_ensure_stlb(v2_context, mtlb_entry);
> +	ret =3D etnaviv_iommuv2_ensure_stlb_new(v2_context, mtlb_entry);
>  	if (ret)
>  		return ret;
> =20


