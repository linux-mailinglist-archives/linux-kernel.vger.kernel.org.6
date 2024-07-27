Return-Path: <linux-kernel+bounces-264270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C7F93E0ED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 22:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7536F1F21A94
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 20:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BD153E22;
	Sat, 27 Jul 2024 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AN5pXvlL"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255F2C69B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722112256; cv=none; b=mwddjtijK++yFatE1qAm6BlqfedMHoA9K/te7ZNMiB09qu2odjfK6v2Vor0jpgJSzOqSQZ+bC3YrpoQduLlekmGOnOBVId+7Qxm92oiispUXBGCcVv0TNaNLRDvICbsuRUwz/k268La1C83eVTCgTQS86Jt1P60/ox+Lb1f7S2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722112256; c=relaxed/simple;
	bh=JMYAJfnvh5fBjtCAE9lnpRby5Iz4gLoiR7otAicAG7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XWLtwTd1mil6wA1P6tUruKzmlaUR4EbvhLQGaMfVhsXt0sXQmEDheMLZRtwgRHv0rTEXNUpT8+1h2fIa8jv/S+L0OXnVgpb7TUkW3xctQnxtYR22LfCrbsiw6VD1f7nHsqkrdRmLexEusLIe6bhMNaupDsT1s82+0NOWT9V981c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AN5pXvlL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05e9e4dfbeso1679673276.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 13:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722112254; x=1722717054; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsba2l+mTog8DKmlCLg5ao+hwsKRjwNNTQ3oaykOYeU=;
        b=AN5pXvlLRuRwkGJ8ZnkhIEEzrhFazra0EcOXiCxHpZrqbuFKBAyT4FgaX7YFSDZLBj
         YzVFVG+niIAnl6zj5ZVtYiQ/3guqBWqlm3OJmLwAPtShuhnG/1dO+AfxkgDl49y0M7bF
         avV1uz55gUUgeLB1sUHqAazYYjI414lu9azj5RXjVn88arvB2/noBQrio43amdWFq1xS
         Hrz1DojZ0b+8n8Uwmn8dk8xi8HqoU+Fh7mrsbovacws5oHr53egCM6F/Sw31VHP+p+wa
         j65EznzWqy9iNRiGzuildY4qLxZXz8QDMtslalXOtvOVxammW30wSgVoZmSUljHlVTuK
         DooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722112254; x=1722717054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsba2l+mTog8DKmlCLg5ao+hwsKRjwNNTQ3oaykOYeU=;
        b=dojSUfNaczpAmkeQYrdbVkc6cFRdt8Zc2kbwYivEmVi7KNL9fFUYvJYPwTOsLzK+iI
         Mlu2Jh1grA60ZFOAl1S864vW6x4SUUR3HvMEb1svDQ+VW4tz4cS4OU0Rsi8d54XdHwML
         VwX8NYZNopeK99JCAiAf7YVat1jUERWPLEBR9nI8Suw2VUudErYnhlN5MU6C+TVp567X
         w+oM2eA/zR2IhvGkUiydTITXJWWpEg3/rchWOOjWr8H6q6ZpwZ89AWG1yt0vhg8vLnxL
         RQtZ7aoHACIsi2syyqhYqIgjJdiuqcW3cThpTlJzbmP7KxN/dRME6U6iF5vH0F1+5zC0
         Jevg==
X-Forwarded-Encrypted: i=1; AJvYcCWWTA162xtbO1ir9UUu8zlfKAuonNbwk+mYwgmhVy4ETUrdGQ/jeb8Gdj0bX1JWs8Og1cPxlsarTpM4+ViA4SD5o78MRJzX1vv4KJzO
X-Gm-Message-State: AOJu0YyL4N3SUfi7XaiGo4eNOZOzS49SJL4nucAwohpcoRuLT3yTyQzY
	zDjYaDzcFBvwS/KEX/nY5BMn2vNFVIgLAeM5BgQQp9VggAstd6B0CZBFCkx9zO7VD4Yx186NnSw
	ZSOc5SjWr6IbBbGoNWfY5ibMZDw==
X-Google-Smtp-Source: AGHT+IHpu7bjRnigEBEh0qhoPcCoGcFLnuGxtsTcc9qvNxSWHxq1NqzBuyWbVE6j5NNmPxREKIAuQuV4TpRKm7sYoyI=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:868f:0:b0:e08:6c33:7334 with SMTP
 id 3f1490d57ef6-e0b5454caa4mr86236276.8.1722112253919; Sat, 27 Jul 2024
 13:30:53 -0700 (PDT)
Date: Sat, 27 Jul 2024 20:30:46 +0000
In-Reply-To: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240727-b4-rbtree-v8-1-951600ada434@google.com>
Subject: [PATCH v8 1/6] rust: kernel: add `drop_contents` to `BoxExt`
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
2.46.0.rc1.232.g9752f9e123-goog


