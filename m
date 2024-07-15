Return-Path: <linux-kernel+bounces-252575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3736F931560
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B92E1C219B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB518C359;
	Mon, 15 Jul 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFgjUgsS"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4018D4A4
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048955; cv=none; b=m6e1FqkLCT7MplEo1KGpoZXA5L0Wgq5zD7yKsP2bjRU5/bsHdXPfyNnKwWRafzmhwZmWyzmPRKJ9CG2avY60P8odDVq1n8/Fq+hVq+DwhJJMoN73ZKsFhxL7YJZItlfrHUQFB7ug/MORYEfRdJLeZS9icjKYv5rOtTGset0oJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048955; c=relaxed/simple;
	bh=CXurBDGmVxl0wZ5hAa2iLZNPfdkE47jNvXlNljIM+KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PImi2alCiEgPTG3UZgKM7RuAqUtDPI1NB0ss0cfmYSME29QYMSPcIGpu86gsPhpol3TFejh9DqQsMu4Ak/f8Dn/hxLAMZ340uuM+Q6urUiCuGCZIcZitd9ugXnX0iD2JhnsK/Sd7EpYmwqg+Li+db+44hW9+zqYTi0Ot9nXC5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TFgjUgsS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-36796bbf687so2385025f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721048952; x=1721653752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8eQQqT0c8dqe8WwiFT0oNTtoVSK1zY8dAW9Gm5vNcM=;
        b=TFgjUgsSdLzhEKuK+oxbr24KZeEbWKucyeoWxVAp6utdK7TSdn66E8OvGgdmzW3T69
         zKPj4nIGm+dRqRJryuxRsBV2EHk3fMMxMMrcFFFKX7ayf5z2Jm4aZszTpZmbXOSp/H8y
         8M5Yrpa4MxLwD18ADJOzGU9sEEWx80dKmLa0vjj4JufzFyn83a3rjZptHkKs96WJEUoR
         QPf+XZyfPDsn8abqnFWC5Yl0Vpxmy2U5hsdCfueqdoXjEcklNuvqHK8mlEdFJsT/X/nz
         i67rcksvK2OYa2N3hbFLi7DqxA173nwJV0me47ZTGACEwJqLg1Mg0jqdLHQLgUP99v7u
         cTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048952; x=1721653752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8eQQqT0c8dqe8WwiFT0oNTtoVSK1zY8dAW9Gm5vNcM=;
        b=nUpbhsUxiNdAL9BPS/5tC8AqWnrvAJeJcDXABKCgNxH4uTjM8x9hZjYXSHefZptmc8
         rRFGkiMaMYkW0woCDkwZu/q6hMuNi/qqnPt0/bdGqUA6uc5ywW8RH6iJwNsJHTs08h9q
         g1MiQ0XnT8jhcohx/6VIUY+zDh2xXiK7tqeyOSAwGDE4rG94HmqeGZ9NgEgo4n3kZqy0
         m6G+UaFTwPNK7OImjIb2+BU1HSaMzAttI7JHXcxVzRoa/rYaROhDMTo1NRZkY/emIVGJ
         cBvr5ful8/aeIvvoPhoENX9afEk1tuATVcZKWMPMRmsdjxYDGVEYOadvToP+jHpmzlJn
         JcPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+QlkzIJCE90WU5KrQDqnqVqi8/tR5mId4jwLWgRobR71TUPrrxCDKsIVWLg1s4+IfKBtHC0DNguvDb2hsOh0n7E2phNMjZ1qVnliM
X-Gm-Message-State: AOJu0YwUpcm1D6p87/vjIEytVyS+UnRvi1DdQ7Y8F8kj1sbJodDDPS0f
	ZNvbtFLPvKWaxtUDbgrH2TEyyP7rsyiqsuRUbCXAA8L20nwq/XtUQFfu2qOrhdE=
X-Google-Smtp-Source: AGHT+IEkQyXvA5mRa8Lirst2IcaNs/BzNCxRdC6Nwo7m5zgs93tenf8EJCOPq+kzxG047cJ1h5B9ow==
X-Received: by 2002:adf:cd8b:0:b0:35f:20eb:cae3 with SMTP id ffacd0b85a97d-367cead8ce2mr11922934f8f.67.1721048951877;
        Mon, 15 Jul 2024 06:09:11 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccdffsm6417766f8f.54.2024.07.15.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 06:09:11 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 1/2] dt-bindings: phy: qcom,sata-phy: convert to dtschema
Date: Mon, 15 Jul 2024 14:01:06 +0100
Message-ID: <20240715130854.53501-2-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240715130854.53501-1-rayyan.ansari@linaro.org>
References: <20240715130854.53501-1-rayyan.ansari@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the bindings for the SATA PHY on both apq8064 and ipq806x from
the old text format to yaml.

Signed-off-by: Rayyan Ansari <rayyan.ansari@linaro.org>
---
 .../bindings/phy/qcom,sata-phy.yaml           | 55 +++++++++++++++++++
 .../bindings/phy/qcom-apq8064-sata-phy.txt    | 24 --------
 .../bindings/phy/qcom-ipq806x-sata-phy.txt    | 23 --------
 3 files changed, 55 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sata-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-ipq806x-sata-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom,sata-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sata-phy.yaml
new file mode 100644
index 000000000000..0bf18d32c133
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,sata-phy.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,sata-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SATA PHY Controller
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description:
+  The Qualcomm SATA PHY describes on-chip SATA Physical layer controllers.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq806x-sata-phy
+      - qcom,apq8064-sata-phy
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: cfg
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#phy-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
+    sata_phy: sata-phy@1b400000 {
+        compatible = "qcom,ipq806x-sata-phy";
+        reg = <0x1b400000 0x200>;
+
+        clocks = <&gcc SATA_PHY_CFG_CLK>;
+        clock-names = "cfg";
+
+        #phy-cells = <0>;
+    };
+
diff --git a/Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt b/Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt
deleted file mode 100644
index 952f6c96bab9..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Qualcomm APQ8064 SATA PHY Controller
-------------------------------------
-
-SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
-Each SATA PHY controller should have its own node.
-
-Required properties:
-- compatible: compatible list, contains "qcom,apq8064-sata-phy".
-- reg: offset and length of the SATA PHY register set;
-- #phy-cells: must be zero
-- clocks: a list of phandles and clock-specifier pairs, one for each entry in
-  clock-names.
-- clock-names: must be "cfg" for phy config clock.
-
-Example:
-	sata_phy: sata-phy@1b400000 {
-		compatible = "qcom,apq8064-sata-phy";
-		reg = <0x1b400000 0x200>;
-
-		clocks = <&gcc SATA_PHY_CFG_CLK>;
-		clock-names = "cfg";
-
-		#phy-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/phy/qcom-ipq806x-sata-phy.txt b/Documentation/devicetree/bindings/phy/qcom-ipq806x-sata-phy.txt
deleted file mode 100644
index 76bfbd056202..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom-ipq806x-sata-phy.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Qualcomm IPQ806x SATA PHY Controller
-------------------------------------
-
-SATA PHY nodes are defined to describe on-chip SATA Physical layer controllers.
-Each SATA PHY controller should have its own node.
-
-Required properties:
-- compatible: compatible list, contains "qcom,ipq806x-sata-phy"
-- reg: offset and length of the SATA PHY register set;
-- #phy-cells: must be zero
-- clocks: must be exactly one entry
-- clock-names: must be "cfg"
-
-Example:
-	sata_phy: sata-phy@1b400000 {
-		compatible = "qcom,ipq806x-sata-phy";
-		reg = <0x1b400000 0x200>;
-
-		clocks = <&gcc SATA_PHY_CFG_CLK>;
-		clock-names = "cfg";
-
-		#phy-cells = <0>;
-	};
-- 
2.45.2


