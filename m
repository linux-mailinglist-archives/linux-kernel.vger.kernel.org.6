Return-Path: <linux-kernel+bounces-400196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA89C0A31
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AF6283644
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22020213EC7;
	Thu,  7 Nov 2024 15:35:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9A212D0C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993737; cv=none; b=sep+MJiCVsG/WkHZiDWmVluX4FyuEgiCEgw8fkZcW6SIU1uXtJAKh+Q+FISf8qVc/wfn7truIb69cT9VxkdXFSqHHpMNkzEeasmikOVulm1oEuO8PSfIVAIX57AEzbP8qeCrKIqq6aHtAmF/Ab1SZ2u6E3HTJqAGDZAtafxVNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993737; c=relaxed/simple;
	bh=CnC2sd8Oao1J21P/qBvL/HWz3WS+2cdCs0teDxRpgrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cI04242knuYz5/959NLueMc639Vp0CKeS2+oUoGP/9+6gOdTULN8arwYZDcTKO/Wo2T8GICvDVbQyyu37452UCT1iPRqS1BDq3CJeMc3UQZWJJULWbTm40TpgzvdUH3VTBINqkMihncyPYZLXwddpRfe8xYwTZ3Dxm1A7WPStv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1t94Xf-0005DD-RL; Thu, 07 Nov 2024 16:35:27 +0100
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 07 Nov 2024 16:35:20 +0100
Subject: [PATCH 1/2] spi: imx: pass struct spi_transfer to
 prepare_transfer()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-imx-spi-word-delay-v1-1-2a969214d796@pengutronix.de>
References: <20241107-imx-spi-word-delay-v1-0-2a969214d796@pengutronix.de>
In-Reply-To: <20241107-imx-spi-word-delay-v1-0-2a969214d796@pengutronix.de>
To: Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
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


