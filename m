Return-Path: <linux-kernel+bounces-309030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2775A96656F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C08B20EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498E1B5830;
	Fri, 30 Aug 2024 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+HkSAZj"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC3192D98;
	Fri, 30 Aug 2024 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031752; cv=none; b=e/F5lS97fZ2TY6AxgYIZpqlc2IS7mEJxixw5zlUjWnHPptvOpmBI0amSuqufg7eEDf5+Xu1YYC6DubPSVDmVmaZUE7/dbmV2z9CNUZDSTck8xH2hpEpOZgzx2oJOGN8plAmUTJCcvD5wZO2GCcpWplKDDx881rUsSX7edQcvN80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031752; c=relaxed/simple;
	bh=UBHir9e9aoYiOymDC7F6H7OVKv7SZxZYlgAHmp1TAI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnTfsETEv2TF/LB5e9okNNVndOWuV6PXI7orSIFIPgssShzA/7DLI1GRm2ChNyg1EDKsi+pWVNTnV4x/Np7oeGSjUG6jBfcH3t9dMadSHkXI1hwbJPyCeLwpHCxWffAUlTx5x2AQr7oLUIZN9Z9IsHGUfeJHSt57b4qNWNpmsjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+HkSAZj; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-829e856a14eso91473639f.2;
        Fri, 30 Aug 2024 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725031750; x=1725636550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb3wjHwKHyyErGOdPoNDwcSg6+46HG6ew+HhAf+N6s0=;
        b=j+HkSAZj1BG2cUiNA//eMlEDQjJAiQdl92wfUTwo4LKAF7fG7XOvUsL4gKQJra53Je
         cJ0szEWjKzAYEvY1/xUS1++vXO2U5SUhnUQEB1HLm8zFgPW1nc8CNOjnzmvKlgZapdDu
         /G4fv+WtXXoiISvraTH2gMFNCkhsHGfETu4Z4Xs6qLLeFvsaKnkfeTioD8swIZVB99BM
         A3uZ7jIiAbwo2AmFD1w/jrwnXln01yJ0ROivxzGHKS6CtB1tycSJuvmyCF8K4TCbdD4w
         HS12yBtK07tY4p27s8vmZzcie+QXsoS9DvSLzlXTrWn/18y6ld1h2HpxuL6rZZ4pxYxB
         WQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031750; x=1725636550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb3wjHwKHyyErGOdPoNDwcSg6+46HG6ew+HhAf+N6s0=;
        b=AkpGIWEnaNXfUWuGrS7/AjFic1ycmPrQPyUn8ABYNjr4HGmcyvdi7ZjeNAKdFLg/LQ
         P4uWPguMjFEUyPLXTAPAUe/QJ7BR2XoxQecwYuzXwCbUnNQ7PPujBuTtgvdqhSTvkASZ
         5XhSfNYZQmPGoPRjsNBiomPiheANVYGj2uYr3xz2FV1nm6t2qqGy+u/3mRw3OLwkEL3C
         KlkXBwALAyV58G8ELXFNtQl6Md2TOYZXZk+e7Kk8g2w7eMrP8vHRwGKAAerFhtNOXMPM
         KpzRGsYCvO2v+ok0dqaC9dDlMkm28lnPveCRwcImOtA5RIljg4s/gejL1Ue3s7VUcdDi
         JuRg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ9FYSf+ww8gy5dL1CW7OB7tgc08k6g5FnEZxEnDn8UfVOsPknfP/eB/0Y0my8oyMRMaCkhr0USQKzcGNE@vger.kernel.org, AJvYcCVrPvgTT5H8R32uTaXcxG17g6/huTUG080a5u8/0ga4/5ze3Nz/XhE+nvWKZU+OcGQlr73flC8RaFcs@vger.kernel.org
X-Gm-Message-State: AOJu0YxmwwV3R86ohBGgbq39uWRqUhEs9ymemuVYSy0YI0QYv2LLgV5M
	Rc0NbhwHHg5ob1L6bmcqJLf6gX3dUt1Nlop+p/JNV50l9CAsKWKW
X-Google-Smtp-Source: AGHT+IEz3mBaOKwLFj/ZjEG+4BFbjz/K3mBFBjE2qjFqGXqza5qxYjxCZaoYDNjR8MMS6ENuF16KGA==
X-Received: by 2002:a05:6602:2d8e:b0:825:2c2c:bd8f with SMTP id ca18e2360f4ac-82a11094862mr827663739f.14.1725031750178;
        Fri, 30 Aug 2024 08:29:10 -0700 (PDT)
Received: from localhost.localdomain (174-20-195-90.mpls.qwest.net. [174.20.195.90])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a2f081csm92197439f.10.2024.08.30.08.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:29:09 -0700 (PDT)
From: Shimrra Shai <shimrrashai@gmail.com>
To: shimrrashai@gmail.com
Cc: Laurent.pinchart@ideasonboard.com,
	aarnoud@me.com,
	airlied@gmail.com,
	algea.cao@rock-chips.com,
	andrzej.hajda@intel.com,
	andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	heiko@sntech.de,
	hjc@rock-chips.com,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	ldearquer@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	maarten.lankhorst@linux.intel.com,
	markyao0591@gmail.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	tzimmermann@suse.de
Subject: [PATCH v5? 5/6] dt-bindings: display: rockchip: Add schema for RK3588 DW HDMI QP TX machine
Date: Fri, 30 Aug 2024 10:28:56 -0500
Message-ID: <20240830152856.9079-1-shimrrashai@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830152132.8894-1-shimrrashai@gmail.com>
References: <20240830152132.8894-1-shimrrashai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
new file mode 100644
index 000000000..e71544ced
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/rockchip/rockchip,rk3588-dw-hdmi-qp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip DW HDMI QP TX Encoder
+
+maintainers:
+  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
+  - Shimrra Shai <shimrrashai@gmail.com>
+
+description:
+  The Rockchip RK3588 SoC integrates the Synopsys DesignWare HDMI QP TX
+  controller IP and an HDMI/eDP TX Combo PHY based on a Samsung IP block.
+
+allOf:
+  - $ref: /schemas/display/bridge/synopsys,dw-hdmi-qp.yaml#
+  - $ref: /schemas/sound/dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3588-dw-hdmi-qp
+
+  clocks:
+    minItems: 4
+    items:
+      - description: Peripheral/APB bus clock
+      - description: EARC RX biphase clock
+      - description: Reference clock
+      - description: Audio interface clock
+      # The next clocks are optional, but shall be specified in this
+      # order when present.
+      - description: TMDS/FRL link clock
+      - description: Video datapath clock
+
+  clock-names:
+    minItems: 4
+    items:
+      - const: pclk
+      - const: earc
+      - const: ref
+      - const: aud
+      - enum: [hdp, hclk_vo1]
+      - const: hclk_vo1
+
+  interrupts:
+    items:
+      - description: AVP Unit interrupt
+      - description: CEC interrupt
+      - description: eARC RX interrupt
+      - description: Main Unit interrupt
+      - description: HPD interrupt
+
+  interrupt-names:
+    items:
+      - const: avp
+      - const: cec
+      - const: earc
+      - const: main
+      - const: hpd
+
+  phys:
+    maxItems: 1
+    description: The HDMI/eDP PHY.
+
+  phy-names:
+    const: hdmi
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    minItems: 2
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: ref
+      - const: hdp
+
+  "#sound-dai-cells":
+    const: 0
+
+  rockchip,grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Most HDMI QP related data is accessed through SYS GRF regs.
+
+  rockchip,vo1-grf:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Additional HDMI QP related data is accessed through VO1 GRF regs.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - phys
+  - phy-names
+  - ports
+  - resets
+  - reset-names
+  - rockchip,grf
+  - rockchip,vo1-grf
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3588-power.h>
+    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      hdmi@fde80000 {
+        compatible = "rockchip,rk3588-dw-hdmi-qp";
+        reg = <0x0 0xfde80000 0x0 0x20000>;
+        clocks = <&cru PCLK_HDMITX0>,
+                 <&cru CLK_HDMITX0_EARC>,
+                 <&cru CLK_HDMITX0_REF>,
+                 <&cru MCLK_I2S5_8CH_TX>,
+                 <&cru CLK_HDMIHDP0>,
+                 <&cru HCLK_VO1>;
+        clock-names = "pclk", "earc", "ref", "aud", "hdp", "hclk_vo1";
+        interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+                     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>;
+        interrupt-names = "avp", "cec", "earc", "main", "hpd";
+        phys = <&hdptxphy_hdmi0>;
+        phy-names = "hdmi";
+        power-domains = <&power RK3588_PD_VO1>;
+        resets = <&cru SRST_HDMITX0_REF>, <&cru SRST_HDMIHDP0>;
+        reset-names = "ref", "hdp";
+        rockchip,grf = <&sys_grf>;
+        rockchip,vo1-grf = <&vo1_grf>;
+        #sound-dai-cells = <0>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            hdmi0_in_vp0: endpoint {
+                remote-endpoint = <&vp0_out_hdmi0>;
+            };
+          };
+
+          port@1 {
+            reg = <1>;
+
+            hdmi0_out_con0: endpoint {
+                remote-endpoint = <&hdmi_con0_in>;
+            };
+          };
+        };
+      };
+    };

