Return-Path: <linux-kernel+bounces-416370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BE19D43E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 23:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E667D1F221A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C2C1C4A2F;
	Wed, 20 Nov 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BthwcSzW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178DC1C1F12
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141691; cv=none; b=Vipl7r0XyTrb61rb/SqmmvA9tUb+14G5PdzVWtEajXQFICYnIVd6ohO/jFyoBwo9xEcJ2MFOnmguWKHbyr23ORvleqDC9Zs4q+ggD1v+Cn7dCmfEOCajSbRqEEmzT5IQ/XQ1AcFvyt9FbChCv9L1hIffOpZwhd+taU6PTdj+uz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141691; c=relaxed/simple;
	bh=D1ZRLzl03yb2edIfySWgebPGvN9qrvWXhhGBcfxbems=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NhXzC9tqVagI4fsGuSrkrn+ND09GKatpTa5fJem56zCX/GhildcoK+78xCNtiJ3eXbVQH5LI5s2mQus2V+5uUHT9ZhzyquxeAFRZcgONWCImVNdfKSlJeoUS9hN3Bc7NxgDZ5CCp9jW1PMDyeCZhbMwoICje9u7IaBIMUusOGCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BthwcSzW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732141686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdgZwkENFqGRYXGdB7HmYKlQGMS8EGyxxtW8qmpT6ds=;
	b=BthwcSzWo4j/D8INaals1veIEB8dGtx1NJe3pBpF3+r5MurJO2ssNIVsKZFzft9uuZMGFS
	Wj0snb8cg77zMYlVTCd6kKc/NrZIs8KQXZWY5p/kTAPYhNfCz75QASaU77L4+cBrrbab0r
	6PFdrCebCn+ZIWhHJKySe8b1X0AvQ5k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-160-SzH8S7oaNvGtSmtrTotStA-1; Wed,
 20 Nov 2024 17:28:03 -0500
X-MC-Unique: SzH8S7oaNvGtSmtrTotStA-1
X-Mimecast-MFC-AGG-ID: SzH8S7oaNvGtSmtrTotStA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7A2EA195609E;
	Wed, 20 Nov 2024 22:27:58 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.88.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8DBA195607C;
	Wed, 20 Nov 2024 22:27:54 +0000 (UTC)
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
	Filipe Xavier <felipe_life@live.com>,
	Valentin Obst <kernel@valentinobst.de>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/2] rust: sync: Add SpinLockGuard type alias
Date: Wed, 20 Nov 2024 17:26:29 -0500
Message-ID: <20241120222742.2490495-3-lyude@redhat.com>
In-Reply-To: <20241120222742.2490495-1-lyude@redhat.com>
References: <20241120222742.2490495-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

A simple helper alias for code that needs to deal with Guard types returned
from SpinLocks.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync.rs               | 2 +-
 rust/kernel/sync/lock/spinlock.rs | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0f630714da2aa..b469d796747a4 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -16,7 +16,7 @@
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
 pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
-pub use lock::spinlock::{new_spinlock, SpinLock};
+pub use lock::spinlock::{new_spinlock, SpinLock, SpinLockGuard};
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 9f4d128bed983..081c0220013b3 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -87,6 +87,14 @@ macro_rules! new_spinlock {
 /// A kernel `spinlock_t` lock backend.
 pub struct SpinLockBackend;
 
+/// A [`Guard`] acquired from locking a [`SpinLock`].
+///
+/// This is simply a type alias for a [`Guard`] returned from locking a [`SpinLock`]. It will unlock
+/// the [`SpinLock`] upon being dropped.
+///
+/// [`Guard`]: super::Guard
+pub type SpinLockGuard<'a, T> = super::Guard<'a, T, SpinLockBackend>;
+
 // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
 // default implementation that always calls the same locking method.
 unsafe impl super::Backend for SpinLockBackend {
-- 
2.47.0


