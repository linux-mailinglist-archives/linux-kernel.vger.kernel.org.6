Return-Path: <linux-kernel+bounces-259748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55436939C90
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79E41F22B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F715098A;
	Tue, 23 Jul 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSLKxPPS"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534814F9DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721722999; cv=none; b=aWf/Qs2+9a8nURq/9PzN9x/V0zb88bbSn1P4yJPdip2artoUoea62NdZcwIl1PXmRkUoOasw6SWCDKuHMmQIcSteWO16jGfVw8SoCZwQZwJYxDCGEgUuC6VUoVCr1Xc2BB7Mjau6+r2pwWvRwgQu3boZd2hHyTD8jWIBnJMXpqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721722999; c=relaxed/simple;
	bh=DGiNcxmXnBX8XeaW9TQmBXqeb7hhSkPo8/+cGCJC2TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A6Y7JqRLoTC2qBUvhFGIktvjgW2Bl50Lz9F2iyzbL3saQmIa6vy15a5UYa9SV8T8hBWcUXNbQnHnKrQ5nVvFKyhk3pYD6OHboXsfFRKnX92grzedVykNx3DTt1Ok1dQg/wtxpiTi4UdTAEbkKKrV+SosbnfDWjw3EfXl883Cz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSLKxPPS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05ec8921fdso11210921276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721722996; x=1722327796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=29r0gIPhUnZ5mBg155qsbH5Qt/QtLWdfTj/Q5hfndv8=;
        b=XSLKxPPSWL4z77pewFKUxWmDmH2KJuQnJmGl+5H06oWMF6fVGm0/07YZi3qWPvrnX+
         DXdX/+DehgsE31BmjVi8YdYzIxw+6jPoHAQNyjLeA/x++SNBppKVsu4BlhozO6/2xEen
         Zc6FockSsuM4uqpGRwB38XZFxJ4EavKfdqw+yQ/GH5IVd4BWc7P50bxbbtfUnFKK1afk
         P5VsRw9NwRZQl8q3wMPtSkMG3I8JcmOsn6h74D+2Jkgg69Nouhz7+e057IlBgFkCIOoi
         Yby8Bzyt/7mYwpN+CZvU1VsFwKC6lVwT4UVXzjgXhMZXn045CqQ6ltKlQKBpnSzgtyy7
         w7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721722996; x=1722327796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29r0gIPhUnZ5mBg155qsbH5Qt/QtLWdfTj/Q5hfndv8=;
        b=DYUCh32CjrF+2z7au7SQrMyGRMXYQjJmXTL5WXi94tobFK8iu0bBL4G4sdqvpLU5zr
         CXb37neNrr002jpieAH9Ks1rhFbohxDVt/UM5u5PQgwUDDiwgGp7u1FWHHUQFB6NbnQU
         UgSj7HcCWGmRcJ6lLiC+smNg4brR46dQIdsZAqDWwBbcPLCnhHlX+9GllrbeYquRmTzE
         eVzAcid5wn4DJGEfP2idePGqh7P/Oc8XDATPPmx8J1h/39yoZJi5ZLtIGTNk6Aol36Ce
         wZfb371sycC7Tl78QfCMgY/8fNSJ9mdX5qYy9mUbBYeG3d0nvBhkVScJFMUB/ksDwIP1
         HTVw==
X-Forwarded-Encrypted: i=1; AJvYcCUtCBsEp9SXrAwF9isYScoZPF2zuPZGyY8xpuaU0rz1wTqZ4ru5M0bKFH3thUrM94pDkaw9KxD/gOxxJ9L3+PL5Yq1+0XW161ND6k/s
X-Gm-Message-State: AOJu0YwUvapZY8Ucx68s29nJirbiBOjgDC63AxyE8El5TeCQYiEea2Gj
	EGfEx2pbukvq0Hk0MHOmIIYcL+5tqYUNot7AIhtzxWEJz4JcvFpYM4BUrOyykQrjOs6o/++Jagf
	QCKV452wGp9CCvg==
X-Google-Smtp-Source: AGHT+IEORvPmcAry+mHuiowBlcK1a5jUA94sbmV2u66xPv16mNcweTtcSgMGB+a3ZAMoz2oR3mgOLF1mDnSqRBM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:8007:0:b0:e08:664c:dd1f with SMTP id
 3f1490d57ef6-e087045b23dmr26333276.12.1721722995934; Tue, 23 Jul 2024
 01:23:15 -0700 (PDT)
Date: Tue, 23 Jul 2024 08:22:09 +0000
In-Reply-To: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5335; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=DGiNcxmXnBX8XeaW9TQmBXqeb7hhSkPo8/+cGCJC2TY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmn2hWHg2ZCJ1/EurYZ0A7P8kK1WXe4nRKxBbRm
 lAcFUe9Nx6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZp9oVgAKCRAEWL7uWMY5
 RrKdD/43jX1KVxMIuuvSWTNjwbZzJ8ks8rU6pLxe5r1N3qgjP9/jEYTZfn+5bp8eMJr6Ym4mned
 ECCI+N6Mh44A/MPNIka2JsyVK3urZNj+PAwp9yyDb9DscJUiEtozN71jrLGepAk82QSmAgP907T
 3ke84jwLNV18qsTaap6XRf5Z9/XtaCAHTfbbr83vjjEkFUlqao/OnqhB6/DsLIZe0tXe3Png+nR
 928INYXcNPPipzkPTDei+bt/hMSdgEMRgG/srv0oehSawgUDJgw7sscLSqHV+SHYx/u9vJ2BKk0
 cNqEyNtEfmYPQjusrt/wwfkG26GRtMBz5qq+rd9sPSIJOiDB7Mh1ye3USz7GuXPeZT024eeaFzX
 uzDozFxNFJNHXcvlwWplHdn5SohePyEH5JcNDT/j6DAuvQdYEvUhRpg2SePyGvVN4QTQfO5kIRZ
 1T0ykWHYqi3dJkHO8w6rDSxqHQ44P6BBl71WquWx5hD1qmz3iJHf10f2eyfgpDoNkiP8pVCJQcl
 un2oY/OTk2VUNDcrePXVzes7IT1AOnalveDgsaE97iMhcgrGQ2gE/hax3VqjkMnMCB/iveLlAST
 PwlY8HQntsgm42mgmpYnKrUbAIOZqC+muGjO1CXMS9Hq6ohg3O9dKExaMMURlvptGGYgZKuTPqR X2BqtcFi6RlQUpQ==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240723-linked-list-v3-8-89db92c7dbf4@google.com>
Subject: [PATCH v3 08/10] rust: list: add cursor
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

The cursor is very similar to the list iterator, but it has one
important feature that the iterator doesn't: it can be used to remove
items from the linked list.

This feature cannot be added to the iterator because the references you
get from the iterator are considered borrows of the original list,
rather than borrows of the iterator. This means that there's no way to
prevent code like this:

let item = iter.next();
iter.remove();
use(item);

If `iter` was a cursor instead of an iterator, then `item` will be
considered a borrow of `iter`. Since `remove` destroys `iter`, this
means that the borrow-checker will prevent uses of `item` after the call
to `remove`.

So there is a trade-off between supporting use in traditional for loops,
and supporting removal of elements as you iterate. Iterators and cursors
represents two different choices on that spectrum.

Rust Binder needs cursors for the list of death notifications that a
process is currently handling. When userspace tells Binder that it has
finished processing the death notification, Binder will iterate the list
to search for the relevant item and remove it.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/list.rs | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index e320da063c07..f36e17369382 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -439,6 +439,20 @@ pub fn push_all_back(&mut self, other: &mut List<T, ID>) {
         other.first = ptr::null_mut();
     }
 
+    /// Returns a cursor to the first element of the list.
+    ///
+    /// If the list is empty, this returns `None`.
+    pub fn cursor_front(&mut self) -> Option<Cursor<'_, T, ID>> {
+        if self.first.is_null() {
+            None
+        } else {
+            Some(Cursor {
+                current: self.first,
+                list: self,
+            })
+        }
+    }
+
     /// Creates an iterator over the list.
     pub fn iter(&self) -> Iter<'_, T, ID> {
         // INVARIANT: If the list is empty, both pointers are null. Otherwise, both pointers point
@@ -513,6 +527,74 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
     }
 }
 
+/// A cursor into a [`List`].
+///
+/// # Invariants
+///
+/// The `current` pointer points a value in `list`.
+pub struct Cursor<'a, T: ?Sized + ListItem<ID>, const ID: u64 = 0> {
+    current: *mut ListLinksFields,
+    list: &'a mut List<T, ID>,
+}
+
+impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> Cursor<'a, T, ID> {
+    /// Access the current element of this cursor.
+    pub fn current(&self) -> ArcBorrow<'_, T> {
+        // SAFETY: The `current` pointer points a value in the list.
+        let me = unsafe { T::view_value(ListLinks::from_fields(self.current)) };
+        // SAFETY:
+        // * All values in a list are stored in an `Arc`.
+        // * The value cannot be removed from the list for the duration of the lifetime annotated
+        //   on the returned `ArcBorrow`, because removing it from the list would require mutable
+        //   access to the cursor or the list. However, the `ArcBorrow` holds an immutable borrow
+        //   on the cursor, which in turn holds a mutable borrow on the list, so any such
+        //   mutable access requires first releasing the immutable borrow on the cursor.
+        // * Values in a list never have a `UniqueArc` reference, because the list has a `ListArc`
+        //   reference, and `UniqueArc` references must be unique.
+        unsafe { ArcBorrow::from_raw(me) }
+    }
+
+    /// Move the cursor to the next element.
+    pub fn next(self) -> Option<Cursor<'a, T, ID>> {
+        // SAFETY: The `current` field is always in a list.
+        let next = unsafe { (*self.current).next };
+
+        if next == self.list.first {
+            None
+        } else {
+            // INVARIANT: Since `self.current` is in the `list`, its `next` pointer is also in the
+            // `list`.
+            Some(Cursor {
+                current: next,
+                list: self.list,
+            })
+        }
+    }
+
+    /// Move the cursor to the previous element.
+    pub fn prev(self) -> Option<Cursor<'a, T, ID>> {
+        // SAFETY: The `current` field is always in a list.
+        let prev = unsafe { (*self.current).prev };
+
+        if self.current == self.list.first {
+            None
+        } else {
+            // INVARIANT: Since `self.current` is in the `list`, its `prev` pointer is also in the
+            // `list`.
+            Some(Cursor {
+                current: prev,
+                list: self.list,
+            })
+        }
+    }
+
+    /// Remove the current element from the list.
+    pub fn remove(self) -> ListArc<T, ID> {
+        // SAFETY: The `current` pointer always points at a member of the list.
+        unsafe { self.list.remove_internal(self.current) }
+    }
+}
+
 impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> FusedIterator for Iter<'a, T, ID> {}
 
 impl<'a, T: ?Sized + ListItem<ID>, const ID: u64> IntoIterator for &'a List<T, ID> {

-- 
2.45.2.1089.g2a221341d9-goog


