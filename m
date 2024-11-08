Return-Path: <linux-kernel+bounces-401529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A29C1BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F011C20E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A751E230C;
	Fri,  8 Nov 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5Ltn10x"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FB91E22E3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063797; cv=none; b=MVGk6o6Nm7o4rR01RlfB1vqQcA4sjrhaDrzU7iHzzRbvUX57j8Qt1q3nF2h7vXIM8QKMmNypRmbWwLZByw+uTtpcYN6kK/Vqu/iws1jpWljbX2nlHzrak7MbqSHMVwGtb0bCV0Rs1V6I7Ay7MCc+En5Ynm0+L2kwi8KcOK3Q0tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063797; c=relaxed/simple;
	bh=SOEVt2Or/kmMQ+ROSwiw8uJCo9rutyQgQh0NzwyWwoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iuQRfCZhPXkQYUObBX7yv/3SX4j/gcW0tdrrs7dEAmNl43vxgLWlS9sm2QxzZPbpXzLzM3aPhQ1i1WudHT1L9ttvjGkYaQt1Nyd1o4VxcivBY2va6XqBtj1SAVDYrWW4slHBV86ztHr8pIoPCuKpaJmOMp+8LUwxCxpIoN9joK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5Ltn10x; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43158124a54so1571195e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731063793; x=1731668593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/54zAdLUpqx2P/YPWSVGcyzYbnWX/zdZkvlSyN6Bgis=;
        b=n5Ltn10xKrHqTHW1v6EgPgQD0sgCfNcclaAmHt4pz1BNKnAqsyiY2pq2GIovpa1Y/D
         jaQaO7dV1daTguPJCPRuL3dPmDoUH7hwdw2uE083sonj0UxeJCBjfw2U2Xs5Y1LOjfX3
         o2VM1DDoVVHQsFvOhSr9qVC7Xhjx1XAXKpAc5h/FktvZTGmPR/hyG7B8sewEmjtbltjE
         gFlUxS73kMktjzw13Yi4XD/T2CUMWjn5gTYiDNGYKt1EAGZCApIwBm/APlCsnhzxvUoB
         xchEARzo+KcN9zusMvyfQPBoYHNTV8s0tVV1sh7XIY32jgWm3LuAM81x4Q7FdvbDATVn
         lvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731063793; x=1731668593;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/54zAdLUpqx2P/YPWSVGcyzYbnWX/zdZkvlSyN6Bgis=;
        b=HaUy+/ymD5RPb1O8y4Bfzxy2J8bb62GwFbAVKnqbUXqJjc+uVELsZDds+qKetgDQUy
         rntE6BXNhhyANO6jwNqRoYUYqLO3Lj12yF5Fxvkks7rOKnnxavnahM+Qw1qY9Kx9jNqo
         MYzia1ye0qdS8zojD790eW/jSs12oMnKNGxzQ7KLCtb3LSUJKy4oILiKenuqiXRCi2Kt
         fdYSEBAtSg/qzJ+XCj27SiMu6sRjvz8Vzbymouj3yjWzODE8+2zEygN6Pwx13C7TyvwE
         I7LkqcVaFL/ROJCcGiWQJkgNmcI/+iIKGuiWlzgnH4D5dNxuOahz2HilGaNFI7InT21O
         EItw==
X-Forwarded-Encrypted: i=1; AJvYcCVDz61ThUhu+CZoeRpdVxbwLJM2C365x4L8HXIZHxv3XQxK7F0FhUjOQ7KsPLLmvTXy1aAmoM446tNpePM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfByBiPQUtyupdRzNI9XUqJivgeQDQbxFJQGrThyr85CUZeo3
	WtiWZogPpj6BBrwJJ0eAh9/uEVsRch+WGOD0CIyhaW1wzHKkVnEcLsOipQyB0t8=
X-Google-Smtp-Source: AGHT+IFwQlbGlL1zaHJ5RrZlqhoWbAPq8iIbPLfXzSgtj1QRCcZA22akk0iOzL+dn46oy/xi3aRdaQ==
X-Received: by 2002:a05:600c:4683:b0:42c:b8da:c79b with SMTP id 5b1f17b1804b1-432b751896bmr8791205e9.5.1731063792774;
        Fri, 08 Nov 2024 03:03:12 -0800 (PST)
Received: from [172.16.24.83] ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b054a5ccsm60210285e9.11.2024.11.08.03.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 03:03:12 -0800 (PST)
Message-ID: <f66a649a-60dc-44ba-b8b0-b049c9e357fb@linaro.org>
Date: Fri, 8 Nov 2024 12:03:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: Fujitsu: Add the Uncore MAC PMU driver
To: Yoshihiro Furudera <fj5100bi@fujitsu.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241108054006.2550856-1-fj5100bi@fujitsu.com>
 <20241108054006.2550856-2-fj5100bi@fujitsu.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241108054006.2550856-2-fj5100bi@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 06:40, Yoshihiro Furudera wrote:
> This adds a new dynamic PMU to the Perf Events framework to program and
> control the Uncore MAC PMUs in Fujitsu chips.
> 
> This driver was created with reference to drivers/perf/qcom_l3_pmu.c.
> 
> This driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls
> 
> FUJITSU-MONAKA Specification URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
> ---
>  .../admin-guide/perf/fujitsu_mac_pmu.rst      |  20 +
>  arch/arm64/configs/defconfig                  |   1 +


defconfig goes via your SoC maintainer. Split the patch and Cc the SoC
folks.

Which ARCH is it, BTW?


>  drivers/perf/Kconfig                          |   9 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/fujitsu_mac_pmu.c                | 633 ++++++++++++++++++
>  include/linux/cpuhotplug.h                    |   1 +
>  6 files changed, 665 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
>  create mode 100644 drivers/perf/fujitsu_mac_pmu.c
> 
> diff --git a/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
> new file mode 100644
> index 000000000000..ddb3dcff3c61
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/fujitsu_mac_pmu.rst
> @@ -0,0 +1,20 @@
> +===========================================================================
> +Fujitsu Uncore MAC Performance Monitoring Unit (PMU)
> +===========================================================================
> +
> +This driver supports the Uncore MAC PMUs found in Fujitsu chips.
> +Each MAC PMU on these chips is exposed as a uncore perf PMU with device name
> +mac_iod<iod>_mac<mac>_ch<ch>.
> +
> +The driver provides a description of its available events and configuration
> +options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/.
> +Given that these are uncore PMUs the driver also exposes a "cpumask" sysfs
> +attribute which contains a mask consisting of one CPU which will be used to
> +handle all the PMU events.
> +
> +Examples for use with perf::
> +
> +  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
> +
> +Given that these are uncore PMUs the driver does not support sampling, therefore
> +"perf record" will not work. Per-task perf sessions are not supported.
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5fdbfea7a5b2..2ef412937228 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1575,6 +1575,7 @@ CONFIG_ARM_CMN=m
>  CONFIG_ARM_SMMU_V3_PMU=m
>  CONFIG_ARM_DSU_PMU=m
>  CONFIG_FSL_IMX8_DDR_PMU=m
> +CONFIG_FUJITSU_MAC_PMU=y
>  CONFIG_QCOM_L2_PMU=y
>  CONFIG_QCOM_L3_PMU=y
>  CONFIG_ARM_SPE_PMU=m
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index bab8ba64162f..4705c605e286 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
>  	 can give information about memory throughput and other related
>  	 events.
>  
> +config FUJITSU_MAC_PMU
> +	bool "Fujitsu Uncore MAC PMU"
> +	depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)

Missing depends on specific ARCH.

Sorry, this looks like work for some out of tree arch support. I don't
think we have any interest in taking it... unless it is part of bigger
patchset/work? If so, then provide *lore* link to relevant patchset.

Best regards,
Krzysztof


