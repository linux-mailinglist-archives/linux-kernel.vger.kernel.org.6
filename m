Return-Path: <linux-kernel+bounces-345930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D1698BD0A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0FEB215E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E641E529;
	Tue,  1 Oct 2024 13:05:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D96637
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787902; cv=none; b=sCOQK6xqv8tDE7ohPKdWtQLoaew2GdN5HWgyNrffA83XIR/jXhEr2PnjZo7Pf2mlDe77mnQALH9+D2tuxjfyX/0TkyVzsuk5GrY0i7doKQGLfYMdS8I/NaC/vdayOTqApGjZL12dT+BHmaiKcfRp+n/jAa+rMAEnfhUajQ2Vyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787902; c=relaxed/simple;
	bh=ddYcEScD3D3snqUi8NxMJEU68fqngyKyG5WL0ouVpX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z7f+9btdbgtYKvbkoT8xtUEvyVdKeVjCDjmUiiU2p+re3whmA6eR1+FsU0ZABlowGoApEdAmfnKgNMyvxLrXiSN+fH6vEPGMRPNeQot2k0sPIwAmgqQSvr7+lRpaDVbZndZPifcv+577RcYdLyDM7EUbsJCOI/CB9FkckN6aCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1svcYg-0005l1-DU; Tue, 01 Oct 2024 15:04:54 +0200
Message-ID: <e4270c6629f4f7ac086e7a177374bdbc306226a0.camel@pengutronix.de>
Subject: Re: [PATCH v15 01/19] drm/etnaviv: Implement
 drm_gem_object_funcs::print_info()
From: Lucas Stach <l.stach@pengutronix.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>, Russell King
	 <linux+etnaviv@armlinux.org.uk>, dri-devel@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 15:04:53 +0200
In-Reply-To: <20240908094357.291862-2-sui.jingfeng@linux.dev>
References: <20240908094357.291862-1-sui.jingfeng@linux.dev>
	 <20240908094357.291862-2-sui.jingfeng@linux.dev>
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

Hi Sui,

Am Sonntag, dem 08.09.2024 um 17:43 +0800 schrieb Sui Jingfeng:
> It will be called by drm_gem_print_info() if implemented, and it can
> provide more information about the framebuffer objects.

Etnaviv GEM BOs are not framebuffer objects.

>=20
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 32 +++++++++++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_gem.h |  2 +-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etna=
viv/etnaviv_gem.c
> index 4247a10f8d4f..543d881585b3 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -534,8 +534,40 @@ static const struct vm_operations_struct vm_ops =3D =
{
>  	.close =3D drm_gem_vm_close,
>  };
> =20
> +static const char *etnaviv_gem_obj_caching_info(u32 flags)
> +{
> +	switch (flags & ETNA_BO_CACHE_MASK) {
> +	case ETNA_BO_CACHED:
> +		return "cached";
> +	case ETNA_BO_UNCACHED:
> +		return "uncached";
> +	case ETNA_BO_WC:
> +		return "write-combine";

"write-combined" to be consistent with the other two.

> +	default:
> +		break;
> +	}
> +
> +	return "unknown";
> +}
> +
> +static void etnaviv_gem_object_info(struct drm_printer *p,
> +				    unsigned int indent,
> +				    const struct drm_gem_object *obj)
> +{
> +	const struct etnaviv_gem_object *etnaviv_obj;
> +
> +	etnaviv_obj =3D container_of(obj, struct etnaviv_gem_object, base);
> +
> +	drm_printf_indent(p, indent, "caching mode=3D%s\n",
> +			  etnaviv_gem_obj_caching_info(etnaviv_obj->flags));
> +	drm_printf_indent(p, indent, "active=3D%s\n",
> +			  str_yes_no(is_active(etnaviv_obj)));
> +	drm_printf_indent(p, indent, "vaddr=3D%p\n", etnaviv_obj->vaddr);

Why should we expose the vaddr to userspace? I don't see why this would
be relevant even as debug info and it leaks the kernel vmap area
address, which could be abused to facilitate kernel exploits.

Regards,
Lucas

> +}
> +
>  static const struct drm_gem_object_funcs etnaviv_gem_object_funcs =3D {
>  	.free =3D etnaviv_gem_free_object,
> +	.print_info =3D etnaviv_gem_object_info,
>  	.pin =3D etnaviv_gem_prime_pin,
>  	.unpin =3D etnaviv_gem_prime_unpin,
>  	.get_sg_table =3D etnaviv_gem_prime_get_sg_table,
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.h b/drivers/gpu/drm/etna=
viv/etnaviv_gem.h
> index a42d260cac2c..3f8fe19a77cc 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.h
> @@ -68,7 +68,7 @@ struct etnaviv_gem_ops {
>  	int (*mmap)(struct etnaviv_gem_object *, struct vm_area_struct *);
>  };
> =20
> -static inline bool is_active(struct etnaviv_gem_object *etnaviv_obj)
> +static inline bool is_active(const struct etnaviv_gem_object *etnaviv_ob=
j)
>  {
>  	return atomic_read(&etnaviv_obj->gpu_active) !=3D 0;
>  }


