Return-Path: <linux-kernel+bounces-573061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E660FA6D283
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5791892421
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 00:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBB2907;
	Mon, 24 Mar 2025 00:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOU0RtbS"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F1367
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742774960; cv=none; b=aZhRIi7n9UZSvFurML262VPsRv/PABDWNbM5pHrsopQMqQtqpY8zT1T9pFTroduT1loGIePqT5v2GWxUYwQZZ1WOMiyAfW2qAf/P9C53Jqu2OkSMf6rDwdDuGIcUQ2GHVhQl/s5wkm8B+qlzlCOgTuj3pvWoOJQU2lQDp3/gdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742774960; c=relaxed/simple;
	bh=xG7KMDmzZFEzMN+AkPk2HVIMj7xs9rXBgCDJ/MFJG+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQ8VGqLqAZRmHb7i2EsBrdBNwj4jANftOmkF399sKgtXzl6HQjJAwcAAqHV6m/VeiQGsIvZQLeGCG+Myjq7vto2VP+EQkqbphweVMUtrRIfrb8CXfQIIQM2Vk3xoD5yQfIZo1NTNgIDX+cUL6jIs0AzI4R4tLI9JrKeOdyLFjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOU0RtbS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so35381465e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742774957; x=1743379757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4Yw/yIFJwPSRIFaWhDguD+3BszBLpL7OesKcw5YFc8=;
        b=WOU0RtbShGEeZvX4arWxIpH7nywv9kzFESLG2OsdEBgE3VwNxq2Lnll6uE7ws3zGhq
         tva4WGopmk0rv7bGn98BvC6ev4zIv3zH+BDjTpevl3aWY5CYOajUBrH3+En3DSuSpU47
         oMA7DbQ7ftD93gWrGuNDFHLweLtWivPZs/Vw2PvKQ37qi0OIUDyiVE9wjURmwr2Kx3jw
         bL0ZosCoazfCzne0ABNtOD8AIg/qnmFPX2RgKJ0MfDVgXyDPAMsmK8QlTqf4sCE2yVBm
         28e8Bs6ZB+vGqhpk5lfwKNS+TR6SBMkWzREpPwt9hhSuBEsbTgYZzVirSd+3Z5yzp3vb
         F0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742774957; x=1743379757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4Yw/yIFJwPSRIFaWhDguD+3BszBLpL7OesKcw5YFc8=;
        b=Y2KkX4iAf1rQI/cG+bfAwkvnij5vGB5BZSk1qw1MuhLJG3Fk1rG4rAC8bIrgMNEbV6
         b50INZ1508i/E+PHCzmVx4V1sgcRoqAk+TiQxbl/IYvP4l/JQOItzYPwZ0W3SS6DGZQD
         t00am2J7x5qkkbV67DLd8OIITPKajPUhthEPCZubjwmYF2dLBj1wa61wbJ1196TBAz7R
         3i16PiSTwI0Nlax+iJNCa3OpzJMKKybUjvrK5tkbF0ONjg7F6AKN2xyExpGHAk22SVAV
         X1BdWS75xIa6h7NbfoBMyF6L3j1bsMBOalGmkYYV8xBB3b77EPy3Cs/3gw7PxeRju0r8
         Hm1g==
X-Forwarded-Encrypted: i=1; AJvYcCWwWsEt/82L0nki6MBmIwYchofSyIVtuhq04fjBcMjkWdz5YtG3rEbHotW9kqtKIAJDWhSRogfCGG5m8do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfAYxAiL224v/qewVhCXgb2DEfRq8OBioQ0eqNlkc+n/HeEUHp
	gUQ7Am5j6K/PwwHmVKhC5pciFGUffTzr/R1iNZ4nzjv2Wt7L2kvTJNwk2O/YBrY=
X-Gm-Gg: ASbGncujT9BezjSB3pIflnSCZQq7cd1R9QW8ytRMCgTz8JqRqEJTTW+wgBnl5bQFPsN
	fmJczlDFs7SGUFJr762IhN0Lckyz6WcLQwzpTCMWN02ltIJ6B3podQ+95GKGK3UAYLB4T2yYNOC
	cEZYkWaNKi2NxemvVSidQseLIUxCZHutCB5q1EKgTR09b7V42eolYceULbac5g3K6oTV6F+smv/
	xZJ4tbMrIfFqK86ZrJce41lVGnS7Xd9nM+YsdPMGM8Q+HZcsW5NC/EEjlTbGisolUKMUHvEmUPI
	RqtCrxnK0P4muTxHeAY0nDiA5gsVXBtqN/dRYtODZxrEZKGapgsAvSoejRTA0HFAmPdRwYlq1ad
	bDTimVgQGQMHbRFv36h6qgYd7
X-Google-Smtp-Source: AGHT+IGY7VtMpwcOgN7vWpF0VeukoOJo86n8xPqYGzuZ9slPTAXMmzoVR8afEL0XrlDXByZw4H9iNw==
X-Received: by 2002:a5d:6c63:0:b0:38d:e304:7470 with SMTP id ffacd0b85a97d-3997f90aa79mr10650444f8f.25.1742774956693;
        Sun, 23 Mar 2025 17:09:16 -0700 (PDT)
Received: from inspiron14p-linux.ht.home (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea6ecsm103160875e9.5.2025.03.23.17.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 17:09:16 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sakari.ailus@linux.intel.com,
	hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 1/1] media: dt-bindings: Add OmniVision OV02C10
Date: Mon, 24 Mar 2025 00:09:12 +0000
Message-ID: <20250324000912.105662-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324000912.105662-1-bryan.odonoghue@linaro.org>
References: <20250319145927.70534-1-hdegoede@redhat.com>
 <20250324000912.105662-1-bryan.odonoghue@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for OVO2C10 a two megapixel 1080p RGB sensor.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/i2c/ovti,ov02c10.yaml      | 117 ++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml
new file mode 100644
index 000000000000..6380a17fe65f
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2025 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov02c10.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV02C10 CMOS Sensor
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  The Omnivision OV02C10 is a 2 megapixel, CMOS image sensor which supports:
+  - Automatic black level calibration (ABLC)
+  - Programmable controls for frame rate, mirror and flip, binning, cropping
+    and windowing
+  - Output formats 10-bit 4C RGB RAW, 10-bit Bayer RAW
+  - 2-lane MIPI D-PHY TX @ 800 Mbps per lane
+  - 1-lane MIPI D-PHY TX @ 1.5 Gbps per lane
+  - Dynamic defect pixel cancellation
+  - Standard SCCB command interface
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: ovti,ov02c10
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
+            oneOf:
+              - items:
+                  - const: 1
+              - items:
+                  - const: 1
+                  - const: 2
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
+        ov02c10: camera@36 {
+            compatible = "ovti,ov02c10";
+            reg = <0x36>;
+
+            reset-gpios = <&tlmm 237 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&cam_rgb_defaultt>;
+
+            clocks = <&ov02c10_clk>;
+
+            assigned-clocks = <&ov02c10_clk>;
+            assigned-clock-parents = <&ov02c10_clk_parent>;
+            assigned-clock-rates = <19200000>;
+
+            avdd-supply = <&vreg_l7b_2p8>;
+            dvdd-supply = <&vreg_l7b_1p8>;
+            dovdd-supply = <&vreg_l3m_1p8>;
+
+            port {
+                ov02c10_ep: endpoint {
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


