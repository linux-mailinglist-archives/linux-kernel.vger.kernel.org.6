Return-Path: <linux-kernel+bounces-407556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 773729C6EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BDFC1F21A42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78B200BA2;
	Wed, 13 Nov 2024 12:18:59 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA51FF615
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500339; cv=none; b=UH0zXsuhDlB10seOI45gDm1r2LpIa0TVEDE0V1AwkfxOf5MqYZVQWto3FIDgvZNbSjN8DBxY/3i4f0PZbuNmYrhBo/SaMuSRIigbcc8dqpPwxetfbFaG+6jDovyF2ElsjVZUbbp8gPAgIvFosEqoYHdgIEsM9kK2TC6jCLMI0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500339; c=relaxed/simple;
	bh=CnC2sd8Oao1J21P/qBvL/HWz3WS+2cdCs0teDxRpgrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBY4CsfKV/oGjr/m4m5s5bEZOJzAlwswe/VHTSBmwgbvSHtyhrtlx9irRWTUL6MyM9bgULeLHhObgNmaAIl3PPUDzuEMlLjs4/59Pz2NwzhTOEY9bX+1YZUPn29t2J3GGAniMR4INLA4JSQB/vZ6/SvbAbqJfJay4aDAefdS3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1tBCKh-0004eO-1X; Wed, 13 Nov 2024 13:18:51 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Date: Wed, 13 Nov 2024 13:18:31 +0100
Subject: [PATCH v2 1/2] spi: imx: pass struct spi_transfer to
 prepare_transfer()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-imx-spi-word-delay-v2-1-2b65b737bf29@pengutronix.de>
References: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
In-Reply-To: <20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
Cc: kernel@pengutronix.de, linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2903; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=CnC2sd8Oao1J21P/qBvL/HWz3WS+2cdCs0teDxRpgrQ=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYkg3mak1i1f7ytH7a0ti4uuOuejpZicumPfx8m0ll3tKk
 Xfm2XSEd5SyMIhxMMiKKbLEqskpCBn7XzertIuFmcPKBDKEgYtTACaiocXIcEfhyL9uMTHn+rx3
 R0penPX/x5S+fp/K42uPDqpsKj/zYyHDH661AYLfInpPiV9lLGcJllM7lfCEuU/n2tW+2Sc6zJm
 +cQMA
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In an upcoming patch, mx51_ecspi_prepare_transfer() needs access to the
word_delay parameter. To enable controller-specific handling of such
per-transfer parameters, extend the prepare_transfer() function of the
spi_imx_devtype_data interface to take a struct spi_transfer argument,
update all controller-specific implementations accordingly.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 drivers/spi/spi-imx.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 85bd1a82a34eb4bc76a4b4528e087fc2ebfa8b85..65a8303b80b1191cd2c19d61f88836e7fd3c7ae9 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -71,7 +71,8 @@ struct spi_imx_data;
 struct spi_imx_devtype_data {
 	void (*intctrl)(struct spi_imx_data *spi_imx, int enable);
 	int (*prepare_message)(struct spi_imx_data *spi_imx, struct spi_message *msg);
-	int (*prepare_transfer)(struct spi_imx_data *spi_imx, struct spi_device *spi);
+	int (*prepare_transfer)(struct spi_imx_data *spi_imx, struct spi_device *spi,
+				struct spi_transfer *t);
 	void (*trigger)(struct spi_imx_data *spi_imx);
 	int (*rx_available)(struct spi_imx_data *spi_imx);
 	void (*reset)(struct spi_imx_data *spi_imx);
@@ -649,7 +650,7 @@ static void mx51_configure_cpha(struct spi_imx_data *spi_imx,
 }
 
 static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
-				       struct spi_device *spi)
+				       struct spi_device *spi, struct spi_transfer *t)
 {
 	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
 	u32 clk;
@@ -774,7 +775,7 @@ static int mx31_prepare_message(struct spi_imx_data *spi_imx,
 }
 
 static int mx31_prepare_transfer(struct spi_imx_data *spi_imx,
-				 struct spi_device *spi)
+				 struct spi_device *spi, struct spi_transfer *t)
 {
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_HOST;
 	unsigned int clk;
@@ -878,7 +879,7 @@ static int mx21_prepare_message(struct spi_imx_data *spi_imx,
 }
 
 static int mx21_prepare_transfer(struct spi_imx_data *spi_imx,
-				 struct spi_device *spi)
+				 struct spi_device *spi, struct spi_transfer *t)
 {
 	unsigned int reg = MX21_CSPICTRL_ENABLE | MX21_CSPICTRL_HOST;
 	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
@@ -953,7 +954,7 @@ static int mx1_prepare_message(struct spi_imx_data *spi_imx,
 }
 
 static int mx1_prepare_transfer(struct spi_imx_data *spi_imx,
-				struct spi_device *spi)
+				struct spi_device *spi, struct spi_transfer *t)
 {
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_HOST;
 	unsigned int clk;
@@ -1304,7 +1305,7 @@ static int spi_imx_setupxfer(struct spi_device *spi,
 		spi_imx->target_burst = t->len;
 	}
 
-	spi_imx->devtype_data->prepare_transfer(spi_imx, spi);
+	spi_imx->devtype_data->prepare_transfer(spi_imx, spi, t);
 
 	return 0;
 }

-- 
2.39.5


