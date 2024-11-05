Return-Path: <linux-kernel+bounces-395796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C89BC321
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 03:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C181E283501
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B4C3FB3B;
	Tue,  5 Nov 2024 02:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezqXrmF7"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302411CD0C;
	Tue,  5 Nov 2024 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773355; cv=none; b=cjp3cFSs0r4RFY/ySSIBZpGmu4xqZdP0FSI/x+qEo+cvI/XJ7u3zXrTnprmJC6OLsEYget1hXR2EqyUNObijjSTLtyQToH5PbN2pfdVKqwJ0u0BB/M0vSer30ogIHPo286PXpqzcTF352vBlIEFryGUiv4/oVou0sFIq3FLSezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773355; c=relaxed/simple;
	bh=ZqtOBaUIlL85JSjKLjL7Yg8E/caHl+YIQGeipquFDcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YBbrlxA/p1NAIK6c6Pcbllpj2KgGLQxDGC+nXNuIxmPUIVS6A+OKkjiiC/xllAdDvzSVa991W9zxmBuq+wqxCEw/XVuaSpt78pwusWlk82Tb+DjY7kaKLlnFAihC2qzlwFuh7s7UVU/4syeR727oQsQjLiZ/necjgen3UhehALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezqXrmF7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cbcd71012so56748965ad.3;
        Mon, 04 Nov 2024 18:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730773353; x=1731378153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0iBc0IPqxP7vxZT8Hy98lVaunuO0bTpMT753cTdrf4=;
        b=ezqXrmF70MVNNbYs/cFhvLUM2S3F7ipcV8Zcv/3s7QYgwkWAVVLvJipbuFFq/9k7tK
         j4w/bO0Z5zlIXH3ulgfiBzIdzJs4v4uggD2yFX7i1ID55nkQoEUj9+k4F5dKG9cpJpsc
         Fgpin+vj5xgV4RvOhW1J0COGo2vCk/falBo6dQsrTZPaQvOWfu94jh2F21N0LS6uUduo
         jDjCFDQyP5VPk+PEYnNkjywm3Rwkg2vfsoyYJC3NW3Col/9rsDksXCZlJvA0+oHpy8VN
         wWgq8xJ6nZObhgpvwI16dRdu+/VFO+4piUk6ll8vR7PQaXUMu9xJLwiDhGMOJV7Dtm2Z
         pVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773353; x=1731378153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0iBc0IPqxP7vxZT8Hy98lVaunuO0bTpMT753cTdrf4=;
        b=wgxzWj2RcPotmK5il3gdUDW7fdnCQAwyIukvDyc/8Ij//bQsh1rxOKViK0RaXgN0v3
         pacpkNxuNvFElfTB9YJW1bE7Yqn77lyLWuuG/3mk5HbHbw7zECNuxUVF7LC7Kv3RoCeA
         e77Taz/rY2yPiAr6H/zzqB7AzMz7fPseS3fFrNQzj2wX6lc/CJBJ1mcJspFZC0E8mZ8J
         SbJpWpbo+rpKCiF6TLYidPHkhR2mJyGSLrxaUOLaR+KR53XZ9xBv8kU9ikLxwznlLBYF
         APSLV6GE/YvxUuabl6hzsmo9vqdoPgWWs4eWK/OQob0VHu3WNB+kWPPbWnnbRxIyLbNE
         rSsA==
X-Forwarded-Encrypted: i=1; AJvYcCWY8HLq5i82k6XJSNysDNNzIMhF23hZntXq9xqWhH+lfFlNWabBhQHwLLdr+kaWo9Dl+8FSRT+c3Z9vZPc1MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuiCXI2gnhBAdG5bprESmtmABMfj5HHeLbrHZdxibrFKKfm18V
	VYW3kNh74LD7sftUr13drwWUc3Aa3MZthBKmNlj2Ygd6X1E8Dz3dSEyfGw==
X-Google-Smtp-Source: AGHT+IHhm/h6HzlWVU0IdX0YaJiUjJb3+/dvHNQi5XOqYuY/1mBNnFH585Yh2b2uswX3oTPwd51vGw==
X-Received: by 2002:a17:903:1c4:b0:211:31ac:89f1 with SMTP id d9443c01a7336-21131ac8d4emr134815185ad.8.1730773353062;
        Mon, 04 Nov 2024 18:22:33 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c68d8sm68159625ad.227.2024.11.04.18.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:22:32 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	gary@garyguo.net
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] rust: bindings: Support some inline static functions
Date: Tue,  5 Nov 2024 12:21:43 +1000
Message-ID: <20241105022143.1087112-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
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
If this is accepted or at least Acked I can work on removing the
existing rust_helper_* functions and convert them to be auto-generated.

 rust/.gitignore      |  2 ++
 rust/Makefile        | 29 +++++++++++++++++++++++++++--
 rust/bindings/lib.rs |  4 ++++
 3 files changed, 33 insertions(+), 2 deletions(-)

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
index b5e0a73b78f3e..649346cfc373e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -10,12 +10,13 @@ always-$(CONFIG_RUST) += exports_core_generated.h
 # for Rust only, thus there is no header nor prototypes.
 obj-$(CONFIG_RUST) += helpers/helpers.o
 CFLAGS_REMOVE_helpers/helpers.o = -Wmissing-prototypes -Wmissing-declarations
+CFLAGS_REMOVE_extern.o = -Wmissing-prototypes -Wmissing-declarations -Wdiscarded-qualifiers
 
 always-$(CONFIG_RUST) += libmacros.so
 no-clean-files += libmacros.so
 
-always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_helpers_generated.rs
-obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o
+always-$(CONFIG_RUST) += bindings/bindings_generated.rs bindings/bindings_generated_static.rs bindings/bindings_helpers_generated.rs
+obj-$(CONFIG_RUST) += alloc.o bindings.o kernel.o extern.o
 always-$(CONFIG_RUST) += exports_alloc_generated.h exports_helpers_generated.h \
     exports_bindings_generated.h exports_kernel_generated.h
 
@@ -267,6 +268,10 @@ endif
 
 bindgen_c_flags_final = $(bindgen_c_flags_lto) -D__BINDGEN__
 
+bindgen_static_functions = --experimental --wrap-static-fns \
+	--blocklist-type '.*' \
+	--allowlist-function crypto_shash_descsize
+
 quiet_cmd_bindgen = BINDGEN $@
       cmd_bindgen = \
 	$(BINDGEN) $< $(bindgen_target_flags) \
@@ -275,6 +280,19 @@ quiet_cmd_bindgen = BINDGEN $@
 		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
 		$(bindgen_target_cflags) $(bindgen_target_extra)
 
+quiet_cmd_bindgen_static = BINDGEN $@
+      cmd_bindgen_static = \
+	$(BINDGEN) $< $(bindgen_target_flags) \
+		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
+		--no-debug '.*' --enable-function-attribute-detection \
+		$(bindgen_static_functions) \
+		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
+		$(bindgen_target_cflags) $(bindgen_target_extra)
+
+$(src)/extern.c: $(obj)/bindings/bindings_generated_static.rs
+	@cp /tmp/bindgen/extern.c $(src)/
+	@sed -i 's|rust/bindings|bindings|g' $@
+
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/bindings/bindings_generated.rs: private bindgen_target_extra = ; \
@@ -283,6 +301,12 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
     $(src)/bindgen_parameters FORCE
 	$(call if_changed_dep,bindgen)
 
+$(obj)/bindings/bindings_generated_static.rs: private bindgen_target_flags = \
+    $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
+$(obj)/bindings/bindings_generated_static.rs: $(src)/bindings/bindings_helper.h \
+    $(src)/bindgen_parameters FORCE
+	$(call if_changed_dep,bindgen_static)
+
 $(obj)/uapi/uapi_generated.rs: private bindgen_target_flags = \
     $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
 $(obj)/uapi/uapi_generated.rs: $(src)/uapi/uapi_helper.h \
@@ -410,6 +434,7 @@ $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/bindings/bindings_generated.rs \
+    $(obj)/bindings/bindings_generated_static.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
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
-- 
2.47.0


