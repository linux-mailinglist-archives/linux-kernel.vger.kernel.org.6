Return-Path: <linux-kernel+bounces-262713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2304393CB31
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C48B2188A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD5DF6C;
	Thu, 25 Jul 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iUB+V1cu"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04381149002
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949707; cv=none; b=JRpupq6NMIReSIxJyM5vH44hDzMPlthZ6rUKqJnkonhPN0AAC9zH21/epDLcV3/r8ySKzYmbWf8gtGcmf8CEkP0YWUJZBRtgNq6l2WeBZcqEU8cB1sRhe91JYzAUsQ8RKfLNd+v/4F2KouJhL8StU1YIkBsb9Ta7LulBdtl5xG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949707; c=relaxed/simple;
	bh=ZKaF/D01LQsHjAvoedlEW93oVhWFVCMFh6KAZt0Po2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aCdBUkkvcwDmZWZ2aRiNSNqXlBWG5xPqIjFg0z1Nv9RnBc8O4/xE8HaDQvlWxdlGN3qc1UnV8aJmdMyd3rgCdMrKbxPTDz5B+cfhPtPl+BNJuxN8lYS2vn/L0pWzidoKxRTpVz6XJ5UKC3O/mKKv/5eZI66cvoZE8h2/7/Qbfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iUB+V1cu; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-79028eac001so375140a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721949704; x=1722554504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y13cefxKDwFOzGl/kd1oLgkzNPir8kAC6sYxj1AUEz8=;
        b=iUB+V1cuhhXYq3f6SYiCQbmKSti7ZtfmhOWJ0f1V2RSD/TYW96twZxMgJGY9EPU3Jx
         rP1LR3jECrGu1uEgVFP3gAnkbQuWtqE9sZgAzadj4pMtLe3bx7NxHsWoMMTot2kaPY/l
         /AO0E3uJiqqGSvGTNi6hjUsPESUCjpkq8qOuUSDpCYPnfdsrpyftEbwNthIUrFeiDmVW
         4jxL0YS2jYL2FjeHyheDFVY04DTS6pxFuktE7nFapDxsN3W6O6KG9xAkIVwjZnWEUH3N
         7Daf9E/bpET7cHUb9vRA4CsBDRQNnqDue9aVy+7B2DynIXqaQZEzlTk2+8SKnr4v4snM
         JnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949704; x=1722554504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y13cefxKDwFOzGl/kd1oLgkzNPir8kAC6sYxj1AUEz8=;
        b=uOVSsnEevgqhPDHIhdzhjEABYldM1oBshpSp9WzXWKGYavXpDpOil3J3BFxBLaCj8l
         oS4YCIen7xLhclfPkWcSlaUUgbMwsiGJjyATCscHnDi2AtCR8ARjyd3FEjNkP/LZzeD3
         NkfcUHvVLG1neryX7N3fm6b6l1dYozEN87FIf0L+mcr1u+fSs+Ow6Squ/5+9vGnkInKN
         e5LRc7mrQCqPHR5wSL1R4AvjNrTQ3Fei3kR+j5r5kucSQ5Vfg9i9HBhV1w3S5oH5KRiW
         lWoOWy90rFBZ/V3i/rn44maLZ8ylTSm79NHha9oxK6kNlK8K6Gqjw2G8Ghwm/74D9xK6
         JQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPC8f9PPV1Ul5EESSZN1hAy0IBUF+pBisKDj7NLbpp8iD6rw2HPN5fawPL56e7QYmk/P9EhOKanqOCUCzUTUOATBlJPwZiWCO6N/8w
X-Gm-Message-State: AOJu0Ywefjcp0rgcIg2Hqri+63V4BGmy/u4PJVNtzNSk4VEEMNeUtwOh
	T6rJuzPYSQXlqAuhVMiI7vBYON0TrhR5UgblniXrM4eD3bYj+nr4r4L8VSAsBDxzwS8gt/ZVuBh
	ObIO5xg==
X-Google-Smtp-Source: AGHT+IHjrE954mcIGIRH54e2mts+0YSZZYtNHD5+2mBbyQ/nTzFDy9aH2ICIt5W6uuPPduDm1v2e1Bn5ggyW
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6a02:488:b0:721:414f:189a with SMTP id
 41be03b00d2f7-7a9c7a67420mr8182a12.4.1721949703919; Thu, 25 Jul 2024 16:21:43
 -0700 (PDT)
Date: Thu, 25 Jul 2024 23:20:46 +0000
In-Reply-To: <20240725232126.1996981-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240725232126.1996981-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240725232126.1996981-2-mmaurer@google.com>
Subject: [PATCH 1/2] kbuild: rust: Define probing macros for rustc
From: Matthew Maurer <mmaurer@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Creates flag probe macro variants for `rustc`. These are helpful
because:

1. `rustc` support will soon be a minimum rather than a pinned version.
2. We already support multiple LLVMs linked into `rustc`, and these are
   needed to probe what LLVM parameters `rustc` will accept.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/Kconfig.include   |  8 ++++++++
 scripts/Makefile.compiler | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 3ee8ecfb8c04..ffafe269fe9e 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -63,3 +63,11 @@ ld-version := $(shell,set -- $(ld-info) && echo $2)
 cc-option-bit = $(if-success,$(CC) -Werror $(1) -E -x c /dev/null -o /dev/null,$(1))
 m32-flag := $(cc-option-bit,-m32)
 m64-flag := $(cc-option-bit,-m64)
+
+# $(rustc-option,<flag>)
+# Return y if the Rust compiler supports <flag>, n otherwise
+# Calls to this should be guarded so that they are not evaluated if
+# CONFIG_HAVE_RUST is not set.
+# If you are testing for unstable features, consider `rustc-min-version`
+# instead, as features may have different completeness while available.
+rustc-option = $(success,trap "rm -rf .tmp_$$" EXIT; mkdir .tmp_$$; $(RUSTC) $(1) --crate-type=rlib /dev/null -o .tmp_$$/tmp.rlib)
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 92be0c9a13ee..485d66768a32 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -72,3 +72,18 @@ clang-min-version = $(call test-ge, $(CONFIG_CLANG_VERSION), $1)
 # ld-option
 # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
 ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
+
+# __rustc-option
+# Usage: MY_RUSTFLAGS += $(call __rustc-option,$(RUSTC),$(MY_RUSTFLAGS),-Cinstrument-coverage,-Zinstrument-coverage)
+__rustc-option = $(call try-run,\
+	$(1) $(2) $(3) --crate-type=rlib /dev/null -o "$$TMP",$(3),$(4))
+
+# rustc-option
+# Usage: rustflags-y += $(call rustc-option,-Cinstrument-coverage,-Zinstrument-coverage)
+rustc-option = $(call __rustc-option, $(RUSTC),\
+	$(KBUILD_RUSTFLAGS),$(1),$(2))
+
+# rustc-option-yn
+# Usage: flag := $(call rustc-option-yn,-Cinstrument-coverage)
+rustc-option-yn = $(call try-run,\
+	$(RUSTC) $(KBUILD_RUSTFLAGS) $(1) --crate-type=rlib /dev/null -o "$$TMP",y,n)
-- 
2.46.0.rc1.232.g9752f9e123-goog


