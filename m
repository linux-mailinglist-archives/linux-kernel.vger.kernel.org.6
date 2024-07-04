Return-Path: <linux-kernel+bounces-241553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D91E3927C80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633BC1F23DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223D976050;
	Thu,  4 Jul 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwRFOQ4O"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A539FC1;
	Thu,  4 Jul 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115340; cv=none; b=gzAai+LHpM8cYy3FYYx7lCziTofB5aFSbshzz4nTwnkYO/NyUxcn3QX3XOIvLaJJn6ODRQiSZI9fOJEkoLU6usbq7X3njF8Bmi1f5ytFkb8VAiVtwOZMdKhSMSLczoq296mXFuRKCV2GbZWR/U+cpxkJ4r4zSuMMQuKPLi2FDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115340; c=relaxed/simple;
	bh=uqplsOTQD0aDmJIIHhCufLbiJywZFMWrn86Eurr6R7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nRD/HS6/jIIBM6RUZJ2EC8O/rSXAcZCPuPOLPLG2gYEIeFZd21H5U5xGWL7KEvUQfDqX8vIhvc0cFV3frEYlySEl6eVeXEBjCHZOad0ig53Aolob7fVQEPcckbKNBi18s/LVLrk4TUL+p3FkAUU4pZmE3RWuJfeUpnwpKUT9T/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwRFOQ4O; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso5919285e9.0;
        Thu, 04 Jul 2024 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115337; x=1720720137; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnbdFOdtX9oRPijliWDcGViUxTAdc58rewNdsige5wE=;
        b=JwRFOQ4OPEA1Oj4Mc5hr6aGZDPaAAU4Uyj31lNalJjom4V8VIr8LVwKajhqDZN/BxW
         5GPnDgzHnb8ruBSCDDF/vMrxl0X14sG4GghQpzc1hKKqHGHNy+mld/B3OVjTNCwT3JQm
         8hy9u11LD90ZIApbQhTUscfVWXCoW01ugOaTki/v/AxI7M+YeJjxK4sL0CEUWZoIemvN
         Y+DR64yRYVfxSvFevwdKsC8RHV6x0FTHbvlaXTE/Xqtb0asQh5ZmAxP+se9bjiWqJE4F
         e+5CKL4+fQ7ot4TQCfepX6WXSWHEm9Q4oFy3EDIAVUWR6vQVb7+vM2AtdiVaaVz3jEjH
         xN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115337; x=1720720137;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnbdFOdtX9oRPijliWDcGViUxTAdc58rewNdsige5wE=;
        b=dz4fOZ8Lfo+r0qHMvsIT0ve/r2oAUvgVsvolfBwEcyII397JR7Ws4zixn3f8c5lccq
         LtQtu7A5X7Rxytr13Ph9l9vs1orpVYiXGPG7RHii+xgFUrxj7pArKI4T5EvT8oI5fmyM
         LinCBYV8PQZeH40i55YPCPrb1VJd/6GEb0RwlLljm+0RENukgGap0D0W34A6bUqlnv0z
         KIK/KboQDMctLuqrSj9ypMC4C7ijq2fd420RrLfGb/ZR0fl5VmMWQzSGa0CRL0DYnfS/
         3OEvhkZ9y1CQVVlnJpIxM/B4+xI1lAO0H2SAWngkwnpi2bBfyL5314WM0UwhIFkK7qMg
         SkEg==
X-Forwarded-Encrypted: i=1; AJvYcCVAbCEhPRP8hxH81CjAqAiVjTi+3s76FIBDRd2331TTdfhQ0dTJ2BywR0X5W9+7Q1dNa/LpVudJtocc8NTgjWq6H6MRcBQiA47twpKO95htg37iIGR/ZbDC5qd7GMUdxKgjqbnt/UOX5A==
X-Gm-Message-State: AOJu0YwnI6H40S2FacWhz0H4hI9cxUt6njWlg2AS18RyDdGNxJ4vD8mu
	u2roagwAI8rJqXK7swUojDaOulmgADui1mQFZpjxHDFFlKtva/8D2DbfhA==
X-Google-Smtp-Source: AGHT+IGidZZbWuMOivpVaUQO5kd1ycunBxGr3awOjcXbzRXsaEA3IudY8yUHse0AZ4joD0otSjkpwQ==
X-Received: by 2002:a05:600c:2210:b0:425:624e:d80a with SMTP id 5b1f17b1804b1-4264a3e1ceamr18030295e9.24.1720115336567;
        Thu, 04 Jul 2024 10:48:56 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264b325576sm28513705e9.5.2024.07.04.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:48:56 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:48:54 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: clock: sprd,sc9860-clk: convert to YAML
Message-ID: <ZobghvwZAyMjl4eB@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC9860 clock bindings to DT schema.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
  - only allow one of reg / sprd,syscon properties

Changes in V2:
  - drop inaccurate clocks description
  - constrain clocks, reg and sprd,syscon per variant

 .../bindings/clock/sprd,sc9860-clk.txt        |  63 -------
 .../bindings/clock/sprd,sc9860-clk.yaml       | 159 ++++++++++++++++++
 2 files changed, 159 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
 create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
deleted file mode 100644
index aaaf02ca2a6a..000000000000
--- a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Spreadtrum SC9860 Clock Binding
-------------------------
-
-Required properties:
-- compatible: should contain the following compatible strings:
-	- "sprd,sc9860-pmu-gate"
-	- "sprd,sc9860-pll"
-	- "sprd,sc9860-ap-clk"
-	- "sprd,sc9860-aon-prediv"
-	- "sprd,sc9860-apahb-gate"
-	- "sprd,sc9860-aon-gate"
-	- "sprd,sc9860-aonsecure-clk"
-	- "sprd,sc9860-agcp-gate"
-	- "sprd,sc9860-gpu-clk"
-	- "sprd,sc9860-vsp-clk"
-	- "sprd,sc9860-vsp-gate"
-	- "sprd,sc9860-cam-clk"
-	- "sprd,sc9860-cam-gate"
-	- "sprd,sc9860-disp-clk"
-	- "sprd,sc9860-disp-gate"
-	- "sprd,sc9860-apapb-gate"
-
-- #clock-cells: must be 1
-
-- clocks : Should be the input parent clock(s) phandle for the clock, this
-	   property here just simply shows which clock group the clocks'
-	   parents are in, since each clk node would represent many clocks
-	   which are defined in the driver.  The detailed dependency
-	   relationship (i.e. how many parents and which are the parents)
-	   are implemented in driver code.
-
-Optional properties:
-
-- reg:	Contain the registers base address and length. It must be configured
-	only if no 'sprd,syscon' under the node.
-
-- sprd,syscon: phandle to the syscon which is in the same address area with
-	       the clock, and so we can get regmap for the clocks from the
-	       syscon device.
-
-Example:
-
-	pmu_gate: pmu-gate {
-		compatible = "sprd,sc9860-pmu-gate";
-		sprd,syscon = <&pmu_regs>;
-		clocks = <&ext_26m>;
-		#clock-cells = <1>;
-	};
-
-	pll: pll {
-		compatible = "sprd,sc9860-pll";
-		sprd,syscon = <&ana_regs>;
-		clocks = <&pmu_gate 0>;
-		#clock-cells = <1>;
-	};
-
-	ap_clk: clock-controller@20000000 {
-		compatible = "sprd,sc9860-ap-clk";
-		reg = <0 0x20000000 0 0x400>;
-		clocks = <&ext_26m>, <&pll 0>,
-			 <&pmu_gate 0>;
-		#clock-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
new file mode 100644
index 000000000000..502cd723511f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sprd,sc9860-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC9860 clock
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-agcp-gate
+      - sprd,sc9860-aonsecure-clk
+      - sprd,sc9860-aon-gate
+      - sprd,sc9860-aon-prediv
+      - sprd,sc9860-apahb-gate
+      - sprd,sc9860-apapb-gate
+      - sprd,sc9860-ap-clk
+      - sprd,sc9860-cam-clk
+      - sprd,sc9860-cam-gate
+      - sprd,sc9860-disp-clk
+      - sprd,sc9860-disp-gate
+      - sprd,sc9860-gpu-clk
+      - sprd,sc9860-pll
+      - sprd,sc9860-pmu-gate
+      - sprd,sc9860-vsp-clk
+      - sprd,sc9860-vsp-gate
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  '#clock-cells':
+    const: 1
+
+  sprd,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the syscon which is in the same address area with the
+      clock, and so we can get regmap for the clocks from the syscon device
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - sprd,sc9860-agcp-gate
+              - sprd,sc9860-aon-gate
+              - sprd,sc9860-apahb-gate
+              - sprd,sc9860-apapb-gate
+              - sprd,sc9860-cam-gate
+              - sprd,sc9860-disp-gate
+              - sprd,sc9860-gpu-clk
+              - sprd,sc9860-pll
+              - sprd,sc9860-pmu-gate
+              - sprd,sc9860-vsp-gate
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - sprd,sc9860-aonsecure-clk
+              - sprd,sc9860-cam-clk
+              - sprd,sc9860-disp-clk
+              - sprd,sc9860-vsp-clk
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - sprd,sc9860-aon-prediv
+              - sprd,sc9860-ap-clk
+    then:
+      properties:
+        clocks:
+          minItems: 3
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - sprd,sc9860-aonsecure-clk
+              - sprd,sc9860-aon-prediv
+              - sprd,sc9860-ap-clk
+              - sprd,sc9860-cam-clk
+              - sprd,sc9860-disp-clk
+              - sprd,sc9860-gpu-clk
+              - sprd,sc9860-vsp-clk
+    then:
+      required:
+        - reg
+      properties:
+        sprd,syscon: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - sprd,sc9860-agcp-gate
+              - sprd,sc9860-aon-gate
+              - sprd,sc9860-apahb-gate
+              - sprd,sc9860-apapb-gate
+              - sprd,sc9860-cam-gate
+              - sprd,sc9860-disp-gate
+              - sprd,sc9860-pll
+              - sprd,sc9860-pmu-gate
+              - sprd,sc9860-vsp-gate
+    then:
+      required:
+        - sprd,syscon
+      properties:
+        reg: false
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pmu-gate {
+        compatible = "sprd,sc9860-pmu-gate";
+        clocks = <&ext_26m>;
+        #clock-cells = <1>;
+        sprd,syscon = <&pmu_regs>;
+      };
+
+      clock-controller@20000000 {
+        compatible = "sprd,sc9860-ap-clk";
+        reg = <0 0x20000000 0 0x400>;
+        clocks = <&ext_26m>, <&pll 0>, <&pmu_gate 0>;
+        #clock-cells = <1>;
+      };
+    };
+...
-- 
2.34.1


