Return-Path: <linux-kernel+bounces-267182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9C940E34
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F03B2985A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F921922C1;
	Tue, 30 Jul 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdOmP+yf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DC19645E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332451; cv=none; b=GD/uC9dZW3P51O/JlPleI9cJ6UKcc4RGR67T6ThmfLZEcD7f+ny1vbl5qZ1zSHyUTVZ6IL/V7HlCg3S8zrwqClUfyFaFGSyObOI87ZqYC8fXKFd67XRIGDq0fxq9y5n9sI8BeYNY1e8kflnebki/gFPsGYYoVwer57FkHLg/3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332451; c=relaxed/simple;
	bh=A3cI2hguaSwLAyhYk7iI/X7OgJ8mJQf9Y4OLgMs18Bo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ThXHVMZ0Z9DR77bkeg3upyyk9VJMDrAYJxs7E1E2HI3H+kZw37lgKkD3lJrcU1KvzzrkpjrR1WGPcmj4BVKl4NLtIFGiKEtzshuXMLYIJBI3g+pQyIeju3Kj14BoCfDJG/NCTkd64xRnl1QlWa35cp8uGyVewwH40CHiHt6U/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdOmP+yf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-650ab31aabdso70280817b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722332449; x=1722937249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cR2nWa9me3V0/h/7Q2Ujr3xpKLLpeeNuky2sgUKvC5o=;
        b=HdOmP+yfqfitS7OdOCZV3070JFdTq5pVdVUn7UkuTPPjg73TZQCyBZ1jtIvv2OgoML
         +rn99NhCm74nKtkudcOGLe1dM4lemZmDsMvsFV7Ng7x1p6tqGqnnG5rE+g5jqImK3Wqu
         a+NVSI8/gALEqGcariUl+yog33tgP8MNkrhTRIlIa1eEwO3roUf3nZqhAnxv1CXJae6e
         ZTh2fJ/Slv8mtaGksDixqiC4vdxv7dc2okVly5337Cx+SG93s3Rm55EzOF6gyosETeq8
         3kbzp6XkOBVlObjjiGeRrMmTYRhrj66YrY8T9Gp/xYdmCUYbINg9RQh62HOmGx7/aZR0
         950Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722332449; x=1722937249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cR2nWa9me3V0/h/7Q2Ujr3xpKLLpeeNuky2sgUKvC5o=;
        b=IMFGsKGtXW58ZY2jZ/z92BHjwCkVfmaRb30L13vtUwIEYgcEYvGsYOSNsR53LzhOuf
         pYKySrF4XptiK98OJxKfEpuAKnMrykD0i7cqOV1bY3pC9lmbizR30jd90x37KGOpz8ki
         xbMfcfsxSWk2woM/BBX78JRYu7qaMVYAFM/mu7gHGqIEz/f4+A7+9HIfsoNhItbQ9dXl
         xsZ1i7+T8pF5ioX6iBtNR/SnoCWFJzQKmgw9/O9hETCqDESs+bpsltfeoW37Onzw8RKg
         0q4Q0Id5yrBJehLtH6oqFOsdisM6HOsxIPWwBQg2SluVIXfWZU0M1mIcTE3eEP/z0Cnl
         o37w==
X-Forwarded-Encrypted: i=1; AJvYcCWuXbWx32uD42hKzEYNsYMEczWLJnHz/gNbx92zGUaSpKfROabkVLTdzlLY+Rur+Ibl2SJbxZfXv0ubUvuz9IeymbzVkXtULpGvyq6w
X-Gm-Message-State: AOJu0YyVjXZ8ReOaydqqot6BGoIuSvKo3kKFAqJrZGBeN+KQ9V1HdEOP
	PRnza46mptjHXAlbu2tFFytM2swrbiydsHKBLOEfsU06pvx5UMOmix3NIP4mI90Mm7jvKvutkMO
	g6Ba8Axm8svfeGA==
X-Google-Smtp-Source: AGHT+IGI7oVDCNSCug5ABVUu6D5JmFYKEyApaYx+gbtysI515vov73l2r/3QnNveGXBT2X3/mxQztTIkdfFeZuk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2b0d:b0:e02:c619:73d with SMTP
 id 3f1490d57ef6-e0b544198d2mr488622276.5.1722332448753; Tue, 30 Jul 2024
 02:40:48 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:40:12 +0000
In-Reply-To: <20240730-kcfi-v1-0-bbb948752a30@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240730-kcfi-v1-0-bbb948752a30@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2976; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Bc7tzTvGYJ0xMlfOL8vhUAcW9moWXAVuJHeorWuuWBQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmqLUXYjbAv7YfVwWFfN92SDQxOLtAy/WaCzGdd
 hE3ksXdCgCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqi1FwAKCRAEWL7uWMY5
 Rq6OD/0UFJQagVrWBkZmg9RytX2H/vdG56Ma4tK8XwOW462Eer56UP5HHvagJRX9+bjtWzZPYdz
 OFJ6kq3ibCrI54fimZmInN8PyPKDgatDNcHYiByHaR108MtKowSHEEN0WKcASZnhaS6FYYEpF/s
 enjWzWCa7F8g1u0UHF2W0NwT/L7aScWsKV/KZPiGAoUYPqsBRhGK5sIddtQvxYz9/ISRkV/iaYb
 EbKc1Mc9px00VEievHbkW/MuRa4feYen+cFMlCD4zYYUESSmLB2KWyrAjXX8MM4YTQpkiMwsCg1
 BCckrulk+aZhCFIy7CAb1IXVwiu22pDT9WXLS/txqGAPg6cJDbsiH6yA6GzhSq3hMRW5PKNwhgL
 s8cOHKep2YJ4GdNMkcQHhYb52+gGlqgj1o/55iQveUUnqFWQ2eq0K52JdvOquntSeV+VdIkA/fm
 PtRMxikbou6Wu9yTWByVCBfZ7gdBoptCaXhMNfYE+FisR0xXqVCvObBnJinyVclFwh4rPkvb6Q4
 39w68LHSf6+i3k55l3vYF94f1sZ7f0locb0PmOj4o2EtDzl1WdRMjcW6kQea9R5OGTbC5JCg8Pq
 M9aYtbk4wWAoRH0WfLBLTkX9atvhrU7JmLOFQqa9VVJQxAibXiUD2JIffbjElTMTPKF/84b5E88 qp48V0MSVXuh1gQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240730-kcfi-v1-2-bbb948752a30@google.com>
Subject: [PATCH 2/2] rust: cfi: add support for CFI_CLANG with Rust
From: Alice Ryhl <aliceryhl@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Sami Tolvanen <samitolvanen@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Maurer <mmaurer@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

From: Matthew Maurer <mmaurer@google.com>

Make it possible to use the Control Flow Integrity (CFI) sanitizer when
Rust is enabled. Enabling CFI with Rust requires that CFI is configured
to normalize integer types so that all integer types of the same size
and signedness are compatible under CFI.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 Makefile                        | 7 +++++++
 init/Kconfig                    | 2 +-
 rust/Makefile                   | 2 +-
 scripts/generate_rust_target.rs | 1 +
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 484c6900337e..8d7d52f57c63 100644
--- a/Makefile
+++ b/Makefile
@@ -955,6 +955,13 @@ CC_FLAGS_CFI	:= -fsanitize=kcfi
 ifdef CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
 	CC_FLAGS_CFI	+= -fsanitize-cfi-icall-experimental-normalize-integers
 endif
+ifdef CONFIG_RUST
+	# Always pass -Zsanitizer-cfi-normalize-integers as CONFIG_RUST depends
+	# on CONFIG_CFI_ICALL_NORMALIZE_INTEGERS.
+	RS_FLAGS_CFI   := -Zsanitizer=kcfi -Zsanitizer-cfi-normalize-integers
+	KBUILD_RUSTFLAGS += $(RS_FLAGS_CFI)
+	export RS_FLAGS_CFI
+endif
 KBUILD_CFLAGS	+= $(CC_FLAGS_CFI)
 export CC_FLAGS_CFI
 endif
diff --git a/init/Kconfig b/init/Kconfig
index b0238c4b6e79..d0d3442d1756 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1905,11 +1905,11 @@ config RUST
 	bool "Rust support"
 	depends on HAVE_RUST
 	depends on RUST_IS_AVAILABLE
-	depends on !CFI_CLANG
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on !CFI_CLANG || RUSTC_VERSION >= 107900 && CFI_ICALL_NORMALIZE_INTEGERS
 	help
 	  Enables Rust support in the kernel.
 
diff --git a/rust/Makefile b/rust/Makefile
index f6b9bb946609..a2c9a3e03a23 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -305,7 +305,7 @@ $(obj)/bindings/bindings_helpers_generated.rs: $(src)/helpers.c FORCE
 quiet_cmd_exports = EXPORTS $@
       cmd_exports = \
 	$(NM) -p --defined-only $< \
-		| awk '/ (T|R|D) / {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
+		| awk '$$2~/(T|R|D)/ && $$3!~/__cfi/ {printf "EXPORT_SYMBOL_RUST_GPL(%s);\n",$$3}' > $@
 
 $(obj)/exports_core_generated.h: $(obj)/core.o FORCE
 	$(call if_changed,exports)
diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index c31657380bf9..9b184099278a 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -192,6 +192,7 @@ fn main() {
         }
         ts.push("features", features);
         ts.push("llvm-target", "x86_64-linux-gnu");
+        ts.push("supported-sanitizers", ["kcfi"]);
         ts.push("target-pointer-width", "64");
     } else if cfg.has("X86_32") {
         // This only works on UML, as i386 otherwise needs regparm support in rustc

-- 
2.46.0.rc1.232.g9752f9e123-goog


