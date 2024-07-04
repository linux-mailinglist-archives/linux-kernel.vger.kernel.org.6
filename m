Return-Path: <linux-kernel+bounces-241480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A0B927BB8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C2288BC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915311D3634;
	Thu,  4 Jul 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axvdwXMO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614E1B6A4F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112983; cv=none; b=bU4BhvUrUHq+5bZGrEeviRK0QIyUpRIBE1NZSxC4Xrlx07JtPW7+73BID/tE3ee9SJkJMbBQfhVYr0nUQboRtozKNTGuhglMbTqxJoJ1aEASo02lik/rgqGEhJxQT6nsI58IHbB1un1nk4n7J/5+lNuhenOD84MVlvFcOCpIaG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112983; c=relaxed/simple;
	bh=bsriniNdpX6h5/yDL9FxdgsDYScO2q5NtPU4YXaim9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZUxAhifVlAzLDhc0lLnId7rRSaNeh9PIW1c+UFWD9vOep3aqOAexEKmm9+86KsBOlGpVFdVBsxJHS9T8LkGz8DL4zu7E4k6PAUCQGhY26gPAgcyKnEmJ5UTMiBAinAmMbXHxWXtU6wv25pXg56zipmh0pB/TxaBh06WfSutw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axvdwXMO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720112980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYIznhyjauFiWydkaqs7Zncv4tbDnSQ032ir9VqSIpY=;
	b=axvdwXMOnv1nEruCYI1ZxVT+l94kd+piPpLK39dH0QcVXMShjCzchbV++v3AEDBJlh47ab
	mq7Sdwnwl/5MNgr8iuyrdne+Btm3wHl2BIuYeYnu2vyZdkf39O94mr/9XE8rlAqjKMnRYl
	4CYpMs6mbRF5Y2HpoJ5kjJmnhBklNlE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-6QiDWvzAOs2Su_xAdoNmMA-1; Thu, 04 Jul 2024 13:09:39 -0400
X-MC-Unique: 6QiDWvzAOs2Su_xAdoNmMA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52ea3c7dfdcso150816e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 10:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720112977; x=1720717777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xYIznhyjauFiWydkaqs7Zncv4tbDnSQ032ir9VqSIpY=;
        b=J4eyjTALnQywnYuXcBTvqKT9nHA2iNxg/vL/gx9xKhQESDKowIxvzqy08kt0tkpQfQ
         2BfUy7EXX3s7C+2QkspFQdhoYCtAgEJTflVqAK5Owh+eLi5pHnANUvevJ/Ylr3tZFxjX
         aVIs8H0R+PlqPjVLAQUMIu6v6f1YQaqJ5KES5RpHM9wJO1J8+nGQzAYwR8gSongQLsov
         A24AWybji0YrA3706VCr30Zk9oGqgNu3AzNGtiQNUEGwiDUrvT0HMsKB/6V2OzhaaR/f
         slYnv0Yd3zScGBYpzI4rb87s4VeRqEFh0fTp0C8pYNHqgWwmNQaiBiQvNTlHNtnINtEv
         hWrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsO3Ka3ttPshnSdUDoVZ8XRcclX3j7FcI+Lr12dtSUGqm7tbJ9rrCGqubB1MSyVbPYSygBR3eWAA+4+4vUh3VZhfF/RBexFdXrvuEf
X-Gm-Message-State: AOJu0YxeToKNxqDNxRKj8d2c6/P/XlxTyYfIJtzeOqMFdTfxCiAySFnS
	gERct6rM7Hg1x9aOolVUw0AWsEqoTSrjARSvoUMaZ9G15LP9JFfOZbTrYBWCxm1yoHn0A9Ti9vL
	5V/l13vZF6F7c6+tf+LBY/9Ce5823Z3Ra+BCmu491B9j8old0QAAWB7q/QKxL/A==
X-Received: by 2002:ac2:5b0e:0:b0:52e:9fda:f18a with SMTP id 2adb3069b0e04-52ea06cbe66mr1511996e87.44.1720112977587;
        Thu, 04 Jul 2024 10:09:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX6ONW2CA5btbaQ6QdRa6JyXEnGgf0cFnmiUOxEATBml1XRR3xBl1VWyuUT+INBga4rn8Mvw==
X-Received: by 2002:ac2:5b0e:0:b0:52e:9fda:f18a with SMTP id 2adb3069b0e04-52ea06cbe66mr1511908e87.44.1720112975258;
        Thu, 04 Jul 2024 10:09:35 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a283577sm31189545e9.44.2024.07.04.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:09:34 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
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
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH 20/20] kbuild: rust: remove the `alloc` crate
Date: Thu,  4 Jul 2024 19:06:48 +0200
Message-ID: <20240704170738.3621-21-dakr@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704170738.3621-1-dakr@redhat.com>
References: <20240704170738.3621-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have our own `Allocator`, `KBox` and `KVec` we can remove
Rust's `alloc` crate and the corresponding unstable features.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/Makefile          | 44 ++++++++++--------------------------------
 rust/exports.c         |  1 -
 scripts/Makefile.build |  7 +------
 3 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index f70d5e244fee..409be08ad09a 100644
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
@@ -60,11 +59,6 @@ endif
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
@@ -87,7 +81,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 # command-like flags to solve the issue. Meanwhile, we use the non-custom case
 # and then retouch the generated files.
 rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
-    rustdoc-alloc rustdoc-kernel
+    rustdoc-kernel
 	$(Q)cp $(srctree)/Documentation/images/logo.svg $(rustdoc_output)/static.files/
 	$(Q)cp $(srctree)/Documentation/images/COPYING-logo $(rustdoc_output)/static.files/
 	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
@@ -111,20 +105,11 @@ rustdoc-core: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
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
 
@@ -169,7 +154,7 @@ quiet_cmd_rustdoc_test_kernel = RUSTDOC TK $<
 	mkdir -p $(objtree)/$(obj)/test/doctests/kernel; \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) --test $(rust_flags) \
-		-L$(objtree)/$(obj) --extern alloc --extern kernel \
+		-L$(objtree)/$(obj) --extern kernel \
 		--extern build_error --extern macros \
 		--extern bindings --extern uapi \
 		--no-run --crate-name kernel -Zunstable-options \
@@ -251,7 +236,7 @@ rusttest-macros: $(src)/macros/lib.rs rusttest-prepare FORCE
 	+$(call if_changed,rustc_test)
 	+$(call if_changed,rustdoc_test)
 
-rusttest-kernel: private rustc_target_flags = --extern alloc \
+rusttest-kernel: private rustc_target_flags = \
     --extern build_error --extern macros --extern bindings --extern uapi
 rusttest-kernel: $(src)/kernel/lib.rs rusttest-prepare \
     rusttestlib-build_error rusttestlib-macros rusttestlib-bindings \
@@ -364,9 +349,6 @@ quiet_cmd_exports = EXPORTS $@
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
 
-$(obj)/exports_alloc_generated.h: $(obj)/alloc.o FORCE
-	$(call if_changed,exports)
-
 $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 	$(call if_changed,exports)
 
@@ -402,7 +384,7 @@ quiet_cmd_rustc_library = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) L
 
 rust-analyzer:
 	$(Q)$(srctree)/scripts/generate_rust_analyzer.py \
-		--cfgs='core=$(core-cfgs)' --cfgs='alloc=$(alloc-cfgs)' \
+		--cfgs='core=$(core-cfgs)' \
 		$(realpath $(srctree)) $(realpath $(objtree)) \
 		$(RUST_LIB_SRC) $(KBUILD_EXTMOD) > \
 		$(if $(KBUILD_EXTMOD),$(extmod_prefix),$(objtree))/rust-project.json
@@ -434,12 +416,6 @@ $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_dep,rustc_library)
 
-$(obj)/alloc.o: private skip_clippy = 1
-$(obj)/alloc.o: private skip_flags = -Dunreachable_pub
-$(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
-$(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORCE
-	+$(call if_changed_dep,rustc_library)
-
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_dep,rustc_library)
 
@@ -454,9 +430,9 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
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


