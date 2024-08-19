Return-Path: <linux-kernel+bounces-292348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383FE956E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86443B25190
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8267D17B4ED;
	Mon, 19 Aug 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WjSglrrd"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A520C176249
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080051; cv=none; b=X/yKh0uFcqc+QcVQHgX7sIvpSObHsLAX6B2L2jg3FOZ0BBfg9bVFOt6cigXGu0EgHGJqqXzjD/lLxRskKmyBYMuK/n2gj9yjiXDwMefre0j5rjrC3t12FREmilV5Cmktys4aZWI1J/ZlXLUipDnrx+DOJ8Pz7ZmiCs2QkJEoV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080051; c=relaxed/simple;
	bh=bY3uwhAdqdUeCxk8YovfoOJpj6gAoBiYhX2fhlfpqY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IIzB2bx0fAV3ZwwPFeJjOsaU1/9iXGBh1lzuHFxGO0NQdesfuDuG4Dp56i32alnGd7p0lno4YFX4MsItP1I+Myjqsgv2Kxnqm1VPl5d6pgzlInhAEo2CPaJ5uIVlfUwY1JuOHbGM925WgX9hGKkdwZgwI/+mJz3q5Sr188jnJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WjSglrrd; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e11368fa2e3so7361548276.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080048; x=1724684848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=85UzCaGowEZwuxuV5kMmpUWk+b/7cJAuTQ/iw0RGtwQ=;
        b=WjSglrrdJh0RgybG9eq5NNUr1dpugvRsJYWfbFeBxQdyBw3Oo6ecVLPfJ3V62NxnQS
         mrF38w5JL89Dzd6fNkPrkqLY2SkQUempfnJbxWJ9Fltm5tr5zW60YS5VIbz4MpntQvdv
         4iFuexFw8j9ZqXXXdmtpDxaNPgI/PntNtRnUp8j6s7gmLPrC5KrQx0XblIWSi0Sq1i6B
         vsyfetTUzTgKJXm/XhpiOi3PtEw/iZ1V+QMCVd+EJPYfBGjP5WkVY7mq4vXOX7i2wqju
         B/3P90qVSk4lvHdplrwFBWX9sW/i1m2Q1FNBoPUVQajTNlvMcdfoY5/VhhBUxYFDiVjJ
         3F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080048; x=1724684848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85UzCaGowEZwuxuV5kMmpUWk+b/7cJAuTQ/iw0RGtwQ=;
        b=i/f4JMBT2yCh3v+78WvQKXK0/d6XBHz7kZnwq2UFA3VSJmbKqa9/A6xaY34xAEOrun
         fDIV3E333JUvSdaZ53dEOglFgk+efU7Zb4zV0/fa79+ypqIzQ8wqsEQ1g81zUJ1jZcUU
         1xXFK7DdKKiV33vPd9OksUzlTSiWcyeDlKr2FihK43v8Y7rL6d57itp+Tly6W4hqBnb2
         wKkvL5d3ssj14J0tzAt8lOSAo2/cxwU6JiwUkLpRANQJT9oQraUKHYT2R14D37ob1g6T
         Ggvd9llsscMPKX49pXQgT8/FlLx2RInYyD6QxDtquB3Gujl2XPg3BmT6MFDCuHNZwsfc
         hpBw==
X-Forwarded-Encrypted: i=1; AJvYcCWxqkUbC3AR3P3YhrTeVxIDAstwLD1hG3YqttGPpGWO5CC6GLPxsmJMdFrRO3DBA6gJhdzWTn1ohz5h/gLb8JtcvsDAgHwuuR+030x1
X-Gm-Message-State: AOJu0YwF8Lgpxm0yxKWQ9xTcf9hKseHXYyhkvShxHnIjBXJvCxgmb8bA
	zSqoU3sqXMo4pG1g5Be8rb9VJL67OfcNj7OICNZ0509dwuAY1ok8LvlY2F0isxe+f4qtCDjz5Qa
	rOYEmD6der87faAkLtZlfSG5xTw==
X-Google-Smtp-Source: AGHT+IH0pNDpzwpu3UuDXN/wj6kQ1ChIbzTzqX9g7z2VYmIU2cDLMj5JmJ33g+U/No06uNi+RVR5rWt69vBUGSO54SU=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:4ad:b0:e11:5f87:1e3c with
 SMTP id 3f1490d57ef6-e1180f8aef5mr172016276.11.1724080048491; Mon, 19 Aug
 2024 08:07:28 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:07:11 +0000
In-Reply-To: <20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240819-b4-rbtree-v10-3-3b3b2c4d73af@google.com>
Subject: [PATCH v10 3/5] rust: rbtree: add mutable iterator
From: Matt Gilbride <mattgilbride@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, 
	Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Add mutable Iterator implementation for `RBTree`,
allowing iteration over (key, value) pairs in key order. Only values are
mutable, as mutating keys implies modifying a node's position in the tree.

Mutable iteration is used by the binder driver during shutdown to
clean up the tree maintained by the "range allocator" [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 104 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 90 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 29e7a0795266..6c9a8f0a00e6 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -12,7 +12,7 @@
     cmp::{Ord, Ordering},
     marker::PhantomData,
     mem::MaybeUninit,
-    ptr::{addr_of_mut, NonNull},
+    ptr::{addr_of_mut, from_mut, NonNull},
 };
 
 /// A red-black tree with owned nodes.
@@ -194,11 +194,31 @@ pub fn new() -> Self {
 
     /// Returns an iterator over the tree nodes, sorted by key.
     pub fn iter(&self) -> Iter<'_, K, V> {
-        // INVARIANT: `bindings::rb_first` returns a valid pointer to a tree node given a valid pointer to a tree root.
         Iter {
             _tree: PhantomData,
-            // SAFETY: `self.root` is a valid pointer to the tree root.
-            next: unsafe { bindings::rb_first(&self.root) },
+            // INVARIANT:
+            //   - `self.root` is a valid pointer to a tree root.
+            //   - `bindings::rb_first` produces a valid pointer to a node given `root` is valid.
+            iter_raw: IterRaw {
+                // SAFETY: by the invariants, all pointers are valid.
+                next: unsafe { bindings::rb_first(&self.root) },
+                _phantom: PhantomData,
+            },
+        }
+    }
+
+    /// Returns a mutable iterator over the tree nodes, sorted by key.
+    pub fn iter_mut(&mut self) -> IterMut<'_, K, V> {
+        IterMut {
+            _tree: PhantomData,
+            // INVARIANT:
+            //   - `self.root` is a valid pointer to a tree root.
+            //   - `bindings::rb_first` produces a valid pointer to a node given `root` is valid.
+            iter_raw: IterRaw {
+                // SAFETY: by the invariants, all pointers are valid.
+                next: unsafe { bindings::rb_first(from_mut(&mut self.root)) },
+                _phantom: PhantomData,
+            },
         }
     }
 
@@ -211,6 +231,11 @@ pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
     pub fn values(&self) -> impl Iterator<Item = &'_ V> {
         self.iter().map(|(_, v)| v)
     }
+
+    /// Returns a mutable iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
+        self.iter_mut().map(|(_, v)| v)
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -414,13 +439,9 @@ fn into_iter(self) -> Self::IntoIter {
 /// An iterator over the nodes of a [`RBTree`].
 ///
 /// Instances are created by calling [`RBTree::iter`].
-///
-/// # Invariants
-/// - `self.next` is a valid pointer.
-/// - `self.next` points to a node stored inside of a valid `RBTree`.
 pub struct Iter<'a, K, V> {
     _tree: PhantomData<&'a RBTree<K, V>>,
-    next: *mut bindings::rb_node,
+    iter_raw: IterRaw<K, V>,
 }
 
 // SAFETY: The [`Iter`] gives out immutable references to K and V, so it has the same
@@ -434,21 +455,76 @@ unsafe impl<'a, K: Sync, V: Sync> Sync for Iter<'a, K, V> {}
 impl<'a, K, V> Iterator for Iter<'a, K, V> {
     type Item = (&'a K, &'a V);
 
+    fn next(&mut self) -> Option<Self::Item> {
+        // SAFETY: Due to `self._tree`, `k` and `v` are valid for the lifetime of `'a`.
+        self.iter_raw.next().map(|(k, v)| unsafe { (&*k, &*v) })
+    }
+}
+
+impl<'a, K, V> IntoIterator for &'a mut RBTree<K, V> {
+    type Item = (&'a K, &'a mut V);
+    type IntoIter = IterMut<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter_mut()
+    }
+}
+
+/// A mutable iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter_mut`].
+pub struct IterMut<'a, K, V> {
+    _tree: PhantomData<&'a mut RBTree<K, V>>,
+    iter_raw: IterRaw<K, V>,
+}
+
+// SAFETY: The [`IterMut`] has exclusive access to both `K` and `V`, so it is sufficient to require them to be `Send`.
+// The iterator only gives out immutable references to the keys, but since the iterator has excusive access to those same
+// keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the user.
+unsafe impl<'a, K: Send, V: Send> Send for IterMut<'a, K, V> {}
+
+// SAFETY: The [`IterMut`] gives out immutable references to K and mutable references to V, so it has the same
+// thread safety requirements as mutable references.
+unsafe impl<'a, K: Sync, V: Sync> Sync for IterMut<'a, K, V> {}
+
+impl<'a, K, V> Iterator for IterMut<'a, K, V> {
+    type Item = (&'a K, &'a mut V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        self.iter_raw.next().map(|(k, v)|
+            // SAFETY: Due to `&mut self`, we have exclusive access to `k` and `v`, for the lifetime of `'a`.
+            unsafe { (&*k, &mut *v) })
+    }
+}
+
+/// A raw iterator over the nodes of a [`RBTree`].
+///
+/// # Invariants
+/// - `self.next` is a valid pointer.
+/// - `self.next` points to a node stored inside of a valid `RBTree`.
+struct IterRaw<K, V> {
+    next: *mut bindings::rb_node,
+    _phantom: PhantomData<fn() -> (K, V)>,
+}
+
+impl<K, V> Iterator for IterRaw<K, V> {
+    type Item = (*mut K, *mut V);
+
     fn next(&mut self) -> Option<Self::Item> {
         if self.next.is_null() {
             return None;
         }
 
-        // SAFETY: By the type invariant of `Iter`, `self.next` is a valid node in an `RBTree`,
+        // SAFETY: By the type invariant of `IterRaw`, `self.next` is a valid node in an `RBTree`,
         // and by the type invariant of `RBTree`, all nodes point to the links field of `Node<K, V>` objects.
-        let cur = unsafe { container_of!(self.next, Node<K, V>, links) };
+        let cur: *mut Node<K, V> =
+            unsafe { container_of!(self.next, Node<K, V>, links) }.cast_mut();
 
         // SAFETY: `self.next` is a valid tree node by the type invariants.
         self.next = unsafe { bindings::rb_next(self.next) };
 
-        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
-        // it is ok to return a reference to members because the iterator must outlive it.
-        Some(unsafe { (&(*cur).key, &(*cur).value) })
+        // SAFETY: By the same reasoning above, it is safe to dereference the node.
+        Some(unsafe { (addr_of_mut!((*cur).key), addr_of_mut!((*cur).value)) })
     }
 }
 

-- 
2.46.0.184.g6999bdac58-goog


