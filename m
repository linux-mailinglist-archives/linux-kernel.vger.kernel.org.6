Return-Path: <linux-kernel+bounces-351310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BD8990F93
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B62F1C22117
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B6E1DDC21;
	Fri,  4 Oct 2024 19:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UZXY4FR1"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA941DDC02
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728069101; cv=none; b=O16+zyMk2IZO2QhESOdkFCHDeAEVFDiBTpDgOnXJ6gSoWS10pKIce1X7ngMak+QmaNawmbZCEi/0jJPMpRhdVu7Sp3VxraoIzcA4Nx4vE2hFv8hRV+vMkIt/FRJbJkcjLMDDG1No2oDyOJbJ7DzaWA6AuoKKO+qYeMQ3DoRLTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728069101; c=relaxed/simple;
	bh=uYPo+e+mTCUcpd9n3QJrV7jvRJEDbjFR9XhK7iRCEN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DURJPibQZU93DpZy7ANmrfX61H7RZ9Np6Xj3C3+ZIExc98y1C+DmOlPkvvWD158+++j/DIZNZba4zTS9eB17d8g1cDuPRwNmStq2mSx7OrOpU+f6CFI5zsMEIypiwXu0n4JxKysXCicWp8piowQHc6w6ZjPQtmx9qkh+TIn1qi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UZXY4FR1; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3525ba6aaso8155245ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728069098; x=1728673898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7DGtjofFLon4QI6Cl3zgL4lNfBVb4VEqAk2u1rUhYQc=;
        b=UZXY4FR1cj8WyoKOUD1Zyy3a1+vbya2w8vz7EeK/S8lypd1gVIElgYiamA6nT5ngIO
         3Myo6umgMD6BA6SV+lTkN9F08rH2J5vhg2K8kGk0Fl8A0IGrmyWTkzbQwPJjGS1nMXB0
         fp+kAjbuMksX9qPInylIRbNcQmMvD0d7hADS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728069098; x=1728673898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7DGtjofFLon4QI6Cl3zgL4lNfBVb4VEqAk2u1rUhYQc=;
        b=Z/MAcmVbfwEfzWZXsuDucqad2hQM68DBqvdwwS4ub7vno5geLm5nCe93cyXai/JS50
         oVkRHoHTae2sA10HlrCV3UaKo8qY03nGFi9svPaNo/K4Zbq1Upf9iBr+xXmYZcEK4shg
         60Dd4tWqnAD9hvn32k1yy93aIEcFvc+azdaqhB0jjVP+NSwPWyFwJFUxm9a0S9O9bocp
         A2YmBjaqMO5P3b7pf8uEShiD67qc1vgRPdemJ0U3oK7//48goV8Bvsix9UHvoETjKiGw
         5gtCtMuJZMpki+xaluTeqv0xfHdB7VaU+Qhn0mthEHvjvffrIAXTpicOGcm+IJTB9K1s
         sNGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVo7XDxytJiTdMKfWx+zzGnscblLud8I716MozwQ3dFRlrOc1cp2LkwJxt7o+EVtmMR48pvCqmMzbpE7Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOH+cD9sfcVLgFu7iM4qZIo/RsgmR4lbP9cyXecJH0J58jhW3
	Q4iGWzfhVMf9CW1gnyqio528RDEKqxKlMshvWk/PlPS0a6JDU40dWnOZ8Tld8To=
X-Google-Smtp-Source: AGHT+IFNSzR4jqR8T4dR5f3ZGvvXjjrep3zTEoQa8V0+74iUAXaRYs9EdKpIP63gWvQZvCpNMFctZg==
X-Received: by 2002:a05:6e02:12e5:b0:3a1:d180:15b4 with SMTP id e9e14a558f8ab-3a375bd2fb8mr34757425ab.23.1728069098538;
        Fri, 04 Oct 2024 12:11:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7e7c23sm980315ab.4.2024.10.04.12.11.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 12:11:37 -0700 (PDT)
Message-ID: <532edd71-93c3-4d90-ac98-9763993807fa@linuxfoundation.org>
Date: Fri, 4 Oct 2024 13:11:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/atmel_hlcdc: Fix uninitialized variable
To: Advait Dhamorikar <advaitdhamorikar@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, anupnewsmail@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241004150849.70883-1-advaitdhamorikar@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241004150849.70883-1-advaitdhamorikar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 09:08, Advait Dhamorikar wrote:
> atmel_hlcdc_plane_update_buffers: may use an uninitialized
> sr variable when the if condition remains unsatisfied
> 

As mentioned in my response to another one of your patches,
include how you found the problem in the change log.

> Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
> ---
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 4a7ba0918eca..4150c4d0b4f2 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -559,7 +559,7 @@ static void atmel_hlcdc_plane_update_buffers(struct atmel_hlcdc_plane *plane,
>   	const struct atmel_hlcdc_layer_desc *desc = plane->layer.desc;
>   	struct atmel_hlcdc_dc *dc = plane->base.dev->dev_private;
>   	struct drm_framebuffer *fb = state->base.fb;
> -	u32 sr;
> +	u32 sr = 0;
  
>   	int i;
>   
>   	if (!dc->desc->is_xlcdc)

sr could be used uninitialized in the for loop, !dc->desc->is_xlcdc
case. However, is 0 the right initialization for this value?

thanks,
-- Shuah

