Return-Path: <linux-kernel+bounces-550841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3DA564F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FECC3B52CD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F8220FA9A;
	Fri,  7 Mar 2025 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyA42FSR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7F2063FD;
	Fri,  7 Mar 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342666; cv=none; b=SJSm7+xwUxwrvpyhwH31LTxR/42ZkAiASYYk2UMSIKKzFSB9rxLNvI9JC7Jw/5hsXFAOzTmfSKuREShYskgS4rUrQfW8VFOjeNnC3cA2MakB7qA7q0ge6IiNXSovTKASOKPnrXtwA3ZvaK2y7z2XfMlCSSTS9Fe+fcvuAJpA0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342666; c=relaxed/simple;
	bh=+XLhd3eVhYxNUamLC4E+qKnoFKEUwstiNGcLZtnX3A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mnbX63kBdkVD06B36USqT1R4MadZ/aoU3wjmqPM3YZEY/w+igiaUXYtFa2G8vfQQqblyvL9yddeYT/NnBjluUld992PUgOKRNEF9IQXifZZ78Z1zC1y25EkfV6X7v5JYHiRXZb2U04JKN23Rlo3/wsJ1YJEZ1J77b8Wpr1/9FDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyA42FSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E0AC4CEE5;
	Fri,  7 Mar 2025 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342665;
	bh=+XLhd3eVhYxNUamLC4E+qKnoFKEUwstiNGcLZtnX3A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hyA42FSRoNAr0jgqehIkiKsqBVvdMfS598OklYwxAKDphxsYP9m/QZKRGBDzgOb4o
	 VxvSAf/OZDKZ3mcvzJoX0jJztWZn8psR7CBUA5+1guQOeJXbmI7ds4soia2Jeli8+4
	 GmIQnjsgor00KYm0psuUM0C5DnPXuC6Vy1z4ntA8/7P9hevM4YfJvl1y9DDOjnET9x
	 sB9A23pQ2b9rq6c502cwRAauj+pDkYEc3MyCeluIinThVFwYtaTGqyKVweZ19tReHn
	 gnLdo9qKH0VHZNdKD5sYNLrEyBPc+immrp5DMFdAjB1fnfaEJ/cW+SQ4lxoT8B8Cml
	 hmYf0WLxnY3Gw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:51 +0100
Subject: [PATCH v10 06/13] rust: hrtimer: add
 `hrtimer::ScopedHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-6-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
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
 h=from:subject:message-id; bh=+XLhd3eVhYxNUamLC4E+qKnoFKEUwstiNGcLZtnX3A0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ7l9DdSW7f4qLNIAng77jFKH3N0WQj5+Upq
 ksg2pOxK/OJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGewAKCRDhuBo+eShj
 d5MeEACwkPEDXyS9fmB+2Vsj355IPW82CNv/nyc+0mRLa/4oN3AVqJTQuazKhcRuePFXqA962+X
 lGL0pXaqvlNCKwtx5Lf9W6iW0ulKJOrMNCy1NitSpoGJ7JBQimvLW/GufnyyjzFEkhWEljIXttY
 BjCZz+vQR4efMpIDdp/PoZNYgOwRrCRDh4VDaz+uF6NThGHkEPxOoD3uezHhFB3nDTGOuce4Vz6
 yqaGskpuTAkFuiAH/qYc7C3OOGwFhsLBSnzx+vZ6CjnmowpgO4hdXe62wmMdEj4wtB/ALZBtvAt
 mOmY/Sh6o9EL8s046SWS7ilrh85TTyxca0BnXt5UzfSa9ET5IspQTULinZglbyX9d29xs5Qz7I7
 i9p6QH5lSBuJ+twoMryOQYGP0SYkATisffqnRcdBhR7gBWi1ABotN0YwyHzL0ycA1/vtu3Iygy4
 mIrk4Z+hOHhfPGqSX9hgNLqGt/stDtdhm0xNfPM3TzSUR9la1B67iQxiRMqStlaYAGEmqSwcCeu
 Q2SDEqj3O+g7P2ptkwddx7LdGqVDje+DM6+UUGJ2UYyKS+cvNWLW2Hqy+a1M6crmsVqZg+JccOL
 E/UEY243FgBi3WAZJ+HYXCxxpefEguxdHCVEr7BHLc+KkD2ET/zOPwZAXyUYxw5eVneB725Y4Z0
 2gj4KCfmpns7cVg==
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
index 1fe25c271e0d..d90a25785f87 100644
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



