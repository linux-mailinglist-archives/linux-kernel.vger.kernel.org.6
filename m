Return-Path: <linux-kernel+bounces-259749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB675939C91
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39542831F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152591509A6;
	Tue, 23 Jul 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3T08d98"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137715099D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723002; cv=none; b=XAF/kYHNCxJLAfXCD6xDeDQaOH+svM69ErWn8gP7S9u8YMsNTt54pC9GCxQl/QMig04OFPa+iry/plceg8W23i5jrw3lxR9HSa2utErf8ngpb9LOitoNLoyAQ2Ol6itNYLU9SLaeFsmXfqc8wHv8ka4sScQ0jjSsHlUbNXM/nAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723002; c=relaxed/simple;
	bh=t2oXckmC19ETgVAHAa4uo0x7V5UDrMT6LVv4t/Ms89Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KkGcC6Ab7SKin2n7lSvqgbz1yuvmJ9fQ358YZMoIitpgaw/+GRXVrme0baQJtXFPoS+0NmO43hz+uM1HCpDsygtcH6YzYZlrutNWQi/Z2xg8KibvCdmgxhywlsdKgp0M5wIOqyR9nZ1k7+eBDmGfCASxE999WDAPNY8NKxl9WYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3T08d98; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-65026e6285eso150177387b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721723000; x=1722327800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SR66IeXZaK15fT7q7EwWrb5J+C89ptRSyhcMWM3W7Cw=;
        b=s3T08d986vnP0XI0RFDoWe8IFUs/bQrFrbd1kBxiZffg6HlfmdDiLMBPF83v1gYKIo
         yxarvkJbbg4Sv2RUQyUHxcqrlxClMQTMt4+oVZoT4PFTV59cGr20GEOR9SQV5kwhCN6G
         uiJ7MGRwwiuDfGWYl43yFXgX301aodjSiR8/CBJuwQNxx9l+TDN7wNo2pfxujLlxgXnt
         OvOi6M+GgPmmf0R9fNCeDJGZt6LoBg/fGWovLsH8UFtBhHNMJAxTXbHxZ+kWtBaWV7Qd
         AII7cEwzU7YgzhB9DXPrxfnmYdY0wfkJ86gPnPdKETLWNUtuFRARlqlXKU3790WF+ezt
         h8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723000; x=1722327800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SR66IeXZaK15fT7q7EwWrb5J+C89ptRSyhcMWM3W7Cw=;
        b=ClXq/7vZI82XoMxsUEBbGWCEU+QDLubw5JIGJsAxZu2+tavxwd3wUBqHUkbdvsez4T
         GKOvlTgqtGRvHtq9PUZ8OJ76ILpv86ia9qkxvMTL77lxx6UpJkRvDwmryyUHUSt2W3Ev
         20ovHuXvr0EefmoANqOK+CDD8rJCMq/E/aWm+qTUtO4LeAHVMjUCbskUgXW+COaUqhAM
         RmeLsEBRViuD1+cvlwUVK4iy4dLgejkRIOKg0TotZCrRcgDXOKr2p+8yV8T9TBdo4LTU
         uyEkRG+HAJspEJFBPmOVfDr+Ff+8fuxNfLHiRHBHldNYLajwLu/1YYQuJdGCIzzxQ+IZ
         /Lrg==
X-Forwarded-Encrypted: i=1; AJvYcCVrlUSMh46K636zlv/R6X2WFocGt2yRMTRCMscWvbOGIHmG9P0APke/D/k4JRijScrxYZ180fuW6oITQyz5+qCCW15z6/VO+rhQ3aI3
X-Gm-Message-State: AOJu0Yww3kFXkse3Rveclmc6WD1KeR30RA6sD4bT38PDYqXmNs0LPY5X
	76ZOZ6+FWlpWJaokcuDaZRekK6GNZfHb8bqF1cYH3H8YvMF73zqg9Zz9WUGpC5Bpimi1chWatDR
	O4QYsvCRzjgjaiQ==
X-Google-Smtp-Source: AGHT+IEkucnm3KX+t4Fn5rUjU9pGGLXEIEsxSCZpG/oHFaXOMsAhblQNZYxocnc0p2MhzC3bcS3CS0UnnMwpi/A=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:fd4:b0:65c:1db1:9235 with SMTP
 id 00721157ae682-66e4900940amr702487b3.0.1721722999935; Tue, 23 Jul 2024
 01:23:19 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:10 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11842; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=t2oXckmC19ETgVAHAa4uo0x7V5UDrMT6LVv4t/Ms89Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hXVZtQKU1bPvIXHJeNDmldhxxTmU2vo054p
 YTXUahkg3uJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oVwAKCRAEWL7uWMY5
 RhNoD/9+bAamGfXBOhmCDMLpZfriTP+vVE5Kl2Te1FExKwBPbVnVO6/GcLstEzQ9rPF+n8hQot0
 7bF5ird2yhpgu8Jg0C+af5RPy8zFVOHd3EAmZmxMwpapF2JPRHTRnKvRRCrqiaHyboqbKa+w7it
 reP+hljsWXsUNiaPfu1jqlI8i4D5C0Mho7X49qXqUlYTA3Bbb1mW4mmCC31/0O4VwmeQdxtnBtR
 zZkKWiu/qaKjyHJVe1vhXjUx89c0C2P0DZ7Z6eHVF++8PUhdeCd5omg06MMbKnVsh95wxeIHRfg
 yRt9mwjDO3+HvNwXCiUEXxUz3KomxUksYU90CvcCG++K7mKcHYiKF9TPXAQxiyBwW848fSIQldX
 6eEVbTgSyilwnjfrn7higRgPHwWttWh4Fgz1hOIw5rcUNSfz2XxK/a6Yk9i1ZcEaLhqAKoHxAj5
 ejJZuinTFkgLPLKxO0Nxu5htGnYk9tAkI1wVi4+N79FdRS/m9gHa/b8DtFs75eGhFufgAJBFARU
 I129k0THNvAR4nPqgnCPnycUebzCMFFXLBgJv8McGx4iunZG9ogies7YF4KfGIj8dVmHumFopFJ
 UpCD9bpmJogTMlfwv1d2TCWA8UZly/OKBfwpMUrhNOofEtjtHMnKKHP2eUpEzsaVguq35cRZVmf MucZxGe5VlD6TWA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-9-89db92c7dbf4@google.com>
Subject: [PATCH v3 09/10] rust: list: support heterogeneous lists
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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs                    |  47 +++++++++++-
 rust/kernel/list/impl_list_item_mod.rs | 129 +++++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index f36e17369382..f61b19c145db 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -7,12 +7,16 @@
 use crate::init::PinInit;
 use crate::sync::ArcBorrow;
 use crate::types::Opaque;
+use core::cell::UnsafeCell;
 use core::iter::{DoubleEndedIterator, FusedIterator};
 use core::marker::PhantomData;
+use core::mem::MaybeUninit;
 use core::ptr;
 
 mod impl_list_item_mod;
-pub use self::impl_list_item_mod::{impl_has_list_links, impl_list_item, HasListLinks};
+pub use self::impl_list_item_mod::{
+    impl_has_list_links, impl_has_list_links_self_ptr, impl_list_item, HasListLinks, HasSelfPtr,
+};
 
 mod arc;
 pub use self::arc::{
@@ -181,6 +185,47 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
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
+    self_ptr: UnsafeCell<MaybeUninit<*const T>>,
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
+            self_ptr: UnsafeCell::new(MaybeUninit::zeroed()),
+        }
+    }
+}
+
 impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
     /// Creates a new empty list.
     pub const fn new() -> Self {
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 9b1947371c63..9335edd8f350 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -67,6 +67,49 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
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
 /// Assumes that the type implements [`HasListLinks`].
@@ -135,5 +178,91 @@ unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
             }
         }
     };
+
+    (
+        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+            using ListLinksSelfPtr;
+        } $($rest:tt)*
+    ) => {
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
+                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
+                // the pointer stays in bounds of the allocation.
+                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
+                    as *const ::core::cell::UnsafeCell<*const Self>;
+                let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
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
+            // GUARANTEES:
+            // * This returns the same pointer as the one passed to the most recent call to
+            //   `prepare_to_insert` since that call wrote that pointer to this location. The value
+            //   is only modified in `prepare_to_insert`, so it has not been modified since the
+            //   most recent call.
+            //
+            // GUARANTEES: (when using the `view_value` safety requirements)
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
+    };
 }
 pub use impl_list_item;

-- 
2.45.2.1089.g2a221341d9-goog


