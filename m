Return-Path: <linux-kernel+bounces-224984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2970791298F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3CD1C260A0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFD884A54;
	Fri, 21 Jun 2024 15:24:52 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012581AC1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983491; cv=none; b=pSq+Ihrifn8u21aEhtmVbzX86gQ1LMnXzsNtZD7vDdwvO6aas9FnqGL1MIS8mD36dffjH/1YGdbNv71jwKmNgn7NzRvmTE27Fgh+5SspQQlRVhNf+5d0svmsMSkTlIGt5wLQdWThn94MXk3ppM3+D6ItXC7Cjv4XyvZhWi788iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983491; c=relaxed/simple;
	bh=S8K2wQr0lkrJTD04cxS37uS9JhPOcydaq6dpbxgMClc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tROixBTENKOlbj3J4Do2zpMBLDs3jet33MfmxFPSpAj0z+ZkfLAoqI2Bm26nX3rutpm4HJyD8zTzNKpJZTEMyj8i0THdwGZDb1hmDf03jk7uNOixFzZF7YDASyUTpW3EbdrWoA9juUfpoMHc3w7MH7Qw1ebVYL8AXJrbiajsz+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKg86-0008LY-O5; Fri, 21 Jun 2024 17:24:46 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 21 Jun 2024 17:24:47 +0200
Subject: [PATCH] reset: zynqmp: allow building under COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-reset-compile-zynqmp-v1-1-ede43ab18101@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAD6bdWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyND3aLU4tQS3eT83ILMnFTdqsq8wtwCXbNUs6TUlGQzU4vENCWg1oK
 i1LTMCrCx0bG1tQBlky5oZgAAAA==
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The ZynqMP reset driver can be compiled without ARCH_ZYNQMP being
enabled. Allow it to be built under COMPILE_TEST.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig  | 6 ++++++
 drivers/reset/Makefile | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 7112f5932609..9b914f8818ef 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -328,6 +328,12 @@ config RESET_ZYNQ
 	help
 	  This enables the reset controller driver for Xilinx Zynq SoCs.
 
+config RESET_ZYNQMP
+	bool "ZYNQMP Reset Driver" if COMPILE_TEST
+	default ARCH_ZYNQMP
+	help
+	  This enables the reset controller driver for Xilinx ZynqMP SoCs.
+
 source "drivers/reset/starfive/Kconfig"
 source "drivers/reset/sti/Kconfig"
 source "drivers/reset/hisilicon/Kconfig"
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index fd8b49fa46fc..544ae3488e3f 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -41,4 +41,4 @@ obj-$(CONFIG_RESET_TN48M_CPLD) += reset-tn48m.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
 obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
-obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
+obj-$(CONFIG_RESET_ZYNQMP) += reset-zynqmp.o

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240621-reset-compile-zynqmp-6e6bedc658af

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


