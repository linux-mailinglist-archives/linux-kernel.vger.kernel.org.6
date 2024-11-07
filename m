Return-Path: <linux-kernel+bounces-399230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28CC9BFC5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 03:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F8611C2289F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244C54EB51;
	Thu,  7 Nov 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsHHVtxC"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96688405F7;
	Thu,  7 Nov 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945328; cv=none; b=OcDcIiWoIeOfbyIwf7z70GhKZclJbfP1tUPXR9h0sw+YxgT1899Z60fbqJbBsprwRlMQ2GfJiZmRJXEV3xiHrPJq5vuE+7sYCmnN/W2ugPpx1LJeiVONSoTCSqGR4qy/VT+/UyjzhUi60d+02EsFWvMlF8Mkz+mqdO+yZ0/3YyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945328; c=relaxed/simple;
	bh=7cu9PKpMg7PIT036BMkB/S+nqDpY4cTVeq6Cz3UwXuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVLk8kHDbP3mXAxEszVUbqwPOYGxtiS65I2KVPRDNCcLE6NyDY/z/wZu07xE3QJpqEmvgezKQMeSiV9I6tO+trLntHY+pC/x1+fRozhoh3L0DIWGLicYOnXGyGfEb4jAj6bCeP7KfIU2I7UN+dX4KL0574oIQ4+vBV3yx4Ps9rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsHHVtxC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ee4c57b037so404606a12.0;
        Wed, 06 Nov 2024 18:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730945326; x=1731550126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8uiK/Ic0Cv9zs1Cmhd/sJuJ73EalyYXJTfTOVDE8k0=;
        b=GsHHVtxCI+j86hBbEPkmNbB16vM1dfdgvSn0piIWNTc2p0aj2rLbMVlRCnkyCj9HIM
         iHsC42vnXLgSoK3XB3/GNiyiwQh4g5/HqwnZRfLefxZClSK7l109kZMO818Bh6fyE6z0
         L/y9swG3cyxXs8an+1927FladQLJMsXnclrCHbmnzVvHyljw9c4inRlQq0J499V0OusW
         0izhHRLTzKtFYvjhqjyYcrD0LXCiCZZEETFDxHLsWZX76JyeYoMjGaQR6eWxMA6cVES/
         nO3FTiUu0IGZBlUTYU1NK8eHmdYkGo4TxPi0/7ssrklW6evfX6/PojWrrND201n2rG0e
         hJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945326; x=1731550126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8uiK/Ic0Cv9zs1Cmhd/sJuJ73EalyYXJTfTOVDE8k0=;
        b=BR/6IEnBV3n9Dp0mTTtYOSx/Nn4uhGg3KcIuLVDxDMwZke8dC/LMcROzHurF5/EAo7
         ZQPtEYFjLIsfvcJndymmKvtOn6gInNjxumCcOTUA5rV/4h5BZv999SrorHTPx3C/f/TJ
         SHun32cM+lw9vEMUroCuQrnHdmxFD0Xjjli1bn+febhY8MZ4rCc5Y/wuMlYf2efkL2tR
         ilaSw7vWeInNbu8M+lccRjJKyPzWGay3ynJGPXQgmguKJSVwu9b0L93/keWTZFCh5311
         27aAFw+C43sZ8CnYa63zWPFq3pjh/bPhMvUmLt9YGJvAuGLy4wKw+BZ1rXKHfByZGNAl
         SBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzS2ll5Dy5IYUehOayXpoourJFcq2twbTA/ijxLnuChhmTKa4ZLssDDUJJBU13BE2aWO/vqqLkJyZo0u4=@vger.kernel.org, AJvYcCXRr7F3dTE2/06NoPoZQrBkl0fu6Fu42nkjkq5/+LA5kK0LGmBGkiuz3ahReoEVvlD2o9Ddxo7SO102pH+C4xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0NHJyWw7hwt6gXbisO3ZJBDFeXUga6R7PLHtDH3oT6RIg/kY
	sMSy/az2npdpab9Lqq5NQIuQ5TAhkEG+4EuFauttqhj3qCivtd6d
X-Google-Smtp-Source: AGHT+IHSZ18e093uRS+GpjjWCpbTJ2osSEj2Jz1jCRDcfKw2MooH+iEJg9ij210Kp4gtbGIk81dMww==
X-Received: by 2002:a17:90b:48c4:b0:2e2:d17e:1ef7 with SMTP id 98e67ed59e1d1-2e94c298d32mr29364096a91.3.1730945325807;
        Wed, 06 Nov 2024 18:08:45 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5f98b3sm2549916a91.32.2024.11.06.18.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 18:08:45 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	me@kloenk.dev,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	aliceryhl@google.com
Cc: alistair23@gmail.com
Subject: [PATCH 01/13] rust: bindings: Support some inline static functions
Date: Thu,  7 Nov 2024 12:08:19 +1000
Message-ID: <20241107020831.1561063-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107020831.1561063-1-alistair.francis@wdc.com>
References: <20241107020831.1561063-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The kernel includes a large number of static inline functions that are
defined in header files. One example is the crypto_shash_descsize()
function which is defined in hash.h as

static inline unsigned int crypto_shash_descsize(struct crypto_shash *tfm)
{
	return tfm->descsize;
}

bindgen is currently unable to generate bindings to these functions as
they are not publically exposed (they are static after all).

The Rust code currently uses rust_helper_* functions, such as
rust_helper_alloc_pages() for example to call the static inline
functions. But this is a hassle as someone needs to write a C helper
function.

Instead we can use the bindgen wrap-static-fns feature. The feature
is marked as experimental, but has recently been promoted to
non-experimental (dependig on your version of bindgen).

By supporting wrap-static-fns we automatically generate a C file called
extern.c that exposes the static inline functions, for example like this

```
unsigned int crypto_shash_descsize__extern(struct crypto_shash *tfm) { return crypto_shash_descsize(tfm); }
```

The nice part is that this is auto-generated.

We then also get a bindings_generate_static.rs file with the Rust
binding, like this

```
extern "C" {
    #[link_name = "crypto_shash_descsize__extern"]
    pub fn crypto_shash_descsize(tfm: *mut crypto_shash) -> core::ffi::c_uint;
}
```

So now we can use the static inline functions just like normal
functions.

There are a bunch of static inline functions that don't work though, because
the C compiler fails to build extern.c:
 * functions with inline asm generate "operand probably does not match constraints"
   errors (rip_rel_ptr() for example)
 * functions with bit masks (u32_encode_bits() and friends) result in
   "call to ‘__bad_mask’ declared with attribute error: bad bitfield mask"
   errors

As well as that any static inline function that calls a function that has been
kconfig-ed out will fail to link as the function being called isn't built
(mdio45_ethtool_gset_npage for example)

Due to these failures we use a allow-list system (where functions must
be manually enabled).

Link: https://github.com/rust-lang/rust-bindgen/discussions/2405
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/.gitignore               |  2 ++
 rust/Makefile                 | 36 ++++++++++++++++++++++++++++++++---
 rust/bindgen_static_functions |  6 ++++++
 rust/bindings/lib.rs          |  4 ++++
 rust/exports.c                |  1 +
 5 files changed, 46 insertions(+), 3 deletions(-)
 create mode 100644 rust/bindgen_static_functions

diff --git a/rust/.gitignore b/rust/.gitignore
index d3829ffab80ba..741a180238013 100644
--- a/rust/.gitignore
+++ b/rust/.gitignore
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
 bindings_generated.rs
+bindings_generated_static.rs
 bindings_helpers_generated.rs
 doctests_kernel_generated.rs
 doctests_kernel_generated_kunit.c
 uapi_generated.rs
 exports_*_generated.h
+extern.c
 doc/
 test/
diff --git a/rust/Makefile b/rust/Makefile
index b5e0a73b78f3e..4ea5ce96440d0 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -10,14 +10,17 @@ always-$(CONFIG_RUST) += exports_core_generated.h
 # for Rust only, thus there is no header nor prototypes.
 obj-$(CONFIG_RUST) += helpers/helpers.o
 CFLAGS_REMOVE_helpers/helpers.o = -Wmissing-prototypes -Wmissing-declarations
+CFLAGS_REMOVE_extern.o = -Wmissing-prototypes -Wmissing-declarations -Wdiscarded-qualifiers
 
 always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
-always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
+always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs \
+	bindings/bindings_generated_static.rs
+obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o extern.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
-    exports_bindings_generated.h exports_kernel_generated.h
+    exports_bindings_generated.h exports_bindings_static_generated.h \
+    exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
@@ -275,6 +278,20 @@ quiet_cmd_bindgen = BINDGEN $@
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
 		$(bindgen_target_cflags) $(bindgen_target_extra)
 
+quiet_cmd_bindgen_static = BINDGEN $@
+      cmd_bindgen_static = \
+	$(BINDGEN) $< $(bindgen_target_flags) \
+		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
+		--no-debug '.*' --enable-function-attribute-detection \
+		--experimental --wrap-static-fns \
+		--wrap-static-fns-path $(src)/extern.c \
+		$(bindgen_static_functions) \
+		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
+		$(bindgen_target_cflags) $(bindgen_target_extra)
+
+$(src)/extern.c: $(obj)/bindings/bindings_generated_static.rs
+	@sed -i 's|rust/bindings|bindings|g' $@
+
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
@@ -283,6 +300,15 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
+$(obj)/bindings/bindings_generated_static.rs: private bindgen_target_flags = \
+    $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
+$(obj)/bindings/bindings_generated_static.rs: private bindgen_static_functions = \
+    $(shell grep -Ev '^#|^$$' $(src)/bindgen_static_functions)
+$(obj)/bindings/bindings_generated_static.rs: $(src)/bindings/bindings_helper.h \
+	$(src)/bindgen_static_functions \
+    $(src)/bindgen_parameters FORCE
+	$(call if_changed_dep,bindgen_static)
+
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
@@ -329,6 +355,9 @@ $(obj)/exports_helpers_generated.h: $(obj)/helpers/helpers.o FORCE
 $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 	$(call if_changed,exports)
 
+$(obj)/exports_bindings_static_generated.h: $(obj)/extern.o FORCE
+	$(call if_changed,exports)
+
 $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 	$(call if_changed,exports)
 
@@ -410,6 +439,7 @@ $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/bindings/bindings_generated.rs \
+    $(obj)/bindings/bindings_generated_static.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
new file mode 100644
index 0000000000000..1f24360daeb38
--- /dev/null
+++ b/rust/bindgen_static_functions
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Don't generate structs
+--blocklist-type '.*'
+
+--allowlist-function blk_mq_rq_to_pdu
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 93a1a3fc97bc9..63b915a8e4fbf 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -33,6 +33,10 @@ mod bindings_raw {
         env!("OBJTREE"),
         "/rust/bindings/bindings_generated.rs"
     ));
+    include!(concat!(
+        env!("OBJTREE"),
+        "/rust/bindings/bindings_generated_static.rs"
+    ));
 }
 
 // When both a directly exposed symbol and a helper exists for the same function,
diff --git a/rust/exports.c b/rust/exports.c
index e5695f3b45b7a..e4bd5b694beb2 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -19,6 +19,7 @@
 #include "exports_alloc_generated.h"
 #include "exports_helpers_generated.h"
 #include "exports_bindings_generated.h"
+#include "exports_bindings_static_generated.h"
 #include "exports_kernel_generated.h"
 
 // For modules using `rust/build_error.rs`.
-- 
2.47.0


