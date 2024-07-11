Return-Path: <linux-kernel+bounces-249505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2EE92EC86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813E71F23F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CB416D33F;
	Thu, 11 Jul 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUYzuRwa"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233FA16C87F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714871; cv=none; b=AQtXGYFMP7YQifLKwfTI1n4yFDvfTFr+lasqE3kuN7Du7A3Xu6BTQczZq9Cd3RzLPfFOrl2ye4IxxGuDQgc53FhTaQ7iOnSICmx+A+yqvtKFU5XLzOf7n3AQMYk4ACpVIaSbsWm75ZM6B2FnrBzPApdU/bmXhUJtNzbAc/3RJ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714871; c=relaxed/simple;
	bh=l4drfiF/RmBw22akhuvPKaORF8RgC3jLRDuFcvLUeL8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jgxQEwhX6DtyGqzob1j2B8GSsOEJjZWsIBrneBt8ID1WscwCyTiW1E/x5XtOEkzvLD3n2zrwfofQcJY0xPOn3iUGDX0s47JxMgJrgbxxTAU17VgB1YBu6EFH6Op4BRNrt0nL45V0ZjgkUqzyDdFboc/WqSPypbsCqAIq9WPU7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUYzuRwa; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6511c587946so17965717b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720714869; x=1721319669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tdAfz6F1LxB1SVILBmz3im7GucsBrJFjA6wosQSGALA=;
        b=cUYzuRwa0xSek8kqHb+eRLvj99vKB9FJyTsFq9DhB6TMquvOvBwDJfxlzMscZuvG//
         +y/z2Od9AMvsneriWYKQmpF4bLbu1FoEvZK8wIQLUWzCMfvlv+w4h1S6QtKKx44FbLWJ
         t0VItBxJXmXCusWkNekzkIK2i2oOIhml+NpFvKMX3/sQwRdwflVSnabjTwU+ba3yOnc1
         jWp/DmXPw7kLiLfJo/VtQngz57fV2zFrAaLQLRStAeoulUoPF6g5ifoa1OsICrq3nxCK
         gxTjkJk27ZqsgBQffkhPuN1u6Z6HV+IQCVRsSDQwSqC+snA8MKa3SACfCw8jazGG32tE
         x8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714869; x=1721319669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tdAfz6F1LxB1SVILBmz3im7GucsBrJFjA6wosQSGALA=;
        b=cUke+eLcO4unlFmCV4K85nP+4PI1dEux/cRQjgAggIOckPU599AmmyQOFeuLuMGYBd
         jljCp/zVZb8Bsp+I/XYOdFWZoe+Ad56QcaXVqjWkawVnX0hL9uDhuWR2fwcYjj+ceio8
         hYFGPJUvAyvT+jSMh1TDhl+Fc58NPrEOZiRWqvAjx3AymkX8EiimMRkmWZsWKBXn4Y66
         e15pCllkeKolvq44JKuBiKBtgftdE2UEU9++lkxOEVOlcgydrCcT2qGE0UQR3FwA/bhD
         dj4nJb+yZBDvnvwU2R4XLaC+CKwUfrSVFZY9gDfeFQedFM8PfK/sfZRMVgVvXKL0UZhW
         8Y1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPm2J5CZUvYOorxPV3YUbXSOojBfY49/IYkf3EBvskT28CPTQM2A/D6W12OWCITDLEn50zCrNIU9qsPMZGpC3Z4gUHYxC6yWPdLn17
X-Gm-Message-State: AOJu0YwhM/yuv0b7MRl3m5673sa2fU4tiCFXNq5AYJalrRcYBrFzSvru
	WvHrFXIxfLKc+47qPn4jOCE/SFx0nM4dJQ3h8ChZAdCqEa08u0y8Y/zQKYlzlzV6gQV4vYVDC7e
	DTF2dCvkxUXHxy/Cyi50Vnyi+3Q==
X-Google-Smtp-Source: AGHT+IFSs76JHmM2LmXNg32ck/ZKUQAWtLq3qigWNXo0ZTjrIc0iQb/8PWxfHMJzU/PwDwBuVbLVyBlgavSzN3LzrU8=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:200e:b0:e03:a2f7:71d with
 SMTP id 3f1490d57ef6-e041af3f7edmr322987276.0.1720714869205; Thu, 11 Jul 2024
 09:21:09 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:20:57 +0000
In-Reply-To: <20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240711-b4-rbtree-v6-1-14bef1a8cdba@google.com>
Subject: [PATCH v6 1/6] rust: kernel: add `drop_contents` to `BoxExt`
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
2.45.2.803.g4e1b14247a-goog


