Return-Path: <linux-kernel+bounces-228898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F675916864
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01ED1C21FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1891581E0;
	Tue, 25 Jun 2024 12:51:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95C156646
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319908; cv=none; b=Xev0zgEPvq+jvErHY7n2WkA+uxtMFo4tfCQPJbQbCu3tFhulAls+xUuraxjJizspFPWjmI9PugeFTX7joTt+jWNKX8dEd22uY2Jj5Xv0FHN+eW6dcZDzyXFevs42ZliBDXWl55bNg8U8Ff5Ap0ZTCYmbEaNRpS6Fndp1Z6gJc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319908; c=relaxed/simple;
	bh=5wgmUWPtNHEugHE9/ecP9fIUWqYMmyFgWiaSpdA3veQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EGe/fiLWVLZjCp2V+xEsGGBlJWC4pvuFC7+SBoUfrwi4jXjU/WJ4HcelfIXY89OHg8G0Ggv++PhB6AuXI1pgrbbEU/HVEn3TpwJLZ0qdmEJmAVDNk0O4LMXK3QzLTurSB6b/YX9uneRcNwvLAZaLMMWnY0APiVsl+6zFLA8C8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sM5e9-0006jk-Cm; Tue, 25 Jun 2024 14:51:41 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 25 Jun 2024 14:51:41 +0200
Subject: [PATCH] reset: tegra-bpmp: allow building under COMPILE_TEST
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-reset-compile-bpmp-v1-1-647e846303d8@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAFy9emYC/x3MTQqAIBBA4avErBsoM4WuEi3SxhroRzQiEO+et
 PwW7yWIFJgiDFWCQA9Hvs6Ctq7AbvO5EvJSDKIRslGix0CRbrTX4XknNP7waDonlZG6t1pACX0
 gx+8/HaecP6DiP3tkAAAA
To: Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The Tegra BPMP reset driver can be compiled without TEGRA_BPMP being
enabled. Allow it to be built under COMPILE_TEST.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Makefile      | 2 +-
 drivers/reset/tegra/Kconfig | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 1b814f08fed7..27b0bbdfcc04 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -3,7 +3,7 @@ obj-y += core.o
 obj-y += hisilicon/
 obj-y += starfive/
 obj-y += sti/
-obj-$(CONFIG_ARCH_TEGRA) += tegra/
+obj-y += tegra/
 obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
diff --git a/drivers/reset/tegra/Kconfig b/drivers/reset/tegra/Kconfig
index e4a9a389e98c..4a2d26d1210a 100644
--- a/drivers/reset/tegra/Kconfig
+++ b/drivers/reset/tegra/Kconfig
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config RESET_TEGRA_BPMP
-	def_bool TEGRA_BPMP
+	bool "Tegra BPMP Reset Driver" if COMPILE_TEST
+	default TEGRA_BPMP

---
base-commit: eb5d88b1538850c6d9ddfcd0b59dc7c84831b530
change-id: 20240625-reset-compile-bpmp-b3f46b475c72

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


