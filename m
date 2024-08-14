Return-Path: <linux-kernel+bounces-286061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCFC95161C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73C1E1C20E1F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE3714373B;
	Wed, 14 Aug 2024 08:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+aHUVG/"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2B13F42A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622767; cv=none; b=gtqRozsp3QRd0vZicmlGwvYxqzqJ17Ses8+cbFiLwX3Qf0EjdEp9rV9tUQ1k7+8YAxKXKU0WhGcaIXkFlHQxjpIBCG92Th2FWnUWK/bKk9KW99weX6nQ4JDXlt52tVomZqF0SjDZPdC08B8pcRkHBi38rXLXabXpOz56UHm4nAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622767; c=relaxed/simple;
	bh=RTOUzFCL9e4o7YmaN6V8KTg9ssYBxofhtcN5frBXE40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PQAT+utT86ob/pIGodor9hXlsh7VtPpQcuEg1qmBce0QCphI59rzViooAOA1+dVegR5qf/1rmhVS5zqxaGdc3pbxCKgAlUlNPlr1+dr6Xww2+Do94237Etc30Es33vMAY0opVC1Rdxmyh623Tryekg8gIYIlikBYcaQ7lZqF47Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+aHUVG/; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso45011175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622762; x=1724227562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gbfgAGvA710CFpAKP9RmDT9+gw+olEYHRYVTDCVqe6I=;
        b=A+aHUVG/NTruAvgauVmN6ZHGe28YLAmbza9tXu/3NxG3RF9JqTk+y4dpEuCTpdO1DF
         FuiK001vmfZczZXKwkc/RLr+c2LQZHGGkITGudK5e6tKeENtFD63pzL05kqnF2gkA1ux
         65vtdO/zZkr/ejn2ImGhskksUcVa1IJZXK3Ie7zoxprYQSA9lZLcPUgzs4JUzjKz73HJ
         B4/ibXRXQ+4rqDxRqTog8D/c0H4oV8cBh0a7cGndMWZxGXDrNuMdHGrY2cWfWjY01ugg
         aFpN5d/xLHt4MH/TKL7m4OGyYaJzOo6WZp6F3ui3uemcuYXKpr/5bcy2/7jweJ8OP6FI
         HceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622762; x=1724227562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbfgAGvA710CFpAKP9RmDT9+gw+olEYHRYVTDCVqe6I=;
        b=Zvj9xCvihigFQ7oahFn8EskrQ1f3roQFD99eIK9wwTWDMmKcVppCiiah35RcxT4VQP
         2PMWu8HQl1WjjI++5a0OOk/9Nxfe6fBJtDu24u+c1y+dq+lXesVnTfJ8+StpIP6gcg+F
         GiZUyWMlKIiUJ1pBRg/TiwpYGdrJ7fBqrJA3o9HjW4I8nqVavjLylVNYYTy5dG4PMGCn
         PN3f/i6FA2Lpv3Tv7QPgBRZ+8Rt2+pIRXh5yBwr8pwwgiqXs6Y2kAKXQpFQXc06Fz76v
         GbYT0KD4N3VrLGeYDnYF8z5VPiqJ51PvjsSPmouTRTO5Qfcwy8i7/sJy112ID4l8Y1aB
         nEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+Wpv9b4o5jXzbKkTzjHXS8nla8mdZMS0TQzDZR/4YUy45UZ07VuBGWxKVmezPcsiqY5nacT3HxPNdE14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrPDrOO5yda1kKtutMv8+DzfEFgnsqj9HCRBIY566sdlvrovAQ
	6HbEjfS7e2fQjqBcZBnq0JuM5xNkY1907ww2ohz3ARfQyJctVfyZ81FyQsNCWwqDwYpESy1mlOG
	OTJoOtu2etKZNkg==
X-Google-Smtp-Source: AGHT+IEWTShI9VkgfCcEDsu2Pz2mWkwmLZMKuvNQVXj4pKsWsDr8W5HESC9nvZ8zxU0dZhgFQr4+JSQpwh9EuyM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:714:b0:428:1718:957f with SMTP
 id 5b1f17b1804b1-429dd26a90fmr40035e9.5.1723622761709; Wed, 14 Aug 2024
 01:06:01 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:21 +0000
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=17972; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=RTOUzFCL9e4o7YmaN6V8KTg9ssYBxofhtcN5frBXE40=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVcuhQvrarQowP8V9X4cScychH87LppiBlhR
 x4W1YQvTN2JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlXAAKCRAEWL7uWMY5
 RvO/EACsRWz1zTXUUktNOdo4A4mOnOYoqGH8vGKpPIDzkRz2b3Nn8Kw5AlRy4KPvoHkmCk2sgJb
 PRBqphz08feeSBVznG7wMY8ueZ8z/+Z0L0LLWUxykOI/UZ7PwY45Ug2xQBs9emxFPhLPrHUdmXK
 T3I+qJl651DyytlVjoCyTSiEVdZkopz3qjuOMkRUBLArfDujQSt1o58OUKYFuVD4pHtZvi8e1AY
 WJOZB6TIu0sRaVBKClKzNx3iRqlqg+t9w2/uI5jURATNuWKLtepmMhIAakWHWGWXZNYYg96GwUJ
 6L6u2EyuV9fa0TWaHBNXQPNfEZJNp6U3nsetJ5Jwcsy/A9+jvXXqOhGCjAwgvt9YWAHFjr9O15i
 EWKRw9gpzEA8Oj6XwsbGqAGX1D+8ffWSQ6IngE+M9VScF59q0ASzL9zWkB+X8Qcmud0aFltDZZb
 I+J7BQhRJxbfv4Xs8yEUZIz5KNnBg4fLcNsl8ea2Eq2/fTCJH70T5RbTJCX3WSyGYzaa3Jjs2YE
 3Guo2Q5PLOOrmmiRAFESaF8x9aJ7G1nnfXIR2FnfhRg23heHQh6IhZYZYw8IZw7CGqqS0KWY62A
 sXmpiuaKDSIqkgsVYzxI32iF8esz3PzPrk6DVAAUglhLo+xXTCNRrRd8G5/o3CmiPYHAKLNra7d ag8uJR4EUe6b8qg==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-2-f5f5e8075da0@google.com>
Subject: [PATCH v5 02/10] rust: list: add ListArc
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
2.46.0.76.ge559c4bf1a-goog


