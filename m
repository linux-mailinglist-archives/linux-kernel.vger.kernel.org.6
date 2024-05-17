Return-Path: <linux-kernel+bounces-181744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00B8C8090
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E1E2823D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2510A12;
	Fri, 17 May 2024 05:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi8vbr24"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963291095A;
	Fri, 17 May 2024 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715922806; cv=none; b=fygVMYL3Z4dsMjRWrLXBs3i/EHABlroiDD/kv+36ZWMl0rty6f6IlGLibhj0b1KZukLvuMtCDBvUUVPT30z1bxfdd64TvCMi8PkE+wSFRQOv1EoVeZJfJ70wFVuqHZDk1yKRIGdg7zpHNzjd/mIaiftro0D0aWKzpF9U63GEFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715922806; c=relaxed/simple;
	bh=SvfYWL6ebOw6IYoDRZM65JOjv1EFu2rJ4OPCYhGja7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tSQBxkl5J/cx3P+3XUmDiksObOd4tPIYDXY/WUGqlAtW/DvFJqlYBwLnI9/e8sAKPEvi4MumAn10fod8/6FSVPfNFcd8EHIiP+caCMsH2llB+gUQ1sc570HKtf2c4thq4puVJ15xy3mBZvplr4IlBVtJ86JBwNxyRwEduR1rBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi8vbr24; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so639931a12.3;
        Thu, 16 May 2024 22:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715922803; x=1716527603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QUvOib2SKkuE7gKNCvxK7NtqB45xxaU/y8wZ/za9sw=;
        b=Bi8vbr24+dOeeUqgZ+oOGUhRtSFxd5xNQpwfSldMXoyjs4HTt7GvPjIcg8ozR65qH3
         WvvEGgwrB3TLCews2NDWmPF0N9yzQCIKPeKPUAIWdYBhqupbveNUqJxQWB9XivDuoGWP
         OWf5P4cXPIPTVl04lJ0xdqlAZGb0cEjrgonRIKk1huypBPyO5RICQUUcYHjtI5E5toks
         Gl6uinPa72lYEg+eAUk/coNiu0aJoP6hAEc97NyFWqkOrrzJ1W5rcwyVwf6ErUFPIGtF
         g1iYgB271hWCPkavujV92MM1bqlCezGLNlFWgeGI6jVc2FcOLXSdEq0Y07rD/iBvwnjA
         33Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715922803; x=1716527603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QUvOib2SKkuE7gKNCvxK7NtqB45xxaU/y8wZ/za9sw=;
        b=N4vY7V2jhs8J3XxaxbF7MKWjsppJvzhrsm/4BbZ0ajW7WIMU1zhYgH6T05zYLtNslS
         qMmDtTDuZi3gJAiI6SfT7WJI0zkPdZVqdM3WZjXtVis6otUpttRpaaVyf/UjzZliiO0v
         tVbXmTGdYzAcfL2MTlJYVNGQ4x54XHx2UTZwvFHoCtjC5b+l/bBB994SpHzJs+c9AuD/
         cnaCDQ2OstizM4DxhJ9TR9pE4bpoAOQY3ifYOzRKCiOgWY235ROSWTaqCw5dCVX8RugZ
         55Ym26IMG+lIxK0EPDbcZlwnzvEV9ctM/p8na0sYhtcHGSofp6Zsw1fwDhJNzw7G2qM8
         tdqg==
X-Forwarded-Encrypted: i=1; AJvYcCV8M+vUSBdQGsFkeL6sR1NP8YDgs5F6MCTdu3hEcecTiFMqLak/+WNj+Q2oiC2QBdeH3nHRzmILtoSQDH25XSDXP3hWwfcamdkdJEFFzE+TfU+DdZbOSMMQkctBgFXVeCYVVuvYtlA66k0=
X-Gm-Message-State: AOJu0YyeRVE7aMBdaQPWNEFAhfQmc/I6HEU0O/2lxBOKkgoWfszRLb8e
	2/dm3Qe/QmhQsQsja+WExQcezcyamgrv/nJnCdcUXJmltwNuvU5nXOIXlEMx65k=
X-Google-Smtp-Source: AGHT+IEcXw8WyYpc4pmN3aTkv76doBsVbog/IMtQd1ElGxA+9KBEm3JOLOINKsJzSDY6QqsKbf/xNw==
X-Received: by 2002:a05:6a21:1693:b0:1af:f64c:b78c with SMTP id adf61e73a8af0-1aff64cba8fmr13880687637.0.1715922803289;
        Thu, 16 May 2024 22:13:23 -0700 (PDT)
Received: from xiaxiShen-ThinkPad.dhcp4.washington.edu ([205.175.106.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf30b22sm148002705ad.180.2024.05.16.22.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 22:13:22 -0700 (PDT)
From: Xiaxi Shen <shenxiaxi26@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: shenxiaxi26@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v4] ASoC: dt-bindings: ak4104: convert to dt schema
Date: Thu, 16 May 2024 22:13:17 -0700
Message-Id: <20240517051317.466764-1-shenxiaxi26@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ak4104 binding to DT schema

Signed-off-by: Xiaxi Shen <shenxiaxi26@gmail.com>
---
Changes since v2:
 - Remove subsystem maintainers
 - Wrap lines at <80
 - Use unevaluatedProperties instead
 - Fix indentations in the example
 - Move changelog in commit to right section
---
 .../devicetree/bindings/sound/ak4104.txt      | 25 ----------
 .../bindings/sound/asahi-kasei,ak4104.yaml    | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ak4104.txt
 create mode 100644 Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4104.txt b/Documentation/devicetree/bindings/sound/ak4104.txt
deleted file mode 100644
index ae5f7f057dc3..000000000000
--- a/Documentation/devicetree/bindings/sound/ak4104.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-AK4104 S/PDIF transmitter
-
-This device supports SPI mode only.
-
-Required properties:
-
-  - compatible : "asahi-kasei,ak4104"
-
-  - reg : The chip select number on the SPI bus
-
-  - vdd-supply : A regulator node, providing 2.7V - 3.6V
-
-Optional properties:
-
-  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
-		  deasserted before communication to the device starts.
-
-Example:
-
-spdif: ak4104@0 {
-	compatible = "asahi-kasei,ak4104";
-	reg = <0>;
-	spi-max-frequency = <5000000>;
-	vdd-supply = <&vdd_3v3_reg>;
-};
diff --git a/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml
new file mode 100644
index 000000000000..86f6061d3c50
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/asahi-kasei,ak4104.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/asahi-kasei,ak4104.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4104 S/PDIF transmitter
+
+allOf:
+  - $ref: dai-common.yaml#
+
+maintainers:
+  - Daniel Mack <github@zonque.org>
+  - Xiaxi Shen <shenxiaxi26@gmail.com>
+
+properties:
+  compatible:
+    const: asahi-kasei,ak4104
+
+  reg:
+    description: Chip select number on the SPI bus 
+    maxItems: 1
+
+  vdd-supply:
+    description: A regulator node providing between 2.7V and 3.6V.
+
+  reset-gpios:
+    maxItems: 1
+    description: Optional GPIO spec for the reset pin, deasserted 
+                  before communication starts.
+    
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@0 {
+            compatible = "asahi-kasei,ak4104";
+            reg = <0>;
+            vdd-supply = <&vdd_3v3_reg>;
+        };
+    };
-- 
2.34.1


