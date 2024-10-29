Return-Path: <linux-kernel+bounces-387112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3E19B4C11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE5FB227BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26365207204;
	Tue, 29 Oct 2024 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqSUx+XW"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9079E206E8D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212104; cv=none; b=fKistsfagIagc9NZuscXw/8Ox/EJqxGBKlj72gZEUwx/ENDl/ULrJFkPr/SFvY7e4nhmyI/VNHF7TJDCfapE5YGISgPHVm17x/Iq15RTqHZuAXIRkDptU+77FJQaJ3GmowVeb2h/B4+3KCTsqWSUzZMxuAubUibED6h3o5ZG11M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212104; c=relaxed/simple;
	bh=R3HggFciVnzg1nms9C0fJofnKZ+TRQbnKSwisKdh2Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9dZkACQE+7vf33bOIJPjbDY/tkUXXpmRL3gXWlw0G7m2maUKt3kswZZKd9iVe3NZvJGstf6SVazn0rubWhKQSpl2gSMhI041vMlr1JFeVKRYTK3TdRPd/xlBm1OemDcBlBruRHp6ry+DTC7BsPmuZKJ6CQTXmMlWe3aDc/FDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqSUx+XW; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea6a4b3807so676771a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730212102; x=1730816902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFVCo6tWC/3dzlDBM+Awij2EzTHybBWBHz3nkZlsvGg=;
        b=kqSUx+XWfrd7ohZa2c5d7oAsY8ZBT0q6+jwtO5Y96JwloL1o//8Z2fJ3gc8vxuG3n0
         GR+uX1wWCe/otaJh8ojHCtFxVkEQBRk7yNFoJdZyLvmEDAqMzIt61DvENhuuvpHyRrXX
         53sfF7DkMcgH7S6DB2aVnmANiq5W9bj+MtfIt4kkKINTfufJZjZGv7Lu/9V8u7QLRr6s
         wuAchVpxR3uqAd+YAADvRwDufXfkwafW3jvD/ZSNd+l+8rsmpH70hFVtbrUZuO0yK9gq
         YPhbZqTY9pk7vJ5yyyuMEtRZ3LAA9DZMDqBJkKAeGI8c5AkVg3g6uVcUF2FISyv1PrvW
         QU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730212102; x=1730816902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFVCo6tWC/3dzlDBM+Awij2EzTHybBWBHz3nkZlsvGg=;
        b=iTbmtf0ggvUGfhTv9TVOHcQkUvQGGDNh0E6oGSx+uF9vueBzE5tsNbvnltsal4R11b
         nByf+Udac3zdvGkUhWMporl8jL9qCIt4GV2EIP4+FeAOYQx4IDr/I7nmFRJZzxJC2rUY
         HKkTjNvSI3BSHDg5+owZXShE+MSaZKW+ji4Py1q6oOaXAQJt0gS1Iv1rpS4f4SmNUPWP
         zgNLmkA9dArPDcurden37K15OBZE0rh3J78p+caXQg+Jkq4s5iN7tSVmZt/Q67fo9pIx
         jXPu9Km5+WcZpJsdt5xMl23N08LQv90TNNBicA3JAhvG6vIx+GwxI7FySH40FPqtHVyO
         QcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ7MTHfalyA3fS0qlW1kL3y39NfXl99zJeBohNbcUmKhk3yrK3vrK+dA55UP+DLDtBAGFFDG4AUTbG5OE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5tipIkuQ6us6k01T4GttRyVpH5dppKiB97L134gUMtEpdAylJ
	duk0qw7NcWeWAHzJllpqoFYYjhrUFbAvNPvSLoNy8IqCkLGO+be1wwp4CAY0gmeb4byJLegoo9b
	gba1nEjoGuPXOHv0ANgfYQYpHvu4=
X-Google-Smtp-Source: AGHT+IEkvqBI3/8hjp2lXdJldAQa5W4d+W9G1Kztg7vJK+yd1OAuMPKaKKLTKVqReRuM6aM7DSmUwP26lIzj8z+eLDI=
X-Received: by 2002:a05:6a21:6d9d:b0:1cf:3a64:cd5c with SMTP id
 adf61e73a8af0-1d9a83aec36mr7473552637.1.1730212101750; Tue, 29 Oct 2024
 07:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802071752.116541-1-yaolu@kylinos.cn> <20240812060914.102614-1-yaolu@kylinos.cn>
In-Reply-To: <20240812060914.102614-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Oct 2024 10:28:10 -0400
Message-ID: <CADnq5_MR1p+Q2cM9wQNQ8xmfDsX=O1sTBUASiBaueFhyfZE6-Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Lu Yao <yaolu@kylinos.cn>
Cc: ckoenig.leichtzumerken@gmail.com, daniel@ffwll.ch, jfalempe@redhat.com, 
	Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	srinivasan.shanmugam@amd.com, sunil.khatri@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks.

Alex

On Mon, Aug 12, 2024 at 2:10=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote:
>
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.
>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
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

