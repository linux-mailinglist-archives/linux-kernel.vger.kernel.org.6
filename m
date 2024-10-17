Return-Path: <linux-kernel+bounces-369824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE899A232F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8EE1C27C13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56041DF240;
	Thu, 17 Oct 2024 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsofrX/E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286351DE8A6;
	Thu, 17 Oct 2024 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170582; cv=none; b=s5rkXOz7arCpoy7n9rNployWJXE3qvpkJAy++Cpt/PXllTRvgF/S9dIhjRkKR9gsbYc3KOb8BTdMi7dx7xaxtb5S0bwA6GizElpaLbLfpZ5fcT/Nkhz444lQWBIe2DUDdPvOm6HTEcDk/L6HULGEaDte3RlEU66qURZZki2kz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170582; c=relaxed/simple;
	bh=BwgOBAi5yShmdWTwzvNb4FXstAurI+WiBcPUMOK/JIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzyDZ3p8xBp99N7s2lte69+Vu2iVsV/jNBBj7VEnxEKYR/Bsb86TxFHRmLexVtlBrsJCXvqQcxWCpsWqDaqKm1JLC+yx66YjuAAl1PYAyMuIsnABhU5shBhtpG0VPDTrYBXrvs01hih/3p3ob1pwCDxOUApAQrpkEiEYR3aUUuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsofrX/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75731C4CEC3;
	Thu, 17 Oct 2024 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170580;
	bh=BwgOBAi5yShmdWTwzvNb4FXstAurI+WiBcPUMOK/JIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WsofrX/EaHtbdH1OJXFOvbZ9Xog1OIC5OzzBQKA9fSZKCySsbg2TtGT2rRZiAgWr7
	 s7TppwDrkllyrh80V7r640hVwSl2YiBNl/FUckwkZE8fM8MrcyWHs4CVRNoPAcoSI5
	 ioawsHljkKSkOmIuxKKL7iNn9/MpGqFzPlvSTEm4pCpkDjLp1xZko4l2DDbSP5AjPd
	 D8nshqg78D5xZBanTKy6xGxrjPRUDk8hIvqEN5PXw90xJQMh7p49UiX+y3fKuuGcH3
	 SXpL9Vt6FhPIKB/dvWsevy4AgC6SNGdHowV5Cd2YWIIQvyR5isZBM/b1t1r0BuPDH2
	 jTy7aPYaddt+A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 17 Oct 2024 15:04:33 +0200
Subject: [PATCH v3 06/13] rust: hrtimer: add `UnsafeTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-6-59a75cbb44da@kernel.org>
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

Add a trait to allow unsafely queuing stack allocated timers.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index eeed2afd501b64b94d57cc658616659e28785078..e97d7b8ec63ce6c9ac3fe9522192a28fba78b8ba 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -151,6 +151,39 @@ pub trait TimerPointer: Sync + Sized {
     fn start(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// Unsafe version of [`TimerPointer`] for situations where leaking the
+/// `TimerHandle` returned by `start` would be unsound. This is the case for
+/// stack allocated timers.
+///
+/// Typical implementers are pinned references such as [`Pin<&T>].
+///
+/// # Safety
+///
+/// Implementers of this trait must ensure that instances of types implementing
+/// [`UnsafeTimerPointer`] outlives any associated [`TimerPointer::TimerHandle`]
+/// instances.
+///
+/// [`Pin<&T>`]: Box
+pub unsafe trait UnsafeTimerPointer: Sync + Sized {
+    /// A handle representing a running timer.
+    ///
+    /// # Safety
+    ///
+    /// If the timer is running, or if the timer callback is executing when the
+    /// handle is dropped, the drop method of `TimerHandle` must not return
+    /// until the timer is stopped and the callback has completed.
+    type TimerHandle: TimerHandle;
+
+    /// Start the timer after `expires` time units. If the timer was already
+    /// running, it is restarted at the new expiry time.
+    ///
+    /// # Safety
+    ///
+    /// Caller promises keep the timer structure alive until the timer is dead.
+    /// Caller can ensure this by not leaking the returned `Self::TimerHandle`.
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;
+}
+
 /// Implemented by [`TimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `TimerPointer` to make it easier to specify trait bounds.

-- 
2.46.0



