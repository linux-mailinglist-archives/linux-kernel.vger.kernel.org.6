Return-Path: <linux-kernel+bounces-294121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A80958991
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 900B5B215C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AB1192B76;
	Tue, 20 Aug 2024 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="W7vcF3dY"
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22F11917E0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164578; cv=none; b=PJKOfmPY5KrWjb8ReGZ8VTrRkwT+kgfC9sWlc/bokbRvhGI1zyP7/w0MQpKbeiwvGsuQrbDnfA4ovW9YRYzimwkfDN3cs78HxptvTpuOFZiSbO4pPJy1KdOnJsQrxTZo+5wr7Bl4+GTatmkSRiXzqOXHBTh+DVMCJCAOo7GM8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164578; c=relaxed/simple;
	bh=zuktvUjNWXMImNkeTtLFSHHzhM7nEaX7nzni+eAnH3Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqC0uZr8ApysQMAlwQkl0xy/mKlARvsfc+KpFDjvwA3XbWCyhl0DINA+8b7a5RAjHAG1H44P3kX8iDDpGxcF4wWGjSdBD7aS7kri5sWwFVT6eqlisnvW61H8+I5FnCCKRqIq0RYnRVxrtSB8PO1rOr0DgYYBjzgfvUFfkuJ+3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=W7vcF3dY; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-52efdf02d13so7407005e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724164573; x=1724769373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHu+9p6fy0B9DjKzKrA0lK/WG9JbQEJbtKENjEf1pwk=;
        b=W7vcF3dYHioTcKOuIYIo6n6+vRtdw1xJkHt8d27dnlXlR95qd8ngmLJXGBgbJoGff9
         /Vwz7WPJhqrrQp626RCGqVG6QRSa1Vgas5KqC4ruq7jaz/9NoLct+VOSQo6bjOVTT3N9
         XrOlwHJFNTJ96f/Pb8dSlNdDYi1h4/PMDOrk0UXcjZiYjk/oUkAN8SUACsjr7IREhZ3L
         ToEVlQ9n3K+1HaNGsyd5MPpZ1XqS3TUyFBM4gpCpd1WUcpsMxkGT5PDkQvc7OUKJj2oj
         sa/q2cVGUikjBoUGE0xqtK3eUegb+zsORBscTnrozIVwNa6XM24eFZJqR1YXVHeQLYxr
         L/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164573; x=1724769373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHu+9p6fy0B9DjKzKrA0lK/WG9JbQEJbtKENjEf1pwk=;
        b=jVhOQeppHsSmo9F923gw/aboGOSXu6p03d+3Y/f1Y1rEy1LJOBHvYeLOJFhSIwYTip
         b73lhvhHb1K6mNZ61JuSha63qbDaBmJhimVsiCHIB21nzb3MxpxxdImOI3HvAJnwE19L
         2FfkCMcl+yjTEnqvDCGK+yLsxb1zldycoow9Kbbt8N7VqrbAYiV+4JbIfSFtYumkl+dZ
         qLpSZE8W6Uq8Y2dyL4vi4JHdPH1+k+RKhDH6CCpIEP3rPWcI3ER5huWUmSof6dZ/orqs
         EswiXuJwBX+Geen5C53k6b3+ehBCp1bVjWABajULPWMUTne7NIkap1ZEJLChLBFJiPpU
         +xvw==
X-Forwarded-Encrypted: i=1; AJvYcCXhzhsR6kYWguDa7w3IdevhQmQ3gFDKLtB26alPp+7HBYeqsRgBuWk41yDxcHm0e1EY7Rb09bTf9+4gcts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zGUqkJvubJSu/45RD/8HAq8K1fVZL2wZwEZle+G68naGbgHA
	nnmexPyHEqnZhqEmTOEKWBz4w1wVUusN68UolOgy56mQyany5YFgkJkPfJM1bbg=
X-Google-Smtp-Source: AGHT+IF9Ser2XrcrS55JMHmj+9A2o//OfYkDsSH6Bg071olmkQupPK4x4M42RDza57V7ur4d+qD5iQ==
X-Received: by 2002:a05:6512:2346:b0:530:ad8d:dcdb with SMTP id 2adb3069b0e04-5331c6a1931mr13803638e87.19.1724164572476;
        Tue, 20 Aug 2024 07:36:12 -0700 (PDT)
Received: from localhost ([87.13.33.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838eee50sm774414666b.93.2024.08.20.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:36:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH 01/11] dt-bindings: clock: Add RaspberryPi RP1 clock bindings
Date: Tue, 20 Aug 2024 16:36:03 +0200
Message-ID: <8d7dd7ca5da41f2a96e3ef4e2e3f29fd0d71906a.1724159867.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724159867.git.andrea.porta@suse.com>
References: <cover.1724159867.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the clock generator found in RP1 multi
function device, and relative entries in MAINTAINERS file.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../clock/raspberrypi,rp1-clocks.yaml         | 87 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 include/dt-bindings/clock/rp1.h               | 56 ++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 create mode 100644 include/dt-bindings/clock/rp1.h

diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
new file mode 100644
index 000000000000..b27db86d0572
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 clock generator
+
+maintainers:
+  - Andrea della Porta <andrea.porta@suse.com>
+
+description: |
+  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
+  VIDEO), and each PLL output can be programmed though dividers to generate
+  the clocks to drive the sub-peripherals embedded inside the chipset.
+
+  Link to datasheet:
+  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-clocks
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    description:
+      The index in the assigned-clocks is mapped to the output clock as per
+      definitions in dt-bindings/clock/rp1.h.
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rp1.h>
+
+    rp1 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        rp1_clocks: clocks@18000 {
+            compatible = "raspberrypi,rp1-clocks";
+            reg = <0xc0 0x40018000 0x0 0x10038>;
+            #clock-cells = <1>;
+            clocks = <&clk_xosc>;
+
+            assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
+                              <&rp1_clocks RP1_PLL_AUDIO_CORE>,
+                              /* RP1_PLL_VIDEO_CORE and dividers are now managed by VEC,DPI drivers */
+                              <&rp1_clocks RP1_PLL_SYS>,
+                              <&rp1_clocks RP1_PLL_SYS_SEC>,
+                              <&rp1_clocks RP1_PLL_AUDIO>,
+                              <&rp1_clocks RP1_PLL_AUDIO_SEC>,
+                              <&rp1_clocks RP1_CLK_SYS>,
+                              <&rp1_clocks RP1_PLL_SYS_PRI_PH>,
+                              /* RP1_CLK_SLOW_SYS is used for the frequency counter (FC0) */
+                              <&rp1_clocks RP1_CLK_SLOW_SYS>,
+                              <&rp1_clocks RP1_CLK_SDIO_TIMER>,
+                              <&rp1_clocks RP1_CLK_SDIO_ALT_SRC>,
+                              <&rp1_clocks RP1_CLK_ETH_TSU>;
+
+            assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
+                                   <1536000000>, // RP1_PLL_AUDIO_CORE
+                                   <200000000>,  // RP1_PLL_SYS
+                                   <125000000>,  // RP1_PLL_SYS_SEC
+                                   <61440000>,   // RP1_PLL_AUDIO
+                                   <192000000>,  // RP1_PLL_AUDIO_SEC
+                                   <200000000>,  // RP1_CLK_SYS
+                                   <100000000>,  // RP1_PLL_SYS_PRI_PH
+                                   /* Must match the XOSC frequency */
+                                   <50000000>, // RP1_CLK_SLOW_SYS
+                                   <1000000>, // RP1_CLK_SDIO_TIMER
+                                   <200000000>, // RP1_CLK_SDIO_ALT_SRC
+                                   <50000000>; // RP1_CLK_ETH_TSU
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..6e7db9bce278 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19116,6 +19116,12 @@ F:	Documentation/devicetree/bindings/media/raspberrypi,pispbe.yaml
 F:	drivers/media/platform/raspberrypi/pisp_be/
 F:	include/uapi/linux/media/raspberrypi/
 
+RASPBERRY PI RP1 PCI DRIVER
+M:	Andrea della Porta <andrea.porta@suse.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	include/dt-bindings/clock/rp1.h
+
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
diff --git a/include/dt-bindings/clock/rp1.h b/include/dt-bindings/clock/rp1.h
new file mode 100644
index 000000000000..1ed67b8a5229
--- /dev/null
+++ b/include/dt-bindings/clock/rp1.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2021 Raspberry Pi Ltd.
+ */
+
+#define RP1_PLL_SYS_CORE		0
+#define RP1_PLL_AUDIO_CORE		1
+#define RP1_PLL_VIDEO_CORE		2
+
+#define RP1_PLL_SYS			3
+#define RP1_PLL_AUDIO			4
+#define RP1_PLL_VIDEO			5
+
+#define RP1_PLL_SYS_PRI_PH		6
+#define RP1_PLL_SYS_SEC_PH		7
+#define RP1_PLL_AUDIO_PRI_PH		8
+
+#define RP1_PLL_SYS_SEC			9
+#define RP1_PLL_AUDIO_SEC		10
+#define RP1_PLL_VIDEO_SEC		11
+
+#define RP1_CLK_SYS			12
+#define RP1_CLK_SLOW_SYS		13
+#define RP1_CLK_DMA			14
+#define RP1_CLK_UART			15
+#define RP1_CLK_ETH			16
+#define RP1_CLK_PWM0			17
+#define RP1_CLK_PWM1			18
+#define RP1_CLK_AUDIO_IN		19
+#define RP1_CLK_AUDIO_OUT		20
+#define RP1_CLK_I2S			21
+#define RP1_CLK_MIPI0_CFG		22
+#define RP1_CLK_MIPI1_CFG		23
+#define RP1_CLK_PCIE_AUX		24
+#define RP1_CLK_USBH0_MICROFRAME	25
+#define RP1_CLK_USBH1_MICROFRAME	26
+#define RP1_CLK_USBH0_SUSPEND		27
+#define RP1_CLK_USBH1_SUSPEND		28
+#define RP1_CLK_ETH_TSU			29
+#define RP1_CLK_ADC			30
+#define RP1_CLK_SDIO_TIMER		31
+#define RP1_CLK_SDIO_ALT_SRC		32
+#define RP1_CLK_GP0			33
+#define RP1_CLK_GP1			34
+#define RP1_CLK_GP2			35
+#define RP1_CLK_GP3			36
+#define RP1_CLK_GP4			37
+#define RP1_CLK_GP5			38
+#define RP1_CLK_VEC			39
+#define RP1_CLK_DPI			40
+#define RP1_CLK_MIPI0_DPI		41
+#define RP1_CLK_MIPI1_DPI		42
+
+/* Extra PLL output channels - RP1B0 only */
+#define RP1_PLL_VIDEO_PRI_PH		43
+#define RP1_PLL_AUDIO_TERN		44
-- 
2.35.3


