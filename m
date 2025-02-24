Return-Path: <linux-kernel+bounces-528971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DCBA41E89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1FA3A62F9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0158E221F2D;
	Mon, 24 Feb 2025 12:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nz86b+8F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D552192E9;
	Mon, 24 Feb 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398757; cv=none; b=TOk9ZD+LlrtabfMcx6fpZTI9y2R4E0lvrtVPuGqzXduGSIZwyesI4RcYnZbPzYfCjWaEiooyQjO2lfcfFOA7pykivEUUpfEyUOmEOL08yMPYInxVXGHV1t5jYMDybUwkCUDtMeo3Ml04wWtlxMYTQVuZbtnDNiWxrbT+sKVcM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398757; c=relaxed/simple;
	bh=axnRrBYF0OzH4Xe3HtChGMprmiCY28WJpn50yBixF8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQTSeMC3fVGBVbz5/TGwEGqTgWyxCrfsO7dwGK5NZ+ge74ceOqq5VMY0KMA+VpkRS9OHxyxSWMfCCCx4wMjH3fKYRBT/wZL8iwUkk4UgTJ7LW2EljfJtXq4jh1FokmN+cpgcrYAfncav+xWf6qopBMscMHSb0OjiU3d/2yll3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nz86b+8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88A20C4CEE8;
	Mon, 24 Feb 2025 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398757;
	bh=axnRrBYF0OzH4Xe3HtChGMprmiCY28WJpn50yBixF8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nz86b+8FudUOzgHQsh6b7LKg+gIllBoqeLzYyzNZhhIKsOuXh3NkQ7MFzxfHLL2mL
	 In4yog2RNOy/KTVX2gaBxfWIJ7UDrQYxAWY32jFBKmRhJMPJU+9M6p6hNI7fPBdsXb
	 JAGTiEvGu3xae0Iy9imHxA9NX5JRQhC25l5C6Qjg1j0HMBtGyizSjOh8Q6GOFpMdGd
	 e5faG7K/8pdD6JJPimWhqLkI42ftiJHw12dJd9ppgiNiG21kkcNytfn9TgN8MH6cdK
	 qAaUGmA1z6i8v7DOeXf05M05K9ykovmNkQeQhVGdt2OPLr3oOQbQX7iC0K6qGU93UC
	 4ECzmiTAwrfaw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:40 +0100
Subject: [PATCH v9 06/13] rust: hrtimer: add
 `hrtimer::ScopedHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-6-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2142; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=axnRrBYF0OzH4Xe3HtChGMprmiCY28WJpn50yBixF8Q=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAh4GeSYqfarAY5Is4mpXvIwk8iIYJmmCL7y
 wmEZfFvEamJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgIQAKCRDhuBo+eShj
 d6ntEACyVIPeMBea1LuWbKmj470DtBYDPZn3+rL1M/QrQPAWm/o5G7v3EJabAgDR2Td5jtj1OT2
 lLvwY7qYUQ9Mozel0uwUCnMNHWusAIa0INL2Lu57jGeXZkNftfiXQSr7mDK/0WeW3WnmwfObHaK
 LWcfBId057SuOEQfR1qpBdOJa2+qXiEFa0RthidzX5E/CRlLMJx34KSS0MJSrvHa27E2eOFba44
 HU0hY/s2XLUCH6bc7NRKMQHaIFU+xb7ltc62PTuqV656K4H050LXxzJUTI09dwL3oKoKFO5J1I2
 Iem0D1uqXkPUQfut6bmReAO2RZ1421HDjKBXbaorsOQiJBEaFRmpC9zu5jXI/KfQUWoVuT0MvAU
 DvwQRYLdFTbN5POZUnLEe3ys8UkSkNkb9ov497G0rG0Od42AfXWko84rScomF0V4aP1THWENl4H
 dmDjSlscyD8Rvf2U2AtozmfeYBu6V+yb+5lhPzpXCr1BVqG5hkPh6yHEYD6/IrpP33QUWV+yVJ6
 kns6R9ibcHzkXglAdla3m5Es3vagIvnn1j1XxEp45z05AdbOCMGF9bOVecfh+lGVr7oA00+JBDQ
 qo+ZLGmREdbRW0wPCpw2zBuoSNrs5depsCxurJiuKaRCSARq+8h2Fq9lKMmo56H7IG/qq9R27/v
 2VdMn5BkFl300zA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the trait `ScopedHrTimerPointer` to allow safe use of stack allocated
timers. Safety is achieved by pinning the stack in place while timers are
running.

Implement the trait for all types that implement `UnsafeHrTimerPointer`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 2cb40b011673..64b769ad59cc 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -212,6 +212,39 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
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



