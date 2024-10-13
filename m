Return-Path: <linux-kernel+bounces-362858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4599BA30
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B069F281B93
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4B146D6E;
	Sun, 13 Oct 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="msMjasvK"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC42233B;
	Sun, 13 Oct 2024 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834764; cv=none; b=QmfgW13da3DiLiRVV/NFtlsEdYJDgEdwtSicunQFvGj5aumcx2ziPUMJcOMCvsbTT74Va1/w6eAXLe1Ptlk6lt6DJdQfD95NUEn8+notjjSuQvYVoyk+uo0YT7vrUQF5i7D1jgJDI5A3+d/gOfeS0gPILg0FuRTcWpUzk8smm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834764; c=relaxed/simple;
	bh=R+liUnQLUiXs/TzzkDL4w9Cd45dKutzbT14EXrrTBcY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dlT+nKm2PGLW+8xH8VXpeI2buQbmAuQp2qjKKwZmw6pwhx6PScFr/qWBkByIwtJ8eTn3hPWtIN8rhkOFo9DrA14hIuPjqCymeQcqP3voltfBJkfbjnH8R3L3/aVM3yTO8BvkDP63m97bShZitt7ZuyG+yzMTeGjQQbFExu7Sel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=msMjasvK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso20052666b.1;
        Sun, 13 Oct 2024 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728834761; x=1729439561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5rcWDuzAT1cWkPvStrvUoyoxPcvB11KzBluywXLg6fw=;
        b=msMjasvKwtPbV7kvs5JCuDp4I5ZhEnYH4WE390TvDYn5tnXVA1aVYbX1/gkh7hBUzx
         sTY9AvBty64R+pzmADug4YVysVJdeBYwIc5FVNg3nYnQt6NUz4YjdWrKEJDqRcVbucQt
         RM+AtxMa4zSwK0GmFF2n9Km7i6SUZYA/d65lO8vpolJ7/0r9x3X8i9e+i7O3DxkPMuNs
         YGsUq1MtDdMtgJuWoRDtq+NS5acTs3AfsDxXiiwUg/mTisMutDlrN+ee6QieMw1B9//P
         qkUS4sqyPp+iyfe13Xyqr5RHyX8HNvyZ/FAO9x8DLWKINv3Y9etUnYg+sPPGsrtPq8vw
         Rblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728834761; x=1729439561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rcWDuzAT1cWkPvStrvUoyoxPcvB11KzBluywXLg6fw=;
        b=InxTxXKLeGHz3pwJgy8wKQbqDP8Svl8gknjIkq/7NnS6kFxnGDg7H9gZ+yDsUyYrSN
         Vm8dNcnxPcP1+++sa2AUstz1D5mXIyC8VuPkniIvu8N1GDw+t1UjL90Zk7KUVBk0W/8L
         XEesk9GAIKRnKzH3k++Caw/gfIce+ATEunB9PArLmzfmLqMk/KJUTox3kyWGpV+MXfNi
         KZWQiCyJCSkC/86/Fmu2mmuLE6akwzJYMHQPMPdfsPwPVfphsEFhiOZ4DyGNAcTqfGTj
         kwobzW83ZQfb1+/X6v5liEtQGEC0x7aKkvbL3oujWGxcj804FgK9h/HceAlUFOUa9Hda
         aQog==
X-Forwarded-Encrypted: i=1; AJvYcCVBo9218xryO7qRlM5a5nLB+a8YQWw3wroKYy3ODrJwIP2lVJ+XPNX+vnd5eS3iifP7xgAMnb1uehfE@vger.kernel.org, AJvYcCWNNV11seGqDKlt0pqJ2GVBaKe5rxRLeuoZWANQtAcac9LxyuRKcjRL65vV7QPqSyl+3iegZKOVS+tnElFY@vger.kernel.org
X-Gm-Message-State: AOJu0YyhrPIgN6k/nLYx0gwr6k8XE1lkW8sv8FNxysEmZrVaX1mlGIrW
	udp3gZixnLLyl61S9UIy6Rg/8CvjjbDh5vtdEb9Jtwlurq5pOEr/
X-Google-Smtp-Source: AGHT+IEj1O8jS8V6YrjgiYlvy+7IPDApkSTule9/hdF2bu3I0CXdsAoQP83/e3cXQFpSo+BGO73mjQ==
X-Received: by 2002:a17:907:6ea1:b0:a9a:8ee:5951 with SMTP id a640c23a62f3a-a9a08ee5b62mr185854566b.25.1728834761312;
        Sun, 13 Oct 2024 08:52:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:ba33:7ef4:2f9b:8303])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99dfa32196sm245975466b.160.2024.10.13.08.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 08:52:41 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add board device tree for rk3588-orangepi-5b
Date: Sun, 13 Oct 2024 17:52:18 +0200
Message-ID: <20241013155225.26259-1-cenk.uluisik@googlemail.com>
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

Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
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


