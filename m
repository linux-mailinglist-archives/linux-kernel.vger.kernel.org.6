Return-Path: <linux-kernel+bounces-520470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C01DBA3AA29
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE0B3164286
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0F1F1505;
	Tue, 18 Feb 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ql67i4xN"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17A91F03F8;
	Tue, 18 Feb 2025 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911334; cv=none; b=sIAQyPdr13SpVRuHpBTR8a2XCINg57okWpa1u/n5dndIc67C75W0R11bcUXGzZlh2/6qGwsNbgr68hIUFJtZ4VaHfb7P7gPyakWJfnUOBA8KJoSZUUzE6ll+NF7s9qh/HYMVPnhlvcjyjwxf6BVVbYek+UsMo7U3xWDCgqi9efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911334; c=relaxed/simple;
	bh=dVbvaG3fsqJHHU8vPdLGsaL3IjVfJ6KHft9lsuSZP2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tufS70WJzd+38PIomIafcmTVTxbh746oAS4DR0HN1QVDeUbbqlIbqmf8ipNVOfHitUyxTqfq+RFlfoDjcNfH5M2EBFRcbZGu7dKo195iKq3DdgiimeW0yP/JwF7b5Zxz265/cHVq3Mttxm0qxl3a1RN8Lcb4DavUWNEgAdbqEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ql67i4xN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43964e79314so55464865e9.3;
        Tue, 18 Feb 2025 12:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739911329; x=1740516129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cG0kJOqvQdLpEmchGNMaA8OFTfI/RCLor80J1PgVfZs=;
        b=Ql67i4xNfImCbPzQqyqXnpfNyCGwRcS/ujVFmI9kRcKL+mvo2VWewIhYkQbXNbsxEI
         /DzWPkbJDY3bgxLxXtdZj2dCx9PZW/KoM1H3db6hLe7WQwcEXggm4fUv+N/lTj2ez4Cb
         8vmLILfLzc+ZGafGiEbijBFwHWrnqUgkoSm2jeLQ1xY0PGm3cq4XEcMxBOIPbenEv32m
         ocqjhcCkf38EHJIjjIiJciE5GZaKp2xv+5XTZ2LikyLgg5/amiA3i2uJFegQIG20iJKE
         QqN7vB2RjPfJTQefFbQFXBBiqYMcIeqWcHCCqgwC6QzRzA9e6eDDffoJ5UElyNkZr+Gg
         rwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739911329; x=1740516129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cG0kJOqvQdLpEmchGNMaA8OFTfI/RCLor80J1PgVfZs=;
        b=AKP1/Qpzql29VMMz/lTg7E8dUufVZpQjy3U/D0yBRAlwmnDJiNQKlj9BbF4Pw0DZa4
         8mCbsFJWTCq5gFCYz6Z8hMpcGyrl1veLoXLIusz+E0aqjRVP0kJ8+eGsGvGak9m3aDop
         wTFKsoEigcjzVIgIvbpTRTCofQmRxuxbhldbjJXjNMvWxsFSUNyoMsXN7g1m2fHZ9otq
         uGlSsuRB/w9+QUN0Ulf7uQMF++vft+bNd+d0osOfA/pb0Pggw+cYzgA7pxqLgsYpHE0f
         2ccjxBPo9VbNxXxdOuIy8E0MMCrxCFK3FPcXLWl84RBq5t+sQ8RxuKrOFrqFw/RSGMOi
         Oj/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUguvDfoqbP1G/BuDcJNOqc5mjBRXgR5wN17fQLdAW1WYgnohKXNXaDhBWBSn9vhDZf18UIy1uDh3EH@vger.kernel.org, AJvYcCVWEjqVjmWwLrKFqbxIdkQERzeC8D23tk4v7p1jNiGW++9fldeJOq7N6UuuErUZl9wgmlnMK8Hm3hjP@vger.kernel.org, AJvYcCWbwg5iR4gjdSaqPUuKC6cIhM/GnKVO1SlMGmmowUfPoOWEBl9DC/F2d0uYjaTeXW9Juhlsa4VyccnXfDVC@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEKMsLQxoqCz4YEAPAB6Rgih9BGrfq/uqsBUOnwUpSbg9cRgQ
	LdEratlUcjRp5D+w9YhYrKHqZWNTjWQ326lgEZc6dnrguvjLKlje
X-Gm-Gg: ASbGnctJtg/Z16gR/z1dKyidqTvGm9OAB5Ukuel6V3hOOYT2Qdq4CH1n0k/IrQnXOrX
	XJkjTOVedHAWsPJc9e3RpKiEdoZQtLtKZWK27gyKRvJ4Rc2fuI0xnGz6ZIzoGGMn1O26rOwrJ1K
	Gc9rfq4YNrx9zveIvfGtoGNRWRx7TI5ZUGUnHKw+60xPytwZMooH6fRSjtRV1T2k6ER9jWSIsWN
	68G0/hLSOZYgbAfJpUFQvxoQfN2pQZEtL/bLE29SZQLGt09GNQNaX9CjtsxlCPkiTRQualwEYoQ
	+UoOAWaSW5QLo6bG/VeKAzLBtzjDMYLpcrncAAEUv2R5GmGk3RQnVxvYNAE0VAB6mZI=
X-Google-Smtp-Source: AGHT+IFO+5jiKhBwvsQewk5Wnf2OG4t+xe1dOa8s/zAgEuRRg3bDgy81GqKdu8oDzQJEtaaIwQMURQ==
X-Received: by 2002:a05:6000:178f:b0:38d:e0be:71a3 with SMTP id ffacd0b85a97d-38f34167cd9mr16618041f8f.54.1739911328838;
        Tue, 18 Feb 2025 12:42:08 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4123sm16371069f8f.17.2025.02.18.12.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 12:42:08 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 15/15] clk: sunxi-ng: add support for the A523/T527 PRCM CCU
Date: Tue, 18 Feb 2025 21:42:06 +0100
Message-ID: <3136553.CbtlEUcBR6@jernej-laptop>
In-Reply-To: <20250214125359.5204-16-andre.przywara@arm.com>
References:
 <20250214125359.5204-1-andre.przywara@arm.com>
 <20250214125359.5204-16-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 14. februar 2025 ob 13:53:59 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> The A523/T527 SoCs have clock/reset controls in the PRCM part, like many
> previous SoCs. For a change, the whole PRCM is documented in the A523
> manual, including the system bus tree, so we can describe all those
> clocks correctly based on that. There layout seems to be derived from
> the H6 and H616 PRCM CCUs, though there are more clocks, and many clocks
> have subtly changed.
>=20
> Describe all the mod and gate clocks, including the three bus clocks
> (R_AHB, R_APB0, and R_APB1).
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig             |   5 +
>  drivers/clk/sunxi-ng/Makefile            |   2 +
>  drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c | 245 +++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h |  14 ++
>  4 files changed, 266 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h
>=20
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 04efbda847cf9..5830a9d87bf25 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -57,6 +57,11 @@ config SUN55I_A523_CCU
>  	default y
>  	depends on ARM64 || COMPILE_TEST
> =20
> +config SUN55I_A523_R_CCU
> +	tristate "Support for the Allwinner A523/T527 PRCM CCU"
> +	default y
> +	depends on ARM64 || COMPILE_TEST
> +
>  config SUN4I_A10_CCU
>  	tristate "Support for the Allwinner A10/A20 CCU"
>  	default y
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index 01a887f7824bb..82e471036de69 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_SUN50I_H6_CCU)	+=3D sun50i-h6-ccu.o
>  obj-$(CONFIG_SUN50I_H6_R_CCU)	+=3D sun50i-h6-r-ccu.o
>  obj-$(CONFIG_SUN50I_H616_CCU)	+=3D sun50i-h616-ccu.o
>  obj-$(CONFIG_SUN55I_A523_CCU)	+=3D sun55i-a523-ccu.o
> +obj-$(CONFIG_SUN55I_A523_R_CCU)	+=3D sun55i-a523-r-ccu.o
>  obj-$(CONFIG_SUN4I_A10_CCU)	+=3D sun4i-a10-ccu.o
>  obj-$(CONFIG_SUN5I_CCU)		+=3D sun5i-ccu.o
>  obj-$(CONFIG_SUN6I_A31_CCU)	+=3D sun6i-a31-ccu.o
> @@ -60,6 +61,7 @@ sun50i-h6-ccu-y			+=3D ccu-sun50i-h6.o
>  sun50i-h6-r-ccu-y		+=3D ccu-sun50i-h6-r.o
>  sun50i-h616-ccu-y		+=3D ccu-sun50i-h616.o
>  sun55i-a523-ccu-y		+=3D ccu-sun55i-a523.o
> +sun55i-a523-r-ccu-y		+=3D ccu-sun55i-a523-r.o
>  sun4i-a10-ccu-y			+=3D ccu-sun4i-a10.o
>  sun5i-ccu-y			+=3D ccu-sun5i.o
>  sun6i-a31-ccu-y			+=3D ccu-sun6i-a31.o
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c b/drivers/clk/sunxi=
=2Dng/ccu-sun55i-a523-r.c
> new file mode 100644
> index 0000000000000..0dafc38370f22
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.c
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Arm Ltd.
> + * Based on the D1 CCU driver:
> + *   Copyright (c) 2020 huangzhenwei@allwinnertech.com
> + *   Copyright (C) 2021 Samuel Holland <samuel@sholland.org>
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "ccu_common.h"
> +#include "ccu_reset.h"
> +
> +#include "ccu_gate.h"
> +#include "ccu_mp.h"
> +
> +#include "ccu-sun55i-a523-r.h"
> +
> +static const struct clk_parent_data r_ahb_apb_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "iosc" },
> +	{ .fw_name =3D "pll-periph" },
> +	{ .fw_name =3D "pll-audio" },

I believe pll-periph has /3 divider and pll-audio x4 multiplier.

> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX(r_ahb_clk, "r-ahb",
> +				 r_ahb_apb_parents, 0x000,
> +				 0, 5,	/* M */
> +				 24, 3,	/* mux */
> +				 0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX(r_apb0_clk, "r-apb0",
> +				 r_ahb_apb_parents, 0x00c,
> +				 0, 5,	/* M */
> +				 24, 3,	/* mux */
> +				 0);
> +
> +static SUNXI_CCU_M_DATA_WITH_MUX(r_apb1_clk, "r-apb1",
> +				 r_ahb_apb_parents, 0x010,
> +				 0, 5,	/* M */
> +				 24, 3,	/* mux */
> +				 0);
> +
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer0, "r-timer0",
> +				      r_ahb_apb_parents, 0x100,
> +				      1, 3,	/* P */
> +				      4, 3,	/* mux */
> +				      BIT(0),
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer1, "r-timer1",
> +				      r_ahb_apb_parents, 0x104,
> +				      1, 3,	/* P */
> +				      4, 3,	/* mux */
> +				      BIT(0),
> +				      0);
> +static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer2, "r-timer2",
> +				      r_ahb_apb_parents, 0x108,
> +				      1, 3,	/* P */
> +				      4, 3,	/* mux */
> +				      BIT(0),
> +				      0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_timer_clk, "bus-r-timer", &r_ahb_clk.comm=
on.hw,
> +			 0x11c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_twd_clk,	"bus-r-twd", &r_apb0_clk.common.=
hw,
> +			 0x12c, BIT(0), 0);
> +
> +static const struct clk_parent_data r_pwmctrl_parents[] =3D {
> +	{ .fw_name =3D "hosc" },
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "iosc" },
> +};
> +static SUNXI_CCU_MUX_DATA_WITH_GATE(r_pwmctrl_clk, "r-pwmctrl",
> +				  r_pwmctrl_parents, 0x130,
> +				  24, 1,	/* mux */

Mux width is 2.

> +				  BIT(31),
> +				  0);
> +static SUNXI_CCU_GATE_HW(bus_r_pwmctrl_clk, "bus-r-pwmctrl",
> +			 &r_apb0_clk.common.hw, 0x13c, BIT(0), 0);
> +
> +/* SPI clock is /M/N (same as new MMC?) */

Missing SPI clock (reg 0x150).

Best regards,
Jernej

> +static SUNXI_CCU_GATE_HW(bus_r_spi_clk, "bus-r-spi",
> +			 &r_ahb_clk.common.hw, 0x15c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_spinlock_clk, "bus-r-spinlock",
> +			 &r_ahb_clk.common.hw, 0x16c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_msgbox_clk, "bus-r-msgbox",
> +			 &r_ahb_clk.common.hw, 0x17c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_uart0_clk, "bus-r-uart0",
> +			 &r_apb1_clk.common.hw, 0x18c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_uart1_clk, "bus-r-uart1",
> +			 &r_apb1_clk.common.hw, 0x18c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_i2c0_clk, "bus-r-i2c0",
> +			 &r_apb1_clk.common.hw, 0x19c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_i2c1_clk, "bus-r-i2c1",
> +			 &r_apb1_clk.common.hw, 0x19c, BIT(1), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_i2c2_clk, "bus-r-i2c2",
> +			 &r_apb1_clk.common.hw, 0x19c, BIT(2), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_ppu0_clk, "bus-r-ppu0",
> +			 &r_apb0_clk.common.hw, 0x1ac, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_ppu1_clk, "bus-r-ppu1",
> +			 &r_apb0_clk.common.hw, 0x1ac, BIT(1), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_cpu_bist_clk, "bus-r-cpu-bist",
> +			 &r_apb0_clk.common.hw, 0x1bc, BIT(0), 0);
> +
> +static const struct clk_parent_data r_ir_rx_parents[] =3D {
> +	{ .fw_name =3D "losc" },
> +	{ .fw_name =3D "hosc" },
> +};
> +static SUNXI_CCU_M_DATA_WITH_MUX_GATE(r_ir_rx_clk, "r-ir-rx",
> +				      r_ir_rx_parents, 0x1c0,
> +				      0, 5,	/* M */
> +				      24, 2,	/* mux */
> +				      BIT(31),	/* gate */
> +				      0);
> +static SUNXI_CCU_GATE_HW(bus_r_ir_rx_clk, "bus-r-ir-rx",
> +			 &r_apb0_clk.common.hw, 0x1cc, BIT(0), 0);
> +
> +static SUNXI_CCU_GATE_HW(bus_r_dma_clk, "bus-r-dma",
> +			 &r_apb0_clk.common.hw, 0x1dc, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc",
> +			 &r_apb0_clk.common.hw, 0x20c, BIT(0), 0);
> +static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg",
> +			 &r_apb0_clk.common.hw, 0x22c, BIT(0), 0);
> +
> +static struct ccu_common *sun55i_a523_r_ccu_clks[] =3D {
> +	&r_ahb_clk.common,
> +	&r_apb0_clk.common,
> +	&r_apb1_clk.common,
> +	&r_cpu_timer0.common,
> +	&r_cpu_timer1.common,
> +	&r_cpu_timer2.common,
> +	&bus_r_timer_clk.common,
> +	&bus_r_twd_clk.common,
> +	&r_pwmctrl_clk.common,
> +	&bus_r_pwmctrl_clk.common,
> +	&bus_r_spi_clk.common,
> +	&bus_r_spinlock_clk.common,
> +	&bus_r_msgbox_clk.common,
> +	&bus_r_uart0_clk.common,
> +	&bus_r_uart1_clk.common,
> +	&bus_r_i2c0_clk.common,
> +	&bus_r_i2c1_clk.common,
> +	&bus_r_i2c2_clk.common,
> +	&bus_r_ppu0_clk.common,
> +	&bus_r_ppu1_clk.common,
> +	&bus_r_cpu_bist_clk.common,
> +	&r_ir_rx_clk.common,
> +	&bus_r_ir_rx_clk.common,
> +	&bus_r_dma_clk.common,
> +	&bus_r_rtc_clk.common,
> +	&bus_r_cpucfg_clk.common,
> +};
> +
> +static struct clk_hw_onecell_data sun55i_a523_r_hw_clks =3D {
> +	.num	=3D CLK_NUMBER,
> +	.hws	=3D {
> +		[CLK_R_AHB]		=3D &r_ahb_clk.common.hw,
> +		[CLK_R_APB0]		=3D &r_apb0_clk.common.hw,
> +		[CLK_R_APB1]		=3D &r_apb1_clk.common.hw,
> +		[CLK_R_TIMER0]		=3D &r_cpu_timer0.common.hw,
> +		[CLK_R_TIMER1]		=3D &r_cpu_timer1.common.hw,
> +		[CLK_R_TIMER2]		=3D &r_cpu_timer2.common.hw,
> +		[CLK_BUS_R_TIMER]	=3D &bus_r_timer_clk.common.hw,
> +		[CLK_BUS_R_TWD]		=3D &bus_r_twd_clk.common.hw,
> +		[CLK_R_PWMCTRL]		=3D &r_pwmctrl_clk.common.hw,
> +		[CLK_BUS_R_PWMCTRL]	=3D &bus_r_pwmctrl_clk.common.hw,
> +		[CLK_BUS_R_SPI]		=3D &bus_r_spi_clk.common.hw,
> +		[CLK_BUS_R_SPINLOCK]	=3D &bus_r_spinlock_clk.common.hw,
> +		[CLK_BUS_R_MSGBOX]	=3D &bus_r_msgbox_clk.common.hw,
> +		[CLK_BUS_R_UART0]	=3D &bus_r_uart0_clk.common.hw,
> +		[CLK_BUS_R_UART1]	=3D &bus_r_uart1_clk.common.hw,
> +		[CLK_BUS_R_I2C0]	=3D &bus_r_i2c0_clk.common.hw,
> +		[CLK_BUS_R_I2C1]	=3D &bus_r_i2c1_clk.common.hw,
> +		[CLK_BUS_R_I2C2]	=3D &bus_r_i2c2_clk.common.hw,
> +		[CLK_BUS_R_PPU0]	=3D &bus_r_ppu0_clk.common.hw,
> +		[CLK_BUS_R_PPU1]	=3D &bus_r_ppu1_clk.common.hw,
> +		[CLK_BUS_R_CPU_BIST]	=3D &bus_r_cpu_bist_clk.common.hw,
> +		[CLK_R_IR_RX]		=3D &r_ir_rx_clk.common.hw,
> +		[CLK_BUS_R_IR_RX]	=3D &bus_r_ir_rx_clk.common.hw,
> +		[CLK_BUS_R_DMA]		=3D &bus_r_dma_clk.common.hw,
> +		[CLK_BUS_R_RTC]		=3D &bus_r_rtc_clk.common.hw,
> +		[CLK_BUS_R_CPUCFG]	=3D &bus_r_cpucfg_clk.common.hw,
> +	},
> +};
> +
> +static struct ccu_reset_map sun55i_a523_r_ccu_resets[] =3D {
> +	[RST_BUS_R_TIMER]	=3D { 0x11c, BIT(16) },
> +	[RST_BUS_R_TWD]		=3D { 0x12c, BIT(16) },
> +	[RST_BUS_R_PWMCTRL]	=3D { 0x13c, BIT(16) },
> +	[RST_BUS_R_SPI]		=3D { 0x15c, BIT(16) },
> +	[RST_BUS_R_SPINLOCK]	=3D { 0x16c, BIT(16) },
> +	[RST_BUS_R_MSGBOX]	=3D { 0x17c, BIT(16) },
> +	[RST_BUS_R_UART0]	=3D { 0x18c, BIT(16) },
> +	[RST_BUS_R_UART1]	=3D { 0x18c, BIT(17) },
> +	[RST_BUS_R_I2C0]	=3D { 0x19c, BIT(16) },
> +	[RST_BUS_R_I2C1]	=3D { 0x19c, BIT(17) },
> +	[RST_BUS_R_I2C2]	=3D { 0x19c, BIT(18) },
> +	[RST_BUS_R_PPU1]	=3D { 0x1ac, BIT(17) },
> +	[RST_BUS_R_IR_RX]	=3D { 0x1cc, BIT(16) },
> +	[RST_BUS_R_RTC]		=3D { 0x20c, BIT(16) },
> +	[RST_BUS_R_CPUCFG]	=3D { 0x22c, BIT(16) },
> +};
> +
> +static const struct sunxi_ccu_desc sun55i_a523_r_ccu_desc =3D {
> +	.ccu_clks	=3D sun55i_a523_r_ccu_clks,
> +	.num_ccu_clks	=3D ARRAY_SIZE(sun55i_a523_r_ccu_clks),
> +
> +	.hw_clks	=3D &sun55i_a523_r_hw_clks,
> +
> +	.resets		=3D sun55i_a523_r_ccu_resets,
> +	.num_resets	=3D ARRAY_SIZE(sun55i_a523_r_ccu_resets),
> +};
> +
> +static int sun55i_a523_r_ccu_probe(struct platform_device *pdev)
> +{
> +	void __iomem *reg;
> +
> +	reg =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg))
> +		return PTR_ERR(reg);
> +
> +	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun55i_a523_r_ccu_desc);
> +}
> +
> +static const struct of_device_id sun55i_a523_r_ccu_ids[] =3D {
> +	{ .compatible =3D "allwinner,sun55i-a523-r-ccu" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sun55i_a523_r_ccu_ids);
> +
> +static struct platform_driver sun55i_a523_r_ccu_driver =3D {
> +	.probe	=3D sun55i_a523_r_ccu_probe,
> +	.driver	=3D {
> +		.name			=3D "sun55i-a523-r-ccu",
> +		.suppress_bind_attrs	=3D true,
> +		.of_match_table		=3D sun55i_a523_r_ccu_ids,
> +	},
> +};
> +module_platform_driver(sun55i_a523_r_ccu_driver);
> +
> +MODULE_IMPORT_NS("SUNXI_CCU");
> +MODULE_DESCRIPTION("Support for the Allwinner A523 PRCM CCU");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h b/drivers/clk/sunxi=
=2Dng/ccu-sun55i-a523-r.h
> new file mode 100644
> index 0000000000000..d50f46ac4f3fe
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun55i-a523-r.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2024 Arm Ltd.
> + */
> +
> +#ifndef _CCU_SUN55I_A523_R_H
> +#define _CCU_SUN55I_A523_R_H
> +
> +#include <dt-bindings/clock/sun55i-a523-r-ccu.h>
> +#include <dt-bindings/reset/sun55i-a523-r-ccu.h>
> +
> +#define CLK_NUMBER	(CLK_BUS_R_CPUCFG + 1)
> +
> +#endif /* _CCU_SUN55I_A523_R_H */
>=20





