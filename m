Return-Path: <linux-kernel+bounces-276355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A18949275
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC26287F1D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EF3200118;
	Tue,  6 Aug 2024 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGrtRExL"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDFF1E7A5F
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952777; cv=none; b=e2H2D3SFcmihVyIuVZXHrgE/2NyBjgrKN1g5RXRk78sAMThMSqCLqCuqmRtykmW/FpY5I8QX6yzVuG8IQT/kZ5sN7yTYrUgvRrYo7xxJaBr797nY8UzD/Jq13kXUpX4yLaNZczju3XnCdEH7F/qs2m/S6iFr1RY4RWZhSRGnXbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952777; c=relaxed/simple;
	bh=JVosXDN3SpVRQ/+0zppKL/7SkJYUfcf7jvmkD80O084=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dTnU5LNP9gSsiliFc41JGZge9IoVxe7GpkqRLdIKw6j9gBOVQ+d/jhA9U4Wbfi5bLUbjthhp0NBkutcg0Mbowkt/8lUEIYvULLvzR+IM5DFLWKPiCRqjd0MHlakbXJs2dJ1tYymcOTRfo0Rkm83brJbdQQCGD0yxwPdmPFC32Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGrtRExL; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4280cf2be19so5706855e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722952772; x=1723557572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=17AMWTa6hYVVRqhZAZZCkooxhjEaCq6cxN+9B6hH6F4=;
        b=oGrtRExLuBQ3xWUcWrIXwbBf11+QSDmTdduLFyKlNkzeDnfj2OXJVFcrQlPo60+2n5
         g2IvrT7t3ptsCLlJf12x76ywU05ueqUNa1xNJz5gYfgIvgzcDlQDmKxIq7A2RhnlRMgP
         YohSZfJ7WR6gyJk9ZrFjIxqIitUM+5EGvaaIgYg+SSCzUx7l9fFC/P76CHs22YPjUUqL
         ccajHsFHuDSwufnwNobKWhxkzim+UquXbCTSF23qyQ02Z3KP98F4LIjMCWvXzrmMRPdx
         GS3ainXX5rJyYCl4o5h7P/uznv2qU/Fb4sFGxS+p968hsM37gcPCdtB2sLwr+7vYJMhx
         HRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952772; x=1723557572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17AMWTa6hYVVRqhZAZZCkooxhjEaCq6cxN+9B6hH6F4=;
        b=Kuo1Desr6kMypKJuWNf/sxHx6fAKJCF1oNmqST+s5uKRuJnN7+JgX3mhyOePeiU3ma
         jbIdA1uUrvHjw/I1ogsNnZRssXZ62fc3eOS3ALJsJh5JqRN0JhDe8NqTQuBWzET6xPnk
         60f2sHnIMjqtOEpcJ3+yLXQzw6lrCo8+cMBXFgKtFYudMm8qutSJTt6OiDSGSI+WztRM
         Vk5LPFhzc2Nn+kCyqTkZTUhmfx9qt2bbYXf9syGUqoZ2Bpb6qkXWswxBPQviRZktF9q8
         2mGufSAuhXwwW47WUZAo689OxS81EsBmlk98YuWGT8Q+KJ9fRQtCVUJvLLI3RAMYL1gx
         jw+A==
X-Forwarded-Encrypted: i=1; AJvYcCUT8afj8PbD3Lr/b0HKERfGej/nTT5T6lS0OLV204dxOyK32NeuRZ4neBGT+EEphGlWbIZVNlzFaW8NFuLgNA8PGIWGgHE+Jt0pC8qB
X-Gm-Message-State: AOJu0Yz8EN/4lohKuXneMPROaYF0aOixIeeIqFRlJgGCqzC9mHczhNh9
	bwrmTlTVcxDtXAytdRcLU4zZg4kho9nFCz1i6AuuYdqSWhTyayx8NY5B81/MbGax3WsCDY9EVB4
	PLvZ8sYSnEp5waA==
X-Google-Smtp-Source: AGHT+IFSDvpm7UR3VV05mU/mykSm2w2atzvPPZhYHV1M2i99LttQ9dstvbKPBbKYh9BFPKxejkz0QSJNh/w272k=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:c13:b0:425:3084:ca1 with SMTP
 id 5b1f17b1804b1-428e6bae4c5mr804395e9.5.1722952772446; Tue, 06 Aug 2024
 06:59:32 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:58:54 +0000
In-Reply-To: <20240806-linked-list-v4-0-23efc510ec92@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806-linked-list-v4-0-23efc510ec92@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=17977; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=JVosXDN3SpVRQ/+0zppKL/7SkJYUfcf7jvmkD80O084=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmsiw3FT8pTJY+HfkVy6EtRK10fhDZGys5y92rJ
 AoCz1QS7sOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrIsNwAKCRAEWL7uWMY5
 RqKPD/9FidqdU0eCJ6ks6AnKj8DcIsDW9LixOjKt0TACpSTDJSTCuiFkjktVbFPZDb+pSHEOzTI
 8XyWe/WEah2zevTudvvUWXpUFiORQnjBSIDJd6wE6rYinaoEHpIgviGITVkqrpF1osfRLF5FC0E
 gixot7ErHBYyk7R2uYL63YBLUVjwMqblyb7bOQ2rYv9D7UYCyxb0B8OuX+aBYruYBf2qY1GC3t+
 kffskAxnlar0qsEJ4vOMAVlOOru6rO80YsZ2Q9G8hHPuiX27Qglx0XstA0eD135fM88SDUsi1GB
 b5PgvWsoJ5LwEkK3WqCjR26T7SZyM+ZLfAybjhToy3IznsjM87U0pTIR6Cjf8YxrX+iar3IY3pF
 k8bSjqzDHTBItT+jC+UwJKkqjAFhdDYPyrfi2lbKFock4ky0l2i1a6Aq1vit7vFW5HLC9aqUkt1
 ur4RrmHjK2y4RcgmXzpWcGlqMqV4R1FPk3svcxRkOW0eOrnXt9FZJVNFvAFUaIfbaSnGoekPPMx
 Oo0tUXalNMb3qat29DqnR+5LNKdySmASoYRobwYpcMBp8emY3FfcRLaHDloM2BxIv2fwtFtaqWy
 EzNKXl8m3SI3s0k9fXD2ajZFSnYrAhK9nbW4Jdp2IowWgoAfs5GcpSQglxp7yW0GjeK/IwSIvdY SnUVozQn7AuyhnQ==
X-Mailer: b4 0.13.0
Message-ID: <20240806-linked-list-v4-2-23efc510ec92@google.com>
Subject: [PATCH v4 02/10] rust: list: add ListArc
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, 
	Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="utf-8"

The `ListArc` type can be thought of as a special reference to a
refcounted object that owns the permission to manipulate the
`next`/`prev` pointers stored in the refcounted object. By ensuring that
each object has only one `ListArc` reference, the owner of that
reference is assured exclusive access to the `next`/`prev` pointers.
When a `ListArc` is inserted into a `List`, the `List` takes ownership
of the `ListArc` reference.

There are various strategies for ensuring that a value has only one
`ListArc` reference. The simplest is to convert a `UniqueArc` into a
`ListArc`. However, the refcounted object could also keep track of
whether a `ListArc` exists using a boolean, which could allow for the
creation of new `ListArc` references from an `Arc` reference. Whatever
strategy is used, the relevant tracking is referred to as "the tracking
inside `T`", and the `ListArcSafe` trait (and its subtraits) are used to
update the tracking when a `ListArc` is created or destroyed.

Note that we allow the case where the tracking inside `T` thinks that a
`ListArc` exists, but actually, there isn't a `ListArc`. However, we do
not allow the opposite situation where a `ListArc` exists, but the
tracking thinks it doesn't. This is because the former can at most
result in us failing to create a `ListArc` when the operation could
succeed, whereas the latter can result in the creation of two `ListArc`
references. Only the latter situation can lead to memory safety issues.

This patch introduces the `impl_list_arc_safe!` macro that allows you to
implement `ListArcSafe` for types using the strategy where a `ListArc`
can only be created from a `UniqueArc`. Other strategies are introduced
in later patches.

This is part of the linked list that Rust Binder will use for many
different things. The strategy where a `ListArc` can only be created
from a `UniqueArc` is actually sufficient for most of the objects that
Rust Binder needs to insert into linked lists. Usually, these are todo
items that are created and then immediately inserted into a queue.

The const generic ID allows objects to have several prev/next pointer
pairs so that the same object can be inserted into several different
lists. You are able to have several `ListArc` references as long as they
correspond to different pointer pairs. The ID itself is purely a
compile-time concept and will not be present in the final binary. Both
the `List` and the `ListArc` will need to agree on the ID for them to
work together. Rust Binder uses this in a few places (e.g. death
recipients) where the same object can be inserted into both generic todo
lists and some other lists for tracking the status of the object.

The ID is a const generic rather than a type parameter because the
`pair_from_unique` method needs to be able to assert that the two ids
are different. There's no easy way to assert that when using types
instead of integers.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/lib.rs      |   1 +
 rust/kernel/list.rs     |   8 ++
 rust/kernel/list/arc.rs | 352 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 274bdc1b0a82..9baea9e9ee1a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -38,6 +38,7 @@
 pub mod ioctl;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod list;
 #[cfg(CONFIG_NET)]
 pub mod net;
 pub mod page;
diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
new file mode 100644
index 000000000000..fb16ea43b2ba
--- /dev/null
+++ b/rust/kernel/list.rs
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A linked list implementation.
+
+mod arc;
+pub use self::arc::{impl_list_arc_safe, ListArc, ListArcSafe};
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
new file mode 100644
index 000000000000..966076da4a75
--- /dev/null
+++ b/rust/kernel/list/arc.rs
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! A wrapper around `Arc` for linked lists.
+
+use crate::alloc::{AllocError, Flags};
+use crate::prelude::*;
+use crate::sync::{Arc, ArcBorrow, UniqueArc};
+use core::marker::Unsize;
+use core::ops::Deref;
+use core::pin::Pin;
+
+/// Declares that this type has some way to ensure that there is exactly one `ListArc` instance for
+/// this id.
+///
+/// Types that implement this trait should include some kind of logic for keeping track of whether
+/// a [`ListArc`] exists or not. We refer to this logic as "the tracking inside `T`".
+///
+/// We allow the case where the tracking inside `T` thinks that a [`ListArc`] exists, but actually,
+/// there isn't a [`ListArc`]. However, we do not allow the opposite situation where a [`ListArc`]
+/// exists, but the tracking thinks it doesn't. This is because the former can at most result in us
+/// failing to create a [`ListArc`] when the operation could succeed, whereas the latter can result
+/// in the creation of two [`ListArc`] references. Only the latter situation can lead to memory
+/// safety issues.
+///
+/// A consequence of the above is that you may implement the tracking inside `T` by not actually
+/// keeping track of anything. To do this, you always claim that a [`ListArc`] exists, even if
+/// there isn't one. This implementation is allowed by the above rule, but it means that
+/// [`ListArc`] references can only be created if you have ownership of *all* references to the
+/// refcounted object, as you otherwise have no way of knowing whether a [`ListArc`] exists.
+pub trait ListArcSafe<const ID: u64 = 0> {
+    /// Informs the tracking inside this type that it now has a [`ListArc`] reference.
+    ///
+    /// This method may be called even if the tracking inside this type thinks that a `ListArc`
+    /// reference exists. (But only if that's not actually the case.)
+    ///
+    /// # Safety
+    ///
+    /// Must not be called if a [`ListArc`] already exist for this value.
+    unsafe fn on_create_list_arc_from_unique(self: Pin<&mut Self>);
+
+    /// Informs the tracking inside this type that there is no [`ListArc`] reference anymore.
+    ///
+    /// # Safety
+    ///
+    /// Must only be called if there is no [`ListArc`] reference, but the tracking thinks there is.
+    unsafe fn on_drop_list_arc(&self);
+}
+
+/// Declares that this type supports [`ListArc`].
+///
+/// When using this macro, it will only be possible to create a [`ListArc`] from a [`UniqueArc`].
+#[macro_export]
+macro_rules! impl_list_arc_safe {
+    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracked; } $($rest:tt)*) => {
+        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
+            unsafe fn on_create_list_arc_from_unique(self: ::core::pin::Pin<&mut Self>) {}
+            unsafe fn on_drop_list_arc(&self) {}
+        }
+        $crate::list::impl_list_arc_safe! { $($rest)* }
+    };
+
+    () => {};
+}
+pub use impl_list_arc_safe;
+
+/// A wrapper around [`Arc`] that's guaranteed unique for the given id.
+///
+/// The `ListArc` type can be thought of as a special reference to a refcounted object that owns the
+/// permission to manipulate the `next`/`prev` pointers stored in the refcounted object. By ensuring
+/// that each object has only one `ListArc` reference, the owner of that reference is assured
+/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is inserted into a `List`, the
+/// `List` takes ownership of the `ListArc` reference.
+///
+/// There are various strategies to ensuring that a value has only one `ListArc` reference. The
+/// simplest is to convert a [`UniqueArc`] into a `ListArc`. However, the refcounted object could
+/// also keep track of whether a `ListArc` exists using a boolean, which could allow for the
+/// creation of new `ListArc` references from an [`Arc`] reference. Whatever strategy is used, the
+/// relevant tracking is referred to as "the tracking inside `T`", and the [`ListArcSafe`] trait
+/// (and its subtraits) are used to update the tracking when a `ListArc` is created or destroyed.
+///
+/// Note that we allow the case where the tracking inside `T` thinks that a `ListArc` exists, but
+/// actually, there isn't a `ListArc`. However, we do not allow the opposite situation where a
+/// `ListArc` exists, but the tracking thinks it doesn't. This is because the former can at most
+/// result in us failing to create a `ListArc` when the operation could succeed, whereas the latter
+/// can result in the creation of two `ListArc` references.
+///
+/// While this `ListArc` is unique for the given id, there still might exist normal `Arc`
+/// references to the object.
+///
+/// # Invariants
+///
+/// * Each reference counted object has at most one `ListArc` for each value of `ID`.
+/// * The tracking inside `T` is aware that a `ListArc` reference exists.
+#[repr(transparent)]
+pub struct ListArc<T, const ID: u64 = 0>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    arc: Arc<T>,
+}
+
+impl<T: ListArcSafe<ID>, const ID: u64> ListArc<T, ID> {
+    /// Constructs a new reference counted instance of `T`.
+    #[inline]
+    pub fn new(contents: T, flags: Flags) -> Result<Self, AllocError> {
+        Ok(Self::from(UniqueArc::new(contents, flags)?))
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// If `T: !Unpin` it will not be able to move afterwards.
+    // We don't implement `InPlaceInit` because `ListArc` is implicitly pinned. This is similar to
+    // what we do for `Arc`.
+    #[inline]
+    pub fn pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        Ok(Self::from(UniqueArc::try_pin_init(init, flags)?))
+    }
+
+    /// Use the given initializer to in-place initialize a `T`.
+    ///
+    /// This is equivalent to [`ListArc<T>::pin_init`], since a [`ListArc`] is always pinned.
+    #[inline]
+    pub fn init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
+    where
+        E: From<AllocError>,
+    {
+        Ok(Self::from(UniqueArc::try_init(init, flags)?))
+    }
+}
+
+impl<T, const ID: u64> From<UniqueArc<T>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Convert a [`UniqueArc`] into a [`ListArc`].
+    #[inline]
+    fn from(unique: UniqueArc<T>) -> Self {
+        Self::from(Pin::from(unique))
+    }
+}
+
+impl<T, const ID: u64> From<Pin<UniqueArc<T>>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Convert a pinned [`UniqueArc`] into a [`ListArc`].
+    #[inline]
+    fn from(mut unique: Pin<UniqueArc<T>>) -> Self {
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { T::on_create_list_arc_from_unique(unique.as_mut()) };
+        let arc = Arc::from(unique);
+        // SAFETY: We just called `on_create_list_arc_from_unique` on an arc without a `ListArc`,
+        // so we can create a `ListArc`.
+        unsafe { Self::transmute_from_arc(arc) }
+    }
+}
+
+impl<T, const ID: u64> ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    /// Creates two `ListArc`s from a [`UniqueArc`].
+    ///
+    /// The two ids must be different.
+    #[inline]
+    pub fn pair_from_unique<const ID2: u64>(unique: UniqueArc<T>) -> (Self, ListArc<T, ID2>)
+    where
+        T: ListArcSafe<ID2>,
+    {
+        Self::pair_from_pin_unique(Pin::from(unique))
+    }
+
+    /// Creates two `ListArc`s from a pinned [`UniqueArc`].
+    ///
+    /// The two ids must be different.
+    #[inline]
+    pub fn pair_from_pin_unique<const ID2: u64>(
+        mut unique: Pin<UniqueArc<T>>,
+    ) -> (Self, ListArc<T, ID2>)
+    where
+        T: ListArcSafe<ID2>,
+    {
+        build_assert!(ID != ID2);
+
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { <T as ListArcSafe<ID>>::on_create_list_arc_from_unique(unique.as_mut()) };
+        // SAFETY: We have a `UniqueArc`, so there is no `ListArc`.
+        unsafe { <T as ListArcSafe<ID2>>::on_create_list_arc_from_unique(unique.as_mut()) };
+
+        let arc1 = Arc::from(unique);
+        let arc2 = Arc::clone(&arc1);
+
+        // SAFETY: We just called `on_create_list_arc_from_unique` on an arc without a `ListArc`
+        // for both IDs (which are different), so we can create two `ListArc`s.
+        unsafe {
+            (
+                Self::transmute_from_arc(arc1),
+                ListArc::transmute_from_arc(arc2),
+            )
+        }
+    }
+
+    /// Transmutes an [`Arc`] into a `ListArc` without updating the tracking inside `T`.
+    ///
+    /// # Safety
+    ///
+    /// * The value must not already have a `ListArc` reference.
+    /// * The tracking inside `T` must think that there is a `ListArc` reference.
+    #[inline]
+    unsafe fn transmute_from_arc(arc: Arc<T>) -> Self {
+        // INVARIANT: By the safety requirements, the invariants on `ListArc` are satisfied.
+        Self { arc }
+    }
+
+    /// Transmutes a `ListArc` into an [`Arc`] without updating the tracking inside `T`.
+    ///
+    /// After this call, the tracking inside `T` will still think that there is a `ListArc`
+    /// reference.
+    #[inline]
+    fn transmute_to_arc(self) -> Arc<T> {
+        // Use a transmute to skip destructor.
+        //
+        // SAFETY: ListArc is repr(transparent).
+        unsafe { core::mem::transmute(self) }
+    }
+
+    /// Convert ownership of this `ListArc` into a raw pointer.
+    ///
+    /// The returned pointer is indistinguishable from pointers returned by [`Arc::into_raw`]. The
+    /// tracking inside `T` will still think that a `ListArc` exists after this call.
+    #[inline]
+    pub fn into_raw(self) -> *const T {
+        Arc::into_raw(Self::transmute_to_arc(self))
+    }
+
+    /// Take ownership of the `ListArc` from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// * `ptr` must satisfy the safety requirements of [`Arc::from_raw`].
+    /// * The value must not already have a `ListArc` reference.
+    /// * The tracking inside `T` must think that there is a `ListArc` reference.
+    #[inline]
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY: The pointer satisfies the safety requirements for `Arc::from_raw`.
+        let arc = unsafe { Arc::from_raw(ptr) };
+        // SAFETY: The value doesn't already have a `ListArc` reference, but the tracking thinks it
+        // does.
+        unsafe { Self::transmute_from_arc(arc) }
+    }
+
+    /// Converts the `ListArc` into an [`Arc`].
+    #[inline]
+    pub fn into_arc(self) -> Arc<T> {
+        let arc = Self::transmute_to_arc(self);
+        // SAFETY: There is no longer a `ListArc`, but the tracking thinks there is.
+        unsafe { T::on_drop_list_arc(&arc) };
+        arc
+    }
+
+    /// Clone a `ListArc` into an [`Arc`].
+    #[inline]
+    pub fn clone_arc(&self) -> Arc<T> {
+        self.arc.clone()
+    }
+
+    /// Returns a reference to an [`Arc`] from the given [`ListArc`].
+    ///
+    /// This is useful when the argument of a function call is an [`&Arc`] (e.g., in a method
+    /// receiver), but we have a [`ListArc`] instead.
+    ///
+    /// [`&Arc`]: Arc
+    #[inline]
+    pub fn as_arc(&self) -> &Arc<T> {
+        &self.arc
+    }
+
+    /// Returns an [`ArcBorrow`] from the given [`ListArc`].
+    ///
+    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
+    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
+    #[inline]
+    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
+        self.arc.as_arc_borrow()
+    }
+
+    /// Compare whether two [`ListArc`] pointers reference the same underlying object.
+    #[inline]
+    pub fn ptr_eq(this: &Self, other: &Self) -> bool {
+        Arc::ptr_eq(&this.arc, &other.arc)
+    }
+}
+
+impl<T, const ID: u64> Deref for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.arc.deref()
+    }
+}
+
+impl<T, const ID: u64> Drop for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: There is no longer a `ListArc`, but the tracking thinks there is by the type
+        // invariants on `Self`.
+        unsafe { T::on_drop_list_arc(&self.arc) };
+    }
+}
+
+impl<T, const ID: u64> AsRef<Arc<T>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + ?Sized,
+{
+    #[inline]
+    fn as_ref(&self) -> &Arc<T> {
+        self.as_arc()
+    }
+}
+
+// This is to allow [`ListArc`] (and variants) to be used as the type of `self`.
+impl<T, const ID: u64> core::ops::Receiver for ListArc<T, ID> where T: ListArcSafe<ID> + ?Sized {}
+
+// This is to allow coercion from `ListArc<T>` to `ListArc<U>` if `T` can be converted to the
+// dynamically-sized type (DST) `U`.
+impl<T, U, const ID: u64> core::ops::CoerceUnsized<ListArc<U, ID>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
+    U: ListArcSafe<ID> + ?Sized,
+{
+}
+
+// This is to allow `ListArc<U>` to be dispatched on when `ListArc<T>` can be coerced into
+// `ListArc<U>`.
+impl<T, U, const ID: u64> core::ops::DispatchFromDyn<ListArc<U, ID>> for ListArc<T, ID>
+where
+    T: ListArcSafe<ID> + Unsize<U> + ?Sized,
+    U: ListArcSafe<ID> + ?Sized,
+{
+}

-- 
2.46.0.rc2.264.g509ed76dc8-goog


