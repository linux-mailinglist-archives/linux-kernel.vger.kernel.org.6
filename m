Return-Path: <linux-kernel+bounces-334461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7397D78F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B42D284376
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D40617BB3F;
	Fri, 20 Sep 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCfhKMJO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C833F4ED
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726846595; cv=none; b=EhBToDeHHJ1wrcvZv5Eg1DCZLP9WyGGyWm+JMIftkV4/FR5N9VqDkJSNPmDPukIl3Jjj647PYAM6hu4MINI+ZF4QqL+a4ClGcv7tUGoKM2z+BJ60pP2xJvYAEutO02FDGyFI7ijG4FRvBbSOSZNXL23DtUJbxfYd9m5+3C6NU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726846595; c=relaxed/simple;
	bh=xzTgl+aGo86H82fLR/N0xFNi6H/y2TnW6BqfgG3saVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+OPaqvqmZCFEnCp1kwgX7Zey6e619a47rAZ9qVvr3APD2C6gPgQun7zVYTtW9Ehfccr0NcY3VNSWebah3QMCJXU4iSuWdWtoCxXS+UOFj+D61GLJernAzdHDz6HLKkBGTWTRcYk3BeUErzr/Ue2/qT3EFEZ3PJHWSjq4loOri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CCfhKMJO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726846592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF81E5q3dcgpsAt6yPTalypggTyS/xoFs7GofpOnUp4=;
	b=CCfhKMJOoX6JAN1rxgmZV0KlK9BiRXbkZm6VnlvBWcap/o+lPAP0QD82MglPUHMD3TDlVJ
	BIE6Ubvsmn1AxGyCgViNQ/qTOm27nweOQWrJ8iPuISMdHvwmLLM+hPrEywkHPVnFCzj18q
	ngE67bQCBHnr3NdgJ1eDhKjDJc2WIgo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-y8qJe2GyONuxUZQDT16I5A-1; Fri, 20 Sep 2024 11:36:31 -0400
X-MC-Unique: y8qJe2GyONuxUZQDT16I5A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42cb471a230so16562555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726846590; x=1727451390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XF81E5q3dcgpsAt6yPTalypggTyS/xoFs7GofpOnUp4=;
        b=LT+PGyNfBirA2E4pwkkHrHK8U0dObZLsWtz4sfrMTR1zpRVoCTn9yRxgONsKeZegPH
         ff4zS7xpzzYjSnl5zBdrundDdvSrSrSccLFcWoPOmGQ3w0FoWdPi13TD1wieWtO6WITy
         YyQL2JcYzz6yzD7OmYhCRA3MdoMKFPmKZfkm9N4mJ4DBpa5PMH+6ivAn2yZKKt+qCn06
         KWAtkPrBUnVkezsTzYRksprUecVlAjQviSnRO/8tWsTjIYxPnVCZHVepSNiWrccmtPKS
         8kRihE3cRaLSNhTze4enzvubwsKVkcmvLD8wVOkxN0BOZo1DzfI4c0n2Bxd2fLBFiVke
         ow7w==
X-Forwarded-Encrypted: i=1; AJvYcCW9Y7Ht70/7TvMQb0p+7kFK2cYY36HFQ6Gu117kld9fDxQO9GJXlBjRpWmxsUOqaJZkHHJc3PxVcCxx3vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfo0E/uNP3s/fmokb2WJEtR7QZspgaFfP7Ldv7ZD4/qVgH1Xi
	2s4I8aSxIMdB8uzROOp8M2FG+cvTH2hp+cjCF4rBVO3T/HakQYnoIbev7+RuWo3XDzZLaJDgQMC
	Gy7w7sHdo1SKKL+W72uUqIEJPxIHTK7sbIDVFjrxfm/j3Bd+RvUiDPDjgm7922g==
X-Received: by 2002:a05:600c:310a:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-42e7ada4d19mr21185495e9.27.1726846589792;
        Fri, 20 Sep 2024 08:36:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbBnSe6ZeVzt8REAbM4EztjbArVr1o71yxuBniSzhuLu4B6LPEfV+k7lLYBVAZUTUqL6NisQ==
X-Received: by 2002:a05:600c:310a:b0:426:61e8:fb3b with SMTP id 5b1f17b1804b1-42e7ada4d19mr21185365e9.27.1726846589389;
        Fri, 20 Sep 2024 08:36:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f9a22sm17878482f8f.61.2024.09.20.08.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 08:36:28 -0700 (PDT)
Message-ID: <16352ae0-7e61-440d-8c04-7ec912f9bf9a@redhat.com>
Date: Fri, 20 Sep 2024 17:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: add dce6 drm_panic support
To: Alex Deucher <alexdeucher@gmail.com>, Lu Yao <yaolu@kylinos.cn>
Cc: ckoenig.leichtzumerken@gmail.com, daniel@ffwll.ch, Xinhui.Pan@amd.com,
 airlied@gmail.com, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
References: <20240802071752.116541-1-yaolu@kylinos.cn>
 <20240812060914.102614-1-yaolu@kylinos.cn>
 <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CADnq5_OcUgV9dgAynDCQnm9NS+QCvhBiHvxWnhWqi2qqhh=zXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/09/2024 15:21, Alex Deucher wrote:
> On Mon, Aug 12, 2024 at 2:10 AM Lu Yao <yaolu@kylinos.cn> wrote:
>>
>> Add support for the drm_panic module, which displays a pretty user
>> friendly message on the screen when a Linux kernel panic occurs.
>>
>> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> 
> Patch looks good to me.  Any chance you want to convert the other
> non-DC dce files (dce_v8_0.c, dce_v10_0.c, dce_v11_0.c) while you are
> at it?

I've made a similar patch in amdgpu_dm_plane.c, and it works on a Radeon 
pro w6400.
But it only works when I'm in a VT terminal (so the framebuffer is 
linear and CPU accessible).
When under Gnome/Wayland, the flag AMDGPU_GEM_CREATE_NO_CPU_ACCESS is 
set, so that means I can't vmap it ?

Also I don't know if there is a similar way to disable 
tiling/compression on this hardware.

Best regards,

-- 

Jocelyn


> 
> Alex
> 
> 
>> ---
>> Changes in v2:
>> 1. Drop include "drm_internal.h"
>> 2. Add disabling DC tiling ops.
>> Per suggestion from previous thread:
>> https://patchwork.freedesktop.org/patch/606879/?series=136832&rev=1
>> ---
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 48 +++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index 05c0df97f01d..ba1b7a36caa3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -28,6 +28,7 @@
>>   #include <drm/drm_modeset_helper.h>
>>   #include <drm/drm_modeset_helper_vtables.h>
>>   #include <drm/drm_vblank.h>
>> +#include <drm/drm_panic.h>
>>
>>   #include "amdgpu.h"
>>   #include "amdgpu_pm.h"
>> @@ -2600,6 +2601,52 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
>>          .get_scanout_position = amdgpu_crtc_get_scanout_position,
>>   };
>>
>> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
>> +                                                        struct drm_scanout_buffer *sb)
>> +{
>> +       struct drm_framebuffer *fb;
>> +       struct amdgpu_bo *abo;
>> +       struct amdgpu_crtc *amdgpu_crtc;
>> +       struct amdgpu_device *adev;
>> +       uint32_t fb_format;
>> +
>> +       if (!plane->fb)
>> +               return -EINVAL;
>> +
>> +       fb = plane->fb;
>> +
>> +       abo = gem_to_amdgpu_bo(fb->obj[0]);
>> +       amdgpu_crtc = to_amdgpu_crtc(plane->crtc);
>> +       adev = drm_to_adev(fb->dev);
>> +
>> +       if (!abo->kmap.virtual &&
>> +           ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size), &abo->kmap)) {
>> +               DRM_WARN("amdgpu bo map failed, panic won't be displayed\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       if (abo->kmap.bo_kmap_type & TTM_BO_MAP_IOMEM_MASK)
>> +               iosys_map_set_vaddr_iomem(&sb->map[0], abo->kmap.virtual);
>> +       else
>> +               iosys_map_set_vaddr(&sb->map[0], abo->kmap.virtual);
>> +
>> +       sb->width = fb->width;
>> +       sb->height = fb->height;
>> +       sb->format = fb->format;
>> +       sb->pitch[0] = fb->pitches[0];
>> +
>> +       /* Disable DC tiling */
>> +       fb_format = RREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset);
>> +       fb_format &= ~GRPH_ARRAY_MODE(0x7);
>> +       WREG32(mmGRPH_CONTROL + amdgpu_crtc->crtc_offset, fb_format);
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
>> +       .get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
>> +};
>> +
>>   static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>   {
>>          struct amdgpu_crtc *amdgpu_crtc;
>> @@ -2627,6 +2674,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>>          amdgpu_crtc->encoder = NULL;
>>          amdgpu_crtc->connector = NULL;
>>          drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
>> +       drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
>>
>>          return 0;
>>   }
>> --
>> 2.25.1
>>
> 


