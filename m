Return-Path: <linux-kernel+bounces-265926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A9C93F7C4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A606DB21092
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0D218C354;
	Mon, 29 Jul 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ab63qm3S"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA74189F55;
	Mon, 29 Jul 2024 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262899; cv=none; b=N99tan+wFkqAhpn7MQiiIEHur3EnFM4yBrAfbDlOInMt1jPSc8CMUlvySrgyRvepG0ERY3JjFR4Dpne8rqtZpkwO681Zao4+RskAev+LWDkcLEy3TRNcq2noZjvMTk1vsfRWT87SQCwkbNe5th1hAm/49oEOXjHeDg3YUw0tTzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262899; c=relaxed/simple;
	bh=f/hrRqpvgSWR7o8SqjfiRErULoXGgJxRx/Q8mSLYBh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVXr6POxHlq0ER5ZiwxgBhqEMqBM+p7yKKzdROEsFOJxPgNTMl72yIKHdwss9BqX2zFy1ZSfa8rhTrckwwFtTatXvsYCHkkY2Yiu+GgWZRBFC1X/LGpT07KsQrG8UKX7ZyZ7JAJFPgDorWe047AvdS+0plIdbKZzJZTufmXNNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ab63qm3S; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id CEE8B240009;
	Mon, 29 Jul 2024 14:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrOLWiN4Z4gUXHz3D+P5LAM+sQ2zdU0ZhJY0pukQIhM=;
	b=ab63qm3SgdCprnyo4hXCO7oG8HathVoPoFQp5BU4mqmZ0XJ1rT24AcMYSdCFbfWwPiBm8P
	kTUwQDK528dd/GbwgyCYQGkjHI6lSHtEi5xLcGQdYNmv5YMREf3bZXdb5mt78gjJ9+ivEW
	BO9PLzsSLAGi0vCKGLaYhx3XZcC0bhyti6Qw6wcOVUEEy4GmjUzG3jSpWZpZHwLSIypXq8
	fsLZcRfH9bHvaUMm92R9uSE2TVswmti9EnWHna/3U/VTN3rLLb6FhJci80qU9c5rGWFcfb
	vtdd6bKEYYwVaCAuRT+bp/dbRV44K1CkLrLzMmtF/j0XxOIlil3BPO46rd3enw==
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
Subject: [PATCH v1 28/36] soc: fsl: cpm1: qmc: Rename qmc_chan_command()
Date: Mon, 29 Jul 2024 16:20:57 +0200
Message-ID: <20240729142107.104574-29-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240729142107.104574-1-herve.codina@bootlin.com>
References: <20240729142107.104574-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Current code handles CPM1 version of QMC and qmc_chan_command() is
clearly CPM1 specific.

In order to prepare the support for the QUICC Engine (QE) version,
rename qmc_chan_command() to reflect that point.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index b95227378f97..272da250a763 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -794,7 +794,7 @@ static int qmc_chan_setup_tsa_rx(struct qmc_chan *chan, bool enable)
 	return qmc_chan_setup_tsa_32rx(chan, &info, enable);
 }
 
-static int qmc_chan_command(struct qmc_chan *chan, u8 qmc_opcode)
+static int qmc_chan_cpm1_command(struct qmc_chan *chan, u8 qmc_opcode)
 {
 	return cpm_command(chan->id << 2, (qmc_opcode << 4) | 0x0E);
 }
@@ -813,7 +813,7 @@ static int qmc_chan_stop_rx(struct qmc_chan *chan)
 	}
 
 	/* Send STOP RECEIVE command */
-	ret = qmc_chan_command(chan, 0x0);
+	ret = qmc_chan_cpm1_command(chan, 0x0);
 	if (ret) {
 		dev_err(chan->qmc->dev, "chan %u: Send STOP RECEIVE failed (%d)\n",
 			chan->id, ret);
@@ -850,7 +850,7 @@ static int qmc_chan_stop_tx(struct qmc_chan *chan)
 	}
 
 	/* Send STOP TRANSMIT command */
-	ret = qmc_chan_command(chan, 0x1);
+	ret = qmc_chan_cpm1_command(chan, 0x1);
 	if (ret) {
 		dev_err(chan->qmc->dev, "chan %u: Send STOP TRANSMIT failed (%d)\n",
 			chan->id, ret);
-- 
2.45.0


