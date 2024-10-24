Return-Path: <linux-kernel+bounces-379644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5E49AE179
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7921C21EFF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFE21B3954;
	Thu, 24 Oct 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MW/jKM4i"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD91C07C2;
	Thu, 24 Oct 2024 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763561; cv=none; b=G/dp0Cgb0QVRbErE5ZZh2nCSt/WwAMUUQJ3VijZTplnPiivuWF+l9g6/xJ6o9RF78CaEMZmPmdcjQGfRfC8linlONGShx9MjvTZSyKd9PfjaPAspGQGrFY/8mq8UBmRnsKmySqvUdui+7/kkP/mxCMAu1x5IVGEKGL4TnSD5Zro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763561; c=relaxed/simple;
	bh=gw6cjoGag2AV+CT146WlAZpimiuukEZAOJpKiI3IzP8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjIjGtH3wm1bjWs17FlDP8Wzb2AD2aFf9HmR3gnlmKYvcGJywrcnLYqm4qcXorn8/TSUzmCyxGslPkCC6daAgY+Jxdow6NYGdknNBV7UziqYgV5pKFJ46ZvEY1ZvfL7ZO6CKLco1T2706zxc8ebscxHMDJr5t1hZC9KdR2e1+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MW/jKM4i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so497589f8f.1;
        Thu, 24 Oct 2024 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1729763557; x=1730368357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnCDGJfcN3PLmfYBMIFGhUBG768VdNHJJP6i96p6xYA=;
        b=MW/jKM4iRY4+AmfYacNUiqao6uNxq3wni5z5ZE2r/dD99VaNUcDcmuuyx1aqL1BRpH
         /tFLrVqlRU0RPNa89f2fwNaZQ/rFZaODSOK7E7blBB8MuIQ5ZZERCjL+9lSAPCsdi9ux
         uv3fFNqUs1ld0BwJv6cIIc/A0vwfNDM6cRbOpX3qJ6jCjY1XI46hzmBy65SmnOUf1aBd
         EjdDRFPWsGD6osltxldtVQdL1k5nfcjvFouHU+y4O2fUsxBpePf12AC7yFFIkjzBnkUZ
         TOsjWHn9onbETlTbJAYOSH545Rf6zqJ6PJcCIrry8qCWI9Y88Xn/Tje7n3sZa9H82rBu
         uNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763557; x=1730368357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnCDGJfcN3PLmfYBMIFGhUBG768VdNHJJP6i96p6xYA=;
        b=XAsyCeUr40DxJRMM8jlsScRANR/bqO3r8tPkMC3qvfjkzrsS3zfCi3ZdNP1u2p1UdA
         bbMeScfheZqqSwzx7Ze/F9dN9tTwLO9FGlaEYpvFsRK9FMNvmLNaef39FBbRxDDfg6Lv
         09F9/S8fwvJPGfkArzDNNgPVL8jlwvc2zmuGBsUfwl7QDflqEXAo3gnFugzNzZbR0TqN
         IT99KAXnJ7lw1XEHvaOvr+EBO0zdZG6RXcRT4Mv11Km1HoGEpSkhuw5h7+gK4gFB+xw/
         CxriSWLiCMmDQPVVif3gubXMZXyt//6M0SdwTRqptpV8FsEm+QPiisI6O0/5I1BJHOxC
         7NSg==
X-Forwarded-Encrypted: i=1; AJvYcCUwXA2P2fYYiRGPXaMhzJ7G4uSCkZ2gl/BQehg7XSw/YvdgNvsLSOI/oEcGs8vlsuLo/7FtppwZxRLI3ocX@vger.kernel.org, AJvYcCWkTxeaXUowsEIc3fKbAXlcNU290sFcdhuAy/uHqoYvwx2ekf2adLQ0Kw+aUp2QB1qTcFWD/tr2KouE@vger.kernel.org
X-Gm-Message-State: AOJu0YwvjpEVLMR7MBkudu9sTSMs5KOE6sG7R/1o6gw0gOfmIh+A12JL
	dmkhLrcE6q2SsGI3uEIHFrTOfAZkHyX3E6JSwgEbW6mUIk0xo02w
X-Google-Smtp-Source: AGHT+IHOGIh30cZeVBaManyxCwsLnI9f8EReanEFaNeNhbdtE6TT2V9YrSK8ERkjOnhQ6SSbt3KcFg==
X-Received: by 2002:adf:fbca:0:b0:37d:377d:c7b0 with SMTP id ffacd0b85a97d-37efcf0699bmr3536455f8f.18.1729763556938;
        Thu, 24 Oct 2024 02:52:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:e265:6c8b:f62b:1474])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37ac4sm10996286f8f.6.2024.10.24.02.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:52:36 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/3] arm64: dts: rockchip: Add rk3588-orangepi-5b device tree
Date: Thu, 24 Oct 2024 09:50:22 +0000
Message-ID: <20241024095038.42079-3-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241024095038.42079-1-cenk.uluisik@googlemail.com>
References: <20241024095038.42079-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implements a slightly modified rk3588s-orangepi-5b.dts from the vendor.
Unfortunately the &wireless_bluetooth and &wireless_wlan are not
implemented yet.

Therefore add the sdhci alias to be mmc0 on the rk3588s-orangepi-5b.dts.

How is the Orange Pi 5B unique?
  - the Orange Pi 5b uses combphy0_ps for the WiFi.
  - the Orange Pi 5B has GPIO0_C5 hooked to BT_WAKE_HOST.
  - builtin eMMC storage
  - ap6275p Wifi module (like the Orange Pi 5 Plus)
  - builtin BlueTooth module

Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
---
Changes in v7:
- Set sdmmc to mmc1 (because this is now reverted in common .dtsi to be
	mmc0, to avoid breaking changes)

 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi | 11 +++++++++++
 .../boot/dts/rockchip/rk3588s-orangepi-5b.dts | 19 +++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index e641033d2..2e485553c 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -160,3 +160,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-odroid-m2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5b.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
index 5ef0ccfcf..0573b8f2d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dtsi
@@ -400,6 +400,17 @@ &saradc {
 	status = "okay";
 };
 
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	max-frequency = <200000000>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	status = "disabled";
+};
+
 &sdmmc {
 	bus-width = <4>;
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
new file mode 100644
index 000000000..d21ec320d
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588s-orangepi-5.dtsi"
+
+/ {
+	model = "Xunlong Orange Pi 5B";
+	compatible = "xunlong,orangepi-5b", "rockchip,rk3588s";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+	};
+};
+
+&sdhci {
+	status = "okay";
+};
-- 
2.46.1


