Return-Path: <linux-kernel+bounces-274251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F599475AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1931C20BA1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AC9145FE2;
	Mon,  5 Aug 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boBhkPvD"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49C1109;
	Mon,  5 Aug 2024 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841389; cv=none; b=IFC6P4MIgvLHFpXXQ7vwr3qU5LlnXymzXDty3P5IMjymIwLEA/vA3AIuYRr7YlcKD8AQqTUyolNs88RRO/CE4qGywkpEv8rMyKBDU9GLYW/eR+mw8Qme5JA3gw/TUwaunUrBDhmoecza9MoZH/3zivuEq7bh7AhdwcEtWYAHtgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841389; c=relaxed/simple;
	bh=c+y0fGE8IuUiI6wsh0DXIPXyyyZzXUepkln5jxYIO7M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jbiDJs1OuYly+M/nfx8UgZSSzZGrWwgDaVrTopVGFxV0V/krKavvxjijTvNTTfMiWXo9nfAWJjzx4TCR78/+QGtAw06bw+jbIFkxcgkDP7ItVTkZhLl7s9gZQnYFxnrfw62vluo+Aaj3y47aUosbN8A5yq7O+6gQv+ioSrdJiwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boBhkPvD; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ef32fea28dso115656751fa.2;
        Mon, 05 Aug 2024 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722841386; x=1723446186; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXH+DPI3k2kYMy5m3D0/h7zELcFvntFbg6PLrvX3u7A=;
        b=boBhkPvD3f/WNRzWoA3I4QlmEf2GbA4eVaLzCSd983AQ1L45ZSBHCEFPNP6Y8WMKWE
         +bWvDwAU5OrzlUSEOj1Yk9MY/ks/vnZeDQFGM+u0SV2Q2nHqDbnAWZpFFQxGtH4VazGS
         /FamhbINk/D0FguG09F2wtdV864/WbUvc93R5jeHpOyq/r2FEKQKTmTly+lMNXziPoOv
         ur6MJaMXPg/4TtpvMrHi20HATJJNUaCxr3WaIfsbSIqFhjfWki7unrJ8keIxrdTccnet
         lq14SLxZ8qEvBl7n7WdIKpD/66/kChiT2ktLabGdtB97JcR4iCNytjsZC/z1M5zOSlyI
         tGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722841386; x=1723446186;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXH+DPI3k2kYMy5m3D0/h7zELcFvntFbg6PLrvX3u7A=;
        b=hs9hSmCn+DLkdyeeT1TBduiIR6h20mV33SPJEAoFA7o4uGebDR0rlyCPF7dTR0Zf0w
         Nxg9jpWXeo1JLS9Zq9oHfBYLz2GLu2HfnN+SN0rRNVSZ7FzuUMafmP8jiCKNnWc+etNV
         fIGuhYDYPd2NUWKs6PQw4kW5gm+snhaIkRMTAulirmS4bl3C39EmxGvghHhNbUgIhTgk
         gsX1uOXFU4iyiO8esxp7VDdDi/23nLpLnhRNRvPCq4aWltimkoQo4ooBgV8HZlrsZYGR
         n7qlvTVxnLX/9pmn7i6w8PzuL+IXvS9lLY8Bu6jvDoLsSwIJReQD9EQIHm+GlJZf/usC
         TH2A==
X-Forwarded-Encrypted: i=1; AJvYcCUIqFR5YKHxYSu+IEyyqRRyICabaqkKPtBGb9chHVFR1iVb2FwXoBALcFyiNzVb1tb8CYB+aTMnRnNEK6+uSJb/7PUm7QfUfDQ3Qg0x
X-Gm-Message-State: AOJu0Yz4/cDkJMlERRAzXP9m0gcpg/IgiZ2TKKdu9VsfauScpE1sing+
	/Bz6Bfxsdp9ieMj8GchBjfstP/SBnpZBfk2xzZmJT2BopxlhjRRu
X-Google-Smtp-Source: AGHT+IForsKntQW2loiqNmH5NvpZ4XaKQdJDkrA0hoC8S8cyYXu3cqpzNSUxPo5SjzXara6eTuhZDg==
X-Received: by 2002:a2e:3019:0:b0:2f0:1a95:7108 with SMTP id 38308e7fff4ca-2f15ab0647dmr69097241fa.32.1722841385064;
        Mon, 05 Aug 2024 00:03:05 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e4073f7bsm147073255e9.18.2024.08.05.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:03:04 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:03:02 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Yanxin Huang <yanxin.huang@unisoc.com>,
	huang yanxin <yanxin.huang07@gmail.com>,
	Wenming Wu <wenming.wu@unisoc.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: nvmem: sprd,sc2731-efuse: convert to YAML
Message-ID: <c487bff193db7a06b846976a80c02c37509943ac.1722841057.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC27XX eFuse bindings to DT schema.
Rename the file after the only in-tree user, SC2731.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
  - add Conor's R-b
  - rebase on next-20240805
  - add lore links to V1 and V2 to the changelog

Changes in V2:
  - don't merge both SPRD eFuse bindings into one
    (ums312 now has separate bindings, see patch 2)
  - drop now unused clocks, clock-names

Link to V2: https://lore.kernel.org/lkml/9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com/
Link to V1: https://lore.kernel.org/lkml/ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP/

 .../bindings/nvmem/sc27xx-efuse.txt           | 52 --------------
 .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt b/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
deleted file mode 100644
index 586c08286aa9..000000000000
--- a/Documentation/devicetree/bindings/nvmem/sc27xx-efuse.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-= Spreadtrum SC27XX PMIC eFuse device tree bindings =
-
-Required properties:
-- compatible: Should be one of the following.
-	"sprd,sc2720-efuse"
-	"sprd,sc2721-efuse"
-	"sprd,sc2723-efuse"
-	"sprd,sc2730-efuse"
-	"sprd,sc2731-efuse"
-- reg: Specify the address offset of efuse controller.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	sc2731_pmic: pmic@0 {
-		compatible = "sprd,sc2731";
-		reg = <0>;
-		spi-max-frequency = <26000000>;
-		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		efuse@380 {
-			compatible = "sprd,sc2731-efuse";
-			reg = <0x380>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			hwlocks = <&hwlock 12>;
-
-			/* Data cells */
-			thermal_calib: calib@10 {
-				reg = <0x10 0x2>;
-			};
-		};
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-Example:
-
-	thermal {
-		...
-		nvmem-cells = <&thermal_calib>;
-		nvmem-cell-names = "calibration";
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
new file mode 100644
index 000000000000..dc25fe3d1841
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sprd,sc2731-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC27XX PMIC eFuse
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc2720-efuse
+      - sprd,sc2721-efuse
+      - sprd,sc2723-efuse
+      - sprd,sc2730-efuse
+      - sprd,sc2731-efuse
+
+  reg:
+    maxItems: 1
+
+  hwlocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - hwlocks
+
+allOf:
+  - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      efuse@380 {
+        compatible = "sprd,sc2731-efuse";
+        reg = <0x380>;
+        hwlocks = <&hwlock 12>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        /* Data cells */
+        fgu_calib: calib@6 {
+          reg = <0x6 0x2>;
+          bits = <0 9>;
+        };
+
+        adc_big_scale: calib@24 {
+          reg = <0x24 0x2>;
+        };
+
+        adc_small_scale: calib@26 {
+          reg = <0x26 0x2>;
+        };
+      };
+    };
+...
-- 
2.34.1


