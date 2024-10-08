Return-Path: <linux-kernel+bounces-355696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AEB9955CD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1CC28C731
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D523420ADCF;
	Tue,  8 Oct 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pB6k5WG9"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96E20A5F9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409050; cv=none; b=k0DRi/fiQ/oxpvQaLSYxkX7jbVDyzc0gMFq6VQg5kFQ0Ikx+SqBmlrkdMJgO98rPMQ6FkmYjSgtjUWPr4vyfhIR4a8a+OHlDqDYAm7OsSY7188ja7ccbl1bI7HJhxGIYHDTdxUu9HLP5Wb1gU26wQ6shEyFZz31qd6XWOFDZzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409050; c=relaxed/simple;
	bh=iFRkliMPUiFgYsM5i8rizMPhx7zFXxbEfxZZGLUEsWI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tmnj45EdbCq3oheM/qe9fnXSwHLa26MtHCdrnFAv4hmin4/IeR+8r2WVHIsBdvt161xWtGDWSkts8D5s2hy8+zAM5JCYjC5dDC0Gx8GQC780jY0f/w1Vx2F08Ubfm6DzPuX5ZCPQsNgdiuknyxcxyHJdIVoNN/3CmFt+Zh/5GaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pB6k5WG9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e258c0e02a9so8081371276.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728409046; x=1729013846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=14kqYH2Lagbmhr3l3ZBauwCKx1YW0pMdZDc5JLpHFBU=;
        b=pB6k5WG9UNsp1t6Yho0GZOWaB4+AGvsPp/rkPm17ZJkgvg9haablpYh1ic0lJlhO5L
         ahDD3zGl4l7NvtP9uQAcCa/PbwRbF7qO6eQSLq11Coi2W8YzYRBBIBvDTIR6n8XFnJGe
         noqatjHuOaRfcBDqexoKuJ2fWxHEuzvMxc2KXfAWoJc5eKG1+kYd7GDb8zBsv+eVTlh/
         0rUdiSMaDeZ3a0Io/Qpe5JWYYaOW/1dIldHHmEZI1tI63wLCmLChdz46Jv+X+WRkOOYC
         CVZYW+Z/pRtCaJA149HctPNxxGE0rQMxEIAoVxny1fB3AZyn4ficJWfTqY40F8lrMEop
         fjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409046; x=1729013846;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=14kqYH2Lagbmhr3l3ZBauwCKx1YW0pMdZDc5JLpHFBU=;
        b=LISNzKHTcPRN7LLFXj3Kpc9Z6+XKF6d0GmXt7IXWjQ5VAjO2oXhJhujBZ8/m8KS6P3
         +TAouH0Sb2QTpAipJvy6FnLWUYHI3Kd7/vcheACHKjx73HbCYEQEPGrbbQ+68MA8Dl70
         b6AMWY5eBPJbp/MByuxlUpP7f8XV74xiorwVUIYndaApEvimxr3ChxIe55BjXp+vSCp0
         GPyo9WopbmTwj/6h0jn1qWchfCwPGKwacDZ8ANWczTohYkiubRHWVRkABAbH+1fKwkcW
         rxYr+0ZtkyvMTpkr0Hov+oceBeHFPBt5guMwbBDfxBzJkBxSJg3DGi1eunKOyqoOIO+j
         3V+w==
X-Forwarded-Encrypted: i=1; AJvYcCVbp8VmBMreNCCt5L54ZzHnYl5UWy+3EG9em9HBCRHjcyJNOQe4rl7k2H/UDKveVrvUf7lxs8LuiJFgBXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1w7bmtRwGu7gA9XBlpAxiMEEu5S0aRYceLlsKyYJRTLhWrN7m
	9HjOFfb95CqzIGU4b2vGdHXO5wgbdyP11HUameckyhtwZleRF3jTW6DxxuHwWp6/hRZsaokG67x
	gh6dtAQcHgT4eGQ==
X-Google-Smtp-Source: AGHT+IEjlJGoTZEIEFPBQWOYQsgcWBNv7STssnAASdis7+wkamn7O6d4OL1Kl7pDAhoyyf9ZnZoeDVErDdxX93A=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5b:c01:0:b0:e1a:9ed2:67f4 with SMTP id
 3f1490d57ef6-e28936be3c5mr12885276.2.1728409046382; Tue, 08 Oct 2024 10:37:26
 -0700 (PDT)
Date: Tue, 08 Oct 2024 17:37:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMxtBWcC/x2MWwqAIBAArxL73YKJPegq0cemay1IiUYE0d2TP
 odh5oHMSTjDWD2Q+JIsx16gqSuwG+0ro7jCoJU2jVIDWi8Y6SxyCYwUAjrnOt23TN54KF1M7OX +n9P8vh+NFNrcYwAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=iFRkliMPUiFgYsM5i8rizMPhx7zFXxbEfxZZGLUEsWI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnBW3TsOD5efmx2WY3KxUXdcrbqgeL+draJdGtZ
 55RjhOGUyCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZwVt0wAKCRAEWL7uWMY5
 RkQED/4zTm/du53TqD729hkfSVNMwM33H05QLQMm9IROlmKLIVEZCA8ESyRXRRzq8VwbtUqzvg4
 LVFE+cW6I0C1POs/RPTyRsXXHl8gKCPXxvKbHf84pnF3BTUAnv5YsSTEyl8dy7LdtHp+q+0VhaI
 xNY8QUGLB0eNQSg+Y12hu7agtkK2fduxLOYugeGNvlAAVkILawMnojEd9QC+V8T59K7retm0F4o
 qO75S0/OSRJBSLxQP+elsafKwxYoFinhixO1x1nvX+HtPcTsjsZ2ZFKD8SpViYHOtxOevQLzuap
 MXwLZWn5z0ecy15jm8oSNNcF1bPYMYyCGN6QZNgrhEGliPuGjZIr41I3Le2UfzWx3ujeY4GeEMH
 3lA1wRQSkGinDGVa6eeSywCG7kcVxFv9wqEdD4DpQI+IKCzFB+fEgsvZef6KhMwKiSIRoVsAnrc
 6RY1KI1XIPFvL2N2VicgwwNVeIfctHMekpgLtph/Di1mKHcGJBisNrkA8I2cDEin+gOLCateN3T
 GKoffCCtKIvnRA2hiY+OcfBzx3tfrLGsGB/KVWJMk2rfrK6qtgoDCaCiYgg3+dpx15xFZsYxbSQ
 rIiZmpyB25viTLbojc9WIxBsefdxAxvV1RxARqd1bI9vsiTuGO/noq84iBRXKwhvM6SfCla1ln5 ls9oM0phnbhLdFA==
X-Mailer: b4 0.13.0
Message-ID: <20241008-cfi-patchable-all-v1-1-512481fd731d@google.com>
Subject: [PATCH] cfi: rust: pass -Zpatchable-function-entry on all architectures
From: Alice Ryhl <aliceryhl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Kees Cook <kees@kernel.org>, 
	Matthew Maurer <mmaurer@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The KCFI sanitizer stores the CFI tag of a function just before its
machine code. However, the patchable-function-entry flag can be used to
introduce additional nop instructions before the machine code, taking up
the space that normally holds the CFI tag. In this case, a backwards
offset is applied to the CFI tag to move them out of the way of the nop
instructions. To ensure that C and Rust agree on the offset used by CFI
tags, pass the -Zpatchable-function-entry to rustc whenever it is passed
to the C compiler.

The required rustc version is bumped to 1.81.0 to ensure that the
-Zpatchable-function-entry flag is available when CFI is used.

Fixes: ca627e636551 ("rust: cfi: add support for CFI_CLANG with Rust")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Note that this fix uses rustc-option which has a pending fix:
https://lore.kernel.org/all/20241008-rustc-option-bootstrap-v2-1-e6e155b8f9f3@google.com/
---
 arch/arm64/Makefile     | 2 ++
 arch/loongarch/Makefile | 1 +
 arch/riscv/Makefile     | 2 ++
 init/Kconfig            | 2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9efd3f37c2fd..d7ec0bb09fc4 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -143,9 +143,11 @@ CHECKFLAGS	+= -D__aarch64__
 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=4,2
+  KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=4$(comma)2)
 else ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_ARGS),y)
   KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
   CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+  KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=2)
 endif
 
 ifeq ($(CONFIG_KASAN_SW_TAGS), y)
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae3f80622f4c..f9cef31d1f0e 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -44,6 +44,7 @@ endif
 ifdef CONFIG_DYNAMIC_FTRACE
 KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=2)
 endif
 
 ifdef CONFIG_64BIT
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index d469db9f46f4..65d4dcba309a 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -16,8 +16,10 @@ ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 ifeq ($(CONFIG_RISCV_ISA_C),y)
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=4
+	KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=4)
 else
 	CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+	KBUILD_RUSTFLAGS += $(call rustc-option,-Zpatchable-function-entry=2)
 endif
 endif
 
diff --git a/init/Kconfig b/init/Kconfig
index 530a382ee0fe..43434b681c3f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1946,7 +1946,7 @@ config RUST
 	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
-	depends on !CFI_CLANG || RUSTC_VERSION >= 107900 && HAVE_CFI_ICALL_NORMALIZE_INTEGERS
+	depends on !CFI_CLANG || RUSTC_VERSION >= 108100 && HAVE_CFI_ICALL_NORMALIZE_INTEGERS
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI_CLANG
 	depends on !CALL_PADDING || RUSTC_VERSION >= 108100
 	depends on !KASAN_SW_TAGS

---
base-commit: 4a335f920bc78e51b1d7d216d11f2ecbb6dd949f
change-id: 20241008-cfi-patchable-all-ddd6275eaf4f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


