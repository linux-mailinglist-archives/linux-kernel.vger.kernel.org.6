Return-Path: <linux-kernel+bounces-523227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C549A3D3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50D53B88C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3DE1EB1A7;
	Thu, 20 Feb 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCUyn11Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362181B4254
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041562; cv=none; b=L/F0Qhg7Bs+YtaCeK0Ga6/7feDkpvTjaSIpwC7PjPyDsVuxoHGwdYGNhwy5kfxCFc6wNIN8H9S5QuTyhBstihtLSJWKZgT6iqZ3xMnN6MgFe6WJs2pqH/qx1pgiFCcUF92UEaPSt6ZWdkCV2/fA1jjzh+5meFwULMx5DriEN+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041562; c=relaxed/simple;
	bh=Y7NzkV18Cd4MonJGL+TfuzST8bQlUXHSm0y773ei5Fw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=baaxDDAac+n52Yl+4KyL8AjduVL8FK4QX3dYT83wqQYZBRuX/WVmRSkMJLP3hAAqDPzz1sZeQLe05K2sRLj3pFg9/MqZbRAh46pvlr2qx1Lkhihf1I4IrptekM9Xw8Sfdkcc5lPLreak4hkEptcStoZxMuSgQ4+5xSHqURDWEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCUyn11Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359B1C4CED1;
	Thu, 20 Feb 2025 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740041561;
	bh=Y7NzkV18Cd4MonJGL+TfuzST8bQlUXHSm0y773ei5Fw=;
	h=From:To:Cc:Subject:Date:From;
	b=WCUyn11Z0scIlqVD1QKgKgXObdu7ScyAd60ily/bEVrsO4Y+zBJ7DkLhxa3tShH+L
	 2p3NRk6KosK3Vj8jyAlPrfzk8mwNgXZ0Dsz1g/NBDEK0VEktnJoyOMavg4znFhkVCu
	 WBJ7pWV4/Y/i4vpzXd95ACet5maG3qF1rFzoYGfAoturP4oK6ohlD1d70wCqQIsf2H
	 Okz7fY2xXNQZZArlOfDm6MA7Ei+tZf9mrC8jiBueSg+JrkU4+GABEMN4V8vRfyT7gZ
	 O9T658RT2H60Bf0aBUjrBXCPRxIaC8uG19Bb62+NK7Kmq/Myf5jvphvhNYV7de2NyI
	 P2t5xCEP47Y5w==
From: Arnd Bergmann <arnd@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: atmel_tcb: fix kconfig dependency
Date: Thu, 20 Feb 2025 09:52:19 +0100
Message-Id: <20250220085231.1719249-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Build-testing this driver on arm without CONFIG_OF produces a warning:

drivers/clocksource/timer-atmel-tcb.c:368:34: error: 'atmel_tcb_of_match' defined but not used [-Werror=unused-const-variable=]
  368 | static const struct of_device_id atmel_tcb_of_match[] = {
      |                                  ^~~~~~~~~~~~~~~~~~

Change the dependency to allow build-testing on all architectures but
instead require CONFIG_OF to be present.

Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I saw this for the first time today in a randconfig build, but I think this
has been around for a long time without ever showing up in random
configs.
---
 drivers/clocksource/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 468c882d9228..1dae9a5ce5d2 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -437,8 +437,8 @@ config ATMEL_ST
 
 config ATMEL_TCB_CLKSRC
 	bool "Atmel TC Block timer driver" if COMPILE_TEST
-	depends on ARM && HAS_IOMEM
-	select TIMER_OF if OF
+	depends on OF && HAS_IOMEM
+	select TIMER_OF
 	help
 	  Support for Timer Counter Blocks on Atmel SoCs.
 
-- 
2.39.5


