Return-Path: <linux-kernel+bounces-398481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE59BF1CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD41F238D7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482B207215;
	Wed,  6 Nov 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV98/D8s"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F12036ED;
	Wed,  6 Nov 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907108; cv=none; b=alv4ppm+SC54iCpILZoZ+RKlBtB3SuAmgl69zXpnu8Whi8VGWlmraWzdhn8ayNiOhYZcAk6FghFW88J0+E7myIh6wqgGK6B1VLFwA5tAz7LyRtV31dSZmsP0hHAUYvkCLohHQ12YNyy+OIXm/4PLvTqnT848tabwlLDSVezO/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907108; c=relaxed/simple;
	bh=YinUtlhN21UTDpWy65DE0bx73dRSBrI4axGpunJIP4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjFlRn2b9DPnyk/ox02nJ/p2YSJFqoA4drumyHzSH9YMmgaI9p+stAWqoaJ4ph0fbwh1CDeNNtu1tQbd+En/GtaPd2WF7O5lk1O5mUeXs/UEyWubH6sL+yR/lZvwJqFqDCCdxbz8tzGYlAj/jXZvEcnggBNqj1J592yE3qPMEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV98/D8s; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e8522445dso731477966b.1;
        Wed, 06 Nov 2024 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730907105; x=1731511905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxZUEYefO8cHk0O3pZ6pSrkyLEtM/cjRFYGqJjEkBSc=;
        b=gV98/D8swQiWj1GoQ9w88zv+fydMA7X3Mgs8EVBU5fLTmogPtXm0EQgHPTTLnDgBEZ
         xnQFgHYLoz8pbqT7VcErljDMrMk6cv3DKZiCH+QkJCnMWZYm2P16Yh+OAe/lRglPXuhH
         uuTaZp4gqhcNnm+hJqSaPqID1eK5N3y7dfx9sT53HeF29uO3spXm+VupvtKt3nf6Hj5V
         iT+dzSPe6L+PObDbskzDCMNglkJq431h53MbBvDuTFRgZbvq6Nvc5XapYifu0J3d6GVp
         P7fIfgYbBog/FVfhRHZFXqYwFPfgsMrVyb/jXkZbyLWXTDzm7YMJqbE+y2vTkT7dJvNS
         FhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730907105; x=1731511905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxZUEYefO8cHk0O3pZ6pSrkyLEtM/cjRFYGqJjEkBSc=;
        b=ubcaOgHqXEXSekHpJt4pS9QdVwbBOXAiMX8GA6iedZs+bb9swDSf2A1q1DOV5AOw9H
         JthjY6MLRZNtfioD9493WiFxiL68qYE/ToVjj2szrMavPLXb7mK1j+RtSlKqZ3kq5K0k
         n/RzO/be3sRKW3RA/1g5C6WlFjU0D5LreDXGyUUp3uKjFoafR60+/2Ob6Zex0Q+eGMwF
         u2SZnjkO7wDlIdOSROil5044zm4Xp1mhMeiALepXogtEMnOC1aUjmOldr70gBMw65MsC
         RrSmbSMmgzvg0/iJ7FoBi1QW+XxRK8jH/ydwNTuRfRRLNOJ2JOKYqDf1rCbUimTL7kd4
         5JFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmhzs+D+z1RTKAx5sv3jsB/ap6j0YOc3XUHC+UI3sUFttpSAcFkfQqvOhcdKRensZJLIz4fRoEPOWd@vger.kernel.org, AJvYcCVqMGiszqMgt5WUMdyOicUX3gGHCn86zb0ahta8udEbFhtj14T/euHrlb9qGk5jKtN6B7xjPiOoVIWY9KTz@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUzzFE0P9NSY4iMXEyMvzQk7EeRuPYpu/y74E//67dITbZ9i4
	c7LeA350opm7MT9/qFonEirrsrihzfP4gc/BWWd3mCxHEQYrEb91
X-Google-Smtp-Source: AGHT+IF0ZzyBdcVslRwOSTjEHqwVoJnmjkaO24ZdQOt67CgbkGTe+T3MfKCDKsQIMoe5M16dlGZRtg==
X-Received: by 2002:a17:906:6a12:b0:a9a:1778:7024 with SMTP id a640c23a62f3a-a9e65576989mr2245715566b.20.1730907105078;
        Wed, 06 Nov 2024 07:31:45 -0800 (PST)
Received: from ivaylo-T580.. (miroral.stz.ddns.bulsat.com. [91.139.249.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17cecd7sm302227066b.100.2024.11.06.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 07:31:44 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: clock: actions,owl-cmu: convert to YAML
Date: Wed,  6 Nov 2024 17:31:41 +0200
Message-ID: <20241106153141.375389-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Actions Semi Owl CMU bindings to DT schema.

Changes during conversion:
 - Since all Actions Semi Owl SoCs utilize the internal low frequency
   oscillator as a parent for some clocks, require it.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
v2: drop address and size cells from example
---
 .../bindings/clock/actions,owl-cmu.txt        | 52 -----------------
 .../bindings/clock/actions,owl-cmu.yaml       | 57 +++++++++++++++++++
 MAINTAINERS                                   |  2 +-
 3 files changed, 58 insertions(+), 53 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml

diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
deleted file mode 100644
index d19885b7c..000000000
--- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-* Actions Semi Owl Clock Management Unit (CMU)
-
-The Actions Semi Owl Clock Management Unit generates and supplies clock
-to various controllers within the SoC. The clock binding described here is
-applicable to S900, S700 and S500 SoC's.
-
-Required Properties:
-
-- compatible: should be one of the following,
-	"actions,s900-cmu"
-	"actions,s700-cmu"
-	"actions,s500-cmu"
-- reg: physical base address of the controller and length of memory mapped
-  region.
-- clocks: Reference to the parent clocks ("hosc", "losc")
-- #clock-cells: should be 1.
-- #reset-cells: should be 1.
-
-Each clock is assigned an identifier, and client nodes can use this identifier
-to specify the clock which they consume.
-
-All available clocks are defined as preprocessor macros in corresponding
-dt-bindings/clock/actions,s900-cmu.h or actions,s700-cmu.h or
-actions,s500-cmu.h header and can be used in device tree sources.
-
-External clocks:
-
-The hosc clock used as input for the plls is generated outside the SoC. It is
-expected that it is defined using standard clock bindings as "hosc".
-
-Actions Semi S900 CMU also requires one more clock:
- - "losc" - internal low frequency oscillator
-
-Example: Clock Management Unit node:
-
-        cmu: clock-controller@e0160000 {
-                compatible = "actions,s900-cmu";
-                reg = <0x0 0xe0160000 0x0 0x1000>;
-                clocks = <&hosc>, <&losc>;
-                #clock-cells = <1>;
-                #reset-cells = <1>;
-        };
-
-Example: UART controller node that consumes clock generated by the clock
-management unit:
-
-        uart: serial@e012a000 {
-                compatible = "actions,s900-uart", "actions,owl-uart";
-                reg = <0x0 0xe012a000 0x0 0x2000>;
-                interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-                clocks = <&cmu CLK_UART5>;
-        };
diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml b/Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
new file mode 100644
index 000000000..3504f70eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/actions,owl-cmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Actions Semi Owl Clock Management Unit (CMU)
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+  The Actions Semi Owl Clock Management Unit generates and supplies clock
+  to various controllers within the SoC.
+
+  All available clocks are defined as preprocessor macros in
+  include/dt-bindings/clock/ headers.
+
+properties:
+  compatible:
+    enum:
+      - actions,s500-cmu
+      - actions,s700-cmu
+      - actions,s900-cmu
+
+  clocks:
+    items:
+      - description: Host oscillator source
+      - description: Internal low frequency oscillator source
+
+  "#clock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  "#reset-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#clock-cells"
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    cmu: clock-controller@e0160000 {
+       compatible = "actions,s900-cmu";
+       reg = <0xe0160000 0x1000>;
+       clocks = <&hosc>, <&losc>;
+       #clock-cells = <1>;
+       #reset-cells = <1>;
+     };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 420d06d37..652c9822a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2016,7 +2016,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/arm/actions.yaml
-F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+F:	Documentation/devicetree/bindings/clock/actions,owl-cmu.yaml
 F:	Documentation/devicetree/bindings/dma/owl-dma.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-owl.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.yaml
-- 
2.43.0


