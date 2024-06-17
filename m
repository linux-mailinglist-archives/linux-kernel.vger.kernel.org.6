Return-Path: <linux-kernel+bounces-217294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB490ADE3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31DE31F21C42
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3D2195FC7;
	Mon, 17 Jun 2024 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fwTHWlDa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="g4K2zHoA"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA99195FC9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627066; cv=none; b=BeQTqEIu0b2jMYmVsvGL9H82ECuyZp7nL4jWn1/+Ft10ZOOBaADt36ApUdNzMuPI/dSnWA3D78DTUr8N3ytmLHTh6zPW8d7BYD72SJufAZjWRZbR/UQNBaAHm/WGsn88yaRn+431YRkX5UpY9+v/tpuS3RXtbQAElFBaIIXBnPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627066; c=relaxed/simple;
	bh=dkMDNulLc5a3KLXLaG9NTS/W6BS8iK9znwy1GGRProY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gox7uTjCiGsWjGvUz6tBvbFUlNieLnQE2jo4TnIIr2G7v34SXAHqldHshuqM7AVXb1uNCc/TO+Kr0sW3tf+Lb/Q+iHdxjCdsnsEhFpynpxsutOdJH+2yru4feVTDYmOX9JUaDUFDViR0xiYA1gSdcQrtE9YKkAjXi3Z3UPkP0n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=fwTHWlDa; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=g4K2zHoA reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718627064; x=1750163064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1DWb/EiOwYhJRYZ8QlGi2CNp9bjqfMiLLHh4hpYPFWY=;
  b=fwTHWlDai6fhRFNxg5aUL7acCM8uSSOJ8i1L/EQ296j0xm8/DGVZjYWk
   O6qX9ti+37E1A67eTbL8/vM7/yjzD//jWjxMJrYCuOJQXITtJJITZTEYh
   YjpNtxMZOuIcoj3V7sHCu7bUVt3Fr++Zhhkkil+vKHePaPP2KVun9CDUt
   9T3OYqHEJiDDF1gWQYRj1zJa2PTteI/+ZGgiDuodaYtsdMw/5GNNaCv0X
   PQIDpRk/WbCtp5bGSvfH9kpuHrBPnRflxAxF6E8DD9nZzyJj19Adq6Xy2
   tX3mfbFsC+Cn9A9Xqy6THw11t4LxdKIwdVeUw12xkNWU6Wuf219/jbkTW
   A==;
X-CSE-ConnectionGUID: +LhNIslwQOiSnbUIsBIBGA==
X-CSE-MsgGUID: S6MTshiITkikvpWnRSPZhQ==
X-IronPort-AV: E=Sophos;i="6.08,244,1712613600"; 
   d="scan'208";a="37427062"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 17 Jun 2024 14:24:23 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 13931165A62;
	Mon, 17 Jun 2024 14:24:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718627059;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1DWb/EiOwYhJRYZ8QlGi2CNp9bjqfMiLLHh4hpYPFWY=;
	b=g4K2zHoAZe44J/CHAJxXu7T6W4h8Qg/VnXzmT/r8JcqkJeYTderXB1FhvapwGh+fdhjzkK
	z922+oekovB31wuWsCsirI1ZJLHpfdpOTE3n/xH7gmvtVDsxYxZSILuxDcIZTYHesW0pTe
	IpS7ixmQIRzSwjaNSDwjRwtd4bz3NPholsCHyz7qcsSswUJ6eAgmJUx0aSUsaVG4lXMxyg
	OFtGKwF37RvvpSJ8TY/oZxemVIg2KnAiPzMpvd48vltXVQhXeowdnhmQqbYfI+Abl5YL19
	x0kSBufWcURXfGL4EbtPJbAnDBHaxag4SROyAZI5OiM93uYi3EJ/VxTtArqzDA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 5/5] mfd: tqmx86: add I2C IRQ support
Date: Mon, 17 Jun 2024 14:23:02 +0200
Message-ID: <b6cc921b24dbe8c2272528c23b683e1180a7234a.1718626665.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
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

Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: improve module parameter description (was patch 4/4)

 drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 7f9ccd83278dd..dcd5fa3e18c50 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -50,6 +50,7 @@
 #define TQMX86_REG_IO_EXT_INT_9			2
 #define TQMX86_REG_IO_EXT_INT_12		3
 #define TQMX86_REG_IO_EXT_INT_MASK		0x3
+#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
 #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
 #define TQMX86_REG_SAUC		0x17
 
@@ -60,7 +61,12 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
-static const struct resource tqmx_i2c_soft_resources[] = {
+static uint i2c_irq;
+module_param(i2c_irq, uint, 0);
+MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)");
+
+static struct resource tqmx_i2c_soft_resources[] = {
+	DEFINE_RES_IRQ(0),
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
 };
 
@@ -271,6 +277,18 @@ static int tqmx86_probe(struct platform_device *pdev)
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
 
 	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
+		if (i2c_irq) {
+			err = tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
+					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
+			if (err)
+				i2c_irq = 0;
+		}
+
+		if (i2c_irq)
+			tqmx_i2c_soft_resources[0].start = i2c_irq;
+		else
+			tqmx_i2c_soft_resources[0].flags = 0;
+
 		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
 					   tqmx86_i2c_soft_dev,
 					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


