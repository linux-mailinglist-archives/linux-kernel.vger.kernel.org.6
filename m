Return-Path: <linux-kernel+bounces-553184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A7CA58552
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB873AA8E4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E81DE8B9;
	Sun,  9 Mar 2025 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsHnY3lw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFB46426;
	Sun,  9 Mar 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533725; cv=none; b=tLLXXdqAJaHzRj4PBimvuKjhM6DD4eDv+NuoEX8uRSmj8F8P9GRrNWmddjEUKsggcqgpYFS5kXt4AoullI6lHHyGgeQuAsmHtAO5c/Y63jpw5lM9ikCkBnl2EgFcZppJciexduvzFCT64w7/2v7lsabSzI8jG7mL078hIe3StTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533725; c=relaxed/simple;
	bh=Ky9iD1F674vvwmdNmX1iOwy1bdlneXIh0b9IeMManG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U2Zrs69IP8qT+4RTQ5wcpX9bY5iFvz2H9kp4udAYtmgiHh0tOlg6K8QDKgdihncTrMuy6dW5cOWHkvplYtZRIYERkTKmurZn9JWY7GoqKEQ+Wx8ucC9N3kXd0y5eNLdwa8i+jTNJ8OnwjkODfHB+bqQaLZS6qPUi6RbTZGDEwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsHnY3lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454A0C4CEE5;
	Sun,  9 Mar 2025 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533724;
	bh=Ky9iD1F674vvwmdNmX1iOwy1bdlneXIh0b9IeMManG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rsHnY3lw7fSzz9P4LG73Au2fTiZc3Cql5uie1eKH8I2EuurKLubFgvh55+LlBz7BN
	 NWpFg3RHMZiX02eeh1QDUrTzcpn7mT9k98mZXwSC9+wUWd+yrq4mOLK4MD0oxRVUIk
	 RSRcxgTzE1H3qd+XSW/vko6rIrvGXGNmaJUbF4+q8Kc0Lkk3Jd4z8L2Sm8mbIGySp/
	 znh4qhLnJfXPa1EZfLsw/LF7lfU0QL7xw6CVJoN8Xcoabq3Z9Dcio15DZGQxHgw3bK
	 vZgs+xJA0rwSPqLNYbjhKytuMN0z+8l85OkOkHyEqtmhI/8JgoxwGhoQaUWfTBfl93
	 gEjie2XGJMqww==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:18:57 +0100
Subject: [PATCH v12 06/13] rust: hrtimer: add
 `hrtimer::ScopedHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-6-73586e2bd5f1@kernel.org>
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
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
 h=from:subject:message-id; bh=Ky9iD1F674vvwmdNmX1iOwy1bdlneXIh0b9IeMManG4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFsX5ukJ8Jdm2B5D7ifYODzlQf7PI7W5bbhI
 3p+koP4ElGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xbAAKCRDhuBo+eShj
 d1AGEAC9jBl6aWS8sob+yPtYSFcUVFlFlzLaZbonK9O7AXrfFoqrJXZ1Wf2fowhYrVpH6GcE+WQ
 ZrNiixRd1a84JsgBKMS6ljQbLnAwSrclGv2imlYgYEYpqtzLQ1c6T3XqRVO+a0qhsqn6Ik204Qe
 4KP0GglEQK/n/KBmiPw6TWwWxO5wQAmuEha1LY0rSFcQO6Vyv22w2oA69TV0KB4T/ddjeKYXqab
 mRT66/9/9GF2TJGbQPyYwm+IeVNBut5HDN+kJxsQtwfYtqvjiECjIgzM1TdEyYTs+AIrF999k7k
 PlI2HHe3bRmWxWwQOk6cvzlwXAZ2dpJS0F3rxCWS+GkzZjWFBF03Xi6KQdGIoAA0RDb2AT+0cxl
 kjAiZvzgJsdifz3H1wPSdRz+y34p2VFJ2cKZb+bELaLmuAKknEnaTuAXHd2NWnbtxB6YE8U5rdt
 eNykYtTCfcXdEU6CTL7XomsVHF/xKZj43/TGo5dCRNSyuWHLZOTFo6vkPVNnVp8wRtqDVOYEHPC
 46nJ3rlwD1NkWEe3I4qhQ9bKw6D2AWyBzzfiBGbjVxJGKFtOxRsUqmxVLCUu6xrNnHuvQLL+Vmg
 rFISarivNNVPnq7561DZ0Bj0uga+aTJzanI1IhRVl9DId/trqfpeAt07Yv9UhepxKi7Tfxm5LvU
 wBVjmBNJ6752DzA==
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
index 0a9ca18df665..f9b2323a305a 100644
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



