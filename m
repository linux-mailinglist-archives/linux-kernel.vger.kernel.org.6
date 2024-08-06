Return-Path: <linux-kernel+bounces-276362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1294927C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF542875AE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF13620FA89;
	Tue,  6 Aug 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ELLNBUG+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4A21C198
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952793; cv=none; b=BCe05XNA43+e3y4vlpJTLvrkBeE2ZrVEGgeGr2ekrYkoySR/Qy1iNJUzSrprfxEiEHwKDmIuDlubaydZhQKLIGGQskQ6xPAhRuY9Gkei/oNcTQInyqPWU84Xw8eXxyp0MtetjjQ800mw6NwQ5VOi1nZtJtDUwlLL89HqmF+OqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952793; c=relaxed/simple;
	bh=DWn7jfpTLBRlhpcytJudwcfEhzJZIMi+Im52RQQpm8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DP2f0ef7mhz5xak6REhYfso6YuCKjTjN1qgQ3GB5CqIrAXS9rAT3nopeOiNPIs0xNna1DiUBj1voihgxEYG+nHq//mAHP0XdXgreT2/xFcmI/AsX0GPQH/i8xIXWjUJiB4II53UEHv7KSobXn2IStY3e0NuoFK7QT3W+7b47xes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ELLNBUG+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4281b7196bbso5798315e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 06:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722952790; x=1723557590; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGFrtitg8gPy3R8NAtg653rpOeRPL0RQ8pJtbADQFYM=;
        b=ELLNBUG+wuWd1BmEEO6J3HmDv2z9cYb5LN6RaqUis7oS3gSNPtnWYlPC4osAlibPJ5
         e9MjRKm8evuMpSd+mS+P+NY4n2eyRIrqajz4EK3zacCEmhSnFMIZBTOcOlH2vooFCxXp
         LZpekx8WvrW1gowzGAZsuvQzymuCqFm03uAlCDyL2cJGxLb80F03Q0qwK7AiApKUWmot
         2kirp7dTJzoMlZo53XMm6iFBTHzoHVnC+VyJhFPrZFKOCxki8ackmFjlmpgMRs6jQP8w
         Acl35CAfCi+LkaE6wgj+H3avwWPFWy0DplYyCMN2rdtrVRGlvPzciGC745rmZ3a6qs5T
         k28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722952790; x=1723557590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGFrtitg8gPy3R8NAtg653rpOeRPL0RQ8pJtbADQFYM=;
        b=MbMypM+MrDk5MVvBvdr+JBRqpdfiYU5Who0/6T7kMJ1UeuJCTaTmborkRFbYeZdec8
         a0aEP9yeYQP+3KcUzEhnKEcH9kyXtMjzNXv62enAW04Mi+maNWSechlBc4uzE5OeaV7L
         HU1GyL32HO6RoOptViLQX83u6p0b9T6mGL/w23ap0dzpz0kBQFvEbvYNLHU5WgDaKkOz
         SXL9k1YNoRHztw9AEW+3dYXHIJ/FbTiMdBAdYaH4DcgxseAV966kCdbthwU242GG26EM
         aKnRKYC0K+X7DMYpkuMh754fI5nDhQ3zEpCqP5N2wWHNUXbZbGH7dg2BDcN6s1qrrZKs
         W+Cw==
X-Forwarded-Encrypted: i=1; AJvYcCW75uf/RGWe3vxo/gMB4QZmDW3msH2xnXyNwPbBB1O7ugkh7qFJx66eMMCicjOazZP4ffIVu0OnzY8p6WxrUGUFSUn7J1xXRNEaXhF1
X-Gm-Message-State: AOJu0YxuVgDheMdU4U0HMnNmsNrCiuNqJqNUZ7/3IDa5uTDawHAEfXNq
	WXb0C1DNYkI/kLpXnEtAzkp6v7vsPi+CvzvLRk8f0GPMiV0HkttYie19y2SXGyPpaE3U+0l1Tuq
	pshp1JhyN81yR0Q==
X-Google-Smtp-Source: AGHT+IFMEkiTrLYVlGwRErNqUfwoDA5zE0L6LG+0tqFbLkqJ2OL6U+Bbd7Qnd82dro7+NlgDM08smzyCo7K43R0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:a085:b0:428:197f:2407 with SMTP
 id 5b1f17b1804b1-428e6cc2a2dmr638185e9.5.1722952789849; Tue, 06 Aug 2024
 06:59:49 -0700 (PDT)
Date: Tue, 06 Aug 2024 13:59:01 +0000
In-Reply-To: <20240806-linked-list-v4-0-23efc510ec92@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806-linked-list-v4-0-23efc510ec92@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11925; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=DWn7jfpTLBRlhpcytJudwcfEhzJZIMi+Im52RQQpm8o=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmsiw8eo7wc3L2etqxaS+zGJn80d3m1Tet5RCE2
 b4yY8dC5+aJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrIsPAAKCRAEWL7uWMY5
 Rh6iD/9K0rfxdSmtprEvtl+EqbMkPLGoj7FkIFcjLwN8UlTy0oH/mqYEbTcGElPwVpPmrZR8Fdi
 9gHCd9ur/rPakWBAV9bSz8rC0guLgWwmdKnEUejjuAL4bR+uXWxz0qFE22IqHETdkxniC1Vx+By
 KGBqzlj789RWwwYXCAyBSzSfFV0vxylrjTNxPForhMSL8SJTFuJty3u7VChOUvAJ03bQsLvIyVX
 LuCNRwXDGZwcJ7ePomCn20i4eqrqEjiZN+UyYccLPoY9zDF4IiUXy+dx+meUurJoMz7uWZJIZ2B
 XrSv1OKg8/AFP62pvmXj4ywpZrAM+dFUqFTilmRqvy2DtSCocIQ/0lx/GYMZEw4YTt2v9Eo/jWg
 Ct3KBlEPo+CWXokG5iOjY+ZVWZVuwbpwwWbl/raXOXiD8xssfx9LWKRH5dPABwIw9nrkhLLTZeT
 kDK9zzjz3bscTvYstVFOGluQRudD7EYZ03MjBcbnb47J/PZeb3mYLDveSLQEq+z1fr02zwedUkc
 UuSNwv/kK3obHuoq4rsPy32ZcdjN7/Bk1Ky0zf6s+rOmiet80ZhZBzzoZTyULXka+5f5/Hjapso
 xNDbhPf2BRdpJEYZ1lM698GSXa1Kyoe+yRiQgeJei63eZcK58m3oXmWkMTCtsTBiErc3+weOH0V IMOcl/GISw1rrXg==
X-Mailer: b4 0.13.0
Message-ID: <20240806-linked-list-v4-9-23efc510ec92@google.com>
Subject: [PATCH v4 09/10] rust: list: support heterogeneous lists
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
 rust/kernel/list/impl_list_item_mod.rs | 131 +++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 904cfa454dff..cf26fec37c1e 100644
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
+    // UnsafeCell is not enough here because we need `Opaque::zeroed` as a dummy value, and
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
index 30886e64b8ef..2dbbc648045f 100644
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
2.46.0.rc2.264.g509ed76dc8-goog


