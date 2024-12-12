Return-Path: <linux-kernel+bounces-443978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E75B9EFE85
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9B1286A48
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B7F1D9337;
	Thu, 12 Dec 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOrHtcwD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB491CEAAC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039673; cv=none; b=sr+TqB9Vybcrb8vWAtJU/0jzQDxV5+qAj+NO/x3L3d0WBSqHnA232U2XFNPO6Wzgo+znVdXBgJxN57l7VtP1V17CKbLwdkCH14WZQjpvGMgzGDYDQ7MauUwdOlVWOj6ybHujCeChkANNzm708OheA7efF+VxQ0WbM+Xra+SPP80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039673; c=relaxed/simple;
	bh=KLUMnDALJvPzrK0jFzagmELmAzq2v7RBM9s3q3lSrhE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R462FfkIXxuJQoL/n2AKbc1hwuDnrjF5dzkl3EtRFPGmyEDbBTq7sfy9ywqHhSR4BFEAcc1QGLtXBXHmzyDCBcK015/hA1yOzQWbdlHuGLw9BdgfdfjWEChz0MjIsaidzRgaC8heum+TEl61Qw9LXT8F9lzBN2i9YWJxztJEbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOrHtcwD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734039669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tR7wzsXXxQ4eqiScyh3B9fZhywf3LiZTde7cxkKtp08=;
	b=dOrHtcwD0+HxSVvq+t5K0Wndn5wcnPBrETcr/BzTkeThricMKzrHHOQa8wapVG3Xl6/QrY
	SqDjCDZEPJBBhC/7eLWKdzIs4M6LlEJ6zTdE/EsutcXVNPNePxP6RjuZ0oesvu8YEFxXzQ
	mpR/tZlH72aPzxWBYJVSL/sJ0p6+0lo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-e18FVyGBP8O17dsLaRbraQ-1; Thu, 12 Dec 2024 16:41:08 -0500
X-MC-Unique: e18FVyGBP8O17dsLaRbraQ-1
X-Mimecast-MFC-AGG-ID: e18FVyGBP8O17dsLaRbraQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so6583325e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039667; x=1734644467;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tR7wzsXXxQ4eqiScyh3B9fZhywf3LiZTde7cxkKtp08=;
        b=KIWUrz5VzUpqUl3smRnBy/LPaf7unuccIeqKxNGznCKFBL30GZCa/oEaPxHkIcEFLN
         SJPILFYbWf3JLwaZUzgNVx7npK1IJqQXvwxhmVqn+w7OudFlQMhwIUm+1bnqT50UcuaX
         3iN6tClHbPLbQUnTLu6HRAjknLSlCxITfPdlJ2lsDnqGbTm+PyuqwiLgB9cbUNmpR/Rc
         wv6OJj8gSAVB/HnIgpDky3oMMbKApRDVkWPO7JCAArQDCVNpBRHkNiPOkB07/hbMcrai
         I2fKji32wgB1DTlAej0kKS8NrkoaLDZtWD371esmjwLuWHuaAbBtWWa4ekl6XUNHUn3M
         IYXw==
X-Forwarded-Encrypted: i=1; AJvYcCXDe1E+ssuVQXpR3ZUj/Jc2tY5Z8fBubhHoya7cwofREQlCqvKULGecXlxqNiAou3fYgKr7v+jJC0zjJUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTC0+gMNWdedHBJGJ6TpIHHEK/KJdBwjc26RJvOfPcAKSIt8C1
	KaAiNeMATay5KumqhBKDwF451ZnFGTtTtkaoSQzEtVlMODaaLLmZvwoET8CQWpCKZPejWV8JrG4
	Oua7Yop4RJBKMhXx9jkudVyOmwc1mhkG0bj47DvU8ibogCpZkmvH9KnI9xe6wRQ==
X-Gm-Gg: ASbGnctm+jl85YJvaoQ4ux4SpJY1+ywz+Qfy3jBWRzTTnUDbOZwyfi9pnKiN//+Ys+v
	gTDT4Lwn4cqMgDt/ohP4wjsUB6jbytbx6nF8oSnzmHfqLzLMMdY5wvldRMLSxWeTuvbxVMKqLjh
	+cmPGYGrnwCIoZ7KX4H7j+HEZyYFxRr2HumQ0fGoKxfAFOHC5XL6xNl+LoEDDnPPC+eBOuJ1BSP
	u1oWTYzm2HaKudjISGyNMf1wWo2LURMhoDpaABxvXDQ9zh7aZbbB8NU0n1rUILH+yj+5axTKuaG
	4jrzBXwfsPnJyk/scG4A
X-Received: by 2002:a05:600c:3d0f:b0:434:f609:1afa with SMTP id 5b1f17b1804b1-4362aa34d42mr1254615e9.4.1734039667081;
        Thu, 12 Dec 2024 13:41:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBEIjlQk7gBoLaQJcKagFV7fcub94Ft/J5oueYwjSMFuuqAh1fVbjgbwpxvCN3dRBCSH43Ng==
X-Received: by 2002:a05:600c:3d0f:b0:434:f609:1afa with SMTP id 5b1f17b1804b1-4362aa34d42mr1254445e9.4.1734039666732;
        Thu, 12 Dec 2024 13:41:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4361ec87bc3sm41655335e9.1.2024.12.12.13.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 13:41:05 -0800 (PST)
Message-ID: <24e1c00a-b988-4b8b-bdf9-b30248070f40@redhat.com>
Date: Thu, 12 Dec 2024 22:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/log: select CONFIG_FONT_SUPPORT
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Arnd Bergmann <arnd@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Ogness <john.ogness@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Andreas Larsson <andreas@gaisler.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241212154003.1313437-1-arnd@kernel.org>
 <eaffbf5e-ecb0-4aa3-8d05-da090494f8c3@redhat.com>
Content-Language: en-US, fr
In-Reply-To: <eaffbf5e-ecb0-4aa3-8d05-da090494f8c3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/12/2024 17:37, Jocelyn Falempe wrote:
> On 12/12/2024 16:39, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Without fonts, this fails to link:
>>
>> drivers/gpu/drm/clients/drm_log.o: in function `drm_log_init_client':
>> drm_log.c:(.text+0x3d4): undefined reference to `get_default_font'
>>
>> Select this, like the other users do.
> 
> Thanks for the fix, I'm sorry I missed that dependency.
> 
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

I just pushed it to drm-misc-next, as it can break the build.

Best regards,

-- 

Jocelyn

> 
>>
>> Fixes: f7b42442c4ac ("drm/log: Introduce a new boot logger to draw the 
>> kmsg on the screen")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/gpu/drm/clients/Kconfig | 1 +
>>   lib/fonts/Kconfig               | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/ 
>> clients/Kconfig
>> index c18decc90200..7b81fd0f4cae 100644
>> --- a/drivers/gpu/drm/clients/Kconfig
>> +++ b/drivers/gpu/drm/clients/Kconfig
>> @@ -77,6 +77,7 @@ config DRM_CLIENT_LOG
>>       select DRM_CLIENT
>>       select DRM_CLIENT_SETUP
>>       select DRM_DRAW
>> +    select FONT_SUPPORT
>>       help
>>         This enable a drm logger, that will print the kernel messages 
>> to the
>>         screen until the userspace is ready to take over.
>> diff --git a/lib/fonts/Kconfig b/lib/fonts/Kconfig
>> index 3ac26bdbc3ff..ae59b5b4e225 100644
>> --- a/lib/fonts/Kconfig
>> +++ b/lib/fonts/Kconfig
>> @@ -10,7 +10,7 @@ if FONT_SUPPORT
>>   config FONTS
>>       bool "Select compiled-in fonts"
>> -    depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC
>> +    depends on FRAMEBUFFER_CONSOLE || STI_CONSOLE || DRM_PANIC || 
>> DRM_CLIENT_LOG
>>       help
>>         Say Y here if you would like to use fonts other than the default
>>         your frame buffer console usually use.
> 


