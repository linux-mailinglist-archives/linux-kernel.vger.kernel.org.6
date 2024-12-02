Return-Path: <linux-kernel+bounces-428286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B09E0C65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FF3165623
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521EF1DF271;
	Mon,  2 Dec 2024 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sb56Fw/N"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141091DE8A5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168501; cv=none; b=De5DWq2NCWVcqzfFHmqTgIQ5/xh0dLRWQ30hUxZCO7jd/xccs0ZQKlPv71sdUWU2W2CbX1Vanaj6gjbOe8eOcZIS/PrNhBJzOGZ2wQxegAn2pH2PZXeZ1jsAljuFMFpcnvSG5pDgGqV2N6JXEBkc8/GbqhQHM0PQBf34gYxNGzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168501; c=relaxed/simple;
	bh=bM81m61bwS2UN2Svbu/r1zfl/LDb+tjGoL6u8SEWQWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLNS6/z1GkTEHiH9rH0JigDawKBTDOTPmF1c6IKK9Pgoi5BdDLqiZHKfAOGLhGOa1o2Hk/98+u5oMcGYkL3STUmXpovPif7wgZWOtn+LihknHtwdmWyhA7J6rRmXJ1PNdLHFhWq2D4DyWiDlhu2KggnTd4iUpF6RPN8jz8a6Fx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sb56Fw/N; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B2JfBig060711;
	Mon, 2 Dec 2024 13:41:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733168471;
	bh=UUkIu/8Qmux6+/va5NpKSfNIFMGEqp8ObO5jfrobR38=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Sb56Fw/Np5bBmWP10EiYKoAuc68IRVqCvFiPqIaTykrGLXoWuQ+/upX8a6SJlKE4I
	 r5cS4bf5eN7PsdtblNfGQZQKZGSBMtvkT82pOv1jMgiG5ZMDRo0sKEs3OfSuq2v+h4
	 WFDf1Oi1v1px4/Vbc4cIdqTTg7nDXt6RbFZwdr+I=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B2JfBjE018352
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Dec 2024 13:41:11 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 13:41:11 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 13:41:11 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2Jf8iP127393;
	Mon, 2 Dec 2024 13:41:10 -0600
From: Andrew Davis <afd@ti.com>
To: Arnd Bergmann <arnd@arndb.de>, Andre Przywara <andre.przywara@arm.com>,
        Russell King <linux@armlinux.org.uk>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik
	<robert.jarzmik@free.fr>,
        Alexey Charkov <alchark@gmail.com>,
        Krzysztof
 Kozlowski <krzk@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 4/5] ARM: vt8500: Switch to new sys-off handler API
Date: Mon, 2 Dec 2024 13:41:06 -0600
Message-ID: <20241202194107.105119-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241202194107.105119-1-afd@ti.com>
References: <20241202194107.105119-1-afd@ti.com>
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


