Return-Path: <linux-kernel+bounces-278997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D4B94B77E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36FD1F22798
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4D19005E;
	Thu,  8 Aug 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jmr0MYli"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01018FC88;
	Thu,  8 Aug 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101128; cv=none; b=V/VsQr+PI5QmWoq1KVRKzDvrheGBpdt2fNfoTqZRcka4nBmCDw3TX0KyhDJkp6dMSNI6Tbmac68HFtnuKzxO7iOwOfiZqt/MWn7wG4uiwIdbsRC0UZ6eXKzawfc89qWHn9g8o6bfKoQYPLi++hpNCaO6AVylsjSwW1Otw4SfBRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101128; c=relaxed/simple;
	bh=1URSoTxl3MWQkIrQVad7ptbdWpjD1dNAjVS+N8fSBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P17UAPAMwk998txqy5Yncz2iNQIW/VFyY+6Chrsip8dtIBqc/9qOcuzIGswwRxw5CpAeEme7LiIBaKMLZHdN8VdojVfia9ptWkmIsc8d+/4d88O49AH7/0XMDfnp02g2AltatK4UUDB9G5cfnHHnf6G0vsMZWNN3O8n1QVxDyXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jmr0MYli; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id E7346C000C;
	Thu,  8 Aug 2024 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhTeQjFFrgyyEBB/vjj0ndtfSFCTyBhsv6uo4yMAh0Y=;
	b=jmr0MYli9sbNQDvQYczkA/Hd3gJsK1Hd3Raafmpgh3CQ+OGJqEsqtjY2c96ZMhkOkD/Fal
	A0TVWJPuH9Gx6cYdBawhndvygWDdC4bJKXBQvboyboZ5TLewxYGO3Tw0p8DXqd+oXhr+pZ
	J6j3gQS38wZltqiFYLxS9HTHpIPozTTjpmFpBUsY40Scml7gPm2I7qtu1/jaVM6ZyUvHQY
	006VoipCz9bvNgpVF/Sw/vnSTjpRdwlZte8W/iyiz9DhY6da8cmiztjkONNVT7xwINKlWX
	o7nY10inn7ULuB+sIq0VhKkYSGzGBrzCrJVQyvl/ly+kWWMvbd7pfX413hQfGQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Zhao <qiang.zhao@nxp.com>,
	Li Yang <leoyang.li@nxp.com>,
	Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 35/36] soc: fsl: cpm1: qmc: Handle QUICC Engine (QE) soft-qmc firmware
Date: Thu,  8 Aug 2024 09:11:28 +0200
Message-ID: <20240808071132.149251-36-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240808071132.149251-1-herve.codina@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

The QUICC Engine (QE) QMC can use a firmware to have the QMC working in
'soft-qmc' mode.

Handle this optional 'soft-qmc' firmware.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 67 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index b3a9534441ee..3dffebb48b0d 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -10,6 +10,7 @@
 #include <soc/fsl/qe/qmc.h>
 #include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
+#include <linux/firmware.h>
 #include <linux/hdlc.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -1649,6 +1650,66 @@ static irqreturn_t qmc_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+static int qmc_qe_soft_qmc_init(struct qmc *qmc, struct device_node *np)
+{
+	struct qe_firmware_info *qe_fw_info;
+	const struct qe_firmware *qe_fw;
+	const struct firmware *fw;
+	const char *filename;
+	int ret;
+
+	ret = of_property_read_string(np, "fsl,soft-qmc", &filename);
+	switch (ret) {
+	case 0:
+		break;
+	case -EINVAL:
+		/* fsl,soft-qmc property not set -> Simply do nothing */
+		return 0;
+	default:
+		dev_err(qmc->dev, "%pOF: failed to read fsl,soft-qmc\n",
+			np);
+		return ret;
+	}
+
+	qe_fw_info = qe_get_firmware_info();
+	if (qe_fw_info) {
+		if (!strstr(qe_fw_info->id, "Soft-QMC")) {
+			dev_err(qmc->dev, "Another Firmware is already loaded\n");
+			return -EALREADY;
+		}
+		dev_info(qmc->dev, "Firmware already loaded\n");
+		return 0;
+	}
+
+	dev_info(qmc->dev, "Using firmware %s\n", filename);
+
+	ret = request_firmware(&fw, filename, qmc->dev);
+	if (ret) {
+		dev_err(qmc->dev, "Failed to request firmware %s\n", filename);
+		return ret;
+	}
+
+	qe_fw = (const struct qe_firmware *)fw->data;
+
+	if (fw->size < sizeof(qe_fw->header) ||
+	    be32_to_cpu(qe_fw->header.length) != fw->size) {
+		dev_err(qmc->dev, "Invalid firmware %s\n", filename);
+		ret = -EINVAL;
+		goto end;
+	}
+
+	ret = qe_upload_firmware(qe_fw);
+	if (ret) {
+		dev_err(qmc->dev, "Failed to load firmware %s\n", filename);
+		goto end;
+	}
+
+	ret = 0;
+end:
+	release_firmware(fw);
+	return ret;
+}
+
 static int qmc_cpm1_init_resources(struct qmc *qmc, struct platform_device *pdev)
 {
 	struct resource *res;
@@ -1855,6 +1916,12 @@ static int qmc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (qmc_is_qe(qmc)) {
+		ret = qmc_qe_soft_qmc_init(qmc, np);
+		if (ret)
+			return ret;
+	}
+
 	/* Parse channels informationss */
 	ret = qmc_of_parse_chans(qmc, np);
 	if (ret)
-- 
2.45.0


