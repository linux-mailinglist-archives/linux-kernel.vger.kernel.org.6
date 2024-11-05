Return-Path: <linux-kernel+bounces-395921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85BA9BC506
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 06:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271FBB20C36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348B1FF038;
	Tue,  5 Nov 2024 05:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXUtWF2P"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63A1FF027;
	Tue,  5 Nov 2024 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730786057; cv=none; b=eK8rLW+WjX4c86RWA3hC41+j4MkC7tx9HwyLbC6IaFvSlcFcRtPkgyEvCtHEOf5akvs/KHmxT66qcqiiV7wRGio83oaxNhAj7nywq8V2Hed5LGftOYKmGXxjh1kuvAQdQ2FQJRSJ+CtvNl1iC557Re0vWh/eLXpoKOmsMyA0lJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730786057; c=relaxed/simple;
	bh=PnMtuvP53to25ELnSSmMbEewp+9GLp6kupRdVZRGNYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+CI8uFwztLxKtW+0srcGuVsZlsZvbbft16rXKuCPpbXq3BkZTFErNQhdeLDeglwgIBBnDSwOfuTE0AokBqT0mxjRuci+24zFOKKaltCqhF111nT/lhpLgjykqUg3XYTL4msH2wb2lsgPSdNC0whXZkHiGyDHR1F3H4AtMBQtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXUtWF2P; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20e6981ca77so52603365ad.2;
        Mon, 04 Nov 2024 21:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730786055; x=1731390855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RSTrj12MA3LSstUjcR2m39zO9Sz//eaW6qPmLd2lLs=;
        b=XXUtWF2PMmLkYF1zeaOmdB1H340YoIDYEXmxQW5TA7LIg9UN5VacYl8fsh1FmR6QgP
         MZnsCePRqOBzVD7lKzLVdQlBBL9pPI0p7a44GlNjJusXlFnwubx+aD5MXcM/luUVnvVC
         Sib2kNkJxZYZgDohCUSIGS1qTqCbQGGr/V7CoYNuPmdu5OI/yR9V71F7Tjm7BfzfNPWy
         +BuNUIxeutiR7RP1A3fe/RXQA9far/i2W0K6ysylxgvgnQgaWEkP2/jALWcIpm2GJNH9
         uak/en4NgHIBVr4uM/U0xYS0oqc/Jx9EbCXYGb5K7fyh9bkOt+cHbVwxNC08UlVElC/K
         9Cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730786055; x=1731390855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RSTrj12MA3LSstUjcR2m39zO9Sz//eaW6qPmLd2lLs=;
        b=DRNOl/VdxfZ9JhdNPaT5MsRDSiqu/ii1Jbkv0ckeHbPN4m8FO6otGWa1WAVp4s0uIB
         7pOblfsvS+2t120FatRMgnMBjEF1hc/TkLO3BRfoDVnzM+H6UOTWh71m59I5ZzJIQviG
         mR77pvD4W7mE1C0vEZj7bVMRTO99gep9hYbFF13IZSOZh9lO1E5YDQYzPL2pXl3WKS2r
         I7hs1SdBUiBkdO9REQ3PYDXtaAhzm/H63gck3r0Qq9sZbz2S9dIv8PR8aVBMBtgUkcyD
         Yc0QAXnYaHWuRe2MHePU9glzLM7x0AUQyv5KTe55BOXTHmN7DMGiOuiBe3DsNuHbs5FQ
         cuIA==
X-Forwarded-Encrypted: i=1; AJvYcCV+T+mgWHCxFZPfZiYE1euZ4fQ7jC5D9fmy7E+r9YsVfy+hMcvm9iScnYtyT6TP1sdITPxVWv045aN4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw05Cq0dOH+p+AZDsgPr9pgAyMCZvwHwjHKvKTjnfz/8ocB0mUU
	rTXMDnmbwIukcUv30EhJNuiYOe0whPVp8JlUic0qmhNd0UYJDHoNS7ANm1bv
X-Google-Smtp-Source: AGHT+IEE2+nq4RnyVrBeTE2rxTbFZpVouLNCIaYjjV2OesMo31jPbvWxV0chgkw6q6ii3tICw0cvgQ==
X-Received: by 2002:a17:90b:5242:b0:2e2:d879:7cfc with SMTP id 98e67ed59e1d1-2e93c1a6337mr24526678a91.21.1730786054947;
        Mon, 04 Nov 2024 21:54:14 -0800 (PST)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:fa8f:7c3e:835f:c642])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa4570fsm10952198a91.30.2024.11.04.21.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 21:54:14 -0800 (PST)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ryan Walklin <ryan@testtoast.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/7] dt-bindings: display: panel: Add YLM-LBV0345001H-V2 panel
Date: Tue,  5 Nov 2024 14:52:32 +0900
Message-ID: <20241105055239.1577275-5-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105055239.1577275-1-kikuchan98@gmail.com>
References: <20241105055239.1577275-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The YLM-LBV0345001H-V2 panel is a display panel used in the recent
revision of Anbernic RG35XX Plus, a handheld gaming device from Anbernic.
It is 3.45 inches in size (diagonally) with a resolution of 640x480.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../panel/anbernic,ylm-lbv0345001h-v2.yaml    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0345001h-v2.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0345001h-v2.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0345001h-v2.yaml
new file mode 100644
index 00000000000..ae00096bf3d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,ylm-lbv0345001h-v2.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anbernic,ylm-lbv0345001h-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anbernic RG35XX series (YLM-LBV0345001H-V2) 3.45" 640x480 24-bit IPS LCD panel
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
+    oneOf:
+      - const: anbernic,ylm-lbv0345001h-v2
+      - items:
+          - enum:
+              - anbernic,rg35xx-2024-panel
+              - anbernic,rg35xx-h-panel
+              - anbernic,rg35xx-sp-panel
+              - anbernic,rg35xx-plus-panel
+          - const: anbernic,ylm-lbv0345001h-v2
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
+            compatible = "anbernic,ylm-lbv0345001h-v2";
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


