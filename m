Return-Path: <linux-kernel+bounces-436449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B429E85FF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 16:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A381188023D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF8714B955;
	Sun,  8 Dec 2024 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Fx4I4GyR"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359C1537CB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733672897; cv=none; b=NIx/J7EJSE5R0ktriQEqVM4qRktM9JPUdtceKHSXKsWpfb6YX06FCp5unJz6cQddawx71yNYT2uNyBGsXDHkxcnbzf6fdtnVbqgli5mY9RhaYyOgN7XwbDauY43BV+Qo/NnPA88sZYsobJq+5vy2z1+d7o3bg36iZiGcAugxRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733672897; c=relaxed/simple;
	bh=13AYxRy7mLuoiwTf98tnGZ9xr0EiKRoIm7G67X3Plv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmMFvDetQ1oNdJpNz71n9FWcZKe6Xo+sUoMHXHRtyLKhKrFTPROiIhxYxRhRV/TRYxd34ZURds7sdUcCpxCj2Aea3lMWNGCHv1k7H5H5sJr3uiNe1ztpfBJ8MRgeDKogDM6SP4vw68XyM50FUn9fsLUahwii5oncKJye/G0mAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Fx4I4GyR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385deda28b3so2814385f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733672893; x=1734277693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vPurqFXPorkFQAbwracDx5f4Bl+jhL448j8yHITY+Q=;
        b=Fx4I4GyRQid3w1JeNHsJHYlRad5zBDPhWZJP73pI8NPc8KPHK+b6TSfqgSBsyuL7P0
         zIIeU5q9ggmWypoMWXwBXkMTWBcFEU5+83zm4MzsErQL0ZVTs1y4ce8nGChFs66MgS9v
         soaFgX1nZxaw/B6KQWff9vKAiPDF4hcougC2Q+3Msf0SI3lhVMO9kHmAkpBi2GnfcMX/
         HwpRczjUshKQT/JCaQvScS7bQuwKCB72kQsmFjoBu6Mvi/Jujg4orI6HiWln+hyHKQRv
         jLPrf86NYnu+NOVj7clsyuf30+MWa85YMk/ZSA27dl1eTNORDxC6JpIn5cIubpsjQOQV
         jRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733672893; x=1734277693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vPurqFXPorkFQAbwracDx5f4Bl+jhL448j8yHITY+Q=;
        b=hJgqajtG/7/Y1jBbQ/NPGhdIOR2M7OyUoNd1cJOmU1Y8X9s3mK7achEHoTsZGbbq4a
         qWl25f0NLWRhZxvOzlkCENN1inLWNr1jRHgFQ5bxt4/SfaF79RJwclbzhlXadZ4wi6Zy
         7lyeg9QlVfGMzWDM+jUucooG7g467KgKZMjlGpFMzUAGyMNo3xJrA8/RQvqTmqEGgJmY
         XXZuTpBuf/2Ydl3My43En+BPxx/MLj2j6jCn8bomPzwjS0fxg/9fNxHI4ByB5G4Gh7mi
         bzWx7RPuO6GcvOZaaOLzjvwIcOwq330RH/EeJ38rHSLz1cz2V0wr/OfsfjmTVx5QRqZC
         k6ww==
X-Forwarded-Encrypted: i=1; AJvYcCXOMGS+RRe4wd/Nju1hCFZ1P+Rmj/Bi62VWLfEYNVwyDX2siG0GhZ0gqgr9ybzid9lAxB38rRWkg3bg9zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dm0znKSklrIUyfloBrcHuAFqAqCsl5DFQ/OpT7GostEB/X7g
	qNiDWfwv7uSNGpaVuU0GXnL3xOKZ9blw8gRnF0xpsX07U7O3nBDzPHP7J4uv/vY=
X-Gm-Gg: ASbGncsSjSumm2vOYdPRbgvBrQ1MNDprQ7Jq1TJ4tHU/eIiR4HO05F4sxi8Vqvd992b
	ftO+qoZqnZYxLRxqbw2VRMmQnUaQZKZH8YYaaVms5uwAvOCXf1BJMN0qE5J1oxU4V0AbtrNKhFA
	XGmOMjGWYesHGOpkdgi6ne6EthcuhDDCBj8/3kfNZghpr4x5nMoYfuUD8maUAHN8B/YYt1r5bCI
	cugMbnr7A96uun+WIVMHfi9Bn4IFruL/nhb1T+YtycxJA9XRlHbeFlYlmk=
X-Google-Smtp-Source: AGHT+IE0HMOWF9ivtat2QG1UsdI7qp7SziCSh4sGJgdvzSPoZrMHHwm8fC7vPzNR841LP8WaedB2jg==
X-Received: by 2002:a5d:5f8f:0:b0:386:1cd3:8a00 with SMTP id ffacd0b85a97d-3862b3d0963mr6129425f8f.40.1733672893174;
        Sun, 08 Dec 2024 07:48:13 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434eba653a0sm50093225e9.22.2024.12.08.07.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 07:48:12 -0800 (PST)
Message-ID: <32b1ae9d-f55b-43d0-bb24-1fd486440ab6@tuxon.dev>
Date: Sun, 8 Dec 2024 17:48:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: change BU Power Switch to automatic mode
Content-Language: en-US
To: nicolas.ferre@microchip.com,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cristian Birsan <cristian.birsan@microchip.com>
References: <20241125165648.509162-1-nicolas.ferre@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241125165648.509162-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25.11.2024 18:56, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Change how the Backup Unit Power is configured and force the
> automatic/hardware mode.
> This change eliminates the need for software management of the power
> switch, ensuring it transitions to the backup power source before
> entering low power modes.
> 
> This is done in the only locaton where this swich was configured. It's
> usually done in the bootloader.
> 
> Previously, the loss of the VDDANA (or VDDIN33) power source was not
> automatically compensated by an alternative power source. This resulted
> in the loss of Backup Unit content, including Backup Self-refresh low
> power mode information, OTP emulation configuration, and boot
> configuration, for instance.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

I've added the fixes tag, s/locaton/location, s/swich/switch.

Applied to at91-soc, thanks!

