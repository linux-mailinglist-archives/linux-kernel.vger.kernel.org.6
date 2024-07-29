Return-Path: <linux-kernel+bounces-265752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B155E93F58B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0081F223C8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4794A6F31E;
	Mon, 29 Jul 2024 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wvU/R4JI"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A91465BE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256573; cv=none; b=eNbFckXgROdhXqP+DN6E1LnRUH2TjwXJWqypm2+w8ogPOA7bG7QXx7wIvcamXkSujKi6spHVz43tOSQHylB0Q5JUyeRNo9svc70wzsBn6lNefk3EMVAYGTPFX176xBuQzCS0HnBvjXZ8l6l/KIgi5PgRQiwrEpmOZplIiNTt0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256573; c=relaxed/simple;
	bh=nuJrTRgLsjQExs+N87GmazFylclUiz4XenNuLHwBWV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPnNNrIYRtlEhdL6hD/ZRRJeLpxPKJC23txEqyTCn9oBUkQONqMngXeXO1Bh1rzXXxFm3hYoiA4NVeoztIow1rkDP52HrCWww6l07eyS7mRwQ/jNltPhk6Lll9zEPbOhHFP4SGFG5LFWljK91k1S7Uf+LaNJu/LMnuUv3VRshGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wvU/R4JI; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TCZfes067690;
	Mon, 29 Jul 2024 07:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722256542;
	bh=E1t2slHF8kd+FV4537/57jAGsLGmbZ2/z9jipE7qiaU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=wvU/R4JI26/NgeSr5ZzUGuJlYHB8SLtbT2u4bPVRYGgGcTzLskOhgO4/ruHJ35w77
	 bjZd+ARzwIV0Aqw3iSgcG2FsFuZxDY47G4rsVU+QzVzGkitMwZEOsndFo1EKcYCnK5
	 9cabEDDKskcXWUueTGRmXug1lkUmoBVXxDGiyiHM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TCZfKK017807
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 07:35:41 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 07:35:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 07:35:41 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TCZd0j128014;
	Mon, 29 Jul 2024 07:35:40 -0500
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
Subject: [PATCH v2 2/7] ARM: imx: Switch to new sys-off handler API
Date: Mon, 29 Jul 2024 07:35:33 -0500
Message-ID: <20240729123538.175704-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729123538.175704-1-afd@ti.com>
References: <20240729123538.175704-1-afd@ti.com>
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
Acked-by: Shawn Guo <shawnguo@kernel.org>
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


