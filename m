Return-Path: <linux-kernel+bounces-345997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6498BE23
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BFA28253E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7831C3F34;
	Tue,  1 Oct 2024 13:41:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C9A19F110
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790063; cv=none; b=rK4o77O1V9m9UUJcfzfdgirGEHi4LUK4xlJXPA+3BYbU61Jd/ymg+Fjy0H/fdn4FUCuor/LeT+AKRutn+yteuWP/0MIpa8PDtA7ngnc56oTStOWlDUVsIAm6CqnGU6WaepWnN9gjiv3v8ejwCyCI4H3spn+K5f3z0q9tmySrVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790063; c=relaxed/simple;
	bh=WzVfn7J1Fd+WhQYzbQblUkhzWwnKMfMZ7IaY2l4tFZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UBUhDBVZk2FAuRAOHp7uExvjPvRhyVu4R66AGVCDi6H9vNz4fQ5inBvTHZ+6CHJIIeyvnMV62Y3dx9kknUpQ2y8f8Mr+r4GUifS6cOcZUHU6kExTFXxxM6t3YwO/tN+BTqHcw8kLPiG4bBO+mNHJzjIxYjagJtptV0skoFeSYPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svd7W-0007sc-4U; Tue, 01 Oct 2024 15:40:54 +0200
Message-ID: <4a8d06075edb6b5e0d2d71355a55acfd19cd2983.camel@pengutronix.de>
Subject: Re: [PATCH v15 04/19] drm/etnaviv: Make etnaviv_gem_prime_vmap() a
 static function
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 15:40:53 +0200
In-Reply-To: <20240908094357.291862-5-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-5-sui.jingfeng@linux.dev>
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

Am Sonntag, dem 08.09.2024 um 17:43 +0800 schrieb Sui Jingfeng:
> The etnaviv_gem_prime_vmap() function has no caller in the
> etnaviv_gem_prime.c file, move it into etnaviv_gem.c file.
> While at it, rename it as etnaviv_gem_object_vmap(), since
> it is a intermidiate layer function, it has no direct relation
> ship with the PRIME. The etnaviv_gem_prime.c file already has
> etnaviv_gem_prime_vmap_impl() as the implementation to vmap
> a imported GEM buffer object.
>=20
I don't agree with the premise with this patch. This function is
clearly prime specific, so I don't think it should move.

Regards,
Lucas

> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.h       |  1 -
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c       | 16 +++++++++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 12 ------------
>  3 files changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etna=
viv/etnaviv_drv.h
> index 2eb2ff13f6e8..c217b54b214c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
> @@ -55,7 +55,6 @@ int etnaviv_ioctl_gem_submit(struct drm_device *dev, vo=
id *data,
> =20
>  int etnaviv_gem_mmap_offset(struct drm_gem_object *obj, u64 *offset);
>  struct sg_table *etnaviv_gem_prime_get_sg_table(struct drm_gem_object *o=
bj);
> -int etnaviv_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map =
*map);
>  struct drm_gem_object *etnaviv_gem_prime_import_sg_table(struct drm_devi=
ce *dev,
>  	struct dma_buf_attachment *attach, struct sg_table *sg);
>  int etnaviv_gem_prime_pin(struct drm_gem_object *obj);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index fad23494d08e..85d4e7c87a6a 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -6,6 +6,7 @@
>  #include <drm/drm_gem.h>
>  #include <drm/drm_prime.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iosys-map.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
> @@ -340,6 +341,19 @@ void *etnaviv_gem_vmap(struct drm_gem_object *obj)
>  	return etnaviv_obj->vaddr;
>  }
> =20
> +static int etnaviv_gem_object_vmap(struct drm_gem_object *obj,
> +				   struct iosys_map *map)
> +{
> +	void *vaddr;
> +
> +	vaddr =3D etnaviv_gem_vmap(obj);
> +	if (!vaddr)
> +		return -ENOMEM;
> +	iosys_map_set_vaddr(map, vaddr);
> +
> +	return 0;
> +}
> +
>  void etnaviv_gem_vunmap(struct drm_gem_object *obj)
>  {
>  	struct etnaviv_gem_object *etnaviv_obj =3D to_etnaviv_bo(obj);
> @@ -595,7 +609,7 @@ static const struct drm_gem_object_funcs etnaviv_gem_=
object_funcs =3D {
>  	.pin =3D etnaviv_gem_prime_pin,
>  	.unpin =3D etnaviv_gem_prime_unpin,
>  	.get_sg_table =3D etnaviv_gem_prime_get_sg_table,
> -	.vmap =3D etnaviv_gem_prime_vmap,
> +	.vmap =3D etnaviv_gem_object_vmap,
>  	.vunmap =3D etnaviv_gem_object_vunmap,
>  	.mmap =3D etnaviv_gem_mmap,
>  	.vm_ops =3D &vm_ops,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/dr=
m/etnaviv/etnaviv_gem_prime.c
> index bea50d720450..8f523cbee60a 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
> @@ -25,18 +25,6 @@ struct sg_table *etnaviv_gem_prime_get_sg_table(struct=
 drm_gem_object *obj)
>  	return drm_prime_pages_to_sg(obj->dev, etnaviv_obj->pages, npages);
>  }
> =20
> -int etnaviv_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map =
*map)
> -{
> -	void *vaddr;
> -
> -	vaddr =3D etnaviv_gem_vmap(obj);
> -	if (!vaddr)
> -		return -ENOMEM;
> -	iosys_map_set_vaddr(map, vaddr);
> -
> -	return 0;
> -}
> -
>  int etnaviv_gem_prime_pin(struct drm_gem_object *obj)
>  {
>  	if (!obj->import_attach) {


