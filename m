Return-Path: <linux-kernel+bounces-553138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF41A58465
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE73F16B12A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482641DE89D;
	Sun,  9 Mar 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzEPQPOQ"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ECE1DF731;
	Sun,  9 Mar 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527049; cv=none; b=PM1ld+39/CafJVbAA/inTWttST+KNs6yWrUr3f1zVIDpNgNEoBYBzmDRtvR+oi7FmQIu08ZNI/u6AMgmpBZffw39SPJrTbK8AlUhp4adE6egkFrx3t/tQoRDHqXM+rrg9/C6ycb4i4Habln8sIAWyE72Is3bU1ly4l/WsMh25Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527049; c=relaxed/simple;
	bh=E5XDfhhhPBiYqBlcttdcgnUez7WPqQY743rf4tAODF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/FCQ4XxjaWJIUo5+iw3lX2n2X7H6Zm3Ez/yJncOEkE4LQHIr6/yWT9M60jjIJ8HBO6HNQmbjlU3QjTTnnZzIsOrg3kYeYvlNzF25ny1j1SpgzLpVUxT82lIiUd6eFzDUoO8pvYk6Z0etLyOIp9ESUv4+kaTb6CMejomLbGMgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzEPQPOQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39127512371so1840233f8f.0;
        Sun, 09 Mar 2025 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527046; x=1742131846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzS4hzE7zDkztDQBx5YAH+xKOh9ZedPuSQIim2JNdCQ=;
        b=DzEPQPOQ1bzhSg62EQBBFUa7vuepP4BbXz8gMIp+XPEStGwD4tnx6eA12kRupdzmXj
         VfCFMqwe2L2GqQU3Jd3fU0ryLfM858yiTf4EuXJqEuacun34i1A263f8JM/DUCLARKC9
         2fXjSCUcIYflAkyggpEw7uqhmvVcJufJeLGdymGxtinlamKpTgpeFIR570eRnGG0Ol/U
         UEruTaHTpHoxUaiRrwjhrFNK2MFESsRwjOl+g8qLdT2Zo37ELn43fNX1fruFPhpNLqxO
         WTWEpH5Iw5sytmZ/MnzGmv3pB2TJrQXuQi9ChpaIP8YuevLhAdsiWoUPAQD5VljTeVnx
         PgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527046; x=1742131846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzS4hzE7zDkztDQBx5YAH+xKOh9ZedPuSQIim2JNdCQ=;
        b=iygvCAaNjGZbhGYZe51VPwu8UKPnFauyqb6me1WZqbk+L8bpcFQYY33TJ67f9leQfB
         xPVkAFEGyZloMo6KFd77/CLERu+Dg+pYSPzHfaVXQjnTtV+InraAR12ADjuvUeN+GePX
         1q97ZlfNTWEv6fhzn54pDbfTus9W3AaCpRavE+uPvcAbfR2fmAIz/L76h5ds8Q3Iamb1
         0V8rAvgTd5WXEJLe5rHBW+J3gXXDjge2zbUfTCCctPtpzdtTinkegakoE13DbtCToupp
         u3NlyZN/tJe7nr11V4qNVpehclgAxoSC6uz9yT/2nirg1l3bT5oC87FwLcZrWRCHB0dX
         9b7A==
X-Forwarded-Encrypted: i=1; AJvYcCUjZcajtAu655obRoVCvp5bUCS9qHM/Wk1UqA3Y8CLPqv7QXS4ECbjJVFwp3i8lZ5xDEtfhIWE4eS9v@vger.kernel.org, AJvYcCUs3ISyEN15f3szbaHyVtFhA+UJduS+UhlgkPhpe7hwolrJ/9sbTnv8RY7R64SOyoiYKgg1nMWyHfJT@vger.kernel.org, AJvYcCWa16atnsp9B5Xwt54hr1tDlAokk88Odg+R/pldGcOQdU2726xjFMm9oVb2dXpoCaUHdmY6Fwlgd3Ns@vger.kernel.org, AJvYcCWu+qwhgSK9k9VQd3cTzmC+2iYvKRkzHg4poai8z21UHXN45JaOkMyzavKszS36rP5+gLssqbhpxPXSFdNq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Se0d3RbNFrrbV69mtOsOCuyTW/KPQPIVzcgEX8AAi56fyjq4
	7NY1SP/zXlvaktCyom3N4BQaQR207FPsy3BuppCJAAVUSFik+llo
X-Gm-Gg: ASbGncs1wdPLv/5TBFm3o2gTWs9Y8XPVoNjRYJxToJasykyBRHvSmvTGPWjrkqyfdTO
	1k5OBE6PIjre5OL4F/KWEZOVKQrilf552sPIjAxZQqzRwf66vyH05mJe/zI/jjsebo2LYk1jXRQ
	hKXUb0Wl8mYRhB3K+ZMHcnZV2N8IRAzPA0jrqyHoXarLanfqbXyeHWJhGjQwdmTY6I8bWKVW4pV
	QZIieprtzjiy9eyEbjOzZ1oFHA+dohmdHSVy9lUGvrisYRZctUWbB5pGC2NA4yBlkamAXzJ+jsF
	+nNOtfjJvI3bu2eJLCS3akIZ8g6MJLV3iREpZpFR8xL3YO/WkmJlqeyPwjYp/KmiDVUOR4Ps+Jl
	gTvtxZsN8hMzFkA==
X-Google-Smtp-Source: AGHT+IE6bIHxYXeJLeLHPL+p4IEp/6DdN3f/i6NZYTP+hM3wxLjboSsLeWZHA3qzqc5r29m1QI1i5A==
X-Received: by 2002:a05:6000:1786:b0:391:48d4:bcf2 with SMTP id ffacd0b85a97d-39148d4bd41mr353208f8f.12.1741527046061;
        Sun, 09 Mar 2025 06:30:46 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 05/13] dt-bindings: mfd: add Documentation for Airoha EN7581 SCU
Date: Sun,  9 Mar 2025 14:29:36 +0100
Message-ID: <20250309132959.19045-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation for Airoha EN7581 SCU.

Airoha EN7581 SoC expose registers to control miscellaneous pheriperals
via the SCU (System Controller Unit).

Example of these pheriperals are reset-controller, clock-controller,
PCIe line speed controller and bits to configure different Serdes ports
for USB or Ethernet usage.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../mfd/airoha,en7581-scu-sysctl.yaml         | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml

diff --git a/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
new file mode 100644
index 000000000000..d7dc66f912c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/airoha,en7581-scu-sysctl.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/airoha,en7581-scu-sysctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN7581 SCU (System Controller Unit)
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha EN7581 SoC expose registers to control miscellaneous
+  pheriperals via the SCU (System Controller Unit).
+
+  Example of these pheriperals are reset-controller, clock-controller,
+  PCIe line speed controller and bits to configure different Serdes ports
+  for USB or Ethernet usage.
+
+properties:
+  compatible:
+    items:
+      - const: airoha,en7581-scu-sysctl
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  clock-controller:
+    type: object
+    $ref: /schemas/clock/airoha,en7523-scu.yaml
+    description:
+      Child node definition for EN7581 Clock controller
+
+  system-controller:
+    type: object
+    $ref: /schemas/soc/airoha/airoha,an7581-scu-ssr.yaml
+    description:
+      Child node definition for EN7581 System Status Register
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/airoha,scu-ssr.h>
+
+    system-controller@1fb00000 {
+        compatible = "airoha,en7581-scu-sysctl", "syscon", "simple-mfd";
+        reg = <0x1fb00000 0x970>;
+
+        clock-controller {
+            compatible = "airoha,en7581-scu";
+
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+        };
+
+        system-controller {
+            compatible = "airoha,an7581-scu-ssr";
+
+            airoha,serdes-usb2 = <AIROHA_SCU_SSR_USB2_PCIE2>;
+        };
+    };
-- 
2.48.1


