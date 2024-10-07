Return-Path: <linux-kernel+bounces-353309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CAF992BFF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BEC51F231E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058971D2F70;
	Mon,  7 Oct 2024 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TDhxZrji"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916321D2226
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304793; cv=none; b=L1TYufif4U/56haJQL7ePGAL3BZTfMGKNeVJCh2G0WL04MOaacwomi1a7cTtWNpMA8VdV79wJjualeb6KUVfqA7RAwIxMPGuHmzSmbn4zQk73aBuEpHLqWaGYVWfuHGzN9l7Llgn8dhU7xxkpbtbFke2zEVOh8SHX/bRqj719+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304793; c=relaxed/simple;
	bh=Vng6Rnm8WZ0QEcMErGHsHitJT99zYtF15IooAdGsAnE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+oTv/KNMnq9NIut26pcOBBEuRYbFxYdCFm4zBwkriDYld1Ht8dSh+NL8m49jNjL33+Xj9dTaVtli4H8jTW2QoQ+bcYysCjRhCGR5+QieRWwHZdgjtL2zA7iWxeUXapzkByfwtrrZi1qEVfriuBMRegL66nPvzUI6y9VcHQ0Kfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TDhxZrji; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c88c9e45c2so9401750a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 05:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728304789; x=1728909589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuhcTT207BoYyeeg1rSml1YhvWxOKliW74hU35I85Z4=;
        b=TDhxZrji15G+EdBBfGzo2BYYL7rRz9aTIdYe5bC37tEFJ/RdBJ/oRvuy+/AjPX6cj4
         SlCtGZG3GnuY5QD6iLtYpNXrKqVd/APYsclClVtagHLyhRnI576uuLbDTwVqsGipjzLU
         iBFopuDRYi94rmow8weIyh97LMTXdbpmEbPWDLVfryRAUxCu7TGWan0ILUaOsCvHXCxo
         YQQvHuKE0+fYPqbjnT8jOgB0GCPRaWERxnypbQUMnlJCJqaxwRlagN40zzA2uODCRBpO
         HCSPnzc2aLJQqP4zyqdr718G3pmEOLpNpSg3qcEiCQbmnS6XBTKR+aoUtQE9812CCOph
         yf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304789; x=1728909589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuhcTT207BoYyeeg1rSml1YhvWxOKliW74hU35I85Z4=;
        b=WI8OVjOjxUVHUSxvEcZyyIKdVf3kKJadFYAzFlzt8mU2XKqYUgiweKomKG269sN3bL
         kXPtqiMfYm8OTY4XLuc3pkiDvOWDFO0/i3AngS3we4Gy1Ob53q4Wllc2npJyu/fqxGPi
         tIINfce/pHCU6VP2OisfzrkRS6AO1uXYC19bdV8eYmImh9NGbFTKVF0A1Y2V+A1Utcnv
         rdTAhrZTSrLVXOZ5XZPj47O0tPpszxLF2WI6K7yF/OARXBZZoCP0WrlOoaf1VmtQct4e
         JR/1ts1PMXG1czGE4wan0Kq8+N89vZir9Y3UHJ1de6w8z/SnETjrPUH5tkzwIgMbFD1W
         NtPg==
X-Forwarded-Encrypted: i=1; AJvYcCURsCkxxcaua4ySOs5gvUARUtv3uqs7jkS/F0QWOPLho8F1zT4uxUfyXjmylSfYIgWMKE2EYbOdLkuZRrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBlJ4YEUJxcmDIDct4SaSfaYHab1B+rk2q8iqXP+VOjU/TLK3
	y0i+vHEOR8k/sG/rczY95txn83zqoyi57vaP08PMSQHz2ui12OxSecfkMDIifLk=
X-Google-Smtp-Source: AGHT+IH4uJtWnmjaVwPOlrjtEv7DLcKyM5zoEla9wX4MrKe8D3yYuCSnyyFIX1r9/Ssik+roi9jduA==
X-Received: by 2002:a05:6402:43c4:b0:5c4:1c89:6e36 with SMTP id 4fb4d7f45d1cf-5c8c0a8ae6amr16557075a12.19.1728304788892;
        Mon, 07 Oct 2024 05:39:48 -0700 (PDT)
Received: from localhost (host-87-21-212-62.retail.telecomitalia.it. [87.21.212.62])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05bd4e7sm3146971a12.47.2024.10.07.05.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:39:48 -0700 (PDT)
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
Subject: [PATCH v2 03/14] dt-bindings: pci: Add common schema for devices accessible through PCI BARs
Date: Mon,  7 Oct 2024 14:39:46 +0200
Message-ID: <e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com>
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

Common YAML schema for devices that exports internal peripherals through
PCI BARs. The BARs are exposed as simple-buses through which the
peripherals can be accessed.

This is not intended to be used as a standalone binding, but should be
included by device specific bindings.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../devicetree/bindings/pci/pci-ep-bus.yaml   | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
new file mode 100644
index 000000000000..9d7a784b866a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/pci-ep-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for PCI MFD endpoints with peripherals addressable from BARs.
+
+maintainers:
+  - Andrea della Porta  <andrea.porta@suse.com>
+
+description:
+  Define a generic node representing a PCI endpoint which contains several sub-
+  peripherals. The peripherals can be accessed through one or more BARs.
+  This common schema is intended to be referenced from device tree bindings, and
+  does not represent a device tree binding by itself.
+
+properties:
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  ranges:
+    minItems: 1
+    maxItems: 6
+    items:
+      maxItems: 8
+      additionalItems: true
+      items:
+        - maximum: 5  # The BAR number
+        - const: 0
+        - const: 0
+
+patternProperties:
+  "^pci-ep-bus@[0-5]$":
+    $ref: '#/$defs/pci-ep-bus'
+    description:
+      One node for each BAR used by peripherals contained in the PCI endpoint.
+      Each node represent a bus on which peripherals are connected.
+      This allows for some segmentation, e.g. one peripheral is accessible
+      through BAR0 and another through BAR1, and you don't want the two
+      peripherals to be able to act on the other BAR. Alternatively, when
+      different peripherals need to share BARs, you can define only one node
+      and use 'ranges' property to map all the used BARs.
+
+required:
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+$defs:
+  pci-ep-bus:
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: simple-bus
+      dma-ranges: true
+      ranges: true
+      "#address-cells": true
+      "#size-cells": true
+    required:
+      - compatible
+      - ranges
+      - '#address-cells'
+      - '#size-cells'
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c55d12550246..ccf123b805c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	include/dt-bindings/clock/rp1.h
 F:	include/dt-bindings/misc/rp1.h
-- 
2.35.3


