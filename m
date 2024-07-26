Return-Path: <linux-kernel+bounces-263321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C41493D450
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363721C235F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879DA17CA14;
	Fri, 26 Jul 2024 13:38:27 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BF517C228
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722001106; cv=none; b=t3q48RbrpYhzDsIxzCKP7mUY3JgpAfnFJtOlw8IHaZvuIBFvYkdcOCJgcSOvOO0XBZfF/3FzwuEvbDBp7NenjR6ZJ+GBtm9fAbK7rTOn5yYynOJnwJJG0AqeCRW/4RQSTnRQb6HHakOMout4k3zXwF589TMoogEsg+BMS+II7uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722001106; c=relaxed/simple;
	bh=IXfAVBJha6O3Zh7HSFhjOKoC8w06/OB1c3mV0auwAxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TvXEnLrABs+GoIjn4M6EeH5C/UyzuzJZfHfvjAVHq1h4yBfFW7Oi1c5UlOVP4vVjeLfWzI6MnR38Kj4cPPBjrNCDb47zGVRGF4Ye1Yqu1OiCfkGnYSyP22KnVxie0YPRYXdHDXPt1QxesuMm6/qTY7FQ6Fob9n4PF07i8n++Shc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:3d94:87cf:603a:d7ae])
	by andre.telenet-ops.be with bizsmtp
	id sDeE2C0041mGjv501DeEKr; Fri, 26 Jul 2024 15:38:15 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sXL8p-003cLz-Qo;
	Fri, 26 Jul 2024 15:38:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sXL9B-004G6G-Ja;
	Fri, 26 Jul 2024 15:38:13 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/7] dt-bindings: fuse: Move renesas,rcar-{efuse,otp} to nvmem
Date: Fri, 26 Jul 2024 15:38:06 +0200
Message-Id: <1a3d4ff8ce34a5e676d1cb1fafd40525378e29a4.1721999833.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721999833.git.geert+renesas@glider.be>
References: <cover.1721999833.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The R-Car E-FUSE blocks can be modelled better using the nvmem
framework.

Replace the R-Car V3U example by an R-Car S4-8 ES1.2 example, to show
the definition of nvmem cells.  While at it, drop unneeded labels from
the examples, and fix indentation.

Add an entry to the MAINTAINERS file.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - New.

I would expect that the calib@144 node needs:

    #nvmem-cell-cells = <0>;

but after adding that, "make dt_binding_check" starts complaining:

    Documentation/devicetree/bindings/nvmem/renesas,rcar-efuse.example.dtb: fuse@e6078800: nvmem-layout: 'oneOf' conditional failed, one must be fixed:
	    '#address-cells', '#size-cells', 'calib@144' do not match any of the regexes: 'pinctrl-[0-9]+'
	    Unevaluated properties are not allowed ('nvmem-cell-cells' was unexpected)
	    'kontron,sl28-vpd' was expected
	    'onie,tlv-layout' was expected
	    from schema $id: http://devicetree.org/schemas/nvmem/renesas,rcar-efuse.yaml#
    Documentation/devicetree/bindings/nvmem/renesas,rcar-efuse.example.dtb: fuse@e6078800: nvmem-layout: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'calib@144' were unexpected)
	    from schema $id: http://devicetree.org/schemas/nvmem/renesas,rcar-efuse.yaml#
    Documentation/devicetree/bindings/nvmem/renesas,rcar-efuse.example.dtb: fuse@e6078800: Unevaluated properties are not allowed ('nvmem-layout' was unexpected)
	    from schema $id: http://devicetree.org/schemas/nvmem/renesas,rcar-efuse.yaml#
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
index d7e289244e72cce1..ce7d65afa4602537 100644
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
index d74872ae9ff378f9..3313c03ea68dfd57 100644
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
index 990aced7e7a57e1f..8da9c4ee231b4db4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2794,6 +2794,7 @@ Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
 F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
+F:	Documentation/devicetree/bindings/nvmem/renesas,*
 F:	Documentation/devicetree/bindings/soc/renesas/
 F:	arch/arm/boot/dts/renesas/
 F:	arch/arm/configs/shmobile_defconfig
-- 
2.34.1


