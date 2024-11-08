Return-Path: <linux-kernel+bounces-400956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28E49C146F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52BAF1F22FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F01494D4;
	Fri,  8 Nov 2024 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoeiEXZn"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7523AD;
	Fri,  8 Nov 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035430; cv=none; b=eu6qxr6Es4UkS8O3h8jhmuoCJ8xytDzOcSN/UjvwqbWxRoaibDuYsdfmuoAEv9pWVx14kNytO74zbHTCzSJWEpok4zBWVfD2y89XqR33Sovkq4uoqHSINXpqUyc5cLsryESoTJtR67ZsEOwKG1ZMLAAOUPkRsA1YGeQ9F76uTLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035430; c=relaxed/simple;
	bh=6SS1RZSKcjrsUA3ksNnohQWZW45NDTHeAxjvxDp4z/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJuylciSjgBx7lwYm0dlCSUqMvSEQB3YjzHS25hEnVM6qj4Uj4HtNw0kdbLhex4XnKKqrkP3RniRD096VYbG6XmdhsByy6tcHsSyUaZkl0JkDdzx1Vv26x5M97laK8h2xLau3T1GjtdeaT7Wy81zm5H6SgSc/kr11mCLOqdiZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoeiEXZn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-720d01caa66so1544569b3a.2;
        Thu, 07 Nov 2024 19:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035428; x=1731640228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDQ0KADemnBAoSQ02FYC88DqCdRiw7yhsS4btgA76rM=;
        b=DoeiEXZnmwOGQjYPlysInjs6RZfg4oVG8hnBubzT8R7JMGfb7PYUQ70W8GvrC/6CG5
         6nO/JW3q1PxoBcQcMUbl/hWeCKQU6jXxFdyKtE5wJTqWiMzOJ3qvHYM3U0+nDcd/lcPb
         NYy6xrY/MrHvns7A0fKOi66mT6cJiTzRE1JlJHaB3fKOYJgKn7RV7dLZ52JBuGBjfnE0
         MGVKc4D37JM0i35DRNvoJyOnbWYnf14juCdctMfzuDdB233l2YFLijPgxsUivdK9H7za
         eNNi0Cxn5TqjLfIEbdc/jAz47sJhHwyiWgNi3jYGk9u74eUORt2vLqVLgRFsBD9Yt/SA
         keRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035428; x=1731640228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDQ0KADemnBAoSQ02FYC88DqCdRiw7yhsS4btgA76rM=;
        b=PlljV3st6Zdp6wMOe+9bpiio1SKzMEA744hIxZR6RBPtF7sDLSY4nD8LfmPoWcRYQY
         +axijL2+DMeiVFnGGRug3l9+qyJDRSmoUmq3ym8UKBkoMdnZKY9zlKSVFJL0c7/PYpgi
         YkNXjkvjCHaSmz2PqITDa7OosJVAKr/5mCPNJj8+p9Lob0xHbu81uEhsiNWPergyAppC
         s9QTJQfhHe+YRJl097loObNUnLscBGqxo77lNKZCmHGQfmIZJ/CQNz9yR1W/dPihvAmM
         5F4e5paodjbJdbTwMaWNcCwuQm3RjayPcJTAz34GaWdN8SDOCIEknohir66mCVptyC3L
         O5BA==
X-Forwarded-Encrypted: i=1; AJvYcCWH4lAaMTta1jFnkFCJ4/5Y7nKzpZb4vuJgFlgvN7oEPRLBt292eqs5H0XcGuiul6EwAgIGvM+OnHKajvGwX98=@vger.kernel.org, AJvYcCXhPBPpiJeIXxdLKACsiXiU3E8lDkBLOKTTvxLaU3hY6d08AsS7NWclHZVXGQbkxnaAZbfx75Zb3KavLMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5oPo1ze9JTuu4cIGdUxBq8Y99l16xL7ksn1LPCz/bIXvF2Cw
	S8p1ROB+KwW4NqHixtOX8UVctaK+Tcmmey8wa0Du5ktB/6o4o1K2
X-Google-Smtp-Source: AGHT+IEtnE0rnqVeBGWEQ/ndWnfZf8Wqrd13sgNHYHGDNOrnwqftRron+Wn5XT7hBhNEJhOFw6bG/A==
X-Received: by 2002:a05:6a00:99b:b0:71e:4930:162c with SMTP id d2e1a72fcca58-72413297235mr1696240b3a.6.1731035428181;
        Thu, 07 Nov 2024 19:10:28 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:10:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 01/11] rust: bindings: Support some inline static functions
Date: Fri,  8 Nov 2024 13:10:02 +1000
Message-ID: <20241108031012.335203-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
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
 rust/Makefile                 | 37 ++++++++++++++++++++++++++++++++---
 rust/bindgen_static_functions |  6 ++++++
 rust/bindings/lib.rs          |  4 ++++
 rust/exports.c                |  1 +
 5 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 rust/bindgen_static_functions

diff --git a/rust/.gitignore b/rust/.gitignore
index d3829ffab80b..741a18023801 100644
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
index 6daaa4dc21db..431edc73e893 100644
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
-obj-$(CONFIG_RUST) += bindings.o kernel.o
+always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs \
+	bindings/bindings_generated_static.rs
+obj-$(CONFIG_RUST) += bindings.o kernel.o extern.o
 always-$(CONFIG_RUST) += exports_helpers_generated.h \
-    exports_bindings_generated.h exports_kernel_generated.h
+    exports_bindings_generated.h exports_bindings_static_generated.h \
+    exports_kernel_generated.h
 
 always-$(CONFIG_RUST) += uapi/uapi_generated.rs
 obj-$(CONFIG_RUST) += uapi.o
@@ -274,6 +277,21 @@ quiet_cmd_bindgen = BINDGEN $@
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
+$(src)/extern.c: $(obj)/bindings/bindings_generated_static.rs \
+	$(src)/bindings/bindings_helper.h
+	@sed -i 's|rust/bindings|bindings|g' $@
+
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
@@ -282,6 +300,15 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
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
@@ -325,6 +352,9 @@ $(obj)/exports_helpers_generated.h: $(obj)/helpers/helpers.o FORCE
 $(obj)/exports_bindings_generated.h: $(obj)/bindings.o FORCE
 	$(call if_changed,exports)
 
+$(obj)/exports_bindings_static_generated.h: $(obj)/extern.o FORCE
+	$(call if_changed,exports)
+
 $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 	$(call if_changed,exports)
 
@@ -400,6 +430,7 @@ $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/bindings/bindings_generated.rs \
+    $(obj)/bindings/bindings_generated_static.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
new file mode 100644
index 000000000000..1f24360daeb3
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
index d6da3011281a..c991bcf607ec 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -34,6 +34,10 @@ mod bindings_raw {
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
index 587f0e776aba..288958d2ebea 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -18,6 +18,7 @@
 #include "exports_core_generated.h"
 #include "exports_helpers_generated.h"
 #include "exports_bindings_generated.h"
+#include "exports_bindings_static_generated.h"
 #include "exports_kernel_generated.h"
 
 // For modules using `rust/build_error.rs`.
-- 
2.47.0


