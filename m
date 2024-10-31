Return-Path: <linux-kernel+bounces-391435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B679B86B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA3D1F21502
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC981E47B9;
	Thu, 31 Oct 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7EziEK0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD31CC8AF
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416244; cv=none; b=Qt0WsEOD6M73Wc75SQw7u99Hp/My22qgvPdknjApXiFZFTmxBulBtCbpbdifWEwUH+r+FPhgx6qdRsGXW9B2vRTRjKg5l4/8T9qhZU1Y6K9NIs3il0UYr7VppZM7WfrewLWVWaEdRkSliEgy9Zk9yAeG78klqeIuLH4KyhHeY2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416244; c=relaxed/simple;
	bh=69kvWKlD1ljOOxc/Rkv1VEHjR2Fv0Qive7nBgZf9sY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHZSGjbgR3Wg6iwWHYjrFhh74Zlob2k1gIN9AP7qht05V3Zcl4Z8QbaXQvfWRNPpsnp/Sn4S5g2PGnK7DwRUlYgHJFGROhT48ZlX9X3nigONFMKrdjPo/qUh3KUcKAWF1NqT+pJZcX7QSQAoe7KOGNCWDn59yJzX9M8nxoyoNQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7EziEK0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730416237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FYmU1GYrdZKJraLw100LERJyFohB8EFrmmyYd49xywA=;
	b=H7EziEK0yWK8OF547nzrQ9t9uCb0F5qld1V+M13ZlE/RCpBY61IGCYuY5ljVdaYb2PenBe
	Gog++07mBwq/dsQ9Ktjua99dVd5xsSaO7/GFcKMwv3FO8mvP7iDsBSnUvb2tfbjEVR1Hct
	lZtvNSOQvvt5aKFvvEQigvoTV7285ow=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-wdCnbxWQNI6AryepPlmDbQ-1; Thu,
 31 Oct 2024 19:10:36 -0400
X-MC-Unique: wdCnbxWQNI6AryepPlmDbQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36B5819560B7;
	Thu, 31 Oct 2024 23:10:34 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.202])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C8E931956052;
	Thu, 31 Oct 2024 23:10:30 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Filipe Xavier <felipe_life@live.com>
Subject: [PATCH v3 1/2] rust: sync: Add Lock::from_raw() for Lock<(), B>
Date: Thu, 31 Oct 2024 19:08:44 -0400
Message-ID: <20241031231025.3466571-2-lyude@redhat.com>
In-Reply-To: <20241031231025.3466571-1-lyude@redhat.com>
References: <20241031231025.3466571-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A few of the APIs I've been writing bindings for (KMS in particular) rely
on the user manually acquiring specific locks before calling certain
functions. At the moment though, the only way of acquiring these locks in
bindings is to simply call the C locking functions directly - since said
locks are not acquired on the rust side of things.

However - if we add `#[repr(C)]` to `Lock<(), B>`, then given `()` is a ZST
- `Lock<(), B>` becomes equivalent in data layout to its inner `B::State`
type. Since locks in C don't have data explicitly associated with them
anyway, we can take advantage of this to add a `Lock::from_raw()` function
that can translate a raw pointer to `B::State` into its proper `Lock<(),
B>` equivalent. This lets us simply acquire a reference to the lock in
question and work with it like it was initialized on the rust side of
things, allowing us to use less unsafe code to implement bindings with lock
requirements.

Signed-off-by: Lyude Paul <lyude@redhat.com>

---

V2:
* Don't implement this for all ZST types, just implement it for ()
V3:
* Get rid of some unused imports
* Make sure that we run rustfmt

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 90cc5416529bd..c7b0c6351f793 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -88,6 +88,7 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
 /// [`Backend`] specified as the generic parameter `B`.
+#[repr(C)]
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
     /// The kernel lock object.
@@ -126,6 +127,27 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
     }
 }
 
+impl<B: Backend> Lock<(), B> {
+    /// Constructs a [`Lock`] from a raw pointer.
+    ///
+    /// This can be useful for interacting with a lock which was initialised outside of rust.
+    ///
+    /// # Safety
+    ///
+    /// The caller promises that `ptr` points to a valid initialised instance of [`State`].
+    ///
+    /// [`State`]: Backend::State
+    pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
+        // SAFETY:
+        // * By the safety contract `ptr` must point to a valid initialised instance of `B::State`
+        // * Since the lock data type is `()` which is a ZST, `state` is the only non-ZST member of
+        //   the struct
+        // * Combined with `#[repr(C)]`, this guarantees `Self` has an equivalent data layout to
+        //   `B::State`.
+        unsafe { &*ptr.cast() }
+    }
+}
+
 impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Acquires the lock and gives the caller access to the data protected by it.
     pub fn lock(&self) -> Guard<'_, T, B> {
-- 
2.47.0


