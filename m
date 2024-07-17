Return-Path: <linux-kernel+bounces-254770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5331493376B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8FA1F22FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2120B17C64;
	Wed, 17 Jul 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgbIyhPo"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BF0168BD;
	Wed, 17 Jul 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199293; cv=none; b=ugsDiJXYSuCPgbf9192HVOnAWa80cfXJ1+jAFs9gMDAusFJ17BqXDpEIotPJikURghfd8Spf/Q2XBBLjgwsPTbcvxylwqR217cegbtm5SrnUPUTNCcsaddJuJITdruz6QC3w6xwu7wzgT3iFMhmCGceyoGwHiAnGdz73uQlj8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199293; c=relaxed/simple;
	bh=aZklrWcoYImMd5kjD1t8jhqUQuG8Fa38mz4PaWKoCrg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C58JhUTKRvTS/lkDC0WEjunV9/XQQv5EKyQdmVkYuIt3O/wTXMWjxET6oP/IYR4njS555i4nFhQDVAAFde5/bZDRQloannr8GHq4xFNTI5TSn3yrA32/KWZzgwSZ4VBSKea8lH8d36HtsxK0OssxN4qUW4Gg98OscnaCrn3oEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgbIyhPo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3679df4cb4cso249478f8f.0;
        Tue, 16 Jul 2024 23:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721199290; x=1721804090; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1YLJ3TkKT1Wj1ZfoVOPP08uP5BHh14hFdEYt5ZtLHM=;
        b=DgbIyhPojnLSuao+wWw/59zSFRQkwrEIx//168Qkyo6p6/ZmCVAt4Phyr2Mwb/4xNb
         pghKcfi/q/M/gdhzFgJ5SXrFIQvbWZCwDgaQLaGSAvRoHTibmVdanEgpuWhFIqfXwCb2
         sJ1w4E8rSuzuS+k4PplZ1KkUSfghfUSVtrbN3vQ9xVvt5/2MZacCl0fyE4GGQqQWRCDu
         7gzTh6AZBYVIgBrgnAbZBPi0Agz6B8UiF+XihOA1HjDxVKNApiIyk+UExouKICdGT4qs
         DqCNp2pYKRFF6LSONRYLRx5OfUa+w+6OkGzRCx4wyA9cGeQ/e2nKHX6JDprRzdYR9X7U
         3Paw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721199290; x=1721804090;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1YLJ3TkKT1Wj1ZfoVOPP08uP5BHh14hFdEYt5ZtLHM=;
        b=QCmt8fEnb0zmZLBcK9aeGQsdac/s5+Qs6Z6Asn/z7y2cdnP6l94JVERsmAoZHkM+o3
         iGujh/SFoiiVFab9ZMiMmOYXgmQVedY6YNXsNMyKEJA7o3k+OuihCkK4FmCCFqIaJfBK
         cXEcEv+15Nyvw47Zpi84RU3i1Jku93+TSBGI0/BEqGjibqYWhzCsrwC8sZmaumRztjUz
         ZL7Eezz1JObWvUPuyIyUtK1PETtOr+GUMzre6xcYbBoOP3mr4CQ8StT4lzqZ6+OFdQxS
         ZxGr912iCKsP+jpawfAS4wy9mpbqOWMm7ENzMqVvqY4dw1avTPJjHaJzs68c+tZIuETC
         NbrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcfeIxeMGjcS5tae7fHIpBstJgwsmnS4bPcDYxK/d1TrfYcFHXeyxubuUW/5oTMC6dqVbTdB8RKgzreVpqyQic7BrQCqn+yk6SNBlB
X-Gm-Message-State: AOJu0YyvimegBmUd2ULzjM21nH+wr3Ne5p1mGgAYAsJMRFgPX5UlzHsb
	PC1QEb4iUlCag2l1XwIB4jxfHx8xTPrHL25RJhsc95MVkGtQY1NV
X-Google-Smtp-Source: AGHT+IHYRN49xMaQSXNqYQxFEVZnNVg9yuFeY/RwsZ0FYGX7WwHG5A8Kr0s8tnPF9SJJRk1ILQnDtA==
X-Received: by 2002:a05:6000:4021:b0:366:e308:f9a1 with SMTP id ffacd0b85a97d-36831670e44mr473294f8f.23.1721199289683;
        Tue, 16 Jul 2024 23:54:49 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf20dsm10918921f8f.38.2024.07.16.23.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:54:49 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:54:47 +0200
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
Subject: [PATCH v2 1/2] dt-bindings: nvmem: sprd,sc2731-efuse: convert to YAML
Message-ID: <9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com>
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

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
  - don't merge both SPRD eFuse bindings into one
    (ums312 now has separate bindings, see patch 2)
  - drop now unused clocks, clock-names

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


