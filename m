Return-Path: <linux-kernel+bounces-339494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2F9865E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746D11F21525
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F4E82488;
	Wed, 25 Sep 2024 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="nOAWnNwi"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B2D520
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286291; cv=none; b=miFFv1CEOINrZz+zvsWwKkuZI/dGGqpFlKC+KIMcrsVvIwFK7Mu5RIpkCgCLyO/3orJpNylgvmk4JZIErOlpfZ7BKOIC+eXTgM828TwUQyAEDNffbEEoLCsAunamSlDgiVB78t2LOo/0YImaEoUyMm5mqVkDC8te6oj8/J8Se1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286291; c=relaxed/simple;
	bh=caFjqUKTTKYo3ARfDI2wUHa6fkmv8GVAarYg8soFnIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IBAb+ygmRfVneoYrz9p2lytaIE9LsABluOCM2wRNl2+hJgzWfw0p3Wd+2GBm9YfV2VgumAfUFXdM3EQj0YU6O4/uTuo0570hiequCB1cjyHz4ygxcxTLlJlFcy8tSuHnRcyEbfP24vYj3oXkgD3w8yb0f4qZ4uuhjI+MHHYVibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=nOAWnNwi; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 55D88C0000E8;
	Wed, 25 Sep 2024 10:38:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 55D88C0000E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1727285894;
	bh=caFjqUKTTKYo3ARfDI2wUHa6fkmv8GVAarYg8soFnIc=;
	h=From:To:Cc:Subject:Date:From;
	b=nOAWnNwihO9FMTacLPkraX34LZeWz1vAzsQ2ncbDYbalmFHWakNXJxlxd8076eAdr
	 zKgx0zWHzKr5NWGBExqazR1y8Pefb9+x1fH4eClfh/zo+KpDE1sM8YuL9QGP5PyACj
	 cCMf4sLNfOiEfok3ldB5P8tLgQDeW6p1ClkBzzF8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id F200518041CAC6;
	Wed, 25 Sep 2024 10:38:13 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM SUB-ARCHITECTURES),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: bcm: brcmstb: Drop custom init_irq callback
Date: Wed, 25 Sep 2024 10:37:58 -0700
Message-ID: <20240925173758.29224-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default is to call irqchip_init() in the absence of a machine
descriptor init_irq callback.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/mach-bcm/brcmstb.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/mach-bcm/brcmstb.c
index 43bc98e388bf..27948b515993 100644
--- a/arch/arm/mach-bcm/brcmstb.c
+++ b/arch/arm/mach-bcm/brcmstb.c
@@ -23,11 +23,6 @@ u32 brcmstb_uart_config[3] = {
 	0,
 };
 
-static void __init brcmstb_init_irq(void)
-{
-	irqchip_init();
-}
-
 static const char *const brcmstb_match[] __initconst = {
 	"brcm,bcm7445",
 	"brcm,brcmstb",
@@ -36,5 +31,4 @@ static const char *const brcmstb_match[] __initconst = {
 
 DT_MACHINE_START(BRCMSTB, "Broadcom STB (Flattened Device Tree)")
 	.dt_compat	= brcmstb_match,
-	.init_irq	= brcmstb_init_irq,
 MACHINE_END
-- 
2.43.0


