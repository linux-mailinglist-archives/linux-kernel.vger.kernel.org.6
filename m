Return-Path: <linux-kernel+bounces-338373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832F4985707
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434FA281F33
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3EF189904;
	Wed, 25 Sep 2024 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMdvomyo"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29710165EF2;
	Wed, 25 Sep 2024 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259314; cv=none; b=GeSCgRtvqkAKtfkArqI9vternsiROPFrFUZr2wxvQC4ywZOx3dSdYx98HO7avGSSBH8hmFDwmulqaku7Tp0ltlHKW3MvRjgHtEVCNkeuWwNBSb+NGElr7qZy1eZcfziP564NXkdutdQnQ27WQ/XI0LAwaAFSb+JgufIs5QWNW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259314; c=relaxed/simple;
	bh=QucO8gEJfWJotXRfJzgyT4H1qW+PxQlhdlDNc0h4/gk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwjMGx1WME1W6ckX9U4dmNi7T6HsR/SD8G9qH/eX/I7Shc2dCr2380/ZAwrm7sOysGN2UOMrIcyiHlhxY5VoI+/uekmZaX4ieFZTZ80wzNFDXYFC+RL0bnzqtUyDBN26k0bZRD0suDwARcrPEXBMUu+w8nyxBqvo5Vegzq44tII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMdvomyo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so61130925e9.3;
        Wed, 25 Sep 2024 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259311; x=1727864111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0yqjz/vLAoslnLJDGa7eN7K2Pvc9Kf7CmkO2W3efDk=;
        b=NMdvomyoyLvTQqgZ1rn+RcL1LUYQA1aEFWikH2dfXZ9toMfsYEQToZgPf6paCnNV5F
         WxI2LsOQmxMXhX2zX84nkKAwTMxZ2XFXh23EwoX2O9fQZcXbEmdgJmrMNOtfff66yR06
         K+TQSGg4mstZBa5qU7Ga1hGN7bOVouBc/88a3FSjVkfgGl8SoYhe1ze8qHMrL7ScOVwR
         woTc5yq9DdW3Hi1XugksGweLkBH9ovYJaPtUlyekJbN1Px9PknH8Jo6wSVIciM9md6Td
         ibNv4+w9MMUfBowKfb7gz2cZsESjsV3H5kIwWtBH3eTpfgtLsUnmPyW/UwrycCmvnxYo
         0aaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259311; x=1727864111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0yqjz/vLAoslnLJDGa7eN7K2Pvc9Kf7CmkO2W3efDk=;
        b=HiWp8ziW3psPFZWWhGM4VEEme23wyc1AR3xpXO2MFUJfRhIfI3J9h6QyRTegbHz6O4
         jKPV2BxD1n+5c/xQBQbUkaslpO6TTHf3T9UVAzbU2cjFHI9KazCtpbOw70e0l3Be0D1/
         7fVW/Ks5gNHBxTp4wykLEyYFc1qy7XM1JyteDVr8umI4ZhfSsKec57LGNnQxHHJbucWm
         ozpS+mKKmQRDCSz7Zt6AXd+TzQcewOoFHu1JGJML813wdj6II5SqswX4ZnDpxlO2MwMs
         kZBr4y/91/QBN5+XEKZcWQqCyuBq+Ka4W+mLCxEJ/5vgqVY2MPaYMSWD85KK1c8z9x6q
         YZxg==
X-Forwarded-Encrypted: i=1; AJvYcCX85FPPGQj8VLTossQdzQwXoKga7Mvm5gUz/VNlI9u1+nlVoc+meDWderfzNM3mY3NjanWJwe+RgxMb@vger.kernel.org, AJvYcCXUgyJQzG+JqkyDsuuFt6x6wRRvUpS21/leEI3fPcjsR4vT3sEJyQz40va4lt3QL3pY8HIUjo7Oso5KtXnI@vger.kernel.org
X-Gm-Message-State: AOJu0YxAtrDEOJs/wK9aZ8wao8dohcl1Cs7ZggOyCYyd82bdpbgI7Tho
	ewv1azQ3bQjHa93qdSH0U53Tw4FQCjOnNoEhrHevl3hZc3BL8lmQ
X-Google-Smtp-Source: AGHT+IGGrksQqujrE8tWrONIU2RpDc8dp9sRezir+8ahhKdtMo+RszPM/Z6hhXo38BC01/GaWh/h6Q==
X-Received: by 2002:a05:600c:4689:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-42e9610d52fmr15491985e9.12.1727259311130;
        Wed, 25 Sep 2024 03:15:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cbc1560a7sm3628194f8f.0.2024.09.25.03.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:15:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH 2/3] dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
Date: Wed, 25 Sep 2024 12:13:58 +0200
Message-ID: <20240925101422.8373-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925101422.8373-1-ansuelsmth@gmail.com>
References: <20240925101422.8373-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Documentation for Airoha fixed-partitions compatibles.

Airoha based SoC declare a dedicated partition at the end of the flash to
store calibration and device specific data, in addition to fixed
partitions.

The offset of this special partition is not well defined as a custom bad
block management driver is used that reserve space at the end of the flash.

This binding allows defining all fixed partitions and marking the last one
to detect the correct offset.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 2 files changed, 81 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
new file mode 100644
index 000000000000..a45df51065af
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/airoha,fixed-partitions.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha SoC partitioning
+
+description: |
+  Airoha based SoC declare a dedicated partition at the end of the flash to
+  store calibration and device specific data, in addition to fixed partitions.
+
+  The offset of this special partition is not well defined as a custom bad block
+  management driver is used that reserve space at the end of the flash.
+
+  This binding allows defining all fixed partitions and marking the last one to
+  detect the correct offset from the new end of the flash.
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+select: false
+
+properties:
+  compatible:
+    const: airoha,fixed-partitions
+
+  "#address-cells":
+    enum: [ 1, 2 ]
+
+  "#size-cells":
+    enum: [ 1, 2 ]
+
+patternProperties:
+  "^partition@[0-9a-f]+$":
+    $ref: partition.yaml#
+    properties:
+      compatible:
+        const: airoha,dynamic-art
+    unevaluatedProperties: false
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "airoha,fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@0 {
+          label = "bootloader";
+          reg = <0x00000000 0x00080000>;
+        };
+
+        partition@80000 {
+          label = "tclinux";
+          reg = <0x00080000 0x02800000>;
+        };
+
+        partition@2880000 {
+          label = "tclinux_slave";
+          reg = <0x02880000 0x02800000>;
+        };
+
+        partition@5080000 {
+          label = "rootfs_data";
+          reg = <0x5080000 0x00800000>;
+        };
+
+        partition@ffffffff {
+          compatible = "airoha,dynamic-art";
+          label = "art";
+          reg = <0xffffffff 0x00300000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
index 1dda2c80747b..ec254e03adf0 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
@@ -14,6 +14,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 oneOf:
+  - $ref: airoha,fixed-partitions.yaml
   - $ref: arm,arm-firmware-suite.yaml
   - $ref: brcm,bcm4908-partitions.yaml
   - $ref: brcm,bcm947xx-cfe-partitions.yaml
-- 
2.45.2


