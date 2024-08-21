Return-Path: <linux-kernel+bounces-295995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 730E895A414
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7BB2855F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CD1B3B1C;
	Wed, 21 Aug 2024 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cs2uIKFb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4802F1B2EE1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262134; cv=none; b=Dwfjt7z5yVDtyy3ur9du9R5Wt7qhIzPdPo207BbwsUeYO0e4NrdLipHSk3SIK4tcyDruimO/swbyXVwvGIxH3KcMnpb2Ax/1zbC9tZeTGAlqeHWRGxhgLueAZfGfgAhdQPu40/9NUdgFQfJbY4rsQLk8aQI9IMbFONlTocsvrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262134; c=relaxed/simple;
	bh=prbzF9A7rp/G33IcXNJKm6tZRhmAfexWxJAHcXVXlYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OVNlkgmUPq+GsLPO16k1dQx2k+Xp/omNcBWfiORBW1OxAwOvwmgt+vUHL3pAJVGAROgDgEqMnl7PQs4w2BgTv03ZQPLkTDFFBVumj8tY8QKEN8FJWEidNTorfXt7FoiY9KWSY+zE8+oEcNv+ZgCZ4ivcuzxw2IZ3nx0id4lArww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cs2uIKFb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b052c5939cso11419317b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724262131; x=1724866931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYBGbx/uYLeIyT2X3cGbSQ5xZpFImUAaykVOvmQ6VX8=;
        b=Cs2uIKFbL2NNxj9RjDNLlp9l1PgbnbZZ8Vo+ahygh0fZPPSOt5HklTtG9DE0Ki+0ft
         y1h5yuIC84iIK6gm+dT1+3glt/dRW0mR5FZEG+hJx+WbMXgLxtSPXMLCfbEIMkeWYAOc
         zk5syfY/sfSqI87G4k18H+FUS3ZNbxQaWtUp3acs9sq9KAYlVLTElgBG8RqKINfSN2dY
         TCct1m/3cB4+J3SWLiqJxzC4gMxgqKcnucJQ7x6Rfc1ovs/wcejJeqtHr45oJmjgCUjA
         WO+S+bLSr4IyVSzhzf/8H17eGOptMWRHzFQ0lObXvPwUxKupkBgXj1T4tcLu5LZ4KGnW
         6hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724262131; x=1724866931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYBGbx/uYLeIyT2X3cGbSQ5xZpFImUAaykVOvmQ6VX8=;
        b=KAsvOUcy4mvlNIis50rz87gcEZQuOPNq7b3hPtfenuEVt77z5nYSlbDMe26P70wSMI
         QKninRxWvvbRK1rBZIJMtDgfZ4LgNf6RTWEulyW34RAXHviapzM9kF9d2UrUOwxKHvWT
         +WASuEmiCI46/vfLJy0NmdXSzs3yGfnGa2TspHrvFMgTA0qIA0XKvYpCGalOKZJV9xMz
         BeSGCnXUyH4QzACc8i7zaM9wdm791+Xnbf7HfPKuJPv0h0WQm5wAPLkAZfRhz3cgAiUo
         JjEqwxAu2H+Ue7qHXUfJK25yWexWAXJhW6UACtwLdBrziHsSJ37fq1bqjfY/qtjR1eoz
         y2mw==
X-Forwarded-Encrypted: i=1; AJvYcCXUd1EutlppnTb8ptlnjncp38gndlx3gdBHeyOKMee9fPa44WR/rM+QN3a5rXvvj6MiT2/UWobZPD/Vq6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZ3x7cyw5OwVotKIWS7/X4BcFGetw81HzOU6XwdxWZxXZAsxe
	Nx5M5zdaM8a3pmQPD74t10VcSpZWU1rIxX7pcOWQslx6qT3aKyE5ZFVEwnq6FOwaV+Hefq989Ig
	Eq2LQBt/l2Pnr0BunLRpnIP8DNA==
X-Google-Smtp-Source: AGHT+IEINZ4v/d1WW6Yp74ioaOYj+iYeZ3vNSgjypCuHeDr9hlI1StxoI6laD74+nWt/F0LZIxtyzEfuZrIVISG8hNI=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:690c:7406:b0:665:7b0d:ed27 with
 SMTP id 00721157ae682-6c303b0b5c4mr248297b3.2.1724262131250; Wed, 21 Aug 2024
 10:42:11 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:42:08 +0000
In-Reply-To: <20240821-b4-rbtree-v11-0-2ddc66f26972@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240821-b4-rbtree-v11-0-2ddc66f26972@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240821-b4-rbtree-v11-2-2ddc66f26972@google.com>
Subject: [PATCH v11 2/5] rust: rbtree: add iterator
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

- Add Iterator implementation for `RBTree`, allowing
  iteration over (key, value) pairs in key order.
- Add individual `keys()` and `values()` functions to iterate over keys
  or values alone.
- Update doctests to use iteration instead of explicitly getting items.

Iteration is needed by the binder driver to enumerate all values in a
tree for oneway spam detection [1].

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-17-08ba9197f637@google.com/ [1]
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 130 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 51c53a25bc7d..29e7a0795266 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -42,14 +42,30 @@
 ///     assert_eq!(tree.get(&30).unwrap(), &300);
 /// }
 ///
+/// // Iterate over the nodes we just inserted.
+/// {
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
+/// }
+///
+/// // Print all elements.
+/// for (key, value) in &tree {
+///     pr_info!("{} = {}\n", key, value);
+/// }
+///
 /// // Replace one of the elements.
 /// tree.try_create_and_insert(10, 1000, flags::GFP_KERNEL)?;
 ///
 /// // Check that the tree reflects the replacement.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &1000);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &300);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &1000));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Change the value of one of the elements.
@@ -57,9 +73,11 @@
 ///
 /// // Check that the tree reflects the update.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &1000);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &3000);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &1000));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &3000));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Remove an element.
@@ -67,9 +85,10 @@
 ///
 /// // Check that the tree reflects the removal.
 /// {
-///     assert_eq!(tree.get(&10), None);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &3000);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &3000));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// # Ok::<(), Error>(())
@@ -109,9 +128,11 @@
 ///
 /// // Check the nodes we just inserted.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30).unwrap(), &300);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert_eq!(iter.next().unwrap(), (&30, &300));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Remove a node, getting back ownership of it.
@@ -119,9 +140,10 @@
 ///
 /// // Check that the tree reflects the removal.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
-///     assert_eq!(tree.get(&30), None);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// // Create a preallocated reservation that we can re-use later.
@@ -133,9 +155,11 @@
 ///
 /// // Check that the tree reflect the new insertion.
 /// {
-///     assert_eq!(tree.get(&10).unwrap(), &100);
-///     assert_eq!(tree.get(&15).unwrap(), &150);
-///     assert_eq!(tree.get(&20).unwrap(), &200);
+///     let mut iter = tree.iter();
+///     assert_eq!(iter.next().unwrap(), (&10, &100));
+///     assert_eq!(iter.next().unwrap(), (&15, &150));
+///     assert_eq!(iter.next().unwrap(), (&20, &200));
+///     assert!(iter.next().is_none());
 /// }
 ///
 /// # Ok::<(), Error>(())
@@ -167,6 +191,26 @@ pub fn new() -> Self {
             _p: PhantomData,
         }
     }
+
+    /// Returns an iterator over the tree nodes, sorted by key.
+    pub fn iter(&self) -> Iter<'_, K, V> {
+        // INVARIANT: `bindings::rb_first` returns a valid pointer to a tree node given a valid pointer to a tree root.
+        Iter {
+            _tree: PhantomData,
+            // SAFETY: `self.root` is a valid pointer to the tree root.
+            next: unsafe { bindings::rb_first(&self.root) },
+        }
+    }
+
+    /// Returns an iterator over the keys of the nodes in the tree, in sorted order.
+    pub fn keys(&self) -> impl Iterator<Item = &'_ K> {
+        self.iter().map(|(k, _)| k)
+    }
+
+    /// Returns an iterator over the values of the nodes in the tree, sorted by key.
+    pub fn values(&self) -> impl Iterator<Item = &'_ V> {
+        self.iter().map(|(_, v)| v)
+    }
 }
 
 impl<K, V> RBTree<K, V>
@@ -358,6 +402,56 @@ fn drop(&mut self) {
     }
 }
 
+impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
+    type Item = (&'a K, &'a V);
+    type IntoIter = Iter<'a, K, V>;
+
+    fn into_iter(self) -> Self::IntoIter {
+        self.iter()
+    }
+}
+
+/// An iterator over the nodes of a [`RBTree`].
+///
+/// Instances are created by calling [`RBTree::iter`].
+///
+/// # Invariants
+/// - `self.next` is a valid pointer.
+/// - `self.next` points to a node stored inside of a valid `RBTree`.
+pub struct Iter<'a, K, V> {
+    _tree: PhantomData<&'a RBTree<K, V>>,
+    next: *mut bindings::rb_node,
+}
+
+// SAFETY: The [`Iter`] gives out immutable references to K and V, so it has the same
+// thread safety requirements as immutable references.
+unsafe impl<'a, K: Sync, V: Sync> Send for Iter<'a, K, V> {}
+
+// SAFETY: The [`Iter`] gives out immutable references to K and V, so it has the same
+// thread safety requirements as immutable references.
+unsafe impl<'a, K: Sync, V: Sync> Sync for Iter<'a, K, V> {}
+
+impl<'a, K, V> Iterator for Iter<'a, K, V> {
+    type Item = (&'a K, &'a V);
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.next.is_null() {
+            return None;
+        }
+
+        // SAFETY: By the type invariant of `Iter`, `self.next` is a valid node in an `RBTree`,
+        // and by the type invariant of `RBTree`, all nodes point to the links field of `Node<K, V>` objects.
+        let cur = unsafe { container_of!(self.next, Node<K, V>, links) };
+
+        // SAFETY: `self.next` is a valid tree node by the type invariants.
+        self.next = unsafe { bindings::rb_next(self.next) };
+
+        // SAFETY: By the same reasoning above, it is safe to dereference the node. Additionally,
+        // it is ok to return a reference to members because the iterator must outlive it.
+        Some(unsafe { (&(*cur).key, &(*cur).value) })
+    }
+}
+
 /// A memory reservation for a red-black tree node.
 ///
 ///

-- 
2.46.0.184.g6999bdac58-goog


