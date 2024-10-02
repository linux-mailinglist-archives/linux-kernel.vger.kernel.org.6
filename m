Return-Path: <linux-kernel+bounces-347355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712B98D199
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F61284CAF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5A20010F;
	Wed,  2 Oct 2024 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT6FcBm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7CC1E766D;
	Wed,  2 Oct 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866101; cv=none; b=YaOxmk6Xj7Hacw4cLMpLjs2E9crZVWhNgJWppuIvAzWD+FdZQlxfs46v4jegLuJb2IByhoPi5TCmAZNd7vDCWWYrefOAJDwKR2fBjIY/mTNbFSzZGGp5RLBo35qoX8z9H7ITg8ao1gWhC2HQ9BGECoWVyRPIpAVqgjJ9ZbKHuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866101; c=relaxed/simple;
	bh=Cx6+Xr1oArOwHT6p6fGbh9KrLTS+vwUt4nrqGVAT8z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njpQl+i0Huz45PxARXDHi2WOBwMLUtlmw2lFCXCfrQOSJNO8igT2/xvFeyQ9kwa30Vxeh5pBUyanueoTUFbg6Z36nzPrNqiZBKjkJp9THlhCdx1GY9GVlo25wqOc6nWCD+beVPKdIGjPJHWfaVBGw66ySRT3UY8yhT2SilsYa3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT6FcBm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2395CC4CEC5;
	Wed,  2 Oct 2024 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727866100;
	bh=Cx6+Xr1oArOwHT6p6fGbh9KrLTS+vwUt4nrqGVAT8z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mT6FcBm+9NPas0k19bmjFgo4pekonLTMebgeSQLTomYODQ9ItjiLn/SR0g+BfHVgb
	 Zo3xYCsBnH6FmANCbXNNF6QjoQKYfFVr1kRviUd+5LHbrnemLFvYcdBTTcjb4ef9wE
	 tTK1k4JFcYqsuQs+45qxZbzcuirI3Pkm+we+laYm/XrG8yCGI1dGjIEeRT8z6zpxaT
	 VO0kj3EbemoK/30qON4gEdd2e7l9jl9Q2HsEQEfbDznsKG4UVoTGirZFrGLDsV9N+A
	 fmb4Rwx4qfHchdB2NAndzljctxUZPqvFIw9o4o/rs70owmpdm0Qx4mc+kOO0n5rLuS
	 hnNJkgfplAWAQ==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	pierre-henry.moussay@microchip.com,
	valentina.fernandezalanis@microchip.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 02/11] mailbox: mpfs: support new, syscon based, devicetree configuration
Date: Wed,  2 Oct 2024 11:48:00 +0100
Message-ID: <20241002-elated-emit-6302c32557c0@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002-private-unequal-33cfa6101338@spud>
References: <20241002-private-unequal-33cfa6101338@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6215; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=c/sHcacLDgEtukJOKU2YjxEWf026tjRvMuKbrhVqPno=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGl/VR7wHYx+eTHzaqTK3Rq33578O/zWlH7se2hwxPtnp skHv80VHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIghzDH25B/o2T/KM6pznI eprcrtfmveKccO9xheqnNzZ35u40y2BkWJxZrbvv/ZorAQ7xy1RnTrkmePDLGfMdCaVGtT1TRGL cGAA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The two previous bindings for this hardware were incorrect, as the
control/status and interrupt register regions should have been described
as syscons and dealt with via regmap in the driver. Add support for
accessing these registers using that method now, so that the hwmon
driver can be supported without using auxdev or hacks with io_remap().

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/mailbox/Kconfig        |  1 +
 drivers/mailbox/mailbox-mpfs.c | 87 +++++++++++++++++++++++++++-------
 2 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 6fb995778636a..f856e01429aae 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -168,6 +168,7 @@ config MAILBOX_TEST
 config POLARFIRE_SOC_MAILBOX
 	tristate "PolarFire SoC (MPFS) Mailbox"
 	depends on HAS_IOMEM
+	depends on MFD_SYSCON
 	depends on ARCH_MICROCHIP_POLARFIRE || COMPILE_TEST
 	help
 	  This driver adds support for the PolarFire SoC (MPFS) mailbox controller.
diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 20ee283a04cc6..4df546e3b7eae 100644
--- a/drivers/mailbox/mailbox-mpfs.c
+++ b/drivers/mailbox/mailbox-mpfs.c
@@ -13,12 +13,15 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/regmap.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/mailbox_controller.h>
 #include <soc/microchip/mpfs.h>
 
+#define MESSAGE_INT_OFFSET		0x18cu
 #define SERVICES_CR_OFFSET		0x50u
 #define SERVICES_SR_OFFSET		0x54u
 #define MAILBOX_REG_OFFSET		0x800u
@@ -68,6 +71,7 @@ struct mpfs_mbox {
 	void __iomem *int_reg;
 	struct mbox_chan chans[1];
 	struct mpfs_mss_response *response;
+	struct regmap *sysreg_scb, *control_scb;
 	u16 resp_offset;
 };
 
@@ -75,7 +79,10 @@ static bool mpfs_mbox_busy(struct mpfs_mbox *mbox)
 {
 	u32 status;
 
-	status = readl_relaxed(mbox->ctrl_base + SERVICES_SR_OFFSET);
+	if (mbox->control_scb)
+		regmap_read(mbox->control_scb, SERVICES_SR_OFFSET, &status);
+	else
+		status = readl_relaxed(mbox->ctrl_base + SERVICES_SR_OFFSET);
 
 	return status & SCB_STATUS_BUSY_MASK;
 }
@@ -95,7 +102,11 @@ static bool mpfs_mbox_last_tx_done(struct mbox_chan *chan)
 	 * Failed services are intended to generated interrupts, but in reality
 	 * this does not happen, so the status must be checked here.
 	 */
-	val = readl_relaxed(mbox->ctrl_base + SERVICES_SR_OFFSET);
+	if (mbox->control_scb)
+		regmap_read(mbox->control_scb, SERVICES_SR_OFFSET, &val);
+	else
+		val = readl_relaxed(mbox->ctrl_base + SERVICES_SR_OFFSET);
+
 	response->resp_status = (val & SCB_STATUS_MASK) >> SCB_STATUS_POS;
 
 	return true;
@@ -143,7 +154,12 @@ static int mpfs_mbox_send_data(struct mbox_chan *chan, void *data)
 
 	tx_trigger = (opt_sel << SCB_CTRL_POS) & SCB_CTRL_MASK;
 	tx_trigger |= SCB_CTRL_REQ_MASK | SCB_STATUS_NOTIFY_MASK;
-	writel_relaxed(tx_trigger, mbox->ctrl_base + SERVICES_CR_OFFSET);
+
+	if (mbox->control_scb)
+		regmap_write(mbox->control_scb, SERVICES_CR_OFFSET, tx_trigger);
+	else
+		writel_relaxed(tx_trigger, mbox->ctrl_base + SERVICES_CR_OFFSET);
+
 
 	return 0;
 }
@@ -185,7 +201,10 @@ static irqreturn_t mpfs_mbox_inbox_isr(int irq, void *data)
 	struct mbox_chan *chan = data;
 	struct mpfs_mbox *mbox = (struct mpfs_mbox *)chan->con_priv;
 
-	writel_relaxed(0, mbox->int_reg);
+	if (mbox->control_scb)
+		regmap_write(mbox->sysreg_scb, MESSAGE_INT_OFFSET, 0);
+	else
+		writel_relaxed(0, mbox->int_reg);
 
 	mpfs_mbox_rx_data(chan);
 
@@ -221,28 +240,62 @@ static const struct mbox_chan_ops mpfs_mbox_ops = {
 	.last_tx_done = mpfs_mbox_last_tx_done,
 };
 
+static inline int mpfs_mbox_syscon_probe(struct mpfs_mbox *mbox, struct platform_device *pdev)
+{
+	mbox->control_scb = syscon_regmap_lookup_by_compatible("microchip,mpfs-control-scb");
+	if (IS_ERR(mbox->control_scb))
+		return PTR_ERR(mbox->control_scb);
+
+	mbox->sysreg_scb = syscon_regmap_lookup_by_compatible("microchip,mpfs-sysreg-scb");
+	if (IS_ERR(mbox->sysreg_scb))
+		return PTR_ERR(mbox->sysreg_scb);
+
+	mbox->mbox_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mbox->ctrl_base))
+		return PTR_ERR(mbox->mbox_base);
+
+	return 0;
+}
+
+static inline int mpfs_mbox_old_format_probe(struct mpfs_mbox *mbox, struct platform_device *pdev)
+{
+	dev_warn(&pdev->dev, "falling back to old devicetree format");
+
+	mbox->ctrl_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mbox->ctrl_base))
+		return PTR_ERR(mbox->ctrl_base);
+
+	mbox->int_reg = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(mbox->int_reg))
+		return PTR_ERR(mbox->int_reg);
+
+	mbox->mbox_base = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(mbox->mbox_base)) // account for the old dt-binding w/ 2 regs
+		mbox->mbox_base = mbox->ctrl_base + MAILBOX_REG_OFFSET;
+
+	return 0;
+}
+
 static int mpfs_mbox_probe(struct platform_device *pdev)
 {
 	struct mpfs_mbox *mbox;
-	struct resource *regs;
 	int ret;
 
 	mbox = devm_kzalloc(&pdev->dev, sizeof(*mbox), GFP_KERNEL);
 	if (!mbox)
 		return -ENOMEM;
 
-	mbox->ctrl_base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
-	if (IS_ERR(mbox->ctrl_base))
-		return PTR_ERR(mbox->ctrl_base);
-
-	mbox->int_reg = devm_platform_get_and_ioremap_resource(pdev, 1, &regs);
-	if (IS_ERR(mbox->int_reg))
-		return PTR_ERR(mbox->int_reg);
-
-	mbox->mbox_base = devm_platform_get_and_ioremap_resource(pdev, 2, &regs);
-	if (IS_ERR(mbox->mbox_base)) // account for the old dt-binding w/ 2 regs
-		mbox->mbox_base = mbox->ctrl_base + MAILBOX_REG_OFFSET;
-
+	ret = mpfs_mbox_syscon_probe(mbox, pdev);
+	if (ret) {
+		/*
+		 * set this to null, so it can be used as the decision for to
+		 * regmap or not to regmap
+		 */
+		mbox->control_scb = NULL;
+		ret = mpfs_mbox_old_format_probe(mbox, pdev);
+		if (ret)
+			return ret;
+	}
 	mbox->irq = platform_get_irq(pdev, 0);
 	if (mbox->irq < 0)
 		return mbox->irq;
-- 
2.45.2


