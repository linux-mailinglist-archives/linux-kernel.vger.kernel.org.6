Return-Path: <linux-kernel+bounces-297661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EC95BC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 695AEB26E41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351851CEAB5;
	Thu, 22 Aug 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Udk1tCez"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38A1CDFC3
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344688; cv=none; b=F7vDt5XKjYFN+iEZ8tOqHOBSqbTPdDBXB/mwEI7yDSfuHUg6igC3LsYOMcOk6dyc2U1ZFyqe9rmhEMJjj+UQZSSZ+GrlShaC9jQ3vbwp5L9fanobYjbL58NrsmitFt3ZpqZZW+8xZpum9wymnDJn5Mhs9Yg7+0ZphmSpQDR6qlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344688; c=relaxed/simple;
	bh=YgKn5khTTKcwOx9H0hS7K13qF7UIOUhQSQ/hdU1d8hY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MaT9b8zKJ4eQ7cjE//MJ7+YZwk/PW+CsEXwZHnaf8IXEi9GjoyfGSfViQ1J8zMSGgglb/cZKyShBnSld4kfdD8RG3rXWrBn2pDfD5/99ai3dXEve7xuyM45+XwHpAQb15YUlSCnWL0F6/GZVf0Bd37ehhpzbPlDRRBBI7IndIrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Udk1tCez; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6adcb88da08so20730467b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724344685; x=1724949485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+zGnoEDVTcDu21K2SzRSopFqVX5Jo8WnkO9z4RZNQE=;
        b=Udk1tCez02EOqXHR9epPFzZzcxfpNW3yt2jvYZ6KAhM9t2Pc6/28nIZDxcNn6gHoAi
         /EjkhMVoxVwrfmqCBHe3q9BIv9Uv8WqUI762BTC3zT0s4cSgs70CKVSBaO1OrocfrJdO
         OWjhJABctFM+SrJodaEQAE/Qm/fZ2Tf1d9CqQ+7+M2qkmdMy1M04OIzcKaoaP2L3hdAn
         fkWxZGZD3Gq8sqJQKRRgF2JR6LTt0nXsHKvBdGxNFTw/M3CYkCx4LUcuM5mP9zgHvKN1
         J1og6mT2wlvHS8BmXKJjsm7aSpWAZy6tDWQrBL6vHOGOvwjM34kQgfBBlPdrnUt1o1zd
         CC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344685; x=1724949485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+zGnoEDVTcDu21K2SzRSopFqVX5Jo8WnkO9z4RZNQE=;
        b=BKL87O95DhZ6d8b6t/Fp9l7LnZ2ae1f4tAgBu2TCAWQkdChZWWTb+XfoD2AYIEhg/G
         VHFC2vE42qOmaMCMfQLUD+YS0yY79Qobewaexf3vrfZOzjOIwhuam0iaqmNJQrLDx+7f
         1+fMcMX8TLyk+5SEe8zpDYyMuoPaCG4Ikws0LSJ71A76LPi9p4XK5uw04BaHbHIbSNIN
         LnaBDLbWRnH3h2Z8S1hBQx1HzlChtLHfEY0pA7zAGPGdo4vrC4iLdAfwxPB2zDoaCs3p
         3nDrXn6fxlQ82HPVhp0d5dHinPVlHTZYk33VaGzSjiqVaSt/whg/yxEi8hbYAMFOr+HU
         raFg==
X-Forwarded-Encrypted: i=1; AJvYcCVDSK8L9oQqWXO3JcfLrNvkbM0c7i/73yg4a5cInqvQU7CxD9s4Ph7TbXplH/xXqg4HgCStyQWGxWwiu8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/9a+osC7zV+Jl7mOw2UMkgzIthaewA5TFjYCSPCzJIU2hulR
	lHmxxAiy7hIpdzKDf+91AecQlES3txbBZbGXYoHDagdtbgy0SM9+kOKQRqCdUkXg9xa9j9Pup+c
	PKXVSowi6NfwYzYQB5KAegOUGeQ==
X-Google-Smtp-Source: AGHT+IEfr+ug11zztxt8seW5OZWZZYOq63HD4SqnNb60NX9b73fNHgyWl2r4DwSmKRXvyzdlAaAO8/SxaFtdyGHkIKA=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:690c:688e:b0:691:41f5:7f42 with
 SMTP id 00721157ae682-6c09effbe95mr4267857b3.4.1724344685168; Thu, 22 Aug
 2024 09:38:05 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:37:57 +0000
In-Reply-To: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
X-Mailer: b4 0.13.0
Message-ID: <20240822-b4-rbtree-v12-5-014561758a57@google.com>
Subject: [PATCH v12 5/5] rust: rbtree: add `RBTree::entry`
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

From: Alice Ryhl <aliceryhl@google.com>

This mirrors the entry API [1] from the Rust standard library on
`RBTree`. This API can be used to access the entry at a specific key and
make modifications depending on whether the key is vacant or occupied.
This API is useful because it can often be used to avoid traversing the
tree multiple times.

This is used by binder to look up and conditionally access or insert a
value, depending on whether it is there or not [2].

Link: https://doc.rust-lang.org/stable/std/collections/btree_map/enum.Entry.html [1]
Link: https://android-review.googlesource.com/c/kernel/common/+/2849906 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/rbtree.rs | 305 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 230 insertions(+), 75 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index fcf0d756c5be..84d08a321495 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -293,12 +293,19 @@ pub fn try_create_and_insert(
     /// key/value pair). Returns [`None`] if a node with the same key didn't already exist.
     ///
     /// This function always succeeds.
-    pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>> {
-        let node = Box::into_raw(node);
-        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
-        // the node is removed or replaced.
-        let node_links = unsafe { addr_of_mut!((*node).links) };
+    pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNode<K, V>> {
+        match self.raw_entry(&node.node.key) {
+            RawEntry::Occupied(entry) => Some(entry.replace(node)),
+            RawEntry::Vacant(entry) => {
+                entry.insert(node);
+                None
+            }
+        }
+    }
 
+    fn raw_entry(&mut self, key: &K) -> RawEntry<'_, K, V> {
+        let raw_self: *mut RBTree<K, V> = self;
+        // The returned `RawEntry` is used to call either `rb_link_node` or `rb_replace_node`.
         // The parameters of `bindings::rb_link_node` are as follows:
         // - `node`: A pointer to an uninitialized node being inserted.
         // - `parent`: A pointer to an existing node in the tree. One of its child pointers must be
@@ -317,62 +324,56 @@ pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) -> Option<RBTree
         // in the subtree of `parent` that `child_field_of_parent` points at. Once
         // we find an empty subtree, we can insert the new node using `rb_link_node`.
         let mut parent = core::ptr::null_mut();
-        let mut child_field_of_parent: &mut *mut bindings::rb_node = &mut self.root.rb_node;
-        while !child_field_of_parent.is_null() {
-            parent = *child_field_of_parent;
+        let mut child_field_of_parent: &mut *mut bindings::rb_node =
+            // SAFETY: `raw_self` is a valid pointer to the `RBTree` (created from `self` above).
+            unsafe { &mut (*raw_self).root.rb_node };
+        while !(*child_field_of_parent).is_null() {
+            let curr = *child_field_of_parent;
+            // SAFETY: All links fields we create are in a `Node<K, V>`.
+            let node = unsafe { container_of!(curr, Node<K, V>, links) };
 
-            // We need to determine whether `node` should be the left or right child of `parent`,
-            // so we will compare with the `key` field of `parent` a.k.a. `this` below.
-            //
-            // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
-            // point to the links field of `Node<K, V>` objects.
-            let this = unsafe { container_of!(parent, Node<K, V>, links) };
-
-            // SAFETY: `this` is a non-null node so it is valid by the type invariants. `node` is
-            // valid until the node is removed.
-            match unsafe { (*node).key.cmp(&(*this).key) } {
-                // We would like `node` to be the left child of `parent`.  Move to this child to check
-                // whether we can use it, or continue searching, at the next iteration.
-                //
-                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
-                Ordering::Less => child_field_of_parent = unsafe { &mut (*parent).rb_left },
-                // We would like `node` to be the right child of `parent`.  Move to this child to check
-                // whether we can use it, or continue searching, at the next iteration.
-                //
-                // SAFETY: `parent` is a non-null node so it is valid by the type invariants.
-                Ordering::Greater => child_field_of_parent = unsafe { &mut (*parent).rb_right },
+            // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+            match key.cmp(unsafe { &(*node).key }) {
+                // SAFETY: `curr` is a non-null node so it is valid by the type invariants.
+                Ordering::Less => child_field_of_parent = unsafe { &mut (*curr).rb_left },
+                // SAFETY: `curr` is a non-null node so it is valid by the type invariants.
+                Ordering::Greater => child_field_of_parent = unsafe { &mut (*curr).rb_right },
                 Ordering::Equal => {
-                    // There is an existing node in the tree with this key, and that node is
-                    // `parent`. Thus, we are replacing parent with a new node.
-                    //
-                    // INVARIANT: We are replacing an existing node with a new one, which is valid.
-                    // It remains valid because we "forgot" it with `Box::into_raw`.
-                    // SAFETY: All pointers are non-null and valid.
-                    unsafe { bindings::rb_replace_node(parent, node_links, &mut self.root) };
-
-                    // INVARIANT: The node is being returned and the caller may free it, however,
-                    // it was removed from the tree. So the invariants still hold.
-                    return Some(RBTreeNode {
-                        // SAFETY: `this` was a node in the tree, so it is valid.
-                        node: unsafe { Box::from_raw(this.cast_mut()) },
-                    });
+                    return RawEntry::Occupied(OccupiedEntry {
+                        rbtree: self,
+                        node_links: curr,
+                    })
                 }
             }
+            parent = curr;
         }
 
-        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
-        // "forgot" it with `Box::into_raw`.
-        // SAFETY: All pointers are non-null and valid (`*child_field_of_parent` is null, but `child_field_of_parent` is a
-        // mutable reference).
-        unsafe { bindings::rb_link_node(node_links, parent, child_field_of_parent) };
+        RawEntry::Vacant(RawVacantEntry {
+            rbtree: raw_self,
+            parent,
+            child_field_of_parent,
+            _phantom: PhantomData,
+        })
+    }
 
-        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
-        unsafe { bindings::rb_insert_color(node_links, &mut self.root) };
-        None
+    /// Gets the given key's corresponding entry in the map for in-place manipulation.
+    pub fn entry(&mut self, key: K) -> Entry<'_, K, V> {
+        match self.raw_entry(&key) {
+            RawEntry::Occupied(entry) => Entry::Occupied(entry),
+            RawEntry::Vacant(entry) => Entry::Vacant(VacantEntry { raw: entry, key }),
+        }
+    }
+
+    /// Used for accessing the given node, if it exists.
+    pub fn find_mut(&mut self, key: &K) -> Option<OccupiedEntry<'_, K, V>> {
+        match self.raw_entry(key) {
+            RawEntry::Occupied(entry) => Some(entry),
+            RawEntry::Vacant(_entry) => None,
+        }
     }
 
-    /// Returns a node with the given key, if one exists.
-    fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
+    /// Returns a reference to the value corresponding to the key.
+    pub fn get(&self, key: &K) -> Option<&V> {
         let mut node = self.root.rb_node;
         while !node.is_null() {
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
@@ -384,47 +385,30 @@ fn find(&self, key: &K) -> Option<NonNull<Node<K, V>>> {
                 Ordering::Less => unsafe { (*node).rb_left },
                 // SAFETY: `node` is a non-null node so it is valid by the type invariants.
                 Ordering::Greater => unsafe { (*node).rb_right },
-                Ordering::Equal => return NonNull::new(this.cast_mut()),
+                // SAFETY: `node` is a non-null node so it is valid by the type invariants.
+                Ordering::Equal => return Some(unsafe { &(*this).value }),
             }
         }
         None
     }
 
-    /// Returns a reference to the value corresponding to the key.
-    pub fn get(&self, key: &K) -> Option<&V> {
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        self.find(key).map(|node| unsafe { &node.as_ref().value })
-    }
-
     /// Returns a mutable reference to the value corresponding to the key.
     pub fn get_mut(&mut self, key: &K) -> Option<&mut V> {
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        self.find(key)
-            .map(|mut node| unsafe { &mut node.as_mut().value })
+        self.find_mut(key).map(|node| node.into_mut())
     }
 
     /// Removes the node with the given key from the tree.
     ///
     /// It returns the node that was removed if one exists, or [`None`] otherwise.
-    fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
-        let mut node = self.find(key)?;
-
-        // SAFETY: The `find` return value is a node in the tree, so it is valid.
-        unsafe { bindings::rb_erase(&mut node.as_mut().links, &mut self.root) };
-
-        // INVARIANT: The node is being returned and the caller may free it, however, it was
-        // removed from the tree. So the invariants still hold.
-        Some(RBTreeNode {
-            // SAFETY: The `find` return value was a node in the tree, so it is valid.
-            node: unsafe { Box::from_raw(node.as_ptr()) },
-        })
+    pub fn remove_node(&mut self, key: &K) -> Option<RBTreeNode<K, V>> {
+        self.find_mut(key).map(OccupiedEntry::remove_node)
     }
 
     /// Removes the node with the given key from the tree.
     ///
     /// It returns the value that was removed if one exists, or [`None`] otherwise.
     pub fn remove(&mut self, key: &K) -> Option<V> {
-        self.remove_node(key).map(|node| node.node.value)
+        self.find_mut(key).map(OccupiedEntry::remove)
     }
 
     /// Returns a cursor over the tree nodes based on the given key.
@@ -1117,6 +1101,177 @@ unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
 // [`RBTreeNode`] without synchronization.
 unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}
 
+impl<K, V> RBTreeNode<K, V> {
+    /// Drop the key and value, but keep the allocation.
+    ///
+    /// It then becomes a reservation that can be re-initialised into a different node (i.e., with
+    /// a different key and/or value).
+    ///
+    /// The existing key and value are dropped in-place as part of this operation, that is, memory
+    /// may be freed (but only for the key/value; memory for the node itself is kept for reuse).
+    pub fn into_reservation(self) -> RBTreeNodeReservation<K, V> {
+        RBTreeNodeReservation {
+            node: Box::drop_contents(self.node),
+        }
+    }
+}
+
+/// A view into a single entry in a map, which may either be vacant or occupied.
+///
+/// This enum is constructed from the [`RBTree::entry`].
+///
+/// [`entry`]: fn@RBTree::entry
+pub enum Entry<'a, K, V> {
+    /// This [`RBTree`] does not have a node with this key.
+    Vacant(VacantEntry<'a, K, V>),
+    /// This [`RBTree`] already has a node with this key.
+    Occupied(OccupiedEntry<'a, K, V>),
+}
+
+/// Like [`Entry`], except that it doesn't have ownership of the key.
+enum RawEntry<'a, K, V> {
+    Vacant(RawVacantEntry<'a, K, V>),
+    Occupied(OccupiedEntry<'a, K, V>),
+}
+
+/// A view into a vacant entry in a [`RBTree`]. It is part of the [`Entry`] enum.
+pub struct VacantEntry<'a, K, V> {
+    key: K,
+    raw: RawVacantEntry<'a, K, V>,
+}
+
+/// Like [`VacantEntry`], but doesn't hold on to the key.
+///
+/// # Invariants
+/// - `parent` may be null if the new node becomes the root.
+/// - `child_field_of_parent` is a valid pointer to the left-child or right-child of `parent`. If `parent` is
+///     null, it is a pointer to the root of the [`RBTree`].
+struct RawVacantEntry<'a, K, V> {
+    rbtree: *mut RBTree<K, V>,
+    /// The node that will become the parent of the new node if we insert one.
+    parent: *mut bindings::rb_node,
+    /// This points to the left-child or right-child field of `parent`, or `root` if `parent` is
+    /// null.
+    child_field_of_parent: *mut *mut bindings::rb_node,
+    _phantom: PhantomData<&'a mut RBTree<K, V>>,
+}
+
+impl<'a, K, V> RawVacantEntry<'a, K, V> {
+    /// Inserts the given node into the [`RBTree`] at this entry.
+    ///
+    /// The `node` must have a key such that inserting it here does not break the ordering of this
+    /// [`RBTree`].
+    fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
+        let node = Box::into_raw(node.node);
+
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let node_links = unsafe { addr_of_mut!((*node).links) };
+
+        // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
+        // "forgot" it with `Box::into_raw`.
+        // SAFETY: The type invariants of `RawVacantEntry` are exactly the safety requirements of `rb_link_node`.
+        unsafe { bindings::rb_link_node(node_links, self.parent, self.child_field_of_parent) };
+
+        // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
+        unsafe { bindings::rb_insert_color(node_links, addr_of_mut!((*self.rbtree).root)) };
+
+        // SAFETY: The node is valid until we remove it from the tree.
+        unsafe { &mut (*node).value }
+    }
+}
+
+impl<'a, K, V> VacantEntry<'a, K, V> {
+    /// Inserts the given node into the [`RBTree`] at this entry.
+    pub fn insert(self, value: V, reservation: RBTreeNodeReservation<K, V>) -> &'a mut V {
+        self.raw.insert(reservation.into_node(self.key, value))
+    }
+}
+
+/// A view into an occupied entry in a [`RBTree`]. It is part of the [`Entry`] enum.
+///
+/// # Invariants
+/// - `node_links` is a valid, non-null pointer to a tree node in `self.rbtree`
+pub struct OccupiedEntry<'a, K, V> {
+    rbtree: &'a mut RBTree<K, V>,
+    /// The node that this entry corresponds to.
+    node_links: *mut bindings::rb_node,
+}
+
+impl<'a, K, V> OccupiedEntry<'a, K, V> {
+    /// Gets a reference to the value in the entry.
+    pub fn get(&self) -> &V {
+        // SAFETY:
+        // - `self.node_links` is a valid pointer to a node in the tree.
+        // - We have shared access to the underlying tree, and can thus give out a shared reference.
+        unsafe { &(*container_of!(self.node_links, Node<K, V>, links)).value }
+    }
+
+    /// Gets a mutable reference to the value in the entry.
+    pub fn get_mut(&mut self) -> &mut V {
+        // SAFETY:
+        // - `self.node_links` is a valid pointer to a node in the tree.
+        // - We have exclusive access to the underlying tree, and can thus give out a mutable reference.
+        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links).cast_mut())).value }
+    }
+
+    /// Converts the entry into a mutable reference to its value.
+    ///
+    /// If you need multiple references to the `OccupiedEntry`, see [`self#get_mut`].
+    pub fn into_mut(self) -> &'a mut V {
+        // SAFETY:
+        // - `self.node_links` is a valid pointer to a node in the tree.
+        // - This consumes the `&'a mut RBTree<K, V>`, therefore it can give out a mutable reference that lives for `'a`.
+        unsafe { &mut (*(container_of!(self.node_links, Node<K, V>, links).cast_mut())).value }
+    }
+
+    /// Remove this entry from the [`RBTree`].
+    pub fn remove_node(self) -> RBTreeNode<K, V> {
+        // SAFETY: The node is a node in the tree, so it is valid.
+        unsafe { bindings::rb_erase(self.node_links, &mut self.rbtree.root) };
+
+        // INVARIANT: The node is being returned and the caller may free it, however, it was
+        // removed from the tree. So the invariants still hold.
+        RBTreeNode {
+            // SAFETY: The node was a node in the tree, but we removed it, so we can convert it
+            // back into a box.
+            node: unsafe {
+                Box::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut())
+            },
+        }
+    }
+
+    /// Takes the value of the entry out of the map, and returns it.
+    pub fn remove(self) -> V {
+        self.remove_node().node.value
+    }
+
+    /// Swap the current node for the provided node.
+    ///
+    /// The key of both nodes must be equal.
+    fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
+        let node = Box::into_raw(node.node);
+
+        // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
+        // the node is removed or replaced.
+        let new_node_links = unsafe { addr_of_mut!((*node).links) };
+
+        // SAFETY: This updates the pointers so that `new_node_links` is in the tree where
+        // `self.node_links` used to be.
+        unsafe {
+            bindings::rb_replace_node(self.node_links, new_node_links, &mut self.rbtree.root)
+        };
+
+        // SAFETY:
+        // - `self.node_ptr` produces a valid pointer to a node in the tree.
+        // - Now that we removed this entry from the tree, we can convert the node to a box.
+        let old_node =
+            unsafe { Box::from_raw(container_of!(self.node_links, Node<K, V>, links).cast_mut()) };
+
+        RBTreeNode { node: old_node }
+    }
+}
+
 struct Node<K, V> {
     links: bindings::rb_node,
     key: K,

-- 
2.46.0.184.g6999bdac58-goog


