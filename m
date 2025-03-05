Return-Path: <linux-kernel+bounces-546416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC1A4FA75
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6701891B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1261FBCB4;
	Wed,  5 Mar 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lusB/yBV"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67219204F6B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167790; cv=none; b=MGf1GQvbOcxHeDHGJEWUYCERq3gqL6iDJRqKDb3fr34sKnv1gUHXwbjCbaVptPCj7tbRqki68O+6k8iXny4dWgbbpiq6ajua0F61pKS5Buua8XznX5WqbVb6KQ25CxPl9ddGQhrLmu+qhbDpykb0y7Nv2nsUmELjDMCe7AqKRR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167790; c=relaxed/simple;
	bh=PVtm/IxvydhmBRd5q6LUI3L5TnOE7L+pdnpkmkDJ9po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScMtB9RM+iFUOgkgdM9nqT0jiW4VENegLiIcsDJ+6adlvV8B2t6QTZvIXo2Ay67V6zZGM5nbVU7+Ed5CUi1dRq5PFWsHsl0cevaOoyfe2Ne7A5bHoyk82UAfkgGPyUiA0Fj2NwgtC9NjYkVVfhGUghfMdfSt5ikoqrurru8eEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lusB/yBV; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso399314f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741167786; x=1741772586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcLEo9C7d754YdOjFOtxhhTyuVlShOS4Gvepo6yn57I=;
        b=lusB/yBVYF3ivkT8YeQlZU3vnd3VFVJxIha5OGu2Q1vVGgaKGZpEVIADsbix+eAdGL
         prg1+4rEmKaxZ3L7aLl8GNEjtdUBgwS9PFW/843nNuZjc1Ncoou/Tv22SB6hE1QiYTYT
         lzZY+3O49bVVXkg34TbXSdP2Nxr9BJtbcNQgy+D5IoQEoDGv48/Si71XN+EwOP+YoxkF
         bQuFxchUCgF8uL9WwDy2LKfS+JKQaa79FO9b2gmpxpUrNG1Q8kr4TJh6uxjaMVpqcYem
         yEUuyi6MDY5lt+6bktNLPIeLqJT2g4tCnD7IUibRotAaEhWtGXfaj9fTWtecVCvoIZ/t
         t5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167786; x=1741772586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hcLEo9C7d754YdOjFOtxhhTyuVlShOS4Gvepo6yn57I=;
        b=IE7iVZqTJemkVJfDaEs1kLIVSIMiMAGLDRP9eWIPvuwkEncuuAsBnuCgrPs1K4w4La
         234yI/dzxpkcUV5V2OEf7Ir5UrH9rCxqkyZNXdLxh8o/c7Bck8clKozbbsz6ghbhoADQ
         InoY5m8PNfKySQ8Ck5IIoMAl1z1yEDLWNC0uJ6L1bJZ9P61eIBTqUK/sPPxFP9cpwsL9
         daMDY+7Nl56FmVgdNBHyVYgtUw16qOSU80fQlzZ9vr0fcIXjt0XRaDOmd6aOsNsr7CyJ
         +UAQpordC0ubp6RgQDm1nEgpD4tUT0lF6y0kzThy2i7KDzcPu5CGtQpKlSevZsb4yHvd
         qiww==
X-Forwarded-Encrypted: i=1; AJvYcCWe2ah2y0QMZ6HZYjo/KjRjQKnSlhS4F1h0RCZFqxDF1Ag4tGQGIH+N+vvTQG8o/WCCiSi4jdEmyj3bBcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXpCVgab4RoFCOx2knK3kyBKwQG45zv5NMqU+c+bnXvn9QDMY9
	NAwWl49kc6hCHnbcEY7l2dr+1CDBiMt1TgwYwZniaZ36qGpTwQe+fsNktm7BCXFx2vwH5kERqzZ
	vVME=
X-Gm-Gg: ASbGncuc+SxMQKCtBZNtcIYbEgF1etCEPsqjO8Ug1zO56BqGUPeNeXwTZNqVv4nbXYL
	8OGzUyJgWmUE5V8B2xrxkZJDasN7KBZfmiZFqnR0UOKlYkWTQiceuscLLXB2pueNjwY6uOtUJzE
	qv7Euua2ZoXVzZi6/UzyqDwgUOE/vBK5zuJtO17B8qR+mNTaVwM8Uaow7HFenZ9cj7ybRoyOO+6
	Dr6Y/r710sUIyDvY5NGComHSTzleL4vEaWWD1cq5Z49+48cOOLYuJts1tCs68ohTczrhE+mL67E
	/qz0zy7tQ6VxDna0Opj8WJa2Rq+iZ/q/+neZCSt6X0FnmGdLAI9qGzqD9UFWhRHNhoL58AwTqsy
	gPEIz5H6O
X-Google-Smtp-Source: AGHT+IEA9x9eIpHEguaymJmRv4i84fzwh2x+uUOGi7ki/p8NE6SyUnBAby+69obVpJEOIv6/ArtGig==
X-Received: by 2002:a5d:64e8:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-391154af01cmr5719740f8f.0.1741167786548;
        Wed, 05 Mar 2025 01:43:06 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43bd435c6f4sm11811915e9.34.2025.03.05.01.43.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 01:43:06 -0800 (PST)
Message-ID: <c1e8abec-680c-451d-b5df-f687291aa413@linaro.org>
Date: Wed, 5 Mar 2025 10:43:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: add module build support
To: Guillaume La Roque <glaroque@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 mkorpershoek@baylibre.com, linux-kernel@vger.kernel.org,
 Linux PM mailing list <linux-pm@vger.kernel.org>
References: <20250220-timer-dm-v1-1-64b6dab5f4a5@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250220-timer-dm-v1-1-64b6dab5f4a5@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/02/2025 15:31, Guillaume La Roque wrote:
> Add missing MODULE_LICENSE variable and convert bool to tristate in
> Kconfig to be able to build driver in module.
> 
> By default this driver was set at y when ARCH_K3=y.
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
> Enable possibility to build in module timer-ti-dm driver needed in
> Android context and Android Generic Kernel Image support.
> 
> I know any other clicksource driver support module build but i do test on AM62X and
> AM62P EVM board and i able to use this driver and test it with PWM.
> 
> By default this driver will be always enable in bultin when ARCH_K3=y so
> no impact for other TI SoC.
> ---

Thomas, Guillaume

there are several requests to convert the built-in timers code into 
modules since Android is converted to a GKI.

I have some concerns about this kind of changes:

  * the core code may not be prepared for that, so loading / unloading 
the modules with active timers may result into some issues

  * it may end up with some interactions with cpuidle at boot time and 
the broadcast timer

  * the timekeeping may do jump in the past [if and] when switching the 
clocksource

  * the GKI approach is to have an update for the 'mainline' kernel and 
let the different SoC vendors deal with their drivers. I'm afraid this 
will prevent driver fixes to be carry on upstream because they will stay 
in the OoT kernels

For all these reasons, I don't think we can take the module change as is 
without figuring out the three first technical reasons (the last one is 
from an upstream maintainer POV)

Thoughts?

Thanks

   -- Daniel




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

