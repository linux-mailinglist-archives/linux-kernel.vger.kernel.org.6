Return-Path: <linux-kernel+bounces-270794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5837A94455C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7031C21DF0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C6B16DC1C;
	Thu,  1 Aug 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoRRRnJF"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2144C16C87B;
	Thu,  1 Aug 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496930; cv=none; b=aS0/6IUg4xrxxbrI5dovS+ua0KdHbgGQYw/nEUQQTQkK0QdQX5554dMiy9dNipTINQTitRsyborrEH6ukXxYmVSKvQ0fgggXlpCZLZ6p0YxmcnHiQY0vhc/fePOoEDuQh4J1UXFWrrsYAXZ2QCzdmHYL4nSnyW4M5vjBUHVye18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496930; c=relaxed/simple;
	bh=iDPnwOSUmxM8H77nmPTsqAprO2WWw9B0gbRSD8D996w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SGzVg7D6Vtx7hYNbE6jV4ugH9uqTq9nG9u5kFilh9txy+ZLvHZQ9xiWiPijlqxNUneUgIIK1MDJNaif3wOABjlXRRFe8+8B2zATZSXGYdVYAeGTvaT7ubswLEUYP6zgAXP75WDFwE4JxurXMIWkyvAlbrRSWaXTL2RcpKREoujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoRRRnJF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb6b247db0so1134120a91.2;
        Thu, 01 Aug 2024 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722496928; x=1723101728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evITfR508dWkC6GH2X8C7bD8ExWPXbUNlGzWar4VMrY=;
        b=CoRRRnJFaJqrmrs/k1bdbkHD+70KHVC6IW4tJReG1iyFystVW+ZUu2aOVbqm1XOng8
         lk8ZZQ0VAfFgXr83/onHBt7Ux84RAdI5pFYG7oLG6UVjjnS9VHswHkgA5CHxvhxAtSH9
         XZ0tthzwgmcVq35eMzEFaoUUqpBFixiOx9p4LbjpLNhikmyj4KEFKo/m50p9aevuOPkA
         4ouaNkPvfCDFl4HBjmlYVImq3MJPsjEK4ty12pW0ls3EuYJUJatI7uVCPZjjVDJXuQ8S
         5Pjcxf2raJrNyDvSgDXg0JQtlEZUxRzehVNiJtfm7T414tZUEHuuSSg/bhoarkzVBK4W
         lzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722496928; x=1723101728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evITfR508dWkC6GH2X8C7bD8ExWPXbUNlGzWar4VMrY=;
        b=uU/E4WyWXkEXlRrx0LDmVvxUaVY+zs8fcfrEDAhWYMarmCydh10+njtPl3Xg+EjlcV
         OZPmoVpJDYav35mPaJGJObSy+luFYwSx1zBNZWLKxwZvQNUa81yk2euURobk79oure51
         OWdc3KtVifELcNMJ7Pq/YeTuRr7cHzJ/6e3tWe44yAYDBbTiDvBgzOvw98szvx7NKXY4
         Yc5t3eCKkvKEI2YfygclAxddI5Mua6hk3gcoaG94x6lKwUCzbc79e1YvynMputh14goD
         60caBs74GemPu/YV8saL1LEnrFApDCj8Ixl2eg3tD8z0MswmGM91kRrMro2dR9dUHb8f
         sofw==
X-Forwarded-Encrypted: i=1; AJvYcCXFw6+wGUkXIZk+uAq8QGg/HVNDUJ3gQ9qlkSAW5lDiZp/ToAvoj2XYNy5kj7zaz1TD/CxSj9PL4qB4aM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYFskkNhUOy2AZwGytInEmsKnlYWGKJMqhZhmZJDRnWr8OOBnr
	7e3MsGa0BHK0Rmle7ZNJqYRBwfn9zzIap9NrJu06oQ1XV7qNai3E
X-Google-Smtp-Source: AGHT+IFJpGO3IL36H7tUcsLnZ2gQA+/8iTcyIiSWhG0CYi1+kos5rW5QPv4Kv6rMtavF6ypKU2LbRg==
X-Received: by 2002:a17:902:e741:b0:1fb:43b5:8793 with SMTP id d9443c01a7336-1ff4d271611mr11171945ad.6.1722496928382;
        Thu, 01 Aug 2024 00:22:08 -0700 (PDT)
Received: from cs20-buildserver.. ([180.217.140.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff4619793bsm22117425ad.120.2024.08.01.00.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 00:22:08 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	cpchiang1@nuvoton.com
Subject: [PATCH v1 1/2] dt-bindings: i3c: Add NPCM845 i3c controller
Date: Thu,  1 Aug 2024 15:19:45 +0800
Message-Id: <20240801071946.43266-2-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240801071946.43266-1-yschu@nuvoton.com>
References: <20240801071946.43266-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The npcm845 i3c devicetree binding follows the basic i3c bindings
and add the properties for allowing to adjust the SDA/SCL timing
to meet different requirements.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
Signed-off-by: James Chiang <cpchiang1@nuvoton.com>
---
 .../bindings/i3c/nuvoton,i3c-master.yaml      | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml

diff --git a/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
new file mode 100644
index 000000000000..a40b37b16872
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/nuvoton,i3c-master.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NPCM845 I3C master
+
+maintainers:
+  - Stanley Chu <yschu@nuvoton.com>
+  - James Chiang <cpchiang1@nuvoton.com>
+
+allOf:
+  - $ref: i3c.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,npcm845-i3c
+
+  reg:
+    items:
+      - description: I3C registers
+      - description: GDMA registers
+      - description: GDMA request control register
+
+  reg-names:
+    items:
+      - const: i3c
+      - const: dma
+      - const: dma_ctl
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: system clock
+      - description: bus clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: fast_clk
+
+  resets:
+    maxItems: 1
+
+  i3c-pp-scl-hi-period-ns:
+    description: |
+      If need to configure SCL with required duty cycle, specify the clock high/low period directly.
+      i3c-pp-scl-hi-perios-ns specifies the high period ns of the SCL clock cycle in push pull mode
+      When i3c-pp-scl-hi-period-ns and i3c-pp-scl-lo-period-ns are specified, the i3c pp frequency is
+      decided by these two properties.
+
+  i3c-pp-scl-lo-period-ns:
+    description: |
+      The low period ns of the SCL clock cycle in push pull mode. i3c-pp-scl-lo-period-ns should not
+      be less than i3c-pp-scl-hi-period-ns and the maximal value is i3c-pp-scl-hi-period-ns + 150.
+
+  i3c-pp-sda-rd-skew:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The number of MCLK clock periods to delay the SDA transition from the SCL clock edge at push
+      pull operation when transfers i3c private read.
+    maximum: 7
+    default: 0
+
+  i3c-pp-sda-wr-skew:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      The number of MCLK clock periods to delay the SDA transition from the SCL clock edge at push
+      pull operation when transfers i3c private write.
+    maximum: 7
+    default: 0
+
+  i3c-od-scl-hi-period-ns:
+    description: |
+      The i3c open drain frequency is 1MHz by default.
+      If need to use different frequency, specify the clock high/low period directly.
+      i3c-od-scl-hi-perios-ns specifies the high period ns of the SCL clock cycle in open drain mode.
+      When i3c-od-scl-hi-period-ns and i3c-od-scl-lo-period-ns are specified, the i3c od frequency is
+      decided by these two properties.
+      i3c-od-scl-hi-period-ns should be equal to i3c-pp-scl-hi-period-ns or i3c-od-scl-lo-period-ns.
+
+  i3c-od-scl-lo-period-ns:
+    description: |
+      The low period ns of the SCL clock cycle in open drain mode. i3c-od-scl-lo-period-ns should be
+      multiple of i3c-pp-scl-hi-period-ns.
+
+  enable-hj:
+    type: boolean
+    description: |
+      Enable SLVSTART interrupt for receiving hot-join request.
+
+  use-dma:
+    type: boolean
+    description: |
+      Enable the i3c private transfers using DMA.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: true
+
+examples:
+  - |
+    i3c@fff10000 {
+        compatible = "nuvoton,npcm845-i3c";
+        clocks = <&clk 4>, <&clk 26>;
+        clock-names = "pclk", "fast_clk";
+        interrupts = <0 224 4>;
+        reg = <0xfff10000 0x1000>,
+              <0xf0850000 0x1000>,
+              <0xf0800300 0x4>;
+        reg-names = "i3c", "dma", "dma_ctl";
+        resets = <&rstc 0x74 8>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };
-- 
2.34.1


