Return-Path: <linux-kernel+bounces-265918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7D993F7B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CB31C219C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7118786D;
	Mon, 29 Jul 2024 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ou+Rt7bI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAA1862A9;
	Mon, 29 Jul 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262893; cv=none; b=LmNPk7m+K1jnip1Wta5A8YNj9KS/+rwE38VnH29DdK9pMCUQYBeKNxEcO8sIXUWyDio4+WvbalveyJP5YYpfD45/QtA4HBOh2inmff2Qcnk+eizm+Q/BzolD113HcSacMvDhpnoNktYZBkyGzP0eoITCpiErEynUKb4rBQHEY4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262893; c=relaxed/simple;
	bh=EfqIxpeHcxquG/A6osWSWsmqDV5LJmj/1Fp0aeEDa5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNDXLIgnnOt+nyi8c/B1wO46HtBLT1ORgmWNTbDHCu4QJKWnIccSW31QtIXPr2jeBeoPU7Avch3O4smDwOpbmy6wyHKQvOLVelNsfIzTYTwgUrbXv6Dwhgqw18oyHdSGuZM493/nVTS6+k1crbgPozt9JvVoUGSSiwR0WLHZKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ou+Rt7bI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id CD458240002;
	Mon, 29 Jul 2024 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722262890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvpSGkwLO+E6MOzmOnoPAe/sppi5mCag/x8MKSW8BQ8=;
	b=Ou+Rt7bI8I3SxCvhwt/hrnWJHz5TAmU7OouVUtnRVrZzwmv/p2ueIDzrFiTzw3OXLnrUZq
	l0HClrTqVPbvkFOaRkFY1vv7l9udUXCCI/wscCeKjcrjTcY12mKF1nLjML76JY4/BZF5W9
	MEzP08FvDn8LFBaD9hxhd4v2NTE9zDvGYDXFv4bH6YaF8ylG3ZuZcaPobT8YyWi5L0dvgy
	6VjeZNaK18rYXZt2xOakpCZmz0TgU3S/upfld+xkJl3zD04CjNYnBW9jAS9gHQs3dMUFb7
	dNBGII68Jioi52KwGFb4M2ExAtfk2m9hP9BRdaf0j6trslB6lV/x7jLwaBdORw==
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
Subject: [PATCH v1 21/36] soc: fsl: cpm1: qmc: Fix 'transmiter' typo
Date: Mon, 29 Jul 2024 16:20:50 +0200
Message-ID: <20240729142107.104574-22-herve.codina@bootlin.com>
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

checkpatch.pl raises the following issue
  CHECK: 'transmiter' may be misspelled - perhaps 'transmitter'?

Indeed, fix it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index 04466e735302..2d54d7400d2d 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1715,7 +1715,7 @@ static int qmc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_disable_intr;
 
-	/* Enable transmiter and receiver */
+	/* Enable transmitter and receiver */
 	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 
 	platform_set_drvdata(pdev, qmc);
@@ -1742,7 +1742,7 @@ static void qmc_remove(struct platform_device *pdev)
 {
 	struct qmc *qmc = platform_get_drvdata(pdev);
 
-	/* Disable transmiter and receiver */
+	/* Disable transmitter and receiver */
 	qmc_setbits32(qmc->scc_regs + SCC_GSMRL, 0);
 
 	/* Disable interrupts */
-- 
2.45.0


