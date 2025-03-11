Return-Path: <linux-kernel+bounces-557056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF0A5D312
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BF9189B041
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9C322E415;
	Tue, 11 Mar 2025 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="VETI7rj6"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAD21D59F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 23:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735199; cv=none; b=uz8TyMTGveKR7fdWyPxhuS+MhFqrsYkDkZYxrWjolL2WmtncCOqCnVnuDV2hry43Es9DAKsZV7TMQz45Pr9n+AJNAgzoWU7REjQccdYH5gt99o6/ZvR4zDcJlZ+rCkikuAto3d/ZIBJXzMzNAvdxax7tW1BWXXGtio3cKR6l3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735199; c=relaxed/simple;
	bh=RN6X8vB1dszqILdwQiWmD0f7+U50L1BcQaks8GYd6Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3z3QCgX7Z4jlhGBgXtMIoVheofX3ePNBSIWO88NwND0qq7mXxIGhsT2UQJwV/AbwfXfjfPI4EC5TKaL1y4vHBywrieb5917j/YJGvHWLsTC18XCYAm8lo+UuG94VDH9guuxgB1g7Up/Upo5BY7dubzrANMYEfMJ/wJ97aiB8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=VETI7rj6; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85ad83ba141so538111039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 16:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1741735194; x=1742339994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/yuA5CJJnNTGrxF6fDBil1DEwDO1Je5mq9iGAGFoUs=;
        b=VETI7rj6BRrfl8ScBsPUmG9JA/8g8AN6PyG8QLnr0zhlXHAAXQkSDjZG/XshmERWam
         tgqju3fowoja07g6iEHy1D5wm56XNPu6BYdyVFW9ZxTFiFYfQW883hi24JDP3QyprnH1
         3rB9Dgu3dkmFuoaULPv8BKFYywleg2649La86jpML4JDJ5QLwritZmmeO+r1AebreYZQ
         qle7TvuQk2J6k/siDtsQXso0xr8ioD0QIeWBj3YKiiE3juJtYpjxkkKDxGK+uRK0mcZB
         Rodu1sy0MHL4MbQ/hWy1Mib2udssLV6mW1Jbuh4UyECSvQsmfTP2CeRHnfHM2RNJumMn
         xsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741735194; x=1742339994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/yuA5CJJnNTGrxF6fDBil1DEwDO1Je5mq9iGAGFoUs=;
        b=O9DqrmFYulZ1YVHCOW6UuN9ULQSG4HG9DaoV8auuSLMTo+xI8ssI0PKQqamua/vT/I
         Etp8EZraoQkom79pXmwAN+Yz0Vs5fvqi5/iesInQvxIY7Xf049mmSYrKsLLrnYqnFrk0
         C2+ihDBoEdS1RWx7uBQQC3NvWSgI0sPgI6pzhRmkLzyF8y+F89T3hPqbJwnkib5AQ8L0
         2S2MTgx0rS+TAswUXfF6y8UFrxVoiyYYpHCZxxdOJGz0csQvLDsUg1AhcNhezUYzDgQG
         xv072keOB0xvOUL2N4JPY1eCBvBn94dKidwchVL7rTnq5IYNEO0BgnHQ7OlZ5IpL4RXR
         YAzA==
X-Forwarded-Encrypted: i=1; AJvYcCURH80cQzVqcz+hPqUrxKWLBvQBkrozdvelrwmEPzW/JXEztY6su57jhqt+9fQNHnj6fSUOGFV8bTqBawA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJvxe6XETvJ2z86+Ch+IC8Btrbb9gYH6AVurTVbg2TTDANnQ9
	s1UkGa3rfiVU1GRZinKmWFRFKasXruL3Kf5KHfi9lLF6pPtncPEwae0/lSKF0D8=
X-Gm-Gg: ASbGnctYFoXfbczNNT99ygdA4LCpX/G9M2QZbwgzQIyNWZ9c+r/1r92ZuzLUTYFv674
	ElCq7vTmV4PESdTc4JmM6ZuGDZHroCZjXl4FbezaSq/ha4WlXkS8XqtyEDfyMKxop7V08lvqhYg
	yynDy8n7x+uVvak4DzMK0EU/ClniWZgkPjUs3gpZJZWfxJyHgjbG4VeJlHJku6qqKix2aDBoFK0
	xtg5JQPjO+gqTowtyfYsb4F55osiECv4TCWNx4g8FTcqyyjNse1CyuLEn6SO9BcMuuLfhvUCbCd
	RmvDykr//cUvypD5KBv7yN5oVO6V9+worCkv3h+bvpuzIxZ+bdTSE5AA1mmoQHIb6kFw7VlaTx8
	2rW3fxl+u
X-Google-Smtp-Source: AGHT+IEUhE/b4sL1a0QlZr/ZVnzaK6rtIwyh3HAuBSBl1n+Ue+iq1MflhdSXrDJYs6O8fMByD8XefA==
X-Received: by 2002:a05:6e02:1a83:b0:3d4:e6:d872 with SMTP id e9e14a558f8ab-3d4418cd5fbmr220663935ab.9.1741735193921;
        Tue, 11 Mar 2025 16:19:53 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f254c4889csm155371173.139.2025.03.11.16.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 16:19:53 -0700 (PDT)
Message-ID: <d625c473-789c-42f9-918c-8a649d058513@riscstar.com>
Date: Tue, 11 Mar 2025 18:19:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
To: Haylen Chu <heylenay@4d2.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>,
 Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 spacemit@lists.linux.dev, Inochi Amaoto <inochiama@outlook.com>,
 Chen Wang <unicornxdotw@foxmail.com>, Jisheng Zhang <jszhang@kernel.org>,
 Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
 Guodong Xu <guodong@riscstar.com>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-5-heylenay@4d2.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250306175750.22480-5-heylenay@4d2.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:57 AM, Haylen Chu wrote:
> The clock tree of K1 SoC contains three main types of clock hardware
> (PLL/DDN/MIX) and has control registers split into several multifunction
> devices: APBS (PLLs), MPMU, APBC and APMU.
> 
> All register operations are done through regmap to ensure atomiciy
> between concurrent operations of clock driver and reset,
> power-domain driver that will be introduced in the future.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>

I'm very glad you have the DT issues resolved now.

I again have lots of comments on the code, and I think I've
identified a few bugs.  Most of my comments, however, are
suggesting minor changes for consistency and readability.

I'm going to skip over a lot of "ccu-k1.c" because most of what I
say applies to the definitions in the header files.

> ---
>   drivers/clk/Kconfig               |    1 +
>   drivers/clk/Makefile              |    1 +
>   drivers/clk/spacemit/Kconfig      |   20 +
>   drivers/clk/spacemit/Makefile     |    5 +
>   drivers/clk/spacemit/ccu-k1.c     | 1714 +++++++++++++++++++++++++++++
>   drivers/clk/spacemit/ccu_common.h |   47 +
>   drivers/clk/spacemit/ccu_ddn.c    |   80 ++
>   drivers/clk/spacemit/ccu_ddn.h    |   48 +
>   drivers/clk/spacemit/ccu_mix.c    |  284 +++++
>   drivers/clk/spacemit/ccu_mix.h    |  246 +++++
>   drivers/clk/spacemit/ccu_pll.c    |  146 +++
>   drivers/clk/spacemit/ccu_pll.h    |   76 ++
>   12 files changed, 2668 insertions(+)
>   create mode 100644 drivers/clk/spacemit/Kconfig
>   create mode 100644 drivers/clk/spacemit/Makefile
>   create mode 100644 drivers/clk/spacemit/ccu-k1.c
>   create mode 100644 drivers/clk/spacemit/ccu_common.h
>   create mode 100644 drivers/clk/spacemit/ccu_ddn.c
>   create mode 100644 drivers/clk/spacemit/ccu_ddn.h
>   create mode 100644 drivers/clk/spacemit/ccu_mix.c
>   create mode 100644 drivers/clk/spacemit/ccu_mix.h
>   create mode 100644 drivers/clk/spacemit/ccu_pll.c
>   create mode 100644 drivers/clk/spacemit/ccu_pll.h
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 713573b6c86c..19c1ed280fd7 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -517,6 +517,7 @@ source "drivers/clk/samsung/Kconfig"
>   source "drivers/clk/sifive/Kconfig"
>   source "drivers/clk/socfpga/Kconfig"
>   source "drivers/clk/sophgo/Kconfig"
> +source "drivers/clk/spacemit/Kconfig"
>   source "drivers/clk/sprd/Kconfig"
>   source "drivers/clk/starfive/Kconfig"
>   source "drivers/clk/sunxi/Kconfig"
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index bf4bd45adc3a..42867cd37c33 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -145,6 +145,7 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
>   obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
>   obj-y					+= socfpga/
>   obj-y					+= sophgo/
> +obj-y					+= spacemit/
>   obj-$(CONFIG_PLAT_SPEAR)		+= spear/
>   obj-y					+= sprd/
>   obj-$(CONFIG_ARCH_STI)			+= st/
> diff --git a/drivers/clk/spacemit/Kconfig b/drivers/clk/spacemit/Kconfig
> new file mode 100644
> index 000000000000..76090cd85668
> --- /dev/null
> +++ b/drivers/clk/spacemit/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config SPACEMIT_CCU
> +	tristate "Clock support for Spacemit SoCs"
> +	default y
> +	depends on ARCH_SPACEMIT || COMPILE_TEST
> +	select MFD_SYSCON
> +	help
> +	  Say Y to enable clock controller unit support for Spacemit SoCs.
> +
> +if SPACEMIT_CCU
> +
> +config SPACEMIT_K1_CCU
> +	tristate "Support for Spacemit K1 SoC"
> +	default y
> +	depends on ARCH_SPACEMIT || COMPILE_TEST

It's great to include COMPILE_TEST.

> +	help
> +	  Support for clock controller unit in Spacemit K1 SoC.
> +
> +endif
> diff --git a/drivers/clk/spacemit/Makefile b/drivers/clk/spacemit/Makefile
> new file mode 100644
> index 000000000000..5ec6da61db98
> --- /dev/null
> +++ b/drivers/clk/spacemit/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_SPACEMIT_K1_CCU)	= spacemit-ccu-k1.o
> +spacemit-ccu-k1-y		= ccu_pll.o ccu_mix.o ccu_ddn.o
> +spacemit-ccu-k1-y		+= ccu-k1.o
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> new file mode 100644
> index 000000000000..5974a0a1b5f6
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -0,0 +1,1714 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/minmax.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_pll.h"
> +#include "ccu_mix.h"
> +#include "ccu_ddn.h"
> +
> +#include <dt-bindings/clock/spacemit,k1-ccu.h>
> +
> +/*	APBS register offset	*/

Use spaces, not tabs above (same as you've done elsewhere).

> +#define APBS_PLL1_SWCR1			0x100
> +#define APBS_PLL1_SWCR2			0x104
> +#define APBS_PLL1_SWCR3			0x108
> +#define APBS_PLL2_SWCR1			0x118
> +#define APBS_PLL2_SWCR2			0x11c
> +#define APBS_PLL2_SWCR3			0x120
> +#define APBS_PLL3_SWCR1			0x124
> +#define APBS_PLL3_SWCR2			0x128
> +#define APBS_PLL3_SWCR3			0x12c
> +
> +/* MPMU register offset */
> +#define MPMU_POSR			0x10
> +#define POSR_PLL1_LOCK			BIT(27)
> +#define POSR_PLL2_LOCK			BIT(28)
> +#define POSR_PLL3_LOCK			BIT(29)
> +
> +#define MPMU_WDTPCR			0x200
> +#define MPMU_RIPCCR			0x210
> +#define MPMU_ACGR			0x1024
> +#define MPMU_SUCCR			0x14
> +#define MPMU_ISCCR			0x44

Somehow the fact that you used just two digits for the above
two made me think maybe they were field values rather than
offsets.

If you used 4 digits for all offsets (with leading 0's) maybe
that consistency would reinforce the difference between an
offset and other values.

Also, please sort the offset definitions in increasing
numeric order (within the groups); that too will help
readability.

> +#define MPMU_SUCCR_1			0x10b0
> +#define MPMU_APBCSCR			0x1050
> +
> +/* APBC register offset */
> +#define APBC_UART1_CLK_RST		0x0
> +#define APBC_UART2_CLK_RST		0x4
> +#define APBC_GPIO_CLK_RST		0x8

. . .

> +#define APBC_PWM17_CLK_RST		0xdc
> +#define APBC_PWM18_CLK_RST		0xe0
> +#define APBC_PWM19_CLK_RST		0xe4
> +

I realize that these symbols are named based on the
underlying hardware register names.  But the above
uses "CLK_RST" to indicate a clock/reset control
register.  But the definitions below spell "reset"
differently:  "CLK_RES".  What do you think about
using a consistent naming scheme in the code?

> +/* APMU register offset */
> +#define APMU_JPG_CLK_RES_CTRL		0x20
> +#define APMU_CSI_CCIC2_CLK_RES_CTRL	0x24
> +#define APMU_ISP_CLK_RES_CTRL		0x38
> +#define APMU_LCD_CLK_RES_CTRL1		0x44
> +#define APMU_LCD_SPI_CLK_RES_CTRL	0x48
> +#define APMU_LCD_CLK_RES_CTRL2		0x4c
> +#define APMU_CCIC_CLK_RES_CTRL		0x50
> +#define APMU_SDH0_CLK_RES_CTRL		0x54
> +#define APMU_SDH1_CLK_RES_CTRL		0x58
> +#define APMU_USB_CLK_RES_CTRL		0x5c
> +#define APMU_QSPI_CLK_RES_CTRL		0x60
> +#define APMU_DMA_CLK_RES_CTRL		0x64
> +#define APMU_AES_CLK_RES_CTRL		0x68
> +#define APMU_VPU_CLK_RES_CTRL		0xa4
> +#define APMU_GPU_CLK_RES_CTRL		0xcc
> +#define APMU_SDH2_CLK_RES_CTRL		0xe0
> +#define APMU_PMUA_MC_CTRL		0xe8
> +#define APMU_PMU_CC2_AP			0x100
> +#define APMU_PMUA_EM_CLK_RES_CTRL	0x104
> +#define APMU_AUDIO_CLK_RES_CTRL		0x14c
> +#define APMU_HDMI_CLK_RES_CTRL		0x1b8
> +#define APMU_CCI550_CLK_CTRL		0x300
> +#define APMU_ACLK_CLK_CTRL		0x388
> +#define APMU_CPU_C0_CLK_CTRL		0x38C
> +#define APMU_CPU_C1_CLK_CTRL		0x390
> +#define APMU_PCIE_CLK_RES_CTRL_0	0x3cc
> +#define APMU_PCIE_CLK_RES_CTRL_1	0x3d4
> +#define APMU_PCIE_CLK_RES_CTRL_2	0x3dc
> +#define APMU_EMAC0_CLK_RES_CTRL		0x3e4
> +#define APMU_EMAC1_CLK_RES_CTRL		0x3ec
> +
> +/*	APBS clocks start	*/
> +
> +/* Frequency of pll{1,2} should not be updated at runtime */

Given the clock tables below only define a single entry,
I don't believe it's even possible to update pll{1,2} at
runtime.  Maybe the above comment could go away.  If
you keep it, I'd say "must not" rather than "should not."

> +static const struct ccu_pll_rate_tbl pll1_rate_tbl[] = {
> +	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
> +};
> +
> +static const struct ccu_pll_rate_tbl pll2_rate_tbl[] = {
> +	CCU_PLL_RATE(3000000000UL, 0x0050dd66, 0x3fe00000),
> +};
> +
> +static const struct ccu_pll_rate_tbl pll3_rate_tbl[] = {
> +	CCU_PLL_RATE(2457600000UL, 0x0050dd64, 0x330ccccd),
> +	CCU_PLL_RATE(3000000000UL, 0x0050dd66, 0x3fe00000),
> +	CCU_PLL_RATE(3200000000UL, 0x0050dd67, 0x43eaaaab),
> +};
> +

I'm going to restate this later.  But I think you can include
"static" in the definition of your CCU_*_DEFINE() macros,
because all defined clocks will be static.  I believe they
can also get the const qualifier here.

> +static CCU_PLL_DEFINE(pll1, pll1_rate_tbl,
> +		      APBS_PLL1_SWCR1, APBS_PLL1_SWCR3,
> +		      MPMU_POSR, POSR_PLL1_LOCK, CLK_SET_RATE_GATE);
> +static CCU_PLL_DEFINE(pll2, pll2_rate_tbl,
> +		      APBS_PLL2_SWCR1, APBS_PLL2_SWCR3,
> +		      MPMU_POSR, POSR_PLL2_LOCK, CLK_SET_RATE_GATE);
> +static CCU_PLL_DEFINE(pll3, pll3_rate_tbl,
> +		      APBS_PLL3_SWCR1, APBS_PLL2_SWCR3,
> +		      MPMU_POSR, POSR_PLL3_LOCK, CLK_SET_RATE_GATE);
> +
> +static CCU_GATE_FACTOR_DEFINE(pll1_d2, CCU_PARENT_HW(pll1),
> +			      APBS_PLL1_SWCR2,
> +			      BIT(1), 2, 1, 0);

You seem to try to use multiple lines for these definitions
to possibly aid readability.  I think that's a good idea in
general.  But it isn't really consistent (I'll point out
a few examples below), and so it doesn't always work.  For
many (maybe all), the first line is consistent, but the rest
seem to vary a bit.

These definitions are basically hardware definitions.  So
assuming you get them all correct initially, they'll never
change (for a given platform, like K1), and readability is
less of an issue.

This time around I haven't scrutinized these in that much
detail.  But I think--once you're confident the definitions
are correct--you can simply format all of these clock
definitions to fit within 80 columns, and save a bunch of
lines in the source file.

> +static CCU_GATE_FACTOR_DEFINE(pll1_d3, CCU_PARENT_HW(pll1),
> +			      APBS_PLL1_SWCR2,
> +			      BIT(2), 3, 1, 0);

. . .

> +static CCU_GATE_FACTOR_DEFINE(pll3_d8, CCU_PARENT_HW(pll3),
> +			      APBS_PLL3_SWCR2,
> +			      BIT(7), 8, 1, 0);
> +

Here (below) you define these PLL "factor" clocks all on one line.

> +static CCU_FACTOR_DEFINE(pll3_20, CCU_PARENT_HW(pll3_d8), 20, 1);
> +static CCU_FACTOR_DEFINE(pll3_40, CCU_PARENT_HW(pll3_d8), 10, 1);
> +static CCU_FACTOR_DEFINE(pll3_80, CCU_PARENT_HW(pll3_d8), 5, 1);
> +
> +/*	APBS clocks end		*/

Use spaces rather than tabs, above and below (and throughout).
Or...  Use tabs consistently.  Pick one.

> +
> +/*	MPMU clocks start	*/
> +static CCU_GATE_DEFINE(pll1_d8_307p2, CCU_PARENT_HW(pll1_d8),
> +		       MPMU_ACGR,
> +		       BIT(13), 0);

But here you define the "factor" clock on two lines.  I'm sure
this is for line length.  I'd say just define them all according
to line length--make them fit within 80 columns, but otherwise
don't bother with extra lines for readability.

> +static CCU_FACTOR_DEFINE(pll1_d32_76p8, CCU_PARENT_HW(pll1_d8_307p2),
> +			 4, 1);

. . .

> +
> +static const struct clk_parent_data apb_parents[] = {
> +	CCU_PARENT_HW(pll1_d96_25p6),
> +	CCU_PARENT_HW(pll1_d48_51p2),
> +	CCU_PARENT_HW(pll1_d96_25p6),
> +	CCU_PARENT_HW(pll1_d24_102p4),
> +};

I think you should have a blank line after this definition (and
all other similar ones in this file).  In some cases you have
no blank line above this sort of definition, and you should.

> +static CCU_MUX_DEFINE(apb_clk, apb_parents,
> +		      MPMU_APBCSCR,
> +		      0, 2,
> +		      0);
> +
> +static CCU_GATE_DEFINE(wdt_bus_clk, CCU_PARENT_HW(apb_clk),
> +		       MPMU_WDTPCR,
> +		       BIT(0),
> +		       0);
> +
> +static CCU_GATE_DEFINE(ripc_clk, CCU_PARENT_HW(apb_clk),
> +		       MPMU_RIPCCR,
> +		       0x1,
> +		       0);
> +/*	MPMU clocks end		*/
> +
> +/*	APBC clocks start	*/
> +static const struct clk_parent_data uart_clk_parents[] = {
> +	CCU_PARENT_HW(pll1_m3d128_57p6),
> +	CCU_PARENT_HW(slow_uart1_14p74),
> +	CCU_PARENT_HW(slow_uart2_48),
> +};

Here you're putting the control register and flags field on
separate lines.  I'd say just join them.

> +static CCU_MUX_GATE_DEFINE(uart0_clk, uart_clk_parents,
> +			   APBC_UART1_CLK_RST,
> +			   4, 3, BIT(1),
> +			   CLK_IS_CRITICAL);

. . .

> +struct spacemit_ccu_clk {
> +	int id;
> +	struct clk_hw *hw;
> +};
> +

The following array defines the clocks under what is matched
as "spacemit,k1-pll".  I know it's the "apbs" (APB Spare)
memory region, but I think it would be better to have the
name here match the compatible string.  Add a comment if
you want to make sure people understand the "PLL<->APBS"
relationship.

> +static struct spacemit_ccu_clk k1_ccu_apbs_clks[] = {
> +	{ CLK_PLL1,		&pll1.common.hw },
> +	{ CLK_PLL2,		&pll2.common.hw },
> +	{ CLK_PLL3,		&pll3.common.hw },

. . .

> +static int spacemit_ccu_register(struct device *dev,
> +				 struct regmap *regmap, struct regmap *lock_regmap,
> +				 const struct spacemit_ccu_clk *clks)
> +{
> +	const struct spacemit_ccu_clk *clk;
> +	int i, ret, max_id = 0;
> +
> +	for (clk = clks; clk->hw; clk++)
> +		max_id = max(max_id, clk->id);
> +
> +	struct clk_hw_onecell_data *clk_data;

The definition of clk_data belongs at the top of the function.

> +
> +	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, max_id + 1), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i <= max_id; i++)
> +		clk_data->hws[i] = ERR_PTR(-ENOENT);
> +
> +	for (clk = clks; clk->hw; clk++) {
> +		struct ccu_common *common = hw_to_ccu_common(clk->hw);
> +		const char *name = clk->hw->init->name;
> +
> +		common->regmap		= regmap;
> +		common->lock_regmap	= lock_regmap;
> +
> +		ret = devm_clk_hw_register(dev, clk->hw);
> +		if (ret) {
> +			dev_err(dev, "Cannot register clock %d - %s\n",
> +				i, name);
> +			return ret;
> +		}
> +
> +		clk_data->hws[clk->id] = clk->hw;
> +	}
> +
> +	clk_data->num = max_id + 1;
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
> +}
> +
> +static int k1_ccu_probe(struct platform_device *pdev)
> +{
> +	struct regmap *base_regmap, *lock_regmap = NULL;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	base_regmap = device_node_to_regmap(dev->of_node);
> +	if (IS_ERR(base_regmap))
> +		return dev_err_probe(dev, PTR_ERR(base_regmap),
> +				     "failed to get regmap\n");
> +

You should add a comment here explaining why there is a special
additional regmap for the PLL clock type (because it requires a
lock that's found in that that device node's memory region).

> +	if (of_device_is_compatible(dev->of_node, "spacemit,k1-pll")) {
> +		struct device_node *mpmu = of_parse_phandle(dev->of_node,
> +							    "spacemit,mpmu", 0);
> +		if (!mpmu)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Cannot parse MPMU region\n");
> +
> +		lock_regmap = device_node_to_regmap(mpmu);
> +		of_node_put(mpmu);
> +
> +		if (IS_ERR(lock_regmap))
> +			return dev_err_probe(dev, PTR_ERR(lock_regmap),
> +					     "failed to get lock regmap\n");
> +	}
> +
> +	ret = spacemit_ccu_register(dev, base_regmap, lock_regmap,
> +				    of_device_get_match_data(dev));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register clocks\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_k1_ccu_match[] = {
> +	{
> +		.compatible	= "spacemit,k1-pll",
> +		.data		= k1_ccu_apbs_clks,
> +	},
> +	{
> +		.compatible	= "spacemit,k1-syscon-mpmu",
> +		.data		= k1_ccu_mpmu_clks,
> +	},
> +	{
> +		.compatible	= "spacemit,k1-syscon-apbc",
> +		.data		= k1_ccu_apbc_clks,
> +	},
> +	{
> +		.compatible	= "spacemit,k1-syscon-apmu",
> +		.data		= k1_ccu_apmu_clks,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
> +
> +static struct platform_driver k1_ccu_driver = {
> +	.driver = {
> +		.name		= "spacemit,k1-ccu",
> +		.of_match_table = of_k1_ccu_match,
> +	},
> +	.probe	= k1_ccu_probe,
> +};
> +module_platform_driver(k1_ccu_driver);
> +
> +MODULE_DESCRIPTION("Spacemit K1 CCU driver");
> +MODULE_AUTHOR("Haylen Chu <heylenay@4d2.org>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/spacemit/ccu_common.h b/drivers/clk/spacemit/ccu_common.h
> new file mode 100644
> index 000000000000..494cde96fe3c
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_common.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_COMMON_H_
> +#define _CCU_COMMON_H_
> +
> +#include <linux/regmap.h>
> +

I'm not going to suggest it at this point, but it might
have worked out more nicely if you defined a top-level CCU
structure that contained a union of structs, one for each
type of clock (PLL, DDN, mix).

> +struct ccu_common {
> +	struct regmap *regmap;
> +	struct regmap *lock_regmap;

The lock_regmap is only used for PLL type clocks, right?
So it could be included in the PLL struct within the union
below?

> +
> +	union {
> +		/* For DDN and MIX */
> +		struct {
> +			u32 reg_ctrl;
> +			u32 reg_fc;
> +			u32 fc;

The fc field is a bit mask, and with a single bit set.

Other fields you define use the convention "mask" in the name
to indicate it is a bit mask.  So I suggest you name "fc" to
be "mask_fc" or "fc_mask" (but in the latter case, I'd rename
the registers to be "fc_reg" and "ctrl_reg"--you decide).

Since fc is a (nonzero) mask, you could use a zero fc value
to indicate that reg_fc is the same as reg_ctrl.

> +		};
> +
> +		/* For PLL */
> +		struct {
> +			u32 reg_swcr1;
> +			u32 reg_swcr2;

The reg_swcr2 is no longer used (now that you've dropped it
from the ccu_pll_rate_tbl structure).

> +			u32 reg_swcr3;

You define PLL_SWCR3_EN in "ccu_pll.c" to have value BIT(31).
that's good.  But you should define its inverse, to define
which bits in the reg_swcr3 field are the valid "magic" part.
In both cases, I would define them here in this file, where
the structure type is defined (not in "ccu_pll.c").

#define SPACEMIT_PLL_SWCR3_EN	(u32)BIT(31)
#define SPACEMIT_PLL_SWCR3_MASK	~(SPACEMIT_PLL_SWCR3_EN)

> +		};
> +	};
> +
> +	struct clk_hw hw;
> +};
> +
> +static inline struct ccu_common *hw_to_ccu_common(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ccu_common, hw);
> +}
> +

This isn't a huge deal, but I think since your functions here
are named ccu_*(), the first argument should be the CCU (or
ccu_common) structure.

> +#define ccu_read(reg, c, val)	regmap_read((c)->regmap, (c)->reg_##reg, val)

I commented before that you're not checking return values for
regmap_read() and regmap_write().  You said you don't expect
MMIO accesses to ever fail.

If we assume that, I'd like to see ccu_read() defined differently,
so that it returns a value (rather than taking the assigned-to
address as an argument).  To me, it makes it much easier to
understand in places it's used, making it more obvious an
assignment is getting made.

static inline u32 _ccu_read(struct ccu_common *common, u32 offset)
{
	u32 val;

	(void)regmap_read(common->regmap, offset>reg_##reg, &val);

	return val;
}
#define ccu_read(reg, c)	_ccu_read((c), (c)->reg_##reg)

	val = ccu_read(ctrl, &ddn->common);


> +#define ccu_update(reg, c, mask, val) \
> +	regmap_update_bits((c)->regmap, (c)->reg_##reg, mask, val)7
> +#define ccu_poll(reg, c, tmp, cond, sleep, timeout) \
> +	regmap_read_poll_timeout_atomic((c)->regmap, (c)->reg_##reg,	\
> +					tmp, cond, sleep, timeout)
> +
> +#endif /* _CCU_COMMON_H_ */
> diff --git a/drivers/clk/spacemit/ccu_ddn.c b/drivers/clk/spacemit/ccu_ddn.c
> new file mode 100644
> index 000000000000..ee187687d0c4
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_ddn.c
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type ddn
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/rational.h>
> +
> +#include "ccu_ddn.h"
> +
> +/*
> + * DDN stands for "Divider Denominator Numerator", it's M/N clock with a
> + * constant x2 factor. This clock hardware follows the equation below,
> + *
> + *	      numerator       Fin
> + *	2 * ------------- = -------
> + *	     denominator      Fout
> + *
> + * Thus, Fout could be calculated with,
> + *
> + *		Fin	denominator
> + *	Fout = ----- * -------------
> + *		 2	 numerator

Thank you for this clear explanation.  I still think the terminology
is weird but with the above it's at least understandable.

> + */
> +
> +static unsigned long clk_ddn_calc_best_rate(struct ccu_ddn *ddn,
> +					    unsigned long rate, unsigned long prate,
> +					    unsigned long *num, unsigned long *den)
> +{
> +	rational_best_approximation(rate, prate / 2,
> +				    ddn->den_mask, ddn->num_mask,
> +				    den, num);

Using rational_best_approximation() is excellent.  However I
think you have a bug, and I don't think the exact way you're
using it is clear (and might be wrong).

The bug is that the third and fourth arguments are the maximum
numerator and denominator, respectively.  You are passing mask
values, which in some sense represent the maximums.  However,
your masks are not always in the low-order bits.  Here is one
example:

static CCU_DDN_DEFINE(slow_uart1_14p74, pll1_d16_153p6,
                       MPMU_SUCCR,
                       GENMASK(28, 16), 16, GENMASK(12, 0), 0,
                       0);

The "_num_mask" argument to this macro is 0x1fff0000, and the
"_den_mask" is 0x00000fff.  The latter value (which gets passed
as the max_numerator argument to rational_best_approximation())
is fine, but the former is not.  So you need to shift both masks
right by their corresponding shift value.

Beyond that bug, rational_best_approximation() wants its first
two arguments to define the desired rate (as a fraction).  So
the desired rate should be the actual desired rate divided by 1
(rather than being divided by the half the parent rate).  So
this too might be a bug.

Maybe I'm misinterpreting this, but the bottom line is I'm
pretty certain this is not producing the correct numerator
and denominator that would produce the closest rate supported
by the hardware.

> +	return prate / 2 * *den / *num;

The above matches your explanation of how the output rate
is computed based on the "denominator" and "numerator".
You could encapsulate simply that in a function, given
tnat you used it here and another time below.

You might get slightly better precision by deferring the
divide-by-2.


> +}
> +
> +static long clk_ddn_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *prate)
> +{
> +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> +	unsigned long num = 0, den = 0;

There should be no need to initialize num and den to 0.

> +
> +	return clk_ddn_calc_best_rate(ddn, rate, *prate, &num, &den);
> +}
> +
> +static unsigned long clk_ddn_recalc_rate(struct clk_hw *hw, unsigned long prate)
> +{
> +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> +	unsigned int val, num, den;
> +
> +	ccu_read(ctrl, &ddn->common, &val);
> +
> +	num = (val & ddn->num_mask) >> ddn->num_shift;
> +	den = (val & ddn->den_mask) >> ddn->den_shift;

I have a strong preference to use a single mask value rather
than a shift and width (or in this case, shift and mask).
But  I know FIELD_GET() requires a constant mask value.

I'll add a comment below (in "ccu_ddn.h") that might address
my concerns a little bit in this case.

> +
> +	return prate / 2 * den / num;
> +}
> +
> +static int clk_ddn_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long prate)
> +{
> +	struct ccu_ddn *ddn = hw_to_ccu_ddn(hw);
> +	unsigned long num, den;
> +
> +	clk_ddn_calc_best_rate(ddn, rate, prate, &num, &den);
> +
> +	ccu_update(ctrl, &ddn->common,
> +		   ddn->num_mask | ddn->den_mask,
> +		   (num << ddn->num_shift) | (den << ddn->den_shift));
> +
> +	return 0;
> +}
> +
> +const struct clk_ops spacemit_ccu_ddn_ops = {
> +	.recalc_rate	= clk_ddn_recalc_rate,
> +	.round_rate	= clk_ddn_round_rate,
> +	.set_rate	= clk_ddn_set_rate,
> +};
> diff --git a/drivers/clk/spacemit/ccu_ddn.h b/drivers/clk/spacemit/ccu_ddn.h
> new file mode 100644
> index 000000000000..3746d084e1e7
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_ddn.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_DDN_H_
> +#define _CCU_DDN_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_ddn {
> +	struct ccu_common common;
> +	unsigned int num_mask;
> +	unsigned int num_shift;
> +	unsigned int den_mask;
> +	unsigned int den_shift;
> +};
> +
> +#define CCU_DDN_INIT(_name, _parent, _flags) \
> +	CLK_HW_INIT_HW(#_name, &_parent.common.hw, &spacemit_ccu_ddn_ops, _flags)
> +

In CCU_DDN_DEFINE(), both the numerator and denominator masks
consist of a contiguous block of 1 bits, with zero or more 0
bits to their left and right.  They are always constant (both
times it's used...).

For that reason, I'd like you to drop the _num_shift and _den_shift
arguments from this macro.  Instead, use __ffs(_num_mask) and
__ffs(_den_mask) when assigning the num_shift and den_shift field
values.

> +#define CCU_DDN_DEFINE(_name, _parent, _reg_ctrl,				\
> +		       _num_mask, _num_shift, _den_mask, _den_shift,		\
> +		       _flags)							\

As I mentioned earlier, I'm sure that every one of these defined
clocks should be both private (static) and constant (const).  I
recommend you include both of those keywords in these CCU_*_DEFINE()
macro definitions.

static const struct ccu_ddn _name = { \

Also, in the definitions of these CCU_*_DEFINE() macros later, you
align the struct below at the left column.  Do that here too.

> +	struct ccu_ddn _name = {						\
> +		.common = {							\
> +			.reg_ctrl = _reg_ctrl,					\
> +			.hw.init  = CCU_DDN_INIT(_name, _parent, _flags),	\
> +		},								\
> +		.num_mask = _num_mask,						\
> +		.num_shift = _num_shift,					\
> +		.den_mask = _den_mask,						\
> +		.den_shift = _den_shift,					\
> +	}
> +
> +static inline struct ccu_ddn *hw_to_ccu_ddn(struct clk_hw *hw)
> +{
> +	struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +	return container_of(common, struct ccu_ddn, common);
> +}
> +
> +extern const struct clk_ops spacemit_ccu_ddn_ops;
> +
> +#endif
> diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
> new file mode 100644
> index 000000000000..a5c13000e062
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_mix.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type mix(div/mux/gate/factor)
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_mix.h"
> +

I think the name of this constant should include "FC", and a
comment should indicate it is a number of microseconds.  "FC"
stands for "frequency change"; I think you should have a comment
explaining exactly what that means (somewhere).

> +#define MIX_TIMEOUT	10000
> +
> +static void ccu_gate_disable(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +
> +	ccu_update(ctrl, common, mix->gate.mask, 0);
> +}

Maybe drop the second local variable and do:

	ccu_update(ctrl, &mix->common, mix->gate.mask, 0);

And this can be done several times below.

> +
> +static int ccu_gate_enable(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_gate_config *gate = &mix->gate;
> +
> +	ccu_update(ctrl, common, gate->mask, gate->mask);
> +
> +	return 0;
> +}
> +
> +static int ccu_gate_is_enabled(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	u32 tmp;
> +
> +	ccu_read(ctrl, common, &tmp);
> +

The next line won't necessarily work.  The gate mask
value in a few cases contains more than one set bit
(rtc_clk is an exmaple).  Therefore this will return
true even if just one of those bits is set.  This is
most likely a bug.

This needs to be:

	return (tmp & mix->gete.mask) == mix->gate.mask;

> +	return !!(tmp & mix->gate.mask);
> +}
> +
> +static unsigned long ccu_factor_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +
> +	return parent_rate * mix->factor.mul / mix->factor.div;
> +}
> +
> +static unsigned long ccu_div_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_div_config *div = &mix->div;
> +	unsigned long val;
> +	u32 reg;
> +
> +	ccu_read(ctrl, common, &reg);
> +
> +	val = reg >> div->shift;
> +	val &= (1 << div->width) - 1;
> +
> +	val = divider_recalc_rate(hw, parent_rate, val, NULL, 0, div->width);
> +
> +	return val;
> +}
> +
> +static int ccu_mix_trigger_fc(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;

You don't use the mix pointer, so you can just do:

	struct ccu_common *common = hw_to_ccu_common(hw);

> +	unsigned int val = 0;
> +

I'm pretty sure you don't need to initialze val to 0, given
you're assuming regmap_read() won't return errors.

Have this function return 0 immediately if there is no
frequency control register/mask:

	if (!common->fc_mask)
		return 0;

This will simplify the callers.
		
> +	ccu_update(fc, common, common->fc, common->fc);
> +
> +	return ccu_poll(fc, common, val, !(val & common->fc),
> +			5, MIX_TIMEOUT);

You should add this above, where you define MIX_TIMEOUT, and
use it here.

#define CCU_FC_MIX_DELAY	5	/* microseconds */

> +}
> +
> +static long ccu_factor_round_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long *prate)
> +{
> +	return ccu_factor_recalc_rate(hw, *prate);
> +}
> +
> +static int ccu_factor_set_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	return 0;
> +}
> +
> +static unsigned long
> +ccu_mix_calc_best_rate(struct clk_hw *hw, unsigned long rate,
> +		       struct clk_hw **best_parent,
> +		       unsigned long *best_parent_rate,
> +		       u32 *div_val)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	unsigned int parent_num = clk_hw_get_num_parents(hw);
> +	struct ccu_div_config *div = &mix->div;
> +	u32 div_max = 1 << div->width;
> +	unsigned long best_rate = 0;
> +
> +	for (int i = 0; i < parent_num; i++) {
> +		struct clk_hw *parent = clk_hw_get_parent_by_index(hw, i);
> +		unsigned long parent_rate;
> +
> +		if (!parent)
> +			continue;
> +
> +		parent_rate = clk_hw_get_rate(parent);
> +
> +		for (int j = 1; j <= div_max; j++) {
> +			unsigned long tmp = DIV_ROUND_UP_ULL(parent_rate, j);

I might have asked this before.  Why round up?  Why not
round closest?

> +
> +			if (abs(tmp - rate) < abs(best_rate - rate)) {
> +				best_rate = tmp;
> +
> +				if (div_val)
> +					*div_val = j - 1;
> +
> +				if (best_parent) {
> +					*best_parent      = parent;
> +					*best_parent_rate = parent_rate;
> +				}
> +			}
> +		}
> +	}
> +
> +	return best_rate;
> +}
> +
> +static int ccu_mix_determine_rate(struct clk_hw *hw,
> +				  struct clk_rate_request *req)
> +{
> +	req->rate = ccu_mix_calc_best_rate(hw, req->rate,
> +					   &req->best_parent_hw,
> +					   &req->best_parent_rate,
> +					   NULL);
> +	return 0;
> +}
> +
> +static int ccu_mix_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_div_config *div = &mix->div;
> +	int ret = 0, tmp = 0;

No need to initialize ret or tmp.

> +	u32 current_div, target_div;
> +
> +	ccu_mix_calc_best_rate(hw, rate, NULL, NULL, &target_div);
> +
> +	ccu_read(ctrl, common, &tmp);
> +
> +	current_div = tmp >> div->shift;
> +	current_div &= (1 << div->width) - 1;
> +
> +	if (current_div == target_div)
> +		return 0;
> +
> +	tmp = GENMASK(div->width + div->shift - 1, div->shift);
> +
> +	ccu_update(ctrl, common, tmp, target_div << div->shift);
> +
> +	if (common->reg_fc)
> +		ret = ccu_mix_trigger_fc(hw);

Drop the test for reg_fc here, and hide those details
inside the called function.  Then:

	return ccu_mix_trigger_fc(hw);

> +
> +	return ret;
> +}
> +
> +static u8 ccu_mux_get_parent(struct clk_hw *hw)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_mux_config *mux = &mix->mux;
> +	u32 reg;
> +	u8 parent;
> +
> +	ccu_read(ctrl, common, &reg);
> +
> +	parent = reg >> mux->shift;
> +	parent &= (1 << mux->width) - 1;
> +
> +	return parent;
> +}
> +
> +static int ccu_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	struct ccu_mix *mix = hw_to_ccu_mix(hw);
> +	struct ccu_common *common = &mix->common;
> +	struct ccu_mux_config *mux = &mix->mux;
> +	int ret = 0;
> +	u32 mask;
> +

I'm not sure it will ever happen, but if index is out of range
this most likely won't do the right thing.

	if (WARN_ON(index >= 1 << mux->width))
		return -EINVAL;

> +	mask = GENMASK(mux->width + mux->shift - 1, mux->shift);
> +
> +	ccu_update(ctrl, common, mask, index << mux->shift);
> +
> +	if (common->reg_fc)
> +		ret = ccu_mix_trigger_fc(hw);
> +
> +	return ret;
> +}
> +

I think your naming for these should follow a pattern, for
example:
   gate then (factor or div) then mux then fc


> +const struct clk_ops spacemit_ccu_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +};
> +
> +const struct clk_ops spacemit_ccu_factor_ops = {
> +	.round_rate	= ccu_factor_round_rate,
> +	.recalc_rate	= ccu_factor_recalc_rate,
> +	.set_rate	= ccu_factor_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_mux_ops = {
> +	.determine_rate = ccu_mix_determine_rate,
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_ops = {
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_gate_factor_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.round_rate	= ccu_factor_round_rate,
> +	.recalc_rate	= ccu_factor_recalc_rate,
> +	.set_rate	= ccu_factor_set_rate,
> +};
> +

If you follow the pattern I said above, this would be
spacemit_ccu_gate_mux_ops().

(And so on.)

> +const struct clk_ops spacemit_ccu_mux_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_mux_gate_ops = {
> +	.disable	= ccu_gate_disable,
> +	.enable		= ccu_gate_enable,
> +	.is_enabled	= ccu_gate_is_enabled,
> +
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> +
> +const struct clk_ops spacemit_ccu_div_mux_ops = {
> +	.get_parent	= ccu_mux_get_parent,
> +	.set_parent	= ccu_mux_set_parent,
> +
> +	.determine_rate = ccu_mix_determine_rate,
> +	.recalc_rate	= ccu_div_recalc_rate,
> +	.set_rate	= ccu_mix_set_rate,
> +};
> diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
> new file mode 100644
> index 000000000000..a3aa292d073d
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_mix.h
> @@ -0,0 +1,246 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_MIX_H_
> +#define _CCU_MIX_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +
> +struct ccu_gate_config {
> +	u32 mask;

Add a comment indicating this mask can contain more than just
one set bit.

> +};
> +
> +struct ccu_factor_config {
> +	u32 div;
> +	u32 mul;
> +};
> +
> +struct ccu_mux_config {
> +	u8 shift;
> +	u8 width;

There's a small chance that these being defined with u8 will
require them to be promoted to u32 where used.  I think the
u8 is just fine, but you might need to be careful.

> +};
> +
> +struct ccu_div_config {
> +	u8 shift;
> +	u8 width;
> +};
> +
> +struct ccu_mix {
> +	struct ccu_factor_config factor;
> +	struct ccu_gate_config gate;
> +	struct ccu_div_config div;
> +	struct ccu_mux_config mux;
> +	struct ccu_common common;
> +};
> +

I suggest aligning the "{" in the next few lines.

> +#define CCU_GATE_INIT(_mask) { .mask = _mask }
> +#define CCU_FACTOR_INIT(_div, _mul) { .div = _div, .mul = _mul }
> +#define CCU_MUX_INIT(_shift, _width) { .shift = _shift, .width = _width }
> +#define CCU_DIV_INIT(_shift, _width) { .shift = _shift, .width = _width }
> +

I think you should define these next two with their types.

> +#define CCU_PARENT_HW(_parent)		{ .hw = &_parent.common.hw }
> +#define CCU_PARENT_NAME(_name)		{ .fw_name = #_name }
> +
#define CCU_PARENT_HW(_parent) \
	(struct clk_parent_data){ .hw = &_parent.common.hw }

> +#define CCU_MIX_INITHW(_name, _parent, _ops, _flags)			\
> +	(&(struct clk_init_data) {					\

I'm pretty sure the left parenthesis above and its matching
right parenthesis below are not needed.

> +		.flags		= _flags,				\
> +		.name		= #_name,				\

If the type is defined above, you don't need to cast it here.
Also the curly braces around _parent look strange to me.  The
parent_data field is a pointer, and ideally there should be
no need to use a type cast here.

> +		.parent_data	= (const struct clk_parent_data[])	\
> +					{ _parent },			\
> +		.num_parents	= 1,					\
> +		.ops		= &_ops,				\
> +	})
> +
> +#define CCU_MIX_INITHW_PARENTS(_name, _parents, _ops, _flags)		\
> +	CLK_HW_INIT_PARENTS_DATA(#_name, _parents, &_ops, _flags)
> +

Many/most of the other CCU_*_DEFINE() macros use the name
_ctrl_reg for the register.  I suggest you use that here
(and everywhere, for consistency).

> +#define CCU_GATE_DEFINE(_name, _parent, _reg, _gate_mask, _flags)		\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.common	= {								\
> +		.reg_ctrl	= _reg,						\

Why do you have a tab before the equal sign here?  (But not
elsewhere?)  Whatever you decide, be consistent.

> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_gate_ops, _flags),	\
> +	}									\
> +}
> +
> +#define CCU_FACTOR_DEFINE(_name, _parent, _div, _mul)				\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
> +	.common = {								\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_factor_ops, 0),		\
> +	}									\
> +}
> +
> +#define CCU_MUX_DEFINE(_name, _parents, _reg, _shift, _width, _flags)		\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_mux_ops,	_flags),\
> +	}									\
> +}
> +
> +#define CCU_DIV_DEFINE(_name, _parent, _reg, _shift, _width, _flags)		\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.div	= CCU_DIV_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_div_ops, _flags)		\
> +	}									\
> +}
> +
> +#define CCU_GATE_FACTOR_DEFINE(_name, _parent,					\
> +			       _reg,						\
> +			       _gate_mask,					\
> +			       _div, _mul,					\
> +			       _flags)						\

static const struct ccu_mix _name = { \

I believe the value of _flags is always zero, so that argument
could be eliminated (it can be added back in the future if it's
ever needed).

There are only two cases where the value of _mul is different
from 1.  You could define a slightly different macro for those
cases, and for this, remove the multiplier argument.

> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.factor	= CCU_FACTOR_INIT(_div, _mul),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_gate_factor_ops, _flags)	\
> +	}									\
> +}
> +
> +#define CCU_MUX_GATE_DEFINE(_name, _parents,					\
> +			    _reg,						\
> +			    _shift, _width,					\
> +			    _gate_mask,						\
> +			    _flags)						\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.mux	= CCU_MUX_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_mux_gate_ops,	\
> +						  _flags),			\
> +	}									\
> +}
> +
> +#define CCU_DIV_GATE_DEFINE(_name, _parent,					\
> +			    _reg,						\
> +			    _shift, _width,					\
> +			    _gate_mask,						\
> +			    _flags)						\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.div	= CCU_DIV_INIT(_shift, _width),					\
> +	.common = {								\
> +		.reg_ctrl	= _reg,						\
> +		.hw.init = CCU_MIX_INITHW(_name, _parent,			\
> +					  spacemit_ccu_div_gate_ops, _flags),	\
> +	}									\
> +}
> +
> +#define CCU_DIV_MUX_GATE_DEFINE(_name, _parents,				\
> +				_reg_ctrl,					\
> +				_mshift, _mwidth, _muxshift, _muxwidth,		\
> +				_gate_mask,					\
> +				_flags)						\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common	= {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_div_mux_gate_ops,\
> +						  _flags),			\
> +	},									\
> +}
> +

I think I might have said this elsewhere;  use _fc_mask
(or something similar) to define what you call _fc here.

> +#define CCU_DIV_SPLIT_FC_MUX_GATE_DEFINE(_name, _parents,			\
> +					 _reg_ctrl, _reg_fc,			\
> +					 _mshift, _mwidth,			\
> +					 _fc,					\
> +					 _muxshift, _muxwidth,			\
> +					 _gate_mask,				\
> +					 _flags)				\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.gate	= CCU_GATE_INIT(_gate_mask),					\
> +	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common = {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.reg_fc		= _reg_fc,					\
> +		.fc		= _fc,						\

In all cases, these FC masks have a single bit set; this is
something I think is worth mentioning in a comment.

> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_div_mux_gate_ops,\
> +						  _flags),			\
> +	},									\
> +}
> +
> +#define CCU_DIV_FC_MUX_GATE_DEFINE(_name, _parents,				\
> +				   _reg_ctrl,					\
> +				   _mshift, _mwidth,				\
> +				   _fc,						\
> +				   _muxshift, _muxwidth,			\
> +				   _gate_mask, _flags)		\
> +CCU_DIV_SPLIT_FC_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl, _reg_ctrl,		\
> +				 _mshift, _mwidth, _fc, _muxshift, _muxwidth,		\
> +				 _gate_mask, _flags)
> +
> +#define CCU_DIV_FC_MUX_DEFINE(_name, _parents,					\
> +			      _reg_ctrl,					\
> +			      _mshift, _mwidth,					\
> +			      _fc,						\
> +			      _muxshift, _muxwidth,				\
> +			      _flags)						\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.div	= CCU_DIV_INIT(_mshift, _mwidth),				\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common = {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.reg_fc		= _reg_ctrl,					\

I suggested elsewhere that you could use a non-zero FC mask
to indicate the FC register is the same as the reg_ctrl
register.  (Despite my repeated suggestion, what you're
doing already is fine...)

> +		.fc		= _fc,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_div_mux_ops,	\
> +						  _flags),			\
> +	},									\
> +}
> +
> +#define CCU_MUX_FC_DEFINE(_name, _parents,					\
> +			  _reg_ctrl,						\
> +			  _fc,							\
> +			  _muxshift, _muxwidth,					\
> +			  _flags)						\

static const struct ccu_mix _name = { \

> +struct ccu_mix _name = {							\
> +	.mux	= CCU_MUX_INIT(_muxshift, _muxwidth),				\
> +	.common = {								\
> +		.reg_ctrl	= _reg_ctrl,					\
> +		.reg_fc		= _reg_ctrl,					\
> +		.fc		= _fc,						\
> +		.hw.init = CCU_MIX_INITHW_PARENTS(_name, _parents,		\
> +						  spacemit_ccu_mux_ops,	_flags)	\
> +	},									\
> +}
> +
> +static inline struct ccu_mix *hw_to_ccu_mix(struct clk_hw *hw)
> +{
> +	struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +	return container_of(common, struct ccu_mix, common);
> +}
> +

I think you can define each ops variable on its own line.

> +extern const struct clk_ops spacemit_ccu_gate_ops, spacemit_ccu_factor_ops;
> +extern const struct clk_ops spacemit_ccu_mux_ops, spacemit_ccu_div_ops;
> +
> +extern const struct clk_ops spacemit_ccu_gate_factor_ops;
> +extern const struct clk_ops spacemit_ccu_div_gate_ops;
> +extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> +extern const struct clk_ops spacemit_ccu_div_mux_ops;
> +
> +extern const struct clk_ops spacemit_ccu_div_mux_gate_ops;
> +#endif /* _CCU_DIV_H_ */
> diff --git a/drivers/clk/spacemit/ccu_pll.c b/drivers/clk/spacemit/ccu_pll.c
> new file mode 100644
> index 000000000000..9df2149f6c98
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_pll.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Spacemit clock type pll
> + *
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/regmap.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_pll.h"
> +

Name this just PLL_TIMEOUT, or maybe CCU_PLL_TIMEOUT, and
indicate in a comment that it is a period in microseconds.

> +#define PLL_DELAY_TIME	3000

You should also define this, as done earlier when polling
for the frequency change:

#define PLL_DELAY		5	/* microseconds */

> +#define PLL_SWCR3_EN	BIT(31)

Define this with the type; otherwise it's possible to get
warnings when you bitwise invert it.

#define PLL_SWCR3_EN	(u32)BIT(31)

> +
> +static int ccu_pll_is_enabled(struct clk_hw *hw)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);

	struct ccu_common *common = hw_to_ccu_common(hw);

> +	u32 tmp;
> +
> +	ccu_read(swcr3, &p->common, &tmp);
> +
> +	return tmp & PLL_SWCR3_EN;

	return !!(tmp & PLL_SWCR3_EN);
> +}
> +
> +/* frequency unit Mhz, return pll vco freq */
> +static unsigned long ccu_pll_get_vco_freq(struct clk_hw *hw)
> +{
> +	const struct ccu_pll_rate_tbl *pll_rate_table;
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;
> +	u32 swcr1, swcr3, size;
> +	int i;
> +
> +	ccu_read(swcr1, common, &swcr1);
> +	ccu_read(swcr3, common, &swcr3);

You are masking off the EN bit, but you should really be
using a mask defining which bits are valid instead.  As
I said earlier:

#define SPACEMIT_PLL_SWCR3_MASK	~(SPACEMIT_PLL_SWCR3_EN)

> +	swcr3 &= ~PLL_SWCR3_EN;

	swcr3 &= SPACEMIT_PLL_SWCR3_MASK;
> +
> +	pll_rate_table = p->pll.rate_tbl;
> +	size = p->pll.tbl_size;
> +
> +	for (i = 0; i < size; i++) {
> +		if (pll_rate_table[i].swcr1 == swcr1 &&
> +		    pll_rate_table[i].swcr3 == swcr3)
> +			return pll_rate_table[i].rate;
> +	}
> +

I have a general question here.  Once you set one of these
clock rates, it will always use one of the rates defined
in the table.

But what about initially?  Could the hardware start in a
state that is not defined by this code?  Do you *set* the
rate initially?  Should you (at least the first time the
clock is prepared/enabled)?

> +	WARN_ON_ONCE(1);

Maybe WARN_ONCE(true, "msg");

> +
> +	return 0;
> +}
> +
> +static int ccu_pll_enable(struct clk_hw *hw)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;
> +	unsigned int tmp;
> +	int ret;
> +

Get rid of ret (see below).

Will clk_ops->enable() ever be called when it's already
enabled?  (If it won't, this isn't needed.  If it will,
this checks the hardware, which is good.)

> +	if (ccu_pll_is_enabled(hw))
> +		return 0;
> +
> +	ccu_update(swcr3, common, PLL_SWCR3_EN, PLL_SWCR3_EN);
> +
> +	/* check lock status */
> +	ret = regmap_read_poll_timeout_atomic(common->lock_regmap,
> +					      p->pll.reg_lock,
> +					      tmp,
> +					      tmp & p->pll.lock_enable_bit,
> +					      5, PLL_DELAY_TIME);

Just:

	return regmap_read_poll_timeout_atomic(...);

I note that you call this here, but you hide the call
to regmap_read_poll_timeout_atomic() behind the macro
ccu_poll().  And ccu_poll() (used for the FC bit) is
also only called once.

I suggest you get rid of regmap_poll() and just open-code
it.

(You use ccu_read() and ccu_update() numerous times, so
your "saving some characters" is justified.)

> +
> +	return ret;
> +}
> +
> +static void ccu_pll_disable(struct clk_hw *hw)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;

	struct ccu_common *common = hw_to_ccu_common(hw);

> +
> +	ccu_update(swcr3, common, PLL_SWCR3_EN, 0);
> +}
> +
> +/*
> + * PLLs must be gated before changing rate, which is ensured by
> + * flag CLK_SET_RATE_GATE.
> + */
> +static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +			    unsigned long parent_rate)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_common *common = &p->common;
> +	struct ccu_pll_config *params = &p->pll;
> +	const struct ccu_pll_rate_tbl *entry = NULL;
> +	int i;
> +
> +	for (i = 0; i < params->tbl_size; i++) {
> +		if (rate == params->rate_tbl[i].rate) {
> +			entry = &params->rate_tbl[i];
> +			break;
> +		}
> +	}
> +
> +	if (WARN_ON_ONCE(!entry))
> +		return -EINVAL;
> +

The next line contains a bug.  The third argument defines
a mask of which bits get updated.  Therefore, any zero bits
in that mask will *not* get updated in the swcr1 register
even if they should be.

Example:
Old SWCR1:	0x01234567
New SWCR1:	0x00112233

Updated:	0x01336777
Want:		0x00112233

You should either define ccu_write() (my preference), or
you you should call:

	ccu_update(swcr1, common, ~0, entry->swcr1);


> +	ccu_update(swcr1, common, entry->swcr1, entry->swcr1);

You should use SPACEMIT_PLL_SWCR3_MASK below.  No
cast should be needed (define the symbol with one).

> +	ccu_update(swcr3, common, (u32)~PLL_SWCR3_EN, entry->swcr3);
> +
> +	return 0;
> +}
> +
> +static unsigned long ccu_pll_recalc_rate(struct clk_hw *hw,
> +					 unsigned long parent_rate)
> +{
> +	return ccu_pll_get_vco_freq(hw);
> +}
> +
> +static long ccu_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long *prate)
> +{
> +	struct ccu_pll *p = hw_to_ccu_pll(hw);
> +	struct ccu_pll_config *params = &p->pll;
> +	unsigned int i;
> +

I'm pretty sure I mentioned this before.  If you cant find a
matching rate, you return the closest rate *less than* what
is requested, which might not be as close as the closest
rate *greater than* the requested rate.

In ccu_mix_calc_best_rate() you actually take this into account
(though you use DIV_ROUND_UP_ULL() there too).

> +	for (i = 0; i < params->tbl_size; i++) {
> +		if (params->rate_tbl[i].rate > rate) {
> +			i--;
> +			break;
> +		}
> +	}
> +
> +	return rate;
> +}
> +
> +const struct clk_ops spacemit_ccu_pll_ops = {
> +	.enable		= ccu_pll_enable,
> +	.disable	= ccu_pll_disable,
> +	.set_rate	= ccu_pll_set_rate,
> +	.recalc_rate	= ccu_pll_recalc_rate,
> +	.round_rate	= ccu_pll_round_rate,
> +	.is_enabled	= ccu_pll_is_enabled,
> +};
> +
> diff --git a/drivers/clk/spacemit/ccu_pll.h b/drivers/clk/spacemit/ccu_pll.h
> new file mode 100644
> index 000000000000..c6a3a5cce995
> --- /dev/null
> +++ b/drivers/clk/spacemit/ccu_pll.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024 SpacemiT Technology Co. Ltd
> + * Copyright (c) 2024 Haylen Chu <heylenay@4d2.org>
> + */
> +
> +#ifndef _CCU_PLL_H_
> +#define _CCU_PLL_H_
> +
> +#include <linux/clk-provider.h>
> +
> +#include "ccu_common.h"
> +

You should add a comment above this structure definition explaining
how exactly it's used.  Namely that SWCR1 and SWCR3 contain encoded
values, and each particular pair of these values creates an output
clock rate that's indicated.  Also note that while all bits in SWCR1
are valid, only the bottom 31 bits of SWCR3 are (its top bit is
used for locking).

> +struct ccu_pll_rate_tbl {
> +	unsigned long rate;
> +	u32 swcr1;
> +	u32 swcr3;
> +};
> +
> +struct ccu_pll_config {
> +	const struct ccu_pll_rate_tbl *rate_tbl;
> +	u32 tbl_size;

I dislike "size" as a name for something that is a "count".
To me, "size" is a number of bytes.

You (and clock code) use "num" elsewhere, but either way,
please use something different from "size" here.

> +	u32 reg_lock;
> +	u32 lock_enable_bit;

Use "lock_mask" here, hopefully matching a pattern you use
elsewhere that you define a register and a bit mask.  These
masks (all three places this is used) all have just one bit set.

> +};
> +
> +#define CCU_PLL_RATE(_rate, _swcr1, _swcr3) \
> +	{									\
> +		.rate	= _rate,							\
> +		.swcr1	= _swcr1,						\
> +		.swcr3	= _swcr3,						\
> +	}
> +
> +struct ccu_pll {
> +	struct ccu_pll_config	pll;
> +	struct ccu_common	common;
> +};
> +
> +#define CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit) \
> +	{									\
> +		.rate_tbl	 = _table,					\
> +		.tbl_size	 = ARRAY_SIZE(_table),				\
> +		.reg_lock	 = (_reg_lock),					\
> +		.lock_enable_bit = (_lock_enable_bit),				\
> +	}
> +
> +#define CCU_PLL_HWINIT(_name, _flags)						\
> +	(&(struct clk_init_data) {						\
> +		.name		= #_name,					\
> +		.ops		= &spacemit_ccu_pll_ops,			\
> +		.parent_data	= &(struct clk_parent_data) { .index = 0 },	\
> +		.num_parents	= 1,						\
> +		.flags		= _flags,					\
> +	})
> +
> +#define CCU_PLL_DEFINE(_name, _table, _reg_swcr1, _reg_swcr3,			\
> +		       _reg_lock, _lock_enable_bit, _flags)			\

static const struct ccu_pll _name = { \

					-Alex

> +	struct ccu_pll _name = {						\
> +		.pll	= CCU_PLL_CONFIG(_table, _reg_lock, _lock_enable_bit),	\
> +		.common = {							\
> +			.reg_swcr1	= _reg_swcr1,				\
> +			.reg_swcr3	= _reg_swcr3,				\
> +			.hw.init	= CCU_PLL_HWINIT(_name, _flags)		\
> +		}								\
> +	}
> +
> +static inline struct ccu_pll *hw_to_ccu_pll(struct clk_hw *hw)
> +{
> +	struct ccu_common *common = hw_to_ccu_common(hw);
> +
> +	return container_of(common, struct ccu_pll, common);
> +}
> +
> +extern const struct clk_ops spacemit_ccu_pll_ops;
> +
> +#endif
	

