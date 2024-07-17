Return-Path: <linux-kernel+bounces-254771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C176B93376D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEB51C225CD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8E217C9E;
	Wed, 17 Jul 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI5SdD0e"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC52171A1;
	Wed, 17 Jul 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721199320; cv=none; b=kSxfGMYuAVYtLu71ncF9R7UfwsSfURNmhpMQSzWxHbOX2pqwDqee5obFLUnc+s6++rPoZaftNna4/nw6mx0eV3G2tvsmqbaH5QtxFHofq3bRI8KDKlbc3A/CpcRefzqyh3P4oo/MsLVnWibTMYnwcc1t9AD4LE8EvRgeQVt4ydI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721199320; c=relaxed/simple;
	bh=K+hLNDemm80k4LEEeo+oaEJZMtNlP6jZSX8TeTH3Ju8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=moGoGB3sAgJGuyGtQuhzcj+Ldv2dzXq9Bjs/4TgvgUN+Z2pPLPQUjdXJf/OzS1b2J0BlzF50losHv74LxR3J8JDoUsjmiqwCoiAb4feRSSfhKkBGP7svlvY2t4q4E5coqY4VgqIzy+yQ1BTSkGwvXJ6XFXai1zzy8sOJfyWafAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI5SdD0e; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso44850625e9.3;
        Tue, 16 Jul 2024 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721199317; x=1721804117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JaLEjmgE7LCagP3kzs36OTaVSU25eNzSxkjwimGIqFg=;
        b=OI5SdD0eouAP9HmjYjlcw00euDc/5vtenGl3hf8LETVGF+8HOPoqWmpmw19AaFqyR6
         BI0eTJCzKZCwMo8VH2KuTHD6GB/pqdRps8CiuM1FQolw1Zejr1xFm9dVvW6EK1qO4aTY
         AMYhPbW/L+Z0GzNvtUSb3aX2jZQDtcxMEsvi9Gi0XWWDNxuEvSMuylmOZAnCHVNHVSiR
         sFg4v2I1CzsV4Xnv/ZDMETdkJpKCpaPUUduWgH2kiQdCRi0288j9UQfT9Xx2OKNs5C2o
         FpEIgORDub/vjfG2gmDmT9hbb1fIT+YMlOnEHcpt9MxQ6w9eGWLTeRUmC1pzzCe/APog
         tnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721199317; x=1721804117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaLEjmgE7LCagP3kzs36OTaVSU25eNzSxkjwimGIqFg=;
        b=ja9ktOVxl75SH6OvoLKw6esBak0xkn9U5Nh5NEgcsj2SmlOLX0FOvmE4aXyQ7e8I3J
         Qiy/YqSfm0lgLaaMCFIRXuLEQMJcpFdz4TypfYOxDvfo1Dxyb083I+FDR/hogoRCCVEt
         6meePm9P6Mnz0Ntz5J1uDNV/hA9yBWW9hnCOqsFyPaeJj5B5qmaBUOH4OWq+lDRQvbUh
         QJHWiqHz7yUdISiD9EWRRZdp/jEDYzR4uu2zJTyqByaUFqPc3bWx8jfWe3FdmRSbulwo
         tIVxzNkJDL8fjOk7K9m02P8zugV546MzhKYIO3FRdk/s9MUSC14Q/hwPzsvwagUnTHWL
         pX8A==
X-Forwarded-Encrypted: i=1; AJvYcCW5beFNWe5Q6gmY1x92QVJIz0Ea0g4dMkI85UM8Wy02lCgG4kV/z1bLcMbZKyfJu1bjGzrGhO8SKmRwxdVqZUnLta6AOHN2Aomxwrvu
X-Gm-Message-State: AOJu0YwsFlVVop8w2D8RuCAJnwUCt66i7SS9AHJr8GAztW8832/N08Y0
	G3Yi9puU4u1ezRjrIvt5H5S+qHlCXMSYzmh/LocGzWy+sXzjdIjS
X-Google-Smtp-Source: AGHT+IGSzVb4t6Y3qX6HCv6CL1607Npb1NuvcbKci4r170WV36Pf9uVIDuBenF36XnCxsDebwDpfbQ==
X-Received: by 2002:a05:600c:1390:b0:426:6ed5:fd5 with SMTP id 5b1f17b1804b1-427c2cadee4mr5398445e9.6.1721199316708;
        Tue, 16 Jul 2024 23:55:16 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f23a000sm195600805e9.5.2024.07.16.23.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:55:16 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:55:14 +0200
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
Subject: [PATCH v2 2/2] dt-bindings: nvmem: sprd,ums312-efuse: convert to YAML
Message-ID: <17ccb895a54d7754d3ddd6de633ad045a5271b4b.1721199034.git.stano.jakubek@gmail.com>
References: <9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com>

Convert the Spreadtrum UMS312 eFuse bindings to DT schema.
Adjust filename to match compatible.

Note: the UMS312 clock bindings include doesn't seem to exist (yet?), so
      the UMS512 one was used for the "CLK_EFUSE_EB" define.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V2:
  - new patch, split from the merged bindings in V1

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


