Return-Path: <linux-kernel+bounces-269942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C645943917
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 00:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3791F225CD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D186160887;
	Wed, 31 Jul 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceplevs+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BB16D4FA
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722465661; cv=none; b=KwJJWSA8hUXEzvuQLWVcTfrsH+lQS97lS2c6wCqKQLgkrHrrAcEcu2pyW9QsC3SV8po3Xq7EnrxJlPw2IeKMDPuqBYVleEP8+Ib4999fuqu+4Cywn8VyXfzQrFaoZjzaFU+wn9Gv/fAoUhkUUbRIYt4tdCFPCq8FcCodl4lpXsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722465661; c=relaxed/simple;
	bh=A37VT/aiB645Oj3o56/HCRKyWDxGWQBLxOipjj2+AEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbFH+IX8P4/CKGHQ9xmfGE3j3ZF1O0gy/k8bewQu5PFXPykUPX1CVLYHiRqP8EmmvLwXn4ZEF3SBDFkwv/ricUWVJTDE+j23cdFjC0r0oUk0kbQy0mV8s7/fPX43OWfYPOnYgG546KQ00Zxa/PjxRc3fyXho7UvCfwIdmSZbpBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ceplevs+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722465658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDZsl29qwgx0PqIl2EajHebKu6jqaPLiGVwcxJe1mco=;
	b=ceplevs+0caa27Nb5HxjCjEyMr9Sl83gF9X+vn/sBwW862YDBfP2x++cIMgLgUASQD9wSR
	ILqLJsxiwEDCPcyCX3ZBPyTS9UjrdDwRiQ6J0cYX/Flc3Po/gwZ0VI4pdqJ5HL5iXdQhD/
	L4BHpi9f6neyCmNDJZNVc4LutPTxiLM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-1y3-pVmsPKCTkgF6PmweEA-1; Wed,
 31 Jul 2024 18:40:51 -0400
X-MC-Unique: 1y3-pVmsPKCTkgF6PmweEA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F325A1955D42;
	Wed, 31 Jul 2024 22:40:48 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.16.173])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8C28300018D;
	Wed, 31 Jul 2024 22:40:44 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Trevor Gross <tmgross@umich.edu>,
	Ben Gooding <ben.gooding.dev@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] rust: sync: Introduce lock::Backend::Context
Date: Wed, 31 Jul 2024 18:35:40 -0400
Message-ID: <20240731224027.232642-3-lyude@redhat.com>
In-Reply-To: <20240731224027.232642-1-lyude@redhat.com>
References: <20240731224027.232642-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Now that we've introduced an `IrqDisabled` token for marking contexts in
which IRQs are disabled, we need a way to be able to pass it to locks that
require that IRQs are disabled. In order to continue using the
`lock::Backend` type instead of inventing our own thing, we accomplish this
by adding the associated Context type, along with a `lock_with()` function
that can accept a Context when acquiring a lock. To allow current users of
context-less locks to keep using the normal `lock()` method, we take an
example from Wedson Almeida Filho's work and add a `where T<'a>: Default`
bound to `lock()` so that it can only be called on lock types where the
context is simply a placeholder value, then re-implement it through the new
`lock_with()` function.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync/lock.rs          | 17 +++++++++++++++--
 rust/kernel/sync/lock/mutex.rs    |  3 +++
 rust/kernel/sync/lock/spinlock.rs |  1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819f..f3ff50c4272cf 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -38,6 +38,9 @@ pub unsafe trait Backend {
     /// [`unlock`]: Backend::unlock
     type GuardState;
 
+    /// The context which much be provided to acquire the lock.
+    type Context<'a>;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -120,14 +123,24 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
-    /// Acquires the lock and gives the caller access to the data protected by it.
-    pub fn lock(&self) -> Guard<'_, T, B> {
+    /// Acquires the lock with the given context and gives the caller access to the data protected
+    /// by it.
+    pub fn lock_with(&self, _context: B::Context<'_>) -> Guard<'_, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
         let state = unsafe { B::lock(self.state.get()) };
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Acquires the lock and gives the caller access to the data protected by it.
+    #[inline]
+    pub fn lock<'a>(&'a self) -> Guard<'a, T, B>
+    where
+        B::Context<'a>: Default,
+    {
+        self.lock_with(B::Context::default())
+    }
 }
 
 /// A lock guard.
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 30632070ee670..327e53be4c0f4 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -4,6 +4,8 @@
 //!
 //! This module allows Rust code to use the kernel's `struct mutex`.
 
+use core::marker::*;
+
 /// Creates a [`Mutex`] initialiser with the given name and a newly-created lock class.
 ///
 /// It uses the name if one is given, otherwise it generates one based on the file name and line
@@ -93,6 +95,7 @@ macro_rules! new_mutex {
 unsafe impl super::Backend for MutexBackend {
     type State = bindings::mutex;
     type GuardState = ();
+    type Context<'a> = PhantomData<&'a ()>;
 
     unsafe fn init(
         ptr: *mut Self::State,
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index ea5c5bc1ce12e..8503d6e8e3de3 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -92,6 +92,7 @@ macro_rules! new_spinlock {
 unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
+    type Context<'a> = PhantomData<&'a ()>;
 
     unsafe fn init(
         ptr: *mut Self::State,
-- 
2.45.2


