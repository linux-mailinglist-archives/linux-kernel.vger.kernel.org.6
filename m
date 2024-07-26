Return-Path: <linux-kernel+bounces-263690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEAF93D95D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF97285BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA141465B8;
	Fri, 26 Jul 2024 19:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLYaDYlN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64F61FCF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023874; cv=none; b=b6HCNnC0AmhxO2xcZKoidF1hfPIqaQkVEsKXFrukASHHlGrjn+nTYyWDLB4eKAZdQGKxEYYCr6sALrpyQM22qREjRR9Xhqo8IgW7rjZqIf8rSd+fWJ1b5nxMhOi8zaHWYFi0jsAJJELQVoJYO0Wcz0UzsOUObE5UKiomLUWx1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023874; c=relaxed/simple;
	bh=JMYAJfnvh5fBjtCAE9lnpRby5Iz4gLoiR7otAicAG7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eFF9n204qDDK1xyA9WTd8wbhJKdrDTaZh+U7oHfPucGdc6cdZg9TRyEHFKn+SH3ITJSomWLcI27mw7o5DfQpjtt6PwT3un8nVtrVTZ3gdm7zvbRMYb/BwVKARbDPy573tkyF8ACCcrkkyabaauhZ5GhGfLtIT0WwlKw+aik0FHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLYaDYlN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b2ca2952eso113660276.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722023871; x=1722628671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsba2l+mTog8DKmlCLg5ao+hwsKRjwNNTQ3oaykOYeU=;
        b=HLYaDYlNRmNdRCZB3f3lZBegM0apDoC2d7Xx7ssqet6uRoqmb2uJYVYwxWfWF8x3jM
         9zIXVPJol5PeuJJJKTnwvaHd4AY+U3MgHuXEusUpY33dtjJRuahKWUK5Pk5zug2PW0tL
         5kCY3wUFK+R2IO9w+pbGChHeTkpLK/JrnFsmMOZY0ZuxSnmAEmp2cqcQ0CW26zblIQeL
         nov5BRYXK1d9KrbuSGehM8vrsXbQXqyqwwclCAH5UyyyFFODvjTckFDKOBhi646E2yvX
         Cw2vtEKra931Pfx2s6Pu2WZ6O9GtzXVuBCTJ8YUHjarqgnPRg7cLUnOFssFd5biRFhdL
         HN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023871; x=1722628671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsba2l+mTog8DKmlCLg5ao+hwsKRjwNNTQ3oaykOYeU=;
        b=dd3M8/KXa0gQVCMfd6g86IoHR69uTMXwwB6zio7KpYE21t1QvTOilWeuESPZuXeKic
         FYmzGIauRPfD6ywTfCd5oov0J5b+hmcaXS04m7RoqQf3Dul76TOGMxVDYvXCl65VGC0a
         P6Nkzry7NaTnaGzTWP/HXwWLvjfuSjcBjCKc2acuW/sX7yA4GR0pT4jGzfuHSU7Bb2/d
         6wJX1dxaloPtphUdOPOTVj2cRzH2TZ5Nt5ofcKJu/ANG52JilLA90Q3qrXhkc0SllU5C
         /TeYcOFPU1BfwNWjGSOPXfqOTRi7HPAioc0j7wl1peQmHyLTQhwAUtZEQ9256vsjexm9
         4YnA==
X-Forwarded-Encrypted: i=1; AJvYcCXZxwvCEA3MF12U5J0NObKNVwedwyFYdNhQY1J1YavnfzfqY9ezcU3FWdkRTvJGvgQ+207aM/D2JKoaild9fcGNtmsJnL2oLjFeMB0W
X-Gm-Message-State: AOJu0YwQkqRk/15rlWFAaWlqaf9frO//gVCU6ahdRNyB8KNgDq8KbtSy
	+g7TkBdqb/UPX0J1xOGqlHOHZ3aAeVn8AyQZ2Q6Ikg79eE69gxg1wS8WxJnU05XCtTpE9asIuud
	c+XSiKFU2h92uv8nf6dEdTdo2FQ==
X-Google-Smtp-Source: AGHT+IFV09z4ES9eTc1iwHg44IFOc1rJLNlXM+zIS2NRSs9E8mi20tWIoRHVg0rk6F7j6t+9cKH8vnFmQ+2I9wUdlrk=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:181d:b0:e03:5144:1d48 with
 SMTP id 3f1490d57ef6-e0b5452490amr1280276.11.1722023871606; Fri, 26 Jul 2024
 12:57:51 -0700 (PDT)
Date: Fri, 26 Jul 2024 19:57:40 +0000
In-Reply-To: <20240726-b4-rbtree-v7-0-aee88caaf97c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240726-b4-rbtree-v7-0-aee88caaf97c@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240726-b4-rbtree-v7-1-aee88caaf97c@google.com>
Subject: [PATCH v7 1/6] rust: kernel: add `drop_contents` to `BoxExt`
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


