Return-Path: <linux-kernel+bounces-199407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C75EA8D86E2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7762A2819C4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7B013666D;
	Mon,  3 Jun 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WS+qJ4Cw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90785133993
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430729; cv=none; b=pxBRdnDkwm+A91TlwZHyJgmnnKkv9B6KM82ss5JCNq9QN57xUbNlcGxetoBIbEq2GQL61yJrY9rn+47AkDqC6uJqbiv9NbwOETLYKrZa2kM+ga9e4o5bmz5lRL2e+wgi6ptZSgnnQ5mFH5sjW46kADhGeuyrCDTOA2VA4zlaC38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430729; c=relaxed/simple;
	bh=SsPguepMYl1k5J1fgsDrPhfob8d08e5oz0Kj/0ra8gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qz8HkwBZdTEfQ+extvRHwMu+SIYq5zK8dbQlVLMbzj4HIn76qyOfbd0smZqqgTrDnAdc88kkiekf/9dMiFGbNYcUAtFT07ZAiunjQyVjhYu8tK21CYjasrz87CNr19ZGRYqOdUvjG2npseMcYiVmbzWrJ3ZESafJGwzGNq2B+RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WS+qJ4Cw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df7bdb0455bso6963811276.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717430726; x=1718035526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXknpeAcJEK6e2DRJM/PLI3NtocdR4jywa4B5EX8TU0=;
        b=WS+qJ4CwWXQzRmxxXEFRjsCabQBtMi9sjzX8RBFcVjZUm9j+WGL2UUCgOiY/RbV48w
         mc5AT683LCFQIr4rDOCLP160VHaxtWqUQIL9HdvZU5fEhMlQGBNWmpD/rg8s7UTx2kJK
         bGvUO7P31dhIzeDI5oq2brpuZ1n0RIIk+2PGc1N4ATCcov1zteh26WHhVq3PX7YV/fVw
         jrI/iIkMiXvS1kfyGHZwB0s4/T5J/H60+EYokJZoYenVeKW4NA0MXMEuX2stf2SOC3+o
         SmsNZfreknyGLlTsjnYTmb58NPwYmzXtutgzaBoCDHEcZjjPFhh9NogeRnhWl8mYHAh+
         xHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430726; x=1718035526;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXknpeAcJEK6e2DRJM/PLI3NtocdR4jywa4B5EX8TU0=;
        b=AQQnKPkgstDIiHoC/S+nyJ7TqScLwO3X2sG5GC+5xZDcG78pLPEOB0PcM0N4Z/Gzq8
         gabAA2qVdbgbiKxYtaI3ipRuvnGAROHFX0DGpOlLieOWV5qD+eXhEE0Dvy9A8eBwoH0A
         pbkpxkAnHsBzmj7u6wccgoh0CQ8IYmUxwcvTXv6D40ytyTp38ervMbcJ5Qccgd2C+yEr
         zQA1D4/yaTQhVRP6rOtBviZrMnl7Gkey6FsuhMTgd8I+hCvpJ+yp9MxjZo73qqs8JyZ6
         9ER43kDMULLfMfV5fYrl3jPpzY2ZVpLbsmTta0eH596K3B3A4YCxSpp7tVJ67+NKi4fI
         UyUA==
X-Forwarded-Encrypted: i=1; AJvYcCXm0E/LIcktUH4SLH5wJQ8mUcFavsEETUMzncMGF7bUX17OkmbKjHMQZoe/nHTuCPMvmjMTHKkJhlaxCPqSLHY7SfzEk7oxocUKGmJI
X-Gm-Message-State: AOJu0Yzg4HmNFL0KxOf65JADmvQwKENPRewdtu1bjluhCqzBHC6FjoP3
	Jtg+TzHHyhxICyZAx0mLcIwOgT9IE5BtOIPsvnhPwsr5h6uwZSCYmH31HCqLgmS1xaH/H4B8IG5
	LrgHpvz1C8ttvJeX6Pd4JBsS0vQ==
X-Google-Smtp-Source: AGHT+IF4YXLHy6VFUWTWeyZSm7amZ/UK0/Qz62/zdwwFfaiQT5/oqh5lb+Ym9APQjs7f9n368VAtKpMTStJM1AYiJgc=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:1247:b0:dee:6f9d:b753 with
 SMTP id 3f1490d57ef6-dfa73bfd47fmr467536276.6.1717430726426; Mon, 03 Jun 2024
 09:05:26 -0700 (PDT)
Date: Mon, 03 Jun 2024 16:05:16 +0000
In-Reply-To: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240603-b4-rbtree-v4-1-308e43d6abfc@google.com>
Subject: [PATCH v4 1/6] rust: kernel: add `drop_contents` to `BoxExt`
From: Matt Gilbride <mattgilbride@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, 
	Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"

From: Benno Lossin <benno.lossin@proton.me>

Sometimes (see [1]) it is necessary to drop the value inside of a
`Box<T>`, but retain the allocation. For example to reuse the allocation
in the future.
Introduce a new function `drop_contents` that turns a `Box<T>` into
`Box<MaybeUninit<T>>` by dropping the value.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e134390ce@google.com/ [1]
---
 rust/kernel/alloc/box_ext.rs | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index 829cb1c1cf9e..557895db4f48 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -4,7 +4,7 @@
 
 use super::{AllocError, Flags};
 use alloc::boxed::Box;
-use core::mem::MaybeUninit;
+use core::{mem::MaybeUninit, ptr};
 
 /// Extensions to [`Box`].
 pub trait BoxExt<T>: Sized {
@@ -17,6 +17,20 @@ pub trait BoxExt<T>: Sized {
     ///
     /// The allocation may fail, in which case an error is returned.
     fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
+
+    /// Drops the contents, but keeps the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::flags;
+    ///
+    /// let value = Box::new([0; 32], flags::GFP_KERNEL);
+    /// let value = value.unwrap().drop_contents();
+    /// // Now we can re-use `value`:
+    /// Box::write(value, [1; 32]);
+    /// ```
+    fn drop_contents(self) -> Box<MaybeUninit<T>>;
 }
 
 impl<T> BoxExt<T> for Box<T> {
@@ -53,4 +67,12 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
         // zero-sized types, we use `NonNull::dangling`.
         Ok(unsafe { Box::from_raw(ptr) })
     }
+
+    fn drop_contents(self) -> Box<MaybeUninit<T>> {
+        let ptr = Box::into_raw(self);
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { ptr::drop_in_place(ptr) };
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { Box::from_raw(ptr.cast()) }
+    }
 }

-- 
2.45.1.288.g0e0cd299f1-goog


