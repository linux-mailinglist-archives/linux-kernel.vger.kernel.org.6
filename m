Return-Path: <linux-kernel+bounces-208199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA08902239
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C257C281E47
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792B881AB4;
	Mon, 10 Jun 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GgrtWk4t"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00280BFC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024399; cv=none; b=D5zON/gftHu5xfr8mBUm0g01++2n9AWVIRziHBj9/C1fYeNOUy0nQqSNCSxauMMRXbinDfsbpTJ9Z/yFfYn3nmHA5wc/Oj4eZZFhXbOdLtRP/51LwKfmIheUmn2flCmD88cxbL4GFwaATLLEW3xBkMAy2cLzDrZE3uB5rbrSbpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024399; c=relaxed/simple;
	bh=fDHQ/whn1e2FLw1pGiafARPj38BZG7jUM/tIWMopJCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ML+VqnZ1aYoPlEPaS2fvTLQavtlFWwGIexCWn76EBAAoT8x+DuHa7ycRv+MWISBb1Iwy4ihG559SUwGvKCnJVW4JDODV4qSWztbIl81Yb83IGPnk02C6cAMS/jGUAaDMNemN0Ci4Be81UOSrN8Uhz6TZwNDXrwSrdX9lB2hEu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GgrtWk4t; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxQfk010146;
	Mon, 10 Jun 2024 07:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718024367;
	bh=osHFNXQYeOZ8cNYjQlaQF7CLkZggS3LAq+r5ol5gjVc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=GgrtWk4tvUSobyWBgRYY9u2MTujyy3SUWyrbOV8nFxIGubWP2pnMFmqaFuvjn7EjE
	 F3XEspGzmKjH7RmWAgqSEWVL9Bdq6iYSt1bMetVd12Rf0YYfB0mbkXOLgzLTYczgkA
	 0s6a9L31BLIL+AQ3Aj1keMFtQ7gklDRlbl5o3EAo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ACxQ0f028872
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 07:59:26 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 07:59:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 07:59:26 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxP7V064068;
	Mon, 10 Jun 2024 07:59:26 -0500
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
Subject: [PATCH 2/6] ARM: imx: Switch to new sys-off handler API
Date: Mon, 10 Jun 2024 07:59:20 -0500
Message-ID: <20240610125924.86003-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610125924.86003-1-afd@ti.com>
References: <20240610125924.86003-1-afd@ti.com>
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
 arch/arm/mach-imx/pm-imx6.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx6.c b/arch/arm/mach-imx/pm-imx6.c
index b36f05b54cc76..a671ca498f887 100644
--- a/arch/arm/mach-imx/pm-imx6.c
+++ b/arch/arm/mach-imx/pm-imx6.c
@@ -634,13 +634,11 @@ static void imx6_pm_stby_poweroff(void)
 
 static int imx6_pm_stby_poweroff_probe(void)
 {
-	if (pm_power_off) {
-		pr_warn("%s: pm_power_off already claimed  %p %ps!\n",
-			__func__, pm_power_off, pm_power_off);
+	if (register_platform_power_off(imx6_pm_stby_poweroff)) {
+		pr_warn("%s: platform power off already claimed!\n", __func__);
 		return -EBUSY;
 	}
 
-	pm_power_off = imx6_pm_stby_poweroff;
 	return 0;
 }
 
-- 
2.39.2


