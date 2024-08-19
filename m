Return-Path: <linux-kernel+bounces-292933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56499576A6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 23:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CB28411A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FDE1DC481;
	Mon, 19 Aug 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d2iYOmyp"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846411D54D8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724103346; cv=none; b=TuFQtLGbQrUhixFJVZqbguylxhlpIGbHtZJ1phPt/vDjuuKsPa/zWRejEJ0B9/3Wmqd2nzYNa+fqubuFeGefbET6Rz5XwdKTOYKcoIDaqejlaBSTGk2cIS6CsQ5Y1+Mk4L/n0+8GlSfbGnWWcOiLyEnLnJCiXLDRuIMKh86Yz9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724103346; c=relaxed/simple;
	bh=uOhiT0jp1CouEzn/qv7waMQHRkLl2sOBHy2Im7EqXS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UkHGe+9qGlNaRL8jWgAK0h4COChkPjTUrKZa0ECp8QEdnAR/W/Lx0Q1aevHC+JIdwA8TFTCTtWP2fWHmynxm6arYbOzKCk09/nKgex5z+zo7bQ05CVjGnEn9Ak7mj0NVEvHyzTyVhc+MrHOn6b16uTD55iM01HLatExdLIhmHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d2iYOmyp; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ad26d5b061so81613797b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 14:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724103343; x=1724708143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dYHfB1jRSques99oHkY91uNPL3BC6i2xvsHR0qX5+O4=;
        b=d2iYOmyp/cBcIKHY3r51ekQb7QPCyD2VGvhG2LIi7EIqd3/F9AiPqBZXwWqVa5DbiJ
         bhbtMnxF9wpPcw3HZkGw6/EZfekomseyKKUV8sYcRfz6xDiYVH4zo8JHCRN441G1X+IP
         a8uEyITezdde6MadzeVELezZhLcL5xUtvXEkxS4FaonmgwHaHoSg1pZciJRFz+SwtPOx
         ROoXNyB4ZFjwdn1MiHO8jDvDDA6N2OVC1IjPR9UnCP1t336VprqrAE8pQ+7cozAyBOTD
         vXxKaHSkG77NIZIPVDmxbFRlZf55rf73VRDALqqbbAI4I7ARxzCPgzbWLLisowyCYs7a
         yduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724103343; x=1724708143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYHfB1jRSques99oHkY91uNPL3BC6i2xvsHR0qX5+O4=;
        b=WuU/F6/smxxtfFjjxgA+FZFkI73LXYryMvw4dt2gdN6c8f2B0O36+dHmw7mTHXBMQJ
         vlrYa0dg/Tp24h6d5d10HNBSc9kdQIBpnEmNkaQ354DOgoXK5wMfuI28uGDhr3f/7O9y
         oHv0/8v2EUOs0HnghDfVd4FPRLKRKIhmycCWBUh5l8HU9P31rlJPH+HKLaIgTBdRi80p
         Uy+G2hwTq17RjEEwxJtPkjabILLdtqg7wZpRkkamqkT/wWAog9/yttQWI5/PEx80+73b
         DZCJkeiqZuWBkHzgz44NDw2d+XLg3xbsoHNhN3lFKrVFTsmsazugMvaeMIDceBcTiWdD
         RPbA==
X-Forwarded-Encrypted: i=1; AJvYcCWxmqtIWdibHCDjWnOta9/z295+/H/wEYTwx7/+5BZWyLiUr3XljnSIFU5wqFGMUW9kYBeNFtRfcSt9GCgJLOZRQMyWBYCke47DSeS1
X-Gm-Message-State: AOJu0YxHnhpCtxi3fQJLSGSksjjp9nQQmJRZszJUKNZS2nfs1cjW7O7g
	qHyTnIeLsytG434uV3PCI3abywtoGfU8Fbi3yEYTb7rbyUivVUCuaqI9u4AnlVET4NFvKAqvEiY
	eO+MYlg==
X-Google-Smtp-Source: AGHT+IFwshO87RfhTzH1yMuE+dB46zbPZ1Eu9OzIlegM79V4EtZO9MXEpG14lmgTuz2TbiBW6ciN753E2AAE
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:2912:b0:62f:f535:f41 with SMTP id
 00721157ae682-6b1bc5e4037mr4097737b3.9.1724103343636; Mon, 19 Aug 2024
 14:35:43 -0700 (PDT)
Date: Mon, 19 Aug 2024 21:35:19 +0000
In-Reply-To: <20240819213534.4080408-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819213534.4080408-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240819213534.4080408-2-mmaurer@google.com>
Subject: [PATCH v3 1/4] kbuild: rust: Define probing macros for rustc
From: Matthew Maurer <mmaurer@google.com>
To: dvyukov@google.com, ojeda@kernel.org, andreyknvl@gmail.com, 
	Masahiro Yamada <masahiroy@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Nathan Chancellor <nathan@kernel.org>
Cc: aliceryhl@google.com, samitolvanen@google.com, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, glider@google.com, ryabinin.a.a@gmail.com, 
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
2.46.0.184.g6999bdac58-goog


