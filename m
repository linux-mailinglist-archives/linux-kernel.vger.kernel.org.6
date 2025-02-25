Return-Path: <linux-kernel+bounces-531880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A61A4462D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E72170840
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B1D19342E;
	Tue, 25 Feb 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AGPOuvXK"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C617E015
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501193; cv=none; b=idQFx262VvhPhO8Fqy7IHFLPeRJSrdHZzbE+bHAHX5DAKUI77twLElPqiRfqB5BDACHOq+cXxeI56jpu6ZQrQnzA4O4nyxmbSBRd0x33hq9KSZPmwJ0pWqiptOUOTpRWpkufUhpi9WhNk42phaURaoyLfFckoakY6+Vf8BXK/Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501193; c=relaxed/simple;
	bh=hGWSqIgg/rBZbqcfD2ICgQjcgKFhcZPXUXCI6ZsG+70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sH72WBNZkvbcgKWWuoH4bSGfYAwD5J4n9sPeSC5npTCorKQf3yK9z6+zGDm7t+/h17QQGu3dbyVjUsDG/fEUq/OW/Kf+JXuFpIqAtP4di5lvLjMrMenKHbMuxCJTzYa3VHjy8/TtcE7qKlgqsstQtUWNRwuzKTlr56E5+B2mmeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AGPOuvXK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43998deed24so55523325e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1740501190; x=1741105990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESHe5tOObnpKqqZ922yCUdfxuhB0YSTVuyOcdcMSVyA=;
        b=AGPOuvXKLC+9ws0AMGpZq8o/5jISLMMuUYac2tZx/ig+Mu3vvseZnOJ1S2G55vG56F
         5cto8FvQJskn28Mgefi6F44w1SBFzmQ5Dxk/rrfPLsOwf23ZPvt3E7NSr/1WqskkStlV
         xHN5p92E66aRGC6rfxWrEIFDbq9BfB6NmRN/4VJPSQqK0vWAhoJrVZyesrg+Ey0Ftwlj
         MJbmXYpyaD2tz3YVdoqPJ7VKt8XFHLMjT3GkDQxvDRtxEUCyI57a+AqeiglpJKJr+p7K
         p5TtJOG/tg96tUsa7z9ZL9M3No8YBCCTG+PuD1s1tc/QgG5+afhFp0sSasIzlxdoXeRs
         yuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501190; x=1741105990;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESHe5tOObnpKqqZ922yCUdfxuhB0YSTVuyOcdcMSVyA=;
        b=uzJKy8rs8AU1YJ0lM66hfrr/FSpbmH2p9yxppgS5Ad0DRcwo+9uHujScw3vh66oR8p
         TDrCFqfve902LcB2WyJfgyQ8HnE45ju8Q7jUfsCLZCtNdJZo0rXuiFZWZEcG53kxLjxG
         AakGtxlkVTzj87uyUGfMfP+0NP4MaZQ78f9Bc7LmmXZgjkPVaHwiWwbu5/TxplrYd/5Y
         evc28VLhl3CjwhTJdT5Wbe2l0NMgZIszIYqTxkwHxTjz/4TqWMD12CCjJYub4eMbcyk9
         /BrLggmfTA0HnkZIH8zGpEmDIHTffUnx3K8fMPBERdQZCp18FLMomIHwlXP/gQP93tR+
         j+og==
X-Forwarded-Encrypted: i=1; AJvYcCXn/N1/PJghhB+a/FNnkIBMs7GzEb+o4uMm4C88aFrd9ZlAI/Vw32zcQCWx1dRCpQ0GBl+17BEQ6Ye0oTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLZEOCYDn9daGexqG0GHSTxO7Q7H7P86B6iDh/PKyS2HCVYSBt
	1WFVH6Pb2q569ow7Qb5iuqbqOnKq7r2grQB0hcRjiQVo9pa3ZJEHvLra8oJPOKQ=
X-Gm-Gg: ASbGncvruomWOg3HWU7IjNR2hvuOKtE3b/NeGdhym/p5KrldXLiMVuQIYb8OOZtQQuN
	+xC/dXncF5tugWaQehepCGZJfyxnmg8vETMXQzEPZfzD4IIOKLp5rEhJr3vm6sWWMYyvW+FeEG2
	iajiHF3SbKd95uhia7qTl9WIUWPg37nqo/W85IF5ZMyRsICAQI0L/KF9nbLJOinYQkg6gx+mq7l
	u8GZlZ/RyvdYK7dgIbLda1/7kp8eGSJH9O2oS9C5OEclzBrpFS/HWOsO9Pv4Py16ilh1CjzKQ0D
	sSxvaW94vF4eTRHPAfJhrQfSIiBPwIYrRg==
X-Google-Smtp-Source: AGHT+IH8putBj58H1Qc2/Pc5IYBftrUEfWyIiIH/BzccCEeS7d12VbdeMMF1dKqYrd30iJtTHLg91Q==
X-Received: by 2002:a05:600c:350a:b0:439:9b82:d6b2 with SMTP id 5b1f17b1804b1-439aeb34f86mr181448335e9.16.1740501189564;
        Tue, 25 Feb 2025 08:33:09 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab153a7bcsm31838645e9.13.2025.02.25.08.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:33:09 -0800 (PST)
Message-ID: <09eafe54-c262-4db4-b11d-0644a1f90a14@tuxon.dev>
Date: Tue, 25 Feb 2025 18:33:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add System Components for Microchip SAMA7D65 SoC
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, vkoul@kernel.org, wim@linux-watchdog.org,
 linux@roeck-us.net
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <cover.1739555984.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <cover.1739555984.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14.02.2025 20:08, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Ryan Wanner (8):
>   dt-bindings: atmel-sysreg: Add SAMA7D65 Chip ID
>   ARM: at91: Add Support in SoC driver for SAMA7D65

Applied to at91-soc, thanks!

>   ARM: dts: microchip: sama7d65: Add chipID for sama7d65
>   ARM: dts: microchip: sama7d65: Add DMAs to sama7d65 SoC
>   ARM: dts: microchip: sama7d65: Enable DMAs

Applied to at91-dt, thanks!


