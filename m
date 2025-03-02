Return-Path: <linux-kernel+bounces-540501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D98A4B161
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984493A49B4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAE81DE4DB;
	Sun,  2 Mar 2025 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="z3Rip9CW"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A4F4C85
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740917047; cv=none; b=BAtXhUKdUPqulXLgIPraVBf8NlZyheSHHSGcWibi2iriB7hTWVAPZNZWtShVbKkF7NRybw/wU25gMOk0FMEJ+wxDjfqQ233FSfEteOzNpI47+RyyCDgU7aTCZeOBcGcmRJsRFnOvSBvAyYARb7vgWKgThO1SShJ/qpf97ymgOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740917047; c=relaxed/simple;
	bh=rUSK+MPqWK7JW6t+Kl156HmvY1C0gKinUp6cPdJpfY8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pZJmt2v55M7cDpwfYOA/C6q9KZo0+FOsjbYBgf551w/9n6XacQgqcYhKkg7GvGtw1k+nMFDfxuWXsgBVhUmot4UXHP6QWI3mlydMnu7AnUSGbVkJIpTsvhZNy+tPDz2Q4RiHj48TkXRChYITTavvktYre05EtRLbmcdsEaFnARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=z3Rip9CW; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740916738; bh=MP9cTQS18F1Nay+dJn0ruW2FP+4xeNvoNS0Kd03Zylk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=z3Rip9CW2RC7xF2B8NiDp0eUWN1emUBLUAWRKGIg+fdiqRj5Uf5UWW20sF/BozdCm
	 L0Wco+eIihMqZtQAsLbaDjfZ3iGdlNTrfzzmCBICoLLoJVSQ8h2baxmnSqRHnESG08
	 x5is8BkBBSYIMi7OZZKcXDmbF5pNyzObaSK/y6DY=
Received: from jckeep-Lenovo-XiaoXinAir-14IIL-2020.. ([240e:3b1:d00c:8e21:ca33:76fa:6eaa:ba4e])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id CEEA88A1; Sun, 02 Mar 2025 19:51:46 +0800
X-QQ-mid: xmsmtpt1740916306tzgkvdr02
Message-ID: <tencent_E9A9DFA5B2C6059DAF39777A40FB86753606@qq.com>
X-QQ-XMAILINFO: MJf32pulH481pe77k9pFMDKMt8LQXajXPlG3FPBFZ+6X9Gh4bexTU+KoZf1uVP
	 eCg1IPJA5xFTOpQdvkJRlJr0HcarFPKF3IFP2kFOK75DJ6JxXrzfMGxMElqsO2H0RfEi/rLr9H4m
	 xdYxfFJ5mTtO+zEhmPLH8wnwiDcZFJi3Xq+8GpAkLEcmEwh+VLlQ107L3Tzt21Cj5HCrTB450XY0
	 qPxHcGwJGtbKfBjGCyDqj8lga/izpeHTnsr65DFJFzt85eYLGypiiQnFLRV6kaB1VdVV+t2DczBR
	 3xFQCvHCWS4GXmVFh1jOWpqL/waUKfzqz0LBBeExGpItERE/S3NYIWbkw9SjA3zbWlkrzr+qABTD
	 KcW1W1uvW/ibuLNcjPRLEGUjPD7KLWSFG+IyBvQpa4E+562vYw1u1nIFockyMYYvAWImXFg3gPwG
	 ph1pFiiuI/rJ4RDgFgE3g+z7iOuepEJ7M2ls60DO0I3YMhnqU/GoaC8EjNB8Ho8U8PAVoWX42DQl
	 GE6pMf/qYxF+aHbeHiU5GpAqCfKtj/5SPUPJo7Giu7PKn4NPTYN3eUpGJBYDoKIO2TtfWxB8efNF
	 +lo9n0fHqGwRxwh245Kff7hrW5La/kLe2TV44No1EqxyWbaQYVzMx5sTnsdnfXN9ycVEmYosSgWH
	 lj/7szLldexy8FT3hAdrpoBkKwC1ZaiweuOfhlgT3mkDa2gLAAYvaP/Hokxiif9o3yjMQwbGkaF8
	 Vqon7xl/d7LWshH1XrbmWyd/E0uqI20ChinC4uuu3FYwGbMbq9p0scNiurpKcsWs9XJIIDJ0DF0I
	 wmCayHc20zJK3GqFQm59pLXVuez7mRDhAEyjUy6Ds+etO4Y7aOpDf89tvgxRiVy81MgdlobjKMHR
	 GdfMS7JDUydaaH2HbZUM17KS6fVTlHbnWIHnDmk+UiiRVjEgHB1fRq37/mja1GjMyLUKHTqYwGp0
	 Crd7jglu1cSjnSdoKYbnaZ2ihxi2KJcAy5YJWLuue0/wuzymq3+Q==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Guangbo Cui <2407018371@qq.com>
To: lyude@redhat.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	mingo@redhat.com,
	ojeda@kernel.org,
	peterz@infradead.org,
	rust-for-linux@vger.kernel.org,
	tglx@linutronix.de,
	tmgross@umich.edu,
	wedsonaf@gmail.com,
	will@kernel.org
Subject: Re: [PATCH v9 6/9] rust: sync: Add SpinLockIrq
Date: Sun,  2 Mar 2025 19:51:46 +0800
X-OQ-MSGID: <20250302115146.59946-1-2407018371@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227221924.265259-7-lyude@redhat.com>
References: <20250227221924.265259-7-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +/// A kernel `spinlock_t` lock backend that is acquired in interrupt disabled contexts.
> +pub struct SpinLockIrqBackend;
> +
> +/// A [`Guard`] acquired from locking a [`SpinLockIrq`] using [`lock()`].
> +///
> +/// This is simply a type alias for a [`Guard`] returned from locking a [`SpinLockIrq`] using
> +/// [`lock_with()`]. It will unlock the [`SpinLockIrq`] and decrement the local processor's
> +/// interrupt disablement refcount upon being dropped.
> +///
> +/// [`Guard`]: super::Guard
> +/// [`lock()`]: SpinLockIrq::lock
> +/// [`lock_with()`]: SpinLockIrq::lock_with
> +pub type SpinLockIrqGuard<'a, T> = super::Guard<'a, T, SpinLockIrqBackend>;
> +
> +// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
> +// default implementation that always calls the same locking method.
> +unsafe impl super::Backend for SpinLockIrqBackend {
> +    type State = bindings::spinlock_t;
> +    type GuardState = ();
> +
> +    unsafe fn init(
> +        ptr: *mut Self::State,
> +        name: *const crate::ffi::c_char,
> +        key: *mut bindings::lock_class_key,
> +    ) {
> +        // SAFETY: The safety requirements ensure that `ptr` is valid for writes, and `name` and
> +        // `key` are valid for read indefinitely.
> +        unsafe { bindings::__spin_lock_init(ptr, name, key) }
> +    }
> +
> +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> +        // memory, and that it has been initialised before.
> +        unsafe { bindings::spin_lock_irq_disable(ptr) }
> +    }
> +
> +    unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
> +        // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
> +        // caller is the owner of the spinlock.
> +        unsafe { bindings::spin_unlock_irq_enable(ptr) }
> +    }
> +
> +    unsafe fn try_lock(ptr: *mut Self::State) -> Option<Self::GuardState> {
> +        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
> +        let result = unsafe { bindings::spin_trylock_irq_disable(ptr) };
> +
> +        if result != 0 {
> +            Some(())
> +        } else {
> +            None
> +        }
> +    }
> +
> +    unsafe fn assert_is_held(ptr: *mut Self::State) {
> +        // SAFETY: The `ptr` pointer is guaranteed to be valid and initialized before use.
> +        unsafe { bindings::spin_assert_is_held(ptr) }
> +    }
> +}

It would be nice to add `SpinLockIrqBackend` to `global_lock`.

---
 rust/kernel/sync/lock/global.rs | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index 480ee724e3..60b88f362b 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -298,4 +298,7 @@ macro_rules! global_lock_inner {
     (backend SpinLock) => {
         $crate::sync::lock::spinlock::SpinLockBackend
     };
+    (backend SpinLockIrq) => {
+        $crate::sync::lock::spinlock::SpinLockIrqBackend
+    };
 }
-- 

Best regards,
Guangbo Cui


