Return-Path: <linux-kernel+bounces-361822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0199AD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FFA1F26A23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435C1D1308;
	Fri, 11 Oct 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nCtWOOoh"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694941CF295
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677843; cv=none; b=lH/Rf3qo6wmRDeLtHAyiD4WwwIEGQupqPVBe24B8cPqDOEjqb5we7H0sYhNFwDuj0IsZV4xfHjaF1FrC81zhSR+X7hnif64PYJN7dXA0CAKfdgW5EpbAFPWm08cZKD6m3H0E4FNLfsqQBWvftbIL23Zw6sjvLX/BEh4D14Lbc6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677843; c=relaxed/simple;
	bh=NJN1GNR5FglhPaWtGVRtLSZ+9nR3k3nYEOBv/xPhWtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u55iOUEJs9QKmzuo9fGXguOfQ4E/25QxhJKr8DnFD1SdYnQEjzn7Z03QQVrPj3uf0agD9PQX8KQXIcZ7tdUKo5x+n6ovEPfCz7mOpZn0r0wL69vrQXTx2W8enSFjKOqs2A5moxErXouTTaFvtq9FRB6PiuBAYI11l5q2cSSYKc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nCtWOOoh; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGnMO029277;
	Fri, 11 Oct 2024 15:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728677809;
	bh=1hB+Rsl8dEIP80gJg1dRpUGGywa9yjHgvJWWFP9MDZc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=nCtWOOohW6BZJk/VXaTP8AdC7WcIZTgcYxv9cw7f2CZdannIIeHVEV83yh+98u5CV
	 d4IsyC1ZdrXTmQ4jkJBRIIqzdzEUYF1ZYivTiq12oRI6JJT5p2SqP+a7ewccwrahMX
	 avy4vussnrnUJdJqbPGAUKKlFtDNhOu9gSPFOzeQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BKGn8a106998
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 15:16:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 15:16:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 15:16:49 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGkCJ102075;
	Fri, 11 Oct 2024 15:16:48 -0500
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
Subject: [PATCH v3 3/6] ARM: pxa: Switch to new sys-off handler API
Date: Fri, 11 Oct 2024 15:16:42 -0500
Message-ID: <20241011201645.797394-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241011201645.797394-1-afd@ti.com>
References: <20241011201645.797394-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Kernel now supports chained power-off handlers. Use
register_platform_power_off() that registers a platform level power-off
handler. Legacy pm_power_off() will be removed once all drivers and archs
are converted to the new sys-off API.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-pxa/spitz.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 33533e35720f8..c0b1f7e6be874 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -1096,7 +1096,7 @@ static void __init spitz_init(void)
 		software_node_register(&spitz_scoop_2_gpiochip_node);
 
 	init_gpio_reset(SPITZ_GPIO_ON_RESET, 1, 0);
-	pm_power_off = spitz_poweroff;
+	register_platform_power_off(spitz_poweroff);
 
 	PMCR = 0x00;
 
-- 
2.39.2


