Return-Path: <linux-kernel+bounces-199411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643EA8D86E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19549288ED5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE6137931;
	Mon,  3 Jun 2024 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28hsN1hn"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03523136E34
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430736; cv=none; b=FXCwTqeykKI3P3fKaAQ3rSQHU4HOR/ydSATis6KQLW6tHDSjyjU5jHSZgr/gKwXk8x9wTFUvLT7uuc+CGcQPY9obW8p9PTTD7YkH5NXUOpotebv7hNiQVDP4C3xmUvTqrQvItn3RFqEMAiwCYEIjFwBkxrfAHmRXZvT3EXDLiIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430736; c=relaxed/simple;
	bh=8bwTV260jHWjBiX672VO+MiKIHxhlZtAlMZULZ/dYds=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dhCafBIU8AFk6YENp7OKNBJEFrsbRxABh/1ojDqhSjN+fz6I8H2MAjKWWLeUyIp7eJaxHxwBYzlrUL8TXjQOH+o+p4S1yonuOMd7ZWlIjYVP4FTffF1bNFd+i6zK0XB+hT8noyzV6aDvfDgNMzzYXSZgT1TK5SUu9slY10mcX3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28hsN1hn; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6ae4a6f537eso40509856d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717430732; x=1718035532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HMQOSD11gHFpjhDvP7Cphqh8wylwk+Y1yYqFz47TwsA=;
        b=28hsN1hnBhk+vegcg/qgulqaKqR17HMo35XPhUuuqpLmRMeOsuqIQLBnJmQnaqn6Kl
         ME+w0G9NnHa7N5ydpgGKFcQft3L9U0RNWbvo13nvgAA6x9fjsdrLhibE+PNA4cg4elcR
         PC6z48od8+eXfIf7kxxs7p91jTyXAG+RsURllrTOC4FomfMkJfxqOjNQm+a8I4y5rS5y
         C4rpC1WIUhlRNJBg2rR4em8SfZEN8VNnBY3Oj4aHKZCipge7/N7EjRi7CmMmG+zQETxk
         YufVMSL/Visf3Xy2wSkqfBa++IJeQnLZxYkmLdrcpz/qdQ9SR6hzSLK6NEyBthV9h0zO
         LXRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430732; x=1718035532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMQOSD11gHFpjhDvP7Cphqh8wylwk+Y1yYqFz47TwsA=;
        b=qGULzLMScRRxI5tqJ66hDxPnriBnqMkxHpl/U+fxPEWXUdFJR2297Hp2UVrjuQywC4
         srmQvEcedEH6/8uNwnhbpXqRqoJXXcSc/sgoDCqdhs8mSYiVipQiBTt31WWRS5gIYZhu
         A27MrLKqB5aSIQTW5fmUXtYVfHzMKZJJ5vS+3BaqnVSRCiSDDetKCfUZ7pI5Nx+DQern
         B/i1uJOCS+bSr2bFtIoNKpLwCDEMoptIeRKT7cBPt11syRkjFWAAqt4lSF02lK4rd4Ce
         JuqGJQdlXbGib/1Gt8Gfk9RokDi97XwPm0iw4oZl05yAI2AeJvdh+dLWIzvjfVgU9sfD
         bRyA==
X-Forwarded-Encrypted: i=1; AJvYcCVojkgXiXvBT+eefVlaQlW9UkMVsiHyuHKwn3PGdPzTYu6RbdaMRUnwYJOJWxhWvFW3l6QE3weAxywuYhaE/VEu6v7VAxVgVNSn9dkO
X-Gm-Message-State: AOJu0YxWvj3c6FPo1QCkA6E7BgnGnHnB7mM6Da2LpufYiEZEA6dRIb8V
	B5vvlp5G2GyJBU4pIF/TGRU10kDUGI5DMo6MOQh3AIjpOW3psbBwAEjVdc87oeGwU1UTVxVI4Ct
	2SQMMxY8AiY/U3iY6RPjJC7owiQ==
X-Google-Smtp-Source: AGHT+IEGa++f22+Aowqhr9JJyXXPE7+K5zq9+k4KYaL7XfiQtX6RbP0czemQNRCqCrSsrq7dxHnbhUH5dGVnHGDSntw=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6214:508f:b0:6ad:7073:706d with
 SMTP id 6a1803df08f44-6aecd6f90acmr6094186d6.12.1717430731734; Mon, 03 Jun
 2024 09:05:31 -0700 (PDT)
Date: Mon, 03 Jun 2024 16:05:20 +0000
In-Reply-To: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240603-b4-rbtree-v4-5-308e43d6abfc@google.com>
Subject: [PATCH v4 5/6] rust: rbtree: add `RBTreeCursor`
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
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 526 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 526 insertions(+)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 28dfa36e81c3..1aa8370f4f06 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -234,6 +234,42 @@ pub fn values(&self) -> impl Iterator<Item = &'_ V> {
     pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
         self.iter_mut().map(|(_, v)| v)
     }
+
+    /// Returns a cursor over the tree nodes, starting with the smallest key.
+    pub fn cursor_front(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_first(root) };
+        if current.is_null() {
+            return None;
+        }
+        // INVARIANT:
+        // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+        // - Due to the type signature of this function, the returned [`RBTreeCursor`]
+        //   borrows mutably from `self`.
+        Some(RBTreeCursor {
+            current,
+            tree: self,
+        })
+    }
+
+    /// Returns a cursor over the tree nodes, starting with the largest key.
+    pub fn cursor_back(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
+        let root = addr_of_mut!(self.root);
+        // SAFETY: `self.root` is always a valid root node
+        let current = unsafe { bindings::rb_last(root) };
+        if current.is_null() {
+            return None;
+        }
+        // INVARIANT:
+        // - `current` is a valid node in the [`RBTree`] pointed to by `self`.
+        // - Due to the type signature of this function, the returned [`RBTreeCursor`]
+        //   borrows mutably from `self`.
+        Some(RBTreeCursor {
+            current,
+            tree: self,
+        })
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -394,6 +430,66 @@ fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
     pub fn remove(&mut self, key: &K) -> Option<V> {
         self.remove_node(key).map(|node| node.node.value)
     }
+
+    /// Returns a cursor over the tree nodes based on the given key.
+    ///
+    /// If the given key exists, the cursor starts there.
+    /// Otherwise it starts with the first larger key in sort order.
+    /// If there is no larger key, it returns [`None`].
+    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor<'_, K, V>>
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
+                // INVARIANT:
+                // - `node` is a valid node in the [`RBTree`] pointed to by `self`.
+                // - Due to the type signature of this function, the returned [`RBTreeCursor`]
+                //   borrows mutably from `self`.
+                return Some(RBTreeCursor {
+                    tree: self,
+                    current: node,
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
+                }
+            };
+        }
+        // INVARIANT:
+        // - `best` is a valid node in the [`RBTree`] pointed to by `self`.
+        // - Due to the type signature of this function, the returned [`RBTreeCursor`]
+        //   borrows mutably from `self`.
+        best_match.map(|best| RBTreeCursor {
+            tree: self,
+            // SAFETY: `best` is a non-null node so it is valid by the type invariants.
+            current: unsafe { addr_of_mut!((*best.as_ptr()).links) },
+        })
+    }
 }
 
 impl<K, V> Default for RBTree<K, V> {
@@ -425,6 +521,431 @@ fn drop(&mut self) {
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
+/// cursor = cursor.remove_current().unwrap();
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
+/// cursor = cursor.remove_current().unwrap();
+/// current = cursor.current();
+/// assert_eq!(current, (&20, &200));
+///
+/// // Removing the last element in the tree returns [`None`].
+/// assert!(cursor.remove_current().is_none());
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
+/// ```
+/// # Invariants
+/// - `current` points to a node that is in the same [`RBTree`] as `tree`.
+pub struct RBTreeCursor<'a, K, V> {
+    tree: &'a mut RBTree<K, V>,
+    current: *mut bindings::rb_node,
+}
+
+// SAFETY: The [`RBTreeCursor`] gives out immutable references to K and mutable references to V,
+// so it has the same thread safety requirements as mutable references.
+unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
+
+// SAFETY: The [`RBTreeCursor`] gives out immutable references to K and mutable references to V,
+// so it has the same thread safety requirements as mutable references.
+unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeCursor<'a, K, V> {}
+
+impl<'a, K, V> RBTreeCursor<'a, K, V> {
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
+    /// Returns a cursor to the next node, if it exists,
+    /// else the previous node. Returns [`None`] if the tree
+    /// becomes empty.
+    pub fn remove_current(self) -> Option<Self> {
+        let prev = self.get_neighbor_raw(Direction::Prev);
+        let next = self.get_neighbor_raw(Direction::Next);
+        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        let this = unsafe { container_of!(self.current, Node<K, V>, links) }.cast_mut();
+        // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
+        // the tree cannot change. By the tree invariant, all nodes are valid.
+        unsafe { bindings::rb_erase(&mut (*this).links, addr_of_mut!(self.tree.root)) };
+
+        let current = match (prev, next) {
+            (_, Some(next)) => next,
+            (Some(prev), None) => prev,
+            (None, None) => {
+                return None;
+            }
+        };
+
+        // INVARIANT:
+        // - `current` is a valid node in the [`RBTree`] pointed to by `self.tree`.
+        // - Due to the function signature, `self` is an owned [`RBTreeCursor`],
+        //   and [`RBTreeCursor`]s are only created via functions with a mutable reference
+        //   to an [`RBTree`].
+        Some(Self {
+            current,
+            tree: self.tree,
+        })
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
+        // - Due to the function signature, `self` is an owned [`RBTreeCursor`],
+        //   and [`RBTreeCursor`]s are only created via functions with a mutable reference
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
+        self.get_neighbor_raw(direction)
+            // SAFETY:
+            // - `neighbor` is a valid tree node.
+            // - By the function signature, we have an immutable reference to `self`.
+            .map(|neighbor| unsafe { Self::to_key_value(neighbor) })
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
+        self.get_neighbor_raw(direction)
+            // SAFETY:
+            // - `neighbor` is a valid tree node.
+            // - By the function signature, we have a mutable reference to `self`.
+            .map(|neighbor| unsafe { Self::to_key_value_mut(neighbor) })
+    }
+
+    fn get_neighbor_raw(&self, direction: Direction) -> Option<*mut bindings::rb_node> {
+        // SAFETY: `self.current` is valid by the type invariants.
+        let neighbor = unsafe {
+            match direction {
+                Direction::Prev => bindings::rb_prev(self.current),
+                Direction::Next => bindings::rb_next(self.current),
+            }
+        };
+
+        if neighbor.is_null() {
+            return None;
+        }
+
+        Some(neighbor)
+    }
+
+    /// SAFETY:
+    /// - `node` must be a valid pointer to a node in an [`RBTree`].
+    /// - The caller has immutable access to `node` for the duration of 'a.
+    unsafe fn to_key_value(node: *mut bindings::rb_node) -> (&'a K, &'a V) {
+        // SAFETY: the caller guarantees that `node` is a valid pointer in an `RBTree`.
+        let (k, v) = unsafe { Self::to_key_value_raw(node) };
+        // SAFETY: the caller guarantees immutable access to `node`.
+        (k, unsafe { &*v })
+    }
+
+    /// SAFETY:
+    /// - `node` must be a valid pointer to a node in an [`RBTree`].
+    /// - The caller has mutable access to `node` for the duration of 'a.
+    unsafe fn to_key_value_mut(node: *mut bindings::rb_node) -> (&'a K, &'a mut V) {
+        // SAFETY: the caller guarantees that `node` is a valid pointer in an `RBTree`.
+        let (k, v) = unsafe { Self::to_key_value_raw(node) };
+        // SAFETY: the caller guarantees mutable access to `node`.
+        (k, unsafe { &mut *v })
+    }
+
+    /// SAFETY:
+    /// - `node` must be a valid pointer to a node in an [`RBTree`].
+    /// - The caller has immutable access to the key for the duration of 'a.
+    unsafe fn to_key_value_raw(node: *mut bindings::rb_node) -> (&'a K, *mut V) {
+        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
+        // point to the links field of `Node<K, V>` objects.
+        let this = unsafe { container_of!(node, Node<K, V>, links) }.cast_mut();
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
+/// Direction for [`RBTreeCursor`] operations.
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
@@ -588,6 +1109,11 @@ impl<K, V> RBTreeNode<K, V> {
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
2.45.1.288.g0e0cd299f1-goog


