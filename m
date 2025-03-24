Return-Path: <linux-kernel+bounces-573373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8440A6D681
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A143A980D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8F625DB1D;
	Mon, 24 Mar 2025 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="x1nRvXqQ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768425D214
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805674; cv=none; b=jIweXRJBzGcXhV9KmNVGcqIO2GKopzTvLcORXjdkHBIZ1mnaE5XQRm3HkGdHZ6v1qaqbglD85HQyeoTH5Hjb6ccNPb94nop3MDN1GLzHu+c4vtWps8tVnfcaHGOhmbl+jF7xbLjIkfyhu4BlKhUivnuQkaRu3cGWHvR7h7ta0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805674; c=relaxed/simple;
	bh=Z7IxqlTsp9CY6CP1V4lWx7K/ws2KibJ2wskITOyNJAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=derzcZpo7+cnS6MnESe9k4FuA5Izb5UOhuiU1umSpjURSpxvrwws7pXp+v3iW1lBXX3rIueP46RfUwQDVncw7CnL5XKoNQ926fTOMP+eJKO4v3ZHEvY8WaRpkBS4U9xDpNWPcR51Mob4orn4wLpJ/VprBJu08ricOvxrJcDI+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=x1nRvXqQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so7643712a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742805668; x=1743410468; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkVUmAZx6lVs5OXdh8l+vKRXKduUD/uqBpWi904hWVs=;
        b=x1nRvXqQGCDOYu2FgRlV0ujsgplhB3ELxfPGxZdt3CMOKWorzPxYAvlDr6b2WRLcmm
         S+sWAUBnvUkEJrKzP3Z7i9BPvdpE/xDm4vL0sZBh8A0RjE5zDlYKNsSPb8BLc6OLzmPI
         5byFcLFb3vMtVRx5SagXuVSJB3Pl+cxsbn43+w/3TAcfyDJEqFtPrKeCwDnjE08pxqfm
         jqjSRyxK2ZI4IhJDIqrLVKWNsVl+s+dXgZapRLfXqn/5umFKH2xg3oSmVtUcFJxVeHxE
         129PHwZ7y4bbqV7cOqMVLz3fH08+m0R/+ofVpOdov9ffTGM2nuPUz9DEAbto9Ya4MVNS
         /ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805668; x=1743410468;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AkVUmAZx6lVs5OXdh8l+vKRXKduUD/uqBpWi904hWVs=;
        b=bsqRg9FzA6wD/36WuoulZmlPnLfifilheqUPMz/3alrrPdF2j6EHBgqU5SnL1TPkwP
         zwl5GwxKliT2lHl6pwW2w19XA8MU2qBxB/CP1CHu0vehM425MCFrAWTuiP4XEVzjH1Jz
         tswDeZZcTEVzCtmwXvyVrxMkXgVrolBOYPwFp8fL/wdHdfvA+/IZrAIm5rinn8Vopmq3
         YkoYKfxsA74mVZJOb0/0TmTgSb+GBkoerjf/i2LkqHeVSvzZU3a3y4RWCkV0YKP/O3zC
         r5DuSoAEY28mVGJYbQXrLPiT2+lZK0AmrlIiON7qeT/v+/QHcRMb9vhoP8z/5/Kg1hQR
         yFAg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Cs5H/D5LYVKDfe6lA17TDq7YKPfnYwgEBR4m0NeqZor/winBVl3cq0SUW0dAM6/a29d3RkWGsIsSAls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tM+ASiUt2crFGMvZoKkHH5SUai40Hot6TYnX+KXsOfLHRFDM
	ruunZCro2G/hrE8nY+yQt+mVPelMXnabn3iHJJvQRNdLrTqjEQohRiOc72cm+zEEtETLOKDVWar
	C
X-Gm-Gg: ASbGncuvRr2dS9yPmcDsJ4CwEgxJCBXCS4CB0huI37eeHsekquX3uH6kfwrmsUZeEOd
	2kmXPtPSYdx6KS/MPnF9WZRL6wFIoA7lCE1iUk/b/z1t9vOFBbUfaikPpD854PBabiYR3WKFW6E
	JbEohB2EzmbycEb6H9U722r8bJEvP0GyylHcmunU0Z/dAvtrrVcuJSWUwXEm9MnmtQHbijT4Mur
	GD8ia6edKB2Cg1EBAPFfy6KY+VShv5snp/+EABkXS3bFKkmdI99YYimWfN6pZqMhjmAb8krGQs3
	J+lX8RGJr65YNCtw4hkeRA4p86WFaG3ySU1G3W/i1VgU/xTwVEW5+PPaMYS0UK/uhCqf6ZFxUEa
	FeO+EYKoZrawpAXA50g==
X-Google-Smtp-Source: AGHT+IGZYnpTAooKGEh2BcI4yBXPcXRUadEOgGc+jDr/nXwaO5/B+mMju37EWSTFJaBhuDJ4Am44SA==
X-Received: by 2002:a05:6402:4315:b0:5ec:8aeb:812a with SMTP id 4fb4d7f45d1cf-5ec8afac4abmr3732044a12.14.1742805668419;
        Mon, 24 Mar 2025 01:41:08 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0dfb33sm5715937a12.68.2025.03.24.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:41:08 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 24 Mar 2025 09:41:03 +0100
Subject: [PATCH v2 3/4] clk: qcom: Add video clock controller driver for
 SM6350
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-sm6350-videocc-v2-3-cc22386433f4@fairphone.com>
References: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
In-Reply-To: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2

From: Konrad Dybcio <konradybcio@kernel.org>

Add support for the video clock controller found on SM6350 based
devices.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
Co-developed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/Kconfig          |   9 +
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/videocc-sm6350.c | 355 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 365 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 7d5dac26b244bfe785370033ad8ba49876d6627d..602e35d3d6c5b3b76947d892bb705fe742daf081 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1329,6 +1329,15 @@ config SA_VIDEOCC_8775P
 	  Say Y if you want to support video devices and functionality such as
 	  video encode/decode.
 
+config SM_VIDEOCC_6350
+	tristate "SM6350 Video Clock Controller"
+	select SM_GCC_6350
+	select QCOM_GDSC
+	help
+	  Support for the video clock controller on SM6350 devices.
+	  Say Y if you want to support video devices and functionality such as
+	  video encode and decode.
+
 config SM_VIDEOCC_7150
 	tristate "SM7150 Video Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 96862e99e5d432bbfba193c961d59ec5e601f10a..70895bc465549b87c7c7a8dc6f8ac84c223a85d6 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -164,6 +164,7 @@ obj-$(CONFIG_SM_LPASSCC_6115) += lpasscc-sm6115.o
 obj-$(CONFIG_SM_TCSRCC_8550) += tcsrcc-sm8550.o
 obj-$(CONFIG_SM_TCSRCC_8650) += tcsrcc-sm8650.o
 obj-$(CONFIG_SM_TCSRCC_8750) += tcsrcc-sm8750.o
+obj-$(CONFIG_SM_VIDEOCC_6350) += videocc-sm6350.o
 obj-$(CONFIG_SM_VIDEOCC_7150) += videocc-sm7150.o
 obj-$(CONFIG_SM_VIDEOCC_8150) += videocc-sm8150.o
 obj-$(CONFIG_SM_VIDEOCC_8250) += videocc-sm8250.o
diff --git a/drivers/clk/qcom/videocc-sm6350.c b/drivers/clk/qcom/videocc-sm6350.c
new file mode 100644
index 0000000000000000000000000000000000000000..34bdc5aa865ac3e0c23ac1a2f5e471d3cfe64192
--- /dev/null
+++ b/drivers/clk/qcom/videocc-sm6350.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ * Copyright (c) 2025, Luca Weiss <luca.weiss@fairphone.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm6350-videocc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "common.h"
+#include "gdsc.h"
+
+enum {
+	DT_IFACE,
+	DT_BI_TCXO,
+	DT_SLEEP_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_CHIP_SLEEP_CLK,
+	P_VIDEO_PLL0_OUT_EVEN,
+};
+
+static const struct pll_vco fabia_vco[] = {
+	{ 125000000, 1000000000, 1 },
+};
+
+/* 600 MHz */
+static const struct alpha_pll_config video_pll0_config = {
+	.l = 0x1f,
+	.alpha = 0x4000,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002067,
+	.test_ctl_val = 0x40000000,
+	.test_ctl_hi_val = 0x00000002,
+	.user_ctl_val = 0x00000101,
+	.user_ctl_hi_val = 0x00004005,
+};
+
+static struct clk_alpha_pll video_pll0 = {
+	.offset = 0x0,
+	.vco_table = fabia_vco,
+	.num_vco = ARRAY_SIZE(fabia_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_pll0",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fabia_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_video_pll0_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv video_pll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_video_pll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_video_pll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_FABIA],
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_pll0_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
+			&video_pll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_fabia_ops,
+	},
+};
+
+static const struct parent_map video_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_VIDEO_PLL0_OUT_EVEN, 3 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &video_pll0_out_even.clkr.hw },
+};
+
+static const struct parent_map video_cc_parent_map_1[] = {
+	{ P_CHIP_SLEEP_CLK, 0 },
+};
+
+static const struct clk_parent_data video_cc_parent_data_1[] = {
+	{ .index = DT_SLEEP_CLK },
+};
+
+static const struct freq_tbl ftbl_video_cc_iris_clk_src[] = {
+	F(133250000, P_VIDEO_PLL0_OUT_EVEN, 2, 0, 0),
+	F(240000000, P_VIDEO_PLL0_OUT_EVEN, 1.5, 0, 0),
+	F(300000000, P_VIDEO_PLL0_OUT_EVEN, 1, 0, 0),
+	F(380000000, P_VIDEO_PLL0_OUT_EVEN, 1, 0, 0),
+	F(460000000, P_VIDEO_PLL0_OUT_EVEN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_iris_clk_src = {
+	.cmd_rcgr = 0x1000,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_0,
+	.freq_tbl = ftbl_video_cc_iris_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_iris_clk_src",
+		.parent_data = video_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_video_cc_sleep_clk_src[] = {
+	F(32764, P_CHIP_SLEEP_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_cc_sleep_clk_src = {
+	.cmd_rcgr = 0x701c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = video_cc_parent_map_1,
+	.freq_tbl = ftbl_video_cc_sleep_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "video_cc_sleep_clk_src",
+		.parent_data = video_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(video_cc_parent_data_1),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch video_cc_iris_ahb_clk = {
+	.halt_reg = 0x5004,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x5004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_iris_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_iris_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs0_axi_clk = {
+	.halt_reg = 0x800c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x800c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvs0_core_clk = {
+	.halt_reg = 0x3010,
+	.halt_check = BRANCH_VOTED,
+	.hwcg_reg = 0x3010,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x3010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvs0_core_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_iris_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvsc_core_clk = {
+	.halt_reg = 0x2014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvsc_core_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_iris_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_mvsc_ctl_axi_clk = {
+	.halt_reg = 0x8004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x8004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_mvsc_ctl_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_sleep_clk = {
+	.halt_reg = 0x7034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x7034,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_sleep_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&video_cc_sleep_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_cc_venus_ahb_clk = {
+	.halt_reg = 0x801c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x801c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "video_cc_venus_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc mvsc_gdsc = {
+	.gdscr = 0x2004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x6,
+	.pd = {
+		.name = "mvsc_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc mvs0_gdsc = {
+	.gdscr = 0x3004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x6,
+	.pd = {
+		.name = "mvs0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL_TRIGGER,
+};
+
+static struct gdsc *video_cc_sm6350_gdscs[] = {
+	[MVSC_GDSC] = &mvsc_gdsc,
+	[MVS0_GDSC] = &mvs0_gdsc,
+};
+
+static struct clk_regmap *video_cc_sm6350_clocks[] = {
+	[VIDEO_CC_IRIS_AHB_CLK] = &video_cc_iris_ahb_clk.clkr,
+	[VIDEO_CC_IRIS_CLK_SRC] = &video_cc_iris_clk_src.clkr,
+	[VIDEO_CC_MVS0_AXI_CLK] = &video_cc_mvs0_axi_clk.clkr,
+	[VIDEO_CC_MVS0_CORE_CLK] = &video_cc_mvs0_core_clk.clkr,
+	[VIDEO_CC_MVSC_CORE_CLK] = &video_cc_mvsc_core_clk.clkr,
+	[VIDEO_CC_MVSC_CTL_AXI_CLK] = &video_cc_mvsc_ctl_axi_clk.clkr,
+	[VIDEO_CC_SLEEP_CLK] = &video_cc_sleep_clk.clkr,
+	[VIDEO_CC_SLEEP_CLK_SRC] = &video_cc_sleep_clk_src.clkr,
+	[VIDEO_CC_VENUS_AHB_CLK] = &video_cc_venus_ahb_clk.clkr,
+	[VIDEO_PLL0] = &video_pll0.clkr,
+	[VIDEO_PLL0_OUT_EVEN] = &video_pll0_out_even.clkr,
+};
+
+static const struct regmap_config video_cc_sm6350_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0xb000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc video_cc_sm6350_desc = {
+	.config = &video_cc_sm6350_regmap_config,
+	.clks = video_cc_sm6350_clocks,
+	.num_clks = ARRAY_SIZE(video_cc_sm6350_clocks),
+	.gdscs = video_cc_sm6350_gdscs,
+	.num_gdscs = ARRAY_SIZE(video_cc_sm6350_gdscs),
+};
+
+static const struct of_device_id video_cc_sm6350_match_table[] = {
+	{ .compatible = "qcom,sm6350-videocc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, video_cc_sm6350_match_table);
+
+static int video_cc_sm6350_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &video_cc_sm6350_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_fabia_pll_configure(&video_pll0, regmap, &video_pll0_config);
+
+	/* Keep some clocks always-on */
+	qcom_branch_set_clk_en(regmap, 0x7018); /* VIDEO_CC_XO_CLK */
+
+	return qcom_cc_really_probe(&pdev->dev, &video_cc_sm6350_desc, regmap);
+}
+
+static struct platform_driver video_cc_sm6350_driver = {
+	.probe = video_cc_sm6350_probe,
+	.driver = {
+		.name = "video_cc-sm6350",
+		.of_match_table = video_cc_sm6350_match_table,
+	},
+};
+
+module_platform_driver(video_cc_sm6350_driver);
+
+MODULE_DESCRIPTION("QTI VIDEO_CC SM6350 Driver");
+MODULE_LICENSE("GPL");

-- 
2.49.0


