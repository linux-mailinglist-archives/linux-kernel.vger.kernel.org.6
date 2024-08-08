Return-Path: <linux-kernel+bounces-279943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B094C3A9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F62B25359
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4612B1917C7;
	Thu,  8 Aug 2024 17:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EE4psJXK"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F8190041
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137911; cv=none; b=qi2uybngSMEO9KWQUtZKtj4dXenioCxFrnX48gTEu5FbpU6l8gsD10Zel2aYX94rc9IIOXJL16DDnX3RsJbAhXfAgj4i9MlenXvyYOx2Ca47AKaxmVWpcKpwMtANwoUxKOG1539KIouLy+6v1C0UFSWt8BaZEayx2VX7wHQiTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137911; c=relaxed/simple;
	bh=LU2HCRxfulJFKotLuKd3nw6dTEyquXzploxE0EWamA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rOUJ2kkN5dH8221akwMI+zL3I9loS5f1WWevOLFiMhtIh4rBW7f033B/vFImFaSUYcEgUJ9eWLqcmwb8GPECLAYp4CKl150gj65DklDp6m4qMtdPFyxyarVWOoG4A3Fn+GPg81Ge0+4GjcqajAFMDcLmyovH2fxu38ZN24NynMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EE4psJXK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-710d1de6ee5so433825b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723137909; x=1723742709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3iZ7fcb1MmjyjW9t+2rUZPHz66g5ifDib2eiW/PAao=;
        b=EE4psJXKKA6S+udSkox1SRdqgC9IlLgkDI7HiWEuruxz88XeHZTfWZSwhE9oPH3qbu
         APo9Pb8r1+HGGInNSj0Ii3INR8yS86J556lNM52z2e5qlEmTJtFvk4P30f3F5R+oVGRv
         j8Gadv/ZgDwFQEjG44BNGb+JcNZ+4yKwxrHIUlhwPha7l4BJrnf7mzgR18igYlBUQ1IP
         O54u81n2KtbJ0NIsIWgdzgnDZUFzy8Y88VEHC4r42ow9wVn80qppm6lux0DWPLPC5b9r
         WamaryG0+ctJ4F3029ZEuMdPJRuRm9kdd6ulWZwSw9cScANwt85f+dwOKvR1IByV6IVF
         Qzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137909; x=1723742709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3iZ7fcb1MmjyjW9t+2rUZPHz66g5ifDib2eiW/PAao=;
        b=rfV2OspIZ2D+CY4D1xAk5s79k3sNHu2yNzQ5+HLgNLuk8QTJsJNvpmcsG/H3aBMnA4
         rlm6gdwwby3AQbJY1QVbiLqhbBo15GhreE6GojxXIkZX1dUwOl9XBM6UXJRCGBXT6NfM
         FattmCTJ/z8yEkoxf8sXLN9DvXkIIZ26PzssigLbWXrTcXH7gKrPARLRzL3LbHIrvMtH
         YJUhGAW03QJuZtepWPnS8DQlHN04HVLzyKqudSS6eSdPb6uXBam2Wz8onZne/GnMgk2f
         /E8vvADYqR4ki00GiIVNF1IlDxgTdRdSVzWdTTS96huJKGQdB/UEB7eaTzpV4/0Vgu5I
         3+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVwdgmiHVk4IUXLEGuYdIjCEQ1TM5OQFOy8r32wnfgHlLQwnnmeWaoLAlvWibCcxYgprumCjwb67IevmEIxLiM9j8GfCMd4+EUGlJ9u
X-Gm-Message-State: AOJu0Yx8CDIGdOYfLRy/NeAfZE9YGrVWsGEXgUgcO5+sN723eSgtBuZr
	RkJHfJcHRiRQUWvzJCKnhPTsO4Oby86o1+TVNp0v0kNH1sf5oMzMtxdfSXcofeuSaeUKAmrS3dV
	GLHiH05G0hcinw5YAgmIZTlcTgSWWA13A
X-Google-Smtp-Source: AGHT+IFK10v9qSl1uG5G5L2+ylqJz2dYSvp5UB5lkFU4pz5Lh0Xi9t+TEluxdykFf+f8QXkF5YuF/Eful1fKeNGkda0=
X-Received: by 2002:a05:6a20:2450:b0:1c3:a760:9757 with SMTP id
 adf61e73a8af0-1c6fcfb1aa2mr3203319637.49.1723137909222; Thu, 08 Aug 2024
 10:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802071752.116541-1-yaolu@kylinos.cn> <20240808061538.502762-1-yaolu@kylinos.cn>
 <CADnq5_NH9hB4v4iyU8r8WB_bDYJGdoeYK4K8gb8ukP-=votW-A@mail.gmail.com>
In-Reply-To: <CADnq5_NH9hB4v4iyU8r8WB_bDYJGdoeYK4K8gb8ukP-=votW-A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Aug 2024 13:24:57 -0400
Message-ID: <CADnq5_PDBZ9APfCpSMOSMPQWzcOeLqw_LngE2BBSOxv__7miGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add dce6 drm_panic support
To: Lu Yao <yaolu@kylinos.cn>
Cc: jfalempe@redhat.com, ckoenig.leichtzumerken@gmail.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	srinivasan.shanmugam@amd.com, sunil.khatri@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 12:43=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Thu, Aug 8, 2024 at 2:35=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote:
> >
> > On 2024/8/5 17:25, Jocelyn Falempe wrote:
> > >
> > >
> > > On 02/08/2024 11:39, Christian K=C3=B6nig wrote:
> > >> Am 02.08.24 um 09:17 schrieb Lu Yao:
> > >>> Add support for the drm_panic module, which displays a pretty user
> > >>> friendly message on the screen when a Linux kernel panic occurs.
> > >>>
> > >>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> > >>> ---
> > >>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32
> > >>> +++++++++++++++++++++++++++
> > >>>   1 file changed, 32 insertions(+)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > >>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > >>> index 05c0df97f01d..12c3801c264a 100644
> > >>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > >>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > >>> @@ -28,6 +28,8 @@
> > >>>   #include <drm/drm_modeset_helper.h>
> > >>>   #include <drm/drm_modeset_helper_vtables.h>
> > >>>   #include <drm/drm_vblank.h>
> > >>> +#include <drm/drm_panic.h>
> > >>
> > >>> +#include "../../drm_internal.h"
> > >>
> > >> Well that this file is named "internal" and not in a common include
> > >> directory is a strong indicator that you should absolutely *not*
> > >> include it in a driver.
> > >>
> > >>>   #include "amdgpu.h"
> > >>>   #include "amdgpu_pm.h"
> > >>> @@ -2600,6 +2602,35 @@ static const struct drm_crtc_helper_funcs
> > >>> dce_v6_0_crtc_helper_funcs =3D {
> > >>>       .get_scanout_position =3D amdgpu_crtc_get_scanout_position,
> > >>>   };
> > >>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct
> > >>> drm_plane *plane,
> > >>> +                             struct drm_scanout_buffer *sb)
> > >>> +{
> > >>> +    struct drm_framebuffer *fb;
> > >>> +    struct drm_gem_object *obj;
> > >>> +    struct amdgpu_bo *abo;
> > >>> +    int ret =3D 0;
> > >>> +
> > >>> +    if (!plane->fb || plane->fb->modifier !=3D DRM_FORMAT_MOD_LINE=
AR)
> > >>> +        return -ENODEV;
> > >>> +
> > >>> +    fb =3D plane->fb;
> > >>> +    sb->width =3D fb->width;
> > >>> +    sb->height =3D fb->height;
> > >>> +    sb->format =3D fb->format;
> > >>> +    sb->pitch[0] =3D fb->pitches[0];
> > >>> +
> > >>> +    obj =3D fb->obj[0];
> > >>> +    abo =3D gem_to_amdgpu_bo(obj);
> > >>> +    if (!abo || abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)
> > >>> +        return -EINVAL;
> > >>> +
> > >>> +    return drm_gem_vmap(obj, &sb->map[0]);
> > >>
> > >> Yeah that will almost always not work. Most display buffers are
> > >> tilled and not CPU accessible.
> > >
> > > For the CPU accessible issue, Christian mentioned there was a debug
> > > interface on AMD GPU that can be used, to work around this:
> > >
> > > https://lore.kernel.org/dri-devel/0baabe1f-8924-2c9a-5cd4-59084a37dbb=
2@gmail.com/
> > > and
> > > https://lore.kernel.org/dri-devel/d233c376-ed07-2127-6084-8292d313dac=
7@amd.com/
> > >
> > > And you will need to use the scanout_buffer->set_pixel() callback to
> > > write the pixels one by one, similar to what I've tried for nouveau w=
ith
> > > https://patchwork.freedesktop.org/series/133963/
> > >
> > > For the tiling format, the problem is that it is internal to the GPU,
> > > and currently the driver don't know which tiling format is being used=
.
> > >
> > > It might be possible to disable tiling and compression, but it
> > > requires some internal DC knowledge:
> > > https://lore.kernel.org/dri-devel/f76a3297-7d63-8615-45c5-47f02b64a1d=
5@amd.com/
> > >
> > >
> > > Best regards,
> >
> > From the discussion provided, it is difficult to implement this feature=
 without the relevant data book and knowledge.(Whether how tiled memory sto=
rage, or how to disable tiling of DC)
>
> For DCE 6, the GRPH_ARRAY_MODE field in mmGRPH_CONTROL controls the
> display tiling.  Set that field to GRPH_ARRAY_LINEAR_GENERAL (0) to
> disable tiling.

For clarity that register is instanced so use mmGRPH_CONTROL +
amdgpu_crtc->crtc_offset to get the right instance.

Alex

>
> Alex

