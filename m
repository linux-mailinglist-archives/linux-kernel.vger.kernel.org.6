Return-Path: <linux-kernel+bounces-199410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE78D86E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54BA1288A47
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4B813790F;
	Mon,  3 Jun 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BeokOhRD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C34136E3E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430735; cv=none; b=pN0otGodiWx54QmIFVkhRJooTR5ws9b63CMAkTQDyrcKHvOuzOVQQrJCB3gCLjWhY6srYKqQjTWQWZVlE/dLGA6qXs/D9umIUD69N9Thimf+eI/yyN51j5WK2DnknsUlD4WFOMi3/m5HGKkEU5uO5qOcFiJkyuqet9Xj92SI404=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430735; c=relaxed/simple;
	bh=1NRPDpmaRDB+AhvQN/BNDaJ6oGKxnyTvq19egS+D89c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tOaNpim/2MKeSvaqrJWveW2l3LfURYN01KmcFb/FIp5f1vZWo19yjZuYgUrOGL7+BmVCCH5eKfEtT3y4dyNB63MhsytYcUTH+a2S3P8Zr50qRXMxRWAikE20WgZED59iImjL8WjWd+eVrVF2t0kyfuzSduWj6xDqoxhiFe6dN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BeokOhRD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfa84f6a603so3855110276.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717430730; x=1718035530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NweWq3SyqbU+cwUgdn2ay8imaAU/0BQPy/p7EbZYlD8=;
        b=BeokOhRDDTThBcpBsRXuQ7ZFPoXQTJC6mr26/PGpbtAGdiVCaSGfIj5wISMIQvuEus
         Cn7So3Lhg6lBMFbhMe3EkEJl+AejZn9kJIHu1vYncJEGmeZGpSRFU3bRO9XckHnQlTbM
         q3NK0bqNIdILeY0mCBP6B0JpjHc1c3zFiehOLdqrM/T2GEMval/Le8hYJQl/TtQ7Wx05
         76bIVj1vcH3pvO2hhBGsDa0j+ovdlU29v3kjmwzZARQfdqAO3f6vx9GN/G79TfScPnCq
         23ZMxjE0ynuIRVidnSDXRQHwQ4hPKXNfh9tJsPxNKdbDZG75QzFaRBDf0yNCqRDSOJTz
         8fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430730; x=1718035530;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NweWq3SyqbU+cwUgdn2ay8imaAU/0BQPy/p7EbZYlD8=;
        b=Q2v7UMrN7wLIfk3hcu97YXuzpUNiUnugryxO7oGN3mAJGtiZlpuaHvnVSFf38u7Ep0
         3GfTijO7/Uot9mEm05qd4dx4Vh41AsGmld4BsmI6n5P1lVVV5Kutt3+7jaCQ9kxLVg1W
         IcA1n8XUiM+9ChTGePQXq5FMNY8hjBkGbeDlNSSF8rYnBTK4YF+AcSsEKMCByGW+e5it
         AbvOVjdvRATzeqGV/EGKk924DR4tKo26HQXLSzz4zZk52P1sgV7LaMVNkgNUGzfrVTZQ
         5Z93CDbpMD/LeYpsc6ta3mENmrz8iM4/L6jh61zopxIs2YQstqQCEBzkOgOoPRDKMxan
         EUbw==
X-Forwarded-Encrypted: i=1; AJvYcCVbnH40sAaMl6xNNXU9DZlSTbMH6Y4KOdYoYYzOORfpyx8t+wy9s+P528gVJnLA7hPq/rZjzhU/2Xy4bEdPF6UaFXkcqVrCTz/E48s1
X-Gm-Message-State: AOJu0YzNnf3UjZsvHZJt61sOAs8AvkTIn2MEuDgcdFp2IqBPfyZk1Z9X
	nr4XL1E89rdQYaxvNdwo7pvA1VnZZgKn/RSPuA/MymKKU/NSpTygG3oWmyUfQI6GnawBo2zOjuy
	6eURYs/nvVorhYMEx9+3Me7KaPA==
X-Google-Smtp-Source: AGHT+IGHnoBBDF+uplOTuhsfaXzMdOsouZCQJQcVfginVN5GDE3IsdPb0SGj8uS3x0aE9ajY8sWv/aeRMLVd7zVDfAA=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:2b12:b0:dd9:2d94:cd8a with
 SMTP id 3f1490d57ef6-dfa73dafa73mr758560276.9.1717430730209; Mon, 03 Jun 2024
 09:05:30 -0700 (PDT)
Date: Mon, 03 Jun 2024 16:05:19 +0000
In-Reply-To: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240603-b4-rbtree-v4-4-308e43d6abfc@google.com>
Subject: [PATCH v4 4/6] rust: rbtree: add mutable iterator
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
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/rbtree.rs | 98 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 86 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 6ebea833e5a9..28dfa36e81c3 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -197,8 +197,26 @@ pub fn iter(&self) -> Iter<'_, K, V> {
         // INVARIANT: `bindings::rb_first` returns a valid pointer to a tree node given a valid pointer to a tree root.
         Iter {
             _tree: PhantomData,
-            // SAFETY: `self.root` is a valid pointer to the tree root.
-            next: unsafe { bindings::rb_first(&self.root) },
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
+                next: unsafe { bindings::rb_first(&self.root) },
+                _phantom: PhantomData,
+            },
         }
     }
 
@@ -211,6 +229,11 @@ pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
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
@@ -414,13 +437,9 @@ fn into_iter(self) -> Self::IntoIter {
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
@@ -434,21 +453,76 @@ unsafe impl<'a, K: Sync, V: Sync> Sync for Iter<'a, K, V> {}
 impl<'a, K, V> Iterator for Iter<'a, K, V> {
     type Item = (&'a K, &'a V);
 
+    fn next(&mut self) -> Option<Self::Item> {
+        self.iter_raw.next().map(|(k, v)|
+            // SAFETY: Due to `self._tree`, `k` and `v` are valid for the lifetime of `'a`.
+            unsafe { (&*k, &*v) })
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
+// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and V, so it has the same
+// thread safety requirements as mutable references.
+unsafe impl<'a, K: Send, V: Send> Send for IterMut<'a, K, V> {}
+
+// SAFETY: The [`RBTreeIterator`] gives out mutable references to K and V, so it has the same
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
2.45.1.288.g0e0cd299f1-goog


