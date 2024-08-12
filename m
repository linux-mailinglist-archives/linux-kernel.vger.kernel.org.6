Return-Path: <linux-kernel+bounces-283910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5CF94FA45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA76A28173D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002419A295;
	Mon, 12 Aug 2024 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nI++Z9P0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B33198858
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723505360; cv=none; b=ZwtofjXkN2tv9iz2VthBW4gbLFKUzHc2g/Zg0GmR4BhsfyWfM8oj2uJ2UZ/ZFA2QqlC4N2vOQnafjwfdwXHvculrBFNZ3/XS+NMbXhhX/5fAOEgsxVVtBXR8cxG7K+YxHC01QvT31TpqOrhlGDHkvS983Vn5qJYTlqhsO/rTrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723505360; c=relaxed/simple;
	bh=WNJRbJEWl/JK8Az8ghGCXWH3fm68Jwe8K6UK0+dCVTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C0FgDvGZdWaZgy8kQFImTKH7yPTSzK5jvecljMEHiyeMPs4I0mE13q5GfJSW8RkJcbN21a5lfhBQIpyPDJxVawZKp1IbPStOJGxIijypCgetBhw6/F5mDs+z8HrPDH5TEWJzEUK5MCdUfrCxs0yAOLLK2uzeZnymrmDRgwlgs+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nI++Z9P0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-664fc7c4e51so101180387b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723505357; x=1724110157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7N7Zf7M9w/vAcr3WmdKFD5NuAFU2ocCw/qlD1RHyGfQ=;
        b=nI++Z9P0Hbtgv6lZRMacQqBuLNhX/D9QUqU0JgQ/McFHvX75Mi9UKlyVfZ/pCERJ+T
         nZjivdKRBO0qIuLWfznqWg7H3ee31ctoIjGH1Men+tiN+WoAkzReKLwJUlBF8mH7jb+2
         v62bjSR6LGhGsY7CvoDYeUXwPq/ZtxaGR4u4+WdhUdOMhnCJzVKwzmFzO0AlnlWZw6Gz
         c014NdptgSHwl50dIrfPB7k76dMvcagTp/MR+nEUnyR+WQxJUtBTkckEIGvsg+12Sp3Q
         AQZKclb2jhdwPztccN6+xKeSiFiqf6+UqwZ989tgKHxkk/m+HeXf4GUbe6yWNII9XWK2
         hxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723505357; x=1724110157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7N7Zf7M9w/vAcr3WmdKFD5NuAFU2ocCw/qlD1RHyGfQ=;
        b=lc2YoghE0N5EFFDV7BSH2WZDEl6E0UzuNXO24RaYScucETaMfHa6WfoqVH8YiuL7Fy
         tNKJTrsftj1nBBlnBWD/bUU7chsma/UCUmHgdp4Kb7/dQcfweMdPybpbFWvzbub40vYt
         ZTAVsNisHITv5PbW+89+Bcb9SvOycXpifoAjebirgZBWaalpsRZjdULSpjYnC9Vfo1+F
         MW2wx2iACwWDZMfC8AVajoXgiQLZBKjQESHOcnxohR4g9Yrx1nwoPclwVEptZPL+PJrp
         eEe8pBkbDEphJjFv1mpoPCRKpvG95YCy/5uQE0YTDiwarkqsy4kYPLwUh/8f9/TAcySp
         VH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0XWbC8ALsqk7pAoXzv43MjTEuWa1MrCFQeM7vsJteubzFm97g9UNFShc2N5s5fi0mOUYx+jwXxeJHRSiX5aOj4yfHpsk9IZXPZJVw
X-Gm-Message-State: AOJu0YxjBp9/fE0GcjTkqRQ5lx8am+QwOHv6JQnlk1tJ2pj0Zv3NZS1q
	kIbQ//VZz/UtYtIr+UAU2hrO1QlCB38hvHOhbfiVq/1EGogELzSIPNrhNbB7zN2FgfxSpbBddnP
	G4+wn5A==
X-Google-Smtp-Source: AGHT+IGRZ7bB9Rd9wSfHyVUbB3/tTwK9kGhukQq3NaerqGLW14qddIs8Na8NhFcz/b5szJZ/mPTFY0ftUxja
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a0d:e943:0:b0:68f:dfc2:98ee with SMTP id
 00721157ae682-6a9755e3147mr733687b3.5.1723505357680; Mon, 12 Aug 2024
 16:29:17 -0700 (PDT)
Date: Mon, 12 Aug 2024 23:29:01 +0000
In-Reply-To: <20240812232910.2026387-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812232910.2026387-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812232910.2026387-2-mmaurer@google.com>
Subject: [PATCH v2 1/3] kbuild: rust: Define probing macros for rustc
From: Matthew Maurer <mmaurer@google.com>
To: dvyukov@google.com, ojeda@kernel.org, 
	Masahiro Yamada <masahiroy@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Nathan Chancellor <nathan@kernel.org>
Cc: aliceryhl@google.com, samitolvanen@google.com, 
	Matthew Maurer <mmaurer@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
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
index 3500a3d62f0d..becad3d0b1fd 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -64,3 +64,11 @@ ld-version := $(shell,set -- $(ld-info) && echo $2)
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
2.46.0.76.ge559c4bf1a-goog


