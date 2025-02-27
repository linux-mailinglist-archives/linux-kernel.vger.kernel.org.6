Return-Path: <linux-kernel+bounces-536941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEC2A4860F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7382E7A6868
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4081DE3CB;
	Thu, 27 Feb 2025 17:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkKOfAU3"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B351DC9AB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675763; cv=none; b=eHLvHi6RonJgQxO8FHjE3z2u/wwbtVAa3l2M5EBod3xrO0bSH94L4+PMDaTgx8ZgrOaVgxPz/nbi21RXE+L76zuMOUuv+TePBeHansSu3fwoKvurAuRfuYNJIkfe1dtys+cvXtN5QZYprywjp0lv9qZ+gDgkqe1LWOV8n91Mvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675763; c=relaxed/simple;
	bh=DX4aj6g1+3gi1MzmclI/m0bUFCVi048l6tZnNSfBMrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MHqj7aW09MLVuhKtMUUkwaPVS9kwYnkGzkGsiteozJPfo6551v/GCKCKJqKsulg6p7Y3fkbRMEyJo1WHXeSc8iMfbaP0ZQdnik0UaNAQexjoYNweoK3rImZqfpl+fF2A9JJUykpjWx7nYh1ReawTzk6P8CFTryIjoUc/AnNRnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkKOfAU3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-439858c5911so6011595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740675760; x=1741280560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uyTw/awpQ2b8W4zrJVV8H3S2MlbDfUjPlgXrev/cyno=;
        b=UkKOfAU3uyQ3KJEpEbNuq3JVFkdb1LL4VA2wcSn/RRcDdYeg9n5SFZdk/pSZ2T8ugm
         bnsQanrfOlyp4eOzoQ07sYqIUEdsL5HcyXSH3qseZoKNzegrROt4D0zpOa3ECEOJ5LYF
         8FZBynFl1Ip5f91Yr21G7ZQONGzVvm0TzzXD5rPh3U7WXrHQ/m+8Nlx59sUGrCp1sTPQ
         aaaIR0LzUcW6mIcpKxLpzd2P76rw+5BTUFc6YfkgDTCA1p3WzyYRHAwrQWoELJrHQOPI
         15wXOwbS28dxndETNCdRo5j/xrSF7oZ1Ry431WK90Y8b7ySoOL6i1nGroLgbuK/wUP/e
         V9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740675760; x=1741280560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uyTw/awpQ2b8W4zrJVV8H3S2MlbDfUjPlgXrev/cyno=;
        b=bg2GmMGW6WkKNJLAZYtc5EB8SUb4sqdtA8lLGaVXdkbkUDYs+E7h72swBD1dKDOdQo
         0DUqKmLIvZmYJpNHhn9AYuht6wZDPzgNVsNuYdM94rGHOvOoIxI9UqdVdCB6m/9uIZSP
         srAwVrpa5KAszqlRWd2/3DqwvixaPmZyfPlMBbWbIif+L6k985YS95wAHxd7GQD0LdsE
         WBc3fwO9JKn+SyK7hTHqJOLxgXTfYNWhUXCBKbzpAVHhKTpiqdAYFfIc710aHIY/6WuF
         anFUD8W6NKadoG9+vEeFU9HFavqvpnZmIGGmpWSDw2mg7pwX6vwNCVXcPm3Po8GV6BBd
         a3Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVwhdM087YHEuWpWC42bHoZAFs5J/KNn/n1aHI6IN3uiAenavMribph8K/auIReUkCtsHA6Y6n5f7XNnxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YznjA/0LODQpRNmQZQ2XOpycSxT2TNd+8hm+jmGw4D/BHoEtQFw
	SYXBXV+5E4Il3VqZDN1ShaximXA6NTGLolc3O+cAqWhAIpT7PfzWi9OOXTbaIgK4w35pVm6uacL
	0lFWh/N1MjCzfFQ==
X-Google-Smtp-Source: AGHT+IETYd45wqLlFSGYfA2r23+tMfJyS7mFkY2/XSj51L1vJ2+M6lbfKeR3YEjy5LaJ4YSnfFn0fdn05icFoqY=
X-Received: from wmbez4.prod.google.com ([2002:a05:600c:83c4:b0:439:8ada:836c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f0d:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43ab90169d5mr68313845e9.19.1740675760403;
 Thu, 27 Feb 2025 09:02:40 -0800 (PST)
Date: Thu, 27 Feb 2025 17:01:59 +0000
In-Reply-To: <20250227-export-macro-v1-0-948775fc37aa@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227-export-macro-v1-0-948775fc37aa@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=DX4aj6g1+3gi1MzmclI/m0bUFCVi048l6tZnNSfBMrY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnwJqpf2Qi8QLFv2OSIJifmJDT7I63pnqPsJGib
 8/RB4+fSH+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8CaqQAKCRAEWL7uWMY5
 Rud9D/9PV7zhQlnXuqvTuDYGJ1Hq8bZynWlH6JAsl8T6q78NM8tFf5f6hi8fs8YgHDZK0PJiCHC
 WFUgxUIf4kpzyTV/hwu4KMggH5sRMnfmNFzQJEFjtB0AZZ99shzceswR+Yl3R6TDvrpPwZhOvBT
 s70bBkW9mkmsR9TLjEzaNDIWkjRUNcQ30JvAlTV1Vqn1Cx4b2q44eSW0Xi5aiwIgSEoroVHbOkL
 rYLzkF7iB+HEQ5C2POOf0D9IJVunNMhgVfr6d5BavKOsvsBU4JacOybGeg7N8VxFkHuMjwZrnN8
 Pu6NZWIaCE895cyrJIV+31NFb0HUZveAlqUsDaPFcqRXmqr9ZcAv1PllPbVFFDNtmtcJIiEg2Uy
 rKoO3uzNVjtvZev2qj3Sh8/C7xiR7uG53F1Vbgd+o36WLOG9yZ9ZwVu9LBTVMvbMk2ZPkyi+qgA
 LrrdvpoXtFSGM0Um9Dt+segnzH+EaQW0JLjKaEWUKHVOQFmj0hmKrBEj5QS4XMw2I7tVr4OtbTz
 fbrNsz2bIYOgwq6R8lakVGZt8txCmiAUYVuAkaJIjNnVLMNOyONgwYN8wNIA+IZ4jN6pOQhIjGv
 L/DlXoYP5ctDsboWl+CIK9STl/jyLn06rIexpwkPOed5fEIGAPcZQKEMKh7b0GxYFZLYR5gWkaK n/NrKkkl0ayaLTg==
X-Mailer: b4 0.14.1
Message-ID: <20250227-export-macro-v1-1-948775fc37aa@google.com>
Subject: [PATCH 1/4] rust: fix signature of rust_fmt_argument
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
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Without this change, the rest of this series will emit the following
error message:

error[E0308]: `if` and `else` have incompatible types
  --> <linux>/rust/kernel/print.rs:22:22
   |
21 | #[export]
   | --------- expected because of this
22 | unsafe extern "C" fn rust_fmt_argument(
   |                      ^^^^^^^^^^^^^^^^^ expected `u8`, found `i8`
   |
   = note: expected fn item `unsafe extern "C" fn(*mut u8, *mut u8, *mut c_void) -> *mut u8 {bindings::rust_fmt_argument}`
              found fn item `unsafe extern "C" fn(*mut i8, *mut i8, *const c_void) -> *mut i8 {print::rust_fmt_argument}`

The error may be different depending on the architecture.

Fixes: 787983da7718 ("vsprintf: add new `%pA` format specifier")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 lib/vsprintf.c       | 2 +-
 rust/kernel/print.rs | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 56fe96319292..a8ac4c4fffcf 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2285,7 +2285,7 @@ int __init no_hash_pointers_enable(char *str)
 early_param("no_hash_pointers", no_hash_pointers_enable);
 
 /* Used for Rust formatting ('%pA'). */
-char *rust_fmt_argument(char *buf, char *end, void *ptr);
+char *rust_fmt_argument(char *buf, char *end, const void *ptr);
 
 /*
  * Show a '%p' thing.  A kernel extension is that the '%p' is followed
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index b19ee490be58..8551631dedf1 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -6,13 +6,13 @@
 //!
 //! Reference: <https://docs.kernel.org/core-api/printk-basics.html>
 
-use core::{
+use core::fmt;
+
+use crate::{
     ffi::{c_char, c_void},
-    fmt,
+    str::RawFormatter,
 };
 
-use crate::str::RawFormatter;
-
 // Called from `vsprintf` with format specifier `%pA`.
 #[expect(clippy::missing_safety_doc)]
 #[no_mangle]

-- 
2.48.1.658.g4767266eb4-goog


