Return-Path: <linux-kernel+bounces-419642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 483C19D7173
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 14:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76BA4B2DF18
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420DD18BC19;
	Sun, 24 Nov 2024 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HOCOk5UP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755318FDBD
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732453568; cv=none; b=SKv1bHFTwe4IEJQNmd0LNyl1oS3p+VMb/1wH26YE1Fii1Z4rbPZhdNOYG9GPFxuRjHeEFRGMu7zlFMMrGp5nso3gtM/YTqDVZgbTd9QtVE/0TZERBtowIYLFvjm/wxNvnECREZcp0L60ZkMReApy/6b90O1qX2kPSWr/jWXo27Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732453568; c=relaxed/simple;
	bh=579OTAxxCTsdzuh+nLXM4qxYrJpkNNqj06Nk7dWiucg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agPEnEYav/TzeMPiTpeg6/bpttab+9UrNBf1jZAbqJ0709ZWvudhoTBLZVnC4E8q5eRbX1Yt2O09wtRbNe4X9vt7rZONLcuGR9A2HFOPaxgO1UTxQjFcz19IXU7lg6TM1uK3MNuWmy7BUkxyLp75j5aHY/YpPvea4bC/C2nnnUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HOCOk5UP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so32109915e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732453565; x=1733058365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDgXaUWWMXn90x1MGvmiPRPBz637uFXJlZfJg+bhsYo=;
        b=HOCOk5UPZKkjXEZ3v14KiQMmAAGJcntS3/JT4Fq3QD4zOnvudYybDR2ooMkWesSgIa
         bNKg7jpn9eNP9/J2CXlRT891DqkzTATJFL10cELoo5QaF0hKpyIzcQOLyc+gtY5zqTs6
         yTCGtSoOIfg/HyXUqJ8jRKCdR9UiYRkQkJnzkHiiEhyy9G/GfPNhfOTgT8FGqmuEUuaR
         US2ve565Xs9ri1J03HdcvO+Oh+gDGDhyM4DcMGAiiEA0RXIxYM8waaLpKoZlghLltFgr
         o8j6dxvw4MHCuOOtO+bMuoFpoSz1GI0mYZ+btL4CWDOMZrHDK6jN4Jf2ekfOeTWV8pX+
         5PVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732453565; x=1733058365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UDgXaUWWMXn90x1MGvmiPRPBz637uFXJlZfJg+bhsYo=;
        b=lPFkLcTvFz5ltbSkzbRZRRof1ESjBveMYzr/vLY+1V6c2izM/MkT6LwgsKmIoxPPBh
         K5gcg56vG3Sw3SWN58eI72GsyGmfg41DHwvmxEH0+4J97bTpWaTlgT4voaKxFNxawtN6
         DWJ05/xDlqMQzCYOZErwlgfcgzxxH/ch15ToqSObof54NLdMC+cPxQpdjpzGIkeOtYAP
         chACxgUO/6jWZBpj4UlEHNk9ofHAlLfZrFs8YJNslJwFlOoAlA1T69HIpSerJPhhvFU2
         NXFfB2h5BbEh6G7Xiy32a3YNRu6DkysghY5rCKJW+Z9aHTeNkbGug9NWb7SVlmPqjtXQ
         zF3g==
X-Forwarded-Encrypted: i=1; AJvYcCXPMEuTbBddQf1sqYVP6InTV8y4cuRKEUAr2mQPcjbapAK6lEawHuIrhcGZ+qVXYgG9/H81gyEFqJhQkok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lJ6bsZxQ6PgDGT/uR/ihAjDP774FT5rTdeDGSGmUHRESqgsj
	VIEcUKsNL84U48aHy/VCT4cH6ftTFIkGnYvx2N7JN9vex8uZ3DUMhXoqim1NPqI=
X-Gm-Gg: ASbGncs3YNszII38Looc9s6gcMpqQweYgQKRxDrebh3V+SZkm52M/vS38c101cCpqiU
	Pm+55m34/jRgaBxwQtY3JI0zgK4zRohmZEsMQ+VyTze8uv5n+afoGPIyBEJY2yBLBYZR2pXaRcG
	I8Yz3ZbToqLM7aiWtZzFALo8Mj868TFDHeo76rnim4ezivVj4+5wb79FgUTbKMTEiVu43KbEK+n
	YaLbCqF3GJXRldPGsNBKTO7nrbBMQoQRAqK8sS7FYC0PHwrf3HNbHF9hA==
X-Google-Smtp-Source: AGHT+IE/ekA4n5NRsUPfRrSQ4WEQs+2aEfMt8e8Vr2hUc52ItH2CCdtUMuUey9X354G87nt1GQ6+6g==
X-Received: by 2002:a5d:64cc:0:b0:382:4503:728a with SMTP id ffacd0b85a97d-38260be41c0mr7533295f8f.53.1732453564522;
        Sun, 24 Nov 2024 05:06:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad5f59sm7682760f8f.10.2024.11.24.05.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 05:06:03 -0800 (PST)
Message-ID: <55685905-7a28-4796-b386-1212bc1abed1@tuxon.dev>
Date: Sun, 24 Nov 2024 15:06:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] ARM: configs: at91: sama7: add new SoC config
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
References: <cover.1732030972.git.Ryan.Wanner@microchip.com>
 <4c7750b6f29b4ac0e2858ac279af7548e19934bc.1732030972.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <4c7750b6f29b4ac0e2858ac279af7548e19934bc.1732030972.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 19.11.2024 18:40, Ryan.Wanner@microchip.com wrote:
> +config SOC_SAMA7D65
> +	bool "SAMA7D65 family"
> +	depends on ARCH_MULTI_V7
> +	select HAVE_AT91_GENERATED_CLK
> +	select HAVE_AT91_SAM9X60_PLL

These starting here:

> +	select HAVE_AT91_USB_CLK
> +	select HAVE_AT91_UTMI
> +	select PM_OPP

ending here are not needed for this phase, AFAICT.

> +	select SOC_SAMA7
> +	help
> +	 Select this if you are using one of Microchip's SAMA7D65 family SoC.
> +

The Kconfig changes should be a separate patch.

