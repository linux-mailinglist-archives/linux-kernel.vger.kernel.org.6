Return-Path: <linux-kernel+bounces-290309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F71955209
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130601C235A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530541C8226;
	Fri, 16 Aug 2024 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CxMeDWk6"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FD71C689A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841291; cv=none; b=twlRaPs0zBuEqTnjYo7Fye8Al4lP+k4Tfh3DIRq/Ay+7HQcwEhivm7Rervo49gp/IuCigPPhxSkKQMWcNllG19SvjNLG0YpQl3QfeZ1WPANoFyGHZiaCVJ0bKExIePqkjQAp2cXNnvC8aFbh9g2S5VD6hDrxHXDcnnfZrGJ378c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841291; c=relaxed/simple;
	bh=QJWOJkpl6KXRAe09TwBaSwnXuTWF1R+OnUVxqnwmS+Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oKpltuigXj1EoDEuk9a0sSJgVaT+hCvC5y2lW1Arz5TEAlQlpW+RNyd5GZ98W9XhAn0mq8tvy8H4301hj4tX+HliPo2ahJ3kkLHH9LsXmhk+C9YCsDwPnrLvA8BzqHKvGllmWtx9SL2r+7+8L0jQt0Os2/+lTErCX49P2uT9398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CxMeDWk6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1159fb1669so3698482276.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723841288; x=1724446088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ergg2PDCx3y6F+ITkJKGedswdbKauEfjSNh9WRyxoQ=;
        b=CxMeDWk6GIUReCiChj3IhnvgDQDOIP8VFknE4zlQZeorZ0SJ05OiLrngQKUb5e5ckb
         ONU1tl+difKIEi7lG8OAGnTnvtEj03o7FSwjRshW2tumjDwGhCV++j8rKZdqDVWrjcg7
         YWRYQGrYCQaUGSfRiDHnu9UX38yxcgPLjprmpFlUEh591USla/p2kd6xc7FePpzy30VM
         LgN8FQk3V1fVboTvSHpmDVbz0+TzDKh3Nj5MQbKKg7rdJ1D0/dzmmkSdAUiFesxTzRcX
         LcVF6SdDvHPqWP4NmhHJiQEkRQio/TYAmEtKTlQ9VoyzzQKQFywlvPReoA2PGNSsQqBE
         mPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723841288; x=1724446088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ergg2PDCx3y6F+ITkJKGedswdbKauEfjSNh9WRyxoQ=;
        b=NMgZdXm9UNzQ++ZzEqX0m+CGDCWUYWjzrhA1z2lV7+Cr5GkO6fymK5bvHj7l7dA5n4
         czqc6WFpvnquXeR3xN2AVK5zj4zxSAfLnB7E+FsSfe30OzKM7Pmj7vdiaWt2oBiGPPK9
         CkiuTx2Ul2s+TEaAaXgJSdnJCl74v3UQ+0b4JoXHAkwpbe/n8Gv/AEQODqw0baQtMZQl
         6+zxziiqAWHfpuXgARU98oqULvwU7EEFoJVz6Rcy+ufOi6MgBtQ3mFvUD/XwVEqbz0Yt
         +wBP0q4HP1c+SuOrVICYwEiCjFS3E/cn93lfAvuMn4/jBjkG+Uv9gT4dgT5GWB4cqlY0
         Jfmw==
X-Forwarded-Encrypted: i=1; AJvYcCWQggqDyUpyAUL13gTjhobkwoNJIAzhC6dIPEyzA0jzxRczCUPpf6LZOHTj80M0pYSjQfQ83+yq2+A3anscfknPnM6U7BQeEXhjRUH5
X-Gm-Message-State: AOJu0Yy9kLrX3/2/M64a0EtC1vbbG6dtM2yCyK8/hGCUZYlaAWiSv5Vb
	wRfa6NJaVLO8a4ywzBlroVmdCRrZq+8gl1W6bGcmtfJzN2MglY7b1dwbMxKHlDTWULDPW3CYALx
	0eNGv3kWqp7OkawzVGvzGMkscTA==
X-Google-Smtp-Source: AGHT+IHenAAP2harMW6zipnTUP9tnim/e+ps7twxCpeMqDJOrbuHJnV4oHjxAPHYzlg6qk2KbLeqB3pcUOf52Vu+ot8=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:8609:0:b0:e0e:cf00:d70b with SMTP
 id 3f1490d57ef6-e1180e4a7edmr6786276.2.1723841287813; Fri, 16 Aug 2024
 13:48:07 -0700 (PDT)
Date: Fri, 16 Aug 2024 20:48:02 +0000
In-Reply-To: <20240816-b4-rbtree-v9-0-425b442af7e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816-b4-rbtree-v9-0-425b442af7e5@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240816-b4-rbtree-v9-5-425b442af7e5@google.com>
Subject: [PATCH v9 5/6] rust: rbtree: add cursor
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

Add a cursor interface to `RBTree`, supporting the following use cases:
- Inspect the current node pointed to by the cursor, inspect/move to
  it's neighbors in sort order (bidirectionally).
- Mutate the tree itself by removing the current node pointed to by the
  cursor, or one of its neighbors.

Add functions to obtain a cursor to the tree by key:
- The node with the smallest key
- The node with the largest key
- The node matching the given key, or the one with the next larger key

The cursor abstraction is needed by the binder driver to efficiently
search for nodes and (conditionally) modify them, as well as their
neighbors [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08ba9197f637@google.com/ [1]
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 541 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 541 insertions(+)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 6c9a8f0a00e6..754af0db86b5 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -236,6 +236,40 @@ pub fn values(&self) -> impl Iterator<Item = &'_ V> {
     pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
         self.iter_mut().map(|(_, v)| v)
     }
+
+    /// Returns a cursor over the tree nodes, starting with the smallest key.
+    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_first(root) };
+        NonNull::new(current).map(|current| {
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+            // - Due to the type signature of this function, the returned [`Cursor`]
+            //   borrows mutably from `self`.
+            Cursor {
+                current,
+                tree: self,
+            }
+        })
+    }
+
+    /// Returns a cursor over the tree nodes, starting with the largest key.
+    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_last(root) };
+        NonNull::new(current).map(|current| {
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+            // - Due to the type signature of this function, the returned [`Cursor`]
+            //   borrows mutably from `self`.
+            Cursor {
+                current,
+                tree: self,
+            }
+        })
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -396,6 +430,75 @@ fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
     pub fn remove(&mut self, key: &K) -> Option<V> {
         self.remove_node(key).map(|node| node.node.value)
     }
+
+    /// Returns a cursor over the tree nodes based on the given key.
+    ///
+    /// If the given key exists, the cursor starts there.
+    /// Otherwise it starts with the first larger key in sort order.
+    /// If there is no larger key, it returns [`None`].
+    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
+    where
+        K: Ord,
+    {
+        let mut node = self.root.rb_node;
+        let mut best_match: Option<NonNull<Node<K, V>>> = None;
+        while !node.is_null() {
+            // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+            // point to the links field of `Node<K, V>` objects.
+            let this = unsafe { container_of!(node, Node<K, V>, links) }.cast_mut();
+            // SAFETY: `this` is a non-null node so it is valid by the type invariants.
+            let this_key = unsafe { &(*this).key };
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            let left_child = unsafe { (*node).rb_left };
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            let right_child = unsafe { (*node).rb_right };
+            if key == this_key {
+                return NonNull::new(node).map(|current| {
+                    // INVARIANT:
+                    // - `node` is a valid node in the [`RBTree`] pointed to by `self`.
+                    // - Due to the type signature of this function, the returned [`Cursor`]
+                    //   borrows mutably from `self`.
+                    Cursor {
+                        current,
+                        tree: self,
+                    }
+                });
+            } else {
+                node = if key > this_key {
+                    right_child
+                } else {
+                    let is_better_match = match best_match {
+                        None => true,
+                        Some(best) => {
+                            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
+                            let best_key = unsafe { &(*best.as_ptr()).key };
+                            best_key > this_key
+                        }
+                    };
+                    if is_better_match {
+                        best_match = NonNull::new(this);
+                    }
+                    left_child
+                };
+            }
+        }
+
+        let best = best_match?;
+
+        // SAFETY: `best` is a non-null node so it is valid by the type invariants.
+        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
+
+        NonNull::new(links).map(|current| {
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+            // - Due to the type signature of this function, the returned [`Cursor`]
+            //   borrows mutably from `self`.
+            Cursor {
+                current,
+                tree: self,
+            }
+        })
+    }
 }
 
 impl<K, V> Default for RBTree<K, V> {
@@ -427,6 +530,439 @@ fn drop(&mut self) {
     }
 }
 
+/// A bidirectional cursor over the tree nodes, sorted by key.
+///
+/// # Examples
+///
+/// In the following example, we obtain a cursor to the first element in the tree.
+/// The cursor allows us to iterate bidirectionally over key/value pairs in the tree.
+///
+/// ```
+/// use kernel::{alloc::flags, rbtree::RBTree};
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
+///
+/// // Get a cursor to the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Move the cursor, updating it to the 2nd element.
+/// cursor = cursor.move_next().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Peek at the next element without impacting the cursor.
+/// let next = cursor.peek_next().unwrap();
+/// assert_eq!(next, (&30, &300));
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Moving past the last element causes the cursor to return [`None`].
+/// cursor = cursor.move_next().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+/// let cursor = cursor.move_next();
+/// assert!(cursor.is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// A cursor can also be obtained at the last element in the tree.
+///
+/// ```
+/// use kernel::{alloc::flags, rbtree::RBTree};
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
+///
+/// let mut cursor = tree.cursor_back().unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Obtaining a cursor returns [`None`] if the tree is empty.
+///
+/// ```
+/// use kernel::rbtree::RBTree;
+///
+/// let mut tree: RBTree<u16, u16> = RBTree::new();
+/// assert!(tree.cursor_front().is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// [`RBTree::cursor_lower_bound`] can be used to start at an arbitrary node in the tree.
+///
+/// ```
+/// use kernel::{alloc::flags, rbtree::RBTree};
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert five elements.
+/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(40, 400, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(50, 500, flags::GFP_KERNEL)?;
+///
+/// // If the provided key exists, a cursor to that key is returned.
+/// let cursor = tree.cursor_lower_bound(&20).unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // If the provided key doesn't exist, a cursor to the first larger element in sort order is returned.
+/// let cursor = tree.cursor_lower_bound(&25).unwrap();
+/// let current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // If there is no larger key, [`None`] is returned.
+/// let cursor = tree.cursor_lower_bound(&55);
+/// assert!(cursor.is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// The cursor allows mutation of values in the tree.
+///
+/// ```
+/// use kernel::{alloc::flags, rbtree::RBTree};
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
+///
+/// // Retrieve a cursor.
+/// let mut cursor = tree.cursor_front().unwrap();
+///
+/// // Get a mutable reference to the current value.
+/// let (k, v) = cursor.current_mut();
+/// *v = 1000;
+///
+/// // The updated value is reflected in the tree.
+/// let updated = tree.get(&10).unwrap();
+/// assert_eq!(updated, &1000);
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// It also allows node removal. The following examples demonstrate the behavior of removing the current node.
+///
+/// ```
+/// use kernel::{alloc::flags, rbtree::RBTree};
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
+///
+/// // Remove the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+/// cursor = cursor.remove_current().0.unwrap();
+///
+/// // If a node exists after the current element, it is returned.
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Get a cursor to the last element, and remove it.
+/// cursor = tree.cursor_back().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // Since there is no next node, the previous node is returned.
+/// cursor = cursor.remove_current().0.unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Removing the last element in the tree returns [`None`].
+/// assert!(cursor.remove_current().0.is_none());
+///
+/// # Ok::<(), Error>(())
+/// ```
+///
+/// Nodes adjacent to the current node can also be removed.
+///
+/// ```
+/// use kernel::{alloc::flags, rbtree::RBTree};
+///
+/// // Create a new tree.
+/// let mut tree = RBTree::new();
+///
+/// // Insert three elements.
+/// tree.try_create_and_insert(10, 100, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(20, 200, flags::GFP_KERNEL)?;
+/// tree.try_create_and_insert(30, 300, flags::GFP_KERNEL)?;
+///
+/// // Get a cursor to the first element.
+/// let mut cursor = tree.cursor_front().unwrap();
+/// let mut current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Calling `remove_prev` from the first element returns [`None`].
+/// assert!(cursor.remove_prev().is_none());
+///
+/// // Get a cursor to the last element.
+/// cursor = tree.cursor_back().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&30, &300));
+///
+/// // Calling `remove_prev` removes and returns the middle element.
+/// assert_eq!(cursor.remove_prev().unwrap().to_key_value(), (20, 200));
+///
+/// // Calling `remove_next` from the last element returns [`None`].
+/// assert!(cursor.remove_next().is_none());
+///
+/// // Move to the first element
+/// cursor = cursor.move_prev().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&10, &100));
+///
+/// // Calling `remove_next` removes and returns the last element.
+/// assert_eq!(cursor.remove_next().unwrap().to_key_value(), (30, 300));
+///
+/// # Ok::<(), Error>(())
+///
+/// ```
+///
+/// # Invariants
+/// - `current` points to a node that is in the same [`RBTree`] as `tree`.
+pub struct Cursor<'a, K, V> {
+    tree: &'a mut RBTree<K, V>,
+    current: NonNull<bindings::rb_node>,
+}
+
+// SAFETY: The [`Cursor`] has exclusive access to both `K` and `V`, so it is sufficient to require them to be `Send`.
+// The cursor only gives out immutable references to the keys, but since it has excusive access to those same
+// keys, `Send` is sufficient. `Sync` would be okay, but it is more restrictive to the user.
+unsafe impl<'a, K: Send, V: Send> Send for Cursor<'a, K, V> {}
+
+// SAFETY: The [`Cursor`] gives out immutable references to K and mutable references to V,
+// so it has the same thread safety requirements as mutable references.
+unsafe impl<'a, K: Sync, V: Sync> Sync for Cursor<'a, K, V> {}
+
+impl<'a, K, V> Cursor<'a, K, V> {
+    /// The current node
+    pub fn current(&self) -> (&K, &V) {
+        // SAFETY:
+        // - `self.current` is a valid node by the type invariants.
+        // - We have an immutable reference by the function signature.
+        unsafe { Self::to_key_value(self.current) }
+    }
+
+    /// The current node, with a mutable value
+    pub fn current_mut(&mut self) -> (&K, &mut V) {
+        // SAFETY:
+        // - `self.current` is a valid node by the type invariants.
+        // - We have an mutable reference by the function signature.
+        unsafe { Self::to_key_value_mut(self.current) }
+    }
+
+    /// Remove the current node from the tree.
+    ///
+    /// Returns a tuple where the first element is a cursor to the next node, if it exists,
+    /// else the previous node, else [`None`] (if the tree becomes empty). The second element
+    /// is the removed node.
+    pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
+        let prev = self.get_neighbor_raw(Direction::Prev);
+        let next = self.get_neighbor_raw(Direction::Next);
+        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        let this = unsafe { container_of!(self.current.as_ptr(), Node<K, V>, links) }.cast_mut();
+        // SAFETY: `this` is valid by the type invariants as described above.
+        let node = unsafe { Box::from_raw(this) };
+        let node = RBTreeNode { node };
+        // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
+        // the tree cannot change. By the tree invariant, all nodes are valid.
+        unsafe { bindings::rb_erase(&mut (*this).links, addr_of_mut!(self.tree.root)) };
+
+        let current = match (prev, next) {
+            (_, Some(next)) => next,
+            (Some(prev), None) => prev,
+            (None, None) => {
+                return (None, node);
+            }
+        };
+
+        (
+            // INVARIANT:
+            // - `current` is a valid node in the [`RBTree`] pointed to by `self.tree`.
+            // - Due to the function signature, `self` is an owned [`Cursor`],
+            //   and [`Cursor`]s are only created via functions with a mutable reference
+            //   to an [`RBTree`].
+            Some(Self {
+                current,
+                tree: self.tree,
+            }),
+            node,
+        )
+    }
+
+    /// Remove the previous node, returning it if it exists.
+    pub fn remove_prev(&mut self) -> Option<RBTreeNode<K, V>> {
+        self.remove_neighbor(Direction::Prev)
+    }
+
+    /// Remove the next node, returning it if it exists.
+    pub fn remove_next(&mut self) -> Option<RBTreeNode<K, V>> {
+        self.remove_neighbor(Direction::Next)
+    }
+
+    fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTreeNode<K, V>> {
+        if let Some(neighbor) = self.get_neighbor_raw(direction) {
+            let neighbor = neighbor.as_ptr();
+            // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
+            // the tree cannot change. By the tree invariant, all nodes are valid.
+            unsafe { bindings::rb_erase(neighbor, addr_of_mut!(self.tree.root)) };
+            // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+            // point to the links field of `Node<K, V>` objects.
+            let this = unsafe { container_of!(neighbor, Node<K, V>, links) }.cast_mut();
+            // SAFETY: `this` is valid by the type invariants as described above.
+            let node = unsafe { Box::from_raw(this) };
+            return Some(RBTreeNode { node });
+        }
+        None
+    }
+
+    /// Move the cursor to the previous node, returning [`None`] if it doesn't exist.
+    pub fn move_prev(self) -> Option<Self> {
+        self.mv(Direction::Prev)
+    }
+
+    /// Move the cursor to the next node, returning [`None`] if it doesn't exist.
+    pub fn move_next(self) -> Option<Self> {
+        self.mv(Direction::Next)
+    }
+
+    fn mv(self, direction: Direction) -> Option<Self> {
+        // INVARIANT:
+        // - `neighbor` is a valid node in the [`RBTree`] pointed to by `self.tree`.
+        // - Due to the function signature, `self` is an owned [`Cursor`],
+        //   and [`Cursor`]s are only created via functions with a mutable reference
+        //   to an [`RBTree`].
+        self.get_neighbor_raw(direction).map(|neighbor| Self {
+            tree: self.tree,
+            current: neighbor,
+        })
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_prev(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Prev)
+    }
+
+    /// Access the previous node without moving the cursor.
+    pub fn peek_next(&self) -> Option<(&K, &V)> {
+        self.peek(Direction::Next)
+    }
+
+    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
+        self.get_neighbor_raw(direction).map(|neighbor| {
+            // SAFETY:
+            // - `neighbor` is a valid tree node.
+            // - By the function signature, we have an immutable reference to `self`.
+            unsafe { Self::to_key_value(neighbor) }
+        })
+    }
+
+    /// Access the previous node mutably without moving the cursor.
+    pub fn peek_prev_mut(&mut self) -> Option<(&K, &mut V)> {
+        self.peek_mut(Direction::Prev)
+    }
+
+    /// Access the next node mutably without moving the cursor.
+    pub fn peek_next_mut(&mut self) -> Option<(&K, &mut V)> {
+        self.peek_mut(Direction::Next)
+    }
+
+    fn peek_mut(&mut self, direction: Direction) -> Option<(&K, &mut V)> {
+        self.get_neighbor_raw(direction).map(|neighbor| {
+            // SAFETY:
+            // - `neighbor` is a valid tree node.
+            // - By the function signature, we have a mutable reference to `self`.
+            unsafe { Self::to_key_value_mut(neighbor) }
+        })
+    }
+
+    fn get_neighbor_raw(&self, direction: Direction) -> Option<NonNull<bindings::rb_node>> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current.as_ptr()),
+                Direction::Next => bindings::rb_next(self.current.as_ptr()),
+            }
+        };
+
+        NonNull::new(neighbor)
+    }
+
+    /// SAFETY:
+    /// - `node` must be a valid pointer to a node in an [`RBTree`].
+    /// - The caller has immutable access to `node` for the duration of 'b.
+    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, &'b V) {
+        // SAFETY: the caller guarantees that `node` is a valid pointer in an `RBTree`.
+        let (k, v) = unsafe { Self::to_key_value_raw(node) };
+        // SAFETY: the caller guarantees immutable access to `node`.
+        (k, unsafe { &*v })
+    }
+
+    /// SAFETY:
+    /// - `node` must be a valid pointer to a node in an [`RBTree`].
+    /// - The caller has mutable access to `node` for the duration of 'b.
+    unsafe fn to_key_value_mut<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, &'b mut V) {
+        // SAFETY: the caller guarantees that `node` is a valid pointer in an `RBTree`.
+        let (k, v) = unsafe { Self::to_key_value_raw(node) };
+        // SAFETY: the caller guarantees mutable access to `node`.
+        (k, unsafe { &mut *v })
+    }
+
+    /// SAFETY:
+    /// - `node` must be a valid pointer to a node in an [`RBTree`].
+    /// - The caller has immutable access to the key for the duration of 'b.
+    unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut V) {
+        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        let this = unsafe { container_of!(node.as_ptr(), Node<K, V>, links) }.cast_mut();
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let k = unsafe { &(*this).key };
+        // SAFETY: The passed `node` is the current node or a non-null neighbor,
+        // thus `this` is valid by the type invariants.
+        let v = unsafe { addr_of_mut!((*this).value) };
+        (k, v)
+    }
+}
+
+/// Direction for [`Cursor`] operations.
+enum Direction {
+    /// the node immediately before, in sort order
+    Prev,
+    /// the node immediately after, in sort order
+    Next,
+}
+
 impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
     type Item = (&'a K, &'a V);
     type IntoIter = Iter<'a, K, V>;
@@ -585,6 +1121,11 @@ impl<K, V> RBTreeNode<K, V> {
     pub fn new(key: K, value: V, flags: Flags) -> Result<RBTreeNode<K, V>> {
         Ok(RBTreeNodeReservation::new(flags)?.into_node(key, value))
     }
+
+    /// Get the key and value from inside the node.
+    pub fn to_key_value(self) -> (K, V) {
+        (self.node.key, self.node.value)
+    }
 }
 
 // SAFETY: If K and V can be sent across threads, then it's also okay to send [`RBTreeNode`] across

-- 
2.46.0.184.g6999bdac58-goog


