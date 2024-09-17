Return-Path: <linux-kernel+bounces-332131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25E497B5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C772A1C236C7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FAC1991C6;
	Tue, 17 Sep 2024 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYUTDoMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880C21991AB;
	Tue, 17 Sep 2024 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612171; cv=none; b=fctUCrugq6dB50/MDekJM3x7B4hBvivv/vyX1ppjbNwnuvAJ891wjLem9vdvRtiLmwdX2xp345XozgLODe2a1qf8WG9PHOTWf0TKZ5My2lP2oPM4aC4+YrfGTujI7cSspy7BpeiOkIM0jNWAHgr3FAPPZXSB1bdFT6r9Z6VPIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612171; c=relaxed/simple;
	bh=xwfzR0ZFcy+ml+aZSm4lbnNCMsv68dKQVX8/+4KnwsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMN9KKEz55hbBm8E/w3iQkEjen32ZGcQoETu1pGMj8viEy4hn6g6G72Co46vMXcQRw0+ckiOBYBEEHzLo3JQqOLdp03S9l2YjIFY0TW4ueD83xxDS5TaSPhgM7hk2hgz6gJ/EM9WujnU2krB3m3jex4Q2mHAuuxOrD5E0gIWL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYUTDoMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F74C4CECE;
	Tue, 17 Sep 2024 22:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612171;
	bh=xwfzR0ZFcy+ml+aZSm4lbnNCMsv68dKQVX8/+4KnwsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FYUTDoMPkodKPu2zkyJLTZpBG5RZw9fMQYi+wZ7FS6X9ga+BUk+zG93MGo9n6rO6z
	 gWX4yhGwugoelmUAk/QCDJhp02E/h3YtAwlkehYrk1lg0VqQIeQtK/nE99fZnPCVtF
	 CbzYe5D7Y4ZUJi54eO9win3FRkhK33ZjfjFoFQOs2FlFctHUUZpvXNixYBsURQNO7i
	 nAZ6GHEsF6HU7gAX+XAQ7OjkfuacBRNkRndGsaoHGTIMkmTEonAAcXWzYoSkL+OiMI
	 fY5Ih0COcOzjbO6MEE3dOMkdf0laIQqAzveO17fHWT2sZK+5+lrHdBOzH5nyqkMOSO
	 WjuMlvOumdTUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/14] rust: hrtimer: implement `TimerPointer` for `Pin<Box<T>>`
Date: Wed, 18 Sep 2024 00:27:36 +0200
Message-ID: <20240917222739.1298275-13-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=a.hindborg@kernel.org; h=from:subject; bh=xwfzR0ZFcy+ml+aZSm4lbnNCMsv68dKQVX8/+4KnwsM=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWdEWEg3aTJCclBRZXU3OTN4TGFNcjNCCnlwVVpNOTdKcmttcktZR1ZH SEhUK0lrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSUF BQW9KRU9HNEdqNTVLR04zdkVVUUFLNUoyOXAwUkZrMThuQzYwMllnWGdOeHR0UDFsdDVWUUVPcQ pmdEZXWTVRdHJLMUhEdzFDUGxpenZPSDJvVlBKMzdNbnZwMm9nVFVPdG51UEtNV1dNMzdMcGtXc FB3UkpQRXVECk91ZlFQeHNtcEx1d3o3Smh4TmRkQk9SQzVWV3RLcnloUHVKUnRqbklqOWREOFV4 SURGR3NUQyszQjV0M2JVWm0KOHR3aE45TEFTQjlIaDFpUWtScnovY245VFhac2NpOE1ZQmpEbTg 2WGhWTXJrcWlhdTRhdVMvQ3lGWWpySVlwdQpYTnE3TldvOVRDK2dEa2R0MlYvbUkzTk40U3B3Um VPUFNVTG85MXVtL1Z0MkF4dVk2cUFzdzJrWlVubEw3ZWhPClo3QXNCM3dXMlg4TnhaOENsUmpqN XdkNGVrcU5ncVhnK1pObThxdzV2WEV4ajh0RmRHeVdqRVh6eDNucUNxS3UKTU0rUzY1NFZUa2Ri KzNlSTZ0ZzA1bExYUTJucWxkTXpEdjlzNFJCeG5wS2NwVEhtNC9Nbk1MYzQ5V2VKYVFFWApXYkd tYUNCWFJzOXNCQVNTO
 Ww2OUhxRDVueURWK2QyVzZmZjE2czNXVldaSDVSUHVuN2g4TVpyYVpzU2 pFNGlUCnFqWlRsb01Xb2xYVWVwWDh3aWFHZG1LSzh4REh2NVRVeUFoZXZqTnBwak1qelRoZ2RjN ll5VFhGbi9vOFpFZWIKZW1JT0laaW1MTTUvZUZLeU5YUE5nOEFjcmZpNll4UTV4ZzZ2bGtxd25s ZXNOYUJwZk5iMWJoQmlVL0p2QnpJbgp2N0Fma2ZBcGJRSld6Tm9sUHY2YkxDaHVoOUltR1RuMWx KbjZhNGJLSDU1SzZPM1hMRHZzbyswaytNN1Rlc2VlCnlTdXJoTDhZQ1hVdC9RPT0KPURSalUKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Allow `Pin<Box<T>>` to be the target of a timer callback.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs      |  3 ++
 rust/kernel/hrtimer/tbox.rs | 95 +++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 rust/kernel/hrtimer/tbox.rs

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 38160221f93e..1750016b2b22 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -493,6 +493,9 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
     }
 }
 
+// `box` is a reserved keyword, so prefix with `t` for timer
+mod tbox;
+
 mod arc;
 mod pin;
 mod pin_mut;
diff --git a/rust/kernel/hrtimer/tbox.rs b/rust/kernel/hrtimer/tbox.rs
new file mode 100644
index 000000000000..089e6ba97801
--- /dev/null
+++ b/rust/kernel/hrtimer/tbox.rs
@@ -0,0 +1,95 @@
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
+/// [`TimerPointer::schedule`].
+pub struct BoxTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    pub(crate) inner: *mut U,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<U> TimerHandle for BoxTimerHandle<U>
+where
+    U: HasTimer<U>,
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
+impl<U> Drop for BoxTimerHandle<U>
+where
+    U: HasTimer<U>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<U> TimerPointer for Pin<Box<U>>
+where
+    U: Send + Sync,
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U>>>,
+    U: for<'a> TimerCallback<CallbackPointer<'a> = &'a U>,
+{
+    type TimerHandle = BoxTimerHandle<U>;
+
+    fn schedule(self, expires: Ktime) -> Self::TimerHandle {
+        use core::ops::Deref;
+        let self_ptr = self.deref() as *const U;
+
+        // SAFETY: Since we generate the pointer passed to `schedule` from a
+        // valid reference, it is a valid pointer.
+        unsafe { U::schedule(self_ptr, expires) };
+
+        // SAFETY: We will not move out of this box during timer callback (we
+        // pass an immutable reference to the callback).
+        let inner = unsafe { Pin::into_inner_unchecked(self) };
+
+        BoxTimerHandle {
+            inner: Box::into_raw(inner),
+        }
+    }
+}
+
+impl<U> RawTimerCallback for Pin<Box<U>>
+where
+    U: HasTimer<U>,
+    U: for<'a> TimerCallback<CallbackTarget<'a> = Pin<Box<U>>>,
+    U: for<'a> TimerCallback<CallbackPointer<'a> = &'a U>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `Timer` is `repr(transparent)`
+        let timer_ptr = ptr.cast::<kernel::hrtimer::Timer<U>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `Timer<T>` embedded in a `T`.
+        let data_ptr = unsafe { U::timer_container_of(timer_ptr) };
+
+        // SAFETY: We called `Box::into_raw` when we queued the timer.
+        let tbox = ManuallyDrop::new(unsafe { Box::from_raw(data_ptr) });
+
+        use core::ops::Deref;
+        U::run(tbox.deref()).into()
+    }
+}
-- 
2.46.0



