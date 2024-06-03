Return-Path: <linux-kernel+bounces-199408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B36F48D86E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FED1C216B2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E613666F;
	Mon,  3 Jun 2024 16:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTyb5s3E"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B044F136663
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430731; cv=none; b=Uhq4239zpLv7/MzuirRntjs9LRooi3bNisoGkPdYeFMavpYS6+31pHWEZznUdLM084aXE9MSYUeO+rpcZrSDUiOqjw5kiOSU3ZCW4Pa8WUFCQYrPjxkbkACEfglM+gCYty8g3u3ieb9R5kRY8vG8LJNcFO9KUP9ZJJ8iw4ApT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430731; c=relaxed/simple;
	bh=3OYBXu3JmXTxowje7u9YRJ3AwCID6d8MnuzpRKwv7LQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9XGPLw+4RJ51T9sd+xb1zS6VZCKrcNEqyYGwKYtK09b30wBhJCp9mcWySn4XMJkK3nS6652k07s9beKfy5dAyFhXKYeu+41O5Lrv2PTEfZsUokS2wtOCei9XvnZSNrkDPtW18NO+jE8uE8T+iYkk1+Gmu1Y+hEaYfS+L2XWgo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTyb5s3E; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa77d54cd2so5247984276.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717430729; x=1718035529; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6paZo5N2Bj7KOX0jnQD83qN0s5hUal/Z6c5JFeBhY+4=;
        b=XTyb5s3E6itdT9kuxWQhlgSusIRozmTSpe/trO29KBh225SCkFzt3F2ZkIi+7S3IBf
         QYwmS9lLvBEFCDNhjikTeV88JsFp833V1LH1KXiiWmQ3P2EAF2U+cc5ZO9mbRHLPC/NZ
         9aAwDgQ08eTlTm6/j/XMSOYO990oQbN0q+AITcQKQ2f3yV4FIwbS5OLDG+kMPDpxmlNV
         1yzDhZdCOYE+PZ7X8FUqldDJzcX7xFJ6RIwgUXK7wT0Q4BldBG1PzUnlv84obeCMT8H4
         o1t/BGY0PfBmyj47sHYK0uy9nT4vFm/9Fc2n8MRIf3wZmnzlqvVJLWMPivfQylIlR2f/
         o6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430729; x=1718035529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6paZo5N2Bj7KOX0jnQD83qN0s5hUal/Z6c5JFeBhY+4=;
        b=Wv2nY1uS3x0yt4Z6uKeTRKGQFj7CuoiNdML0dWmk7u6yf1fLxB94gLiwRz8I5+TCJD
         TfWEVVtBMbxEADxwDTYSd1yupL38TXG21Fo/pleJrH6IdtZriE5VYkgqSWsSpTtUP4Gv
         unD6bO8RCLA0VysDk21WF8dPp7fnCZrCYRyT/Vz8kxkj7cr7NjpOGhdjs6RsvQ4d7pvB
         7UIZSamZES6FhqQMcQC/TxSDDjBrGYDaDZepn3iL7IHl+BKDFM0knzgUby7LRycugvWI
         /Ki5CvOkJOl1SOM234Pv2F5zxX69KRWJgk0tIda430x5/KgQJiusuvgf4EHOL/Aq1iqD
         +yvg==
X-Forwarded-Encrypted: i=1; AJvYcCWhoCpJpBDxkv5EhZ+sX0o76BL22YEpEcpVzvWgNe34va5YW1nxpV8dvuZwuplGs5aemmxs1DlCiqviQueW2elB9oqSYWhm4gR1mnCw
X-Gm-Message-State: AOJu0Yxm2QbGaRs7duGjcM7KtMk6YIzIMJdmLsuL3QPSvDcCeEEzXhBR
	K7wZjtFM5ilAqz/VsmaJLz721NUYQWkTB/zvxJmx6RxoU6B1XQTvDkRKcr1B3o2uQDX1iiBveTN
	CoCc7qvA15StUaaXNL5anbV/7WA==
X-Google-Smtp-Source: AGHT+IHaay9T4RlB/0VRBDU2er4eaV5yp9Ba7mEyxwYy+VPvirMdOQlOybQK1uimrd+1d4jexFUkGP6bxbq9YwZ5ek0=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:2b85:b0:df4:dfce:ba0 with
 SMTP id 3f1490d57ef6-dfa73db4ca7mr1013253276.11.1717430728839; Mon, 03 Jun
 2024 09:05:28 -0700 (PDT)
Date: Mon, 03 Jun 2024 16:05:18 +0000
In-Reply-To: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240603-b4-rbtree-v4-3-308e43d6abfc@google.com>
Subject: [PATCH v4 3/6] rust: rbtree: add iterator
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
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 130 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 112 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 6c4e259f7516..6ebea833e5a9 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -47,14 +47,30 @@
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
@@ -62,9 +78,11 @@
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
@@ -72,9 +90,10 @@
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
@@ -114,9 +133,11 @@
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
@@ -124,9 +145,10 @@
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
@@ -138,9 +160,11 @@
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
2.45.1.288.g0e0cd299f1-goog


