Return-Path: <linux-kernel+bounces-393804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C5F9BA56E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AC5281CD1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073971632CA;
	Sun,  3 Nov 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmUmyJAi"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1A15A8;
	Sun,  3 Nov 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730637564; cv=none; b=aS+iy28igQeJB6xfDFE5FqwIlbr1MSdBj/eKcbaEIjNPT40Msi7U0/tg6pypDsT6lXWcu3f3TlXelUAezJ+8ZO6IkbBhKRj0WqtXxtbYUqDtGCMCDjb4iNr8z0RA/o3B2MI0On1KWShq5IOgDMqZlYjyigkX0LIa2sZAbmiDuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730637564; c=relaxed/simple;
	bh=g/1irk4ewyRYssspPZE2aQmRqzVxj36HGlIhjKds740=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ca03kQXUoYxqdOdw6wHNFJBF5UrRqMlW18SDEaprf7ggsABSh4q1KMSXmfPx3btrUOlqNn+1iffMG0IxJyRlmZ6cZf5uWzMzDDT5GdCyt72kJ9ZCVcRwc4tvDg3rBeBr79LHjDdVE8160Xgqzgu1Maf+APVkTNGbAQrFTuSzcoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmUmyJAi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e8522445dso186778766b.1;
        Sun, 03 Nov 2024 04:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730637561; x=1731242361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7j3cATWnm4HzXABiCv4XHWvp91cgQ9f7x4sZtJZS+Es=;
        b=MmUmyJAiLU5pMMvrm57hHZR/U/7D/Eq2SmCQ316gTty499sEOxDqsJN5vce2e+iFyK
         QYcuxWlsH2SHX8OiSL9KTa/+t3GCyodYUGQzeOpczg4xQ4oB50JmFM7Ny3bQ5PLY5n8w
         hjCL8jXCbnrdpX9CzrI2B8h+3tHcOJS/B196zBzIFPGdY4HBlAsrC5yrWn9baMT4R/Ll
         BKgKBgOylhXbDw1ECd8Lhw6C8WMs5+J7GtgSaE+hX0dBA2mY0T55j/eTLKKi2eiVRbM7
         UsLPEuQyxVbEht+Iuf7BS7Ub4LgfzHJ+9gF8pURrFZpnlkFjUG3+Cc42KUHAQPPYWlYJ
         zlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730637561; x=1731242361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7j3cATWnm4HzXABiCv4XHWvp91cgQ9f7x4sZtJZS+Es=;
        b=VddGL+Www5ZWJ5jnu0brTjTu9fHIZEktNVepRouOR0CcJ4969rws3cZsb/5JV7kcv2
         xtF8b5Rm3JL/iqFIHdSsfFOlQWYlton5d/YFoTnKGe1o4gyPRc8+ILf9cNYJvvGK23ob
         AgPbl49O6X1sim9C6YtbrU/+O7oRNFE/edxKfTvxFmkUWfE6B3kZBu0/zXML1pR6FNjv
         JO0c10eC4XmpN6VER944BZP6GFkeXyHHksa36umaIZJJRFMTLG2UMuBU6QKDkq9XVMYx
         5Un8VZeW2Im/nZNdKpz8QtT90yVz0o+Cs4aJQN58xJ9aM8vxdjQlttwvoUNKmO826t4o
         fUow==
X-Forwarded-Encrypted: i=1; AJvYcCU0Rj3CUrFpk0TviOtgjxwUNYqTatImfVIJDMkNoTSeLimajODjnj5S5uFWciezbO+bWzUrjAB0yEVUeDoh@vger.kernel.org, AJvYcCUu3n8/HG5a3R18pk2alZAxokbIyj9Ogfb09enWNpxjsJZ4L/cohU3nzEAlQ6GHsFwb9rfeyTHPo+wP@vger.kernel.org
X-Gm-Message-State: AOJu0YxIF+XuwdMqp1skUJ3mPRTH6sZTHMnZVCUO7t5p8xQh167B7CkD
	EwhRd3WtBaMZock40wI2PnB/4NDN3r8GZyyVz9nbg7pDvMss5IS1
X-Google-Smtp-Source: AGHT+IGpnRd0UvcHqm472HJ7iothM0hy6ObMxdHV/Ghz9bQRgK1XBu15I9OSgPH8IQoyOnJ1aBCQGQ==
X-Received: by 2002:a17:907:ea8:b0:a99:44d1:5bba with SMTP id a640c23a62f3a-a9e6587e272mr855330966b.45.1730637560566;
        Sun, 03 Nov 2024 04:39:20 -0800 (PST)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494119sm418884266b.27.2024.11.03.04.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 04:39:20 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-actions@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: power: actions,owl-sps: convert to YAML
Date: Sun,  3 Nov 2024 14:39:16 +0200
Message-ID: <20241103123917.2890436-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Actions Semi Owl Smart Power System (SPS) bindings to DT
schema.

Changes during conversion:
 - Add a description

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
v2: add r-b tag from Krzysztof Kozlowski <krzk@kernel.org>
v2: update commit message to be accurate (Krzysztof)
v2: don't preserve formatting in the description (Krzysztof)
v2: add a blank line after additionalProperties (Krzysztof)
---
 .../bindings/power/actions,owl-sps.txt        | 21 --------
 .../bindings/power/actions,owl-sps.yaml       | 51 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 52 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.yaml

diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
deleted file mode 100644
index a3571937b..000000000
--- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Actions Semi Owl Smart Power System (SPS)
-
-Required properties:
-- compatible          :  "actions,s500-sps" for S500
-                         "actions,s700-sps" for S700
-                         "actions,s900-sps" for S900
-- reg                 :  Offset and length of the register set for the device.
-- #power-domain-cells :  Must be 1.
-                         See macros in:
-                          include/dt-bindings/power/owl-s500-powergate.h for S500
-                          include/dt-bindings/power/owl-s700-powergate.h for S700
-                          include/dt-bindings/power/owl-s900-powergate.h for S900
-
-
-Example:
-
-		sps: power-controller@b01b0100 {
-			compatible = "actions,s500-sps";
-			reg = <0xb01b0100 0x100>;
-			#power-domain-cells = <1>;
-		};
diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.yaml b/Documentation/devicetree/bindings/power/actions,owl-sps.yaml
new file mode 100644
index 000000000..0855d82f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/actions,owl-sps.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/actions,owl-sps.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl Smart Power System (SPS)
+
+maintainers:
+  - Andreas Färber <afaerber@suse.de>
+
+description:
+  Actions Semi Owl SoCs feature a Smart Power System (SPS) that manages power
+  domains to optimize power usage across various hardware blocks. Each power
+  domain corresponds to a specific hardware block and is represented by a bit
+  in the power control register and an acknowledgment bit, which is then
+  translated into a corresponding voltage on a rail.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-sps
+      - actions,s700-sps
+      - actions,s900-sps
+
+  reg:
+    maxItems: 1
+
+  "#power-domain-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#power-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/power/owl-s500-powergate.h>
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      sps: power-controller@b01b0100 {
+        compatible = "actions,s500-sps";
+        reg = <0xb01b0100 0x100>;
+        #power-domain-cells = <1>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 76ea65128..420d06d37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2023,7 +2023,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
 F:	Documentation/devicetree/bindings/mmc/owl-mmc.yaml
 F:	Documentation/devicetree/bindings/net/actions,owl-emac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/actions,*
-F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
+F:	Documentation/devicetree/bindings/power/actions,owl-sps.yaml
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.yaml
 F:	arch/arm/boot/dts/actions/
 F:	arch/arm/mach-actions/
-- 
2.43.0


