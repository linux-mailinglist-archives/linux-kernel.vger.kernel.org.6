Return-Path: <linux-kernel+bounces-249507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC92C92EC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F20284999
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64DA16DC00;
	Thu, 11 Jul 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MDOumcr+"
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784E16D9B7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714876; cv=none; b=cCHIZupG7eZ2RUUEZzjOWx2CvLm3Il0ZJnmQFjRzJU2/8HM8aCZ/39FlgM8DqPdy1KyUcqfZm2msKGzPV35edluhAWXbFhGZOfUqSQv82jTNmiHTk+MKaThaXzNAs/lfTp6yJn1ATef7YKYkpbAfkY7XNu6Q/XKjaYukR1iRP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714876; c=relaxed/simple;
	bh=+iMjzdybNqBqXXCjam5FpThUhMMyg6A2oKjNQHWAPHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N7Eo28ER68X3bxwwMNb5q81DjCGG8CVI/vOmj/KtxTgQ9Uv90pidxeNA9ro5/WCC0gpUoaKsCu2XMIaOf2eWpXzqBeIGa4GZ1xQy9ukSBRhSv2K//r8u+ZIBohbWu0ep1T+iRsXmowlny0TZjwZlI2yjH2kgdbGKXszIAlX8pJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MDOumcr+; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4467f700bb4so13219771cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720714874; x=1721319674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rS2L2O0D/9ujxMuhUqLSBo3lLoXXH1VDEl2AcwGhnM=;
        b=MDOumcr+X5qRuCnnEKUTp9h515YEN8k/BwlZpecEutaAlIp8torBSpOPktXQaPnbuU
         d0lvoOvuOduPZUFsRcfgP1QwQrmFK1Sp67T/EFJ/crAEMtHCwubn5pc8vanSwHNU1h9U
         HhVBOdAZXS8iffR6J1V02Vo03h6coeIjHYNwtQx0VsxcC7HPMNcICuZEDH/h4RDFTzPk
         5Wo3GQGW5kLkB8D2Mttf3HQeGjiIWdY3YpLYrA62VvUG42eI4GvxcPRW5m7kEvgRXcu8
         fDwClg+59LQG2Om9O1o9hNhnXPGDmtlvfEo6C8CsDQ7EBL36HRii4OAERvFpqOgREsSF
         pCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714874; x=1721319674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rS2L2O0D/9ujxMuhUqLSBo3lLoXXH1VDEl2AcwGhnM=;
        b=vPRJhocQE+nS8dhJe2D+lvb9rTjeOWwq6mRuwx+MOda6oojvNZCquiSCm3P4MpRFiW
         0ECDZnkZDlJ3XF1SZxREB3yw7Nid3Btoq3yC9Bri2rmaeLE2J2KUA3jqsVOeMlc3xX/c
         fPYc6bYPp+IIMh1SoDWPRNiHcPvdba55KUSzC1CgaFqEoMV9o9G+Fbs07hCMRsrTuwUy
         WVHx6H3u7h3irGiEqOw+71p9hCb/ik46l5Qxr4aXjB+E45J2xSTiRiPLBu/PmjdKrKSI
         uWWQvf2Shq/s5/1Wtoblpl+hAXHPlNw3tBdvkioyOcxCaon7/DsqNge/OY2u2wqG1FAH
         qpGA==
X-Forwarded-Encrypted: i=1; AJvYcCWMpj69yAoEjpApHhQNwmLinZIIABgIdBkdzIEee6znQNrPQw2/iwx7PQu4QVDSzID8DyLeXWq8oofVtnZNwimUnudvMU9ciQxcz9tW
X-Gm-Message-State: AOJu0YzH+K0t1qbD4B0c+Lxrp4WV607b8MKilbfPkusxFLVJmntqrxwp
	+OhPpMttefZhVAnWeZpfT9qO8RAdjh2bTWEE1/Ecb50b2xjP8CK4IBFJ43aCmuba8tz1ojzrGrB
	giR0uOkPZhDSRxvyK6tPZKH4LGA==
X-Google-Smtp-Source: AGHT+IFsKSJand81HJsB482IL+bVTcDYlp8FOZxBQTJoHPmeT261LBWcO7/EdrsYf/ej/U/w4aLjjy6B6V84Yo8Yke0=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:620a:3b16:b0:79f:8aa:a85a with
 SMTP id af79cd13be357-79f19a1fdbamr1722285a.9.1720714873681; Thu, 11 Jul 2024
 09:21:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 16:20:59 +0000
In-Reply-To: <20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240711-b4-rbtree-v6-3-14bef1a8cdba@google.com>
Subject: [PATCH v6 3/6] rust: rbtree: add iterator
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
index a515bfa80113..40db6d3e732b 100644
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
2.45.2.803.g4e1b14247a-goog


