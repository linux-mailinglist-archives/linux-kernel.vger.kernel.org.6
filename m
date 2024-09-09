Return-Path: <linux-kernel+bounces-320844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE01E97113F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C9562807AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796E1B3F22;
	Mon,  9 Sep 2024 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyKMe9e+"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC11B3B16;
	Mon,  9 Sep 2024 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869229; cv=none; b=FRX3nuw3P5qcwNuwFDAQcteC61AbopAvpFWsJFdDQCSowoZ4G/H9s6MeLgxjXN4r8IoB85/j0GPEkLfmtqj2tgMR0C06pNwJbTt4vlNnS+ffR6Joj9QK96IPEn2JnZd8vRzbjOC8AHFjbHsqGmubkcjOrQ57ICZEIUIZPpyP5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869229; c=relaxed/simple;
	bh=taKj446+/fKcRx0XZYjC92kpqKNCYpK4TAy3GsEXvbo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=auOuhRLpJmzhTPCV5ZyI9Z8EUDFGwSxKZbHwwQF6NsRw/HtY+HJ1bae2FboLZ8U00qW29r5odckNV84crH2oLXYjwfexuUQENmT9Ritn1jgRN/YLoM4+6/ZeT65K9CwezKzo6Jfot+qmoFTzpr0Rp0KUmjd6Zdnd5+d1ffoHGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyKMe9e+; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso2917136a91.3;
        Mon, 09 Sep 2024 01:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725869228; x=1726474028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrsojVcXdP7VbUJkVIZWlDcZmLbxH8yTx3aUvs3NVIY=;
        b=GyKMe9e+0QjarPP0WFwOZtPOEEObSBcpe8IdLmFAOEjt2OXLo1zNBqz091AIXu6dWN
         +s4iDDzc2Q1j0OlFAyZ/oo4Dfe0+HPOJuCUeWhquYDygctULnCr7i7JjKEd21Yr4fPCg
         nHtYqr+rqYVau+FhCiUiffz2sJxvAxoMHENoKnYwo8eMjTVTECe96euLHtZfhkpCRU9a
         Dzg4k/5oO5fGqVFYLQ3NkBBeP4od3VV66o+tmpm7giwhXaf1deLghsc0y3iIB7ltSNXH
         m/wCLl/qh5+HfwNNRMq3sX/L3lfoglR7c9HW9Jf5Hsc9Pbvh2cO+aksBBiz/pVnYpQjP
         43UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869228; x=1726474028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YrsojVcXdP7VbUJkVIZWlDcZmLbxH8yTx3aUvs3NVIY=;
        b=uHIrCoRZdTGy4s7Eu1Ss0p01yCuf8JTQJGoPNllOZtiCHDCnv/Qr3wXSeib5M1G0O0
         p1XhZOXlSbuo9pm51o7fva/tLIqlbNxJeMgXeOvmNmUvE+fRT5QCG+/jjtABsNHdxWfh
         WySOkyrftbIKHTP+DYC3figEk5e8rSVaEn4RDQeT07PqWRwhm9d4wnPYc7jFKi3eg3Q0
         npyFX0wVNCAm7xlFArfbqICe3EWQJdKbfL3zp1850UaG0eUdB8gO6xidgHmNpmxicHwY
         YJ197z4jgdU03GTY+q2oAljJGTS7RQ92iBLQF+TYsTQKEGlrz6yUaUt6zch15N6bh39j
         t0vw==
X-Forwarded-Encrypted: i=1; AJvYcCW2vX6a5mBEJbA0epOzjGoDS1DG5iV0Gt7Hmxt45gpSfnKtugNrNp2r4rsbz4AS8YldSfBabF+FIuao@vger.kernel.org, AJvYcCXE9qiQ4adRJb0h7qEcq52AVRKq4FUk6x17Ojb4mXJFHWEyOOHRheuzhb6Q9GcMU319dP6PJRKPoqC2rT3F@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVzjWqlWjt32+mE/ZTJKCWXwpc9GlcxG9WsU9RghQ+YLcCilC
	YRKkl3i/1X8ctPCRfM2ntaM++isj0EK00tiGKHlVAtd02Sym/C4T
X-Google-Smtp-Source: AGHT+IFVeStqcCLHFeJFmPSKwkY6xVOD7KFhLsjEH2hXJSBguqu/gXh13TrqWZOjarwMr7+jXXH3aQ==
X-Received: by 2002:a17:90a:c706:b0:2da:8974:b3e3 with SMTP id 98e67ed59e1d1-2dafd0971e1mr7978914a91.27.1725869227864;
        Mon, 09 Sep 2024 01:07:07 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c4916sm3917541a91.31.2024.09.09.01.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:07:07 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Harma: revise sgpio line name
Date: Mon,  9 Sep 2024 16:04:59 +0800
Message-Id: <20240909080459.3457853-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240909080459.3457853-1-peteryin.openbmc@gmail.com>
References: <20240909080459.3457853-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

power-card-enable
power-fault-n
power-hsc-good
power-chassis-good

asic0-card-type-detection0-n
asic0-card-type-detection1-n
asic0-card-type-detection2-n
presence-cmm

uart-switch-button
uart-switch-lsb
uart-switch-msb

reset-control-cmos-clear

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 92068c65eae4..9cb511a846e3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -393,12 +393,6 @@ gpio@31 {
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
 
 	// PTTV FRU
@@ -422,12 +416,6 @@ gpio@31 {
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
@@ -566,7 +554,7 @@ &gpio0 {
 	/*B0-B7*/	"","","","",
 			"bmc-spi-mux-select-0","led-identify","","",
 	/*C0-C7*/	"reset-cause-platrst","","","","",
-			"cpu0-err-alert","","",
+			"power-hsc-good","power-chassis-good","",
 	/*D0-D7*/	"","","sol-uart-select","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
@@ -585,14 +573,16 @@ &gpio0 {
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
@@ -673,7 +663,7 @@ &sgpiom0 {
 	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
 	"presence-asic-modules-1","bios-debug-msg-disable",
 	"","uart-control-buffer-select",
-	"","ac-control-n",
+	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
 	"FM_CPU_CORETYPE1","",
@@ -685,7 +675,7 @@ &sgpiom0 {
 	"FM_BOARD_REV_ID2","",
 	"FM_BOARD_REV_ID1","",
 	/*H0-H3 line 112-119*/
-	"FM_BOARD_REV_ID0","",
+	"FM_BOARD_REV_ID0","reset-control-cmos-clear",
 	"","","","","","",
 	/*H4-H7 line 120-127*/
 	"","",
@@ -700,7 +690,7 @@ &sgpiom0 {
 	/*I4-I7 line 136-143*/
 	"","","","","","","","",
 	/*J0-J3 line 144-151*/
-	"","","","","","","","",
+	"","","power-card-enable","","","","","",
 	/*J4-J7 line 152-159*/
 	"SLOT_ID_BCB_0","",
 	"SLOT_ID_BCB_1","",
@@ -716,9 +706,15 @@ &sgpiom0 {
 	"cpu0-thermtrip-alert","",
 	"reset-cause-pcie","",
 	/*L4-L7 line 184-191*/
-	"pvdd11-ocp-alert","","","","","","","",
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


