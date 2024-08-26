Return-Path: <linux-kernel+bounces-301518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F295F208
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7B1F23F09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F51865FD;
	Mon, 26 Aug 2024 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuybHtF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8F155A43;
	Mon, 26 Aug 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676492; cv=none; b=lyU0ZY1yiwlfrBYfYmrqiGOxmzvKiu7kl9HVrrsB9A+pXXr4mprqmO06IUavhe9SEr4HGeD7kkIiJj+iRcDphNMeqJWU66Tp+2XQSHVvHFOBp5Hfl2rV2jE6dN2wTHgEmlx/obXI2852siuuam/0QQ3s2iOrrg2wQMUjD62AXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676492; c=relaxed/simple;
	bh=vIc3CjymiCxc/rWgM8Rdk5oh2gtNDlRqS9o5BN/ii6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9GWNA1OTqFYdYtVlBDVPz4+bGl3oHxnwO905mILPhvD9A2bZuvrJWnIPVGmnROKEGDKBlo1YxWdGznm4x3lWfMTE45f1WTbalzFVmRT6TqLSuUggelL1OkazCSgNAOos0OO5ypR4m/jUKklVOATydcJC7iCEEPdxSLxhz7+XLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuybHtF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E1EC51429;
	Mon, 26 Aug 2024 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724676492;
	bh=vIc3CjymiCxc/rWgM8Rdk5oh2gtNDlRqS9o5BN/ii6w=;
	h=From:To:Cc:Subject:Date:From;
	b=kuybHtF0dPOYVzEMclFokkYXL/arB3vs50wrzl+k+txjBQ6rCLwkYmxE9hP6GeYhZ
	 kg6fQ6KDlc/5lOL2ZMjNILKSX7w1hhM6Fz2K9q3vMW4FfWTKuFGUApmWP30ZmZeqPJ
	 d3Y6eLCvwU4EjEQlcSm3NncVLOABJJH6lbyEBkP7ZBJdT7Rb8NcAhimE2A+Qlu4nyC
	 tLBzPIPeL2Rzg7xI6ZD13D0KDtuN+unTpo3JesP+TGdxNz3+m98t74j5gMAGHivGbX
	 JMnjtBUOgwqqzYxirxtQUUF9TAfn4YCD1AcmYG3ALJ+cU9NChO1z1z9VhU6iyc9Hb/
	 MM0UhxubzRVbQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] of: move empty_root and unittest data DTBs to .init.rodata section
Date: Mon, 26 Aug 2024 21:48:01 +0900
Message-ID: <20240826124802.1552738-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures can embed DTB(s) in vmlinux. Most of them expect a
single DTB in the .dtb.init.rodata section.

For example, RISC-V previously allowed embedding multiple DTBs in
vmlinux, but only the first DTB in the .dtb.init.rodata section was
used. Which DTB was used was unpredictable, as it depended on the link
order (i.e., the order in Makefile).

Commit 2672031b20f6 ("riscv: dts: Move BUILTIN_DTB_SOURCE to common
Kconfig") changed the Makefiles to ensure only one DTB is embedded.

However, commit 7b937cc243e5 ("of: Create of_root if no dtb provided by
firmware") introduced another DTB into the .dtb.init.rodata section.

Since then, the symbol dump (sorted by address) for ARCH=riscv
nommu_k210_defconfig is as follows:

    00000000801290e0 D __dtb_k210_generic_begin
    00000000801290e0 D __dtb_start
    000000008012b571 D __dtb_k210_generic_end
    000000008012b580 D __dtb_empty_root_begin
    000000008012b5c8 D __dtb_empty_root_end
    000000008012b5e0 D __dtb_end

The .dtb.init.rodata section now contains the following two DTB files:

    arch/riscv/boot/dts/canaan/k210_generic.dtb
    drivers/of/empty_root.dtb

This is not an immediate problem because the boot code picks up the
first DTB. The second one, empty_root.dtb is just ignored.

However, as mentioned above, it is fragile to rely on the link order,
as future Makefile changes may break the behavior.

The cmd_wrap_S_dtb rule in scripts/Makefile.lib is used for embedding a
DTB into the .dtb.init.rodata, so that the arch boot code can find it by
the __dtb_start symbol.

empty_root.dtb is looked up by its own symbol, so it does not need to
be located in the .dtb.init.rodata. It can be moved to the .init.rodata
section.

When CONFIG_OF_UNITTEST is enabled, more unittest DTBOs are embedded in
the .dtb.init.rodata section. These are also looked up by name and for
generic purposes, so they can be moved to the .init.rodata section as
well.

I added a wrapper source file, drivers/of/empty_root_dtb.S, because this
is the only wrapper used in driver/of/Makefile. I moved the rule for
generating *.dtbo.S to drivers/of/unittest-data/Makefile because it is
not used anywhere else.

I added the __initdata annotation to the overlay_info data array to
avoid section mismatch warnings. The .dtb.init.rodata section is not
checked by modpost, even though it is discarded after the early boot
stage.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 drivers/of/Makefile               |  4 +++-
 drivers/of/empty_root_dtb.S       | 11 +++++++++++
 drivers/of/fdt.c                  |  4 ----
 drivers/of/unittest-data/Makefile | 20 ++++++++++++++++++++
 drivers/of/unittest.c             |  6 +++---
 scripts/Makefile.build            |  2 --
 scripts/Makefile.lib              |  5 +----
 7 files changed, 38 insertions(+), 14 deletions(-)
 create mode 100644 drivers/of/empty_root_dtb.S

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 251d33532148..c6eb4f6df6e6 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,7 +2,9 @@
 obj-y = base.o cpu.o device.o module.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
-obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root.dtb.o
+obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root_dtb.o
+$(obj)/empty_root_dtb.o: $(obj)/empty_root.dtb
+targets += empty_root.dtb
 obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
 obj-$(CONFIG_OF_PROMTREE) += pdt.o
 obj-$(CONFIG_OF_ADDRESS)  += address.o
diff --git a/drivers/of/empty_root_dtb.S b/drivers/of/empty_root_dtb.S
new file mode 100644
index 000000000000..482d6a33f4ae
--- /dev/null
+++ b/drivers/of/empty_root_dtb.S
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <asm-generic/vmlinux.lds.h>
+
+.section .init.rodata,"a"
+.balign STRUCT_ALIGNMENT
+.global __dtb_empty_root_begin
+__dtb_empty_root_begin:
+.incbin "drivers/of/empty_root.dtb"
+.global __dtb_empty_root_end
+__dtb_empty_root_end:
+.balign STRUCT_ALIGNMENT
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 68103ad230ee..f719256988eb 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -32,10 +32,6 @@
 
 #include "of_private.h"
 
-/*
- * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created by
- * cmd_dt_S_dtb in scripts/Makefile.lib
- */
 extern uint8_t __dtb_empty_root_begin[];
 extern uint8_t __dtb_empty_root_end[];
 
diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 01a966e39f23..fe280a36cf88 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -104,3 +104,23 @@ static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
 static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
 
 dtb-$(CONFIG_OF_OVERLAY) += static_test_1.dtb static_test_2.dtb
+
+# Generate an assembly file to wrap the output of the device tree compiler
+quiet_cmd_wrap_S_dtbo = WRAP    $@
+      cmd_wrap_S_dtbo = {					\
+		echo '\#include <asm-generic/vmlinux.lds.h>';	\
+		echo '.section .init.rodata,"a"';		\
+		echo '.balign STRUCT_ALIGNMENT';		\
+		echo '.global __dtbo_$*_begin';			\
+		echo '__dtbo_$*_begin:';			\
+		echo '.incbin "$<"';				\
+		echo '.global __dtbo_$*_end';			\
+		echo '__dtbo_$*_end:';				\
+		echo '.balign STRUCT_ALIGNMENT';		\
+	} > $@
+
+$(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
+	$(call if_changed,wrap_S_dtbo)
+
+targets += $(foreach x, dtbo.S dtbo, \
+              $(patsubst %.dtbo.o,%.$(x), $(filter %.dtbo.o, $(obj-y))))
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index c830f346df45..21ee856e9d74 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1861,7 +1861,7 @@ static int __init unittest_data_add(void)
 	struct device_node *unittest_data_node = NULL, *np;
 	/*
 	 * __dtbo_testcases_begin[] and __dtbo_testcases_end[] are magically
-	 * created by cmd_dt_S_dtbo in scripts/Makefile.lib
+	 * created by cmd_wrap_S_dtbo in drivers/of/unittest-data/Makefile
 	 */
 	extern uint8_t __dtbo_testcases_begin[];
 	extern uint8_t __dtbo_testcases_end[];
@@ -3525,7 +3525,7 @@ static void __init of_unittest_lifecycle(void)
 
 /*
  * __dtbo_##overlay_name##_begin[] and __dtbo_##overlay_name##_end[] are
- * created by cmd_dt_S_dtbo in scripts/Makefile.lib
+ * created by cmd_wrap_S_dtbo in drivers/of/unittest-data/Makefile
  */
 
 #define OVERLAY_INFO_EXTERN(overlay_name) \
@@ -3585,7 +3585,7 @@ OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 OVERLAY_INFO_EXTERN(overlay_bad_unresolved);
 
 /* entries found by name */
-static struct overlay_info overlays[] = {
+static __initdata struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999, 0),
 	OVERLAY_INFO(overlay, 0, 0),
 	OVERLAY_INFO(overlay_0, 0, 0),
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a5ac8ed1936f..d0dfdf043ce2 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -451,12 +451,10 @@ intermediate_targets = $(foreach sfx, $(2), \
 					$(filter %$(strip $(1)), $(targets))))
 # %.asn1.o <- %.asn1.[ch] <- %.asn1
 # %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
-# %.dtbo.o <- %.dtbo.S <- %.dtbo <- %.dtso
 # %.lex.o <- %.lex.c <- %.l
 # %.tab.o <- %.tab.[ch] <- %.y
 targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
-	   $(call intermediate_targets, .dtbo.o, .dtbo.S .dtbo) \
 	   $(call intermediate_targets, .lex.o, .lex.c) \
 	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 207325eaf1d1..a5584ca72857 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -382,7 +382,7 @@ DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_wrap_S_dtb = WRAP    $@
       cmd_wrap_S_dtb = {								\
-		symbase=__$(patsubst .%,%,$(suffix $<))_$(subst -,_,$(notdir $*));	\
+		symbase=__dtb_$(subst -,_,$(notdir $*));				\
 		echo '\#include <asm-generic/vmlinux.lds.h>';				\
 		echo '.section .dtb.init.rodata,"a"';					\
 		echo '.balign STRUCT_ALIGNMENT';					\
@@ -397,9 +397,6 @@ quiet_cmd_wrap_S_dtb = WRAP    $@
 $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
 	$(call if_changed,wrap_S_dtb)
 
-$(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
-	$(call if_changed,wrap_S_dtb)
-
 quiet_dtb_check_tag = $(if $(dtb-check-enabled),[C],   )
 cmd_dtb_check = $(if $(dtb-check-enabled),; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true)
 
-- 
2.43.0


