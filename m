Return-Path: <linux-kernel+bounces-251812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F31930A2B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470871C210F9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B478132103;
	Sun, 14 Jul 2024 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="G0eoedj4"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309301311B5
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720964298; cv=none; b=shBRuFLHCV5cX2p5dk3HAPkIRWtdqgiTtrzSDHtVF/SV3nfdb8ipjIMnLJUjNW3OYA2g99E6Qhep4ei8y53ciKduVkaTnCApufwDO070iY8iJkhC4Peb49oLoHkjoUjqEqt7tx/0nv0CWX0lwLHMYj+cWscqGHiO56qpm3GcGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720964298; c=relaxed/simple;
	bh=QZY2hZhNnGQLCp8+5ukUCPPpMFw1QM7HMfILfBTDvDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ceB8EL3LwGAerzftxKncrTy74N1dX2ueGhM2fvdrWIKONoV0RQJJxW+L9a/VA1EcSfn0JB5K+7VqlfXYA64yKP5boh4vOnycUIk8Wr+zGtMUZzNdjMKTmIZT9puC/0pafB+fF3vJcHBS0/TUzk0xJMFv74dsiBH55kPVNzHnejU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=G0eoedj4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4279c10a40eso20578105e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720964293; x=1721569093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wwd7SINeI/1DxU+7e+Q9QSHZPJTXasD4d85bd48Sn3o=;
        b=G0eoedj4ZvhQr61MIV/TvIf/TnFPEwlBckY8G1GBl3GV3bFHCkCOy0Zz2S1EIdqWVK
         0vyzcMADYl64kE3w5aVgzTo5O1OhhaJBkdRQT3QE/e84mCsRQQxD2QmkjPkl2qbe/95v
         74DE4EpTTmgnLdxhr2I/jXbPCoUjd+WJORfdW2chzsX7WigN5RntymqiCf3ugYOWkM/a
         aChVZFnRdw1Krafm4jqpwJ+9zGv8Fr+2u/PsOi4yVfn9uvl8nL/mE2kAn4vVr9F/eLVY
         qY7npxZbfkeYXEG9wb+uRrBnTxPNB8hyJctNo7s3feP/dTsMUOJ5ey2fZwNHhwXsExeC
         8Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720964293; x=1721569093;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwd7SINeI/1DxU+7e+Q9QSHZPJTXasD4d85bd48Sn3o=;
        b=CoRu4/LiAmOqcwci7anED87iDJX7AZOzCflcnc77x7MEKuxR/r6eEomqv6fr2YfIbO
         BH6dloD8Rh71Wp64lx9ZW4zd4JiFXCHuyBtsMXb00flRJC0ZAKIoCUqgeS8Va3QTMBTx
         GYk2ESgjtTARcou7av/GSzj58TH3Cb7p+f/EP8Z6NjY8YiLdbVFAZNH/9wkyDPE2XWru
         KrQNk8hEVkYfhHunBfZI+QFtYAfdppAF0t4+d5xlbKAiTDTa3SL7U5ACtzao5tMfrM4J
         jGd/bF/7aEkCSp4QrcgenoAigz0nY6bPFxnLy8cx/XdmqQ6PwPUmEvXHdP1gj/UuetgC
         qYbg==
X-Forwarded-Encrypted: i=1; AJvYcCUmY/6rUsNn2aQDQ26ZXzQZjvTg3r6XFKGW4j+umS+Jq0TTho8JW31LKdK58Mq4JlAq4siMfbglXY78/0Ii9eDQJMdRuJSptyav15nm
X-Gm-Message-State: AOJu0YyEJhs6U/qMoVZtlPlKbg/kJR+UeGCMdIYBHk9UciHSCv+f4Qdq
	vI7zKBfiDmvhy2le6ZpOuTitAOscYEq5NWNohpO3pSlf2V7pme2c/O9Trv46/Hk=
X-Google-Smtp-Source: AGHT+IFwcwVEMTH7jDV4nRgsurNgTJqPOSeV5vd4ZVdWbfgJJBoThCb2ydKOegYzE35V9vdUJDJLTw==
X-Received: by 2002:a05:6000:1fae:b0:367:f281:260d with SMTP id ffacd0b85a97d-367f2812aecmr9337596f8f.1.1720964293229;
        Sun, 14 Jul 2024 06:38:13 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm3871306f8f.82.2024.07.14.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 06:38:12 -0700 (PDT)
Message-ID: <bc9f50f3-e7e5-4519-9815-7fe93bfb6d8f@tuxon.dev>
Date: Sun, 14 Jul 2024 16:38:11 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/27] ARM: at91: pm: add sam9x7 SoC init config
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 linux@armlinux.org.uk, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102702.195564-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240703102702.195564-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 03.07.2024 13:27, Varshini Rajendran wrote:
> Add SoC init config for sam9x7 family.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v5:
> - Removed unnecessary header file.
> - Added a space in the return type for clarity.
> ---
>  arch/arm/mach-at91/Makefile |  1 +
>  arch/arm/mach-at91/sam9x7.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 arch/arm/mach-at91/sam9x7.c
> 
> diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> index 794bd12ab0a8..7d8a7bc44e65 100644
> --- a/arch/arm/mach-at91/Makefile
> +++ b/arch/arm/mach-at91/Makefile
> @@ -7,6 +7,7 @@
>  obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
>  obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
>  obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
> +obj-$(CONFIG_SOC_SAM9X7)	+= sam9x7.o
>  obj-$(CONFIG_SOC_SAMA5)		+= sama5.o sam_secure.o
>  obj-$(CONFIG_SOC_SAMA7)		+= sama7.o
>  obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> diff --git a/arch/arm/mach-at91/sam9x7.c b/arch/arm/mach-at91/sam9x7.c
> new file mode 100644
> index 000000000000..e1ff30b5b09b
> --- /dev/null
> +++ b/arch/arm/mach-at91/sam9x7.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Setup code for SAM9X7.
> + *
> + * Copyright (C) 2023 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Varshini Rajendran <varshini.rajendran@microchip.com>
> + */
> +
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/mach/arch.h>
> +
> +#include "generic.h"
> +
> +static void __init sam9x7_init(void)
> +{
> +	of_platform_default_populate(NULL, NULL, NULL);
> +
> +	sam9x7_pm_init();
> +}
> +
> +static const char * const sam9x7_dt_board_compat[] __initconst = {
> +	"microchip,sam9x7",
> +	NULL
> +};
> +
> +DT_MACHINE_START(sam9x7_dt, "Microchip SAM9X7")
> +	/* Maintainer: Microchip */
> +	.init_machine	= sam9x7_init,
> +	.dt_compat	= sam9x7_dt_board_compat,
> +MACHINE_END

