Return-Path: <linux-kernel+bounces-577202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3CAA719C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DDD17730E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41435968;
	Wed, 26 Mar 2025 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yd9ZfB9n"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAB129A78
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001282; cv=none; b=V6iFhoRpta2m5p/4yYLcsIg0ia1p9gZwokFCgtzca3bAkcO1notCdxXIKS29GiV6hwMBMvCm3l45WOkaHP2l2ZMjbm9TftIB1u3OC8GRh82q6MDAXyityrc3aPf7vRWHxR5Qdq+ZYfXz6CCWSECMOp3K/HcTCDxQ8+iutL70ZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001282; c=relaxed/simple;
	bh=dEEHMCaZuBhSVR8548s7dYibu0O+KizI9ENpYjHaHN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT2DQ7XM1md2pZOmw7vyxQoBj4DYaNxOtqdGkI6fZPjt0z/ZiKuuaO21W4UN8m8ZSfpEFc487x8/R/wOkeWy3lwGGQ/COkh+jPBnrrfgBBwSNrRBi3R54p6O+f7KnRmuWE+FsruKgxDVXNXHyg0W6IAwqimACDXSBXFYX+EA2rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yd9ZfB9n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso68571855e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743001278; x=1743606078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUwLKknfTenPDH0/Fy4kPfAbwbk8wFgm9qaIXqrjO4M=;
        b=yd9ZfB9nTXF5wq5BzojMmTUBfYVcZPSydrXn7BZwepclNK+VO5sbw55NN/oYckfGps
         FcftaAjLax/y/mPc667QZphb0UvPocLrCqBlaYAAuCs3gB/WwDd7ActX5PVi08vCbxyq
         pRmOY+DuiPQSiZJIPT+xWUxbw3beMHrpzZaOZq3aLH9P20GHPG3ls4gqwag0gkw/m6ye
         QP/Wq2bIhwBBgr48+bCmXWHxQgyKCRv4knNPwekULsHkWZieukrHL1IWGNED6KdWMzu/
         GiuX8Iybqu6+aZMr7VsNQAoE54X3k9ggve472s06VagRgU3yvtzVP57vbMZiLtmeLjmp
         dttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001278; x=1743606078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUwLKknfTenPDH0/Fy4kPfAbwbk8wFgm9qaIXqrjO4M=;
        b=qm7gvM3ERIRj3mHeAhelBus7ZLK96GGnHEFSTnoyfkS5Ij3TSY8iBdD8i1U3t+O/C7
         nNSfLWGJTT/Noyk3sd/GmIDfhzCAFEdE5fGXPHa4+Faa95PQzIFr4503UvecGKmZGyKl
         9i3+y6TwGRPK7tJk8+hOditURn+tchk/exbiMtm1O2uLMNpgN8sWEe3g4ycJjYpErz7h
         eGQqIgh4TZWKW1eyDX1tUtcmaVbsW9a05fvkIE2+JOCJsBjWdvKQfgrTLGrBb/xsrnSh
         mWinKisrjpRDgWXPfBk/ctdpuajdojQsMCFtxICMT0EP+Yaxfs3DwSjsauf9iWbh3Sl4
         cVYw==
X-Forwarded-Encrypted: i=1; AJvYcCXMNFAWvInWtu12J0+WmijumjvAVnJqwyEwAKwmO9Jfijv7OXRVmR35VZZOXfw59AJ7MOb/97aqVXOizh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrazTUWehn1fW1xO8j/ecIDpp5MN0L0kAv21iuu5GTMveFd/Pa
	3y2fdkKMQkh4due86b/qLQcNwiudbtVvZUmsUtsxnvfZYPGA7K9yjjp99yonBNk=
X-Gm-Gg: ASbGnct/xhX0jCqkeC3kWAQwdydYIsltKDUCa8xtJo6qnMPIkzRpo/8LoY0tBynPek0
	kdTwdSTlQ0s+XWs417H03W8aXCI6WnUB/LG/bEVRZ1Cxo+iS35Lif8yrsqwDcnkGIiQ91kDAJmn
	85WLvNbBBGA88dgBySidPKZP8IQQtYPLStbg+5DHEwbQ/F9jXiFZ+4j2B6//hKiwM09ldpd5tNM
	ZYjWIE07C/ko7+A31nsSXwcai/wr2dWyRP2WHZjn24ErcIGHVopVW7owZY5dPdX4m2rd9EzTGdB
	wbLK/M73qyAiHc25WuGOGul6BhazT/wp/RSAJScee1dllyQpIQOF/himF3VLEwg/rKIx1GRPGX5
	HfdtfICbKtxIvBTcVNC6UEtr1
X-Google-Smtp-Source: AGHT+IFwJbRy2F6SHfurVSyLZ4rU1yis69Di0l4fXOHSEYK7xg2ZdnkrHcG3ZwZ/nzU4Utk7RDBoaw==
X-Received: by 2002:a5d:5f8b:0:b0:38f:231a:635e with SMTP id ffacd0b85a97d-3997f912722mr19224217f8f.25.1743001277560;
        Wed, 26 Mar 2025 08:01:17 -0700 (PDT)
Received: from inspiron14p-linux.ht.home (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm17408125f8f.35.2025.03.26.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 08:01:16 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To: robh@kernel.org,
	hdegoede@redhat.com,
	mchehab@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	sakari.ailus@linux.intel.com,
	hverkuil@xs4all.nl
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bod@kernel.org,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH] media: dt-bindings: Add OmniVision OV02C10
Date: Wed, 26 Mar 2025 15:01:14 +0000
Message-ID: <20250326150114.71401-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324171508.GA668235-robh@kernel.org>
References: <20250324171508.GA668235-robh@kernel.org>
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
 .../bindings/media/i2c/ovti,ov02c10.yaml      | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml
new file mode 100644
index 000000000000..8cd174075d52
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov02c10.yaml
@@ -0,0 +1,115 @@
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
+            minItems: 1
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


