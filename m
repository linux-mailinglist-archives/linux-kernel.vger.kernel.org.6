Return-Path: <linux-kernel+bounces-243211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B56929319
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 13:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC9AB22316
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A415DBB9;
	Sat,  6 Jul 2024 11:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="fZ3aorz2"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42BB158210
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720264925; cv=none; b=PWB8mKj+KHVOdYvEaenZoiYr+K8oqQQmDUWQcu/ojqdzLcDRUVK0wbYzWEcP3nXp2AcUSFF7Vj+YvqdfhT4LpA48QcbWWjYeUh1EjvtgIcioykTEZK30L0BPV2NkYLVRfWtobrJIVfyEZUPbM7Bz6Yxo8wgiYIAhx1Xbp2p8ZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720264925; c=relaxed/simple;
	bh=AVr8OD19xzmckBYHnS9TvD6yvY4gB56cNiw6JOoCwIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9amkTnni1PIqldJzwUkq54Jeqo1u6/hBsxAFvWXYJ5LhoZzAcvelOHoRMhTjQs55+1V1MkHX0GnsrQntY2/DCo69fM/5bzWLOHkom5rCR+1JSgiU6V1dTu7PZjdguGMtIg1h8WbVToMHpH24ZIv2LmE1NebRaBUYO88eLYhKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=fZ3aorz2; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=4SfqK3a3ab1W0iaWE9SHADzKqKu/0soHbCUAPyHoA7w=; b=fZ3aor
	z2AYi9bXR2+KD6x7oNaHAtybWU+78rTcYpFozktkP+fiTs7m9llAcALPM5+Sw0x6
	ImdgDAdO3womljU1sZTz43E8PlaVxCUVKctG2iAIUVMGGvUiKx3JBE7PoaxsS5M4
	CxbT5G9kKJlNIDUKSydyPuKCm8aB88qCJ0bj4/fmDbyGFxqvHrjxAZMCOLe9MmkT
	yK8g4Bi+IxJVEAm18oPzj8bjLSPUro4ONVP3AtMj5w0uaeLo/BtoK1htU3/gc1DK
	Djig+mldT3PPO2CtShpkIf1bB2zveaInE3imrWFCkyfIZgr/CJwoYMhb/sFj8qrP
	Io76D8V015HwKBMQ==
Received: (qmail 3810543 invoked from network); 6 Jul 2024 13:21:47 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 Jul 2024 13:21:47 +0200
X-UD-Smtp-Session: l3s3148p1@vZm8YpIcFsJQT+F6
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/60] i2c: owl: reword according to newest specification
Date: Sat,  6 Jul 2024 13:20:36 +0200
Message-ID: <20240706112116.24543-37-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
References: <20240706112116.24543-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the wording of this driver wrt. the newest I2C v7 and SMBus 3.2
specifications and replace "master/slave" with more appropriate terms.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-owl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index 777f1a0278c7..84a195e35886 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -172,7 +172,7 @@ static void owl_i2c_xfer_data(struct owl_i2c_dev *i2c_dev)
 
 	i2c_dev->err = 0;
 
-	/* Handle NACK from slave */
+	/* Handle NACK from target */
 	fifostat = readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT);
 	if (fifostat & OWL_I2C_FIFOSTAT_RNB) {
 		i2c_dev->err = -ENXIO;
@@ -302,7 +302,7 @@ static int owl_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg *msgs,
 			   OWL_I2C_CTL_IRQE, !atomic);
 
 	/*
-	 * Select: FIFO enable, Master mode, Stop enable, Data count enable,
+	 * Select: FIFO enable, controller mode, Stop enable, Data count enable,
 	 * Send start bit
 	 */
 	i2c_cmd = OWL_I2C_CMD_SECL | OWL_I2C_CMD_MSS | OWL_I2C_CMD_SE |
@@ -314,7 +314,7 @@ static int owl_i2c_xfer_common(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		i2c_cmd |= OWL_I2C_CMD_AS(msgs[0].len + 1) |
 			   OWL_I2C_CMD_SAS(1) | OWL_I2C_CMD_RBE;
 
-		/* Write slave address */
+		/* Write target address */
 		addr = i2c_8bit_addr_from_msg(&msgs[0]);
 		writel(addr, i2c_dev->base + OWL_I2C_REG_TXDAT);
 
@@ -420,9 +420,9 @@ static int owl_i2c_xfer_atomic(struct i2c_adapter *adap,
 }
 
 static const struct i2c_algorithm owl_i2c_algorithm = {
-	.master_xfer	     = owl_i2c_xfer,
-	.master_xfer_atomic  = owl_i2c_xfer_atomic,
-	.functionality	     = owl_i2c_func,
+	.xfer = owl_i2c_xfer,
+	.xfer_atomic = owl_i2c_xfer_atomic,
+	.functionality = owl_i2c_func,
 };
 
 static const struct i2c_adapter_quirks owl_i2c_quirks = {
-- 
2.43.0


