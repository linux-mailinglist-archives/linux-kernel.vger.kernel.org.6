Return-Path: <linux-kernel+bounces-340014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C2986D54
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2541C218E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB31D18E05E;
	Thu, 26 Sep 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqeEBGNf"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5C718C013;
	Thu, 26 Sep 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334846; cv=none; b=qXnJILmFrNYPkGoTidyTH235abn84uO7kHSzDc71qwlWdU3aaN+MEOsu+rB1fh4ouzp4NJDdw8t5tsEoCUj0PAlyUGpONrfCJPF3dWX7enq1sy7T6vFuDzWUa0EOX7s97xseRpHfXBLTKNqxrGpN0QhsZZjeMzD9tr+1vs9Jkkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334846; c=relaxed/simple;
	bh=9ss1m1bom+zDCDWvUCJj5aWhrVLAjqPukFd575DvUMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcAEqUN5FyRKcT2j3BvO9PQf6wGdtDXMah567LiFZzMKYcvZcU7vwpur76gNzJLJ27Rpj5S393hYe00waUx4zWPFMLWrz9N+byCgq5AJP/Q2BxGosrhLbb8Osu4DNlG6T2coEICOHMAnJ+ogUUdgx2DZ92//XncrP75vHK/RKRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqeEBGNf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so173544a91.0;
        Thu, 26 Sep 2024 00:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727334844; x=1727939644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOJeAQBgJ2clDphyw+PZwbFI1eIa6mgTGdFOxyjksqw=;
        b=RqeEBGNfoGd0UaaguGugw/kiTFJj05WtWGUs281pL9FZdxcO5IdFR+FHgT7Yy3xrJf
         fba2h9bnDXbOUkIj7nVZd8R7CC53H7HmWZSF5q8lKgD4sMDtnogPil5EJxmqPjVMaiis
         Au9Rh6Wt2z4NVCTVrMCCEH2yfnMVMLaJdtfK3yltydLDrDwYG9fqQ2CzVjDB+yelqLT9
         jP55Ul/vvGfwmxRmdw/4Es/HWkDSoAW4IdzllCASFEbQT6cgxp/xue+Ho8zFiGG8QMKD
         UXBZ1jCQqjQp5t51zvHBSard/GDAUxeRBmfjV4zGro77CvUHBx/F8oAwr20F1Cb6FjV+
         SjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727334844; x=1727939644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOJeAQBgJ2clDphyw+PZwbFI1eIa6mgTGdFOxyjksqw=;
        b=exgRAcfcPEt9Ttw0vUASBFwS8Cah61RZfBHneMovKGQmrCFXcOuTSMLajgcPD/2UVg
         aKaNRCEHG/PSEk83r5R+ytJSA8Tf3IdbZJBIo1R7M9WdRFwtjftner2TLG8szW8U7rj7
         f+wMShZQJsRnb6icbR+7EuX3SiybngyyDf+D5mRLo9SJNI8x8X5vjcQ756gcu8nNfQb9
         HOqJ7xuiy2iywKN9Wfvf4zZBWGJUeq7TlNs/w6fpimlug8ZrnKRsvmj9leL7dynh/99I
         Uzzk52vMosO7SQC+4un+SsJ8IY/P+t4CRjB/AVxzSlkAvMz98uZVwHBF1rlOdgZlv4ze
         k9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCnTKwHGaUkifkhadB+GdFymV44GCsayn9nooOG2JFQL29WUbaUi+PqV0DWtOvBdRYE9W3atyTZKeBPh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKGRVotKlETOo2tars4oX/yp2Zo5MUdOSGFL4U724jomsUMFgJ
	TQ0DZ6z1tw0zjctlhdOe91J4k51UzhmIo0RO1xJr9TKT8odSg5zR
X-Google-Smtp-Source: AGHT+IEr0OC5xf4XAI3Bau5P0hFkvteHeXyqqWZcfhKPX6p6ofsNIC/S6xM3sQSJY+w10o33KtGTAA==
X-Received: by 2002:a17:90b:3e82:b0:2cd:4100:ef17 with SMTP id 98e67ed59e1d1-2e06afbdcb8mr6503278a91.31.1727334843941;
        Thu, 26 Sep 2024 00:14:03 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d3e79sm2662906a91.27.2024.09.26.00.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:14:03 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 26 Sep 2024 15:10:44 +0800
Subject: [PATCH v2 1/3] ARM: dts: aspeed: catalina: move hdd board i2c mux
 bus to i2c5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-catalina-evt-dvt-system-modify-v2-1-a861daeba059@gmail.com>
References: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
In-Reply-To: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727334839; l=4559;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=bVHCPsMjz6la14pOQHSDdWP8VOORoHkUheYAAgbPX2g=;
 b=jFN+8gsBzVgcOwW0viNvRHj9cunW7PBxpzL8bSdIfiZIhjeAe7cw9Kia+Gk829Txp1vVUUdSs
 emHkvv+vd5eA2c1EnETLQKtLyxhQfFqqPVMUZ9cV1z+mpmwqbVUZ82E
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


