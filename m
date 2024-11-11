Return-Path: <linux-kernel+bounces-403819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD189C3B40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC7F1F21208
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C3817A586;
	Mon, 11 Nov 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT4hFvyc"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6DA1552EB;
	Mon, 11 Nov 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318363; cv=none; b=JHH0S5886eBlBaI9yUE9iXOmghC9afIUfZ56m9supmK8MnF9Sf7IZC/qFmpqeY7BekFq5ftIy4qY7iEgc2tDs6nXFsWMFFsqSPaVfFYzgw6BC4k61dgVHkQsx0cDaJP8pKSIQVcN6UicKDMY+gcYbQuIXgZbATUecyzfVMMZrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318363; c=relaxed/simple;
	bh=QEy6WTlAzCaY30R0NRE96MT4l5WFNYPsrxsa6pkVl9s=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPiPijc4WpChYR5BZKn5Jm/9eueXZfJ8PV2Qtn7GvEoBJ5krnHoWwtF4dlYWe9Z0on7YD92/hcpoaDDYmfId5C+WhlkB2jPD0nujkPlo1qSwosPZBRyTJylMsKQw5ySJlyrk1rftTnWBiOgbKncfW+BHzGVJivvWpNAizYhe2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT4hFvyc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ca388d242so43392205ad.2;
        Mon, 11 Nov 2024 01:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318361; x=1731923161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnd0dMgn8pF5mC6ybOYdJ6wVojOcLARfVRQ6oD52meo=;
        b=RT4hFvycvg3Ep7RzjCFbZ2N5jVqECWjTsHyif+h+qBs23iJGMshpgn1NsGQJBxkqoi
         aCAnb2JKJYeHA3GkSaQdi0+Otk3Agfbs8iQbYQ0CBBQf/FdMvUfyCjLxFiMuYQWEpLgh
         Di88KAyAVrzVm0Zn29Ahmq9nzt0tn/Io65zf+IEX0u7D2kJHXyO1CtlFeH0OakNfdrww
         24g25wXcTKTP34fKrp5TTEhhjjRcR3XzJGzOUpRTiAxxtCQu3kS8nhsCPw2SU7cgXHNK
         gl94hDPhXhOmptkMNCDVRugKQHGkUh1+UbnomEVlZX8DZh0GeGqsMy376TwAfctu/flk
         gxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318361; x=1731923161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnd0dMgn8pF5mC6ybOYdJ6wVojOcLARfVRQ6oD52meo=;
        b=Yi1peLVehfW18+Vx3BlTb6EmstLzL5RC9bp2T6k0dBWmY7d9kl7iWmaF6Lt1o4ujSP
         3cRiSFJk1oSVSyHbmbUapnXqY7pZVvg15dcWzNqtqxSJkOqqR1Om5HlSqQu8GuRbD4k4
         LJrzU2DYMglTHXdToAXmmb3cOOtuqeNcNT/kwRTs0eGkeElgpNPP29ii7hoirNxv6Qfv
         7MbfPtlHzBTzZv8Ip5Pp4ement0v3siNLi5onewXM+RbXoulhMrjulZYEMdoBdUeEfHM
         l3x7EI4fQStQ3PTqiV6LPmmOBx2QyAyE1wM4mofioi+KeVRb9h28047VNSiMpmfdjZ5C
         Gxdw==
X-Forwarded-Encrypted: i=1; AJvYcCUMLrx2q2TiKhL/ktdIFAo+G0/OTSjYXLnr2QA5WYSSRg6zuIm6xQGo7CmYHspoZIFsTYRutn0KWYPI@vger.kernel.org, AJvYcCWkTMMjy6JM5UicbBsTvlyJpwOwWlVI812XlXLG5GcyjBRHS0mfqYcpBGvJ59GCxhwvi6TEHblpcEzW0Bvt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XYeuThGCnxrPWAbKZ5VgF5UP7QraJWKo5xO5ibFtPsfvawWQ
	a12WyAnmHTAwok9H8RstJDjt/Yt+Nd3SJ6/2x5PQOCyOFczDmGK3
X-Google-Smtp-Source: AGHT+IHJPX81v+bCNaryh8mrbkn4Vw2k+4EN2NzDFSUrUCEELhKBfLTnc5EyUfjXpNmdcZ3GqJq0Xw==
X-Received: by 2002:a17:903:2347:b0:20b:b455:eb4f with SMTP id d9443c01a7336-21183d6eff4mr178322555ad.25.1731318360826;
        Mon, 11 Nov 2024 01:46:00 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:46:00 -0800 (PST)
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
Subject: [PATCH v1 3/5] ARM: dts: aspeed: Harma: Revise GPIO line name
Date: Mon, 11 Nov 2024 17:43:47 +0800
Message-Id: <20241111094349.2894060-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
References: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  Add:
    "ac-power-button",
    "asic0-card-type-detection0-n"
    "asic0-card-type-detection1-n"
    "asic0-card-type-detection2-n"

    "cpu0-prochot-alert",
    "cpu0-thermtrip-alert",

    "irq-uv-detect-alert",
    "irq-hsc-alert",

    "uart-switch-button"
    "uart-switch-lsb"
    "uart-switch-msb"

    "leakage-detect-alert",

    "power-card-enable",
    "power-fault-n",
    "power-hsc-good",
    "power-chassis-good"
    "presence-post-card",
    "presence-cmm"
    "pvdd11-ocp-alert"

    "reset-control-cmos-clear"
    "reset-cause-pcie",
    "reset-cause-platrst",

    "P0_I3C_APML_ALERT_L",

  Rename:
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


