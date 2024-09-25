Return-Path: <linux-kernel+bounces-338260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E04F98558B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A711E1F248B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1731591F0;
	Wed, 25 Sep 2024 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7FwaUrz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44815666A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727253213; cv=none; b=YWzNe72MYTxaxA/nxH/8WU6RjVaSU9Jhw25gmzgtVl3oDM3Dm47+ABOarxR1oUqQ1AX0HAZjdr5rWXAFxgIWFcjm+5IPyBgbfugcTj7oZqJsYzt3qWnDcCJktShg0t3y0aqAZACSm4y5bAsUvi7WQu2jjiiPnFYu51FdmJCH1pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727253213; c=relaxed/simple;
	bh=jFfGRsQmotDYwKRXWJkZoomWJG3x00ioH21oH7oqs84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHO4AcoXY/McqwraBeRB18xUYhpSniOFfQxbtMq40QYy5YUBu28IwYRlJiaxJ48IL8LC33FJm0TnHsNkVUfsde22slcBTeaqh971YCkFlXGRYtTDYplNYvTUiy2GUkezP+yEm+GKOTayoBDSW6Fx9sWevc9YyjsK9foPzWsGoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R7FwaUrz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727253210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZA8VDPtGlvwIthUScFgsavzcHEFuzxlED4I0C6Ur+E=;
	b=R7FwaUrzhQ2x8lwpV9etbXYi68y3i8J8aYoZvgulKl20wYnjxeVuS4wyr1zrlSBRY5eV2z
	hefN2I+1iCr/wNSLffgmQAOqatuc2JYICknwx4CS8yu6grRQkciC0xxTphNvZGZvKxInkQ
	9spacfzrm90LhNSG3k0UywUZFzreswo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-9Zf_TGS6NzKtVMx4fOf5Dg-1; Wed, 25 Sep 2024 04:33:28 -0400
X-MC-Unique: 9Zf_TGS6NzKtVMx4fOf5Dg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3787ea79dceso2474346f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 01:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727253207; x=1727858007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZA8VDPtGlvwIthUScFgsavzcHEFuzxlED4I0C6Ur+E=;
        b=hIdYg0lH7uCWD7PnioNUeDCf3Hp1DxzxzO1f7sXYuMLE7wTBgUqg0Xpb6BfogxYoRm
         +ZGXuvpJCB/JFedTwY99XKfZcRn2WRiJUjnTjOdjylQzld7S5QX/qbP9A3IbQFxjuDGg
         vY6LTWs8Iy0U0sO4k85Yhb47hxuljlRuQQNJXwMxAFElx32jc98EY9rqxhIljepngSWW
         oHkDHbhzpTCtM/KqGHMzj68/l9fASZIYDtBkewR2snK9dc4O+HUSsRwp1WAHCT/AxEf7
         S6D6UWLVeJFmTr20EY9yKTqihuVx6R90UXnDLoNt8K7q19+qaSWc/XzFZd0qfVCvNB13
         oSpA==
X-Forwarded-Encrypted: i=1; AJvYcCV1asjFfoSq9v7vf8E4dZ7WNLQmaVhlNDbP9JIg7oilP9U7HoUhssGXN+GssBuDQC+HtZKhWbebfiKju38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyUozC1DlODFrup741vOgtBjHdf2SewUVnKeq1bgPcABoJVX9W
	MM8xAvi7otWa1vvKK0Bh5aDPCFFGK1KGxoGu2k5A0f5ggebPmFUGgQjogCG+gSRpxYkOf04nQUf
	v+nAsSMOL0ewu7IGx8x18ATHC8YnaN7A4xulCQJ5G5PBedukH5NK5bZEX7o+znA==
X-Received: by 2002:a5d:452d:0:b0:374:c0c9:d171 with SMTP id ffacd0b85a97d-37cc245b7d5mr1365138f8f.1.1727253207422;
        Wed, 25 Sep 2024 01:33:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFymhK0jUZ+fPlNh2eTsqndaCWYE8cdqkpijneOQ2sfuibiyEcvSp9O/qZ6iD39XtkpfqBumw==
X-Received: by 2002:a5d:452d:0:b0:374:c0c9:d171 with SMTP id ffacd0b85a97d-37cc245b7d5mr1365123f8f.1.1727253207018;
        Wed, 25 Sep 2024 01:33:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2cece5sm3328624f8f.54.2024.09.25.01.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 01:33:26 -0700 (PDT)
Message-ID: <8a1afe12-4d59-4cbd-aede-fce22f8fb979@redhat.com>
Date: Wed, 25 Sep 2024 10:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Lu Yao <yaolu@kylinos.cn>, ckoenig.leichtzumerken@gmail.com,
 daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
 <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
 <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CADnq5_O7njHcvu0ejvVPPKF7szsbEQ8oFfHr9GTyD+zAe2EJ8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/09/2024 16:02, Alex Deucher wrote:
> On Fri, Sep 20, 2024 at 11:36 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> On 17/09/2024 15:21, Alex Deucher wrote:
>>> On Mon, Aug 12, 2024 at 2:10 AM Lu Yao <yaolu@kylinos.cn> wrote:
>>>>
>>>> Add support for the drm_panic module, which displays a pretty user
>>>> friendly message on the screen when a Linux kernel panic occurs.
>>>>
>>>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>>>
>>> Patch looks good to me.  Any chance you want to convert the other
>>> non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
>>> at it?
>>
>> I've made a similar patch in amdgpu_dm_plane.c, and it works on a Radeon
>> pro w6400.
>> But it only works when I'm in a VT terminal (so the framebuffer is
>> linear and CPU accessible).
>> When under Gnome/Wayland, the flag AMDGPU_GEM_CREATE_NO_CPU_ACCESS is
>> set, so that means I can't vmap it ?
> 
> It just means that the application does not need CPU access.  Whether
> or not the CPU can access the buffer or not depends on the size of the
> PCI BAR.  E.g., if the driver or bios has resized the PCI BAR, then
> the CPU can access the entire BAR, but if not you are generally
> limited to the first 256M of framebuffer.

I tried to use ttm_bo_kmap() anyway, it returns a valid virtual address, 
but writing to it has no effect on the display.
> 
>>
>> Also I don't know if there is a similar way to disable
>> tiling/compression on this hardware.
> 
> UNP_GRPH_CONTROL on chips with DCE display hardware and
> DCSURF_ADDR_CONFIG and DCSURF_TILING_CONFIG on DCN display hardware.

Thanks a lot, I will see if I can make this work.
For DCN, it depends on the HUBP version, and I need a pipe_ctx to access 
it. I didn't find how to get a pipe_ctx from the current primary plane.

Best regards,

-- 

Jocelyn

> 
> Alex
> 
>>
>> Best regards,
>>
>> --
>>
>> Jocelyn
>>
>>
>>>
>>> Alex
>>>
>>>
>>>> ---
>>>> Changes in v2:
>>>> 1. Drop include "drm_internal.h"
>>>> 2. Add disabling DC tiling ops.
>>>> Per suggestion from previous thread:
>>>> https://patchwork.freedesktop.org/patch/606879/?series=136832&rev=1
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
>>>>    1 file changed, 48 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>>> index 05c0df97f01d..ba1b7a36caa3 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>>>> @@ -28,6 +28,7 @@
>>>>    #include <drm/drm_modeset_helper.h>
>>>>    #include <drm/drm_modeset_helper_vtables.h>
>>>>    #include <drm/drm_vblank.h>
>>>> +#include <drm/drm_panic.h>
>>>>
>>>>    #include "amdgpu.h"
>>>>    #include "amdgpu_pm.h"
>>>> @@ -2600,6 +2601,52 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
>>>>           .get_scanout_position = amdgpu_crtc_get_scanout_position,
>>>>    };
>>>>
>>>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
>>>> +                                                        struct drm_scanout_buffer *sb)
>>>> +{
>>>> +       struct drm_framebuffer *fb;
>>>> +       struct amdgpu_bo *abo;
>>>> +       struct amdgpu_crtc *amdgpu_crtc;
>>>> +       struct amdgpu_device *adev;
>>>> +       uint32_t fb_format;
>>>> +
>>>> +       if (!plane->fb)
>>>> +               return -EINVAL;
>>>> +
>>>> +       fb = plane->fb;
>>>> +
>>>> +       abo = gem_to_amdgpu_bo(fb->obj[0]);
>>>> +       amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
>>>> +       adev = drm_to_adev(fb->dev);
>>>> +
>>>> +       if (!abo->kmap.virtual &&
>>>> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
>>>> +               DRM_WARN("amdgpu bo map failed, panic won't be displayed\n");
>>>> +               return -ENOMEM;
>>>> +       }
>>>> +
>>>> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>>>> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
>>>> +       else
>>>> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
>>>> +
>>>> +       sb->width = fb->width;
>>>> +       sb->height = fb->height;
>>>> +       sb->format = fb->format;
>>>> +       sb->pitch[0] = fb->pitches[0];
>>>> +
>>>> +       /* Disable DC tiling */
>>>> +       fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
>>>> +       fb_format &= ~GRPH_ARRAY_MODE(0x7);
>>>> +       WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
>>>> +       .get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
>>>> +};
>>>> +
>>>>    static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>>>    {
>>>>           struct amdgpu_crtc *amdgpu_crtc;
>>>> @@ -2627,6 +2674,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>>>           amdgpu_crtc->encoder = NULL;
>>>>           amdgpu_crtc->connector = NULL;
>>>>           drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
>>>> +       drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
>>>>
>>>>           return 0;
>>>>    }
>>>> --
>>>> 2.25.1
>>>>
>>>
>>
> 


