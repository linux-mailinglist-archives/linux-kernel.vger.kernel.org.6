Return-Path: <linux-kernel+bounces-345933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3F898BD14
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3DBB213FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED441BF7F5;
	Tue,  1 Oct 2024 13:10:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008D1EB29
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788223; cv=none; b=nZB/XIPjZLCy8Zp2BKeRRdl3HLJTkb2oZTPjjFPUZeSYAWrfUfUcPEn1b7QSsb3AADfeu1SgquQat0DsUP1jCJ2ysgAtjxS/bI5VRnQDw8hKVKn5jRniYSRezvevI1OZqC5Wmor3MvxZjAcexreUv32Gardb/jYFGJJtw98tUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788223; c=relaxed/simple;
	bh=W+cSLWEfIH5Pz1bD5QW3kSoRGkJbhjA7XycijzEZ19o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqv5Sp2mC1m3PqWPudebjFD9guITc5oEmUBQVcWnmWeSBjeIkXdNxj/TpUWpdpxfRfZsoAAVUkZ7TvGsz7D/RfuPkPjEZUtJ+NeJCsUCnXYyYtYn4JOGiGVSRQXESiBkD5fU09Oxbi5Qw48LzHtk4peacN5OvZ8oN+CVLOvseoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svcdr-0008U4-Gj; Tue, 01 Oct 2024 15:10:15 +0200
Message-ID: <45d134bbd77a53de225b7bef55c73778bb7dc993.camel@pengutronix.de>
Subject: Re: [PATCH v15 02/19] drm/etnaviv: Export drm_gem_print_info() and
 use it
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 15:10:14 +0200
In-Reply-To: <20240908094357.291862-3-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-3-sui.jingfeng@linux.dev>
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
> This will make the newly implemented etnaviv_gem_object_funcs::print_info
> get in use, which improves code sharing and simplifies debugfs. Achieve
> better humen readability for debug log.
>=20
> Use container_of_const() if 'struct etnaviv_gem_object *etnaviv_obj' is a
> constant pointer.
>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/drm_gem.c             |  1 +
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 13 +++++--------
>  include/drm/drm_gem.h                 |  2 ++
>  3 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index d4bbc5d109c8..9c5c971c1b23 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1160,6 +1160,7 @@ void drm_gem_print_info(struct drm_printer *p, unsi=
gned int indent,
>  	if (obj->funcs->print_info)
>  		obj->funcs->print_info(p, indent, obj);
>  }
> +EXPORT_SYMBOL(drm_gem_print_info);

This needs to be a separate patch. I don't think I can take such a
change intermingled with etnaviv changes in the same patch. This needs
some acks from DRM core.

Regards,
Lucas

> =20
>  int drm_gem_pin_locked(struct drm_gem_object *obj)
>  {
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index 543d881585b3..6bdf72cd9e85 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2015-2018 Etnaviv Project
>   */
> =20
> +#include <drm/drm_gem.h>
>  #include <drm/drm_prime.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/shmem_fs.h>
> @@ -432,15 +433,11 @@ int etnaviv_gem_wait_bo(struct etnaviv_gpu *gpu, st=
ruct drm_gem_object *obj,
>  #ifdef CONFIG_DEBUG_FS
>  static void etnaviv_gem_describe(struct drm_gem_object *obj, struct seq_=
file *m)
>  {
> -	struct etnaviv_gem_object *etnaviv_obj =3D to_etnaviv_bo(obj);
> +	struct drm_printer p =3D drm_seq_file_printer(m);
>  	struct dma_resv *robj =3D obj->resv;
> -	unsigned long off =3D drm_vma_node_start(&obj->vma_node);
>  	int r;
> =20
> -	seq_printf(m, "%08x: %c %2d (%2d) %08lx %p %zd\n",
> -			etnaviv_obj->flags, is_active(etnaviv_obj) ? 'A' : 'I',
> -			obj->name, kref_read(&obj->refcount),
> -			off, etnaviv_obj->vaddr, obj->size);
> +	drm_gem_print_info(&p, 1, obj);
> =20
>  	r =3D dma_resv_lock(robj, NULL);
>  	if (r)
> @@ -461,7 +458,7 @@ void etnaviv_gem_describe_objects(struct etnaviv_drm_=
private *priv,
>  	list_for_each_entry(etnaviv_obj, &priv->gem_list, gem_node) {
>  		struct drm_gem_object *obj =3D &etnaviv_obj->base;
> =20
> -		seq_puts(m, "   ");
> +		seq_printf(m, "obj[%d]:\n", count);
>  		etnaviv_gem_describe(obj, m);
>  		count++;
>  		size +=3D obj->size;
> @@ -556,7 +553,7 @@ static void etnaviv_gem_object_info(struct drm_printe=
r *p,
>  {
>  	const struct etnaviv_gem_object *etnaviv_obj;
> =20
> -	etnaviv_obj =3D container_of(obj, struct etnaviv_gem_object, base);
> +	etnaviv_obj =3D container_of_const(obj, struct etnaviv_gem_object, base=
);
> =20
>  	drm_printf_indent(p, indent, "caching mode=3D%s\n",
>  			  etnaviv_gem_obj_caching_info(etnaviv_obj->flags));
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index bae4865b2101..0791566fab53 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -480,6 +480,8 @@ void drm_gem_vm_close(struct vm_area_struct *vma);
>  int drm_gem_mmap_obj(struct drm_gem_object *obj, unsigned long obj_size,
>  		     struct vm_area_struct *vma);
>  int drm_gem_mmap(struct file *filp, struct vm_area_struct *vma);
> +void drm_gem_print_info(struct drm_printer *p, unsigned int indent,
> +			const struct drm_gem_object *obj);
> =20
>  /**
>   * drm_gem_object_get - acquire a GEM buffer object reference


