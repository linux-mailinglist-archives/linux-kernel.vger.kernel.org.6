Return-Path: <linux-kernel+bounces-370984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897579A349C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202D51F22684
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9615B188CC9;
	Fri, 18 Oct 2024 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2MyUtM9"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322618870E;
	Fri, 18 Oct 2024 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230729; cv=none; b=lt1TE37MwuwaffBhskN4CUfaLcO3aFgxll6ebqki1bJFAINS0QDR36PeKYaJ8DAKwFXj9mxvZOymbUcKYSGQL0L7imUjUa5wEYCFbtNX3nXM7uPuI20D4xTM87suObCGEp6jujyAm6Bv8ucCQrb88hj6M4mQgu0zFzgKbOSeIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230729; c=relaxed/simple;
	bh=Olilde3fU9liAfVYtogjPSf9m7opIVIiHuPznn1iveg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRTQYMBwOh94vRCaQfb/yJyGWJopQ3HUxtBVRUEglvb1vtjR+alfC5YKUvssrsohyr4mrRT6/9pZe9h8xbqDZUEsBk+opfw9p9q+rfST8pdEtQMthDQKL7yqE+1clTvBv6KqMLY3yFLGLSRnQko6SUb5BZ6VPXfxaZWVa3/V01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2MyUtM9; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460a415633fso7220161cf.2;
        Thu, 17 Oct 2024 22:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230727; x=1729835527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCrCyE2+SZF83j5kss/ADEwfWXSUmxKxUyHtwgYvegQ=;
        b=Z2MyUtM9ipdWZCde2qx13DpM5Mre+F7do/paM8ZXzmR7qXDXeBax4NF8CH9eQSCHaN
         dMu0G5l9ekMqh+rwegeApZP0SY8UT2mUDoQ6v4dGPf5yFXT+ebOUfBFJ/NlNGzjkHrp1
         FA/QdQ/vv9uVuvJ/lc8+s8eu0XjWDDN7qxX3rN20D0WcclLX2s5nD9wUy7l3+lZOX6Ha
         0sZDuFWw4aSIZe7etgKioALbaWs6r908+BBcAKEzxOgcuO1FqPjBw/bwLaIxs5OqNDiG
         vjdPqdoqsw+7S1EvTPs8AVEcrFHX7OKQJn5mTwxlmenc/sm5czCrIqJ0VNSHHJMxoXsc
         Exzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230727; x=1729835527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zCrCyE2+SZF83j5kss/ADEwfWXSUmxKxUyHtwgYvegQ=;
        b=bo0PS9ldlLs/ga3A563CRXUBs1eboE92Wv3aLciQwADAmmx47R2m8VRKTxsQvwnQz2
         V89nJIsabRPfFJDAOSD5wImywUbbH1jPxDDHvbx7LlKvPdF/ye9s4LuqAeZgwGUeCPaX
         NUNb81qqK7hmPZ8Gdm8Yciy0rEBSBAj4rsNC42MVBGZupIBgAACnNCNssdMHGdjoUae3
         6VrAY67PUTF//40+kmDrfepNn4VNLOfu5aJ0qA5uOV5InFcmi0esV3NbNvr8vLoeWzd6
         Cltxcqt7NcshgeerdBEMtpei9aovwPEtwHqVt8UYRjKmrO4vHwJ2jaFJHTQmS/EQqhFL
         e7jA==
X-Forwarded-Encrypted: i=1; AJvYcCU7jaeojrd6ok8T2pG7NMz9mSrdhZLqw9JTElIqPzLkIlDpQWRr1aph5X78Wo6fZEVG8azim6in5CTTOEU=@vger.kernel.org, AJvYcCVZmcj80BeF4oa6/w6JRMvVwl0vipnEQs9K1Su7LUE55Ffl8HT/eHmjEYLBtyctk7WubNg2yrW5ELWRdCTCZbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiuryPtbJnk17Jd4igyfZD+K4PKiKcPw+tITOsHcsBFKkzpE+
	HYufBU1a6V2CqT6qJmkyMjAhJMijvnm+Q+uqAOqKvzSrbeXNlT5q
X-Google-Smtp-Source: AGHT+IH9e62snMfTi+nvdpvBORtjymUBqFymyxF5Th73SGnnUVY2SNOf+XhMUnHQxQZ10CIVYsCOsg==
X-Received: by 2002:a05:622a:1992:b0:45d:969f:8031 with SMTP id d75a77b69052e-460aed4a163mr17747841cf.25.1729230726920;
        Thu, 17 Oct 2024 22:52:06 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460ae94751bsm4057681cf.15.2024.10.17.22.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:52:06 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 73A6F1200073;
	Fri, 18 Oct 2024 01:52:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 18 Oct 2024 01:52:05 -0400
X-ME-Sender: <xms:hfcRZ4kcaDFKMLE3hBq2CLYk7CF2XEjC5NwZrbBZQf-6L-E5FVeP2A>
    <xme:hfcRZ31YOfce-8Tex4XoygXI4ARG2xso8AeUTjYTIvfjbDNI8ZykaC_et3NLN7T1H
    ILkKmO6LHioRoa3uQ>
X-ME-Received: <xmr:hfcRZ2pTh7lOMPRaUpX-DKwjk1hPwsvmDIvCyIAnxBNms_O5LIXnC3HfRyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepughirhhkrdgsvghhmhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqd
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivggusehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhl
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrd
    gtohhm
X-ME-Proxy: <xmx:hfcRZ0ksK6oAiu9LffKw4BFFgouFlcqyseLAFSnqXbP-LN33Z6-bng>
    <xmx:hfcRZ201u5vsJoyqAl9TZEwNAl1adcYWF5qiyB6HYGH_S7dYOU5ETQ>
    <xmx:hfcRZ7tJGMjNc2VimQFcynPEOiNAkryA5v-5AWTY5IeXmvGvyqsomA>
    <xmx:hfcRZyX4lplFWCVAMkEE_VA_DsZ52WnWtqr5AsFhKy1-CNm0fv3zog>
    <xmx:hfcRZ52yBek8Dfa8x2tEkFtNX6KQ9dVmOx78FOXKDnpEb20ovQJLwWjC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:52:04 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [POC 6/6] rust: sync: lock: Add `Backend::BackendInContext`
Date: Thu, 17 Oct 2024 22:51:25 -0700
Message-ID: <20241018055125.2784186-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018055125.2784186-1-boqun.feng@gmail.com>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
 <20241018055125.2784186-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`SpinLock`'s backend can be used for `SpinLockIrq`, if the interrupts
are disabled. And it actually provides performance gains since
interrupts are not needed to be disabled anymore. So add
`Backend::BackendInContext` to describe the case where one backend can
be used for another. Use the it to implement the `lock_with()` so that
`SpinLockIrq` can avoid disabling interrupts by using `SpinLock`'s
backend.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++--
 rust/kernel/sync/lock/mutex.rs    |  1 +
 rust/kernel/sync/lock/spinlock.rs |  9 +++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 49b53433201c..4e3316feb497 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -24,10 +24,14 @@
 ///   is owned, that is, between calls to [`lock`] and [`unlock`].
 /// - Implementers must also ensure that [`relock`] uses the same locking method as the original
 ///   lock operation.
+/// - Implementers must ensure if [`BackendInContext`] is a [`Backend`], it's safe to acquire lock
+///   under the [`Context`], the [`State`] of two backends must be the same.
 ///
 /// [`lock`]: Backend::lock
 /// [`unlock`]: Backend::unlock
 /// [`relock`]: Backend::relock
+/// [`BackendInContext`]: Backend::BackendInContext
+/// [`Context`]: Backend::Context
 pub unsafe trait Backend {
     /// The state required by the lock.
     type State;
@@ -41,6 +45,9 @@ pub unsafe trait Backend {
     /// The context which can be provided to acquire the lock with a different backend.
     type Context<'a>;
 
+    /// The alternative backend we can use if a [`Context`] is provided.
+    type BackendInContext: Sized;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -125,8 +132,22 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
 impl<T: ?Sized, B: Backend> Lock<T, B> {
     /// Acquires the lock with the given context and gives the caller access to the data protected
     /// by it.
-    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
-        todo!()
+    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B::BackendInContext>
+    where
+        B::BackendInContext: Backend,
+    {
+        // SAFETY: Per the safety guarantee of `Backend`, if `B::BackendIncontext` and `B` should
+        // have the same state, therefore the layout of the lock is the same so it's safe the
+        // convert one to another.
+        let lock = unsafe { &*(self as *const _ as *const Lock<T, B::BackendInContext>) };
+        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
+        // that `init` was called. Plus the safety guarantee of `Backend` guarantees that `B::state`
+        // is the same as `B::BackendInContext::state`, also it's safe to call another backend
+        // because there is `B::Context<'a>`.
+        let state = unsafe { B::BackendInContext::lock(lock.state.get()) };
+
+        // SAFETY: The lock was just acquired.
+        unsafe { Guard::new(lock, state) }
     }
 
     /// Acquires the lock and gives the caller access to the data protected by it.
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 7c2c23994493..ddb7d06676f7 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -94,6 +94,7 @@ unsafe impl super::Backend for MutexBackend {
     type State = bindings::mutex;
     type GuardState = ();
     type Context<'a> = ();
+    type BackendInContext = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 8f9e1b27e474..3bec25b65c55 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -94,6 +94,7 @@ unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
     type Context<'a> = ();
+    type BackendInContext = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
@@ -146,6 +147,7 @@ macro_rules! new_spinlock_irq {
 ///
 /// ```
 /// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
+/// use kernel::interrupt::InterruptDisabled;
 ///
 /// struct Inner {
 ///     a: u32,
@@ -168,6 +170,12 @@ macro_rules! new_spinlock_irq {
 ///     }
 /// }
 ///
+/// // Accessing an `Example` from a function that can only be called in no-irq contexts
+/// fn noirq_work(e: &Example, irq: &InterruptDisabled) {
+///     assert_eq!(e.c, 10);
+///     assert_eq!(e.d.lock_with(irq).a, 20);
+/// }
+///
 /// // Allocate a boxed `Example`
 /// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
 ///
@@ -186,6 +194,7 @@ unsafe impl super::Backend for SpinLockIrqBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
     type Context<'a> = &'a InterruptDisabled;
+    type BackendInContext = SpinLockBackend;
 
     unsafe fn init(
         ptr: *mut Self::State,
-- 
2.45.2


