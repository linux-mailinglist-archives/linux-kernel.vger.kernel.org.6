Return-Path: <linux-kernel+bounces-377229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234D39ABB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C84A1F24626
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039913211F;
	Wed, 23 Oct 2024 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x6RQx9Y4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9287602D
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650703; cv=none; b=seUWdPMFv22abju2TGQRuNyy19KtGLiyFHQeCRT8t3BCAYvWTm1k32FixfJ11/+vnXiuUy6e+1KZX4CAES1ZPfo0elDiaijQMDrUodkQLNjuJnW/aUEznkV3pTUd4uTpZ1D7uExwVv3vaK8K7oylR9EWcru0Vk4ElCX4Wa0i+lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650703; c=relaxed/simple;
	bh=AXnGIklQqq/lnjPHJiHbKua3HNYNN7XmIM8srTiC2rw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uHGiU2ZaI7vMEyLYSaB7huKR/RTgG1214KybyRKTljsVCRCExG8aTcHGRVwRpEJjnTs6yl0POgYLXRFzyz4jQCr6yOMEopyOtM3mIeOOMGIvUXq6A4pqYfUrmqBl1JT11MLsVM4fwJlsSMwcGr4XKd86rHIi5C4Edt9PHlnWhmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x6RQx9Y4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e370139342so107242417b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 19:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729650701; x=1730255501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YVm76pegvjtsU2eVkCp0KUVvIC3D2L+QTQ/qD8J0RGc=;
        b=x6RQx9Y4aYypbZVPWI2tSTKcrTH4HgP/YtcBMY56Q0w1dV+TKE2ab34jduWTEaSKaf
         P5SMsto8G8CsBz4c4t9om9qwC4nbuavYJH+/MP4ax7b84d7uZFUjeQA1dinBDHyKiTLQ
         YYdjwqm7BXXaQmcpKP8Kf82c6WFrN9IilLR6XSZPcQSZhBiqWNcYfrbg1eb8uruA41Tf
         CwrzNWa8lQS4eQkYk29vMcSnGRBIDSCQoK8tODo1VxGv11qX9cfmfyLPkii2Z+FSOakn
         uGP4kGgqdy+yRAw33P7FHGOZJOY5yp/3AxSqbnTrl/0Fyc21VIbPuzIs50bhnyCHABlR
         J7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650701; x=1730255501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVm76pegvjtsU2eVkCp0KUVvIC3D2L+QTQ/qD8J0RGc=;
        b=LmBhB2o0UBHC6OYT7bLbc2UkJf9EI17a7NDL7AytyrGxrTp2bM+ZbJXYmqlS3A2T03
         ALKUCF2s3wHvqCi2cc5lIuOZ24BuG4J5rLdTCyq3JrdylIBzXY7K7OKjeKeQjYbkION7
         HY43cb1gXkpC1pYmB46ATDCIPWIO2YrZU2THQGQ8JdfOIjT9yu0e9n3UgXruE0sdXQAd
         QekHEULZRFewNC1fthkOnFKj14Mp5qWF//HskeVXSmqEUQFx9P6u/HrkBxH4TNYq43ld
         MNkLx9AfiWKfNjj0AY4v3AaEDjecLZQ4LwfscYda8XK0J1PugQDcVrbcDc7fTl7Eah/f
         AtsA==
X-Forwarded-Encrypted: i=1; AJvYcCWkasm3mnf/EM5fVWH7P5K9pJ/EGWgJC1cWvQOiKPkwLTLttNpIOTlCT3dEdguc94PnoC4kGb5yPt3+ePE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9sZ2KKUoG9Y9n+KIW0FVfu19Gt5jIn/n4Bx7iNMFIJnrIXt1
	mrLsX3dPWec+eH8joamX/xCw3iycW5Ccjx0YhbGkvSdwHDmBhuBPVQYbSrT+k3kc1iwUJLAbNNK
	Tsbsuig==
X-Google-Smtp-Source: AGHT+IEAkeaejmFNh7AdweUswVgSnsnPXI+PIy2hRogub8V/yCkXh4Je5UqAMfghNt8CcH8kkBRMSxNOEULS
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:25c9:b0:6e6:38:8567 with SMTP id
 00721157ae682-6e7f0fdb1ecmr462847b3.8.1729650700838; Tue, 22 Oct 2024
 19:31:40 -0700 (PDT)
Date: Wed, 23 Oct 2024 02:31:30 +0000
In-Reply-To: <20241023-extended-modversions-v7-0-339787b43373@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241023-extended-modversions-v7-0-339787b43373@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20241023-extended-modversions-v7-3-339787b43373@google.com>
Subject: [PATCH v7 3/3] rust: Use gendwarfksyms + extended modversions for CONFIG_MODVERSIONS
From: Matthew Maurer <mmaurer@google.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sami Tolvanen <samitolvanen@google.com>

Previously, two things stopped Rust from using MODVERSIONS:
1. Rust symbols are occasionally too long to be represented in the
   original versions table
2. Rust types cannot be properly hashed by the existing genksyms
   approach because:
	* Looking up type definitions in Rust is more complex than C
	* Type layout is potentially dependent on the compiler in Rust,
	  not just the source type declaration.

CONFIG_EXTENDED_MODVERSIONS addresses the first point, and
CONFIG_GENDWARFKSYMS the second. If Rust wants to use MODVERSIONS, allow
it to do so by selecting both features.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Co-developed-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 init/Kconfig  |  3 ++-
 rust/Makefile | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 530a382ee0feb391b4717abdba3672e584a462d0..f5cce579f29b2ed89e97f8075a3bf70e32e71ad0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1942,7 +1942,8 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
-	depends on !MODVERSIONS
+	select EXTENDED_MODVERSIONS if MODVERSIONS
+	depends on (GENDWARFKSYMS || !MODVERSIONS)
 	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
diff --git a/rust/Makefile b/rust/Makefile
index b5e0a73b78f3e58fc8fb8c9fab8fb5792406c6d8..b80bc4eb98202f774c493da89c2caee322cffc91 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -303,10 +303,11 @@ $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ;
 $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers/helpers.c FORCE
 	$(call if_changed_dep,bindgen)
 
+rust_exports = $(NM) -p --defined-only $(1) | awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ { printf $(2),$(3) }'
+
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
-	$(NM) -p --defined-only $< \
-		| awk '$$2~/(T|R|D|B)/ && $$3!~/__cfi/ {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
+	$(call rust_exports,$<,"EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3) > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
@@ -378,11 +379,35 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
 		__ashlti3 __lshrti3
 endif
 
+ifdef CONFIG_MODVERSIONS
+cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
+	$(call rust_exports,$@,"%s\n",$$3) | \
+	scripts/gendwarfksyms/gendwarfksyms \
+		$(if $(KBUILD_SYMTYPES), --symtypes $(@:.o=.symtypes),) \
+		$@ >> $(dot-target).cmd)
+endif
+
 define rule_rustc_library
 	$(call cmd_and_fixdep,rustc_library)
 	$(call cmd,gen_objtooldep)
+	$(call cmd,gendwarfksyms)
 endef
 
+define rule_rust_cc_library
+	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
+	$(call cmd,gendwarfksyms)
+endef
+
+# helpers.o uses the same export mechanism as Rust libraries, so ensure symbol
+# versions are calculated for the helpers too.
+$(obj)/helpers/helpers.o: $(src)/helpers/helpers.c $(recordmcount_source) FORCE
+	+$(call if_changed_rule,rust_cc_library)
+
+# Disable symbol versioning for exports.o to avoid conflicts with the actual
+# symbol versions generated from Rust objects.
+$(obj)/exports.o: private skip_gendwarfksyms = 1
+
 $(obj)/core.o: private skip_clippy = 1
 $(obj)/core.o: private skip_flags = -Wunreachable_pub
 $(obj)/core.o: private rustc_objcopy = $(foreach sym,$(redirect-intrinsics),--redefine-sym $(sym)=__rust$(sym))
@@ -394,6 +419,7 @@ ifneq ($(or $(CONFIG_X86_64),$(CONFIG_X86_32)),)
 $(obj)/core.o: scripts/target.json
 endif
 
+$(obj)/compiler_builtins.o: private skip_gendwarfksyms = 1
 $(obj)/compiler_builtins.o: private rustc_objcopy = -w -W '__*'
 $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 	+$(call if_changed_rule,rustc_library)
@@ -404,6 +430,7 @@ $(obj)/alloc.o: private rustc_target_flags = $(alloc-cfgs)
 $(obj)/alloc.o: $(RUST_LIB_SRC)/alloc/src/lib.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/build_error.o: private skip_gendwarfksyms = 1
 $(obj)/build_error.o: $(src)/build_error.rs $(obj)/compiler_builtins.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
@@ -413,6 +440,7 @@ $(obj)/bindings.o: $(src)/bindings/lib.rs \
     $(obj)/bindings/bindings_helpers_generated.rs FORCE
 	+$(call if_changed_rule,rustc_library)
 
+$(obj)/uapi.o: private skip_gendwarfksyms = 1
 $(obj)/uapi.o: $(src)/uapi/lib.rs \
     $(obj)/compiler_builtins.o \
     $(obj)/uapi/uapi_generated.rs FORCE

-- 
2.47.0.105.g07ac214952-goog


