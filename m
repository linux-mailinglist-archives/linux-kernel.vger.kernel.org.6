Return-Path: <linux-kernel+bounces-568863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4F0A69B64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB92D468757
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3362206A8;
	Wed, 19 Mar 2025 21:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IM6eFRHj"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94721C9EB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421100; cv=none; b=d9w1q9WWdZfuK4q4EaWZUfpyj1PVtkMjHGq579zBugyIBywwNLXHwm9lNXIKqPI7XNjS4HFFrYczK1M4+3sB+nMjnR+cXCtchaycKtb23svn8dQQcgNxMcsENdtz/7nhR40j5iFXVCPcXDKnu6FvfnG7Ya1iXN+Lw93AV0F7U0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421100; c=relaxed/simple;
	bh=Lhy7CEokE9Gijs+wEZ0284UNzyprowstDvOGnqo+duQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3cm/d2SvXIEldLk79cF2MKYH5PDWZVaKvdXcwadPYlxLTS2/C3SbjVFw89VZ5OvZjjK0Ku2CrZn/OSsqy+1jHsd/hDxQ4uxVwAgk/0jpLpJbQwro0Ctf8glRYhQ/u0H8Mz3X9+0m+8BcAV/PawIzmcjEBJ18km3nagrE64ppQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IM6eFRHj; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so37490466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421093; x=1743025893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2zy4FeXIXTtYjjpoH71JN1fhoa8L/cfW4fCg6XzYKI=;
        b=IM6eFRHja71MgTnpPW93Xsz2c42RXxF/xScgjf1LbKTxopDYTW2aksK5Z40ZdKSzEb
         tnH5PZyrDRYJGjbinmixiT9rc9aDKcNbdlVUIYajaFKOJqAE5g4oXhsFyxalnRvHADHb
         Izcp6klqJxF2JKQIklP5IqxnXGM14V308rigU5ijCKwWR2FqD7oI3YcdUTYOJ+AsUSeb
         7uY7F58cX3DX5RU+0OOipp7qKwbJmiLcQrqn6yC2VStyq9V5fuXEWcenO5e/smlFxcB0
         KsD/z2CosSbdtfUyz92k5zXEdo5vjdKXKclbvr+j1UEKe3kYLF1YoapzYxv/0gZcanBS
         O0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421093; x=1743025893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2zy4FeXIXTtYjjpoH71JN1fhoa8L/cfW4fCg6XzYKI=;
        b=gDiojYhnLSV9XasO8+m2tiM5hQKBJ0/1pTSIQOdi+SVY7hrRwEduohVoSl4KcDFbyI
         rY8IzDlXjjFxXgymLW9iagX8yPxMkdvcuse8FnDQMHe8+I5qPpy8mA0UKi0hbJEn5mA3
         fawuh5cdGC0YBxB7vu0z4LNr21r5J9zEOGJX7cVBHmKuemx5RYuryC+OFh+3XV1gcOwt
         OdMk6Ue6BxkodQJOnBZNCorbhHyf+pLMXdWxIg3mxDFWQ9RIYO2acjvS0yOnE+aeD1i7
         DpKFJVOrDi2dQa0ceQ/OYEk45U7wHDQ2H6XSka0GmGCKz5xE6e9FxJ2zRvX15WNxjtcI
         pALg==
X-Forwarded-Encrypted: i=1; AJvYcCUX0r7+t1ZKsh4Rq3wIFYf9EdgvmaGIT0539R5WgDCJo6LOaE1wUbeiOokv3XAtG/BS5mMydQkpq+MwjKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1WH6cNIbEejj1yF4W1Rtl3E1aZ7OGRZQztHGE0AIO/YWBOS6J
	9PDVUoW+vaXN8NsyPQB+b3qm02lZSKtpw37PlX1DjSPTOMZXC2ghi+P7AgMgEl0=
X-Gm-Gg: ASbGncvESk/d1yNjceG4RIeBirV1ZuUNHQcb6BXtMiHWNH8QWivL6OF8N2SLukqM1EA
	vkBU8CZ6gzExf/5bH9ZiNXtb+jeEQjW0hLxDgOy8r1yU6hSw5uTmaTsWOIHPdfnkBy6iPkbn7g+
	6CiCxiUbZHPiCec1dIy7RDjTZaEooctYkOr8rxvP87gGr+aFkOQE7mpkWqaYWTU0zWhACAswBnG
	miB6DxCGtyNq5CqLSyPdblLHW1PyOTXSrxirFx4Jd7SMkNcaaMvqNq5Tf8P8/eNfNng3cpW86en
	4RVbWZxG1hj4S1+PycXmH7HvyHvZqLqq487eNtaPkq+5s0JWF4+CfMJhBuOeBAdMvy7HJCrOFVD
	m/D2FS0hAog==
X-Google-Smtp-Source: AGHT+IGNlsQE3/+ip7HiTTOlJRqlxotWKEGD3QpH9WcC3PxLd3+7MT5s4pAz5vww6yDtWBF8s6KPiQ==
X-Received: by 2002:a17:907:3d9e:b0:ac2:7cd1:3aa0 with SMTP id a640c23a62f3a-ac3b7fcca8bmr538543566b.57.1742421093063;
        Wed, 19 Mar 2025 14:51:33 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa5208sm1073774366b.177.2025.03.19.14.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:32 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: [PATCH v8 07/13] arm64: dts: rp1: Add support for RaspberryPi's RP1 device
Date: Wed, 19 Mar 2025 22:52:28 +0100
Message-ID: <99269f7762ec0124315e0e8977d9ca4f469f89ce.1742418429.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1742418429.git.andrea.porta@suse.com>
References: <cover.1742418429.git.andrea.porta@suse.com>
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
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 MAINTAINERS                                  |  1 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi | 42 ++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi  | 14 +++++++
 3 files changed, 57 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-common.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index c2749c588809..6e07b4fb1924 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19751,6 +19751,7 @@ F:	drivers/media/platform/raspberrypi/rp1-cfe/
 RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/rp1*.dts*
 F:	drivers/clk/clk-rp1.c
 F:	drivers/pinctrl/pinctrl-rp1.c
 
diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
new file mode 100644
index 000000000000..5002a375eb0b
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
+
+pci_ep_bus: pci-ep-bus@1 {
+	compatible = "simple-bus";
+	ranges = <0x00 0x40000000  0x01 0x00 0x00000000  0x00 0x00400000>;
+	dma-ranges = <0x10 0x00000000  0x43000000 0x10 0x00000000  0x10 0x00000000>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	rp1_clocks: clocks@40018000 {
+		compatible = "raspberrypi,rp1-clocks";
+		reg = <0x00 0x40018000 0x0 0x10038>;
+		#clock-cells = <1>;
+		clocks = <&clk_rp1_xosc>;
+		assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
+				  <&rp1_clocks RP1_PLL_SYS>,
+				  <&rp1_clocks RP1_PLL_SYS_SEC>,
+				  <&rp1_clocks RP1_CLK_SYS>;
+		assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
+				       <200000000>,  // RP1_PLL_SYS
+				       <125000000>,  // RP1_PLL_SYS_SEC
+				       <200000000>;  // RP1_CLK_SYS
+	};
+
+	rp1_gpio: pinctrl@400d0000 {
+		compatible = "raspberrypi,rp1-gpio";
+		reg = <0x00 0x400d0000  0x0 0xc000>,
+		      <0x00 0x400e0000  0x0 0xc000>,
+		      <0x00 0x400f0000  0x0 0xc000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+			     <1 IRQ_TYPE_LEVEL_HIGH>,
+			     <2 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi b/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
new file mode 100644
index 000000000000..0ef30d7f1c35
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+rp1_nexus {
+	compatible = "pci1de4,1";
+	#address-cells = <3>;
+	#size-cells = <2>;
+	ranges = <0x01 0x00 0x00000000
+		  0x02000000 0x00 0x00000000
+		  0x0 0x400000>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	#include "rp1-common.dtsi"
+};
-- 
2.35.3


