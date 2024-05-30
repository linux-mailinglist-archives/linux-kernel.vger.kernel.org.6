Return-Path: <linux-kernel+bounces-195533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A928D4E23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A782819BF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B615E17F517;
	Thu, 30 May 2024 14:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SxP13fgI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Zt3GU4BX"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C417D881
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079867; cv=none; b=kdSbnLRW1Uc3YG3FRmTYfo//uW5KpwOuPYsTCu5QULbv/ANT0p4mdlG2lt8k6T5sZBXKDswg7tSOhB8j6ISH46BglJVczr4uVPW40eZB9kzAyNqnrPIte2ZLQfrEhGgII+RvSd26+BPfUY4XZFcwf2lsUGdpyHaIPAYC4ITxt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079867; c=relaxed/simple;
	bh=Hd/kqSDVWjaerU0649WRAuzQ3rjHR4d2hAZJKd4XRPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLVxE4H6Z7vPlpwt1f57mC4F1i/aCYgot7JwmjeQyB+whfecekTZiDcNWNQB25vfG9TiYQs+5oLJ6OzZCUheu0YE6nWM8HjzLF9bQq8G7/TJ7PDtOOc9V+xtwtvtPmJHAMWCd0mMVVy7zFjIBG8TWwPoNAKxFEoY7V0H6oTNNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SxP13fgI; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Zt3GU4BX reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1717079864; x=1748615864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+RNcrHzh6WcQ1ij3/nOnEX9lVFjkLoJCZA6UagyL3GY=;
  b=SxP13fgI9SB1eRAYHCJcu2m3uRKeblYO9RaKhGE87juZ7kCSPAC2ajdE
   oruQs/aoWuRZV4k8vYZn8bohHlndPMT9re4qfwbPzdezMoO4mi4qhrNwP
   z+Rc9euztCDyjXbYumr9JAGFLkDGy9/cW6ifYYloMkNxXjHa8/W9T9MY5
   tBcyu7SwYzBFqIQ/XW2VBxF3wxhgxKtfUJJ3Dc7pWJbNwK4UdhjYu1jAw
   k9eRIKBwOPJtXArcRYq9uA6knoWLR1X6nczegeWHJlXQjFRhg86W9fL/L
   XPOtyEkLzN9h2Bc2d7wKoMa+kNOkmf+ACW9En/3izTmJY48zoi2OLoWC0
   g==;
X-CSE-ConnectionGUID: 7tIcQiyWQ2SwyuQ/0ELpnA==
X-CSE-MsgGUID: /eBcSUNjTae86ULERTy5AA==
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; 
   d="scan'208";a="37145456"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 30 May 2024 16:37:36 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B2DE1664CE;
	Thu, 30 May 2024 16:37:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1717079851; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=+RNcrHzh6WcQ1ij3/nOnEX9lVFjkLoJCZA6UagyL3GY=;
	b=Zt3GU4BXKdbne7lC9yXfqM3IojJq90MdHrexZzn3tmy21JasnwEhPfjiAZnZtJPjEWazVP
	+ME6Ymz/4Vhi+B2pRu2hOB3Vhwj4XzLY7QZFDUxvGGZwx6damyfG5vWdVvHChCFg+1LW8y
	tAN0SWcAfcfTH6gvRxzcRXNFWO/czqflkK9XvadFiFNUiFHBFvRf1KzBDQ0Z2qsMCGx9UX
	ZVXzH5NVpqNWbsZWg2EkZM8LngAq/mal0HRtfLuTPhe993O0SNmEXMhOFBlXWTW/nNu0N8
	Wxh8E6VMUyhK5l64eV/axMJaM1YuimXjcbXFSTVbw8sF7kTzswRCT8QuIkW9OQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ARM: imx_v6_v7_defconfig: Enable drivers for TQMa7x/MBa7x
Date: Thu, 30 May 2024 16:37:22 +0200
Message-Id: <20240530143722.834264-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Enable drivers for devices/features used on MBa7x.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8e93e637ee139..61206ac584088 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -133,6 +133,7 @@ CONFIG_SMSC911X=y
 # CONFIG_NET_VENDOR_STMICRO is not set
 CONFIG_MICREL_PHY=y
 CONFIG_AT803X_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
@@ -180,6 +181,7 @@ CONFIG_TOUCHSCREEN_SX8654=y
 CONFIG_TOUCHSCREEN_COLIBRI_VF50=y
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_MMA8450=y
+CONFIG_INPUT_GPIO_BEEPER=m
 CONFIG_SERIO_SERPORT=m
 # CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_IMX=y
@@ -211,6 +213,7 @@ CONFIG_GPIO_SIOX=m
 CONFIG_GPIO_VF610=y
 CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_PCA953X=y
+CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_PCF857X=y
 CONFIG_GPIO_BD71815=y
 CONFIG_GPIO_STMPE=y
@@ -226,6 +229,7 @@ CONFIG_RN5T618_POWER=m
 CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
+CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_PWM_FAN=y
 CONFIG_SENSORS_SY7636A=y
 CONFIG_THERMAL_STATISTICS=y
@@ -282,6 +286,7 @@ CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
+CONFIG_DRM_LVDS_CODEC=m
 CONFIG_DRM_TI_TFP410=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
-- 
2.34.1


