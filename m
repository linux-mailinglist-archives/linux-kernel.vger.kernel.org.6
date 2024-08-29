Return-Path: <linux-kernel+bounces-307055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF8964761
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87751F214E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C81AD3E4;
	Thu, 29 Aug 2024 13:59:06 +0000 (UTC)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [195.130.132.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98818CC1A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939945; cv=none; b=I52ajUMhp387Dk3N7Y7LREYyQXDL+GxCmxc8aHNI4HP1aKzrLMdqMt1YiF8ptFOoz2GqkYCua8ipDDRa77+xh1WMYawW4an7fQDWS5Cg1Lq+FhdbQRH9Er/pMCMJI19uiUFSXD7wFr8IHDMr9/Zt6iMnuppMaQ2sDwurU9qjUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939945; c=relaxed/simple;
	bh=2ZzzzbFibssxKlI8fgEo5y/RMIwq+8GMREcd6JnM4T0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u5cPL1zLWaiysOVrfTO99ZhcZ3eKhA1HcOGAZdokvUE2TTIyBUPkihD/qd6IkrmTaaTTIz57VXydJ16H9WgL0VuIuq56Pb9x+Mpo6EpMqGS7ub3PwvF/8UUeqYV6WRAvowZVu92B+YaIP+CIJFidqMjlwhrwbvEaqZiOmGu0TQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fbdf:b855:e99a:9ec0])
	by baptiste.telenet-ops.be with cmsmtp
	id 5pyv2D0010Yrr4n01pyvfB; Thu, 29 Aug 2024 15:58:55 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sjffo-001GSq-5f;
	Thu, 29 Aug 2024 15:58:54 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sjffq-0002Ze-SV;
	Thu, 29 Aug 2024 15:58:54 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] mailbox: ARM_MHU_V3 should depend on ARM64
Date: Thu, 29 Aug 2024 15:58:53 +0200
Message-Id: <a391c86658d6c2e6d1aee583caa7a030731596d1.1724939823.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add a
dependency on ARM64, to prevent asking the user about this driver when
configuring a kernel for a different architecture than ARM64.

Fixes: ca1a8680b134b5e6 ("mailbox: arm_mhuv3: Add driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 4eed972959279a07..cbd9206cd7de34c5 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -25,6 +25,7 @@ config ARM_MHU_V2
 
 config ARM_MHU_V3
 	tristate "ARM MHUv3 Mailbox"
+	depends on ARM64 || COMPILE_TEST
 	depends on HAS_IOMEM || COMPILE_TEST
 	depends on OF
 	help
-- 
2.34.1


