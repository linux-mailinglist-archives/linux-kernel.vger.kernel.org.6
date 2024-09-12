Return-Path: <linux-kernel+bounces-326668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469C976B84
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D867B22BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AB21B9828;
	Thu, 12 Sep 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="aW5vDA7J";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="H8Ue6sZb"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E261B5801
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726149905; cv=none; b=f5+Zj26Ha7xrPot+12mTqT9enQkFccoV69EJ0DCfDkMhut2RIJW8FG0hKmMvDMhNX5wrCDdExE5T33TkEX7WBWVp2GrgNDCCHFQ/sQgal4ntqD33uagxKwzaChBTeQJfGxpkCBoqsXmqrpY5xbyYzRuq2n6MyCo4Qww4uu2unJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726149905; c=relaxed/simple;
	bh=WwOoSBmoZ4ON9NPKxdbO0Z9C73w5T8x3dw0XhV9cUxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGZjMxWIjrqHuMCyGKbRi0axP1ZcZjH5DwHqbxDPZsJlyyCbPqGi43CVFRhEYYsXc5V2nNMsfFCdDvwhoqHEg5lMvjDa/RstFahRHeoxbA4gZN3sYDdBJlWP1+KXXLdypWjQCROjdLMWiXqsNmtGLP/UlnSjhopPNZ/pdx3LX1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=aW5vDA7J; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=H8Ue6sZb reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1726149903; x=1757685903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QT2Ld9MEQXoIockANwaetzu1uNGZhRF1yfsxNvnSN8E=;
  b=aW5vDA7Jqiv9omOD9YDFNavpB1KCHmYyNJuA31a4dLBv7YdO9kbQNwhI
   oKZlek0NhtTU+Hx95RgFvNk0N0Tp5x1bqhsQJUpwT94KkYgYUb7GEAkpT
   qY9vRXNv7Z0tfAKeUcIgRk+foLLE8vnm/t52XtkA2ory3gHquBPVv56ao
   TrxwSBOq9ilC7zfcMljItS0M7a61Ls3TzM9GpsVAPBdKpdUsT9jV318Ia
   kXUW+6SrwHIirZwSvff5A5WTwXLb7nJfS6ySaNtnmqnZvy60m2S+6dWhh
   xzmMvBmFU6TO+JvwX8bHnYaaf0NSO2tf4JNsPSAG2RhF0ud3A7v/XhTyP
   Q==;
X-CSE-ConnectionGUID: WpHqEP7LQ/q4uyz5+M+7PA==
X-CSE-MsgGUID: DT5tvyrwQLe25cRvkk2TEA==
X-IronPort-AV: E=Sophos;i="6.10,223,1719871200"; 
   d="scan'208";a="38915422"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Sep 2024 16:05:02 +0200
X-CheckPoint: {66E2F50E-1F-22BB8E18-F5F6D0B4}
X-MAIL-CPID: 1CF0AA7FD2F2BB93F8E20F541D6C46E1_5
X-Control-Analysis: str=0001.0A782F27.66E2F50E.015B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79A01166F0F;
	Thu, 12 Sep 2024 16:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1726149898;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QT2Ld9MEQXoIockANwaetzu1uNGZhRF1yfsxNvnSN8E=;
	b=H8Ue6sZb06au5Lyv95s/blhHPGR7PdILZzbfSAuemgIPtjJQPhIrM158kDzWVJvNqjcjbs
	RkFspmCCDA+7XfREFmRa2dJOfEsq8rsNEUxOIWf3d4Psts9u6hZQyNfRQS2sxPjCYwi6qI
	Nl5eqxrLsdUwDzxvMPvwa4unH7h6yOp5taOSP7gSLnlK32nQIv6XmesfmjlpuB+SEg6KGc
	2lioFWPl7C0oW68d308+0Xt7xcyt9UzKGCxt5S5XtlWiaf4O9ZiWY8oD5xvwE2FwI2Pb1J
	zzTIm44sMEWjpKmaP910x6OJELiYG8G0w3BYVXQ5OanVcFXEwlJf4I0WY43KXA==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Date: Thu, 12 Sep 2024 16:04:11 +0200
Message-ID: <5ad957126c6757be0fc4563d9ed00ba10caa6e3f.1726148801.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
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

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: no changes (was patch 3/4)
v3: replace IRQ 0 resource with an empty placeholder to simplify error handling

 drivers/mfd/tqmx86.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 5aa51ead00a28..979b6816adfa7 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -68,12 +68,12 @@ static const struct resource tqmx_watchdog_resources[] = {
 	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
 };
 
-/*
- * The IRQ resource must be first, since it is updated with the
- * configured IRQ in the probe function.
- */
 static struct resource tqmx_gpio_resources[] = {
-	DEFINE_RES_IRQ(0),
+	/*
+	 * Placeholder for IRQ resource - must come first to be filled in by the
+	 * probe function.
+	 */
+	{},
 	DEFINE_RES_IO(TQMX86_IOBASE_GPIO, TQMX86_IOSIZE_GPIO),
 };
 
@@ -258,13 +258,9 @@ static int tqmx86_probe(struct platform_device *pdev)
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
+			/* Assumes the IRQ resource placeholder is first */
+			tqmx_gpio_resources[0] = DEFINE_RES_IRQ(gpio_irq);
 	}
 
 	ocores_platform_data.clock_khz = tqmx86_board_id_to_clk_rate(dev, board_id);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

