Return-Path: <linux-kernel+bounces-331737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A2C97B0B4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3630E1F228AA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176FD16EC0E;
	Tue, 17 Sep 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4iX5dtT"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7801EB2E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579275; cv=none; b=SDf9iORarprKJmCGMfSBYHi9RO2ZlzUNPSVF2BADqhFhNKO+2wjhLDiyYrHQVix56RrfXo30CCpI4mIp/ki9Y4oQDk1wJXXL8WZqUXisUkxC8iHSztToa4LUAwX1LHF+7tCaynpG2gyGHOrk5RxBjX7tNdw3L4t/Y+tmdwyU9sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579275; c=relaxed/simple;
	bh=A9dnX1pZ9CAAMEz86pL6CzeEKbetGgbWUyWKVJ1N4yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WeubbtToHQ2M22Tx+1sLB9LgsjJh+e993jDt2eiFQd5Q4Xt7MnWUiVKh/VR+19MveAa9MPi/dcTgB9tCSCZpzwANeJSQYGB4Ss5zSEwSQVZcopIX2tP2FX0WRVwWrhiwWaP1Rx5WBDdIDCvyKOasyTtRq34pOkvW3zwLNrOz+LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4iX5dtT; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d8a1a58d5aso503551a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726579273; x=1727184073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POFr2Bd6CmH5BZIMOjewYOxEcX6ZrAvV6FajAw0VAt4=;
        b=k4iX5dtT/BxfkxirfQDgBRpyUVm/oMaHufX23l/QdCpFS80lI/s1jmmfcCGChLLvPq
         JR0UBJtV/tZAf3NoSH9LDrKCYyuvUVs5bnR6C49dC9y4jro/a6QPYj08DSAe3v2FDzvL
         rZ6QQqjPXz5f3ohx6vhQ8jHz+Ci+gn6WMfdjNnenQs0ZMWahLDNmNkFNA2wlqHFGSsxE
         Jv4KJ7FZZEuN3P5s9iJH5XSxrjgTLIte/FfRdZtQBj8bTdZnfjkL1HZ9KEcOGe/i9DTN
         O5CjTQf8ZQZ5My0laiqsAtNJdzw88/YKkINGFV0i/IUaGfyLiWecH/2kvRKxTfIxZJm7
         Pv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726579273; x=1727184073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POFr2Bd6CmH5BZIMOjewYOxEcX6ZrAvV6FajAw0VAt4=;
        b=psBsLN0yAXNtjEzThxg6wUoHwULPda99aj7bUka8Cbu0hnM9ZixzGggBZxZAUKzhmc
         dHLu4KCyDIIjSoVC3CzSJEpvrYCV4PGxMZqatP4n0IpDoGLJVEsbyOQvz/6/ZHn94IeV
         BQzkcj9jm7lxO3DONZoAXN6o13jCntC5O4BCJy0MUX9zBQFrbhjWHZU1gV+9CUIJhKGs
         BNjI235gsQDkDa1PAfWuVPVz/PrwJoXmUtKA2ZqAFEbXzyVVjHmtO0BzH4mSUMOQtnWJ
         72ECMF1W4X3YE1pTReatz1eqHop5xldogLZ1hGzDAi1rXCFmeoR80EN8ffIL3JFBysLU
         zMRA==
X-Forwarded-Encrypted: i=1; AJvYcCUxCsKQzm2xw9z6xLv+3MssxAaf9hMkqyogQ6sRtn6B+dw7gv8D26t0h5quGoI8xpQjxVR7X1hn5cNve3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq9AQWCnRtYtq54dDaSNWZs405VPzEHuI+3Vm1uDGhuAYgN/EA
	172h/kqXC2qUy032ow3qA5ihCLg/1kiW0ZBB1XyKw+LfWTEDzG2NAfY9wQ0fx3ApxCmKkcEgcv4
	0CLrRpSt6upCpxUXxG08rjHd1Eek=
X-Google-Smtp-Source: AGHT+IHjNWh5CNBJRCGp31ma7fmz05XPtGvBsAlfXjTLm85sqM4sDr9JcsbaQU27QweMPt9f8e0Riu0kx4R0pJ654ng=
X-Received: by 2002:a17:90a:2e8a:b0:2d8:ca39:5972 with SMTP id
 98e67ed59e1d1-2db9ff6cd70mr9076236a91.1.1726579273043; Tue, 17 Sep 2024
 06:21:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802071752.116541-1-yaolu@kylinos.cn> <20240812060914.102614-1-yaolu@kylinos.cn>
In-Reply-To: <20240812060914.102614-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Sep 2024 09:21:00 -0400
Message-ID: <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Lu Yao <yaolu@kylinos.cn>
Cc: ckoenig.leichtzumerken@gmail.com, daniel@ffwll.ch, jfalempe@redhat.com, 
	Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	srinivasan.shanmugam@amd.com, sunil.khatri@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 2:10=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote:
>
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.
>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>

Patch looks good to me.  Any chance you want to convert the other
non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
at it?

Alex


> ---
> Changes in v2:
> 1. Drop include "drm_internal.h"
> 2. Add disabling DC tiling ops.
> Per suggestion from previous thread:
> https://patchwork.freedesktop.org/patch/606879/?series=3D136832&rev=3D1
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 05c0df97f01d..ba1b7a36caa3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -28,6 +28,7 @@
>  #include <drm/drm_modeset_helper.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_vblank.h>
> +#include <drm/drm_panic.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_pm.h"
> @@ -2600,6 +2601,52 @@ static const struct drm_crtc_helper_funcs dce_v6_0=
_crtc_helper_funcs =3D {
>         .get_scanout_position =3D amdgpu_crtc_get_scanout_position,
>  };
>
> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plan=
e *plane,
> +                                                        struct drm_scano=
ut_buffer *sb)
> +{
> +       struct drm_framebuffer *fb;
> +       struct amdgpu_bo *abo;
> +       struct amdgpu_crtc *amdgpu_crtc;
> +       struct amdgpu_device *adev;
> +       uint32_t fb_format;
> +
> +       if (!plane->fb)
> +               return -EINVAL;
> +
> +       fb =3D plane->fb;
> +
> +       abo =3D gem_to_amdgpu_bo(fb->obj[0]);
> +       amdgpu_crtc =3D to_amdgpu_crtc(plane->crtc);
> +       adev =3D drm_to_adev(fb->dev);
> +
> +       if (!abo->kmap.virtual &&
> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->k=
map)) {
> +               DRM_WARN("amdgpu bo map failed, panic won't be displayed\=
n");
> +               return -ENOMEM;
> +       }
> +
> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual)=
;
> +       else
> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
> +
> +       sb->width =3D fb->width;
> +       sb->height =3D fb->height;
> +       sb->format =3D fb->format;
> +       sb->pitch[0] =3D fb->pitches[0];
> +
> +       /* Disable DC tiling */
> +       fb_format =3D RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
> +       fb_format &=3D ~GRPH_ARRAY_MODE(0x7);
> +       WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
> +
> +       return 0;
> +}
> +
> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_he=
lper_funcs =3D {
> +       .get_scanout_buffer =3D dce_v6_0_drm_primary_plane_get_scanout_bu=
ffer
> +};
> +
>  static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>  {
>         struct amdgpu_crtc *amdgpu_crtc;
> @@ -2627,6 +2674,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device =
*adev, int index)
>         amdgpu_crtc->encoder =3D NULL;
>         amdgpu_crtc->connector =3D NULL;
>         drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_fun=
cs);
> +       drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_pri=
mary_plane_helper_funcs);
>
>         return 0;
>  }
> --
> 2.25.1
>

