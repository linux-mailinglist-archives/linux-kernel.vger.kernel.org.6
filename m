Return-Path: <linux-kernel+bounces-308424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7C965CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B911C232E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1617A18BBBC;
	Fri, 30 Aug 2024 09:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce6v2N4V"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013E17C9FB;
	Fri, 30 Aug 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009840; cv=none; b=YnhOfos0qwpYQ0MLoJgzBB5nK+Z652RcrBxK/2HFUesBDccPz7PrFLJ1oZTk1BrhOrvEShs9nVt7a2+yIO4VdWxST2ulpihTJsNIuoDdACxdTbuMCDZh7fGwArwYQ99j79c8vqinTRkwgGLYldwOK0mLNqaIvaujVgVp1hVnaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009840; c=relaxed/simple;
	bh=BT3IzxbvCZzFYHHlTQPXkf2olM9onJ2quFEwGGsFtlA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYsAQ7pUlGvDcqyLgVokCcnYEyebWychhN8ydBdaXZinfrzCz2Cznwoi9GXpvUyFv06s0T9cPbJIANm1/R+YERZv4IFb5FKUQLVnEfNH8loMsLGSIsVtIC4qKyc2WBkNf6puiJFYAVD0GMZNpixX1hLu+T2obNu6idPJ6zs2wFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce6v2N4V; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df0fc40271so556833b6e.3;
        Fri, 30 Aug 2024 02:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725009837; x=1725614637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2qJ5H4TeLGmSdfoWP7b3jAie759gREUlRrWmjjXFdQw=;
        b=Ce6v2N4VsglSd84UWTOJYQgHLMeAcjnFT4UY/+WsMGrFIMX8RoB1ZE9eywwFO4BYEB
         aB6ugfBrRo/0mWjSQku1Rv+8Fms1bnHwYD6a3M1Wm6NP8mZXvwoWOSZcLBLmT1N1Ovr+
         UrQQb+DSt+DKjf275FLeo6P1+32LIcGn6QmdpA2JAPoigr4NayIygSghRkJc7ETu+WM8
         +FjSMu0/hyczk8oHta8xdbCJIZlbnSsTjU5qPq9PVRneMLMgjPE7acz7gLzs0cfuY75s
         uJwVHZ6eCBQXQJvgASCkLVfrPg2xzwX0IqZh+BPHE0saBXbsWiDEyNf4uJB5Pl/IR6TO
         0j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009837; x=1725614637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qJ5H4TeLGmSdfoWP7b3jAie759gREUlRrWmjjXFdQw=;
        b=HZ8ENlgivGk3lR8tpLtFNFMe5/0ZAwmYUS0q6BzG7zxQZyDE/5MaeX4sZ8Z42ca59r
         oBnXAnoIr1zQ0Nxqr3IR1dCl1E5eDT5UViDlX+chknTT6eVgh2m3y8a6DpkFCc4htq73
         odV1MykU56wUXIvvnpBsfC7T+/EKwP0SmQMuj4vqQMsr6poC0RcNvsrbVle6Dp3lCD+q
         wdOyJgbsYcNwig58OBMY4qzBFBjjCSTSKxIFD/U+mvJRJ3NMO6jZgVesfs6Tb+3CBujJ
         Dtpu3D3hYH+h7EuglmJAXhbRQhP+glp2nWKThAaeiPleS5aODhFrfgpPDZORVyWaAlgl
         Y6vA==
X-Forwarded-Encrypted: i=1; AJvYcCW5KEEdWI2XwmbU8YuFqEJbz05RNFl9DaQjbQhtwXhmB8/ut1dxNXRQMqKkDESaHmEYXW9oku7OnjmdVZca@vger.kernel.org, AJvYcCXccaQeTlioOGGx4fUJXwMcW7fq/D/0SdJ0FT+iW6x3NMT0D8sDHxHPI3YlSD4YYLp1sS0CzJRXns0C@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZcKurKDPrVEmj07meI2DFaG2TwAZALMv7mh7p9N6x0eKDS0d
	E7cSzHrxTiiwo38wpfRaWX/f5cohltxBzRVI4UKYqBBmCn6KaqU67ize8A==
X-Google-Smtp-Source: AGHT+IFM1tLoimDRFy3xRY0N39UW6MPxB6ovxXNeLIg6sw1fC7i7BPyaqG7A6GRFXJb8TCfCa6tCXQ==
X-Received: by 2002:a05:6808:178c:b0:3db:2070:909d with SMTP id 5614622812f47-3df05d7b3bdmr6260766b6e.19.1725009837322;
        Fri, 30 Aug 2024 02:23:57 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e66d8f4sm2566744a12.0.2024.08.30.02.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:23:56 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ARM: dts: aspeed: Harma: update sgpio line name
Date: Fri, 30 Aug 2024 17:21:47 +0800
Message-Id: <20240830092148.1574520-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830092148.1574520-1-peteryin.openbmc@gmail.com>
References: <20240830092148.1574520-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

power-card-enable
uart-switch-button
power-fault-n
asic0-card-type-detection0-n
asic0-card-type-detection1-n
asic0-card-type-detection2-n
uart-switch-lsb
uart-switch-msb
presence-cmm

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 32 ++++++++-----------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 92068c65eae4..5440181730f6 100644
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
+			"cpu0-err-alert","power-card-enable","",
 	/*D0-D7*/	"","","sol-uart-select","","","","","",
 	/*E0-E7*/	"","","","","","","","",
 	/*F0-F7*/	"","","","","","","","",
@@ -585,7 +573,9 @@ &gpio0 {
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


