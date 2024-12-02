Return-Path: <linux-kernel+bounces-428291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152209E0C6D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A291656A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650481DF99E;
	Mon,  2 Dec 2024 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t62o3g68"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED51DF737
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168510; cv=none; b=dVa5123qVdHU5LStOcqfPMIGqq5CbvTCODj0ekLk9ixgzEbKY2BzEBxibdyoZU9Y9vJjbSYfXhIlOUVS3S+M8fjjp68mWx2VEAyRiIDJ16NvqsgtDhKY0kAAuNjk6Hih+H9qGmrCpTgGCIQ0BG4FzuRIMZC16N5C1c+q2tg1Ots=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168510; c=relaxed/simple;
	bh=F1JZZ3VxwsSKTg2LjGq0rUIE/gVME8qmJ40fxossfJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmLrPxFmMMnH/pgOD8lm+6a6QCMHWIqPVbUxqqTb/ZeCScszZQWa87e99FYrfYo5YJ+DlRrPTs1lS7mfZhqBQimh1VxcMk+4ZjuUuvD+IvwHnwcFD4pgCqxLDocOWUfdBI4VSwVnGgCzMgKab3ysHxgKV5uL8wA8RfCfV76xkog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t62o3g68; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B2JfBHg018434;
	Mon, 2 Dec 2024 13:41:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733168471;
	bh=8gIz69rx+O7g3l2dUBVUwaQsvlZ4QBJNSMujzHzSCeo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=t62o3g685pCzx96mI0/dHENguE2daTXBpYrgLh0cn+WfgnPhOsx4Ad4tPHOuH5DVl
	 jI5vTfxmbYpfzLfcc4fSSDSxqnCQU54Wx74TOOLbonG3fpDlZCCp+9RQjE10eQH+k1
	 WpkCLDsfC75vGblnqkelqHwXxydf2Axg/O2QF+WY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2JfB4d073869;
	Mon, 2 Dec 2024 13:41:11 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Dec 2024 13:41:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Dec 2024 13:41:10 -0600
Received: from fllvsmtp7.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B2Jf8iO127393;
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
Subject: [PATCH v4 3/5] ARM: sa1100: Switch to new sys-off handler API
Date: Mon, 2 Dec 2024 13:41:05 -0600
Message-ID: <20241202194107.105119-4-afd@ti.com>
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


