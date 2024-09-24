Return-Path: <linux-kernel+bounces-337227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4A98473E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 441A51F24123
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AC1AB50C;
	Tue, 24 Sep 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGYQ+rQO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966161A76AA;
	Tue, 24 Sep 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186669; cv=none; b=rHzDuxM6adq+nn1vyQkcdhpCzREZ2flQx16J8/ls1BAfu89buNIAKYcIQVgcaP3Mn/GAPqAqnt8Y51cHHzKwo1E9I1k92Hj9uKOeZ3zJpx7jtrbfFOBZixke1MCzolX+wWSaQJKkSihiv3mOqrMYTKFz2o+L798NCk5zO8H3CIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186669; c=relaxed/simple;
	bh=dSxFZCnd2ec64OV3Oj8qOp4UN7fcBrZdB78QkkpfRRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O2aj81rPCHMh0WRhAN2FDtmzWCfdX7gRTPNO/x16QKqpsl+XVuT4bn1Q3LFxxDDIgJrxCcpvFGpOqPzDp8ThbG5oDutC6kxFhAcZF/rLLkbdNQYie2LCMWfb5JnuRgL9uvQxMcBg5vqiAC3jya0dNmRiflP7dnefwWsIDFMGDVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGYQ+rQO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068a7c9286so55659515ad.1;
        Tue, 24 Sep 2024 07:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727186667; x=1727791467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t41RrvA9ibashCj3l3oDsqUmb7XQG+ol4j0yx1LSoJs=;
        b=gGYQ+rQOaj4Xkk5axYhJsxgte2PCRAbM+Y1OCxnpZlZ+tFwNfxYt192HcL1Pqv0qK8
         USeqlFoF3drK/MfLfiR8qF3VYuHHq5J6jdj747UjfPJe8nOhwEdvjsXvrTE2qU21ohBR
         jPuIQ0cQH12XixwQFNFjbxFNSu6FXzZXd1HE1l1fOnIGUglGZsE7G0C49xMTgWoh52d9
         +KagbvTRhmpH30HpB29QGk2ndTC0zoT3qZH0iUOoha0rHBjboMuwjF8wD13tujTC+lUo
         Qq+E+jFRIEzQySeivOGW7E02+JFElf+r0F1Wbu5xRBWGsF5Nyp+W9WwEJHYsn/R5AqyQ
         WBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727186667; x=1727791467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t41RrvA9ibashCj3l3oDsqUmb7XQG+ol4j0yx1LSoJs=;
        b=UJebfa8G8nXYZmc/5OYanO7j9T5MDqfwc+UOn1h8goIu/lMVvf7imP6gX3HsqqKjaM
         6p1fsdkNwJjAVwCP3rRDVTCryq7utlKS6tbpQniQY7XlepYg93D8brXF8SQwuklJHDUZ
         jhy3u1zqt6IAtd11Bmfmx/W0GIvnTlXGJx14vPTmNr0/mWdUljRACINjyldRWE7HXgeW
         iUK/Pi/9yJ60FpERaBPBCFg4YOYDt67fK5XWetPBZ4h0WaGCRFvJ/3pBsYtZyfInLhnL
         BNMifbKkWTOegdQlHjaXixLDRC1RvcKsdZ21rRKDiUkIkImUkv6KHpvqG+6Z/c7HcDFi
         ZB0w==
X-Forwarded-Encrypted: i=1; AJvYcCXXFZanIUW/X7T7CnhBHBHPTJ+QdVCFwHXvrPyEb9N8qEF/dtb/0omtg14hm8CdPsjBc48eZDZy7vRj@vger.kernel.org, AJvYcCXZ3kidHl4BK43SGGF8xF3fczK1JzpzRR/fxcRh3wSXCjwmGCSQony1IOLSEqw0cyT1+W4SnS6CjlywEXI/@vger.kernel.org
X-Gm-Message-State: AOJu0YwmmpfCb3jAJvfKSOw8PA3seykzW23GSGTnjmjGPRxU0tyLQnxN
	LaUaEbQIr6kYXDskyp/USR1sKF/ZMbtgto8uNf7D9hCG36d8G2LR
X-Google-Smtp-Source: AGHT+IHnzkG8P7QQgG9rKuqx66HrjkDX9178ig3DFr0CaK8vzpF07XzLy0C6tKxwVlqORq0CLbLAzQ==
X-Received: by 2002:a17:902:d4d2:b0:207:3a4a:de43 with SMTP id d9443c01a7336-208d83c8114mr188656825ad.34.1727186666859;
        Tue, 24 Sep 2024 07:04:26 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1821f33sm10678895ad.219.2024.09.24.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 07:04:26 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH v1 2/3] ARM: dts: aspeed: minerva: change the i2c mux number for FCBs
Date: Tue, 24 Sep 2024 22:02:14 +0800
Message-Id: <20240924140215.2484170-3-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
References: <20240924140215.2484170-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the i2c mux channel to match the correct fan board location.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-minerva.dts    | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 38eb42aaa98b..c915db28a806 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -213,10 +213,11 @@ i2c-mux@77 {
 		#size-cells = <0>;
 		i2c-mux-idle-disconnect;
 
-		imux16: i2c@0 {
+		// FCB 1
+		imux16: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0>;
+			reg = <1>;
 
 			eeprom@50 {
 				compatible = "atmel,24c128";
@@ -259,11 +260,11 @@ temperature-sensor@4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux17: i2c@1 {
+		// FCB 2
+		imux17: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <1>;
+			reg = <0>;
 
 			eeprom@50 {
 				compatible = "atmel,24c128";
@@ -306,11 +307,11 @@ temperature-sensor@4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux18: i2c@2 {
+		// FCB 3
+		imux18: i2c@3 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <2>;
+			reg = <3>;
 
 			eeprom@50 {
 				compatible = "atmel,24c128";
@@ -353,11 +354,11 @@ temperature-sensor@4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux19: i2c@3 {
+		// FCB 4
+		imux19: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <3>;
+			reg = <2>;
 
 			eeprom@50 {
 				compatible = "atmel,24c128";
@@ -400,8 +401,8 @@ temperature-sensor@4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux20: i2c@5 {
+		// FCB 5
+		imux20: i2c@4 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <4>;
@@ -446,8 +447,8 @@ temperature-sensor@4b {
 				reg = <0x4b>;
 			};
 		};
-
-		imux21: i2c@4 {
+		// FCB 6
+		imux21: i2c@5 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <5>;
-- 
2.34.1


