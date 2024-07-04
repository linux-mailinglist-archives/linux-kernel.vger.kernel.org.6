Return-Path: <linux-kernel+bounces-241034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD82927629
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7293FB21B09
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B571A1AE84D;
	Thu,  4 Jul 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjjN/Jh1"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E86846F;
	Thu,  4 Jul 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096836; cv=none; b=a9zk7+g8/2zMsjs1GKF4tY1jUcquCxUXQNHBfNvScpsxcbcRF07w6RQEp6+/OWj0KNu7EMLgM3crSZIW9DCAtsUxzluS6ZSNc/pcIYWZtvmCcyKh8QtnFXG+1qE/Aw6UXjeI2FsJtFfqtwCSYIoYx/h0hGG2jio+GI73h9mMkPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096836; c=relaxed/simple;
	bh=D8VUJnunWboUU9bednYtacDXYcGV2olR/LCMTFuPCNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=skUMUzZMC3TGHH1o76yCzbRHb4DCSN3INvETU9LXepbJa0oUd+bC0mZJAI54/no625Hnb3SUdj/j83LR4UqXUMU2EeRcEWzBEKBOskgIgt/RlRZS/wi7BRTKETbUZNEC9wORScTJt/lHOy0DqWxTEayyuiFAKCFT5xAn8tWbopw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjjN/Jh1; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-36785e72a48so397305f8f.3;
        Thu, 04 Jul 2024 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720096833; x=1720701633; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koF2tzkq+XQjWQ8NSnINgUtvR9xz9Ne3DH92HnQbg0c=;
        b=FjjN/Jh1IB7wGp9ZmxfWUkBvTLZZ/ZlwyWTiuoiA291C4k1nyq3E5yFGs1ikIss93T
         gjuLEQKTC5xRgntgPK8jj/aP7TKWN5Dnu6kW5QnUmyIPnIjVHICDWwkwzoRn9d05ZNJ0
         y00R5DFk0k08YnLu4NGMYVxIwYmB7863BvOBV4Ai6sfmouBtH+xBc9cPZtqO8YXCUNdu
         P9feW9EgnI/PUGsuFvur8nl58yGacFWsTuio5xBkvbYOBHLWj8bIRZSwdFdwkhJUNjnx
         5BkxDUNtENHd6AATkyBtP+QW1OXr+50GenaGtevHxUJF7wHWDBqUawlmtfnIWGtzj2nD
         zH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720096833; x=1720701633;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=koF2tzkq+XQjWQ8NSnINgUtvR9xz9Ne3DH92HnQbg0c=;
        b=NNH/RTnr3VSjiVLPW0k5ktpw71yOncNbKFzf0tGE15X9N3gYaW2EWN4Ya31+uXZiNA
         Djv+HIWgW1Wd9OfBaZlnun8+mT99DGFbHVYHkA5mmAxqLBSivLX8DmZRag5J8+GeRrhJ
         rm6JH+PII4hvz45U7Ia/NIJjkt400XNp3/5VLEtny0SiOcR5PaCzJ1Qp9zLzMk9HA82t
         mWlHC1gbNoPpaF7aSzh3NA9sDEXbN/38IPfEMcHXTx/baAlOxBrnzTvTG0KbNFEq28oP
         HISJ9h3/oiRFTWEW8S/xGqabOjuNY6tLEi6MLK7h+OcN+z2ICvpIWVridjdMfDFq2qyB
         BL4g==
X-Forwarded-Encrypted: i=1; AJvYcCWyCXONEHPdErqcll88OGXMvkqq3UdbF/ws332f0YRvwy4tM0SaNRogxEOYi+aVuzRiUlc5i0rhdcim8Pd1VGwR1DOdTlgc0vbv/4joyp2yBpeA+/3MpIPDetwV30676UHh3TyrbxQPuA==
X-Gm-Message-State: AOJu0YzY08FiDyXHEOtDXiuRck/Kf2RZzjQiRhEHoQ124dITjMvUu3pp
	M+rVRLWGHwbe+tHIulxZKvX1VteNRTZj+Ln71GHVLcfr3Y4jkTBS
X-Google-Smtp-Source: AGHT+IFlrY9wlMLwr8/bndCL69wANwDUTycEwTQ0Ic1ymWjXE1Y7/0E6iLMkYNpwc9CzFyR5jg7+og==
X-Received: by 2002:adf:e7c9:0:b0:367:96b5:784e with SMTP id ffacd0b85a97d-3679dd65277mr1111127f8f.50.1720096833073;
        Thu, 04 Jul 2024 05:40:33 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679ed376cdsm1347135f8f.114.2024.07.04.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:40:32 -0700 (PDT)
Date: Thu, 4 Jul 2024 14:40:30 +0200
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
Subject: [PATCH v2] dt-bindings: clock: sprd,sc9860-clk: convert to YAML
Message-ID: <ZoaYPg2avtYpKQjB@standask-GA-A55M-S2HP>
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
Changes in V2:
  - drop inaccurate clocks description
  - constrain clocks, reg and sprd,syscon per variant

 .../bindings/clock/sprd,sc9860-clk.txt        |  63 -------
 .../bindings/clock/sprd,sc9860-clk.yaml       | 155 ++++++++++++++++++
 2 files changed, 155 insertions(+), 63 deletions(-)
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
index 000000000000..1bd9b8b5202c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
@@ -0,0 +1,155 @@
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


