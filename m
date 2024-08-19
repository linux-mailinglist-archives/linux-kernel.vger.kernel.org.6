Return-Path: <linux-kernel+bounces-291951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9510956948
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B3828200F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFD3166313;
	Mon, 19 Aug 2024 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HSQS1LK7"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37082142900;
	Mon, 19 Aug 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066689; cv=none; b=WXiPcNDQBqq8V15R9+THmkZog/fPx/dHUZPT0JBSKeKVsNiYZb8/SJkJmRm7pRusCrr3n2zmyhgM6RdXP/QMJ9a0An9/ljbe8AEckaCyNZKKrOPyCn8LQalTNgSmxqWsrg2wkhwzgYJGZOofzPsKxAqGuX9p2+HJTgdOrQG8G1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066689; c=relaxed/simple;
	bh=LbRFn62ecbLf29F1YC968ykQ84zaLwEJBRwts8aNNog=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=L7/FRe+6U57pcLyykB5tTs7wqu7d4UiCUZb7DWcTupY06ttWk3VrCc+O/tADbY8A+gbvV8wiPAMJDg1EgcK+vC4T6DP5/oStHRTCGJTYCnjDCQCyzh1Za0fa6RDO+FCxJai7NyKPxWgScLtji2HOiJZfYhV5Crm4HnsDpB5Q0WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HSQS1LK7; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724066684; x=1724325884;
	bh=M/jI8Buod5/ftUezgCTTRBGMAk+KfEY7PTZZcXJeT0U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=HSQS1LK7XUKNn4s9N3pbjm4vY6UWoYYuKbOLVn+mJ3zSSUBG9mrwQEJstpzCEkCVM
	 mBZfuPzX/0AmU1i8unn2e0P4Mu/Q2U8ezbxqrT3f9FUpLce6k/aoQ4KokerDCJV8T9
	 gkDRyZYsFImsKxKXy+dwSdp+xRJTT8NUaMh3Da0MeOMza9vXvscrCf0J4lGnQiG0ou
	 YxiJYk6fRYMU2oBk6UNd3o3IpvB9JSwN5TaEkDhImrrQ52CLp7cBvBmCs6nzuyNU+c
	 2gnKg1p1+DjuWKgZf4pmtDJakYtUESKbUmyJ7jV2WFgiVRIgHUmI9y1TXDHCrr0cbw
	 O0AyGlgZci/ig==
Date: Mon, 19 Aug 2024 11:24:35 +0000
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] rust: kernel: add `drop_contents` to `BoxExt`
Message-ID: <20240819112415.99810-1-benno.lossin@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a0252b75cbbe8e8c7345969b04e6326d787da8b3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sometimes (see [1]) it is necessary to drop the value inside of a
`Box<T>`, but retain the allocation. For example to reuse the allocation
in the future.
Introduce a new function `drop_contents` that turns a `Box<T>` into
`Box<MaybeUninit<T>>` by dropping the value.

Signed-off-by: Benno Lossin <benno.lossin@proton.me>
Link: https://lore.kernel.org/rust-for-linux/20240418-b4-rbtree-v3-5-323e13=
4390ce@google.com/ [1]
---
 rust/kernel/alloc/box_ext.rs | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index 829cb1c1cf9e..b68ade26a42d 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -4,7 +4,7 @@
=20
 use super::{AllocError, Flags};
 use alloc::boxed::Box;
-use core::mem::MaybeUninit;
+use core::{mem::MaybeUninit, ptr, result::Result};
=20
 /// Extensions to [`Box`].
 pub trait BoxExt<T>: Sized {
@@ -17,6 +17,22 @@ pub trait BoxExt<T>: Sized {
     ///
     /// The allocation may fail, in which case an error is returned.
     fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>=
;
+
+    /// Drops the contents, but keeps the allocation.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// use kernel::alloc::{flags, box_ext::BoxExt};
+    /// let value =3D Box::new([0; 32], flags::GFP_KERNEL)?;
+    /// assert_eq!(*value, [0; 32]);
+    /// let value =3D Box::drop_contents(value);
+    /// // Now we can re-use `value`:
+    /// let value =3D Box::write(value, [1; 32]);
+    /// assert_eq!(*value, [1; 32]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn drop_contents(this: Self) -> Box<MaybeUninit<T>>;
 }
=20
 impl<T> BoxExt<T> for Box<T> {
@@ -53,4 +69,17 @@ fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>=
>, AllocError> {
         // zero-sized types, we use `NonNull::dangling`.
         Ok(unsafe { Box::from_raw(ptr) })
     }
+
+    fn drop_contents(this: Self) -> Box<MaybeUninit<T>> {
+        let ptr =3D Box::into_raw(this);
+        // SAFETY: `ptr` is valid, because it came from `Box::into_raw`.
+        unsafe { ptr::drop_in_place(ptr) };
+
+        // CAST: `MaybeUninit<T>` is a transparent wrapper of `T`.
+        let ptr =3D ptr.cast::<MaybeUninit<T>>();
+
+        // SAFETY: `ptr` is valid for writes, because it came from `Box::i=
nto_raw` and it is valid for
+        // reads, since the pointer came from `Box::into_raw` and the type=
 is `MaybeUninit<T>`.
+        unsafe { Box::from_raw(ptr) }
+    }
 }

base-commit: c4d7f546dd9aa9780716cdb07416ca97264dce43
--=20
2.45.2



