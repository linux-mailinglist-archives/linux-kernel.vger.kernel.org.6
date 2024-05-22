Return-Path: <linux-kernel+bounces-185882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931A58CBC69
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63A21C20D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B15A7FBA0;
	Wed, 22 May 2024 07:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCvavQVI"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAA7F7FF;
	Wed, 22 May 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364379; cv=none; b=dOMcFTgT+nDpjTaUY4h+Hpt4Kf7iUhVsXFig1XmA5c59PL1JR/seuJ331zhQnNgFQHNe2AKfQmw4a9ixoughXoHSSfqa2F2PDvWMBfl2NXDADh9li83KIaZ8ctxsH8H46DdrE4YWRiq72ifMvpCa+bZw0diXhWrOowpUtBLUpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364379; c=relaxed/simple;
	bh=zOtFi+77WdrckOeoDk0EekiaDHgdaiNscqDbmPY/Rlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mKgdcxGp6CDW7+mvITIHaGfywbzS5VJMF9YA6htlG5I0hT6CH3/rAUS0FZLhy1kSR5JIHPxKQW0Pm6JTpuAIRq/jZ3vwH2xe6SwwGVf8Wpc8QL40VDARTrloLyWtRQwYvplvn4nQhs4ulGhGajwUhdhOVWxi5U2915Mw4VYcSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCvavQVI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1919709a12.2;
        Wed, 22 May 2024 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716364377; x=1716969177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xR9Ht3CQdBGvtndjJsShMiO9FjAlBRZ2HivTlX4+0zY=;
        b=QCvavQVIvuf3SQyeZBW7iOw5rVScIAqqZe48JknuzYR2+9n523Po/3MnCNI+gE2yie
         mxwbTLmsfTROClWx/odjSu+K/UtoJyip/CpAJFpKxOnqBc60G6ZMEv8e7iAYYJV+Ndkp
         w0bu7fpYAnLZRNkvnVk9vaUD9jmE/wUCRM7RCrp2ZREHBswJ+EaQsl1KDJnY5SFBl2jY
         bxKkO0USFVpfo72rEEWAzmDeqw8We4fcofYgxUFacYjQPmoNJhwea66BKjWB7XcdFHqN
         exDsmK+bJHJZeGkB5pjrbJv++zxMmiXCivJmSKlzBzh9UrmOMvXvhEV0tApF6kq0V8sn
         iv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716364377; x=1716969177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xR9Ht3CQdBGvtndjJsShMiO9FjAlBRZ2HivTlX4+0zY=;
        b=HM4OR8+ev/8M4QBiNo6dHUzUcbWsE3/pmhJdZbXjblkxtp+MAtYC8TpMsUQm+SkEsg
         Ao8glOFlBq5Zk1bYmq7R55lrCepFROTe/HT0RogM6uYaOKSjrExlqbTZLVJgNXMlWtXP
         cD1F89yPXq26CZ8iZ07hRg8g5QmYj7xsNOWN7NrHryNliyjFUKJ76Z9IYsNOFcGPbo7f
         KvGGwwac7tNSjc9rdlkHGnfFu/KjS4kkPacozRA6xLXpqYJ7d+zFf4U6mmMiswjS8wGg
         yvYN2LCHI7n66TcrCi9QgTwISl/HL1T+EEfnY92yAIkM4umJYPTun/cPbkOL9Eyt4CKT
         cY8w==
X-Forwarded-Encrypted: i=1; AJvYcCWM2n4kbHA2DQo/nJgtP2+hF2DB83ht88BI+Seas5h19BS4+WjlXvZ/Js9Hw92FF/jEgf6vXkvwor3f7IHY4f6PNetePpDoCOdt3yy68gfQ1pLt1ze8MyqVTduLurUAo4oqDM9ahwlHU4E08173e4NDC7bIpBMv9CP3R858SM9j6U3Lbke2
X-Gm-Message-State: AOJu0YzpcvJIJVoUvO24VG5uVDAAMiqsBP+bEZMpMW+lR1MZN9jGX8sd
	BTB6NcFDdA7TZbi4yOlowLiWCVuvor1/UY6flRwhg9iGa9hX1pYA
X-Google-Smtp-Source: AGHT+IGt5hUedJgq2tvzHeKcHMluAEaiOFJypIgtXd2oVgcIFh2hk73oE1nEKq5wammTtgyc/bcBLA==
X-Received: by 2002:a17:90b:e90:b0:2bd:6f39:b0ea with SMTP id 98e67ed59e1d1-2bd9f5a5c03mr1260668a91.42.1716364376872;
        Wed, 22 May 2024 00:52:56 -0700 (PDT)
Received: from localhost.localdomain ([120.88.183.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67158c39dsm22931318a91.35.2024.05.22.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 00:52:55 -0700 (PDT)
From: Mighty <bavishimithil@gmail.com>
To: 
Cc: Mithil Bavishi <bavishimithil@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lopez Cruz <misael.lopez@ti.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema
Date: Wed, 22 May 2024 13:22:45 +0530
Message-Id: <20240522075245.388-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mithil Bavishi <bavishimithil@gmail.com>

Convert the OMAP4+ McPDM bindings to DT schema.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
Changelog v5:
- Add imports for constants
- Add desc to ti,hwmods

 .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ---------
 .../bindings/sound/ti,omap4-mcpdm.yaml        | 61 +++++++++++++++++++
 2 files changed, 61 insertions(+), 30 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-mcpdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
deleted file mode 100644
index ff98a0cb5..000000000
--- a/Documentation/devicetree/bindings/sound/omap-mcpdm.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-* Texas Instruments OMAP4+ McPDM
-
-Required properties:
-- compatible: "ti,omap4-mcpdm"
-- reg: Register location and size as an array:
-       <MPU access base address, size>,
-       <L3 interconnect address, size>;
-- interrupts: Interrupt number for McPDM
-- ti,hwmods: Name of the hwmod associated to the McPDM
-- clocks:  phandle for the pdmclk provider, likely <&twl6040>
-- clock-names: Must be "pdmclk"
-
-Example:
-
-mcpdm: mcpdm@40132000 {
-	compatible = "ti,omap4-mcpdm";
-	reg = <0x40132000 0x7f>, /* MPU private access */
-	      <0x49032000 0x7f>; /* L3 Interconnect */
-	interrupts = <0 112 0x4>;
-	interrupt-parent = <&gic>;
-	ti,hwmods = "mcpdm";
-};
-
-In board DTS file the pdmclk needs to be added:
-
-&mcpdm {
-	clocks = <&twl6040>;
-	clock-names = "pdmclk";
-	status = "okay";
-};
diff --git a/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
new file mode 100644
index 000000000..966406078
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,omap4-mcpdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP McPDM
+
+maintainers:
+  - Misael Lopez Cruz <misael.lopez@ti.com>
+
+description:
+  OMAP ALSA SoC DAI driver using McPDM port used by TWL6040
+
+properties:
+  compatible:
+    const: ti,omap4-mcpdm
+
+  reg:
+    items:
+      - description: MPU access base address
+      - description: L3 interconnect address
+
+  interrupts:
+    maxItems: 1
+
+  ti,hwmods:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [mcpdm]
+    description: Name of the hwmod associated to the McPDM, likely "mcpdm"
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pdmclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,hwmods
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pdm@40132000 {
+      compatible = "ti,omap4-mcpdm";
+      reg = <0x40132000 0x7f>, /* MPU private access */
+            <0x49032000 0x7f>; /* L3 Interconnect */
+      interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-parent = <&gic>;
+      ti,hwmods = "mcpdm";
+      clocks = <&twl6040>;
+      clock-names = "pdmclk";
+    };
-- 
2.34.1


