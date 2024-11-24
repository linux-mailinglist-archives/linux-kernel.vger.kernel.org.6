Return-Path: <linux-kernel+bounces-419372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6E9D6D10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 09:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7FE16184E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E711891A8;
	Sun, 24 Nov 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN9RjGNW"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C21632C7;
	Sun, 24 Nov 2024 08:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732435395; cv=none; b=t+WE6lfoVlJLYLMJz4Sqd6oi/Orgr3vcZPNONwPs9iFoPjOrDVCIGPMZUPCRa7VL0CM/5vt6eaco8pcrIJcawXmSjDb0Huhgr6ZChp8GwrOkkGrfZ172D/BoCFQActlwtIEoSE3b4WbppyT9/i/vc1qgdwyapvwlKE71mtW0aOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732435395; c=relaxed/simple;
	bh=zt89irQDW9CsH40Zyg/0WkJVDAxLXQtPDXUHOyIhEG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvd7cUK870RFJd9cAEwALPcLK3rd+0NknEC9vJ6jo+fFuJ6T1pjb0OMubqSWqJZCSCvnslCuevS0sA4TxEb0KjsLz7uAiPMVXeB2t/r/Vvs8KNH2s+0S6rPvHRFyeOencuXgGFuODKDjn7wNbPBecUA24uHdvZFK8CG5fPunmgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN9RjGNW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e3686088c3so2807416a91.0;
        Sun, 24 Nov 2024 00:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732435393; x=1733040193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyN3lb5o5xZdLZFjo/taUmbi+nBHaQ8I8tpHgqQH4t0=;
        b=lN9RjGNWGlRs1JD3/W6JiGkuq1JnzqQfg4F54YZ6NiQeg/JHxjR+E0PHIOVbwL1xDV
         kLAkLQGoo7Tjka0j2/blumtP/FCPPaezndaKjXx2sDwwUSwABcgN/aS1e5cTGOvLf9wO
         Hd4DPlosfb9GvFJ75ks28qqeMa8rIIHWx3/xiYW6ea82kxwVrNuzF2kEY8mA7T+0BqpA
         O6vtk2kPiXtWZTuQfoyC+VrfHnqmtPlPWtaBlIAR1VlCOqJhbxTbSCEdcJYrl8jrIV+L
         IKsbFTjvA+wbLtiEKNODMkxmzJ3Roix/M9fscxX2aBwZkAnTR0dxLB8azX6RpCQ7LrCq
         N7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732435393; x=1733040193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyN3lb5o5xZdLZFjo/taUmbi+nBHaQ8I8tpHgqQH4t0=;
        b=dG+IfKlISTkJA1DzoVnQeYwhRjmnWdGnO9y4w8OTfIHPLrEWmrQFqb3fSNADCbANaB
         onIQPrL0vbeeKCwlS3H6lKB+8Gni97+X9idVK23yxGAiIRsc7V+aXOrlA/Ij6olU2jsU
         fOcZt6SDnswdxmzh/t+ircb09mIBn1RnR6LM18yL7KuLRRXzNkjpVAuFA5YEZFhq2m1i
         /5MM1J50f/q7sRayoYOtCv1ACyRN78tyTv7YaQTMWC3Q3mRo6itsg2EoA+wBgvO4xncm
         WpIYg3R2HGjOWw7RWuNq7ijGhm1/vWnuKwfQSNDbppvZjo5lOF1psijgRNCW5ktcJQZV
         Z/rA==
X-Forwarded-Encrypted: i=1; AJvYcCUSHJNmnDW5leQODDNrQpNit9TCKClJOgq9sfYEJrj5UR+P7vpxz/2HEn8Od8yXn/ENA+cuzz+diY8s@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaDHQ4y6LcyYF0VfVivpv2V9Ssz6ABQ5xNROLDSvcHBVE/M2D
	sEJDzDfqUaYs3drSsad40OHeAoXd3W0tXZwwi7RL/uif6msyI44zq41wRkYsd3Q=
X-Gm-Gg: ASbGncv0njduyFmz8yqi2F6vEXNarFqqLNiUzZkRigZi3wojvQVjXgOpVyqftzenhkH
	7sizcYyReFI1Wd8/o6SKapXjIypmgPsBLybcy4ApY3xnskp/hKGifRJym7yJHmykDMZAkIevH/6
	2RHV01nvjr3PMKjJrtxTZ/EM5M5wfAMqPg3eq5UtZl0cia1Hgzdsv7/MR1VHyb4mdXgpT14gmw8
	YKP+pIo2/+wH6hKEuFTFTErnlIp8J3oQEVVyRdjgkbbcrkKy1EXAfIIBdT/WAA=
X-Google-Smtp-Source: AGHT+IHm7fTQFFW7HR2+//ajs5yB9voo7Vxd8MOCqrw1gY2F4ee0ZrKdNLDFYAHMj9ASYYKS7Gb1JQ==
X-Received: by 2002:a17:90b:17c8:b0:2ea:8e42:c46 with SMTP id 98e67ed59e1d1-2eb0d50eb9dmr12049101a91.0.1732435393155;
        Sun, 24 Nov 2024 00:03:13 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead03de6f6sm7956708a91.34.2024.11.24.00.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:03:12 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Christophe Branchereau <cbranchereau@gmail.com>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: display: panel: Add a panel for RG40XX series
Date: Sun, 24 Nov 2024 17:02:14 +0900
Message-ID: <20241124080220.1657238-4-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241124080220.1657238-1-kikuchan98@gmail.com>
References: <20241124080220.1657238-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a display panel used in the Anbernic RG40XX series (H and V),
a handheld gaming device from Anbernic. It is 4.00 inches in size
(diagonally) with a resolution of 640x480.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../display/panel/anbernic,rg40xx-panel.yaml  | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,rg40xx-panel.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,rg40xx-panel.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,rg40xx-panel.yaml
new file mode 100644
index 00000000000..bec5363e1d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,rg40xx-panel.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anbernic,rg40xx-panel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anbernic RG40XX series (YLM-LBV0400001X-V1) 4.00" 640x480 24-bit IPS LCD panel
+
+maintainers:
+  - Hironori KIKUCHI <kikuchan98@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: anbernic,rg40xx-panel
+
+  reg:
+    maxItems: 1
+
+  spi-3wire: true
+
+required:
+  - compatible
+  - reg
+  - port
+  - power-supply
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "anbernic,rg40xx-panel";
+            reg = <0>;
+
+            spi-3wire;
+            spi-max-frequency = <3125000>;
+
+            reset-gpios = <&pio 8 14 GPIO_ACTIVE_LOW>; // PI14
+
+            backlight = <&backlight>;
+            power-supply = <&reg_lcd>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&tcon_lcd0_out_lcd>;
+                };
+            };
+        };
+    };
-- 
2.47.0


