Return-Path: <linux-kernel+bounces-288045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2D0953229
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D7B232B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE11A08CB;
	Thu, 15 Aug 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXzjbCfV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317D71A0710;
	Thu, 15 Aug 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730512; cv=none; b=bX1HnEMZQCDZTNwKpsWDJ5Vq/cU1352zRCMWDNrlzYijRacC1zP0k8czFJdY8M2lCioBUZWOV+wrC3iDMkgLbDMxvWLs4cI5Qj5DNA9zKMEjUOzzpYpiq6iBd2Xwe1RQlmd5XT7shwv+VgSfHRteRmmv2R3bvqDZuGTY7pX2Wvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730512; c=relaxed/simple;
	bh=NOz0Uv8wGGzTdwwKAO9HS5pRf+gFIIXkiQP/tdo821A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvJE5HHmG6SCvzqGwYxzXBQW/N7pjdDZMd3ebCIsPyDEUYICLiwp+aIrVy2uM6Q8rJV/2PeHZXSAwN0SyOAaU0i2ghGzKLDU95ANQxmw+V9uVOSJ7OapfQWEUV7ykB6KYKD0s2KBVHYXAXJs3j5GsOJq3fZp+Rl670AZF4hHBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXzjbCfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B74EC4AF12;
	Thu, 15 Aug 2024 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723730512;
	bh=NOz0Uv8wGGzTdwwKAO9HS5pRf+gFIIXkiQP/tdo821A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXzjbCfVMQI43SWYiP1/vltNgziBil/v7r9ulr7An346+FEcO6XuyFl32fkuTafQk
	 i1s62y2vOA06ukgnyd5/03EA2rPqnewVcuQZBUTaUYeLmNkS4NwkuXkz5BzTlzpXPM
	 REf4GMPb3vGse+cXF/6fKQ0yade6+8EKkP3YlXLcdegbU06WV4HsDk6QHTsX1Dsgcw
	 xQPrqckPpGWxCiHOo1Rzy1KB8Tmd/YitkPlMAavOA5MoycvvPUI4cbeo56OZIW3xXX
	 PifnqGz1YGTNWA1ZPN2PIkmB7HSk/MZC9LBdcNpxqyJy9B2L5YmWtNlRWt0DvItCZA
	 KGsqb4TxKBnuQ==
From: Conor Dooley <conor@kernel.org>
To: devicetree@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/11] mailbox: mpfs: support fixed binding (TODO: always use regmap)
Date: Thu, 15 Aug 2024 15:01:06 +0100
Message-ID: <20240815-vantage-clambake-5923706562a8@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-shindig-bunny-fd42792d638a@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4296; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=N2EYlHnPdpSTmBB5yWHl6UOJ2EHCrvSsT03RsLJC+eE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGn7uHT2fWNPF7vY7XHr2/H4y0dC5l60+T+599btOQZ+/ DMsLkSXdpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiyskM/2On9xyXmZjvIV5+ LdjqbuPE59v8XrMF3lh6/IHntt8e2h6MDFtNp3T+1t5w9oYlY+5Htozrl1k37p1+svff3L3zI6r yNbgA
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
 drivers/mailbox/mailbox-mpfs.c | 45 +++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
index 0fd83bdd4cee..65aa466ffe8b 100644
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
 
@@ -231,6 +250,23 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
 	if (!mbox)
 		return -ENOMEM;
 
+	mbox->control_scb = syscon_regmap_lookup_by_compatible("microchip,mpfs-control-scb");
+	if (IS_ERR(mbox->control_scb)) {
+		mbox->control_scb = NULL;
+		goto old_format;
+	}
+
+	mbox->sysreg_scb = syscon_regmap_lookup_by_compatible("microchip,mpfs-sysreg-scb");
+	if (IS_ERR(mbox->sysreg_scb))
+		return -1;
+
+	mbox->mbox_base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
+	if (IS_ERR(mbox->ctrl_base))
+		return PTR_ERR(mbox->mbox_base);
+
+	goto done;
+
+old_format:
 	mbox->ctrl_base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(mbox->ctrl_base))
 		return PTR_ERR(mbox->ctrl_base);
@@ -243,6 +279,7 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
 	if (IS_ERR(mbox->mbox_base)) // account for the old dt-binding w/ 2 regs
 		mbox->mbox_base = mbox->ctrl_base + MAILBOX_REG_OFFSET;
 
+done:
 	mbox->irq = platform_get_irq(pdev, 0);
 	if (mbox->irq < 0)
 		return mbox->irq;
-- 
2.43.0


