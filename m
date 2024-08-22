Return-Path: <linux-kernel+bounces-297659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E8195BC16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AB21F21EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345231CE6FC;
	Thu, 22 Aug 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Xby0inC"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE41CDA2A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344687; cv=none; b=mW+zZfk0KNt2GywL6MUipI3RyP88UuxYFl2L9WBbWILLOzt0VLwsAWwhwFvWZalGiM3aoWkzTq3hdJJ0atv7kOmve6zz8wOjC4IUaKyEP0CA15EL/J/JiPC1AvbCbTE7JesrY3C/urbRf2xPwPw+oZKjbV6B8C05bh0qNsBeVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344687; c=relaxed/simple;
	bh=CHEPUnEo1ublThVvZv27KVkUnXnCL42Vbhba4e3iR0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKioQb6bWf3JMH+9TUvse8TJI4oLPOCm6c4Uf2X5cdxM+lVSxk/LgVEHNdWTk8XObggYgG0km3jXg8CasP736VODshlDJMbwvWNeuqJQ33eBT/hvth/vxbPDWclItvOCcsNCfav2GaMmLtN28oJTQrEhhJpF+VQhka4QAQeEqok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Xby0inC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1653c8a32eso1644835276.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724344683; x=1724949483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/j9j1rbxZpBdi5oEplcJiifVcCwTYu4oYwyR+PLoz+E=;
        b=4Xby0inC9CROxN8/H2N6j8oSyRhf76C8RTrWUKoz+5a/uMMSBK/33CQqRv3zxvf52W
         5nIIGXJhQ9UPwc/m7TMfsPr1ZfzLf9ep7DM+2CVYTKr5S17ZjryL5oS1AYsoMjpfxfcx
         yefaPoTTxnWSah/azDG6xAGEFMIx4fVwJgNAOghCmITVlwwf5DB1Ux4l0w5nuNAcQ5UD
         vY+tsWlrflRNrNn8QqJagBaic/CmG2XMgzFJGml1QaTPRYr+aRCJRocFZNsOrNUmXriu
         njVqNv3ppn31Vi/PFOm1XSGE/gc1KF0j26Txv2XAtgWl/6lbHIYMUJdQYj9znvgD7kE9
         SaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344683; x=1724949483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/j9j1rbxZpBdi5oEplcJiifVcCwTYu4oYwyR+PLoz+E=;
        b=mjj5A8acEbuC23bexWPK2GEzoXahzwx8pcTXjlwAlG+VSzJhmuvNRbHoS4czPBUWEd
         /L8JuRzd9dKGpNVXZrKygsYn2i+rZHMUjFsGqxnH7HwKiskDiOlMgXxLoxrHP9i4CBiF
         is82t3EXaMwVv0vP7yVbjr9K98Q7a9REgTDGVhYRT8BAT4204tuG7WxlvLt/Ee710Gp4
         g4b5S5N9/1LhgknzyXYgM0WmDLKSLpAC2IuyD4DYzVktwHp8G8JQQqT4cKV8afIR2lQg
         Z81VRvxfvhGvabPlm1RI6RPQrAa7bN1cpPkuZIffHBFAL9CPsPj1mG8cDGR+W7775nZb
         8NnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhSO/xPqN6YnRGeJMr9bkw9ZD1yLTEfuZhfvoilrEGXh7tcbKwsBghg9hS5jSE0rjMSP9xag9Uze5X4Is=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOfreC6RnxRvtTrQ+mR/AonXCvbK9gvdfgVG3lCb4H7Jo6+WI
	+pbGJk8aH+7DxvI3Pxt6BqpDHGQMWVD+dYHshOD/Kd9YSd/Ke+X0+lVReJHROKpgB73I5icajvI
	BnWJ70ltg1zOdbHxZoFVhjSSKyw==
X-Google-Smtp-Source: AGHT+IGVt5PpJ0FznyUHRjkqyMLSJdpcH7tywDb/fsIlyRnaTGNjWbLMhIZRmp4Q/xBghf0C3a2e2PgsKQnDV6I6gXo=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a5b:60a:0:b0:e0b:ab63:b9c8 with SMTP
 id 3f1490d57ef6-e17a4521d12mr76276.11.1724344683085; Thu, 22 Aug 2024
 09:38:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:37:55 +0000
In-Reply-To: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240822-b4-rbtree-v12-3-014561758a57@google.com>
Subject: [PATCH v12 3/5] rust: rbtree: add mutable iterator
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 103 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 29e7a0795266..399ace4e1949 100644
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
@@ -434,21 +455,75 @@ unsafe impl<'a, K: Sync, V: Sync> Sync for Iter<'a, K, V> {}
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
+        let cur = unsafe { container_of!(self.next, Node<K, V>, links) }.cast_mut();
 
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


