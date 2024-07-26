Return-Path: <linux-kernel+bounces-263834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6993DB2E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BD91C231DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783014B07E;
	Fri, 26 Jul 2024 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RXtEjK5w"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BE17BDC
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722037208; cv=none; b=TfgbVqvBROBF0rCEXm7HuPGrh3goH0zGgaOjkoWa6gqFiuflmodztePIRJbutRnWPYLx7NZ20dTyegZvNKqJ+L57lirN6auuHFn55T6WjYySthOICYw5b0CTmru+ok4eNZdapNipaCDmRK3dI6kGmFbKMo8paCuG9K0AV4FGx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722037208; c=relaxed/simple;
	bh=Q3fSBrrZPqa7egg3tBbnZ2O+IC+t6/YBZYgNqr3XajM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NXuF/WfRZMYpceVsV9MuJDrvg5fVHRH9hoaW4A5gVnN0kJldgiMxDAKPAOp76oHn5Ufw/nWTikGvhqF3EXq1fQFrvQ/V/hnRRq3YZbTnsC940eIX+Kp+Ir2iqCkuXpD1iNx8YISloXWDkHIVwM40uvswqLpzYKhFGNL/iNLkDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RXtEjK5w; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8CDD3C0000EA;
	Fri, 26 Jul 2024 16:34:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8CDD3C0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1722036861;
	bh=Q3fSBrrZPqa7egg3tBbnZ2O+IC+t6/YBZYgNqr3XajM=;
	h=From:To:Cc:Subject:Date:From;
	b=RXtEjK5wE8jp1E1nvkXsVb6JIyfwDv0eKqjLCQj3AQ2G2m4EB9Hk+vEyd6aSrIX+Q
	 N4/of2gUW7F0+o7PsI7k9fFIeIwdfrxx8DuIYReaHObg6AxiSrnr6nI9qXR0asFhRq
	 BRdC91amH+yX2gN6BwK9z2LIhIlLFTTkvIvV80Po=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 01C4218041CAC4;
	Fri, 26 Jul 2024 16:34:18 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: bcm: Select ARM_GIC_V3 for ARCH_BRCMSTB
Date: Fri, 26 Jul 2024 16:34:14 -0700
Message-Id: <20240726233414.2305526-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of recent Broadcom STB SoCs utilize a GIC-600 interrupt
controller thus requiring the use of the GICv3 driver.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7318d8789e24..24bc6e18d806 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -185,6 +185,7 @@ config ARCH_BRCMSTB
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V3
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select ZONE_DMA if ARM_LPAE
-- 
2.34.1


