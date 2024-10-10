Return-Path: <linux-kernel+bounces-358994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931E99861B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65231F21BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062901C6F68;
	Thu, 10 Oct 2024 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tOUKZjjY"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835321C1AD9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563605; cv=none; b=PfL+1AM5JcUhjJjzTP9soy8nFXM95QgCLjTJmdC3NuLyzej1vac3vrzal0JSwg2RVP/CUdN/ZPSggqepJ5l4yVtqar1xn72ps66DOl9LzcQKzSuAv6jtZC1hxez0RkX6Ui6bxNN6Fqk1L7PJ7GPng88n6Ixk1lbyiEUyhDqjODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563605; c=relaxed/simple;
	bh=fCv2ql3x5MRYj+V94Droy/AZAMcQ97gJ5jPEcJz0y8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l/Ze7rauNg0By+5gP0t2ePzYbMUZoL9vpV/ibKyraFtTT8cTP3gW0CNkg+S8ioSrMCVqIq/A0yHb2kw/2esHztn6F2fof7E+7iPn5iWMX9YM29S7cMkClI8NrZf0SgcydoTUgzRhaC65bNDZzIKFBDGzn1DaJTSJYZx+cpFFRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tOUKZjjY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99543ab209so120554166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728563602; x=1729168402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCl/oQotG7Ck6NtzjioXPnOyFASYLcPzzgeAry7FXvU=;
        b=tOUKZjjYtIa54LTxqTIkiLk+S9Rccq6e7HiciRFh+Q8kyEL5KvvKJlzCJ+//jdCM1i
         HuruiQubn2wtSj4oEPoryoBsmLFUBXn0yFzXZNir7vu9+PGoUXaYA8GfWunKCawjVegR
         A80uN+BdexxJQIQoa/iPqZzyb+QDYvsNk5uFXKP5OI7MJ+ag0r9ggzPaLApiOjkD7gTT
         D3k2PILwjKBOS86qY8vdwsHpp2bmlVuW1qe2XRr8V4F+yWXm2LARgmXl3SGusVbqMYQx
         zu1opxXBH0fam6T1Sq1TeYdofOIWDzRDH2dzcf+QxBSP735juoTdUE9bhstEwBsTF7fX
         93rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563602; x=1729168402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCl/oQotG7Ck6NtzjioXPnOyFASYLcPzzgeAry7FXvU=;
        b=kEaDNV0cvhyhwIy5fAdd1dU1vN6QTK5zUbX81Bpd5oXW/M3Yfs/yfWKjDbRdQoR2j9
         jAYSIrPQN69STpqjHCZ3hUpAnRneVDOi0ePk05Z7vvmeSY3bQQc0FKzBQMcZ3vjx0dX1
         XdYdXWvRpfqVzQwBrxmPvMdOrrWKttb9DngiUuRIoLmqD6Ceeg/navHKvEIBBzyxbV1j
         CS2/lhZ4BlybOB6GFhsqj4XbG7uDbHJpWXJCafy95jke9iaUgBr8ccq3Fq270CUUrOFw
         R8fGMMwiJ4vNKJ7bUQdYq5ZfXy2dSpqQJvRKsIhQCEhIK0+9j/LdLfVNzfSkxxol0+Fr
         0rcA==
X-Forwarded-Encrypted: i=1; AJvYcCUtIbveOZQ+qFz8GmH1z5pI+mIlNQMNQD7MmnY+G0TuPrYYkUsFTTLVnVlO12oAR7b13roKP2I+X9eWmeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLdwy1EvnioNeMoxIoz1JjNqup72az5wor0YjMcQbe/D3G1fYU
	JHY1dOK1ngckQ6teH3zeNdeNopvKDwPElFY9c+1Qh56OyZhnR54jemeB8WlTyKc=
X-Google-Smtp-Source: AGHT+IEN8tvLkNd2SXFiSFvvdTshSPJa0h2Z7P/ZCsSDK9uL+ad6NWD80/M3p3V1zOus1/1nyuyRDg==
X-Received: by 2002:a17:907:60d6:b0:a99:4982:da46 with SMTP id a640c23a62f3a-a998d3299a8mr448933766b.63.1728563601693;
        Thu, 10 Oct 2024 05:33:21 -0700 (PDT)
Received: from [127.0.0.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80c0723sm82416666b.135.2024.10.10.05.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:33:21 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Thu, 10 Oct 2024 13:33:18 +0100
Subject: [PATCH v6 2/4] media: dt-bindings: Add OmniVision OV08X40
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-b4-master-24-11-25-ov08x40-v6-2-cf966e34e685@linaro.org>
References: <20241010-b4-master-24-11-25-ov08x40-v6-0-cf966e34e685@linaro.org>
In-Reply-To: <20241010-b4-master-24-11-25-ov08x40-v6-0-cf966e34e685@linaro.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Jason Chen <jason.z.chen@intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-dedf8

Add bindings for the already upstream OV08X40 to enable usage of this
sensor on DTS based systems.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/media/i2c/ovti,ov08x40.yaml           | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov08x40.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov08x40.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..552efdf8934f73f8f202f5555351f1123b91a252
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov08x40.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2024 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ovti,ov08x40.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV08X40 CMOS Sensor
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  The Omnivision OV08X40 is a 9.2 megapixel, CMOS image sensor which supports:
+  - Automatic black level calibration (ABLC)
+  - Programmable controls for frame rate, mirror and flip, binning, cropping
+    and windowing
+  - Output formats 10-bit 4C RGB RAW, 10-bit Bayer RAW
+  - 4-lane MIPI D-PHY TX @ 1 Gbps per lane
+  - 2-lane MPIP D-PHY TX @ 2 Gbps per lane
+  - Dynamic defect pixel cancellation
+  - Standard SCCB command interface
+
+allOf:
+  - $ref: /schemas/media/video-interface-devices.yaml#
+
+properties:
+  compatible:
+    const: ovti,ov08x40
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
+                  - const: 2
+              - items:
+                  - const: 1
+                  - const: 2
+                  - const: 3
+                  - const: 4
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
+        ov08x40: camera@36 {
+            compatible = "ovti,ov08x40";
+            reg = <0x36>;
+
+            reset-gpios = <&tlmm 111 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&cam_rgb_defaultt>;
+
+            clocks = <&ov08x40_clk>;
+
+            assigned-clocks = <&ov08x40_clk>;
+            assigned-clock-parents = <&ov08x40_clk_parent>;
+            assigned-clock-rates = <19200000>;
+
+            avdd-supply = <&vreg_l7b_2p8>;
+            dvdd-supply = <&vreg_l7b_1p8>;
+            dovdd-supply = <&vreg_l3m_1p8>;
+
+            port {
+                ov08x40_ep: endpoint {
+                    remote-endpoint = <&csiphy4_ep>;
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <400000000>;
+                };
+            };
+        };
+    };
+...

-- 
2.46.2


