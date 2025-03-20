Return-Path: <linux-kernel+bounces-569062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1216DA69E19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A6898283A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B8E1E520A;
	Thu, 20 Mar 2025 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="V1z1PKLJ"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F91E47CC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436546; cv=none; b=OAiPtKJ0E+2yzKpms9eoajw8Y9BlPQ8uddKKRA448wjCpMY/MskLME4D03x8xfYdHwZzjOwpOVw9jDVlgf/gVVXiNQ7prdqVtneX9TAtgpDkS4IE2+wQOVugRBpvybj1xrj6+4s4mMjZLocNxNPSaMfsGVG4zVj0jXp6moYP11o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436546; c=relaxed/simple;
	bh=pi+pEaoyFUXdjUPjWzkFZKes4cJRaD/E2bTgU0j4JhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ths8omCCk8C6Tvq6Gr3/4D00QnQlHisIUKsAmvAvKG0RuPK1EO6TZDMXhmtADkdfjdEORT0gEHwHAGOp8RzL3gv6eYN5A2ixyUAuVIXyKbaEnLg8eSmWVNxdWl6mI55vpL21A4I/8OOC6mQd2GYU/kxRET06NYd21hZF798JLQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=V1z1PKLJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e6405e4ab4dso1270107276.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436542; x=1743041342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOO4dZDi8/uRLLt68uqql0ISlVxWy8Fz1YfUMcxKvPQ=;
        b=V1z1PKLJqNAUsOIXi0p+y2PiPepxpf9IU+Mdu3VzZesPnKxrdWzf3KViSmgoBJVf38
         Pe7bPRZoUPxM88mbtTkw+KDTEOhpyu2TRkiAP1RNSrJSKNOzMk5Jmo+mLLcIMVjQ0v7i
         wutSPL6zKqEWHVRPWHbnt7+SEPOGutfCU/thofWnRP3ys9zk31l8hhpVx3hWT99NDh+5
         7VqvVc1xtu8VzIzHsQ/IuRutSDPO2hqJ2w7hWwLJu7c5bSKUMOHoCTpgt7lgvggvxCTp
         bWQxd6EtOb2F2UZtstsiFkxNdvreCRMSE7LMm4JD/B4vcjvLJk2QBDjSUKLmmLQz8X8S
         hfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436542; x=1743041342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOO4dZDi8/uRLLt68uqql0ISlVxWy8Fz1YfUMcxKvPQ=;
        b=QZ6LsAX84AlNwWBhMiLF8HydFxpR90k7+y0gkSS4bwuuIHlTUgRsfEnODt2gJyYKZ/
         jVrJzYKUbmMozPLmsaz5GIEFYFBnooQBOO0nCX5/9/CDNDYgmcyWdp/4mYsYIK/Bndqo
         PPLd0JtM1pp9n6ziN3IaTHJqpa+pyHBN03z0r7NEtSfcPhdp7UFWzhOg+fCUlUeiLMJq
         HdNHxasBIz+7F6qavltKBsOGXrFOUnFpHIAsvokasP+kMJm9bNNAcvhEqAEKlgvfgJ57
         1yPzvzL7dgfbK40AWAIAoqttquiUJ05McBvU5TlCKQqaxL1oAwZDf+uhn4C2awyMJTu0
         5JrA==
X-Forwarded-Encrypted: i=1; AJvYcCVTPdMBqmrbmVnsGjwaxRRteaFZStW/jQkJJsgqznnAq0xU1tnax0oJBZUUqPC3z+isPzGo593nro7yxeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeJlNyvEViylbyoR0P2OWt+SppxHGdkhVjnzYcJT/tDLxjLAgE
	vUuhVpzuLm8fdbSTcGIzd3n639UXz3aIgvzLJ9APB6bhKierp5tedD89IE+6PJU=
X-Gm-Gg: ASbGncuYHIEbkbjmjK/fS3bzGB3KQ8jtiFsubihG8b5GZDMXgEHIznzC3QHwx94+lwH
	fz5jIXvT7BWm08YutqjEAi8mbx0tmirPlrQBLICo5KgKBVAtXm8t54afE5spjnEiLk5OOHSuZHw
	drMCtDkUnHDuKsEq7BT9uO7GlFTChvplF7KeJd974dVww8SR3Uqr201J0NlwzStuZojq7IE3jq0
	gscCMhVoxMR7VvoYqijc89qkPMUDCaMvM/GzD16iTbelKoIrGNR6n+Vrbf0lQ6qL60qYP47EjQl
	6veMB8Je9bZ0Ar28R004GwsoEmJr3gd+DGRmPgNCW1FFuE6FDRli7B2CbqN2jncpGfVhk4BvlEd
	l7qbpdidChiwu65mK6eUTvi1xAMCzOw==
X-Google-Smtp-Source: AGHT+IEhvT8wohI8NhdtN+MDUk8ZdeHZdhLmwNUSjsDMoy3UxeGn+hyXwvUJy2tt8QkpyK2n5U0WwQ==
X-Received: by 2002:a05:690c:688b:b0:6f9:47ad:f5f1 with SMTP id 00721157ae682-700ab316793mr24224277b3.17.1742436542504;
        Wed, 19 Mar 2025 19:09:02 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:09:02 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/17] rust: rbtree: refactor to use `&raw [const|mut]`
Date: Wed, 19 Mar 2025 22:07:30 -0400
Message-ID: <20250320020740.1631171-12-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of_mut!(place)`
with `&raw mut place`.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw mut` is similar to `&mut`
making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/rbtree.rs | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index 1ea25c7092fb..b0ad35663cb0 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -11,7 +11,7 @@
     cmp::{Ord, Ordering},
     marker::PhantomData,
     mem::MaybeUninit,
-    ptr::{addr_of_mut, from_mut, NonNull},
+    ptr::{from_mut, NonNull},
 };
 
 /// A red-black tree with owned nodes.
@@ -238,7 +238,7 @@ pub fn values_mut(&mut self) -> impl Iterator<Item = &'_ mut V> {
 
     /// Returns a cursor over the tree nodes, starting with the smallest key.
     pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
-        let root = addr_of_mut!(self.root);
+        let root = &raw mut self.root;
         // SAFETY: `self.root` is always a valid root node
         let current = unsafe { bindings::rb_first(root) };
         NonNull::new(current).map(|current| {
@@ -253,7 +253,7 @@ pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
 
     /// Returns a cursor over the tree nodes, starting with the largest key.
     pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
-        let root = addr_of_mut!(self.root);
+        let root = &raw mut self.root;
         // SAFETY: `self.root` is always a valid root node
         let current = unsafe { bindings::rb_last(root) };
         NonNull::new(current).map(|current| {
@@ -459,7 +459,7 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K, V>>
         let best = best_match?;
 
         // SAFETY: `best` is a non-null node so it is valid by the type invariants.
-        let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };
+        let links = unsafe { &raw mut (*best.as_ptr()).links };
 
         NonNull::new(links).map(|current| {
             // INVARIANT:
@@ -767,7 +767,7 @@ pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
         let node = RBTreeNode { node };
         // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
         // the tree cannot change. By the tree invariant, all nodes are valid.
-        unsafe { bindings::rb_erase(&mut (*this).links, addr_of_mut!(self.tree.root)) };
+        unsafe { bindings::rb_erase(&mut (*this).links, &raw mut self.tree.root) };
 
         let current = match (prev, next) {
             (_, Some(next)) => next,
@@ -803,7 +803,7 @@ fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTreeNode<K, V>>
             let neighbor = neighbor.as_ptr();
             // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
             // the tree cannot change. By the tree invariant, all nodes are valid.
-            unsafe { bindings::rb_erase(neighbor, addr_of_mut!(self.tree.root)) };
+            unsafe { bindings::rb_erase(neighbor, &raw mut self.tree.root) };
             // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
             // point to the links field of `Node<K, V>` objects.
             let this = unsafe { container_of!(neighbor, Node<K, V>, links) }.cast_mut();
@@ -918,7 +918,7 @@ unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> (&'b K, *mut
         let k = unsafe { &(*this).key };
         // SAFETY: The passed `node` is the current node or a non-null neighbor,
         // thus `this` is valid by the type invariants.
-        let v = unsafe { addr_of_mut!((*this).value) };
+        let v = unsafe { &raw mut (*this).value };
         (k, v)
     }
 }
@@ -1027,7 +1027,7 @@ fn next(&mut self) -> Option<Self::Item> {
         self.next = unsafe { bindings::rb_next(self.next) };
 
         // SAFETY: By the same reasoning above, it is safe to dereference the node.
-        Some(unsafe { (addr_of_mut!((*cur).key), addr_of_mut!((*cur).value)) })
+        Some(unsafe { (&raw mut (*cur).key, &raw mut (*cur).value) })
     }
 }
 
@@ -1170,7 +1170,7 @@ fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
-        let node_links = unsafe { addr_of_mut!((*node).links) };
+        let node_links = unsafe { &raw mut (*node).links };
 
         // INVARIANT: We are linking in a new node, which is valid. It remains valid because we
         // "forgot" it with `Box::into_raw`.
@@ -1178,7 +1178,7 @@ fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
         unsafe { bindings::rb_link_node(node_links, self.parent, self.child_field_of_parent) };
 
         // SAFETY: All pointers are valid. `node` has just been inserted into the tree.
-        unsafe { bindings::rb_insert_color(node_links, addr_of_mut!((*self.rbtree).root)) };
+        unsafe { bindings::rb_insert_color(node_links, &raw mut (*self.rbtree).root) };
 
         // SAFETY: The node is valid until we remove it from the tree.
         unsafe { &mut (*node).value }
@@ -1261,7 +1261,7 @@ fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
 
         // SAFETY: `node` is valid at least until we call `Box::from_raw`, which only happens when
         // the node is removed or replaced.
-        let new_node_links = unsafe { addr_of_mut!((*node).links) };
+        let new_node_links = unsafe { &raw mut (*node).links };
 
         // SAFETY: This updates the pointers so that `new_node_links` is in the tree where
         // `self.node_links` used to be.


