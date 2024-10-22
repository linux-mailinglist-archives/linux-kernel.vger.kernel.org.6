Return-Path: <linux-kernel+bounces-376037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791329A9F11
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6CC2840F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE16146A97;
	Tue, 22 Oct 2024 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yEdf+8zJ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B318198A25
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590453; cv=none; b=cmLGSkBuPQCPFIO/7q42WUd08pOjroZHEnUhkxaVudv9AKXCpNRHQINon+JEwhGPfGl8ZLCSrlHuR2jKciefJEW18cRh4lXN9AqnMX1mT0YSg1HbxO0H/VzOFAyKB/rph2a58thJJq5bqm6FqOoOACR3pHJglylMOc5xJYkzb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590453; c=relaxed/simple;
	bh=lEWoKqm+WN9mw31Yaj/wruMiFEU4oa/eGyPFsYdcVxY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b/qnBXJP+mtbOHsBy9sPzrA77GwFM9FNk6fRf2aIWaSoGS/LUyw94MxjjqIQ44RTwhcBYguc4jh+255SVZ7LckzpIB8MD0WPr/cB4b0yDDmEdfTrtnYmqCt70/hlOgycWJ9oDLthpOO3FdiiSgS+L3BiDKWU2CzoEk5I2WFvfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yEdf+8zJ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431688d5127so30769345e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 02:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729590449; x=1730195249; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sgK9H05RmQRns7wyD4ECy1YtNohLlQQJRE+nRTeQ/1w=;
        b=yEdf+8zJJidb+fLGv9qNY4c0MEpU8trOtMOMqDKnq2oy43o5CUnlJMkmJrBPWslPww
         FwxgoZ67iqhVJIzb45A6yVWG0Wpbr13fV08hBzmpVjwWIk+BxPZJGOMxcxVnRXD4mXdf
         rIhijxC7cZ1a/skS519NVcQLIc5tqmVnKFjlfqNS2wLsXgaG+7W8NJtriRd/N6GpvE2q
         qfhWRSRpGawFDXqJRi5kPUbczTKGcr/oeB3KHkyEnFztuRhIrCsM6IPqcw1+zZcwonU3
         DQfkHo9nYi/pKbCmLEq/oN5XB4DGzvynB8wzMgOoiedQEtOQ/O9ZFb6ivBshx7OuMaxa
         h0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729590449; x=1730195249;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgK9H05RmQRns7wyD4ECy1YtNohLlQQJRE+nRTeQ/1w=;
        b=uA4e2XhXUbt9W3ag+iuq0lpBEy4GH8VslbQazmHcrGcY2x0q4zmB5wGLt6rd/brpFH
         KO/ubEaurrBxQ3NUWDCePQ+BAEvU6rgnRYgrlX6hFqIAyCZitrTqJBatWId9qrfqOmmU
         PEQYVr+PsLJYUlv4JBksVP0DuKQyQzg+SKMAgnp+H3FxqKGnS51+v7mRD/59rLmOKqIk
         kb2juBYUtUCtlyl+hM0eDyohFQs+JWaaFqETzk7nztWilU6re9bPK1jKlhIyzbtKNK1K
         kNXtb2p/TSCb3B/3C78NF1qWoFvFy0tkjF9pg+0FsZfB+VVQRv+GwqctfJONnBKMkh2z
         rwWw==
X-Forwarded-Encrypted: i=1; AJvYcCVmU8i3ZQQQ/lbcMSp1D1/X+CyTa2x6RuEZL0bkAD+XrrmGgiWZtcu1m5TO4OrXeU2cvEi0BRzAqauN1CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz69unL2WX/HifyeWoOkBq98SFQ06bda85FSnpWNmUNg1SqRZWE
	DcC9f0SAsvqm9NDHLsbdgObsCv0mf4J3nXmQbmFRZOEcMmiUkSSQPiKLuWpGi3/Y3D143KSlc9a
	q1xU=
X-Google-Smtp-Source: AGHT+IFcPcPsTUbPGzW9RJKXn1+FylYrTnEjk0xEi0sL24IUUgz5S7OwGB+DKXVolvwEZI4kIph7ew==
X-Received: by 2002:a5d:588d:0:b0:37d:4956:b0c2 with SMTP id ffacd0b85a97d-37eb48a802cmr11188427f8f.58.1729590448676;
        Tue, 22 Oct 2024 02:47:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:ef1c:ae40:1300:20c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0ba74dbsm6230394f8f.112.2024.10.22.02.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:47:28 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>,  <devicetree@vger.kernel.org>,
  Kevin Hilman <khilman@baylibre.com>,  "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>,  <linux-amlogic@lists.infradead.org>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-clk@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
  Philipp Zabel <p.zabel@pengutronix.de>,  Rob Herring <robh@kernel.org>,
  Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH v4 4/5] clk: meson: a1: add the audio clock
 controller driver
In-Reply-To: <20240913121152.817575-5-jan.dakinevich@salutedevices.com> (Jan
	Dakinevich's message of "Fri, 13 Sep 2024 15:11:51 +0300")
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
	<20240913121152.817575-5-jan.dakinevich@salutedevices.com>
Date: Tue, 22 Oct 2024 11:47:27 +0200
Message-ID: <1jttd4jwpc.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 13 Sep 2024 at 15:11, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> This controller provides clocks and reset functionality for audio
> peripherals on Amlogic A1 SoC family.
>
> The driver is almost identical to 'axg-audio', however it would be better
> to keep it separate due to following reasons:
>
>  - significant amount of bits has another definition. I will bring there
>    a mess of new defines with A1_ suffixes.
>
>  - registers of this controller are located in two separate regions. It
>    will give a lot of complications for 'axg-audio' to support this.
>
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  drivers/clk/meson/Kconfig             |  14 +
>  drivers/clk/meson/Makefile            |   3 +
>  drivers/clk/meson/a1-audio-clkc.c     | 359 ++++++++++++++++++++++++++
>  drivers/clk/meson/a1-audio-drv.c      | 104 ++++++++
>  drivers/clk/meson/a1-audio-vad-clkc.c |  85 ++++++

This split over 3 files appears unnecessary, especially since you've got
a single configuration option for both drivers.

a1-audio.c is enough AFAICT.

>  drivers/clk/meson/a1-audio.h          | 131 ++++++++++

not necessary.

>  6 files changed, 696 insertions(+)
>  create mode 100644 drivers/clk/meson/a1-audio-clkc.c
>  create mode 100644 drivers/clk/meson/a1-audio-drv.c
>  create mode 100644 drivers/clk/meson/a1-audio-vad-clkc.c
>  create mode 100644 drivers/clk/meson/a1-audio.h
>
> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
> index 78f648c9c97d..b558288a6b78 100644
> --- a/drivers/clk/meson/Kconfig
> +++ b/drivers/clk/meson/Kconfig
> @@ -132,6 +132,20 @@ config COMMON_CLK_A1_PERIPHERALS
>  	  device, A1 SoC Family. Say Y if you want A1 Peripherals clock
>  	  controller to work.
>  
> +config COMMON_CLK_A1_AUDIO
> +	tristate "Amlogic A1 SoC Audio clock controller support"
> +	depends on ARM64
> +	select COMMON_CLK_MESON_REGMAP
> +	select COMMON_CLK_MESON_PHASE
> +	select COMMON_CLK_MESON_SCLK_DIV
> +	select COMMON_CLK_MESON_CLKC_UTILS
> +	select REGMAP_MMIO
> +	imply RESET_MESON_AUX
> +	help
> +	  Support for the Audio clock controller on Amlogic A113L based
> +	  device, A1 SoC Family. Say Y if you want A1 Audio clock controller
> +	  to work.
> +
>  config COMMON_CLK_C3_PLL
>  	tristate "Amlogic C3 PLL clock controller"
>  	depends on ARM64
> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index bc56a47931c1..f7ea11df1de3 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -16,10 +16,13 @@ obj-$(CONFIG_COMMON_CLK_MESON_VCLK) += vclk.o
>  
>  # Amlogic Clock controllers
>  
> +a1-audio-y := a1-audio-drv.o a1-audio-clkc.o a1-audio-vad-clkc.o
> +
>  obj-$(CONFIG_COMMON_CLK_AXG) += axg.o axg-aoclk.o
>  obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) += axg-audio.o
>  obj-$(CONFIG_COMMON_CLK_A1_PLL) += a1-pll.o
>  obj-$(CONFIG_COMMON_CLK_A1_PERIPHERALS) += a1-peripherals.o
> +obj-$(CONFIG_COMMON_CLK_A1_AUDIO) += a1-audio.o
>  obj-$(CONFIG_COMMON_CLK_C3_PLL) += c3-pll.o
>  obj-$(CONFIG_COMMON_CLK_C3_PERIPHERALS) += c3-peripherals.o
>  obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
> diff --git a/drivers/clk/meson/a1-audio-clkc.c b/drivers/clk/meson/a1-audio-clkc.c
> new file mode 100644
> index 000000000000..48160dcb7f47
> --- /dev/null
> +++ b/drivers/clk/meson/a1-audio-clkc.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
> +
> +#include "a1-audio.h"
> +
> +#define AUDIO_CLK_GATE_EN0	0x000
> +#define AUDIO_MCLK_A_CTRL	0x008
> +#define AUDIO_MCLK_B_CTRL	0x00c
> +#define AUDIO_MCLK_C_CTRL	0x010
> +#define AUDIO_MCLK_D_CTRL	0x014
> +#define AUDIO_MCLK_E_CTRL	0x018
> +#define AUDIO_MCLK_F_CTRL	0x01c
> +#define AUDIO_SW_RESET0		0x028
> +#define AUDIO_MST_A_SCLK_CTRL0	0x040
> +#define AUDIO_MST_A_SCLK_CTRL1	0x044
> +#define AUDIO_MST_B_SCLK_CTRL0	0x048
> +#define AUDIO_MST_B_SCLK_CTRL1	0x04c
> +#define AUDIO_MST_C_SCLK_CTRL0	0x050
> +#define AUDIO_MST_C_SCLK_CTRL1	0x054
> +#define AUDIO_MST_D_SCLK_CTRL0	0x058
> +#define AUDIO_MST_D_SCLK_CTRL1	0x05c
> +#define AUDIO_CLK_TDMIN_A_CTRL	0x080
> +#define AUDIO_CLK_TDMIN_B_CTRL	0x084
> +#define AUDIO_CLK_TDMIN_LB_CTRL	0x08c
> +#define AUDIO_CLK_TDMOUT_A_CTRL	0x090
> +#define AUDIO_CLK_TDMOUT_B_CTRL	0x094
> +#define AUDIO_CLK_SPDIFIN_CTRL	0x09c
> +#define AUDIO_CLK_RESAMPLE_CTRL	0x0a4
> +#define AUDIO_CLK_LOCKER_CTRL	0x0a8
> +#define AUDIO_CLK_EQDRC_CTRL	0x0c0
> +
> +struct clk_regmap aud_ddr_arb =
> +	AUD_PCLK_GATE(ddr_arb, AUDIO_CLK_GATE_EN0, 0);
> +struct clk_regmap aud_tdmin_a =
> +	AUD_PCLK_GATE(tdmin_a, AUDIO_CLK_GATE_EN0, 1);
> +struct clk_regmap aud_tdmin_b =
> +	AUD_PCLK_GATE(tdmin_b, AUDIO_CLK_GATE_EN0, 2);
> +struct clk_regmap aud_tdmin_lb =
> +	AUD_PCLK_GATE(tdmin_lb, AUDIO_CLK_GATE_EN0, 3);
> +struct clk_regmap aud_loopback =
> +	AUD_PCLK_GATE(loopback, AUDIO_CLK_GATE_EN0, 4);
> +struct clk_regmap aud_tdmout_a =
> +	AUD_PCLK_GATE(tdmout_a, AUDIO_CLK_GATE_EN0, 5);
> +struct clk_regmap aud_tdmout_b =
> +	AUD_PCLK_GATE(tdmout_b, AUDIO_CLK_GATE_EN0, 6);
> +struct clk_regmap aud_frddr_a =
> +	AUD_PCLK_GATE(frddr_a, AUDIO_CLK_GATE_EN0, 7);
> +struct clk_regmap aud_frddr_b =
> +	AUD_PCLK_GATE(frddr_b, AUDIO_CLK_GATE_EN0, 8);
> +struct clk_regmap aud_toddr_a =
> +	AUD_PCLK_GATE(toddr_a, AUDIO_CLK_GATE_EN0, 9);
> +struct clk_regmap aud_toddr_b =
> +	AUD_PCLK_GATE(toddr_b, AUDIO_CLK_GATE_EN0, 10);
> +struct clk_regmap aud_spdifin =
> +	AUD_PCLK_GATE(spdifin, AUDIO_CLK_GATE_EN0, 11);
> +struct clk_regmap aud_resample =
> +	AUD_PCLK_GATE(resample, AUDIO_CLK_GATE_EN0, 12);
> +struct clk_regmap aud_eqdrc =
> +	AUD_PCLK_GATE(eqdrc, AUDIO_CLK_GATE_EN0, 13);
> +struct clk_regmap aud_audiolocker =
> +	AUD_PCLK_GATE(audiolocker, AUDIO_CLK_GATE_EN0, 14);
> +
> +struct clk_regmap aud_mst_a_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_a_mclk, AUDIO_MCLK_A_CTRL);
> +struct clk_regmap aud_mst_a_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_a_mclk, AUDIO_MCLK_A_CTRL);
> +struct clk_regmap aud_mst_a_mclk =
> +	AUD_MST_MCLK_GATE(mst_a_mclk, AUDIO_MCLK_A_CTRL);
> +
> +struct clk_regmap aud_mst_b_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_b_mclk, AUDIO_MCLK_B_CTRL);
> +struct clk_regmap aud_mst_b_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_b_mclk, AUDIO_MCLK_B_CTRL);
> +struct clk_regmap aud_mst_b_mclk =
> +	AUD_MST_MCLK_GATE(mst_b_mclk, AUDIO_MCLK_B_CTRL);
> +
> +struct clk_regmap aud_mst_c_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_c_mclk, AUDIO_MCLK_C_CTRL);
> +struct clk_regmap aud_mst_c_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_c_mclk, AUDIO_MCLK_C_CTRL);
> +struct clk_regmap aud_mst_c_mclk =
> +	AUD_MST_MCLK_GATE(mst_c_mclk, AUDIO_MCLK_C_CTRL);
> +
> +struct clk_regmap aud_mst_d_mclk_sel =
> +	AUD_MST_MCLK_MUX(mst_d_mclk, AUDIO_MCLK_D_CTRL);
> +struct clk_regmap aud_mst_d_mclk_div =
> +	AUD_MST_MCLK_DIV(mst_d_mclk, AUDIO_MCLK_D_CTRL);
> +struct clk_regmap aud_mst_d_mclk =
> +	AUD_MST_MCLK_GATE(mst_d_mclk, AUDIO_MCLK_D_CTRL);
> +
> +struct clk_regmap aud_spdifin_clk_sel =
> +	AUD_MST_MCLK_MUX(spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
> +struct clk_regmap aud_spdifin_clk_div =
> +	AUD_MST_MCLK_DIV(spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
> +struct clk_regmap aud_spdifin_clk =
> +	AUD_MST_MCLK_GATE(spdifin_clk, AUDIO_CLK_SPDIFIN_CTRL);
> +
> +struct clk_regmap aud_eqdrc_clk_sel =
> +	AUD_MST_MCLK_MUX(eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
> +struct clk_regmap aud_eqdrc_clk_div =
> +	AUD_MST_MCLK_DIV(eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
> +struct clk_regmap aud_eqdrc_clk =
> +	AUD_MST_MCLK_GATE(eqdrc_clk, AUDIO_CLK_EQDRC_CTRL);
> +
> +struct clk_regmap aud_resample_clk_sel =
> +	AUD_MUX(resample_clk_sel, AUDIO_CLK_RESAMPLE_CTRL, 0xf, 24,
> +		CLK_MUX_ROUND_CLOSEST, AUD_MST_MCLK_PDATA, 0);
> +struct clk_regmap aud_resample_clk_div =
> +	AUD_DIV(resample_clk_div, AUDIO_CLK_RESAMPLE_CTRL, 0, 8,
> +		CLK_DIVIDER_ROUND_CLOSEST, aud_resample_clk_sel,
> +		CLK_SET_RATE_PARENT);
> +struct clk_regmap aud_resample_clk =
> +	AUD_GATE(resample_clk, AUDIO_CLK_RESAMPLE_CTRL, 31,
> +		 aud_resample_clk_div, CLK_SET_RATE_PARENT);
> +
> +struct clk_regmap aud_locker_in_clk_sel =
> +	AUD_MUX(locker_in_clk_sel, AUDIO_CLK_LOCKER_CTRL, 0xf, 8,
> +		CLK_MUX_ROUND_CLOSEST, AUD_MST_MCLK_PDATA, 0);
> +struct clk_regmap aud_locker_in_clk_div =
> +	AUD_DIV(locker_in_clk_div, AUDIO_CLK_LOCKER_CTRL, 0, 8,
> +		CLK_DIVIDER_ROUND_CLOSEST, aud_locker_in_clk_sel,
> +		CLK_SET_RATE_PARENT);
> +struct clk_regmap aud_locker_in_clk =
> +	AUD_GATE(locker_in_clk, AUDIO_CLK_LOCKER_CTRL, 15,
> +		 aud_locker_in_clk_div, CLK_SET_RATE_PARENT);
> +
> +struct clk_regmap aud_locker_out_clk_sel =
> +	AUD_MUX(locker_out_clk_sel, AUDIO_CLK_LOCKER_CTRL, 0xf, 24,
> +		CLK_MUX_ROUND_CLOSEST, AUD_MST_MCLK_PDATA, 0);
> +struct clk_regmap aud_locker_out_clk_div =
> +	AUD_DIV(locker_out_clk_div, AUDIO_CLK_LOCKER_CTRL, 16, 8,
> +		CLK_DIVIDER_ROUND_CLOSEST, aud_locker_out_clk_sel,
> +		CLK_SET_RATE_PARENT);
> +struct clk_regmap aud_locker_out_clk =
> +	AUD_GATE(locker_out_clk, AUDIO_CLK_LOCKER_CTRL, 31,
> +		 aud_locker_out_clk_div, CLK_SET_RATE_PARENT);
> +
> +struct clk_regmap aud_mst_a_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0, mst_a_mclk);
> +struct clk_regmap aud_mst_a_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0);
> +struct clk_regmap aud_mst_a_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL0);
> +struct clk_regmap aud_mst_a_sclk =
> +	AUD_MST_SCLK(mst_a_sclk, AUDIO_MST_A_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_b_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0, mst_b_mclk);
> +struct clk_regmap aud_mst_b_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0);
> +struct clk_regmap aud_mst_b_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL0);
> +struct clk_regmap aud_mst_b_sclk =
> +	AUD_MST_SCLK(mst_b_sclk, AUDIO_MST_B_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_c_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0, mst_c_mclk);
> +struct clk_regmap aud_mst_c_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0);
> +struct clk_regmap aud_mst_c_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL0);
> +struct clk_regmap aud_mst_c_sclk =
> +	AUD_MST_SCLK(mst_c_sclk, AUDIO_MST_C_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_d_sclk_pre_en =
> +	AUD_MST_SCLK_PRE_EN(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0, mst_d_mclk);
> +struct clk_regmap aud_mst_d_sclk_div =
> +	AUD_MST_SCLK_DIV(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0);
> +struct clk_regmap aud_mst_d_sclk_post_en =
> +	AUD_MST_SCLK_POST_EN(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL0);
> +struct clk_regmap aud_mst_d_sclk =
> +	AUD_MST_SCLK(mst_d_sclk, AUDIO_MST_D_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_a_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_a_lrclk, AUDIO_MST_A_SCLK_CTRL0,
> +			  mst_a_sclk_post_en);
> +struct clk_regmap aud_mst_a_lrclk =
> +	AUD_MST_LRCLK(mst_a_lrclk, AUDIO_MST_A_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_b_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_b_lrclk, AUDIO_MST_B_SCLK_CTRL0,
> +			  mst_b_sclk_post_en);
> +struct clk_regmap aud_mst_b_lrclk =
> +	AUD_MST_LRCLK(mst_b_lrclk, AUDIO_MST_B_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_c_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_c_lrclk, AUDIO_MST_C_SCLK_CTRL0,
> +			  mst_c_sclk_post_en);
> +struct clk_regmap aud_mst_c_lrclk =
> +	AUD_MST_LRCLK(mst_c_lrclk, AUDIO_MST_C_SCLK_CTRL1);
> +
> +struct clk_regmap aud_mst_d_lrclk_div =
> +	AUD_MST_LRCLK_DIV(mst_d_lrclk, AUDIO_MST_D_SCLK_CTRL0,
> +			  mst_d_sclk_post_en);
> +struct clk_regmap aud_mst_d_lrclk =
> +	AUD_MST_LRCLK(mst_d_lrclk, AUDIO_MST_D_SCLK_CTRL1);
> +
> +struct clk_regmap aud_tdmin_a_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_sclk =
> +	AUD_TDM_SCLK_WS(tdmin_a_sclk, AUDIO_CLK_TDMIN_A_CTRL);
> +struct clk_regmap aud_tdmin_a_lrclk =
> +	AUD_TDM_LRLCK(tdmin_a_lrclk, AUDIO_CLK_TDMIN_A_CTRL);
> +
> +struct clk_regmap aud_tdmin_b_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_sclk =
> +	AUD_TDM_SCLK_WS(tdmin_b_sclk, AUDIO_CLK_TDMIN_B_CTRL);
> +struct clk_regmap aud_tdmin_b_lrclk =
> +	AUD_TDM_LRLCK(tdmin_b_lrclk, AUDIO_CLK_TDMIN_B_CTRL);
> +
> +struct clk_regmap aud_tdmin_lb_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_sclk =
> +	AUD_TDM_SCLK_WS(tdmin_lb_sclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +struct clk_regmap aud_tdmin_lb_lrclk =
> +	AUD_TDM_LRLCK(tdmin_lb_lrclk, AUDIO_CLK_TDMIN_LB_CTRL);
> +
> +struct clk_regmap aud_tdmout_a_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_sclk =
> +	AUD_TDM_SCLK_WS(tdmout_a_sclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +struct clk_regmap aud_tdmout_a_lrclk =
> +	AUD_TDM_LRLCK(tdmout_a_lrclk, AUDIO_CLK_TDMOUT_A_CTRL);
> +
> +struct clk_regmap aud_tdmout_b_sclk_sel =
> +	AUD_TDM_SCLK_MUX(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_sclk_pre_en =
> +	AUD_TDM_SCLK_PRE_EN(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_sclk_post_en =
> +	AUD_TDM_SCLK_POST_EN(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_sclk =
> +	AUD_TDM_SCLK_WS(tdmout_b_sclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +struct clk_regmap aud_tdmout_b_lrclk =
> +	AUD_TDM_LRLCK(tdmout_b_lrclk, AUDIO_CLK_TDMOUT_B_CTRL);
> +
> +static struct clk_hw *a1_audio_clkc_hws[] = {
> +	[AUD_CLKID_DDR_ARB]		= &aud_ddr_arb.hw,
> +	[AUD_CLKID_TDMIN_A]		= &aud_tdmin_a.hw,
> +	[AUD_CLKID_TDMIN_B]		= &aud_tdmin_b.hw,
> +	[AUD_CLKID_TDMIN_LB]		= &aud_tdmin_lb.hw,
> +	[AUD_CLKID_LOOPBACK]		= &aud_loopback.hw,
> +	[AUD_CLKID_TDMOUT_A]		= &aud_tdmout_a.hw,
> +	[AUD_CLKID_TDMOUT_B]		= &aud_tdmout_b.hw,
> +	[AUD_CLKID_FRDDR_A]		= &aud_frddr_a.hw,
> +	[AUD_CLKID_FRDDR_B]		= &aud_frddr_b.hw,
> +	[AUD_CLKID_TODDR_A]		= &aud_toddr_a.hw,
> +	[AUD_CLKID_TODDR_B]		= &aud_toddr_b.hw,
> +	[AUD_CLKID_SPDIFIN]		= &aud_spdifin.hw,
> +	[AUD_CLKID_RESAMPLE]		= &aud_resample.hw,
> +	[AUD_CLKID_EQDRC]		= &aud_eqdrc.hw,
> +	[AUD_CLKID_LOCKER]		= &aud_audiolocker.hw,
> +	[AUD_CLKID_MST_A_MCLK_SEL]	= &aud_mst_a_mclk_sel.hw,
> +	[AUD_CLKID_MST_A_MCLK_DIV]	= &aud_mst_a_mclk_div.hw,
> +	[AUD_CLKID_MST_A_MCLK]		= &aud_mst_a_mclk.hw,
> +	[AUD_CLKID_MST_B_MCLK_SEL]	= &aud_mst_b_mclk_sel.hw,
> +	[AUD_CLKID_MST_B_MCLK_DIV]	= &aud_mst_b_mclk_div.hw,
> +	[AUD_CLKID_MST_B_MCLK]		= &aud_mst_b_mclk.hw,
> +	[AUD_CLKID_MST_C_MCLK_SEL]	= &aud_mst_c_mclk_sel.hw,
> +	[AUD_CLKID_MST_C_MCLK_DIV]	= &aud_mst_c_mclk_div.hw,
> +	[AUD_CLKID_MST_C_MCLK]		= &aud_mst_c_mclk.hw,
> +	[AUD_CLKID_MST_D_MCLK_SEL]	= &aud_mst_d_mclk_sel.hw,
> +	[AUD_CLKID_MST_D_MCLK_DIV]	= &aud_mst_d_mclk_div.hw,
> +	[AUD_CLKID_MST_D_MCLK]		= &aud_mst_d_mclk.hw,
> +	[AUD_CLKID_RESAMPLE_CLK_SEL]	= &aud_resample_clk_sel.hw,
> +	[AUD_CLKID_RESAMPLE_CLK_DIV]	= &aud_resample_clk_div.hw,
> +	[AUD_CLKID_RESAMPLE_CLK]	= &aud_resample_clk.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK_SEL]	= &aud_locker_in_clk_sel.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK_DIV]	= &aud_locker_in_clk_div.hw,
> +	[AUD_CLKID_LOCKER_IN_CLK]	= &aud_locker_in_clk.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK_SEL]	= &aud_locker_out_clk_sel.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK_DIV]	= &aud_locker_out_clk_div.hw,
> +	[AUD_CLKID_LOCKER_OUT_CLK]	= &aud_locker_out_clk.hw,
> +	[AUD_CLKID_SPDIFIN_CLK_SEL]	= &aud_spdifin_clk_sel.hw,
> +	[AUD_CLKID_SPDIFIN_CLK_DIV]	= &aud_spdifin_clk_div.hw,
> +	[AUD_CLKID_SPDIFIN_CLK]		= &aud_spdifin_clk.hw,
> +	[AUD_CLKID_EQDRC_CLK_SEL]	= &aud_eqdrc_clk_sel.hw,
> +	[AUD_CLKID_EQDRC_CLK_DIV]	= &aud_eqdrc_clk_div.hw,
> +	[AUD_CLKID_EQDRC_CLK]		= &aud_eqdrc_clk.hw,
> +	[AUD_CLKID_MST_A_SCLK_PRE_EN]	= &aud_mst_a_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_A_SCLK_DIV]	= &aud_mst_a_sclk_div.hw,
> +	[AUD_CLKID_MST_A_SCLK_POST_EN]	= &aud_mst_a_sclk_post_en.hw,
> +	[AUD_CLKID_MST_A_SCLK]		= &aud_mst_a_sclk.hw,
> +	[AUD_CLKID_MST_B_SCLK_PRE_EN]	= &aud_mst_b_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_B_SCLK_DIV]	= &aud_mst_b_sclk_div.hw,
> +	[AUD_CLKID_MST_B_SCLK_POST_EN]	= &aud_mst_b_sclk_post_en.hw,
> +	[AUD_CLKID_MST_B_SCLK]		= &aud_mst_b_sclk.hw,
> +	[AUD_CLKID_MST_C_SCLK_PRE_EN]	= &aud_mst_c_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_C_SCLK_DIV]	= &aud_mst_c_sclk_div.hw,
> +	[AUD_CLKID_MST_C_SCLK_POST_EN]	= &aud_mst_c_sclk_post_en.hw,
> +	[AUD_CLKID_MST_C_SCLK]		= &aud_mst_c_sclk.hw,
> +	[AUD_CLKID_MST_D_SCLK_PRE_EN]	= &aud_mst_d_sclk_pre_en.hw,
> +	[AUD_CLKID_MST_D_SCLK_DIV]	= &aud_mst_d_sclk_div.hw,
> +	[AUD_CLKID_MST_D_SCLK_POST_EN]	= &aud_mst_d_sclk_post_en.hw,
> +	[AUD_CLKID_MST_D_SCLK]		= &aud_mst_d_sclk.hw,
> +	[AUD_CLKID_MST_A_LRCLK_DIV]	= &aud_mst_a_lrclk_div.hw,
> +	[AUD_CLKID_MST_A_LRCLK]		= &aud_mst_a_lrclk.hw,
> +	[AUD_CLKID_MST_B_LRCLK_DIV]	= &aud_mst_b_lrclk_div.hw,
> +	[AUD_CLKID_MST_B_LRCLK]		= &aud_mst_b_lrclk.hw,
> +	[AUD_CLKID_MST_C_LRCLK_DIV]	= &aud_mst_c_lrclk_div.hw,
> +	[AUD_CLKID_MST_C_LRCLK]		= &aud_mst_c_lrclk.hw,
> +	[AUD_CLKID_MST_D_LRCLK_DIV]	= &aud_mst_d_lrclk_div.hw,
> +	[AUD_CLKID_MST_D_LRCLK]		= &aud_mst_d_lrclk.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_SEL]	= &aud_tdmin_a_sclk_sel.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_PRE_EN]	= &aud_tdmin_a_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK_POST_EN] = &aud_tdmin_a_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_A_SCLK]	= &aud_tdmin_a_sclk.hw,
> +	[AUD_CLKID_TDMIN_A_LRCLK]	= &aud_tdmin_a_lrclk.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_SEL]	= &aud_tdmin_b_sclk_sel.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_PRE_EN]	= &aud_tdmin_b_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK_POST_EN] = &aud_tdmin_b_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_B_SCLK]	= &aud_tdmin_b_sclk.hw,
> +	[AUD_CLKID_TDMIN_B_LRCLK]	= &aud_tdmin_b_lrclk.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_SEL]	= &aud_tdmin_lb_sclk_sel.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_PRE_EN] = &aud_tdmin_lb_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK_POST_EN] = &aud_tdmin_lb_sclk_post_en.hw,
> +	[AUD_CLKID_TDMIN_LB_SCLK]	= &aud_tdmin_lb_sclk.hw,
> +	[AUD_CLKID_TDMIN_LB_LRCLK]	= &aud_tdmin_lb_lrclk.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_SEL]	= &aud_tdmout_a_sclk_sel.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_PRE_EN] = &aud_tdmout_a_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK_POST_EN] = &aud_tdmout_a_sclk_post_en.hw,
> +	[AUD_CLKID_TDMOUT_A_SCLK]	= &aud_tdmout_a_sclk.hw,
> +	[AUD_CLKID_TDMOUT_A_LRCLK]	= &aud_tdmout_a_lrclk.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_SEL]	= &aud_tdmout_b_sclk_sel.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_PRE_EN] = &aud_tdmout_b_sclk_pre_en.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK_POST_EN] = &aud_tdmout_b_sclk_post_en.hw,
> +	[AUD_CLKID_TDMOUT_B_SCLK]	= &aud_tdmout_b_sclk.hw,
> +	[AUD_CLKID_TDMOUT_B_LRCLK]	= &aud_tdmout_b_lrclk.hw,
> +};
> +
> +struct a1_audio_data a1_audio_clkc = {
> +	.hw_clks = {
> +		.hws = a1_audio_clkc_hws,
> +		.num = ARRAY_SIZE(a1_audio_clkc_hws),
> +	},
> +	.rst_drvname = "rst-a1",
> +};
> diff --git a/drivers/clk/meson/a1-audio-drv.c b/drivers/clk/meson/a1-audio-drv.c
> new file mode 100644
> index 000000000000..879a9d7bed72
> --- /dev/null
> +++ b/drivers/clk/meson/a1-audio-drv.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include <soc/amlogic/reset-meson-aux.h>
> +
> +#include "a1-audio.h"
> +
> +static const struct regmap_config a1_audio_regmap_cfg = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +};
> +
> +static int a1_audio_clkc_probe(struct platform_device *pdev)
> +{
> +	const struct a1_audio_data *data;
> +	struct regmap *map;
> +	void __iomem *base;
> +	struct clk *clk;
> +	unsigned int i;
> +	int ret;
> +
> +	data = device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	clk = devm_clk_get_enabled(&pdev->dev, "pclk");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	map = devm_regmap_init_mmio(&pdev->dev, base, &a1_audio_regmap_cfg);
> +	if (IS_ERR(map))
> +		return PTR_ERR(map);
> +
> +	ret = device_reset(&pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to reset device");
> +
> +	for (i = 0; i < data->hw_clks.num; i++) {
> +		struct clk_hw *hw = data->hw_clks.hws[i];
> +		struct clk_regmap *clk_regmap = to_clk_regmap(hw);
> +
> +		if (!hw)
> +			continue;
> +
> +		clk_regmap->map = map;
> +
> +		ret = devm_clk_hw_register(&pdev->dev, hw);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_of_clk_add_hw_provider(&pdev->dev, meson_clk_hw_get,
> +					  (void *)&data->hw_clks);
> +	if (ret)
> +		return ret;
> +
> +	if (!data->rst_drvname)
> +		return 0;
> +
> +	return devm_meson_rst_aux_register(&pdev->dev, map, data->rst_drvname);
> +}
> +
> +static const struct of_device_id a1_audio_clkc_match_table[] = {
> +	{
> +		.compatible = "amlogic,a1-audio-clkc",
> +		.data = &a1_audio_clkc,
> +	},
> +	{
> +		.compatible = "amlogic,a1-audio-vad-clkc",
> +		.data = &a1_audio_vad_clkc,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, a1_audio_clkc_match_table);
> +
> +static struct platform_driver a1_audio_clkc_driver = {
> +	.probe = a1_audio_clkc_probe,
> +	.driver = {
> +		.name = "a1-audio-clkc",
> +		.of_match_table = a1_audio_clkc_match_table,
> +	},
> +};
> +module_platform_driver(a1_audio_clkc_driver);
> +
> +MODULE_DESCRIPTION("Amlogic A1 Audio Clock driver");
> +MODULE_AUTHOR("Jan Dakinevich <jan.dakinevich@salutedevices.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/clk/meson/a1-audio-vad-clkc.c b/drivers/clk/meson/a1-audio-vad-clkc.c
> new file mode 100644
> index 000000000000..0b1365d30ce1
> --- /dev/null
> +++ b/drivers/clk/meson/a1-audio-vad-clkc.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
> +
> +#include "a1-audio.h"
> +
> +#define AUDIO_VAD_CLK_GATE_EN0		0x00c
> +#define AUDIO_VAD_MCLK_CTRL		0x040
> +#define AUDIO_VAD_CLK_CTRL		0x044
> +#define AUDIO_VAD_CLK_PDMIN_CTRL0	0x058
> +#define AUDIO_CLK_VAD_PDMIN_CTRL1	0x05c
> +
> +struct clk_regmap aud_vad_ddr_arb =
> +	AUD_PCLK_GATE(vad_ddr_arb, AUDIO_VAD_CLK_GATE_EN0, 0);
> +struct clk_regmap aud_vad_pdm =
> +	AUD_PCLK_GATE(vad_pdm, AUDIO_VAD_CLK_GATE_EN0, 1);
> +struct clk_regmap aud_vad_tdmin_vad =
> +	AUD_PCLK_GATE(vad_tdmin_vad, AUDIO_VAD_CLK_GATE_EN0, 2);
> +struct clk_regmap aud_vad_toddr_vad =
> +	AUD_PCLK_GATE(vad_toddr_vad, AUDIO_VAD_CLK_GATE_EN0, 3);
> +struct clk_regmap aud_vad =
> +	AUD_PCLK_GATE(vad, AUDIO_VAD_CLK_GATE_EN0, 4);
> +struct clk_regmap aud_vad_audiotop =
> +	AUD_PCLK_GATE(vad_audiotop, AUDIO_VAD_CLK_GATE_EN0, 7);
> +
> +struct clk_regmap aud_vad_mclk_sel =
> +	AUD_MST_MCLK_MUX(vad_mclk, AUDIO_VAD_MCLK_CTRL);
> +struct clk_regmap aud_vad_mclk_div =
> +	AUD_MST_MCLK_DIV(vad_mclk, AUDIO_VAD_MCLK_CTRL);
> +struct clk_regmap aud_vad_mclk =
> +	AUD_MST_MCLK_GATE(vad_mclk, AUDIO_VAD_MCLK_CTRL);
> +
> +struct clk_regmap aud_vad_clk_sel =
> +	AUD_MST_MCLK_MUX(vad_clk, AUDIO_VAD_CLK_CTRL);
> +struct clk_regmap aud_vad_clk_div =
> +	AUD_MST_MCLK_DIV(vad_clk, AUDIO_VAD_CLK_CTRL);
> +struct clk_regmap aud_vad_clk =
> +	AUD_MST_MCLK_GATE(vad_clk, AUDIO_VAD_CLK_CTRL);
> +
> +struct clk_regmap aud_vad_pdm_dclk_sel =
> +	AUD_MST_MCLK_MUX(vad_pdm_dclk, AUDIO_VAD_CLK_PDMIN_CTRL0);
> +struct clk_regmap aud_vad_pdm_dclk_div =
> +	AUD_MST_MCLK_DIV(vad_pdm_dclk, AUDIO_VAD_CLK_PDMIN_CTRL0);
> +struct clk_regmap aud_vad_pdm_dclk =
> +	AUD_MST_MCLK_GATE(vad_pdm_dclk, AUDIO_VAD_CLK_PDMIN_CTRL0);
> +
> +struct clk_regmap aud_vad_pdm_sysclk_sel =
> +	AUD_MST_MCLK_MUX(vad_pdm_sysclk, AUDIO_CLK_VAD_PDMIN_CTRL1);
> +struct clk_regmap aud_vad_pdm_sysclk_div =
> +	AUD_MST_MCLK_DIV(vad_pdm_sysclk, AUDIO_CLK_VAD_PDMIN_CTRL1);
> +struct clk_regmap aud_vad_pdm_sysclk =
> +	AUD_MST_MCLK_GATE(vad_pdm_sysclk, AUDIO_CLK_VAD_PDMIN_CTRL1);
> +
> +static struct clk_hw *a1_audio_vad_clkc_hws[] = {
> +	[AUD_CLKID_VAD_DDR_ARB]		= &aud_vad_ddr_arb.hw,
> +	[AUD_CLKID_VAD_PDM]		= &aud_vad_pdm.hw,
> +	[AUD_CLKID_VAD_TDMIN]		= &aud_vad_tdmin_vad.hw,
> +	[AUD_CLKID_VAD_TODDR]		= &aud_vad_toddr_vad.hw,
> +	[AUD_CLKID_VAD]			= &aud_vad.hw,
> +	[AUD_CLKID_VAD_AUDIOTOP]	= &aud_vad_audiotop.hw,
> +	[AUD_CLKID_VAD_MCLK_SEL]	= &aud_vad_mclk_sel.hw,
> +	[AUD_CLKID_VAD_MCLK_DIV]	= &aud_vad_mclk_div.hw,
> +	[AUD_CLKID_VAD_MCLK]		= &aud_vad_mclk.hw,
> +	[AUD_CLKID_VAD_CLK_SEL]		= &aud_vad_clk_sel.hw,
> +	[AUD_CLKID_VAD_CLK_DIV]		= &aud_vad_clk_div.hw,
> +	[AUD_CLKID_VAD_CLK]		= &aud_vad_clk.hw,
> +	[AUD_CLKID_VAD_PDM_DCLK_SEL]	= &aud_vad_pdm_dclk_sel.hw,
> +	[AUD_CLKID_VAD_PDM_DCLK_DIV]	= &aud_vad_pdm_dclk_div.hw,
> +	[AUD_CLKID_VAD_PDM_DCLK]	= &aud_vad_pdm_dclk.hw,
> +	[AUD_CLKID_VAD_PDM_SYSCLK_SEL]	= &aud_vad_pdm_sysclk_sel.hw,
> +	[AUD_CLKID_VAD_PDM_SYSCLK_DIV]	= &aud_vad_pdm_sysclk_div.hw,
> +	[AUD_CLKID_VAD_PDM_SYSCLK]	= &aud_vad_pdm_sysclk.hw,
> +};
> +
> +struct a1_audio_data a1_audio_vad_clkc = {
> +	.hw_clks = {
> +		.hws = a1_audio_vad_clkc_hws,
> +		.num = ARRAY_SIZE(a1_audio_vad_clkc_hws),
> +	},

No reset for VAD ? The documentation shows some.

> +};
> diff --git a/drivers/clk/meson/a1-audio.h b/drivers/clk/meson/a1-audio.h
> new file mode 100644
> index 000000000000..ecd0b1ea4aea
> --- /dev/null
> +++ b/drivers/clk/meson/a1-audio.h
> @@ -0,0 +1,131 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> + */
> +
> +#ifndef __MESON_CLK_A1_AUDIO_H
> +#define __MESON_CLK_A1_AUDIO_H
> +
> +#include "clk-phase.h"
> +#include "clk-regmap.h"
> +#include "meson-audio.h"
> +#include "meson-clkc-utils.h"
> +#include "sclk-div.h"
> +
> +#define AUD_PCLK_GATE(_name, _reg, _bit) {				\
> +	.data = &(struct clk_regmap_gate_data){				\
> +		.offset = (_reg),					\
> +		.bit_idx = (_bit),					\
> +	},								\
> +	.hw.init = &(struct clk_init_data) {				\
> +		.name = "aud_"#_name,					\
> +		.ops = &clk_regmap_gate_ops,				\
> +		.parent_data = &(const struct clk_parent_data) {	\
> +			.fw_name = "pclk"				\
> +		},							\
> +		.num_parents = 1,					\
> +	},								\
> +}

No reason to leave this out of the common solely because of the parent
name. Add argument.

BUT checking more carefully, the chip does have audio top clocks, one for
each controller, plus a common one. Check EE_AUDIO2_CLK81_EN and
EE_AUDIO2_GATE_EN0. There is a tree to properly implement, same as sm1.

* EE_AUDIO2_CLK81_CTRL (which you skipped) feeds EE_AUDIO2_CLK81_EN
* EE_AUDIO2_CLK81_EN should be the parent of audio_top
* audio_top the parent of pclks - VAD is pclks are skipping it, is
  intentional ?

All that seems critical for the audio tree to be properly clocked.

> +
> +#define AUD_MST_MCLK_PDATA ((const struct clk_parent_data[]) {		\
> +	{ .fw_name = "mst_in0" },					\
> +	{ .fw_name = "mst_in1" },					\
> +	{ .fw_name = "mst_in2" },					\
> +	{ .fw_name = "mst_in3" },					\
> +	{ .fw_name = "mst_in4" },					\
> +})
> +#define AUD_MST_MCLK_MUX(_name, _reg)					\
> +	AUD_MUX(_name##_sel, (_reg), 0x7, 24, CLK_MUX_ROUND_CLOSEST,	\
> +		AUD_MST_MCLK_PDATA, 0)
> +#define AUD_MST_MCLK_DIV(_name, _reg)					\
> +	AUD_DIV(_name##_div, (_reg), 0, 16, CLK_DIVIDER_ROUND_CLOSEST,	\
> +		aud_##_name##_sel, CLK_SET_RATE_PARENT)
> +#define AUD_MST_MCLK_GATE(_name, _reg)					\
> +	AUD_GATE(_name, (_reg), 31,					\
> +		aud_##_name##_div, CLK_SET_RATE_PARENT)
> +
> +#define AUD_MST_SCLK_PRE_EN(_name, _reg, _pname)			\
> +	AUD_GATE(_name##_pre_en, (_reg), 31,				\
> +		aud_##_pname, 0)
> +#define AUD_MST_SCLK_DIV(_name, _reg)					\
> +	AUD_SCLK_DIV(_name##_div, (_reg), 20, 10, 0, 0,			\
> +		aud_##_name##_pre_en, CLK_SET_RATE_PARENT)
> +#define AUD_MST_SCLK_POST_EN(_name, _reg)				\
> +	AUD_GATE(_name##_post_en, (_reg), 30,				\
> +		 aud_##_name##_div, CLK_SET_RATE_PARENT)
> +#define AUD_MST_SCLK(_name, _reg)					\
> +	AUD_TRIPHASE(_name, (_reg), 1, 0, 2, 4,				\
> +		aud_##_name##_post_en, CLK_SET_RATE_PARENT)
> +
> +#define AUD_MST_LRCLK_DIV(_name, _reg, _pname)				\
> +	AUD_SCLK_DIV(_name##_div, (_reg), 0, 10, 10, 10,		\
> +		aud_##_pname, 0)
> +#define AUD_MST_LRCLK(_name, _reg)					\
> +	AUD_TRIPHASE(_name, (_reg), 1, 1, 3, 5,				\
> +		aud_##_name##_div, CLK_SET_RATE_PARENT)
> +
> +#define AUD_MST_SCLK_PDATA ((const struct clk_parent_data[]) {		\
> +	{ .hw = &aud_mst_a_sclk.hw, .index = -1 },			\
> +	{ .hw = &aud_mst_b_sclk.hw, .index = -1 },			\
> +	{ .hw = &aud_mst_c_sclk.hw, .index = -1 },			\
> +	{ .hw = &aud_mst_d_sclk.hw, .index = -1 },			\
> +	{ .hw = NULL },							\
> +	{ .hw = NULL },							\
> +	{ .fw_name = "slv_sclk0" },					\
> +	{ .fw_name = "slv_sclk1" },					\
> +	{ .fw_name = "slv_sclk2" },					\
> +	{ .fw_name = "slv_sclk3" },					\
> +	{ .fw_name = "slv_sclk4" },					\
> +	{ .fw_name = "slv_sclk5" },					\
> +	{ .fw_name = "slv_sclk6" },					\
> +	{ .fw_name = "slv_sclk7" },					\
> +	{ .fw_name = "slv_sclk8" },					\
> +	{ .fw_name = "slv_sclk9" },					\
> +})
> +#define AUD_TDM_SCLK_MUX(_name, _reg)					\
> +	AUD_MUX(_name##_sel, (_reg), 0xf, 24, CLK_MUX_ROUND_CLOSEST,	\
> +		AUD_MST_SCLK_PDATA, 0)
> +#define AUD_TDM_SCLK_PRE_EN(_name, _reg)				\
> +	AUD_GATE(_name##_pre_en, (_reg), 31,				\
> +		aud_##_name##_sel, CLK_SET_RATE_PARENT)
> +#define AUD_TDM_SCLK_POST_EN(_name, _reg)				\
> +	AUD_GATE(_name##_post_en, (_reg), 30,				\
> +		aud_##_name##_pre_en, CLK_SET_RATE_PARENT)
> +#define AUD_TDM_SCLK_WS(_name, _reg)					\
> +	AUD_SCLK_WS(_name, (_reg), 1, 29, 28,				\
> +		aud_##_name##_post_en,					\
> +		CLK_DUTY_CYCLE_PARENT | CLK_SET_RATE_PARENT)
> +
> +#define AUD_MST_LRCLK_PDATA ((const struct clk_parent_data[]) {		\
> +	{ .hw = &aud_mst_a_lrclk.hw, .index = -1 },			\
> +	{ .hw = &aud_mst_b_lrclk.hw, .index = -1 },			\
> +	{ .hw = &aud_mst_c_lrclk.hw, .index = -1 },			\
> +	{ .hw = &aud_mst_d_lrclk.hw, .index = -1 },			\
> +	{ .hw = NULL },							\
> +	{ .hw = NULL },							\
> +	{ .fw_name = "slv_lrclk0" },					\
> +	{ .fw_name = "slv_lrclk1" },					\
> +	{ .fw_name = "slv_lrclk2" },					\
> +	{ .fw_name = "slv_lrclk3" },					\
> +	{ .fw_name = "slv_lrclk4" },					\
> +	{ .fw_name = "slv_lrclk5" },					\
> +	{ .fw_name = "slv_lrclk6" },					\
> +	{ .fw_name = "slv_lrclk7" },					\
> +	{ .fw_name = "slv_lrclk8" },					\
> +	{ .fw_name = "slv_lrclk9" },					\
> +})
> +#define AUD_TDM_LRLCK(_name, _reg)					\
> +	AUD_MUX(_name, (_reg), 0xf, 20, CLK_MUX_ROUND_CLOSEST,		\
> +		AUD_MST_LRCLK_PDATA, CLK_SET_RATE_PARENT)
> +
> +struct a1_audio_data {
> +	struct meson_clk_hw_data hw_clks;
> +	const char *rst_drvname;
> +};
> +
> +extern struct a1_audio_data a1_audio_clkc;
> +extern struct a1_audio_data a1_audio_vad_clkc;
> +
> +#endif /* __MESON_CLK_A1_AUDIO_H */

-- 
Jerome

