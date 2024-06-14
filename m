Return-Path: <linux-kernel+bounces-214307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA5690828A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911D91F23BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD21146A68;
	Fri, 14 Jun 2024 03:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gmv7WXQt"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A9144D2C;
	Fri, 14 Jun 2024 03:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336364; cv=none; b=sypTUbocbto/BdKhb/73kGHV9R4ggcWMcUTqheJz4s6PlgCxw/EcUB9ZXvp3vP0WJnARnAGUEyTExJ63Z6bfNmC97fDTa1ZsKQFzbkxS1g+butJzcW9LJQTljISqexRN2gjm9fl4xBHeAXtLs37Rccn7rBhM9VmhjwwxNTsIs70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336364; c=relaxed/simple;
	bh=GNAEDvNKlW8bZj7JdRG8bxyTRhbaj1s3OfFXcZK3Lqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVpsfjTKEQTHv+Oe9KmJ7Y6wTF5OSz6RI7LkfCqBtGb0fTfnqMJacX860Bur1zhhQEcjwL5Kbyz/SJHTNU3KsO1arqy4GNwDEQwRipratIg8jQLWRcrSSS9YBHn/yGFTxY8Q0mKNs/P8SE7EyBFrEVPpNgpEl2pmMVlqvOviWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gmv7WXQt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f480624d0dso14289635ad.1;
        Thu, 13 Jun 2024 20:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718336362; x=1718941162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wj31yPYy6tRRBSt9nJyH+0doinj9fP9C2Og2zh8SH8=;
        b=Gmv7WXQt/NWWBcLvhx6EhVefH+Py8rHcKcX54imwfRJYE3PCtzQFuunj3I6/P9aJOj
         Hnr83K426Cyd2Hkv5YqAtzN4j6ZCok3nj1u+dqke5kgmb1kqDxmTgtI2f52TOB7tk8xq
         hBZdkYEpy7BqFBge8W7ThgC4xgn2+4gUWgd0/PPptYNMFsntMyOOOa9BQL6lVzBksZXC
         cynEWGI9sqyGL/t++9gLnV4lrnrh8i05BUKMV4sMNK9ZmhkZu3TgTwLubmGxnhw3yj01
         QiK/kZ2vnBRmjR1Wk3+LGz263iq06KR3f+0I5v9rl90IC+Dpcnxhf/dW9K2QTArKlJaf
         kHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718336362; x=1718941162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wj31yPYy6tRRBSt9nJyH+0doinj9fP9C2Og2zh8SH8=;
        b=O6JZGBOSr4WhtDPrQ+jne8YHJBLyYjQLyezOHxcM+F/hdpFNWf95ZZB8sVTofZalXK
         ri3gYCoVt0k0FgS3g6Shkwk2DeJaghJA9xbJdOjCA3CcSnSWr8s0wMQ1jQ/gucLI5YPp
         afxlVIANS8f7/c8e7fy/lA8ikev+DkU/bw9Wn/EYltRldVbeyPEADGFZPxyWX4vvGeRX
         ybcSQISGvPhT+RwIkICK8Ebn6XKEBuIwCZamb0gr98zRh+aUd5OTwiO/9JZuvrd8al9O
         9qCBAmmA1dmSHRlDi1PADaDXNhaI0R1DO8FGfUk3OGw/7WVwrd/9rwW4kAFMCRC2q2IT
         eU+w==
X-Forwarded-Encrypted: i=1; AJvYcCV1EdHSuQFOi/9yztBRRgR4GNeHHhgjdNarBDZ7SJi4y+6wngqXP5ZKLVv7/PykdHpoqMhd+XnGQdWFB13BafkW0aVwGW1x9yGzo97nQGpqVtwghq7OA0lfy8R+jJkibJZyR/3jGxRUZ0vlcatpsqGkd9/6y8ym5NaATsHagLcNAqEnTyz2
X-Gm-Message-State: AOJu0YwO5Cw778uRw96pEAKdr2+NOfH8QOzrzCNqACMzt0wvI7C2WbCX
	TZAvkZeiXXID/KfqxJ3R32RJcv1AgEDQjYDzLQ9nFpemC2QAtoy2
X-Google-Smtp-Source: AGHT+IGEvO9MbSiy6fnAEbwKDUg7/14/AfofLJlLjTYA/ri1ZNObseGveHaMKbvtAX0iB9gF0pM02w==
X-Received: by 2002:a17:903:1250:b0:1f6:9181:47ac with SMTP id d9443c01a7336-1f8625c0427mr22643805ad.1.1718336362331;
        Thu, 13 Jun 2024 20:39:22 -0700 (PDT)
Received: from fedora.one.one.one.one ([2405:201:6013:c0b2:ea4b:30e0:4e3a:ab56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f002b0sm21824085ad.192.2024.06.13.20.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 20:39:22 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Animesh Agarwal <animeshagarwal28@nxp.com>
Subject: [PATCH 2/2] ASoC: dt-bindings: realtek,rt5631: Convert to dtschema
Date: Fri, 14 Jun 2024 09:08:07 +0530
Message-ID: <20240614033812.51312-3-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240614033812.51312-1-animeshagarwal28@gmail.com>
References: <20240614033812.51312-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ALC5631/RT5631 audio CODEC bindings to DT Schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../bindings/sound/realtek,rt5631.yaml        | 63 +++++++++++++++++++
 .../devicetree/bindings/sound/rt5631.txt      | 48 --------------
 2 files changed, 63 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/rt5631.txt

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5631.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
new file mode 100644
index 000000000000..05b83d907b38
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5631.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/realtek,rt5631.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ALC5631/RT5631 audio CODEC
+
+description: |
+  This device supports I2C only.
+
+  Pins on the device (for linking into audio routes):
+      * SPK_OUT_R_P
+      * SPK_OUT_R_N
+      * SPK_OUT_L_P
+      * SPK_OUT_L_N
+      * HP_OUT_L
+      * HP_OUT_R
+      * AUX_OUT2_LP
+      * AUX_OUT2_RN
+      * AUX_OUT1_LP
+      * AUX_OUT1_RN
+      * AUX_IN_L_JD
+      * AUX_IN_R_JD
+      * MONO_IN_P
+      * MONO_IN_N
+      * MIC1_P
+      * MIC1_N
+      * MIC2_P
+      * MIC2_N
+      * MONO_OUT_P
+      * MONO_OUT_N
+      * MICBIAS1
+      * MICBIAS2
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - realtek,alc5631
+      - realtek,rt5631
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        codec@1a {
+            compatible = "realtek,alc5631";
+            reg = <0x1a>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/sound/rt5631.txt b/Documentation/devicetree/bindings/sound/rt5631.txt
deleted file mode 100644
index 56bc85232c49..000000000000
--- a/Documentation/devicetree/bindings/sound/rt5631.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-ALC5631/RT5631 audio CODEC
-
-This device supports I2C only.
-
-Required properties:
-
-  - compatible : "realtek,alc5631" or "realtek,rt5631"
-
-  - reg : the I2C address of the device.
-
-Pins on the device (for linking into audio routes):
-
-  * SPK_OUT_R_P
-  * SPK_OUT_R_N
-  * SPK_OUT_L_P
-  * SPK_OUT_L_N
-  * HP_OUT_L
-  * HP_OUT_R
-  * AUX_OUT2_LP
-  * AUX_OUT2_RN
-  * AUX_OUT1_LP
-  * AUX_OUT1_RN
-  * AUX_IN_L_JD
-  * AUX_IN_R_JD
-  * MONO_IN_P
-  * MONO_IN_N
-  * MIC1_P
-  * MIC1_N
-  * MIC2_P
-  * MIC2_N
-  * MONO_OUT_P
-  * MONO_OUT_N
-  * MICBIAS1
-  * MICBIAS2
-
-Example:
-
-alc5631: audio-codec@1a {
-	compatible = "realtek,alc5631";
-	reg = <0x1a>;
-};
-
-or
-
-rt5631: audio-codec@1a {
-	compatible = "realtek,rt5631";
-	reg = <0x1a>;
-};
-- 
2.45.2


