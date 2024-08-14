Return-Path: <linux-kernel+bounces-286065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1503951622
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91517284197
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8321494CD;
	Wed, 14 Aug 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c1Qk9i4M"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539313D531
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622777; cv=none; b=T7NEIKcrQK/sylflVdH/N7Aa2aztQdt000DlArDMPpkfpDJFe2zaKpnr5hnHtInETa4OcAs/TQnTVSirGYXeCn5B1oXhAE8wvlSsWuGojsAU0I2ZOjotph4+jeSnYRZ3EL2cavgIJDhCk6BJiQT5rGjEBVqnk7H3Sio7tFAcKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622777; c=relaxed/simple;
	bh=iE5BUobdaUXoE7DrPJDKOBE+/KVoLiI+OKEKvkvjTdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GPq6teogDSDLOvObaHS20ubuiUKKG/KdHR5SSx0c2iiZvyYzepxnNxbZiA/NNdqX7PvSs83Mgo+pjGlgOtZcUszrtstjjAZYbvlXCWoR33rE6DZQg7wJIeTZ1G6RoaLr0zFI22mtEhQRjwPGxO2wjK0zG/DLk87B4g9cUawnIGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c1Qk9i4M; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso45011885e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723622772; x=1724227572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5SVLo3I7t3VZwktEnZCFUT5k7rjJkC5UNvGelK4Neo=;
        b=c1Qk9i4MpdJsGzy0oGwTW0IHEdUAVr1+NMOHHjqzReaRT0iuyfEIUSgT9vXXFlyzCe
         Ua8CcTibf6v2+6ijJGZetbrPoRGoAixYYjYtfDiJGVmw1lhKjTwGu4V/FdKK7r+hm9tl
         oEK1hzT9uCpwDET+n82PQhSb+4A5MShSC/TbCsIoEW0RcLX4+aBLU0GM/9GfP+920mnD
         ko9hYvHrPZ/rcrV+chUyYdDDWjsM/EvV970qRqO2y0hBWJQuwa4GE9NfdG8o0Six9nvG
         40nf+htoydbOsGP/6FqQWdHdj4RHSceveGO0g143RX5em65AQhCeR3XFGhEZY8lT0jd5
         QzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622772; x=1724227572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5SVLo3I7t3VZwktEnZCFUT5k7rjJkC5UNvGelK4Neo=;
        b=ojE/eg5NE0Y9TYXAjeNWwS2+PYPk7+ckK8rJiNKMkHhdryVYRZBeGP84v1L+Sue23Z
         fI/34LLXea6wrD0wkwUEP/XT1sET96wWVeVrzTAJFxHt9XIImqCGp0fYBhf8k1dLkFvW
         F1JDuG6oPZVKpGBwvAqVnvbc55/mhztoEmnErndN72pErW53pRr+WE+L7MzIlQuC7xZk
         w7ZFR0oszLRJDjqW4bn5UOprsgpvLBfTMg1DRlF2/ioC2TbeJ78uB5tldrIGcXD9Rrz/
         CzYvJNua3cNHq79v20umcjZvAKI3Jww3reQ93ZrgHpwRAMhah+aY3V8O+BWcy+ut7QpM
         yYAg==
X-Forwarded-Encrypted: i=1; AJvYcCUhurw+m8gxWbiOeuzDuqPOOb41TaHZcWTXCjAz8w96p32PvLMlYpa+2cEBZVV8Oove1u0AqtSR2jDbfY2h21TM/TfA/r0Nte8hS84U
X-Gm-Message-State: AOJu0YxuOBHBt9RyviQxQ1ix1N75duLAXBMYJSm3KUPIKrlMNTVIx2Fq
	HRAm1++Blybs74WLV9qLs1zdw8BZJxl3pyek83KKBdxhh1mJ5ZJ9lfHKW9drtPBviGicHRvORSD
	CoBLmuIHi/YsEvA==
X-Google-Smtp-Source: AGHT+IGamAxiaZ0cArkmmYAzWJHmi4njPXNMi9SOr2n+ceXNrQHpm4OuaZt149fe+WIF1ewix6qX+6qG5me65ww=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:49a7:b0:428:1001:2ee1 with SMTP
 id 5b1f17b1804b1-429dd273d99mr39735e9.7.1723622771807; Wed, 14 Aug 2024
 01:06:11 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:05:25 +0000
In-Reply-To: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240814-linked-list-v5-0-f5f5e8075da0@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=19102; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=iE5BUobdaUXoE7DrPJDKOBE+/KVoLiI+OKEKvkvjTdQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmvGVf2hJsIY4xrqewlT6SN4Kgv6/Z82X8OFvDz
 rpNAVSqG7mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrxlXwAKCRAEWL7uWMY5
 RnpdEACao3/GHbsJwwyuJE92aaXDvEfiDjWBmlkts3pyM2G1Iss00MItws0Uy6yghC6Pnsk0TAK
 lHUdP6L8c2L4TR11hgUMievlyOqW2IlqnOMJK0JkVn+6Qk//8jbjPXQCPpgx21lJLqQGCjxhTOq
 Nj1AjaSkj/Z4LjWoSDfuYbJYizkzteEBFWZOUKnGvJGLTmNifMt/+7UpEqlHiPT752BBpE9izyE
 WPTPQZwm11csOccUVVuNLPdRi7n7xdgNJEtz91SuhE0Wo5vebCQOq3DCByAr7su/ySMSMIApbN4
 HQlvq85ksU0/PFZALxUe21wBY48RsutR0+pWOXYbLD4PPbJDvYVDI/NKXhcNhL2/vABCo8gmhJZ
 hefodCBfHawMWJlctg/p7xxTqtJAIwpGWwQ2klzLbQvnm90GC7xs3PyE+JH/UUZy3g2BxVwVDXI
 gZzEM1BhiREOdqRQlU15y6H6e7x351QvuxjSIRNcYkgE749yxWhVjvxzdxEFV35YvD71d7vY6lR
 cXUhr7lblhwtbYufu9vcT4y/vtoLcDxNuQWAg5tJk8VcaLlEqhZkH4YOa4gg3nP2MFh6rPQvWIO
 VCrkHcF2osrHGwxmIixsV8DreK8KVg8LNPyWBP6OH75K5oTur3VUpAxGB6Yg6gx2RZfh2LoaY7J t6FATJQ9yIw0Eyw==
X-Mailer: b4 0.13.0
Message-ID: <20240814-linked-list-v5-6-f5f5e8075da0@google.com>
Subject: [PATCH v5 06/10] rust: list: add List
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

Add the actual linked list itself.

The linked list uses the following design: The List type itself just has
a single pointer to the first element of the list. And the actual list
items then form a cycle. So the last item is `first->prev`.

This is slightly different from the usual kernel linked list. Matching
that exactly would amount to giving List two pointers, and having it be
part of the cycle of items. This alternate design has the advantage that
the cycle is never completely empty, which can reduce the number of
branches in some cases. However, it also has the disadvantage that List
must be pinned, which this design is trying to avoid.

Having the list items form a cycle rather than having null pointers at
the beginning/end is convenient for several reasons. For one, it lets us
store only one pointer in List, and it simplifies the implementation of
several functions.

Unfortunately, the `remove` function that removes an arbitrary element
from the list has to be unsafe. This is needed because there is no way
to handle the case where you pass an element from the wrong list. For
example, if it is the first element of some other list, then that other
list's `first` pointer would not be updated. Similarly, it could be a
data race if you try to remove it from two different lists in parallel.
(There's no problem with passing `remove` an item that's not in any
list. Additionally, other removal methods such as `pop_front` need not
be unsafe, as they can't be used to remove items from another list.)

A future patch in this series will introduce support for cursors that
can be used to remove arbitrary items without unsafe code.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs     | 330 +++++++++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/list/arc.rs |   6 +-
 2 files changed, 331 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index 670d53989b8f..551c46a2401b 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -6,6 +6,7 @@
 
 use crate::init::PinInit;
 use crate::types::Opaque;
+use core::marker::PhantomData;
 use core::ptr;
 
 mod impl_list_item_mod;
@@ -14,7 +15,42 @@
 mod arc;
 pub use self::arc::{impl_list_arc_safe, AtomicTracker, ListArc, ListArcSafe, TryNewListArc};
 
-/// Implemented by types where a [`ListArc<Self>`] can be inserted into a `List`.
+/// A linked list.
+///
+/// All elements in this linked list will be [`ListArc`] references to the value. Since a value can
+/// only have one `ListArc` (for each pair of prev/next pointers), this ensures that the same
+/// prev/next pointers are not used for several linked lists.
+///
+/// # Invariants
+///
+/// * If the list is empty, then `first` is null. Otherwise, `first` points at the `ListLinks`
+///   field of the first element in the list.
+/// * All prev/next pointers in `ListLinks` fields of items in the list are valid and form a cycle.
+/// * For every item in the list, the list owns the associated [`ListArc`] reference and has
+///   exclusive access to the `ListLinks` field.
+pub struct List<T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    first: *mut ListLinksFields,
+    _ty: PhantomData<ListArc<T, ID>>,
+}
+
+// SAFETY: This is a container of `ListArc<T, ID>`, and access to the container allows the same
+// type of access to the `ListArc<T, ID>` elements.
+unsafe impl<T, const ID: u64> Send for List<T, ID>
+where
+    ListArc<T, ID>: Send,
+    T: ?Sized + ListItem<ID>,
+{
+}
+// SAFETY: This is a container of `ListArc<T, ID>`, and access to the container allows the same
+// type of access to the `ListArc<T, ID>` elements.
+unsafe impl<T, const ID: u64> Sync for List<T, ID>
+where
+    ListArc<T, ID>: Sync,
+    T: ?Sized + ListItem<ID>,
+{
+}
+
+/// Implemented by types where a [`ListArc<Self>`] can be inserted into a [`List`].
 ///
 /// # Safety
 ///
@@ -56,7 +92,7 @@ pub unsafe trait ListItem<const ID: u64 = 0>: ListArcSafe<ID> {
     ///   been called.
     unsafe fn view_value(me: *mut ListLinks<ID>) -> *const Self;
 
-    /// This is called when an item is inserted into a `List`.
+    /// This is called when an item is inserted into a [`List`].
     ///
     /// # Guarantees
     ///
@@ -103,7 +139,6 @@ struct ListLinksFields {
 pub struct ListLinks<const ID: u64 = 0> {
     // This type is `!Unpin` for aliasing reasons as the pointers are part of an intrusive linked
     // list.
-    #[allow(dead_code)]
     inner: Opaque<ListLinksFields>,
 }
 
@@ -127,4 +162,293 @@ pub fn new() -> impl PinInit<Self> {
             }),
         }
     }
+
+    /// # Safety
+    ///
+    /// `me` must be dereferencable.
+    #[inline]
+    unsafe fn fields(me: *mut Self) -> *mut ListLinksFields {
+        // SAFETY: The caller promises that the pointer is valid.
+        unsafe { Opaque::raw_get(ptr::addr_of!((*me).inner)) }
+    }
+
+    /// # Safety
+    ///
+    /// `me` must be dereferencable.
+    #[inline]
+    unsafe fn from_fields(me: *mut ListLinksFields) -> *mut Self {
+        me.cast()
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
+    /// Creates a new empty list.
+    pub const fn new() -> Self {
+        Self {
+            first: ptr::null_mut(),
+            _ty: PhantomData,
+        }
+    }
+
+    /// Returns whether this list is empty.
+    pub fn is_empty(&self) -> bool {
+        self.first.is_null()
+    }
+
+    /// Add the provided item to the back of the list.
+    pub fn push_back(&mut self, item: ListArc<T, ID>) {
+        let raw_item = ListArc::into_raw(item);
+        // SAFETY:
+        // * We just got `raw_item` from a `ListArc`, so it's in an `Arc`.
+        // * Since we have ownership of the `ListArc`, `post_remove` must have been called after
+        //   the most recent call to `prepare_to_insert`, if any.
+        // * We own the `ListArc`.
+        // * Removing items from this list is always done using `remove_internal_inner`, which
+        //   calls `post_remove` before giving up ownership.
+        let list_links = unsafe { T::prepare_to_insert(raw_item) };
+        // SAFETY: We have not yet called `post_remove`, so `list_links` is still valid.
+        let item = unsafe { ListLinks::fields(list_links) };
+
+        if self.first.is_null() {
+            self.first = item;
+            // SAFETY: The caller just gave us ownership of these fields.
+            // INVARIANT: A linked list with one item should be cyclic.
+            unsafe {
+                (*item).next = item;
+                (*item).prev = item;
+            }
+        } else {
+            let next = self.first;
+            // SAFETY: By the type invariant, this pointer is valid or null. We just checked that
+            // it's not null, so it must be valid.
+            let prev = unsafe { (*next).prev };
+            // SAFETY: Pointers in a linked list are never dangling, and the caller just gave us
+            // ownership of the fields on `item`.
+            // INVARIANT: This correctly inserts `item` between `prev` and `next`.
+            unsafe {
+                (*item).next = next;
+                (*item).prev = prev;
+                (*prev).next = item;
+                (*next).prev = item;
+            }
+        }
+    }
+
+    /// Add the provided item to the front of the list.
+    pub fn push_front(&mut self, item: ListArc<T, ID>) {
+        let raw_item = ListArc::into_raw(item);
+        // SAFETY:
+        // * We just got `raw_item` from a `ListArc`, so it's in an `Arc`.
+        // * If this requirement is violated, then the previous caller of `prepare_to_insert`
+        //   violated the safety requirement that they can't give up ownership of the `ListArc`
+        //   until they call `post_remove`.
+        // * We own the `ListArc`.
+        // * Removing items] from this list is always done using `remove_internal_inner`, which
+        //   calls `post_remove` before giving up ownership.
+        let list_links = unsafe { T::prepare_to_insert(raw_item) };
+        // SAFETY: We have not yet called `post_remove`, so `list_links` is still valid.
+        let item = unsafe { ListLinks::fields(list_links) };
+
+        if self.first.is_null() {
+            // SAFETY: The caller just gave us ownership of these fields.
+            // INVARIANT: A linked list with one item should be cyclic.
+            unsafe {
+                (*item).next = item;
+                (*item).prev = item;
+            }
+        } else {
+            let next = self.first;
+            // SAFETY: We just checked that `next` is non-null.
+            let prev = unsafe { (*next).prev };
+            // SAFETY: Pointers in a linked list are never dangling, and the caller just gave us
+            // ownership of the fields on `item`.
+            // INVARIANT: This correctly inserts `item` between `prev` and `next`.
+            unsafe {
+                (*item).next = next;
+                (*item).prev = prev;
+                (*prev).next = item;
+                (*next).prev = item;
+            }
+        }
+        self.first = item;
+    }
+
+    /// Removes the last item from this list.
+    pub fn pop_back(&mut self) -> Option<ListArc<T, ID>> {
+        if self.first.is_null() {
+            return None;
+        }
+
+        // SAFETY: We just checked that the list is not empty.
+        let last = unsafe { (*self.first).prev };
+        // SAFETY: The last item of this list is in this list.
+        Some(unsafe { self.remove_internal(last) })
+    }
+
+    /// Removes the first item from this list.
+    pub fn pop_front(&mut self) -> Option<ListArc<T, ID>> {
+        if self.first.is_null() {
+            return None;
+        }
+
+        // SAFETY: The first item of this list is in this list.
+        Some(unsafe { self.remove_internal(self.first) })
+    }
+
+    /// Removes the provided item from this list and returns it.
+    ///
+    /// This returns `None` if the item is not in the list. (Note that by the safety requirements,
+    /// this means that the item is not in any list.)
+    ///
+    /// # Safety
+    ///
+    /// `item` must not be in a different linked list (with the same id).
+    pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> {
+        let mut item = unsafe { ListLinks::fields(T::view_links(item)) };
+        // SAFETY: The user provided a reference, and reference are never dangling.
+        //
+        // As for why this is not a data race, there are two cases:
+        //
+        //  * If `item` is not in any list, then these fields are read-only and null.
+        //  * If `item` is in this list, then we have exclusive access to these fields since we
+        //    have a mutable reference to the list.
+        //
+        // In either case, there's no race.
+        let ListLinksFields { next, prev } = unsafe { *item };
+
+        debug_assert_eq!(next.is_null(), prev.is_null());
+        if !next.is_null() {
+            // This is really a no-op, but this ensures that `item` is a raw pointer that was
+            // obtained without going through a pointer->reference->pointer conversion rountrip.
+            // This ensures that the list is valid under the more restrictive strict provenance
+            // ruleset.
+            //
+            // SAFETY: We just checked that `next` is not null, and it's not dangling by the
+            // list invariants.
+            unsafe {
+                debug_assert_eq!(item, (*next).prev);
+                item = (*next).prev;
+            }
+
+            // SAFETY: We just checked that `item` is in a list, so the caller guarantees that it
+            // is in this list. The pointers are in the right order.
+            Some(unsafe { self.remove_internal_inner(item, next, prev) })
+        } else {
+            None
+        }
+    }
+
+    /// Removes the provided item from the list.
+    ///
+    /// # Safety
+    ///
+    /// `item` must point at an item in this list.
+    unsafe fn remove_internal(&mut self, item: *mut ListLinksFields) -> ListArc<T, ID> {
+        // SAFETY: The caller promises that this pointer is not dangling, and there's no data race
+        // since we have a mutable reference to the list containing `item`.
+        let ListLinksFields { next, prev } = unsafe { *item };
+        // SAFETY: The pointers are ok and in the right order.
+        unsafe { self.remove_internal_inner(item, next, prev) }
+    }
+
+    /// Removes the provided item from the list.
+    ///
+    /// # Safety
+    ///
+    /// The `item` pointer must point at an item in this list, and we must have `(*item).next ==
+    /// next` and `(*item).prev == prev`.
+    unsafe fn remove_internal_inner(
+        &mut self,
+        item: *mut ListLinksFields,
+        next: *mut ListLinksFields,
+        prev: *mut ListLinksFields,
+    ) -> ListArc<T, ID> {
+        // SAFETY: We have exclusive access to the pointers of items in the list, and the prev/next
+        // pointers are always valid for items in a list.
+        //
+        // INVARIANT: There are three cases:
+        //  * If the list has at least three items, then after removing the item, `prev` and `next`
+        //    will be next to each other.
+        //  * If the list has two items, then the remaining item will point at itself.
+        //  * If the list has one item, then `next == prev == item`, so these writes have no
+        //    effect. The list remains unchanged and `item` is still in the list for now.
+        unsafe {
+            (*next).prev = prev;
+            (*prev).next = next;
+        }
+        // SAFETY: We have exclusive access to items in the list.
+        // INVARIANT: `item` is being removed, so the pointers should be null.
+        unsafe {
+            (*item).prev = ptr::null_mut();
+            (*item).next = ptr::null_mut();
+        }
+        // INVARIANT: There are three cases:
+        //  * If `item` was not the first item, then `self.first` should remain unchanged.
+        //  * If `item` was the first item and there is another item, then we just updated
+        //    `prev->next` to `next`, which is the new first item, and setting `item->next` to null
+        //    did not modify `prev->next`.
+        //  * If `item` was the only item in the list, then `prev == item`, and we just set
+        //    `item->next` to null, so this correctly sets `first` to null now that the list is
+        //    empty.
+        if self.first == item {
+            // SAFETY: The `prev` pointer is the value that `item->prev` had when it was in this
+            // list, so it must be valid. There is no race since `prev` is still in the list and we
+            // still have exclusive access to the list.
+            self.first = unsafe { (*prev).next };
+        }
+
+        // SAFETY: `item` used to be in the list, so it is dereferencable by the type invariants
+        // of `List`.
+        let list_links = unsafe { ListLinks::from_fields(item) };
+        // SAFETY: Any pointer in the list originates from a `prepare_to_insert` call.
+        let raw_item = unsafe { T::post_remove(list_links) };
+        // SAFETY: The above call to `post_remove` guarantees that we can recreate the `ListArc`.
+        unsafe { ListArc::from_raw(raw_item) }
+    }
+
+    /// Moves all items from `other` into `self`.
+    ///
+    /// The items of `other` are added to the back of `self`, so the last item of `other` becomes
+    /// the last item of `self`.
+    pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
+        // First, we insert the elements into `self`. At the end, we make `other` empty.
+        if self.is_empty() {
+            // INVARIANT: All of the elements in `other` become elements of `self`.
+            self.first = other.first;
+        } else if !other.is_empty() {
+            let other_first = other.first;
+            // SAFETY: The other list is not empty, so this pointer is valid.
+            let other_last = unsafe { (*other_first).prev };
+            let self_first = self.first;
+            // SAFETY: The self list is not empty, so this pointer is valid.
+            let self_last = unsafe { (*self_first).prev };
+
+            // SAFETY: We have exclusive access to both lists, so we can update the pointers.
+            // INVARIANT: This correctly sets the pointers to merge both lists. We do not need to
+            // update `self.first` because the first element of `self` does not change.
+            unsafe {
+                (*self_first).prev = other_last;
+                (*other_last).next = self_first;
+                (*self_last).next = other_first;
+                (*other_first).prev = self_last;
+            }
+        }
+
+        // INVARIANT: The other list is now empty, so update its pointer.
+        other.first = ptr::null_mut();
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> Default for List<T, ID> {
+    fn default() -> Self {
+        List::new()
+    }
+}
+
+impl<T: ?Sized + ListItem<ID>, const ID: u64> Drop for List<T, ID> {
+    fn drop(&mut self) {
+        while let Some(item) = self.pop_front() {
+            drop(item);
+        }
+    }
 }
diff --git a/rust/kernel/list/arc.rs b/rust/kernel/list/arc.rs
index c5921a7d5966..d801b9dc6291 100644
--- a/rust/kernel/list/arc.rs
+++ b/rust/kernel/list/arc.rs
@@ -133,8 +133,8 @@ fn try_new_list_arc(&self) -> bool {
 /// The `ListArc` type can be thought of as a special reference to a refcounted object that owns the
 /// permission to manipulate the `next`/`prev` pointers stored in the refcounted object. By ensuring
 /// that each object has only one `ListArc` reference, the owner of that reference is assured
-/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is inserted into a `List`, the
-/// `List` takes ownership of the `ListArc` reference.
+/// exclusive access to the `next`/`prev` pointers. When a `ListArc` is inserted into a [`List`],
+/// the [`List`] takes ownership of the `ListArc` reference.
 ///
 /// There are various strategies to ensuring that a value has only one `ListArc` reference. The
 /// simplest is to convert a [`UniqueArc`] into a `ListArc`. However, the refcounted object could
@@ -156,6 +156,8 @@ fn try_new_list_arc(&self) -> bool {
 ///
 /// * Each reference counted object has at most one `ListArc` for each value of `ID`.
 /// * The tracking inside `T` is aware that a `ListArc` reference exists.
+///
+/// [`List`]: crate::list::List
 #[repr(transparent)]
 pub struct ListArc<T, const ID: u64 = 0>
 where

-- 
2.46.0.76.ge559c4bf1a-goog


