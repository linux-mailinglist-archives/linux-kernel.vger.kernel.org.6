Return-Path: <linux-kernel+bounces-353308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463B2992C01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15934B242A0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338B1D4156;
	Mon,  7 Oct 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mi0rwbNZ"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850111D2F64
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304793; cv=none; b=VGAZ1DAuKA6UtN1/dGlfVoj+J42lFXCf9u0QykgnruJDS1DRmkJwu8ITKfww1rTY6fbTOpbnos4eEYtez7K77ik7Je1S6elId1Fd94aboXf8xFbkQTVBMxmVKeEEbD5N90qZZ4be3iBavkvbOTkwFuUWSOoil+nJQ9t3/wqwaWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304793; c=relaxed/simple;
	bh=ltCfjL/BttTDZuaWgfdIsVdh9gcTTSxn5v05bkxiJI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKxJBI6XwfMGCYUbPfsm6TfjYvfH+gPTOcIJZcIDZEieRmULLhlE1UL1QRRBFaUb36PttffypPNMbbgPbG7kY7qy0n4XH661xwB+fIvRKZ/T46+TrN5BFj2gvvePx89gL56WdzrJgcas1vIRXsjXwsAoYzaMRP8JyZY5ksD5aC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mi0rwbNZ; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5c8784e3bc8so6079466a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728304790; x=1728909590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eU3ji42pHlrfWJq1prcISuPTGN0LAJnGrZqn8om944U=;
        b=Mi0rwbNZKOFsChgSbgQbV50TVrReDZrVpfPS5+o8Fhz5kNKoenzZO4V/LSz3TzwUzQ
         bfsV5FmoT055ZR4wvXQsE/2DDld9/x99ToXAdpLJNqo8TAPJcn7R2X1esoFMT7rB/Wyj
         Y1BQERe7y/aSnARiZ4ldXTXd7W3QBgTGMoGMSPXKe7r8PLCMlcDgOS3PVMfcMxd+DR/S
         447GQ7ddwlU7K3YbSkZQC+mpQKNxovXnNFWLSLA6OcRJ6cZdRtHR0qF/MjhbsuOZOQbF
         WVnlw2s0+aggwKV5lX8CrarIWpiJxMbhr0StEysvpG8HiTsLBmz/sHoMGPYsOmrc+o7J
         SySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304790; x=1728909590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eU3ji42pHlrfWJq1prcISuPTGN0LAJnGrZqn8om944U=;
        b=GDAH5vJi3nZlb6t6U0tmfm+zauufxiq8X0afNLdvXJhWE96bhnBSmTBwpr+v05e0MH
         5zrqFYfICQEtnQsZrH3lrpD59KbZH5i4nvZ03n1bGUQQHU7JjWTVUaUNVkTnZMo8F1OV
         uYymi4sL9A039Fsn0lwcQGGXBnMRSL4Vqct8zx1jYb3C1U3/Kp11wX5pwgEkM/sa5igW
         K6CPHLIlhzNlDoyN1PpeFHzwp8TQQHRHI6PObdW2p0i40Lhj9+cuhsEtEuCnMESCPD2h
         KbB1hvpLGHaEthex9V9kxQW0q8ur0jGF7L57l0X9pLVOwfYYNAt1LOwtK+MmMK4ozObW
         AInQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/352GGG3kct2vudATo+HMJIMgTZ1FRUrk/JpELYrcBrptHsqUj50tD2Pws+fxxNNrhO9i/FL8mzRG6xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJGSWCO+LvlHLWsoq63iqN8VhMRADZ/8ERv3x+28wvnehkC9NR
	oY1IbpuWOD6BMWzhoylXYUC5mu41N5nZW/etCqIG+jMJGr8I5unutNTTyNuvYdE=
X-Google-Smtp-Source: AGHT+IGYdZc/ujfTjPKKP+5yoVqaatgPK8/RvNoAMYBcHf4RI2gthY/T+ULNWJG+Qr9qq+CZHwh19w==
X-Received: by 2002:a05:6402:4404:b0:5c8:9548:f283 with SMTP id 4fb4d7f45d1cf-5c8d2e4571fmr10385444a12.20.1728304789894;
        Mon, 07 Oct 2024 05:39:49 -0700 (PDT)
Received: from localhost (host-87-21-212-62.retail.telecomitalia.it. [87.21.212.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e0598947sm3101345a12.11.2024.10.07.05.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:39:49 -0700 (PDT)
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
Subject: [PATCH v2 04/14] dt-bindings: misc: Add device specific bindings for RaspberryPi RP1
Date: Mon,  7 Oct 2024 14:39:47 +0200
Message-ID: <3141e3e7898c1538ea658487923d3446b3d7fd0c.1728300189.git.andrea.porta@suse.com>
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

The RP1 is a MFD that exposes its peripherals through PCI BARs. This
schema is intended as minimal support for the clock generator and
gpio controller peripherals which are accessible through BAR1.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../devicetree/bindings/misc/pci1de4,1.yaml   | 110 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml

diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
new file mode 100644
index 000000000000..3f099b16e672
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/pci1de4,1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 MFD PCI device
+
+maintainers:
+  - Andrea della Porta <andrea.porta@suse.com>
+
+description:
+  The RaspberryPi RP1 is a PCI multi function device containing
+  peripherals ranging from Ethernet to USB controller, I2C, SPI
+  and others.
+  The peripherals are accessed by addressing the PCI BAR1 region.
+
+allOf:
+  - $ref: /schemas/pci/pci-ep-bus.yaml
+
+properties:
+  compatible:
+    additionalItems: true
+    maxItems: 3
+    items:
+      - const: pci1de4,1
+
+patternProperties:
+  "^pci-ep-bus@[0-2]$":
+    $ref: '#/$defs/bar-bus'
+    description:
+      The bus on which the peripherals are attached, which is addressable
+      through the BAR.
+
+unevaluatedProperties: false
+
+$defs:
+  bar-bus:
+    $ref: /schemas/pci/pci-ep-bus.yaml#/$defs/pci-ep-bus
+    unevaluatedProperties: false
+
+    properties:
+      "#interrupt-cells":
+        const: 2
+        description:
+          Specifies respectively the interrupt number and flags as defined
+          in include/dt-bindings/interrupt-controller/irq.h.
+
+      interrupt-controller: true
+
+      interrupt-parent:
+        description:
+          Must be the phandle of this 'pci-ep-bus' node. It will trigger
+          PCI interrupts on behalf of peripheral generated interrupts.
+
+    patternProperties:
+      "^clocks(@[0-9a-f]+)?$":
+        type: object
+        $ref: /schemas/clock/raspberrypi,rp1-clocks.yaml
+
+      "^ethernet(@[0-9a-f]+)?$":
+        type: object
+        $ref: /schemas/net/cdns,macb.yaml
+
+      "^pinctrl(@[0-9a-f]+)?$":
+        type: object
+        $ref: /schemas/pinctrl/raspberrypi,rp1-gpio.yaml
+
+    required:
+      - interrupt-parent
+      - interrupt-controller
+
+examples:
+  - |
+    pci {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        rp1@0,0 {
+            compatible = "pci1de4,1";
+            ranges = <0x01 0x00 0x00000000
+                      0x82010000 0x00 0x00
+                      0x00 0x400000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            pci_ep_bus: pci-ep-bus@1 {
+                compatible = "simple-bus";
+                ranges = <0xc0 0x40000000
+                          0x01 0x00 0x00000000
+                          0x00 0x00400000>;
+                dma-ranges = <0x10 0x00000000
+                              0x43000000 0x10 0x00000000
+                              0x10 0x00000000>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+                interrupt-controller;
+                interrupt-parent = <&pci_ep_bus>;
+                #interrupt-cells = <2>;
+
+                rp1_clocks: clocks@c040018000 {
+                    compatible = "raspberrypi,rp1-clocks";
+                    reg = <0xc0 0x40018000 0x0 0x10038>;
+                    #clock-cells = <1>;
+                    clocks = <&clk_rp1_xosc>;
+                    clock-names =  "rp1-xosc";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ccf123b805c8..2aea5a6166bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	include/dt-bindings/clock/rp1.h
-- 
2.35.3


