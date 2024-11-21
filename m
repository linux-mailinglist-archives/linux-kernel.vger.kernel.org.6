Return-Path: <linux-kernel+bounces-416501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D0D9D45EF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED75F1F223D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB716A397;
	Thu, 21 Nov 2024 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icQLkNSl"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CE156F30;
	Thu, 21 Nov 2024 02:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732157620; cv=none; b=ULKTFIJ9QKmG0J1tYSzG9ZpdlNz7j2cYRnIU388q8tC8gW8A8KN34NkjjfkY4jVlqUAudO8rvCCN3AlVu4h9qWhpjSc/t7yZUHi2nLonXGgNIHK1qNxmD697ilanInQ7CnGN/udf0WY5Fj2aHkRsX1evm4r/Bhxa+kq0ywnrSpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732157620; c=relaxed/simple;
	bh=GryuZGEu/a+ZzDtvUjyjCWZ4FMldjV+M4EwxpZGJeEo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tK0ODZeVdfuBeE3qcw+QvZmCi/7HR6NNN17lShJgEmjJ2/D2sh6b71heuRF8LjnmqQpBa++y6xmHclYSzoHGwePnJhPDEn6Ov4wuFJxLC6m5Y4eOrLu6tv/1VwX8aCKJL+wLE3bVPmXvpQToV6L0x6pgTE0JK0v/xOLEjgquBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icQLkNSl; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-71a9a02b499so173823a34.1;
        Wed, 20 Nov 2024 18:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732157618; x=1732762418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hFpMGE8s7psUHx3+Wdj8euFlIX9fVjcGzp1EwkK8LE=;
        b=icQLkNSlTXhixz1XAhaazZ+ac3k6c0e1YDNTwzpe7liUXzv8fP+4jJiscwKa8dlIyt
         Z7KyVkhLNRI0W1OCHH/UP3eL4v7p3ejfWHhHnSf9STY8zbZyqpVCWpUkTzLzQeL/Sxji
         /DeNaWaTplI8X5CWJeBDX7FiQVtYnjH2rNCPMMS2LhPEnOQzjqWl5YVxfmclxlxaRrAU
         lq/O4FY0ZNavC9utOiY53An4gS2ETpqLlz9tjxuiWEc5HlEhOw6H3aN2u6UtS16lPYZI
         7njfzfGDGjmG0Q31w5EocjPMt/LNN3i6fY/0+uORSKdKmUfxFNfn2ftjb9tjuawWUoTb
         FFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732157618; x=1732762418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hFpMGE8s7psUHx3+Wdj8euFlIX9fVjcGzp1EwkK8LE=;
        b=q6bV0CObgpf3iifuMaFSwsO/7mRbhbDYLZvM5KOjGfxnRx0UDyJkcKz9Ox5SzgiGsm
         u4xkMCR5gDTnC0jemy1miO6qSS/uTtUWyeAFz0NyJF/vW4OmarRdombXxm3JKo6o3t16
         M+00Q1s422JYH2BeMmOPnhStlMukAM8IsFk8jAFqR+aRgupgf5anPd9FEKUHwjooUxfA
         X0qPbOboBPjj0KUJjtGhxcYPk9H7rptkbNOKmZFhOdiWqza3X3Qrh89+knykxFP6/l+P
         +CeD5TacpZFu0bKez07o87PfeaXozF7ugq07creDdlI8d0rjWFjUJGlYdire+/5IJeDX
         D31Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjS7eQ0g94D2EwAYmkKKYBFVEEU6V4spF08yWndGdiH41UjDSZmFuuyCB1ungv7hvIt+odK2xYX5UP@vger.kernel.org, AJvYcCXmPbQNSM6FLkZ/bwzqaYbzB2ZrkhSHTc9ktHGQAB7YtkAbTD7uZEgicRBpfOTfW6HsqmYksJB3RTQoHUeC@vger.kernel.org
X-Gm-Message-State: AOJu0YwKz+2QTc9FpFTyGj0Yiox7zQ0bLnYul/oppEGxba2PvsPLAbmn
	9zw9PFHNp3Yckdb44dUMSQee7fYTUFXHiM3XLMcFJyIOEV+vwS8/
X-Google-Smtp-Source: AGHT+IFinVzwidv3KxbK4poEFtxDXiNYFFKy7ns+/JV5m2BWBfiQ/ywhmjk5vggcq044ZI8cYP3oKQ==
X-Received: by 2002:a05:6830:6e99:b0:71a:6cbf:7e96 with SMTP id 46e09a7af769-71ab30ed2c8mr6011687a34.9.1732157617978;
        Wed, 20 Nov 2024 18:53:37 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e309-7a4e-e779-1177-8427-3602.emome-ip6.hinet.net. [2001:b400:e309:7a4e:e779:1177:8427:3602])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64f5514sm285513a12.34.2024.11.20.18.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 18:53:37 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: dts: aspeed: Harma: Revise GPIO line name
Date: Thu, 21 Nov 2024 10:53:20 +0800
Message-Id: <20241121025323.1403409-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
References: <20241121025323.1403409-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add:
"ac-power-button",              // AC power button input signal
"asic0-card-type-detection0-n", // ASIC0 detection signal 0
"asic0-card-type-detection1-n", // ASIC0 detection signal 1
"asic0-card-type-detection2-n", // ASIC0 detection signal 2

"cpu0-prochot-alert",           // CPU 0 processor hot alert signal
"cpu0-thermtrip-alert",         // CPU 0 thermal trip alert signal

"irq-uv-detect-alert",          // IRQ for undervoltage detection alert
"irq-hsc-alert",                // IRQ for hot-swap controller alert

"uart-switch-button",           // Button to switch UART interfaces
"uart-switch-lsb",              // UART switch signal, least significant bit
"uart-switch-msb",              // UART switch signal, most significant bit

"leakage-detect-alert",         // Leakage detection alert signal

"power-card-enable",            // Power card enable signal
"power-fault-n",                // Power fault signal
"power-hsc-good",               // Hot-swap controller power good signal
"power-chassis-good",           // Chassis power good signal
"presence-post-card",           // Presence for debug card
"presence-cmm",                 // Presence for chassis manager
"pvdd11-ocp-alert",             // PVDD11 overcurrent protection alert signal

"reset-control-cmos-clear",     // Reset control signal for clearing CMOS
"reset-cause-pcie",             // Reset cause indication for PCIe
"reset-cause-platrst",          // Reset cause indication for platform reset

"P0_I3C_APML_ALERT_L",          // APML alert signal

Rename:
// Rename the power signal to match PSM defined
"power-cpu-good" to "host0-ready",
"host-ready-n" to "post-end-n

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 58 ++++++++++++-------
 1 file changed, 37 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index fd85d5e34a55..ce1731bdc1af 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -416,12 +416,6 @@ gpio@31 {
 		reg = <0x31>;
 		gpio-controller;
 		#gpio-cells = <2>;
-
-		gpio-line-names =
-		"","","","",
-		"","","presence-cmm","",
-		"","","","",
-		"","","","";
 	};
 
 	// Aegis FRU
@@ -559,7 +553,8 @@ &gpio0 {
 	/*A0-A7*/	"","","","","","","","",
 	/*B0-B7*/	"","","","",
 			"bmc-spi-mux-select-0","led-identify","","",
-	/*C0-C7*/	"","","","","","","","",
+	/*C0-C7*/	"reset-cause-platrst","","","","",
+			"power-hsc-good","power-chassis-good","",
 	/*D0-D7*/	"","","sol-uart-select","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
@@ -568,7 +563,8 @@ &gpio0 {
 	/*I0-I7*/	"","","","","","","","",
 	/*J0-J7*/	"","","","","","","","",
 	/*K0-K7*/	"","","","","","","","",
-	/*L0-L7*/	"","","","","","","","",
+	/*L0-L7*/	"","","","",
+			"leakage-detect-alert","","","",
 	/*M0-M7*/	"","","","","","","","",
 	/*N0-N7*/	"led-postcode-0","led-postcode-1",
 			"led-postcode-2","led-postcode-3",
@@ -577,18 +573,29 @@ &gpio0 {
 	/*O0-O7*/	"","","","","","","","",
 	/*P0-P7*/	"power-button","power-host-control",
 			"reset-button","","led-power","","","",
-	/*Q0-Q7*/	"","","","","","power-chassis-control","","",
+	/*Q0-Q7*/
+			"","","","",
+			"","power-chassis-control","","uart-switch-button",
 	/*R0-R7*/	"","","","","","","","",
 	/*S0-S7*/	"","","","","","","","",
 	/*T0-T7*/	"","","","","","","","",
 	/*U0-U7*/	"","","","","","","led-identify-gate","",
 	/*V0-V7*/	"","","","",
 			"rtc-battery-voltage-read-enable","",
-			"power-chassis-good","",
+			"","",
 	/*W0-W7*/	"","","","","","","","",
 	/*X0-X7*/	"","","","","","","","",
 	/*Y0-Y7*/	"","","","","","","","",
-	/*Z0-Z7*/	"","","","","","","","";
+	/*Z0-Z7*/	"","","","","","","presence-post-card","";
+};
+
+&gpio1 {
+	gpio-line-names =
+	/*18A0-18A7*/ "ac-power-button","","","","","","","",
+	/*18B0-18B7*/ "","","","","","","","",
+	/*18C0-18C7*/ "","","","","","","","",
+	/*18D0-18D7*/ "","","","","","","","",
+	/*18E0-18E3*/ "","","","","","","","";
 };
 
 &sgpiom0 {
@@ -636,10 +643,10 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"power-cpu-good","reset-control-smb-e1s-0",
+	"host0-ready","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
-	"host-ready-n","reset-control-srst",
+	"post-end-n","reset-control-srst",
 	"presence-e1s-0","reset-control-usb-hub",
 	"","reset-control",
 	/*E4-E7 line 72-79*/
@@ -656,7 +663,7 @@ &sgpiom0 {
 	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
 	"presence-asic-modules-1","bios-debug-msg-disable",
 	"","uart-control-buffer-select",
-	"","ac-control-n",
+	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
 	"FM_CPU_CORETYPE1","",
@@ -668,7 +675,7 @@ &sgpiom0 {
 	"FM_BOARD_REV_ID2","",
 	"FM_BOARD_REV_ID1","",
 	/*H0-H3 line 112-119*/
-	"FM_BOARD_REV_ID0","",
+	"FM_BOARD_REV_ID0","reset-control-cmos-clear",
 	"","","","","","",
 	/*H4-H7 line 120-127*/
 	"","",
@@ -683,22 +690,31 @@ &sgpiom0 {
 	/*I4-I7 line 136-143*/
 	"","","","","","","","",
 	/*J0-J3 line 144-151*/
-	"","","","","","","","",
+	"","","power-card-enable","","","","","",
 	/*J4-J7 line 152-159*/
 	"SLOT_ID_BCB_0","",
 	"SLOT_ID_BCB_1","",
 	"SLOT_ID_BCB_2","",
 	"SLOT_ID_BCB_3","",
 	/*K0-K3 line 160-167*/
-	"","","","","","","","",
+	"","","","","","","P0_I3C_APML_ALERT_L","",
 	/*K4-K7 line 168-175*/
-	"","","","","","","","",
+	"","","","","","","irq-uv-detect-alert","",
 	/*L0-L3 line 176-183*/
-	"","","","","","","","",
+	"irq-hsc-alert","",
+	"cpu0-prochot-alert","",
+	"cpu0-thermtrip-alert","",
+	"reset-cause-pcie","",
 	/*L4-L7 line 184-191*/
-	"","","","","","","","",
+	"pvdd11-ocp-alert","",
+	"power-fault-n","",
+	"asic0-card-type-detection0-n","",
+	"asic0-card-type-detection1-n","",
 	/*M0-M3 line 192-199*/
-	"","","","","","","","",
+	"asic0-card-type-detection2-n","",
+	"uart-switch-lsb","",
+	"uart-switch-msb","",
+	"","",
 	/*M4-M7 line 200-207*/
 	"","","","","","","","",
 	/*N0-N3 line 208-215*/
-- 
2.25.1


