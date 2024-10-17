Return-Path: <linux-kernel+bounces-369825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFC99A2330
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087991F22FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D71DF25C;
	Thu, 17 Oct 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mq+pY+/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E31DE8AB;
	Thu, 17 Oct 2024 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170585; cv=none; b=ZmIeAGn/lktXycgzlWKW6llpc8gb550fj9ba4Fv+4RBb2W+qBpDCadHd3lKSD8yzPUNFukiVuycYrKGjpni05oVgE70q7C3Loe8k02TYbQiqItIFvzCZUi/V7zx+ZDpcnCi7yxOsd8W3DnAY3TwguuL4XNBKaCbkhYJB57P0ahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170585; c=relaxed/simple;
	bh=ubHMqwiCJXg9dE3U2XZY1Btul8vxT790+NI8IDvfJuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBFDhGBLlW3PIUfwo24JYFGdS0J2SgAhg8G+NUpCroe+nTQFH2nKF6sVxAzLiNNk1s93fq5yJP1G0y1aOW8H1Jk8jX2AI7ak583Z+HCvrpE+lEqnkIZTSYuuzyqmqBoVTy3byD8OPUgyyXmVAWKDJnkzAdCAIh2bbivv3HzoXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mq+pY+/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EA0C4CEC5;
	Thu, 17 Oct 2024 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170584;
	bh=ubHMqwiCJXg9dE3U2XZY1Btul8vxT790+NI8IDvfJuU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mq+pY+/LTrq/w9pHX6cpZV5ibbpxS1npFZ19lxdGDdXV7cxH7KMDr0Udi03gZecqR
	 drwGS5D4Nks8gLROMjg10vVDt9EV6xMLm0L6moGXMR3nShVKIm6LlidZtJzUVWX5PH
	 V14q0NcArZUPAz2T5aTxjoUNKhSCxMgezQBEXD+r+gNC9n9X7OL8/8i3vjIg2EdIV1
	 JilrQ7Uf6xAjuuWBBBmwbP+SvUnsuxLXtJ/E+LW255pHqV8cL/1bJYYSd3rznbh5pQ
	 9gSF7DKo6PdkP8aXsdZlBPjDi0zN/0BmgesJ2hq4x4lrl9VyNExv4qSy02hzrdGKcZ
	 x0SnS99kh5teg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:36 +0200
Subject: [PATCH v3 09/13] rust: hrtimer: add `hrtimer::ScopedTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-9-59a75cbb44da@kernel.org>
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

Add the trait `ScopedTimerPointer` to allow safe use of stack allocated
timers. Safety is achieved by pinning the stack in place while timers are
running.

Implement the trait for all types that implement `UnsafeTimerPointer`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 940390aa2a6c6a222534b545d8d2fbd639a19f64..d8cea8b15a9afc134b10dc5703d88d70323fc943 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -184,6 +184,39 @@ pub unsafe trait UnsafeTimerPointer: Sync + Sized {
     unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// A trait for stack allocated timers.
+///
+/// # Safety
+///
+/// Implementers must ensure that `start_scoped` does not return until the
+/// timer is dead and the timer handler is not running.
+pub unsafe trait ScopedTimerPointer {
+    /// Start the timer to run after `expires` time units and immediately
+    /// after call `f`. When `f` returns, the timer is cancelled.
+    fn start_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    where
+        F: FnOnce() -> T;
+}
+
+// SAFETY: By the safety requirement of `UnsafeTimerPointer`, dropping the
+// handle returned by [`UnsafeTimerPointer::start`] ensures that the timer is
+// killed.
+unsafe impl<U> ScopedTimerPointer for U
+where
+    U: UnsafeTimerPointer,
+{
+    fn start_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    where
+        F: FnOnce() -> T,
+    {
+        // SAFETY: We drop the timer handle below before returning.
+        let handle = unsafe { UnsafeTimerPointer::start(self, expires) };
+        let t = f();
+        drop(handle);
+        t
+    }
+}
+
 /// Implemented by [`TimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `TimerPointer` to make it easier to specify trait bounds.

-- 
2.46.0



