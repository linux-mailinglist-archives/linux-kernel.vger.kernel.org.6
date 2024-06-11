Return-Path: <linux-kernel+bounces-209232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68501902F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36C31F2386E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C616F915;
	Tue, 11 Jun 2024 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFNhhsbB"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA564B;
	Tue, 11 Jun 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718078057; cv=none; b=GIomLdhYP/hBMFOiwYO2SlRkesRybJU0ha0kRDe875Qgw+TIhpEfmnGr5D2qzXAId8LTOTIAC4PBjFd2mw0l9OQ92FOFJV4sUDU6WW2ytPDn6UaQ4F9/vZEbCDrv42cp+X1C5tyXWp60Y+UVSaBkHizUj3EXBx/IYnV5zRCsmZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718078057; c=relaxed/simple;
	bh=P/JlWkj1d4lbqMVcIecB6nL36p87uwx5huDvmxRLP50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POHZFuaLWPFFMMCwHYH0gGrx5FsS0BeK9nbBvDQvk4Ztd4SiR/Ou1/g2gviPl8IOgUikzjB1aQdMvULAherbM1tMoT6uZfx7Wc2s2l6tHagS/sSRptt4H57yBmxcMptSYMOSGKEpyV0Ud97ghPEUphettRJ2orOSQRJPAVee7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFNhhsbB; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375ae697214so3095095ab.1;
        Mon, 10 Jun 2024 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718078055; x=1718682855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZOXFTXYUG3Q3znuwbPKJY/6pkvj0jJfwfifudPkm/g=;
        b=QFNhhsbB0KXPiglzELpfBKtQTsCdgjvjRM2rfU4Zbmrz+tkamdgw6R9PqN8Sq4rtUi
         W5BNDLzRhmh+RLzKHyyPAxXH8vnbrPqPTat5Hy16SBS2z4rdwVCVJhAwb29453Swuj6O
         9tsEZRNub/q2ul2sSLL/ydLxyRg+yUE/lwzZ+LzVrqDPZ2MNXTeSVW85/Ggpbz+nQrmc
         X1hXkNlrqXZtF9lwXI455y/u/qjuIsircBtxUVe54fY0A7d/XpZKbQEqOP/0RCy/aQry
         JQcoXkS0XTbBwU2JQdw/Tyam+nlHtOS8EMEN+iBhqQ3U6rNdZNgxiTRFe8ZlsU1DHHHj
         8eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718078055; x=1718682855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZOXFTXYUG3Q3znuwbPKJY/6pkvj0jJfwfifudPkm/g=;
        b=RJDtmjK3sp8BIbLBQ8Pv1qBfDKyFrEG+5/ZQnV7f/vizsVbYFJd6e5/XZMqjGYax9L
         gbht15kzXkhttR/y+z9bGUpZjwlRctQejq6QP45l/APYG01oyoMEhTGpf4yxJF/uRDDw
         XJLjcYgoRExLGIp6aBQC7MCQhSWhaImSj0h2qhFA4yQ8cQyS/RuK87sZmiOdyqDEZ/sK
         lgaxAB2a22DGFQztZOJZSTqZ8hDqrl3bgRuI153YE7dgUBJUY1SLMhLHmxlVKYXc2F/d
         G92yxrVOtP40s3yvM6xHVOTrmfmoEG8jPJQbXFjBnxgrQs7yOf7Xw+YEajoaWYu5JanA
         7eEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW23Nf1/Q7CDz/1jv398IaBzQF0/vn2OdEOzGu3698hlwgChRSXEaVTs9thYSurIaxfbcItmBeTxnS5oWjrTSUASFHxWgJaPqihjwNzuuqVjuZHFdBNWiiDYKopQ6TpRGi1adeIcgXJPQ==
X-Gm-Message-State: AOJu0YzHGqSl2kNGMCKZl7YCYogaESnY4m3k6/MbDMUDrQhH7eEU5AEv
	YuSkGV1QgGoUmoaLTIReA1YtFqn1TmIPyv+DWnzmOKYfD+AXQ0T2
X-Google-Smtp-Source: AGHT+IHvVho54m9hVhHxrAOmzVD1b15JqFTjH/MROr8cx0rEmOV1us0+bFPZHq5JZQE63gPj2sWKdQ==
X-Received: by 2002:a92:c244:0:b0:374:a176:e26e with SMTP id e9e14a558f8ab-375803a4565mr125901145ab.31.1718078055139;
        Mon, 10 Jun 2024 20:54:15 -0700 (PDT)
Received: from ga401ii.SRMIST.EDU.IN ([59.152.80.69])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6eb420e918esm3005937a12.2.2024.06.10.20.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 20:54:14 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: brcm,bcm63138-pmb: convert to yaml
Date: Tue, 11 Jun 2024 09:23:23 +0530
Message-ID: <20240611035329.33648-2-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom BCM63138 Processor Monitor Bus to newer DT
schema. Created DT schema based on the .txt file which had `compatible`,
`reg` and `"#reset-cells" as required properties.
Added one line description which was missing in the original .txt file.
Added Philipp Zabel as the maintainer (took from MAINTAINERS file).

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
 .../bindings/reset/brcm,bcm63138-pmb.txt      | 19 --------
 .../bindings/reset/brcm,bcm63138-pmb.yaml     | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt b/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
deleted file mode 100644
index a98872d27872..000000000000
--- a/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-Broadcom BCM63138 Processor Monitor Bus binding
-===============================================
-
-Please also refer to reset.txt in this directory for common reset
-controller binding usage.
-
-Require properties:
-
-- compatible: must be "brcm,bcm63138-pmb"
-- reg: base register address and size for this bus controller
-- #reset-cells: must be 2 first cell is the address within the bus instance designated
-  by the phandle, and the second is the number of zones for this peripheral
-
-Example:
-	pmb0: reset-controller@4800c0 {
-		compatible = "brcm,bcm63138-pmb";
-		reg = <0x4800c0 0x10>;
-		#reset-cells = <2>;
-	};
diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.yaml
new file mode 100644
index 000000000000..162b4c472c18
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm63138-pmb.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/brcm,bcm63138-pmb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM63138 Processor Monitor Bus
+
+description: This document describes the BCM63138 processor monitor bus.
+
+maintainers:
+  - Philipp Zabel <p.zabel@pengutronix.de>
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
+
+properties:
+  compatible:
+    const: brcm,bcm63138-pmb
+
+  reg:
+    description: base register address and size for this bus controller
+    maxItems: 1
+
+  "#reset-cells":
+    description: |
+      must be 2 first cell is the address within the bus instance
+      designated by the phandle, and the second is the number of zones
+      for this peripheral.
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - "#reset-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pmb0: reset-controller@4800c0 {
+        compatible = "brcm,bcm63138-pmb";
+        reg = <0x4800c0 0x10>;
+        #reset-cells = <2>;
+    };
-- 
2.45.2


