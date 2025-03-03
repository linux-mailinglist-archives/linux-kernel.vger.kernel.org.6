Return-Path: <linux-kernel+bounces-541182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0DA4B9BB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49DB63A6A4A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5301F0E3E;
	Mon,  3 Mar 2025 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p48O97by"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F771F0E43
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991558; cv=none; b=HZ7jFFWvCY85V6lagGC4kNDvdZ7FwipNyN63FqOIxiY1qL1PKq1NjSGQKDFXXK4i7UGvCGMoR0tgEGKfyfsNa3xLE+rlYHobOECtTps3WJmU4YkeYttsBd2/ewxYuOPlpDIHBmhcUNXoHIRHymUKfW551FeXrjsxzHGBLFhUDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991558; c=relaxed/simple;
	bh=27rIJnpKMgqp3S9uOE1r8d3kMA+evBJFEj9qZVD/zkk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=krK+Ljmgf2RbhzRNanzuKjW2rEvC0b/ccOhuuKsJyvOgqqJTH6ZM6A45JFDneSRncyKqriPrflAILWomm8QuhZZqGQk1ev1a04HDMLdJtnFIX+p1eYsz9g4QD7g+MAJGKEZX4hK04zFpmYmGOT7d0EyoFpACVFXNxbYjv4HFQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p48O97by; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so35745675e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740991555; x=1741596355; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlZATerwOi5j8gaqWad51my4T/CPZsM36wEeCkoHEk0=;
        b=p48O97by5p6mUj8nZfDGwi4iuM/oROgGLYrNRlsmfg6Xblg0vmQEGagz+wu+Wh01LH
         m8rBVI7TP/ZiJk+jV5cUaDYTIdUVCnoD6XM1gFHXQqiz4mubtzpXCO2muQtqGyYyfwmz
         5OjN6p4JOlpM8tX7/EwcFjG9HawDckUiVATXkFdUBMg+A1aBGwIX8LuOcZVo7hzqD1Lz
         m9eSsnBGiAo5TUmA/3lPHXzhrxKovn7IkXbauit28Le0eJrHagDLbdRP6ioSGWK/PhGw
         hMEsXZe3Kbw5sKGoqnJ/6PKUN/P3DppszCTiOjEu2on03kBnRYk0bRUxzHahpMYMYy/7
         s5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991555; x=1741596355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TlZATerwOi5j8gaqWad51my4T/CPZsM36wEeCkoHEk0=;
        b=WHvb7cSLnvp0jDLhGBo0OlS5p9+udo82eY2pZBiip4d6s7ptZ+yJuQQr8KR3tgv1mB
         m2DaWgELgrYm7QO3f/3Oh5J9o8KvMXILJyH2uybvhf57onLWY722H9InrOVVQIlkd9xU
         TDMwRH1t4Ed3xifQ7WZUeK+yNjetHsTYhtNWi60jRd9SkRjQkNyC16fYvTEjbrnubb/R
         DdipLyv/GGPpVzHigIFQvnhHeEaF9NZ8FBtcT33AhFphRBmtcoKL3/NXYPNKW9Hlpd40
         hjkB+Dn8n+XwsO6CUX4Jh+69PXqohPQ4Z5ksC81m1GcdBOuxwh4s9tU/MITMt3j7Bgem
         loPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjWYsndhjuqhFoS82ORSgmYUlQdnRIrmnmghdpCaTFUe2vWIuPDjj6l8UoQNv0rcpZr8gCf+pRcCMAYHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWkWnuRW+egCmEwvZ5lMWoKKCvh2FKk3N2XKjZ5Cg7Yfog6/38
	11gtjIeSz8wCDrQ49/1kDVpwjRwvzBm9gJYOMMG1aLJB1pdhx74BXourgBWmiyj5KksBC5wu6Is
	DyRUvpREBbsavIg==
X-Google-Smtp-Source: AGHT+IF/OlL6SSDUrA711Q70XX+2KHCrfpkEqlIN+HJZdKgaK09VyIf3il1gLPXIbqk4NQNUA9/BHyQB6JirT4I=
X-Received: from wmbhc11.prod.google.com ([2002:a05:600c:870b:b0:43b:6943:f013])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:154f:b0:43b:b933:33e4 with SMTP id 5b1f17b1804b1-43bb9333572mr39999305e9.15.1740991555606;
 Mon, 03 Mar 2025 00:45:55 -0800 (PST)
Date: Mon, 03 Mar 2025 08:45:15 +0000
In-Reply-To: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=27rIJnpKMgqp3S9uOE1r8d3kMA+evBJFEj9qZVD/zkk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxWw2Tay53acZ34Qn0eFiLPW+Lb9vqKq4R/vG+
 fx9bpMrWpmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8VsNgAKCRAEWL7uWMY5
 RnTbD/9YsPVC7+afuFs+98V5aJHhzrUsrsUFek7EYVLlN7anvgFXZxC5zDoVi/nKouxeYNlUrkc
 nfExRYI0ZxQ54u4GfOXQlinasxJJwgXnwcymxJNwO4mg0St1dJaIgInwn4tvjtASj5I9aEOwcXE
 u45D6rRKGtyWOJkwGSh76n3mNuwWSLejj6TrTQeItBP2dK1djpNdyvqjWE1NT6bijf79nFgDOCG
 b5rQ/f253UATffkklrsB+DVFQ2C3Qwke3eDB9sZsNNlOUzX2FPFxuUhc/g0iMsp74jbh+mPLauc
 MDp6YC0mvqDWt9VykZdmjb9WhvgOQxktmuMMmszdOBgpu2Q1zJ0yXZ7bEqtwPgLzGS2e3RfUvII
 QSGkt4/jG/5vCO7daJ6gnQJrOHdK6oh5SvbjPLOhOnDqo6ZiQ94EBhmdnc9lZXFFLLixX57HALS
 hxF+9lS0IGeqfadsMhaBnBU2iKF7M5zcIv2GP4xS93UMUuDLv9zXn6jR8tdAxHnRVPwlzvb3LQ2
 kljkwSsO+yYAsFZogs2EyYIs3myE57AmrK5QsztGscSBm0GmYx75alc7vCq2XKeDsVVa3Ysmn4G
 22cKUJot+xuuQtxOslAt3ovEaDbED+emWSenu2ChOBo+AvJ6KAl2UMB5JzN3ejJFsF7d3X4oQJz dmH/R6fzrwpBmvg==
X-Mailer: b4 0.14.1
Message-ID: <20250303-export-macro-v3-4-41fbad85a27f@google.com>
Subject: [PATCH v3 4/5] print: use new #[export] macro for rust_fmt_argument
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This moves the rust_fmt_argument function over to use the new #[export]
macro, which will verify at compile-time that the function signature
matches what is in the header file.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/sprintf.h | 3 +++
 lib/vsprintf.c          | 3 ---
 rust/kernel/print.rs    | 3 ++-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/sprintf.h b/include/linux/sprintf.h
index 33dcbec71925..029ad83efd74 100644
--- a/include/linux/sprintf.h
+++ b/include/linux/sprintf.h
@@ -24,4 +24,7 @@ __scanf(2, 0) int vsscanf(const char *, const char *, va_list);
 extern bool no_hash_pointers;
 int no_hash_pointers_enable(char *str);
 
+/* Used for Rust formatting ('%pA'). */
+char *rust_fmt_argument(char *buf, char *end, const void *ptr);
+
 #endif	/* _LINUX_KERNEL_SPRINTF_H */
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a8ac4c4fffcf..1da61c3e011f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2284,9 +2284,6 @@ int __init no_hash_pointers_enable(char *str)
 }
 early_param("no_hash_pointers", no_hash_pointers_enable);
 
-/* Used for Rust formatting ('%pA'). */
-char *rust_fmt_argument(char *buf, char *end, const void *ptr);
-
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
  * by an extra set of alphanumeric characters that are extended format
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index 61ee36c5e5f5..cf4714242e14 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -8,13 +8,14 @@
 
 use crate::{
     ffi::{c_char, c_void},
+    prelude::*,
     str::RawFormatter,
 };
 use core::fmt;
 
 // Called from `vsprintf` with format specifier `%pA`.
 #[expect(clippy::missing_safety_doc)]
-#[no_mangle]
+#[export]
 unsafe extern "C" fn rust_fmt_argument(
     buf: *mut c_char,
     end: *mut c_char,

-- 
2.48.1.711.g2feabab25a-goog


