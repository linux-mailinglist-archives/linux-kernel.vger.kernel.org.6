Return-Path: <linux-kernel+bounces-274455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE67947848
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BC062824C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2CF15250F;
	Mon,  5 Aug 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YnUhfrO0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1522309
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849936; cv=none; b=fOnXeZHLUScnS81o3lOIh69NMMgB8jWTAKXi7KlH6OHTu8N6K3zqnquM+dTTRQkPsJQ18PnCPJkmislS6YIV8y8+f0CgKNnt/RpslXzBGH44TQaT+GXmnXGmLugmAsyCEdrPlkES6n6tJDk9/PtzQ5Kan8T7SJQudcJzrc9F4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849936; c=relaxed/simple;
	bh=gMHLwLm94oxGtUFFLaUGOYO9PWeF1QbpC+pPvSvOxXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbtT/ZoKM4Jj+Oba5UmNhxBbcMeb/AOAR+PNOJTG0J4uL4exkjiP7insZQRJCXjFyQMWO18yU1WR5tG1s6iWMKlYbB3sm8imSmnlWLowU0hIyB/pM8lpdMrScnR77J9H8jr1IbxqY4Epxw6bcXeA+rcypXEYVmfHVjVOS2Z5zSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YnUhfrO0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722849933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DVPje45jRqWUyf21vKY8ziLaJNWS7/hvJnTk3KHALc4=;
	b=YnUhfrO0MZbd4cj2AML9VKMY8AXxj3A3aFNnc1r3Ds7w/8RLuOxid5AL7BoCKS+HGKfzjD
	gcf/E21jbTsrxj6AFazS4LhYA4kJdd7nG2yWKnTU1vHRW5ujCcPHHjAC51N1/IkhdiOXkZ
	HI7Ov/sM51jStUqrDZaBD2F4ao3vqX8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-uTyUUnwdMDy5XH388W6Imw-1; Mon, 05 Aug 2024 05:25:32 -0400
X-MC-Unique: uTyUUnwdMDy5XH388W6Imw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef286cf0e8so110353861fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 02:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849930; x=1723454730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVPje45jRqWUyf21vKY8ziLaJNWS7/hvJnTk3KHALc4=;
        b=xB8kAv2v8/jUAI8yCPjJwAlwlmbnTBVtDwvbyyRvd/ykeZpSGpFrVjaehK55Q89/wF
         iG6mmNZsqZocTMZmLG+Dk48ERoAQJycNRDq6cLP+naoOVBrjxbJaPtVTpwdMpg7hU33i
         nuE1Kt8RikNArxhoaFBpJtXHy1qvZbhM/PCanzhnE5ypaRoWKP8/A0pl7Q6IdREWjMwa
         LxztoZRXrKlobySYzJ9RfZ7EyQhl+ZPUDZaXnFPgMbvPoXsdQ80X2Nu8qG2xe4qygqPS
         4BwZE5nTUelGI6wOyTD6lsyclcdhrS/k7O9m4PQ2P6W+fulCERZy8M65vsNgcsOD/y6L
         prOw==
X-Forwarded-Encrypted: i=1; AJvYcCVPUWkmmBnz6LkNanmeuKzdZUlnRGSnHVniozA+fOfn83lDNDq1bPSDAdMKDnYkY7PAaMggdHJlhz+BBRyWoCU1o2SkeEyrvb9BpVEX
X-Gm-Message-State: AOJu0YxPc3669JzxL87mVanIIfyt9T345uGAFMJIV6YIbOLo1u2jYa9L
	lMm+V8TwsbITXUpU6Mmr146zfmU9cYkPx2f1/MQ0DZAYx08MLHMMpuWSrNb+/M1oo7CZV8vE2Az
	fNoNElx9UP3oSA/cMtE/Qd0Vz++R9ug4bH2TqVUOHnhMRSMiQmC5w92Y7xe8Omw==
X-Received: by 2002:a2e:9cc4:0:b0:2ef:2504:22d8 with SMTP id 38308e7fff4ca-2f15ab5e795mr70393151fa.48.1722849930332;
        Mon, 05 Aug 2024 02:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGONShcOrHu4P1pU0+nQTi0tuMGpcoRSWwxmHo4dIcFqCEAaNuVDpqTjn4XVExilHl4PzKZng==
X-Received: by 2002:a2e:9cc4:0:b0:2ef:2504:22d8 with SMTP id 38308e7fff4ca-2f15ab5e795mr70392921fa.48.1722849929695;
        Mon, 05 Aug 2024 02:25:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:d5:a000:d3ea:62cf:3052:fac6? ([2a01:e0a:d5:a000:d3ea:62cf:3052:fac6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0597b2sm9218693f8f.81.2024.08.05.02.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 02:25:29 -0700 (PDT)
Message-ID: <0e6d6a46-9e7f-4077-ba2d-edae91ab2165@redhat.com>
Date: Mon, 5 Aug 2024 11:25:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add dce6 drm_panic support
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lu Yao <yaolu@kylinos.cn>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
Cc: airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <ce45d800-ad6a-4cef-9c57-480908867490@gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <ce45d800-ad6a-4cef-9c57-480908867490@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/08/2024 11:39, Christian König wrote:
> Am 02.08.24 um 09:17 schrieb Lu Yao:
>> Add support for the drm_panic module, which displays a pretty user
>> friendly message on the screen when a Linux kernel panic occurs.
>>
>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
>> ---
>> The patch can work properly on the TTY, but after start X, drawn
>> image is messy, it looks like the data isn't linearly arranged.
>> However at this time 'fb->modifier' is 'DRM_FORMAT_MOD_LINEAR'.
>>
>> Another difference I found is:
>>    For TTY, the amdgpu_bo is created with flag
>>    'AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED|AMDGPU_GEM_CREATE_CPU_GTT_USWC|
>>    AMDGPU_GEM_CREATE_VRAM_CLEARED|AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS'.
>>    For X, the amdgpu_bo is created with flag
>>    'AMDGPU_GEM_CREATE_NO_CPU_ACCESS|AMDGPU_GEM_CREATE_CPU_GTT_USWC'
>> I try to use same flag for X, it looks like no difference.
>>
>> Can someone provide some insight into this problem or where I am going
>> wrong. Thanks a lot.
>>
>> Test environment: X86 arch + v6.6 kernel + R7340.
>> ---
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32 +++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index 05c0df97f01d..12c3801c264a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -28,6 +28,8 @@
>>   #include <drm/drm_modeset_helper.h>
>>   #include <drm/drm_modeset_helper_vtables.h>
>>   #include <drm/drm_vblank.h>
>> +#include <drm/drm_panic.h>
> 
>> +#include "../../drm_internal.h"
> 
> Well that this file is named "internal" and not in a common include 
> directory is a strong indicator that you should absolutely *not* include 
> it in a driver.
> 
>>   #include "amdgpu.h"
>>   #include "amdgpu_pm.h"
>> @@ -2600,6 +2602,35 @@ static const struct drm_crtc_helper_funcs 
>> dce_v6_0_crtc_helper_funcs = {
>>       .get_scanout_position = amdgpu_crtc_get_scanout_position,
>>   };
>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct 
>> drm_plane *plane,
>> +                             struct drm_scanout_buffer *sb)
>> +{
>> +    struct drm_framebuffer *fb;
>> +    struct drm_gem_object *obj;
>> +    struct amdgpu_bo *abo;
>> +    int ret = 0;
>> +
>> +    if (!plane->fb || plane->fb->modifier != DRM_FORMAT_MOD_LINEAR)
>> +        return -ENODEV;
>> +
>> +    fb = plane->fb;
>> +    sb->width = fb->width;
>> +    sb->height = fb->height;
>> +    sb->format = fb->format;
>> +    sb->pitch[0] = fb->pitches[0];
>> +
>> +    obj = fb->obj[0];
>> +    abo = gem_to_amdgpu_bo(obj);
>> +    if (!abo || abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)
>> +        return -EINVAL;
>> +
>> +    return drm_gem_vmap(obj, &sb->map[0]);
> 
> Yeah that will almost always not work. Most display buffers are tilled 
> and not CPU accessible.

For the CPU accessible issue, Christian mentioned there was a debug 
interface on AMD GPU that can be used, to work around this:

https://lore.kernel.org/dri-devel/0baabe1f-8924-2c9a-5cd4-59084a37dbb2@gmail.com/ 
and 
https://lore.kernel.org/dri-devel/d233c376-ed07-2127-6084-8292d313dac7@amd.com/

And you will need to use the scanout_buffer->set_pixel() callback to 
write the pixels one by one, similar to what I've tried for nouveau with
https://patchwork.freedesktop.org/series/133963/

For the tiling format, the problem is that it is internal to the GPU, 
and currently the driver don't know which tiling format is being used.

It might be possible to disable tiling and compression, but it requires 
some internal DC knowledge:
https://lore.kernel.org/dri-devel/f76a3297-7d63-8615-45c5-47f02b64a1d5@amd.com/

Best regards,

-- 

Jocelyn



> 
> Regards,
> Christian.
> 
>> +}
>> +
>> +static const struct drm_plane_helper_funcs 
>> dce_v6_0_drm_primary_plane_helper_funcs = {
>> +    .get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
>> +};
>> +
>>   static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>   {
>>       struct amdgpu_crtc *amdgpu_crtc;
>> @@ -2627,6 +2658,7 @@ static int dce_v6_0_crtc_init(struct 
>> amdgpu_device *adev, int index)
>>       amdgpu_crtc->encoder = NULL;
>>       amdgpu_crtc->connector = NULL;
>>       drm_crtc_helper_add(&amdgpu_crtc->base, 
>> &dce_v6_0_crtc_helper_funcs);
>> +    drm_plane_helper_add(amdgpu_crtc->base.primary, 
>> &dce_v6_0_drm_primary_plane_helper_funcs);
>>       return 0;
>>   }
> 


