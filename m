Return-Path: <linux-kernel+bounces-239542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E4D9261E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69D9CB24E4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA91617967E;
	Wed,  3 Jul 2024 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j27u54KE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9A17996;
	Wed,  3 Jul 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013530; cv=none; b=ZzDuUdEIcAYLn3u3irTOKM8GrgLRtf3qcWXwbTWo59CqT5BTf+XV6Oc88Ev1/4XyTsbE2CGnAqyHtCtO7dYE+fPS8ka0PqAFlc+G3WCw0FkgwV8HJWLcPbvfBsSEUWvrT1ZNsEHzmEYVdFV1xLdEunXjvuiwOhV9QxoXCaFsB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013530; c=relaxed/simple;
	bh=cC9yez9ru5tz6L+ZBQOiScXqAx6CzS9LIQV+YWh1sK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VT3qZ7WvBQidigqZMbZ05ldeuk3UKJBnIK6Pl2ntrrgIAUKPUgtUAxBbZDLny7nTVCV+4keNBxEKHkmYpb1MHoh7XAMuVIbJ/Xb6jPuUn6ZBUF78uyffmcfxpPZCIt557wWTrrm6MYZ0eEjvL+ol56hKD9ikZsqo05NiaM+G3MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j27u54KE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42565697036so4223575e9.1;
        Wed, 03 Jul 2024 06:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720013527; x=1720618327; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kl2pjHJm1h/ffi90DDR4egoLaMikdE5VLzt8GYsReJI=;
        b=j27u54KEkeaOJ/hpCovl49EhB3PwY1SQoO0frasIk4SLBOhay3FyssplmclzqGdDOh
         MrvrdBHA7bnvoNTUUZk+cx02NnTUV3kMBr0x3ek+p6ZEfG1B8VvYJmW+OW2rORlWLZ7n
         F+mDEzsMEIONTW3hW9MMVRVQQc7CbBqQzn8aFaA2PrrWe54DIJKvCxA6UB6LJ+LU7X3I
         yIePtmARZgO5rRmWjEtOdwHd+a17XCC2e1w5PdZRFeE2VmFkuDbeXfgegRrkW0+CqCfd
         c9AtAk1CfAdo3eQu77l/GKtDCZlIhjfQZX2V2KxKN8ZTtph6R9OKt8OfrWmzjtOfOkQ2
         b9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013527; x=1720618327;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kl2pjHJm1h/ffi90DDR4egoLaMikdE5VLzt8GYsReJI=;
        b=uVuxXVDdCO0YxLabK7zI/BM5VPGab7izON+05AOD6jE5WRN2fkM4TUSVUcYXGy2Hb1
         mDf6dlIjoCtQhKqqwhgdRjHokgOl5rOwaTiRwZZbSjbF7vQk2dGaQgqgXTrrKAOKY6Yk
         DV4ANWIbZYb+KU1XEP1tBOK8L0B+bJ3aQjNWudobvQoHI0Wmd6bGDhqMa3zgFFmKqeKX
         EKIhWGOArkBMXmMQSkPuQb1INywl6+a/QwysdH8/cL2HKVgC7hzXkqSV/2OpGIB9PWl+
         SNjpTuETXV0/h2N8RMfJALFQscHv/kg3J61JNQYFT/k2taEWHqVA/X7TOrZmtNwxZuHC
         xy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnblhw4J3vKiuGwIhKt9r54CaP9YLR35Q56MpIFrq555HMkGukBVbpVQR3hOyexWdA/Qh93gH55/d0NkXoxLjYjuJOi0h542qh8s/wxWzAsMehZfxqDGrqE7OU9ILCF+Dk8/LY/MHzgw==
X-Gm-Message-State: AOJu0YwwqwhDlIzJ+iF4K3PKPd3RGpJsgjSDlPPe42KW+IMYiFW49KYv
	iXKHVW+Avv1Ogm03oO1H2YmdSLD4iVg6kqVaILnfhSWxHY/YrUMV
X-Google-Smtp-Source: AGHT+IGFr7nyIVzVY5CNAur2UEQy1puK2wRucx6U1PuVyGu1HvCbNL+KZoL1fXuTJC/SwvxI1gnpgw==
X-Received: by 2002:a05:600c:4ca5:b0:424:895c:b84b with SMTP id 5b1f17b1804b1-426408e4d90mr16230135e9.4.1720013527265;
        Wed, 03 Jul 2024 06:32:07 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42573c55ff4sm216113945e9.46.2024.07.03.06.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:32:06 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:32:04 +0200
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
Subject: [PATCH] dt-bindings: clock: sprd,sc9860-clk: convert to YAML
Message-ID: <ZoVS1GAC28Zpzok4@standask-GA-A55M-S2HP>
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
 .../bindings/clock/sprd,sc9860-clk.txt        | 63 -------------
 .../bindings/clock/sprd,sc9860-clk.yaml       | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 63 deletions(-)
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
index 000000000000..21ed023a928c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sprd,sc9860-clk.yaml
@@ -0,0 +1,90 @@
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
+    description:
+      Should be the input parent clock(s) phandle for the clock, this
+      property just simply shows which clock group the clocks' parents
+      are in, since each clk node would represent many clocks which are
+      defined in the driver. The detailed dependency relationship
+      (i.e. how many parents and which are the parents) are implemented
+      in driver code.
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
+oneOf:
+  - required:
+      - reg
+  - required:
+      - sprd,syscon
+
+required:
+  - compatible
+  - clocks
+  - '#clock-cells'
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


