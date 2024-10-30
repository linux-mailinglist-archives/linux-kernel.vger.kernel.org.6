Return-Path: <linux-kernel+bounces-388843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECE29B6523
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21D91C21044
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822431EF93A;
	Wed, 30 Oct 2024 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNeic6np"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3B1EBA08
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730297023; cv=none; b=PHH4JSmPDTRBZidnr4jc9MhZOJwrvqftGBm25YOZez2qo9WLLK+42GmRAYeDfSJbeG4Sx9Hpe5NDpv0sWXxfdIX8LarCUdjT4R+cVVJ9cSG3QPj9HYJxMWU7lbtBMWif774xg8sqcGRYoALvtvYXmVM8eXyfcHjLRK3fy+1OELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730297023; c=relaxed/simple;
	bh=nbMY5/x+dbMsqaNrYH3cAttll2rbKjnf7PUSqcK3ZrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjR/p/0hPxs5l858EU5dC8efHU4C7cmNLuZ4VKaEKAyjK8rrjcW40Cc6vTW0EUmdQUcTj9gqs7o1n9pri4jVKTtrTCqJQEQ8LMmPnJnyMeGyNsgKTJfpgfcUNw6OQnE5WXh76qT0cQJfDv7xGeUCmlLo3QSnZU+hMlnbzC6fIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kNeic6np; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-431616c23b5so6375235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 07:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730297020; x=1730901820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6f04onKhg2BcvYZRQva/GJx3NTh2UIMiNUM08tNq4c=;
        b=kNeic6npKQC7lwOQtL7Fd5uHw2GmzLBpcjGVWNer66SyT/OHFb+cbyrOjuNnC49VL1
         hb8YURXMjkeNr0ahvjFCN8Hvgm+rRYxEZ37BxscGNnqzZwwoMLEBF1qMOup2HyONStFG
         Ad0Pnap9/aq5Ve1i9/Yt47l2qGA3jgHd3l5u16baijyyGavwoexsVnRE1Rlx/8hCZ0YJ
         zw6m60oFtYukgegfeTe2GqtW4CgHUsaRMaQyBeOrO9917Kx4pHd3Ys6QOzTmxLOUwCrt
         ifyw2Bx936Fg+bKQmQ5PmM5Pyiclh5rAAYX05Sb0/r3didBlc21B3hJ8pSLO5BcFOxOu
         8c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730297020; x=1730901820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6f04onKhg2BcvYZRQva/GJx3NTh2UIMiNUM08tNq4c=;
        b=q9odzzKJ+QvC2dRn7EAyGmroYVHH3YnYRkgX/+bgzsAlQfA/0xxv1086VL8kit6G+t
         lFqjP10qIuueESJqHZHtW8mV9LhOseDMoOlyhPfH6DHDEPFuSnLkCdGT9VWMBl6YdyxO
         +qPfklufqwcJ7fm6WmlqwuuEQS4p5z2tm1QsNDVqKQnjnQhoFSz25s7Oog0mPoxZILrv
         VImrVAC5hk4rxQWU/SD4Ae4STOYbQn7QDXXqxfM+w3Q7AgfErMIEGm55rmdfaNRq095n
         Wd6Xeb3s7kh38gFSUundGwl5WCyo5KCb2WgBBE6zhUmHlvn3w05p9xM2FVns9ocqSNMO
         2X4g==
X-Gm-Message-State: AOJu0YzBeDdEKBXe5jwuL02Bqo95UXfyGhUt6iwHCOu48gbquS0gp+k7
	C2SIVBMBDhkg4VKjeGbf5cpHllbkmWt6CbpEYgtTatrBNmyYvTiM7NJ5sj1lNDU=
X-Google-Smtp-Source: AGHT+IH9qQ26UfUIVOkVpNtE48/3/x0A7AdAGuPJooQT4HVlIwHqt5RS6ZcAcYmQsOuXx+U2vBwb3A==
X-Received: by 2002:a05:600c:1c96:b0:431:55af:a220 with SMTP id 5b1f17b1804b1-431b5729f16mr50868555e9.12.1730297019571;
        Wed, 30 Oct 2024 07:03:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm22498405e9.30.2024.10.30.07.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:03:39 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/7] dt-bindings: fuse: Move renesas,rcar-{efuse,otp} to nvmem
Date: Wed, 30 Oct 2024 14:03:09 +0000
Message-Id: <20241030140315.40562-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
References: <20241030140315.40562-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5497; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=W45eHvGZ5R9J5tq5JLMjXz3ZBZio+iQpx3uwUWg4vIk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnIjyirm5Xro7ybZq195NOGZiGjYRahiKQkORXb H1l2LH4R3WJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZyI8ogAKCRB6of1ZxzRV N0ifB/954qv0hzcaihwaoX3J0je1jfqFkwLGbBMZwsMWz/51kTHNk0J0gTgqJmswPNM+taPQWfQ tYfaO0176kb3MIXFGytAdhKcFelOmkavkLoyk0G5LZ9PLjb0LdE22dTM8wLUtIMbCzrwgrGn9QD tkw1Lc1IFUg8KpmFJcEW4Yy8GAldLErZ4Gw8aO37CsG1rjkCaLWsBWl3cc8MQf1KFkTz6IBHEtm 8cNObXc4A9tVZanMsGUKlLUeF01kYnFmsZ6qPukv47pITn3U4hD2HyDx2bpUOgVVIlfYJmxzGYs fbumbWq44sNQ+TpR0Jf01QXUpENHtv4oG8im2d3qZ4B3Y3VT
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

The R-Car E-FUSE blocks can be modelled better using the nvmem
framework.

Replace the R-Car V3U example by an R-Car S4-8 ES1.2 example, to show
the definition of nvmem cells.  While at it, drop unneeded labels from
the examples, and fix indentation.

Add an entry to the MAINTAINERS file.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../{fuse => nvmem}/renesas,rcar-efuse.yaml   | 35 +++++++++++++------
 .../{fuse => nvmem}/renesas,rcar-otp.yaml     | 17 +++++----
 MAINTAINERS                                   |  1 +
 3 files changed, 36 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{fuse => nvmem}/renesas,rcar-efuse.yaml (54%)
 rename Documentation/devicetree/bindings/{fuse => nvmem}/renesas,rcar-otp.yaml (60%)

diff --git a/Documentation/devicetree/bindings/fuse/renesas,rcar-efuse.yaml b/Documentation/devicetree/bindings/nvmem/renesas,rcar-efuse.yaml
similarity index 54%
rename from Documentation/devicetree/bindings/fuse/renesas,rcar-efuse.yaml
rename to Documentation/devicetree/bindings/nvmem/renesas,rcar-efuse.yaml
index d7e289244e72..ce7d65afa460 100644
--- a/Documentation/devicetree/bindings/fuse/renesas,rcar-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/renesas,rcar-efuse.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/fuse/renesas,rcar-efuse.yaml#
+$id: http://devicetree.org/schemas/nvmem/renesas,rcar-efuse.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: R-Car E-FUSE connected to PFC
@@ -13,6 +13,9 @@ description:
   The E-FUSE is a type of non-volatile memory, which is accessible through the
   Pin Function Controller (PFC) on some R-Car Gen4 SoCs.
 
+allOf:
+  - $ref: nvmem.yaml#
+
 properties:
   compatible:
     enum:
@@ -39,17 +42,27 @@ required:
   - power-domains
   - resets
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/r8a779a0-cpg-mssr.h>
-    #include <dt-bindings/power/r8a779a0-sysc.h>
-
-    fuse: fuse@e6078800 {
-            compatible = "renesas,r8a779a0-efuse";
-            reg = <0xe6078800 0x100>;
-            clocks = <&cpg CPG_MOD 916>;
-            power-domains = <&sysc R8A779A0_PD_ALWAYS_ON>;
-            resets = <&cpg 916>;
+    #include <dt-bindings/clock/r8a779f0-cpg-mssr.h>
+    #include <dt-bindings/power/r8a779f0-sysc.h>
+
+    fuse@e6078800 {
+        compatible = "renesas,r8a779f0-efuse";
+        reg = <0xe6078800 0x200>;
+        clocks = <&cpg CPG_MOD 915>;
+        power-domains = <&sysc R8A779F0_PD_ALWAYS_ON>;
+        resets = <&cpg 915>;
+
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            calib@144 {
+                reg = <0x144 0x08>;
+            };
+        };
     };
diff --git a/Documentation/devicetree/bindings/fuse/renesas,rcar-otp.yaml b/Documentation/devicetree/bindings/nvmem/renesas,rcar-otp.yaml
similarity index 60%
rename from Documentation/devicetree/bindings/fuse/renesas,rcar-otp.yaml
rename to Documentation/devicetree/bindings/nvmem/renesas,rcar-otp.yaml
index d74872ae9ff3..3313c03ea68d 100644
--- a/Documentation/devicetree/bindings/fuse/renesas,rcar-otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/renesas,rcar-otp.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/fuse/renesas,rcar-otp.yaml#
+$id: http://devicetree.org/schemas/nvmem/renesas,rcar-otp.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: R-Car E-FUSE connected to OTP_MEM
@@ -13,6 +13,9 @@ description:
   The E-FUSE is a type of non-volatile memory, which is accessible through the
   One-Time Programmable Memory (OTP_MEM) module on some R-Car Gen4 SoCs.
 
+allOf:
+  - $ref: nvmem.yaml#
+
 properties:
   compatible:
     enum:
@@ -22,17 +25,19 @@ properties:
   reg:
     items:
       - description: OTP_MEM_0
-      - description: OTP_MEM_1
+      - description: OTP_MEM_1.
+          The addresses of cells defined under the optional nvmem-layout
+          subnode are relative to this register bank.
 
 required:
   - compatible
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-    otp: otp@e61be000 {
-            compatible = "renesas,r8a779g0-otp";
-            reg = <0xe61be000 0x1000>, <0xe61bf000 0x1000>;
+    otp@e61be000 {
+        compatible = "renesas,r8a779g0-otp";
+        reg = <0xe61be000 0x1000>, <0xe61bf000 0x1000>;
     };
diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..269529b370a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2916,6 +2916,7 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
 F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
+F:	Documentation/devicetree/bindings/nvmem/renesas,*
 F:	Documentation/devicetree/bindings/soc/renesas/
 F:	arch/arm/boot/dts/renesas/
 F:	arch/arm/configs/shmobile_defconfig
-- 
2.25.1


