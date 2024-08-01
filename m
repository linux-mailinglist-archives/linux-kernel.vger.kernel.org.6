Return-Path: <linux-kernel+bounces-270631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E06944291
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965F81C2184F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D64913E023;
	Thu,  1 Aug 2024 05:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuHI8Kva"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCE13D283;
	Thu,  1 Aug 2024 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722489283; cv=none; b=aOFJEYT45KIHiU2vwsw2KGOCsQx7n3b4MAAUZdIw1NnLEdKLrhqisSDfVpohve2dhPE6yJnQrYP7z6+XO7q3JlmOgIZINkLmfGv8YF7gA+mXepo2L38fGyo9vUjy0VflnVV71n99xzxNfnvFlkFxhASKaFu0KqyW92oOnYIHMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722489283; c=relaxed/simple;
	bh=ZsvwGaGoEAcPO7DkzH/FQcfX3tob/yYcuPjkpB9TDh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NC/n2e/zvw8ldUw2K9UMN0hL6VZloCqJ8sd4QOY6dTdjV87UVs/Gk+2uGi0l3I78hKqCSEzH0ytSwIeuHpguT0CzaQARCAGqd4ToNZcg+QG9q9SOvgj+U9YOGqKZJf1LGEuuPbWUDffcr3FaVQSWVGFqjJnbsef1o2IjrxjfYB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuHI8Kva; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso10064555e87.2;
        Wed, 31 Jul 2024 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722489280; x=1723094080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwe1CFr7XDtc90/o/bWkFlT5zGqIJ/h6TtZLaOU7lZo=;
        b=VuHI8Kvac3EA2OMkoNfF+Q5pZ791POD53o+8j5oDr3uKGPjEha+UPLhn71qLTybq9+
         oMUNJ99zu2KUlYYWtLkeEbzaBIyp+D2mZKfaBu1ZmaY3dxarY9+6x2tZdBmhQseLgkyV
         ivKy0JuqurOETG0uX7aLVUBS1b4zM0luBNGKC49EzN0yfOOvy9LxMMCvShD6TvjKDf5j
         /+41s2nreoHMy2KUzncwLAqibKzDQ18XggdfbqW5SIm6MpZiuC/pewuAis1DGNjgbMHS
         crpCZITx/nq7356t30kzkpeLhmW7HChf7cTPuR8eCWF0k22UwEGo4jz4cDdVHX9zVPUH
         Hqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722489280; x=1723094080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dwe1CFr7XDtc90/o/bWkFlT5zGqIJ/h6TtZLaOU7lZo=;
        b=tQzTLC0ZRR3MPOPf7btKKtb2/DmgDaEUqZ/Y0fk/ncn+4ZS420PBzjrKz2Y8MKdFEt
         7QVi2CGtokgsoVSzSDg9etf6uuG2N4duQlp44/WliGxGrGdS00B3/IEIdsZXEnz3oO9l
         SHGmBcj3L4eLmFNJinjFNxX5BLQEdess4gBzmA00S3ZaUCl1M9EX4bdTUr8VOcAmfHNq
         bUq448gw0x60MyEe7nnjeBt9z29ATS8Lj4fwrY5ZiD+vL4GlyJonRji7bCp5wqA3pKYq
         /yC/d2ovbIjluo9rHFCAsbO1nSADcoaGdDbydb2cgVoFBXm504GkrUCNPGyM6Elx3qDI
         yqqA==
X-Forwarded-Encrypted: i=1; AJvYcCUH9PVTnqnativ3wEL9LFCUXqywE0UfWw0uMiI7ZRoRjFAKZ6XqgD4OZzxNvpjAalFi1VuRiXJW3X8J1k0rFcWENp0YdsClUCrctu1Nc6mFliuFwuAxsdQvRFMeC+KEE5LlXOgwI2429g==
X-Gm-Message-State: AOJu0YxgIkZ8V/E8+x38dWBpjskiJDsy5oQq35JUSNoA3GcA1k9tUseO
	siqa6D2XUGNULKbAwUpKpnFO3H4MAXtoXZDfW3FOfJWAoeM2TwQ+l4HIihCl
X-Google-Smtp-Source: AGHT+IGpNCSVm6hYkMRgsT/z/Oa2FjemtIZEfC7W2b0eQB93+x4euJWk0w43mBqDph9ZoRI7njDGeg==
X-Received: by 2002:a19:2d54:0:b0:52e:fa5f:b6b1 with SMTP id 2adb3069b0e04-530b61f81bamr444856e87.60.1722489279571;
        Wed, 31 Jul 2024 22:14:39 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bd0c4csm2474129e87.72.2024.07.31.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:14:39 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dtc: update P2020RDB dts
Date: Thu,  1 Aug 2024 07:14:01 +0200
Message-Id: <20240801051402.584652-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

P2020RDB contains multiple peripherals, which isn't added to
devicetree:
  - Switch: Microchip VSC7385
  - PMIC: Renesas ZL2006
  - Temperature sensor: Analog Devices ADT7461
  - Two eeproms: 24C256 and 24C01
  - GPIO expander: NXP PCA9557
  - reset gpios of Ethernet PHYs

This commit adds it.

Some refreshments was done:
  - fixed link in ethernet-node
  - platform drivers nodes names
  - added 'gpio0' label in pq3-gpio-0.dtsi

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 arch/powerpc/boot/dts/fsl/p2020rdb.dts    | 85 +++++++++++++++++++++--
 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi |  2 +-
 2 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p2020rdb.dts b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
index 3acd3890b397..d563d37b91f1 100644
--- a/arch/powerpc/boot/dts/fsl/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
@@ -6,6 +6,7 @@
  */
 
 /include/ "p2020si-pre.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "fsl,P2020RDB";
@@ -33,7 +34,7 @@ lbc: localbus@ffe05000 {
 			  0x1 0x0 0x0 0xffa00000 0x00040000
 			  0x2 0x0 0x0 0xffb00000 0x00020000>;
 
-		nor@0,0 {
+		nor@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "cfi-flash";
@@ -79,7 +80,7 @@ partition@f00000 {
 			};
 		};
 
-		nand@1,0 {
+		nand@1 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,p2020-fcm-nand",
@@ -128,11 +129,49 @@ partition@1100000 {
 			};
 		};
 
-		L2switch@2,0 {
+		ethernet-switch@2 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "vitesse-7385";
+			compatible = "vitesse,vsc7385";
 			reg = <0x2 0x0 0x20000>;
+			reset-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@1 {
+					reg = <1>;
+					label = "lan1";
+				};
+				port@2 {
+					reg = <2>;
+					label = "lan2";
+				};
+				port@3 {
+					reg = <3>;
+					label = "lan3";
+				};
+				port@4 {
+					reg = <4>;
+					label = "lan4";
+				};
+				vsc: port@6 {
+					reg = <6>;
+					label = "cpu";
+					ethernet = <&enet0>;
+					phy-mode = "rgmii";
+					rx-internal-delay-ps = <1400>;
+					tx-internal-delay-ps = <2000>;
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+						pause;
+					};
+				};
+			};
+
 		};
 
 	};
@@ -141,12 +180,39 @@ soc: soc@ffe00000 {
 		ranges = <0x0 0x0 0xffe00000 0x100000>;
 
 		i2c@3000 {
+			temperature-sensor@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c256";
+				reg = <0x50>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
 		};
 
+		i2c@3100 {
+			pmic@11 {
+				compatible = "zl2006";
+				reg = <0x11>;
+			};
+
+			gpio@18 {
+				compatible = "nxp,pca9557";
+				reg = <0x18>;
+			};
+
+			eeprom@52 {
+				compatible = "atmel,24c01";
+				reg = <0x52>;
+			};
+		};
+
 		spi@7000 {
 			flash@0 {
 				#address-cells = <1>;
@@ -200,11 +266,15 @@ mdio@24520 {
 			phy0: ethernet-phy@0 {
 				interrupts = <3 1 0 0>;
 				reg = <0x0>;
+				reset-gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
 			};
+
 			phy1: ethernet-phy@1 {
 				interrupts = <3 1 0 0>;
 				reg = <0x1>;
+				reset-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 			};
+
 			tbi-phy@2 {
 				device_type = "tbi-phy";
 				reg = <0x2>;
@@ -232,8 +302,13 @@ ptp_clock@24e00 {
 		};
 
 		enet0: ethernet@24000 {
-			fixed-link = <1 1 1000 0 0>;
 			phy-connection-type = "rgmii-id";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+				pause;
+			};
 		};
 
 		enet1: ethernet@25000 {
diff --git a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
index a1b48546b02d..5181117ea6b5 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
@@ -32,7 +32,7 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 
-gpio-controller@fc00 {
+gpio0: gpio-controller@fc00 {
 	#gpio-cells = <2>;
 	compatible = "fsl,pq3-gpio";
 	reg = <0xfc00 0x100>;
-- 
2.34.1


