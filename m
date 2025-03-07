Return-Path: <linux-kernel+bounces-551995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C700A573DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C9C172314
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221C25A345;
	Fri,  7 Mar 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqYd8Bst"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2A258CD5;
	Fri,  7 Mar 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383663; cv=none; b=HLPULVHSSyj/hyJcwMq266wZ+st8KGlKIs2SoeY0v0kzK1R1QBHTgSBdmGeku68P4k6qTHHuF5P1qZXclqR0IPfZuTjsyykwkpatKCSz0HRKdfYkvXqS11iBYXinkz+QXIAw/gNHSuK2kfJ0FEk+ApE/+i5Gziwukp24PTmkHmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383663; c=relaxed/simple;
	bh=+68seFzrEi0GzijSyUe+gmFbssuxM4rVKQnDZNFI5WU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BCW2LxBwhddvQ8T02xvtsN6sBmBMcwStjKgSJsBMK/s/oQzr7c1L35gZM/HgH2B/AZYPrS0GUN38rFJk3WCocdoboRFEO0G9DDH2fKiIiBpV0rONPf1itUGD0b59ZcU9S2jnwpfC3GwXWbYpotGIZho0I/8xNZ4061hY5t+HYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqYd8Bst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6A1C4CED1;
	Fri,  7 Mar 2025 21:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383663;
	bh=+68seFzrEi0GzijSyUe+gmFbssuxM4rVKQnDZNFI5WU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uqYd8Bst81Tr3zUDU3ssjKMw9tOa57gckjBdWHuwyYlgsLkeoHgM+LVKiFk9ue7EB
	 oAgIxxVS8dazp9qxDEju0U5BX0ach3qpxrCuzhQR8T7/T6ngt0IJaDcbBW/3YCx2Az
	 55fZUX6AAJf68liyI1HwDIfEvi2mgHtOzOMvlV35mQ+yriXmF8j0zxODssbHD8zCu/
	 sXeFhYuBlbTQ/1d/4L//1bH6UpZxwMUN4PL9x4rhMdJdswqUSKitLxoY1SvZdmgoYN
	 blVaGEsrmR08mVHkM2dICaCsd4MwDeVd+obBygL4ccRshPKlqS7WjBE8xVjR6MGSRM
	 mvRMpnLzpiZ+A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:47 +0100
Subject: [PATCH v11 06/13] rust: hrtimer: add
 `hrtimer::ScopedHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-6-7934aefd6993@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
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
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=+68seFzrEi0GzijSyUe+gmFbssuxM4rVKQnDZNFI5WU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2du37D/hncQ/oolfD4OeASse0x3kbA751ihO
 uFXctFjSE+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tnbgAKCRDhuBo+eShj
 d9aXD/9wLBn5mY33LIM2RUFBwJfmEPY67Xy+cXvB21ooUyxcg7E0vanDM67a2sUWAFibTUJSzJW
 dOYIinIz924CN5rEOdWogOsGjVZoU9DH2i62LfeD8jzLEmsNp2ZsdCw8rLwUMzgfkP0u1/F1xaS
 pblT765+J9iUbBGT5c4ByleyfBDDpv9ldHspLByXdcjm2Y/kIvZMIFcqMHWh/qvV4JsBvomaUDu
 eBW2Lez2G2DI98aW8fOI5rZEJIqiGVfK9RPi9R9S3yuFCTL2121VgpANXcdJUMdTxpRKnVUQyF+
 ogEsHMu7kDhaZO4Ki0n2g7QA9cbEgVqVMsWoMmkuywm9UcdUzyX8NtRaI/CHI/YIr9H11mrlEo1
 g2+c4mzDwv3DlNaDOp12Gl399VrVViT136HJnOv7eny3kjD/fZr8oUKssDAiFjGRaoAH/IMqLNv
 zy2SjWOo/rRLn6GdK1cTo+IVHvDKlBMTsuYUq8VKeUndKk5ptIIvUXk4LcAddaVSC/94JWJ7UCx
 b0/bqv9EtByzg3DRfI1Cl3Ws8+X0joXwcEv3PYgdEvgnGACDuojgSQiRYj1oM2XDM0AIJs5aazM
 a/1d1nFURovNt1cYvyqx4AYcJXrZWolXXnrpxAdBM4oxWNrmHIQdYrFUi/LRCP/Qn2GWhFXORNn
 mZH6Nlus07jAdwQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the trait `ScopedHrTimerPointer` to allow safe use of stack allocated
timers. Safety is achieved by pinning the stack in place while timers are
running.

Implement the trait for all types that implement `UnsafeHrTimerPointer`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 07709c795022..8eae2d10b6a5 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -219,6 +219,39 @@ pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
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



