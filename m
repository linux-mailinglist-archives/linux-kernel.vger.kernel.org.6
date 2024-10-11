Return-Path: <linux-kernel+bounces-361825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4425999AD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88354286C85
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC91D173D;
	Fri, 11 Oct 2024 20:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tiJlTzew"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0FD1D0E0A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728677845; cv=none; b=hk4hoEsJPrG17cjfGzbNLaZwRznhdpMFaa1ik3izMSgnJD9SJM35ouXCd4aQpWOeiy6AXgLQSaska6xLjj5HOAKj3NFITdwTCzg+QjZK6Ct1aF4UrDhbRs2W29T/XLHpwlWQWznZ/fglGWe9kB3s0PUigoPGewECtSiku3Ijhm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728677845; c=relaxed/simple;
	bh=F1JZZ3VxwsSKTg2LjGq0rUIE/gVME8qmJ40fxossfJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFe4DsyOCIjJ1LZOlOG1CJtrGFhSQejA+uAm8ucX1vGklrszSLKvXu9jLEFHRwmtZjEY8CrwXAi5p1Slqgqokt/lQ+xDpmhY7qzp+JU//fACjec2GaNghMvDyX3d6wRbXfkfWvSfIO5DykrjUezVrO2eBiFlcKEd4WSXqj5C19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=tiJlTzew; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGnDu081112;
	Fri, 11 Oct 2024 15:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728677810;
	bh=8gIz69rx+O7g3l2dUBVUwaQsvlZ4QBJNSMujzHzSCeo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=tiJlTzewA8RT6Ar2WrjqwVi38PgJaLnwp1K2Lf/cvbbF94QkBHP+qmy35pbumjYmK
	 g0NfsFhGsLS864+6GIsiZhudJBjrRRkJlDPU4u3nL0e5w39x0SOO32ual8/dJ9egSp
	 yfPzjxMDUJVjOxwnCOLeE1Rl6cwhx1FluiA+mm/E=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49BKGnL7028961
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 11 Oct 2024 15:16:49 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Oct 2024 15:16:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Oct 2024 15:16:49 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49BKGkCK102075;
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
Subject: [PATCH v3 4/6] ARM: sa1100: Switch to new sys-off handler API
Date: Fri, 11 Oct 2024 15:16:43 -0500
Message-ID: <20241011201645.797394-5-afd@ti.com>
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
 arch/arm/mach-sa1100/generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index 0c586047d130f..5383a26f51169 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -298,7 +298,7 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 static int __init sa1100_init(void)
 {
 	struct resource wdt_res = DEFINE_RES_MEM(0x90000000, 0x20);
-	pm_power_off = sa1100_power_off;
+	register_platform_power_off(sa1100_power_off);
 
 	regulator_has_full_constraints();
 
-- 
2.39.2


