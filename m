Return-Path: <linux-kernel+bounces-403959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F59C3D27
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98323280EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA96156F44;
	Mon, 11 Nov 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="krv2CcHg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rkes+uFs"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A718A6A8;
	Mon, 11 Nov 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324391; cv=none; b=XJ6v6xYO37uKku6faty//iX9p8o6dQ7Xg6DZvIADVcX3FG4H0tkn6QzpsCg70Chm6oJ+l2I+/xATsMQp/s3mjXz0Uz/zNXbjsY3IuhG4RkEgjaCU914TXyLwshYBtwKbIBiHuA1Q5fuxBO+Zs5/0pnlYSxnQIz90lGAsPz6JMxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324391; c=relaxed/simple;
	bh=TEL79ox3fIqCGIkDxbJzv8epE22eE0exixwhXg6WwAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwXC2AQkVCbwEX3JaKGuc3pVdxlhUfNCIMTVPonmV/hiDimjBuVZpOikcV6Qw3vQ48JEMHjQCtpl8hXbSm3dIXaT87lxPMXFoA9C2otpqE3mfp3uGERGtdCrhJv/HHshcjmp0yKBTjWhCUR5CdQt2XdNpi6WA+tw1EUGFZwE12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=krv2CcHg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rkes+uFs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ADC40114010A;
	Mon, 11 Nov 2024 06:26:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 Nov 2024 06:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1731324387; x=1731410787; bh=6ansabR635sGWr6JVqI8JQfwDufPlCHV
	pGLOLU/q+Wk=; b=krv2CcHgs8Gd0DGiaAI1chuLxJXER8PXcqbhMtxl2pjeJsBj
	UJU0FZ7BxLzQyaiAA/M097eeY+K/322Cz1F40JeHB3qjsfkzVHr4eLRSBbtAjxEa
	ngeQxo72zLguXCHWrtAVPPVF46cRF1mWfKg3+TCF1dd0uB1kKUzqVLQoGxBkKdLS
	NivwFR/yva/jt4xruKeb/WKy3KIK2dFHOh9SbuKoQkdKh87DzjegRfbSv6yIBXPV
	4E8qpCKQ5+7yY7keQ+dk90AiC0tfMcp8NvDRFE9qxwhawWHPm/r2o9RXwgQgjYso
	5QJvFpu+/4C3wwM6RN+jccExqXJ2a7QaBb6kOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731324387; x=
	1731410787; bh=6ansabR635sGWr6JVqI8JQfwDufPlCHVpGLOLU/q+Wk=; b=R
	kes+uFsV+YuO36+Um6scknkanQ0jaWnEHkD8FoDLtpNXU3YunWHOjbiEDUGyuiF1
	EArXkljbAHglgluzG2doivskLJ7NQqYRTSw/iDDRac64GCJZWWfYoUfC04TWaBVO
	9ykZNG/LxDHzbw9g+W4zTxkg+B7Q2kxcVqzlIMXNRyo855XpR4a9v7SLhj3mLRo3
	K+ruSDOmNFr868x8Hz4J3Gq84sNqEVx/IO4u722gZTE6bSblFKi6+GMfTEhjxids
	5nhY8xaOwlxhl8GxUY8od3HQeZqSFbeI01n84DheFnIQv0qERjVef7u/iUz1YVYr
	shmbKrt7xZP5PtqPNZwLg==
X-ME-Sender: <xms:4-kxZ6atqA9GxzZPMm3AyhuxFg1Iwl2XfmH83UMxLleCdy3L8FL0uw>
    <xme:4-kxZ9Yv04ctkXP_xbPTDXTxe4wVrc_t8xdPXF3x445ENRfqSOhWL-Sx4Zq5VRN3n
    1PDO8Ly-asOuC6V6iw>
X-ME-Received: <xmr:4-kxZ0_6jTb9YoooeP_3ie8Cn8sqN2V1tCy0gCzbNNJtONHqXP2l9MiWOG6dIlJ4YmwtHyFacnoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghn
    tghishcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrth
    htvghrnhephfetjeejteeileehvdehgeetgeffueetgfetleelgeehjedvgfefvdeukedt
    gfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhr
    vdefrdhmvgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopegrrd
    hhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehklhhovghn
    khdruggvvhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
    dprhgtphhtthhopehtmhhgrhhoshhssehumhhitghhrdgvughupdhrtghpthhtoheprghl
    ihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhi
    hguhhordhnvghtpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:4-kxZ8r5DVHKiFRrBrhw7dkJRG1PHKXCaCJL7SrJJLhPK2lhR2dv-w>
    <xmx:4-kxZ1qb2r-C5AhMhFnkcG3CseqL7JB7IQBh9zBVOmB5nZ8ZJgdaWA>
    <xmx:4-kxZ6SdhdsvqIs18Zo8HSWu4dqVa6cwCloYuH8s5NfoGsDDAdc_pA>
    <xmx:4-kxZ1oIU4FNHy1OljP118W_ESVb48yXumj9lUfcXzTtCDPCQnigwQ>
    <xmx:4-kxZ9aHQxnp3XPBdih0dICmnKR44AsSRCTzw6p-WEvtBMc4r_LFLYq0>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 06:26:22 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	aliceryhl@google.com,
	gary@garyguo.net,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	alex.gaynor@gmail.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v3 01/11] rust: bindings: Support some inline static functions
Date: Mon, 11 Nov 2024 21:26:05 +1000
Message-ID: <20241111112615.179133-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111112615.179133-1-alistair@alistair23.me>
References: <20241111112615.179133-1-alistair@alistair23.me>
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
non-experimental (depending on your version of bindgen).

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
Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 Documentation/rust/general-information.rst | 10 +++---
 rust/.gitignore                            |  2 ++
 rust/Makefile                              | 37 ++++++++++++++++++++--
 rust/bindgen_static_functions              |  6 ++++
 rust/bindings/lib.rs                       |  4 +++
 rust/exports.c                             |  1 +
 6 files changed, 53 insertions(+), 7 deletions(-)
 create mode 100644 rust/bindgen_static_functions

diff --git a/Documentation/rust/general-information.rst b/Documentation/rust/general-information.rst
index 6146b49b6a98..632a60703c96 100644
--- a/Documentation/rust/general-information.rst
+++ b/Documentation/rust/general-information.rst
@@ -119,10 +119,12 @@ By including a C header from ``include/`` into
 bindings for the included subsystem. After building, see the ``*_generated.rs``
 output files in the ``rust/bindings/`` directory.
 
-For parts of the C header that ``bindgen`` does not auto generate, e.g. C
-``inline`` functions or non-trivial macros, it is acceptable to add a small
-wrapper function to ``rust/helpers/`` to make it available for the Rust side as
-well.
+C ``inline`` functions will only be generated if the function name is
+specified in ``rust/bindgen_static_functions``.
+
+For parts of the C header that ``bindgen`` does not auto generate, e.g.
+non-trivial macros, it is acceptable to add a small wrapper function
+to ``rust/helpers/`` to make it available for the Rust side as well.
 
 Abstractions
 ~~~~~~~~~~~~
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


