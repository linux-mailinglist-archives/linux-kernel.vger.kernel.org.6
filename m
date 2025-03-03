Return-Path: <linux-kernel+bounces-541178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2965FA4B9B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1398918901AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD541F03C8;
	Mon,  3 Mar 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zd3xqMn7"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40241EE021
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991552; cv=none; b=J6kwnaSqZ6y8FLOKOOSJeAyYdKrRG9jPSqdXzHUsfXOsZEB2tf02AEb87gzEyXuKH3pPk9irpD+lGDqE9E735MXwkBIaekQviyH710bvFJcjo2teFE6VJmC9dXyUsWAdbwgHkHQN/54DNBBNAhnwXttdkMozAftb6pMoWLzCJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991552; c=relaxed/simple;
	bh=rXOlJP2KwbZg6HLcbrBJs+P0GV/Go4oAq5PQVguOe0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N3+D8xqymy2U6HNs9rwpHFxEY3l5g9GDGaAQv8Sp4vFFRUZA9oFJBdVvMh7idvAjlMhVDmL1e18TSYRRD1B/3nF2VlcIBBqLIJliVOSLv7tjrFcq62F75+07905qoE0CL6bRo6m47g3XLct4fMsTBp7SVYM2vr7VouWBjgSGwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zd3xqMn7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ab456333aso35869445e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740991549; x=1741596349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uszf9jNzimaGC7A+MjcMbFfOoksGjtwuorOL4my3lD8=;
        b=Zd3xqMn7RXIz8sj1odvqq8+CEJsOSoZJLNB2Mk0FOc/AxFdaA9dcBZsR0EkADQFMkl
         zBGexVf5TILZQrfxMeJ+kqaSG65a29QjrbdUMx79U3PJvJYnSswJDDjZr5lNhhsHFe8b
         5RaX68lichSToLh+xhpfQnx9h2vBC0QTEP/X04Yk8u1xqVTkqtZRGsb80q5LjSyDiycI
         /5Lop8+qSjn0lQaJ/ByD7hfVTBv3Usb8KsW01VuXabMGKnQw98kUC2VuQhSWl+6gbmN8
         dvhiUbflt49sJIkGrtYgLXXp4nP9PODnfUPzTN8LsE6cEIhvLV+ceG4u9Td6KLj528Qq
         oNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991549; x=1741596349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uszf9jNzimaGC7A+MjcMbFfOoksGjtwuorOL4my3lD8=;
        b=jLbTTQ2srSpVooSza2Dj1n5UFBruK3krjpU4sM+vGUE4iere175JfsLioQDDKSerlh
         WKGS/ntdg6tkXfyrXjWihMNKoY3JqD+agAIL5UjCTu4cOi/jCwlEIBM7FgRV9Z5AqHfa
         i0k0equ5LXxEDUi8kOe9M19nsaOW4u+/LBf7H9ccDf94FCpSKZITgJ/YNcUV6yG3m3z2
         35tXhpW0uRBXbfoqBbQT1dqf0ttXrqffIKvDiBdLF6VPj/RLss7i3a/lcjax3Rm/+qrx
         7iUJjvoX/vIW29nSEJjWUtMwg4lW/q55j3d16q0xCTvpuB7FT9BX7j5dsPm9mSPbZV/2
         LdWA==
X-Forwarded-Encrypted: i=1; AJvYcCWcyDUdJxIJXRFLvyqe3C6SPBxTGrEg1WHOq1Fopq63SqOMj/GRkDbwIv9zW+1c3EDGg/VLu+KvUgdOBaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaK//drlLFzFqJMjYQ8rQYKnrV3oPTHcDjiz9B0Ew+sUsWn523
	Mk9m8bSJjuiaXsRW+VAlAVG+KmIiX+SUUarxNct/F1gqIrf6MkwbWPoRjpDfA04yYyLJyROT2OL
	hJ9jS6JgiA6DKPg==
X-Google-Smtp-Source: AGHT+IECCbQDp007YY5H9TzV4VTf2BNZ8iJKkXWl3w/rGfL/ku4+FSGRABIL2DQ9M+TCDMAM8FaLElccEauucog=
X-Received: from wmpz20.prod.google.com ([2002:a05:600c:a14:b0:439:80fc:8bce])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ca8:b0:439:9424:1b70 with SMTP id 5b1f17b1804b1-43ba675caafmr134644415e9.30.1740991549163;
 Mon, 03 Mar 2025 00:45:49 -0800 (PST)
Date: Mon, 03 Mar 2025 08:45:12 +0000
In-Reply-To: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=rXOlJP2KwbZg6HLcbrBJs+P0GV/Go4oAq5PQVguOe0Q=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxWw0XCXyKCpx73jSQ2riTrt89M1w4DSLnlZ1+
 Cb235TozJGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8VsNAAKCRAEWL7uWMY5
 RgRRD/9PrC+8ReqGY3MVcspxlBxm4PzYImTmwadXxvv6K8NDFtqSgszoxEfNsDJXIFFzYRHYa+N
 mJdl98HU7r6JRSNL6VV/+oRKhnoHhYbIAna1gFnE/RYTvvWwyUeyO/3CFv7nowjzYM2AnjxOWtM
 OOmg43zFRY6b/s1XnuR8F/qR30rygGjeSdK7pbE+PygOwoeoXMLh7Yr/UQ0him2uoJXBP0F/4Jt
 NhUEJHPhJV2Uts4nr2e42HpL35fnn8SH+eaBo+nrTG3wXgOEK3ItExaFsD8x6eYCRN9tONisJjH
 xBz+9+5gzepyskX2bOZ0ZhqRPhCSdiZBHxPdJAqs30uzVl7n2MQW5GzBrqu06sCxQ3iY4km60MC
 QkK3CQsguGeSvbMPuYpoIKd+Ld7jxqM27Pe8XJHI2H+nVz+/C5Ps7rZriN2QV4HCqc93vLTtGpB
 bfT33fQo4J5G/ediSmFwtU9NbUEyDlI3/LNY8azVt58TysT3PPWfLU/jtyifkjgDeFs1Tzwlv58
 AoTz7LeIRR8/ZK/Y4q/Nq9NF8+vnZf9gm4eXxu81s7bnfqXUiKc/+UoLzwpoBElajRnbah8+nQ/
 6A9eT6t+gCWE1hGbbP3vLG1gJgVICGT/4nZEhu8Ujark/AVtP1xoIh0B/sjLHEAQDPC8Rc5IGkh NtML/q9eIA2gOFg==
X-Mailer: b4 0.14.1
Message-ID: <20250303-export-macro-v3-1-41fbad85a27f@google.com>
Subject: [PATCH v3 1/5] rust: fix signature of rust_fmt_argument
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

To fix this, change the void pointer argument to use a const pointer,
and change the imports to use crate::ffi instead of core::ffi for
integer types.

Fixes: 787983da7718 ("vsprintf: add new `%pA` format specifier")
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 lib/vsprintf.c       | 2 +-
 rust/kernel/print.rs | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

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
index b19ee490be58..61ee36c5e5f5 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -6,12 +6,11 @@
 //!
 //! Reference: <https://docs.kernel.org/core-api/printk-basics.html>
 
-use core::{
+use crate::{
     ffi::{c_char, c_void},
-    fmt,
+    str::RawFormatter,
 };
-
-use crate::str::RawFormatter;
+use core::fmt;
 
 // Called from `vsprintf` with format specifier `%pA`.
 #[expect(clippy::missing_safety_doc)]

-- 
2.48.1.711.g2feabab25a-goog


