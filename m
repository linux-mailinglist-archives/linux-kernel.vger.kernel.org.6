Return-Path: <linux-kernel+bounces-283911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF92994FA48
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC19281A20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE719A28C;
	Mon, 12 Aug 2024 23:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dMMgEMHW"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20D192B69
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505362; cv=none; b=eMxUmFD5T0TOqPkEXsDPifiZy9xxkYkdGexCVSyW/hzrBowBmR2O/SWpmEBfYMAvenyT0cB6ER2ITTHObxtap/abOKQcHzcjGU4DC4TIyUyLXtWvDAJUPZEDFeU+PAz1cQ+ABEXVJiFZMEYxFCbrVPuyQ926GqM//4+BusEcVUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505362; c=relaxed/simple;
	bh=7F7SE7aoRT7voG2xQs8VDom1T/z2v/0g5da5noTFJXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SaA2uuFDwza3lo8yHKcI1QzSjFNn6YLv2o87G+wwwSNPWBB8xl1t32Tx1Vn+nC4F2RF0tXvYG0I1TgauVNtmYzswDQ0U3HWipS5m6INjzp4PH3mURcGzMWIbk/gxpB757CyBPc4DShyIjCI0/gWGaBR8gMJkbT1TtjwvQh6VnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dMMgEMHW; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-69a0536b23aso109569187b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723505360; x=1724110160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NYZAmb95Zdt4FYIjmbgakWRAyFL76pOHkgozh+PgbQY=;
        b=dMMgEMHW8++lX3cEYyw98Q+7HJSpNlQm6QTusiHYrSZIJcumHQMYoutrW/V9kncxc7
         sSsDTjBMM7ncY34uPUdJJH/2LlJm/FBb3zL81OuIevcvuApgTXF3KYbSM48T6cxnO6yS
         ofYGsLb7PET0k+2AeqCjoqy7ql9aSgWB4DQsiUMncs/cccYjvAXAtOJN3zRwIrMePknD
         amkCmrLny22vOV2xyvRN5n4tJk05Cb3z8MFZxMI8IMSq8dj3XZbb+RN68h96HypZuyzp
         pb4EMmRL2Rbk8L/65qS+Wkz722gL5ysLSRbSCH6A/zQibkITpjxEout5IC9/g3iy43Lp
         WAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505360; x=1724110160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYZAmb95Zdt4FYIjmbgakWRAyFL76pOHkgozh+PgbQY=;
        b=axvACEEDjcEBhKq5K4Rn6KU8tHVTvnszN7WLP+fj0XPnjwSsYJvu81yMRs2aRzmW/1
         xZnI0XIuXmpZEl6DKZGRBtKKqbF63vj8Tv/0EW2rsRLxH/cSdvmulf+uCpkY6YHfkKOA
         nz/+88PB04iyoMGiw72LkTNtAsXEhs9pSbtYpaL9Sf0/ZIFDZbzu0Jx479/BHlEUfDlU
         7igtL+fjn7NkL97uRAsHacvmyy3vtwOWOXHm2ryBf7CyTeo3kzHMsEc/aqpJ3BkXIN+X
         D9kqkrkrONJiCtbDSjt5FyTUlhw4Owj+Sye3L+UMlGcEaEALVccAFVEhWlAtdVhKtRs7
         78eA==
X-Forwarded-Encrypted: i=1; AJvYcCUcbRCiEgEv1CxdRbTkp7FXJOVdBz7SYpRPrx5xaMIgGlNR/xx9/0sOddMDWiah+QMGBFRC3vexgj6WzFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPXztByBqZKrBJtyzcE2NPRcC/yAvTFnuu3XJhAG38gXyR/JrQ
	Ofm0fPa7fjCB2UhSe52T/B3YGMXBvDjojE/4qfaGTpRcMD4ZQHllt9FeHZ+ETQGCK160elOxb4Q
	9lRLTIg==
X-Google-Smtp-Source: AGHT+IE1MApIbnBSlutXKaHC7CEgt9yRvSYQdwzC6dANObTA6whJsq38wsLYhU4NYJw1r2PDYod/5O8g467o
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:145:b0:e03:2f90:e81d with SMTP id
 3f1490d57ef6-e113d2867a6mr91705276.11.1723505359845; Mon, 12 Aug 2024
 16:29:19 -0700 (PDT)
Date: Mon, 12 Aug 2024 23:29:02 +0000
In-Reply-To: <20240812232910.2026387-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812232910.2026387-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812232910.2026387-3-mmaurer@google.com>
Subject: [PATCH v2 2/3] kbuild: rust: Enable KASAN support
From: Matthew Maurer <mmaurer@google.com>
To: dvyukov@google.com, ojeda@kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: aliceryhl@google.com, samitolvanen@google.com, 
	Matthew Maurer <mmaurer@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Rust supports KASAN via LLVM, but prior to this patch, the flags aren't
set properly.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/Makefile.kasan          | 51 +++++++++++++++++++++++----------
 scripts/Makefile.lib            |  3 ++
 scripts/generate_rust_target.rs |  1 +
 3 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
index 390658a2d5b7..bfd37be9cc45 100644
--- a/scripts/Makefile.kasan
+++ b/scripts/Makefile.kasan
@@ -12,6 +12,9 @@ endif
 KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
 
 cc-param = $(call cc-option, -mllvm -$(1), $(call cc-option, --param $(1)))
+rustc-param = $(call rustc-option, -Cllvm-args=-$(1),)
+
+check-args = $(foreach arg,$(2),$(call $(1),$(arg)))
 
 ifdef CONFIG_KASAN_STACK
 	stack_enable := 1
@@ -28,6 +31,7 @@ else
 endif
 
 CFLAGS_KASAN_MINIMAL := -fsanitize=kernel-address
+RUSTFLAGS_KASAN_MINIMAL := -Zsanitizer=kernel-address -Zsanitizer-recover=kernel-address
 
 # -fasan-shadow-offset fails without -fsanitize
 CFLAGS_KASAN_SHADOW := $(call cc-option, -fsanitize=kernel-address \
@@ -35,44 +39,61 @@ CFLAGS_KASAN_SHADOW := $(call cc-option, -fsanitize=kernel-address \
 			$(call cc-option, -fsanitize=kernel-address \
 			-mllvm -asan-mapping-offset=$(KASAN_SHADOW_OFFSET)))
 
+# The minimum supported `rustc` version has a minimum supported LLVM
+# version late enough that we can assume support for -asan-mapping-offset
+RUSTFLAGS_KASAN_SHADOW := $(RUSTFLAGS_KASAN_MINIMAL) \
+			  -Cllvm-args=-asan-mapping-offset=$(KASAN_SHADOW_OFFSET)
+
+KASAN_PARAMS :=
+
 ifeq ($(strip $(CFLAGS_KASAN_SHADOW)),)
 	CFLAGS_KASAN := $(CFLAGS_KASAN_MINIMAL)
+	# We still need to consider this case for Rust because we want Rust code
+	# to match the behavior of possibly old C compilers when linked together.
+	ifdef CONFIG_RUST
+		RUSTFLAGS_KASAN := $(RUSTFLAGS_KASAN_MINIMAL)
+	endif
 else
-	# Now add all the compiler specific options that are valid standalone
-	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
-	 $(call cc-param,asan-globals=1) \
-	 $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
-	 $(call cc-param,asan-instrument-allocas=1)
+	KASAN_PARAMS += asan-globals=1 asan-instrumentation-with-call-threshold=$(call_threshold) asan-instrument-allocas=1
+	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW)
+	ifdef CONFIG_RUST
+		RUSTFLAGS_KASAN := $(RUSTFLAGS_KASAN_SHADOW)
+	endif
 endif
 
-CFLAGS_KASAN += $(call cc-param,asan-stack=$(stack_enable))
+KASAN_PARAMS += asan-stack=$(stack_enable)
 
 # Instrument memcpy/memset/memmove calls by using instrumented __asan_mem*()
 # instead. With compilers that don't support this option, compiler-inserted
 # memintrinsics won't be checked by KASAN on GENERIC_ENTRY architectures.
-CFLAGS_KASAN += $(call cc-param,asan-kernel-mem-intrinsic-prefix=1)
+KASAN_PARAMS += asan-kernel-mem-intrinsic-prefix=1
 
 endif # CONFIG_KASAN_GENERIC
 
 ifdef CONFIG_KASAN_SW_TAGS
 
 ifdef CONFIG_KASAN_INLINE
-    instrumentation_flags := $(call cc-param,hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET))
+    KASAN_PARAMS += hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET)
 else
-    instrumentation_flags := $(call cc-param,hwasan-instrument-with-calls=1)
+    KASAN_PARAMS += hwasan-instrument-with-calls=1
 endif
 
-CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
-		$(call cc-param,hwasan-instrument-stack=$(stack_enable)) \
-		$(call cc-param,hwasan-use-short-granules=0) \
-		$(call cc-param,hwasan-inline-all-checks=0) \
-		$(instrumentation_flags)
+KASAN_PARAMS += hwasan-instrument-stack=$(stack_enable) hwasan-use-short-granules=0 hwasan-inline-all-checks=0 $(instrumentation_params)
+CFLAGS_KASAN := -fsanitize=kernel-hwaddress
 
 # Instrument memcpy/memset/memmove calls by using instrumented __hwasan_mem*().
 ifeq ($(call clang-min-version, 150000)$(call gcc-min-version, 130000),y)
 CFLAGS_KASAN += $(call cc-param,hwasan-kernel-mem-intrinsic-prefix=1)
 endif
 
+ifdef CONFIG_RUST
+	RUSTFLAGS_KASAN := -Zsanitizer=kernel-hwaddress -Zsanitizer-recover=kernel-hwaddress
+endif
+
 endif # CONFIG_KASAN_SW_TAGS
 
-export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE
+# Add all as-supported KASAN LLVM parameters requested by the configuration
+CFLAGS_KASAN += $(call check-args, cc-param, $(KASAN_PARAMS))
+RUSTFLAGS_KASAN += $(call check-args, rustc-param, $(KASAN_PARAMS))
+
+export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE RUSTFLAGS_KASAN
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index fe3668dc4954..27999da3d382 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -167,6 +167,9 @@ ifneq ($(CONFIG_KASAN_HW_TAGS),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(target-stem).o)$(KASAN_SANITIZE)$(is-kernel-object)), \
 		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
+_rust_flags += $(if $(patsubst n%,, \
+		$(KASAN_SANITIZE_$(target-stem).o)$(KASAN_SANITIZE)$(is-kernel-object)), \
+		$(RUSTFLAGS_KASAN))
 endif
 endif
 
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 8a0644c0beed..1a4d468c575f 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -187,6 +187,7 @@ fn main() {
         }
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
+        ts.push("supported-sanitizers", ["kernel-address"]);
         ts.push("target-pointer-width", "64");
     } else if cfg.has("X86_32") {
         // This only works on UML, as i386 otherwise needs regparm support in rustc
-- 
2.46.0.76.ge559c4bf1a-goog


