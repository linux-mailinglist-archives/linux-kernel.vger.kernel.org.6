Return-Path: <linux-kernel+bounces-217229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81A590AD17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EC41F22FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421DD194AD5;
	Mon, 17 Jun 2024 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXGJnJB5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E349519069A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718624301; cv=none; b=OCpk/bSu2lEQKUHJgAUaF6pwFENTIxdRdsaxPvONWMyBWOujxXHgw5Yrvkxg5tBj58y3AkUQc75WroyAAQbsGnOG0lLIGQUaqbOwhDwJ3hCro7G71V2YR1tc7TNiyls6H6HLsdwZD7FuHjGrBduDYC/qCFkL6Y6qGEIjy45TPNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718624301; c=relaxed/simple;
	bh=Jhscx+ZIsUJjtjS+S1mYdMxAB0SSRoCRbFclSexxvm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSBR0Vjzk8cK7cG6jVh6JTJBx+sfMPBXA5/konmHykNcVrYJEJ/0bkGZxM2AE7dza7eY31/GMwO/7RlVloslrdG9F7AoYusliyAL0X86eIoCfT95z9UawCpO9Xa7QlETvzDPBG4WgpcvWdS/UW/4uBbNawUD6VihoJDbuzU0Rto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXGJnJB5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718624298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0Kc7h87YsT9DHt1tRlY5kGZHCAuCj2NA4WSI3E/cJE=;
	b=cXGJnJB5hwksnOh47e5GZG3FYsTOBazCGNdcijzY2D9JV1+1AR/FPh3gG2nsVf1co1OyMJ
	uU6Ho6VZDnGlmKJeMDI6Y5uQB5QDM9pql0evZUBu1jaMOzdmim9aIqKpsS0jSLilqVHJHy
	0DcEjbSv/MvXvctogxMZCJfBN1XbjiY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-qdb0_cisMDKnKqmd_gFB4g-1; Mon, 17 Jun 2024 07:38:17 -0400
X-MC-Unique: qdb0_cisMDKnKqmd_gFB4g-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52c968340c8so3895316e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 04:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718624295; x=1719229095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0Kc7h87YsT9DHt1tRlY5kGZHCAuCj2NA4WSI3E/cJE=;
        b=o+n/ZsL/uxCaMGZZKY5A5EOzYEPeUWGZmTTlD6PR7EKKRFRmG8cPlpbhwIYaNmKwoa
         RR1dEjHNGMaxHtpgK1Jlb2OW05rkciMaVsXoYUp+QoIXwryk1fVV+jbX9ar1kt3OehYb
         4xeKo9ZPNO74RDlYWeHT6bvR0123sjnuqA0noS0mv3bDlam9BHmxmXEFr98sZBCtPBHC
         bEhxdMvSCKZ7Qx2ELy1njoRx/4aKfkS+Ix4wIzhUzYt9YDXMnMRRy4VD+2/P6fsec/F2
         mzTFfq21b7jeFJmETruQOz02J9346RjRhhdPsAyWdg/Lh9aXM7VKrAIjHBW0WKIV/7dU
         G8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUMZW0oxn/4wnQdy9Ys+u6eusioq+qBCZ9f25N5gd46Z4p8T1Vc5Nne5jYzaNXllZKlybsI/ySqEa5kE/FwtF5zrEFgPbajg8bRMDqZ
X-Gm-Message-State: AOJu0YxKbbxlV3J+M4x8TM+XOs2G4IxIphDyZv4NpyJQzVv0wd1G1XMO
	S+2K1y2GpuWY9tHAbTm603rr0aEd6mxDYk2LpOecza8uIHFSCTzFOH93a3mtAtMtmfD9DMlIniC
	XX0fVSIRrY+kFaZYRleF7qYmKe1gdzCKgdwodLZgf5IX97BuLAGGKwiAumpyAoBhfBhLUpsfq
X-Received: by 2002:ac2:5f53:0:b0:52c:9bcc:e177 with SMTP id 2adb3069b0e04-52ca6e6db3emr6446176e87.34.1718624295403;
        Mon, 17 Jun 2024 04:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8ieLGLkSX25YvxUU73G1pJZDdpLd+LcNUpG3OzlHqw6rNPX8yyM8oB/AHOC5zwwT4lEJRAg==
X-Received: by 2002:ac2:5f53:0:b0:52c:9bcc:e177 with SMTP id 2adb3069b0e04-52ca6e6db3emr6446167e87.34.1718624295024;
        Mon, 17 Jun 2024 04:38:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422ffdc329asm122167725e9.1.2024.06.17.04.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 04:38:14 -0700 (PDT)
Message-ID: <7807302b-a501-46f5-8326-2b6394a3ab7c@redhat.com>
Date: Mon, 17 Jun 2024 13:38:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/tidss: Add drm_panic support
To: Javier Martinez Canillas <javierm@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Vetter
 <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
References: <20240615085326.1726262-1-javierm@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240615085326.1726262-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15/06/2024 10:53, Javier Martinez Canillas wrote:
> Add support for the drm_panic module, which displays a pretty user
> friendly message on the screen when a Linux kernel panic occurs.

Thanks for enabling drm panic on another hardware.
It looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>


> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> Tested on an AM625 BeaglePlay board by triggering a panic using the
> `echo c > /proc/sysrq-trigger` command.
> 
>   drivers/gpu/drm/tidss/tidss_plane.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/tidss/tidss_plane.c
> index 68fed531f6a7..a5d86822c9e3 100644
> --- a/drivers/gpu/drm/tidss/tidss_plane.c
> +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> @@ -8,6 +8,7 @@
>   #include <drm/drm_atomic_helper.h>
>   #include <drm/drm_blend.h>
>   #include <drm/drm_crtc.h>
> +#include <drm/drm_fb_dma_helper.h>
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_gem_atomic_helper.h>
> @@ -166,6 +167,14 @@ static const struct drm_plane_helper_funcs tidss_plane_helper_funcs = {
>   	.atomic_disable = tidss_plane_atomic_disable,
>   };
>   
> +static const struct drm_plane_helper_funcs tidss_primary_plane_helper_funcs = {
> +	.atomic_check = tidss_plane_atomic_check,
> +	.atomic_update = tidss_plane_atomic_update,
> +	.atomic_enable = tidss_plane_atomic_enable,
> +	.atomic_disable = tidss_plane_atomic_disable,
> +	.get_scanout_buffer = drm_fb_dma_get_scanout_buffer,
> +};
> +
>   static const struct drm_plane_funcs tidss_plane_funcs = {
>   	.update_plane = drm_atomic_helper_update_plane,
>   	.disable_plane = drm_atomic_helper_disable_plane,
> @@ -211,7 +220,10 @@ struct tidss_plane *tidss_plane_create(struct tidss_device *tidss,
>   	if (ret < 0)
>   		goto err;
>   
> -	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
> +	if (type == DRM_PLANE_TYPE_PRIMARY)
> +		drm_plane_helper_add(&tplane->plane, &tidss_primary_plane_helper_funcs);
> +	else
> +		drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
>   
>   	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
>   				       num_planes - 1);


