Return-Path: <linux-kernel+bounces-389223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E469B6A37
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D911C22781
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D2219CA0;
	Wed, 30 Oct 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="Kj+p16d8"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8411219487
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307483; cv=none; b=jsSClTgwG0AWXJctN+CsK1j3b89PS57QG2ocJvMsi+siNx6jEOn88IIKDhNQJkLpF8T4JBhOZByDygPmw9QPbdYvsVQBxnUr5Xf5iUUSbk3ZE0vPxdUQGicfpRLQCcsqLVNN1Crw/pT+gwrJKnt6fNlWA0c2bgYFoEO/96B9ql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307483; c=relaxed/simple;
	bh=ytr4kv67qGAo7czUluBX9q+jXByw5RP4zcvFDppWqgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMYXDcYPalHwrbLwrTR+rJ5Z0z/Rq792DhFajIdLg/DP6FbocAznWUWS4SWyXUtEfzXE6rMrjYbs8zu9q/wg3J74qb8cV0J4iPGS3y534PQzhT+OVt9AU+GQx+qMi1fU1ycsAk1i30V5ovDUcJRvv6P6fKAvOtGY/hdmtQOeaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=Kj+p16d8; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so101117a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1730307479; x=1730912279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzL62SVyIjejPV0WK5Icvrl5yXIEFUYP1mc1b47FbtQ=;
        b=Kj+p16d8qUy8TxJkWPxHrnyq/TbM65sJgMEwFprUWsv5s2ImiK/UoFZSr7LlXuTgMK
         ZhbDn+aeecnAzOR0L7bCXJv29TEy53cHa5L4zguQz7gX7FUMNwnooHKoeCBXY4tryiEJ
         scDanIxNINqjk3gVX34GjThPD2jj9Bhjzc7ATD5ypRzhc/A6aVWTOlQ7Be2klzbBFOEp
         07uLxpvHXw7p99GTTZ0RpHfpTsJZJBu6AQiyftoKL1F71ehT8kmsAf6DJFneXeK8D3WA
         CbTmsJkAm0d7OaR/3mXVC95lLhCO89tOUpDDUwW9BWaumBD/3JZYWGNm3Op/fewY4AMJ
         Z/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730307479; x=1730912279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzL62SVyIjejPV0WK5Icvrl5yXIEFUYP1mc1b47FbtQ=;
        b=w+oF/+a3VOj6USLeDWBMqCPq1Zvz1Rwrf4LR2t4bCAAzcSp4pC44nZQ1b8JBhmJqb9
         oOJIV3PpkWAevYCsWyPhqnerZD/o7+bl6OZaKIQ3Cg1gTNp5ryEGm06Pdwk+7H3oCEOV
         eAFtK4X5RWmS8lUNo3qf8VJ/y9OdMpER5rFT66GwqpAg2rPVxTUtCu+e1DBR6iSQsn9Q
         8y8G2pmFHpIbJPWNoe5vgB2TtjjqDKIjWkXJv5lv2pSo1ho9E58QbJ3/G7rrrgRuZDKH
         ih9XlXntV3iW2AAm5JrwcdE9yDJ9kQta0uoHOzEa3O025aCRj3MoHWJ0RtAcvcIiR3ku
         eosg==
X-Forwarded-Encrypted: i=1; AJvYcCVIsnOrdVnKkGkVo5IKH4kf5k67p7BFkUX5mAhwE5c04E9k7N4VFWjMSdYb89fEdZJWbB5zbFjUgig3RH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkMwzlNB8kZT7cEjOPUJy0TGidP9YL23rb4k3Vj7Tvuo23CBAf
	kfZSqUM97cOIX6F87ZDvfgxTZRcELSsRc1IUooAhzrFgXzqbJdOtX4u9JY6z0TM=
X-Google-Smtp-Source: AGHT+IE8bL+epQxJK6CXce+NuA003s35k7m7I3D6tHPjdUbTchJcFFfnxiHRxOXvx11kN2Kqf0lARg==
X-Received: by 2002:a05:6a21:6e41:b0:1d9:175a:c2ba with SMTP id adf61e73a8af0-1db91d8b4b5mr85520637.20.1730307478935;
        Wed, 30 Oct 2024 09:57:58 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a1f1ddsm9810776b3a.149.2024.10.30.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:57:58 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Wed, 30 Oct 2024 09:57:44 -0700
Subject: [PATCH net-next v6 1/2] dt-bindings: net: Add T-HEAD dwmac support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-th1520-gmac-v6-1-e48176d45116@tenstorrent.com>
References: <20241030-th1520-gmac-v6-0-e48176d45116@tenstorrent.com>
In-Reply-To: <20241030-th1520-gmac-v6-0-e48176d45116@tenstorrent.com>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Drew Fustini <drew@pdp7.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Drew Fustini <dfustini@tenstorrent.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1

From: Jisheng Zhang <jszhang@kernel.org>

Add documentation to describe the DesginWare-based GMAC controllers in
the T-HEAD TH1520 SoC.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[drew: rename compatible, add apb registers as second reg of gmac node,
       add clocks and interrupts poroperties]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml | 110 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 112 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 4e2ba1bf788c..474ade185033 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -99,6 +99,7 @@ properties:
         - snps,dwxgmac-2.10
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
+        - thead,th1520-gmac
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
new file mode 100644
index 000000000000..6d9de3303762
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/thead,th1520-gmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD TH1520 GMAC Ethernet controller
+
+maintainers:
+  - Drew Fustini <dfustini@tenstorrent.com>
+
+description: |
+  The TH1520 GMAC is described in the TH1520 Peripheral Interface User Manual
+  https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
+
+  Features include
+    - Compliant with IEEE802.3 Specification
+    - IEEE 1588-2008 standard for precision networked clock synchronization
+    - Supports 10/100/1000Mbps data transfer rate
+    - Supports RGMII/MII interface
+    - Preamble and start of frame data (SFD) insertion in Transmit path
+    - Preamble and SFD deletion in the Receive path
+    - Automatic CRC and pad generation options for receive frames
+    - MDIO master interface for PHY device configuration and management
+
+  The GMAC Registers consists of two parts
+    - APB registers are used to configure clock frequency/clock enable/clock
+      direction/PHY interface type.
+    - AHB registers are use to configure GMAC core (DesignWare Core part).
+      GMAC core register consists of DMA registers and GMAC registers.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - thead,th1520-gmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - thead,th1520-gmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    items:
+      - description: DesignWare GMAC IP core registers
+      - description: GMAC APB registers
+
+  reg-names:
+    items:
+      - const: dwmac
+      - const: apb
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: Peripheral registers interface clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: pclk
+
+  interrupts:
+    items:
+      - description: Combined signal for various interrupt events
+
+  interrupt-names:
+    items:
+      - const: macirq
+
+required:
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    gmac0: ethernet@e7070000 {
+        compatible = "thead,th1520-gmac", "snps,dwmac-3.70a";
+        reg = <0xe7070000 0x2000>, <0xec003000 0x1000>;
+        reg-names = "dwmac", "apb";
+        clocks = <&clk 1>, <&clk 2>;
+        clock-names = "stmmaceth", "pclk";
+        interrupts = <66>;
+        interrupt-names = "macirq";
+        phy-mode = "rgmii-id";
+        snps,fixed-burst;
+        snps,axi-config = <&stmmac_axi_setup>;
+        snps,pbl = <32>;
+        phy-handle = <&phy0>;
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "snps,dwmac-mdio";
+
+            phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index f39ab140710f..72dee6d07ced 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19827,6 +19827,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c
 F:	include/dt-bindings/clock/thead,th1520-clk-ap.h

-- 
2.34.1


