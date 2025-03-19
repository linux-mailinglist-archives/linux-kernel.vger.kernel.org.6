Return-Path: <linux-kernel+bounces-568860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F16CA69B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 22:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A3719C1028
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D51621C9E4;
	Wed, 19 Mar 2025 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q69Ffxw8"
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB221A452
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421092; cv=none; b=ovSWQZAjG/7DHn9Yw1FgbG7mNQ9M1MjqPvCXAJVPUv5UKmt1cR3e3DS5r6qkKcyvBV7Q5ge+p/vF5T7Omesexa01U+dHl5zCxWX+lfYqydYHiBf2kCk3n3OzTdUFqK1xk0Oe+8P8K0hQv6fpXtgqfXxXwWj0iptPffra8E95HFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421092; c=relaxed/simple;
	bh=oo7i3AvF5caqx2Q44Kchnwcy9Z40hQ+mBhncGJ3iEX4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2iAk3EvuAwhg5zL9Q7C6iMLXlVVTVV3PA4EJxfaFw/E5U8aErJFejco2FaHGi7xo/oulec9JWqCY7qMRdP0X3jiHI+CY9sV1/jzBLzk2qC5JdEz0zZ9iRxGfmd8WupQWpr0KcGXEbUujMXrmm2Kz721cBpl+rG3DZEVUaPsKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q69Ffxw8; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so235429a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421087; x=1743025887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4+2NUQXL7dLOg2OQ30WAPn8JqJfl7rhQlqfAESD2hk=;
        b=Q69Ffxw8I3+mb34bjXcAgM3R8NY6q6J5RbGIq5Uq53GqW9vQ+9M9Mp37dQ3ivF2sKX
         URt6UhZKD7SLnFS1jMgiaWi23S0EUo6ZaK7XmtY9MDKjOLzk+5hAaZ5Z6KQWyw8eTYqb
         TtSjLlT9GBfeAxnKs6ALCtZPCaAQvlvSiiFGSYpTo/BCAONrf+BuNM5xVPNBpnycFUv8
         RP7FPnagktLoDrhV2D7bW/lOk5r5AGPMimE0L3+4LDF+bp7KT8viRcsPu+NbIhwY11LQ
         pDihgKyl/ufOasRoDuj4pHTvbLSWGY+57D18tSwsyHqnOZYZK7p1rAq7n2hzHTPLlgFP
         ws3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421087; x=1743025887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4+2NUQXL7dLOg2OQ30WAPn8JqJfl7rhQlqfAESD2hk=;
        b=G4ZBQiaA8jxlFbfRWi461zouQLYP/l2z4mjdx4BOIoRxuz8N/3Z4zl++jqJfQdOHee
         DlZ4D+K6JLEO6qv5gIzuYJUzPaqeNWio/CG4sbm0FU56sGsLoby+QKbJSYhro/E3U56F
         Ig3DHYCv7YVccxDPsCV9KZfwkKfOkTsMslI2VdsaWn78+zQCAGVKWxUFfrU1+bztFxYp
         mpQ8lqVMyO/hXcL8cq6NrAMmpgo5+qxhEmy1W7hnT04GQAqgTe/J2mXuMY19YaJ9we9S
         CBw50tHyaQdHTuix3jLLzOpTAIqZIvX04zfi1bIqiA7BLpPlmYedotHfyr7Fo2COHDBO
         K4BA==
X-Forwarded-Encrypted: i=1; AJvYcCW2Vn/2dZZEJNmUXUgh4XF/VrWPlpNEyqOHzujaW0F/t31yNbK3eqjQ1r87HRVGJToBtqSTZKDQIckvKBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf62GJgdgbjFi1rWQRotiZyY40kuIcz9IYcDrOjl3qvAE6RUAu
	MJc82cZD/kcr5HZ5sk4VFvNeJfvYoHoM8PFmkuD+Moj0J2xPnzEpHHMmhgvfkc4=
X-Gm-Gg: ASbGncsrtUVlvtjZ1rXbdzn4ca11f9U0dyjPApMLooErKuzHZbVCELDk2Jsq203MGFn
	8hiokMsyOfEHWoCGTUDgqdsjx2bRiaw6BCR+RNih9jVvKdTauWu+47Mvaf6ioW+ayxysQrZLtA0
	kHpcF3dS5yZDK1RsqQaazMwC5tH5UCxaaU2iJc89jX0sfw67WZ18lDc/4y0QTo/sE6h6UHzhj4z
	YW9yAohClumExpqU7RV0X/t9XLzdTSRS1jRzDNMthbwiVfHpLwagOoo4l5TzE+/Rp3p92VKp3pe
	jkhCaZNxMT2lwSeQljYdu65wwA04B1Rcwi6j0018VECO/fa4rjLICX6P8+dwvYN2Cf8ma3z+qBu
	64W+e7VxpWQ==
X-Google-Smtp-Source: AGHT+IECByxBqyw0La28yzoSSkVXFaROTbSXGqLjaas9yMmdWpYo/OIW+kPPZ5laN9UoChAX7VneJQ==
X-Received: by 2002:a05:6402:524a:b0:5dc:6e27:e6e8 with SMTP id 4fb4d7f45d1cf-5eb80f8a1e0mr3956840a12.24.1742421087214;
        Wed, 19 Mar 2025 14:51:27 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e691sm9444602a12.5.2025.03.19.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:26 -0700 (PDT)
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
Subject: [PATCH v8 03/13] dt-bindings: pci: Add common schema for devices accessible through PCI BARs
Date: Wed, 19 Mar 2025 22:52:24 +0100
Message-ID: <096ab7addb39e498e28ac2526c07157cc9327c42.1742418429.git.andrea.porta@suse.com>
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

Common YAML schema for devices that exports internal peripherals through
PCI BARs. The BARs are exposed as simple-buses through which the
peripherals can be accessed.

This is not intended to be used as a standalone binding, but should be
included by device specific bindings.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../devicetree/bindings/pci/pci-ep-bus.yaml   | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml

diff --git a/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
new file mode 100644
index 000000000000..78129712da87
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/pci-ep-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common Properties for PCI MFD EP with Peripherals Addressable from BARs
+
+maintainers:
+  - A. della Porta  <andrea.porta@suse.com>
+
+description:
+  Define a generic node representing a PCI endpoint which contains several sub-
+  peripherals. The peripherals can be accessed through one or more BARs.
+  This common schema is intended to be referenced from device tree bindings, and
+  does not represent a device tree binding by itself.
+
+properties:
+  '#address-cells':
+    const: 3
+
+  '#size-cells':
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
+  '^pci-ep-bus@[0-5]$':
+    type: object
+    description:
+      One node for each BAR used by peripherals contained in the PCI endpoint.
+      Each node represent a bus on which peripherals are connected.
+      This allows for some segmentation, e.g. one peripheral is accessible
+      through BAR0 and another through BAR1, and you don't want the two
+      peripherals to be able to act on the other BAR. Alternatively, when
+      different peripherals need to share BARs, you can define only one node
+      and use 'ranges' property to map all the used BARs.
+
+    additionalProperties: true
+
+    properties:
+      compatible:
+        const: simple-bus
+
+    required:
+      - compatible
+
+additionalProperties: true
+...
-- 
2.35.3


