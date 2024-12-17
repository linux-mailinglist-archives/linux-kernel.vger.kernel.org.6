Return-Path: <linux-kernel+bounces-449448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D809F4F45
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F17188C713
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446721F76C2;
	Tue, 17 Dec 2024 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1cLTgo0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD58148850;
	Tue, 17 Dec 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448772; cv=none; b=FlIdSNueckqJr9jzLvX3WrEgR7NK0+4go0CxymO4cuxFteBZaH9YVz56QXTYyeZf8RBI1Y9KLT5VAza3mXDnZagBmGor0vDnNFsi1NZgH48BdwC9dU16jv3qAGjmc80a4ko/5h7uG1YfwrQZhrTHY+k/yq7QU2gZ0sr/qdGHSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448772; c=relaxed/simple;
	bh=IockKtI7QGJV7LebkeC6HsGmg4JRpkVZ9iWx/ck781A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L53GJmxKjTphY4qoBl5ut9viVirFUzODde9IDK7wKm0SIvCqYL2PbPNhv+B7wKUtsHRFZpN0OzeN5sB9pLA6FtbCjQE8gt59h1GxygV78Ow8tDgjEMTntziHvSRmhrRvK6BYZuZLSconzijRnWP3hOaf/8yTIHDHD/gx6hv21Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1cLTgo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF432C4CED6;
	Tue, 17 Dec 2024 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448772;
	bh=IockKtI7QGJV7LebkeC6HsGmg4JRpkVZ9iWx/ck781A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g1cLTgo0pmaywInUfUscY/Q9kujnLjO+lBMaYtjabvNo6mKwISjgvD48am9vkEtgz
	 vrYuTGg32sJhCFAB+EsXL2tkEgdlrxtRXZowVoOXMJWjcRKqPSEZY5PfgdyBEE8uTB
	 d18R8lOd8pYz5GHyy+Fy4/S7jqIFqFLZWVRO6SE6O0wUbcKxgzFCXjrwPviKumUkZX
	 DmNnbGUitAM3oOKVHawUKhMA/SK/AU46gVkMy1GkxjoLWAa5vwWZW7XkYnCzDs8EDc
	 /nxH6729Hl+lwhLmnnCQdSCgALfg+4vbfvnHVOM+pRBFlfXmbr+/6YdboHLbIztKvT
	 Pk2pTacqlKj7A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:42 +0100
Subject: [PATCH v5 11/14] rust: hrtimer: implement `TimerPointer` for
 `Pin<Box<T>>`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-11-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4446; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=IockKtI7QGJV7LebkeC6HsGmg4JRpkVZ9iWx/ck781A=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYbVJ45/hEWh8UYwRE6hMhUIHwpq62jdxXhK
 ES/LrNETCuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWGwAKCRDhuBo+eShj
 d8qtD/9nfl55jzwMkmbLmSa+P5NcDaQYKMTNZIC2VGBPwoq49MxUF10Mtl2uq4NmCqWUeywPmUs
 0zRBTAQhMOW9vaGwRuakB4UldRekWt0dD4EJqylb9fqW55dC+veNrT5pgq55JvxpnbpAFmBHNSx
 P1KIIoMguGwf1lyxlJm/dd+NHzNduN5YW9KYXzXfsQdduWy5BZxRWJp1zpQWGE02RpxtsqttW2t
 N7HURVG85M7BfiX8BDndNAWjXpBekDaYNiIXF0bB51f2Q81Jri2aHbnxPvgNgj13om/2F4pVwr7
 SkwjUS6JCP6L4e/jQtY+3ejnEhNkJy5tmTRL9p1BZWwDYibMz+ml7AG7AE+n9Gyvci9CnmT95ax
 Y9oP6qC/uq96NrOnErMz5oyv0TE2TT1uMw81oO208Lbmv6EqNeyPnvLc2rtj5ynYpOrLj0NkT71
 KJ/D/h70Hgv/GkwXxXBOCD9Ycny6OoWRzOD4BzPflYGJPzMZRgfd1R9n4CQv7RKAip5+C8Sh9cn
 RbB6LuIORoS2A0FZHTESRD54qgSZ6hOJ+cnqqG+JXen2BfaVh5N/pPO/g2188yFlUu9sQdShRPD
 NZuCrvS7dGv1JDrRBupVvdnezWJCkHMzU9oGEx+s/XrQchwKatSwhj1L93Fc0YXS1SaT1x/LBqV
 J7cEhf98uRLfBcg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow `Pin<Box<T>>` to be the target of a timer callback.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs      |   3 ++
 rust/kernel/time/hrtimer/tbox.rs | 102 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index c223f1385c723a0b75e7f8184deadbca38872e0a..46dbf0d7fe30d271a2b76af89cc4e9e18b42a19a 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -395,6 +395,9 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
     }
 }
 
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+
 mod arc;
 mod pin;
 mod pin_mut;
diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
new file mode 100644
index 0000000000000000000000000000000000000000..4b932a20cf6fcacdff7c40fc280f8d73a45addc0
--- /dev/null
+++ b/rust/kernel/time/hrtimer/tbox.rs
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasTimer;
+use super::RawTimerCallback;
+use super::Timer;
+use super::TimerCallback;
+use super::TimerHandle;
+use super::TimerPointer;
+use crate::prelude::*;
+use crate::time::Ktime;
+use core::mem::ManuallyDrop;
+
+/// A handle for a `Box<HasTimer<U>>` returned by a call to
+/// [`TimerPointer::start`].
+pub struct BoxTimerHandle<U, A>
+where
+    U: HasTimer<U>,
+    A: crate::alloc::Allocator,
+{
+    pub(crate) inner: *mut U,
+    _p: core::marker::PhantomData<A>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<U, A> TimerHandle for BoxTimerHandle<U, A>
+where
+    U: HasTimer<U>,
+    A: crate::alloc::Allocator,
+{
+    fn cancel(&mut self) -> bool {
+        // SAFETY: As we obtained `self.inner` from a valid reference when we
+        // created `self`, it must point to a valid `U`.
+        let timer_ptr = unsafe { <U as HasTimer<U>>::raw_get_timer(self.inner) };
+
+        // SAFETY: As `timer_ptr` points into `U` and `U` is valid, `timer_ptr`
+        // must point to a valid `Timer` instance.
+        unsafe { Timer::<U>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<U, A> Drop for BoxTimerHandle<U, A>
+where
+    U: HasTimer<U>,
+    A: crate::alloc::Allocator,
+{
+    fn drop(&mut self) {
+        self.cancel();
+        // SAFETY: `self.inner` came from a `Box::into_raw` call
+        drop(unsafe { Box::<U, A>::from_raw(self.inner) })
+    }
+}
+
+impl<U, A> TimerPointer for Pin<Box<U, A>>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U, A>>>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = Pin<&'a U>>,
+    A: crate::alloc::Allocator,
+{
+    type TimerHandle = BoxTimerHandle<U, A>;
+
+    fn start(self, expires: Ktime) -> Self::TimerHandle {
+        let self_ptr: *const U = <Self as core::ops::Deref>::deref(&self);
+
+        // SAFETY: Since we generate the pointer passed to `start` from a valid
+        // reference, it is a valid pointer.
+        unsafe { U::start(self_ptr, expires) };
+
+        // SAFETY: We will not move out of this box during timer callback (we
+        // pass an immutable reference to the callback).
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+
+        BoxTimerHandle {
+            inner: Box::into_raw(inner),
+            _p: core::marker::PhantomData,
+        }
+    }
+}
+
+impl<U, A> RawTimerCallback for Pin<Box<U, A>>
+where
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U, A>>>,
+    U: for<'a> TimerCallback<CallbackTargetParameter<'a> = Pin<&'a U>>,
+    A: crate::alloc::Allocator,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(C)`
+        let timer_ptr = ptr.cast::<super::Timer<U>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `Timer<T>` embedded in a `T`.
+        let data_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: We called `Box::into_raw` when we queued the timer.
+        let tbox = ManuallyDrop::new(Box::into_pin(unsafe { Box::<U, A>::from_raw(data_ptr) }));
+
+        U::run(tbox.as_ref()).into()
+    }
+}

-- 
2.47.0



