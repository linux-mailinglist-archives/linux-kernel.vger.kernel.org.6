Return-Path: <linux-kernel+bounces-408498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D049C7F93
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F29D1F2305C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5281CF96;
	Thu, 14 Nov 2024 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="hvFW+glT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dQEGKH9/"
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79B18C0C;
	Thu, 14 Nov 2024 00:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731545809; cv=none; b=CuGTw3g5I253Rv42hhnQhLH5+UMEPsjCgAX7uaBgymPZ6yEnARewCKSRjmMPfacXYQU3wpyVYXKzrAMo9kQ5iYiyZJrK+GiTRsZ5CN4q0VgosjfGUtnAip6sGGfupd4lHE+fo/XjDZVt4kmogEMe5tVJpMQzvAw4+/lOD0lUXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731545809; c=relaxed/simple;
	bh=9C65kBmkAR6cChs2nZ7CihG3j5zRSexZrv6B08Szl3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQM6uQHjZECV3dpIlxPvA7SihIxs1rQCUjoo68c161Za0xHC9NYALMk8ydKgmB3CkWBPkKK1n22ZTSjLzy5Hxp3cHzbTKzU6ppCiFA6CskMdGoYBLfRr1k+5P2PR+co3Qq3OPMkYOQ2xxEUdR5gXyOrbB2DZzGSfdQTVY73W4Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=hvFW+glT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dQEGKH9/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1AC212540043;
	Wed, 13 Nov 2024 19:56:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 13 Nov 2024 19:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1731545805; x=1731632205; bh=+d8V6Jj0Y/vJREyku853JCQb+9egjMgH
	l0thuG2QDGs=; b=hvFW+glT03gn+agOd5juZlrNInUo5F+v5GNsZ1mQINwUhVph
	VM7JMKd1WQiAxnLdbje5bu6ChFzPAdeEdNZGBkulCMMweSgXP9Tf/zUSj1Io5ouW
	KMrWypQt44cOKotuC+tK4BeAJUZ3E/UqE2ZFQG5tfejhlNKwa6dl+yclNNObpAH6
	BYIUM9dcCicfZCRbm+CvAI916tWWis3G0IkUI4N7GA4NAngE7q9QZfkdJk94eBFs
	ax7WpuJT0jhwdnmRG++tlagLV5L5vZej8w93GcLIlDlOnq2KnrPztEGrLYhU0ACu
	ggSfBGOaj8NDi9UUJ3ZWfB5s2hjkoNaMpa16zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731545805; x=
	1731632205; bh=+d8V6Jj0Y/vJREyku853JCQb+9egjMgHl0thuG2QDGs=; b=d
	QEGKH9/TFWDFwygVDVIKdWxoqVcVH3W5PS2lIVXHRkYRJi9pEV/GFovEITGmUoNI
	KZRN3xRBuWPFQ4CMekLXqLM4n7lnTXiALvNNccAbgeAkMb+FWZeQrEgv0FpFhROQ
	VOdU9/DmjaDcvLgg+ohz2Eak/8iKUiXcsECdMdTsZ2sbLW5Zl0qnDSZ4ZNRQNddq
	dzuZyNg6DDC9T2p5o4fhNvTuOzrMkUAILLJqcR4vXwzSK7g0J/MUBrUqSuYtwzbT
	L7aI9cXwgJIFZdFNbjTM0KnwsMf8QpKnlq3jmietfXo2sZPSgf1AY80aWP6s+d2L
	12y52Xe47+NrAmRCPe0Ug==
X-ME-Sender: <xms:zEo1Zwgpk7RUz1u6kvLlyEldTu1BB3ICi3-IfHZH5u-SKxpjp2GA-A>
    <xme:zEo1Z5DE2yTSid_ZyPb5gnNf82cRbznrkg6l7hC1rDdAA99td2Okl0z-0eXXyPkor
    T3QHG4zwgUKiIzMJZg>
X-ME-Received: <xmr:zEo1Z4FpTDCtDVjrPRR_b5uPEkuDqlouLqOUlap1brkQ_xTvyRXNPTYLZCizLJlEqz7mkqPQhWTq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeen
    ucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhrsegrlh
    hishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpefhteejjeetieelhedvheeg
    teegffeutefgteelleegheejvdfgfedvueektdfgudenucffohhmrghinhepghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhnsggprhgtphhtthhope
    duiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhhnohdrlhhoshhsih
    hnsehprhhothhonhdrmhgvpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepmhgvsehklhhovghnkhdruggvvhdprhgtphhtthhopegrlh
    gvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusgho
    rhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnh
    gvthdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphht
    thhopegrlhhishhtrghirhdrfhhrrghntghishesfigutgdrtghomh
X-ME-Proxy: <xmx:zEo1ZxQ-Ip2Rtc1x9vuMDrKim0uxG7S8tFSwy3vviDECAMNHuCIU2w>
    <xmx:zEo1Z9wqDnqSxdkqS0SdBRrU6Xb_nUZctaWNrw1i6DpQq_1nT7J8AQ>
    <xmx:zEo1Z_6DQH4SFG3dCQSU11tm8ar_f3bYFtGREFfloA2N2jhXhNKSuA>
    <xmx:zEo1Z6z40xyY6C9KGPTAA1J17qC82V5zyWJqT2jKIQ-f6M87ySgHCg>
    <xmx:zUo1Z6j-H-mH5uYsAiwAGUnn1f-tygK4ZuPMFsLqNh8RHH5AQdvmmTor>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 19:56:40 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-kernel@vger.kernel.org,
	benno.lossin@proton.me,
	boqun.feng@gmail.com,
	me@kloenk.dev,
	alex.gaynor@gmail.com,
	a.hindborg@kernel.org,
	gary@garyguo.net,
	aliceryhl@google.com,
	alistair.francis@wdc.com,
	bjorn3_gh@protonmail.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org,
	ojeda@kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair@alistair23.me>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v4 01/11] rust: bindings: Support some inline static functions
Date: Thu, 14 Nov 2024 10:56:21 +1000
Message-ID: <20241114005631.818440-2-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114005631.818440-1-alistair@alistair23.me>
References: <20241114005631.818440-1-alistair@alistair23.me>
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
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
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
index 6daaa4dc21db..2d91160dcc69 100644
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
+	@sed -i 's|#include ".*|#include "bindings/bindings_helper.h"|g' $@
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


