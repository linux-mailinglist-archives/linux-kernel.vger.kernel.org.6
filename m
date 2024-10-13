Return-Path: <linux-kernel+bounces-362853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0999BA27
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06946281A02
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9892146D6A;
	Sun, 13 Oct 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZK2Ib4f9"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0477143890;
	Sun, 13 Oct 2024 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834085; cv=none; b=JHFWtI1OcgbZ5pnQe4k7MZqsAPdV8vLwVD0moHsm5IArOYSFxIWLFGFCV5HEScbFwK7tGecPfcUjQT2KbQeQ/O0vrvLDn/PEq4j2+0Vafq2QZdhajLw0+H4ToyxP5zFTIv4vY3kpry16bFJnQeLxRcDaBHZY7DAFdm6uNINykgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834085; c=relaxed/simple;
	bh=cfzq2KgRElwGiNITo9B21QIYNm/V2uqoAmrYPShePWs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jPO65Z3xKjehAGFOdZhUlB9dUR29AAeAsgcevjDb6fI55zP7FyJ6a9IOT+oWhDWaRsBNAC+nTLIDYY/WqC6Znns46w/YcYr2USuXor+R1LvbN+cyqfUTxHPyA/BQ/5c5b9siTOMtWLx2OEN0JIpdaWi/O73fKDH1K3PqlOrNxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZK2Ib4f9; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43116f8a3c9so38390055e9.1;
        Sun, 13 Oct 2024 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728834082; x=1729438882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CsPJewwB5IvvxkmdERVsHKdiFqgiQNMaWLL2puTpWUk=;
        b=ZK2Ib4f9bZaEwjq8ryK9zFaCIzHIPXkv9T/YBtqklGnBHtz8lhE2qmRGCaHbsdbMNv
         ZFxVCVDRoVvjoVoRLGcav7tqGBq+iVaD+U03dH4pCCs6/rzOpv4xry/+QuR8nMxXO4Ps
         8eHWvrN75podSTO9fBLmudz4uiHvVN0AeN6fVr5Of55ijsj7zQZINik1RlAdSJ9teeCV
         Y4aV6+HiYgXaX2hLXJ/tGhGg+k3N4IFZvvqL5qDIi13c2z6+dxhh1zXYX98FtY7u+AGB
         R6pBg4b8WRtzKAXDODbA18tj+Ypp5EG2oz7NNn9Pm1dBsrfDZDJq3qJYQ97rRjgB9k54
         +FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728834082; x=1729438882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsPJewwB5IvvxkmdERVsHKdiFqgiQNMaWLL2puTpWUk=;
        b=E2U52E3g380S9yH3MQspu6nhMyq+41kcdH0I69fFyirwubHw2TxecNXXOZYnbloOfJ
         05q/YowrqzP6+3sZT707pOGAIT3Z0TsTrFPLZw5gonde44jEC36s5UIdXhJe7KY3sxSO
         vEp7GsOMweqMS+uRuewVtO+ZzUsZa/Au0VQqf03zb45clgvKNvo0EistNMHgBZCMT6eV
         s3V8TJ7MZWOhvoMgouj3VqVxLswCp+C4m/bZnKuxT5Gra7G5fTzfjYOUMbR8TJEENZ4r
         voq4NSQJwWVIf5bS8/WvnJyyn7rHOpmxTlKscMxPD7jVefmvKn97NKXuXmewSSJnDVbJ
         6NWw==
X-Forwarded-Encrypted: i=1; AJvYcCVTb7ffTbfo/2xnXko/WDThrtd2FdT1V82KyiMEWfdNJbuJVji7LQrLX8SgrOEqq+D3slZHu/pT3o5+@vger.kernel.org, AJvYcCVxDbIaoamKKtTGeoThzTHF1dT+WVhlC0vqLYyQD7EnRK/C9ldgzJSJJKfX2fseg38jAjODbDn9ragudRAO@vger.kernel.org
X-Gm-Message-State: AOJu0YxprOo6YdkILR8aQe4vPsW+NtSprFRB8Xw36sN1NCWL9pFpK3an
	D4Z+4lX39WGjPNMXt3kHES1fKi+YKS17PqTmd5opkBtybuqXcorkgnxIM2r2
X-Google-Smtp-Source: AGHT+IHgrEYi1YlHIlrkzs6Td76e71adRbBemav3YpY8doMdMxvf1ZX1XZ42XIn1qpbvJ7sKKdys6g==
X-Received: by 2002:a05:600c:444f:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-431255e03d0mr71238585e9.17.1728834081649;
        Sun, 13 Oct 2024 08:41:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:ba33:7ef4:2f9b:8303])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0e83f83fsm27498466b.125.2024.10.13.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 08:41:20 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	"GitAuthor: Cenk Uluisik" <cenk.uluisik@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5b
Date: Sun, 13 Oct 2024 17:41:00 +0200
Message-ID: <20241013154107.25017-1-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for OPi5b that includes support for USB2, PCIe2, Sata,
Sdmmc, SPI Flash, PMIC.
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../boot/dts/rockchip/rk3588s-orangepi-5b.dts | 26 +++++++++++++++++++
 2 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 09423070c992..45249ce15175 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -154,3 +154,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-odroid-m2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5b.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
new file mode 100644
index 000000000000..107b65a5e7ea
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588s-orangepi-5.dts"
+
+/ {
+	model = "Xunlong Orange Pi 5B";
+	compatible = "rockchip,rk3588s-orangepi-5", "rockchip,rk3588";
+};
+
+&sdhci {
+	status = "okay";
+};
+
+&sfc {
+	status = "disabled";
+};
+
+&wireless_bluetooth {
+	status = "okay";
+};
+
+&wireless_wlan {
+	status = "okay";
+};
-- 
2.46.0


