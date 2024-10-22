Return-Path: <linux-kernel+bounces-377104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A39B9AB9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA783284651
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1CE1CEE9B;
	Tue, 22 Oct 2024 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8jEy0aJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752214B97E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638631; cv=none; b=LfvdBnu7TTlKV7OzTM/Vtdsc+Kx9Ub+2F36nuzIaZceKZjc/mUcBj7uF9z0Pl/NCO9INsvxTJDOmOA7FdAopluO9uvGcnyxKqgFJ6S3dXZ4ZSicGUDrod6bnUzi2zvHm7ttaZJAMxIBEJocUzrmiGf9TTiRJYHCWxwjSrx/zbNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638631; c=relaxed/simple;
	bh=FO2iyhRoWiS5FiEaYWNNj8vCjAsHnlO2MYIw1cQe6zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZlO/NPmojo3a1fdiRKNC3wDyCTPHWAQlz98v/HX600ZLDLtkuG8Csbpe5Btk/XQzb6j2iEGb2gJKZdVyBHe9Ysv3i1+Hggvsr7L0QCZCrAejEJJu9jXAAb0SuJTuunuWi5QINCJ6P4LqYDXoK6Nnu29NIcKVZ2mn1oRZJk6qpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8jEy0aJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729638628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6kMnkm0DXaeDv9LWmSm2TIQ2bggTG+h0gDH5aYSnYo=;
	b=C8jEy0aJR2Kp9pKtjGl1QCXMz3YoHmENJuEWCETsdVn3CJ4FxISWMAFgYeOnaSKBDjGZf+
	2rUAQ8VKnRCAv8AfSeuRl0610a9itkNTAenTIpjBHKcYA9IzQuw4JLf3PfLhaHqN+fg450
	gVt88UB0kHnaH4x6HUdYC+ZFRXprd0I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-5PWJh8kjP2aLtfTaz88XSg-1; Tue, 22 Oct 2024 19:10:27 -0400
X-MC-Unique: 5PWJh8kjP2aLtfTaz88XSg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d67f4bf98so3581073f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729638626; x=1730243426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6kMnkm0DXaeDv9LWmSm2TIQ2bggTG+h0gDH5aYSnYo=;
        b=L6eSUYvEqPNfkv8gVhbVRXGm9KRY9sisYtIeC3T9GrGpD7MLgMov4HTK4oD45TRZNw
         8sgXfKBLwfrMEtlQoUEIJgXRdZd5kQMrLRdYycRSMIbiKWytcIKSw2sDj86Cf731GYzE
         j+sMtNL0/GAVk1eM20YvVXm/hV5wbqn+Mc0g+IJ9BAxk6UDRdkz06+/Wosh52LbqLE1U
         zxuIzeDr1sFpBvEyqoQ3ZgIK/sqMNKm72zP/7Kfv+lPVaVACrA6lartePtVtC9//nldW
         f7O4UFdBmUFlcJsMN0RT6IiDzAGO9fRCIDFBNIhuog3/hgzkVgqC/fRqZSlYdUFcfSAt
         H0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/pAm4Wl28YlcCkYljla6OjWmAQBKJGyQkeDoUxhJBc2qFYtlNvmuHS+SFG2q3X6A2UMHO8ibx0yexR8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/UashbjqYs8ZeBZqfF7g2DV2ln6ghyS2Erf8EhLpT+uODzDCs
	lEA5CT2jaxXGMm8JkGckZHRjtta6DmM7s3Wm0lHDnRcNz0qaPrcshZEVzZLufDW6a8E8U0etwri
	98B9ShvuXIi5r9mUo+0Dpz5mreBsCChJLF+8lUr2m9PZrmpGolXxIhPpnvxsuOQ==
X-Received: by 2002:a5d:61d2:0:b0:374:c3e4:d6de with SMTP id ffacd0b85a97d-37efcf7ecbamr290757f8f.41.1729638625811;
        Tue, 22 Oct 2024 16:10:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2IspmdpuL6izzK5vZSRb2wfOr/Yp4Y9d+rQdEshWOWUcDHCMCPXf5RpkCUztIWrHTkfiSJA==
X-Received: by 2002:a5d:61d2:0:b0:374:c3e4:d6de with SMTP id ffacd0b85a97d-37efcf7ecbamr290736f8f.41.1729638625332;
        Tue, 22 Oct 2024 16:10:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b8b9sm7568258f8f.92.2024.10.22.16.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 16:10:24 -0700 (PDT)
Message-ID: <1ac31a51-54e8-49d4-9aac-5e22360d63b8@redhat.com>
Date: Wed, 23 Oct 2024 01:09:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Add dcn30 drm_panic support
To: Alex Deucher <alexdeucher@gmail.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Melissa Wen <mwen@igalia.com>,
 Joshua Ashton <joshua@froggi.es>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Bhuvana Chandra Pinninti <bhuvanachandra.pinninti@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, Sung Joon Kim <sungkim@amd.com>,
 Duncan Ma <duncan.ma@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Lu Yao <yaolu@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
References: <20241004090850.460668-1-jfalempe@redhat.com>
 <CADnq5_MKhtZ6cLoNTmt_vBTNw1KrjpkJobkriSUi_wdjCE1++w@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CADnq5_MKhtZ6cLoNTmt_vBTNw1KrjpkJobkriSUi_wdjCE1++w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2024 22:10, Alex Deucher wrote:
> On Fri, Oct 4, 2024 at 5:09 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> Add support for the drm_panic module, which displays a pretty user
>> friendly message on the screen when a Linux kernel panic occurs.
>>
>> It should work on all readeon using amdgpu_dm_plane.c, when the
> 
> radeon
> 
>> framebuffer is linear (like when in a VT). For tiled framebuffer, it
>> will only work on radeon with dcn30. It should be easy to add support
>> for dcn20 or dcn31, but I can't test it.
>> I've tested it on a Radeon W6400 pro.
> 
> Looks good to me.  @Wentland, Harry, @Siqueira, Rodrigo, etc, does
> this look ok to you guys?  If so, can you pick it up and look at
> adding the callbacks for other DCN versions?

I've sent a v2 of this patch, and I'm preparing a v3, which adds dcn31, 
dnc32 and dnc35 support. I've tested it successfully on a 7900XTX and 
radeon RX 5700.
One thing that doesn't work yet, is on a laptop's panel.
Thomas Weißschuh tested it on a laptop with an integrated radeon 780M, 
and the screen is not updated.
It has something to do with PSR, but I didn't find a way to workaround this.
So basically calling hubp_program_surface_flip_and_addr() is not enough 
to get the new framebuffer content to the internal panel, but it works 
on an external display on his laptop.
I tried to call dc_set_psr_allow_active(dc, false), but it has no effect.

Anyway I will send the v3 tomorrow.

Best regards,

-- 

Jocelyn

> 
> Thanks,
> 
> Alex
> 
>>
>> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
>> ---
>>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 137 +++++++++++++++++-
>>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 +++
>>   .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
>>   drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
>>   4 files changed, 155 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> index 25f63b2e7a8e2..a62b197ab6833 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>> @@ -26,7 +26,9 @@
>>
>>   #include <drm/drm_atomic_helper.h>
>>   #include <drm/drm_blend.h>
>> +#include "drm/drm_framebuffer.h"
>>   #include <drm/drm_gem_atomic_helper.h>
>> +#include <drm/drm_panic.h>
>>   #include <drm/drm_plane_helper.h>
>>   #include <drm/drm_gem_framebuffer_helper.h>
>>   #include <drm/drm_fourcc.h>
>> @@ -36,6 +38,7 @@
>>   #include "amdgpu_display.h"
>>   #include "amdgpu_dm_trace.h"
>>   #include "amdgpu_dm_plane.h"
>> +#include "bif/bif_4_1_d.h"
>>   #include "gc/gc_11_0_0_offset.h"
>>   #include "gc/gc_11_0_0_sh_mask.h"
>>
>> @@ -1420,6 +1423,125 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
>>          amdgpu_dm_plane_handle_cursor_update(plane, old_state);
>>   }
>>
>> +/* panic_bo is set in amdgpu_dm_plane_get_scanout_buffer() and only used in amdgpu_dm_set_pixel()
>> + * they are called from the panic handler, and no race condition can occurs.
>> + */
>> +static struct amdgpu_bo *panic_abo;
>> +
>> +/* Use the indirect MMIO to write each pixel to the GPU VRAM,
>> + * This is a simplified version of amdgpu_device_mm_access()
>> + */
>> +static void amdgpu_dm_set_pixel(struct drm_scanout_buffer *sb,
>> +                               unsigned int x,
>> +                               unsigned int y,
>> +                               u32 color)
>> +{
>> +       struct amdgpu_res_cursor cursor;
>> +       unsigned long offset;
>> +       struct amdgpu_bo *abo = panic_abo;
>> +       struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
>> +       uint32_t tmp;
>> +
>> +       offset = x * 4 + y * sb->pitch[0];
>> +       amdgpu_res_first(abo->tbo.resource, offset, 4, &cursor);
>> +
>> +       tmp = cursor.start >> 31;
>> +       WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t) cursor.start) | 0x80000000);
>> +       if (tmp != 0xffffffff)
>> +               WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
>> +       WREG32_NO_KIQ(mmMM_DATA, color);
>> +}
>> +
>> +static int amdgpu_dm_plane_disable_tiling(struct dc_plane_state *dc_plane_state)
>> +{
>> +       struct dc_state *dc_state;
>> +       int i;
>> +
>> +       if (!dc_plane_state)
>> +               return -EINVAL;
>> +
>> +       dc_state = dc_plane_state->ctx->dc->current_state;
>> +       if (!dc_state)
>> +               return -EINVAL;
>> +
>> +       for (i = 0; i < dc_plane_state->ctx->dc->res_pool->pipe_count; i++) {
>> +               struct pipe_ctx *pipe_ctx = &dc_state->res_ctx.pipe_ctx[i];
>> +               struct hubp *hubp;
>> +
>> +               if (!pipe_ctx)
>> +                       continue;
>> +
>> +               hubp = pipe_ctx->plane_res.hubp;
>> +               if (!hubp)
>> +                       continue;
>> +
>> +               if (!hubp->funcs->hubp_clear_tiling)
>> +                       return -EINVAL;
>> +
>> +               hubp->funcs->hubp_clear_tiling(hubp);
>> +               hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
>> +                                                               &dc_plane_state->address,
>> +                                                               dc_plane_state->flip_immediate);
>> +       }
>> +       return 0;
>> +}
>> +
>> +static int amdgpu_dm_plane_get_scanout_buffer(struct drm_plane *plane,
>> +                                             struct drm_scanout_buffer *sb)
>> +{
>> +       struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane->state);
>> +       struct amdgpu_bo *abo;
>> +       struct drm_framebuffer *fb = plane->state->fb;
>> +
>> +       if (!fb)
>> +               return -EINVAL;
>> +
>> +       DRM_DEBUG_KMS("Framebuffer %dx%d %p4cc\n", fb->width, fb->height, &fb->format->format);
>> +
>> +       abo = gem_to_amdgpu_bo(fb->obj[0]);
>> +       if (!abo)
>> +               return -EINVAL;
>> +
>> +       /* disable tiling */
>> +       if (fb->modifier && amdgpu_dm_plane_disable_tiling(dm_plane_state->dc_state))
>> +               return -EINVAL;
>> +
>> +       sb->width = fb->width;
>> +       sb->height = fb->height;
>> +       /* Use the generic linear format, because we just disabled tiling */
>> +       sb->format = drm_format_info(fb->format->format);
>> +       if (!sb->format)
>> +               return -EINVAL;
>> +
>> +       sb->pitch[0] = fb->pitches[0];
>> +
>> +       if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
>> +               if (abo->tbo.resource->mem_type != TTM_PL_VRAM) {
>> +                       DRM_WARN("amdgpu panic, framebuffer not in VRAM\n");
>> +                       return -EINVAL;
>> +               }
>> +               /* Only handle 32bits format, to simplify mmio access */
>> +               if (fb->format->cpp[0] != 4) {
>> +                       DRM_WARN("amdgpu panic, pixel format is not 32bits\n");
>> +                       return -EINVAL;
>> +               }
>> +               sb->set_pixel = amdgpu_dm_set_pixel;
>> +               panic_abo = abo;
>> +               return 0;
>> +       }
>> +       if (!abo->kmap.virtual &&
>> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
>> +               DRM_WARN("amdgpu bo map failed, panic won't be displayed\n");
>> +               return -ENOMEM;
>> +       }
>> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
>> +       else
>> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
>> +
>> +       return 0;
>> +}
>> +
>>   static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
>>          .prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
>>          .cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
>> @@ -1428,6 +1550,15 @@ static const struct drm_plane_helper_funcs dm_plane_helper_funcs = {
>>          .atomic_async_update = amdgpu_dm_plane_atomic_async_update
>>   };
>>
>> +static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
>> +       .prepare_fb = amdgpu_dm_plane_helper_prepare_fb,
>> +       .cleanup_fb = amdgpu_dm_plane_helper_cleanup_fb,
>> +       .atomic_check = amdgpu_dm_plane_atomic_check,
>> +       .atomic_async_check = amdgpu_dm_plane_atomic_async_check,
>> +       .atomic_async_update = amdgpu_dm_plane_atomic_async_update,
>> +       .get_scanout_buffer = amdgpu_dm_plane_get_scanout_buffer,
>> +};
>> +
>>   static void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
>>   {
>>          struct dm_plane_state *amdgpu_state = NULL;
>> @@ -1854,7 +1985,10 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>              plane->type != DRM_PLANE_TYPE_CURSOR)
>>                  drm_plane_enable_fb_damage_clips(plane);
>>
>> -       drm_plane_helper_add(plane, &dm_plane_helper_funcs);
>> +       if (plane->type == DRM_PLANE_TYPE_PRIMARY)
>> +               drm_plane_helper_add(plane, &dm_primary_plane_helper_funcs);
>> +       else
>> +               drm_plane_helper_add(plane, &dm_plane_helper_funcs);
>>
>>   #ifdef AMD_PRIVATE_COLOR
>>          dm_atomic_plane_attach_color_mgmt_properties(dm, plane);
>> @@ -1876,4 +2010,3 @@ bool amdgpu_dm_plane_is_video_format(uint32_t format)
>>
>>          return false;
>>   }
>> -
>> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
>> index 60a64d2903527..3b16c3cda2c3e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
>> @@ -334,6 +334,22 @@ void hubp3_program_tiling(
>>
>>   }
>>
>> +void hubp3_clear_tiling(struct hubp *hubp)
>> +{
>> +       struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
>> +
>> +       REG_UPDATE(DCHUBP_REQ_SIZE_CONFIG, SWATH_HEIGHT, 0);
>> +       REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, DC_SW_LINEAR);
>> +
>> +       REG_UPDATE_6(DCSURF_SURFACE_CONTROL,
>> +               PRIMARY_SURFACE_DCC_EN, 0,
>> +               PRIMARY_SURFACE_DCC_IND_BLK, 0,
>> +               PRIMARY_SURFACE_DCC_IND_BLK_C, 0,
>> +               SECONDARY_SURFACE_DCC_EN, 0,
>> +               SECONDARY_SURFACE_DCC_IND_BLK, 0,
>> +               SECONDARY_SURFACE_DCC_IND_BLK_C, 0);
>> +}
>> +
>>   void hubp3_dcc_control(struct hubp *hubp, bool enable,
>>                  enum hubp_ind_block_size blk_size)
>>   {
>> @@ -512,6 +528,7 @@ static struct hubp_funcs dcn30_hubp_funcs = {
>>          .hubp_in_blank = hubp1_in_blank,
>>          .hubp_soft_reset = hubp1_soft_reset,
>>          .hubp_set_flip_int = hubp1_set_flip_int,
>> +       .hubp_clear_tiling = hubp3_clear_tiling,
>>   };
>>
>>   bool hubp3_construct(
>> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
>> index b010531a7fe88..cfb01bf340a1a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
>> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.h
>> @@ -297,6 +297,8 @@ void hubp3_read_state(struct hubp *hubp);
>>
>>   void hubp3_init(struct hubp *hubp);
>>
>> +void hubp3_clear_tiling(struct hubp *hubp);
>> +
>>   #endif /* __DC_HUBP_DCN30_H__ */
>>
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
>> index 16580d6242789..d0878fc0cc948 100644
>> --- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
>> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
>> @@ -275,6 +275,7 @@ struct hubp_funcs {
>>                          enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cb_b,
>>                          enum hubp_3dlut_fl_crossbar_bit_slice bit_slice_cr_r);
>>          int (*hubp_get_3dlut_fl_done)(struct hubp *hubp);
>> +       void (*hubp_clear_tiling)(struct hubp *hubp);
>>   };
>>
>>   #endif
>>
>> base-commit: a5c2320151ff7cdf9ec50630d638a417ff927e31
>> --
>> 2.46.1
>>
> 


