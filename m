Return-Path: <linux-kernel+bounces-541811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D3DA4C1E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD013AA24C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197BA78F32;
	Mon,  3 Mar 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="cTHRFPUC"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398A35CDF1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008615; cv=none; b=TxduqQ/1TtwJXxAXzHc+jiUJeEOGCbnXHeQQF9j/2lCkd2UDY11owO6Eq6GhHL8mFj5Nph9mGYBq77c3ha7hcW+ZFwgPDDVJD9UOhe4mEMFoVR23qlEIgcFJKXGgfiZK+mazwEHG7ha12sJP+Hb6x7sIcgnQ5amlA4NHQy25X0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008615; c=relaxed/simple;
	bh=27k9PY93t8tqudCjHh3c5c3Elf9YBdFndls+poK3PJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdfZRmRmyBGqDonIxf2x35YG6cT1trjjOx+P2r8UzNPlWkZmZ0lJtw8bWJoUOGQr0Ba1IcUudI7KK0w43moZDfrdvM7Ig9TpsIaR3hUuxyem1sBLJSWPnrG5Or/odzTJ0rDwDX/pSwBLKe+aJqQXgTqs3kB0Oimu6OlhDIhFNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=cTHRFPUC; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2A4FBFB6A;
	Mon,  3 Mar 2025 14:23:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1741008204; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ytag+vUn1YOAY7Tv+GjF5B1jzcAOw0B2REY/Qu/aUug=;
	b=cTHRFPUCljYtWPPD51NPpSneH3cw1vuMO7E0wdjg2BCkCAAl/vtK2rAvtxU1ZA/O3RDg7E
	P0m22GIrd5s8aY+ZqXbAAzKrfOH6b1DvysS1svZ4uqtNuLp52wD+/ITB3Kvz5FaBiJnpkS
	vAUHZSMR+hBZI/Ojb18tkzqBewNhdEXQpjDZIZ33gKr+r+nb693V+HPgcLT6aeXTo9f07b
	Pbp3+JbzyrzXeEqE0gDDAssvTtM5kKRgDMLZLl7kDrj6tKrKA0483qfQL3AUEhlJOcRNCN
	Q5BtQdmP4Yxeew82r41HR3Of7CDpdiSMgOzKaCzU01HhgX63+WWZm8B+Ng28bg==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bo Liu <liubo03@inspur.com>,
	Frank Li <Frank.Li@nxp.com>,
	Joy Zou <joy.zou@nxp.com>,
	Robin Gong <yibin.gong@nxp.com>
Subject: [RESEND PATCH v3] regulator: pca9450: Handle hardware with fixed SD_VSEL for LDO5
Date: Mon,  3 Mar 2025 14:22:54 +0100
Message-ID: <20250303132258.50204-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There are two ways to set the output voltage of the LD05
regulator. First by writing to the voltage selection registers
and second by toggling the SD_VSEL signal.

Usually board designers connect SD_VSEL to the VSELECT signal
controlled by the USDHC controller, but in some cases the
signal is hardwired to a fixed low level (therefore selecting
3.3V as initial value for allowing to boot from the SD card).

In these cases, the voltage is only determined by the value
of the LDO5CTRL_L register. Introduce a property
nxp,sd-vsel-fixed-low to let the driver know that SD_VSEL
is low and there is no GPIO to actually get that
information from dynamically.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
This was originally part of the series here: [1]. The other patches
were already applied, but this one is missing in regulator/for-next
and linux-next, which is why I'm resending.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20241218152842.97483-1-frieder@fris.de/
---
---
 drivers/regulator/pca9450-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 8f81d813640d..a56f3ab754fa 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -36,6 +36,7 @@ struct pca9450 {
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
+	bool sd_vsel_fixed_low;
 };
 
 static const struct regmap_range pca9450_status_range = {
@@ -102,6 +103,9 @@ static unsigned int pca9450_ldo5_get_reg_voltage_sel(struct regulator_dev *rdev)
 {
 	struct pca9450 *pca9450 = rdev_get_drvdata(rdev);
 
+	if (pca9450->sd_vsel_fixed_low)
+		return PCA9450_REG_LDO5CTRL_L;
+
 	if (pca9450->sd_vsel_gpio && !gpiod_get_value(pca9450->sd_vsel_gpio))
 		return PCA9450_REG_LDO5CTRL_L;
 
@@ -1100,6 +1104,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	pca9450->sd_vsel_fixed_low =
+		of_property_read_bool(ldo5->dev.of_node, "nxp,sd-vsel-fixed-low");
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
 		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
-- 
2.48.1

