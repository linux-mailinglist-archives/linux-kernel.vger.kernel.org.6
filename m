Return-Path: <linux-kernel+bounces-337714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A119984DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9025E1F23BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB65D13A25F;
	Tue, 24 Sep 2024 22:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a3oh11bO"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584301482F5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217308; cv=none; b=tI1p/kTcrEwVF3T9H/FKOWRGl32IbL1L3G2WKO7lcB9wgPvJXsLfzm3HLg0+Mxomqsvk+zl9G3eSAb6Gx7oXeScialyl9nVZc5DWC9FE5RmspaVzUJl7hRkyrjv3xX2Jtj6Sje8iJKrJk++aw2CwjjMI5ZBwzUqUxHY2njjwvyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217308; c=relaxed/simple;
	bh=QN5PPNc4JqPCQzNZ5O+T9mm7r5XpZiPt75jXGUAQWUk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AOfSTnimcbvEgtNlBRmjLo5uWOvch3H0VqTDQxc5e1P+Z7WO2fNTGnBWSkfWR8ybveF+OHdAeKbpT/phiKoHuC6qbYRwS3HiQrGs/H+NyvZStucozGbbTf8IC/BfZ18ENDSbd5+R0tV0zyV+c+6dKv/2kpzAWmmwpHysYHkdAwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a3oh11bO; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48OMYsEP082732;
	Tue, 24 Sep 2024 17:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727217294;
	bh=UAjLUup3eFAO+n1nuEVrh8XiebkiHDitWC4eqUr+RvE=;
	h=From:To:CC:Subject:Date;
	b=a3oh11bOAbcYNt0kS5oNa1Hl13tbcOBmsBqZNAFuq0nCP9SMOy7UiJdjnCML+vKxj
	 KpLg7zG6I3Y8lPBZ7oVF9mzsAwqXTrAwhxL8EANBN/vUeZUOVWAZIKbF0iTGIJXanP
	 ZNRF/Fs+BUlGOuQEbmnAniTkw1w4btEd0s1WXxf4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OMYs50053628;
	Tue, 24 Sep 2024 17:34:54 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 17:34:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 17:34:54 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48OMYrGO064847;
	Tue, 24 Sep 2024 17:34:53 -0500
From: Judith Mendez <jm@ti.com>
To: <linux-kernel@vger.kernel.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner
	<tglx@linutronix.de>, Judith Mendez <jm@ti.com>
Subject: [PATCH] clocksource/drivers/timer-ti-dm: Don't fail probe if int not found
Date: Tue, 24 Sep 2024 17:34:52 -0500
Message-ID: <20240924223452.895081-1-jm@ti.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Some timers may not have an interrupt routed to
the A53 GIC, but the timer PWM functionality can still
be used by Linux Kernel. Therefore, do not fail probe
if interrupt is not found and ti,timer-pwm exists.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/clocksource/timer-ti-dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b7a34b1a975e..1b61fefed213 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1104,8 +1104,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return  -ENOMEM;
 
 	timer->irq = platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
-		return timer->irq;
+	if (timer->irq < 0) {
+		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
+			dev_err(dev, "Did not find timer interrupt, timer usable in PWM mode only\n");
+		else
+			return timer->irq;
+	}
 
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))
-- 
2.46.0


