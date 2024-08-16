Return-Path: <linux-kernel+bounces-290308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E497B955207
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF4C286791
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875CB1C7B71;
	Fri, 16 Aug 2024 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V6LYW95j"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6F1C57AA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841289; cv=none; b=YnAjxTcPR//0MD+WDybdTeIRZHaCB8DAPr6v+Wv7iBUKiZUrnkVPY/ehQFLon6OEcoMdRKyylS/rKPJquCWbm/9f98F/H8mZdV+cT5ZqfqQHqV1YxXTvYT5F6s2wwRK5gW3/mx4Tfiu73vgVt40vQdH0hD/HDFtieidFSswEM3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841289; c=relaxed/simple;
	bh=bY3uwhAdqdUeCxk8YovfoOJpj6gAoBiYhX2fhlfpqY4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=THjFUTcaGUX3TUoioAlZrSZBV6jQWEHTIDykczL7CALT8jiWOvfyBAszNF1sxrUp0kgPoxZNj4EefvUgCb5dCouzwkxUE0rftqfLILSkXZwVXYFFXuXWEuwTGXo8UwkvfWLlXwKa3s20WzYsILTIcN1jNr7VP3OF5P4p1gpa4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V6LYW95j; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1173581259so3041087276.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723841287; x=1724446087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=85UzCaGowEZwuxuV5kMmpUWk+b/7cJAuTQ/iw0RGtwQ=;
        b=V6LYW95jwciTJjFDvXI829RIb4zn6+DUA+/w43S/u0tv+oEzk72lU2wbDF2tWBd28J
         i9hQyNZl3mB0jmLIeQfbdWND7Yi5bjeXj/CuijlvcefT/DIIvWS1zb3Csgdy8hYQXD5I
         054e2vZJs448l985N2hn7tSwycNZ9D6Fvm6vH61WnS7g1Jl03oWr67I+5yEFNhj8eDeE
         k7iGvUJX61AP/6q7AkA0rJLrQRjXpwfArhxDOs6J8htlgcnXuR6hLb00asyRnKmn6vOw
         W/TaAlL5A/1kq3tobXNeJibexGxfKP1wkyuLGNYtRCpIl7VQNoG+1zgeFlEhdC9GP2KX
         1lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723841287; x=1724446087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85UzCaGowEZwuxuV5kMmpUWk+b/7cJAuTQ/iw0RGtwQ=;
        b=RxPcSuQwwJwQDqaYUkflG89j68SDxuFdsLN0fYYhaVgi/SjZkqsDK74b2dPd66k5/0
         mfqGDNSbUpY7JzjXXZXj9u7q/3J4lF0VjjTFAn0zXzGCTWBkwP3oXcFJvFHo7fICvmPt
         ymwKH61syGk3rK0Pgq3h6CMHfH1StHNf0Z/lddmMuZVcl7cs6K+6xa+jiPF8Kg7xw7Y2
         fr331US9SV8HBKDf2RF8Np0TqnDKtNCCeuwb5P+1Cxw8zNHukj9aQ2ea5SK+CrtrG8bI
         CuUrZLUPVVhI5K8lSLK1hQe9tA0BnMqgWc0o2n0NbpU3X/yI2cBoAaAc1e1WQzFe23Ej
         nYZg==
X-Forwarded-Encrypted: i=1; AJvYcCUIJ1fl39Mqoa06aEcqly4Mf7UXGEdKgiF/pYDyCK17HOf/NrI5jZHg6xVfkAthS/m7B9X5ey30eQHttCCt1fj2+TIzXWYTnpCJoLXj
X-Gm-Message-State: AOJu0YxC7TpQSL6s1QvS2KVMVO4qJjNZ/ub53Nt4JWzQWpCo1+thM2F5
	q2YOkQRrOe6BjkvHVpDZs0q7aU95T8FIjb4MP1VbZaRxuVJxJAQ8DkHBfEvwWmEUW9I94W83tRv
	owKBtrDfix/g7TB5TeMrxFocgTQ==
X-Google-Smtp-Source: AGHT+IEpVi+7weJZuzse+CvCW18k10JcXLaoNK+bFag9nfLLoD0F+VpBnt8nL67pEI1q2tcnpiQNdaMuixBwtV3YY3M=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a5b:b92:0:b0:e0b:4dd5:3995 with SMTP
 id 3f1490d57ef6-e1180f69be9mr6247276.7.1723841286811; Fri, 16 Aug 2024
 13:48:06 -0700 (PDT)
Date: Fri, 16 Aug 2024 20:48:01 +0000
In-Reply-To: <20240816-b4-rbtree-v9-0-425b442af7e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816-b4-rbtree-v9-0-425b442af7e5@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240816-b4-rbtree-v9-4-425b442af7e5@google.com>
Subject: [PATCH v9 4/6] rust: rbtree: add mutable iterator
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


