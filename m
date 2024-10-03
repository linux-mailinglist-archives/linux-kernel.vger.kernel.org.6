Return-Path: <linux-kernel+bounces-349258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2533898F344
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80F128281E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D64E1A3033;
	Thu,  3 Oct 2024 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9MXDicp"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF401A2C06
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970884; cv=none; b=sM/jqJISBzR23rDh4P66ZGHC1I3myMUhpeRf7XxS4FHqh0ue+4cgKQIybCScATQBg9vGMiQRccNuIQABRDVSDDD5OY93dVf0RIY1lT6P05GTCsOAQxdT4WYAUQiJlmDqENR7R2xusCMOpbvhLuJdS+zPPo5Ye6PhAR7SxrU0nKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970884; c=relaxed/simple;
	bh=Dmr73yYMO3R8FpsZ2/WHKis7JEc3Bj0B1/YZcAb8FY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1BPjkBRhx5bwCqxWr8T46hdkI2QW8J3aINtA0XsYRa6nrT9UyWyupsAXTkMMerXUzVQOm3zYOqRi9A0Hooa4T7K4k8/is6gUs3b9FOlcEVCO3aruXOPXfgcn5i+V6/KhJ0sKyZKqLMcCPAsc5m+JseWlsKFz9nP2HYOUg7L6vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9MXDicp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e13718283bso187959a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727970882; x=1728575682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yGeUrKYFIPCVFsOqzylmOrv3kBoBBc0wc9fqVx2R8I=;
        b=h9MXDicpHsFLc3w0Dm2eGj+ww9kiuPqZzbVHo7reEm6yXMz/2lJFskqZTU0xFK5ZO4
         pMsQBijiT6KL8C+xIQCSGZKlfoMOLk96mTXm/XfDz9cTQZW8mewuX/mNHbet0PRxvk2s
         TexVNn1O6o+IoKxY1iwOn6k+Rq3zUX0vWg7YdcJt2JGh6TOFQwkEOUoeUJgB/8bj1fiW
         ChppqpXG0FeNKJQ9X3P+mEgsCC3EQmorQN6kLuv0imPgHNJAK0IhmQCmfKZqLlk1TtPB
         1BaE8mOkWsamwAVHpqzRHAeOmdchiCPRHeDLvQ1WybCux5ec++bBmd6QNelVfEb3lSJr
         D12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970882; x=1728575682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yGeUrKYFIPCVFsOqzylmOrv3kBoBBc0wc9fqVx2R8I=;
        b=j2E6rmVZ9996a41HsHKTnAHzfQzaRYJHd1Z2rCzIVPWuxHck4YdZB+AFtPAxN8xAWe
         MJiJZt0L3ZBa+cWZ4hv2W4jO9Yl5t7Nb3bRo04Hjf9R02pBXOhI/hqUJtixzJfEw3q1E
         ifBarAbId/f2cNMihg60pBJcxEutTgvT2xGF+NRBDRaUh8bZ5kbhy15MbkAmuaBlhI8z
         N5fKo9JUXQDQbXUuBktN0jNHQ+kCslddpcAPlqUS4OQdDBibm6HcWCq75kp5oCm0qH95
         XWjtrak60VneMFMcqOdTP6BeWXQafDs/5anCzwIT/8ylv8NTPaO/GDqaz+0YDMHhR5wx
         rIUA==
X-Forwarded-Encrypted: i=1; AJvYcCU4IBlwuib1j33dBCGpemmQAvpYmAeFjVmFTdX94LdEScGhUYFXLJoEJ9i8trBdfFkWGHnd0LimvgyHa5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFS46mhbrebuySOIRU/jQieKW3Iy5fB2m6k1vMPb1JPcmcs0nJ
	VlYK2WrE7U/FIz/Ve/XUtuI9Dw1Uiq9ee+esrjZKoZD6Fx/bS52ebOCpJJkgg89Mt5gAyqHb2ra
	HPnHCjbCEIL1+H7BobVd55GuLACc=
X-Google-Smtp-Source: AGHT+IH+eTjTi91vp6di708DRWo+fli07tV+SgXGhpx5vBaiOKNM8nEPU0iifLJQbB3mv3n732aR5ljw2ZJKiemM5cM=
X-Received: by 2002:a17:90b:3c6:b0:2da:a6d4:fd5d with SMTP id
 98e67ed59e1d1-2e184527f84mr3469685a91.1.1727970882126; Thu, 03 Oct 2024
 08:54:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003060650.18454-1-wuhoipok@gmail.com>
In-Reply-To: <20241003060650.18454-1-wuhoipok@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 3 Oct 2024 11:54:30 -0400
Message-ID: <CADnq5_PA37NQ52-Y8r6JEtXDRwPehzM5+cxysiZgVks4AkivjQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: add late_register for connector
To: Wu Hoi Pok <wuhoipok@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Christian Zigotzky <chzigotzky@xenosoft.de>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Hans

On Thu, Oct 3, 2024 at 2:33=E2=80=AFAM Wu Hoi Pok <wuhoipok@gmail.com> wrot=
e:
>
> This is a fix patch not tested yet,
> for a bug I introduce in previous rework of radeon driver.
> The bug is a null dereference in 'aux.dev', which is the
> 'device' not registered, resulting in kernel panic. By having
> 'late_register', the connector should be registered after
> 'drm_dev_register' automatically.
>
> Please help testing thank you.
>
> Signed-off-by: Wu Hoi Pok <wuhoipok@gmail.com>
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

