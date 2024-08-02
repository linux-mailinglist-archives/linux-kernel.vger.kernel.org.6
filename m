Return-Path: <linux-kernel+bounces-272394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2779A945B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6281F24C94
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9951DAC71;
	Fri,  2 Aug 2024 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzeHhu5D"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD731D1F54
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591582; cv=none; b=YxX3sR7YST6Bl2vg2YSZt/HrGt1vdLyvWi6w+5iz9OpATzuJlZDbCAMinAB2m4Xp5BashFIQuhQbnmoqDabD9H1TeK49fbapDbOYvZbqwsLT8iu/GwNqns4NdlYKetFKBxF848F3joMgzICOCeddZ0LO5WvZsHfH8yMAjkATT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591582; c=relaxed/simple;
	bh=ZbKunDPMEEJPtvGdIuC2HdQLTmr+t5xKKq8Z5QNBj9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ijl7jhzjhspb9xtTKm6Ij10SWQKjCd6dilxyOwAYI9GfPKXUYnNHV6hpZKO848eq5gALcbGxEhINWgZC3kcx6JJ+CZoC0+9gI9Rf6P57JYENfmRnOGe3zl1yzNloGUlBhxuFpP0eSyE5cA9k9CObwvCf2VcjbJPF5lsAs54Gg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzeHhu5D; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36865a516f1so5472530f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722591579; x=1723196379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epsFg+QNub+FqtmHtHz144X/ITFDI4OkHx3ujhgC24A=;
        b=YzeHhu5DDbFwV3eM7iUGiW1MxqBo8cSZ9pEfSvAV/VAra2CU3HDoaK2d3NsuDkIpfF
         ce796TNhZHJGQUMfWkcpVCHmRffY0e0v38CtWp4CwmKda74BZlMwVoMT/p1T+F++Tx1I
         PIzuj/Vx6xSxFKANAPJ5kiC8bWJIL74Mb3v1KzqutcB7qo1Pj8K8Ke1qPqsNJBZvIevl
         QwFQHoiYv6UC/MTWu6Lb3WOTzULsw5tcQcBol04xe/7ouVSGmPhx7GVZNnx3bZiy7pph
         tRP11kbyrEftx4Tq6Iaqc86WRwjsj+DVPSLmlQkE1GZB4nYoSjLZus9TbdnHpcIwKlYh
         o1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591579; x=1723196379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epsFg+QNub+FqtmHtHz144X/ITFDI4OkHx3ujhgC24A=;
        b=wJXGvJiYJg/mokWpcmzGuV7SZGVav91901FhHsjjCuGX+OftTLQgjUo+XBM0fBc6zw
         d0yUDd9tFCcZm2DMgTTpw54C63V7OPoez/N8c8ADMihaPXSMen2cvVflwW1YCN2iIMYM
         wLZ9fdRqFxjVb8YgHf3Y46cPQUJSw6OB2rUztQbBt3R98Zyc0AYmGdInvffAVMgR8wX2
         4l0Pf1kyCBP61S6DVwy4zNJatp4ERtfn56EVumGJpfw/HMxsIVZdVgMrgUnQiOdVmHBC
         7kEDnXAgrLFAnvJwz8Hb9l+fbeCGmEv4wIJEucKAWASsdv8GYFcY0/194eO6tf0YW/Mj
         0Dzg==
X-Forwarded-Encrypted: i=1; AJvYcCWS6mGqoAOzqQA67bzKbBXZFFcbDDlxsOOXfAWdE3CQRuX47gEhyjShVPnl3oZHFb5XZLEfXMvpOqr8UOacxbsu8/zT3U3AY3GjEFff
X-Gm-Message-State: AOJu0Yzo9e4qKokhvlTe8xJFVsG3Av1PKDKBWf93tLhCQq1HLHgwRIJc
	xunH607pPLzGuY1j9On/vOqcG73oUPiuWlaUU1FAzCmYlX8eCKBw
X-Google-Smtp-Source: AGHT+IHNFpNyZLyDG82LlxIHjrUDxrGrZIvbFsdh4WVQj+Ss/wNeTYIUpERWeCU6ixu2lioDvMJyQg==
X-Received: by 2002:a05:6000:b92:b0:368:7ad8:531f with SMTP id ffacd0b85a97d-36bbc1a5174mr1844283f8f.42.1722591578368;
        Fri, 02 Aug 2024 02:39:38 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01ee30sm1501150f8f.50.2024.08.02.02.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 02:39:37 -0700 (PDT)
Message-ID: <ce45d800-ad6a-4cef-9c57-480908867490@gmail.com>
Date: Fri, 2 Aug 2024 11:39:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add dce6 drm_panic support
To: Lu Yao <yaolu@kylinos.cn>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, srinivasan.shanmugam@amd.com,
 sunil.khatri@amd.com
Cc: airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240802071752.116541-1-yaolu@kylinos.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240802071752.116541-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 02.08.24 um 09:17 schrieb Lu Yao:
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.
>
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
> The patch can work properly on the TTY, but after start X, drawn
> image is messy, it looks like the data isn't linearly arranged.
> However at this time 'fb->modifier' is 'DRM_FORMAT_MOD_LINEAR'.
>
> Another difference I found is:
>    For TTY, the amdgpu_bo is created with flag
>    'AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED|AMDGPU_GEM_CREATE_CPU_GTT_USWC|
>    AMDGPU_GEM_CREATE_VRAM_CLEARED|AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS'.
>    For X, the amdgpu_bo is created with flag
>    'AMDGPU_GEM_CREATE_NO_CPU_ACCESS|AMDGPU_GEM_CREATE_CPU_GTT_USWC'
> I try to use same flag for X, it looks like no difference.
>
> Can someone provide some insight into this problem or where I am going
> wrong. Thanks a lot.
>
> Test environment: X86 arch + v6.6 kernel + R7340.
> ---
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 32 +++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 05c0df97f01d..12c3801c264a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -28,6 +28,8 @@
>   #include <drm/drm_modeset_helper.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_vblank.h>
> +#include <drm/drm_panic.h>

> +#include "../../drm_internal.h"

Well that this file is named "internal" and not in a common include 
directory is a strong indicator that you should absolutely *not* include 
it in a driver.

>   
>   #include "amdgpu.h"
>   #include "amdgpu_pm.h"
> @@ -2600,6 +2602,35 @@ static const struct drm_crtc_helper_funcs dce_v6_0_crtc_helper_funcs = {
>   	.get_scanout_position = amdgpu_crtc_get_scanout_position,
>   };
>   
> +static int dce_v6_0_drm_primary_plane_get_scanout_buffer(struct drm_plane *plane,
> +							 struct drm_scanout_buffer *sb)
> +{
> +	struct drm_framebuffer *fb;
> +	struct drm_gem_object *obj;
> +	struct amdgpu_bo *abo;
> +	int ret = 0;
> +
> +	if (!plane->fb || plane->fb->modifier != DRM_FORMAT_MOD_LINEAR)
> +		return -ENODEV;
> +
> +	fb = plane->fb;
> +	sb->width = fb->width;
> +	sb->height = fb->height;
> +	sb->format = fb->format;
> +	sb->pitch[0] = fb->pitches[0];
> +
> +	obj = fb->obj[0];
> +	abo = gem_to_amdgpu_bo(obj);
> +	if (!abo || abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)
> +		return -EINVAL;
> +
> +	return drm_gem_vmap(obj, &sb->map[0]);

Yeah that will almost always not work. Most display buffers are tilled 
and not CPU accessible.

Regards,
Christian.

> +}
> +
> +static const struct drm_plane_helper_funcs dce_v6_0_drm_primary_plane_helper_funcs = {
> +	.get_scanout_buffer = dce_v6_0_drm_primary_plane_get_scanout_buffer
> +};
> +
>   static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>   {
>   	struct amdgpu_crtc *amdgpu_crtc;
> @@ -2627,6 +2658,7 @@ static int dce_v6_0_crtc_init(struct amdgpu_device *adev, int index)
>   	amdgpu_crtc->encoder = NULL;
>   	amdgpu_crtc->connector = NULL;
>   	drm_crtc_helper_add(&amdgpu_crtc->base, &dce_v6_0_crtc_helper_funcs);
> +	drm_plane_helper_add(amdgpu_crtc->base.primary, &dce_v6_0_drm_primary_plane_helper_funcs);
>   
>   	return 0;
>   }


