Return-Path: <linux-kernel+bounces-415030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190839D30D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE75283EC2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903521D61AF;
	Tue, 19 Nov 2024 23:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQTALvVR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032791D47DC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732057924; cv=none; b=SFgDMGOfIMujR2yaC5vtZEDLzXgXTh3c9auNqxUHkAUvSGt/RK/AHeYKPJ3m0HeYHauNhg9jxvJTkn7yLAarnDssQpBYvxDtBtWcbmvvs6/Devu+SBvUET1PcNsD3uhmZGgvC4q4A1Rs/kk83wNer6mLc/MqpQwd+BVOrgdH+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732057924; c=relaxed/simple;
	bh=mDrVfKm68H9Lt8M5M2TJ9UWUgDhY0gs8uSoapCQIRl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddBIUO4OAxGA7fpGcgyncIV4564TF2ym8zKrBc9MC1yip32HsFmqc5F8yFb+/Bh3YuHGCltMdAs0Em5ZYYhdNawjv0qRzkt61403MK1+O5d0qsP/MgH3/Tyuok1DFTiRvm1pUI13AAa0FYQGDG3qWyaBb/gCsXEQGdaV/X3/ixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQTALvVR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732057921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irOV6jSVhz78wp4LVQsCSePNnXVEznkS8FVGwjEs6IY=;
	b=NQTALvVRjF3l1X8M+YvVkyCZRO/TAHtTh2SskgL7sK3OIjSlDNadnX4LS0Rg+N9QUyhWIV
	WGM059aeX/MVRhEHzzfzIk8ihBS7YFIpMv7P3UXs/iTYZgecisNyG7ujU7tYh6GOIcI/tN
	zw8Pgr+m8G2wW9I26myG5vqbJp0UHMQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-FdhaoK23NjOZjd1XhoIAJA-1; Tue,
 19 Nov 2024 18:11:57 -0500
X-MC-Unique: FdhaoK23NjOZjd1XhoIAJA-1
X-Mimecast-MFC-AGG-ID: FdhaoK23NjOZjd1XhoIAJA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A4081955F45;
	Tue, 19 Nov 2024 23:11:55 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.23])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7D8C30000DF;
	Tue, 19 Nov 2024 23:11:52 +0000 (UTC)
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
Subject: [PATCH v4 1/2] rust: sync: Add Lock::from_raw() for Lock<(), B>
Date: Tue, 19 Nov 2024 18:11:03 -0500
Message-ID: <20241119231146.2298971-2-lyude@redhat.com>
In-Reply-To: <20241119231146.2298971-1-lyude@redhat.com>
References: <20241119231146.2298971-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The KMS bindings ( https://patchwork.freedesktop.org/series/131522/ ) have
a few bindings that require manually acquiring specific locks before
calling certain functions. At the moment though, the only way of acquiring
these locks in bindings is to simply call the C locking functions directly
- since said locks are not acquired on the rust side of things.

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
V4:
* Documentation fixes from Boqun
* Reword commit message (Boqun)

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 6d3c8874eb26a..ea65f84b76f8e 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -91,6 +91,7 @@ unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
 ///
 /// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock
 /// [`Backend`] specified as the generic parameter `B`.
+#[repr(C)]
 #[pin_data]
 pub struct Lock<T: ?Sized, B: Backend> {
     /// The kernel lock object.
@@ -129,6 +130,28 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
     }
 }
 
+impl<B: Backend> Lock<(), B> {
+    /// Constructs a [`Lock`] from a raw pointer.
+    ///
+    /// This can be useful for interacting with a lock which was initialised outside of Rust.
+    ///
+    /// # Safety
+    ///
+    /// The caller promises that `ptr` points to a valid initialised instance of [`State`] during
+    /// the whole lifetime of `'a`.
+    ///
+    /// [`State`]: Backend::State
+    pub unsafe fn from_raw<'a>(ptr: *mut B::State) -> &'a Self {
+        // SAFETY:
+        // - By the safety contract `ptr` must point to a valid initialised instance of `B::State`
+        // - Since the lock data type is `()` which is a ZST, `state` is the only non-ZST member of
+        //   the struct
+        // - Combined with `#[repr(C)]`, this guarantees `Self` has an equivalent data layout to
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


