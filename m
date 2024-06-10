Return-Path: <linux-kernel+bounces-208198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7399902238
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ACF91F21560
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5241D81AAA;
	Mon, 10 Jun 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MfYKvQU+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CF7FBA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718024399; cv=none; b=udJsUBTObPbCAu3jbgqBcUTjTz0OjEigNEmnNG9HpHpWiKEJuvA4I0+UGnKOx3KTR4rtVQN1lafebiqTh2XD+74YldHRNGV4C9ECGdL23WQGRXtFGV6f6ui0a9gvy88jEGyynZt7NVXLPPzmjPdXSi8YxMsR6l8iz9G854M7OXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718024399; c=relaxed/simple;
	bh=bM81m61bwS2UN2Svbu/r1zfl/LDb+tjGoL6u8SEWQWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbqb5eG1geV4Q8GQejib0JEiQ+A4ZAYrCvLuep24Ol8dlj6OXDgDhV4R8GzO99bxjXQCzCurolaqvLhNS2xqSwLhUPMugVsHSz4e88QBXRWiHQpyNXIsGkQvZy6UwljLZ7/R2siHfYwYIqgWlLtBVmTOblWSY6Sn2pZ/OWdA8ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MfYKvQU+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxTM1010160;
	Mon, 10 Jun 2024 07:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718024369;
	bh=UUkIu/8Qmux6+/va5NpKSfNIFMGEqp8ObO5jfrobR38=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MfYKvQU+50NmBlRsRK4gnQkcG5nLX5QmL/9ANDT46GgQ5P2B6QM33aAG7+UcEXmPf
	 cCXdm48FU7OoXMqI0CVkfcEmQvc4rl+bFGG0qK9sp/t7ziEEmdrnYlH4CU6n456fV3
	 7uUsaHeKyLfpkQaYGy+IuxVVFo9ftDvHo32cVrfo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ACxTd7040422
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 07:59:29 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 07:59:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 07:59:29 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ACxP7Z064068;
	Mon, 10 Jun 2024 07:59:28 -0500
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
Subject: [PATCH 6/6] ARM: vt8500: Switch to new sys-off handler API
Date: Mon, 10 Jun 2024 07:59:24 -0500
Message-ID: <20240610125924.86003-6-afd@ti.com>
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


