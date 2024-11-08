Return-Path: <linux-kernel+bounces-401530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5609B9C1BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF991F23CC3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA71E22FD;
	Fri,  8 Nov 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o7m7OGWJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A1D47F69
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063836; cv=none; b=ABtnLM/aAzxmf8D4JzxtEZxFnowvhTiUmGUUCCwXp9+xGHymVFXqtXt9PIzXoq3p9QJ5Wq+z8qIEkb67xFqjGhDQSsfyKvg6RIYZhJNTuhfDjofIMMKSPw217bBktCWu9nvjF+BkumMdpbtbqkmUPpFEBn2SjlJkrmCzxT8cw/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063836; c=relaxed/simple;
	bh=v4iX0CXqvThJdyZI61gxIcHcsRox+2hpVafEVV+l/O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nBN1ihfHDxIVKZFm4lUCVvc9uhiWvoUwGyKUhKyD9+hUgyam2aQBzfCT5uMU+nG4HPnBnI4Jve4g8YBvhy+UnmhwXonZkux/IsXLlDQwcw7yKn4q7QvqTsjbkSoIJJzgYLjVkCxnoYYSbUavfQr+PSHpzcJlxnWs8ij+1LwiyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o7m7OGWJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso1795095e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 03:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731063833; x=1731668633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+Mib9CSQrRNQrH6ffNUaqnBKqKAyWoqmRpZgNfrOoU=;
        b=o7m7OGWJcZm21vrmANQGKaTewyDRX5AUmgEZefF5gFbn+4xQ3loyNym07uLOddlB9M
         1i02kQ+uqOVT2X10q3xN+PoGUPILLRMqoD9qetMMljwOCR/X3XJsV/FhrV/LkGjA2L9C
         SUHkE/gLqnjd6NbME5uZPQhQodK74YnV0Nm3f1iR4GwCO/CFSbcBe2YvmJuuhn/vQiQH
         zT1MjtIhzpiaDDfzLKJuSDDfYiJz755jzK/4go6E0HbC8Z/7dsDsFMORo3emm26u9OBP
         8Q1GXDYfeGbMGh9ttdCJy3QChOD/WDAx6rPxpqJ8QxFO8sySLDmdT2w14AOaXYC7PZiO
         ijyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731063833; x=1731668633;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+Mib9CSQrRNQrH6ffNUaqnBKqKAyWoqmRpZgNfrOoU=;
        b=w04fSoXR6IqpHIKR6GS+Wcbkjrn/7OPMwxO6rNesln4lDUhT8IIR8VXGe4DZcGiDH0
         V36MkyPslz/dokjSVzOOxItFUsNggio8D9k2PKTQ7wZebZqYdh6R2xxCIiGwsGK3RkZG
         vff6pO+8py2gSnR8ErwhhNJ5jRrHwNscLtTlt0OlPnvz3GOgVk1AfZPhs+kDMvM4zRcI
         hOuvQ6ut8e6AnI/RQsyy3WZGt32iWTW+ElHMreuobgGq99vvUTK2gG4Cy1JwFbSa3+/3
         g5LEaGW15DDOMqyy3CGRMNxlu+zfdPD7Suu6ykskM8aI28ia+v8buLKPGErpLDhthI7T
         Lxsw==
X-Forwarded-Encrypted: i=1; AJvYcCVPc2kiROoGA0TDHFI0Iiakhir1XGgb6biwKdvEqRPevHtotCFON6kmlC+ROaAauGtMrgmudYcbVWYiF08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rP90BURh7uQ69rToJkVMv6iSv3ICkiPHO98EQ8UcmRzrnJIx
	0FNcXHY9DZzgAE/iXB1MwxTrsTPX8Sz2hvilRTba7SJo03NGwV/wn92MjJN4H80=
X-Google-Smtp-Source: AGHT+IFuHqksscHYCKJL9TXvwIn0/9t2dRL5asA5FUu4BuQuURI1Ofgo7nnNngECV7K4h3RPflkjHA==
X-Received: by 2002:a05:600c:190e:b0:42c:aeee:80c with SMTP id 5b1f17b1804b1-432b752a8b9mr8941955e9.9.1731063833114;
        Fri, 08 Nov 2024 03:03:53 -0800 (PST)
Received: from [172.16.24.83] ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a23fsm100508225e9.33.2024.11.08.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 03:03:52 -0800 (PST)
Message-ID: <f593f02d-1c55-4db9-bec6-ad46b4b7a98e@linaro.org>
Date: Fri, 8 Nov 2024 12:03:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: Fujitsu: Add the Uncore PCI PMU driver
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
 <20241108054006.2550856-3-fj5100bi@fujitsu.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241108054006.2550856-3-fj5100bi@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 06:40, Yoshihiro Furudera wrote:
> This adds a new dynamic PMU to the Perf Events framework to program and
> control the Uncore PCI PMUs in Fujitsu chips.
> 
> This driver was created with reference to drivers/perf/qcom_l3_pmu.c.
> 
> This driver exports formatting and event information to sysfs so it can
> be used by the perf user space tools with the syntaxes:
> 
> perf stat -e pci_iod0_pci0/ea-pci/ ls
> perf stat -e pci_iod0_pci0/event=0x80/ ls
> 
> FUJITSU-MONAKA Specification URL:
> https://github.com/fujitsu/FUJITSU-MONAKA
> 
> Signed-off-by: Yoshihiro Furudera <fj5100bi@fujitsu.com>
> ---
>  .../admin-guide/perf/fujitsu_pci_pmu.rst      |  20 +
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/perf/Kconfig                          |   9 +
>  drivers/perf/Makefile                         |   1 +
>  drivers/perf/fujitsu_pci_pmu.c                | 613 ++++++++++++++++++
>  include/linux/cpuhotplug.h                    |   1 +
>  6 files changed, 645 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
>  create mode 100644 drivers/perf/fujitsu_pci_pmu.c
> 
> diff --git a/Documentation/admin-guide/perf/fujitsu_pci_pmu.rst b/Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
> new file mode 100644
> index 000000000000..5fee3a3ccc86
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/fujitsu_pci_pmu.rst
> @@ -0,0 +1,20 @@
> +===========================================================================
> +Fujitsu Uncore PCI Performance Monitoring Unit (PMU)
> +===========================================================================
> +
> +This driver supports the Uncore PCI PMUs found in Fujitsu chips.
> +Each PCI PMU on these chips is exposed as a uncore perf PMU with device name
> +pci_iod<iod>_pci<pci>.
> +
> +The driver provides a description of its available events and configuration
> +options in sysfs, see /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
> +Given that these are uncore PMUs the driver also exposes a "cpumask" sysfs
> +attribute which contains a mask consisting of one CPU which will be used to
> +handle all the PMU events.
> +
> +Examples for use with perf::
> +
> +  perf stat -e pci_iod0_pci0/ea-pci/ ls
> +
> +Given that these are uncore PMUs the driver does not support sampling, therefore
> +"perf record" will not work. Per-task perf sessions are not supported.
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 2ef412937228..d7df90205be6 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1576,6 +1576,7 @@ CONFIG_ARM_SMMU_V3_PMU=m
>  CONFIG_ARM_DSU_PMU=m
>  CONFIG_FSL_IMX8_DDR_PMU=m
>  CONFIG_FUJITSU_MAC_PMU=y
> +CONFIG_FUJITSU_PCI_PMU=y

Same concerns. There is no such ARCH and this must be sent via your SoC
folks.

Best regards,
Krzysztof


