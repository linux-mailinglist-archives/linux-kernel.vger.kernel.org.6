Return-Path: <linux-kernel+bounces-420151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAF49D75B9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AEB16473C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2EF1891AA;
	Sun, 24 Nov 2024 16:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdEVYxKE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE373186294
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 16:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732464724; cv=none; b=ZX8id1YrMh/WZDLGwzT1wAl6cg9mNadz+1QUl5lRWZZXtKzsIH8vxSQzWl8jlDorwTrk1Axu4EX8wJ5TvPxjwh57Gua1IXTv6TEdxPCoHmwtOnp1KU9nU1SalZX2sA8tipA4aFHXoP2FnJeWA/tqxCW/GU6PgrwJbQ7dt9TUAuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732464724; c=relaxed/simple;
	bh=qQm6bVf/4ltr/ujc1ydQY5ajzT7bkLtyYQuXyO2SU0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A/2LBGRP/mteQJIu+WYvrqVcbMi2mu7ygdyxULj2QDtF8mG6edMYe059b2AiLNN31AM3VjXyx2D2G57wVN8rCAyYqelLxD0quE6mL8biYTI3tkN39Gt4sXby0o5FZqvD3wt5qkU2AovpE+EXx5naX5aamIBxR5qWc8976iuldGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdEVYxKE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3822e64b2d8so113185f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 08:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732464721; x=1733069521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQm6bVf/4ltr/ujc1ydQY5ajzT7bkLtyYQuXyO2SU0Y=;
        b=LdEVYxKEWoTW3cH4WBSfmGUsN5o1EL1C8bk6LRTxVbpe+K2aUk1GvvhJH3mgWyyCQF
         7wzLtaqbSyBSHyPxBFtbILrTIxoKUpNEbEJzEz4GnckRdD9GA+u0VL5dx0jWkkZPwrQh
         kKViaVYV4pvmz8dYjYQoxc+jzwzT7b8Kiywj8Xsn3uqA0RrqRqz7xM6LOHA56axbSszN
         HQf6QHoAIrRFNO6SDIxHpP3aSaabz8Q8U5c9e3ohxZumPEHl1tZJqHyLxQUsM0PZ6Vyo
         QLsOTKugkK3a5hkZD/xHgfKYWErfFK9gufM7S5ul8h8O84k/LPDbOOQrGBTCQ8n1ZGWH
         EQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732464721; x=1733069521;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQm6bVf/4ltr/ujc1ydQY5ajzT7bkLtyYQuXyO2SU0Y=;
        b=v3muTdJ/2sW4yjrovFglZPSSAn4E/0aQSTWOQgrGX7qFFooLeCnOmYhupmzgQnsmpC
         jQqn8D0MJIfCtBFKFzefOTvF9DgJ840z2K3dUC2J7U8b1SVCjUS2Zbg06jse4pUjQiwh
         FObb7mUXojD3lV0jvV98GvcEWnu/1iLa4O5bN2K5sl4d9LLKh3mZRFcCk+6qLZdA03vf
         MnTTpZgq/w8ux/EmfarqrnEu/Z/ZKav4FfD17ijSp5CK/xZ/12hlvfnU3y8tAAoGAH/1
         HaEG0BD8g+yhxj0XUfsEGwXLvAbVv99+oVfvGhqLtkJNgFGXcyfCrsfcpgVjUo+SNQHQ
         cNIw==
X-Forwarded-Encrypted: i=1; AJvYcCXF2Tt4heQdn/ZOwbywU7G/TLCxmR5lw05u7ipgF8RWSumEeZKqDJWeMEqhuGNJmzH61JLWKQ6XIowDW14=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrV/dOXEDI3knjJt1TOFiWbeTrIJHSJub9pZ0zdzy0Zf1ualz
	FNR9P15CeBg6QenqyQU8Ws1PqpnVOqoH/1hMXdifzo9AHOAt5DkOCGhPbWtv0pk=
X-Gm-Gg: ASbGnctr3MP1pPwcrXAsULWDTOHV7GRnvkv634wS4RMKkQIHDRrn1fZiztbGO8vfoXs
	656pTyLAdtYADlG+utlxrt1EOhcxBjM8xLFDuiRMX0tmsQr42cxIUwt0fvGj2PEWxsEXQS+CeV1
	JlVI9FYIX1C61dwtchNfk6GNcHhR2ix9jyKqwj5q2+rumF9TMvaXl3F6OkkHV+Pa3tJaLimMxlW
	VyzA06LIgnKRkVmFs3hXqvTXGle5uUISlD1z8eKhQjFD51HKXc2HBsfx8xdi3mhaoUsyQ==
X-Google-Smtp-Source: AGHT+IHgR5KeuA3oyfRDBJFP0KZz5l5B23PsJTeLmKZrmZd8h4yWmBqlsCgmqP5F0Hxsdg8tYQ/oaA==
X-Received: by 2002:a5d:5f85:0:b0:382:46cb:5469 with SMTP id ffacd0b85a97d-3826089cdc5mr3452504f8f.0.1732464721200;
        Sun, 24 Nov 2024 08:12:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbed85bsm8030423f8f.90.2024.11.24.08.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 08:12:00 -0800 (PST)
Message-ID: <027767d4-89e7-4665-b840-294a84a89869@linaro.org>
Date: Sun, 24 Nov 2024 17:11:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] WIP: arm64: dts: meson: drop broadcom compatible from
 reference board SDIO nodes
To: Christian Hewitt <christianshewitt@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20241124083453.900368-1-christianshewitt@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241124083453.900368-1-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/11/2024 09:34, Christian Hewitt wrote:
> Drop the Broadcom compatible and use a generic sdio identifier with the Amlogic

1. Heh, what? Why? This is not really explained and does not look
sensible at all.
2. What is "generioc sdio identifier"?

> reference boards. This allows a wider range of Android STB devices with QCA9377
> and RTL8189ES/FS chips to have working WiFi when booting from the reference dtb

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597


> files. There is no observed impact on Broadcom devices.

So how does it allow wider range of devices to have working wifi?


Best regards,
Krzysztof

