Return-Path: <linux-kernel+bounces-370983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11189A349A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20F61C237B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E150188906;
	Fri, 18 Oct 2024 05:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ei5mxr0Y"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2907187FEB;
	Fri, 18 Oct 2024 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230728; cv=none; b=E4+zRPZJf8awBbBHa2PfxX4lcao9Nrv6PUy81J8HYiYZHlyyGxGLv4i+0gSzd/K/hxzkHBnPzBSpBHCLcdfjvzw1RiiV+vLw/47woPohDmZ3NMzsY8ABGS8o2TWzTQcM3oiZYdvIeKKdrBYwF2ybmjdUIgFD+uWCaQWQ2QTkWpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230728; c=relaxed/simple;
	bh=tbSrVABp3PaXJkMn+Cm+M441qbWN9NPoBe7KufBm1QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZ+JNfkbd40gVqh8/ywohU9xLUy57xEhPuFkFZUtVge8LDUz+9qqu2ktIiWWz3rpQYsUC7scDTVuPIB1NCiMUXNMpp35EQJOEHUtAkW7BwCZVtC/IujEgjtyZt3taQjwY2Yy1c44EVSIJKzaCUFYUQcEPn2/UORSzeWNnCgkIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ei5mxr0Y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cbd092f7f0so11489386d6.0;
        Thu, 17 Oct 2024 22:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230726; x=1729835526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PiO8wSvLJP3CfC2CFEiFL3JHXiCvMRVN6nfnfklyn+E=;
        b=Ei5mxr0YqKaU2EWnfeJhBuY9eExmE4+a5alfG8X1OiSZTzzt9dIzgCPLPH6ZxQqy2N
         x+LHAhR3ABXKY4DJ3pOyPzOtjqTgboiV69U+4M7zhJSYRBzGAYn0EJHQITiAlHDnHx8y
         806YbVwbCcbd9p8cfbmISj0fof346aj7kOqiMppbn5MvOosh32a4iClMoZfSk0uXneMC
         H3GfuPYUpvpK9yviPZQw1QWtRXMjjJ3gnm8p4DkNw540BZOE5SGD1YbL+GTZu96S0G4T
         MD54TKC1lpdeH6syq3IOoCFFoC8Ai0ICDzoXJIzbPmTca8Bi9dt4nHLHNzvsKD27tPg6
         JdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230726; x=1729835526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiO8wSvLJP3CfC2CFEiFL3JHXiCvMRVN6nfnfklyn+E=;
        b=xDLDlR15Lf9eVbW0w4tyFFA/bsFJ0YxlwYb5sGIOhgTvNtfeC9zKf/IK3T21t2lJE2
         TuKeMk9oNaiX+ZIaaE9mPgL/Cn753yU14GqnSBI4WWMXnoy2ksg5m1sCa5Fs8LaRfbgr
         /klolBquDVnMXKwlFHRMK/dw2YxQ7ULxtjJeuQbgRXfrLFHTx2j1YR+vqNL48AFWzzCN
         GTmybu2ILNYXlmGDy7Mw0fup9yYK6ak0ZgIoUSSNDi/dlWQz9YMVbA+3tNiNwrP8pggu
         rAT0vKY6t2fcyMwpkiLHf1rUQtm5lMVaoEdewGLA2COrH7aXcjgK2Ge2XUzVPXSnlaXK
         ohQA==
X-Forwarded-Encrypted: i=1; AJvYcCU1wXAfnWoGebijpEI5g6u++hzJpenRxAiwR+TEBduwE/5CPZJfm14hmAaQJ1wMtq6MPHo2+LkIE6Rh84m7kBw=@vger.kernel.org, AJvYcCVS6kGylnon3ngHgDf5fXdZ2T0jgiq6cQgm07IJyVdPBgKyMDmpTJKzbxNUJOZXmmdZVU/sEgp8Fk3ggB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9/ojAUd2bOIcQZLhPDuNHpKP8MWFKgR0nDL1XxoSA9zNlN8+/
	mwYay9hKLoDycO5ENX2LEL/WaMILkitoLRB16Z6y3AVAYakNWuTy
X-Google-Smtp-Source: AGHT+IF4dS/pPKXEPCvmpweymPZSUAD0UOsQ1pCKGWPLMt2tDJw3rXN9Sx/soWflN4T5oAgrXMUObg==
X-Received: by 2002:a05:6214:3b83:b0:6cc:42d:bbb with SMTP id 6a1803df08f44-6cde1695f11mr12452786d6.53.1729230725599;
        Thu, 17 Oct 2024 22:52:05 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114d0d7sm3899996d6.40.2024.10.17.22.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:52:05 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 15B7D1200071;
	Fri, 18 Oct 2024 01:52:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 01:52:04 -0400
X-ME-Sender: <xms:g_cRZy3C4v0fXvvjZvDMoEMYntzXIeQmbLGpxfgKxkCTyAKRd9xJ3w>
    <xme:g_cRZ1E3cyOAI27RGLta3XJBATXTtYBoV5fG-Qigf7Dmh8g36JQDzgAsoVk5cpvnp
    lMBxtmPQ5XjMnACvA>
X-ME-Received: <xmr:g_cRZ66rzc8pvklqIEfdpoQ9uVxBasp_WkDu_ilFvOSkNozEK31FKHV5AKt76w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
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
X-ME-Proxy: <xmx:hPcRZz3ZG7CztJMS1ok5HhafKUA06sVpBrd9xmaWjZrdG0Pd2VRIWg>
    <xmx:hPcRZ1ERiGeYB8o3uC0mna2lzRd8p0vyV8xLXnBNN0Jcp1ku5aUGBw>
    <xmx:hPcRZ8_BEArpSLdJTsigbeh20PJRg2iVoP7gXV3iP2px0xsbMA_eHA>
    <xmx:hPcRZ6kQtPaKVPJaaeRc4pB5lD6Q-5z0tu6JmqVaZYcrtWQ46VAz8A>
    <xmx:hPcRZ9G6H8Shyq2M9WRmiaaiFW2Q8AEmgmEOwOY5M7j-rFxn5eq_w_qs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:52:03 -0400 (EDT)
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
Subject: [POC 5/6] rust: sync: Introduce lock::Backend::Context
Date: Thu, 17 Oct 2024 22:51:24 -0700
Message-ID: <20241018055125.2784186-6-boqun.feng@gmail.com>
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

From: Lyude Paul <lyude@redhat.com>

Now that we've introduced an `InterruptDisabled` token for marking
contexts in which IRQs are disabled, we can have a way to avoid
`SpinLockIrq` disabling interrupts if the interrupts have already been
disabled. Basically, a `SpinLockIrq` should work like a `SpinLock` if
interrupts are disabled. So a function:

	(&'a SpinLockIrq, &'a InterruptDisabled) -> Guard<'a, .., SpinLockBackend>

makes senses. Note that due to `Guard` and `InterruptDisabled` has the
same lifetime, interrupts cannot be enabled whiel the Guard exists.

Add a `lock_with()` interface for `Lock`, and an associate type of
`Backend` to describe the context.

[Boqun: Change the interface a lot, now `SpinLockIrq` can use the
`lock()` function, but it always disable the interrupts, reuse the
`lock_with()` method to provide a way for locking if interrupts are
already disabled. `lock_with()` implementation will be added later.]

Co-developed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/lock.rs          | 12 +++++++++++-
 rust/kernel/sync/lock/mutex.rs    |  1 +
 rust/kernel/sync/lock/spinlock.rs |  3 +++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f6c34ca4d819..49b53433201c 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -38,6 +38,9 @@ pub unsafe trait Backend {
     /// [`unlock`]: Backend::unlock
     type GuardState;
 
+    /// The context which can be provided to acquire the lock with a different backend.
+    type Context<'a>;
+
     /// Initialises the lock.
     ///
     /// # Safety
@@ -120,8 +123,15 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
+    /// Acquires the lock with the given context and gives the caller access to the data protected
+    /// by it.
+    pub fn lock_with<'a>(&'a self, _context: B::Context<'a>) -> Guard<'a, T, B> {
+        todo!()
+    }
+
     /// Acquires the lock and gives the caller access to the data protected by it.
-    pub fn lock(&self) -> Guard<'_, T, B> {
+    #[inline]
+    pub fn lock<'a>(&'a self) -> Guard<'a, T, B> {
         // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
         // that `init` was called.
         let state = unsafe { B::lock(self.state.get()) };
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 30632070ee67..7c2c23994493 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -93,6 +93,7 @@ macro_rules! new_mutex {
 unsafe impl super::Backend for MutexBackend {
     type State = bindings::mutex;
     type GuardState = ();
+    type Context<'a> = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 884d4d1cbf23..8f9e1b27e474 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -3,6 +3,7 @@
 //! A kernel spinlock.
 //!
 //! This module allows Rust code to use the kernel's `spinlock_t`.
+use crate::interrupt::InterruptDisabled;
 
 /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
 ///
@@ -92,6 +93,7 @@ macro_rules! new_spinlock {
 unsafe impl super::Backend for SpinLockBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
+    type Context<'a> = ();
 
     unsafe fn init(
         ptr: *mut Self::State,
@@ -183,6 +185,7 @@ macro_rules! new_spinlock_irq {
 unsafe impl super::Backend for SpinLockIrqBackend {
     type State = bindings::spinlock_t;
     type GuardState = ();
+    type Context<'a> = &'a InterruptDisabled;
 
     unsafe fn init(
         ptr: *mut Self::State,
-- 
2.45.2


