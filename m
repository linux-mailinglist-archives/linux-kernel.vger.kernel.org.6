Return-Path: <linux-kernel+bounces-238983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B11925475
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25371F24C95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDEC136982;
	Wed,  3 Jul 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gDY8nuV8"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794F130488
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990998; cv=none; b=fUTFHgF5zLQ8KZ2JUMsjoWfZzxiKoPR4gykWaxGzdEm6Jsko5MTCbah3owTR6enqrwuit6ed7XZppu4h7y99cKgR5Ykr5WdI16Uj7pjAhfvgNKrOHf87OYBoRp5CXgBl19S7FJO96wU65KG7/jc+F1sgENRrOBoH5rOuhRIWW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990998; c=relaxed/simple;
	bh=KTDcWsE7q4CAGrggP1GbK428gemPHQuwGvTGjC4cR9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lO9GkTRLQnyNiPuYyS7Rf/DyEnFA01p9IolINNpIPe1OSjUkmy0v3mWS4GJJH8X/wqmIS0Ss7eZkhFpFsW2NCnoettB9mYYyc+JrfBnsijPPeVt3+uEFJ7X6pjGYIdaWla2FZT9ggznsGwgdnwvUovg96qzqgQ4dDhWUT98Uw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gDY8nuV8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=3YHgR2kPNRh6LD
	6XnaVo+nlQknMU0QRGpA7uAzZVuBs=; b=gDY8nuV8rZhIxJHTHPkdNHFsOmkRiR
	6KMji7NU9ODVPWP9ByB4CKCHwTA4wTY+SkuhsFG459pr6Pbne0C4Lu3EeMysjkqy
	cSKnAi6WtcC7L5v5mMd2l/0v9W7REa63RO9z/4wNBrVedG6gq98mBuOtjd9L64Tj
	cgHHqTUqoQVRS6bQwMXOKBewGiQdUKlmxC++QwPh/d5ISDXyhc95ZSCUPULAjiqX
	2zHkFD9HN3Aa8+PvSKa5mVJZIs2VaNrbH5TDCeYF/30S/GVg7bOemSAIjjZZO0TO
	ShPxqS8hW0N4hSfnhbbIeTURDIG0C5q+it1oQG1GTB+Qw3aRjoUpJS6A==
Received: (qmail 2715603 invoked from network); 3 Jul 2024 09:16:32 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Jul 2024 09:16:32 +0200
X-UD-Smtp-Session: l3s3148p1@Zq8ZnFIcBK9ehhrb
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] i2c: rcar: bring hardware to known state when probing
Date: Wed,  3 Jul 2024 09:12:03 +0200
Message-ID: <20240703071625.5389-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probably due to a lot of refactorization, the hardware was not brought
into a known state in probe. This may be a problem when a hypervisor
restarts Linux without resetting the hardware, leaving an old state
running. Make sure the hardware gets initialized, especially interrupts
should be cleared and disabled.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/r/20240702045535.2000393-1-dirk.behme@de.bosch.com
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Here is my proposal to fix the issue reported by Dirk. Build tested.
I can do proper testing on HW only tomorrow. But so you know already...

It is strange to add another "_slave" function to the driver while I
work on removing such language from I2C somewhere else. "Consistency" is
the answer here. The driver will be converted as well. But then as a
whole.

 drivers/i2c/busses/i2c-rcar.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 828aa2ea0fe4..00a885205075 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -257,6 +257,14 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 	}
 }
 
+static void rcar_i2c_init_slave(struct rcar_i2c_priv *priv)
+{
+	rcar_i2c_write(priv, ICSIER, 0);
+	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_write(priv, ICSCR, SDBS);
+	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+}
+
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
 {
 	int ret;
@@ -1033,11 +1041,8 @@ static int rcar_unreg_slave(struct i2c_client *slave)
 
 	/* ensure no irq is running before clearing ptr */
 	disable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSIER, 0);
-	rcar_i2c_write(priv, ICSSR, 0);
+	rcar_i2c_init_slave(priv);
 	enable_irq(priv->irq);
-	rcar_i2c_write(priv, ICSCR, SDBS);
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
 	priv->slave = NULL;
 
@@ -1152,7 +1157,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		goto out_pm_disable;
 	}
 
-	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
+	/* Bring hardware to known state */
+	rcar_i2c_init(priv);
+	rcar_i2c_init_slave(priv);
 
 	if (priv->devtype < I2C_RCAR_GEN3) {
 		irqflags |= IRQF_NO_THREAD;
-- 
2.43.0


