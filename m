Return-Path: <linux-kernel+bounces-217896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1011B90B5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B270E1F230FB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEE577102;
	Mon, 17 Jun 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYOtCiC6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5B6BFAA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639741; cv=none; b=OHXj/HwVXo+SvcKrrPZiaNeb3VWxx6s7iqlfqnQJNAkA39ULEkVefxeGZtV1NwpasQUDu1d5IzioCqMPjMtzpfNfNj+PliO4e1ysu8A9m0R0RGbgjNB81OuZcS6t+xOovT9gX4IHHDJ3BuOE/gYsnHiC4fmxv9OVrozoDZqd4do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639741; c=relaxed/simple;
	bh=JANif8e1KKUW7ry1WN7ofm9l+tvrWerY2twJ/3A32Ug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4+K4OIkKm/6Sal1ukxG5MOigtzdMpAnSK2C6NFpyZZxkHfPaSjJvUQtM96y+FcFJGs/AFYy5OnCe/5yTqE9Ro1SatsP3DUxnLXZ/j4lCgWAFO8TA5pTpaauKfQZN2mKtiynGWjuYuUVpGfncZiqZ/jFv1HvzdmNad6wMDhoh2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYOtCiC6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718639739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qmb8gUny6Zpgr7K8KEYWVXXhXU3OWlH3oKm/5lLTDS8=;
	b=VYOtCiC6Xdvf7HBnYxuRDefoT452YELIMjfFM4x7tkk7GoiUVmo1z4tlqhFf5kIeHvfZt2
	go8mLY6nmDhIAeVDFecF8WkRBYhNAS7mLPbEK6YJcX2k8CplBZeW8NL6OuHa6UIkKky56I
	gFX5Sc10T2dU8i+aSgBt/N0SmrGHY5A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-V2ezrCppPzmEj6t26K4eog-1; Mon, 17 Jun 2024 11:55:37 -0400
X-MC-Unique: V2ezrCppPzmEj6t26K4eog-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f1f29ccefso2407652f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 08:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718639736; x=1719244536;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmb8gUny6Zpgr7K8KEYWVXXhXU3OWlH3oKm/5lLTDS8=;
        b=EdjJNLbLnmh9WLSwUBZqbRHubAyeYaT3dk8H3JIz7msNIaN3//LMz0DDXeTJsN5tQX
         mlbefEIkQwWopzIAZ/Z1EjQ85pk3RHMVlgx0+QYJbM1ys+HahOJSST4OG4tJNYQZzaHJ
         tNvK4CJhxgHOKyuRHVA6Dcw72gv/Gs4wjyixPWNtBIhl0hYPT8+tsw0uxPGA67CembiP
         MUP+25jU82PzjFTg/gPCOxDA4RvqIrEPpu8pUyDhtePbmE4LNGZ+nZJmrvUGemppn64j
         ZGKPGBYvZCebREpUdRoGpOKfwFB4Zi+1nBDb63O32jj5TaW5hEg8P3vhmVMnqY8s/KrR
         GqrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXlIihDCGOQ1y5sELGLNckoec/P5VRWNtLLEewYM1RlPIAMiYpU4BkqQZafFjMPHJN31nSe445vL5PUDNZp1Coos9BcLxjvlEZYcO1
X-Gm-Message-State: AOJu0YwKhGlg2qnoLoZbGHi/Z11DnGT5Ki3THw/viOM0Pm6pmkUUFHrS
	rygYHnCfr0+0l9CgIHPQTYAWL11IP6HlD3mLXDHf+No4WIZ9cZbWdN6RGsLcIKY3sRRq+5XD9K7
	b387Bhsge8vddAPyfe1BIMPUGyHEjQQCr/i4C8EtRTwU4XeB4bN1YNgWIlrtKhQ==
X-Received: by 2002:a05:600c:4ed2:b0:421:7983:f1c4 with SMTP id 5b1f17b1804b1-42304822952mr78837505e9.6.1718639735982;
        Mon, 17 Jun 2024 08:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG2HBjQR/zaDHDGvKUJDd9tDwyIlWmvB+O3V20u9Yfc0HFIdhjMf6sutXTwVwI4ehzNmpWbg==
X-Received: by 2002:a05:600c:4ed2:b0:421:7983:f1c4 with SMTP id 5b1f17b1804b1-42304822952mr78837335e9.6.1718639735666;
        Mon, 17 Jun 2024 08:55:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33bdasm164871085e9.8.2024.06.17.08.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 08:55:35 -0700 (PDT)
Message-ID: <a61d9781-7c6e-46b8-ab1b-cf4fc1c76ba3@redhat.com>
Date: Mon, 17 Jun 2024 17:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/nouveau: Use kmemdup_array() instead of kmemdup()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Karol Herbst <kherbst@redhat.com>
References: <a3e8cecc-77dd-4a4a-bb12-c1d6759d3efb@moroto.mountain>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <a3e8cecc-77dd-4a4a-bb12-c1d6759d3efb@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 11:33, Dan Carpenter wrote:
> Use kmemdup_array() because we're allocating an array.
> 
> The main difference between kmemdup() and kmemdup_array() is that the
> kmemdup_array() function has integer overflow checking built it.  The
> "args->in_sync.count" variable is a u32 so integer overflows would only
> be a concern on 32bit systems.  Fortunately, however, the u_memcpya()
> function has integer overflow checking which means that it is not an
> issue.
> 
> Still using kmemdup_array() is more appropriate and makes auditing the
> code easier.

Indeed, we shouldn't rely on the previous check here, good catch.

> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/gpu/drm/nouveau/nouveau_sched.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_sched.c b/drivers/gpu/drm/nouveau/nouveau_sched.c
> index 32fa2e273965..53d8b0584a56 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sched.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_sched.c
> @@ -45,10 +45,10 @@ nouveau_job_init(struct nouveau_job *job,
>   		if (job->sync)
>   			return -EINVAL;
>   
> -		job->in_sync.data = kmemdup(args->in_sync.s,
> -					 sizeof(*args->in_sync.s) *
> -					 args->in_sync.count,
> -					 GFP_KERNEL);
> +		job->in_sync.data = kmemdup_array(args->in_sync.s,
> +					args->in_sync.count,
> +					sizeof(*args->in_sync.s),
> +					GFP_KERNEL);
>   		if (!job->in_sync.data)
>   			return -ENOMEM;

Not sure if this is what we want for kmemdup_array(). It just saturates the
size. This doesn't prevent accessing the array out of bounds later on. I mean,
it's rather unlikely to get such a huge amount of physically contiguous memory
anyways, but wouldn't it be cleaner to let kmemdup_array() return
ERR_PTR(-EOVERFLOW) on overflow, just like memdup_array_user()[1]?

AFAICS, there's just two users of kmemdup_array(), hence it should be an easy
change. :-)

[1] https://elixir.bootlin.com/linux/latest/source/include/linux/string.h#L30

>   	}
> @@ -60,10 +60,10 @@ nouveau_job_init(struct nouveau_job *job,
>   			goto err_free_in_sync;
>   		}
>   
> -		job->out_sync.data = kmemdup(args->out_sync.s,
> -					  sizeof(*args->out_sync.s) *
> -					  args->out_sync.count,
> -					  GFP_KERNEL);
> +		job->out_sync.data = kmemdup_array(args->out_sync.s,
> +					args->out_sync.count,
> +					sizeof(*args->out_sync.s),
> +					GFP_KERNEL);
>   		if (!job->out_sync.data) {
>   			ret = -ENOMEM;
>   			goto err_free_in_sync;


