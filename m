Return-Path: <linux-kernel+bounces-370982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0F9A3499
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F309281BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561491885A5;
	Fri, 18 Oct 2024 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkx2DoP6"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01761865EE;
	Fri, 18 Oct 2024 05:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230726; cv=none; b=MJAjs1R6tUfaGBM3rYG6ItSdllNk57dhmBtuGP2J1sGdf6BdZAswPAgTdGnC4tFf8WzFjv/uF+rNRW6h0GDfpkPC8m0I/SqqZDtuojgn7qVbGWlN6u47pwxdf1HrpyskwuCxFIW9JKgo3n5EqhWOUkqqObvBW9L/4hNmZDRz734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230726; c=relaxed/simple;
	bh=Zz/XCdMoetiDJ3KgZ7uJO+07jo81iMjuuKEUb0AVVVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntECaYg8eUWhcWhki6FA5OMiLHWjiu8lNpmsx8Kx7DJqCzS7nzB4vWlHq4nKhGUk6xRZjDtFl8lSulBXR2YgNhvif/t1XmlBg6BjzRqMsz6w0S0XyeZW2x6VZx3bHnTSQw+pV//oVkKmlWb7gCRCYJieSP/5AkeFkDAWfVcWJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkx2DoP6; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1363c7977so173242985a.1;
        Thu, 17 Oct 2024 22:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230723; x=1729835523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Abd9MR76gPMr7HW1p52lgGxqPWUVwdyQxqLxRSgnZYA=;
        b=Bkx2DoP6EUF5bxpo9U1gX55O/3aXJegCldAfY1WqoFHtcnorc3lBbEuLc1Y8GwHwki
         +/xGhP6R4SUtC5JwrmOqzGVOGcqtueMcvvSDUe2FavzuNg1eM4u4ML2wj0ZUvJhh3ZMB
         05dMoICrzVOHlzxnpC+Mo0ZEU90XqPNH2zMQQPSK7ybNyOP5WSrL20W8mgLp2ZLZ+M+t
         fPYPE49rzXEJ+2SmXvCmdAVBpNyEFeUHwPi686F+nfeQjd67wu3xuGyjziRCoLHWRvQl
         Bp1+E9YR+AGxIWf429U7Im0TBBMNC2Ap0Ek7pj4B1AvLnHXmdGXHS1Me8lbLTkg21695
         2oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230723; x=1729835523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Abd9MR76gPMr7HW1p52lgGxqPWUVwdyQxqLxRSgnZYA=;
        b=njprNDg2nKG8aOyM2SdvYkTU2tMO9aS5u9i20JU2EnEmfYl20eMs+FLjg2Tu2BkZIW
         GMwIgWukHDe07//S7QwRpBdC+ZsB6g/giGR5D5c8xK/W8+P29txrmNskRvhQtlqNYRwi
         am5Tl+wuM5rt+urDpSmGC6j2Cgz9JJPHnVi3ccw38V0hijcRwyPpZAkkofRmoKp6/m2e
         NpCBGSIcZZt6+YnrH6LTAssMjpqtM17pvTNY8fGgERjVHE2ZDHTGc5uK5PDPbhaJzgqY
         dHsiCRjNlT90Jz9kOPfMp/mUpSY3yRe76CuUqgPujc2BSZzl9D2ZI7Z6/8o8u3ah+zVG
         fAHg==
X-Forwarded-Encrypted: i=1; AJvYcCVpabAlYrqIT4W/8n8nDvn9q+f/IRXKRXmAFw+X5fD+jmabaKbI3TBOsWGcvZi+aDr9vbNyfNAmgVOtdrzDigs=@vger.kernel.org, AJvYcCWCv9P1BCAWmWkX8/1of9CRVRDWm3ropnHfNCep88m4dXl3PfyxuaM53rq3Rn2krMQY0a3NUtaIgSFme+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAuL+7AQ+K1X8zvr4f4+IymEF/IVY5EF8dIOQ24oQOscpTssn
	iiFc5+jOezkgH79Yv0Ijh3mC3LhTSKRbMq9d2jbIyJTQVlx2WN6f
X-Google-Smtp-Source: AGHT+IFa5OrjzRklHkcP+21YQNpIXKSgcGSZqIkBGX4gOTx4WgLSdQHRwBCiNOm1oUuGjLOSCiZBYg==
X-Received: by 2002:a05:6214:4403:b0:6cb:ef1b:33d2 with SMTP id 6a1803df08f44-6cde14b965emr18362336d6.3.1729230723530;
        Thu, 17 Oct 2024 22:52:03 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114ea1bsm3881556d6.51.2024.10.17.22.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:52:03 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id B3DB71200071;
	Fri, 18 Oct 2024 01:52:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Oct 2024 01:52:02 -0400
X-ME-Sender: <xms:gvcRZ7YI4VU5OPNNyb7_dNvZCRoamDsKD6xrgJDmW0Xlx_j7BPbLWQ>
    <xme:gvcRZ6ZVYuLSJ0XSka1sS8b6CuHFSDYGE0fDP6MahwcnSULyeen8BvPi3P9t02hCs
    ziXihyuZMv-9GcrPA>
X-ME-Received: <xmr:gvcRZ9_zOZ1rKzInTJzZoHbJRbqIoCDn-Seol7NGOSBDcAHbW_OGEZRYMUJPsQ>
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
X-ME-Proxy: <xmx:gvcRZxqcPnt4j_ZlSJsIWL2xO-wExdXUbtAyV0Zng6Jgyatqzs_fCA>
    <xmx:gvcRZ2qXI2pVWWkMvVFBd47inLqyHt1M94IqvpqpZqIbBf_VpjzX3A>
    <xmx:gvcRZ3RQzy3PqN1xE8UwSizootpd255QF0YIupswj5T8_xe3JV3msA>
    <xmx:gvcRZ-oKG_kSnL3QD2b4fe7lXTJq4uG1zRxlQ2oCXzReqSF01ptugQ>
    <xmx:gvcRZ36uumCoMEOkfS-9pP8KN0cL5GB4i3FEm_I8AdfI2fVrQtPnuxge>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:52:02 -0400 (EDT)
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
Subject: [POC 4/6] rust: sync: Add SpinLockIrq
Date: Thu, 17 Oct 2024 22:51:23 -0700
Message-ID: <20241018055125.2784186-5-boqun.feng@gmail.com>
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

A variant of SpinLock that is expected to be used in noirq contexts, so
lock() will disable interrupts and unlock() (i.e. `Guard::drop()` will
undo the interrupt disable.

[Boqun: Port to use spin_lock_irq_disable() and
spin_unlock_irq_enable()]

Co-developed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync.rs               |  2 +-
 rust/kernel/sync/lock/spinlock.rs | 91 +++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 0ab20975a3b5..b028ee325f2a 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -15,7 +15,7 @@
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::mutex::{new_mutex, Mutex};
-pub use lock::spinlock::{new_spinlock, SpinLock};
+pub use lock::spinlock::{new_spinlock, new_spinlock_irq, SpinLock, SpinLockIrq};
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index ea5c5bc1ce12..884d4d1cbf23 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -115,3 +115,94 @@ unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         unsafe { bindings::spin_unlock(ptr) }
     }
 }
+
+/// Creates a [`SpinLockIrq`] initialiser with the given name and a newly-created lock class.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_spinlock_irq {
+    ($inner:expr $(, $name:literal)? $(,)?) => {
+        $crate::sync::SpinLockIrq::new(
+            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+pub use new_spinlock_irq;
+
+/// A spinlock that may be acquired when interrupts are disabled.
+///
+/// A version of [`SpinLock`] that can only be used in contexts where interrupts for the local CPU
+/// are disabled. It requires that the user acquiring the lock provide proof that interrupts are
+/// disabled through [`IrqDisabled`].
+///
+/// For more info, see [`SpinLock`].
+///
+/// # Examples
+///
+/// The following example shows how to declare, allocate initialise and access a struct (`Example`)
+/// that contains an inner struct (`Inner`) that is protected by a spinlock.
+///
+/// ```
+/// use kernel::sync::{new_spinlock_irq, SpinLockIrq};
+///
+/// struct Inner {
+///     a: u32,
+///     b: u32,
+/// }
+///
+/// #[pin_data]
+/// struct Example {
+///     c: u32,
+///     #[pin]
+///     d: SpinLockIrq<Inner>,
+/// }
+///
+/// impl Example {
+///     fn new() -> impl PinInit<Self> {
+///         pin_init!(Self {
+///             c: 10,
+///             d <- new_spinlock_irq!(Inner { a: 20, b: 30 }),
+///         })
+///     }
+/// }
+///
+/// // Allocate a boxed `Example`
+/// let e = Box::pin_init(Example::new(), GFP_KERNEL)?;
+///
+/// // Accessing an `Example` from a context where IRQs may not be disabled already.
+/// let b = e.d.lock().b;
+///
+/// assert_eq!(b, 30);
+/// # Ok::<(), Error>(())
+/// ```
+pub type SpinLockIrq<T> = super::Lock<T, SpinLockIrqBackend>;
+
+/// A kernel `spinlock_t` lock backend that is acquired in interrupt disabled contexts.
+pub struct SpinLockIrqBackend;
+
+unsafe impl super::Backend for SpinLockIrqBackend {
+    type State = bindings::spinlock_t;
+    type GuardState = ();
+
+    unsafe fn init(
+        ptr: *mut Self::State,
+        name: *const core::ffi::c_char,
+        key: *mut bindings::lock_class_key,
+    ) {
+        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
+        // `key` are valid for read indefinitely.
+        unsafe { bindings::__spin_lock_init(ptr, name, key) }
+    }
+
+    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        unsafe { bindings::spin_lock_irq_disable(ptr) }
+    }
+
+    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
+        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
+        // caller is the owner of the spinlock.
+        unsafe { bindings::spin_unlock_irq_enable(ptr) }
+    }
+}
-- 
2.45.2


