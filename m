Return-Path: <linux-kernel+bounces-286068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45078951624
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C2A283C62
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A84F14A4EF;
	Wed, 14 Aug 2024 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIY+w6D/"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB234149C76
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622782; cv=none; b=muOKHXXtEQLlrCE5y97uV3KYTizxS/J7C3A8HPkI5gWNnKg96JyDvOy2uTgNtFjk0ypXQ+7l/Z0NSQQJqj6skG+FXPc87porgz2wOfNNz33C8oeYggkYaB5sIJzi0BWbOLq6HFdUrmBQdA0kSrhg2qCh3X0Gbbv2LQmF1cITAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622782; c=relaxed/simple;
	bh=qxOnt3B/il49VIsNhZQiolE1dcglvPZWrKlXJi+q0nY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rZYLc9sCE6MDsXl4I1P7j/60AIk4fLBDdQdPn76TUiIBI71/BZtl//ZLJl87LVNdOeAbyAezmmzuvoCXP7G9jJHquDyLIzs0IcAlo2LjSSLHL3ePTEhDEOHIla1K+db8RSQ7EQJ7PYfHHYPcH8bpUmeR7PbT8lBAN+12/mwHg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TIY+w6D/; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-36835f6ebdcso3941858f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622779; x=1724227579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7kWCK2VoUqBufThd68FvbHXMOxTe06YHLnYmz4zMnA=;
        b=TIY+w6D/5S7UsIGVtCW7YVQaoLzbGrnU83eC4WU+qTWh1Ypk5oRowmevAsq1EDNQar
         1YRxiOWqqwlZwkrFVVTrFBUMpdCMuxsgkj4/CK7hPHjWLRvTxBnkMd/woIdyBd/MjzA3
         VZf7cQUMjq05ZJpT1YxeGvL5BKE74BYb6LpXduVkmROAU0wsIT760RMGLftt5vSlvnQs
         9dY7cN/UK0a0TY7uW1ozH1K4MjSlvB1yCDEgjPrVATt5B6NolVgBJXqqfkuToobUyS6Q
         RY2EmgMSgLAI3vHpFaZRFntOV8zJbPCf7rekGLe6I9RYFWdStQvao9rlxo6KsZGJutaT
         R2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622779; x=1724227579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R7kWCK2VoUqBufThd68FvbHXMOxTe06YHLnYmz4zMnA=;
        b=KkGHr3DKzQpH5e7dz2xQJQpd37Bkthc7SfkHhxNBnFYQ0ZGNAXm70SZgvdq67e1eQV
         1rj3HPDLtZj5SwVyE81wfokvAwGRLfr8tES/FRKmWHi3nWvBfwsTBwRtw8NWTmrrbEuK
         VXbUsG68HsSwyH0iq3GfOB7pFI6O2kw55d4jPB6IJMd/Or5m6eYJiLMI1JnXxBUd1m+v
         eS1BIleIFAyKCoyb5qnsPfypTPeKMt96z4nwXNcXjVqW9pjcCJU9IqPphYvvF05yXuTJ
         UOnY/4M4+W7yekXH68/almf2Awy2okH6BHzETE4SXumUg0VcR1UnHAMiQxWT7C6QGzB8
         rkKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWf75ZhxsIYlplGvahC6Oet8XaccFUAxGRczi37y2iaFV9Gw5E9S+HXmVYwAs0se3A8YtoeP6ctacjtXzM9gXFR8t0GFIAcZXGcwZB
X-Gm-Message-State: AOJu0YzK9jCZ/9cU1Dy/+C9/hPLyDostLiiOs8fiE1/d6uZcAX/1cIeZ
	fcb3X0BIBRyiWl15va0CZawas9dcziKjTuTV6C3e2UKA0Vr23QLUONFsHgJgJjBlwx4T5np6yba
	4qQzXzVkraHiuLA==
X-Google-Smtp-Source: AGHT+IE4208iwPdBYeJ4g5leQlxcXm00lPjnY9qa7sTcRG5r4C4Jrl4dAcjUyPqiyJm8D4xWCsdgG3jwDo3D2nY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5d:6dc7:0:b0:368:4b3e:e35b with SMTP id
 ffacd0b85a97d-371777fb0bemr5797f8f.7.1723622779081; Wed, 14 Aug 2024 01:06:19
 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:28 +0000
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11971; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qxOnt3B/il49VIsNhZQiolE1dcglvPZWrKlXJi+q0nY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVhkzlmRyvElrNUcjrIS9ObnnPVV1o0AKRz/
 GZYJS0anfSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlYQAKCRAEWL7uWMY5
 RuZmEACRb28wZ56Q3QxZLYMrvcLyCi+jG1EvBr70Qr16IiAAMweAbDPAfDmN+fpK4g8FyjrGhsk
 lcrBi4RkI0n2ztbw7bao2aKmzm7pymIpcb1h+OUWRrHn3j3PopocAz75jP/rIaL0n8XdTqErjGE
 A1Im8XBBVZ1m+V725pbFMlGU++8gnUV1yTnrBmgaR3zZtOxFkuAE2cKk8afMWKVUxQAdy+y3dG+
 pJbrjmARNjUF5nt/OonK6vOSqg/RAKu/06RjecfAbGehafIl6mKuhjRt7c4Am/dTq6J1kvINvg2
 V2EfuhVLpUxwK+58mMTW8g/NKTbfEJu7g+Wpp0GcPTy/ghw5gRbUrW/QSwbQfJ9fX8F24zSs4t2
 IzJ17RHykpvO3i4dlf4c82hsUG1gmR1zMsTHajEcruosW4zxr8+BomHn/SUH+CYgSnJts2/zVKI
 o1oY6mk+twsRXCdMEfIjRimv4ay13qsc2QIYNF9QPLFOsf8qdeu7R3u7KIZcdzoCzgXLLJobdy5
 bxqpEjcsZav3JIEMUTyTDOv73G/n9vWFHJXaoB2LXvyYVvlz/hTLbVVDMJlWnp0XtVJrJnSIS3P
 qrQofeRfGiTg4oID6JE5G7Ki/KmJ4U1KFTinTmw+a0uGXI2JsQ+PMUQ4+s9yFroWktgs4bzfeCD AUcnknh3tOfCa6A==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-9-f5f5e8075da0@google.com>
Subject: [PATCH v5 09/10] rust: list: support heterogeneous lists
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

Support linked lists that can hold many different structs at once. This
is generally done using trait objects. The main challenge is figuring
what the struct is given only a pointer to the ListLinks.

We do this by storing a pointer to the struct next to the ListLinks
field. The container_of operation will then just read that pointer. When
the type is a trait object, that pointer will be a fat pointer whose
metadata is a vtable that tells you what kind of struct it is.

Heterogeneous lists are heavily used by Rust Binder. There are a lot of
so-called todo lists containing various events that need to be delivered
to userspace next time userspace calls into the driver. And there are
quite a few different todo item types: incoming transaction, changes to
refcounts, death notifications, and more.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs                    |  47 +++++++++++-
 rust/kernel/list/impl_list_item_mod.rs | 131 +++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 904cfa454dff..8946c6c92521 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -12,7 +12,9 @@
 use core::ptr;
 
 mod impl_list_item_mod;
-pub use self::impl_list_item_mod::{impl_has_list_links, impl_list_item, HasListLinks};
+pub use self::impl_list_item_mod::{
+    impl_has_list_links, impl_has_list_links_self_ptr, impl_list_item, HasListLinks, HasSelfPtr,
+};
 
 mod arc;
 pub use self::arc::{impl_list_arc_safe, AtomicTracker, ListArc, ListArcSafe, TryNewListArc};
@@ -183,6 +185,49 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
     }
 }
 
+/// Similar to [`ListLinks`], but also contains a pointer to the full value.
+///
+/// This type can be used instead of [`ListLinks`] to support lists with trait objects.
+#[repr(C)]
+pub struct ListLinksSelfPtr<T: ?Sized, const ID: u64 = 0> {
+    /// The `ListLinks` field inside this value.
+    ///
+    /// This is public so that it can be used with `impl_has_list_links!`.
+    pub inner: ListLinks<ID>,
+    // UnsafeCell is not enough here because we use `Opaque::uninit` as a dummy value, and
+    // `ptr::null()` doesn't work for `T: ?Sized`.
+    self_ptr: Opaque<*const T>,
+}
+
+// SAFETY: The fields of a ListLinksSelfPtr can be moved across thread boundaries.
+unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr<T, ID> {}
+// SAFETY: The type is opaque so immutable references to a ListLinksSelfPtr are useless. Therefore,
+// it's okay to have immutable access to a ListLinks from several threads at once.
+//
+// Note that `inner` being a public field does not prevent this type from being opaque, since
+// `inner` is a opaque type.
+unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr<T, ID> {}
+
+impl<T: ?Sized, const ID: u64> ListLinksSelfPtr<T, ID> {
+    /// The offset from the [`ListLinks`] to the self pointer field.
+    pub const LIST_LINKS_SELF_PTR_OFFSET: usize = core::mem::offset_of!(Self, self_ptr);
+
+    /// Creates a new initializer for this type.
+    pub fn new() -> impl PinInit<Self> {
+        // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
+        // not be constructed in an `Arc` that already has a `ListArc`.
+        Self {
+            inner: ListLinks {
+                inner: Opaque::new(ListLinksFields {
+                    prev: ptr::null_mut(),
+                    next: ptr::null_mut(),
+                }),
+            },
+            self_ptr: Opaque::uninit(),
+        }
+    }
+}
+
 impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
     /// Creates a new empty list.
     pub const fn new() -> Self {
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 1bcb14774aeb..a0438537cee1 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -68,6 +68,49 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 }
 pub use impl_has_list_links;
 
+/// Declares that the `ListLinks<ID>` field in this struct is inside a `ListLinksSelfPtr<T, ID>`.
+///
+/// # Safety
+///
+/// The `ListLinks<ID>` field of this struct at the offset `HasListLinks<ID>::OFFSET` must be
+/// inside a `ListLinksSelfPtr<T, ID>`.
+pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
+where
+    Self: HasListLinks<ID>,
+{
+}
+
+/// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for the given type.
+#[macro_export]
+macro_rules! impl_has_list_links_self_ptr {
+    ($(impl$({$($implarg:tt)*})?
+       HasSelfPtr<$item_type:ty $(, $id:tt)?>
+       for $self:ident $(<$($selfarg:ty),*>)?
+       { self.$field:ident }
+    )*) => {$(
+        // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
+        // right type.
+        unsafe impl$(<$($implarg)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for
+            $self $(<$($selfarg),*>)?
+        {}
+
+        unsafe impl$(<$($implarg)*>)? $crate::list::HasListLinks$(<$id>)? for
+            $self $(<$($selfarg),*>)?
+        {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+
+            #[inline]
+            unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                let ptr: *mut $crate::list::ListLinksSelfPtr<$item_type $(, $id)?> =
+                    unsafe { ::core::ptr::addr_of_mut!((*ptr).$field) };
+                ptr.cast()
+            }
+        }
+    )*};
+}
+pub use impl_has_list_links_self_ptr;
+
 /// Implements the [`ListItem`] trait for the given type.
 ///
 /// Requires that the type implements [`HasListLinks`]. Use the [`impl_has_list_links!`] macro to
@@ -139,5 +182,93 @@ unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
             }
         }
     )*};
+
+    (
+        $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+            using ListLinksSelfPtr;
+        })*
+    ) => {$(
+        // SAFETY: See GUARANTEES comment on each method.
+        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $t {
+            // GUARANTEES:
+            // This implementation of `ListItem` will not give out exclusive access to the same
+            // `ListLinks` several times because calls to `prepare_to_insert` and `post_remove`
+            // must alternate and exclusive access is given up when `post_remove` is called.
+            //
+            // Other invocations of `impl_list_item!` also cannot give out exclusive access to the
+            // same `ListLinks` because you can only implement `ListItem` once for each value of
+            // `ID`, and the `ListLinks` fields only work with the specified `ID`.
+            unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
+                // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
+                let links_field = unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) };
+
+                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
+                // Goes via the offset as the field is private.
+                //
+                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
+                // the pointer stays in bounds of the allocation.
+                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
+                    as *const $crate::types::Opaque<*const Self>;
+                let cell_inner = $crate::types::Opaque::raw_get(self_ptr);
+
+                // SAFETY: This value is not accessed in any other places than `prepare_to_insert`,
+                // `post_remove`, or `view_value`. By the safety requirements of those methods,
+                // none of these three methods may be called in parallel with this call to
+                // `prepare_to_insert`, so this write will not race with any other access to the
+                // value.
+                unsafe { ::core::ptr::write(cell_inner, me) };
+
+                links_field
+            }
+
+            // GUARANTEES:
+            // * This returns the same pointer as `prepare_to_insert` because `prepare_to_insert`
+            //   returns the return value of `view_links`.
+            // * By the type invariants of `ListLinks`, the `ListLinks` has two null pointers when
+            //   this value is not in a list.
+            unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
+                // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
+                unsafe { <Self as HasListLinks<$num>>::raw_get_list_links(me.cast_mut()) }
+            }
+
+            // This function is also used as the implementation of `post_remove`, so the caller
+            // may choose to satisfy the safety requirements of `post_remove` instead of the safety
+            // requirements for `view_value`.
+            //
+            // GUARANTEES: (always)
+            // * This returns the same pointer as the one passed to the most recent call to
+            //   `prepare_to_insert` since that call wrote that pointer to this location. The value
+            //   is only modified in `prepare_to_insert`, so it has not been modified since the
+            //   most recent call.
+            //
+            // GUARANTEES: (only when using the `view_value` safety requirements)
+            // * The pointer remains valid until the next call to `post_remove` because the caller
+            //   of the most recent call to `prepare_to_insert` promised to retain ownership of the
+            //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
+            //   be destroyed while a `ListArc` reference exists.
+            unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
+                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
+                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
+                // the pointer stays in bounds of the allocation.
+                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
+                    as *const ::core::cell::UnsafeCell<*const Self>;
+                let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
+                // SAFETY: This is not a data race, because the only function that writes to this
+                // value is `prepare_to_insert`, but by the safety requirements the
+                // `prepare_to_insert` method may not be called in parallel with `view_value` or
+                // `post_remove`.
+                unsafe { ::core::ptr::read(cell_inner) }
+            }
+
+            // GUARANTEES:
+            // The first guarantee of `view_value` is exactly what `post_remove` guarantees.
+            unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
+                // SAFETY: This specific implementation of `view_value` allows the caller to
+                // promise the safety requirements of `post_remove` instead of the safety
+                // requirements for `view_value`.
+                unsafe { <Self as $crate::list::ListItem<$num>>::view_value(me) }
+            }
+        }
+    )*};
 }
 pub use impl_list_item;

-- 
2.46.0.76.ge559c4bf1a-goog


