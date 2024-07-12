Return-Path: <linux-kernel+bounces-250936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A992FEC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42691F22FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A3176ADE;
	Fri, 12 Jul 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKCNMaKf"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A8E176AB8;
	Fri, 12 Jul 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802800; cv=none; b=XN7P780mZKlhTxTuaby2DoCylCrdH5kmnPnSXud6b0atc8ljsqWEDJq5j51BI3407WnLDg0WtZtwsBVoa8sy01s/4yLuKs2TRGkceSAcHQzO+1RpaDYgE6kx9FYunztAzv+UP4ASUTFzb3NT42AuIdGgwRFwDzTtzJm/ehW/8L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802800; c=relaxed/simple;
	bh=Tnv+wPkl5iedsiSRgZoWfPlkEv8VDVaevxoFB/n0xC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdOVNxFkOHOSp2o00PZ/+ak7DTNztIiyjsNQOUK3744H9LnnO5Zzu9+4axizBzwMaT0ExR0cXbL1APp/xiwQ6302ry1od3nniOv1DwfzZ+3kvckJe+cM4f76UOfL1FzrH6s/W8IeTWh6K1TKrt5uUMMDlH6kotaF4XLvFW5ezcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKCNMaKf; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70b09c2ade6so1792092b3a.3;
        Fri, 12 Jul 2024 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720802798; x=1721407598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=78IepMnmU/3kKOZs1MFUObqCBdnDJ+SvmFkmQ0mtZdQ=;
        b=FKCNMaKf7yHHbuiEVYMZ30Dw15peJJm5cKZf0Ubq2b71HBrCGqOwMy2HeqRvjsEtzD
         8hUJXJ+vDHjUgQriqd1UL7zyB3kkyCSpfvMCG3vcyhtI6iexi2toI+W3M5Vcw9gLemNW
         H4GMaTzi2kYrDdCP//kWyFY1Sefqzc1aJmY86awJSGieY0A0HKok7EwRmQad12ueWWE4
         ScDX1JsDLpIakUwz2Hn5CCGuI0U1TOdPHdw7TqUktYGXT8vZYy/YoFfiCJg+xlckbSEz
         je+tYL9/CWQtxfbs6cQu38wQBY4q1j12ZE6faBdTnYKC+pX8Ys/hR/CClzjyZKrpdfYu
         f4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720802798; x=1721407598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78IepMnmU/3kKOZs1MFUObqCBdnDJ+SvmFkmQ0mtZdQ=;
        b=dvVCDwyZ8jqc7e6fF0/iRo+LrS2BDVOYHQzIimWjFrBYrWjywa+NWQYtGiOjyqvtOs
         4jLRBAcEWeuiEoAEEaPrekMxxjR893qfHs4UdxdFPyPkdOcDjjR5Vt+wfBoCqqI27vMg
         L9Zg3c+mrBd56eLPwQgQHH1wGt63OhwFClF2TFTbhDGKheBjIUCy3bYELnQTgBDogbZ8
         Abqk+fzCICZk9qQ9tYtNNVWyIueNWzmVk8Qs1leXsf8EwWV/3pFl58xIqdHsOWYoN2Oy
         sTIbRmRO6GwvQjpGvpiAm9QJJzNcYNTooD9VIVN/XG4wyLI6ptKOdfFja4Swrd9fNiu7
         jf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXp2Fjw7y1MsxLqonhGNXJqDO6/TrfebsVI2pekoMajpLso7mS/oj2RnatSD3ozKhahZ07CLCL0GHrscvyxqrFlW0BzIy9FWiDMU/UqcLPxw7k0GlkkT/6E/Q6T6kzKrO9arW4nw9d/PQ==
X-Gm-Message-State: AOJu0YxcZft+ZMN++oVsVpjVMiXDLrvdvOYvdB7fPZhAqD1QZEkhvYoT
	XHFvm2xCSBGz+g5mlPCmPlpBUGu+4I6fBYLoj4CLt6oWBogeG4iHoH02GA==
X-Google-Smtp-Source: AGHT+IFmaeWr7wFpB8oCJawosait80Yrc0MOzrvGc/xTpX5SwheOPSjGoN3sw7j+RsF+hUMJx6wSrg==
X-Received: by 2002:a05:6a20:258f:b0:1c0:d9c9:64f9 with SMTP id adf61e73a8af0-1c298243af3mr13027593637.36.1720802798295;
        Fri, 12 Jul 2024 09:46:38 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cacd65a663sm1765436a91.40.2024.07.12.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:46:37 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <linux.amoon@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH-next v3 1/3] arm64: dts: rockchip: Add missing pinctrl for PCIe30x4 node
Date: Fri, 12 Jul 2024 22:15:49 +0530
Message-ID: <20240712164554.1763-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing pinctrl settings for PCIe 3.0 x4 clock request and wake
signals. Each component of PCIe communication have the following control
signals: PERST, WAKE, CLKREQ, and REFCLK. These signals work to generate
high-speed signals and communicate with other PCIe devices.
Used by root complex to endpoint depending on the power state.

PERST is referred to as a fundamental reset. PERST should be held low
until all the power rails in the system and the reference clock are stable.
A transition from low to high in this signal usually indicates the
beginning of link initialization.

WAKE signal is an active-low signal that is used to return the PCIe
interface to an active state when in a low-power state.

CLKREQ signal is also an active-low signal and is used to request the
reference clock.

Rename node from 'pcie3' to 'pcie30x4' to align with schematic
nomenclature.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
V3: use pinctrl local to board
V2: Update the commit messge to describe the changs.
    use pinctl group as its pre define in pinctrl dtsi
---
 .../arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 966bbc582d89..721e87a3a464 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -338,7 +338,7 @@ &pcie30phy {
 
 &pcie3x4 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pcie3_rst>;
+	pinctrl-0 = <&pcie30x4_pins>;
 	reset-gpios = <&gpio4 RK_PB6 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_pcie30>;
 	status = "okay";
@@ -377,14 +377,20 @@ pcie2_2_rst: pcie2-2-rst {
 		};
 	};
 
-	pcie3 {
-		pcie3_rst: pcie3-rst {
-			rockchip,pins = <4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-
+	pcie30x4 {
 		pcie3_vcc3v3_en: pcie3-vcc3v3-en {
 			rockchip,pins = <1 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
+
+		pcie30x4_pins: pcie30x4-pins {
+			rockchip,pins =
+				/* PCIE30X4_CLKREQn_M1_L */
+				<4 RK_PB4 4 &pcfg_pull_up>,
+				/* PCIE30X4_PERSTn_M1_L */
+				<4 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* PCIE30X4_WAKEn_M1_L */
+				<4 RK_PB5 4 &pcfg_pull_down>;
+		};
 	};
 
 	usb {
-- 
2.44.0


