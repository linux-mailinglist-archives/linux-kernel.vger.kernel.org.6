Return-Path: <linux-kernel+bounces-349648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6507398F997
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894A71C21A94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996451CC8AB;
	Thu,  3 Oct 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXL7M8Jw"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9541CB327;
	Thu,  3 Oct 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993379; cv=none; b=SJSFtqDPBeujlA17aejuxuYdNO4/uRFGjjaEUl2NN0hRiVw/CxHAzd/8vPpYaYPDPSBm596cAp0rBFKehuORFIGO1YDEFo21ZGR1uKwVwX2fOnGDAyUA8G12eZpUVkyYY2xlHHlsRdoQ03FySPcF1AO9oZgcCN+vB9eR6caH7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993379; c=relaxed/simple;
	bh=4Q1Deb34MnXtuhesjeCLN57PwpyPJQ5GH+jgBDCLl0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktI6lz67vRCj0/DH+QUIbT7Ld/2wmE8g2/m8AvDOrt+Lrhmc1o4EpmwF2bFlfkGhAV97fRwgSq3/rTHWaQ2miv2PTv9ZUY8rGEyZUqzTCbmaPA263y4AcvRgLery4WD39h8l22SExXkTyDDehqGKRSXoSWAv5AlzAIzNgxMnmcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXL7M8Jw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e18aa9f06dso1112734a91.0;
        Thu, 03 Oct 2024 15:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993378; x=1728598178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E91rfKcYw9IuIWwIQIGEzOIkm79LZ9bOHrsBMYtdt+A=;
        b=KXL7M8JwvwfvaMCXccdIRzjq1WjugwwnL4hJ6LjA+17BCMD0r5g0mTE8r7kKfr/AfD
         0Qs6oo88uGuAJZXOAk3HPpAADyrl2kYxuSWHw4z51L9YmbYbtxsTVpjZApoNcTOwRgf6
         yDVcVtine7uEEAFlma3R97gjISqNElqmOKvK36iEbr+bo4/yuOhw8Is7kl11O4wRCxZy
         p//MOjIrxm9VygBdKJwVJNJi6Dn76OaMiS99TcKb9iXfXkqODGYorI1pCnRqUyZqYWlv
         IDHZC8XdbVRPt03f+mQLQw44dspO1Ep4d5r8cnpr3/njHVJVW7IjSwc3nDwB5zkmiNHI
         CBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993378; x=1728598178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E91rfKcYw9IuIWwIQIGEzOIkm79LZ9bOHrsBMYtdt+A=;
        b=S37Ge76VcsldWymsW0ECb1sXz1OsTpU1QbUFIpwM2nVuxurUxl9rIyndZf89nF+bcR
         MipZyLBXAmmZFRPLPtgNtF/jETE+nUOwpefflOQ8YCpOvHbpVJsrTBT7vI7UTi2z1jf+
         b98KOA8AdX8jZnW4t9T+ViO27tuaRyhVqyvg/RmWQ8HOadtThvg+lNw7Fs9E7umejlmf
         4irYViDJPhOYaxQTl2la7cWUWxcrKPHGSatkJ65P8B7WtcEsoHQfM7sdon5rTLLjcXyN
         iOEaaFqzyUJBEn6mk8OVL52v3ty5X94fnWAk100DIBF5XoNymaGOgxm3K26UiChGU1JA
         kMPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBzAGR1Bq9N1Bq24Jrm3x7Al3LBcMnO4aRSWt/WSFDJ9vpg/duxwmmG6NLVV9SPj87cvgKfe0puUB9JEy8@vger.kernel.org, AJvYcCVl8rJad83hp1Xtsw+tvV4PeDZ5GhE2CDbCzI8Fh6N6TDWT68I74OCUEiaU5uWyaCCXqZ6BK155xbG6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WQE5ilurbHjzqnDTQPP6Xdxz7GHs9RWpbOXiF9RSzj7ytiKG
	RAtzcaBNMpqq/EAISiOWofhEYDCM0I80VZUpBl8wsAhSv4zp6Pdj
X-Google-Smtp-Source: AGHT+IEx31Wo3RHQhlQ+bJER9qwgWtEFev8OhjxjOYjmNLA5Ltf/UkCLEmUf765W3VIw0oyKUCENCg==
X-Received: by 2002:a17:90b:33c9:b0:2d8:b510:170f with SMTP id 98e67ed59e1d1-2e1b398fe46mr5668153a91.20.1727993377654;
        Thu, 03 Oct 2024 15:09:37 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:b8ac:3fa:437b:85fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d211asm5976a91.14.2024.10.03.15.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:09:37 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 2/2] arm64: dts: broadcom: bcmbca: bcm4908: Add DT for Zyxel EX3510-B
Date: Thu,  3 Oct 2024 15:08:20 -0700
Message-ID: <20241003220820.1345048-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241003220820.1345048-1-CFSworks@gmail.com>
References: <20241003220820.1345048-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zyxel EX3510-B is a WiFi 6 capable home gateway (family) based on the
BCM4906 SoC, with 512MiB of RAM and 512MiB of NAND flash. WiFi support
consists of a BCM6710 and a BCM6715 attached to separate PCIe buses.

Add an initial devicetree for this system, with support for:
- Onboard UART (per base dtsi)
- USB (2.0 only; superspeed devices are treated as high-speed due to an
    unknown cause)
- Both buttons (rear reset, front WPS)
- Almost all LEDs:
  - Power (red/green)
  - Internet (red/green)
  - WAN (green)
  - LAN (green; anode is connected to GPIO 13 so currently
      nonfunctioning)
  - USB (green)
  - WPS button (red/green)
  - Absent in DT: There are 2.4GHz/5.0GHz WiFi status LEDs connected to
      the WiFi chips instead of the SoC.
- NAND flash
- Embedded Ethernet switch
- Factory-programmed Ethernet MAC address

WiFi cannot be enabled at this time due to Linux lacking drivers for
both the PCIe controllers and the PCIe WiFi peripherals.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   1 +
 .../broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts | 197 ++++++++++++++++++
 2 files changed, 198 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
index 27741b71ba9e..9a8461d91c8c 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_BCMBCA) += \
 				bcm4906-netgear-r8000p.dtb \
 				bcm4906-tplink-archer-c2300-v1.dtb \
+				bcm4906-zyxel-ex3510b.dtb \
 				bcm4908-asus-gt-ac5300.dtb \
 				bcm4908-netgear-raxe500.dtb \
 				bcm94908.dtb \
diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts
new file mode 100644
index 000000000000..b70d8ffe4922
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "bcm4906.dtsi"
+
+/ {
+	compatible = "zyxel,ex3510b", "brcm,bcm4906", "brcm,bcm4908", "brcm,bcmbca";
+	model = "Zyxel EX3510-B";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0 0 0 0x20000000>;
+	};
+
+	gpio-keys-polled {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		key-wps {
+			label = "WPS";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+		};
+
+		key-reset {
+			label = "Reset";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
+		};
+	};
+};
+
+&leds {
+	pinctrl-0 = <&pins_led_0_a>, <&pins_led_2_a>, <&pins_led_3_a>,
+		    <&pins_led_4_a>, <&pins_led_10_a>, <&pins_led_12_a>,
+		    <&pins_led_14_a>, <&pins_led_15_a>, <&pins_led_21_a>;
+	pinctrl-names = "default";
+
+	led@0 {
+		reg = <0x0>;
+		function = LED_FUNCTION_POWER;
+		color = <LED_COLOR_ID_RED>;
+	};
+
+	led@2 {
+		reg = <0x2>;
+		function = LED_FUNCTION_WAN_ONLINE;
+		color = <LED_COLOR_ID_GREEN>;
+	};
+
+	led@3 {
+		reg = <0x3>;
+		function = LED_FUNCTION_WAN_ONLINE;
+		color = <LED_COLOR_ID_RED>;
+	};
+
+	led@4 {
+		reg = <0x4>;
+		function = LED_FUNCTION_USB;
+		color = <LED_COLOR_ID_GREEN>;
+		trigger-sources = <&ohci_port1>, <&ohci_port2>,
+				  <&ehci_port1>, <&ehci_port2>,
+				  <&xhci_port1>, <&xhci_port2>;
+		linux,default-trigger = "usbport";
+	};
+
+	led@a {
+		reg = <0xa>;
+		function = LED_FUNCTION_POWER;
+		color = <LED_COLOR_ID_GREEN>;
+		linux,default-trigger = "default-on";
+	};
+
+	led@c {
+		reg = <0xc>;
+		function = LED_FUNCTION_LAN;
+		color = <LED_COLOR_ID_GREEN>;
+		active-low;
+	};
+
+	led@e {
+		reg = <0xe>;
+		function = LED_FUNCTION_WPS;
+		color = <LED_COLOR_ID_GREEN>;
+		active-low;
+	};
+
+	led@f {
+		reg = <0xf>;
+		function = LED_FUNCTION_WPS;
+		color = <LED_COLOR_ID_RED>;
+		active-low;
+	};
+
+	led@15 {
+		reg = <0x15>;
+		function = LED_FUNCTION_WAN;
+		color = <LED_COLOR_ID_GREEN>;
+		active-low;
+	};
+};
+
+&enet {
+	nvmem-cells = <&base_mac_addr>;
+	nvmem-cell-names = "mac-address";
+};
+
+&usb_phy {
+	brcm,ioc = <1>;
+	brcm,ipp = <1>;
+	status = "okay";
+};
+
+&ehci {
+	status = "okay";
+};
+
+&ohci {
+	status = "okay";
+};
+
+&xhci {
+	status = "okay";
+};
+
+&ports {
+	port@0 {
+		label = "lan1";
+	};
+
+	port@1 {
+		label = "lan2";
+	};
+
+	port@2 {
+		label = "lan3";
+	};
+
+	port@3 {
+		label = "lan4";
+	};
+
+	port@7 {
+		reg = <7>;
+		phy-mode = "internal";
+		phy-handle = <&phy12>;
+		label = "wan";
+	};
+};
+
+&nand_controller {
+	status = "okay";
+};
+
+&nandcs {
+	brcm,nand-oob-sector-size = <27>;
+	nand-ecc-strength = <8>;
+	nand-ecc-step-size = <512>;
+	nand-on-flash-bbt;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	partitions {
+		compatible = "brcm,bcm4908-partitions";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			compatible = "nvmem-cells";
+			label = "cferom";
+			reg = <0x0 0x100000>;
+			read-only;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x0 0x100000>;
+
+			base_mac_addr: mac@106a0 {
+				reg = <0x106a0 0x6>;
+			};
+		};
+
+		partition@100000 {
+			compatible = "brcm,bcm4908-firmware";
+			reg = <0x100000 0x5f80000>;
+		};
+
+		partition@6080000 {
+			compatible = "brcm,bcm4908-firmware";
+			reg = <0x6080000 0x5f80000>;
+		};
+	};
+};
-- 
2.44.2


