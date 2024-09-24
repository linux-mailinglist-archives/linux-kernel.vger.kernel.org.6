Return-Path: <linux-kernel+bounces-337223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE801984732
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF2A2844BF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D0D1AAE07;
	Tue, 24 Sep 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwNVPUW9"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11E51A7059
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186569; cv=none; b=ojNkBRpjbjilK1fvFIhuNIxhlMa3jHnaPtrzdXzlR3BHQcmRi7UKyS6A9wboy0gNv43GhWLtHMX1bqsgu1fxcBi5PAhClqvX4d9ZjTVy4l+5cZUPRStwmkDAJHaJXPoHjtugXr3WEamRw1/2PXku833DSAxki7t89w1xwMBpVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186569; c=relaxed/simple;
	bh=rdH70v6B7KWuGB/2VcdaJ6DjZfNHSb0eqIxm/7Z4Ha4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gGTbk/VM30v/1OsOGQPBdpxXONnaau/T7XugG6kK93SdOfve8bk+ewCjhWcYL1FaZwz4iaEy5NEmo1Ug+yn9dknbPcXXIXveghC22qXZNqCSTF4yTsvyYujmrk07+MUP5gW0/SGpevZyqD9QntFS9vlcM/Fz6cGfBOTVjIsxU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwNVPUW9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71790698b22so1238469b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186567; x=1727791367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rjn9iKxlm6Sd+6XN6DcxEA/4SLhFIMgFLjUo0PYnDM=;
        b=AwNVPUW9K9O35FpeQjNV+syTPFKVtSQ+/u4kWC2G7afSgGA3HPwTBHdPtGbcII+lKV
         MiaihuBg1JYh7cpmCPB+BcPmgpbMbhR6uu6vsfu2nl7NKw0d1A60YzcL0jsHOphqOPQl
         tw4N+n3Z8cltAb08jgB86k7TaV3mmKUhC3rylw4CtviVt0sBmJL8nYYsjaCovJm5IyBL
         6+0Yv9Zmzn737P5ZbE5rSOobYdXplS0HwE6sYl1OYMG++BhIdH7akDn3Ggk0eycFdSxW
         k+KQTDfV3BA0aX0uY47j6gS/giq08uT/A6DZ48mjntgPSirePgbTgDnedR3rG2w47En6
         zWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186567; x=1727791367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rjn9iKxlm6Sd+6XN6DcxEA/4SLhFIMgFLjUo0PYnDM=;
        b=eGtuKg/JlABxSR2IaSnd2fO+wpw6wGJXp7Hb/Rv4BTkxkuCyb8pX5h8kKQr36/jIqz
         /jo2Bzh/SYV1C/LsNxTRrParNljPEwmaRaUCrlHADJUo25OTEBT2vaZ3xacQj2tBrbBO
         wKMSJY8zBIARHmujuyIQTUJDyCandtjVW2qwdKVudEbv5+kQFCtbx4gF2FAPYHBuL3Pb
         lJ8hXmXVjnxVt4OYchOOYSnbmSGs0lqf/Bcp76JtE0VA1GUjuhY5DTRBYOacQcKs3XeF
         eR+9S5qxcgy72iEUuCUL8WpNI02XXNmnnNAjII0sPk3UuEuVsQ8HQVxFnTt3OOKQmgK6
         p6yg==
X-Forwarded-Encrypted: i=1; AJvYcCUZdLuDQpbfaWuFq82+p4lpIiTcS5MIqujZPz0hlK3uu76RMd3V5VKaTvVfbrpZbwoy270mnavwAqTM4L8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLH9kB3bX4GjxyFaiNBnwq68gY6UPMS2eGito52BXYPOh+Jyh
	RJG7sg89r9658V/hS2wDGSCZMKlGAJYKzM+KfDUEEFRmZFLvxwjfawJkABJowr+37eLd/cbkxDI
	vsBmVwbVVZxnbALmZd0K3N91arLs=
X-Google-Smtp-Source: AGHT+IE1PcaGG5MlOA5G50BEYkhHdz226rGnVOaCdEzWbvwdrUSDzSOAA624Ed9ZJ832fNZwZpAC9edRNln7NeFRyio=
X-Received: by 2002:a05:6a00:21d3:b0:718:e49f:246f with SMTP id
 d2e1a72fcca58-71afb71496amr1767124b3a.7.1727186566728; Tue, 24 Sep 2024
 07:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802071752.116541-1-yaolu@kylinos.cn> <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com> <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
In-Reply-To: <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 10:02:35 -0400
Message-ID: <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Lu Yao <yaolu@kylinos.cn>, ckoenig.leichtzumerken@gmail.com, daniel@ffwll.ch, 
	Xinhui.Pan@amd.com, airlied@gmail.com, alexander.deucher@amd.com, 
	amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	srinivasan.shanmugam@amd.com, sunil.khatri@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 11:36=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.c=
om> wrote:
>
> On 17/09/2024 15:21, Alex Deucher wrote:
> > On Mon, Aug 12, 2024 at 2:10=E2=80=AFAM Lu Yao <yaolu@kylinos.cn> wrote=
:
> >>
> >> Add support for the drm_panic module, which displays a pretty user
> >> friendly message on the screen when a Linux kernel panic occurs.
> >>
> >> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> >
> > Patch looks good to me.  Any chance you want to convert the other
> > non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
> > at it?
>
> I've made a similar patch in amdgpu_dm_plane.c, and it works on a Radeon
> pro w6400.
> But it only works when I'm in a VT terminal (so the framebuffer is
> linear and CPU accessible).
> When under Gnome/Wayland, the flag AMDGPU_GEM_CREATE_NO_CPU_ACCESS is
> set, so that means I can't vmap it ?

It just means that the application does not need CPU access.  Whether
or not the CPU can access the buffer or not depends on the size of the
PCI BAR.  E.g., if the driver or bios has resized the PCI BAR, then
the CPU can access the entire BAR, but if not you are generally
limited to the first 256M of framebuffer.

>
> Also I don't know if there is a similar way to disable
> tiling/compression on this hardware.

UNP_GRPH_CONTROL on chips with DCE display hardware and
DCSURF_ADDR_CONFIG and DCSURF_TILING_CONFIG on DCN display hardware.

Alex

>
> Best regards,
>
> --
>
> Jocelyn
>
>
> >
> > Alex
> >
> >
> >> ---
> >> Changes in v2:
> >> 1. Drop include "drm_internal.h"
> >> 2. Add disabling DC tiling ops.
> >> Per suggestion from previous thread:
> >> https://patchwork.freedesktop.org/patch/606879/?series=3D136832&rev=3D=
1
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++=
++
> >>   1 file changed, 48 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v6_0.c
> >> index 05c0df97f01d..ba1b7a36caa3 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> >> @@ -28,6 +28,7 @@
> >>   #include <drm/drm_modeset_helper.h>
> >>   #include <drm/drm_modeset_helper_vtables.h>
> >>   #include <drm/drm_vblank.h>
> >> +#include <drm/drm_panic.h>
> >>
> >>   #include "amdgpu.h"
> >>   #include "amdgpu_pm.h"
> >> @@ -2600,6 +2601,52 @@ static const struct drm_crtc_helper_funcs dce_v=
6_0_crtc_helper_funcs =3D {
> >>          .get_scanout_position =3D amdgpu_crtc_get_scanout_position,
> >>   };
> >>
> >> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_p=
lane *plane,
> >> +                                                        struct drm_sc=
anout_buffer *sb)
> >> +{
> >> +       struct drm_framebuffer *fb;
> >> +       struct amdgpu_bo *abo;
> >> +       struct amdgpu_crtc *amdgpu_crtc;
> >> +       struct amdgpu_device *adev;
> >> +       uint32_t fb_format;
> >> +
> >> +       if (!plane->fb)
> >> +               return -EINVAL;
> >> +
> >> +       fb =3D plane->fb;
> >> +
> >> +       abo =3D gem_to_amdgpu_bo(fb->obj[0]);
> >> +       amdgpu_crtc =3D to_amdgpu_crtc(plane->crtc);
> >> +       adev =3D drm_to_adev(fb->dev);
> >> +
> >> +       if (!abo->kmap.virtual &&
> >> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo=
->kmap)) {
> >> +               DRM_WARN("amdgpu bo map failed, panic won't be display=
ed\n");
> >> +               return -ENOMEM;
> >> +       }
> >> +
> >> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> >> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtu=
al);
> >> +       else
> >> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
> >> +
> >> +       sb->width =3D fb->width;
> >> +       sb->height =3D fb->height;
> >> +       sb->format =3D fb->format;
> >> +       sb->pitch[0] =3D fb->pitches[0];
> >> +
> >> +       /* Disable DC tiling */
> >> +       fb_format =3D RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset=
);
> >> +       fb_format &=3D ~GRPH_ARRAY_MODE(0x7);
> >> +       WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane=
_helper_funcs =3D {
> >> +       .get_scanout_buffer =3D dce_v6_0_drm_primary_plane_get_scanout=
_buffer
> >> +};
> >> +
> >>   static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
> >>   {
> >>          struct amdgpu_crtc *amdgpu_crtc;
> >> @@ -2627,6 +2674,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_devi=
ce *adev, int index)
> >>          amdgpu_crtc->encoder =3D NULL;
> >>          amdgpu_crtc->connector =3D NULL;
> >>          drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper=
_funcs);
> >> +       drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_=
primary_plane_helper_funcs);
> >>
> >>          return 0;
> >>   }
> >> --
> >> 2.25.1
> >>
> >
>

