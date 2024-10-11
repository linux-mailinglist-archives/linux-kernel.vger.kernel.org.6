Return-Path: <linux-kernel+bounces-361634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E77799AAB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AAF1C21576
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77A1BE86E;
	Fri, 11 Oct 2024 17:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IZe6JCFg"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721819EEC4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669136; cv=none; b=UO1Vx9iQZStLu0b+jmiF/cHZEeS1UTB8VJBx3vGRqJmhgvg+aF+vVr0OK9CsfRosUj/hjnutIhhpArZjLbPR0kd3P6pgVmrPeZF3aP2fert59Gps+0aZqhx2U0H7KpqIJ1Nu0GuTkMuZMHzeXOrgE02P+vaO3M/ON2UqV4UrWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669136; c=relaxed/simple;
	bh=x+TgFR/e+3s+vUjK0QH1Ta10PIrvSijdB8M3Iq3DQ6o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P7YPe6kH+Op0p2IThI8r/izliRvvatyGO/BNjlC5eKOcDtTYrtNKSoHc3tbM6vd8cXQyrUol6m6gF+GM+rFnmkT6pRpwb57o2fZyPhRlvEurWsZOMy6Difa6o+/hsVagFRYo4rauY4m9xxuGbtpputXOdRwuYm/oKP0Mg4SpZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IZe6JCFg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BHqBei033104;
	Fri, 11 Oct 2024 12:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728669131;
	bh=CjtYFl3pEv+beuRqt1KSFZBpUzj+CQaGmUW7+s5EK5g=;
	h=From:To:CC:Subject:Date;
	b=IZe6JCFg6uoCkvieSH+iqyQVTRl65B2C5utknIgk47D97Pc0EM47Y51zxPKnMvabK
	 31kxm9lhT8NK65qpeCP4RJBEYOcUuo+8DNIootEpw06BUb7bGAspY2dwMW8DIiTsdW
	 KSUdssIBHDDAmsroLmAuQh/psqFObJmbv97FyZSU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BHqBMS079315
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 12:52:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 12:52:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 12:52:10 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BHqAEZ076869;
	Fri, 11 Oct 2024 12:52:10 -0500
From: Judith Mendez <jm@ti.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner
	<tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Bryan Brattlof <bb@ti.com>, Judith Mendez <jm@ti.com>
Subject: [PATCH v2] clocksource/drivers/timer-ti-dm: Don't fail probe if int not found
Date: Fri, 11 Oct 2024 12:52:03 -0500
Message-ID: <20241011175203.1040568-1-jm@ti.com>
X-Mailer: git-send-email 2.47.0
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
Changes since v1:
- Switch to dev_info()
- Drop fixes tag

Link to v1: https://lore.kernel.org/all/20241010144440.24654-1-jm@ti.com/
---
 drivers/clocksource/timer-ti-dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b7a34b1a975e..3666d94cc8dd 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1104,8 +1104,12 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		return  -ENOMEM;
 
 	timer->irq = platform_get_irq(pdev, 0);
-	if (timer->irq < 0)
-		return timer->irq;
+	if (timer->irq < 0) {
+		if (of_property_read_bool(dev->of_node, "ti,timer-pwm"))
+			dev_info(dev, "Did not find timer interrupt, timer usable in PWM mode only\n");
+		else
+			return timer->irq;
+	}
 
 	timer->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(timer->io_base))

base-commit: d3d1556696c1a993eec54ac585fe5bf677e07474
-- 
2.47.0


