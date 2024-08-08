Return-Path: <linux-kernel+bounces-278990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EDB94B76F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014681F22334
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B2018EFDA;
	Thu,  8 Aug 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZM06mKVk"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF2818E03F;
	Thu,  8 Aug 2024 07:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101123; cv=none; b=QcMGAa3i4naWwhJKK2eiEOU3+jX6gDfJzQiv76erNhE7GoENVDcOwPOme06Eqm5AJ7GAehg2KZBKcs5pL6m59XZxt+re3J00qNF0/irVAq24kOJ7cF6bb1qwoflRr/3now9+2K2U+RrPBjWyPFr0YE26jxG8MviJWlB4gY/MxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101123; c=relaxed/simple;
	bh=f/hrRqpvgSWR7o8SqjfiRErULoXGgJxRx/Q8mSLYBh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4Obi3CX62SlYm4UpaQ4wGzn20BotFYP850vo1b2lEu/5mwL/j8uE4paARXhiSD9+NP2ZiRWuGAgEdDnU2l32GnfQ7NrILi6IKm2wv76nmPOLiDz18Zklj7xRFS/Z6gJjy+nAMQO6xaHxmH7vghdWYsp9ofF9/NUhpAEsm0Cnw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZM06mKVk; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 8B277C000E;
	Thu,  8 Aug 2024 07:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723101120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrOLWiN4Z4gUXHz3D+P5LAM+sQ2zdU0ZhJY0pukQIhM=;
	b=ZM06mKVkWxip8jeTHbTGOzVT2AN+OnEHd+U/xXElUS450tiav/PKKlL8o0hDfhKS70RkxJ
	0J2M8fMrkf89VgA46ppnyJV08EMTU/FAR1lOTgjw4ND/w8E3WuyGAYwjta74BltWxU0ob3
	NuLpdCDdAGrWY+Z8/pJ/TzjfRHPPPkzStEegwqkdeEA3d4HKz+nKLDAuNDE/1w4szjq+eA
	DFmurRVc+dC0qfA8T2I8r9SHKSV/A6pj3iRsf5RmNqQkW4/wfRMF4rRIf6DuHSF5zYIK2s
	VwHnRHlLdc3qAC+lYbxRc1N2wg6xGfWFVeVwJuKIzePWACmgvORFyPrp5u0+wA==
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
Subject: [PATCH v2 28/36] soc: fsl: cpm1: qmc: Rename qmc_chan_command()
Date: Thu,  8 Aug 2024 09:11:21 +0200
Message-ID: <20240808071132.149251-29-herve.codina@bootlin.com>
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


