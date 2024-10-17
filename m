Return-Path: <linux-kernel+bounces-369826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3039A2331
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229DD280EEE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B81DF260;
	Thu, 17 Oct 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdvHDHcC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151631DE2AD;
	Thu, 17 Oct 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170589; cv=none; b=mUAGrRuV0vtlD3oK/2Z/siEKH8lK0DdNqApz4Q3JmlU7XduC1faefOLKqtcxVYlX/MR8CZSUskIjs0jg+3D/RQi5rPvclt+pqSN7XSvZyS2IXCvcz1a+DoKhDS34Hs4yH6SkMOE4CSUZ5+cMk4RpYBJW3y1mW/ZZZVLYmTKDDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170589; c=relaxed/simple;
	bh=5K0yiQ3f26xg0MDHhzbmwWVR37a+DzYwHtFeTLTca1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a+rwLottZEiaazHC+oTl/8y2tzwKStLY30GRkFPeMymWKtzEW1/bznbLIJ+vExVde54vfIMa5m8RBL9h+me0T7tAqOp1zxFSr7KFn19rGwyi5/dAFzohZ7bnI4FOXONkFvUHDD/sTwoHsLbP9J4yy+bdq+6sl5CtX4GjK4Vr2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdvHDHcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72765C4CEC3;
	Thu, 17 Oct 2024 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170588;
	bh=5K0yiQ3f26xg0MDHhzbmwWVR37a+DzYwHtFeTLTca1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XdvHDHcC2qFBDxhuvVWplIb0PNKti6pP3/674B+02Ato/qYJ+RChxQfjb2Ummqhtq
	 5TI8nk4RnR9J8z2RvP5AijDfZCxS43UgpRcFtJNcxGqY7WjVEnwDkX397Lph4unwFp
	 GpX4h+BJmj5q8OrhWI5x0j8Zcg/89nN5tR1/S4lVs7kHmbvt3QHYlPA3ajiwQu2O3n
	 4JnxwxxGJSDYzR9HXziYdqK0UpySxTGFnVyt7NamQExf9kN9yqcGBMCyUdtH9zXPWR
	 lmBDP/5Td6LTPYbMlD/k0m6E/rx0vU3muxf0rIyk3FNWZV2lfycc8iNjIrt+H2XZRs
	 lRnjHsHSG0FrQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:32 +0200
Subject: [PATCH v3 05/13] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-5-59a75cbb44da@kernel.org>
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
In-Reply-To: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2

This patch allows timer handlers to report that they want a timer to be
restarted after the timer handler has finished executing.

Also update the `hrtimer` documentation to showcase the new feature.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs     | 28 +++++++++++++++++++++++++++-
 rust/kernel/hrtimer/arc.rs |  4 +---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 6427b0450c694105190c8cddea0c768ab195aca2..eeed2afd501b64b94d57cc658616659e28785078 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -176,7 +176,7 @@ pub trait TimerCallback {
     type CallbackTargetParameter<'a>;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: Self::CallbackTargetParameter<'_>)
+    fn run(this: Self::CallbackTargetParameter<'_>) -> TimerRestart
     where
         Self: Sized;
 }
@@ -270,6 +270,32 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
     }
 }
 
+/// Restart policy for timers.
+pub enum TimerRestart {
+    /// Timer should not be restarted.
+    NoRestart,
+    /// Timer should be restarted.
+    Restart,
+}
+
+impl From<u32> for TimerRestart {
+    fn from(value: bindings::hrtimer_restart) -> Self {
+        match value {
+            0 => Self::NoRestart,
+            _ => Self::Restart,
+        }
+    }
+}
+
+impl From<TimerRestart> for bindings::hrtimer_restart {
+    fn from(value: TimerRestart) -> Self {
+        match value {
+            TimerRestart::NoRestart => bindings::hrtimer_restart_HRTIMER_NORESTART,
+            TimerRestart::Restart => bindings::hrtimer_restart_HRTIMER_RESTART,
+        }
+    }
+}
+
 /// Use to implement the [`HasTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
index 881de053ecad866a26e46a0123ec2bf38511c2bc..c6283bd0dbb10dbc733c3f4092f107db2f3c5c5f 100644
--- a/rust/kernel/hrtimer/arc.rs
+++ b/rust/kernel/hrtimer/arc.rs
@@ -82,8 +82,6 @@ impl<U> RawTimerCallback for Arc<U>
         // timer. This `U` is contained in an `Arc`.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        U::run(receiver);
-
-        bindings::hrtimer_restart_HRTIMER_NORESTART
+        U::run(receiver).into()
     }
 }

-- 
2.46.0



