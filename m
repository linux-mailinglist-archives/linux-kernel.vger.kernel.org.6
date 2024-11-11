Return-Path: <linux-kernel+bounces-404188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB6A9C4068
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9682AB21420
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961B019F130;
	Mon, 11 Nov 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EcSaGMBb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GxuLtTHp"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982641A0737
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334300; cv=none; b=Hdc5Ls2Az450WHPpKy/d0qefDyj4Oi5V4ZUTTpgRvPGOMTsPI8JlRUfTY4fqE5xgl7gof5Kv296Hd8nyRQRp/9MmzTXNVd9MFj6Vt2w/WO4BfRWgwo1c9CIg1Smoafx6GmEbYuRipK3Gz20O2YIWzcPwomR1o88fvx35VqgRaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334300; c=relaxed/simple;
	bh=ITLTQe4IwIVfMF9vMHmkjHkFPbTvcSak1wsm0nCNqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN0P9kyGAJr4wnHr59Sph5GqK1RE/3vb59A8qUZwWKfSOyT6tEkhBGpSPdOZaT4ss6GzHSQY/TEjxIhfAp9W9M7FY3FtpUKuWM8vdMi/x1w/RkgtjBU1GXN6Fx+KCZw06kzlAShhWHkp06FOd7VrIRoACjYkFubnZ+d+xo3R/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EcSaGMBb; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GxuLtTHp reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731334298; x=1762870298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oCv9AlYEwKdYqm17u15TzBK9bW+nvaK/He+UnkJ6eow=;
  b=EcSaGMBblXOk0hhgFdNFLYU6DJego5DUx77lNSi1TZmYvLS7Es8Ee61l
   bppqKCfCNHhC9XbOrN2T1RlbWIHIAuSOYevrXTp/MShkhA9vuAzLJrh7S
   KWuR36H0IAPXQkygn3/pQwsE9H382w8FfZEV5Lk+1gyuo9ERRtwyRthW7
   hhy8Mz3ry9VWD0vQpIBjEj7IwWOf8spsEPt4l+nIwkY0AmLnfo5rNujeF
   dgcxhdy/sVdGfHFEZjiSa7Itl6uDtFVgC/zExLL2PZ6jWXMT2AcyHu5wG
   vstK+gexrSwezN0Ysffysk45vNW4ZlXAdS4Iwg/+uSkv8aBSCiCsj+qNt
   g==;
X-CSE-ConnectionGUID: Vkll+ek1TEyv5ptsUbyTJA==
X-CSE-MsgGUID: 5n/cIIAJQ+m2unzB+/RX/Q==
X-IronPort-AV: E=Sophos;i="6.12,145,1728943200"; 
   d="scan'208";a="39967040"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 11 Nov 2024 15:11:37 +0100
X-CheckPoint: {67321099-25-F5DC7025-F79421CB}
X-MAIL-CPID: 2BF4CDB44D290D73AE1164C742094A63_0
X-Control-Analysis: str=0001.0A682F24.6732109A.0045,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89DBD166E08;
	Mon, 11 Nov 2024 15:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731334293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCv9AlYEwKdYqm17u15TzBK9bW+nvaK/He+UnkJ6eow=;
	b=GxuLtTHpEptkkAif8bvKt5A0gavUAaqwZGIMI3D1S7ksGEx1i2Ki0jjspcISbIbGo3WoBP
	YOIbojCkY6+Eqxx7rW6fPTt6ACONSlAZCV2nGe2NpOZQLqtQXiNPYdWZbeHpPJlYrYf0/a
	KkBdRj5BmH+CRRcCI9ijM3HwEapBbOLfvvWTfesEarG/p+Fbc7cpfqNS1eo7srRadYY5z0
	wqh46st1l8g0SmeEovkNOnEqNL1ik4HXJU8O6m/vD58zuFNP+60hJYITZFs1F3SF7Nxmrb
	35NGw01yhCxZc0qfNEIgkSRXgehuuNFniWSw1MbVbEZts4AMGR9jyoj5Mu54rw==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v7 5/5] mfd: tqmx86: add I2C IRQ support
Date: Mon, 11 Nov 2024 15:10:32 +0100
Message-ID: <c1b0769e00a8a4e463cffe725e939b0e5c2992c8.1731325758.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Gregor Herburger <gregor.herburger@tq-group.com>

The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
Add a module parameter to allow configuring the IRQ number, similar to the
handling of the GPIO IRQ.

The new code and module parameter refer to the I2C controller as "I2C1",
as the TQMx86 PLD actually contains a second I2C controller, for which
driver support will be added in the future.

Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/mfd/tqmx86.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index d2704526f9d4b..1cba3b67b0fb9 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -50,6 +50,7 @@
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_I2C1_SHIFT	0
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -60,8 +61,19 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
-static const struct resource tqmx_i2c_soft_resources[] = {
-	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
+static uint i2c1_irq;
+module_param(i2c1_irq, uint, 0);
+MODULE_PARM_DESC(i2c1_irq, "I2C1 IRQ number (valid parameters: 7, 9, 12)");
+
+enum tqmx86_i2c1_resource_type {
+	TQMX86_I2C1_IO,
+	TQMX86_I2C1_IRQ,
+};
+
+static struct resource tqmx_i2c_soft_resources[] = {
+	[TQMX86_I2C1_IO] = DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
+	/* Placeholder for IRQ resource */
+	[TQMX86_I2C1_IRQ] = {},
 };
 
 static const struct resource tqmx_watchdog_resources[] = {
@@ -264,6 +276,13 @@ static int tqmx86_probe(struct platform_device *pdev)
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
 	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		if (i2c1_irq) {
+			err = tqmx86_setup_irq(dev, "I2C1", i2c1_irq, io_base,
+					       TQMX86_REG_IO_EXT_INT_I2C1_SHIFT);
+			if (!err)
+				tqmx_i2c_soft_resources[TQMX86_I2C1_IRQ] = DEFINE_RES_IRQ(i2c1_irq);
+		}
+
 		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					   tqmx86_i2c_soft_dev,
 					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


