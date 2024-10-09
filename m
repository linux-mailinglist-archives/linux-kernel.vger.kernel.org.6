Return-Path: <linux-kernel+bounces-357933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 050B59977F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DCD1C2287C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511451E32DF;
	Wed,  9 Oct 2024 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CADBKayP"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8B193092;
	Wed,  9 Oct 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728511008; cv=none; b=IAS+cEhExlD/UoEUQsA2O9Q+UpvY+Pvxw/4BG7CJYRGDZSp6hBxADy5cGHHKk5WbKs5MjDlzt8XJzeTmWYD/x3t/v6QRu1MHdobm4dMEmpQMhAb8dvIRh7vJVpuapZM6J0+pFO4v4JyqFxNDjAZMBI3W5yJZLIucG0h+wtlXZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728511008; c=relaxed/simple;
	bh=luxZS1EIGyKLUGSsyxSU0E6dfvKUVRkocMRabdI39Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtlsFXRuqBMqSfzl+T4TV1T1DKBkFkGHcfxWkjQJ8KR6Dr7EDySiu/BjvejJre9MwIRLW853bRqmyWpnDAGOEJGp5tir+tct4ZGiIaFLgLLWnVYoqGznsVPpNo9jD1hex2tEeolVG0gwebNTKl8/TmbLF8WY7kXcu1xMgxd2MeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CADBKayP; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71def715ebdso198657b3a.2;
        Wed, 09 Oct 2024 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728511006; x=1729115806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvc12RrHD0EbcHd1cDy0DszpAW7DOryGG1aaLpMkDbY=;
        b=CADBKayPZQOtteiLxcpY4SmHOxd7Y6a1KzJKZ9+hrjYPS7wY/RgcQfuZJJni78pQkl
         WVPfywUf9U38fjbol+wlvEJbrfsY2c26vS61uQ8Ty8Jd7A/TvxOMnfZfdQdPVdgEHby6
         Tue2B47NNrRnkSFKONb0UrZEj08jFjYDiVevJttdTqF+RMGI6cK/Qct3AdE4SwvQmCzU
         S//aDPajot6VY5WipRuc628Xo14ysVEOt7k5/9JdjO27ouKJAUVug6QQj/rdMYU+uDum
         cIbGij4EmuUyugIhfQKzIphT6lK7VzxvAWr6CrJc20R7fDZhr0swOnzVDrUOAU2qXBg3
         wzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728511006; x=1729115806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvc12RrHD0EbcHd1cDy0DszpAW7DOryGG1aaLpMkDbY=;
        b=wL8J6YPPC2kYOY5uaI+q/2JIVbtWQ3MInxmO4TucaMVPyFguO+clZSgGXoVlFylyGs
         OEhqgD4KnHhQGkxG/jKk864D/sGxIDpA9n9Niv1vHKGTNXrXPMmNh1ilf9I47+y9/Aqk
         LM5ym6VOU8PcEnTvEZJp7GAiJF4Pxouk//wxjURtauTxgRpfFnp1TVuU7qruZCWyKC0T
         xf+WaKD80+Iz4/n9N2tpSttQHWoYOxVVr0V0TYzRJhWlFYkfjE7z5Yu48RGJu744/QhW
         pvyPDj1q8IKxtXU8i1D+i1cWGiAgRAhhTIgcaf2llTqmW+1vf9Laqaf1TeTU9QriNddI
         A7Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVFrN/PBXVEUK8ou2VHCL5rABdqDhLA7tMNQ8P4/wfbPVzVDzlFcIirJM5m3PRm70TwnQcIBGvkBBfe@vger.kernel.org, AJvYcCX6xQn3TQdm7Xj+EWUYeLGLQdx4kaMR5+4YXx7Becb2rUB8qLGLXuD86GDMiK+DPQM9JSmVyNmtXmemYUux@vger.kernel.org
X-Gm-Message-State: AOJu0YznZNxnCBe2b1iY1bLYld+cq6TBh5NiT+sqLhHghvdjdO8658UC
	4VQsvz3/ukjfw6pDPIM3nRP6Xmaq1q1mKJafzsxfbrKE51IcfSLz
X-Google-Smtp-Source: AGHT+IEfUmWu5lAViwsQxHBJzI1BXfFw4WFfIWwDFa7hlvWzEhgH9U4Hq4sxnX827I217uJMaHA7CA==
X-Received: by 2002:a05:6a00:1149:b0:719:8f48:ff01 with SMTP id d2e1a72fcca58-71e1db63ea9mr6194879b3a.6.1728511006356;
        Wed, 09 Oct 2024 14:56:46 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00::315])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6833ce7sm7726646a12.48.2024.10.09.14.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:56:45 -0700 (PDT)
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
Subject: [PATCH v2 2/2] arm64: dts: broadcom: bcmbca: bcm4908: Add DT for Zyxel EX3510-B
Date: Wed,  9 Oct 2024 14:54:54 -0700
Message-ID: <20241009215454.1449508-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20241009215454.1449508-1-CFSworks@gmail.com>
References: <20241009215454.1449508-1-CFSworks@gmail.com>
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
 .../broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts | 196 ++++++++++++++++++
 2 files changed, 197 insertions(+)
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
index 000000000000..54e453bd09f7
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts
@@ -0,0 +1,196 @@
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
+		reg = <0x0 0x0 0x0 0x20000000>;
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


