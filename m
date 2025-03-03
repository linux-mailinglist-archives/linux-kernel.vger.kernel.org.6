Return-Path: <linux-kernel+bounces-545217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1289BA4EA66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A9916B317
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201C3202C53;
	Tue,  4 Mar 2025 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fris.de header.i=@fris.de header.b="cTHRFPUC"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E36250C16
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109881; cv=fail; b=sbBiQQHj/fQfK0p+oRRZBB/9MOpzWnnnaHLgVp2iOq9B61Z/voicC5KsZmzUB89O2SwBiXV2xg4iYWX2ZheAJpZdiUEu1M3GxoEehVmTzYilOw50ODE9mYOstAi2WYf/emGddWYDccb0Zc/NcJtzwAAzhurb8ZB0448udIDRlDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109881; c=relaxed/simple;
	bh=sRs+4S/gLJ7xnkCNVK2MMAjZJvx6EcAWXs4mmk+OBiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CCAU5jrZUsDyAPN4WY1Fmq3KeQEXTyeldIKSNA8cb0GNBhaK7JaluCMwgsdE+STTDLxmRK8NcupfV/9VfqjrOO09MdVG50CH9CwrdaXN/j6AzwwmKBGLyz1FyRgvDvoQ7gwEHav5Bw26gW+kIE+bKuV/lv2Lmcj4a4f29NjxIbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=fris.de header.i=@fris.de header.b=cTHRFPUC reason="signature verification failed"; arc=none smtp.client-ip=116.203.77.234; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id A804F408B640
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:37:56 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g9W1y81zG1c5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:49:51 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 19A2E4271F; Tue,  4 Mar 2025 18:49:47 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fris.de header.i=@fris.de header.b=cTHRFPUC
X-Envelope-From: <linux-kernel+bounces-541811-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fris.de header.i=@fris.de header.b=cTHRFPUC
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 975274201E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:30:43 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 6E1E7305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:30:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CC91894182
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7FC211A15;
	Mon,  3 Mar 2025 13:30:18 +0000 (UTC)
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g9W1y81zG1c5
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714562.39631@y3SzkZzivKQPfZQwHL0wWA
X-ITU-MailScanner-SpamCheck: not spam

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

[1] https://patchwork.kernel.org/project/linux-arm-kernel/cover/202412181=
52842.97483-1-frieder@fris.de/
---
---
 drivers/regulator/pca9450-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pc=
a9450-regulator.c
index 8f81d813640d..a56f3ab754fa 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -36,6 +36,7 @@ struct pca9450 {
 	enum pca9450_chip_type type;
 	unsigned int rcnt;
 	int irq;
+	bool sd_vsel_fixed_low;
 };
=20
 static const struct regmap_range pca9450_status_range =3D {
@@ -102,6 +103,9 @@ static unsigned int pca9450_ldo5_get_reg_voltage_sel(=
struct regulator_dev *rdev)
 {
 	struct pca9450 *pca9450 =3D rdev_get_drvdata(rdev);
=20
+	if (pca9450->sd_vsel_fixed_low)
+		return PCA9450_REG_LDO5CTRL_L;
+
 	if (pca9450->sd_vsel_gpio && !gpiod_get_value(pca9450->sd_vsel_gpio))
 		return PCA9450_REG_LDO5CTRL_L;
=20
@@ -1100,6 +1104,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c=
)
 		return ret;
 	}
=20
+	pca9450->sd_vsel_fixed_low =3D
+		of_property_read_bool(ldo5->dev.of_node, "nxp,sd-vsel-fixed-low");
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type =3D=3D PCA9450_TYPE_PCA9450A ? "pca9450a" :
 		(type =3D=3D PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
--=20
2.48.1


