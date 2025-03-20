Return-Path: <linux-kernel+bounces-569219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D59A6A028
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E60E4631F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161AC1EE7A1;
	Thu, 20 Mar 2025 07:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBvdVqAP"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B861C3F02;
	Thu, 20 Mar 2025 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742454591; cv=none; b=CIMS1Kgx2kqnLN/JYhDrgW8lF8HiLXDeb3vDOPZ0G6ZAXzVCid+3/rPfuFpixHDIJr/0CgGGCWWgY9NiNK6f8HYxOaF8hJ+f8iefjXlA44LqzdndaLSJt0OsjunCrEagnZC7FakZjX7eYVMANj36wloztSWuYI2eZKijKWuYJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742454591; c=relaxed/simple;
	bh=l54Me8SQYtRJpOJzuEZvDZASIL9r7/2qgJpC4Wv8qBs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jbfezDi43fo2BsXy9JmupPWW7dqkIa4Gb7JzNs1Er2mIFBae9aFwofayPVLVIOlGYe4kpWUUgF64V40XlnfyTUroYMahKxAqKwC2z6k1qxFGSHaxSf7srvrHlSpImZptwI3qXeLqGgYqs0VhzjlYg0s1P2AzP61oZmEOaQeQTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBvdVqAP; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22435603572so5792475ad.1;
        Thu, 20 Mar 2025 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742454588; x=1743059388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4nAhjK9y3Zh+il9eKutxRFA5s28HksmXJM2UbJ9s7NY=;
        b=bBvdVqAPtIUe+1YgMlbSmdMuTSlJFt6PXt33RfU58SMLEDn496amNfD02aA7bFdOHv
         uoRTjy8sApQog7tACPfprrfIhmKDqtrjxtVA5B01ZlfMoVx3N8mzqtcFejmLbAkiTrTl
         anNAqMa+7Nw6U2hnyXdCnQK6SGSb+gtxeoRMIdpBSsS3+ofjuNqekDR5+sMZrBWvY+WN
         gF7ndbQSo0aG1MpncCM2xi9onNB4dKY+hGml0DslLy7I/H70y1NxJjoAgMvSnEdl5HUy
         0Ae9oyAwuyMcTmh/xvMTG8FOovb/R9itskavxtE6jx0hevCvC5f3B9WC0rmUjsyDzWEr
         tLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742454588; x=1743059388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nAhjK9y3Zh+il9eKutxRFA5s28HksmXJM2UbJ9s7NY=;
        b=uYtJp5lYiVXkDSZwjRPNxFrRlW1mMM3/iSzXn1o2qWbdf5tgL0rjB8hLW6WHExmMZv
         EH3xpiE14R3cjnb3CeRq2/BM31+g7tEYk9z3o+a7LkHEzQ566uRwy3eM6ZiM6uT3OwNM
         YSb1seOYSg2xp00ejPxmzDFaFlNX8bcyRAimDrzOBrleU5XkLb8PNXbPwPFw2l539pgb
         qDVkVzcwxlmpCQcN3X+H1pLXKzPCxxmlJEzK92yFjUHZxfs2hHlAlR6/IbmkEWgYyW4k
         jCrcRUwyRorl1Yf1ToyizvV1tpHnRhDESHfgemZCp23Eztf1jgU1Z06KZv1CiRIBS0aY
         wjOg==
X-Forwarded-Encrypted: i=1; AJvYcCVmRyp+NvWrqTTA3qf3cSGAu08tvw6e4tO7Yasr4PLUhsfMIBkmcQBZeESybE/UlCn/nsIahkhsNhUq@vger.kernel.org, AJvYcCXNvNMyLqfVZ4gDv0f4oG03E8SWZk6/QRm7RMa+Y2jJSLC32m60IQU8H9vZeGjNTvjvQXwbTAxsFaAP@vger.kernel.org, AJvYcCXxhAkDeZDcVB13RRH3olGtpXnZUdhPw2RwZMAC5gHaDsgSkOnKx6br/Gim3P5XQtW9kDliExDi4MqPuTFn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vWmzW0bxdgdNqDR8HBanl1TR0Dx7qH9nNZ6wpM36ApQ/KR/g
	mxGi0RHBsq7zyvI51b1Sn9XctQWweMaUdSc2AXA1RgsUm/MRgOy2
X-Gm-Gg: ASbGncu9gIANFmHGpb4frWqkgUmTIjdCKWy87JERfhLJ1XrTC1sjTxhO4cZRgb+X03d
	dyribQVLrTzklOxyu+/8p0SYJs1QLIyOC8DPDt3XckpZJGs0Giwz6iQ0SIs8YC8d8YnkA0kZe4X
	MVfCqjoMlpwT6CmYh5xgKwj1WDAx+fkFZ6/ZfW3N9Tar0t/ZnlSoFm0kggzO5nEwH5KIQ24PNuh
	EmTuTQUTQBx8TGW/qxO3d5sF9becNoL+fyIHXHlPOlX4HU9Fcm3MAWvo9aCqMZ3zsiHNgDG2sgg
	APgFiBy16cIbkrkImdL02grmdxUTMw==
X-Google-Smtp-Source: AGHT+IGE5LYsYMAutyot9CUzHw9f/eayOhashOgX28tKi4FuPJBcL2K77OwhQcox15wTLrQtWywGNQ==
X-Received: by 2002:a17:902:e841:b0:220:e63c:5aff with SMTP id d9443c01a7336-2265ee904c0mr30968485ad.47.1742454588075;
        Thu, 20 Mar 2025 00:09:48 -0700 (PDT)
Received: from [172.29.0.1] ([2a0d:2683:c100::bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688856fsm128073435ad.14.2025.03.20.00.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 00:09:47 -0700 (PDT)
Message-ID: <fb9dba11-5a23-48a2-8b11-a544580eeaca@gmail.com>
Date: Thu, 20 Mar 2025 15:09:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: troymitchell988@gmail.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH RESEND v5 2/3] clk: canaan: Add clock driver for Canaan
 K230
To: Xukai Wang <kingxukai@zohomail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>
References: <20250320-b4-k230-clk-v5-0-0e9d089c5488@zohomail.com>
 <20250320-b4-k230-clk-v5-2-0e9d089c5488@zohomail.com>
Content-Language: en-US
From: Troy Mitchell <troymitchell988@gmail.com>
In-Reply-To: <20250320-b4-k230-clk-v5-2-0e9d089c5488@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/3/20 11:25, Xukai Wang wrote:
> This patch provides basic support for the K230 clock, which does not
> cover all clocks.
> 
> The clock tree of the K230 SoC consists of OSC24M, PLLs and sysclk.
> 
> Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
> Signed-off-by: Xukai Wang <kingxukai@zohomail.com>
> ---
>  drivers/clk/Kconfig    |    6 +
>  drivers/clk/Makefile   |    1 +
>  drivers/clk/clk-k230.c | 1711 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1718 insertions(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 299bc678ed1b9fcd9110bb8c5937a1bd1ea60e23..1817b8883af9a3d00ac7af2cb88496274b591001 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -464,6 +464,12 @@ config COMMON_CLK_K210
>  	help
>  	  Support for the Canaan Kendryte K210 RISC-V SoC clocks.
>  
> +config COMMON_CLK_K230
> +	bool "Clock driver for the Canaan Kendryte K230 SoC"
> +	depends on ARCH_CANAAN || COMPILE_TEST
> +        help
> +          Support for the Canaan Kendryte K230 RISC-V SoC clocks.
> +
>  config COMMON_CLK_SP7021
>  	tristate "Clock driver for Sunplus SP7021 SoC"
>  	depends on SOC_SP7021 || COMPILE_TEST
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index fb8878a5d7d93da6bec487460cdf63f1f764a431..5df50b1e14c701ed38397bfb257db26e8dd278b8 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_MACH_ASPEED_G6)		+= clk-ast2600.o
>  obj-$(CONFIG_ARCH_HIGHBANK)		+= clk-highbank.o
>  obj-$(CONFIG_CLK_HSDK)			+= clk-hsdk-pll.o
>  obj-$(CONFIG_COMMON_CLK_K210)		+= clk-k210.o
> +obj-$(CONFIG_COMMON_CLK_K230)		+= clk-k230.o
>  obj-$(CONFIG_LMK04832)			+= clk-lmk04832.o
>  obj-$(CONFIG_COMMON_CLK_LAN966X)	+= clk-lan966x.o
>  obj-$(CONFIG_COMMON_CLK_LOCHNAGAR)	+= clk-lochnagar.o
> diff --git a/drivers/clk/clk-k230.c b/drivers/clk/clk-k230.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..96e2a83830c1b69f0ed70ef2b6267e9f05fc505b
> --- /dev/null
> +++ b/drivers/clk/clk-k230.c
> @@ -0,0 +1,1711 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Kendryte Canaan K230 Clock Drivers
> + *
> + * Author: Xukai Wang <kingxukai@zohomail.com>
> + * Author: Troy Mitchell <troymitchell988@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/iopoll.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <dt-bindings/clock/canaan,k230-clk.h>
> +
> +/* PLL control register bits. */
> +#define K230_PLL_BYPASS_ENABLE				BIT(19)
> +#define K230_PLL_GATE_ENABLE				BIT(2)
> +#define K230_PLL_GATE_WRITE_ENABLE			BIT(18)
> +#define K230_PLL_OD_SHIFT				24
> +#define K230_PLL_OD_MASK				0xF
> +#define K230_PLL_R_SHIFT				16
> +#define K230_PLL_R_MASK					0x3F
> +#define K230_PLL_F_SHIFT				0
> +#define K230_PLL_F_MASK					0x1FFFF
> +#define K230_PLL0_OFFSET_BASE				0x00
> +#define K230_PLL1_OFFSET_BASE				0x10
> +#define K230_PLL2_OFFSET_BASE				0x20
> +#define K230_PLL3_OFFSET_BASE				0x30
> +#define K230_PLL_DIV_REG_OFFSET				0x00
> +#define K230_PLL_BYPASS_REG_OFFSET			0x04
> +#define K230_PLL_GATE_REG_OFFSET			0x08
> +#define K230_PLL_LOCK_REG_OFFSET			0x0C
> +
> +/* PLL lock register bits.  */
> +#define K230_PLL_STATUS_MASK				BIT(0)
> +
> +/* K230 CLK registers offset */
> +#define K230_CLK_AUDIO_CLKDIV_OFFSET			0x34
> +#define K230_CLK_PDM_CLKDIV_OFFSET			0x40
> +#define K230_CLK_CODEC_ADC_MCLKDIV_OFFSET		0x38
> +#define K230_CLK_CODEC_DAC_MCLKDIV_OFFSET		0x3c
> +
> +/* K230 CLK OPS. */
> +#define K230_CLK_OPS_GATE				\
> +	.enable		= k230_clk_enable,		\
> +	.disable	= k230_clk_disable,		\
> +	.is_enabled	= k230_clk_is_enabled
> +
> +#define K230_CLK_OPS_RATE				\
> +	.set_rate	= k230_clk_set_rate,		\
> +	.round_rate	= k230_clk_round_rate,		\
> +	.recalc_rate	= k230_clk_get_rate
> +
> +#define K230_CLK_OPS_MUX				\
> +	.set_parent	= k230_clk_set_parent,		\
> +	.get_parent	= k230_clk_get_parent,		\
> +	.determine_rate	= clk_hw_determine_rate_no_reparent
> +
> +#define K230_CLK_OPS_ID_NONE				0
> +#define K230_CLK_OPS_ID_GATE_ONLY			1
> +#define K230_CLK_OPS_ID_RATE_ONLY			2
> +#define K230_CLK_OPS_ID_RATE_GATE			3
> +#define K230_CLK_OPS_ID_MUX_ONLY			4
> +#define K230_CLK_OPS_ID_MUX_GATE			5
> +#define K230_CLK_OPS_ID_MUX_RATE			6
> +#define K230_CLK_OPS_ID_ALL				7
> +#define K230_CLK_OPS_ID_NUM				8
> +
> +/* K230 CLK MACROS */why all caps?

> +#define K230_CLK_MAX_PARENT_NUM				6
> +
> +#define K230_GATE_FORMAT(_reg, _bit, _reverse)					\
> +	.gate_reg_off = (_reg),							\
> +	.gate_bit_enable = (_bit),						\
> +	.gate_bit_reverse = (_reverse)
> +
> +#define K230_RATE_FORMAT(_mul_min, _mul_max, _mul_shift, _mul_mask,		\
> +			_div_min, _div_max, _div_shift, _div_mask,		\
> +			_reg, _bit, _method)					\
> +	.rate_mul_min = (_mul_min),						\
> +	.rate_mul_max = (_mul_max),						\
> +	.rate_mul_shift = (_mul_shift),						\
> +	.rate_mul_mask = (_mul_mask),						\
> +	.rate_div_min = (_div_min),						\
> +	.rate_div_max = (_div_max),						\
> +	.rate_div_shift = (_div_shift),						\
> +	.rate_div_mask = (_div_mask),						\
> +	.rate_reg_off = (_reg),							\
> +	.rate_write_enable_bit = (_bit),					\
> +	.method = (_method)
> +
> +#define K230_RATE_C_FORMAT(_mul_min, _mul_max, _mul_shift, _mul_mask,		\
> +			   _reg, _bit)						\
> +	.rate_mul_min_c = (_mul_min),						\
> +	.rate_mul_max_c = (_mul_max),						\
> +	.rate_mul_shift_c = (_mul_shift),					\
> +	.rate_mul_mask_c = (_mul_mask),						\
> +	.rate_reg_off_c = (_reg),						\
> +	.rate_write_enable_bit_c = (_bit)
> +
> +#define K230_MUX_FORMAT(_reg, _shift, _mask)					\
> +	.mux_reg_off = (_reg),							\
> +	.mux_reg_shift = (_shift),						\
> +	.mux_reg_mask = (_mask)
> +
> +struct k230_sysclk;
> +
> +/* K230 PLLs. */
Consider dropping this comment?
It's already clear enough

> +enum k230_pll_id {
> +	K230_PLL0,
> +	K230_PLL1,
> +	K230_PLL2,
> +	K230_PLL3,
> +	K230_PLL_NUM
> +};
> +
> +struct k230_pll {
> +	enum k230_pll_id id;
> +	struct k230_sysclk *ksc;
> +	void __iomem *div, *bypass, *gate, *lock;
> +	struct clk_hw hw;
> +};
> +
> +#define to_k230_pll(_hw)	container_of(_hw, struct k230_pll, hw)
> +
> +struct k230_pll_cfg {
> +	u32 reg;
> +	const char *name;
> +	struct k230_pll *pll;
> +};
> +
> +/* K230 PLL_DIVS. */
same

> +struct k230_pll_div {
> +	struct k230_sysclk *ksc;
> +	struct clk_hw *hw;
> +};
> +
> +struct k230_pll_div_cfg {
> +	const char *parent_name, *name;
> +	int div;
> +	struct k230_pll_div *pll_div;
> +};
> +
> +enum k230_pll_div_id {
> +	K230_PLL0_DIV2,
> +	K230_PLL0_DIV3,
> +	K230_PLL0_DIV4,
> +	K230_PLL0_DIV16,
> +	K230_PLL1_DIV2,
> +	K230_PLL1_DIV3,
> +	K230_PLL1_DIV4,
> +	K230_PLL2_DIV2,
> +	K230_PLL2_DIV3,
> +	K230_PLL2_DIV4,
> +	K230_PLL3_DIV2,
> +	K230_PLL3_DIV3,
> +	K230_PLL3_DIV4,
> +	K230_PLL_DIV_NUM
> +};
> +
> +enum k230_clk_div_type {
> +	K230_MUL,
> +	K230_DIV,
> +	K230_MUL_DIV,
> +};
> +
> +/* K230 CLKS. */
same

> +struct k230_clk {
> +	int id;
> +	struct k230_sysclk *ksc;
> +	struct clk_hw hw;
> +};
> +
> +#define to_k230_clk(_hw)	container_of(_hw, struct k230_clk, hw)
> +
> +/* K230 SYSCLK. */
Check other places and remove unnecessary comments.

> +struct k230_sysclk {
> +	struct platform_device *pdev;
> +	void __iomem	       *pll_regs, *regs;
> +	spinlock_t	       pll_lock, clk_lock;
> +	struct k230_pll	       *plls;
> +	struct k230_clk	       *clks;
> +	struct k230_pll_div    *dclks;
> +};
> +
> +struct k230_clk_rate_cfg {
> +	/* rate reg */
> +	u32 rate_reg_off;
> +	void __iomem *rate_reg;
> +	/* rate info*/
> +	u32 rate_write_enable_bit;
> +	enum k230_clk_div_type method;
> +	/* rate mul */
> +	u32 rate_mul_min;
> +	u32 rate_mul_max;
> +	u32 rate_mul_shift;
> +	u32 rate_mul_mask;
> +	/* rate div */
> +	u32 rate_div_min;
> +	u32 rate_div_max;
> +	u32 rate_div_shift;
> +	u32 rate_div_mask;
> +};
> +
> +struct k230_clk_rate_cfg_c {
> +	/* rate_c reg */
> +	u32 rate_reg_off_c;
> +	void __iomem *rate_reg_c;
> +	/* rate_c info */
> +	u32 rate_write_enable_bit_c;
> +	/* rate mul-changable */
> +	u32 rate_mul_min_c;
> +	u32 rate_mul_max_c;
> +	u32 rate_mul_shift_c;
> +	u32 rate_mul_mask_c;
> +};
> +
> +struct k230_clk_gate_cfg {
> +	/* gate reg */
> +	u32 gate_reg_off;
> +	void __iomem *gate_reg;
> +	/* gate info*/
> +	u32 gate_bit_enable;
> +	bool gate_bit_reverse;
> +};
> +
> +struct k230_clk_mux_cfg {
> +	/* mux reg */
> +	u32 mux_reg_off;
> +	void __iomem *mux_reg;
> +	/* mux info */
> +	u32 mux_reg_shift;
> +	u32 mux_reg_mask;
> +};
How about leaving a blank line between different categories in each structure.

> +
> +enum k230_clk_parent_type {
> +	K230_OSC24M,
> +	K230_PLL,
> +	K230_PLL_DIV,
> +	K230_CLK_COMPOSITE,
> +};
> +
> +struct k230_clk_cfg;
> +
> +struct k230_clk_parent {
> +	enum k230_clk_parent_type type;
> +	union {
> +		struct k230_pll_cfg	*pll_cfg;
> +		struct k230_pll_div_cfg	*pll_div_cfg;
> +		struct k230_clk_cfg	*clk_cfg;
> +	};
> +};
> +
> +struct k230_clk_cfg {
> +	/* attr */
> +	const char *name;
> +	/* 0-read & write; 1-read only */
The meaning of the variable name is already clear enough.

> +	bool read_only;
> +	int num_parent;
> +	struct k230_clk_parent parent[K230_CLK_MAX_PARENT_NUM];
> +	struct k230_clk *clk;
> +	int flags;
> +
> +	/* cfgs */
unnecessary comment
> +	struct k230_clk_rate_cfg	*rate_cfg;
> +	struct k230_clk_rate_cfg_c	*rate_cfg_c;
> +	struct k230_clk_gate_cfg	*gate_cfg;
> +	struct k230_clk_mux_cfg		*mux_cfg;
> +};

...

> +
> +static void k230_init_pll(void __iomem *regs, enum k230_pll_id pll_id,
> +			  struct k230_pll *pll)
> +{
> +	void __iomem *base;
> +
> +	pll->id = pll_id;
> +	base = regs + k230_pll_cfgs[pll_id].reg;
> +	pll->div = base + K230_PLL_DIV_REG_OFFSET;
> +	pll->bypass = base + K230_PLL_BYPASS_REG_OFFSET;
> +	pll->gate = base + K230_PLL_GATE_REG_OFFSET;
> +	pll->lock = base + K230_PLL_LOCK_REG_OFFSET;
> +}
> +
> +static int k230_pll_prepare(struct clk_hw *hw)
> +{
> +	struct k230_pll *pll = to_k230_pll(hw);
> +	u32 reg;
> +
> +	/* wait for PLL lock until it reaches lock status */
> +	return readl_poll_timeout(pll->lock, reg,
> +				  (reg & K230_PLL_STATUS_MASK) == K230_PLL_STATUS_MASK,
> +				  400, 0);
> +}
> +
> +static bool k230_pll_hw_is_enabled(struct k230_pll *pll)
> +{
> +	return (readl(pll->gate) & K230_PLL_GATE_ENABLE) == K230_PLL_GATE_ENABLE;
> +}
> +
> +static void k230_pll_enable_hw(void __iomem *regs, struct k230_pll *pll)
> +{
> +	u32 reg;
> +
> +	if (k230_pll_hw_is_enabled(pll))
> +		return;
> +
> +	/* Set PLL factors */
> +	reg = readl(pll->gate);
> +	reg |= (K230_PLL_GATE_ENABLE | K230_PLL_GATE_WRITE_ENABLE);
> +	writel(reg, pll->gate);
> +}
> +
> +static int k230_pll_enable(struct clk_hw *hw)
> +{
> +	struct k230_pll *pll = to_k230_pll(hw);
> +	struct k230_sysclk *ksc = pll->ksc;
> +
> +	guard(spinlock)(&ksc->pll_lock);
> +	k230_pll_enable_hw(ksc->regs, pll);
> +
> +	return 0;
> +}
> +
> +static void k230_pll_disable(struct clk_hw *hw)
> +{
> +	struct k230_pll *pll = to_k230_pll(hw);
> +	struct k230_sysclk *ksc = pll->ksc;
> +	u32 reg;
> +
> +	guard(spinlock)(&ksc->pll_lock);
> +	reg = readl(pll->gate);
> +
drop blank line
> +	reg &= ~(K230_PLL_GATE_ENABLE);
> +	reg |= (K230_PLL_GATE_WRITE_ENABLE);
> +
drop blank line
> +	writel(reg, pll->gate);
> +}
> +
> +static int k230_pll_is_enabled(struct clk_hw *hw)
> +{
> +	return k230_pll_hw_is_enabled(to_k230_pll(hw));
> +}
> +
> +static int k230_pll_init(struct clk_hw *hw)
> +{
> +	if (k230_pll_is_enabled(hw))
> +		return clk_prepare_enable(hw->clk);
> +
> +	return 0;
> +}
> +
> +static unsigned long k230_pll_get_rate(struct clk_hw *hw, unsigned long parent_rate)
> +{
> +	struct k230_pll *pll = to_k230_pll(hw);
> +	struct k230_sysclk *ksc = pll->ksc;
> +	u32 reg;
> +	u32 r, f, od;
> +
> +	reg = readl(pll->bypass);
> +	if (reg & K230_PLL_BYPASS_ENABLE)
> +		return parent_rate;
> +
> +	reg = readl(pll->lock);
> +	if (!(reg & (K230_PLL_STATUS_MASK))) { /* unlocked */
unnecessary comment and wrong position.

> +		dev_err(&ksc->pdev->dev, "%s is unlock.\n", clk_hw_get_name(hw));
> +		return 0;
> +	}
> +
> +	reg = readl(pll->div);
> +	r = ((reg >> K230_PLL_R_SHIFT) & K230_PLL_R_MASK) + 1;
> +	f = ((reg >> K230_PLL_F_SHIFT) & K230_PLL_F_MASK) + 1;
> +	od = ((reg >> K230_PLL_OD_SHIFT) & K230_PLL_OD_MASK) + 1;
> +
> +	return mul_u64_u32_div(parent_rate, f, r * od);
> +}
> +

...

> +
> +static int k230_clk_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct k230_sysclk *ksc;
> +
> +	ksc = devm_kzalloc(&pdev->dev, sizeof(struct k230_sysclk), GFP_KERNEL);
you can use `sizeof(*ksc)` instead. same below.

> +	if (!ksc)
> +		return -ENOMEM;
> +
> +	ksc->plls = devm_kcalloc(&pdev->dev, K230_PLL_NUM,
> +				 sizeof(struct k230_pll), GFP_KERNEL);
> +	if (!ksc->plls)
> +		return -ENOMEM;
> +
> +	ksc->dclks = devm_kcalloc(&pdev->dev, K230_PLL_DIV_NUM,
> +				  sizeof(struct k230_pll_div), GFP_KERNEL);
> +	if (!ksc->dclks)
> +		return -ENOMEM;
> +
> +	ksc->clks = devm_kcalloc(&pdev->dev, K230_CLK_NUM,
> +				 sizeof(struct k230_clk), GFP_KERNEL);
> +	if (!ksc->clks)
> +		return -ENOMEM;
> +
> +	ksc->pdev = pdev;
> +	platform_set_drvdata(pdev, ksc);
> +
> +	ret = k230_clk_init_plls(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "init plls failed\n");
> +
> +	ret = k230_clk_init_clks(pdev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "init clks failed\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id k230_clk_ids[] = {
> +	{ .compatible = "canaan,k230-clk" },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, k230_clk_ids);
> +
> +static struct platform_driver k230_clk_driver = {
> +	.driver = {
> +		.name  = "k230_clock_controller",
> +		.of_match_table = k230_clk_ids,
> +	},
> +	.probe = k230_clk_probe,
> +};
> +builtin_platform_driver(k230_clk_driver);
> 

-- 
Troy Mitchell

