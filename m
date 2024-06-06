Return-Path: <linux-kernel+bounces-204521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA938FF00F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5FCB1F24D94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A401993A7;
	Thu,  6 Jun 2024 14:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V8tpqz01"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383A199396
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685424; cv=none; b=aiw1rJfkaSoItIQOVFYJMBtR7nXMyyTgEZx5C8fiOEh162FxVP/JSkttfJ1Ol6IAKuGP/KRajBMUibH5K2kLw3GjoTBwkuwYHmYrezEWuXbskv/IE2emTxpSOhXLuJkvixLBt/sxpRABsSTI+e1pSq8xH/kwSNC5iJTBLhpOqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685424; c=relaxed/simple;
	bh=6KVODQnYtWNQoMLw85R2yUtqc1xp53xILtMXwocmZ5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jtIdMbc0cQIDqdolQTTcPpFhQRXIzjDLvjU87A1u0eCf+N0sUbyENT0aDAansMWk8nllYbQa2YqdDU/tEwXregHiPG/GPOJRE2mx1i1axrBI5f/45bCm4NY/HKVKcZpDDgSRWtAI7PeXTeAl8dl+udwuQxueGokqxPGwgFC10UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V8tpqz01; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627e4afa326so15878747b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717685421; x=1718290221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D83xpw4zc0nTnhAHOcVsYRJWLRnvj7gUU4+SqE71h3c=;
        b=V8tpqz01VBw1o6lsZL/rw9ymWya02o6z2r6MtsgVpvnn3oTJq1j3p1Y0lfHud8BzT3
         xxxKLeyat7GpL/eyLA+KpwQRXMW62OLYneRX5LWghnRU638TaLjKyvETDtOAde5prLHM
         q9XcxkvYL4ca48RY9HTpz2RFKtJcWKwIzMf9C9JiE4CkU0Um2mNTuiikYyJiSOZZ2nG0
         alUiF+hdZ40oBWcwmK3m/xGWdHW+PL0jBkqv5Wonpmi4N/wNB0juq6l575LD3wQ6qGgd
         LDntH9q6NV1o30fnb7OMDbf4Bihkagt3w58/yqLzAgPcvENOJbX0oY2PbLyEtG70W0m8
         E4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717685421; x=1718290221;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D83xpw4zc0nTnhAHOcVsYRJWLRnvj7gUU4+SqE71h3c=;
        b=EPhPOhE3wtL4iZRMziWhHwicuIfnWgTn0nEEi6gb0ZsojmK5ZvAcxVeLzMHPJsyx7v
         B9kRshNO9vIW1ktLAxhBWBGaKFgy6fSZTBxu/aHdyYvBqNrEly0g8uasFo428BHQBtAy
         t2hWFA7YJhST8OqHhlxwy4Gu0asSmqlWS7uWIJaI7YDxfxy6G0I56arSh0VhmYFfs5fT
         0XNZaNwRN+JtiU0+jzd4zj5377yGciHeBT5nylPIDJC8oiu00c5TViHVBefs+L7/Gf/y
         f/tKWxX8Sqm3W/kWvCm064jkiEr8s9KStU0DwbTI3KepaSK8hZ5t7yEsSTYgTXix4juX
         JdCA==
X-Forwarded-Encrypted: i=1; AJvYcCX7KrzTOPWARQ6asKYdAlcevsNfX38FgrLPxW5MHAZRb+9iQgf1yut13j59cJU9w8T7HjSoymx0qqDG4lgC1qUw8BPjdIlPNTl+DRyL
X-Gm-Message-State: AOJu0Yyeink0ziY9iJ0Io/7KqmY2PaW4sNheWFnMGoU6C8Voqxuu4pJu
	VipEMAJgbGG3VxuPh1nCKnpFi8zaJjN3CP4nXmpUff9Ozx8P+l5idTBgD3TzWD+kjlxOSI5efIz
	gf8ww7sadfQAqpvwa+GzHUDJJnQ==
X-Google-Smtp-Source: AGHT+IGw3wLc7XnxXpEgcjIpc9GAoF7EZlm4CA11KQkZmy3hezSnaWe5GPHz2Zn7qS7Ou2teHPex30H7A4lXSUxWEmE=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:18d4:b0:dfa:56fa:bb52 with
 SMTP id 3f1490d57ef6-dfaca7df41cmr347156276.0.1717685421503; Thu, 06 Jun 2024
 07:50:21 -0700 (PDT)
Date: Thu, 06 Jun 2024 14:50:04 +0000
In-Reply-To: <20240606-b4-rbtree-v5-0-96fe1a0e97c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240606-b4-rbtree-v5-0-96fe1a0e97c0@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240606-b4-rbtree-v5-1-96fe1a0e97c0@google.com>
Subject: [PATCH v5 1/6] rust: kernel: add `drop_contents` to `BoxExt`
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
2.45.1.467.gbab1589fc0-goog


