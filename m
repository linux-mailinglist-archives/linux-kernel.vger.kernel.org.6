Return-Path: <linux-kernel+bounces-276139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A0F948EFE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A3928F153
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BB51C37A5;
	Tue,  6 Aug 2024 12:23:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D41D52B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947029; cv=none; b=ACbwrNgqS0zMtVSGfVzccf5JiBe017Q4eGINJgGG4WwNU4EP7aVjZVGPH0ixt+gU1e+8Xdr1UvsxalmX3e3iv28vqJl+iX497uUiD994XKsjj9VkEKcgNFKkmVh/eV7vQDt3yFpUbDIhlYIII98/ogcsWWS+XSAl4Sm/efsmvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947029; c=relaxed/simple;
	bh=PFMBY7T5xc7aoaFgPa4YWNBsfl8yUUtwGtfrAjmY5j8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7PYAagZeb3SHB0bW9CYJ7BSVDLIPVJzXmcz5Uivhk8hMmJVyaf8ta9UrVJWAl7J4PE8WSwYZ/mMhNM/fuJ5J5xJz0XE61UI8HuiHvj92OdpzzXURtAsE3shUMvJbieGyrTmCnMUnEkshcve4t9Fl9uCwEpZCgiR0+DN1kEtOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1sbJE4-0002qq-KH; Tue, 06 Aug 2024 14:23:40 +0200
Message-ID: <8040eb85dbdef646a3373ef4602a9614f2d468c1.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Remove GFP_HIGHUSER in systems with 32
 address limits
From: Lucas Stach <l.stach@pengutronix.de>
To: Xiaolei Wang <xiaolei.wang@windriver.com>,
 linux+etnaviv@armlinux.org.uk,  christian.gmeiner@gmail.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 06 Aug 2024 14:23:39 +0200
In-Reply-To: <20240806104733.2018783-1-xiaolei.wang@windriver.com>
References: <20240806104733.2018783-1-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

Hi Xiaolei,

Am Dienstag, dem 06.08.2024 um 18:47 +0800 schrieb Xiaolei Wang:
> GFP_HIGHUSER is for userspace allocations that may be mapped
> to userspace,An example may be a hardware allocation that maps
> data directly into userspace but has no addressing limitations,
> this conflicts with GFP_DMA32,The kernel reports a BUG:
>=20
GFP_HIGHUSER is a combination of GFP_USER | __GFP_HIGHMEM. Only the
highmem part is incompatible with DMA32. You don't want to clear the
GFP_USER bit here, as the driver allocated buffers might be mapped to
userspace.

Regards,
Lucas

> kernel BUG at include/linux/gfp.h:139!
> Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> Modules linked in:
> Hardware name: NXP i.MX8MPlus EVK board (DT)
> pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : __alloc_pages_noprof+0x5d8/0x72c
>  lr : alloc_pages_mpol_noprof+0x100/0x4e0
>  sp : ffffffc08c6a71c0
>  x29: ffffffc08c6a71c0 x28: ffffffc086e46000 x27: ffffffc086e46a68
>  x26: 1ffffff81122b260 x25: ffffffc089159304 x24: ffffff80da938000
>  x23: 0000000000000000 x22: 0000000000000000 x21: ffffff80da938000
>  x20: 1ffffff8118d4e46 x19: 0000000000146cc6 x18: 0000000000000000
>  x17: ffffffc081b00980 x16: ffffffc081b002a8 x15: 1ffffff8118d4e56
>  x14: 00000000f1f1f1f1 x13: 00000000f3f3f300 x12: 0000000000000000
>  x11: ffffff80da9384c8 x10: ffffff80da938000 x9 : 00000000f2f2f200
>  x8 : 0000000041b58ab3 x7 : 00000000f3000000 x6 : 00000000f3f3f3f3
>  x5 : 1ffffff01b527005 x4 : 000000000000000c x3 : 0000000000000006
>  x2 : 0000000000000000 x1 : 00000000000003a3 x0 : 0000000000000000
>  Call trace:
>   __alloc_pages_noprof+0x5d8/0x72c
>   alloc_pages_mpol_noprof+0x100/0x4e0
>   folio_alloc_mpol_noprof+0x18/0xb8
>   shmem_alloc_folio+0x154/0x1a8
>   shmem_alloc_and_add_folio+0x180/0xee8
>   shmem_get_folio_gfp+0x660/0x103c
>   shmem_read_folio_gfp+0x98/0x104
>   drm_gem_get_pages+0x174/0x5ac
>   etnaviv_gem_shmem_get_pages+0x18/0x5c
>   etnaviv_gem_get_pages+0x100/0x328
>   etnaviv_gem_cpu_prep+0x2e8/0x438
>   etnaviv_ioctl_gem_cpu_prep+0xb0/0x1ac
>   drm_ioctl_kernel+0x158/0x2c8
>   drm_ioctl+0x494/0xb48
>   __arm64_sys_ioctl+0x120/0x18c
>   invoke_syscall+0x6c/0x25c
>   el0_svc_common.constprop.0+0x174/0x278
>   do_el0_svc+0x40/0x58
>   el0_svc+0x50/0xc0
>   el0t_64_sync_handler+0xc0/0xc4
>   el0t_64_sync+0x190/0x194
>  Code: 52800021 39003c01 d4210000 17ffff57 (d4210000)
>=20
> Fixes: b72af445cd38 ("drm/etnaviv: request pages from DMA32 zone when nee=
ded")
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etna=
viv/etnaviv_gpu.c
> index 7c7f97793ddd..c3f329226bed 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -844,8 +844,10 @@ int etnaviv_gpu_init(struct etnaviv_gpu *gpu)
>  	 * request pages for our SHM backend buffers from the DMA32 zone to
>  	 * hopefully avoid performance killing SWIOTLB bounce buffering.
>  	 */
> -	if (dma_addressing_limited(gpu->dev))
> -		priv->shm_gfp_mask |=3D GFP_DMA32;
> +	if (dma_addressing_limited(gpu->dev)) {
> +		priv->shm_gfp_mask |=3D GFP_DMA32 & GFP_USER;
> +		priv->shm_gfp_mask &=3D ~GFP_HIGHUSER;
> +	}
> =20
>  	/* Create buffer: */
>  	ret =3D etnaviv_cmdbuf_init(priv->cmdbuf_suballoc, &gpu->buffer,


