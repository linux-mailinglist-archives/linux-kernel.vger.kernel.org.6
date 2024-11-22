Return-Path: <linux-kernel+bounces-418622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BAA9D638A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6976628272E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB541DF978;
	Fri, 22 Nov 2024 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKQbXSMe"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512891DF972;
	Fri, 22 Nov 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297669; cv=none; b=cdLw9kMYCM7jjlRu+8zsuXtxIbaaqgQdoYIOy1b+CzRx4JZe0HodOQeXRfO+cgJypUhoNiLNsZVWEiKLXwJRoiI0ewxmuQfIqtvMEaUTvqygYSVFDEr/swM+Pw9UUOk1gV/pP69EMJlSo/8LPMnk66YDGphZuWjTLriFx/cfrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297669; c=relaxed/simple;
	bh=Du+Neyr/WNcJrPpbWCuDG16ayhTygLRPR+kbur4hjTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAVaROeUlR2Cpal/g4l8aPb27CavXpK1hdNGqLXkmWkkkB3gdrpkOB+D52jmGjBg8AYNUbO7LaLs+ZWQMP3pTL+11TvhwOfaf0vZF8rOEa/0AIfXHg+X0fWnRB+bT4Yymk8+hAartUB35jhV8E43A3gp1TWnVz6ISaFFxlIIq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKQbXSMe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21288ce11d7so20375565ad.2;
        Fri, 22 Nov 2024 09:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732297666; x=1732902466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RozJxbbhHAnxyuf0zMlnjub0R1dzjd+pDVDSVch830c=;
        b=KKQbXSMeTwha/lley64CH2lahYN9Ez875jGlr+q3gn394Z8ktd1g8tLfYj8XoncTQd
         kvGCie7uIliHMQIFtAWF1sgy9sGJI98DMDV2pf6vWkOpESGGXUeG2dhLZdBUwq6wvmh/
         Xo77e3It/WpT5BNsYqVmbZzAbWKsRg0HvZ9qysE7F7nQy5YapbREPXumms6KKLiZVech
         ZBOTDTmmXQ7dXJs1ePXkoDQ5VoHncRgAA/CqEAkv5/CwJuVP85oMgWzIdZkudX4EF4pr
         5bG/eig+qWajVSiXWRtK7yB5LbwEnh4O7AD9jDqKCsbSwlEfMT/+mU09JGceiLOcvY2y
         xUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297666; x=1732902466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RozJxbbhHAnxyuf0zMlnjub0R1dzjd+pDVDSVch830c=;
        b=xLAdQif6mNGroFCo6uYbwORh3uIMYc5glLJF5wtvUF8RknvUJY9Gmsw7Jmbomse8eb
         56H1RXMCt6W6Vaf09xZbJ/BZ4flKlqkUf96Xp4wnkVmASJPG1T2VNlhPZgw8NaFEkcH3
         Xacdxp0Ilo2CwZr7CV3Dr+Kuuy5D6softthqR278d6A1Y8hrIqbZpOZB8pFNTtQ6BNzw
         tvFZ/tjWE4l0MkGDU5KuFIMjrnERrCm9pps/hVh59Y0gZJ5+0ZdD+7UCEL6SXz8K+n67
         0kGQuMLHe9iJ7MjT6xDIblZO59SPQQlAcPTrfWpJcLVV2748VM/Eoas6mEthPERtrdJO
         Wqsg==
X-Forwarded-Encrypted: i=1; AJvYcCXVVa7hTbgt6bJp/3HirWd4rMMdl+NZksGPkBMic+m7RccX0nXj0vg5RMUN4yF6wMOdgbEWir3HrW77eXYW@vger.kernel.org, AJvYcCXZeAE0SssFsCRHrcP/lZKmfug4hMDiMFVPDhYTMC2H99qaM9IjHGOwkVaDj87Pt1LCuFA4DaErKKeI2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI0/JqlbgIfqkds8TPXDyOvm3v8XrhKIofvVH/+4NSdz3kv6Qs
	4gNL1Rxb9Y9lOaQvOndpH06P7j/3URJfrDHACry4ErA6jqcF168r
X-Gm-Gg: ASbGncv/KcTaZhOvqkPprXi+pQxpOpDWqqMWkRqqJfp6dwQ+zKHlutTEkh+XWzyCjbg
	8Bg99ts2VyezgeCEh8Up7QoUS0If6uubI8MqLG2lKVOYoDClHnEtPZhvmFchQCI5z3Epa87Hle9
	jzXgK/MYVDro1UyldFTT4hOomGqP8kU5BMAzagLkaAInuWaNKlXeCEXTkJlh7k+Glf/qcXsxMmE
	9MsZk1+nCc6bMMQcy1IHzW/nY218ubc4Y7bQuB+Y+RSOHsEKEZrMcgSr71bcjE=
X-Google-Smtp-Source: AGHT+IEfK5ryvaugeTTLu3sx6/23KRTihc6Bh63s+mr3xDzzH/z+sTHpO8P3eez+WU5pUzK5G9ChWw==
X-Received: by 2002:a17:902:dac8:b0:211:e686:760 with SMTP id d9443c01a7336-2129f2a53a6mr57737585ad.53.1732297666562;
        Fri, 22 Nov 2024 09:47:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dbfeafdsm18979145ad.143.2024.11.22.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 09:47:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Nov 2024 09:47:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Drop IIO from the title of the Chipcap
 2 hwmon driver
Message-ID: <bd3f8926-4e9b-4323-9cf2-8f2e9ca86298@roeck-us.net>
References: <20241121-chipcap_no_iio-v1-0-6c157848a36f@gmail.com>
 <20241121-chipcap_no_iio-v1-1-6c157848a36f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-chipcap_no_iio-v1-1-6c157848a36f@gmail.com>

On Thu, Nov 21, 2024 at 10:44:55PM +0100, Javier Carrasco wrote:
> The Chipcap 2 driver belongs to hwmon, and not to iio. When at it,
> drop the sensor type description, as that is documented elsewhere.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20df6282d1d2..91936a9ba56f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1226,7 +1226,7 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/rtc/amlogic,a4-rtc.yaml
>  F:	drivers/rtc/rtc-amlogic-a4.c
>  
> -AMPHENOL CHIPCAP 2 HUMIDITY-TEMPERATURE IIO DRIVER
> +AMPHENOL CHIPCAP 2 DRIVER

I am not entirely sure I understand why you want to have
"HUMIDITY-TEMPERATURE" dropped, but then I figured that
you are the driver maintainer and that it should be your call.

Applied.

Guenter

