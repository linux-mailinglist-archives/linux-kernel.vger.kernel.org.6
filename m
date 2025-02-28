Return-Path: <linux-kernel+bounces-538520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E4A4999B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 852617AB0FB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D326E643;
	Fri, 28 Feb 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bzm1HW/W"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353D26E16C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746417; cv=none; b=WrBgkNwP/1rHp3kXFtqpoJK0G+Zg7hdpl034G+cKyiR+JwZGt+3DRywuTPePk+bTBwZDvMhGqZrB4C4c+/c8rCtmuyb1Ur6jK3ByXIgacXnKftpYn2Jl45UDJ0j5k15yY3RrJzqW/2uI1fyhA79EkMZTxUNaGMX1X2fvtNKKv5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746417; c=relaxed/simple;
	bh=r7jgVsiiJzFKABmvsoHtJDihUf1aN5aOfGCQnlUXLR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h2DMh5V/VLtLh9Ld7WVA+09pwgrbwNWpaq2On+QrZOYq5B4w7AjEpjEmiNtW097piX6FcaODpv4wP7RuVRmNFks/9k+xii/O0urfDgOU0Hi1h9qfqOOiH+5ZoySw6DcmwF6nAmWlo/a9tZlieKyEcMvcvQMSbEOWydul1ICOOg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bzm1HW/W; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4399a5afcb3so20122185e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740746414; x=1741351214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5gHFsUk/zR3QwRdy/hSALMqHlURbjWQTJYZwElRBw=;
        b=Bzm1HW/WaiU8mt0VN/aGZLpWWHwT6ZzHUwCAZzA9IhOjKIzWMUhjGl7aLfBJ0U9OtT
         0fFlTIFaV/AR1aruvNuzKRwgQ1yMI/ah/WpbRMya5Q1ZooHG+SXz0FTteIQ3/JJOlHMM
         wTDDYBRM1y5wqTnOMUZXuzVXAglFCDDIhksj+3VwBwSHwy/wnjIqyV9FLfxjkwMm4Dpz
         Cld4/hNOi2hhVqkCy9Dq4sAH/N8+S6nRtcVzHMOcvOOzCeyjd8skKzRyHpExGuvI3Vto
         pZELgW8lR8qPtNyyutNoC3YQaHQmR5keP1HexIbiGUKZWZ4RgM83Gsajt0NOPk3NnOPU
         5bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746414; x=1741351214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+5gHFsUk/zR3QwRdy/hSALMqHlURbjWQTJYZwElRBw=;
        b=dcHBGYzq1Qzw3nRGi+pBW2iVdZWbw/DJ6lUXCMzyRBSHm5nIPVPesqa35uYzG3xvRu
         PNSdf012jRmLJKE8P8Nuv1LR9xxJHeYHKq9SOyl234HX13VE+sWAEQAoLNqPDNUnOCNh
         SKjdXjukf4dGO7br+HCwVdX/zczS3FPSn+u6h0pmrQBCpjRtmxoKRj/B5xAkUTcuzIvH
         AEyYF7l7zvZvEcdcn+51HUhtY9AvlAcvufPh6xtgCKeGJaOSJ6PeVAPMnxcC8CbiNFJo
         K47jZGGAaw/Y7+SSmus12CQ0SFdjF2/bi1jjojRdhlPflAw8GWNotLgVk/jbxWqAc26K
         +k5A==
X-Forwarded-Encrypted: i=1; AJvYcCV2Wmulri4fuODb7NOsJMTggL9oy5gFwb3/SsVLFqTuMdm8ryYzdr+qOZfKjMhboxonZFjfXNYKjJLu/Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YydPuAE9s8dcDgHkv83UzROJVnaJwLIP8ggBHA0gM1SfJ77Os0H
	mtYXDyS1ahqKdcXqEjmWh8y2NH0k6rWSUP1FX4qjnsLVfmr4XG3JQ474NQZGY1V7e30OcTPMfx1
	bX/mLPb6iF3OK5A==
X-Google-Smtp-Source: AGHT+IHbIphIQcEXilOr7Ntw6WaNAr5phX1XmvUcyGqxwt+X3Cd6rOdQsMiRHilLofVXJl6ZHWfjzIcpQ0HSDVU=
X-Received: from wmcn18-n1.prod.google.com ([2002:a05:600c:c0d2:10b0:436:fdb2:fa5])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3507:b0:439:3d5c:8c19 with SMTP id 5b1f17b1804b1-43ba674c911mr25914985e9.24.1740746414470;
 Fri, 28 Feb 2025 04:40:14 -0800 (PST)
Date: Fri, 28 Feb 2025 12:39:33 +0000
In-Reply-To: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=r7jgVsiiJzFKABmvsoHtJDihUf1aN5aOfGCQnlUXLR8=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnwa6iZBH4LXAf1My/2Bb4bMU2tOy+URmQaqy+I
 0YgolPCIOyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8GuogAKCRAEWL7uWMY5
 RntsEAC4uGdMp+3gOxWauz1JDyiZzR/Atujxvqo0jIjAoxK2HzkZY9QWUrC7RzFUKejI9Kba7dK
 6I3yW8hwYThfVdITfDRhoegt/cJ4p/rBCktrQ/bDhIz0Gtg8Je8371Rg+tfgNJW15cdXD4eWKBf
 UUPBZLV/CtFQyCyhALtXPzhVfZrWxTqko8eE5bZP7rDrNZcPCUqqdGmYDLf2uyuSUkeW/L139bb
 DZqLXQ8oIjoGwuT6lvqTCQtZiBc9csEB0JKTywoJAO96QK8BmySRWsEBoBsBeoL5wUWrfk3Vd9b
 SSMMVT8XIJqKL/DxtvnppRQWiXZbdRaTaNVmh4hFbeOKPp9W2mbYaLlkXBqX/rRrYoOBE1jYoD7
 n6MAIRSn4PoKhXOjfHr2ZqZFlEqrVpbZ33bzuIFnXnA0kzjTyO5QCwUIXghkuHdS6FjHa+yaAtV
 M2OIf2DAn0roOnGvIAu8HKCa/RY2fc7oItuhyF727kP4bWhnRUpm+0vi4O5Sdveq0W77yQgQS2B
 hqWpZba4ARnFFAT0uSS+CpMVdFPYwqhpREFLcw7qXmfVWTUYcjEMYxnrHoHf7qqtOhKE4Vc3QSS
 aCIyd8EwbEPwOybRVuVFiJMrTqtMEI+50Fm7LZ5wFZLOOevDJSvKQbuJlzgVE+zHoTuJxhz0ijN QgT9cliZsSNsMag==
X-Mailer: b4 0.14.1
Message-ID: <20250228-export-macro-v2-4-569cc7e8926c@google.com>
Subject: [PATCH v2 4/5] print: use new #[export] macro for rust_fmt_argument
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

This moves the rust_fmt_argument function over to use the new #[export]
macro, which will verify at compile-time that the function signature
matches what is in the header file.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
I'm not sure which header file to put this in. Any advice?
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


