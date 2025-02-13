Return-Path: <linux-kernel+bounces-513043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C4BA340F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D3916AEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C800D2222D3;
	Thu, 13 Feb 2025 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgFTW3VU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5824BBE0;
	Thu, 13 Feb 2025 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455003; cv=none; b=ZegdpDrvpWAqCuKYCtMsMkQqcA99QGp/bZZAHndJSZPuJhzrNcyYoRXpwHHPVVqCd6ewwTx+2OUy9r1yfFOpNwX/NBCLxdjBNu1NxtPixDSO5KBBZVgeomlqvsXbO3o044tvsaWJezY7VCb451Z+RruxYPn679VfePD7eBg0dy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455003; c=relaxed/simple;
	bh=MjbfY61IU0YUEm7VqTwHxj+rCjCkApQN3mOQK0DAL34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMLF2wH7mWMCTsJyvdI8bhRvFpBGHmfSyGAdnkpTzxcUj1nPJUaWpi7sC4gveSvo1K9U2MCOXrnEJhvr4QRiZo9yz8w2lFvERbiu21JncKOI7b1TJ9PaAugDpEl8PIj6rjT0SU/2MDzmRclVQ4JdqnYZ5IR7bb+wto3h2nkKd9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgFTW3VU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-54509f46614so896862e87.0;
        Thu, 13 Feb 2025 05:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739454999; x=1740059799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1IGkQScRodOBygrIsMSnLoiENI5KM9I94X/GE+75SU=;
        b=IgFTW3VUoGra4JzCs/phe+2ZBekGCX5d6ybAaKMUBTW7L0Hftahf4ysFSBp+yo37Bs
         a/mLFCL8aYzl/7vQjy5y6llDL/WE4Ulutu4l0UXy3WN5zFNN0htelMutFbmr8C+tIP5H
         c+YStMWcSMxm3u5PwCe6cLldOEE5JHNErrztNZlo7ZahAbnZyEFB3IxM6bw8IIrk3kFV
         /URUO4osDyo/0dLAsg5gwE6/+8S6zdveK5pf21P7Hbi9ejWmhyPZVswd0/T6BursnHSQ
         101pUJXdQVbtk6XkZh4fy3eaKUhQgpIe9lFcXDXZHmcJECLHzUmdvwn1ZdJpyrWhUs2i
         wrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454999; x=1740059799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1IGkQScRodOBygrIsMSnLoiENI5KM9I94X/GE+75SU=;
        b=GPOf6cVqpDfbyPVOUij0gFv5qSh14jj6LIEn5h9LdU3i6mjb8to//U8Tye8KQU+Vmt
         x0hWwpPVrGgTrDnglQ2S/GRH9FqIM7V1kH+OAlpt64isjsGZKSiNhmbcGDFQF3FfCytG
         is3C2AaagUcvxSrUMgzGxFYaxx+i+H8N7wqIYeuZwXKghmWr1/NQ7raftRPsZv1ZDQ4p
         ldmUE9BdrhkITxeWSIDKFbpT0+qGjzWVP4uhhKa2JSDeYOJfWEFBYgtOQ2JrwEYj/E+k
         a8ZcMTRPpPF2Reig7RhlrdNB1N+sAY1itfy9RifL2IF/U+tANn2d/XqM35PHAnTScg6d
         6w4A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9onLUzVCl4a6bULjHjt49rkANlmi/ZFc9gk5f9ot7gmhzQir/UBix51eG0IP1lIR+oZekhgquah4@vger.kernel.org, AJvYcCW8MM3MhG/9N8UmvYVGhUUMT9LiwgALCa7NlsuTTXhiDczhdMtKknX8hHuz/gxCL2KFftqQ6MU0q/fOaKOx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JEeejZKBlpeP4jXVkpLfkdRT0aYIZuLndPD8S+y3pZpo76mc
	HdPjdTvDzOb0H8gwDW17pcAY7bzmKPEJ9NWywNS7Hq2NapKgbMGm
X-Gm-Gg: ASbGncsuKPHlwcUoFBrTtcD5AlBzsozk2CHRr044eRCW0J/zOlPhJGoCCheCAqeM96C
	pQvvwVpjMTefhoQPhAOU+FtSPuka0dKFWK2MiOa7hPNHVzxcwGOrfZgYlNbqlCTp69BivFsaS9Z
	EFsdE3mi033WSLJLaajVxohURtbZmaeotcCLZvlCs6mbM5/WdiA8Yy7h+ytaseHj4evlb6L9CKg
	4KGa0aulAKS169EDdI0PXnLtSRIdHKsMSkZRzPTb60RRQatY7xTd/k7qURKXNRsupJJXcuciXWC
	qAIGzw==
X-Google-Smtp-Source: AGHT+IEQ5oFs1ifcABBwjOpA5t4U65S3XXvUcxsC19cuCWeiLav/s9wwWL2jOoOY4wqwjyi0rQBVhA==
X-Received: by 2002:a05:6512:3d0d:b0:545:d7d:ac4a with SMTP id 2adb3069b0e04-545181771d1mr2208375e87.36.1739454998935;
        Thu, 13 Feb 2025 05:56:38 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f105cdcsm177789e87.116.2025.02.13.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:56:38 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: display: bridge: Document Solomon SSD2825
Date: Thu, 13 Feb 2025 15:56:04 +0200
Message-ID: <20250213135605.157650-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213135605.157650-1-clamor95@gmail.com>
References: <20250213135605.157650-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for Solomon SSD2825 MIPI master bridge chip that connects an
application processor with traditional parallel LCD interface and an LCD
driver with MIPI slave interface. The SSD2825 supports both parallel RGB
interface and serial SPI interface.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/bridge/solomon,ssd2825.yaml       | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
new file mode 100644
index 000000000000..cd7ff971495c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/solomon,ssd2825.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/solomon,ssd2825.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD2825 RGB to MIPI-DSI bridge
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: solomon,ssd2825
+
+  reg:
+    maxItems: 1
+
+  reset-gpios: true
+
+  dvdd-supply:
+    description: Regulator for 1.2V digital power supply.
+
+  avdd-supply:
+    description: Regulator for 1.2V analog power supply.
+
+  vddio-supply:
+    description: Regulator for 1.8V IO power supply.
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  spi-cpha: true
+  spi-cpol: true
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: tx_clk
+
+  solomon,hs-zero-delay-ns:
+    description:
+      HS zero delay period
+    default: 133
+
+  solomon,hs-prep-delay-ns:
+    description:
+      HS prep delay period
+    default: 40
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Video port for RGB input
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              bus-width:
+                enum: [ 16, 18, 24 ]
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Video port for DSI output (panel or connector)
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dsi@2 {
+            compatible = "solomon,ssd2825";
+            reg = <2>;
+
+            spi-max-frequency = <1000000>;
+
+            spi-cpha;
+            spi-cpol;
+
+            reset-gpios = <&gpio 114 GPIO_ACTIVE_LOW>;
+
+            dvdd-supply = <&vdd_1v2>;
+            avdd-supply = <&vdd_1v2>;
+            vddio-supply = <&vdd_1v8_io>;
+
+            solomon,hs-zero-delay-ns = <300>;
+            solomon,hs-prep-delay-ns = <65>;
+
+            clocks = <&ssd2825_tx_clk>;
+            clock-names = "tx_clk";
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    bridge_input: endpoint {
+                        remote-endpoint = <&dpi_output>;
+                        bus-width = <24>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    bridge_output: endpoint {
+                        remote-endpoint = <&panel_input>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.43.0


