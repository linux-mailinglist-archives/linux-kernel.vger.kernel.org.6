Return-Path: <linux-kernel+bounces-273166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 414D5946528
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF69B21BA0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345D139CF7;
	Fri,  2 Aug 2024 21:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RM2ny2y2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00C1369AE;
	Fri,  2 Aug 2024 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634799; cv=none; b=M16uxVQAbdW/kPyJq+NofnlcH6rPOaMGmy0vmdkoxS7zTtsXOT0CCMLiuUntUwWcHBn6nc5GwFlTdOSmd1YZOXROc2Lu/IpPbQD8xdjKrsiQwepbLU0FDS5+j4uInKa8MeLVHd+wW9N3wWv63z4shK8MOsnuSabMQsyTbaZGkBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634799; c=relaxed/simple;
	bh=xe5yCl6Qm6cFZaCcj3py0S3B091mqrl+eeqvaMQEiqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL32aFtui+Ov0e3H0Px+H0Dj3diQZqE7n/EugSBu1etxED4639wSR2uq9Q6YdnV55M/YBpG/nGRhRh3W1AzaRuyAbatuk+xasMdDBE0TavnX7+bhIlJbLoLqN5E+T9jAKaaZPFgLE2BGHJArQWzPCWzgNN76JgzmSZu59bhQS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RM2ny2y2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722634795;
	bh=xe5yCl6Qm6cFZaCcj3py0S3B091mqrl+eeqvaMQEiqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RM2ny2y2FyCso/Zy02j+gwu9rWTdaYpKKKveQp84YhOet5avmqk0JT9waqvX55GBm
	 uWVoc3vG+494UBT7OkeKAznJRz0j+JKmOEEjANkBhJPTTjCrnwmcEx5GQ3LrChPKi3
	 elO611POyefB7/oV1yER2C70FTyjb2y/0c3yfi0ESv+EgF0yUBIrk5liZdr6+5WfEZ
	 5YcnA5QOiZkNYfqaRVWrfZIADpLs4XUPqdhKDz3jdeKEsajJN5swTkkRy2AWo7dtSL
	 eQvS5tbB+NDVYwlQV7OeEAtKb/5LutF+t+TaS150+m8E6p5ahrAtg+QVq3pEOidXYl
	 yoybWrHnNisZg==
Received: from trenzalore.hitronhub.home (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB98D378221B;
	Fri,  2 Aug 2024 21:39:52 +0000 (UTC)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 2/3] clk: rockchip: Add dt-binding header for rk3576
Date: Fri,  2 Aug 2024 17:35:40 -0400
Message-ID: <20240802214053.433493-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240802214053.433493-1-detlev.casanova@collabora.com>
References: <20240802214053.433493-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Elaine Zhang <zhangqing@rock-chips.com>

Add the dt-bindings header for the rk3576, that gets shared between
the clock controller and the clock references in the dts.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
[rebased, separate clocks and resets]
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 .../dt-bindings/clock/rockchip,rk3576-cru.h   | 589 ++++++++++++++++++
 .../dt-bindings/reset/rockchip,rk3576-cru.h   | 484 ++++++++++++++
 2 files changed, 1073 insertions(+)
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h

diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h b/include/dt-bindings/clock/rockchip,rk3576-cru.h
new file mode 100644
index 0000000000000..14b54543d1a11
--- /dev/null
+++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
@@ -0,0 +1,589 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RK3576_H
+
+/* cru-clocks indices */
+
+/* cru plls */
+#define PLL_BPLL			1
+#define PLL_LPLL			3
+#define PLL_VPLL			4
+#define PLL_AUPLL			5
+#define PLL_CPLL			6
+#define PLL_GPLL			7
+#define PLL_PPLL			9
+#define ARMCLK_L			10
+#define ARMCLK_B			11
+
+/* cru clocks */
+#define CLK_CPLL_DIV20			15
+#define CLK_CPLL_DIV10			16
+#define CLK_GPLL_DIV8			17
+#define CLK_GPLL_DIV6			18
+#define CLK_CPLL_DIV4			19
+#define CLK_GPLL_DIV4			20
+#define CLK_SPLL_DIV2			21
+#define CLK_GPLL_DIV3			22
+#define CLK_CPLL_DIV2			23
+#define CLK_GPLL_DIV2			24
+#define CLK_SPLL_DIV1			25
+#define PCLK_TOP_ROOT			26
+#define ACLK_TOP			27
+#define HCLK_TOP			28
+#define CLK_AUDIO_FRAC_0		29
+#define CLK_AUDIO_FRAC_1		30
+#define CLK_AUDIO_FRAC_2		31
+#define CLK_AUDIO_FRAC_3		32
+#define CLK_UART_FRAC_0			33
+#define CLK_UART_FRAC_1			34
+#define CLK_UART_FRAC_2			35
+#define CLK_UART1_SRC_TOP		36
+#define CLK_AUDIO_INT_0			37
+#define CLK_AUDIO_INT_1			38
+#define CLK_AUDIO_INT_2			39
+#define CLK_PDM0_SRC_TOP		40
+#define CLK_PDM1_OUT			41
+#define CLK_GMAC0_125M_SRC		42
+#define CLK_GMAC1_125M_SRC		43
+#define LCLK_ASRC_SRC_0			44
+#define LCLK_ASRC_SRC_1			45
+#define REF_CLK0_OUT_PLL		46
+#define REF_CLK1_OUT_PLL		47
+#define REF_CLK2_OUT_PLL		48
+#define REFCLKO25M_GMAC0_OUT		49
+#define REFCLKO25M_GMAC1_OUT		50
+#define CLK_CIFOUT_OUT			51
+#define CLK_GMAC0_RMII_CRU		52
+#define CLK_GMAC1_RMII_CRU		53
+#define CLK_OTPC_AUTO_RD_G		54
+#define CLK_OTP_PHY_G			55
+#define CLK_MIPI_CAMERAOUT_M0		56
+#define CLK_MIPI_CAMERAOUT_M1		57
+#define CLK_MIPI_CAMERAOUT_M2		58
+#define MCLK_PDM0_SRC_TOP		59
+#define HCLK_AUDIO_ROOT			60
+#define HCLK_ASRC_2CH_0			61
+#define HCLK_ASRC_2CH_1			62
+#define HCLK_ASRC_4CH_0			63
+#define HCLK_ASRC_4CH_1			64
+#define CLK_ASRC_2CH_0			65
+#define CLK_ASRC_2CH_1			66
+#define CLK_ASRC_4CH_0			67
+#define CLK_ASRC_4CH_1			68
+#define MCLK_SAI0_8CH_SRC		69
+#define MCLK_SAI0_8CH			70
+#define HCLK_SAI0_8CH			71
+#define HCLK_SPDIF_RX0			72
+#define MCLK_SPDIF_RX0			73
+#define HCLK_SPDIF_RX1			74
+#define MCLK_SPDIF_RX1			75
+#define MCLK_SAI1_8CH_SRC		76
+#define MCLK_SAI1_8CH			77
+#define HCLK_SAI1_8CH			78
+#define MCLK_SAI2_2CH_SRC		79
+#define MCLK_SAI2_2CH			80
+#define HCLK_SAI2_2CH			81
+#define MCLK_SAI3_2CH_SRC		82
+#define MCLK_SAI3_2CH			83
+#define HCLK_SAI3_2CH			84
+#define MCLK_SAI4_2CH_SRC		85
+#define MCLK_SAI4_2CH			86
+#define HCLK_SAI4_2CH			87
+#define HCLK_ACDCDIG_DSM		88
+#define MCLK_ACDCDIG_DSM		89
+#define CLK_PDM1			90
+#define HCLK_PDM1			91
+#define MCLK_PDM1			92
+#define HCLK_SPDIF_TX0			93
+#define MCLK_SPDIF_TX0			94
+#define HCLK_SPDIF_TX1			95
+#define MCLK_SPDIF_TX1			96
+#define CLK_SAI1_MCLKOUT		97
+#define CLK_SAI2_MCLKOUT		98
+#define CLK_SAI3_MCLKOUT		99
+#define CLK_SAI4_MCLKOUT		100
+#define CLK_SAI0_MCLKOUT		101
+#define HCLK_BUS_ROOT			102
+#define PCLK_BUS_ROOT			103
+#define ACLK_BUS_ROOT			104
+#define HCLK_CAN0			105
+#define CLK_CAN0			106
+#define HCLK_CAN1			107
+#define CLK_CAN1			108
+#define CLK_KEY_SHIFT			109
+#define PCLK_I2C1			110
+#define PCLK_I2C2			111
+#define PCLK_I2C3			112
+#define PCLK_I2C4			113
+#define PCLK_I2C5			114
+#define PCLK_I2C6			115
+#define PCLK_I2C7			116
+#define PCLK_I2C8			117
+#define PCLK_I2C9			118
+#define PCLK_WDT_BUSMCU			119
+#define TCLK_WDT_BUSMCU			120
+#define ACLK_GIC			121
+#define CLK_I2C1			122
+#define CLK_I2C2			123
+#define CLK_I2C3			124
+#define CLK_I2C4			125
+#define CLK_I2C5			126
+#define CLK_I2C6			127
+#define CLK_I2C7			128
+#define CLK_I2C8			129
+#define CLK_I2C9			130
+#define PCLK_SARADC			131
+#define CLK_SARADC			132
+#define PCLK_TSADC			133
+#define CLK_TSADC			134
+#define PCLK_UART0			135
+#define PCLK_UART2			136
+#define PCLK_UART3			137
+#define PCLK_UART4			138
+#define PCLK_UART5			139
+#define PCLK_UART6			140
+#define PCLK_UART7			141
+#define PCLK_UART8			142
+#define PCLK_UART9			143
+#define PCLK_UART10			144
+#define PCLK_UART11			145
+#define SCLK_UART0			146
+#define SCLK_UART2			147
+#define SCLK_UART3			148
+#define SCLK_UART4			149
+#define SCLK_UART5			150
+#define SCLK_UART6			151
+#define SCLK_UART7			152
+#define SCLK_UART8			153
+#define SCLK_UART9			154
+#define SCLK_UART10			155
+#define SCLK_UART11			156
+#define PCLK_SPI0			157
+#define PCLK_SPI1			158
+#define PCLK_SPI2			159
+#define PCLK_SPI3			160
+#define PCLK_SPI4			161
+#define CLK_SPI0			162
+#define CLK_SPI1			163
+#define CLK_SPI2			164
+#define CLK_SPI3			165
+#define CLK_SPI4			166
+#define PCLK_WDT0			167
+#define TCLK_WDT0			168
+#define PCLK_PWM1			169
+#define CLK_PWM1			170
+#define CLK_OSC_PWM1			171
+#define CLK_RC_PWM1			172
+#define PCLK_BUSTIMER0			173
+#define PCLK_BUSTIMER1			174
+#define CLK_TIMER0_ROOT			175
+#define CLK_TIMER0			176
+#define CLK_TIMER1			177
+#define CLK_TIMER2			178
+#define CLK_TIMER3			179
+#define CLK_TIMER4			180
+#define CLK_TIMER5			181
+#define PCLK_MAILBOX0			182
+#define PCLK_GPIO1			183
+#define DBCLK_GPIO1			184
+#define PCLK_GPIO2			185
+#define DBCLK_GPIO2			186
+#define PCLK_GPIO3			187
+#define DBCLK_GPIO3			188
+#define PCLK_GPIO4			189
+#define DBCLK_GPIO4			190
+#define ACLK_DECOM			191
+#define PCLK_DECOM			192
+#define DCLK_DECOM			193
+#define CLK_TIMER1_ROOT			194
+#define CLK_TIMER6			195
+#define CLK_TIMER7			196
+#define CLK_TIMER8			197
+#define CLK_TIMER9			198
+#define CLK_TIMER10			199
+#define CLK_TIMER11			200
+#define ACLK_DMAC0			201
+#define ACLK_DMAC1			202
+#define ACLK_DMAC2			203
+#define ACLK_SPINLOCK			204
+#define HCLK_I3C0			205
+#define HCLK_I3C1			206
+#define HCLK_BUS_CM0_ROOT		207
+#define FCLK_BUS_CM0_CORE		208
+#define CLK_BUS_CM0_RTC			209
+#define PCLK_PMU2			210
+#define PCLK_PWM2			211
+#define CLK_PWM2			212
+#define CLK_RC_PWM2			213
+#define CLK_OSC_PWM2			214
+#define CLK_FREQ_PWM1			215
+#define CLK_COUNTER_PWM1		216
+#define SAI_SCLKIN_FREQ			217
+#define SAI_SCLKIN_COUNTER		218
+#define CLK_I3C0			219
+#define CLK_I3C1			220
+#define PCLK_CSIDPHY1			221
+#define PCLK_DDR_ROOT			222
+#define PCLK_DDR_MON_CH0		223
+#define TMCLK_DDR_MON_CH0		224
+#define ACLK_DDR_ROOT			225
+#define HCLK_DDR_ROOT			226
+#define FCLK_DDR_CM0_CORE		227
+#define CLK_DDR_TIMER_ROOT		228
+#define CLK_DDR_TIMER0			229
+#define CLK_DDR_TIMER1			230
+#define TCLK_WDT_DDR			231
+#define PCLK_WDT			232
+#define PCLK_TIMER			233
+#define CLK_DDR_CM0_RTC			234
+#define ACLK_RKNN0			235
+#define ACLK_RKNN1			236
+#define HCLK_RKNN_ROOT			237
+#define CLK_RKNN_DSU0			238
+#define PCLK_NPUTOP_ROOT		239
+#define PCLK_NPU_TIMER			240
+#define CLK_NPUTIMER_ROOT		241
+#define CLK_NPUTIMER0			242
+#define CLK_NPUTIMER1			243
+#define PCLK_NPU_WDT			244
+#define TCLK_NPU_WDT			245
+#define ACLK_RKNN_CBUF			246
+#define HCLK_NPU_CM0_ROOT		247
+#define FCLK_NPU_CM0_CORE		248
+#define CLK_NPU_CM0_RTC			249
+#define HCLK_RKNN_CBUF			250
+#define HCLK_NVM_ROOT			251
+#define ACLK_NVM_ROOT			252
+#define SCLK_FSPI_X2			253
+#define HCLK_FSPI			254
+#define CCLK_SRC_EMMC			255
+#define HCLK_EMMC			256
+#define ACLK_EMMC			257
+#define BCLK_EMMC			258
+#define TCLK_EMMC			259
+#define PCLK_PHP_ROOT			260
+#define ACLK_PHP_ROOT			261
+#define PCLK_PCIE0			262
+#define CLK_PCIE0_AUX			263
+#define ACLK_PCIE0_MST			264
+#define ACLK_PCIE0_SLV			265
+#define ACLK_PCIE0_DBI			266
+#define ACLK_USB3OTG1			267
+#define CLK_REF_USB3OTG1		268
+#define CLK_SUSPEND_USB3OTG1		269
+#define ACLK_MMU0			270
+#define ACLK_SLV_MMU0			271
+#define ACLK_MMU1			272
+#define ACLK_SLV_MMU1			273
+#define PCLK_PCIE1			275
+#define CLK_PCIE1_AUX			276
+#define ACLK_PCIE1_MST			277
+#define ACLK_PCIE1_SLV			278
+#define ACLK_PCIE1_DBI			279
+#define CLK_RXOOB0			280
+#define CLK_RXOOB1			281
+#define CLK_PMALIVE0			282
+#define CLK_PMALIVE1			283
+#define ACLK_SATA0			284
+#define ACLK_SATA1			285
+#define CLK_USB3OTG1_PIPE_PCLK		286
+#define CLK_USB3OTG1_UTMI		287
+#define CLK_USB3OTG0_PIPE_PCLK		288
+#define CLK_USB3OTG0_UTMI		289
+#define HCLK_SDGMAC_ROOT		290
+#define ACLK_SDGMAC_ROOT		291
+#define PCLK_SDGMAC_ROOT		292
+#define ACLK_GMAC0			293
+#define ACLK_GMAC1			294
+#define PCLK_GMAC0			295
+#define PCLK_GMAC1			296
+#define CCLK_SRC_SDIO			297
+#define HCLK_SDIO			298
+#define CLK_GMAC1_PTP_REF		299
+#define CLK_GMAC0_PTP_REF		300
+#define CLK_GMAC1_PTP_REF_SRC		301
+#define CLK_GMAC0_PTP_REF_SRC		302
+#define CCLK_SRC_SDMMC0			303
+#define HCLK_SDMMC0			304
+#define SCLK_FSPI1_X2			305
+#define HCLK_FSPI1			306
+#define ACLK_DSMC_ROOT			307
+#define ACLK_DSMC			308
+#define PCLK_DSMC			309
+#define CLK_DSMC_SYS			310
+#define HCLK_HSGPIO			311
+#define CLK_HSGPIO_TX			312
+#define CLK_HSGPIO_RX			313
+#define ACLK_HSGPIO			314
+#define PCLK_PHPPHY_ROOT		315
+#define PCLK_PCIE2_COMBOPHY0		316
+#define PCLK_PCIE2_COMBOPHY1		317
+#define CLK_PCIE_100M_SRC		318
+#define CLK_PCIE_100M_NDUTY_SRC		319
+#define CLK_REF_PCIE0_PHY		320
+#define CLK_REF_PCIE1_PHY		321
+#define CLK_REF_MPHY_26M		322
+#define HCLK_RKVDEC_ROOT		323
+#define ACLK_RKVDEC_ROOT		324
+#define HCLK_RKVDEC			325
+#define CLK_RKVDEC_HEVC_CA		326
+#define CLK_RKVDEC_CORE			327
+#define ACLK_UFS_ROOT			328
+#define ACLK_USB_ROOT			329
+#define PCLK_USB_ROOT			330
+#define ACLK_USB3OTG0			331
+#define CLK_REF_USB3OTG0		332
+#define CLK_SUSPEND_USB3OTG0		333
+#define ACLK_MMU2			334
+#define ACLK_SLV_MMU2			335
+#define ACLK_UFS_SYS			336
+#define ACLK_VPU_ROOT			337
+#define ACLK_VPU_MID_ROOT		338
+#define HCLK_VPU_ROOT			339
+#define ACLK_JPEG_ROOT			340
+#define ACLK_VPU_LOW_ROOT		341
+#define HCLK_RGA2E_0			342
+#define ACLK_RGA2E_0			343
+#define CLK_CORE_RGA2E_0		344
+#define ACLK_JPEG			345
+#define HCLK_JPEG			346
+#define HCLK_VDPP			347
+#define ACLK_VDPP			348
+#define CLK_CORE_VDPP			349
+#define HCLK_RGA2E_1			350
+#define ACLK_RGA2E_1			351
+#define CLK_CORE_RGA2E_1		352
+#define DCLK_EBC_FRAC_SRC		353
+#define HCLK_EBC			354
+#define ACLK_EBC			355
+#define DCLK_EBC			356
+#define HCLK_VEPU0_ROOT			357
+#define ACLK_VEPU0_ROOT			358
+#define HCLK_VEPU0			359
+#define ACLK_VEPU0			360
+#define CLK_VEPU0_CORE			361
+#define ACLK_VI_ROOT			362
+#define HCLK_VI_ROOT			363
+#define PCLK_VI_ROOT			364
+#define DCLK_VICAP			365
+#define ACLK_VICAP			366
+#define HCLK_VICAP			367
+#define CLK_ISP_CORE			368
+#define CLK_ISP_CORE_MARVIN		369
+#define CLK_ISP_CORE_VICAP		370
+#define ACLK_ISP			371
+#define HCLK_ISP			372
+#define ACLK_VPSS			373
+#define HCLK_VPSS			374
+#define CLK_CORE_VPSS			375
+#define PCLK_CSI_HOST_0			376
+#define PCLK_CSI_HOST_1			377
+#define PCLK_CSI_HOST_2			378
+#define PCLK_CSI_HOST_3			379
+#define PCLK_CSI_HOST_4			380
+#define ICLK_CSIHOST01			381
+#define ICLK_CSIHOST0			382
+#define CLK_ISP_PVTPLL_SRC		383
+#define ACLK_VI_ROOT_INTER		384
+#define CLK_VICAP_I0CLK			385
+#define CLK_VICAP_I1CLK			386
+#define CLK_VICAP_I2CLK			387
+#define CLK_VICAP_I3CLK			388
+#define CLK_VICAP_I4CLK			389
+#define ACLK_VOP_ROOT			390
+#define HCLK_VOP_ROOT			391
+#define PCLK_VOP_ROOT			392
+#define HCLK_VOP			393
+#define ACLK_VOP			394
+#define DCLK_VP0_SRC			395
+#define DCLK_VP1_SRC			396
+#define DCLK_VP2_SRC			397
+#define DCLK_VP0			398
+#define DCLK_VP1			400
+#define DCLK_VP2			401
+#define PCLK_VOPGRF			402
+#define ACLK_VO0_ROOT			403
+#define HCLK_VO0_ROOT			404
+#define PCLK_VO0_ROOT			405
+#define PCLK_VO0_GRF			406
+#define ACLK_HDCP0			407
+#define HCLK_HDCP0			408
+#define PCLK_HDCP0			409
+#define CLK_TRNG0_SKP			410
+#define PCLK_DSIHOST0			411
+#define CLK_DSIHOST0			412
+#define PCLK_HDMITX0			413
+#define CLK_HDMITX0_EARC		414
+#define CLK_HDMITX0_REF			415
+#define PCLK_EDP0			416
+#define CLK_EDP0_24M			417
+#define CLK_EDP0_200M			418
+#define MCLK_SAI5_8CH_SRC		419
+#define MCLK_SAI5_8CH			420
+#define HCLK_SAI5_8CH			421
+#define MCLK_SAI6_8CH_SRC		422
+#define MCLK_SAI6_8CH			423
+#define HCLK_SAI6_8CH			424
+#define HCLK_SPDIF_TX2			425
+#define MCLK_SPDIF_TX2			426
+#define HCLK_SPDIF_RX2			427
+#define MCLK_SPDIF_RX2			428
+#define HCLK_SAI8_8CH			429
+#define MCLK_SAI8_8CH_SRC		430
+#define MCLK_SAI8_8CH			431
+#define ACLK_VO1_ROOT			432
+#define HCLK_VO1_ROOT			433
+#define PCLK_VO1_ROOT			434
+#define MCLK_SAI7_8CH_SRC		435
+#define MCLK_SAI7_8CH			436
+#define HCLK_SAI7_8CH			437
+#define HCLK_SPDIF_TX3			438
+#define HCLK_SPDIF_TX4			439
+#define HCLK_SPDIF_TX5			440
+#define MCLK_SPDIF_TX3			441
+#define CLK_AUX16MHZ_0			442
+#define ACLK_DP0			443
+#define PCLK_DP0			444
+#define PCLK_VO1_GRF			445
+#define ACLK_HDCP1			446
+#define HCLK_HDCP1			447
+#define PCLK_HDCP1			448
+#define CLK_TRNG1_SKP			449
+#define HCLK_SAI9_8CH			450
+#define MCLK_SAI9_8CH_SRC		451
+#define MCLK_SAI9_8CH			452
+#define MCLK_SPDIF_TX4			453
+#define MCLK_SPDIF_TX5			454
+#define CLK_GPU_SRC_PRE			455
+#define CLK_GPU				456
+#define PCLK_GPU_ROOT			457
+#define ACLK_CENTER_ROOT		458
+#define ACLK_CENTER_LOW_ROOT		459
+#define HCLK_CENTER_ROOT		460
+#define PCLK_CENTER_ROOT		461
+#define ACLK_DMA2DDR			462
+#define ACLK_DDR_SHAREMEM		463
+#define PCLK_DMA2DDR			464
+#define PCLK_SHAREMEM			465
+#define HCLK_VEPU1_ROOT			466
+#define ACLK_VEPU1_ROOT			467
+#define HCLK_VEPU1			468
+#define ACLK_VEPU1			469
+#define CLK_VEPU1_CORE			470
+#define CLK_JDBCK_DAP			471
+#define PCLK_MIPI_DCPHY			472
+#define CLK_32K_USB2DEBUG		473
+#define PCLK_CSIDPHY			474
+#define PCLK_USBDPPHY			475
+#define CLK_PMUPHY_REF_SRC		476
+#define CLK_USBDP_COMBO_PHY_IMMORTAL	477
+#define CLK_HDMITXHPD			478
+#define PCLK_MPHY			479
+#define CLK_REF_OSC_MPHY		480
+#define CLK_REF_UFS_CLKOUT		481
+#define HCLK_PMU1_ROOT			482
+#define HCLK_PMU_CM0_ROOT		483
+#define CLK_200M_PMU_SRC		484
+#define CLK_100M_PMU_SRC		485
+#define CLK_50M_PMU_SRC			486
+#define FCLK_PMU_CM0_CORE		487
+#define CLK_PMU_CM0_RTC			488
+#define PCLK_PMU1			489
+#define CLK_PMU1			490
+#define PCLK_PMU1WDT			491
+#define TCLK_PMU1WDT			492
+#define PCLK_PMUTIMER			493
+#define CLK_PMUTIMER_ROOT		494
+#define CLK_PMUTIMER0			495
+#define CLK_PMUTIMER1			496
+#define PCLK_PMU1PWM			497
+#define CLK_PMU1PWM			498
+#define CLK_PMU1PWM_OSC			499
+#define PCLK_PMUPHY_ROOT		500
+#define PCLK_I2C0			501
+#define CLK_I2C0			502
+#define SCLK_UART1			503
+#define PCLK_UART1			504
+#define CLK_PMU1PWM_RC			505
+#define CLK_PDM0			506
+#define HCLK_PDM0			507
+#define MCLK_PDM0			508
+#define HCLK_VAD			509
+#define CLK_OSCCHK_PVTM			510
+#define CLK_PDM0_OUT			511
+#define CLK_HPTIMER_SRC			512
+#define PCLK_PMU0_ROOT			516
+#define PCLK_PMU0			517
+#define PCLK_GPIO0			518
+#define DBCLK_GPIO0			519
+#define CLK_OSC0_PMU1			520
+#define PCLK_PMU1_ROOT			521
+#define XIN_OSC0_DIV			522
+#define ACLK_USB			523
+#define ACLK_UFS			524
+#define ACLK_SDGMAC			525
+#define HCLK_SDGMAC			526
+#define PCLK_SDGMAC			527
+#define HCLK_VO1			528
+#define HCLK_VO0			529
+#define PCLK_CCI_ROOT			532
+#define ACLK_CCI_ROOT			533
+#define HCLK_VO0VOP_CHANNEL		534
+#define ACLK_VO0VOP_CHANNEL		535
+#define ACLK_TOP_MID			536
+#define ACLK_SECURE_HIGH		537
+#define CLK_USBPHY_REF_SRC		538
+#define CLK_PHY_REF_SRC			539
+#define CLK_CPLL_REF_SRC		540
+#define CLK_AUPLL_REF_SRC		541
+#define PCLK_SECURE_NS			542
+#define HCLK_SECURE_NS			543
+#define ACLK_SECURE_NS			544
+#define PCLK_OTPC_NS			545
+#define HCLK_CRYPTO_NS			546
+#define HCLK_TRNG_NS			547
+#define CLK_OTPC_NS			548
+#define SCLK_DSU			549
+#define SCLK_DDR			550
+#define ACLK_CRYPTO_NS			551
+#define CLK_PKA_CRYPTO_NS		552
+#define ACLK_RKVDEC_ROOT_BAK		553
+#define CLK_AUDIO_FRAC_0_SRC		554
+#define CLK_AUDIO_FRAC_1_SRC		555
+#define CLK_AUDIO_FRAC_2_SRC		556
+#define CLK_AUDIO_FRAC_3_SRC		557
+#define PCLK_HDPTX_APB			558
+
+/* secure clk */
+#define CLK_STIMER0_ROOT		600
+#define CLK_STIMER1_ROOT		601
+#define PCLK_SECURE_S			602
+#define HCLK_SECURE_S			603
+#define ACLK_SECURE_S			604
+#define CLK_PKA_CRYPTO_S		605
+#define HCLK_VO1_S			606
+#define PCLK_VO1_S			607
+#define HCLK_VO0_S			608
+#define PCLK_VO0_S			609
+#define PCLK_KLAD			610
+#define HCLK_CRYPTO_S			611
+#define HCLK_KLAD			612
+#define ACLK_CRYPTO_S			613
+#define HCLK_TRNG_S			614
+#define PCLK_OTPC_S			615
+#define CLK_OTPC_S			616
+#define PCLK_WDT_S			617
+#define TCLK_WDT_S			618
+#define PCLK_HDCP0_TRNG			619
+#define PCLK_HDCP1_TRNG			620
+#define HCLK_HDCP_KEY0			621
+#define HCLK_HDCP_KEY1			622
+#define PCLK_EDP_S			623
+#define ACLK_KLAD			624
+
+#endif
diff --git a/include/dt-bindings/reset/rockchip,rk3576-cru.h b/include/dt-bindings/reset/rockchip,rk3576-cru.h
new file mode 100644
index 0000000000000..5bf1e7d17be56
--- /dev/null
+++ b/include/dt-bindings/reset/rockchip,rk3576-cru.h
@@ -0,0 +1,484 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright (c) 2023 Rockchip Electronics Co. Ltd.
+ * Copyright (c) 2024 Collabora Ltd.
+ *
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ * Author: Detlev Casanova <detlev.casanova@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
+#define _DT_BINDINGS_RESET_ROCKCHIP_RK3576_H
+
+#define SRST_A_TOP_BIU			1
+#define SRST_P_TOP_BIU			2
+#define SRST_A_TOP_MID_BIU		3
+#define SRST_A_SECURE_HIGH_BIU		4
+#define SRST_H_TOP_BIU			5
+
+#define SRST_H_VO0VOP_CHANNEL_BIU	6
+#define SRST_A_VO0VOP_CHANNEL_BIU	7
+
+#define SRST_BISRINTF			8
+
+#define SRST_H_AUDIO_BIU		9
+#define SRST_H_ASRC_2CH_0		10
+#define SRST_H_ASRC_2CH_1		11
+#define SRST_H_ASRC_4CH_0		12
+#define SRST_H_ASRC_4CH_1		13
+#define SRST_ASRC_2CH_0			14
+#define SRST_ASRC_2CH_1			15
+#define SRST_ASRC_4CH_0			16
+#define SRST_ASRC_4CH_1			17
+#define SRST_M_SAI0_8CH			18
+#define SRST_H_SAI0_8CH			19
+#define SRST_H_SPDIF_RX0		20
+#define SRST_M_SPDIF_RX0		21
+
+#define SRST_H_SPDIF_RX1		22
+#define SRST_M_SPDIF_RX1		23
+#define SRST_M_SAI1_8CH			24
+#define SRST_H_SAI1_8CH			25
+#define SRST_M_SAI2_2CH			26
+#define SRST_H_SAI2_2CH			27
+#define SRST_M_SAI3_2CH			28
+#define SRST_H_SAI3_2CH			29
+
+#define SRST_M_SAI4_2CH			30
+#define SRST_H_SAI4_2CH			31
+#define SRST_H_ACDCDIG_DSM		32
+#define SRST_M_ACDCDIG_DSM		33
+#define SRST_PDM1			34
+#define SRST_H_PDM1			35
+#define SRST_M_PDM1			36
+#define SRST_H_SPDIF_TX0		37
+#define SRST_M_SPDIF_TX0		38
+#define SRST_H_SPDIF_TX1		39
+#define SRST_M_SPDIF_TX1		40
+
+#define SRST_A_BUS_BIU			41
+#define SRST_P_BUS_BIU			42
+#define SRST_P_CRU			43
+#define SRST_H_CAN0			44
+#define SRST_CAN0			45
+#define SRST_H_CAN1			46
+#define SRST_CAN1			47
+#define SRST_P_INTMUX2BUS		48
+#define SRST_P_VCCIO_IOC		49
+#define SRST_H_BUS_BIU			50
+#define SRST_KEY_SHIFT			51
+
+#define SRST_P_I2C1			52
+#define SRST_P_I2C2			53
+#define SRST_P_I2C3			54
+#define SRST_P_I2C4			55
+#define SRST_P_I2C5			56
+#define SRST_P_I2C6			57
+#define SRST_P_I2C7			58
+#define SRST_P_I2C8			59
+#define SRST_P_I2C9			60
+#define SRST_P_WDT_BUSMCU		61
+#define SRST_T_WDT_BUSMCU		62
+#define SRST_A_GIC			63
+#define SRST_I2C1			64
+#define SRST_I2C2			65
+#define SRST_I2C3			66
+#define SRST_I2C4			67
+
+#define SRST_I2C5			68
+#define SRST_I2C6			69
+#define SRST_I2C7			70
+#define SRST_I2C8			71
+#define SRST_I2C9			72
+#define SRST_P_SARADC			73
+#define SRST_SARADC			74
+#define SRST_P_TSADC			75
+#define SRST_TSADC			76
+#define SRST_P_UART0			77
+#define SRST_P_UART2			78
+#define SRST_P_UART3			79
+#define SRST_P_UART4			80
+#define SRST_P_UART5			81
+#define SRST_P_UART6			82
+
+#define SRST_P_UART7			83
+#define SRST_P_UART8			84
+#define SRST_P_UART9			85
+#define SRST_P_UART10			86
+#define SRST_P_UART11			87
+#define SRST_S_UART0			88
+#define SRST_S_UART2			89
+#define SRST_S_UART3			90
+#define SRST_S_UART4			91
+#define SRST_S_UART5			92
+
+#define SRST_S_UART6			93
+#define SRST_S_UART7			94
+#define SRST_S_UART8			95
+#define SRST_S_UART9			96
+#define SRST_S_UART10			97
+#define SRST_S_UART11			98
+#define SRST_P_SPI0			99
+#define SRST_P_SPI1			100
+#define SRST_P_SPI2			101
+
+#define SRST_P_SPI3			102
+#define SRST_P_SPI4			103
+#define SRST_SPI0			104
+#define SRST_SPI1			105
+#define SRST_SPI2			106
+#define SRST_SPI3			107
+#define SRST_SPI4			108
+#define SRST_P_WDT0			109
+#define SRST_T_WDT0			110
+#define SRST_P_SYS_GRF			111
+#define SRST_P_PWM1			112
+#define SRST_PWM1			113
+
+#define SRST_P_BUSTIMER0		114
+#define SRST_P_BUSTIMER1		115
+#define SRST_TIMER0			116
+#define SRST_TIMER1			117
+#define SRST_TIMER2			118
+#define SRST_TIMER3			119
+#define SRST_TIMER4			120
+#define SRST_TIMER5			121
+#define SRST_P_BUSIOC			122
+#define SRST_P_MAILBOX0			123
+#define SRST_P_GPIO1			124
+
+#define SRST_GPIO1			125
+#define SRST_P_GPIO2			126
+#define SRST_GPIO2			127
+#define SRST_P_GPIO3			128
+#define SRST_GPIO3			129
+#define SRST_P_GPIO4			130
+#define SRST_GPIO4			131
+#define SRST_A_DECOM			132
+#define SRST_P_DECOM			133
+#define SRST_D_DECOM			134
+#define SRST_TIMER6			135
+#define SRST_TIMER7			136
+#define SRST_TIMER8			137
+#define SRST_TIMER9			138
+#define SRST_TIMER10			139
+
+#define SRST_TIMER11			140
+#define SRST_A_DMAC0			141
+#define SRST_A_DMAC1			142
+#define SRST_A_DMAC2			143
+#define SRST_A_SPINLOCK			144
+#define SRST_REF_PVTPLL_BUS		145
+#define SRST_H_I3C0			146
+#define SRST_H_I3C1			147
+#define SRST_H_BUS_CM0_BIU		148
+#define SRST_F_BUS_CM0_CORE		149
+#define SRST_T_BUS_CM0_JTAG		150
+
+#define SRST_P_INTMUX2PMU		151
+#define SRST_P_INTMUX2DDR		152
+#define SRST_P_PVTPLL_BUS		153
+#define SRST_P_PWM2			154
+#define SRST_PWM2			155
+#define SRST_FREQ_PWM1			156
+#define SRST_COUNTER_PWM1		157
+#define SRST_I3C0			158
+#define SRST_I3C1			159
+
+#define SRST_P_DDR_MON_CH0		160
+#define SRST_P_DDR_BIU			161
+#define SRST_P_DDR_UPCTL_CH0		162
+#define SRST_TM_DDR_MON_CH0		163
+#define SRST_A_DDR_BIU			164
+#define SRST_DFI_CH0			165
+#define SRST_DDR_MON_CH0		166
+#define SRST_P_DDR_HWLP_CH0		167
+#define SRST_P_DDR_MON_CH1		168
+#define SRST_P_DDR_HWLP_CH1		169
+
+#define SRST_P_DDR_UPCTL_CH1		170
+#define SRST_TM_DDR_MON_CH1		171
+#define SRST_DFI_CH1			172
+#define SRST_A_DDR01_MSCH0		173
+#define SRST_A_DDR01_MSCH1		174
+#define SRST_DDR_MON_CH1		175
+#define SRST_DDR_SCRAMBLE_CH0		176
+#define SRST_DDR_SCRAMBLE_CH1		177
+#define SRST_P_AHB2APB			178
+#define SRST_H_AHB2APB			179
+#define SRST_H_DDR_BIU			180
+#define SRST_F_DDR_CM0_CORE		181
+
+#define SRST_P_DDR01_MSCH0		182
+#define SRST_P_DDR01_MSCH1		183
+#define SRST_DDR_TIMER0			184
+#define SRST_DDR_TIMER1			185
+#define SRST_T_WDT_DDR			186
+#define SRST_P_WDT			187
+#define SRST_P_TIMER			188
+#define SRST_T_DDR_CM0_JTAG		189
+#define SRST_P_DDR_GRF			190
+
+#define SRST_DDR_UPCTL_CH0		191
+#define SRST_A_DDR_UPCTL_0_CH0		192
+#define SRST_A_DDR_UPCTL_1_CH0		193
+#define SRST_A_DDR_UPCTL_2_CH0		194
+#define SRST_A_DDR_UPCTL_3_CH0		195
+#define SRST_A_DDR_UPCTL_4_CH0		196
+
+#define SRST_DDR_UPCTL_CH1		197
+#define SRST_A_DDR_UPCTL_0_CH1		198
+#define SRST_A_DDR_UPCTL_1_CH1		199
+#define SRST_A_DDR_UPCTL_2_CH1		200
+#define SRST_A_DDR_UPCTL_3_CH1		201
+#define SRST_A_DDR_UPCTL_4_CH1		202
+
+#define SRST_REF_PVTPLL_DDR		203
+#define SRST_P_PVTPLL_DDR		204
+
+#define SRST_A_RKNN0			205
+#define SRST_A_RKNN0_BIU		206
+#define SRST_L_RKNN0_BIU		207
+
+#define SRST_A_RKNN1			208
+#define SRST_A_RKNN1_BIU		209
+#define SRST_L_RKNN1_BIU		210
+
+#define SRST_NPU_DAP			211
+#define SRST_L_NPUSUBSYS_BIU		212
+#define SRST_P_NPUTOP_BIU		213
+#define SRST_P_NPU_TIMER		214
+#define SRST_NPUTIMER0			215
+#define SRST_NPUTIMER1			216
+#define SRST_P_NPU_WDT			217
+#define SRST_T_NPU_WDT			218
+
+#define SRST_A_RKNN_CBUF		219
+#define SRST_A_RVCORE0			220
+#define SRST_P_NPU_GRF			221
+#define SRST_P_PVTPLL_NPU		222
+#define SRST_NPU_PVTPLL			223
+#define SRST_H_NPU_CM0_BIU		224
+#define SRST_F_NPU_CM0_CORE		225
+#define SRST_T_NPU_CM0_JTAG		226
+#define SRST_A_RKNNTOP_BIU		227
+#define SRST_H_RKNN_CBUF		228
+#define SRST_H_RKNNTOP_BIU		229
+
+#define SRST_H_NVM_BIU			230
+#define SRST_A_NVM_BIU			231
+#define SRST_S_FSPI			232
+#define SRST_H_FSPI			233
+#define SRST_C_EMMC			234
+#define SRST_H_EMMC			235
+#define SRST_A_EMMC			236
+#define SRST_B_EMMC			237
+#define SRST_T_EMMC			238
+
+#define SRST_P_GRF			239
+#define SRST_P_PHP_BIU			240
+#define SRST_A_PHP_BIU			241
+#define SRST_P_PCIE0			242
+#define SRST_PCIE0_POWER_UP		243
+
+#define SRST_A_USB3OTG1			244
+#define SRST_A_MMU0			245
+#define SRST_A_SLV_MMU0			246
+#define SRST_A_MMU1			247
+
+#define SRST_A_SLV_MMU1			248
+#define SRST_P_PCIE1			249
+#define SRST_PCIE1_POWER_UP		250
+
+#define SRST_RXOOB0			251
+#define SRST_RXOOB1			252
+#define SRST_PMALIVE0			253
+#define SRST_PMALIVE1			254
+#define SRST_A_SATA0			255
+#define SRST_A_SATA1			256
+#define SRST_ASIC1			257
+#define SRST_ASIC0			258
+
+#define SRST_P_CSIDPHY1			259
+#define SRST_SCAN_CSIDPHY1		260
+
+#define SRST_P_SDGMAC_GRF		261
+#define SRST_P_SDGMAC_BIU		262
+#define SRST_A_SDGMAC_BIU		263
+#define SRST_H_SDGMAC_BIU		264
+#define SRST_A_GMAC0			265
+#define SRST_A_GMAC1			266
+#define SRST_P_GMAC0			267
+#define SRST_P_GMAC1			268
+#define SRST_H_SDIO			269
+
+#define SRST_H_SDMMC0			270
+#define SRST_S_FSPI1			271
+#define SRST_H_FSPI1			272
+#define SRST_A_DSMC_BIU			273
+#define SRST_A_DSMC			274
+#define SRST_P_DSMC			275
+#define SRST_H_HSGPIO			276
+#define SRST_HSGPIO			277
+#define SRST_A_HSGPIO			278
+
+#define SRST_H_RKVDEC			279
+#define SRST_H_RKVDEC_BIU		280
+#define SRST_A_RKVDEC_BIU		281
+#define SRST_RKVDEC_HEVC_CA		282
+#define SRST_RKVDEC_CORE		283
+
+#define SRST_A_USB_BIU			284
+#define SRST_P_USBUFS_BIU		285
+#define SRST_A_USB3OTG0			286
+#define SRST_A_UFS_BIU			287
+#define SRST_A_MMU2			288
+#define SRST_A_SLV_MMU2			289
+#define SRST_A_UFS_SYS			290
+
+#define SRST_A_UFS			291
+#define SRST_P_USBUFS_GRF		292
+#define SRST_P_UFS_GRF			293
+
+#define SRST_H_VPU_BIU			294
+#define SRST_A_JPEG_BIU			295
+#define SRST_A_RGA_BIU			296
+#define SRST_A_VDPP_BIU			297
+#define SRST_A_EBC_BIU			298
+#define SRST_H_RGA2E_0			299
+#define SRST_A_RGA2E_0			300
+#define SRST_CORE_RGA2E_0		301
+
+#define SRST_A_JPEG			302
+#define SRST_H_JPEG			303
+#define SRST_H_VDPP			304
+#define SRST_A_VDPP			305
+#define SRST_CORE_VDPP			306
+#define SRST_H_RGA2E_1			307
+#define SRST_A_RGA2E_1			308
+#define SRST_CORE_RGA2E_1		309
+#define SRST_H_EBC			310
+#define SRST_A_EBC			311
+#define SRST_D_EBC			312
+
+#define SRST_H_VEPU0_BIU		313
+#define SRST_A_VEPU0_BIU		314
+#define SRST_H_VEPU0			315
+#define SRST_A_VEPU0			316
+#define SRST_VEPU0_CORE			317
+
+#define SRST_A_VI_BIU			318
+#define SRST_H_VI_BIU			319
+#define SRST_P_VI_BIU			320
+#define SRST_D_VICAP			321
+#define SRST_A_VICAP			322
+#define SRST_H_VICAP			323
+#define SRST_ISP0			324
+#define SRST_ISP0_VICAP			325
+
+#define SRST_CORE_VPSS			326
+#define SRST_P_CSI_HOST_0		327
+#define SRST_P_CSI_HOST_1		328
+#define SRST_P_CSI_HOST_2		329
+#define SRST_P_CSI_HOST_3		330
+#define SRST_P_CSI_HOST_4		331
+
+#define SRST_CIFIN			332
+#define SRST_VICAP_I0CLK		333
+#define SRST_VICAP_I1CLK		334
+#define SRST_VICAP_I2CLK		335
+#define SRST_VICAP_I3CLK		336
+#define SRST_VICAP_I4CLK		337
+
+#define SRST_A_VOP_BIU			338
+#define SRST_A_VOP2_BIU			339
+#define SRST_H_VOP_BIU			340
+#define SRST_P_VOP_BIU			341
+#define SRST_H_VOP			342
+#define SRST_A_VOP			343
+#define SRST_D_VP0			344
+
+#define SRST_D_VP1			345
+#define SRST_D_VP2			346
+#define SRST_P_VOP2_BIU			347
+#define SRST_P_VOPGRF			348
+
+#define SRST_H_VO0_BIU			349
+#define SRST_P_VO0_BIU			350
+#define SRST_A_HDCP0_BIU		351
+#define SRST_P_VO0_GRF			352
+#define SRST_A_HDCP0			353
+#define SRST_H_HDCP0			354
+#define SRST_HDCP0			355
+
+#define SRST_P_DSIHOST0			356
+#define SRST_DSIHOST0			357
+#define SRST_P_HDMITX0			358
+#define SRST_HDMITX0_REF		359
+#define SRST_P_EDP0			360
+#define SRST_EDP0_24M			361
+
+#define SRST_M_SAI5_8CH			362
+#define SRST_H_SAI5_8CH			363
+#define SRST_M_SAI6_8CH			364
+#define SRST_H_SAI6_8CH			365
+#define SRST_H_SPDIF_TX2		366
+#define SRST_M_SPDIF_TX2		367
+#define SRST_H_SPDIF_RX2		368
+#define SRST_M_SPDIF_RX2		369
+
+#define SRST_H_SAI8_8CH			370
+#define SRST_M_SAI8_8CH			371
+
+#define SRST_H_VO1_BIU			372
+#define SRST_P_VO1_BIU			373
+#define SRST_M_SAI7_8CH			374
+#define SRST_H_SAI7_8CH			375
+#define SRST_H_SPDIF_TX3		376
+#define SRST_H_SPDIF_TX4		377
+#define SRST_H_SPDIF_TX5		378
+#define SRST_M_SPDIF_TX3		379
+
+#define SRST_DP0			380
+#define SRST_P_VO1_GRF			381
+#define SRST_A_HDCP1_BIU		382
+#define SRST_A_HDCP1			383
+#define SRST_H_HDCP1			384
+#define SRST_HDCP1			385
+#define SRST_H_SAI9_8CH			386
+#define SRST_M_SAI9_8CH			387
+#define SRST_M_SPDIF_TX4		388
+#define SRST_M_SPDIF_TX5		389
+
+#define SRST_GPU			390
+#define SRST_A_S_GPU_BIU		391
+#define SRST_A_M0_GPU_BIU		392
+#define SRST_P_GPU_BIU			393
+#define SRST_P_GPU_GRF			394
+#define SRST_GPU_PVTPLL			395
+#define SRST_P_PVTPLL_GPU		396
+
+#define SRST_A_CENTER_BIU		397
+#define SRST_A_DMA2DDR			398
+#define SRST_A_DDR_SHAREMEM		399
+#define SRST_A_DDR_SHAREMEM_BIU		400
+#define SRST_H_CENTER_BIU		401
+#define SRST_P_CENTER_GRF		402
+#define SRST_P_DMA2DDR			403
+#define SRST_P_SHAREMEM			404
+#define SRST_P_CENTER_BIU		405
+
+#define SRST_LINKSYM_HDMITXPHY0		406
+
+#define SRST_DP0_PIXELCLK		407
+#define SRST_PHY_DP0_TX			408
+#define SRST_DP1_PIXELCLK		409
+#define SRST_DP2_PIXELCLK		410
+
+#define SRST_H_VEPU1_BIU		411
+#define SRST_A_VEPU1_BIU		412
+#define SRST_H_VEPU1			413
+#define SRST_A_VEPU1			414
+#define SRST_VEPU1_CORE			415
+
+#endif
-- 
2.46.0


