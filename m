Return-Path: <linux-kernel+bounces-442925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE419EE418
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F271631A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B11210F57;
	Thu, 12 Dec 2024 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoNrv3kT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6E12101A3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999286; cv=none; b=IZyCy4A/rIp/tTs7bOOxyHWEDUW0jevjJGfBfwan2+WYUuq9ZRpSkFQivTMdZDAzs9g6xtibEa0VxoMlzW+DisYf5tMLmNz2gg6sD45ImhCx/zqjvHpz8VcU0k6lLua20VQxBzoQo27sy8K6FkF6UxwN8h24QXox8cX9JNCQGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999286; c=relaxed/simple;
	bh=C5aJ/cCEhq5/s8GG03LZ46SonuUtCC5hmJzefRQuci8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9ejL6i3eB1QD5qU/+IxdMhl18N1wCTKwxggrID4U/EmgF+dTWIVTjrCx4bbmUnVq1H6UQ2uoD0VfAXn6Syb25R17RBbfEok9OdRsfzDb6Hrg4ejduIRkTZIejOshHEfWr8mIIgn7JsE0kyUkuMk7fbO4VHkqPPvtlMkgqEtVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoNrv3kT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733999283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVaq2qSCQwPtfs8iwrJJIk50sgodNy897IFKHraNxV0=;
	b=eoNrv3kTdyGCALLyubC7sVES50C1ca68qHvpX/blnr1ujX8Fb+Nmd27KhJ2hMy1i5b1/eu
	tP1a7i+yWJ1HT5vf7Kcy+5u2HbWF3yQ0qnHAja1QDdMm5RdA5MMnzvJJh+LTtrLJSmCuIW
	yf3AEyFt7qBAm5wWfAqrBwxVSwp0Z4I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-B0z29henPqONoWbDPcYPlg-1; Thu, 12 Dec 2024 05:28:02 -0500
X-MC-Unique: B0z29henPqONoWbDPcYPlg-1
X-Mimecast-MFC-AGG-ID: B0z29henPqONoWbDPcYPlg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-436225d4389so4243555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999281; x=1734604081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVaq2qSCQwPtfs8iwrJJIk50sgodNy897IFKHraNxV0=;
        b=McOfygHmuc1Z+QQsuCmcHgdL7NV/nDdbmVJBWWPHj4/0kSDDjJfO4gXEpkdXKljB5P
         zRJwCWtl9NtpWP8cUTgFNYNYCEmdTgmX3f2DrpduW7Kke8lHNA/nkaTpWGRc5wcH1yoO
         jlADAhhPwDVuAPDUpfm4cV0G+EfmgPiE7cYjJ38MlJcdV6Bh1nKs9Rm3amofV5Dv+xpg
         3XLIXq6GbjBInIXwJreF5Xq8PRTwB4G1yPrMRSfhPj1cFO4S5wljOxOubig6rzyKeHSQ
         fPSTBgyRZJGv1Um8VrqYSex+ovmdzbM5RMitjEnEX8Uj0VScAVjTwubJpkvlFcI8M6eT
         oXSg==
X-Forwarded-Encrypted: i=1; AJvYcCUku+50rRPGDw9U0wjLXracWWdU1I/7tNA2IctRN2s9RjvyJDhsdbQwZl8JztIcFhAgHubtLE2h3j7XHPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1uVQ6arEF3rVuyBSTWTrxA0faEA66hW1++E8PmX75xtlqUEjY
	HI+jgYC4RKMH5w6zU9GCHfLAq+DVly48sEhsXZX/6xvA9JBmgWpBAXMZFfDVZJ3on+HPuq8kqdM
	XYUkPfiiPgPiol178RV9cOeLb5t1fTi2+ShxsjlXRplDehSVl7XYDK/NzIzhlGw==
X-Gm-Gg: ASbGncvZbuPnHcktkMeKqRy24umqqg54WpDSkN/bj0iSSozvBmS09cDK6xjrUT9or41
	kBxCQ5c2ulLocqbvvOouZPyB/ZHoJDEOwN2rTn+wYmFm1DVPEshpMC3fBFPTl8FZsV+DjdO4OgA
	yLDB64gqYz8uf6wjePwWi9ZjVRMuXxUy8aA4b/5MLZxL6j8dKZsmbbE3CBwedmvdv9qdvHFJHKf
	6Cw1lYRdFBTgHjYWrHt9euXuv/I+AU5OCnCjanE9oH4SusSuakO0EJfyg8Ip/RfRvGtoCxU3/2X
	Bi622CkJgeF33XD2j4G5
X-Received: by 2002:a05:600c:1f13:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-43622e1d89fmr17568225e9.0.1733999281034;
        Thu, 12 Dec 2024 02:28:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJgRY5o2EC5V/rXg0TUe4GYsezYBjI8CpktJ+KXMUbQXgvlQPxsTnXuvrx2+8Cjx8dMTUWOQ==
X-Received: by 2002:a05:600c:1f13:b0:434:92f8:54a8 with SMTP id 5b1f17b1804b1-43622e1d89fmr17568045e9.0.1733999280683;
        Thu, 12 Dec 2024 02:28:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b7d46sm12216165e9.35.2024.12.12.02.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 02:28:00 -0800 (PST)
Message-ID: <4dccaf7d-09b1-49c6-a9de-ec327eafaf13@redhat.com>
Date: Thu, 12 Dec 2024 11:27:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/client: Fix drm client endless Kconfig loop
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
 bluescreen_avenger@verizon.net, Caleb Connolly <caleb.connolly@linaro.org>,
 Petr Mladek <pmladek@suse.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>
References: <20241212091153.1592096-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241212091153.1592096-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 10:11, Jocelyn Falempe wrote:
> if DRM_CLIENT_SELECTION is enabled, and none of the client is, the
> "Default DRM Client" choice is empty, and this makes Kconfig goes
> into an infinite loop of:
> 
>    Default DRM Client
>    choice[1-0?]: 0
>    Default DRM Client
>    choice[1-0?]: 0
>    Default DRM Client
>    choice[1-0?]: 0
>    ....
> 
> So only allow the choice if at least one of the client is selected.

I've pushed it to drm-misc-next, endless Kconfig loop is not fun for CI.

Best regards,

-- 

Jocelyn

> 
> Fixes: f7b42442c4ac ("drm/log: Introduce a new boot logger to draw the kmsg on the screen")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> Tested-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/gpu/drm/clients/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
> index c18decc90200..82a7d4e584dd 100644
> --- a/drivers/gpu/drm/clients/Kconfig
> +++ b/drivers/gpu/drm/clients/Kconfig
> @@ -87,6 +87,7 @@ config DRM_CLIENT_LOG
>   choice
>   	prompt "Default DRM Client"
>   	depends on DRM_CLIENT_SELECTION
> +	depends on DRM_FBDEV_EMULATION || DRM_CLIENT_LOG
>   	default DRM_CLIENT_DEFAULT_FBDEV
>   	help
>   	  Selects the default drm client.
> 
> base-commit: 19851fa2ba9824bede16f55234f63d9423897c3d


