Return-Path: <linux-kernel+bounces-292347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 243FD956E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492881C2219D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7BB179953;
	Mon, 19 Aug 2024 15:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQIrjZJh"
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAAF175D5F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080050; cv=none; b=TPhqlvjgqKc9qCQ0swOaQc8f2zQDVmDLo3zpctz85jr6RqZPsTH0MVQFgE0x8zBGet8k9kY59XOZzeYgKjl9wAAnAKBV6j5Ha8n1L5mYkp2hvPXHu3ZYTBnJkZtENGd7SWFPK7SIc6xG+pjm//2ARISGtVVQPUXzyVZJxh+AyG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080050; c=relaxed/simple;
	bh=prbzF9A7rp/G33IcXNJKm6tZRhmAfexWxJAHcXVXlYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dKySbfu5unmtlZAizaSdoi2tTAr3LFN6ISVymNrj41j0Rc4TAY6QLxLRtOMRwtUyVi1lq1ehJO1Nu+PiYOinS6VXeHP83Lr2OUNl6+VvrJVEdKoxDduOTgIiP5sxxA0azOrmn4VJRPwPAKoPWCNRhjx6BEdKQ/VbFp2Sfa0wVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQIrjZJh; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6bf6da864a6so52078476d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724080047; x=1724684847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYBGbx/uYLeIyT2X3cGbSQ5xZpFImUAaykVOvmQ6VX8=;
        b=yQIrjZJhhfaZxR6DrdNqf7OJfKBjOHB4IvwV5VWv/RRtsqwYoKUP+p7bS4ENuXu5RS
         RfyIj0h+YpJ5DCqorlxSBMlQCyZo8T/wzM+4A3Z3yOPYtI+tp7Bp67YFoClhIbLRkIjW
         2ZtwJx2UC3DbxT40QwYMQA30+81ggTH9lE8Tl4Y2FX9zPorSnjOVaLht5GJkfvlvh/VA
         HmsAEEjwVEzB9nkVth3DsaPT/zv9E35SSYPfLNOHggMaw4fhEW5POFchl1v6FB0k875U
         wwcsr9RCPd5iM7kS5BCBBhZ9lHuI1Ws2m1ObiRtf+MhAlEvW8LRy2RYcQGeVjMM72hcE
         v/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724080047; x=1724684847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYBGbx/uYLeIyT2X3cGbSQ5xZpFImUAaykVOvmQ6VX8=;
        b=CylumwrP+3ZSS5PIi3x0B35V0xvDJwRF+iY6PSS+eaAnoJPTDM2WtViOo2X0hR2QIz
         TTag0NdiXrgtlEoX3/r2HmxkYDa7IpaFq5cC1f2L/+vAsYv/TnGntz1+av7qFxvrqDb0
         QZnL2AlfmVf+dp2t+tJ9IXdDn8HHq/q6w6n0ZDhfM9J1VdGnJhvOrcotKkmRBV/UOYeV
         WYHQcvJAyRcfUMX5s9a4MJ9G4edEKd6FQyPJguqcx1Dg/Mq+YiP2T/xu4nfWezNcBYsv
         Uui7ls/yGv2maQ9EZRUaGW/6T0eGcWLMqmj9oP54wCtunEKUNr05s0ozZk/geKs0G1qr
         IerQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8d89Ea4oPZoWiFpJrjWDUxyVFxgrIhcMBcf5RMCvLgJV/KB6nOOxxGtQ90DZVWVJbVv+81wqS1ftdJ9j3bFWioGT5NeucYMwR9mPi
X-Gm-Message-State: AOJu0Ywjk1prWsD082jXhsZj/LiPsaSoFg/lRgHlXnSTzCEOF5WtNs9C
	FG0VNRcXBL/xMCAkCmaaRna9ZlrRFFuqF/mT91FDFV3LzQvcDhha5PaRIVgrM/WEYwMsmfm0YF4
	/rZv2eqe/qE5f6CovUWg+jAb2Ow==
X-Google-Smtp-Source: AGHT+IH8CwNc1AeUg31OWohquZPNxZpUUr0cyhV4RpH3f2FhxI6NTXi3a6nWqOovpY2lzkhR/TJnHA5e2mF3F63mXsQ=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:620a:209c:b0:7a2:a1d:bc95 with
 SMTP id af79cd13be357-7a5068eaabbmr3961285a.3.1724080046963; Mon, 19 Aug 2024
 08:07:26 -0700 (PDT)
Date: Mon, 19 Aug 2024 15:07:10 +0000
In-Reply-To: <20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240819-b4-rbtree-v10-2-3b3b2c4d73af@google.com>
Subject: [PATCH v10 2/5] rust: rbtree: add iterator
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


