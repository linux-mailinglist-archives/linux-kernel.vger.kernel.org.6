Return-Path: <linux-kernel+bounces-374199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D732F9A66AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A8A1F22632
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEF41EABA4;
	Mon, 21 Oct 2024 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="acFq7zXa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="kb/yu5C3"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944811E9088
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729510511; cv=none; b=fvpM9OrrHNGeMbJ9Wzw2Rujc66WhmHnxeXu7sVTp69jp4LyUWOh18xi07XmTpujzaeh3Sh4G2Y6zUydOAXG5BWSEsoPasOZbHoJuv06FmMiU6rfwaCj9gRTq1L6+ey1F6ZhWTLV5E2lkERx3fV/1A6a+5CVxrKc8I60XFxy/mUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729510511; c=relaxed/simple;
	bh=fRVRaBwlJZbv50zfC2PPH76a//MtJAkMe+p9jYxgtLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c7fD8JP8h3e5fZdGQHPPXe7t1No4kdRugSkbBHoDRJwO14Eu+kznY20AVznEzWt6yzIPCYgnrpDX/x4fYA0ECrL0BaOlZalt+lwblRZob3FcqOSfTtq6a1cHdRhjldwBDe5E/K6tqKOcpLvNXAvvCBOXzLberokCqrsXHfKzP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=acFq7zXa; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=kb/yu5C3 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729510508; x=1761046508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yn7P9s9yfLjz2aH1iQX9Xxev1nS9eDHS8J7ckQDc9R8=;
  b=acFq7zXaxt4CbiOraDX3ABRN3C4KoVFtpyaqVUrBd9ABqUs5qF26r8sc
   bXwV4K7YX4PNTSvqJUbFRx9B/NM4iz69YdrcpUP8KfqqqZ+ocUQ8U4o+P
   8MZndvWlsiDF6jFtNAJIBR1gQUhz0qgTuIEGx2HWyrCYin0Y86b7gCM4r
   KY6mskce+cswu9H3qBoA6r+9jIvRBqx7aEMw2CL/nXYBAav8jJ2fKSDdo
   94odRnlzD6Acnupyhrysq9EcYsftfgtcrMA465wfWEiQ1raME0V3iUNOp
   Bmu1M41VnVBL3gDtr4A64Oc3Y80forDdECBtx7Uk2szU3cWDish95M7Ep
   w==;
X-CSE-ConnectionGUID: 7Q3Bgeb7QGWKcbF8hbPCLw==
X-CSE-MsgGUID: DRbSwB3pQyWirI7fZeqMeg==
X-IronPort-AV: E=Sophos;i="6.11,220,1725314400"; 
   d="scan'208";a="39572176"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Oct 2024 13:35:06 +0200
X-CheckPoint: {67163C6A-27-69FF9A8E-EE9CEDAF}
X-MAIL-CPID: 506B085ADD78BEFC05A4BB5CBF61F036_0
X-Control-Analysis: str=0001.0A682F21.67163C76.002A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 27E5616B2F7;
	Mon, 21 Oct 2024 13:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729510502;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yn7P9s9yfLjz2aH1iQX9Xxev1nS9eDHS8J7ckQDc9R8=;
	b=kb/yu5C3qbqwyvDbDwBcQ48XRy0xSEecXcMmTq6Ug96swvkvOTeUaNWjihcK2mhx5AHZto
	+siJw6FoCn3A8yhMEGu8aZYQJHT+zUhkFNs8+JkYu+lr4p3cFnp2L20X1OqsRkKAO8JOr9
	ULRhwrkDeoZblvxegRp4WVavzsyjI56o52rQpIi6KquBelvFg9yTBBawe2tTg/C8zVWlcY
	mpuDsDqYwhUYTMd+l9ZJnZfjBeGPxEsLHgShJOCI0ozWMxlm2y/Ik3Spe9XFPYbpg9nE1r
	v4+oucbp998+bIDuZBpG+lsjDRiOBgVNC3GIyMl8de89YaGQf7aymRq79zehtg==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v5 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Date: Mon, 21 Oct 2024 13:34:26 +0200
Message-ID: <95e7deca3451f2fb19b2c8253e9d19117bbdd06c.1729509613.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1729509613.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

GPIO IRQ setup can fail either because an invalid IRQ was passed as a
parameter, or because the GPIO controller does not support interrupts.
Neither is severe enough to stop the whole probe; simply disable IRQ
support in the GPIO resource when setup fails.

The code is made a bit more robust by introduing a define for the index
of the IRQ resource in the resource list instead of assuming that it is
at index 0.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes (was patch 3/4)
v3: replace IRQ 0 resource with an empty placeholder to simplify error handling
v4: no changes
v5: move placeholder to the end of the resource array, use define for index

 drivers/mfd/tqmx86.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 8aa448a67c9a5..1fd2212bf492c 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -60,6 +60,9 @@ static uint gpio_irq;
 module_param(gpio_irq, uint, 0);
 MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 12)");
 
+/* Index of IRQ placeholder in resource list */
+#define TQMX86_IRQ_GPIO 1
+
 static const struct resource tqmx_i2c_soft_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
 };
@@ -68,13 +71,10 @@ static const struct resource tqmx_watchdog_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
 };
 
-/*
- * The IRQ resource must be first, since it is updated with the
- * configured IRQ in the probe function.
- */
 static struct resource tqmx_gpio_resources[] = {
-	DEFINE_RES_IRQ(0),
 	DEFINE_RES_IO(TQMX86_IOBASE_GPIO, TQMX86_IOSIZE_GPIO),
+	/* Placeholder for IRQ resource - filled in by the probe function */
+	[TQMX86_IRQ_GPIO] = {},
 };
 
 static struct i2c_board_info tqmx86_i2c_devices[] = {
@@ -255,13 +255,8 @@ static int tqmx86_probe(struct platform_device *pdev)
 	if (gpio_irq) {
 		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
 				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
-		if (err)
-			return err;
-
-		/* Assumes the IRQ resource is first. */
-		tqmx_gpio_resources[0].start = gpio_irq;
-	} else {
-		tqmx_gpio_resources[0].flags = 0;
+		if (!err)
+			tqmx_gpio_resources[TQMX86_IRQ_GPIO] = DEFINE_RES_IRQ(gpio_irq);
 	}
 
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

