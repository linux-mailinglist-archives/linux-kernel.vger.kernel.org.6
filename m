Return-Path: <linux-kernel+bounces-225812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 924EC913599
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 20:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90162828A5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 18:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F102A381CC;
	Sat, 22 Jun 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g52BCUjO"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C41820332;
	Sat, 22 Jun 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719080560; cv=none; b=ZcdUuGN/YRJrHxk8I7sFyMtojJcNuvG4sZ5IKau6b9r6RtRCSG27H13L2wXnoqvuKhh1nnyebDLrM4gvaoDPLBSdlvyW7LuoclyZxp5M4WIRNwCXhGopUGtzIf2JfkDofxZ2l7Lj36XMj6Z0Q27PQxcn4VNGZ6cjsNxSM1CzvFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719080560; c=relaxed/simple;
	bh=ICz9k805W8OYylRda156ORFIN7cEsgDT2/4ec7IeMLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onPhqx2Y5+vgnVdGqWYotrsYSWFZOB6G7hJojbfMRssChmtwyjEonKHA0DbCn+6POtXRLQC2dHYcOJSZpxtSjs+PyVpyNJNxZin6m6vZeb+bbHvraO1R61dqBPP7ewFKPtQQYzl4VQNVQVKxu9/ShfVFUjO8H55a6t14IYDpl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g52BCUjO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f4a5344ec7so20673635ad.1;
        Sat, 22 Jun 2024 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719080558; x=1719685358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kSS06er1VarQnO16XXiZ+cNjn4u2G2NLIQN3unM0EE=;
        b=g52BCUjOAykmbU0k5Z3CKezoAaml6zo3CaC2yJ2LkKKNeIyJ/eoNo3uaEoCja+IJMs
         em87S0RE727rsGs58bKTUvVkXSyZ23GORThjRcYymosQpxJi1Y+/1bHnNtL/XgMyitBh
         OeijQWExtFOD69StxuakwdxCFiIUBSpnZGkGHTO+DoWq44t8covqtHlr4mScm2WZaAZ7
         ydsxklv32ntaEOFJXqGAbkCscwhl+LABfN7IoHvuWWpvjtP+zRehTQ/CkQYOUw+m4yCy
         enL6/a7GD1JxQP5CmcxmHDT2AGO9L2Eo6jJJ2TWQZcLz33gLICS+WHPsiRS+WS2AMS3d
         BzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719080558; x=1719685358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kSS06er1VarQnO16XXiZ+cNjn4u2G2NLIQN3unM0EE=;
        b=PgeoTqiTLoB4BgUOKKTZ775dama17VhO5KRS9UDbJYLkXzx55eY0pM1wJL3YdULMAZ
         a2mIA6nnfpf9cKq/xa6IKWKYYJaocMgfFsvJJw+0I/grjYQ33fDEvVcfFLHK0wtUYxhx
         dG/Xwz+2B8I9nr3EJRPrZnMrnotRKyaxqM8V3BHzhy0CttGmLgiiOeLomG3QvvgQzueX
         ajGqxjcZF0tQ4cBsXmfmUw7htEAM9DYXV7nKtwvLGlMUX4Fq0eMHPRpyl6y2PXQU/XI+
         OJVXel1ICn5mUCr1W4naQ8lb80e+7qw3osK4LvBPqyBAPNFzkUzCUiEfm1nIUXQeCGz4
         ohtA==
X-Forwarded-Encrypted: i=1; AJvYcCVnFVZBT5LQ3VUCIbH7c0xqQEkWStlTMn2rP3Q7pOZ8wbcjd5P3i3PxhrkSowIRSLFtm5W2qUlVnjgxKbLbPgClT/U31MFLKG49JudI5dkzm1QMH0t51yop91EPMeB2sp1nUyUsisRQTn//PIemrn3s7qFS7KMFdVOkF/fnbkvkF2bjdicM
X-Gm-Message-State: AOJu0Yy3Jy8SagPJmwis4dMyxk4oXGDOtjUAzNMoTPa6Tx/XRn2EQ9el
	3tJKIEyy4ukQm/EtYRMIruJcrp+ikdKj8JKVUckGHuXIZmf3dY7T
X-Google-Smtp-Source: AGHT+IFSi6Zl6roN+pMwkndNjWlqH2oNq/bbNLK+UAZlb4vSoJGqMkxrLST790YOyh4/Jg6sPZ2R1g==
X-Received: by 2002:a17:903:a46:b0:1f9:fe14:592f with SMTP id d9443c01a7336-1fa0f8cd95cmr18266495ad.17.1719080556950;
        Sat, 22 Jun 2024 11:22:36 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc7b8asm33794545ad.300.2024.06.22.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 11:22:36 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: fsl,imx-audio-sgtl5000: Convert to dtschema
Date: Sat, 22 Jun 2024 23:51:56 +0530
Message-ID: <20240622182200.245339-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the imx-audio-sgtl bindings to DT schema. Make bindings complete
by adding audio-cpu property.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../sound/fsl,imx-audio-sgtl5000.yaml         | 108 ++++++++++++++++++
 .../bindings/sound/imx-audio-sgtl5000.txt     |  56 ---------
 2 files changed, 108 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml
new file mode 100644
index 000000000000..906dcecb73b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-audio-sgtl5000.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,imx-audio-sgtl5000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX audio complex with SGTL5000 codec
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx25-pdk-sgtl5000
+              - fsl,imx51-babbage-sgtl5000
+              - fsl,imx53-m53evk-sgtl5000
+              - tq,imx53-mba53-sgtl5000
+              - fsl,imx53-cpuvo-sgtl5000
+              - fsl,imx53-qsb-sgtl5000
+              - karo,tx53-audio-sgtl5000
+              - fsl,imx53-voipac-sgtl5000
+              - fsl,imx6q-ba16-sgtl5000
+              - fsl,imx6q-ventana-sgtl5000
+              - fsl,imx-sgtl5000
+              - fsl,imx6-armadeus-sgtl5000
+              - fsl,imx6dl-nit6xlite-sgtl5000
+              - fsl,imx6q-nitrogen6_max-sgtl5000
+              - fsl,imx6q-nitrogen6_som2-sgtl5000
+              - fsl,imx6q-nitrogen6x-sgtl5000
+              - fsl,imx6-rex-sgtl5000
+              - fsl,imx6q-sabrelite-sgtl5000
+              - fsl,imx6-wandboard-sgtl5000
+          - const: fsl,imx-audio-sgtl5000
+      - const: fsl,imx-audio-sgtl5000
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+
+  audio-cpu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of an CPU DAI controller
+
+  ssi-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the i.MX SSI controller.
+
+  audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the SGTL5000 audio codec.
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components. Each entry is a pair
+      of strings, the first being the connection's sink, the second being the
+      connection's source. Valid names could be:
+
+      Power supplies:
+        * Mic Bias
+
+      SGTL5000 pins:
+        * MIC_IN
+        * LINE_IN
+        * HP_OUT
+        * LINE_OUT
+
+      Board connectors:
+        * Mic Jack
+        * Line In Jack
+        * Headphone Jack
+        * Line Out Jack
+        * Ext Spk
+
+  mux-int-port:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The internal port of the i.MX audio muxer (AUDMUX).
+    enum: [1, 2]
+
+  mux-ext-port:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The external port of the i.MX audio muxer.
+    enum: [3, 4, 5, 6]
+
+required:
+  - compatible
+  - model
+
+additionalProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "fsl,imx51-babbage-sgtl5000",
+            "fsl,imx-audio-sgtl5000";
+        model = "imx51-babbage-sgtl5000";
+        ssi-controller = <&ssi1>;
+        audio-codec = <&sgtl5000>;
+        audio-routing =
+            "MIC_IN", "Mic Jack",
+            "Mic Jack", "Mic Bias",
+            "Headphone Jack", "HP_OUT";
+        mux-int-port = <1>;
+        mux-ext-port = <3>;
+    };
diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
deleted file mode 100644
index 2f89db88fd57..000000000000
--- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Freescale i.MX audio complex with SGTL5000 codec
-
-Required properties:
-
-  - compatible		: "fsl,imx-audio-sgtl5000"
-
-  - model		: The user-visible name of this sound complex
-
-  - ssi-controller	: The phandle of the i.MX SSI controller
-
-  - audio-codec		: The phandle of the SGTL5000 audio codec
-
-  - audio-routing	: A list of the connections between audio components.
-			  Each entry is a pair of strings, the first being the
-			  connection's sink, the second being the connection's
-			  source. Valid names could be power supplies, SGTL5000
-			  pins, and the jacks on the board:
-
-			  Power supplies:
-			   * Mic Bias
-
-			  SGTL5000 pins:
-			   * MIC_IN
-			   * LINE_IN
-			   * HP_OUT
-			   * LINE_OUT
-
-			  Board connectors:
-			   * Mic Jack
-			   * Line In Jack
-			   * Headphone Jack
-			   * Line Out Jack
-			   * Ext Spk
-
-  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
-
-  - mux-ext-port	: The external port of the i.MX audio muxer
-
-Note: The AUDMUX port numbering should start at 1, which is consistent with
-hardware manual.
-
-Example:
-
-sound {
-	compatible = "fsl,imx51-babbage-sgtl5000",
-		     "fsl,imx-audio-sgtl5000";
-	model = "imx51-babbage-sgtl5000";
-	ssi-controller = <&ssi1>;
-	audio-codec = <&sgtl5000>;
-	audio-routing =
-		"MIC_IN", "Mic Jack",
-		"Mic Jack", "Mic Bias",
-		"Headphone Jack", "HP_OUT";
-	mux-int-port = <1>;
-	mux-ext-port = <3>;
-};
-- 
2.45.2


