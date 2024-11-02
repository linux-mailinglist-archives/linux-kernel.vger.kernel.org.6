Return-Path: <linux-kernel+bounces-393162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D95E9B9C8C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 880ACB21C1A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C6112BEBB;
	Sat,  2 Nov 2024 03:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="glGHEmHu"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD06482DD
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 03:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730519309; cv=none; b=KamPOKBhhyeFPvX4ZtZoxMCPMGXf1IP5bYAdPVmcWc8WnHIUtGo2e941I+iQWBX7+Y3WgwPhYyGjAcKpj+KaCoVjVPhTlVvM99p/vFRDlZV8U65s2H8bYhcjExeVypPsR4lcLzhWq411rwJvNJY9MfSI0f8j1iIxFVA+3vh4MUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730519309; c=relaxed/simple;
	bh=vP4zsOqNtMbKO2+jVJEXwJdYxLid9vzXb56DQWl1K9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rd9mt5epscukHBjICEGHXFx7d7p/S1UKJW5djS2p5tLITd4q9uQUVYjQAfrP6G54BKjzPHg9gcsY5qKC41qz8JW+L13/UMeQhwtqqQfS6F2mMgjvLFLVFi+xLZYBFSlwsWinclD6lUsN2YN+MZcxRqUT7tnTycDP6Ml7YtGTFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=glGHEmHu; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-83ab00438acso79631639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 20:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1730519306; x=1731124106; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cFAxfJPYMHZcgM/IbSJdK8jCoxixwBpatcLPEMEnlyg=;
        b=glGHEmHuBRHQ2w1lkMPygKEzcCZXom8snmPAObJGJ5Iobo59FC7HRyd8UQHrimEaJr
         0mpZE4h6EJ0e7g/6YA0NQcXoYY1PcdKYWQiB7P1IvZzpozmqcylsjw+tSjtZWtjrkIlZ
         loCNSltUi22qrUTACQRvDK4ceiDKzlNptknYNBA1VuprCwhMz6911rHwuoMHfhWL3tAq
         U0vc+3fhnvLGI+oB/71Aw0YUJQ9XxlFjumfsPp3sv3SRgkJ8tp7H0TSI2UHN3EXcVtJI
         McP8r+nP4nhmyy/jtPufH01wej5Xjs+gFp7Bz3LotSqFoniCLGhRPLupLP3T62Wzm5yX
         b/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730519306; x=1731124106;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFAxfJPYMHZcgM/IbSJdK8jCoxixwBpatcLPEMEnlyg=;
        b=QKItjdOblNgjSTxqiXZcr3sVMkqZibsdTUf/6m9//zqaXWDqj19j1z4Clle9apetA8
         qvtaZabcZ39zHJIS8gwJMBV0QbvY6Qmpa7e20SwS5Tt4RyUfWUcTBMDq2uVmXXiWZLW9
         1HI2jOTs5gll66UGYSfy/ibDLzIEwHW9kZf1u3Vs5SEJwFABK9akKcjTSI8FFM3cKGuy
         iuBFZfb05op0IwdjsrNJR5ZvrNQU1T/zcz6KmbWqvOuSQkEsG7JXL04lD8gfKfeeHVVn
         j+sea/6gZC7mugyRyBYkYU7viQA8mNjgrPkdiSwOZ80Xg1DhG0q3E3EoV479BU2gnxOo
         2d4g==
X-Forwarded-Encrypted: i=1; AJvYcCXuxoK2lcOeVMbQF5ax3uTuOaTADCxdIAGtSITBxNUqyUlXnMtLlz9cV9RtMoWbKXGHrjLp5MNzU87vh10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjLIz7IQJjEdtCA3d+pSW51134uRZ+If2WM4r+1wPkfEVhxfLV
	UTHWhHUsv/XG2FmLandtuZxuWXsCdB7Dw3oxo7QYtdxVQIJPaTGKt12Una+iF6s=
X-Google-Smtp-Source: AGHT+IEjX1mR0HcedUZXdXQVrMhUH8jXN4cBozN2zssjtGKah59T7pHiVZuQPT9WVqvySZ4MDCEgRw==
X-Received: by 2002:a6b:7e44:0:b0:805:2048:a492 with SMTP id ca18e2360f4ac-83b7133cf86mr460121839f.6.1730519306354;
        Fri, 01 Nov 2024 20:48:26 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67bb57a5sm108525239f.28.2024.11.01.20.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 20:48:25 -0700 (PDT)
Message-ID: <846b4f2a-602e-431e-affc-0e995db5eee5@sifive.com>
Date: Fri, 1 Nov 2024 22:48:24 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: i2c: spacemit: add support for K1 SoC
To: Troy Mitchell <troymitchell988@gmail.com>, andi.shyti@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20241028053220.346283-1-TroyMitchell988@gmail.com>
 <20241028053220.346283-2-TroyMitchell988@gmail.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20241028053220.346283-2-TroyMitchell988@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Troy,

On 2024-10-28 12:32 AM, Troy Mitchell wrote:
> The I2C of K1 supports fast-speed-mode and high-speed-mode,
> and supports FIFO transmission.
> 
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> ---
>  .../bindings/i2c/spacemit,k1-i2c.yaml         | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> 
> diff --git a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> new file mode 100644
> index 000000000000..57af66f494e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i2c/spacemit,k1-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C controller embedded in SpacemiT's K1 SoC
> +
> +maintainers:
> +  - Troy Mitchell <troymitchell988@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-i2c
> +
> +  reg:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1

Looking at the K1 user manual (9.1.4.77 RCPU I2C0 CLOCK RESET CONTROL
REGISTER(RCPU_I2C0_CLK_RST)), I see two clocks (pclk, fclk) and a reset, which
looks to be standard across the peripherals in this SoC. Please be sure that the
binding covers all resources needed to use this peripheral.

> +
> +  clock-frequency:
> +    description:
> +      Desired I2C bus clock frequency in Hz. As only fast and high-speed
> +      modes are supported by hardware, possible values are 100000 and 400000.
> +    enum: [100000, 400000]

This looks wrong. In the manual I see:

* Supports standard-mode operation up to 100 Kbps
* Supports fast-mode operation up to 400Kbps
* Supports high-speed mode (HS mode) slave operation up to 3.4Mbps(High-speed
I2C only)
* Supports high-speed mode (HS mode) master operation up to 3.3 Mbps (High-speed
I2C only)

So even ignoring HS mode, 100 kHz and 400 kHz are only the maximums, not fixed
frequencies.

Regards,
Samuel

> +    default: 100000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c@d4010800 {
> +        compatible = "spacemit,k1-i2c";
> +        reg = <0x0 0xd4010800 0x0 0x38>;
> +        interrupt-parent = <&plic>;
> +        interrupts = <36>;
> +        clocks = <&ccu 90>;
> +        clock-frequency = <100000>;
> +    };
> +
> +...


