Return-Path: <linux-kernel+bounces-224974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F091912955
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92AD11C21D80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7B7D095;
	Fri, 21 Jun 2024 15:21:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7796B4EB51
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983279; cv=none; b=aI/VVQwBkn3sfHo7RBU1yc7tbpIuEUFNBYVkacyc8FbYZ4Oej8v3AUcnByvdcDRHZVWROWFAd+vygtu8g0P7k5I3UoQrHe7Pp6pUgGlniejzWJh1kzMPnBBgz1fpJD4VUur0iradNp9HpXq2ksAQ08Y5opW1jLgEDRWb6P2x5d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983279; c=relaxed/simple;
	bh=PA/4Jt+uZ9BVn9W11/ioyDi0MwIWlu6jd0biIaDvqJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p/iKOyo0PeOu/beovXTPstsvJ6nSYDzoRwwfe+3qTsIDKvI6B7+qcp9DrV73QsqiVSULotC+OaoA/p0GxPUu2qq+Z2qX6sCZk4eFsQJqixPjj5/MIr/iBAkSii8hzM3oQjt1fTS/wEP0L3lovcpIQZrzTLuy2F0egltNq06eCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKg4f-0007eK-CK; Fri, 21 Jun 2024 17:21:13 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 21 Jun 2024 17:21:09 +0200
Subject: [PATCH] reset: sti: allow building under COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-reset-compile-sti-v1-1-b7a66ce29911@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAGSadWYC/x3MMQqAMAxA0atIZgO1SgevIg6SRg1oK42IUHp3i
 +Mb/s+gnIQVxiZD4kdUYqjo2gZoX8LGKL4arLGDcbbDxMo3UjwvORj1FqTFkfXeG3I91O5KvMr
 7P6e5lA9hQLaqYwAAAA==
To: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The STIH407 reset driver can be compiled without ARCH_STI being
enabled. Allow it to be built under COMPILE_TEST.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Makefile    | 2 +-
 drivers/reset/sti/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index fd8b49fa46fc..ff716f9afc84 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -2,7 +2,7 @@
 obj-y += core.o
 obj-y += hisilicon/
 obj-y += starfive/
-obj-$(CONFIG_ARCH_STI) += sti/
+obj-y += sti/
 obj-$(CONFIG_ARCH_TEGRA) += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
diff --git a/drivers/reset/sti/Kconfig b/drivers/reset/sti/Kconfig
index a2622e146b8b..0b599f7cf6ed 100644
--- a/drivers/reset/sti/Kconfig
+++ b/drivers/reset/sti/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-if ARCH_STI
+if ARCH_STI || COMPILE_TEST
 
 config STIH407_RESET
-	bool
+	bool "STIH407 Reset Driver" if COMPILE_TEST
 
 endif

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240621-reset-compile-sti-ca6c2ddd0c63

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


