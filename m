Return-Path: <linux-kernel+bounces-270040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAB7943A8A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 02:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFBF1C21328
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B6E14B94F;
	Thu,  1 Aug 2024 00:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqXl2YJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A2314B083;
	Thu,  1 Aug 2024 00:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470950; cv=none; b=tjO83+Sm0OoqD0PL3F8Z2fRH+P7+CthBAjotuNEkQ9bG0Imvdv7roUABbldSi5G0ZBbFj1mY9TOWOhM8fSvzHL3ZGO2cQbOg13aB84T34GmN1lZjpDX4Kui3T5upAEHq08AUJhlSN5igxN/t2TQ/EGWvb/p7n9bEJX8IWKLantg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470950; c=relaxed/simple;
	bh=BnmAT9t/c5IIktW7mx1EDTKEy8RKB4RK+wsZKxEJOuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbPoxVrhSWD74AKNcQ6RGiQZS480EPsFYYk4P/T17HMMGRz+E55cTsIt6E106dV4xz7sw2KfjC2CjUM9vbYBe3pZJCBIzAr7vHPCwadJGzSJ6vXNA5pO6Fdcdd34u/0oNNs/nmdz2L3bW0uS+IMAkaitfQHvBlDOUtEzaqEJZxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqXl2YJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75ACC4AF0E;
	Thu,  1 Aug 2024 00:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470949;
	bh=BnmAT9t/c5IIktW7mx1EDTKEy8RKB4RK+wsZKxEJOuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqXl2YJctV4+2BxtsudvILdtsnrDRujuYFcK21c61VUzWMO6s8gKoKdd6VeU4Zh2/
	 NOw7F1yFbCrIMM1ZZUQchqSucqHSSNIeGOB76yTwVyzMzP9fCFHfv5FQdktcziyCGc
	 7/XrrIn5Wr2cuYEgMu96XF3nvzAJKc0ULuQg9VontBVIBpcSizZfcHUOiK1O4cVeX/
	 zkpPIsldXC0oz+htxFFvBkvp5f98umynm8rZXHVYtdFTUdlSlMBihqDzA4YtnNTOlr
	 WHJKAPxP9z8+9kdAcXAvGKj9CDYKdTHccKcEmTHd9GQPNs4MWOTLTmwIXH4mC17kUZ
	 N0li3AXJWwPdA==
From: Danilo Krummrich <dakr@kernel.org>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	akpm@linux-foundation.org
Cc: daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com,
	lina@asahilina.net,
	mcanal@igalia.com,
	zhiw@nvidia.com,
	acurrid@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	airlied@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v3 25/25] kbuild: rust: remove the `alloc` crate
Date: Thu,  1 Aug 2024 02:02:24 +0200
Message-ID: <20240801000641.1882-26-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801000641.1882-1-dakr@kernel.org>
References: <20240801000641.1882-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have our own `Allocator`, `Box` and `Vec` types we can remove
Rust's `alloc` crate and the corresponding unstable features.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/Makefile          | 44 ++++++++++--------------------------------
 rust/exports.c         |  1 -
 scripts/Makefile.build |  7 +------
 3 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 1f10f92737f2..8900c3d06573 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -15,9 +15,8 @@ always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
 always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
-always-$(CONFIG_RUST) += exports_alloc_generated.h exports_bindings_generated.h \
-    exports_kernel_generated.h
+obj-$(CONFIG_RUST) += bindings.o kernel.o
+always-$(CONFIG_RUST) += exports_bindings_generated.h exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
@@ -53,11 +52,6 @@ endif
 core-cfgs = \
     --cfg no_fp_fmt_parse
 
-alloc-cfgs = \
-    --cfg no_global_oom_handling \
-    --cfg no_rc \
-    --cfg no_sync
-
 quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
@@ -80,7 +74,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # command-like flags to solve the issue. Meanwhile, we use the non-custom case
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
-    rustdoc-alloc rustdoc-kernel
+    rustdoc-kernel
 	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/static.files/
 	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/static.files/
 	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
@@ -104,20 +98,11 @@ rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
 rustdoc-compiler_builtins: $(src)/compiler_builtins.rs rustdoc-core FORCE
 	+$(call if_changed,rustdoc)
 
-# We need to allow `rustdoc::broken_intra_doc_links` because some
-# `no_global_oom_handling` functions refer to non-`no_global_oom_handling`
-# functions. Ideally `rustdoc` would have a way to distinguish broken links
-# due to things that are "configured out" vs. entirely non-existing ones.
-rustdoc-alloc: private rustc_target_flags = $(alloc-cfgs) \
-    -Arustdoc::broken_intra_doc_links
-rustdoc-alloc: $(RUST_LIB_SRC)/alloc/src/lib.rs rustdoc-core rustdoc-compiler_builtins FORCE
-	+$(call if_changed,rustdoc)
-
-rustdoc-kernel: private rustc_target_flags = --extern alloc \
+rustdoc-kernel: private rustc_target_flags = \
     --extern build_error --extern macros=$(objtree)/$(obj)/libmacros.so \
     --extern bindings --extern uapi
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-macros \
-    rustdoc-compiler_builtins rustdoc-alloc $(obj)/libmacros.so \
+    rustdoc-compiler_builtins $(obj)/libmacros.so \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustdoc)
 
@@ -161,7 +146,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_flags) \
-		-L$(objtree)/$(obj) --extern alloc --extern kernel \
+		-L$(objtree)/$(obj) --extern kernel \
 		--extern build_error --extern macros \
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
@@ -197,7 +182,7 @@ rusttest-macros: $(src)/macros/lib.rs FORCE
 	+$(call if_changed,rustc_test)
 	+$(call if_changed,rustdoc_test)
 
-rusttest-kernel: private rustc_target_flags = --extern alloc \
+rusttest-kernel: private rustc_target_flags = \
     --extern build_error --extern macros --extern bindings --extern uapi
 rusttest-kernel: $(src)/kernel/lib.rs \
     rusttestlib-build_error rusttestlib-macros rusttestlib-bindings \
@@ -310,9 +295,6 @@ quiet_cmd_exports = EXPORTS $@
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
 
-$(obj)/exports_alloc_generated.h: $(obj)/alloc.o FORCE
-	$(call if_changed,exports)
-
 $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 	$(call if_changed,exports)
 
@@ -348,7 +330,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
-		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
+		--cfgs='core=$(core-cfgs)' \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
@@ -380,12 +362,6 @@ $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_dep,rustc_library)
 
-$(obj)/alloc.o: private skip_clippy = 1
-$(obj)/alloc.o: private skip_flags = -Wunreachable_pub
-$(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
-$(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORCE
-	+$(call if_changed_dep,rustc_library)
-
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_dep,rustc_library)
 
@@ -400,9 +376,9 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/uapi/uapi_generated.rs FORCE
 	+$(call if_changed_dep,rustc_library)
 
-$(obj)/kernel.o: private rustc_target_flags = --extern alloc \
+$(obj)/kernel.o: private rustc_target_flags = \
     --extern build_error --extern macros --extern bindings --extern uapi
-$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/alloc.o $(obj)/build_error.o \
+$(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/build_error.o \
     $(obj)/libmacros.so $(obj)/bindings.o $(obj)/uapi.o FORCE
 	+$(call if_changed_dep,rustc_library)
 
diff --git a/rust/exports.c b/rust/exports.c
index 3803c21d1403..1b870e8e83ea 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -16,7 +16,6 @@
 #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
 
 #include "exports_core_generated.h"
-#include "exports_alloc_generated.h"
 #include "exports_bindings_generated.h"
 #include "exports_kernel_generated.h"
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index efacca63c897..7e7b6b3d5bb9 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -262,18 +262,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
 
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
-
-rust_allowed_features := new_uninit
-
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
 # modules case.
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
-	-Zallow-features=$(rust_allowed_features) \
 	-Zcrate-attr=no_std \
-	-Zcrate-attr='feature($(rust_allowed_features))' \
-	-Zunstable-options --extern force:alloc --extern kernel \
+	-Zunstable-options --extern kernel \
 	--crate-type rlib -L $(objtree)/rust/ \
 	--crate-name $(basename $(notdir $@)) \
 	--sysroot=/dev/null \
-- 
2.45.2


