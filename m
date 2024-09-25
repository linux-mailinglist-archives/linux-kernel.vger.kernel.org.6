Return-Path: <linux-kernel+bounces-339495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD84D9865E9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE25D1C2480C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E3F78B50;
	Wed, 25 Sep 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="pllh3hS9"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31201870
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286397; cv=none; b=tMBIr1l3qWJ7lLfiqoFzy+5QEHJxKWbuf6R9Y3h4Uu32BCvQhH7nGpzd3K+E3e84TgjolNOjNRWduoD0VsxbDL0/gLl6J2pDkaCXMIgSEj+mCE2KYoRL1tPA/ghd8ZrDRNeEcTmtYQGmPh2/aWuhb2GJ4FWGa7t9w9OaaaETmms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286397; c=relaxed/simple;
	bh=caFjqUKTTKYo3ARfDI2wUHa6fkmv8GVAarYg8soFnIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCjSFjZ0tv35HEoA9qadgM8lzoaq5B7bqWBXxqyVwon4kWlJEfuOIClbZjoWfBSTIVnuidExyUhFLsK7lIdSQyTRIhdLSxlzhJfeLnxZDHBz/QIJMrBei5QXOEQBS5RrdEjmtitQaNKEnbf31UaRfmL5L7nOVsLI42nfSiPL5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=pllh3hS9; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 70FDCC0000EA;
	Wed, 25 Sep 2024 10:38:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 70FDCC0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1727285921;
	bh=caFjqUKTTKYo3ARfDI2wUHa6fkmv8GVAarYg8soFnIc=;
	h=From:To:Cc:Subject:Date:From;
	b=pllh3hS9zoX7zSOuuJkwjw7ku3qZEEsWBeUEhB2ZLDrBdE1JJ1EPCCH6nZUB+JNnD
	 kzTlAP6TeVfTfjSGjJ6hcx1lclWbTKf/8CfCqa3uOh59c1i46mpSgH+5b8tWNUNySz
	 F/19XKrot6XgHNXWLs5IMpf3FItnLwwDt21DWMjg=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 244FE18041CAC6;
	Wed, 25 Sep 2024 10:38:41 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: bcm: brcmstb: Drop custom init_irq callback
Date: Wed, 25 Sep 2024 10:38:39 -0700
Message-ID: <20240925173839.29315-1-florian.fainelli@broadcom.com>
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


