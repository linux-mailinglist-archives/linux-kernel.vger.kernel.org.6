Return-Path: <linux-kernel+bounces-350438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B300990526
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05509282C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7775C212EE3;
	Fri,  4 Oct 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFXmXkPS"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463B015748E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050473; cv=none; b=dETM+VVAiGabIShAXOWfozxAuwT0eXO0sSGB3zfOyuZIj9jNPMXK6F1lZQL1CJkJ573BuPU7ZhXO12UtERDcqJ7KVEVSlSmPS5IoQ3wyhDz7Cr1V0wAVtBf58dWkNKbyxjMgmd0bSZVtM3JAa9su+d8eH4OWR79+izyX328BbbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050473; c=relaxed/simple;
	bh=/zMrKxC8mpcCh8PWGsWshD5vTxrsSfWP0tQd1Iy3mJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ku5g40lqvFNxQRE+VvtFRM/eYMeb92+MvBwrEfyjnxAawXvdiKnJLgteQ8o6bfT0a4cnCYfLfnNaCF5oKS8DbnGDvUaUI6usxSZYbAiN6tVLc3XvS18d9gKBVQOqy9dgMfVMcRnDgOPL/W+KTC2t/jRHwGqssIrXw/hCL00Y9Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFXmXkPS; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0752be2d1so308486a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728050471; x=1728655271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMwn901ZRLoRHXVyYDozCoh9nimOdyplKHDEtmswe7U=;
        b=IFXmXkPSquvdcAbfVm5N2Pc6mbPjwEWoaQvT1Rlb1AiwbTqbK6O/vpaL47IspyHOHN
         AYjCHwWVuXN1HlOJ6IF21MIsfuRtrDvSHXszl4dtsOkfPm68Tbdt0cAkuQMaPZpIsUlw
         AdGu8lM5SRq72MknI4zKmFDW6jVN27Eoa8/PV5HyEg7HzxGbbCLKg++D0Ri5hTs18oGF
         5PV+Qnri/YCV+tPUtTJx14yX94JYF9js1smlxmymZ84bRsZmxOhYx5+8m1LrcMLAebc6
         l31Vk1LHd3r9ONIkWyWmTnTUztYOZpCBlXVmb+zqK5NKGFnakcynm4gBzx7uJ2fD81/W
         RSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050471; x=1728655271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KMwn901ZRLoRHXVyYDozCoh9nimOdyplKHDEtmswe7U=;
        b=ii4U4sCvcwqiv2vXVTkXhQ9mc6pgch5BzKQFocMWuR2El2e1Cv+AqHwl2erPlAknjH
         e/OjuhLouyowss1xki/WsneXjhWinHdhFQB0EoiUqJxKOpo+/rYpwRojbR3m9TkFnuxt
         60lbewsmMZjtYd8oljgXr9JRzFZBDaOKu7AoOJmdsiOQUsSDG27tVk4o2JLUU6Yc1W4L
         u8bcUA9Z6Wyc50satXP/NkxHp5hGilTnRbqezPcB0dmLEMTJGBFjGjGFV8sDboQCnIus
         yqSKag+YQNkYyQUNhmGvstQmN9LVJdaDMF8wRiNJizcqQRZ6rupHnNcx1WVjr+fzp0v7
         AkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW51j3OgdXbpKkbTg7hYHMcVq25wrgStKGLG0d2XcNGs6MnsqDqcRbNMGgmaS/jHtWtr/e+zpxaTKS9um8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqlRx4/hs9hzM2kKao2ATEdCmmcYbfELm6rvMT90F+h5nk99D
	GsLke65UsMWY8mCEIBfIymOdUqEZc+dL5giBD7+JprkuPRQLFUMfZFugkxUc79Nx+48qI5i0cwz
	q1Ol5xYQWOyIGpgR6QynwOkA1tHM=
X-Google-Smtp-Source: AGHT+IEJ1tRqM5NLWvzkRdlOsKIDAq7K9+lPQKlj31f3AEwobSgsbCs+ky8e9auMeCNS8p7/tSoWstvR8FyH9iCmeAs=
X-Received: by 2002:a17:90a:c88:b0:2e0:9d3f:4292 with SMTP id
 98e67ed59e1d1-2e1e62117bemr1411095a91.1.1728050471300; Fri, 04 Oct 2024
 07:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004010601.3387-1-wuhoipok@gmail.com>
In-Reply-To: <20241004010601.3387-1-wuhoipok@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 10:00:59 -0400
Message-ID: <CADnq5_Nt=8Lx6KOXHf0DHmqo2O7dYKDTfGCz-w_Hv+__=BqP9w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: add late_register for connector
To: Wu Hoi Pok <wuhoipok@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Christian Zigotzky <chzigotzky@xenosoft.de>, Alex Deucher <alexander.deucher@amd.com>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:18=E2=80=AFPM Wu Hoi Pok <wuhoipok@gmail.com> wrot=
e:
>
> The patch is to solve null dereference in 'aux.dev', which is
> introduced in recent radeon rework. By having 'late_register',
> the connector should be registered after 'drm_dev_register'
> automatically, where in before it is the opposite.
>
> Fixes: 90985660ba48 ("drm/radeon: remove load callback from kms_driver")
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/atombios_dp.c       |  9 ++-------
>  drivers/gpu/drm/radeon/radeon_connectors.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeo=
n/atombios_dp.c
> index fca8b08535a5..6328627b7c34 100644
> --- a/drivers/gpu/drm/radeon/atombios_dp.c
> +++ b/drivers/gpu/drm/radeon/atombios_dp.c
> @@ -228,10 +228,8 @@ void radeon_dp_aux_init(struct radeon_connector *rad=
eon_connector)
>  {
>         struct drm_device *dev =3D radeon_connector->base.dev;
>         struct radeon_device *rdev =3D dev->dev_private;
> -       int ret;
>
>         radeon_connector->ddc_bus->rec.hpd =3D radeon_connector->hpd.hpd;
> -       radeon_connector->ddc_bus->aux.dev =3D radeon_connector->base.kde=
v;
>         radeon_connector->ddc_bus->aux.drm_dev =3D radeon_connector->base=
.dev;
>         if (ASIC_IS_DCE5(rdev)) {
>                 if (radeon_auxch)
> @@ -242,11 +240,8 @@ void radeon_dp_aux_init(struct radeon_connector *rad=
eon_connector)
>                 radeon_connector->ddc_bus->aux.transfer =3D radeon_dp_aux=
_transfer_atom;
>         }
>
> -       ret =3D drm_dp_aux_register(&radeon_connector->ddc_bus->aux);
> -       if (!ret)
> -               radeon_connector->ddc_bus->has_aux =3D true;
> -
> -       WARN(ret, "drm_dp_aux_register() failed with error %d\n", ret);
> +       drm_dp_aux_init(&radeon_connector->ddc_bus->aux);
> +       radeon_connector->ddc_bus->has_aux =3D true;
>  }
>
>  /***** general DP utility functions *****/
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index 528a8f3677c2..f9c73c55f04f 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -1786,6 +1786,20 @@ static enum drm_mode_status radeon_dp_mode_valid(s=
truct drm_connector *connector
>         return MODE_OK;
>  }
>
> +static int
> +radeon_connector_late_register(struct drm_connector *connector)
> +{
> +       struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
> +       int r =3D 0;
> +
> +       if (radeon_connector->ddc_bus->has_aux) {
> +               radeon_connector->ddc_bus->aux.dev =3D radeon_connector->=
base.kdev;
> +               r =3D drm_dp_aux_register(&radeon_connector->ddc_bus->aux=
);
> +       }
> +
> +       return r;
> +}
> +
>  static const struct drm_connector_helper_funcs radeon_dp_connector_helpe=
r_funcs =3D {
>         .get_modes =3D radeon_dp_get_modes,
>         .mode_valid =3D radeon_dp_mode_valid,
> @@ -1800,6 +1814,7 @@ static const struct drm_connector_funcs radeon_dp_c=
onnector_funcs =3D {
>         .early_unregister =3D radeon_connector_unregister,
>         .destroy =3D radeon_connector_destroy,
>         .force =3D radeon_dvi_force,
> +       .late_register =3D radeon_connector_late_register,
>  };
>
>  static const struct drm_connector_funcs radeon_edp_connector_funcs =3D {
> @@ -1810,6 +1825,7 @@ static const struct drm_connector_funcs radeon_edp_=
connector_funcs =3D {
>         .early_unregister =3D radeon_connector_unregister,
>         .destroy =3D radeon_connector_destroy,
>         .force =3D radeon_dvi_force,
> +       .late_register =3D radeon_connector_late_register,
>  };
>
>  static const struct drm_connector_funcs radeon_lvds_bridge_connector_fun=
cs =3D {
> @@ -1820,6 +1836,7 @@ static const struct drm_connector_funcs radeon_lvds=
_bridge_connector_funcs =3D {
>         .early_unregister =3D radeon_connector_unregister,
>         .destroy =3D radeon_connector_destroy,
>         .force =3D radeon_dvi_force,
> +       .late_register =3D radeon_connector_late_register,
>  };
>
>  void
> --
> 2.46.2
>

