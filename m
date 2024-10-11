Return-Path: <linux-kernel+bounces-361823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80499AD6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3141F26978
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D991D1318;
	Fri, 11 Oct 2024 20:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ys1tgLpu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AF81CF7A4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677844; cv=none; b=d2rj6aGGud8hRYo2oDZAJMkiZ7wAeZSUg3JBBlGsONb8kMO0j8lPycFnXUQ8B84gmQRPUznDlJm3RxLQJJNZfNbzCbxMsiEOAF3E3qln+zKviD5I/3yQBGxpdHSWK+4FYa+fAW1KtfUo0g+7/Hf8/T+Fc+7Yyc7sMAkNTruptDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677844; c=relaxed/simple;
	bh=bM81m61bwS2UN2Svbu/r1zfl/LDb+tjGoL6u8SEWQWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCtq2drl3qsykbWPjzUnSON5HVNOVvyLq5BpY0T2PDwngClN+AP2tk0HGsA1p/MdA8D8iBDX9MKK3uA4wT1D4TDiADMZvpuWB9c1J6Dw5AYFp5gQN5umzYomvWzjvGvJm0k7DeZw+6lI9usRfRtuoaHOqRoZV+AX0q+8bjo7MwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ys1tgLpu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGoCh081117;
	Fri, 11 Oct 2024 15:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728677810;
	bh=UUkIu/8Qmux6+/va5NpKSfNIFMGEqp8ObO5jfrobR38=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Ys1tgLpuFXSBnj0huEtZLyJs+aQzdephLYChH632hJqcX4hjvmw57FjmBlodrFHrn
	 ROd9EZnMNY3aoJHcFfOmKKa4BmT9lMBCP/255q0gFHxBdJZUa7CSBiTFLnvznI/6HE
	 sMs6DD3+xlqLxQloBPOdsQQaO2Ruv2/9eEsWmzB4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BKGoBm107009
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 15:16:50 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 15:16:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 15:16:50 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGkCL102075;
	Fri, 11 Oct 2024 15:16:49 -0500
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
Subject: [PATCH v3 5/6] ARM: vt8500: Switch to new sys-off handler API
Date: Fri, 11 Oct 2024 15:16:44 -0500
Message-ID: <20241011201645.797394-6-afd@ti.com>
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
 arch/arm/mach-vt8500/vt8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
index 0ab40087ae1cc..1d294255d7083 100644
--- a/arch/arm/mach-vt8500/vt8500.c
+++ b/arch/arm/mach-vt8500/vt8500.c
@@ -141,7 +141,7 @@ static void __init vt8500_init(void)
 			pr_err("%s:ioremap(power_off) failed\n", __func__);
 	}
 	if (pmc_base)
-		pm_power_off = &vt8500_power_off;
+		register_platform_power_off(vt8500_power_off);
 	else
 		pr_err("%s: PMC Hibernation register could not be remapped, not enabling power off!\n", __func__);
 }
-- 
2.39.2


