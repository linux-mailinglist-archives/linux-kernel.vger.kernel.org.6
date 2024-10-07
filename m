Return-Path: <linux-kernel+bounces-353315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F8D992C23
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27AE2813F3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C021D7985;
	Mon,  7 Oct 2024 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JD4qR1in"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D821D5ACE
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304804; cv=none; b=uL1XEUVFdMkCurlYR3Nn6TtZN+5gOZRzDA9tS5wSW6ZEZdogWBQ0Kk/GIrz9I2NZTAgTiwJ6b6dO01v/55Q+BiE5MehTvd+TKXkcgsMeKvEI7ceWBsGZlMrRZqWklKuFZxUvnVPUzTspwGBBsVmr6N3GXHxOP7kwW+0/TlBNt4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304804; c=relaxed/simple;
	bh=MG2zG1bQpYhX9tF6Jz6wNxWrPu+3Z4sbMxD50E4qKOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TdlOwOKuhOk42VVUqHvr1MncQM+H1d3PA8HvTqtDK5DhW17C0TR2JOcgBHrcO9L+KnT/bONw3z+lHmbtHapIBAAw/chVz/pVBl4KvoGAiB1t+oZNRFIRi1Ak6YV11p2GSeh3iMgzvdaUQnROk4mftVn2lYMczFZO0JSniaUpCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JD4qR1in; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539973829e7so4279071e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728304797; x=1728909597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDBbUzAbVmbfauTgZMPEls+orUZqC1xI/z6QelfsXFI=;
        b=JD4qR1inRSdtNB0+ZrzVy1BGbR8QneP09WeESPh0ZVVwOQF/jlWJO8bilWi2yMpEuT
         RPhMJ4CJbFsn3Wz8brZ2Q1e/RC40iIJ1/JaiOI9zwbqGiCsaRPJA+TxW2uJup0K0BQa3
         e7x9VqWBhCDUV2uneUNZ035VSyMtYLQ02ICduwCzny4zaAZvJoqwykPXFus47rkHeEv1
         GtzZcP4Cind0ZhOp1NQh/OMDHT67Qw/b9yZuufiMhCR3vu0BagE3gErEWw59cnTmbhgs
         n1rThDrsa2uziJsSi6K3r0MwKojJGxXhZyeZjY70lJwZ+0oCXHo56cuU3OC6CTX70BKz
         rGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304797; x=1728909597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDBbUzAbVmbfauTgZMPEls+orUZqC1xI/z6QelfsXFI=;
        b=JWTr9QfX3H6Uxep/85oedAJMrm5QYOmEQbqSyusSMAIn6V2TCxORI8k4BoFzazjAFE
         xku7lSgsHjqZUt5V2g5yNM8XzqRop5B+tegmT8uYAsWVWOKafy2RkNZCWTUYlEJVfCBd
         p6o4gf4IwcSgXBTgwEh83mh5gjoQNiBW//Jo55clqAUkrb8m3gEt3ONypsFGVWJ1SfA2
         aEyIzfxjKgJ2YEHHwKwuq5DvjRFz2jz5H470QWjJ6DBgtcC3QjgtPCVVqeoK1HCKlRSp
         J0b1MWsCH4KHE3t3PvMdDXdXzACVEzFBWNzyaNfBmUHZrF8vbLh9D5X/AImlP2iFKClX
         T+6A==
X-Forwarded-Encrypted: i=1; AJvYcCV85syFHo9EEIkWNCaMIP4uWPE4M1ESliH1bfliO2fTKCw++AHnL2Jl2u0oRox2ceHsTS4IFXZ8v3JpZrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0J8119upZvoemdixTfa5j6BLZm3iaW2yZqdp3Jln6XFuna5N
	s6SqSuuQMpGlR5+usiAOzwxqpNtEmsOjW+THB/Dg8LKUQ8EEPpaYP42SWmxlLyA=
X-Google-Smtp-Source: AGHT+IHsa3cuseb+TMLjf68nJZfaXpa4Y/U/qsSRZ8J4Yx8YStwpVyo0ZpW4Nb8/l9tXLVtsADvnlA==
X-Received: by 2002:a05:6512:159d:b0:536:53a9:96d5 with SMTP id 2adb3069b0e04-539ab866484mr5107703e87.17.1728304797453;
        Mon, 07 Oct 2024 05:39:57 -0700 (PDT)
Received: from localhost (host-87-21-212-62.retail.telecomitalia.it. [87.21.212.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a995350d522sm145624166b.32.2024.10.07.05.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:39:57 -0700 (PDT)
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
Subject: [PATCH v2 10/14] arm64: dts: rp1: Add support for RaspberryPi's RP1 device
Date: Mon,  7 Oct 2024 14:39:53 +0200
Message-ID: <3f6f38c06b065f5f6034ad4ed3a24902ee59f378.1728300190.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1728300189.git.andrea.porta@suse.com>
References: <cover.1728300189.git.andrea.porta@suse.com>
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
"[PATCH v2 11/14] misc: rp1: RaspberryPi RP1 misc driver", since they
are closely related in terms of compiling.

 MAINTAINERS                           |  1 +
 arch/arm64/boot/dts/broadcom/rp1.dtso | 62 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
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
index 000000000000..846a0c99a098
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
@@ -0,0 +1,62 @@
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
+				interrupt-controller;
+				interrupt-parent = <&pci_ep_bus>;
+				#interrupt-cells = <2>;
+
+				rp1_clocks: clocks@c040018000 {
+					compatible = "raspberrypi,rp1-clocks";
+					reg = <0xc0 0x40018000 0x0 0x10038>;
+					#clock-cells = <1>;
+					clocks = <&clk_rp1_xosc>;
+					clock-names = "rp1-xosc";
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


