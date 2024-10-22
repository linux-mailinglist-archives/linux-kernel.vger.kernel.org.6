Return-Path: <linux-kernel+bounces-376919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0369D9AB77B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCB32878BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375891CBE80;
	Tue, 22 Oct 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOL4qBay"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79261A0BE0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627864; cv=none; b=OKdu1Vd9IV5J0L98GMCndwZ290aVErCcny0RRvm7v3vMwGtthwV0uGEndiDHIGe+XnW3KXsbY30HXuU+06N7yX6v5WftStAtPM+z6M/GrHl1tGtihdWPNrbvT33S0DbaBflJr/3CpiJCDqEpYRopN2/PCMtfA77OG3+UP+41EcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627864; c=relaxed/simple;
	bh=SFcRckadaZDSsWFFo3y+TAIa0rWbTL3k/MQhohDWouc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o27g5QsOYe+pza1MSGXUgLfnQSzNvJosxMVPygYERpqndER3AWOOt+F2swr8AckDt+Sqea3M3Dl+r3uX5md94lnqkHTHPHV1HIdNb2h1EKXEoVQBnRvY4G72dGpwzGInvwSh2L8h63BYipDKugH5vI9udCyg7y5SANnZGQTor3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BOL4qBay; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7eadb7f77e8so348959a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729627862; x=1730232662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAVsxz70ZrQRQFTMQObZNm1iEjHtJKghKIh1nth1f80=;
        b=BOL4qBayrJDiF6IFQ28QcKE8YkGKQdAnfRnLhm1ErjSP4tw+h+xdInUPUoJFyF9Ixi
         8YVfNT6fCjXJKJWyrJDDS55vYR/iG0ykU3G5/wJiFuNTD9y+QdC7OxAo0pOiIk3NB5mr
         qvi+rKDGsD852ZsbHHbd5Lo/IIItHoFYai1+euS/75jIO7yDl/dkA2RqolG1TQUn3T+Q
         G8J1QBjwoegDRV1Bw5U8Ay1YFE03tUjp0UXa6irogTkz+MxHGW5sV0lTAFPjEoIt0tJj
         4J0JKHeq277Qj79FHghCRA9bxiJE2G8yAUdwgoAEuPYdizsYs/umPwcu4N6zujHSTubg
         vYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729627862; x=1730232662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAVsxz70ZrQRQFTMQObZNm1iEjHtJKghKIh1nth1f80=;
        b=Dl+aixlnFso5L4xk5oPQIB29B5hQyzN4rPmdjWCcEBu9YIakwI5AGd4FFVDqdLAui4
         xUvaZCe8fzGCyR857coCyr8301+ATnY9Tvu/P2TGrzpXY+v0/vXoFfWgN0UECz0w1ysX
         kvYc85CCw0uJzpUaQZmO54MdZ13txnmYOwYLs0+toJsOD4FQlQAMjchPTFoc6rBnNSB8
         9VAttwS8gigPfQTSkJ5NLNyFvJUGhDznrjbXcWcJ3LHYLS/I72bL44GXseN0kz1MLGpm
         BX3yVLZJ3DXf/UJKnqXkifVHYyFa49JLHmctvrlr39bexgrKR9a5XOn/gLBOQhbEBXiK
         A71w==
X-Forwarded-Encrypted: i=1; AJvYcCUUnQCPg8fqnciYxoyjbBJ2FRLRcaflgsNPcG9AO0uzc2wsiTIJ2Csmwe4zYgFEzfCzmJSVqF7feaHi4Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfvaNvoWNOlOM89GsRzmtYWbGZvNz390BbM5RzHj3qiZ4s+S9W
	bu59uLzQna9ZgQtCYWOjrDcQBtleEsO3OUp+j3pKufBmoM94tj1mF0p5842tGy+l6XWcdpG3LoS
	ylQ2qUohVTaF6k6kYAztxkQStOcA=
X-Google-Smtp-Source: AGHT+IHdfs+BDRWtsv/ri5QLnC/d0wsmMXXSOOF14kqT4Eo1zOYeaEHOnaT6Cx+lI0wt38KlwKB85T/SDTgHzVq8aOU=
X-Received: by 2002:a05:6a20:4309:b0:1cf:4fc0:4ad8 with SMTP id
 adf61e73a8af0-1d978b14d35mr155724637.6.1729627861806; Tue, 22 Oct 2024
 13:11:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004090850.460668-1-jfalempe@redhat.com>
In-Reply-To: <20241004090850.460668-1-jfalempe@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Oct 2024 16:10:50 -0400
Message-ID: <CADnq5_MKhtZ6cLoNTmt_vBTNw1KrjpkJobkriSUi_wdjCE1++w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add dcn30 drm_panic support
To: Jocelyn Falempe <jfalempe@redhat.com>, "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Melissa Wen <mwen@igalia.com>, 
	Joshua Ashton <joshua@froggi.es>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>, 
	Hersen Wu <hersenxs.wu@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
	Roman Li <roman.li@amd.com>, 
	Bhuvana Chandra Pinninti <bhuvanachandra.pinninti@amd.com>, Alvin Lee <alvin.lee2@amd.com>, 
	Sung Joon Kim <sungkim@amd.com>, Duncan Ma <duncan.ma@amd.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Lu Yao <yaolu@kylinos.cn>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 5:09=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.com=
> wrote:
>
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.
>
> It should work on all readeon using amdgpu_dm_plane.c, when the

radeon

> framebuffer is linear (like when in a VT). For tiled framebuffer, it
> will only work on radeon with dcn30. It should be easy to add support
> for dcn20 or dcn31, but I can't test it.
> I've tested it on a Radeon W6400 pro.

Looks good to me.  @Wentland, Harry, @Siqueira, Rodrigo, etc, does
this look ok to you guys?  If so, can you pick it up and look at
adding the callbacks for other DCN versions?

Thanks,

Alex

>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 137 +++++++++++++++++-
>  .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
>  .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
>  drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
>  4 files changed, 155 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 25f63b2e7a8e2..a62b197ab6833 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -26,7 +26,9 @@
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_blend.h>
> +#include "drm/drm_framebuffer.h"
>  #include <drm/drm_gem_atomic_helper.h>
> +#include <drm/drm_panic.h>
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_fourcc.h>
> @@ -36,6 +38,7 @@
>  #include "amdgpu_display.h"
>  #include "amdgpu_dm_trace.h"
>  #include "amdgpu_dm_plane.h"
> +#include "bif/bif_4_1_d.h"
>  #include "gc/gc_11_0_0_offset.h"
>  #include "gc/gc_11_0_0_sh_mask.h"
>
> @@ -1420,6 +1423,125 @@ static void amdgpu_dm_plane_atomic_async_update(s=
truct drm_plane *plane,
>         amdgpu_dm_plane_handle_cursor_update(plane, old_state);
>  }
>
> +/* panic_bo is set in amdgpu_dm_plane_get_scanout_buffer() and only used=
 in amdgpu_dm_set_pixel()
> + * they are called from the panic handler, and no race condition can occ=
urs.
> + */
> +static struct amdgpu_bo *panic_abo;
> +
> +/* Use the indirect MMIO to write each pixel to the GPU VRAM,
> + * This is a simplified version of amdgpu_device_mm_access()
> + */
> +static void amdgpu_dm_set_pixel(struct drm_scanout_buffer *sb,
> +                               unsigned int x,
> +                               unsigned int y,
> +                               u32 color)
> +{
> +       struct amdgpu_res_cursor cursor;
> +       unsigned long offset;
> +       struct amdgpu_bo *abo =3D panic_abo;
> +       struct amdgpu_device *adev =3D amdgpu_ttm_adev(abo->tbo.bdev);
> +       uint32_t tmp;
> +
> +       offset =3D x * 4 + y * sb->pitch[0];
> +       amdgpu_res_first(abo->tbo.resource, offset, 4, &cursor);
> +
> +       tmp =3D cursor.start >> 31;
> +       WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t) cursor.start) | 0x80000000)=
;
> +       if (tmp !=3D 0xffffffff)
> +               WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> +       WREG32_NO_KIQ(mmMM_DATA, color);
> +}
> +
> +static int amdgpu_dm_plane_disable_tiling(struct dc_plane_state *dc_plan=
e_state)
> +{
> +       struct dc_state *dc_state;
> +       int i;
> +
> +       if (!dc_plane_state)
> +               return -EINVAL;
> +
> +       dc_state =3D dc_plane_state->ctx->dc->current_state;
> +       if (!dc_state)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < dc_plane_state->ctx->dc->res_pool->pipe_count; =
i++) {
> +               struct pipe_ctx *pipe_ctx =3D &dc_state->res_ctx.pipe_ctx=
[i];
> +               struct hubp *hubp;
> +
> +               if (!pipe_ctx)
> +                       continue;
> +
> +               hubp =3D pipe_ctx->plane_res.hubp;
> +               if (!hubp)
> +                       continue;
> +
> +               if (!hubp->funcs->hubp_clear_tiling)
> +                       return -EINVAL;
> +
> +               hubp->funcs->hubp_clear_tiling(hubp);
> +               hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
> +                                                               &dc_plane=
_state->address,
> +                                                               dc_plane_=
state->flip_immediate);
> +       }
> +       return 0;
> +}
> +
> +static int amdgpu_dm_plane_get_scanout_buffer(struct drm_plane *plane,
> +                                             struct drm_scanout_buffer *=
sb)
> +{
> +       struct dm_plane_state *dm_plane_state =3D to_dm_plane_state(plane=
->state);
> +       struct amdgpu_bo *abo;
> +       struct drm_framebuffer *fb =3D plane->state->fb;
> +
> +       if (!fb)
> +               return -EINVAL;
> +
> +       DRM_DEBUG_KMS("Framebuffer %dx%d %p4cc\n", fb->width, fb->height,=
 &fb->format->format);
> +
> +       abo =3D gem_to_amdgpu_bo(fb->obj[0]);
> +       if (!abo)
> +               return -EINVAL;
> +
> +       /* disable tiling */
> +       if (fb->modifier && amdgpu_dm_plane_disable_tiling(dm_plane_state=
->dc_state))
> +               return -EINVAL;
> +
> +       sb->width =3D fb->width;
> +       sb->height =3D fb->height;
> +       /* Use the generic linear format, because we just disabled tiling=
 */
> +       sb->format =3D drm_format_info(fb->format->format);
> +       if (!sb->format)
> +               return -EINVAL;
> +
> +       sb->pitch[0] =3D fb->pitches[0];
> +
> +       if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
> +               if (abo->tbo.resource->mem_type !=3D TTM_PL_VRAM) {
> +                       DRM_WARN("amdgpu panic, framebuffer not in VRAM\n=
");
> +                       return -EINVAL;
> +               }
> +               /* Only handle 32bits format, to simplify mmio access */
> +               if (fb->format->cpp[0] !=3D 4) {
> +                       DRM_WARN("amdgpu panic, pixel format is not 32bit=
s\n");
> +                       return -EINVAL;
> +               }
> +               sb->set_pixel =3D amdgpu_dm_set_pixel;
> +               panic_abo =3D abo;
> +               return 0;
> +       }
> +       if (!abo->kmap.virtual &&
> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->k=
map)) {
> +               DRM_WARN("amdgpu bo map failed, panic won't be displayed\=
n");
> +               return -ENOMEM;
> +       }
> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual)=
;
> +       else
> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
> +
> +       return 0;
> +}
> +
>  static const struct drm_plane_helper_funcs dm_plane_helper_funcs =3D {
>         .prepare_fb =3D amdgpu_dm_plane_helper_prepare_fb,
>         .cleanup_fb =3D amdgpu_dm_plane_helper_cleanup_fb,
> @@ -1428,6 +1550,15 @@ static const struct drm_plane_helper_funcs dm_plan=
e_helper_funcs =3D {
>         .atomic_async_update =3D amdgpu_dm_plane_atomic_async_update
>  };
>
> +static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs=
 =3D {
> +       .prepare_fb =3D amdgpu_dm_plane_helper_prepare_fb,
> +       .cleanup_fb =3D amdgpu_dm_plane_helper_cleanup_fb,
> +       .atomic_check =3D amdgpu_dm_plane_atomic_check,
> +       .atomic_async_check =3D amdgpu_dm_plane_atomic_async_check,
> +       .atomic_async_update =3D amdgpu_dm_plane_atomic_async_update,
> +       .get_scanout_buffer =3D amdgpu_dm_plane_get_scanout_buffer,
> +};
> +
>  static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
>  {
>         struct dm_plane_state *amdgpu_state =3D NULL;
> @@ -1854,7 +1985,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_man=
ager *dm,
>             plane->type !=3D DRM_PLANE_TYPE_CURSOR)
>                 drm_plane_enable_fb_damage_clips(plane);
>
> -       drm_plane_helper_add(plane, &dm_plane_helper_funcs);
> +       if (plane->type =3D=3D DRM_PLANE_TYPE_PRIMARY)
> +               drm_plane_helper_add(plane, &dm_primary_plane_helper_func=
s);
> +       else
> +               drm_plane_helper_add(plane, &dm_plane_helper_funcs);
>
>  #ifdef AMD_PRIVATE_COLOR
>         dm_atomic_plane_attach_color_mgmt_properties(dm, plane);
> @@ -1876,4 +2010,3 @@ bool amdgpu_dm_plane_is_video_format(uint32_t forma=
t)
>
>         return false;
>  }
> -
> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/dri=
vers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
> index 60a64d2903527..3b16c3cda2c3e 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
> @@ -334,6 +334,22 @@ void hubp3_program_tiling(
>
>  }
>
> +void hubp3_clear_tiling(struct hubp *hubp)
> +{
> +       struct dcn20_hubp *hubp2 =3D TO_DCN20_HUBP(hubp);
> +
> +       REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
> +       REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
> +
> +       REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
> +               PRIMARY_SURFACE_DCC_EN, 0,
> +               PRIMARY_SURFACE_DCC_IND_BLK, 0,
> +               PRIMARY_SURFACE_DCC_IND_BLK_C, 0,
> +               SECONDARY_SURFACE_DCC_EN, 0,
> +               SECONDARY_SURFACE_DCC_IND_BLK, 0,
> +               SECONDARY_SURFACE_DCC_IND_BLK_C, 0);
> +}
> +
>  void hubp3_dcc_control(struct hubp *hubp, bool enable,
>                 enum hubp_ind_block_size blk_size)
>  {
> @@ -512,6 +528,7 @@ static struct hubp_funcs dcn30_hubp_funcs =3D {
>         .hubp_in_blank =3D hubp1_in_blank,
>         .hubp_soft_reset =3D hubp1_soft_reset,
>         .hubp_set_flip_int =3D hubp1_set_flip_int,
> +       .hubp_clear_tiling =3D hubp3_clear_tiling,
>  };
>
>  bool hubp3_construct(
> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/dri=
vers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
> index b010531a7fe88..cfb01bf340a1a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
> @@ -297,6 +297,8 @@ void hubp3_read_state(struct hubp *hubp);
>
>  void hubp3_init(struct hubp *hubp);
>
> +void hubp3_clear_tiling(struct hubp *hubp);
> +
>  #endif /* __DC_HUBP_DCN30_H__ */
>
>
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/d=
rm/amd/display/dc/inc/hw/hubp.h
> index 16580d6242789..d0878fc0cc948 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
> @@ -275,6 +275,7 @@ struct hubp_funcs {
>                         enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_c=
b_b,
>                         enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_c=
r_r);
>         int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
> +       void (*hubp_clear_tiling)(struct hubp *hubp);
>  };
>
>  #endif
>
> base-commit: a5c2320151ff7cdf9ec50630d638a417ff927e31
> --
> 2.46.1
>

