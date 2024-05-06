Return-Path: <linux-kernel+bounces-169627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E678BCB53
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B311B2835F6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E18145343;
	Mon,  6 May 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sml947SM"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A5414532E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989253; cv=none; b=MXu/QIACcgZuVGMthFxxEXXbMatqvDrupqnQSavw8JYajXMGEcJgvPPCuoUOgSbQHl2ApQWFM6wyCszxiC58SSgouq83sx/SzxmFdTm8v5lTA4FmxWg5OcvCh8+d9Yw6JpvXihhJ4QyPPiyaIXoDYXpGi+ejSe7T9CTuo+IDKtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989253; c=relaxed/simple;
	bh=Ut9pc7UnK/ZLhjyeKL4QL6legRdAKj0mXCzKnKTUcy4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O2tRKhlwBuT/l0czSdck+RtTpennBo8rwPNLEuRG8LjNRbbtoutP14fe8EAEZbmwgaH7ra9Dxc+HWqlJCBwZ0357308/i+QWzCvhBlyib1HQfj3IqXwqT2/N2tdeGDvoT+tJlwRW26WYEITZAfvLnj2QTKyz/0EUdJc+0fa4Ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sml947SM; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-51f7c8c7d85so1145410e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714989250; x=1715594050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfFNNPf+Z0+9z9blRE9xu/wRB+nVh4d9kT8iySlhYHI=;
        b=Sml947SMVAnL5nVuoJRcCzTqwkhGUngf5H/wPb5EVttV+ICM/DD2kylgoZ62Kj2ch6
         kaMW2bCCE3NYBC3Eg0T+/485SK/ousI15zGR9328QI5DhEFU53oV7r8tSuDOhJcTIv2a
         gCMUfIv3cC8Ndn/ue5HZgXOiHb19vpo0MURNCfQL6yOMmkoh0mQJGvbRF23fPG1gRmKV
         0CVP9hZ7zG4JUuLp62ZuyJKcufAu90lLzJcLKu1g8w88bDw/ocHh15tYSVWZNJfKv/qx
         JV3uS86kVAv685iKLq1IZ92TcxaQWSVs3KauW6IIX6T2l70rJ8iA6rRj52D6+Fm424LN
         wJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714989250; x=1715594050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfFNNPf+Z0+9z9blRE9xu/wRB+nVh4d9kT8iySlhYHI=;
        b=qZ9Nbqk4947wHsaFqqUwb0w1P1tEAb1lKTg2mJKl85m9ULUEK/MOpQHEev4Nvxdd4F
         Q3K6W8FfVftemmaE3zpA7b+Cf6LFjGk0xzXrInmggTo87pKbQAPyVm/XGoJ4tNlddVQF
         9l2BWtPeFvbgIBD3ejOT/M2L+6C8uAQp9X7W5f6aZ/+u7VBbOse7Icg54vRUdupOIqU3
         AsFyGQF3JE4BvOWK7eh1meLMIeuXbSrOdzbKV1CLcpF/09vvn1ElJZXdF8duM1994tZ1
         Tv+ROXZBv/fwN99PFSWEDNaTBOUvYR2hWJ0yJdWf4Wd/Nq3mnaSjzB7FcNE99AQ8csvv
         kJFw==
X-Forwarded-Encrypted: i=1; AJvYcCXM6J0RfhTNl2u9O5KKxjijVlDIASgzs9OSpDeoA6pK2+K88wxVXW6e2MG7ohxzh9b81UoI2XDscDo5T0I1j76AQsMNyMZxIV5gGtFG
X-Gm-Message-State: AOJu0YwY4/CLLZf4wmly996dVq0NaePZnq9Mld+G8hBAq5OxKAVhYFzv
	k9IRWOKJcph5YVS8eXa2nemBOdYHgHwPoPKCqtoh/SQc82f7iLVJFHQ55eG7ConEnyS9RXSuU09
	IpoUPX6tL2/7mdA==
X-Google-Smtp-Source: AGHT+IEIiU5srimAu61wpVuiQ73nCqqEVfVL9ZMjs6eaUNS9JsY4zXGhb0qE0I0mdt847qn6BvJ4STQf1QI7oDg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:43bc:0:b0:51c:db00:d8ac with SMTP id
 t28-20020ac243bc000000b0051cdb00d8acmr8885lfl.4.1714989250005; Mon, 06 May
 2024 02:54:10 -0700 (PDT)
Date: Mon, 06 May 2024 09:53:29 +0000
In-Reply-To: <20240506-linked-list-v2-0-7b910840c91f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506-linked-list-v2-0-7b910840c91f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=10137; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Ut9pc7UnK/ZLhjyeKL4QL6legRdAKj0mXCzKnKTUcy4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmOKimJcgo5x/r/jpVzu97yu6NLP309aNRbBReV
 05j16WbRJSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZjiopgAKCRAEWL7uWMY5
 Rl1yEACG1DVHT7Wgv9VEBDkJZklxRP/Z732G2d0TSo1518CQ9I8cWeDvmdy6+KPJAFO8Y2a8sN2
 2veAX3A4aGf8bSJsSxkZ9bgq78XyGX9vd8ubySrnWFX7nnOeOu9XVNGpzzva5BCrHJtfroHk9sS
 qUte0+DQAwXkEjnz4KrWaiN0qv4tFk8W6TZvzqb35BC0WfBLFDFBeKMD87USt5+nCMpyQ4JXAcA
 ZE3aRAvvyohFZKLVzIYg3DKSoQHjhgtFxdCV8tyvxJK/1frc+NJPeR8V2EL9Pk/kffR6GYw26hM
 mTEgBno/9IIluY8iFzTUFZ1saCih5sS/o/4wle/SGyENywhkB7GPJZCw1SllJwpd3jBPVWH7Ykf
 EhGJ0MJs3ynpTq22V57SBDmB/6uRdRTn5wRrt8viZHt+w1FuC/LZ8qQ4lpFpMbmP7BrX0vOmyOk
 dphz2fQN2EZpe/e1bDhJgCRqMs4QujPFzbmgnxrzGXA3yZjqMNFwKyj1MfZEcxKr7ZKYZTyYZMp
 EmG/QdXZ3UsRsjjEUhJekIl2OfnsctfJ2tKcVYmmrkE4wmvZHRjXo1tYxmkLFZWzecrDvbwElQC
 BjGJLOW3U3mMaijMkQ3nmYFQYg/RN+OhjRv44IR5ociynbZqlexht66jguiybCezhg/mTh0KLnr fmn6FbyH6h5UmOQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240506-linked-list-v2-8-7b910840c91f@google.com>
Subject: [PATCH v2 8/9] rust: list: support heterogeneous lists
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, 
	Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Support linked lists that can have many different structs at once. This
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
 rust/kernel/list.rs                    |  47 ++++++++++++++-
 rust/kernel/list/impl_list_item_mod.rs | 105 +++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 641b434e3841..3e687401c6d3 100644
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
@@ -180,6 +184,47 @@ unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
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
index 3ff483be89d1..96e90c0ec587 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -62,6 +62,49 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
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
@@ -95,5 +138,67 @@ unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
             }
         }
     };
+
+    (
+        impl$({$($generics:tt)*})? ListItem<$num:tt> for $t:ty {
+            using ListLinksSelfPtr;
+        } $($rest:tt)*
+    ) => {
+        unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $t {
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
+            unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
+                // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
+                unsafe { <Self as HasListLinks<$num>>::raw_get_list_links(me.cast_mut()) }
+            }
+
+            // This function is also used as the implementation of `post_remove`, so the caller
+            // may choose to satisfy the safety requirements of `post_remove` instead of the safety
+            // requirements for `view_value`.
+            unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
+                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
+                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
+                // the pointer stays in bounds of the allocation.
+                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
+                    as *const ::core::cell::UnsafeCell<*const Self>;
+                let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
+                // This returns the same pointer as the one passes to the previous call to
+                // `prepare_to_insert` since that previous call wrote that pointer to this
+                // location, and the value has not been modified since.
+                //
+                // SAFETY: This is not a data race, because the only function that writes to this
+                // value is `prepare_to_insert`, but by the safety requirements the
+                // `prepare_to_insert` method may not be called in parallel with `view_value` or
+                // `post_remove`.
+                unsafe { ::core::ptr::read(cell_inner) }
+            }
+
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
2.45.0.rc1.225.g2a3ae87e7f-goog


