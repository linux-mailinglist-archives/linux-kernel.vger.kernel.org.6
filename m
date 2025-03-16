Return-Path: <linux-kernel+bounces-562893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AF6A63442
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C11A172E58
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AF5194096;
	Sun, 16 Mar 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="pSNfKSSL"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBF193425
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106046; cv=none; b=uLliAhpLnSxuL/wMu//b2ZVWVQIjXMYLVOOhgFq/ZWE225R0V6DpCfACikpWSX7XpKaWBct0zu4rhXkTloN74Tg2j2jlk5JZ0X/jvEWhpipio1ad1ZIt3m0vcyzKQXytwZnFGJt9u1rsL2adYKNgQXHDWSM63uSjC58WT1Tr2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106046; c=relaxed/simple;
	bh=QPOFwZHtH2bm3PMPve3G3ymYu6EUUPtMjAkdSJMFOF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQpDqcjgj9Z1V0MJrBvxlxVcF+ThtI5GaasN/oY/IcIn7pzuXJiA5CQnQBPR5AWBtEzjOHytSWllW3zCbr/Ds1E6cPmWYI2eCknYc95X456bIWmIiLrpD2I8X67X9aiClicU76Ok232RCLrvoLuPetqq8lIpyi8GVD9RwyCWh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=pSNfKSSL; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e637669ef11so2609147276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106044; x=1742710844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j40J60/8dwJtQ0qumDuP3ZSYTIG5oq9pHnoWFccPBEI=;
        b=pSNfKSSL7tXHcU3dA6bMinNKACoykZ3xkZ2YIF7dsVx4bLbyea4kPH18+S7/qTym9F
         /vJGU6h+1x+T9L/SI9tAg54IIbwcYWDp4WaSVO6bKO2v4ydXdHMKNcW7cDWy4Ezlo/0C
         nuyfuqczPwgys53TcVxtcBHIvHmZQw5EaeRoI66sou/gM1CceQc8yuC3d4oiS69/41+u
         87tzCszEmflHviGB9RMHh0dBB6HYprh34XAHUszXrKNquWNI/njEkJGnDzyjbqJUie9S
         qJVDzCXt34f+2z5WxmVfsUtlVDYEPJRb7dRB82a81H4Z7KTmURreVA96/Dloezat09NH
         wyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106044; x=1742710844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j40J60/8dwJtQ0qumDuP3ZSYTIG5oq9pHnoWFccPBEI=;
        b=EZElL/FL0fxRcRioHFC8YY9GGp6n3gbwK/3ENhtmG5OKST9KZuJbB3/h85nUOkvlLA
         YHgZD3fDK/Dotefv0xU5IiuzB8+HAW+DqFw+fqz5plxosYCMTeFgGxdJ1hd1IjM0xpAS
         gfA6qsp1uBe4vmN4ncAvXYAg+X5QFOlRtntUkDgByV9xOCdFgimjY2jgkPAxufmauU2X
         ZJxjgW5+vZE+SpdiC7Youw7GKIMh9KcT2ucvr7PsC/VU1hHJaOyQlMI/SzT6nz415YtU
         LfbjAGKycADWmaIYZNY879cYRLH3oN0EK0rPC5mKf3LX6lKuiQPWcoBDQs9Zvtb5OAxo
         Hwng==
X-Forwarded-Encrypted: i=1; AJvYcCXZtugnzWO2jlmyePjkpKg9G/XihuI0NBARSHQM0Sn28baQZ1gz4qQnJqA4URlS1BNncEMxxu5dGYhyRfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtc9l69hTwjC3CXd2yNOJwHx5aTPdTwwIifd8W7oxBbIzuyNDB
	J8JDdYw5AebKXwCpssPbJP+SxgPkLhowF7bin+S7hRWNbf7OJapj1FyJsXfPB2k=
X-Gm-Gg: ASbGncsooWdbnt9KyEs6HbB9hxQkjP4Z+8j5Qrv4PNBwHWLzuOWW3P8Lsnl+MU4iTyp
	5LS9kiq0IX6HDelR10eNQ8GOLDso83LRyLCvNnAO+xKW2vcrq0SpnIlHbdikAYDjhHnnuBD7y1Z
	tbNbBOQzCk9AnpbLDQR2oq0oXvJ/C8jkKhi9ffD5kIscOT57+Fqvmc059FUsDg1G8e9OgjRl28v
	+yE0Vam5/beo7r2VnSAv3k067eRFsohbnAUUZgGLKHzEo4vzLW4a0X0MNnzX0ez/9OgoBHZ1pvV
	GzUPKdiGprPiaBoBGmeuGNd7Do9R8yZ8SSB9+6U8pWOSilxq0WXmXuUG6AFmbzQ+6CPx+G0sjdz
	aOQrlWnquwG/ehIjFK0i7kPbVvvBcIA==
X-Google-Smtp-Source: AGHT+IE/mTvXMqV0s/+LHXzvohwhDqn7W1S2amsuiM3yQZid97d7VNvCS3Mt3LbK4hZ/6Uo8uc/+mg==
X-Received: by 2002:a05:6902:cc5:b0:e63:d10e:edc1 with SMTP id 3f1490d57ef6-e63f64d661emr10880244276.3.1742106043897;
        Sat, 15 Mar 2025 23:20:43 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:43 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v4 10/16] rust: rbtree: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:19 -0400
Message-ID: <20250316061429.817126-11-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

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
-- 
2.48.1


