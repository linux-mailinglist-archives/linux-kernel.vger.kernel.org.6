Return-Path: <linux-kernel+bounces-381772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0488A9B043B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85D4283A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9301D4604;
	Fri, 25 Oct 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQKJLNfl"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2B212178
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863425; cv=none; b=B6vYEBSEHHZ+PpD72q2f2FVxR89CLA+ll4JA9g3A63zWyb7i0C22DrMO2CWpBkkDizsObLcEkr7R+SCkJKiS84eZDOY69VrYwwvupdWcAx18GwVyFEjbFjqRA8g0HWc4NAE9AUMckkR3fb+4LLB+NxzhnLcZkQdIkXfp+XSFKQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863425; c=relaxed/simple;
	bh=9gY5q3ghk/LFg3fNaRQcmj16lb1Zt7PEwDLcyq7MfLc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T1+Qj0TsTwYgGHSiijEGsrqzT3P4etISvZpLf1QR7vBXQgmviBwvOK/q9pCF3m9ZuThYqkRfN5NcALRRUU1qdZqosO0QBzrTZBoEeNnYmRKTZjaVNo1/+S0NFfz1qEYTcplA6RLMMwL4vF4duAtRaiNdgfOO/30U7PDrRPhSxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQKJLNfl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43157cff1d1so14630125e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729863421; x=1730468221; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bsKmcbdbng+Ot/9g2bRkSU0+6hSqrVl48IwtXK6xYHw=;
        b=gQKJLNfl/nRgMzAhhS6zGhqtLZ3D0rBQAXWaPU8cwIdSHEqCjkn8OMPljUYpcEj5BQ
         IdoNdtaMlwKMUubcnC+C29ZZPxUximU9xO5ezuPFpHka3gByu79bkM/uu1jCq3VzgLLt
         zB5Crftzs5djs79JyflrG4RnE5gYEcFLOt3rWGpWwLMR40tRqruDMMcOyJ6Hod9BKvSY
         7i9v/5KvKTyCyX9CedLXiyLGgh1sizvzcN7ha2pjwUQSXJSiTotUATyhPYp46crZjRzF
         DpjmKzWVk9CwHZgvY8cH+22KQ9eJxjbnJnA8muABHW+qmuF1p6aiRXSRtIoaAtxP59MN
         yoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729863421; x=1730468221;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bsKmcbdbng+Ot/9g2bRkSU0+6hSqrVl48IwtXK6xYHw=;
        b=MP+jp8gPBDATx6L6WQrzBTjQ9yCZuab6gUX1EAphgrCslxLgAYEs+jFY9Gz4xaq/2l
         8vlblNLeKmc9XwlqvkV0kU46j5vn0cQndxROaSMMcVBskH4P9WCzFX6CALL8nisgr8Z+
         mTtKfybMdvc2nir5dnWWemv7BOtJa9h/FoLD1brHaxYZ58l4SdoYx3Ht7/s20bhR/H+c
         ireGpWezUXNCsBBHo8u4gQGxfPNKgA7wHkdrhmhxZdm1J/B7WUcF/gLNm427+x8g4MtE
         5h8EJtKsJA+BhZmmiCDaqb2uUacwbhiPQd5cYmhdiQmx4bshyYKunGs10Eu61fC8DMIl
         JTmA==
X-Forwarded-Encrypted: i=1; AJvYcCWhR6vhfaYJtFEjBsvmhZxn+x50b7ySdFVB/AogqcSFJQ7fGW7jHkGmBvwjFpT4insODONs38E6ar/p4FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbk0vLZrTqF2mBTJp7zLCb+y2cSMveRgyZ6ZwdWTPMvpL0JJnt
	Rprwi4NSQwau4ZqM59sn35e/nmgSNBaHxtqdetUI3zxP0hTsy6xzt0SERpnt78e2sa8LVbF1lfX
	DugVdGABLFW5Epg==
X-Google-Smtp-Source: AGHT+IFGaKc9BC1dPa+xw/K36/yFKcP63EktEDAnjAivv2n9eKf5rakqbxLSG8Zlx5tSlKVxiCI3DemrUIWZVRM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:4c94:b0:430:52b1:ae39 with SMTP
 id 5b1f17b1804b1-4318c75ad66mr185365e9.6.1729863420449; Fri, 25 Oct 2024
 06:37:00 -0700 (PDT)
Date: Fri, 25 Oct 2024 13:36:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=18108; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=9gY5q3ghk/LFg3fNaRQcmj16lb1Zt7PEwDLcyq7MfLc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnG569sGqgPsj3OqpcVqFAtrBNsXK8l2NvASm4m
 7JWKATjIsWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZxuevQAKCRAEWL7uWMY5
 Ru+gEACtPmac5cbnECfCQdlh6ckS69c5j3QaNtX6oxzEvhHjI1cn3N22kVHkLqTgWUidzHWl9ZH
 HWDWX0OzYmgkC2qx7kWT3YyHiBI8uRCEMrHPJEQ7BDOzTOQvqat1ebmTVOPMKjYZkQmwmqJ/Wcs
 quMXIfrzmjFORQIxRFcMVa2JYaEZPJWmj7nhA9wpMNp55fxdfN3jwkAcuJpSo3RJscYKfxQ7Vnj
 Scu2dRSpIoc2Kk/IPb3zUY3TehpOkXnU0eoi843MVqMDKUB8PYfT8Ggz6n9iGOnbhlImgbQcgq1
 2MMaEPYBkI2/pz8H7lCB6fuRAJY+1aYpPQZGteryTjXteViUWFM2zpyKFEO+YpT0VaNghkWCDBZ
 CG9kcqY4HRJZSnTitzhhprp9L6ni2t6xLv0+fslAWtZ2pjFHqMGnO88RNFFgAJISCPCambn9ur4
 Hf3SSqjNRQstcz3vWxFdm65NyrMS8RYX0xjK9C5Ie6IXlHHIDPNqAO000LgcOVtmHnWgjZZq/uj
 CHzJpofREqiFad8m4xciJZ1ZfzSGx3PLaW7jlEbVjXXy8uCg6yVwzt07ye4Sq0FMUK+esQAcvx8
 VnWGDWlUnbhv3/hoBIpgDzGImNxR96nbGtYsQ0t5nkm/4HmHuqR35mzNgvncxt1sU1aAx01egYi 4v2ZYqmbsdHP2NA==
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025-cursor-between-v1-1-08913714aae5@google.com>
Subject: [PATCH] rust: list: make the cursor point between elements
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

I've been using the linked list cursor for a few different things, and I
find it inconvenient to use because all of the functions have signatures
along the lines of `Self -> Option<Self>`. The root cause of these
signatures is that the cursor points *at* an element, rather than
*between* two elements.

Thus, change the cursor API to point between two elements. This is
inspired by the stdlib linked list (well, really by this guy [1]), which
also uses cursors that point between elements.

The `peek_*` methods returns a helper that lets you look at and
optionally remove the element, as one common use-case of cursors is to
iterate a list to look for an element, then remove that element.

Another advantage is that this means you can now have a cursor into an
empty list.

Link: https://rust-unofficial.github.io/too-many-lists/sixth-cursors-intro.html [1]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 325 +++++++++++++++++++++++++++++++-------------
 1 file changed, 231 insertions(+), 94 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fb93330f4af4..328d3e369d57 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -245,8 +245,20 @@ pub fn is_empty(&self) -> bool {
         self.first.is_null()
     }
 
-    /// Add the provided item to the back of the list.
-    pub fn push_back(&mut self, item: ListArc<T, ID>) {
+    /// Inserts `item` before `next` in the cycle.
+    ///
+    /// Returns a pointer to the newly inserted element. Never changes `self.first` unless the list
+    /// is empty.
+    ///
+    /// # Safety
+    ///
+    /// * `next` must be an element in this list or null.
+    /// * if `next` is null, then the list must be empty.
+    unsafe fn insert_inner(
+        &mut self,
+        item: ListArc<T, ID>,
+        next: *mut ListLinksFields,
+    ) -> *mut ListLinksFields {
         let raw_item = ListArc::into_raw(item);
         // SAFETY:
         // * We just got `raw_item` from a `ListArc`, so it's in an `Arc`.
@@ -259,16 +271,16 @@ pub fn push_back(&mut self, item: ListArc<T, ID>) {
         // SAFETY: We have not yet called `post_remove`, so `list_links` is still valid.
         let item = unsafe { ListLinks::fields(list_links) };
 
-        if self.first.is_null() {
-            self.first = item;
+        // Check if the list is empty.
+        if next.is_null() {
             // SAFETY: The caller just gave us ownership of these fields.
             // INVARIANT: A linked list with one item should be cyclic.
             unsafe {
                 (*item).next = item;
                 (*item).prev = item;
             }
+            self.first = item;
         } else {
-            let next = self.first;
             // SAFETY: By the type invariant, this pointer is valid or null. We just checked that
             // it's not null, so it must be valid.
             let prev = unsafe { (*next).prev };
@@ -282,45 +294,24 @@ pub fn push_back(&mut self, item: ListArc<T, ID>) {
                 (*next).prev = item;
             }
         }
+
+        item
     }
 
+    /// Add the provided item to the back of the list.
+    pub fn push_back(&mut self, item: ListArc<T, ID>) {
+        // SAFETY:
+        // * `self.first` is null or in the list.
+        // * `self.first` is only null if the list is empty.
+        unsafe { self.insert_inner(item, self.first) };
+    }
+
     /// Add the provided item to the front of the list.
     pub fn push_front(&mut self, item: ListArc<T, ID>) {
-        let raw_item = ListArc::into_raw(item);
-        // SAFETY:
-        // * We just got `raw_item` from a `ListArc`, so it's in an `Arc`.
-        // * If this requirement is violated, then the previous caller of `prepare_to_insert`
-        //   violated the safety requirement that they can't give up ownership of the `ListArc`
-        //   until they call `post_remove`.
-        // * We own the `ListArc`.
-        // * Removing items] from this list is always done using `remove_internal_inner`, which
-        //   calls `post_remove` before giving up ownership.
-        let list_links = unsafe { T::prepare_to_insert(raw_item) };
-        // SAFETY: We have not yet called `post_remove`, so `list_links` is still valid.
-        let item = unsafe { ListLinks::fields(list_links) };
-
-        if self.first.is_null() {
-            // SAFETY: The caller just gave us ownership of these fields.
-            // INVARIANT: A linked list with one item should be cyclic.
-            unsafe {
-                (*item).next = item;
-                (*item).prev = item;
-            }
-        } else {
-            let next = self.first;
-            // SAFETY: We just checked that `next` is non-null.
-            let prev = unsafe { (*next).prev };
-            // SAFETY: Pointers in a linked list are never dangling, and the caller just gave us
-            // ownership of the fields on `item`.
-            // INVARIANT: This correctly inserts `item` between `prev` and `next`.
-            unsafe {
-                (*item).next = next;
-                (*item).prev = prev;
-                (*prev).next = item;
-                (*next).prev = item;
-            }
-        }
-        self.first = item;
+        // SAFETY:
+        // * `self.first` is null or in the list.
+        // * `self.first` is only null if the list is empty.
+        self.first = unsafe { self.insert_inner(item, self.first) };
     }
 
     /// Removes the last item from this list.
@@ -489,17 +480,21 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
         other.first = ptr::null_mut();
     }
 
-    /// Returns a cursor to the first element of the list.
-    ///
-    /// If the list is empty, this returns `None`.
-    pub fn cursor_front(&mut self) -> Option<Cursor<'_, T, ID>> {
-        if self.first.is_null() {
-            None
-        } else {
-            Some(Cursor {
-                current: self.first,
-                list: self,
-            })
-        }
-    }
+    /// Returns a cursor that points before the first element of the list.
+    pub fn cursor_front(&mut self) -> Cursor<'_, T, ID> {
+        // INVARIANT: `self.first` is in this list.
+        Cursor {
+            next: self.first,
+            list: self,
+        }
+    }
+
+    /// Returns a cursor that points after the last element in the list.
+    pub fn cursor_back(&mut self) -> Cursor<'_, T, ID> {
+        // INVARIANT: `next` is allowed to be null.
+        Cursor {
+            next: core::ptr::null_mut(),
+            list: self,
+        }
+    }
 
@@ -579,69 +574,211 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
 
 /// A cursor into a [`List`].
 ///
+/// A cursor always rests between two elements in the list. This means that a cursor has a previous
+/// and next element, but no current element. It also means that it's possible to have a cursor
+/// into an empty list.
+///
 /// # Invariants
 ///
-/// The `current` pointer points a value in `list`.
+/// The `next` pointer is null or points a value in `list`.
 pub struct Cursor<'a, T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
-    current: *mut ListLinksFields,
     list: &'a mut List<T, ID>,
+    /// Points at the element after this cursor, or null if the cursor is after the last element.
+    next: *mut ListLinksFields,
 }
 
 impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> {
+    /// Returns a pointer to the element before the cursor.
+    ///
+    /// Returns null if there is no element before the cursor.
+    fn prev_ptr(&self) -> *mut ListLinksFields {
+        let mut next = self.next;
+        let first = self.list.first;
+        if next == first {
+            // We are before the first element.
+            return core::ptr::null_mut();
+        }
+
+        if next.is_null() {
+            // We are after the last element, so we need a pointer to the last element, which is
+            // the same as `(*first).prev`.
+            next = first;
+        }
+
+        // SAFETY: `next` can't be null, because then `first` must also be null, but in that case
+        // we would have exited at the `next == first` check. Thus, `next` is an element in the
+        // list, so we can access its `prev` pointer.
+        unsafe { (*next).prev }
+    }
+
-    /// Access the current element of this cursor.
-    pub fn current(&self) -> ArcBorrow<'_, T> {
-        // SAFETY: The `current` pointer points a value in the list.
-        let me = unsafe { T::view_value(ListLinks::from_fields(self.current)) };
-        // SAFETY:
-        // * All values in a list are stored in an `Arc`.
-        // * The value cannot be removed from the list for the duration of the lifetime annotated
-        //   on the returned `ArcBorrow`, because removing it from the list would require mutable
-        //   access to the cursor or the list. However, the `ArcBorrow` holds an immutable borrow
-        //   on the cursor, which in turn holds a mutable borrow on the list, so any such
-        //   mutable access requires first releasing the immutable borrow on the cursor.
-        // * Values in a list never have a `UniqueArc` reference, because the list has a `ListArc`
-        //   reference, and `UniqueArc` references must be unique.
-        unsafe { ArcBorrow::from_raw(me) }
-    }
+    /// Access the element after this cursor.
+    pub fn peek_next(&mut self) -> Option<CursorPeek<'_, 'a, T, true, ID>> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        // INVARIANT:
+        // * We just checked that `self.next` is non-null, so it must be in `self.list`.
+        // * `ptr` is equal to `self.next`.
+        Some(CursorPeek {
+            ptr: self.next,
+            cursor: self,
+        })
+    }
+
+    /// Access the element before this cursor.
+    pub fn peek_prev(&mut self) -> Option<CursorPeek<'_, 'a, T, false, ID>> {
+        let prev = self.prev_ptr();
+
+        if prev.is_null() {
+            return None;
+        }
+
+        // INVARIANT:
+        // * We just checked that `prev` is non-null, so it must be in `self.list`.
+        // * `self.prev_ptr()` never returns `self.next`.
+        Some(CursorPeek {
+            ptr: prev,
+            cursor: self,
+        })
+    }
 
-    /// Move the cursor to the next element.
-    pub fn next(self) -> Option<Cursor<'a, T, ID>> {
-        // SAFETY: The `current` field is always in a list.
-        let next = unsafe { (*self.current).next };
-
-        if next == self.list.first {
-            None
-        } else {
-            // INVARIANT: Since `self.current` is in the `list`, its `next` pointer is also in the
-            // `list`.
-            Some(Cursor {
-                current: next,
-                list: self.list,
-            })
-        }
-    }
+    /// Move the cursor one element forward.
+    ///
+    /// If the cursor is after the last element, then the cursor will move back to the beginning.
+    pub fn move_next(&mut self) {
+        if self.next.is_null() {
+            // INVARIANT: `list.first` is in the list or null.
+            self.next = self.list.first;
+            return;
+        }
+
+        // SAFETY: `self.next` is an element in the list and we borrow the list mutably, so we can
+        // access the `next` field.
+        let mut next = unsafe { (*self.next).next };
+
+        if next == self.list.first {
+            next = core::ptr::null_mut();
+        }
+
+        // INVARIANT: `next` is either null or the next element after an element in the list.
+        self.next = next;
+    }
 
-    /// Move the cursor to the previous element.
-    pub fn prev(self) -> Option<Cursor<'a, T, ID>> {
-        // SAFETY: The `current` field is always in a list.
-        let prev = unsafe { (*self.current).prev };
-
-        if self.current == self.list.first {
-            None
-        } else {
-            // INVARIANT: Since `self.current` is in the `list`, its `prev` pointer is also in the
-            // `list`.
-            Some(Cursor {
-                current: prev,
-                list: self.list,
-            })
-        }
-    }
+    /// Move the cursor one element backwards.
+    ///
+    /// If the cursor is before the first element, then the cursor will move to the end of the
+    /// list.
+    pub fn move_prev(&mut self) {
+        if self.next == self.list.first {
+            // We are before the first element, so move the cursor after the last element.
+            // INVARIANT: `next` can be a null pointer.
+            self.next = core::ptr::null_mut();
+            return;
+        }
+
+        // INVARIANT: `prev_ptr()` always returns a pointer that is null or in the list.
+        self.next = self.prev_ptr();
+    }
+
+    /// Inserts an element where the cursor is pointing and get a pointer to the new element.
+    fn insert_inner(&mut self, item: ListArc<T, ID>) -> *mut ListLinksFields {
+        let ptr = if self.next.is_null() {
+            self.list.first
+        } else {
+            self.next
+        };
+        // SAFETY:
+        // * `ptr` is an element in the list or null.
+        // * if `ptr` is null, then `self.list.first` is null so the list is empty.
+        unsafe { self.list.insert_inner(item, ptr) }
+    }
+
+    /// Inserts an element after this cursor.
+    pub fn insert_next(&mut self, item: ListArc<T, ID>) {
+        self.next = self.insert_inner(item);
+    }
+
+    /// Inserts an element before this cursor.
+    pub fn insert_prev(&mut self, item: ListArc<T, ID>) {
+        self.insert_inner(item);
+    }
 
-    /// Remove the current element from the list.
-    pub fn remove(self) -> ListArc<T, ID> {
-        // SAFETY: The `current` pointer always points at a member of the list.
-        unsafe { self.list.remove_internal(self.current) }
-    }
+    /// Remove the next element from the list.
+    pub fn remove_next(&mut self) -> Option<ListArc<T, ID>> {
+        self.peek_next().map(|v| v.remove())
+    }
+
+    /// Remove the previous element from the list.
+    pub fn remove_prev(&mut self) -> Option<ListArc<T, ID>> {
+        self.peek_prev().map(|v| v.remove())
+    }
 }
+
+/// References the element in the list next to the cursor.
+///
+/// # Invariants
+///
+/// * `ptr` is an element in `self.cursor.list`.
+/// * `ISNEXT == (self.ptr == self.cursor.next)`.
+pub struct CursorPeek<'a, 'b, T: ?Sized + ListItem<ID>, const ISNEXT: bool, const ID: u64> {
+    cursor: &'a mut Cursor<'b, T, ID>,
+    ptr: *mut ListLinksFields,
+}
+
+impl<'a, 'b, T: ?Sized + ListItem<ID>, const ISNEXT: bool, const ID: u64>
+    CursorPeek<'a, 'b, T, ISNEXT, ID>
+{
+    /// Remove the element from the list.
+    pub fn remove(self) -> ListArc<T, ID> {
+        if ISNEXT {
+            self.cursor.move_next();
+        }
+
+        // INVARIANT: `self.ptr` is not equal to `self.cursor.next` due to the above `move_next`
+        // call.
+        // SAFETY: By the type invariants of `Self`, `next` is not null, so `next` is an element of
+        // `self.cursor.list` by the type invariants of `Cursor`.
+        unsafe { self.cursor.list.remove_internal(self.ptr) }
+    }
+
+    /// Access this value as an [`ArcBorrow`].
+    pub fn arc(&self) -> ArcBorrow<'_, T> {
+        // SAFETY: `self.ptr` points at an element in `self.cursor.list`.
+        let me = unsafe { T::view_value(ListLinks::from_fields(self.ptr)) };
+        // SAFETY:
+        // * All values in a list are stored in an `Arc`.
+        // * The value cannot be removed from the list for the duration of the lifetime annotated
+        //   on the returned `ArcBorrow`, because removing it from the list would require mutable
+        //   access to the `CursorPeek`, the `Cursor` or the `List`. However, the `ArcBorrow` holds
+        //   an immutable borrow on the `CursorPeek`, which in turn holds a mutable borrow on the
+        //   `Cursor`, which in turn holds a mutable borrow on the `List`, so any such mutable
+        //   access requires first releasing the immutable borrow on the `CursorPeek`.
+        // * Values in a list never have a `UniqueArc` reference, because the list has a `ListArc`
+        //   reference, and `UniqueArc` references must be unique.
+        unsafe { ArcBorrow::from_raw(me) }
+    }
+}
+
+impl<'a, 'b, T: ?Sized + ListItem<ID>, const ISNEXT: bool, const ID: u64> core::ops::Deref
+    for CursorPeek<'a, 'b, T, ISNEXT, ID>
+{
+    // This can't use `ArcBorrow<'a, T>` as the target type because 'a is too long. It would let
+    // you obtain an `ArcBorrow<'a, T>` and then call `CursorPeek::remove` without giving up the
+    // `ArcBorrow<'a, T>`.
+    type Target = T;
+
+    fn deref(&self) -> &T {
+        // SAFETY: `self.ptr` points at an element in `self.cursor.list`.
+        let me = unsafe { T::view_value(ListLinks::from_fields(self.cursor.next)) };
+
+        // SAFETY: The value cannot be removed from the list for the duration of the lifetime
+        // annotated on the returned `&T`, because removing it from the list would require mutable
+        // access to the `CursorPeek`, the `Cursor` or the `List`. However, the `&T` holds an
+        // immutable borrow on the `CursorPeek`, which in turn holds a mutable borrow on the
+        // `Cursor`, which in turn holds a mutable borrow on the `List`, so any such mutable access
+        // requires first releasing the immutable borrow on the `CursorPeek`.
+        unsafe { &*me }
+    }
+}
 
---
base-commit: 6ce162a002657910104c7a07fb50017681bc476c
change-id: 20241016-cursor-between-154bed859e27

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


