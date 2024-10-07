Return-Path: <linux-kernel+bounces-352938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6036199265E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D791C2249D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD52518C02E;
	Mon,  7 Oct 2024 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QzNrow6M";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dT+piBa+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4E18C027
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287403; cv=none; b=T1JvX/joA6MRh/QcTWy44k2S9kyuhrc4a4Swj2u3IgdUQTsTJ6abD2DwLeqiyZ0fBj0ohxFHTpcHGTW/xCmZgOK4yd6RtExGvgRtw52k74oeHgdBao6jZl5jCZnsJcaCpLsupPWsit202flB6RySvt+uegyRpMLldgwMWGEaBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287403; c=relaxed/simple;
	bh=ccgRXV/sbGLbrv7yS6yGTQciaCzuc0wCuURVfvrCjfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1q9eQJrjxlRt5Poq0dxNES6PVLkj4Wwaakadt0ZVSH0GxQlF0z4+qnRUzf1MF867zK5uhIu7dPCDakWPhTL/34wxZKFPmD+ao1zK4RKG6Q6FZB6XVAMvQ+MvqDWU4QuHoqNJJr7zcI8ihJY0GZtiuLkyu07TlqhVcMlmcW6IjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QzNrow6M; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dT+piBa+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1728287401; x=1759823401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gV+HjTlsSJWYhabyWjpXtxtlpvti8ZSOvu5o7P88OBM=;
  b=QzNrow6MlzV8ZQTvxw8rWSu6cWsFO94IXMt644+DcqA94V+u+qL2h34A
   +O1GfFkC6d7HVBGn/NiBXeS3hs2uRXWxiKvytmmy+WRNVahUdgL/kA6yA
   z63J/6X2etalxaXT6+Z5EaJMQ+tpvnNbcYkP8LxTwXcMjTh35XjVtkF/d
   kp2YvgoQvnJJcPrSXWr0xYkLd6TTUbc4PbzivdXYxOXP/rE5Mt1QWKnhF
   QoBbyosvpIwIAaTb1CpXwDQ9GV9ovXuhEz/C6vx8T1G95aBHErat4MBcQ
   xJba5Tw9/nwY6feaP2LFFGosBVo5oDREDiG4mUfm2wCkJZ15bN3QIkMYV
   Q==;
X-CSE-ConnectionGUID: VgoEKYTkQiewIZ9h4fqgAA==
X-CSE-MsgGUID: FhvVirYIRY+iIC+9xOUi4w==
X-IronPort-AV: E=Sophos;i="6.11,183,1725314400"; 
   d="scan'208";a="39297581"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Oct 2024 09:48:57 +0200
X-CheckPoint: {67039269-7-60D1B728-D7971DF8}
X-MAIL-CPID: 790FE4BFD5C18DD35A8F3C31BFD46F5A_4
X-Control-Analysis: str=0001.0A682F28.67039269.0038,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A683C16BD32;
	Mon,  7 Oct 2024 09:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1728287332;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gV+HjTlsSJWYhabyWjpXtxtlpvti8ZSOvu5o7P88OBM=;
	b=dT+piBa+GwgZ2ciNOq0Oj9PXbarozKpWW9uOuBpv8CEVxebGAz+n23YNfqj8segibHH7eL
	lhGtknDSZwYvzpqkEy1qitYT1sKZdERs2LgCWJikhQ5Xt1iiohhwn4l0oTnSdz5cJgQWAi
	k1KdTQILjqe8wLzn0joRgZmhR7tYGeAZKV1Gox7GmWSXCD9K2RdtbZx8otDAlGJ08zADJz
	DMvChwCHPOeumARTdjXfpLA7plZb38p4fFcD4V2Newt854gOdVE2VIDv4NnRtwSiiAV6lF
	BE1ruujSEsSYMM8f+f+rvsnUrhsYXJlP6o2Wmm1QeUSiA0vcZB9d14JkVlLe9w==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com,
	linux-kernel@vger.kernel.org,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v4 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
Date: Mon,  7 Oct 2024 09:48:07 +0200
Message-ID: <4c1d5044eaeae67854a7b9c97f364648b275b710.1728286453.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
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
v4: no changes

 drivers/mfd/tqmx86.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 8aa448a67c9a5..e444fcd2a3e9d 100644
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
 
@@ -255,13 +255,9 @@ static int tqmx86_probe(struct platform_device *pdev)
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


