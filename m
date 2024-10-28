Return-Path: <linux-kernel+bounces-385122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B0F9B32C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3711F22684
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC69E1DED67;
	Mon, 28 Oct 2024 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SMecslP5"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3631DE4CD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124452; cv=none; b=s4ho+mF93VT9/8IxMZCjI+DknaSg/oaO4VvQQP4c0YNUPvSHTAzPEMDho6hRKlj/R3UmaPr5FUtgjbvLWfwgabB4w59zukpmo6Ppp5PEnEqO0VOa9K+5j7M8jLPwphyDke7x5oSgkry3jMheSsikKH/bn7TSHRqBtWVImI44bMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124452; c=relaxed/simple;
	bh=jVpFSFjRvCO431pFJM5NtQyQ/ko6vIsiLp52mklCu98=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSg0+hqYXo3cRQtImLUy5/8+rAZZCiPE+uYhYpPlL26l7BcshTHSJFwlyR+Pf6zOjwPtIQrxZVBxrgb04uUVBg8ki+d94tpQ3dNIJHtvU+e+TS08YbL0garBvrTKughXa89TK1e9mPEexPQw0CPvfoVW/nOKEE1n3IM1fwxrf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SMecslP5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9acafdb745so782279566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730124445; x=1730729245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVZZiKyJj7ZnmSyKDxiL2Ewqy8l9yzTHRtpEpGvvetk=;
        b=SMecslP5R+XHNDJJDRWjDaPp0yrVA66icFom+/n2LAvdC5i6tr67KO6e6M8pi99om8
         EX8I0CuW83XGmvWJcTJE8OUGjh8Ugceo6LqmmdE7TFrXthgeGTxG8j99HMndi3+o/Czr
         vUuVd6ts9DdMJM5HnlX4Ns1ChGNqGIU9GM4ifn4WcgZgwbxfDzvMlvXOdqkQMnZRZ8oI
         ttI0wQ0IUWoerN3nlfjeqGDLIqv3MRpITPDrD6CHwWpBYqAo1qy429TecWu8oq3KDVf/
         Id6yvj5xXBGazXhXcKeyA4N/S/JM83J9MnHaApCktpqHZe5MqoiR1XGT6nA0zZervsko
         pw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124445; x=1730729245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVZZiKyJj7ZnmSyKDxiL2Ewqy8l9yzTHRtpEpGvvetk=;
        b=iEMqQtqnjCPgdVERHwPX1L3ie2cP9zyXU5q/Rfx0KH3hfbMHu/pxSMLbq7v2sB3l7O
         QdIo5ita9W8qw/TVUkm2ejhn7pIL+Vau8yItN92b15XuROsNe85fVXlV1gQyXjse/Q5C
         80IPB4SvtMemLXCgB3sj+YdGj1wSFTvCxF1/n2rhf5bwP/Rxa9YlC9e6EVsWBRURQwfI
         tsKAhSmxE97RztlgY3Ajc+lI4XlTeKbE6V69ArTUe5scKUKDg68F2akFvHX2W1R32a/H
         IPTWeFBLawiasHDVP8ML04DgcIAuRaiHG5fwVxucYbsQpjJGttI6Eks9tsL9XN3ThOjK
         VUnA==
X-Forwarded-Encrypted: i=1; AJvYcCXWp65PO8t7lQwKwWx6EaCtW3crEK4ljIF768FRWksDN3J1MYvHCbeECmyxWpv8PG1Ywzdcfw1b4eC5Rpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERnHIeNQfS3b9R1SX5SYBTsse5OZyBpGZ1YM90WUmaFRv2Npl
	nGHdxcz/Rv6lYsAGEXvTqkstE6u2+QOzVuxQ4fHB4s1opiqgFFyoCASw8uaroTU=
X-Google-Smtp-Source: AGHT+IEQdbITjqhgIXETXbiDGS9CpxFITbMxPJxEoYU59S+9lkAwLuR8Fmvi9lRxn9X6MPz0PlOOOw==
X-Received: by 2002:a17:907:1c92:b0:a99:f9fa:5c01 with SMTP id a640c23a62f3a-a9de391b292mr763533366b.32.1730124445300;
        Mon, 28 Oct 2024 07:07:25 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7d16sm378731766b.21.2024.10.28.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:07:24 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v3 09/12] arm64: dts: rp1: Add support for RaspberryPi's RP1 device
Date: Mon, 28 Oct 2024 15:07:26 +0100
Message-ID: <1f4cec50493ec5d3168735c0a005771787e5cd59.1730123575.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RaspberryPi RP1 is a multi function PCI endpoint device that
exposes several subperipherals via PCI BAR.
Add a dtb overlay that will be compiled into a binary blob
and linked in the RP1 driver.
This overlay offers just minimal support to represent the
RP1 device itself, the sub-peripherals will be added by
future patches.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
NOTE: this patch should be taken by the same maintainer that will take
"[PATCH v3 10/12] misc: rp1: RaspberryPi RP1 misc driver", since they
are closely related in terms of compiling.

 MAINTAINERS                           |  1 +
 arch/arm64/boot/dts/broadcom/rp1.dtso | 61 +++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso

diff --git a/MAINTAINERS b/MAINTAINERS
index 06277969a522..510a071ede78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19383,6 +19383,7 @@ F:	include/uapi/linux/media/raspberrypi/
 RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/rp1.dtso
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
new file mode 100644
index 000000000000..8d1bbf207a30
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			compatible = "pci1de4,1";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			pci_ep_bus: pci-ep-bus@1 {
+				compatible = "simple-bus";
+				ranges = <0xc0 0x40000000
+					  0x01 0x00 0x00000000
+					  0x00 0x00400000>;
+				dma-ranges = <0x10 0x00000000
+					      0x43000000 0x10 0x00000000
+					      0x10 0x00000000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+
+				rp1_clocks: clocks@c040018000 {
+					compatible = "raspberrypi,rp1-clocks";
+					reg = <0xc0 0x40018000 0x0 0x10038>;
+					#clock-cells = <1>;
+					clocks = <&clk_rp1_xosc>;
+					clock-names = "xosc";
+					assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
+							  <&rp1_clocks RP1_PLL_SYS>,
+							  <&rp1_clocks RP1_CLK_SYS>;
+					assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
+							       <200000000>,  // RP1_PLL_SYS
+							       <200000000>;  // RP1_CLK_SYS
+				};
+
+				rp1_gpio: pinctrl@c0400d0000 {
+					compatible = "raspberrypi,rp1-gpio";
+					reg = <0xc0 0x400d0000  0x0 0xc000>,
+					      <0xc0 0x400e0000  0x0 0xc000>,
+					      <0xc0 0x400f0000  0x0 0xc000>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+						     <1 IRQ_TYPE_LEVEL_HIGH>,
+						     <2 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+		};
+	};
+};
-- 
2.35.3


