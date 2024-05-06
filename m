Return-Path: <linux-kernel+bounces-169708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4028BCC66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3193F1C2232D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75046142E62;
	Mon,  6 May 2024 10:51:43 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3D414262C;
	Mon,  6 May 2024 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992701; cv=none; b=HwzHt2uolCvz7+rMOR39K6ymtGWtaNlNJDtU8DXiVT0e9gqK1tV6BZRzpkZ7cavdorrtUwgdCgUsKOEuadMI9GA5i0L6Jla53mj8TzoJe7zVDWva1QhmdygaYtDUwjW0T3ru/Rfi5UMlgBr+Fo0z58PKFnuWQ8oEpxY+0nQ35pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992701; c=relaxed/simple;
	bh=YK54AHSWdsNfDqKDkfBrxytDDm2YNhpwCfMA8i5HU+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uztc4La1Ju4/5IP+ZU6Z7nFBnIzSVE9Ta7+I/uuM/w5bia0zUtSaqV5wlIj8poejIRf8MXLBnEWlax9m9akXMQcg/M0tegsKd5856c3nV3fKMxSHhwvLISf9LzviGQjDEIfAh7FZddizjfSqjo5wnI/LJK+tGlW42p6+eUGGcD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 6 May
 2024 18:51:20 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 6 May 2024 18:51:20 +0800
From: Dylan Hung <dylan_hung@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>,
	<alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH 2/2] [RFC] i3c: ast2600: Validate AST2600 I3C for MCTP-over-I3C
Date: Mon, 6 May 2024 18:51:20 +0800
Message-ID: <20240506105120.3028083-3-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
References: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch introduces minimal changes to validate the functionality of
Aspeed AST2600 I3C controllers for MCTP-over-I3C.

Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
---
 drivers/i3c/master/ast2600-i3c-master.c | 137 +++++++
 drivers/i3c/master/dw-i3c-master.c      | 513 ++++++++++++++++++++----
 drivers/i3c/master/dw-i3c-master.h      |  12 +
 3 files changed, 581 insertions(+), 81 deletions(-)

diff --git a/drivers/i3c/master/ast2600-i3c-master.c b/drivers/i3c/master/ast2600-i3c-master.c
index 01a47d3dd499..a0a48f10bccb 100644
--- a/drivers/i3c/master/ast2600-i3c-master.c
+++ b/drivers/i3c/master/ast2600-i3c-master.c
@@ -10,6 +10,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/bitfield.h>
 
 #include "dw-i3c-master.h"
 
@@ -33,9 +34,29 @@
 #define AST2600_I3CG_REG1_SA_EN			BIT(15)
 #define AST2600_I3CG_REG1_INST_ID_MASK		GENMASK(19, 16)
 #define AST2600_I3CG_REG1_INST_ID(x)		(((x) << 16) & AST2600_I3CG_REG1_INST_ID_MASK)
+#define SCL_SW_MODE_OE				BIT(20)
+#define SCL_OUT_SW_MODE_VAL			BIT(21)
+#define SCL_IN_SW_MODE_VAL			BIT(23)
+#define SDA_SW_MODE_OE				BIT(24)
+#define SDA_OUT_SW_MODE_VAL			BIT(25)
+#define SDA_IN_SW_MODE_VAL			BIT(27)
+#define SCL_IN_SW_MODE_EN			BIT(28)
+#define SDA_IN_SW_MODE_EN			BIT(29)
+#define SCL_OUT_SW_MODE_EN			BIT(30)
+#define SDA_OUT_SW_MODE_EN			BIT(31)
 
 #define AST2600_DEFAULT_SDA_PULLUP_OHMS		2000
 
+/* dw-i3c registers */
+#define IBI_QUEUE_STATUS			0x18
+
+#define PRESENT_STATE				0x54
+#define   CM_TFR_STS				GENMASK(13, 8)
+#define     CM_TFR_STS_MASTER_SERV_IBI		0xe
+#define   SDA_LINE_SIGNAL_LEVEL			BIT(1)
+#define   SCL_LINE_SIGNAL_LEVEL			BIT(0)
+
+/* DAT */
 #define DEV_ADDR_TABLE_IBI_PEC			BIT(11)
 
 struct ast2600_i3c {
@@ -117,9 +138,125 @@ static void ast2600_i3c_set_dat_ibi(struct dw_i3c_master *i3c,
 	}
 }
 
+static int aspeed_i3c_bus_recovery(struct dw_i3c_master *dw)
+{
+	struct ast2600_i3c *i3c = to_ast2600_i3c(dw);
+	int i, ret = -1;
+
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SCL_OUT_SW_MODE_VAL, SCL_OUT_SW_MODE_VAL);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SCL_SW_MODE_OE, SCL_SW_MODE_OE);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SCL_OUT_SW_MODE_EN, SCL_OUT_SW_MODE_EN);
+
+	for (i = 0; i < 19; i++) {
+		regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+				  SCL_OUT_SW_MODE_VAL, 0);
+		regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+				  SCL_OUT_SW_MODE_VAL, SCL_OUT_SW_MODE_VAL);
+		if (readl(dw->regs + PRESENT_STATE) & SDA_LINE_SIGNAL_LEVEL) {
+			ret = 0;
+			break;
+		}
+	}
+
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SCL_OUT_SW_MODE_EN, 0);
+	if (ret)
+		dev_err(&dw->base.dev, "Failed to recover the bus\n");
+
+	return ret;
+}
+
+static void ast2600_i3c_gen_target_reset_pattern(struct dw_i3c_master *dw)
+{
+	struct ast2600_i3c *i3c = to_ast2600_i3c(dw);
+	int i;
+
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_OUT_SW_MODE_VAL | SCL_OUT_SW_MODE_VAL,
+			  SDA_OUT_SW_MODE_VAL | SCL_OUT_SW_MODE_VAL);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_SW_MODE_OE | SCL_SW_MODE_OE,
+			  SDA_SW_MODE_OE | SCL_SW_MODE_OE);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_OUT_SW_MODE_EN | SCL_OUT_SW_MODE_EN,
+			  SDA_OUT_SW_MODE_EN | SCL_OUT_SW_MODE_EN);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_IN_SW_MODE_VAL | SCL_IN_SW_MODE_VAL,
+			  SDA_IN_SW_MODE_VAL | SCL_IN_SW_MODE_VAL);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_IN_SW_MODE_EN | SCL_IN_SW_MODE_EN,
+			  SDA_IN_SW_MODE_EN | SCL_IN_SW_MODE_EN);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SCL_OUT_SW_MODE_VAL, 0);
+	for (i = 0; i < 7; i++) {
+		regmap_write_bits(i3c->global_regs,
+				  AST2600_I3CG_REG1(i3c->global_idx),
+				  SDA_OUT_SW_MODE_VAL, 0);
+		regmap_write_bits(i3c->global_regs,
+				  AST2600_I3CG_REG1(i3c->global_idx),
+				  SDA_OUT_SW_MODE_VAL, SDA_OUT_SW_MODE_VAL);
+	}
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SCL_OUT_SW_MODE_VAL, SCL_OUT_SW_MODE_VAL);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_OUT_SW_MODE_VAL, 0);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_OUT_SW_MODE_VAL, SDA_OUT_SW_MODE_VAL);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_OUT_SW_MODE_EN | SCL_OUT_SW_MODE_EN, 0);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_IN_SW_MODE_EN | SCL_IN_SW_MODE_EN, 0);
+}
+
+static bool ast2600_i3c_fsm_exit_serv_ibi(struct dw_i3c_master *dw)
+{
+	u32 state;
+
+	/*
+	 * Clear the IBI queue to enable the hardware to generate SCL and
+	 * begin detecting the T-bit low to stop reading IBI data.
+	 */
+	readl(dw->regs + IBI_QUEUE_STATUS);
+	state = FIELD_GET(CM_TFR_STS, readl(dw->regs + PRESENT_STATE));
+	if (state == CM_TFR_STS_MASTER_SERV_IBI)
+		return false;
+
+	return true;
+}
+
+static void ast2600_i3c_gen_tbits_in(struct dw_i3c_master *dw)
+{
+	struct ast2600_i3c *i3c = to_ast2600_i3c(dw);
+	bool is_idle;
+	int ret;
+
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_IN_SW_MODE_VAL, SDA_IN_SW_MODE_VAL);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_IN_SW_MODE_EN, SDA_IN_SW_MODE_EN);
+
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_IN_SW_MODE_VAL, 0);
+	ret = readx_poll_timeout_atomic(ast2600_i3c_fsm_exit_serv_ibi, dw,
+					is_idle, is_idle, 0, 2000000);
+	regmap_write_bits(i3c->global_regs, AST2600_I3CG_REG1(i3c->global_idx),
+			  SDA_IN_SW_MODE_EN, 0);
+	if (ret)
+		dev_err(&dw->base.dev,
+			"Failed to exit the I3C fsm from %lx(MASTER_SERV_IBI): %d",
+			FIELD_GET(CM_TFR_STS, readl(dw->regs + PRESENT_STATE)),
+			ret);
+}
+
 static const struct dw_i3c_platform_ops ast2600_i3c_ops = {
 	.init = ast2600_i3c_init,
 	.set_dat_ibi = ast2600_i3c_set_dat_ibi,
+	.gen_target_reset_pattern = ast2600_i3c_gen_target_reset_pattern,
+	.gen_tbits_in = ast2600_i3c_gen_tbits_in,
+	.bus_recovery = aspeed_i3c_bus_recovery,
 };
 
 static int ast2600_i3c_probe(struct platform_device *pdev)
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 0ec00e644bd4..a9fe886ee840 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/err.h>
@@ -26,8 +27,10 @@
 #define DEVICE_CTRL			0x0
 #define DEV_CTRL_ENABLE			BIT(31)
 #define DEV_CTRL_RESUME			BIT(30)
+#define DEV_CTRL_ABORT			BIT(29)
 #define DEV_CTRL_HOT_JOIN_NACK		BIT(8)
 #define DEV_CTRL_I2C_SLAVE_PRESENT	BIT(7)
+#define DEV_CTRL_IBA_INCLUDE		BIT(0)
 
 #define DEVICE_ADDR			0x4
 #define DEV_ADDR_DYNAMIC_ADDR_VALID	BIT(31)
@@ -40,6 +43,16 @@
 #define COMMAND_PORT_SDAP		BIT(27)
 #define COMMAND_PORT_ROC		BIT(26)
 #define COMMAND_PORT_SPEED(x)		(((x) << 21) & GENMASK(23, 21))
+#define   SPEED_I3C_SDR0		0x0
+#define   SPEED_I3C_SDR1		0x1
+#define   SPEED_I3C_SDR2		0x2
+#define   SPEED_I3C_SDR3		0x3
+#define   SPEED_I3C_SDR4		0x4
+#define   SPEED_I3C_HDR_TS		0x5
+#define   SPEED_I3C_HDR_DDR		0x6
+#define   SPEED_I3C_I2C_FM		0x7
+#define   SPEED_I2C_FM			0x0
+#define   SPEED_I2C_FMP			0x1
 #define COMMAND_PORT_DEV_INDEX(x)	(((x) << 16) & GENMASK(20, 16))
 #define COMMAND_PORT_CP			BIT(15)
 #define COMMAND_PORT_CMD(x)		(((x) << 7) & GENMASK(14, 7))
@@ -76,6 +89,7 @@
 
 #define RX_TX_DATA_PORT			0x14
 #define IBI_QUEUE_STATUS		0x18
+#define IBI_QUEUE_STATUS_RSP_NACK	BIT(31)
 #define IBI_QUEUE_STATUS_IBI_ID(x)	(((x) & GENMASK(15, 8)) >> 8)
 #define IBI_QUEUE_STATUS_DATA_LEN(x)	((x) & GENMASK(7, 0))
 #define IBI_QUEUE_IBI_ADDR(x)		(IBI_QUEUE_STATUS_IBI_ID(x) >> 1)
@@ -96,7 +110,8 @@
 #define QUEUE_THLD_CTRL_RESP_BUF(x)	(((x) - 1) << 8)
 
 #define DATA_BUFFER_THLD_CTRL		0x20
-#define DATA_BUFFER_THLD_CTRL_RX_BUF	GENMASK(11, 8)
+#define DATA_BUFFER_THLD_TX_START	GENMASK(18, 16)
+#define DATA_BUFFER_THLD_CTRL_RX_BUF	GENMASK(10, 8)
 
 #define IBI_QUEUE_CTRL			0x24
 #define IBI_MR_REQ_REJECT		0x2C
@@ -156,6 +171,12 @@
 #define DATA_BUFFER_STATUS_LEVEL_TX(x)	((x) & GENMASK(7, 0))
 
 #define PRESENT_STATE			0x54
+#define   CM_TFR_STS			GENMASK(13, 8)
+#define     CM_TFR_STS_MASTER_SERV_IBI	0xe
+#define     CM_TFR_STS_MASTER_HALT	0xf
+#define   SDA_LINE_SIGNAL_LEVEL		BIT(1)
+#define   SCL_LINE_SIGNAL_LEVEL		BIT(0)
+
 #define CCC_DEVICE_STATUS		0x58
 #define DEVICE_ADDR_TABLE_POINTER	0x5c
 #define DEVICE_ADDR_TABLE_DEPTH(x)	(((x) & GENMASK(31, 16)) >> 16)
@@ -173,17 +194,17 @@
 #define DEVICE_CTRL_EXTENDED		0xb0
 #define SCL_I3C_OD_TIMING		0xb4
 #define SCL_I3C_PP_TIMING		0xb8
-#define SCL_I3C_TIMING_HCNT(x)		(((x) << 16) & GENMASK(23, 16))
-#define SCL_I3C_TIMING_LCNT(x)		((x) & GENMASK(7, 0))
-#define SCL_I3C_TIMING_CNT_MIN		5
+#define   SCL_I3C_TIMING_HCNT		GENMASK(23, 16)
+#define   SCL_I3C_TIMING_LCNT		GENMASK(7, 0)
+#define     SCL_I3C_TIMING_CNT_MIN	5
 
 #define SCL_I2C_FM_TIMING		0xbc
-#define SCL_I2C_FM_TIMING_HCNT(x)	(((x) << 16) & GENMASK(31, 16))
-#define SCL_I2C_FM_TIMING_LCNT(x)	((x) & GENMASK(15, 0))
+#define   SCL_I2C_FM_TIMING_HCNT	GENMASK(31, 16)
+#define   SCL_I2C_FM_TIMING_LCNT	GENMASK(15, 0)
 
 #define SCL_I2C_FMP_TIMING		0xc0
-#define SCL_I2C_FMP_TIMING_HCNT(x)	(((x) << 16) & GENMASK(23, 16))
-#define SCL_I2C_FMP_TIMING_LCNT(x)	((x) & GENMASK(15, 0))
+#define   SCL_I2C_FMP_TIMING_HCNT	GENMASK(23, 16)
+#define   SCL_I2C_FMP_TIMING_LCNT	GENMASK(15, 0)
 
 #define SCL_EXT_LCNT_TIMING		0xc8
 #define SCL_EXT_LCNT_4(x)		(((x) << 24) & GENMASK(31, 24))
@@ -192,8 +213,14 @@
 #define SCL_EXT_LCNT_1(x)		((x) & GENMASK(7, 0))
 
 #define SCL_EXT_TERMN_LCNT_TIMING	0xcc
+#define SDA_HOLD_SWITCH_DLY_TIMING	0xd0
+#define   SDA_TX_HOLD			GENMASK(18, 16)
+#define     SDA_TX_HOLD_MIN		0b001
+#define     SDA_TX_HOLD_MAX		0b111
 #define BUS_FREE_TIMING			0xd4
-#define BUS_I3C_MST_FREE(x)		((x) & GENMASK(15, 0))
+#define   BUS_AVAIL_TIME		GENMASK(31, 16)
+#define     MAX_BUS_AVAIL_CNT		0xffffU
+#define   BUS_I3C_MST_FREE		GENMASK(15, 0)
 
 #define BUS_IDLE_TIMING			0xd8
 #define I3C_VER_ID			0xe0
@@ -201,10 +228,11 @@
 #define EXTENDED_CAPABILITY		0xe8
 #define SLAVE_CONFIG			0xec
 
-#define DEV_ADDR_TABLE_IBI_MDB		BIT(12)
-#define DEV_ADDR_TABLE_SIR_REJECT	BIT(13)
 #define DEV_ADDR_TABLE_LEGACY_I2C_DEV	BIT(31)
 #define DEV_ADDR_TABLE_DYNAMIC_ADDR(x)	(((x) << 16) & GENMASK(23, 16))
+#define DEV_ADDR_TABLE_MR_REJECT	BIT(14)
+#define DEV_ADDR_TABLE_SIR_REJECT	BIT(13)
+#define DEV_ADDR_TABLE_IBI_MDB		BIT(12)
 #define DEV_ADDR_TABLE_STATIC_ADDR(x)	((x) & GENMASK(6, 0))
 #define DEV_ADDR_TABLE_LOC(start, idx)	((start) + ((idx) << 2))
 
@@ -212,8 +240,19 @@
 #define I3C_BUS_SDR2_SCL_RATE		6000000
 #define I3C_BUS_SDR3_SCL_RATE		4000000
 #define I3C_BUS_SDR4_SCL_RATE		2000000
+#define I3C_BUS_I2C_STD_SCL_RATE	100000
+#define I3C_BUS_I2C_STD_TLOW_MIN_NS	4700
+#define I3C_BUS_I2C_STD_THIGH_MIN_NS	4000
+#define I3C_BUS_I2C_STD_TR_MAX_NS	1000
+#define I3C_BUS_I2C_STD_TF_MAX_NS	300
 #define I3C_BUS_I2C_FM_TLOW_MIN_NS	1300
+#define I3C_BUS_I2C_FM_THIGH_MIN_NS	600
+#define I3C_BUS_I2C_FM_TR_MAX_NS	300
+#define I3C_BUS_I2C_FM_TF_MAX_NS	300
 #define I3C_BUS_I2C_FMP_TLOW_MIN_NS	500
+#define I3C_BUS_I2C_FMP_THIGH_MIN_NS	260
+#define I3C_BUS_I2C_FMP_TR_MAX_NS	120
+#define I3C_BUS_I2C_FMP_TF_MAX_NS	120
 #define I3C_BUS_THIGH_MAX_NS		41
 
 #define XFER_TIMEOUT (msecs_to_jiffies(1000))
@@ -292,6 +331,18 @@ to_dw_i3c_master(struct i3c_master_controller *master)
 	return container_of(master, struct dw_i3c_master, base);
 }
 
+static void dw_i3c_master_set_iba(struct dw_i3c_master *master, bool enable)
+{
+	u32 reg;
+
+	reg = readl(master->regs + DEVICE_CTRL);
+	reg &= ~DEV_CTRL_IBA_INCLUDE;
+	if (enable)
+		reg |= DEV_CTRL_IBA_INCLUDE;
+
+	writel(reg, master->regs + DEVICE_CTRL);
+}
+
 static void dw_i3c_master_disable(struct dw_i3c_master *master)
 {
 	writel(readl(master->regs + DEVICE_CTRL) & ~DEV_CTRL_ENABLE,
@@ -304,6 +355,50 @@ static void dw_i3c_master_enable(struct dw_i3c_master *master)
 	       master->regs + DEVICE_CTRL);
 }
 
+static int dw_i3c_master_exit_halt(struct dw_i3c_master *master)
+{
+	u32 status;
+	u32 halt_state = CM_TFR_STS_MASTER_HALT;
+	int ret;
+
+	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_RESUME,
+	       master->regs + DEVICE_CTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + PRESENT_STATE, status,
+					FIELD_GET(CM_TFR_STS, status) != halt_state,
+					10, 1000000);
+
+	if (ret)
+		dev_err(&master->base.dev,
+			"Exit halt state failed: %d %#x %#x\n", ret,
+			readl(master->regs + PRESENT_STATE),
+			readl(master->regs + QUEUE_STATUS_LEVEL));
+	return ret;
+}
+
+static int dw_i3c_master_enter_halt(struct dw_i3c_master *master, bool by_sw)
+{
+	u32 status;
+	u32 halt_state = CM_TFR_STS_MASTER_HALT;
+	int ret;
+
+	if (by_sw)
+		writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_ABORT,
+		       master->regs + DEVICE_CTRL);
+
+	ret = readl_poll_timeout_atomic(master->regs + PRESENT_STATE, status,
+					FIELD_GET(CM_TFR_STS, status) == halt_state,
+					10, 1000000);
+
+	if (ret)
+		dev_err(&master->base.dev,
+			"Enter halt state failed: %d %#x %#x\n", ret,
+			readl(master->regs + PRESENT_STATE),
+			readl(master->regs + QUEUE_STATUS_LEVEL));
+
+	return ret;
+}
+
 static int dw_i3c_master_get_addr_pos(struct dw_i3c_master *master, u8 addr)
 {
 	int pos;
@@ -506,9 +601,14 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
 	complete(&xfer->comp);
 
 	if (ret < 0) {
+		/*
+		 * The controller will enter the HALT state if an error occurs.
+		 * Therefore, there is no need to manually halt the controller
+		 * through software.
+		 */
+		dw_i3c_master_enter_halt(master, false);
 		dw_i3c_master_dequeue_xfer_locked(master, xfer);
-		writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_RESUME,
-		       master->regs + DEVICE_CTRL);
+		dw_i3c_master_exit_halt(master);
 	}
 
 	xfer = list_first_entry_or_null(&master->xferqueue.list,
@@ -521,41 +621,76 @@ static void dw_i3c_master_end_xfer_locked(struct dw_i3c_master *master, u32 isr)
 	dw_i3c_master_start_xfer_locked(master);
 }
 
+static int calc_i2c_clk(struct dw_i3c_master *master, unsigned long fscl,
+			u16 *hcnt, u16 *lcnt)
+{
+	unsigned long core_rate, core_period;
+	u32 period_cnt, margin;
+	u32 hcnt_min, lcnt_min;
+
+	core_rate = master->timing.core_rate;
+	core_period = master->timing.core_period;
+
+	if (fscl <= I3C_BUS_I2C_STD_SCL_RATE) {
+		lcnt_min = DIV_ROUND_UP(I3C_BUS_I2C_STD_TLOW_MIN_NS +
+						I3C_BUS_I2C_STD_TF_MAX_NS,
+					core_period);
+		hcnt_min = DIV_ROUND_UP(I3C_BUS_I2C_STD_THIGH_MIN_NS +
+						I3C_BUS_I2C_STD_TR_MAX_NS,
+					core_period);
+	} else if (fscl <= I3C_BUS_I2C_FM_SCL_RATE) {
+		lcnt_min = DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS +
+						I3C_BUS_I2C_FM_TF_MAX_NS,
+					core_period);
+		hcnt_min = DIV_ROUND_UP(I3C_BUS_I2C_FM_THIGH_MIN_NS +
+						I3C_BUS_I2C_FM_TR_MAX_NS,
+					core_period);
+	} else {
+		lcnt_min = DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS +
+						I3C_BUS_I2C_FMP_TF_MAX_NS,
+					core_period);
+		hcnt_min = DIV_ROUND_UP(I3C_BUS_I2C_FMP_THIGH_MIN_NS +
+						I3C_BUS_I2C_FMP_TR_MAX_NS,
+					core_period);
+	}
+
+	period_cnt = DIV_ROUND_UP(core_rate, fscl);
+	margin = (period_cnt - hcnt_min - lcnt_min) >> 1;
+	*lcnt = lcnt_min + margin;
+	*hcnt = max(period_cnt - *lcnt, hcnt_min);
+
+	return 0;
+}
+
 static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 {
 	unsigned long core_rate, core_period;
 	u32 scl_timing;
 	u8 hcnt, lcnt;
 
-	core_rate = clk_get_rate(master->core_clk);
-	if (!core_rate)
-		return -EINVAL;
-
-	core_period = DIV_ROUND_UP(1000000000, core_rate);
-
-	hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_MAX_NS, core_period) - 1;
-	if (hcnt < SCL_I3C_TIMING_CNT_MIN)
-		hcnt = SCL_I3C_TIMING_CNT_MIN;
+	core_rate = master->timing.core_rate;
+	core_period = master->timing.core_period;
 
-	lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) - hcnt;
-	if (lcnt < SCL_I3C_TIMING_CNT_MIN)
-		lcnt = SCL_I3C_TIMING_CNT_MIN;
+	if (master->timing.i3c_pp_scl_high && master->timing.i3c_pp_scl_low) {
+		hcnt = DIV_ROUND_CLOSEST(master->timing.i3c_pp_scl_high,
+					 core_period);
+		lcnt = DIV_ROUND_CLOSEST(master->timing.i3c_pp_scl_low,
+					 core_period);
+	} else {
+		hcnt = DIV_ROUND_UP(I3C_BUS_THIGH_MAX_NS, core_period) - 1;
+		if (hcnt < SCL_I3C_TIMING_CNT_MIN)
+			hcnt = SCL_I3C_TIMING_CNT_MIN;
+
+		lcnt = DIV_ROUND_UP(core_rate, master->base.bus.scl_rate.i3c) -
+		       hcnt;
+		if (lcnt < SCL_I3C_TIMING_CNT_MIN)
+			lcnt = SCL_I3C_TIMING_CNT_MIN;
+	}
 
-	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
+	scl_timing = FIELD_PREP(SCL_I3C_TIMING_HCNT, hcnt) |
+		     FIELD_PREP(SCL_I3C_TIMING_LCNT, lcnt);
 	writel(scl_timing, master->regs + SCL_I3C_PP_TIMING);
 
-	/*
-	 * In pure i3c mode, MST_FREE represents tCAS. In shared mode, this
-	 * will be set up by dw_i2c_clk_cfg as tLOW.
-	 */
-	if (master->base.bus.mode == I3C_BUS_MODE_PURE)
-		writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
-
-	lcnt = max_t(u8,
-		     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period), lcnt);
-	scl_timing = SCL_I3C_TIMING_HCNT(hcnt) | SCL_I3C_TIMING_LCNT(lcnt);
-	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
-
 	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR1_SCL_RATE) - hcnt;
 	scl_timing = SCL_EXT_LCNT_1(lcnt);
 	lcnt = DIV_ROUND_UP(core_rate, I3C_BUS_SDR2_SCL_RATE) - hcnt;
@@ -566,6 +701,20 @@ static int dw_i3c_clk_cfg(struct dw_i3c_master *master)
 	scl_timing |= SCL_EXT_LCNT_4(lcnt);
 	writel(scl_timing, master->regs + SCL_EXT_LCNT_TIMING);
 
+	if (master->timing.i3c_od_scl_high && master->timing.i3c_od_scl_low) {
+		hcnt = DIV_ROUND_CLOSEST(master->timing.i3c_od_scl_high,
+					 core_period);
+		lcnt = DIV_ROUND_CLOSEST(master->timing.i3c_od_scl_low,
+					 core_period);
+	} else {
+		lcnt = max_t(u8,
+			     DIV_ROUND_UP(I3C_BUS_TLOW_OD_MIN_NS, core_period),
+			     lcnt);
+	}
+	scl_timing = FIELD_PREP(SCL_I3C_TIMING_HCNT, hcnt) |
+		     FIELD_PREP(SCL_I3C_TIMING_LCNT, lcnt);
+	writel(scl_timing, master->regs + SCL_I3C_OD_TIMING);
+
 	return 0;
 }
 
@@ -575,27 +724,56 @@ static int dw_i2c_clk_cfg(struct dw_i3c_master *master)
 	u16 hcnt, lcnt;
 	u32 scl_timing;
 
-	core_rate = clk_get_rate(master->core_clk);
-	if (!core_rate)
-		return -EINVAL;
+	core_rate = master->timing.core_rate;
+	core_period = master->timing.core_period;
 
-	core_period = DIV_ROUND_UP(1000000000, core_rate);
-
-	lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS, core_period);
-	hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_RATE) - lcnt;
-	scl_timing = SCL_I2C_FMP_TIMING_HCNT(hcnt) |
-		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
+	calc_i2c_clk(master, I3C_BUS_I2C_FM_PLUS_SCL_RATE, &hcnt, &lcnt);
+	scl_timing = FIELD_PREP(SCL_I2C_FMP_TIMING_HCNT, hcnt) |
+		     FIELD_PREP(SCL_I2C_FMP_TIMING_LCNT, lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
 
-	lcnt = DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
-	hcnt = DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
-	scl_timing = SCL_I2C_FM_TIMING_HCNT(hcnt) |
-		     SCL_I2C_FM_TIMING_LCNT(lcnt);
+	calc_i2c_clk(master, master->base.bus.scl_rate.i2c, &hcnt, &lcnt);
+	scl_timing = FIELD_PREP(SCL_I2C_FM_TIMING_HCNT, hcnt) |
+		     FIELD_PREP(SCL_I2C_FM_TIMING_LCNT, lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
 
-	writel(BUS_I3C_MST_FREE(lcnt), master->regs + BUS_FREE_TIMING);
-	writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_I2C_SLAVE_PRESENT,
-	       master->regs + DEVICE_CTRL);
+	return 0;
+}
+
+static int dw_i3c_bus_clk_cfg(struct i3c_master_controller *m)
+{
+	struct dw_i3c_master *master = to_dw_i3c_master(m);
+	struct i3c_bus *bus = i3c_master_get_bus(m);
+	int ret;
+	u16 lcnt;
+
+	ret = dw_i2c_clk_cfg(master);
+	if (ret)
+		return ret;
+
+	ret = dw_i3c_clk_cfg(master);
+	if (ret)
+		return ret;
+
+	/*
+	 * I3C register 0xd4[15:0] BUS_FREE_TIMING used to control several parameters:
+	 * - bus free time between a STOP condition and a START condition
+	 *
+	 * The constraints of these parameters differ in various bus contexts:
+	 * MIPI I3C, pure bus : BUS_FREE_TIMING = I3C PP SCL low period
+	 * MIPI I3C, mixed bus: BUS_FREE_TIMING = I2C FM SCL low period
+	 */
+	if (bus->mode == I3C_BUS_MODE_PURE) {
+		lcnt = FIELD_GET(SCL_I3C_TIMING_LCNT,
+				 readl(master->regs + SCL_I3C_PP_TIMING));
+	} else {
+		writel(readl(master->regs + DEVICE_CTRL) | DEV_CTRL_I2C_SLAVE_PRESENT,
+		       master->regs + DEVICE_CTRL);
+		lcnt = FIELD_GET(SCL_I2C_FM_TIMING_LCNT,
+				 readl(master->regs + SCL_I2C_FM_TIMING));
+	}
+
+	writel(FIELD_PREP(BUS_I3C_MST_FREE, lcnt), master->regs + BUS_FREE_TIMING);
 
 	return 0;
 }
@@ -603,7 +781,6 @@ static int dw_i2c_clk_cfg(struct dw_i3c_master *master)
 static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 {
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
-	struct i3c_bus *bus = i3c_master_get_bus(m);
 	struct i3c_device_info info = { };
 	u32 thld_ctrl;
 	int ret;
@@ -612,21 +789,11 @@ static int dw_i3c_master_bus_init(struct i3c_master_controller *m)
 	if (ret)
 		return ret;
 
-	switch (bus->mode) {
-	case I3C_BUS_MODE_MIXED_FAST:
-	case I3C_BUS_MODE_MIXED_LIMITED:
-		ret = dw_i2c_clk_cfg(master);
-		if (ret)
-			return ret;
-		fallthrough;
-	case I3C_BUS_MODE_PURE:
-		ret = dw_i3c_clk_cfg(master);
-		if (ret)
-			return ret;
-		break;
-	default:
-		return -EINVAL;
-	}
+	spin_lock_init(&master->devs_lock);
+
+	ret = dw_i3c_bus_clk_cfg(m);
+	if (ret)
+		return ret;
 
 	thld_ctrl = readl(master->regs + QUEUE_THLD_CTRL);
 	thld_ctrl &= ~(QUEUE_THLD_CTRL_RESP_BUF_MASK |
@@ -682,6 +849,7 @@ static int dw_i3c_ccc_set(struct dw_i3c_master *master,
 {
 	struct dw_i3c_xfer *xfer;
 	struct dw_i3c_cmd *cmd;
+	u32 sda_lvl_pre, sda_lvl_post;
 	int ret, pos = 0;
 
 	if (ccc->id & I3C_CCC_DIRECT) {
@@ -707,9 +875,21 @@ static int dw_i3c_ccc_set(struct dw_i3c_master *master,
 		      COMMAND_PORT_TOC |
 		      COMMAND_PORT_ROC;
 
+	sda_lvl_pre = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+				readl(master->regs + PRESENT_STATE));
 	dw_i3c_master_enqueue_xfer(master, xfer);
-	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT)) {
+		dw_i3c_master_enter_halt(master, true);
 		dw_i3c_master_dequeue_xfer(master, xfer);
+		sda_lvl_post = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+					 readl(master->regs + PRESENT_STATE));
+		if (sda_lvl_pre == 0 && sda_lvl_post == 0) {
+			dev_warn(&master->base.dev,
+				 "SDA stuck low! Try to recover the bus...\n");
+			master->platform_ops->bus_recovery(master);
+		}
+		dw_i3c_master_exit_halt(master);
+	}
 
 	ret = xfer->ret;
 	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
@@ -724,6 +904,7 @@ static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
 {
 	struct dw_i3c_xfer *xfer;
 	struct dw_i3c_cmd *cmd;
+	u32 sda_lvl_pre, sda_lvl_post;
 	int ret, pos;
 
 	pos = dw_i3c_master_get_addr_pos(master, ccc->dests[0].addr);
@@ -748,9 +929,21 @@ static int dw_i3c_ccc_get(struct dw_i3c_master *master, struct i3c_ccc_cmd *ccc)
 		      COMMAND_PORT_TOC |
 		      COMMAND_PORT_ROC;
 
+	sda_lvl_pre = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+				readl(master->regs + PRESENT_STATE));
 	dw_i3c_master_enqueue_xfer(master, xfer);
-	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT)) {
+		dw_i3c_master_enter_halt(master, true);
 		dw_i3c_master_dequeue_xfer(master, xfer);
+		sda_lvl_post = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+					 readl(master->regs + PRESENT_STATE));
+		if (sda_lvl_pre == 0 && sda_lvl_post == 0) {
+			dev_warn(&master->base.dev,
+				 "SDA stuck low! Try to recover the bus...\n");
+			master->platform_ops->bus_recovery(master);
+		}
+		dw_i3c_master_exit_halt(master);
+	}
 
 	ret = xfer->ret;
 	if (xfer->cmds[0].error == RESPONSE_ERROR_IBA_NACK)
@@ -782,7 +975,7 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	struct dw_i3c_xfer *xfer;
 	struct dw_i3c_cmd *cmd;
-	u32 olddevs, newdevs;
+	u32 olddevs, newdevs, sda_lvl_pre, sda_lvl_post;
 	u8 p, last_addr = 0;
 	int ret, pos;
 
@@ -825,9 +1018,21 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 		      COMMAND_PORT_TOC |
 		      COMMAND_PORT_ROC;
 
+	sda_lvl_pre = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+				readl(master->regs + PRESENT_STATE));
 	dw_i3c_master_enqueue_xfer(master, xfer);
-	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT)) {
+		dw_i3c_master_enter_halt(master, true);
 		dw_i3c_master_dequeue_xfer(master, xfer);
+		sda_lvl_post = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+					 readl(master->regs + PRESENT_STATE));
+		if (sda_lvl_pre == 0 && sda_lvl_post == 0) {
+			dev_warn(&master->base.dev,
+				 "SDA stuck low! Try to recover the bus...\n");
+			master->platform_ops->bus_recovery(master);
+		}
+		dw_i3c_master_exit_halt(master);
+	}
 
 	newdevs = GENMASK(master->maxdevs - cmd->rx_len - 1, 0);
 	newdevs &= ~olddevs;
@@ -835,6 +1040,16 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 	for (pos = 0; pos < master->maxdevs; pos++) {
 		if (newdevs & BIT(pos))
 			i3c_master_add_i3c_dev_locked(m, master->devs[pos].addr);
+
+		/* cleanup the free HW DATs */
+		if (master->free_pos & BIT(pos)) {
+			u32 dat = DEV_ADDR_TABLE_SIR_REJECT |
+				  DEV_ADDR_TABLE_MR_REJECT;
+
+			writel(dat,
+			       master->regs +
+			       DEV_ADDR_TABLE_LOC(master->datstartaddr, pos));
+		}
 	}
 
 	dw_i3c_master_free_xfer(xfer);
@@ -851,6 +1066,7 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	unsigned int nrxwords = 0, ntxwords = 0;
 	struct dw_i3c_xfer *xfer;
+	u32 sda_lvl_pre, sda_lvl_post;
 	int i, ret = 0;
 
 	if (!i3c_nxfers)
@@ -901,9 +1117,21 @@ static int dw_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 			cmd->cmd_lo |= COMMAND_PORT_TOC;
 	}
 
+	sda_lvl_pre = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+				readl(master->regs + PRESENT_STATE));
 	dw_i3c_master_enqueue_xfer(master, xfer);
-	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT)) {
+		dw_i3c_master_enter_halt(master, true);
 		dw_i3c_master_dequeue_xfer(master, xfer);
+		sda_lvl_post = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+					 readl(master->regs + PRESENT_STATE));
+		if (sda_lvl_pre == 0 && sda_lvl_post == 0) {
+			dev_warn(&master->base.dev,
+				 "SDA stuck low! Try to recover the bus...\n");
+			master->platform_ops->bus_recovery(master);
+		}
+		dw_i3c_master_exit_halt(master);
+	}
 
 	for (i = 0; i < i3c_nxfers; i++) {
 		struct dw_i3c_cmd *cmd = &xfer->cmds[i];
@@ -1002,6 +1230,7 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	struct dw_i3c_master *master = to_dw_i3c_master(m);
 	unsigned int nrxwords = 0, ntxwords = 0;
 	struct dw_i3c_xfer *xfer;
+	u32 sda_lvl_pre, sda_lvl_post;
 	int i, ret = 0;
 
 	if (!i2c_nxfers)
@@ -1021,6 +1250,12 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 	    nrxwords > master->caps.datafifodepth)
 		return -ENOTSUPP;
 
+	if (ntxwords == 0 && nrxwords == 0) {
+		dev_warn(&master->base.dev,
+			 "Transfers w/o data bytes are not supported");
+		return -EOPNOTSUPP;
+	}
+
 	xfer = dw_i3c_master_alloc_xfer(master, i2c_nxfers);
 	if (!xfer)
 		return -ENOMEM;
@@ -1048,9 +1283,21 @@ static int dw_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 			cmd->cmd_lo |= COMMAND_PORT_TOC;
 	}
 
+	sda_lvl_pre = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+				readl(master->regs + PRESENT_STATE));
 	dw_i3c_master_enqueue_xfer(master, xfer);
-	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT))
+	if (!wait_for_completion_timeout(&xfer->comp, XFER_TIMEOUT)) {
+		dw_i3c_master_enter_halt(master, true);
 		dw_i3c_master_dequeue_xfer(master, xfer);
+		sda_lvl_post = FIELD_GET(SDA_LINE_SIGNAL_LEVEL,
+					 readl(master->regs + PRESENT_STATE));
+		if (sda_lvl_pre == 0 && sda_lvl_post == 0) {
+			dev_warn(&master->base.dev,
+				 "SDA stuck low! Try to recover the bus...\n");
+			master->platform_ops->bus_recovery(master);
+		}
+		dw_i3c_master_exit_halt(master);
+	}
 
 	ret = xfer->ret;
 	dw_i3c_master_free_xfer(xfer);
@@ -1272,8 +1519,10 @@ static void dw_i3c_master_handle_ibi_sir(struct dw_i3c_master *master,
 	struct i3c_ibi_slot *slot;
 	struct i3c_dev_desc *dev;
 	unsigned long flags;
+	u32 state;
 	u8 addr, len;
 	int idx;
+	bool terminate_ibi = false;
 
 	addr = IBI_QUEUE_IBI_ADDR(status);
 	len = IBI_QUEUE_STATUS_DATA_LEN(status);
@@ -1316,6 +1565,7 @@ static void dw_i3c_master_handle_ibi_sir(struct dw_i3c_master *master,
 		dev_dbg_ratelimited(&master->base.dev,
 				    "IBI payload len %d greater than max %d\n",
 				    len, dev->ibi->max_payload_len);
+		terminate_ibi = true;
 		goto err_drain;
 	}
 
@@ -1331,6 +1581,9 @@ static void dw_i3c_master_handle_ibi_sir(struct dw_i3c_master *master,
 
 err_drain:
 	dw_i3c_master_drain_ibi_queue(master, len);
+	state = FIELD_GET(CM_TFR_STS, readl(master->regs + PRESENT_STATE));
+	if (terminate_ibi && state == CM_TFR_STS_MASTER_SERV_IBI)
+		master->platform_ops->gen_tbits_in(master);
 
 	spin_unlock_irqrestore(&master->devs_lock, flags);
 }
@@ -1343,15 +1596,30 @@ static void dw_i3c_master_irq_handle_ibis(struct dw_i3c_master *master)
 {
 	unsigned int i, len, n_ibis;
 	u32 reg;
+	int ret;
 
 	reg = readl(master->regs + QUEUE_STATUS_LEVEL);
 	n_ibis = QUEUE_STATUS_IBI_STATUS_CNT(reg);
 	if (!n_ibis)
 		return;
 
+	if (n_ibis > 16) {
+		dev_err(&master->base.dev,
+			"The n_ibis %d surpasses the tolerance level for the IBI buffer\n",
+			n_ibis);
+		goto ibi_fifo_clear;
+	}
+
 	for (i = 0; i < n_ibis; i++) {
 		reg = readl(master->regs + IBI_QUEUE_STATUS);
 
+		if (reg & IBI_QUEUE_STATUS_RSP_NACK) {
+			dev_dbg_ratelimited(&master->base.dev,
+					    "Nacked IBI from non-requested dev addr %02lx\n",
+					    IBI_QUEUE_IBI_ADDR(reg));
+			goto ibi_fifo_clear;
+		}
+
 		if (IBI_TYPE_SIRQ(reg)) {
 			dw_i3c_master_handle_ibi_sir(master, reg);
 		} else if (IBI_TYPE_HJ(reg)) {
@@ -1364,6 +1632,19 @@ static void dw_i3c_master_irq_handle_ibis(struct dw_i3c_master *master)
 			dw_i3c_master_drain_ibi_queue(master, len);
 		}
 	}
+
+	return;
+
+ibi_fifo_clear:
+	dw_i3c_master_enter_halt(master, true);
+	writel(RESET_CTRL_IBI_QUEUE, master->regs + RESET_CTRL);
+	ret = readl_poll_timeout_atomic(master->regs + RESET_CTRL, reg, !reg,
+					10, 1000000);
+	if (ret)
+		dev_err(&master->base.dev,
+			"Timeout waiting for IBI FIFO reset\n");
+
+	dw_i3c_master_exit_halt(master);
 }
 
 static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
@@ -1378,11 +1659,14 @@ static irqreturn_t dw_i3c_master_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	spin_lock(&master->xferqueue.lock);
-	dw_i3c_master_end_xfer_locked(master, status);
-	if (status & INTR_TRANSFER_ERR_STAT)
-		writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
-	spin_unlock(&master->xferqueue.lock);
+	if (status & INTR_RESP_READY_STAT ||
+	    status & INTR_TRANSFER_ERR_STAT) {
+		spin_lock(&master->xferqueue.lock);
+		dw_i3c_master_end_xfer_locked(master, status);
+		if (status & INTR_TRANSFER_ERR_STAT)
+			writel(INTR_TRANSFER_ERR_STAT, master->regs + INTR_STATUS);
+		spin_unlock(&master->xferqueue.lock);
+	}
 
 	if (status & INTR_IBI_THLD_STAT)
 		dw_i3c_master_irq_handle_ibis(master);
@@ -1439,11 +1723,70 @@ static void dw_i3c_platform_set_dat_ibi_nop(struct dw_i3c_master *i3c,
 {
 }
 
+static void dw_i3c_gen_target_reset_pattern_nop(struct dw_i3c_master *i3c)
+{
+}
+
+static void dw_i3c_gen_tbits_in_nop(struct dw_i3c_master *i3c)
+{
+}
+
+static int dw_i3c_bus_recovery_nop(struct dw_i3c_master *i3c)
+{
+	return 0;
+}
+
 static const struct dw_i3c_platform_ops dw_i3c_platform_ops_default = {
 	.init = dw_i3c_platform_init_nop,
 	.set_dat_ibi = dw_i3c_platform_set_dat_ibi_nop,
+	.gen_target_reset_pattern = dw_i3c_gen_target_reset_pattern_nop,
+	.gen_tbits_in = dw_i3c_gen_tbits_in_nop,
+	.bus_recovery = dw_i3c_bus_recovery_nop,
 };
 
+static int dw_i3c_of_populate_bus_timing(struct dw_i3c_master *master,
+					 struct device_node *np)
+{
+	u32 val, reg, sda_tx_hold_ns;
+
+	master->timing.core_rate = clk_get_rate(master->core_clk);
+	if (!master->timing.core_rate) {
+		dev_err(&master->base.dev, "core clock rate not found\n");
+		return -EINVAL;
+	}
+
+	/* core_period is in nanosecond */
+	master->timing.core_period =
+		DIV_ROUND_UP(1000000000, master->timing.core_rate);
+
+	/* Parse configurations from the device tree */
+	if (!of_property_read_u32(np, "i3c-pp-scl-hi-period-ns", &val))
+		master->timing.i3c_pp_scl_high = val;
+
+	if (!of_property_read_u32(np, "i3c-pp-scl-lo-period-ns", &val))
+		master->timing.i3c_pp_scl_low = val;
+
+	if (!of_property_read_u32(np, "i3c-od-scl-hi-period-ns", &val))
+		master->timing.i3c_od_scl_high = val;
+
+	if (!of_property_read_u32(np, "i3c-od-scl-lo-period-ns", &val))
+		master->timing.i3c_od_scl_low = val;
+
+	sda_tx_hold_ns = SDA_TX_HOLD_MIN * master->timing.core_period;
+	if (!of_property_read_u32(np, "sda-tx-hold-ns", &val))
+		sda_tx_hold_ns = val;
+
+	val = clamp((u32)DIV_ROUND_CLOSEST(sda_tx_hold_ns,
+					   master->timing.core_period),
+		    (u32)SDA_TX_HOLD_MIN, (u32)SDA_TX_HOLD_MAX);
+	reg = readl(master->regs + SDA_HOLD_SWITCH_DLY_TIMING);
+	reg &= ~SDA_TX_HOLD;
+	reg |= FIELD_PREP(SDA_TX_HOLD, val);
+	writel(reg, master->regs + SDA_HOLD_SWITCH_DLY_TIMING);
+
+	return 0;
+}
+
 static void dw_i3c_hj_work(struct work_struct *work)
 {
 	struct dw_i3c_master *master =
@@ -1456,6 +1799,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 			struct platform_device *pdev)
 {
 	const struct i3c_master_controller_ops *ops;
+	struct device_node *np;
 	int ret, irq;
 
 	if (!master->platform_ops)
@@ -1493,6 +1837,11 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	platform_set_drvdata(pdev, master);
 
+	np = pdev->dev.of_node;
+	ret = dw_i3c_of_populate_bus_timing(master, np);
+	if (ret)
+		goto err_assert_rst;
+
 	/* Information regarding the FIFOs/QUEUEs depth */
 	ret = readl(master->regs + QUEUE_STATUS_LEVEL);
 	master->caps.cmdfifodepth = QUEUE_STATUS_LEVEL_CMD(ret);
@@ -1514,6 +1863,8 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 	if (ret)
 		goto err_assert_rst;
 
+	dw_i3c_master_set_iba(master, true);
+
 	return 0;
 
 err_assert_rst:
diff --git a/drivers/i3c/master/dw-i3c-master.h b/drivers/i3c/master/dw-i3c-master.h
index 4ab94aa72252..4c41bbd6490a 100644
--- a/drivers/i3c/master/dw-i3c-master.h
+++ b/drivers/i3c/master/dw-i3c-master.h
@@ -58,6 +58,15 @@ struct dw_i3c_master {
 	/* platform-specific data */
 	const struct dw_i3c_platform_ops *platform_ops;
 
+	struct {
+		unsigned long core_rate;
+		unsigned long core_period;
+		u32 i3c_od_scl_low;
+		u32 i3c_od_scl_high;
+		u32 i3c_pp_scl_low;
+		u32 i3c_pp_scl_high;
+		u32 timed_reset_scl_low_ns;
+	} timing;
 	struct work_struct hj_work;
 };
 
@@ -78,6 +87,9 @@ struct dw_i3c_platform_ops {
 	 */
 	void (*set_dat_ibi)(struct dw_i3c_master *i3c,
 			    struct i3c_dev_desc *dev, bool enable, u32 *reg);
+	void (*gen_target_reset_pattern)(struct dw_i3c_master *i3c);
+	void (*gen_tbits_in)(struct dw_i3c_master *i3c);
+	int (*bus_recovery)(struct dw_i3c_master *i3c);
 };
 
 extern int dw_i3c_common_probe(struct dw_i3c_master *master,
-- 
2.25.1


