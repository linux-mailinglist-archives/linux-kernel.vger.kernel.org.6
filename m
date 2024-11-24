Return-Path: <linux-kernel+bounces-419417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDFC9D6DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 11:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA7B1618D2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BB18DF93;
	Sun, 24 Nov 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BTK7v4OY"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C946018A93F
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732445488; cv=none; b=PofoTW6Al94jBbtduVlhBKSghJHHgG/WM5BQ+Ui60PIONdxzzyuUCUMdVTJbcb6gFJMUlZ0PPRya+M9ZHmMZJ+Y/XJ9LZCAtG1+gmsdTT7ZriAjlvBgYc0YeFzJSsFTztmGlIIVsrGz+VxSIvpOi9mdoCt1hdk/+gIkvsKwV79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732445488; c=relaxed/simple;
	bh=OizOgkqM/ciCQRFNflnDesht9tvKXDx3pzXOy1c8Mz8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8D1mYc5qfuAzZ5/YH9FziHk2V/mP9HbZar0fLHk3QwS9krMhmy/2J8//NAvchlvYgshnROP8zMimb2g8UlUMdyALpB1MV16PFC5Kdd/V9EmDmPsqAQc0Y0Y4FdPAU/Z8L0LVKP0+qfcVkSyos0TF0sRpyZwW402m9rxkCELMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BTK7v4OY; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so577257766b.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 02:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732445484; x=1733050284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0h/dJNmLaJkRXln6GWtNUJKLiMzuYHl099QEc2GHa+E=;
        b=BTK7v4OYc1ZDHNBUBMgA5tZNXmkp4hkD8r3vZHYBkGsirZ6G+GktYXazaOZ4wCptGu
         1Hn5KqdYuHh+jODsjKse2X3TTKqmd25hgd9NhwrHaRVOhu1un1b3Jw9adAInap9h0KxT
         NSW1kv1fwvLaposqfkFJbOPwjmDfdWfb7uDD2ts+lBH7ADKaEVlswXC4lWtPzPhYvKEz
         X1mpxdS/JieEOpjgEgRsntiGGc5qQt3nN494s8TUEJ4J1GjgS+2SVL3vp7NTvjt2nxTg
         aAgDT422YhxPvqXxULudPS5Vv8R7XYu6Gn5j9nSKrIhu0bXYxOdOiNcTU8LVsIBGlvEA
         ukkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732445484; x=1733050284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h/dJNmLaJkRXln6GWtNUJKLiMzuYHl099QEc2GHa+E=;
        b=eUBoaWTSPo3nT2aFlcz17+PkdxuFRwXudPnFg2E7aTjTDqCceeryjOgARClKRoZ7ag
         MqEWtBOrSNk30RAOQXBuX+9Yc/sQAQwXk6Sy2IbYn23RCHUvaRyh8iNOC8r/llnSNj5y
         c0x2KmSKRZw+2Vdr/DXxaf36nXtaxqaBGStEz6rTQaaz/S57ReqLl44sDxhjH3MeNlWi
         IIHleaj/0sMmaEjw487NX7ouLsBD2skeKTwbGY/GOb6jMFByJ5vvQv7lqDx7NcwNy95N
         G7YYi/oVeOoivJ6OPK+zvTx2+JdH4+OVyzsN+Tbn5Yj/bE2wMJ07MWy/p/OYcTMWbhzL
         9mmA==
X-Forwarded-Encrypted: i=1; AJvYcCUsbtAjs8EQf8h+3O8xmvR9Y+qqpD6WcrCA965ZYeeIqhZHw8Ju21aYhz9d0MPLvdx/UiUpd+LcQbkvYEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6a39LYc9YafgU3zwyOogYdbSspM8+gLYNugZ9NcSAhjSxNHQ
	hbtDMk0W/E6S8cukjYKGIw1dbK2Bn8/sUSTf1s/EpHDEzaI1b6Djq2CNg7Br4hw=
X-Gm-Gg: ASbGncujYDidE74ou/p//h+6xa/6fEpTITZTUcMOhn3iXWAeQJtwM6/lYHPqOT3e36k
	kZRg6giugRriNCXgeD9yCUV7N/wu+HzQOhKrI7khPZ9tdm46irpDVpQKbcQ88vkuZeTA20xIZJV
	JeIUHh9B8ZzQzsPRAJ71pyV5Z/bruXDLS7zqIL+falxgZj/djgpvEsQAh6TQmxtppxcOshv/9jv
	Y8slZrBciPAE7hlRFyuqXGC38wGDRs7xueVV/aYxOhUaLSvWTJdUwlCeqqjnDh/Z1khWohm00Va
	WTGfqTjr157reAdUFk4Z
X-Google-Smtp-Source: AGHT+IFCpVvo0hkBe9gao8DgUns3PDPSWgbR0TGeCkcxYWD2ZwTIRxp0fywsn/nQF4Dz7vC2x1KBAA==
X-Received: by 2002:a17:907:7848:b0:aa5:35a6:8da8 with SMTP id a640c23a62f3a-aa535a693ebmr408145566b.12.1732445484047;
        Sun, 24 Nov 2024 02:51:24 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54423e8e9sm85491966b.77.2024.11.24.02.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 02:51:23 -0800 (PST)
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
Subject: [PATCH v4 04/10] dt-bindings: misc: Add device specific bindings for RaspberryPi RP1
Date: Sun, 24 Nov 2024 11:51:41 +0100
Message-ID: <ebb21da5cb41391421b364815705be8b4c415f8a.1732444746.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1732444746.git.andrea.porta@suse.com>
References: <cover.1732444746.git.andrea.porta@suse.com>
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
 .../devicetree/bindings/misc/pci1de4,1.yaml   | 74 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml

diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
new file mode 100644
index 000000000000..304d6b3d9e83
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
@@ -0,0 +1,74 @@
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
+  '#interrupt-cells':
+    const: 2
+    description:
+      Specifies respectively the interrupt number and flags as defined
+      in include/dt-bindings/interrupt-controller/irq.h.
+
+  interrupt-controller: true
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - pci-ep-bus@1
+
+examples:
+  - |
+    pci {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        rp1@0,0 {
+            compatible = "pci1de4,1";
+            ranges = <0x01 0x00 0x00000000  0x82010000 0x00 0x00  0x00 0x400000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            pci_ep_bus: pci-ep-bus@1 {
+                compatible = "simple-bus";
+                ranges = <0xc0 0x40000000  0x01 0x00 0x00000000  0x00 0x00400000>;
+                dma-ranges = <0x10 0x00000000  0x43000000 0x10 0x00000000  0x10 0x00000000>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+
+                rp1_clocks: clocks@c040018000 {
+                    compatible = "raspberrypi,rp1-clocks";
+                    reg = <0xc0 0x40018000 0x0 0x10038>;
+                    #clock-cells = <1>;
+                    clocks = <&clk_rp1_xosc>;
+                    clock-names =  "xosc";
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


