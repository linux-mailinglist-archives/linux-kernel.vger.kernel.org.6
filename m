Return-Path: <linux-kernel+bounces-290306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C65955206
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AEDB2138D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41941C68B0;
	Fri, 16 Aug 2024 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="baI+I4R0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C91C5789
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723841288; cv=none; b=CJpsq3tROl7dOlV7DpWjspMw9mZdconhoq/ZwBlC8itG90yHaf29hEyy4Ao8E09m9eKP4hsTG09O0Pg3v1d2rqlVQRJlLzfp0I70wMKpRb5R7mGi9T3G+g2KZ0EyNQarzJMAmfZ8kLJ2WdY9c5g0mSO6TIEA91v0gWHYkjEZr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723841288; c=relaxed/simple;
	bh=prbzF9A7rp/G33IcXNJKm6tZRhmAfexWxJAHcXVXlYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DL4JHz9TZZXSZrP5KlQVeGYFN4e/uGI7Vwpc4DbbhRE3C+iX13fuFKlGTMv8giuqE8SXHCWrOknXih6HQQWDPeDKB4nE/3T0S+174VJH8dCfMKxlFnfBuEIu6uFBUebnVH7oTS1gHZlgEUwVT+C/u+Qg0rfNIUXEkQ1f0d9TQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=baI+I4R0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0353b731b8so3926324276.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723841286; x=1724446086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CYBGbx/uYLeIyT2X3cGbSQ5xZpFImUAaykVOvmQ6VX8=;
        b=baI+I4R01PsdkegUxkNazl1CABmqY9nnlYaKkd5AvJb3ydYQx7B0SUbJugVj5z6Uu2
         +A67UwpDbUGrzioFRPhM8r4iwpSEZjKuoLWxx0++V+sZ6tz18tyFFjwAadQer7QIqMxv
         QtxptYWb4w4qchF3Me4kDyuDmbd5Usl/M2d+UOGnci6MIRSVr7t3FVRrhXJuKcMmKncW
         ojUKRgzlLvpr2SlBcSfxvJDaZiHf1bqhf6R6ORK+K/qBtZGYB9yQqovkOEfzUekhP6zb
         dpdRi4KYFiMAVwlLDZ/GdwOQtrWsjMhsGu2aIVmVDbx3gX2oQUEasVzhNVscAf8UBvdg
         AuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723841286; x=1724446086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYBGbx/uYLeIyT2X3cGbSQ5xZpFImUAaykVOvmQ6VX8=;
        b=n0z8CAv9o0BkKNi45bvLIWjIIImRhsNl1WN1FZgGIGT+wI7FHpP3kumORykL6ONPfb
         9wactkdAxZFNta6hLQo6w4j153GCdirCnSqNRLIFnJ2Jus/G2PlHOkZvtRcI8F64uO3n
         I7OQ7o68qU7PH27EVpljJdf71ANZjpS/z2fPlyOa8jBtTejuvXu4lrCxXbR+xXtJFIaU
         Ehbos2AM+LQN88vXESkPblkOujrygKNqeINrVH3T1SM0rWhuEvjN9lQPvi2DUOe6iSFS
         vGS1IetYFHS40jy+7FAW8v11rvlj+QPSvCZoTtmLTQ1tDjgtF7ur9ka4UgDDBrmmAQES
         jeow==
X-Forwarded-Encrypted: i=1; AJvYcCUwXve8AgDjhLvGw23NR4VzBV7Dt1fY8Ek8B3E1OC1pt9qJGgZ8GDIO9X49Ax1GG4IbZtd54TLE3Gnpy/nHGVkaYDu9OrGc6pLVQrgK
X-Gm-Message-State: AOJu0YzvOAXPLAOiFggahWBK7WWOWqFgxZqJ6B3xlqBSCCufut509Rtg
	fTwWA6VozkHEdI/5iC2UIYbgcPvINihGknGnaZ4BbtwwvtQdra/yXHI5YUeDcrdOz29UuYk4yWH
	7dQq/K+FzELJ/d52XitzEl8lTKA==
X-Google-Smtp-Source: AGHT+IFGWGXjPlapIMI+q0beoMNWHOobKuxJEyRVUKqmyxFq7ot/YtLvcJBUC5HMMYGbEzKfcgJGUbQ/06ts1TaSr/A=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a25:b206:0:b0:e0b:fa7e:8cbe with SMTP
 id 3f1490d57ef6-e1180fa581fmr5533276.11.1723841285901; Fri, 16 Aug 2024
 13:48:05 -0700 (PDT)
Date: Fri, 16 Aug 2024 20:48:00 +0000
In-Reply-To: <20240816-b4-rbtree-v9-0-425b442af7e5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816-b4-rbtree-v9-0-425b442af7e5@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240816-b4-rbtree-v9-3-425b442af7e5@google.com>
Subject: [PATCH v9 3/6] rust: rbtree: add iterator
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


