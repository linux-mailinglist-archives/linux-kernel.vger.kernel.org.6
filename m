Return-Path: <linux-kernel+bounces-519520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1E5A39DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07CE167A92
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AD126F453;
	Tue, 18 Feb 2025 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8AWdgWl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D17269D19;
	Tue, 18 Feb 2025 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885333; cv=none; b=Dee82EgUTlwQWLzxOMcuNGM5/q5A37GTK5hcIVB59tiYCzqj6snJ2itS917o7QL+MdI6YvZyXaN2VWr0d6t6EftMFD1l7bnldCqCqm5E4Tc508nYveWAFXJdlPP/Z3D9+2Z7j9/wvFcCFaAPJVpyM6FUHYmK2fAKJgGbx4lgp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885333; c=relaxed/simple;
	bh=eG4ncH1UpYgaVh2bHTMXHYfnt6y7lXx/vhY2bJebvmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGlLWJ/D5EJJSlQpzM4Mq3KXPIKl4YgbcKOoDo0jIuxkWDPSYxwDZeCBJreoDGq/1lkfPRvaYOno6l5DIRg76iiOWxA9obSG0OZ7liV6HU+OsyBx+kk5xQjINcoFVHKv1HfmG+iXyfEY7YeiLOg2DDGjDu46Yv1S/rG0IUJnkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8AWdgWl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F4BC4CEE6;
	Tue, 18 Feb 2025 13:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885332;
	bh=eG4ncH1UpYgaVh2bHTMXHYfnt6y7lXx/vhY2bJebvmk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n8AWdgWllC23AxEpooosl8nepwYudG4h/jaEXTBcBOuXt6fDKmSeL3hvCzPD9F/s+
	 LNxoYmbgG6BMJAIhXA8bHI4tFaz6pkYeCocHAV1GUe8Hgs4PUZgux+rVWIZ2ffVVXk
	 rEylj9vo1P0mDMtLv5zjRBkyzRLlorbCFsrHWwOzIX825CKLq5Lybu+jckvky9OAEX
	 YDlj/LxRpdmeiP1eNiZxLq8gK+cdmIbaeSBW2i6gqtoqx/IblzlI+FTiyWEpmnnV/6
	 O+iTGaR7SXRIC7FHdjfrJf7r9qvq9LTKiHE4dPj7WaEqQSkNrN7337Tftv89hZ8AWX
	 N+Hj6rnEPqPGA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:12 +0100
Subject: [PATCH v8 07/14] rust: hrtimer: add
 `hrtimer::ScopedHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-7-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=eG4ncH1UpYgaVh2bHTMXHYfnt6y7lXx/vhY2bJebvmk=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq1p6ks8VywJik0hkPMD6Zjviq3fHfnEQsuG
 3qg5YdiekyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKtQAKCRDhuBo+eShj
 d9V3EAC2FtW1buWNFpDSd6arpX4//wpy/ItGaUM0JT6r5yJ3JTz3F3KO7s0jRTny/bM61WNlLGS
 xn32/hNxfRQ+vFQn4UIji+8+p+ljGOio9u4IKktdY+6BB9GxAgJwMii5G3PCnrQkx+t3c+MFUip
 2IgwnNytRJasVeZV3LlLiJHktaVFIx7sVybAPj9GdiRtt+wZ+5z9IKlc7q3040Gvvm0ZPZEySJN
 mptiNGci8KHkG2c1CKR+v0m0diECzaSVwKZKVS0s0yioqyKJMDYPpz1AwXb5c8Eq6jll3NA3Cvi
 HqNoqkYhBdWNWUye/b53A0Gbz2Y7XP0SOTcriy09yCqimRFujymS86pGqXmnqVga0dtmuKCKvZU
 xri+qOBxyi1mJNoXawpDMSBzyQVRFJphcPhnDTUgG7gyP7cL+l5xJPpYHGlsBdnlDPMnYJN9dMe
 IMbS9d35vSJc/wYz41aAinzUg2f7GBUG0X4JCCBS536El91ay9fwrFp6E++xKhQScREj1VPUYCM
 Nk4Rt2cG/rJgO+iuQi8npNAT7pGjtCSSzkjmJ1V9Tj5UybbcAzW2Ix6SMiXxKvGItxIFs56xJ4h
 stCS07wBzMCguKc3dB7vtEKhv2DdmZA7BmOAAPDMNgmZ20ZZsX9LepSmF5BIlRPC+ikfcDyLhCG
 4OHIfGyOIlj4ufA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the trait `ScopedHrTimerPointer` to allow safe use of stack allocated
timers. Safety is achieved by pinning the stack in place while timers are
running.

Implement the trait for all types that implement `UnsafeHrTimerPointer`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 196794089f033..666bcd6e46a11 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -188,6 +188,39 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
     unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// A trait for stack allocated timers.
+///
+/// # Safety
+///
+/// Implementers must ensure that `start_scoped` does not return until the
+/// timer is dead and the timer handler is not running.
+pub unsafe trait ScopedHrTimerPointer {
+    /// Start the timer to run after `expires` time units and immediately
+    /// after call `f`. When `f` returns, the timer is cancelled.
+    fn start_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    where
+        F: FnOnce() -> T;
+}
+
+// SAFETY: By the safety requirement of [`UnsafeHrTimerPointer`], dropping the
+// handle returned by [`UnsafeHrTimerPointer::start`] ensures that the timer is
+// killed.
+unsafe impl<T> ScopedHrTimerPointer for T
+where
+    T: UnsafeHrTimerPointer,
+{
+    fn start_scoped<U, F>(self, expires: Ktime, f: F) -> U
+    where
+        F: FnOnce() -> U,
+    {
+        // SAFETY: We drop the timer handle below before returning.
+        let handle = unsafe { UnsafeHrTimerPointer::start(self, expires) };
+        let t = f();
+        drop(handle);
+        t
+    }
+}
+
 /// Implemented by [`HrTimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `HrTimerPointer` to make it easier to specify trait bounds.

-- 
2.47.0



