Return-Path: <linux-kernel+bounces-575569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03AA70441
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7CE173EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E0A25BAD7;
	Tue, 25 Mar 2025 14:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoDcS+aA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE825A62E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914177; cv=none; b=LzDww/ThN3k0+56HhfgymXJSyOoK+Qt8SAz33MocsA8dMEoya6OrZXfWrdzueAqG5451B2athaV9DtEwKTz+8LFRjdidplfcR3Ed4DV4HXpcY+UmVpZBcyE/T47PbTaMIoacWSkMxey3npP0iqG8OQHXJVXewOomU7jvHS1n7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914177; c=relaxed/simple;
	bh=4h90l3uCKnzIWFZ+vJClR6va3K7yLEzxfMXFVnVjwgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2eWmOUWwHwJgyF7Us1irIOxB+cdG4b1qQ9+Hp5UVV+xmaU1pgUOYHX52QVc476+xHdg5Cb6uJXVQbPTG9hLSqdBJ49WOIuaQHv8UCobl8RUN0MxkxtheCzI5yDO+fBTUyDBjLX2LDMjYRnwamnGZP5HoeGvt7FB9/mdW6VlpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XoDcS+aA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so39791275e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742914173; x=1743518973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SxNSfKs3qjdQU1MDAWHJDUTKqSXIO9sYXN3sPNJ2EKI=;
        b=XoDcS+aA7dgZ/en6ymKq3TUmfBRVx5r6EmU3xKdX47DlrwPb/kegbiQnqBJpXGStz5
         PurqGLLf7o9Lv/Akj+cniNvL0PbqbDPSLvkJrBL5xyp0r5ESx66HjLsN8A7FAQO1n+Le
         9r5GZRD39MP+TOC9NRs0rQBPBaBCQ5vR8/RtdnT2uDZMT8rOJvOx+mjs7cK7Y0ujNKZd
         fcFw1JFxaLSJoDw2ZlUtfqNW0O1AdIgTwuiiOMeFQvXaeucAgEcDujBglZ14oCk9FkdH
         7xwgq+Efi1EZmohqo4cxySPW0IHj9doyyMEvump1h2+utg/VAFWi141l2cwMtUnAAX+I
         riSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742914173; x=1743518973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxNSfKs3qjdQU1MDAWHJDUTKqSXIO9sYXN3sPNJ2EKI=;
        b=fDPRIedvvvhM01OqQiaZVKbXtsvG8bpw/MJw5VFVjt86vDpM6DIWQZwcXMNqO7Gm8v
         aLT98gLm2L73OFjYQ6FylheUoOnh3qdWdI7ZAWL5IgnRPm5AYDyR49MAdgh0Yfddi9oB
         rxmh/yENxHNwzq7kWtGuwlqZn4hhveFZcq06+GbgjDt80ts8RMtZ6hnpoZ5lWCrao+Fy
         DHnhKK9ZlO8ZD6HILBLoBe9GVJv57jnpgmR0CZ5TgCimc4VOhV7l/qW8DVADbZKCRFk9
         9FbXMYNNK26HhSpaD4UZh/RvnBqdZO56DQwALXQA7O8sbCDa7k44I1zBtQPIjCj3Zxuc
         GjFg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ2Dr2ScjEG1sAsLOlyVwNIq9Idkvmi/Xh/XLzlz1105rhWUIzsLIiEytrcHVj/+QrUrquonqvdGX2omI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhH8M7w6d4bonV4nzbvl3Ttwj7iJYq5tSxbJnqEdHjJTsc7Zjl
	bnFxm4tH7lvBbCp4NeW5sqQxn5kTHXqyaDgIC+ccfAnUqLFYaYPr6rXhsGf3G7E=
X-Gm-Gg: ASbGnctByizKnWSO3wB+6jha+29Ecbm71DdSNOVIs1Lybq/Naakh99m7qFMi17+pA9S
	3LL3UK0ifR6gjPVXxZ4mVvaOQZKq1OO4yg7jmMYZoGBg0SsC9d1QcF+z+IHraL0ECgu7fNdJf7n
	vPXckqHaHAQgrzdSBdnugFw/gmm2XaZAiFkVO27elWfVOXAzM6VrbTcqruOIq+LGfVUZQrKV8cz
	JhYTyZ26ZpaBoGPEGyLQoXKLHs//Ot/IMmiHsvhNqt+/Dsn4yQkmvN0pky679TePzjsVDSEFvxm
	qWd+lEUHa050umSHQUluBpXKzA0DQP9Cy7S+sls3LrtxN6DPBwAgERd96tI8qMZJ8aj0OK1Yqdk
	jyUuq8//m9g==
X-Google-Smtp-Source: AGHT+IG4CKp1FZaRLBixTMuTyKNtj56FAP2yubtmsAabtieb/14MG43qeHYB8FO5lYDNkcZHx6+TIA==
X-Received: by 2002:a05:6000:1448:b0:391:253b:405d with SMTP id ffacd0b85a97d-3997f933da0mr16760940f8f.41.1742914172633;
        Tue, 25 Mar 2025 07:49:32 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm13796071f8f.25.2025.03.25.07.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:49:32 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 25 Mar 2025 14:49:28 +0000
Subject: [PATCH v2 1/2] media: dt-bindings: Add OmniVision OV02E10
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-media-comitters-next-25-03-13-ov02e10-v2-1-4d933ac8cff6@linaro.org>
References: <20250325-b4-media-comitters-next-25-03-13-ov02e10-v2-0-4d933ac8cff6@linaro.org>
In-Reply-To: <20250325-b4-media-comitters-next-25-03-13-ov02e10-v2-0-4d933ac8cff6@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
Cc: Jingjing Xiong <jingjing.xiong@intel.com>, Hao Yao <hao.yao@intel.com>, 
 Jim Lai <jim.lai@intel.com>, You-Sheng Yang <vicamo.yang@canonical.com>, 
 Alan Stern <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2

Add bindings for OVO2E10 a two lane MIPI CSI, two megapixel 1080p RGB sensor.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/i2c/ovti,ov02e10.yaml           | 113 +++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov02e10.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov02e10.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..4ac4e11a16c8bb7a53db0c44289b1004dbdc282a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov02e10.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2025 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov02e10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV02E10 CMOS Sensor
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  The Omnivision OV02E10 is a 2 megapixel, CMOS image sensor which supports:
+  - Automatic black level calibration (ABLC)
+  - Programmable controls for frame rate, mirror and flip, binning, cropping
+    and windowing
+  - Output formats 10-bit 4C RGB RAW, 10-bit Bayer RAW
+  - 2-lane MIPI D-PHY TX @ 720 Mbps per lane
+  - Dynamic defect pixel cancellation
+  - Standard SCCB command interface
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: ovti,ov02e10
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  avdd-supply:
+    description: Analogue circuit voltage supply.
+
+  dovdd-supply:
+    description: I/O circuit voltage supply.
+
+  dvdd-supply:
+    description: Digital circuit voltage supply.
+
+  reset-gpios:
+    description: Active low GPIO connected to XSHUTDOWN pad of the sensor.
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        $ref: /schemas/media/video-interfaces.yaml#
+        additionalProperties: false
+
+        properties:
+          data-lanes:
+            items:
+              - const: 1
+              - const: 2
+          link-frequencies: true
+          remote-endpoint: true
+
+        required:
+          - data-lanes
+          - link-frequencies
+          - remote-endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ov02e10: camera@10 {
+            compatible = "ovti,ov02e10";
+            reg = <0x10>;
+
+            reset-gpios = <&tlmm 237 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&cam_rgb_defaultt>;
+
+            clocks = <&ov02e10_clk>;
+
+            assigned-clocks = <&ov02e10_clk>;
+            assigned-clock-parents = <&ov02e10_clk_parent>;
+            assigned-clock-rates = <19200000>;
+
+            avdd-supply = <&vreg_l7b_2p8>;
+            dvdd-supply = <&vreg_l7b_1p8>;
+            dovdd-supply = <&vreg_l3m_1p8>;
+
+            port {
+                ov02e10_ep: endpoint {
+                    remote-endpoint = <&csiphy4_ep>;
+                    data-lanes = <1 2>;
+                    link-frequencies = /bits/ 64 <400000000>;
+                };
+            };
+        };
+    };
+...

-- 
2.49.0


