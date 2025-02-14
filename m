Return-Path: <linux-kernel+bounces-515704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF5A367E9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C907189014D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 21:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FCD1DDC08;
	Fri, 14 Feb 2025 21:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sw9Yp+Hj"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8D6AAD;
	Fri, 14 Feb 2025 21:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739570314; cv=none; b=Op46RcDJRZtW4gtLdMKC4t+6DGFsQw7GTWGPne2v0Zr0ltKMkVvMGjn/iKfBk4UdSbeXhz1OmF8VYiE0itgivnI/8cz0bewlyY7n2D1t98ZVndu5ZPCRRnBW0THObrJNiiLhsccZF0PS2bBIK6PKniyBu8K/HKlC9/VgVxGkpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739570314; c=relaxed/simple;
	bh=iSUEhgvx0wFV9+Nn3QSRw8A/ciA7RcP9dHPQWTkLMTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciTYG28JlbWc1OwODriWK7rwZe6lSup2Hl018MDZwiORGqyO2Vz/8N54aqbexK/l9OiCTVTc+CVvbeQwzHfZ+0tN+qx17WYlZn+xwBedgEeBW4CDbIGjljHuOUyi87Mq7VtG+SmyMf0aFrBP6czz8D8ZH1qv+vb8eTuim7yHzyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sw9Yp+Hj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f24fc466aso1742208f8f.2;
        Fri, 14 Feb 2025 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739570311; x=1740175111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HjHdIFNpacetIZjKxU9WkI1c16gFjSb3NmTyh+Z5Omw=;
        b=Sw9Yp+HjBcDyzpEDucWhsAQBzpaaUREOt63f5DpR/JeGT04obvJoJL1rgk9aIMcIQV
         taeiSSVSVyDrj5K8uQfUgOQwMPO2IMnxecBxWi7HTFu2PtTynFQfTvtyDyRMLir+yz9A
         fgVgVkYDzYje9VUfd93AN/M0y5My+A5ah4kl8aNwUvZjeJCtaCS4ApLCuYYcgZ6GeE+G
         5s6Xn/XmChAZ0oej1kuq9kz7Caww6HE3MRVWwx5LvbtIjkWwCtBcdecFy4XuY0MKq39O
         HtxKjcBKa58D8GhYUKw2DeyegIIb4LXgFIdrbKfuLCJRPBAK9B2aJZxaZMrMYnBO1ahG
         sh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739570311; x=1740175111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjHdIFNpacetIZjKxU9WkI1c16gFjSb3NmTyh+Z5Omw=;
        b=FEGYQNTyGL+PQn3Y4K+sA4wF5AYbwS3dHfs1N/uRdgv5zfyw1cs8EeLscixCUeAzSf
         8beWjgsAkV6+j5I+TzZyGUfF1oCTM90dW2Gd3vkNX+mmjvW/GO8K2ZEMcxM7I88snwQB
         n0u0goLGCzfqoM6EUHEHber7/YM/RHIdYBfQi7X9aeifsL+2cDxEXwV39jXdG2uju+ip
         iB2gzUBCWD9y9rkBKVCOmFutwKb9b6bpeqscHVsw8NQykuUUx8L9JS9rXgzEN9xHFWe0
         K2v9YkiM9lGBb+m26+tUfCs03t2qZG4aFiUaMF9nSc1pTqi2KORYAUWeXJZPcQ+r6hpg
         IVjA==
X-Forwarded-Encrypted: i=1; AJvYcCUDneO98C5hMPWn+i8SNDufwb6t6yfZgfVXSp786APd0I6lYj3sDhvgGuWioSNVY4KyEYHvSK+TaCXAn3Tj@vger.kernel.org, AJvYcCWEQ1uh1VwKm8z/MCTGbVXQJho5uS6Nqo1cu9OdfPoFiU9oNmq17NCgxTa/I7Y6WLJiBk9fHvb0oAih@vger.kernel.org, AJvYcCWutmffxp13awfiTmawuBRkHQ1zp6fcoc+KK+PtSfW8u12YbFtWl9PQtvTkJcFXxRiXVUKJiMK7lKMF6Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEiEE9UTbrPUIhpawqNvQcRR2yEfOOvwXMevfJEwyWFft4sFTD
	+kSADs4V+iKRcUOL6WHJ5rkKVaBC27YbpGxaC7lCY527ukkqVXmP
X-Gm-Gg: ASbGncvP9huvHBd9lD5HKuq0hxHfOi8o2EhylqZDijQsqji6ckRDF/irLAoCCIRGWl9
	fp2QihROUZHYO/FlXpJ7htCm8B8Xbjj1ry3vJA6G3B74glWdZSz8+eiQom+bJcBRQqi0SOSy+dc
	CSiOju3uPGOZeIpaEB4zDk3Qag5D1j5SXh0XHxRzNHgWjmDYCNE+Q77LCULxzLCIu9XtZHZjiuW
	OJAyvGekDEWjAfEiw9x0uuaYme5OaopheSgwbD/jgQtluZC5Cq3IjNSC7tltQVNWjsHVibZ9bsl
	BAfpna83oFTHUCwIZDIeXbP5AUEo3VQ=
X-Google-Smtp-Source: AGHT+IFAkyA+auhZYxZHiiVU7CrJjKC7m/ayNJTLshQZe6et28NL4/Sd0WpkVR3JHBODymhMpQQ05Q==
X-Received: by 2002:a05:6000:1845:b0:385:fd07:8616 with SMTP id ffacd0b85a97d-38f33e80e93mr985951f8f.0.1739570310711;
        Fri, 14 Feb 2025 13:58:30 -0800 (PST)
Received: from CYBER-ABAKUS.kucica ([87.116.134.57])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259d5ee2sm5558903f8f.80.2025.02.14.13.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 13:58:29 -0800 (PST)
From: Nikola Jelic <nikola.jelic83@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rwalton@cmlmicro.com
Subject: [PATCH 1/2 V4] ASoC: dt-bindings: Add cmx655 codec
Date: Fri, 14 Feb 2025 22:58:01 +0100
Message-ID: <20250214215826.80878-1-nikola.jelic83@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Nikola Jelic <nikola.jelic83@gmail.com>

---
V3 -> V4: review remarks
V2 -> V3: fixed dt_binding_check + yamllint warnings
V1 -> V2: removed the txt file, fixed review remarks
---
 .../bindings/sound/cml,cmx655d.yaml           | 62 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cml,cmx655d.yaml

diff --git a/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
new file mode 100644
index 000000000000..577e1d4942c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cml,cmx655d.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/cml,cmx655d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CML Micro CMX655D codec
+
+maintainers:
+  - Richard Walton <rwalton@cmlmicro.com>
+  - Nikola Jelic <nikola.jelic83@gmail.com>
+
+description:
+  The CMX655D is an ultra-low power voice codec.
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: cml,cmx655d
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: cmx-irq
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        audio-codec@54 {
+            compatible = "cml,cmx655d";
+            reg = <0x54>;
+            #sound-dai-cells = <0>;
+            reset-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+        };
+
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index dac80c62b742..74f925f3e3cb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -310,6 +310,8 @@ patternProperties:
     description: Carl Cloos Schweisstechnik GmbH.
   "^cloudengines,.*":
     description: Cloud Engines, Inc.
+  "^cml,.*":
+    description: CML Micro, Ltd.
   "^cnm,.*":
     description: Chips&Media, Inc.
   "^cnxt,.*":
-- 
2.47.2


