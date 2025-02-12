Return-Path: <linux-kernel+bounces-511198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DD0A32789
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA74D3A4388
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF8282ED;
	Wed, 12 Feb 2025 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="JEoTr1iU"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B4364BA
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368222; cv=none; b=u7QxyOYwR3RM6RS5tjUvpke9Dpr8S92bT0F1HBywFt0oRb3eBoXKnbeP9CYFCImz46TVAZglPHKpFhKbzr6ynGprSTndym7z9ydd2qIgZMoZi0jE/uutWL/ypf9mwgEMx0zYq3aAJx+XIpuiKti1/ssfO5gshWV6NFRqbXklbjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368222; c=relaxed/simple;
	bh=b578F3G4ksg9uYuuIbDmEdH1PzTG2rkqiAEAgGBywv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Noz55Kh437JubTdlKvg1r8ByX43TIBpjKUvTzjEz3Qn2wQsAJMiSpKKuhct3bSLwLfmm04Igy8pNQs/8dyz5QZkrT8pOX0SBwo78mOtUnDh5syQCJq9R50wIrG1jprvz3brAU7UdD1A4OZY7nLu3W72DbE/vZE6d/E7TO+2SZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=JEoTr1iU; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8551c57cb8aso99840139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1739368219; x=1739973019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L++QIvyizjU09jC6Ra79XUphzeMezUQZEHB1o4PFgv4=;
        b=JEoTr1iU02+HdmXf12s1+WhKYBOYAqZ7ZXunK8wuc4u3+bk7/kLfSP+9opAPDzLeze
         7l7Dc5KWM94MFpb3jldq5EdGY+QTqIA+xH4NtNzk38h8cicctdViXeBNmDjRzV3rYhCl
         iGZvpqXDOr6MAZfBG9DB7oIurXo2YHntaT29fpN+CCtUty+HYC4FhdutcyFQkcrfyojB
         ZjCo+I8fQMhWeBou4zVNjsXvwDDH69LHSfuF6BqIqrYqd17NdiMwr6ZRWTfGgo/bTQYg
         u3xwCgloMh4Kut7fzGZVmAlhyyTJGrifambbjVsDdxg9nmNB+Str6HtFD2quZb5xj0kn
         /QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739368219; x=1739973019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L++QIvyizjU09jC6Ra79XUphzeMezUQZEHB1o4PFgv4=;
        b=b2gYuWYhjibTjpWZm2CrmlXDwIIADQ+5DU3pbSBmSlUbrg+84jQjMtICBY0Ivz9OYI
         V2vD7ED6GrWiYtUUZrLdHNWpsF+FcJSUco7oF1iV2RFjfevt1eB2S3hwNY/2uNh//72O
         dAOWG8fae1+4pUTKXI4SEzVwxAW2xKPEePnd0xX9+I9NEYvyyMSLMQp+C0IE96vB75+M
         XJ0pF+zxXOBl+5vPzzAkvfrhqCy7LMdV9iRX4+uQVXYKqnULiLA8bYB/j4FRxUuAowXq
         WUAzMBi0YkOA8O+Rs3Ca7MRYfY5x6tYUGimSpQIZMURzjx+oINCTTTLnhVQtCsAhoNi2
         JU4A==
X-Forwarded-Encrypted: i=1; AJvYcCWU6AyHdbQCz+T+BYbMCPUTU1wv6tQNpVbvMU0PE5IK8uSyKvgEVMoTTrKS9MUJ9Vi5SQjjXYDtzJf75Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3gh0UzweQ5xA5BMIVbGjmqfFqUkmdS/qE0l7UrF2FzXdT9uI
	qvkwQh8IYHLzD8+PlYLqMRt5UwoLwXZj4hfpm0+6au7QIg4J7hCP/pjbDdCRzLmYItYGQFgkvGT
	KdCI=
X-Gm-Gg: ASbGncu4nwZu1m8dZS4NfvrdGUBqJ2UIHGqSAdkG0ecz8s/SksLIOzMrlHUZHUj3AeS
	GRbDVKbbKLWWWtHLZNLchnt2Ia8LPRsLMrqzlJMtlmTgoIMBLhqd8uH/aiRQqp+riFn3Ud8z56g
	uhbZ6BMqWIpbYXYR47u96gftp4B4179aQW+CogfJUzyODYZfsciYA0w5N+x14JAEbJDttzYlxiS
	GlkgFilJbgVKpbOAXUPWaekL4x9e3ZmBPhDG+hkkhUCqS4ppFD15ChkpTcjembn1a8Q/5Lkqb2D
	IPkvyI1NFCit25i74XFirU1HcB1IKqOGi8368tX8zzOQ63oCami0VQo=
X-Google-Smtp-Source: AGHT+IGZhne98LVx62ktvxV2QQrzKBPSzDo+6zahs2aSXaoHvmnrhXadwbf8Kww9ZmRSX7qfmJgLgQ==
X-Received: by 2002:a92:c56d:0:b0:3d0:4700:db18 with SMTP id e9e14a558f8ab-3d17c1090damr31382265ab.20.1739368219019;
        Wed, 12 Feb 2025 05:50:19 -0800 (PST)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d05e96f2cdsm32337095ab.50.2025.02.12.05.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 05:50:18 -0800 (PST)
Message-ID: <b67abe31-5647-4450-b025-2bbacee5fa72@riscstar.com>
Date: Wed, 12 Feb 2025 07:50:17 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pinctrl: spacemit: enable config option
To: Yixun Lan <dlan@gentoo.org>, Linus Walleij <linus.walleij@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alex Elder <elder@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 spacemit@lists.linux.dev, Conor Dooley <conor.dooley@microchip.com>
References: <20250212-k1-pinctrl-option-v2-1-bde7da0bc0d9@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250212-k1-pinctrl-option-v2-1-bde7da0bc0d9@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/25 2:27 AM, Yixun Lan wrote:
> Pinctrl is an essential driver for SpacemiT's SoC,
> so let's enable it by default for this SoC.
> 
> The CONFIG_PINCTRL_SPACEMIT_K1 isn't enabled when using
> 'make defconfig' to select kernel configuration options.
> This result in a broken uart driver where fail at probe()
> stage due to no pins found.
> 
> Fixes: a83c29e1d145 ("pinctrl: spacemit: add support for SpacemiT K1 SoC")
> Reported-by: Alex Elder <elder@kernel.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Tested-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>

I just tested this version of the patch.  By default
PINCTRL_SPACEMIT_K1 is "y".  But since it's tristate,
perhaps it should be default=m so it's not built in
for everyone.  Yixun I assume the K1 pinctrl driver
actually *works* as a kernel module.

Anyway, I suggest this change to be a module; Conor
should weigh in.  Either way is good for me, and I
have tested both.

Reviewed-by: Alex Elder <elder@riscstar.com>

> ---
> This should fix problem that CONFIG_PINCTRL_SPACEMIT_K1 is not enabled
> when using make defconfig, thus fail to initilize uart driver which requst
> pins during probe stage.
> ---
> Changes in v2:
> - set default as y
> - Link to v1: https://lore.kernel.org/r/20250207-k1-pinctrl-option-v1-1-e8a7e4d8404f@gentoo.org
> ---
>   arch/riscv/Kconfig.socs          | 1 +
>   drivers/pinctrl/spacemit/Kconfig | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1916cf7ba450ec9958265de2ca41dc504d4d2f7c..17606940bb5239d0fdfc6b5aefb50eeb982d14aa 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -26,6 +26,7 @@ config ARCH_SOPHGO
>   
>   config ARCH_SPACEMIT
>   	bool "SpacemiT SoCs"
> +	select PINCTRL
>   	help
>   	  This enables support for SpacemiT SoC platform hardware.
>   
> diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
> index 168f8a5ffbb952cbeae3e3401c11149558e0a84b..c18d879274e72df251e0bc82a308603ce23738bd 100644
> --- a/drivers/pinctrl/spacemit/Kconfig
> +++ b/drivers/pinctrl/spacemit/Kconfig
> @@ -7,6 +7,7 @@ config PINCTRL_SPACEMIT_K1
>   	tristate "SpacemiT K1 SoC Pinctrl driver"
>   	depends on ARCH_SPACEMIT || COMPILE_TEST
>   	depends on OF
> +	default y
>   	select GENERIC_PINCTRL_GROUPS
>   	select GENERIC_PINMUX_FUNCTIONS
>   	select GENERIC_PINCONF
> 
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250207-k1-pinctrl-option-de5bdfd6b42e
> 
> Best regards,


