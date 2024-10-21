Return-Path: <linux-kernel+bounces-373568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9629A58F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 04:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35D21C2098F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 02:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15839481DD;
	Mon, 21 Oct 2024 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="X12pcGQI"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7F1EB21
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478218; cv=none; b=nYH6AVV0IOrZrjavzBgduSqH0U9GB4zhCoZS+1uOZStsUD14PgZ1Kl/ueHYF9yBrfQye3LP0zrv/ENceEOCoFoo/FMaauEZWNzlil5mDW56FhlTa9g5rSk+4RWgRS1HXKMFvCjCeptX/iSKwtRjTkPFtbiGHf2vj1kCRbDZuz1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478218; c=relaxed/simple;
	bh=afsnMpQ5eTp0P23sbeiUEptavts4PCGe1unUWc5taUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfHOL39/nEDPfNxmGfZaOmczLw2ZkBIgv0Ce/OpAxplfC51ZWT6hm61jRK+xjxOqxdQbyLkdI4ryDOU5B9hSzYSFvWJq+4lmjtti2JA7VXQEJU24Mx987cb97poZDUtUAFBwmVG1PGeKfZsGh5uS+T9WyCh+4g/xfxfInSFMZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=X12pcGQI; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso3076411a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 19:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1729478215; x=1730083015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUNFNowz14dkfUGFMLmJpIFRrRBzO1OU5EXyGYyuqF0=;
        b=X12pcGQILbWQ6xhbNgdFf5DTOHop4DTfNgUjcJtt6AHQyowPWxngaK6h4uR6OVkTkN
         f75mLyi6DkSs9uQvjAt+ywmHvsBYLP0KEiIcgEWEUQuBudo/92bAGIaUnxPOQnGN5E0G
         pq43huwwjcm1NW2Jga+eRZbEqdSKTdOZWLJUWkcaCZpk82VhtgUXnIBs/TGx7h24kApR
         44oB/0Or4elYViwsS47LGsWREJYQrFK0fMq+xaixTwzwnYtTlG9tr3FI0PF9sjnpF0aA
         iE/VIpRR8mAA0FVxO0QeQkNVfT0BxEDI8tSuIRthuh8PNh6xkLeMUeiBoVIkrh01wdg4
         pk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729478215; x=1730083015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUNFNowz14dkfUGFMLmJpIFRrRBzO1OU5EXyGYyuqF0=;
        b=Zh0ZOg+VWsHOYZ/T24SSTX3jB2X+pX8vb839iyq5b5/nU25Jwl7Qcr895tyWiGrHNl
         wf9uXrv20HzoZ8/WVVZWCzz99qOYOcL8ffH24PJUgnaQwpLWeN7tqutHEbg3YjXN9uxj
         3XV2E3ZPq2X8mB04L0dUkVnueNuVRLIZePZhntmee/26dqRiHBfMCgMmyQWh80eDZqAb
         ydXO+4OTLnbIjEOZ5oCyJn7B1GDW5pRRslhND9uM1FkkntiUeFjkth8by8Wfk5Lte7oG
         uuHx1OReFpxX5XBs4OVNrc8+4JsUyNZDP0TVExt46gmc8LRC4SPY5ZKip5Az0I9Wovlf
         +VBw==
X-Forwarded-Encrypted: i=1; AJvYcCVFnbWzlGldcnxcHSdL9u8YBJbhL92z9tsRjUIJ0D7aXbo6BZ6V7wW81i02KBMaQ0rMqCqWibguYmhZix4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vYeL008JpCAEKHuKJT9coA1rSumTR5IAXkUQJZOSL33DQPyT
	kSPs8CkrO5Lg+jnU8u0dOIQlMPrJ+Fbw0Lj9Nx/3WHHOiDxBMyzyKL55Z39FNEs=
X-Google-Smtp-Source: AGHT+IFNTpbNDFgH8LuAVW9Gkv6jojNSOBsKW5UinaIGSi9hSSIrshAVU6Zb7qkpi/uqMXAvslY7AQ==
X-Received: by 2002:a05:6a20:e617:b0:1cf:3f2a:d1dd with SMTP id adf61e73a8af0-1d92c4dfd14mr14319446637.12.1729478214886;
        Sun, 20 Oct 2024 19:36:54 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad355bebsm2337008a91.7.2024.10.20.19.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 19:36:54 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Sun, 20 Oct 2024 19:36:00 -0700
Subject: [PATCH net-next v4 1/3] dt-bindings: net: Add T-HEAD dwmac support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241020-th1520-dwmac-v4-1-c77acd33ccef@tenstorrent.com>
References: <20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com>
In-Reply-To: <20241020-th1520-dwmac-v4-0-c77acd33ccef@tenstorrent.com>
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
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.14.1

From: Jisheng Zhang <jszhang@kernel.org>

Add documentation to describe the DesginWare-based GMAC controllers in
the T-HEAD TH1520 SoC.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[drew: rename compatible, add apb registers as second reg of gmac node,
       add clocks and interrupts poroperties]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/net/thead,th1520-gmac.yaml | 115 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 3 files changed, 117 insertions(+)

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
index 000000000000..cea652ff6255
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
@@ -0,0 +1,115 @@
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
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phy-mode
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
index a858224b59d5..a16418d68383 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20066,6 +20066,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git https://github.com/pdp7/linux.git
 F:	Documentation/devicetree/bindings/clock/thead,th1520-clk-ap.yaml
+F:	Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
 F:	Documentation/devicetree/bindings/pinctrl/thead,th1520-pinctrl.yaml
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/clk/thead/clk-th1520-ap.c

-- 
2.34.1


