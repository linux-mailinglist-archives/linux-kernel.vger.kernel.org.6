Return-Path: <linux-kernel+bounces-190484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB7F8CFEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D72CB2340A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B9F14F9CC;
	Mon, 27 May 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyVltNGu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5114EC6B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 11:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716809043; cv=none; b=QzRpyEXLKFdZEl3tgBCk/XGt+gFmTw7+AYnd1/kpM4ZYV71aWR6qzS445xzizwuTluXQA2njTRUTE5UhUnFqc2C/ZhyLCAyXyzufykI9sgA5CK+3cyDu2wRB2maSIrU3WzSuovI5UVbZ+5Pj/5pOhlVPu3R//ub0CU4orz/3xPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716809043; c=relaxed/simple;
	bh=I1jeBlgpNjWM5V+1t6DmYPIGjHTRRjbnXfam3eEIuDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F92LTUuNT+4HHYHtRsIJ0P0TaVmzDl/QlBiRpedLHMJC6XFw0LWDPiqNU6mddh/zbve8EF4if2Ezkz0p1YqjHrEx5Cj2YQEwLJLSvREVPW/KK9t7SHfYdZyz0Zc7m7YuGh/K3LG+dHajNZREtJabpQ3q9Q7P+UVB4otxN62cl9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyVltNGu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716809040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezJXdyF0CJ1UVaUvAyDpaA8e9pPvbwoD8x8nXFabkEM=;
	b=gyVltNGuPrAMQhZz8Q0NmHAbYIOCm1F5Ru6+4MJUZU0aqqcyiS+tuDhbNIdBejc5Tsi8Lv
	gPhGaF1XvGm4oppyVO4dO1o0VmYtKxjPL4HmBVOCeh9X4oyAKT+m+JqtNthw8K99TsD+r9
	RBTzHUA2tEaiPXPJpAehwsNNpH4dZJ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-63bF6eYWNluJon4DL7PHSg-1; Mon, 27 May 2024 07:23:59 -0400
X-MC-Unique: 63bF6eYWNluJon4DL7PHSg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4211211e18cso6043735e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 04:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716809036; x=1717413836;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezJXdyF0CJ1UVaUvAyDpaA8e9pPvbwoD8x8nXFabkEM=;
        b=iTITveeSqFeZ794f8UnivVpDhfgifwARwfhz8GyAJ/PGlwER2gFZdEdDVXVrY3NZQ6
         HaQcbGRkoMlFF8O7WeT/CC4IC+puDyb0fn8bPyzUxMzE3Iw7mUuMiqj/8EOI+pcQ8RL7
         SgW2gJWsidey/EWnTIY51ZvsdgNLY7ZycO2GQbphJ6WSbdPzmFXHmknWjsKMKUl6uH9x
         RmRIl3kVPRyEJnMFqOMa8Up0wolTnecry2ezDtWtX5CXrZNlLB/Ac9vZNnahPfe9WLu1
         Sr0U1e2DTmBtMJ3jQl+zsDCCOY8Kj9rm6WHU6D+/5vpDCQiJS+Z89gt4A6xhfBQ0JyOL
         GPeA==
X-Forwarded-Encrypted: i=1; AJvYcCWRpAR9ZSbO3fXncrwq/elniYrGw+Qzvht0E11hmMaM8nKQwjFPsOaG9phYgKP1xl7AjDYFpHMIj9+vqALPDMhKowUiZK/yA/8l4SeY
X-Gm-Message-State: AOJu0YzWNI6HDmlQxcMyKJUjBl5eSL+IH7te6PUVes2iuqOS6vmo99Lg
	Y8+vN/1gFsvbAmz+hRX4oIjZ9LG9kMUBo9faNUaQe0bxJA+fq9s1QhS6GIxP566CarukMsUVf+m
	HTxC9+x6cTiW77XyWSBGle97nzHV8yMrtvNJBkuQuwMgnx3sLvPNAm2n1dTTI1Q==
X-Received: by 2002:a05:600c:474f:b0:421:10e4:7f6b with SMTP id 5b1f17b1804b1-42110e47fd9mr36926245e9.27.1716809036240;
        Mon, 27 May 2024 04:23:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEikC1MDgYWGSkvxnXWs44q8PtsKnEAug1a4E0ySEMd1oLjB/kkI4c5l3efqErU0u/TQoTByQ==
X-Received: by 2002:a05:600c:474f:b0:421:10e4:7f6b with SMTP id 5b1f17b1804b1-42110e47fd9mr36926025e9.27.1716809035839;
        Mon, 27 May 2024 04:23:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089708f8sm105016995e9.20.2024.05.27.04.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 04:23:55 -0700 (PDT)
Message-ID: <59d4bf96-9a94-4e2c-9636-81e79d572438@redhat.com>
Date: Mon, 27 May 2024 13:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/nouveau/nvif: Avoid build error due to potential
 integer overflows
To: Guenter Roeck <linux@roeck-us.net>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jani Nikula <jani.nikula@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Joe Perches <joe@perches.com>, David Airlie <airlied@gmail.com>
References: <20240524134817.1369993-1-linux@roeck-us.net>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <20240524134817.1369993-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/24/24 15:48, Guenter Roeck wrote:
> Trying to build parisc:allmodconfig with gcc 12.x or later results
> in the following build error.
> 
> drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_mthd':
> drivers/gpu/drm/nouveau/nvif/object.c:161:9: error:
> 	'memcpy' accessing 4294967264 or more bytes at offsets 0 and 32 overlaps 6442450881 bytes at offset -2147483617 [-Werror=restrict]
>    161 |         memcpy(data, args->mthd.data, size);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/nouveau/nvif/object.c: In function 'nvif_object_ctor':
> drivers/gpu/drm/nouveau/nvif/object.c:298:17: error:
> 	'memcpy' accessing 4294967240 or more bytes at offsets 0 and 56 overlaps 6442450833 bytes at offset -2147483593 [-Werror=restrict]
>    298 |                 memcpy(data, args->new.data, size);
> 
> gcc assumes that 'sizeof(*args) + size' can overflow, which would result
> in the problem.
> 
> The problem is not new, only it is now no longer a warning but an error
> since W=1 has been enabled for the drm subsystem and since Werror is
> enabled for test builds.
> 
> Rearrange arithmetic and use check_add_overflow() for validating the
> allocation size to avoid the overflow. While at it, split assignments
> out of if conditions.
> 
> Fixes: a61ddb4393ad ("drm: enable (most) W=1 warnings by default across the subsystem")
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Danilo Krummrich <dakr@redhat.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Cc: Joe Perches <joe@perches.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied to drm-misc-fixes, thanks!

> ---
> v3: Split assignments from if conditions.
> v2: Use check_add_overflow() to calculate the allocation size and to check
>      for overflows.
> 
>   drivers/gpu/drm/nouveau/nvif/object.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvif/object.c b/drivers/gpu/drm/nouveau/nvif/object.c
> index 4d1aaee8fe15..1d19c87eaec1 100644
> --- a/drivers/gpu/drm/nouveau/nvif/object.c
> +++ b/drivers/gpu/drm/nouveau/nvif/object.c
> @@ -142,11 +142,16 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
>   		struct nvif_ioctl_v0 ioctl;
>   		struct nvif_ioctl_mthd_v0 mthd;
>   	} *args;
> +	u32 args_size;
>   	u8 stack[128];
>   	int ret;
>   
> -	if (sizeof(*args) + size > sizeof(stack)) {
> -		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL)))
> +	if (check_add_overflow(sizeof(*args), size, &args_size))
> +		return -ENOMEM;
> +
> +	if (args_size > sizeof(stack)) {
> +		args = kmalloc(args_size, GFP_KERNEL);
> +		if (!args)
>   			return -ENOMEM;
>   	} else {
>   		args = (void *)stack;
> @@ -157,7 +162,7 @@ nvif_object_mthd(struct nvif_object *object, u32 mthd, void *data, u32 size)
>   	args->mthd.method = mthd;
>   
>   	memcpy(args->mthd.data, data, size);
> -	ret = nvif_object_ioctl(object, args, sizeof(*args) + size, NULL);
> +	ret = nvif_object_ioctl(object, args, args_size, NULL);
>   	memcpy(data, args->mthd.data, size);
>   	if (args != (void *)stack)
>   		kfree(args);
> @@ -276,7 +281,15 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
>   	object->map.size = 0;
>   
>   	if (parent) {
> -		if (!(args = kmalloc(sizeof(*args) + size, GFP_KERNEL))) {
> +		u32 args_size;
> +
> +		if (check_add_overflow(sizeof(*args), size, &args_size)) {
> +			nvif_object_dtor(object);
> +			return -ENOMEM;
> +		}
> +
> +		args = kmalloc(args_size, GFP_KERNEL);
> +		if (!args) {
>   			nvif_object_dtor(object);
>   			return -ENOMEM;
>   		}
> @@ -293,8 +306,7 @@ nvif_object_ctor(struct nvif_object *parent, const char *name, u32 handle,
>   		args->new.oclass = oclass;
>   
>   		memcpy(args->new.data, data, size);
> -		ret = nvif_object_ioctl(parent, args, sizeof(*args) + size,
> -					&object->priv);
> +		ret = nvif_object_ioctl(parent, args, args_size, &object->priv);
>   		memcpy(data, args->new.data, size);
>   		kfree(args);
>   		if (ret == 0)


