Return-Path: <linux-kernel+bounces-411739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B339CFF0B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17001B27DEF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945AB1BBBC9;
	Sat, 16 Nov 2024 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXHo6KTW"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E8195985;
	Sat, 16 Nov 2024 13:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762639; cv=none; b=BSg0MXfTkdlyV6NDjgvrjmxRrgCj6+8DR90T+VRvY+9uHHvhrBGIuMtANsJzc4uPX3cuCDTCNS3IuuIGtCyde03CJ7oqaBSAfFtKOTJEk8MgSkrJlqtP8EDWj8RlDJS9XtJglH1fTc5+3BgPzuKz+XWEK/3kzyRovTgzLpp47H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762639; c=relaxed/simple;
	bh=VSX6Tupea+lveH5OF2V660luvXroshLKhKowGY60eC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EPPNy6ONifcC4+36iJ2FFnegmomLcqH78pCg2sxtP20g/7dTSYvG1PBwnwGrjz2ceYKGbjDDqK+j7UtOhjg7sF6ANjARRYteehb6ggqjpCWEY8xSK6Zu6k1gMccdgoI6cZdI4uWQelLkeDd0W3erG+B9Et73yt6uQUlBe6MRUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXHo6KTW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5045987dso258805f8f.1;
        Sat, 16 Nov 2024 05:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762636; x=1732367436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB3ulxCecmsW7fjuWD1ocrPoiUFrXT+TWPSU1MrEKrA=;
        b=PXHo6KTWkBn3fYBQ8azJKCHmdgsdMD+BtWDMostP2Hlx05RGBFiKQN4nFRs5OYZbTW
         Wo8ScPcjUP4URdqmWB/CgOF00YjjIWd6KZotOVwR9OU3GxmrT4W5XKd95LOaZ5aEcx6V
         HyummuQ2gHtGZPtaYx2rTq+bxIbYxF6WtChVDx1QF2NEu3DoFtXbaAMavTXtdehCB3JR
         pb7AssmhTM3K7eJn7F5ek/PuqyUOihceh46Ut3mIEUsgewCcvvPAwBPD8Cxc4+TdahlG
         wzGIlNn1rfC43Re/y+jfayQZ0vwIBLgYBcMhCQkHVREnp6GqxnIeqQI7PITY2GkXudJ7
         r4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762636; x=1732367436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB3ulxCecmsW7fjuWD1ocrPoiUFrXT+TWPSU1MrEKrA=;
        b=LB/EtIJW8vEkzbx86YF5Nx+IyDMtWjs8YUF0/7UcgSPw25qQQ3h1GYuMpnOZl/hVF4
         7KYKt7M88pUgAhOShUZlPS1s+rqx2nn3Q5dl8VZDeeLxQEto5/yOtdiK0fYYVDLQzkRF
         Cb+TOJYqKpr2HVQEfLR0knCuOwp71ALrLRQuHsl+Yb55a/vHi1guXyvklv8delFPxhhq
         vdlfjX3+MAYbybgN20b2vgnuPv2N3/kXRpCOAKCk7Q4K9RGemi+d8te/3OctxQiKehS8
         6ZLCRI74uMG115g1XIOKzwY68GgaUcQ14jV1C2VZpEpeuNetkRMDqvQ06WVSmC47bYUG
         SxnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8TXLIaE7AOFgf4GkmvAD3s3hTielgj3Bn8H+E38M/iX+JDfVq3BWHR2/jejCbFMVlSCBnn53exbGy@vger.kernel.org, AJvYcCXwYuBy0WkeG4E4p000g4yIjFdqiZHMvFKeHkgJ7I+YcSYKl1ibu8uEG1SQ6ATija/6pXNVtWxvdMGWpmRd@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxUr4yHZ3ijEOkGMaoBEa/aWmWi1oI4wo69n9V1S6fBX7Enw7
	PxVu+N+1V2DQP6Ar2evJBnXTfSFFMRtUR33nri8eDeYH5OvaqIkF
X-Google-Smtp-Source: AGHT+IEj0WfYDhjcOKOoyiKe++NDFUW6QqxTyrv7WCpZdG/AbHV6ZXBJ8Nm61tf5WL0/2POhCgssIg==
X-Received: by 2002:a05:600c:4710:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-432df7878bcmr22275335e9.4.1731762636000;
        Sat, 16 Nov 2024 05:10:36 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:35 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/11] ARM: dts: socfpga: add Mercury AA1 combinations
Date: Sat, 16 Nov 2024 13:10:21 +0000
Message-Id: <20241116131025.114542-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241116131025.114542-1-l.rubusch@gmail.com>
References: <20241116131025.114542-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for Enclustra's Mercury+ AA1 SoM, based on Intel
Arria10. This is a flexible approach to allow for combining SoM
with carrier board .dtsi and boot-mode .dtsi in a device-tree file.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga/socfpga_arria10_mercury_aa1.dtsi  | 141 +++++++++++++++---
 1 file changed, 120 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
index 41f865c8c..41351d58f 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_aa1.dtsi
@@ -7,12 +7,14 @@
 
 / {
 
-	model = "Enclustra Mercury AA1";
-	compatible = "enclustra,mercury-aa1", "altr,socfpga-arria10", "altr,socfpga";
+	model = "Enclustra Mercury+ AA1";
+	compatible = "enclustra,mercury-aa1",
+		     "altr,socfpga-arria10", "altr,socfpga";
 
 	aliases {
 		ethernet0 = &gmac0;
 		serial1 = &uart1;
+		spi0 = &qspi;
 	};
 
 	memory@0 {
@@ -24,52 +26,102 @@ memory@0 {
 	chosen {
 		stdout-path = "serial1:115200n8";
 	};
+
+	/* Adjusted the i2c labels to use generic base-board dtsi files for
+	 * Enclustra Arria10 and Cyclone5 SoMs.
+	 *
+	 * The set of i2c0 and i2c1 labels defined in socfpga_cyclone5.dtsi and in
+	 * socfpga_arria10.dtsi do not allow for using the same base-board .dtsi
+	 * fragments. Thus define generic labels here to match the correct i2c
+	 * bus in a generic base-board .dtsi file.
+	 */
+	soc {
+		i2c_encl: i2c@ffc02300 {
+		};
+		i2c_encl_fpga: i2c@ffc02200 {
+		};
+	};
+};
+
+&i2c_encl {
+	status = "okay";
+	i2c-sda-hold-time-ns = <300>;
+	clock-frequency = <100000>;
+
+	atsha204a: crypto@64 {
+		compatible = "atmel,atsha204a";
+		reg = <0x64>;
+	};
+
+	isl12022: rtc@6f {
+		compatible = "isil,isl12022";
+		reg = <0x6f>;
+	};
+};
+
+&i2c_encl_fpga {
+	i2c-sda-hold-time-ns = <300>;
+	status = "disabled";
 };
 
 &gmac0 {
+	status = "okay";
 	phy-mode = "rgmii";
 	phy-addr = <0xffffffff>; /* probe for phy addr */
-
 	max-frame-size = <3800>;
-
 	phy-handle = <&phy3>;
 
+	/delete-property/ mac-address;
+
 	mdio {
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "snps,dwmac-mdio";
 		phy3: ethernet-phy@3 {
-			txd0-skew-ps = <0>; /* -420ps */
-			txd1-skew-ps = <0>; /* -420ps */
-			txd2-skew-ps = <0>; /* -420ps */
-			txd3-skew-ps = <0>; /* -420ps */
+			reg = <3>;
+
+			/* Add 2ns RX clock delay (1.2ns + 0.78ns)*/
+			rxc-skew-ps = <1680>; /* 780ps */
 			rxd0-skew-ps = <420>; /* 0ps */
 			rxd1-skew-ps = <420>; /* 0ps */
 			rxd2-skew-ps = <420>; /* 0ps */
 			rxd3-skew-ps = <420>; /* 0ps */
-			txen-skew-ps = <0>; /* -420ps */
-			txc-skew-ps = <1860>; /* 960ps */
 			rxdv-skew-ps = <420>; /* 0ps */
-			rxc-skew-ps = <1680>; /* 780ps */
-			reg = <3>;
+
+			/* Add 1.38ns TX clock delay (0.96ns + 0.42ns)*/
+			txc-skew-ps = <1860>; /* 960ps */
+			txd0-skew-ps = <0>; /* -420ps */
+			txd1-skew-ps = <0>; /* -420ps */
+			txd2-skew-ps = <0>; /* -420ps */
+			txd3-skew-ps = <0>; /* -420ps */
+			txen-skew-ps = <0>; /* -420ps */
 		};
 	};
 };
 
-&i2c1 {
-	atsha204a: crypto@64 {
-		compatible = "atmel,atsha204a";
-		reg = <0x64>;
-	};
+&gpio0 {
+	status = "okay";
+};
 
-	isl12022: isl12022@6f {
-		compatible = "isil,isl12022";
-		reg = <0x6f>;
-	};
+&gpio1 {
+	status = "okay";
+};
+
+&gpio2 {
+	status = "okay";
+};
+
+&uart0 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
 };
 
 /* Following mappings are taken from arria10 socdk dts */
 &mmc {
+	status = "okay";
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
@@ -79,3 +131,50 @@ &mmc {
 &osc1 {
 	clock-frequency = <33330000>;
 };
+
+&eccmgr {
+	sdmmca-ecc@ff8c2c00 {
+		compatible = "altr,socfpga-sdmmc-ecc";
+		reg = <0xff8c2c00 0x400>;
+		altr,ecc-parent = <&mmc>;
+		interrupts = <15 IRQ_TYPE_LEVEL_HIGH>,
+					 <47 IRQ_TYPE_LEVEL_HIGH>,
+					 <16 IRQ_TYPE_LEVEL_HIGH>,
+					 <48 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
+&qspi {
+	status = "okay";
+	flash0: flash@0 {
+		u-boot,dm-pre-reloc;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,s25fl512s", "jedec,spi-nor";
+		reg = <0>;
+
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <4>;
+		spi-max-frequency = <10000000>;
+
+		cdns,read-delay = <4>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partition@raw {
+			label = "Flash Raw";
+			reg = <0x0 0x4000000>;
+		};
+	};
+};
+
+&watchdog1 {
+	status = "disabled";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.39.2


