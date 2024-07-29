Return-Path: <linux-kernel+bounces-265759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2240F93F596
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90881F2276B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400E1155300;
	Mon, 29 Jul 2024 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DJVZ3QRW"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE1148833
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256575; cv=none; b=Oq+8TMaIiGcr/wUHuYyCbbCU9esm95Gk6JCSPMml6HAf+ffquYiYpfM8XqgELkFTpEiNa3bPgxnuk0nitW864tJmltgb4ftEVNGlwhz7+8kNhzEF3UBrNrRJU2NjJllS2imADKAoAhPaEL9staQ+1AZVcFCXM7Tesb1T9wPh1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256575; c=relaxed/simple;
	bh=5M6ZDjw0MU4A/OwviHm+a622lr9vP5tFcBVBN7fGyS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFiVu8L4yvJcb0ZirWLku64AYo7DViUzEvU9EHfrsb+zoAM2E8/ETnRHs1zF5r3IMJvDp8+bVf79EmoqH67Zp4qvoRQAbWunw2BRR11SDAKSHqA8IHQXSC8oFxJKmKaRY7LzzsqWEy0Tr7NuRsJYt525huXtHX940beEHZrzt0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DJVZ3QRW; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46TCZjC3086633;
	Mon, 29 Jul 2024 07:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722256545;
	bh=wQeXaz16g8BvuxKa6rSagWr4SkeKW522Qc0ciOgW77o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DJVZ3QRWxZsKT3wDN386/fzx0b4esRkZ8XhvtFQ7gS3baqsKB9mC778BuoAvTSiM2
	 lGk3mx5HhQkpKFLzRA5p5O9Ti84x5t7Yw/u+eGmaWW87l4uLTYyzkkB9NhCLjHaanK
	 Z9TUl/nIxbUB48nrOCFq8LJd/sOwSAJ3NEbBWVrg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46TCZjTE040013
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 29 Jul 2024 07:35:45 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jul 2024 07:35:44 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jul 2024 07:35:44 -0500
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46TCZd0o128014;
	Mon, 29 Jul 2024 07:35:44 -0500
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
Subject: [PATCH v2 7/7] arm/xen: Switch to new sys-off handler API
Date: Mon, 29 Jul 2024 07:35:38 -0500
Message-ID: <20240729123538.175704-8-afd@ti.com>
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
---
 arch/arm/xen/enlighten.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index a395b6c0aae2a..8655bc3d36347 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -541,7 +541,7 @@ static int __init xen_late_init(void)
 	if (!xen_domain())
 		return -ENODEV;
 
-	pm_power_off = xen_power_off;
+	register_platform_power_off(xen_power_off);
 	register_restart_handler(&xen_restart_nb);
 	if (!xen_initial_domain()) {
 		struct timespec64 ts;
-- 
2.39.2


