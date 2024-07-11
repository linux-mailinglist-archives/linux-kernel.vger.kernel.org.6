Return-Path: <linux-kernel+bounces-249368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC5492EABD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C991F22890
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E01662FA;
	Thu, 11 Jul 2024 14:28:51 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAC15ECCA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708130; cv=none; b=LnnnnW8/PcC+qV+vW++OhTgaxRAgqNCBj6CM3v24qj7IVBUvu4WOu1UmE97d2B8RzO6XtNPPN1eWTFO1EDkGWC9nF0fsvKz6bI2X+D/qfsmcd/DadvwtI8/fblcHejcGQZ0i6Vc81qpkqm9Y0ayHKKJ+sBBkcKd+dWAiNpysOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708130; c=relaxed/simple;
	bh=eiSasGCrA3fKd8PFdd7iVlxNpta3/jrT40usetjF85o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=esnUK+6Swq9ysAGlY5MxsTzmJYWShArKLkzlVHPCCoi4J8FjEy4MtOaueGSGsD7gCHjXWp3SlNd+fWQcammbZ4JbOQ/4kAlMlBbShvULyDfqo5z1yu3aYMgOfSQPSgx4zPK1czHRC+x+frkaPyvIMwKX2XGEtOGJZ0aaxj6Gf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:9b6b:6da0:997b:7165])
	by andre.telenet-ops.be with bizsmtp
	id mEUg2C00546XLxg01EUgre; Thu, 11 Jul 2024 16:28:40 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRumY-001kQg-Ff;
	Thu, 11 Jul 2024 16:28:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRumm-0009sm-0p;
	Thu, 11 Jul 2024 16:28:40 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] platform: cznic: CZNIC_PLATFORMS should depend on MACH_ARMADA_38X || ARCH_MVEBU || PPC_P2020
Date: Thu, 11 Jul 2024 16:28:38 +0200
Message-Id: <80e17dffa8f4c1d3fdedd4d82df3a722aa4044ff.1720707932.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CZ.NIC's Turris devices are based on Marvell Armada 385 or 3720, or on
Freescale P2020 SoCs.  Hence add dependencies on MACH_ARMADA_38X,
ARCH_MVEBU, and PPC_P2020, to prevent asking the user about these
drivers when configuring a kernel that cannot run on any CZ.NIC Turris
system.

Fixes: 992f1a3d4e88498d ("platform: cznic: Add preliminary support for Turris Omnia MCU")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Perhaps the dependency on PPC_P2020 should be dropped?
---
 drivers/platform/cznic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/cznic/Kconfig b/drivers/platform/cznic/Kconfig
index 6edac80d5fa37762..70f5e683f61f2708 100644
--- a/drivers/platform/cznic/Kconfig
+++ b/drivers/platform/cznic/Kconfig
@@ -6,6 +6,7 @@
 
 menuconfig CZNIC_PLATFORMS
 	bool "Platform support for CZ.NIC's Turris hardware"
+	depends on MACH_ARMADA_38X || ARCH_MVEBU || PPC_P2020 || COMPILE_TEST
 	help
 	  Say Y here to be able to choose driver support for CZ.NIC's Turris
 	  devices. This option alone does not add any kernel code.
-- 
2.34.1


