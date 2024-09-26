Return-Path: <linux-kernel+bounces-339998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB07986D1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9049AB258C4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261A18DF89;
	Thu, 26 Sep 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ach4zzoj"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E3018BB9B;
	Thu, 26 Sep 2024 06:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333883; cv=none; b=VQs0jkMZuPuXbxvLOd6mGJsNAmRC2vfPdCjVyCVR+lIvjfh/ELebsOGQ9xhMmS+Vp8JC+oAXtISbdkIgcmOMPoOf/Gd0QMwiJg7FvZqgCSpdeFcsb6L2/8jDtfNAu6F7HKmFMfNiZ2SqhemQ3OLmWZWNZE9/FeYZSitrAQMK0N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333883; c=relaxed/simple;
	bh=9ss1m1bom+zDCDWvUCJj5aWhrVLAjqPukFd575DvUMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dt3m8nCqPb5r/IMf0uY1ngisve4uPivy32f3Id4jNbVWjP+VLRREqRNW7qlOiMw7eUUGZKv2Qhx23zT7QkcK6fhqk1hDVktChgI2b7ahZ3w2WbQ57s3VD7aHMVAiAgS41dbNSKjeRy/HgMdgSwKFroyNdJ4Kc/LzOi3kPZSxGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ach4zzoj; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71100987d1cso365752a34.2;
        Wed, 25 Sep 2024 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727333880; x=1727938680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOJeAQBgJ2clDphyw+PZwbFI1eIa6mgTGdFOxyjksqw=;
        b=ach4zzojCyignAXSQxBXNn7/7AE3JcHkGyVbKnCnvWZZKcJJTIIs8ziLZhd+21o14M
         18S/ygqT+og0aj2diGkuV0+yEbR43gNM33hjdyScPZ7Zo5mxHT+s4iAin+ZFMJdv5vqf
         cWPXhD4kXRhJYO2LdJK+V0LVp1usr0aOqyiOqOO/ycE2yKOIDz7lkL5NmCYuNQlCUUB5
         6xxVB0+UB4sAdSu4Z17VUNmZo5M39bI12RaFQ5yZJ2jUlS/Y/myPcaJjsj6SxVJY1AmM
         INe6ozbiopLfPsy4g7om8ExD92dvOngvKZhschTTaU4GwXTNAFlvQrSatrfr6+/lRgZ4
         O6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333880; x=1727938680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOJeAQBgJ2clDphyw+PZwbFI1eIa6mgTGdFOxyjksqw=;
        b=JzDV6WJt8To6li0HmGxV66TaUjcf1y1H7aciWEObjHeaKZW4AUJGg7GcBCWbsFIqE5
         fZLZ7FUbMJNHth/SGuo8zs2ZfCU/rFYC6obRbb5nu1W61eEjnE8Vg9HglER/I61eBnB3
         OJFh+jOxoZbybqtXT3UmiYWbxltcZrFB+tuXDcqUsK+vUfJklJaYjOmFBnyx70vP7M6a
         7HUOcf+otWzK7GLt9I2G603qTx9uYsitLi/yZGCnM35tC7wVe4a1+TZxMb1ymaNS+PuQ
         o5Nq2OjFyzwXxPoOVai9ZBVTbCdlCgkaYvFpSKEWMQy1rf2qSZrbVWeOZWoZZIah/Xn4
         hJwg==
X-Forwarded-Encrypted: i=1; AJvYcCW1KTVJEOdCsJ/DxBbEfhs0f2q/gN9G5M38d4FcoYiloOMX0ewjbzkdMvgvUKzHgB15BEEtadaWESNCa4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TotVlBblI3EdESd2MpfYtiJT7AsDdSjcqvzfjLnJAvmMyKO6
	jhbXLhGcvtJWQYnaJyzNPrJDpQrjDM1ZsLhtwT6QMXVZS8gzUfp8
X-Google-Smtp-Source: AGHT+IExWK+57Nv4bnkY6Z4Z3F5Ia4gqBkNVZyx9LkGlgz4UdeGz9WEEAh9zY+ip9cLnrr+1vzswXQ==
X-Received: by 2002:a05:6359:5fa6:b0:1b8:32b5:4e90 with SMTP id e5c5f4694b2df-1bea86a70f4mr220637455d.27.1727333880448;
        Wed, 25 Sep 2024 23:58:00 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c51112sm3656709a12.42.2024.09.25.23.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:58:00 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 14:55:31 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: catalina: move hdd board i2c mux bus
 to i2c5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-catalina-evt-dvt-system-modify-v1-1-84a27b47040b@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727333875; l=4559;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=bVHCPsMjz6la14pOQHSDdWP8VOORoHkUheYAAgbPX2g=;
 b=FbMAYYDOp4IUOZBWRvqxzcluqfEkK3cvoWaLbUyyAfYkdWaLSpyoH9naFSdYvHzf267hQ/ODN
 x7ArvoNb9IjA4UYMRfxxklZG8nU5hR9CtEpfEF29lKp+7dzbysU8416
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

From: Potin Lai <potin.lai@quantatw.com>

Due to EVT hardware changes, move HDD board i2c mux bus from i2c30 to i2c5.

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 165 +++++++++++----------
 1 file changed, 83 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index fa0921a4afe2..eac6e33e98f4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -50,14 +50,14 @@ aliases {
 		i2c45 = &i2c0mux5ch1;
 		i2c46 = &i2c0mux5ch2;
 		i2c47 = &i2c0mux5ch3;
-		i2c48 = &i2c30mux0ch0;
-		i2c49 = &i2c30mux0ch1;
-		i2c50 = &i2c30mux0ch2;
-		i2c51 = &i2c30mux0ch3;
-		i2c52 = &i2c30mux0ch4;
-		i2c53 = &i2c30mux0ch5;
-		i2c54 = &i2c30mux0ch6;
-		i2c55 = &i2c30mux0ch7;
+		i2c48 = &i2c5mux0ch0;
+		i2c49 = &i2c5mux0ch1;
+		i2c50 = &i2c5mux0ch2;
+		i2c51 = &i2c5mux0ch3;
+		i2c52 = &i2c5mux0ch4;
+		i2c53 = &i2c5mux0ch5;
+		i2c54 = &i2c5mux0ch6;
+		i2c55 = &i2c5mux0ch7;
 	};
 
 	chosen {
@@ -244,80 +244,6 @@ i2c0mux1ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			i2c-mux@70 {
-				compatible = "nxp,pca9548";
-				reg = <0x70>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				i2c-mux-idle-disconnect;
-
-				i2c30mux0ch0: i2c@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-				};
-				i2c30mux0ch1: i2c@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-				};
-				i2c30mux0ch2: i2c@2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-				};
-				i2c30mux0ch3: i2c@3 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <3>;
-				};
-				i2c30mux0ch4: i2c@4 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <4>;
-				};
-				i2c30mux0ch5: i2c@5 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <5>;
-				};
-				i2c30mux0ch6: i2c@6 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <6>;
-					// HDD FRU EEPROM
-					eeprom@52 {
-						compatible = "atmel,24c64";
-						reg = <0x52>;
-					};
-				};
-				i2c30mux0ch7: i2c@7 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <7>;
-
-					power-sensor@40 {
-						compatible = "ti,ina230";
-						reg = <0x40>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@41 {
-						compatible = "ti,ina230";
-						reg = <0x41>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@44 {
-						compatible = "ti,ina230";
-						reg = <0x44>;
-						shunt-resistor = <2000>;
-					};
-					power-sensor@45 {
-						compatible = "ti,ina230";
-						reg = <0x45>;
-						shunt-resistor = <2000>;
-					};
-				};
-			};
 		};
 		i2c0mux1ch3: i2c@3 {
 			#address-cells = <1>;
@@ -647,6 +573,81 @@ &i2c4 {
 
 &i2c5 {
 	status = "okay";
+
+	i2c-mux@70 {
+		compatible = "nxp,pca9548";
+		reg = <0x70>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c5mux0ch0: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+		};
+		i2c5mux0ch1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+		i2c5mux0ch2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+		i2c5mux0ch3: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
+		i2c5mux0ch4: i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+		};
+		i2c5mux0ch5: i2c@5 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <5>;
+		};
+		i2c5mux0ch6: i2c@6 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <6>;
+			// HDD FRU EEPROM
+			eeprom@52 {
+				compatible = "atmel,24c64";
+				reg = <0x52>;
+			};
+		};
+		i2c5mux0ch7: i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			power-sensor@40 {
+				compatible = "ti,ina230";
+				reg = <0x40>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor@41 {
+				compatible = "ti,ina230";
+				reg = <0x41>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor@44 {
+				compatible = "ti,ina230";
+				reg = <0x44>;
+				shunt-resistor = <2000>;
+			};
+			power-sensor@45 {
+				compatible = "ti,ina230";
+				reg = <0x45>;
+				shunt-resistor = <2000>;
+			};
+		};
+	};
 };
 
 &i2c6 {

-- 
2.31.1


