Return-Path: <linux-kernel+bounces-423731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 852DA9DABFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FD7B24832
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA0F20110B;
	Wed, 27 Nov 2024 16:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="YbwGJoKI"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DDE2010E2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725890; cv=none; b=tr4xIwr5zXM/AWF6aB3cs/2nwTfE1G9t43r4jeKGczscxiphNOnH3TK7ZiFPd89UX1pnBkhoC06o17J6hUaj67BC2sNwfCA7osjfUid2MHvIOD9Rq6LI/dSDFjyFKFJJrzvGkIhDBtcCeHpQXOguqB2c9nY7Fa2DwL/uiyoUUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725890; c=relaxed/simple;
	bh=d996Pb4grSMymj8iX4YrCnnfv31zNoY9lRlxym/+8yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6yIJocD0hqCF+l4uuSMiU4qkWXsU4cwpYAbhUbrKxZ6NAXj4h4ZlWwwv71zN3S9t9ytnTm6LtUZCde9RawBIe35VpN9NBKWVHtoyO0dkdLu7vzmoosalXXVBKTOOyLL4Sc4vcVjVtQv97RZqZORLL12Cx99HJEpXbhlfzlwP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=YbwGJoKI; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F404BFB96;
	Wed, 27 Nov 2024 17:44:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1732725887; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AxOVFaaTtf3vqrp1NbSGzCrsRokoNNo20iMlzSXj/hw=;
	b=YbwGJoKIUvNDlJNRQkanxrXcaqQ4B34YnRbJw4V3kacSCu1AzoBxBMaS6Hpkbfh225avgM
	cP/JEPgUeMtfSxRZPfDTLRlfiMQGBhOYP8DFVtMUjZg5auNiURv9CPoc5zR4dncRj11LJL
	hZBG2oPPyjad2OaOl/0zP0iQMRgKYmRwu7DUXFhDVE1wG41VdiBRLiehAmTsHDmtm9VY2G
	LQ0syTDiKnuqVFsfHH8ZEVULp/5DdSHZwiTzeR22Nlgp1q6C3Fp2lmeFdS/6qLEtJ9miq1
	fpundE7b/DKanTPwKKPh6XCNqtXkuAkH1AbY904c/setcNm0iOKM5yBAihfG5A==
From: Frieder Schrempf <frieder@fris.de>
To: linux-arm-kernel@lists.infradead.org,
	Marek Vasut <marex@denx.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Bo Liu <liubo03@inspur.com>,
	Joy Zou <joy.zou@nxp.com>
Subject: [PATCH v2 08/11] regulator: pca9450: Handle hardware with fixed SD_VSEL for LDO5
Date: Wed, 27 Nov 2024 17:42:24 +0100
Message-ID: <20241127164337.613915-9-frieder@fris.de>
In-Reply-To: <20241127164337.613915-1-frieder@fris.de>
References: <20241127164337.613915-1-frieder@fris.de>
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
Changes for v2:
* new patch
---
 drivers/regulator/pca9450-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 7f7e176bef452..6024de9656e8e 100644
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
 
@@ -1084,6 +1088,9 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	pca9450->sd_vsel_fixed_low =
+		of_property_read_bool(ldo5->dev.of_node, "nxp,sd-vsel-fixed-low");
+
 	dev_info(&i2c->dev, "%s probed.\n",
 		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
 		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
-- 
2.46.1


