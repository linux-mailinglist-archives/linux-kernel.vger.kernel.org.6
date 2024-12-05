Return-Path: <linux-kernel+bounces-434086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453459E6175
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B2928394F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D71D1D61A3;
	Thu,  5 Dec 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLVXn/J2"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF071CDA2F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733442003; cv=none; b=YvQVEbTyHYM4tRACTCV+ULH9slDsUMpcq4x8x+zhWv38SKZj1mWUWaaE5bLCZGLlb0KKasSOhQhU0V+H+RALVoenEDqYcrRwCo8PnPzjagmSRCXX2gLjWDxICFO8SPEub57ugw+wzu2B4kaiIsWT0g36lRKNywVnxEcStvdTpKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733442003; c=relaxed/simple;
	bh=SS+CvjwgmBviiYkG3lhdmjo9XVPZiBnQEjZhknvEuWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpgRtxWbl7wC6PrPI/COmYH6QuI5rPqh6SDCNAkPD8njCqJG473BsVZzBNdrYIs0hkZYM7brFi9+YuXjcWWosDgA7GBy9QMdhz+azW3xbzS6kUb+YOm2C6df4LIfgIEUz7c51EL5BsheH3em7vzdFWd3XnCd8vBQFQrsfWOTweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LLVXn/J2; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afce0e21daso25507137.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 15:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733441999; x=1734046799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oacZmWmcYUh3aS8DM+UCqcN8A1TL7Wl2Fm4tR+M814g=;
        b=LLVXn/J2c8n14jZgLLTWWQsoo9F1FjdaTzUNDYL93bth7i9Z2/T2pOnd+S8hX/F2/Q
         a0mmaCom1uX1y1gUjh39ljUrc0kxtlddzG6ClA51Lz82jpcxCYHeFygiMmV1fSvtgkki
         hTnBiU0MFhyv+zdFXyY+haM3zGZ4Rb8Wyt7VmJbaSRKELfQq/SeGFCgI5mkk3rlGIQN2
         f1ZXBJ5LisPW3KJzcSDuCIw1eC9n3ZG2QSXKejq9gQCSAFtkF6lGHWBkHp2e1ZHH7pty
         aO8jgj7C161UggVVSyEGWyMi6j8/MyNyDNDZs/lvDf1ydgeUa6Lr92BOqIb45CD4HJ51
         0IBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733441999; x=1734046799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oacZmWmcYUh3aS8DM+UCqcN8A1TL7Wl2Fm4tR+M814g=;
        b=ZeWqM1+jb/9fvkWALyIrCLpqsn6a5AlRumt4BAxqT1tgktCU4XHn1QFDv9sj7GOQDE
         qKYl1gOoVlN8jCGSMvNX5YztlUAAtqZd2vWRyBijbQSKdtAT8ICRLCoRAuprCkOKSe1B
         09PR1huTHZegNEaco6cvkDdnACXF2dweK7k/ebPYKpSvQp1vWsAAH/rnVkCybKNSzpdO
         DJ8IRn51xosist+jNkJl/jTEes6pf4dMmEIYOoy/XVoGYBpp0Wto9IuOrL060O+jSwEZ
         yFdN//WmyELVvO1YR2ZoYPxvOb1p2QYaWi7ZKwMhYqqj9Iqjuwh3XmiZCpSgRt3J8JDz
         umew==
X-Gm-Message-State: AOJu0YwL7KvJ/c4G3b7dEZ/6E4A5W6ayEi4ZWhlTOlJKmClJzX7ih/Hv
	p4VeNEnvdVQ0zmzbfex1NN5NDEwrCZbjaB8rN/jYwL/xRkppSIZt2bfDkCCHVok=
X-Gm-Gg: ASbGncvIwHnFP7oHfk48nqexggru4FFtgBX/H4huC4BmZEU1D0weHWO9jpnfwiR2fXD
	H3zuZJVSkiN6jw8dmB7YeJj/L7H6/Zs3CaGJmtKcWUaAd65nC+wmg5V3TQvJ/SehE8W93c27LjB
	/7Xdbo5U7zCnIV4ANip+iMx+5knqeUBBOuFiWgheL+AE1e3R8f8zRIM6Qa1oURdsLrnhjC/kdlm
	GwE50zPCySkEeopIkBYkpKH4I5JwG+8ZjU2TUtXvG2d84Izo5K0taMUXyfHAB3KoDURD+hywddE
	cNbgvZe5
X-Google-Smtp-Source: AGHT+IHGLFK0NpREIiG2QUT311n7NIrWXQMbIVONL3n7iGYRppYRkj7evZc5Sutsvv1h+Rf5qB58KQ==
X-Received: by 2002:a05:6102:370f:b0:4af:4d2:488a with SMTP id ada2fe7eead31-4afcab63efemr1980371137.24.1733441999270;
        Thu, 05 Dec 2024 15:39:59 -0800 (PST)
Received: from [192.168.1.124] (49.93.157.89.rev.sfr.net. [89.157.93.49])
        by smtp.googlemail.com with ESMTPSA id a1e0cc1a2514c-85c2b9fd799sm316484241.11.2024.12.05.15.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 15:39:58 -0800 (PST)
Message-ID: <ce757b8e-4e6c-4ba9-9483-b57e6e230fdf@linaro.org>
Date: Fri, 6 Dec 2024 00:39:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] firmware: add exynos ACPM protocol driver
To: Tudor Ambarus <tudor.ambarus@linaro.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com,
 peter.griffin@linaro.org, javierm@redhat.com, tzimmermann@suse.de,
 vincent.guittot@linaro.org, ulf.hansson@linaro.org, arnd@arndb.de
References: <20241205175345.201595-1-tudor.ambarus@linaro.org>
 <20241205175345.201595-3-tudor.ambarus@linaro.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20241205175345.201595-3-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/24 18:53, Tudor Ambarus wrote:
> Alive Clock and Power Manager (ACPM) Message Protocol is defined for
> the purpose of communication between the ACPM firmware and masters
> (AP, AOC, ...). ACPM firmware operates on the Active Power Management
> (APM) module that handles overall power activities.
> 
> ACPM and masters regard each other as independent hardware component and
> communicate with each other using mailbox messages and shared memory.
> 
> This protocol library provides the interface for all the client drivers
> making use of the features offered by the APM. Add ACPM protocol support.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>   drivers/firmware/Kconfig                      |   1 +
>   drivers/firmware/Makefile                     |   1 +
>   drivers/firmware/samsung/Kconfig              |  14 +
>   drivers/firmware/samsung/Makefile             |   4 +
>   drivers/firmware/samsung/exynos-acpm-pmic.c   | 226 +++++
>   drivers/firmware/samsung/exynos-acpm-pmic.h   |  24 +
>   drivers/firmware/samsung/exynos-acpm.c        | 772 ++++++++++++++++++
>   drivers/firmware/samsung/exynos-acpm.h        |  15 +
>   .../linux/soc/samsung/exynos-acpm-protocol.h  |  57 ++
>   9 files changed, 1114 insertions(+)
>   create mode 100644 drivers/firmware/samsung/Kconfig
>   create mode 100644 drivers/firmware/samsung/Makefile
>   create mode 100644 drivers/firmware/samsung/exynos-acpm-pmic.c
>   create mode 100644 drivers/firmware/samsung/exynos-acpm-pmic.h
>   create mode 100644 drivers/firmware/samsung/exynos-acpm.c
>   create mode 100644 drivers/firmware/samsung/exynos-acpm.h
>   create mode 100644 include/linux/soc/samsung/exynos-acpm-protocol.h
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 71d8b26c4103..24edb956831b 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -267,6 +267,7 @@ source "drivers/firmware/meson/Kconfig"
>   source "drivers/firmware/microchip/Kconfig"
>   source "drivers/firmware/psci/Kconfig"
>   source "drivers/firmware/qcom/Kconfig"
> +source "drivers/firmware/samsung/Kconfig"
>   source "drivers/firmware/smccc/Kconfig"
>   source "drivers/firmware/tegra/Kconfig"
>   source "drivers/firmware/xilinx/Kconfig"
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index 7a8d486e718f..91efcc868a05 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -33,6 +33,7 @@ obj-y				+= efi/
>   obj-y				+= imx/
>   obj-y				+= psci/
>   obj-y				+= qcom/
> +obj-y				+= samsung/
>   obj-y				+= smccc/
>   obj-y				+= tegra/
>   obj-y				+= xilinx/
> diff --git a/drivers/firmware/samsung/Kconfig b/drivers/firmware/samsung/Kconfig
> new file mode 100644
> index 000000000000..eed8cd8a677b
> --- /dev/null
> +++ b/drivers/firmware/samsung/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config EXYNOS_ACPM_PROTOCOL
> +	tristate "Exynos Alive Clock and Power Manager (ACPM) Message Protocol"

Given the importance of this driver where a lot of PM services rely on, 
does it really make sense to allow it as a module ?

Some PM services may be needed very early in the boot process

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

