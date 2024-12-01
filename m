Return-Path: <linux-kernel+bounces-426699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F69DF6CA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 18:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E548FB223AA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 17:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB04D1DDC3A;
	Sun,  1 Dec 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TdXRAtwe"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D481DE2A2
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733075264; cv=none; b=DpiPXIXNpQ8PlE9VHL5yJD6a+LPaPzvSgYqKTOZH8mg0cX1x0WeU5Eb4VpnOBpI9RKyBMlFrhK0vgdgxJHWWIoAvLE4vKsoIjQQ1+lqR4Z/XBopZ+5RBSRfVHpwTpsXX/yCfld4jrm4NNszp3PCoQxkUPrmhT7OWt2Tks/DxLrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733075264; c=relaxed/simple;
	bh=i+zaQKGw+SJKrdqETRU8S6D5mn97fzLB2huk0KC7t7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrPuXwhFIk/JO0/8Of2c8u8DXa0/J/zp1WHqg7SZXpHFMf7WZg5eKbQ6pKPkssxKHK7PEiQyAwIlVuqAR2cfdTCLSlS2gabVa28IwXetZ09ZoAwAd8gQZby3Ol1g/cFHUvIBu9t+CjpJ0uFXvPYhx7uUdrM1/z1HQlLOrmlu3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=TdXRAtwe; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0d4a2da4dso1332526a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 09:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1733075260; x=1733680060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8Mnl1funP026bpupc6kClrugt4oD6R0yljLualdHeA=;
        b=TdXRAtwedXGz/VxnGAzSId548nGsSo4FiAhzNxCEnpvXo2MziF5KONrLvzuy2U8x0B
         OxpsJzoo+EPImiuLg4CM8qSasIW+mZk5ytJU4q21Ao/mjXDVlOm8ubA3MKjmMvKJvrIw
         sKo3X/nQtc3oQccs9QPfUgHZ3xOwtTrH3eIgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733075260; x=1733680060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8Mnl1funP026bpupc6kClrugt4oD6R0yljLualdHeA=;
        b=NVzVoLlXOW/prl8Yrid6C8pzsBXf6GG21bcKGH0gMXYh4ALNUhLs33zVW6ycpUvEjl
         RN5t1EOB7wj4lgSyCx15Y0y04sq40CWRtwegKwm+6ip5mFlI3wJdjCnHd/qWT+2zbxZe
         ehWcsE0A9uirhgQKYu1GV4yFS27ceShbmF+QSbiVM5ognhFlKvipUL2GM/tx1Yb51MML
         uR4Chiciy8D2NR2K7utHNuGcL0tavESlnJcgq6w+gFW10BambqOtXgN6FAFquI7MIQya
         39k6wFQUQv4FSK7JprMVFpH/GB8qmCJ2m9rbdHlGJcCABfzM05Rt3n3FSOtL7uYu4N2U
         L24w==
X-Gm-Message-State: AOJu0YwxM9fsJTJyLjX0LMszo64HzM5kypgp46fu6lbEZPceQQMCJgIq
	qxoliWSqL+od6PVrVOgbCa4K32pUK1app3DCPR8CY7NJXMTdWlt1v/EJTsN1O4cEFDtnWWYwLdb
	7
X-Gm-Gg: ASbGnctup+U0XqZJAWZoDarO3l8XTyPMOAr46S9sz0Bt18mMz3Lh+CgbpzZ3laOj7Rt
	RUYgRPyJw1QyyAonOAMS4ccld1wH1HC2dcpbCUIxc1O9/VCuoJHRTQNcEFXUynZf4OhMFQm9/on
	vXb3Vyz3zSy6Gyv6uucJIqW1cipzGnJ/uyY7YfJAd8RjBIMaUQHj4tcbvFNObQaPcHWZdjzUlZ2
	sh1IOSaIhcNGmGNECeY9BOBmBaFclrI61dpxve+Le2Wp0Gpu0igyqfE6fRTJM8kORITQIRf2z2+
	pDOH4Ij70uP2IusJP6oLhQ1hGfoJV28Ntzk0Ca0Vyu0hprA12p0v8FR7WoBbCiKz8UkKJCqwFII
	NZ3/EKCjyGATaGvwk
X-Google-Smtp-Source: AGHT+IFV72Xrog96l7fs/EfUFu2CelIfYRaRPp9iwFgjtNC+Uq3ekIXkP8zlYtkGxH0RM/aN9S5fHg==
X-Received: by 2002:a17:906:2921:b0:aa5:2232:c8d2 with SMTP id a640c23a62f3a-aa580ef31c1mr1541928666b.10.1733075260573;
        Sun, 01 Dec 2024 09:47:40 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-54-94-193.retail.telecomitalia.it. [82.54.94.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a78esm415220066b.163.2024.12.01.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 09:47:40 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v4 13/18] dt-bindings: clock: imx8m-clock: support spread spectrum clocking
Date: Sun,  1 Dec 2024 18:46:13 +0100
Message-ID: <20241201174639.742000-14-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
References: <20241201174639.742000-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch adds the DT bindings for enabling and tuning spread spectrum
clocking generation.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

 - Drop "fsl,ssc-clocks" property. The other added properties now refer
   to the clock list.
 - Updated minItems and maxItems of
   - clocks
   - clock-names
   - fsl,ssc-modfreq-hz
   - fsl,ssc-modrate-percent
   - fsl,ssc-modmethod
 - Updated the dts examples

 - Added in v3
 - The dt-bindings have been moved from fsl,imx8m-anatop.yaml to
   imx8m-clock.yaml. The anatop device (fsl,imx8m-anatop.yaml) is
   indeed more or less a syscon, so it represents a memory area
   accessible by ccm (imx8m-clock.yaml) to setup the PLLs.

 - Add "allOf:" and place it after "required:" block, like in the
   example schema.
 - Move the properties definition to the top-level.
 - Drop unit types as requested by the "make dt_binding_check" command.

---

(no changes since v1)

 .../bindings/clock/imx8m-clock.yaml           | 77 +++++++++++++++++--
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
index c643d4a81478..83036f6d2274 100644
--- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
@@ -29,12 +29,12 @@ properties:
     maxItems: 2
 
   clocks:
-    minItems: 6
-    maxItems: 7
+    minItems: 7
+    maxItems: 10
 
   clock-names:
-    minItems: 6
-    maxItems: 7
+    minItems: 7
+    maxItems: 10
 
   '#clock-cells':
     const: 1
@@ -43,6 +43,34 @@ properties:
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
       for the full list of i.MX8M clock IDs.
 
+  fsl,ssc-modfreq-hz:
+    description:
+      The values of modulation frequency (Hz unit) for each clock
+      supporting spread spectrum.
+    minItems: 7
+    maxItems: 10
+
+  fsl,ssc-modrate-percent:
+    description:
+      The percentage values of modulation rate for each clock
+      supporting spread spectrum.
+    minItems: 7
+    maxItems: 10
+
+  fsl,ssc-modmethod:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      The modulation techniques for each clock supporting spread
+      spectrum.
+    minItems: 7
+    maxItems: 10
+    items:
+      enum:
+        - ""
+        - down-spread
+        - up-spread
+        - center-spread
+
 required:
   - compatible
   - reg
@@ -76,6 +104,10 @@ allOf:
             - const: clk_ext2
             - const: clk_ext3
             - const: clk_ext4
+        fsl,ssc-modfreq-hz: false
+        fsl,ssc-modrate-percent: false
+        fsl,ssc-modmethod: false
+
     else:
       properties:
         clocks:
@@ -86,6 +118,10 @@ allOf:
             - description: ext2 clock input
             - description: ext3 clock input
             - description: ext4 clock input
+            - description: audio1 PLL input
+            - description: audio2 PLL input
+            - description: dram PLL input
+            - description: video PLL input
 
         clock-names:
           items:
@@ -95,20 +131,49 @@ allOf:
             - const: clk_ext2
             - const: clk_ext3
             - const: clk_ext4
+            - const: audio_pll1
+            - const: audio_pll2
+            - const: dram_pll
+            - const: video_pll
 
 additionalProperties: false
 
 examples:
   # Clock Control Module node:
   - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+
     clock-controller@30380000 {
         compatible = "fsl,imx8mm-ccm";
         reg = <0x30380000 0x10000>;
         #clock-cells = <1>;
         clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
-                 <&clk_ext3>, <&clk_ext4>;
+                 <&clk_ext3>, <&clk_ext4>,
+                 <&anatop IMX8MM_ANATOP_AUDIO_PLL1>,
+                 <&anatop IMX8MM_ANATOP_AUDIO_PLL1>,
+                 <&anatop IMX8MM_ANATOP_DRAM_PLL>,
+                 <&anatop IMX8MM_ANATOP_VIDEO_PLL>;
         clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
-                      "clk_ext3", "clk_ext4";
+                      "clk_ext3", "clk_ext4", "audio_pll1", "audio_pll2",
+                      "dram_pll", "video_pll";
+        fsl,ssc-modfreq-hz = <0>, <0>, <0>, <0>,
+                             <0>, <0>,
+                             <6818>,
+                             <0>,
+                             <0>,
+                             <2419>;
+        fsl,ssc-modrate-percent = <0>, <0>, <0>, <0>,
+                             <0>, <0>,
+                             <3>,
+                             <0>,
+                             <0>,
+                             <7>;
+        fsl,ssc-modmethod = "", "", "", "",
+                            "", "",
+                            "down-spread",
+                            "",
+                            "",
+                            "center-spread";
     };
 
   - |
-- 
2.43.0


