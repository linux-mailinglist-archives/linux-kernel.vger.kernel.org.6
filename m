Return-Path: <linux-kernel+bounces-394715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BF69BB319
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C1D28268A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7AA1B21BC;
	Mon,  4 Nov 2024 11:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="LgHEW3oB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Ff7kdpZj"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FABE1D63C9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730718871; cv=none; b=jtrBT2fqRtLCcIGct9HbX/CO/urlOEaVBnoqTeriWq7VJ72h1w1shUdpLoKK2PgYLYqqVx+cNPSq6OdfFPnHVVa05fD/7knyHBbP1x8+tVsCm3HCsqjSGf1V16g6vtnGq9cNMGlO3G+y3mnMc0/HoNXv2mULXiwnQdD4cffvcfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730718871; c=relaxed/simple;
	bh=+beHcLgIUxi1Mim/HpZ7JvNMEbOcqwsEDzqXNpU79HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGeMJuY1+wKTaUk03riPWNmWw0cyg0HoxE6UrHAMuyhe7T9FHR74L7brAxcDIKh3osiMg3rIZ75jM3Y7xB+1sXEUeb9o6SmtP13kYuf7KEszDkajf/te1vdZKZ+arPZa9p5a8D8riWe+HLPTszZCuTRruPRCQl8ShG45+tqjuuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=LgHEW3oB; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Ff7kdpZj reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730718869; x=1762254869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+LOrG+TF2iFIuOL/HdJ+hGmYA88dTXTNReBNAUuqr8=;
  b=LgHEW3oBEbIYBzk7HtaPlRdzSSyoM+jxE7X7I6WIgFw39hr4pNN04nJ/
   NjbXsAiho/0Ykax6n3Ca9hQi7B1yRzeh4eQw2Y308vBpZEl/PCwOtUYCP
   i7Ur91173Sgb6w6L9EUihWw9SQx8XR95RpQT1OuEsvBBn31199xEDkCaC
   NxEEDke7xxrCOWqos4obrtEZmdslv4OEm4JYokXwglkqKdveuxLVMyvjY
   nvuEaS7HI3J/Qaz7+DB3ZFzt7HEbTxlGR4RethRpea1RGWtMjxbFuTK9b
   eOn1n7wbBCS43h7tmAy1QWWgauWA5VxH6sZjtYMC3b8/ekAqrAdCoHgyf
   A==;
X-CSE-ConnectionGUID: wG47SwRMSA2Dv74JbDAVog==
X-CSE-MsgGUID: gSai7tf1RAywTdTMNR2yOg==
X-IronPort-AV: E=Sophos;i="6.11,256,1725314400"; 
   d="scan'208";a="39829949"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Nov 2024 12:14:26 +0100
X-CheckPoint: {6728AC8F-11-D31EDE1A-D52D6119}
X-MAIL-CPID: BD26B7E974B5E2AC6AA67F8F74B77F4C_5
X-Control-Analysis: str=0001.0A682F19.6728AC93.0058,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 475C116A08F;
	Mon,  4 Nov 2024 12:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730718859;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=w+LOrG+TF2iFIuOL/HdJ+hGmYA88dTXTNReBNAUuqr8=;
	b=Ff7kdpZjaZkt9rZgwIrY9Au9wGoXSPOIlXKHKvlJP7aCoA0dPy4uPCaU+aFN17AEjfdAfi
	IPgGXBYLPiI4o7xaHy5fBvWQSKc2byunC9lRhSeXjKuHArJbxXz7aFnQs/c2esUxo6ttvk
	z0N3YcWS8+AGgQHikwq5lB1G1QfAjOMCbBgtqCK6Pym1thFvysaZ8xWFrcB5bmz/DSjz0X
	PfJpQGYkbhk+Z5bQIa5XV1kIYrddP9KU+kVWf0zksumKJCfT9+abMSmmdyOxG6suSjW8iJ
	A6b9itREox++YTp1ObdRGuJJgF3DQ13URBst0pQ0praEdfRMXry8uXW5oZeifg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v6 5/5] mfd: tqmx86: add I2C IRQ support
Date: Mon,  4 Nov 2024 12:13:33 +0100
Message-ID: <db981ff0a5c4f5cae898e6cd4ffcc530e5b09ba8.1730717841.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1730717841.git.matthias.schiffer@ew.tq-group.com>
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
Add module parameter to allow configuring the IRQ number, similar to the
handling of the GPIO IRQ.

The new code and module parameter refer to the I2C controller as "I2C1",
as the TQMx86 PLD actually contains a second I2C controller, for which
driver support will be added in the future.

Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: improve module parameter description (was patch 4/4)
v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
v4: no changes
v5: move placeholder to the end of the resource array, use define for index
v6:
  - remove obsolete comment
  - refer to I2C controller as "I2C1"

 drivers/mfd/tqmx86.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 1fd2212bf492c..7dd971b762578 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -50,6 +50,7 @@
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_I2C1_SHIFT	0
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -60,11 +61,18 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
+static uint i2c1_irq;
+module_param(i2c1_irq, uint, 0);
+MODULE_PARM_DESC(i2c1_irq, "I2C1 IRQ number (valid parameters: 7, 9, 12)");
+
 /* Index of IRQ placeholder in resource list */
 #define TQMX86_IRQ_GPIO 1
+#define TQMX86_IRQ_I2C1 1
 
-static const struct resource tqmx_i2c_soft_resources[] = {
+static struct resource tqmx_i2c_soft_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
+	/* Placeholder for IRQ resource - filled in by the probe function */
+	[TQMX86_IRQ_I2C1] = {},
 };
 
 static const struct resource tqmx_watchdog_resources[] = {
@@ -262,6 +270,13 @@ static int tqmx86_probe(struct platform_device *pdev)
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
 	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		if (i2c1_irq) {
+			err = tqmx86_setup_irq(dev, "I2C1", i2c1_irq, io_base,
+					       TQMX86_REG_IO_EXT_INT_I2C1_SHIFT);
+			if (!err)
+				tqmx_i2c_soft_resources[TQMX86_IRQ_I2C1] = DEFINE_RES_IRQ(i2c1_irq);
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


