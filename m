Return-Path: <linux-kernel+bounces-343771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB8A989F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA111F22C35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD7518990B;
	Mon, 30 Sep 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mjcziuuf"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489017BB28
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691391; cv=none; b=aL120bTz8aiUDRrhhoXit1fcxf1LlO1tKNpADjxHPRpwQ85BXe2PGodg9xN4vBzKlCsDCXAYCmtiDRl6SEtwtxL68PBn3UdRvMqlHz+0wLCKIT/LMDRHrpkQr5SaxsN0IT25dzgoe3N/m82MUce0XR09u7PtXSJfyai/mUqRkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691391; c=relaxed/simple;
	bh=nxnkKpVKYhz1uhaTWThL3G5q2cQLmLgqieyZA2MyJek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NR7sPHDTbrBKiXcKbv2SZZLymJu9oCUI8pH5Q8SzFvLxFepHtpIYnbdHnXv7k9K4L4LP077RX/tdKL8TKMZ2vTx4DeZhUEPITb+9MfW5o/oH7h/RuhdFYf1k8KEBlKhBGi6bJRVp8UeMWPh+t/azAuuvo0ruHj3Lv+l5u3CuSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mjcziuuf; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ce18b042fso1203588f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727691387; x=1728296187; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ept6PF3z6zGmfanJb7Xv6BjUTwCdrXXzgAXSokyXkdU=;
        b=mjcziuufC6R9m5Yt/HvavDc3MxBTL+pj5LUqC60w/oTIMCdmLQoKt+ERwQm7utiJlg
         WxQh2mZrIeql0GJum6e20xXlggtnlrAN0bop36gFweFRrnfiepbUz0dyyry9EzjsvZ4w
         Hvt4mrPICkgr0UR8d9lhXoaeiRb5Fz25jm22fEXY0ctoRtEdwzXVT1WBl8Cbv5MFoZv8
         YpndRW7JfNoU7dDfe1oLYoEoD0VoBvAHTOjHkw0hSJ4StWkzN98RyS6yz1Ox27pltW5T
         rlulRFepXX5IrA0tdAalULBh33f6RedGE2/lwDqS0bLIHDsCQGDgiW4YFH/0p7a+lUI8
         YpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691387; x=1728296187;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ept6PF3z6zGmfanJb7Xv6BjUTwCdrXXzgAXSokyXkdU=;
        b=jQ4jGJmqKm0joz2gxJ3PpaLJiPVPyYMePoX7VrmCRK4aVqQfswsWaf68Jcs4clXy7f
         IT/UWAoPpcDyeKVUAUFnPgbnuTaGeAnygYp0X7Q/zTORcVSwrnClPI1rh4cYw+JbXHIv
         uuKpqaAAZDMjqdTWM+gfIohXtJ3ldardyHj6t966qst3gOM2v7RebYxYxeca8GMAP2GP
         4Bvf/1zRVIe/MnvrT4xFGjTYNfpyzBGhEE3lrOX6beB3Jgvyqdox3WO34o6vy2YqTpOa
         /alXvhtxlZ2JKxMI7BSeoMjGNZlLqV4CGshWkgtZicy7oMeBxVQU4ZCFWOz3Be7CfUxE
         LSIw==
X-Forwarded-Encrypted: i=1; AJvYcCUvtxQHwJlSCqg46sNyhzmweTB0wIzRd0uK6WOUyj22ganVcLrN6qiXll191FHUEwcyf72hZVIH9TGR/Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbELR+nQzlt7qcrHBDEtuJ1D2oFaALUSw54d9bR/AUBriNkzqe
	OLzCP0nQQ1LPBX9ZHN2qbSVo6nmP+wsWjDwH2iY2AOhDgKJbbqAQxPG+c1VC4Sk=
X-Google-Smtp-Source: AGHT+IE9hAG6wDYLSDHEcerPNno3aHUL2cQSG0dDgw4C8t0z2/bGDDaSzeigceSgmlLPCKImmNAdcg==
X-Received: by 2002:adf:fec7:0:b0:37c:d11c:aa45 with SMTP id ffacd0b85a97d-37cd5b1ebcfmr5961790f8f.59.1727691386672;
        Mon, 30 Sep 2024 03:16:26 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b6ba:bab:ced3:2667])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e433sm8645836f8f.36.2024.09.30.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:16:26 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>,
  Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Chuan Liu <chuan.liu@amlogic.com>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] clk: meson: add A5 clock peripherals controller driver
In-Reply-To: <4ce0c864-fd82-42f3-8122-7ff921b5cc8b@amlogic.com> (Xianwei
	Zhao's message of "Sun, 29 Sep 2024 16:44:03 +0800")
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
	<20240914-a5-clk-v1-5-5ee2c4f1b08c@amlogic.com>
	<1jjzf1xf55.fsf@starbuckisacylon.baylibre.com>
	<4ce0c864-fd82-42f3-8122-7ff921b5cc8b@amlogic.com>
Date: Mon, 30 Sep 2024 12:16:25 +0200
Message-ID: <1jldz9tpja.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun 29 Sep 2024 at 16:44, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

[...]

>>> +static A4_SYS_GATE(sys_eth_mac,              CLKCTRL_SYS_CLK_EN0_REG0, 26, 0);
>>> +
>>> +/*
>>> + * FIXME: sys_gic provides the clock for GIC(Generic Interrupt Controller).
>>> + * After clock is disabled, The GIC cannot work properly. At present, the driver
>>> + * used by our GIC is the public driver in kernel, and there is no management
>>> + * clock in the driver.
>>> + */
>>> +static A4_SYS_GATE(sys_gic,          CLKCTRL_SYS_CLK_EN0_REG0, 27, CLK_IS_CRITICAL);
>> The GIC has a driver. If it needs clock, maybe it should request it and
>> enable it, maybe as optional.
>> 
>
> This has been explained in C3. GIC is a public driver that does not
> reference clock, so you suggest setting it as CRITICAL and adding the
> "FIXME" annotation.

Yes indeed ... and at some point, it is expected something will be done
a actually fix the situation ... not just pile-up FIXME comments.

Adding a clock to a driver that should have one seems doable.

>
>>> +static A4_SYS_GATE(sys_rama,         CLKCTRL_SYS_CLK_EN0_REG0, 28, 0);
>>> +
>>> +/*
>>> + * NOTE: sys_big_nic provides the clock to the control bus of the NIC(Network
>>> + * Interface Controller) between multiple devices(CPU, DDR, RAM, ROM, GIC,
>>> + * SPIFC, CAPU, JTAG, EMMC, SDIO, sec_top, USB, Audio, ETH, SPICC) in the
>>> + * system. After clock is disabled, The NIC cannot work.
>>> + */
>> This comment looks like a clock that should be passed as ressource to a
>> bus or power-domain to be properly manage. This is a pattern that keeps
>> on repeating. I will not block you on it this time around but I strong
>> suggest you fix up the situation on the related platform. Next time
>> around, the reason won't be a valid one.
>> 
>
> There are too many modules associated with this clock... The most important
> is the inclusion of some system-level modules that are not managed by the
> driver in the kernel and cannot close their clocks, perhaps it is not
> appropriate to describe it here.
>
> In the next version I moved it to scmi-clk for management?

No. The number of module associated with a clock should not be a
concern and SCMI should not be a 'Hide all the things I don't want to do
in linux things'.

You've got a bus that needs a clocks. There are possibilities associate
a clock with bus in DT, either directly or through power-domains. Please
do it correctly.

>
>>> +static A4_SYS_GATE(sys_big_nic,              CLKCTRL_SYS_CLK_EN0_REG0, 29, CLK_IS_CRITICAL);
>>> +static A4_SYS_GATE(sys_ramb,         CLKCTRL_SYS_CLK_EN0_REG0, 30, 0);
>>> +static A4_SYS_GATE(sys_audio_top,    CLKCTRL_SYS_CLK_EN0_REG1, 0, 0);
>>> +static A4_SYS_GATE(sys_audio_vad,    CLKCTRL_SYS_CLK_EN0_REG1, 1, 0);
>>> +static A4_SYS_GATE(sys_usb,          CLKCTRL_SYS_CLK_EN0_REG1, 2, 0);
>>> +static A4_SYS_GATE(sys_sd_emmc_a,    CLKCTRL_SYS_CLK_EN0_REG1, 3, 0);
>>> +static A4_SYS_GATE(sys_sd_emmc_c,    CLKCTRL_SYS_CLK_EN0_REG1, 4, 0);
>>> +static A4_SYS_GATE(sys_pwm_ab,               CLKCTRL_SYS_CLK_EN0_REG1, 5, 0);
>>> +static A4_SYS_GATE(sys_pwm_cd,               CLKCTRL_SYS_CLK_EN0_REG1, 6, 0);
>>> +static A4_SYS_GATE(sys_pwm_ef,               CLKCTRL_SYS_CLK_EN0_REG1, 7, 0);
>>> +static A4_SYS_GATE(sys_pwm_gh,               CLKCTRL_SYS_CLK_EN0_REG1, 8, 0);
>>> +static A4_SYS_GATE(sys_spicc_1,              CLKCTRL_SYS_CLK_EN0_REG1, 9, 0);
>>> +static A4_SYS_GATE(sys_spicc_0,              CLKCTRL_SYS_CLK_EN0_REG1, 10, 0);
>>> +static A4_SYS_GATE(sys_uart_a,               CLKCTRL_SYS_CLK_EN0_REG1, 11, 0);
>>> +static A4_SYS_GATE(sys_uart_b,               CLKCTRL_SYS_CLK_EN0_REG1, 12, 0);
>>> +static A4_SYS_GATE(sys_uart_c,               CLKCTRL_SYS_CLK_EN0_REG1, 13, 0);
>>> +static A4_SYS_GATE(sys_uart_d,               CLKCTRL_SYS_CLK_EN0_REG1, 14, 0);
>>> +static A4_SYS_GATE(sys_uart_e,               CLKCTRL_SYS_CLK_EN0_REG1, 15, 0);
>>> +static A4_SYS_GATE(sys_i2c_m_a,              CLKCTRL_SYS_CLK_EN0_REG1, 16, 0);
>>> +static A4_SYS_GATE(sys_i2c_m_b,              CLKCTRL_SYS_CLK_EN0_REG1, 17, 0);
>>> +static A4_SYS_GATE(sys_i2c_m_c,              CLKCTRL_SYS_CLK_EN0_REG1, 18, 0);
>>> +static A4_SYS_GATE(sys_i2c_m_d,              CLKCTRL_SYS_CLK_EN0_REG1, 19, 0);
>>> +static A4_SYS_GATE(sys_rtc,          CLKCTRL_SYS_CLK_EN0_REG1, 21, 0);
>>> +
>>> +#define A4_AXI_GATE(_name, _reg, _bit, _flags)                               \
>>> +     A4_CLK_GATE(_name, _reg, _bit, axiclk,                          \
>>> +                 &clk_regmap_gate_ops, _flags)
>>> +
>>> +static A4_AXI_GATE(axi_audio_vad,    CLKCTRL_AXI_CLK_EN0, 0, 0);
>>> +static A4_AXI_GATE(axi_audio_top,    CLKCTRL_AXI_CLK_EN0, 1, 0);
>>> +
>>> +/*
>>> + * NOTE: axi_sys_nic provides the clock to the AXI bus of the system NIC. After
>>> + * clock is disabled, The NIC cannot work.
>>> + */
>>> +static A4_AXI_GATE(axi_sys_nic,              CLKCTRL_AXI_CLK_EN0, 2, CLK_IS_CRITICAL);
>>> +static A4_AXI_GATE(axi_ramb,         CLKCTRL_AXI_CLK_EN0, 5, 0);
>>> +static A4_AXI_GATE(axi_rama,         CLKCTRL_AXI_CLK_EN0, 6, 0);
>>> +
>>> +/*
>>> + * NOTE: axi_cpu_dmc provides the clock to the AXI bus where the CPU accesses
>>> + * the DDR. After clock is disabled, The CPU will not have access to the DDR.
>>> + */
>>> +static A4_AXI_GATE(axi_cpu_dmc,              CLKCTRL_AXI_CLK_EN0, 7, CLK_IS_CRITICAL);
>>> +static A4_AXI_GATE(axi_nna,          CLKCTRL_AXI_CLK_EN0, 12, 0);
>>> +
>>> +/*
>>> + * NOTE: axi_dev1_dmc provides the clock for the peripherals(EMMC, SDIO,
>>> + * sec_top, USB, Audio) to access the AXI bus of the DDR.
>>> + */
>> Same.
>> 
>
> These normal peripheral drivers manage the clock without a problem.
>
>>> +static A4_AXI_GATE(axi_dev1_dmc,     CLKCTRL_AXI_CLK_EN0, 13, 0);
>>> +
>>> +/*
>>> + * NOTE: axi_dev0_dmc provides the clock for the peripherals(ETH and SPICC)
>>> + * to access the AXI bus of the DDR.
>>> + */
>>> +static A4_AXI_GATE(axi_dev0_dmc,     CLKCTRL_AXI_CLK_EN0, 14, 0);
>>> +static A4_AXI_GATE(axi_dsp_dmc,              CLKCTRL_AXI_CLK_EN0, 15, 0);
>>> +
>>> +static struct clk_regmap clk_12_24m_in = {
>>> +     .data = &(struct clk_regmap_gate_data) {
>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>> +             .bit_idx = 11,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "clk_12_24m_in",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_data = &(const struct clk_parent_data) {
>>> +                     .fw_name = "xtal_24m",
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap clk_12_24m = {
>>> +     .data = &(struct clk_regmap_div_data) {
>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>> +             .shift = 10,
>>> +             .width = 1,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "clk_12_24m",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &clk_12_24m_in.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +/* FIXME: set value 0 will div by 2 like value 1 */
>> Again, it is fine when it happens once, like the c3.
>> When the pattern starts repeating, it is time to do something about it.
>> 
>
> The corresponding suggestions have been made to the hardware designer, but
> now the designed chip cannot be repaired.

Not asking to fix the HW (although that would be nice if you could)
The HW is what it is. The SW needs fixing. That you can do.

>
>>> +static struct clk_regmap fclk_25m_div = {
>>> +     .data = &(struct clk_regmap_div_data) {
>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>> +             .shift = 0,
>>> +             .width = 8,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_25m_div",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_data = &(const struct clk_parent_data) {
>>> +                     .fw_name = "fix",
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap fclk_25m = {
>>> +     .data = &(struct clk_regmap_gate_data) {
>>> +             .offset = CLKCTRL_CLK12_24_CTRL,
>>> +             .bit_idx = 12,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "fclk_25m",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &fclk_25m_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +/*
>>> + * Channel 3(ddr_dpll_pt_clk) is manged by the DDR module; channel 12(cts_msr_clk)
>>> + * is manged by clock measures module. Their hardware are out of clock tree.
>> Yet, they exist and should be part of the bindings since they are
>> obviously input to this clock.
>> 
>
> Will add it to bindings, as optional input clock source.
>
>>> + * Channel 4 5 8 9 10 11 13 14 15 16 18 are not connected.
>>> + *
>>> + * gp1 is designed for DSU (DynamIQ Shared Unit) alone. It cannot be changed
>>> + * arbitrarily. gp1 is read-only in the kernel and is only open for debug purposes.
>>> + */
>>> +static u32 gen_parent_table[] = { 0, 1, 2, 6, 7, 17, 19, 20, 21, 22, 23, 24, 25,
>>> +                               26, 27, 28};
>>> +
>>> +static const struct clk_parent_data gen_parent_data[] = {
>>> +     { .fw_name = "oscin" },
>>> +     { .hw = &rtc_clk.hw },
>>> +     { .fw_name = "sysplldiv16" },
>>> +     { .fw_name = "gp1" },
>>> +     { .fw_name = "hifi" },
>>> +     { .fw_name = "cpudiv16" },
>>> +     { .fw_name = "fdiv2" },
>>> +     { .fw_name = "fdiv2p5" },
>>> +     { .fw_name = "fdiv3" },
>>> +     { .fw_name = "fdiv4" },
>>> +     { .fw_name = "fdiv5" },
>>> +     { .fw_name = "fdiv7" },
>>> +     { .fw_name = "mpll0" },
>>> +     { .fw_name = "mpll1" },
>>> +     { .fw_name = "mpll2" },
>>> +     { .fw_name = "mpll3" }
>>> +};

[...]

>>> +
>>> +static struct clk_regmap pwm_h_sel =
>>> +     AML_PWM_CLK_MUX(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 25);
>>> +static struct clk_regmap pwm_h_div =
>>> +     AML_PWM_CLK_DIV(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 16);
>>> +static struct clk_regmap pwm_h =
>>> +     AML_PWM_CLK_GATE(pwm_h, CLKCTRL_PWM_CLK_GH_CTRL, 24);
>>> +
>>> +/* Channel 7 is gp1. */
>> and ? if GP1 is RO, why can't you add it here ?
>> 
>
> gp1_pll is a special clock for DSU, it is integrated into dsu_clk, we
> don't want other modules to reference it.
>
> My understanding is that gp1_pll should not be provided to the peripheral
> clock tree, perhaps this is a redundant design.

Then /* Channel 7 is gp1 which is reserved for DSU */

Note that if GP1 is actually RO and DSU does not change the rate at
runtime through other means, then listing GP1 here should not be a
problem, spi would just be user of an available PLL.

>
>>> +static const struct clk_parent_data spicc_parent_data[] = {
>>> +     { .fw_name = "oscin" },
>>> +     { .fw_name = "sysclk" },
>>> +     { .fw_name = "fdiv4" },
>>> +     { .fw_name = "fdiv3" },
>>> +     { .fw_name = "fdiv2" },
>>> +     { .fw_name = "fdiv5" },
>>> +     { .fw_name = "fdiv7" }
>>> +};
>>> +
>>> +static struct clk_regmap spicc_0_sel = {
>>> +     .data = &(struct clk_regmap_mux_data) {
>>> +             .offset = CLKCTRL_SPICC_CLK_CTRL,
>>> +             .mask = 0x7,
>>> +             .shift = 7,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "spicc_0_sel",
>>> +             .ops = &clk_regmap_mux_ops,
>>> +             .parent_data = spicc_parent_data,
>>> +             .num_parents = ARRAY_SIZE(spicc_parent_data),
>>> +     },
>>> +};

[...]

>>> +
>>> +static struct clk_regmap dspa_1 = {
>>> +     .data = &(struct clk_regmap_gate_data) {
>>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>>> +             .bit_idx = 29,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "dspa_1",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &dspa_1_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT,
>> A word about SET_RATE_GATE ?
>> 
>
> Look at the response to one of the questions below.

Still a word ? your comment below does justify this flag clearly.

>
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap dspa = {
>>> +     .data = &(struct clk_regmap_mux_data){
>>> +             .offset = CLKCTRL_DSPA_CLK_CTRL0,
>>> +             .mask = 0x1,
>>> +             .shift = 15,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "dspa",
>>> +             .ops = &clk_regmap_mux_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &dspa_0.hw,
>>> +                     &dspa_1.hw
>>> +             },
>>> +             .num_parents = 2,
>>> +             /*
>>> +              * NOTE: This level of mux is "no glitch mux", and mux_0
>>> +              * (here dspa_0) is not only the clock source for mux, but also
>>> +              * provides a working clock for "no glitch mux". "no glitch mux"
>>> +              * can be switched only when mux_0 has a clock input. Therefore,
>>> +              * add flag CLK_OPS_PARENT_ENABLE to ensure that mux_0 has clock
>>> +              * when "no glitch mux" works.
>>> +              */
>>> +             .flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
>> Humm CLK_OPS_PARENT_ENABLE is not how we have handling glitch free mux
>> so far. What changed ?
>> 
>
> This is a hidden problem we have discovered in recent years, the previous
> chip use is ping-pong switching "no-glitch-mux/glitch free" have this
> problem. If mux_0 does not have a clock "no-glitch-mux", it will not be
> able to switch channels, and I will organize and submit patch to fix it
> later.

The NOTE comment and what the code does are not aligned.
* Your comment says that input #0 must be enabled for the mux to work
* The flag ensure that parent is enabled before switching to it. There
  is nothing specific about input #0

>
>>> +     },
>>> +};
>>> +
>>> +/* Channel 6 is gp1. */
>>> +static u32 nna_parent_table[] = { 0, 1, 2, 3, 4, 5, 7};
>>> +
>>> +static const struct clk_parent_data nna_parent_data[] = {
>>> +     { .fw_name = "oscin" },
>>> +     { .fw_name = "fdiv2p5" },
>>> +     { .fw_name = "fdiv4" },
>>> +     { .fw_name = "fdiv3" },
>>> +     { .fw_name = "fdiv5" },
>>> +     { .fw_name = "fdiv2" },
>>> +     { .fw_name = "hifi" }
>>> +};


