Return-Path: <linux-kernel+bounces-449459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C74979F4F59
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B7A217023C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADC51F9A81;
	Tue, 17 Dec 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGumXfkY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D681F76D7;
	Tue, 17 Dec 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448835; cv=none; b=DgxJSpXaA3LfweidSEoR/IMALn0PUEIYCjlGD0yMsvoXKRIVCPKmzV0LFDqNMsUIKABKiDQUB3R+qC3tVFUmXHHWXUqqfPpCwVojxfuXxujiFWsDe3rr0hGBktmDPyU1dKZejQAkqXUwtuSqlSymGFVL5AoX3gc13TZhEkT2R/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448835; c=relaxed/simple;
	bh=PL/P/k1EasTopinIiSOzrV7o07tpGR6uAbv10aSKQj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kSxRD7a4MMOpUWidewDtOrgPZ0TtLuAsN5WwZRwdpfgZs35Fh0o4o03+1oowjYy+BqY4394EVo7lw5UwyEPwYzk00QpxUI40W3Z1bVRDeKNw6MR2DhkVCaxq039dbXKc9+Ce0j6SrQp7tv6eG/ETbp0WD/OSDcq4aWid8CoEt3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGumXfkY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE1DC4CED3;
	Tue, 17 Dec 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448835;
	bh=PL/P/k1EasTopinIiSOzrV7o07tpGR6uAbv10aSKQj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kGumXfkY8q8bM8OvHiqaWo9tImvDkIEUkafzMXjeuj7lz+0x++0fN3m7nMeeBUu09
	 AQvWtD6alUmU+QQ7rg/sf4pFmth4BDjeTmfF9KP+2GNX2Py4vm9fi+V4lGggT5DlDI
	 2Ruyfb+b53hrA5t1iGL7IOFWlNZDtZ2cGDsGwzMLTiFf+El/BSTYcs+lcORSALB8yb
	 7Ci+ogJf71JHcz+JZBdZ2X4VHSygXWke/pnhKlj1xmpA3BRDJ97iOtyE95hZuQgiZN
	 v8KUeuV35j3zqsDp9eo2c24PAJF3uAbL/gjF9TzDFzg74sBxeA0rHcCljFAUrpQrVl
	 bscCCXKOGSKtQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:37 +0100
Subject: [PATCH v5 06/14] rust: hrtimer: add `UnsafeTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-6-b34c20ac2cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PL/P/k1EasTopinIiSOzrV7o07tpGR6uAbv10aSKQj0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYWPNFv0sIzctht0bDA4QzEKBPWNPTfT0x2L
 EU3IXrQGvSJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWFgAKCRDhuBo+eShj
 d+i6D/9mEsn1EYvscjqoGMr6VHU2ehx/wZ8FA3z/CRgm6OJxtBtW9rGCixBDzIckEs2/dcFb0YQ
 7kQAj59tCq974P1LukhS4gLSyx5hOdqS8S8c+uxfAbtHYuwLW7LM+H225WCGxCMRJATf7eqgwEq
 kghtp+hLffmicmGyRB/ux1MVk8a1Zch/eQUtsTuKwloJoUOVnFb/uftz2mEIUmoULDme6+5KxRa
 13okQcMiDQDbpxInU3V/v1Gvo1Hum5I7c1w5dXHCDZL9gbTVV0hB0J/QKVAsZtJaC+6RhQIHfYn
 Noxn6KL7ON0Xk1Y4Lp5hT9ylsLJUBwIf0gWRAVQL7F901qBDlxHV+DTiZTZRxBbxbuAoOukk8kG
 WhwOBjI/G1hWWup1yO5USMxfTgDG0SJ5BClCAnFwIjUYSP7W1fXrEBPvejGBwgv8C5XD1jaBzbs
 jqH+Mxaoto+jBLX867TRGnHkiDpKcIu781Zf1JFlTcYI0Poy7ijYATrCqNIMaq/9IwdwnzBTEND
 w70xYFIaEIli9EBfZZX1V1WcZoAC/ecGvHgsaEgJ4wKpsg+s79LnwxKUDZ/C+/5vf+AMVaYM8Jq
 2I9fomQx2cAVW24uIo0LDmieRiZjM3jY6DBlg0xF7jLqJx3Jw44C3YLS0pVQMGb3vewlZvb7qd+
 BJNuP8duZIhyp2Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a trait to allow unsafely queuing stack allocated timers.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 38a8251ea6ba4d84dadad009ed540c150bea4775..df0f6e720f1644ca31e0b64cd0f05a4a46098ec4 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -142,6 +142,39 @@ pub trait TimerPointer: Sync + Sized {
     fn start(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// Unsafe version of [`TimerPointer`] for situations where leaking the
+/// `TimerHandle` returned by `start` would be unsound. This is the case for
+/// stack allocated timers.
+///
+/// Typical implementers are pinned references such as [`Pin<&T>`].
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
2.47.0



