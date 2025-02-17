Return-Path: <linux-kernel+bounces-517242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3941BA37E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3A9188D4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53C1A8403;
	Mon, 17 Feb 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ZbbQQmyg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3171AA1C8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739783511; cv=none; b=DwsZk4T1xZpduezSApiE0xNJ74pre8TM2LbdZsJpGwf6vvk/1MwmDoYrnWaMPiriyVv34qYhH8OMcRz+cA6wC6ggmizBcFMEHKiEiCEvGK0HHSTvSMzwbqeV8UWv78A5Ippa3b6yer9jbct0a7y0h7849gHP7Zr+F0RUZM0VAMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739783511; c=relaxed/simple;
	bh=Yeiz2kj64kEbfNbt5aYOJ/jGd8dP6KZ2dsWH1WXTr3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSV8BkGjcI+3vUrgMpL6oLzDGuzgKiGfgH+80oocFX39GNIy1H72QU/02B2e0zPJtw0bxmV6ZoKrZHQWevwTZRYUJab/RwA7NImMYhgk0TYQ/ImDezgpdZaye2Azf2g3bfEWDWCkO7CpTkvlXIzxkndZ8UwqNKBZOrcrlbaTj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ZbbQQmyg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb8e405640so150840966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739783508; x=1740388308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYoZrFVwEGY8opk8QO/5pLPuklVAIKXU/foFnheb5eQ=;
        b=ZbbQQmygWQx2e0hy6mI60EeRPBPR5AugsyozbiN1USnGevfCleVm2jA6fTIrGrPj4t
         7w9CJNsIrFV4wwY/NhPy6FFKIGWyOpTwzhvHioe4wFjmeen5jLiqOQRKL99KFeBauw0G
         pGvwlU3wM2TzDSiIBNKCh/0ulBAFJO1IgXZedBvARPe5Y2yvPwVpBQpkh5EO8OX9Ca6k
         Gn/616eWMYZVsN7tITQfo+fZIU+EO6TyD3n1KH03QfMs7UEr7/zHq1IjhRoAIeQnjhAx
         RxFzJ70RB4hZO4wje8wDOJJfHRGZKEUkZNknIvLxUqzFGI4jrrmv7IA9xDHm497jRuLM
         gpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739783508; x=1740388308;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYoZrFVwEGY8opk8QO/5pLPuklVAIKXU/foFnheb5eQ=;
        b=ldyZxdM/+39t3aOe8ulOYZhxxtbgodUm5DzU9vBDDcn81fZjy51ZciN4P1Un14NNVD
         tMtsOH5vBakRNPG2FA89dkGSLDwL5G8nlvELcc8KV/msD2hgS3LCWGZrQjTNua55vf/5
         ntaGM7Vm3gro4tKCkrnoOA6vBsnJoM2C7rlAJA7h1U//oTozomyywFeGCFw0ugJHc7oW
         2nE+ZtkWTWJdUQFeaBoYiao1BHnN96mXvGDQnCVV4R/grVy7gERupfmdRp15jcU+OC1e
         bZOpHIRLgfKfKMog/zCoPgG/y8aqGNY+mK9ej6vwY8bV+Gbym6R9OqBfxwxARtPHIMSu
         JavQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtX7mIzb3yxk0aqjbhfeeZvIZUXd8ifylnMFH7TUgruyMazR9vnXLnkD9LnNq7rus+1KH4W+btFF9rTSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBmpOHY5i/OIZJIiabpenNtNvHV9ZFBE5Y1KinzZSNzYdyA4s
	lM5fd6S6aToK/9EuRcJlrOIklesZv8nOntSc7y7MjQPDDQcMiuMPcfazRr4XXqc=
X-Gm-Gg: ASbGncu8j0a9Ly1Qbn4j5XlYoVUlLmZE8jvnVSl/xmNX6NcQ9r25Bz2o9BhUg61HkOJ
	ZtB5yMtqNPcle99oKo81BCWz4WIaC80eqBSLDHuoUMa71hUgW6K4eWqKP/afVQZhcRVsIKNTpMP
	3wvbJsVKZEgBVLjSMpHDIlahPClrHO8oJMyrbdhJEG4KGopxxDC5w2JRS7tNEfVRddXInZOq6OI
	U79YKxyzSNqieRiua9LHpD5pvMDqMSJfL8Dcp5Jbow6JJeks4OuFnGACBY66RpVCJZ7aF1PJ2Jr
	Z2MSuKqcE5A2NmOexmNRBbc=
X-Google-Smtp-Source: AGHT+IH0ZSgjgJTIia6iqC6h5c4cn2rdeaWssWndx+F3YgQmZCBCBDS670k/uUUFdqaubd4pzdmRhg==
X-Received: by 2002:a17:907:7842:b0:ab7:cfe7:116f with SMTP id a640c23a62f3a-abb70d96544mr908000266b.46.1739783507597;
        Mon, 17 Feb 2025 01:11:47 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b81aacdsm162495766b.104.2025.02.17.01.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:11:47 -0800 (PST)
Message-ID: <a1dff4af-d771-4424-869f-15d3b6bca013@tuxon.dev>
Date: Mon, 17 Feb 2025 11:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] dt-bindings: clock: at91: Split up per SoC
 partially
To: Alexander Dahl <ada@thorsis.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Ryan Wanner <ryan.wanner@microchip.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20250210164506.495747-1-ada@thorsis.com>
 <20250210164506.495747-2-ada@thorsis.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250210164506.495747-2-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexander,

On 10.02.2025 18:44, Alexander Dahl wrote:
> Before adding even more new indexes creating more holes in the
> clk at91 drivers pmc_data->chws arrays, split this up.
> 
> This is a partial split up only for SoCs affected by upcoming changes
> and by that PMC_MAIN + x hack, others could follow by the same scheme.
> 
> Binding splitup was proposed for several reasons:
> 
> 1) keep the driver code simple, readable, and efficient
> 2) avoid accidental array index duplication
> 3) avoid memory waste by creating more and more unused array members.
> 
> Old values are kept to not break dts, and to maintain dt ABI.
> 
> Link: https://lore.kernel.org/linux-devicetree/20250207-jailbird-circus-bcc04ee90e05@thorsis.com/T/#u
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
> 
> Notes:
>     v2:
>     - new patch, not present in v1
> 
>  .../dt-bindings/clock/microchip,sam9x60-pmc.h | 19 +++++++++++
>  .../dt-bindings/clock/microchip,sam9x7-pmc.h  | 25 +++++++++++++++
>  .../clock/microchip,sama7d65-pmc.h            | 32 +++++++++++++++++++
>  .../dt-bindings/clock/microchip,sama7g5-pmc.h | 24 ++++++++++++++
>  4 files changed, 100 insertions(+)
>  create mode 100644 include/dt-bindings/clock/microchip,sam9x60-pmc.h
>  create mode 100644 include/dt-bindings/clock/microchip,sam9x7-pmc.h
>  create mode 100644 include/dt-bindings/clock/microchip,sama7d65-pmc.h
>  create mode 100644 include/dt-bindings/clock/microchip,sama7g5-pmc.h
> 

[ ...]

> diff --git a/include/dt-bindings/clock/microchip,sama7g5-pmc.h b/include/dt-bindings/clock/microchip,sama7g5-pmc.h
> new file mode 100644
> index 0000000000000..ad69ccdf9dc78
> --- /dev/null
> +++ b/include/dt-bindings/clock/microchip,sama7g5-pmc.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> +/*
> + * The constants defined in this header are being used in dts and in
> + * at91 sama7g5 clock driver.
> + */
> +
> +#ifndef _DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H
> +#define _DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H
> +
> +#include <dt-bindings/clock/at91.h>
> +
> +/* old from before bindings splitup */
> +#define SAMA7G5_PMC_MCK0	PMC_MCK		/* 1 */
> +#define SAMA7G5_PMC_UTMI	PMC_UTMI	/* 2 */
> +#define SAMA7G5_PMC_MAIN	PMC_MAIN	/* 3 */
> +#define SAMA7G5_PMC_CPUPLL	PMC_CPUPLL	/* 4 */
> +#define SAMA7G5_PMC_SYSPLL	PMC_SYSPLL	/* 5 */
> +
> +#define SAMA7G5_PMC_AUDIOPMCPLL	PMC_AUDIOPMCPLL	/* 9 */
> +#define SAMA7G5_PMC_AUDIOIOPLL	PMC_AUDIOIOPLL	/* 10 */
> +
> +#define SAMA7G5_PMC_MCK1	PMC_MCK1	/* 13 */
> +
> +#endif

I would have expected this to be something like:

#ifndef __DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H__
#define __DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H__

/* Core clocks. */
#define SAMA7G5_MCK0			1
#define SAMA7G5_UTMI			2
#define SAMA7G5_MAIN			3
#define SAMA7G5_CPUPLL			4
#define SAMA7G5_SYSPLL			5
#define SAMA7G5_DDRPLL			6
#define SAMA7G5_IMGPLL			7
#define SAMA7G5_BAUDPLL			8

// ...

#define SAMA7G5_MCK1			13

#endif /* __DT_BINDINGS_CLOCK_MICROCHIP_SAMA7G5_PMC_H__ */

Same for the other affected SoCs.

The content of include/dt-bindings/clock/at91.h would be limited eventually
only to the PMC clock types.

The other "#define PMC_*" defines will eventually go to SoC specific
bindings. "#define AT91_PMC_*" seems to not belong here anyway and these
would in the end removed, as well.

Thank you,
Claudiu

