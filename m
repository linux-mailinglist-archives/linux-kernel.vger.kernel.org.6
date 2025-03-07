Return-Path: <linux-kernel+bounces-552135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F99AA57611
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 00:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC3D3B58A6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E9625A645;
	Fri,  7 Mar 2025 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lntV4bw+"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0325A2AA;
	Fri,  7 Mar 2025 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390184; cv=none; b=QbU5mchX4iY+Sts6Iv30F0kgXL00IukQ7e0Jnhf2drUKRIAQTMEO/MUbuAQS6aQAdtTm0d8geSVbBbLjVpf5K3G/i3arSjIBRGZKq0FqD8+Su1eDcqLPgTvoJhrSgxsNUoiQG30esy73BSO6I3tpNVkezWoouxuTaIWthfuJW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390184; c=relaxed/simple;
	bh=4T6JiUrprXIHYAAwo9JH+u1tRa+hCt1edvmkZjmco9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0TNlMG4njAqRcV2xV0AS+xdkTaVDnfTTM7yujY7GITPgGvxY5TWHE4cidgEdztC1AN16N59olPI002E1O/GbqDXjnMmRBmJfQIChJ5y07WnWpmaot7074h+yA1wZzfLkQvB9X6hoRZawi7tZ/0QrgPmxQJf6300Kh0+DTH4ohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lntV4bw+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f6970326so17846056d6.0;
        Fri, 07 Mar 2025 15:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741390181; x=1741994981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=APp1sd7jGBSg/u5pTAADDBD+S92qNVZmi8A5p35ed74=;
        b=lntV4bw+Yu/4saIo9Lvnj7S5b7NgQfMyKKqaSfTZ/wbI19oF7/wSXHdhpc2jz4h7Kx
         VWI/EUdRVNfdlGANsjqDPGRbiSVNOn8wPXHOBpBFtovbgcM6jkOPHUj7vjKO332G2YCC
         v2hyYf7eaZt3W0vJ9ekCC/8h7ZXj2gRyH21FoY76khOzvxqVnSjZcuY57XzqGSxVN1DT
         GT1bYKaIuTqoNyNr32ReIIjrgbq0xEfQPL1YKIAKkpa316/djrxFyZzkApdSw17+x0Zp
         JZvDwvEbc6HfRioyFGUs4P4agPdwoiJa80ZmhqwAo10Gr2qEjtreQkRN2cifzMZN0SnU
         EJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741390181; x=1741994981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=APp1sd7jGBSg/u5pTAADDBD+S92qNVZmi8A5p35ed74=;
        b=nZA8hQ0pX9W0WNO0cJHaK85HjcXKfoNR8ABkL2hcYSxtTmvlAHoh7gDQhlLLnDI2ci
         5j1xkRERrBxbPkjC1RSf2jLJlXXza3eDdke3aD0jvIBbNfdI2cVpHUrI4HiDI7Rc+VXX
         N4wgxeWb+OQBO64KBp5yFM+VvMzaZf7/ZBYP0sxpuorWYBdn4T18FCSnLhH/Cz5JF/Aj
         pm0bqUBbu+841Uc04ETef+/1Fp3oPSScSVdXrOyA/hc7YuAsNdWLt3W7GSxaOMhynSrt
         IprZ5yn3cAXInGqcw2/0xOv+MyBfm265Bb44ONkWyeseoOwDtKPHUd4KPJ7upppO+APB
         v3wg==
X-Forwarded-Encrypted: i=1; AJvYcCUwPBIf43EAo7SenRZpYkH4GwnCF+RDoiBfbo+TWkesljyzi/rp3BzsbnG3qvAzHWpENkuLQzcFvrp3jzs=@vger.kernel.org, AJvYcCVQGH9bNxbjcJFXMkSBDTe3J4WCfl/Acw0vQ/iCoA+LMtlSuRSw+XVUeU82awtTTl+9R7RD/WG51RrbMtPjVsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwd5fbWXuEdvrJL9u0+KBtlEzVh65Q7Rgdt2JGg0+VWuRPoKBp
	fAU/ov+CBCobNdmPB2E9/QDdPZVMcVlerGK94dBu8cDucq3gVixQ
X-Gm-Gg: ASbGncsnAghYJFOfvYJk6JqClESF58FXzHz4RFQrAQq3Gr45GJIGO1K6VvJt9HCRFbq
	5uwNvzgyIS8YiYnc7huJljA2RAUPQYXrngEuVptCbdMgKKDxr3dbwl1pi3fdd2pLbaa1ql2M+M0
	iUJYCBv9qXsDabr3QV/s/vlqmqO9grFNvr66I2wAHkAC1zlsRX/6rrWcSbA7qXvzyEj8uhJSKx8
	YSoHl3/0BLQ/cgqbNgJsXHUcsALbdX9j1wbaowAYIFRybpUmDijdj6A1Yr1Soa08l1vH9G9SRWJ
	4YqQWEniOGzq1lfau1H16py5/WhxM5aiDEvtngPYnNk97ksO+R40GJGMsHjAGX+wzWg1trB6lMr
	KtmuMokFzh4VAzHgLoDakiy4QpLBCS+NolTI=
X-Google-Smtp-Source: AGHT+IHcYE8/LLj0kiFeVLR9T+AdpRWKX6nUtKgMM2ov/QeiBydpmcduyzzTOanK37zj/UgZu6cPpg==
X-Received: by 2002:ad4:5cae:0:b0:6e8:ebfa:42f9 with SMTP id 6a1803df08f44-6e9005f79admr72055636d6.16.1741390181043;
        Fri, 07 Mar 2025 15:29:41 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c4b5sm24771966d6.1.2025.03.07.15.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 15:29:40 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1EF7A120006A;
	Fri,  7 Mar 2025 18:29:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 07 Mar 2025 18:29:40 -0500
X-ME-Sender: <xms:ZIHLZzDy_doWn2gcNiuPCWUfwSj67AE81_MFqFGxmGMg0ikAhjKJtQ>
    <xme:ZIHLZ5ha7ZF91FfMpd_933UGTixSOnzoj8oBiYIKlDiPUmcnQ8bU7I5pHam63suZX
    s_OFWavhGBa8ku1fA>
X-ME-Received: <xmr:ZIHLZ-l69KwG7Y3OONaFefObl7E7qkY0PoorRTFweRHF6W7iVl7dNfgcYr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeekteetjeegudeikedujeefvddvtdeigfei
    ffffleejfeeiheeiffefvdeffffgteenucffohhmrghinhepghhithhhuhgsrdgtohhmpd
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdegpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopeifihhllh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgt
    ohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhgvvhihmhhithgthhgvlhhltdesghhmrghilhdrtghomhdp
    rhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtth
    hopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZIHLZ1wXNewFLVUfBtpXxtc4pKxKpgYHW6IrYvDQAvaaVgKxeCHfOw>
    <xmx:ZIHLZ4Req9LXhsEZ1PEHFJu1hkTNWADdBh3Kw_en5Sm3amJLRYYVCw>
    <xmx:ZIHLZ4ZyeMRZuFQYTgJ3DUlQlBL_hkpoU5CO4lOa5PkhIJoAoa9wMg>
    <xmx:ZIHLZ5S4UhiPyntxikWk2PTeyi04KTQOIin1PbqI9x0tJa46qgWphQ>
    <xmx:ZIHLZ-BbLjb3Qop0xqRejr8HdR50IhOWLAj_3pZYqH4JNBGxto9kmU3h>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 18:29:39 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Mitchell Levy <levymitchell0@gmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Boqun Feng <boqun.feng@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Ingo Molnar <mingo@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Roland Xu <mu001999@outlook.com>,
	rust-for-linux@vger.kernel.org (open list:RUST)
Subject: [PATCH locking 11/11] rust: lockdep: Use Pin for all LockClassKey usages
Date: Fri,  7 Mar 2025 15:27:01 -0800
Message-ID: <20250307232717.1759087-12-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307232717.1759087-1-boqun.feng@gmail.com>
References: <Z76Uk1d4SHPwVD6n@Mac.home>
 <20250307232717.1759087-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mitchell Levy <levymitchell0@gmail.com>

Reintroduce dynamically-allocated LockClassKeys such that they are
automatically (de)registered. Require that all usages of LockClassKeys
ensure that they are Pin'd.

Currently, only `'static` LockClassKeys are supported, so Pin is
redundant. However, it is intended that dynamically-allocated
LockClassKeys will eventually be supported, so using Pin from the outset
will make that change simpler.

Closes: https://github.com/Rust-for-Linux/linux/issues/1102
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250207-rust-lockdep-v4-2-7a50a7e88656@gmail.com
---
 rust/helpers/helpers.c          |  1 +
 rust/helpers/sync.c             | 13 ++++++++
 rust/kernel/sync.rs             | 57 +++++++++++++++++++++++++++++++--
 rust/kernel/sync/condvar.rs     |  5 ++-
 rust/kernel/sync/lock.rs        |  4 +--
 rust/kernel/sync/lock/global.rs |  5 +--
 rust/kernel/sync/poll.rs        |  2 +-
 rust/kernel/workqueue.rs        |  2 +-
 8 files changed, 77 insertions(+), 12 deletions(-)
 create mode 100644 rust/helpers/sync.c

diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 0640b7e115be..4c1a10a419cf 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -30,6 +30,7 @@
 #include "signal.c"
 #include "slab.c"
 #include "spinlock.c"
+#include "sync.c"
 #include "task.c"
 #include "uaccess.c"
 #include "vmalloc.c"
diff --git a/rust/helpers/sync.c b/rust/helpers/sync.c
new file mode 100644
index 000000000000..ff7e68b48810
--- /dev/null
+++ b/rust/helpers/sync.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/lockdep.h>
+
+void rust_helper_lockdep_register_key(struct lock_class_key *k)
+{
+	lockdep_register_key(k);
+}
+
+void rust_helper_lockdep_unregister_key(struct lock_class_key *k)
+{
+	lockdep_unregister_key(k);
+}
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 16eab9138b2b..4104bc26471a 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -5,6 +5,8 @@
 //! This module contains the kernel APIs related to synchronisation that have been ported or
 //! wrapped for usage by Rust code in the kernel.
 
+use crate::pin_init;
+use crate::prelude::*;
 use crate::types::Opaque;
 
 mod arc;
@@ -23,15 +25,64 @@
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
-pub struct LockClassKey(Opaque<bindings::lock_class_key>);
+#[pin_data(PinnedDrop)]
+pub struct LockClassKey {
+    #[pin]
+    inner: Opaque<bindings::lock_class_key>,
+}
 
 // SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
 // provides its own synchronization.
 unsafe impl Sync for LockClassKey {}
 
 impl LockClassKey {
+    /// Initializes a dynamically allocated lock class key. In the common case of using a
+    /// statically allocated lock class key, the static_lock_class! macro should be used instead.
+    ///
+    /// # Example
+    /// ```
+    /// # use kernel::{c_str, stack_pin_init};
+    /// # use kernel::alloc::KBox;
+    /// # use kernel::types::ForeignOwnable;
+    /// # use kernel::sync::{LockClassKey, SpinLock};
+    ///
+    /// let key = KBox::pin_init(LockClassKey::new_dynamic(), GFP_KERNEL)?;
+    /// let key_ptr = key.into_foreign();
+    ///
+    /// {
+    ///     stack_pin_init!(let num: SpinLock<u32> = SpinLock::new(
+    ///         0,
+    ///         c_str!("my_spinlock"),
+    ///         // SAFETY: `key_ptr` is returned by the above `into_foreign()`, whose
+    ///         // `from_foreign()` has not yet been called.
+    ///         unsafe { <Pin<KBox<LockClassKey>> as ForeignOwnable>::borrow(key_ptr) }
+    ///     ));
+    /// }
+    ///
+    /// // SAFETY: We dropped `num`, the only use of the key, so the result of the previous
+    /// // `borrow` has also been dropped. Thus, it's safe to use from_foreign.
+    /// unsafe { drop(<Pin<KBox<LockClassKey>> as ForeignOwnable>::from_foreign(key_ptr)) };
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    pub fn new_dynamic() -> impl PinInit<Self> {
+        pin_init!(Self {
+            // SAFETY: lockdep_register_key expects an uninitialized block of memory
+            inner <- Opaque::ffi_init(|slot| unsafe { bindings::lockdep_register_key(slot) })
+        })
+    }
+
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
-        self.0.get()
+        self.inner.get()
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for LockClassKey {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: self.as_ptr was registered with lockdep and self is pinned, so the address
+        // hasn't changed. Thus, it's safe to pass to unregister.
+        unsafe { bindings::lockdep_unregister_key(self.as_ptr()) }
     }
 }
 
@@ -44,7 +95,7 @@ macro_rules! static_lock_class {
             // SAFETY: lockdep expects uninitialized memory when it's handed a statically allocated
             // lock_class_key
             unsafe { ::core::mem::MaybeUninit::uninit().assume_init() };
-        &CLASS
+        $crate::prelude::Pin::static_ref(&CLASS)
     }};
 }
 
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 5c1e546a26c3..fbf68ada582f 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -17,8 +17,7 @@
     time::Jiffies,
     types::Opaque,
 };
-use core::marker::PhantomPinned;
-use core::ptr;
+use core::{marker::PhantomPinned, pin::Pin, ptr};
 use macros::pin_data;
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
@@ -103,7 +102,7 @@ unsafe impl Sync for CondVar {}
 
 impl CondVar {
     /// Constructs a new condvar initialiser.
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index f53e87d04cd2..360a10a9216d 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -12,7 +12,7 @@
     str::CStr,
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
-use core::{cell::UnsafeCell, marker::PhantomPinned};
+use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
 use macros::pin_data;
 
 pub mod mutex;
@@ -129,7 +129,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             data: UnsafeCell::new(t),
             _pin: PhantomPinned,
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 480ee724e3cc..d65f94b5caf2 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -13,6 +13,7 @@
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
+    pin::Pin,
 };
 
 /// Trait implemented for marker types for global locks.
@@ -26,7 +27,7 @@ pub trait GlobalLockBackend {
     /// The backend used for this global lock.
     type Backend: Backend + 'static;
     /// The class for this global lock.
-    fn get_lock_class() -> &'static LockClassKey;
+    fn get_lock_class() -> Pin<&'static LockClassKey>;
 }
 
 /// Type used for global locks.
@@ -270,7 +271,7 @@ impl $crate::sync::lock::GlobalLockBackend for $name {
             type Item = $valuety;
             type Backend = $crate::global_lock_inner!(backend $kind);
 
-            fn get_lock_class() -> &'static $crate::sync::LockClassKey {
+            fn get_lock_class() -> Pin<&'static $crate::sync::LockClassKey> {
                 $crate::static_lock_class!()
             }
         }
diff --git a/rust/kernel/sync/poll.rs b/rust/kernel/sync/poll.rs
index d5f17153b424..c4934f82d68b 100644
--- a/rust/kernel/sync/poll.rs
+++ b/rust/kernel/sync/poll.rs
@@ -89,7 +89,7 @@ pub struct PollCondVar {
 
 impl PollCondVar {
     /// Constructs a new condvar initialiser.
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
         pin_init!(Self {
             inner <- CondVar::new(name, key),
         })
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0cd100d2aefb..6b6f3ad08951 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -369,7 +369,7 @@ unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
 impl<T: ?Sized, const ID: u64> Work<T, ID> {
     /// Creates a new instance of [`Work`].
     #[inline]
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
+    pub fn new(name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self>
     where
         T: WorkItem<ID>,
     {
-- 
2.47.1


