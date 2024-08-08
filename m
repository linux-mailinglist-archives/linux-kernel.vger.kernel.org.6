Return-Path: <linux-kernel+bounces-279879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD994C2F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4E31C20E1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768D190068;
	Thu,  8 Aug 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlaIm0za"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942BB18EFDC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723135432; cv=none; b=tn7KIbpn03qIB1oJfX6J/c7BCbWp0s81lN7EkFBDQlrw6I9tZqkesw3jrS94SdVyYNlDh7Hvvmk5w+9FbxB7Z0xVtFHOtDgrb++kqyNBJ8jo6v3lZaKnNkwQvXYhXkhYMRb2QSKlmNNAgrzqYN9GAv2ffkzmJfZ1d/pVRWWCgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723135432; c=relaxed/simple;
	bh=nMZ7h5kL/cQC3mNo2rYU7viihd77UbK6CxC44okxUU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlxQzK93CKfjgxSOPkFq9uY8KO9UrzZrM9AtJKJwQLw8nJyLiSY7Gsr/mtIEbc9WVVijO49LTCCz56/z5WpdX7n+iUEcEAeifH2yDcrS20ESyV9GMjry6LjwNz3X5yC9/V8nZbAb5LKHzorXmVMLwaCMHQfxg6FGUDd4cCUjm5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlaIm0za; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7106e2d0ec1so1040930b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723135430; x=1723740230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BncAidYttaXwWTJrXVRaT/JdaRkWy8ih2u+dDbnusos=;
        b=OlaIm0zaP1oEYWRzZDI5psH/vIddpkRxiuXsjgtcxU2i2FgwlC9cbMI2tg0JiIWzFC
         /FULkLNc10U3a1jTVQAdzZ6yGtYa8VJ4xNhSjy7SYYORKqlswfTfb4IsbXTvqh9Uka3p
         fsB7p3xhvTx+q3086nB7+G0A3sdmlgQ5cm0PaAaiux/Mb2P3ZGAsgZ1fOsW39m/Sw72F
         oJ95Ov/mXHzyLnQoIWTHhNi0yKig8jcClDosCevQ1HQ9FS6XUApNJOcFSBqde+6O7FX8
         fPoYWVOj3Yh2XSUCKvIIHYkt4mUrdQdNfJcdSmllGI8bZZOgcLUuBSYHzQX4MIv/Bdf2
         u31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723135430; x=1723740230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BncAidYttaXwWTJrXVRaT/JdaRkWy8ih2u+dDbnusos=;
        b=fXc6xs3IsrwNhewQrbkgVe27G3Lvpi56xQb7q1oWCgMrUaWG6UUnnnB9PkgBtIVsPj
         YuNG9h20fLefhZN6YXNaFC6FZnpqDnVGUxNLqZkqHVJ8nnMn9EmwMsT2AP1/ALaBizVi
         6q4vq66eGep8u3maPlfeQ0TB4u4vWFYGwWc2H/I9JZa0GPZ/qtvayfjPXr70x0rviSAG
         UWHsb9IgC0gAcmu4vJeG3lmLbiKskxzSYIu1NKUyH81i9ginWXaCz7LcMt04VnjvWZv8
         azjvGC1iQNSAFeq22tznv8iikOG2B1itZXRm5t7rYqdJQ8PTGdwZit92VZIuxS9mZUUp
         ZvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzmH8J7uQBmjR/DEX7IRSoBZPuvvXBZtzgXnuIK2sUqs0Ww2slFUYou9jvemgloSO97CO3RhrpdHBvCpCPTrh9xnsInudyvKQ0yX3p
X-Gm-Message-State: AOJu0YwEwT/ln3XkxEmiuxaWKvUrmZ9sQpBMYbPPf+NBcMz35CMEX+au
	N+Kw4cDjJEGIDakIN6jVyJUm1enesyLkiSk3XW9E12bfk6BzORG/dFsqHIszz3YSHp6tArHBY+X
	LS+v/woujz+wxzjiw7yRFVH2EsAeKK/CH
X-Google-Smtp-Source: AGHT+IHmwzgpU9ZIK7iJG45Xt+sTotIFrBcVrRJ/Q05dToUmheju3DBdj5rzaGq4Jys4eXNsEjDxlZf5yoTgyq8ffIQ=
X-Received: by 2002:a05:6a20:a11b:b0:1c6:a825:8bc1 with SMTP id
 adf61e73a8af0-1c6fcf623e8mr2951527637.29.1723135429712; Thu, 08 Aug 2024
 09:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802071752.116541-1-yaolu@kylinos.cn> <20240808061538.502762-1-yaolu@kylinos.cn>
In-Reply-To: <20240808061538.502762-1-yaolu@kylinos.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Aug 2024 12:43:37 -0400
Message-ID: <CADnq5_NH9hB4v4iyU8r8WB_bDYJGdoeYK4K8gb8ukP-=votW-A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add dce6 drm_panic support
To: Lu Yao <yaolu@kylinos.cn>
Cc: jfalempe@redhat.com, ckoenig.leichtzumerken@gmail.com, 
	alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, 
	srinivasan.shanmugam@amd.com, sunil.khatri@amd.com, airlied@gmail.com, 
	daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 2:35=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote:
>
> On 2024/8/5 17:25, Jocelyn Falempe wrote:
> >
> >
> > On 02/08/2024 11:39, Christian K=C3=B6nig wrote:
> >> Am 02.08.24 um 09:17 schrieb Lu Yao:
> >>> Add support for the drm_panic module, which displays a pretty user
> >>> friendly message on the screen when a Linux kernel panic occurs.
> >>>
> >>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32
> >>> +++++++++++++++++++++++++++
> >>>   1 file changed, 32 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> >>> index 05c0df97f01d..12c3801c264a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> >>> @@ -28,6 +28,8 @@
> >>>   #include <drm/drm_modeset_helper.h>
> >>>   #include <drm/drm_modeset_helper_vtables.h>
> >>>   #include <drm/drm_vblank.h>
> >>> +#include <drm/drm_panic.h>
> >>
> >>> +#include "../../drm_internal.h"
> >>
> >> Well that this file is named "internal" and not in a common include
> >> directory is a strong indicator that you should absolutely *not*
> >> include it in a driver.
> >>
> >>>   #include "amdgpu.h"
> >>>   #include "amdgpu_pm.h"
> >>> @@ -2600,6 +2602,35 @@ static const struct drm_crtc_helper_funcs
> >>> dce_v6_0_crtc_helper_funcs =3D {
> >>>       .get_scanout_position =3D amdgpu_crtc_get_scanout_position,
> >>>   };
> >>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct
> >>> drm_plane *plane,
> >>> +                             struct drm_scanout_buffer *sb)
> >>> +{
> >>> +    struct drm_framebuffer *fb;
> >>> +    struct drm_gem_object *obj;
> >>> +    struct amdgpu_bo *abo;
> >>> +    int ret =3D 0;
> >>> +
> >>> +    if (!plane->fb || plane->fb->modifier !=3D DRM_FORMAT_MOD_LINEAR=
)
> >>> +        return -ENODEV;
> >>> +
> >>> +    fb =3D plane->fb;
> >>> +    sb->width =3D fb->width;
> >>> +    sb->height =3D fb->height;
> >>> +    sb->format =3D fb->format;
> >>> +    sb->pitch[0] =3D fb->pitches[0];
> >>> +
> >>> +    obj =3D fb->obj[0];
> >>> +    abo =3D gem_to_amdgpu_bo(obj);
> >>> +    if (!abo || abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)
> >>> +        return -EINVAL;
> >>> +
> >>> +    return drm_gem_vmap(obj, &sb->map[0]);
> >>
> >> Yeah that will almost always not work. Most display buffers are
> >> tilled and not CPU accessible.
> >
> > For the CPU accessible issue, Christian mentioned there was a debug
> > interface on AMD GPU that can be used, to work around this:
> >
> > https://lore.kernel.org/dri-devel/0baabe1f-8924-2c9a-5cd4-59084a37dbb2@=
gmail.com/
> > and
> > https://lore.kernel.org/dri-devel/d233c376-ed07-2127-6084-8292d313dac7@=
amd.com/
> >
> > And you will need to use the scanout_buffer->set_pixel() callback to
> > write the pixels one by one, similar to what I've tried for nouveau wit=
h
> > https://patchwork.freedesktop.org/series/133963/
> >
> > For the tiling format, the problem is that it is internal to the GPU,
> > and currently the driver don't know which tiling format is being used.
> >
> > It might be possible to disable tiling and compression, but it
> > requires some internal DC knowledge:
> > https://lore.kernel.org/dri-devel/f76a3297-7d63-8615-45c5-47f02b64a1d5@=
amd.com/
> >
> >
> > Best regards,
>
> From the discussion provided, it is difficult to implement this feature w=
ithout the relevant data book and knowledge.(Whether how tiled memory stora=
ge, or how to disable tiling of DC)

For DCE 6, the GRPH_ARRAY_MODE field in mmGRPH_CONTROL controls the
display tiling.  Set that field to GRPH_ARRAY_LINEAR_GENERAL (0) to
disable tiling.

Alex

