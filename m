Return-Path: <linux-kernel+bounces-436479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4B59E8680
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678AF1884C5D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836071714BE;
	Sun,  8 Dec 2024 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cPog8pRH"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB63158535
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675620; cv=none; b=i2HSHPCWFf/aiVDnEVAgYCa9Nl4tvyJb7aaqqx2+UvsaCvxEbk7sbH9h/gt3hQAEHu93TTznL7kFNDGKhDPbUuuSRJLqcTRR4XVOdtMcCrJ20I2/5ta5ylTG9kA3vgHLlABwIMiYIsmo5YrENToWVKCr/ykSViXK8ovzCAMYfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675620; c=relaxed/simple;
	bh=/35qo1NSaXfj274xmXlQdRGosPADR6c0eJgSNOG7OjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMM71KSxwb6GabvH9L+2XNEJXfid1cooHq3zMNafUFr84OetphQrASflSnVlJ/1FldGUR/g8+zxJqRztTAJ7DDTKObaGtLsr5lumiT1NfY+OGpgGiqx4YPH0+VRTzmjlA290gw+WeFajJI0czkMWNOlNsBcdokvMFq5liZ4ZTFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cPog8pRH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso620374466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675617; x=1734280417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pAZgKK7Ob7dVD/6GRHg29F0t0wRjMiOSNr01J0LKftk=;
        b=cPog8pRHKdk/okPkIRve2/Z9TqHy/oP114O8aBGG/kgUGYAE8asM9POL/3cEmVGaF0
         4vlINOjfpBaA1uuQPyfq9va3Yrx659D+R6aQvXT91LkfdtCU1c3kN3+VkCAyT4YAAq1n
         BITjI4hTOx+pLsPZaeGg5Szkc/ZuOwLnb5ZuKeP6fOZ0KheqI4w2EV6hJnOy6TXkdaz9
         sfPrh7ENqzhadDvR2i5Behk+dh6H0IEBqviSUMtSh0+RRjtJdhiP6JO1XDaFy1AhzA/S
         2KGvNsXXtzcyW8mjNiynTjWK7hlIxNdwMsQLHagGVTPDzocYYhVmVBHwuW60FaKncFr9
         NASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675617; x=1734280417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAZgKK7Ob7dVD/6GRHg29F0t0wRjMiOSNr01J0LKftk=;
        b=ryFNpR46f/UAAuKGpBKLz9pSfoayXR8gi1M0XBmTjfrjIbOuOl3eLE+xRb0teqRydR
         H16U9Mx67f7ungGIdF7srGuDPR124dYNCbdPp+/lyf/HKIA2ohngmS94CnJ0ko8TgyUG
         0TSR+v8dMOfNAwCqSPKSP0o8d1u9Dy9QpSgiqJEMnqd1J2BgId+/FwtY3Mb+A1puvnJt
         tY5dVWYqw2JVYwQFwYYaPPcuGEycqHQ17tl4uQUna4Vrvw8T6N37BndYwUrd3yjdg4Es
         0rN+rz90GMNwk0+O3nEu05ZqgIalMBIdNfoUOUrNk5eWWaQZORaEZs2oVbltPBvYs0rk
         jghw==
X-Forwarded-Encrypted: i=1; AJvYcCU/HiI33NrHLDJu+7TnT1mVqRzscTDUUwGqj5bcy5fXP9nkj0RFaWpFECQseg3B0lh2l+oPcgOQE++Hgdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7YyKKZaFU03vNCP+/0CnQTG7xvFqi+dQWO6G7/aFNPL+b1Ks
	hIDxSDX8HKjlsk/WqdLofSlJEybwGRsQnexw9tf19JlPuuPwdAPX9xuTHtQMiPw=
X-Gm-Gg: ASbGncvp8SI5R860PeYhjNkOxRLijTRV6izKAPrdC5sk79KZ4K6Lm3q9+nAgyfHqWlW
	R5xuYJh4fWUT2ZD6BLQUcd74V/g7JB/u2O5t405+NKOz5Kw/7JNHqrFo2WaCrMv/FJNLo9sUnXY
	fVALC6OslfHbg/nEKn+LVoqxFaMuBRcLWeLWroXV3BITnt3RaYjk/mGHaNYIcQjKZsYJoC2Z7em
	d8YwbB+kB05R9P91UhuB7AHbhbE1hUCfNCH1Gq8IQXwFACQABDdQP/srno=
X-Google-Smtp-Source: AGHT+IEG5BzdBKSU5T5ma5GlgSE9+K05duEqvgjt64DfRU1QPy3ISe7GWbOxCcAy7BgfRsflElX9gA==
X-Received: by 2002:a17:906:32d0:b0:aa6:7027:7b01 with SMTP id a640c23a62f3a-aa670277bf0mr300268066b.20.1733675616848;
        Sun, 08 Dec 2024 08:33:36 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67a4f8dc2sm113804466b.179.2024.12.08.08.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:33:36 -0800 (PST)
Message-ID: <6ea8fa5a-78e4-46d3-8e20-c2a723bb7e86@tuxon.dev>
Date: Sun, 8 Dec 2024 18:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] ARM: configs: at91: sama7: add new SoC config
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <e5a1311100a4f05fdc44107e124129d2d93df2e0.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <e5a1311100a4f05fdc44107e124129d2d93df2e0.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add sama7d65 to the sama7_defconfig.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

