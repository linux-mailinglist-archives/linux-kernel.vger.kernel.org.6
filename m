Return-Path: <linux-kernel+bounces-274255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4269475B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9431F21822
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376EF149C59;
	Mon,  5 Aug 2024 07:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5myd2to"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B597E1420B6;
	Mon,  5 Aug 2024 07:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841501; cv=none; b=aETN6sjytv3eLzXE+lodT+0BcbikLYTB+1SWvPOR8yXLE4V0JSJFImiTEIwISGHHA07MinO3RQ5Gfh2TEdVFkDJOkwuh+mx3kdiebKHuu+nQFHk8KVICdilJJtd8vtVRHgbVCp7bzAF8czjCoVVg//Ey1X8yoxm6t2VmWToxvGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841501; c=relaxed/simple;
	bh=Z93IupthTrqFn5V8ceCot+25OQXmjZHhMm3z56mtxBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnV+Jcijm0NCHVNpzjh2XpBSdkc9pdlVoWnSUgLpegJCA9eHE173IFgIZo4vPcXjTrWCQnI7KtfophTFK8bbk26Z59xVlVr/Te1ozyEp5DdA/kCrWX8pcKmjcR0DwUU+GvB6lW0AqkGhifTDXnCNc8Lpt6E2KP7ySrRk6KzcXO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5myd2to; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3686b285969so5239952f8f.0;
        Mon, 05 Aug 2024 00:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722841498; x=1723446298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GvqGaTFVop2jOLifovYvjCOzgpHTLzWLXCFiNxbBn8w=;
        b=X5myd2toCwEYRXNAy4BKrvoO23VWEZWww9j2wGuD2fA3VKF0qJyY9R/F9D5V1YhFX5
         6yacH+K6Ryjxa67ZSuY/vhBquZLNUY5ooxsZaTV2qJPAQrC/kN3rNG5jhhnyxuNujuPE
         DIyB8GNBhu0U2GWDJZzWWmEO3S3X9cA4OLSoVccs/Y36VfZL+pcNoDtKs0gq9uRcnGM/
         ZDjxf3j69afz+4yQMxIBfXvQgqKZWTc0K83Jdex5ikYGL2XNd61gPUWgYmqh3USegHOY
         kIamJe7RPeM+q+/65VnzkT/K7lVFBZqXz70jfcJUVTz4VReVcHGkhKNdWu3w8MCp7e0b
         lr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722841498; x=1723446298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvqGaTFVop2jOLifovYvjCOzgpHTLzWLXCFiNxbBn8w=;
        b=DkvttGF0HA52bRIeTVtxtQbQ25kB4deNWWMimDfYitGFyob8SLCM9dtkaSd5L91le5
         1YuIaZfOkiwKosmWvwwawtsM374sWcwqEaBDSepKWi5RDRToP0KYbTD9sd4/lqd2qhWY
         zss2blqV+gsys7WHO8XvfCL/k++XGKRbbtPUuur9xgixJhJbQcErqwxUAYElx5NaBJPN
         BwIAYFnve52Vx/15QZwydQRhDvZL7VbA08JaHlt/ayerZK9L1yZoF317auKGZGWNm2ME
         CgNL00QBm7Wgc0Le6UIZEudk0UKMKsjFtElDfTo8/71fusmwcoMNO7ivEEOszqhgJQMd
         Zr7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKw8w/c7g9GJ8xebUuYiqXSVBjbpos4+ZJLs0dPVA6kNjvnSElaokqOT+A3oXPT76i4xYiwp0tEk0JM1Rwi7WgtL9aaosBCoOLe6Hi
X-Gm-Message-State: AOJu0YysZqmlHBMLSuhoVNrTKWLq26B/zOYyKjM86asKS7ECqsP/Ug8d
	dhG4BEqm9GvUfDos2IZ+1IQNOzTNvXcfT+kqn9Cv6/+xKSTRRCWv
X-Google-Smtp-Source: AGHT+IEtizPWYpUTh9qVPUGhF7NSe9dJE7VPAOGYzjWkYLIBuObho8HMvoykd5AYBwVJpvbz65nZMA==
X-Received: by 2002:adf:e008:0:b0:367:9d82:8370 with SMTP id ffacd0b85a97d-36bbc152c97mr5886538f8f.45.1722841497743;
        Mon, 05 Aug 2024 00:04:57 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1dc58sm8809924f8f.28.2024.08.05.00.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 00:04:57 -0700 (PDT)
Date: Mon, 5 Aug 2024 09:04:55 +0200
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
Subject: [PATCH v3 2/2] dt-bindings: nvmem: sprd,ums312-efuse: convert to YAML
Message-ID: <edd56598a05184605f463146cdffbcc1457ed6da.1722841057.git.stano.jakubek@gmail.com>
References: <c487bff193db7a06b846976a80c02c37509943ac.1722841057.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c487bff193db7a06b846976a80c02c37509943ac.1722841057.git.stano.jakubek@gmail.com>

Convert the Spreadtrum UMS312 eFuse bindings to DT schema.
Adjust filename to match compatible.

Note: the UMS312 clock bindings include doesn't seem to exist (yet?), so
      the UMS512 one was used for the "CLK_EFUSE_EB" define.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
  - add Conor's R-b
  - rebase on next-20240805
  - add lore links to V1 and V2 to the changelog

Changes in V2:
  - new patch, split from the merged bindings in V1

Link to V2: https://lore.kernel.org/lkml/17ccb895a54d7754d3ddd6de633ad045a5271b4b.1721199034.git.stano.jakubek@gmail.com/
Link to V1: https://lore.kernel.org/lkml/ZpJvRePtbaiG94Te@standask-GA-A55M-S2HP/

 .../bindings/nvmem/sprd,ums312-efuse.yaml     | 61 +++++++++++++++++++
 .../devicetree/bindings/nvmem/sprd-efuse.txt  | 39 ------------
 2 files changed, 61 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
new file mode 100644
index 000000000000..00e0fd1353a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sprd,ums312-efuse.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sprd,ums312-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum UMS312 eFuse
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,ums312-efuse
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: enable
+
+  hwlocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
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
+    #include <dt-bindings/clock/sprd,ums512-clk.h>
+
+    efuse@32240000 {
+      compatible = "sprd,ums312-efuse";
+      reg = <0x32240000 0x10000>;
+      clocks = <&aonapb_gate CLK_EFUSE_EB>;
+      clock-names = "enable";
+      hwlocks = <&hwlock 8>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      /* Data cells */
+      thermal_calib: calib@10 {
+        reg = <0x10 0x2>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt b/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
deleted file mode 100644
index 96b6feec27f0..000000000000
--- a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-= Spreadtrum eFuse device tree bindings =
-
-Required properties:
-- compatible: Should be "sprd,ums312-efuse".
-- reg: Specify the address offset of efuse controller.
-- clock-names: Should be "enable".
-- clocks: The phandle and specifier referencing the controller's clock.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	ap_efuse: efuse@32240000 {
-		compatible = "sprd,ums312-efuse";
-		reg = <0 0x32240000 0 0x10000>;
-		clock-names = "enable";
-		hwlocks = <&hwlock 8>;
-		clocks = <&aonapb_gate CLK_EFUSE_EB>;
-
-		/* Data cells */
-		thermal_calib: calib@10 {
-			reg = <0x10 0x2>;
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
-
-		nvmem-cells = <&thermal_calib>;
-		nvmem-cell-names = "calibration";
-	};
-- 
2.34.1


