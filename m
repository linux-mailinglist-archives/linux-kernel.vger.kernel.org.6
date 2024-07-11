Return-Path: <linux-kernel+bounces-248818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFBF92E263
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6721C2170A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E015B15D;
	Thu, 11 Jul 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="akx8IgIN"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29915A865
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686658; cv=none; b=GHlsC1IwNp6obKJ+/fiWd6HdT7W9avrEQpQOBgEZfp9/rRziE7PpF9ALonNgzDDefoaC5hz+kyJtP40mjw0pLoPUwkYcRmmHL/63GQx3sy0CmuXnch6cK6TVvXukCfHSwCK9sZY4HfB4/rt1jpcF3N3BZR+W/TXrTeletOnPhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686658; c=relaxed/simple;
	bh=GNnb2pMEpLCZWuU8exB1G4Ok1i/56wOMag9mtFIm49I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iXmDhe2hcR+K/ebnGqEGUKcFxD96MGVJQCd7AQONdIOL57UMChosu8xFkg0K81i59UItPNZWKgBIrjreHwuZnuBdqcUPQN0IIZTVPz0gWkJXLTEWMMylFUKWblKQWbUSt9H3BpHw7OKxuEqZ5hTbr8n35UhhbvTFhubTvZO1dRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=akx8IgIN; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=P+uBeegXTfrwt6
	z+MKaVDcauEQ2cMUwbT1jXu03xNsk=; b=akx8IgINx6+frcTynwYHGUMx3B3S/B
	6ccUemnF+1fVjBblUeDVehwjMuW/h7tnSgoIq/EUmu4Oc7dpAkuqnsOy/Hb09sps
	+QejBZW8wHdMGxZs8Topwla9ASdY7RvkNv0Q3YpBWi+en+utY/y2IhW+NoJ0Zi7s
	WWSI2y8jTResX39Sx/Y9+tUWNUPY9i6VSnDvdcXtBm0HZnn/r7P+voEGijpjWn8w
	USBSS02d/m2VxyL4JdOg4syIJDbrE71yjaQazLLnsm+VNz8CyiZBY1VpQTi68hXr
	iOx2Lc1rQKN82y4iBSmygSgD7wDOKR2xmARP7atm3FHvg1FWZ1H7E7YQ==
Received: (qmail 777695 invoked from network); 11 Jul 2024 10:30:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jul 2024 10:30:52 +0200
X-UD-Smtp-Session: l3s3148p1@0iKxlPQcOoQgAwDPXwmZAIsFIv4n+Dpm
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: rcar: ensure Gen3+ reset does not disturb local targets
Date: Thu, 11 Jul 2024 10:30:44 +0200
Message-ID: <20240711083043.8334-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car Gen3+ needs a reset before every controller transfer. That erases
configuration of a potentially in parallel running local target
instance. To avoid this disruption, avoid controller transfers if a
local target is running. Also, disable SMBusHostNotify because it
requires being a controller and local target at the same time.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 8f2ede534f30..29cbeda59f3e 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -884,6 +884,10 @@ static int rcar_i2c_do_reset(struct rcar_i2c_priv *priv)
 {
 	int ret;
 
+	/* Don't reset if a slave instance is currently running */
+	if (priv->slave)
+		return -EISCONN;
+
 	ret = reset_control_reset(priv->rstc);
 	if (ret)
 		return ret;
@@ -1176,6 +1180,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (of_property_read_bool(dev->of_node, "smbus"))
 		priv->flags |= ID_P_HOST_NOTIFY;
 
+	/* R-Car Gen3+ needs a reset before every transfer */
 	if (priv->devtype >= I2C_RCAR_GEN3) {
 		priv->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 		if (IS_ERR(priv->rstc)) {
@@ -1186,6 +1191,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		ret = reset_control_status(priv->rstc);
 		if (ret < 0)
 			goto out_pm_put;
+
+		/* hard reset disturbs HostNotify local target, so disable it */
+		priv->flags &= ~ID_P_HOST_NOTIFY;
 	}
 
 	ret = platform_get_irq(pdev, 0);
-- 
2.43.0


