Return-Path: <linux-kernel+bounces-208203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F01902240
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589B81C2156B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A86130AFC;
	Mon, 10 Jun 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VjQMnxBV"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C54681AA2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024401; cv=none; b=HY3aMEBCxa7XR7uNz36nFA1q9olE1WIde4VfLmLuqabl5N84bJ4SDzjpiIPrXEk9awF6+tmauOA+L0K0AaZiRkCI5Aef21ADiVn0bQhqesjSCizzmZQPdcxROHfHC8liBeiekOYsH2oIu17gAqJ8d/FXNBun505O/eWUevUwQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024401; c=relaxed/simple;
	bh=4MGgnzg2JZ2JhUvWSpp/hH/wLfi88rLG9cyyoXmgbz4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AzOzHsbWwTVXBQPC8I6GWKS91S/V2gjaG6GPEevP2T+Bz9eiubbfSThEkWX44ANQsB/6nhhCWcdovhRF+GcLra8VyMICnV8DbmHrBD7MBMaNfKJ0qsjMZJMcSfXlmpAZroI3hgqmhD9K+q6uG+if2nC2FmyyvrdzeX67ZMerqqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VjQMnxBV; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxQij041177;
	Mon, 10 Jun 2024 07:59:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718024366;
	bh=9qVYz6uxkNZ9EajXzIvmaiC+dOktkrr+a+eYnCwY8ho=;
	h=From:To:CC:Subject:Date;
	b=VjQMnxBVs/9EZmKnHQyYqu9wOceaukxURf/8jBJJzPypAJVNyOw4Lxkhr/s7w+I+e
	 oDUPF1bmX6S+PL/qK4+Px9TrDTuTdVKT25Li0hCm7R94NX5EFowai2RL4gTEgnHRR9
	 ybfgPmXoVUWvK5WQJRd3XOj8r4/RziNQ0LN90cIQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ACxQjU013522
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 07:59:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 07:59:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 07:59:26 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxP7U064068;
	Mon, 10 Jun 2024 07:59:25 -0500
From: Andrew Davis <afd@ti.com>
To: Andre Przywara <andre.przywara@arm.com>,
        Russell King
	<linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement
	<gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian
 Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/6] ARM: highbank: Switch to new sys-off handler API
Date: Mon, 10 Jun 2024 07:59:19 -0500
Message-ID: <20240610125924.86003-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Kernel now supports chained power-off handlers. Use
register_platform_power_off() that registers a platform level power-off
handler. Legacy pm_power_off() will be removed once all drivers and archs
are converted to the new sys-off API.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-highbank/highbank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index 5d4f977ac7d2a..47335c7dadf8d 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -143,7 +143,7 @@ static void __init highbank_init(void)
 	sregs_base = of_iomap(np, 0);
 	WARN_ON(!sregs_base);
 
-	pm_power_off = highbank_power_off;
+	register_platform_power_off(highbank_power_off);
 	highbank_pm_init();
 
 	bus_register_notifier(&platform_bus_type, &highbank_platform_nb);
-- 
2.39.2


