Return-Path: <linux-kernel+bounces-570818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42CBA6B4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF793B1D3F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C451EE7DD;
	Fri, 21 Mar 2025 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR2pe+m3"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7C1EDA2C;
	Fri, 21 Mar 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542111; cv=none; b=bzKnYlZqTI6C+0vkopxY3abejHpn+3TpmmLwdBnuUlTg/yFz6FU9+n5oSa4bi925/RAbANR40zgKmzg/8R+0fdrt8tiENKAFdCwPdhg7aHfYk80MkGDxH0FH7RdCTGNAv1BKWUUa+va1y9UIgi7V02VhbBt6bxWyrvwvzmlpSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542111; c=relaxed/simple;
	bh=ZE8DMnDtK6GtXz/R29k12joihlo+gxEvbFhaGKQky3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pi+vZ76GZsKfUmwy42AVjMlLfRYTHctWhqzyqf5jylXoSczOKK8AFnY2FhwOETKR90FGgl15gWYvnWcmkdkBtY//wO3IktkTdBvRAAxElJozZ3mBK4HomgtbjG6Q5mgj79SU8rP45iCbu2mAH+uwTLR5touIPsGHhm6p2AYuKMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR2pe+m3; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22403cbb47fso30818415ad.0;
        Fri, 21 Mar 2025 00:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542109; x=1743146909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=UR2pe+m3s0gNQMBWcmXb4/vWMCflNG3MeAjwmC6Kos1Cgy2F5owb0fH+CVutob/XOt
         Jd7N4BSdhm6i3G/RpZIqLngH0qc795xdn7KNnhvlVTbWj11+qfo3ji8YSzmih0UE2kPy
         i6951YDdcZhbvozX+NzKKigqr1wYR10o515cvhh70WNC/7GctUAD7Hayd8thv5LWsy22
         u+uSs4WZ7tT7SeaGEokpipUApn1al7VX2c8qZOLTynypQ4flMCX3tU0h5wVSxt/zD1oK
         nNIvTFK1qZInfrjCJHhT2xu13ru42SePuuZrYJ5JnGoF9uVMiA3cRCEkzMF7NqCATFGz
         NoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542109; x=1743146909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsGnq8WpEGq8rItMy0um7W6pcAm/zbCWTBE+mh8Th8U=;
        b=AldvAgl47QzEdXA7AW7KC99zz9Umgxa62riwzq2wWsB1MTIslohFrkiLRzmZv2O4Qz
         ifAJahgoU/Q5D03ikPPtEFLdw/V9l1iuXhxzhA/4/RvjMbImShEV5X9yR0G8lAQS4zYs
         QGcebrRPJNYbJkECFU75KF1DWaSNN2cmku81OPI1r8sYG9HZL64b4XAyMQvM8636PHoL
         H5vd1ZTkzF4zqmRAR88bpsM1zBRk1HZ471MXegNIX6cOEoO9kf0SeiJS4Mr0QEy3tjQn
         iTf5u+rVgu9sNvQ6KoKb/6ROADtMImoAcdV2fuAOpKIx891j6932fvE49eDLIXcGWFHU
         Vpdw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9/U0viaF3Y47jful5VfbT+zLtisj2M+D9an/Dtz1yxbWkZAij6BNLZEnDYOac6ZxxXTIOkEH/x94lX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8gVLK4kW0UyATBTuGLeUC+cr8DDB9+Dd+GegYEGwaOL0cR9P
	cZ9dtuZ+mifc7U/c2R3XqTJjS7Ih8QHHreX9rTT6/Z35VVJQ/Zre
X-Gm-Gg: ASbGncuZtW9tHkINiLHIoSSHh9nuJg4qUjP+Ih0wMsUnHm/wVSXTy6j1B29q+W+aUo5
	edZhLuVQR5MARq/7bzKBTNeo2PaMU1t3TjBvOc1lcBLiDtnX3KblyL427SNc4J616CVCTeQCCLF
	mQ4SfStvjVTnlPB/14HAZHbHQpvg8nxHMB5Pf8gl1AQhYkyp1J2/p6BiBaLVMf85da250zc1X+B
	ymaCnZWaVybrRk5Wc2NRq50zCzS1ZMxqHIJvaSp6gzwRcIgJFQomWYE6SNcj3vJIu5uf2K7PBLB
	zU4WembYlzhPNMMwEB58b8zzFi2TESjTyJ5pLj132f7xXUPkDZaZ0gUiri5vng/AiubPSZlhCTF
	AfWhi1bSiS6XzMzTOMrhcTw==
X-Google-Smtp-Source: AGHT+IHZwkqqnNy+VPxGo4BdiCjiJgfTxT+uvqFaJnReF+y/mGA7CSLdbLFcCPQBoqccVKLmssYfMA==
X-Received: by 2002:a17:902:da82:b0:224:162:a3e0 with SMTP id d9443c01a7336-22780e2a37fmr35488305ad.49.1742542109028;
        Fri, 21 Mar 2025 00:28:29 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:28 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:02 +0800
Subject: [PATCH v6 01/10] ARM: dts: aspeed: catalina: Add IO Mezz board
 thermal sensor nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-1-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1855;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=ZE8DMnDtK6GtXz/R29k12joihlo+gxEvbFhaGKQky3s=;
 b=hSNSRF8aykCJoZWrCIMBeG6atv69rGcfZy7cKck3omGOD07NUktdt5H/dVqsU4O70JCwkQyrQ
 FiGZEehi0WUDAuOve21El2ZnNN9uElK4xLudO4NPMRmsXKLjsDs8SN5
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add thermal sensor nodes for the IO Mezzanine (IO Mezz) board in the
Catalina platform device tree. These nodes enable temperature monitoring
for the backend NIC, improving thermal management and monitoring
capabilities.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index c151984289bc..d5d99a945ee4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -198,6 +198,12 @@ i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB0 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch1: i2c@1 {
 			#address-cells = <1>;
@@ -208,6 +214,12 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB0 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux0ch3: i2c@3 {
 			#address-cells = <1>;
@@ -299,6 +311,12 @@ i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+
+			// IOB1 NIC0 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch1: i2c@1 {
 			#address-cells = <1>;
@@ -309,6 +327,12 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+
+			// IOB1 NIC1 TEMP
+			temperature-sensor@1f {
+				compatible = "ti,tmp421";
+				reg = <0x1f>;
+			};
 		};
 		i2c0mux3ch3: i2c@3 {
 			#address-cells = <1>;

-- 
2.31.1


