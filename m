Return-Path: <linux-kernel+bounces-359354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C349998A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEC228928D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDAF1CF287;
	Thu, 10 Oct 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OzQ+Yjc/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764DC1CC888
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571499; cv=none; b=ioIacd+ravfvKTdHVgPKcYXBYQ4YV2awfJD0zj3162US9OnKrZTI0hDMrrtwjAazmrAPdf+nCJV1YCq7AR3OPrcJgTunu66dixWUKFJvuFYKbKqWrERdzLKp0it7PR+/8Q3uGAkJzOeYzwPUv5fRgJjSYPcHFp83h1VCJI+kPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571499; c=relaxed/simple;
	bh=6Cp4gBt/7na3rA/D1YYkCY+Uja7S7a+flTHHwic0BuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HUeneSoBB10Kq5GjkN9uOIVXm/hsBHm8jzAmH974jN+BVXA/3PgrCEy5O65gCSPdfSZE2uRTqDQA16IKzrbqyIfDxdAqLgyh4DUkg98WynMOYcf2SOWK9+K2cw7K8WotMdT5Xwsa4ebWxIf1oA8jDl9tMjlMkdjYfLqjqMma0gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OzQ+Yjc/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49AEihSx064561;
	Thu, 10 Oct 2024 09:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728571483;
	bh=oe7GKFlH8bpk3mIcfwhAiSMQwyMMH73q7BAlvz8nVig=;
	h=From:To:CC:Subject:Date;
	b=OzQ+Yjc/vJCsLna2hrNDKUnTJbTbe8AIDm1g16f4Rs4o5s4eL9KbGwWxJDSClUuSt
	 QGRL5JU3aRUcylW91m91vhIaQN8HPks7U33VIA3z72Vk6CH3kllKcLxWfnR84+RMHP
	 q6Y4J70TFC9XjtkrYBC7FbVUAFhEuD8K6nIboahQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49AEih4C077766;
	Thu, 10 Oct 2024 09:44:43 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 09:44:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 09:44:41 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49AEifWt006669;
	Thu, 10 Oct 2024 09:44:41 -0500
From: Judith Mendez <jm@ti.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner
	<tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Bryan Brattlof <bb@ti.com>, Judith Mendez <jm@ti.com>
Subject: [PATCH RESEND] clocksource/drivers/timer-ti-dm: Don't fail probe if int not found
Date: Thu, 10 Oct 2024 09:44:40 -0500
Message-ID: <20241010144440.24654-1-jm@ti.com>
X-Mailer: git-send-email 2.46.2
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

Fixes: df28472a1b28 ("ARM: OMAP: dmtimer: platform driver")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v1:
- Rebased, add to CC list, add fixes tag
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

base-commit: d3d1556696c1a993eec54ac585fe5bf677e07474
-- 
2.46.2


