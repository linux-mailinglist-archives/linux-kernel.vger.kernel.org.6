Return-Path: <linux-kernel+bounces-553190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461B1A58558
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBCF16351D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAD1E5205;
	Sun,  9 Mar 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvMiLCwa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2531DF268;
	Sun,  9 Mar 2025 15:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533774; cv=none; b=VnW5aw5k0WwvD/yJo68uw3TaVpI3d63Q5Mfe2E5YpMlnVmk2je/sx7wNhff5EWG6nIQVLfLxQAKBjq8p3cYOwW1Lu77F3rg8M+u578cQSKzIrsFUHjso0Aqb1dAbllinIp/V7NhmvzHg9D/F8c4gpQg+CymAtFmCIHhDDGMscWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533774; c=relaxed/simple;
	bh=DwVZIip6YffDFOKj/P5+b+mVe4Ium7/J5/6ey3jh4Lg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJRnkLMi2/5FNYitnGUlcIfY4XwSbyTY38+vG1KUjomdotif0+IjCkPhwtjNklO96NgLX2aXv7yEZ1+jUk9yegguOT6r3tg5TyKzXld7/6rqL4UlaAfbm9a9i0Gjc6BW+bgWfIIUvnboMv9oE8JykY9wH6n42NG8APk1GXw63kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvMiLCwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8E5C4CEF0;
	Sun,  9 Mar 2025 15:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533774;
	bh=DwVZIip6YffDFOKj/P5+b+mVe4Ium7/J5/6ey3jh4Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WvMiLCwaN9iRE2PJLvEIURPdJbfcx9XuM4dv0gnRkbD5LHbEDX8hFIyTXBX1kRxN9
	 qDkA8RltR1l14LFPTA3M5MAtvrGPTO+cg9fFcva9C+sYdsQi5+pEbLyUjlBYMiNxl5
	 H6xgKhOXKzn7XxYypF0LmO51cUxNOlm6N7Y4p1tcLMljXrqQOgjmgZFViicspBv605
	 +ifwAHwwCwKu5MoRIvJBAcGpwjE+97CSd6IS/G9XocV8g7kKxsh18Hp/X++Q5V8g61
	 LdWTRtVcFATkQvrMWmugwrLcQEKtqGoqhs0WitPuuyvitm2fZE33AxT8sJBUwATzyr
	 +VU+YYrTkipnw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:18:56 +0100
Subject: [PATCH v12 05/13] rust: hrtimer: add `UnsafeHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-5-73586e2bd5f1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=DwVZIip6YffDFOKj/P5+b+mVe4Ium7/J5/6ey3jh4Lg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFrduYuZDMu3VkzOXc0pl/c6PQOsXoR93SMy
 ASfP2X8qhWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xawAKCRDhuBo+eShj
 d3A9D/44BsscnA2s+Mkhz2BcQ1kjqzljdUTnre8L99O2WD4G9kv9h1EFODep106880asrsZPfjO
 4H5p3wDlZMZqswhPf/pyGWUHjeQwgZvvbWmV1yRpWt6jAJ5I8QmD8cirDwOXI5h8wcxZBgeuim8
 wKyZlTq4/+BHV+MFYgZjBJEaGwL6Lz1WCuBX7WvGCIyBxnfbLtJTASf7gJFQhv4FMFWyaHCHaXr
 LhOP43c+xgifqOzWXghxVmwXllvShqp9QNGys0lK15tPfrJs80CxPgmHIeyFwok+BSJssoCy5ez
 /oNmRNTuw9ToepZtjBNjv3f/IC8keImdqPaS4smeFZUxAsteCKXPHSM+B7T4YfI4uEBxvl5MvYg
 6TOalYVZveTnwm5ZX1jBrUVXdSPDhMTAhprBewAyNpyVxN/Iezf5dAEGtYbiQzfSLl1pNlnxz0F
 ielqe+NjPgys5gdpGtMGOy+eowT/jlKP+jk8aCiz9zOAXprtvom2O2Ac78gbSBCEfsLvBOUTjqD
 DWtIb6r3ES1d8jliF/PXx+klLZdNmF0xEApUaTkM+zwWBg85vpkKYewb+G2D+klYIFZ+ucQ5PbZ
 bTMasPsFC2w7kBE0erqSw+t/Va0TUC7/4+NZ23Y/bVFu8UnAnM++VhImv8e66Z/9qgOwXgOPdwU
 1ggUruqA+UbOHCg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a trait to allow unsafely queuing stack allocated timers.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 78afb093aee8..0a9ca18df665 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -188,6 +188,37 @@ pub trait HrTimerPointer: Sync + Sized {
     fn start(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// Unsafe version of [`HrTimerPointer`] for situations where leaking the
+/// [`HrTimerHandle`] returned by `start` would be unsound. This is the case for
+/// stack allocated timers.
+///
+/// Typical implementers are pinned references such as [`Pin<&T>`].
+///
+/// # Safety
+///
+/// Implementers of this trait must ensure that instances of types implementing
+/// [`UnsafeHrTimerPointer`] outlives any associated [`HrTimerPointer::TimerHandle`]
+/// instances.
+pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
+    /// A handle representing a running timer.
+    ///
+    /// # Safety
+    ///
+    /// If the timer is running, or if the timer callback is executing when the
+    /// handle is dropped, the drop method of [`Self::TimerHandle`] must not return
+    /// until the timer is stopped and the callback has completed.
+    type TimerHandle: HrTimerHandle;
+
+    /// Start the timer after `expires` time units. If the timer was already
+    /// running, it is restarted at the new expiry time.
+    ///
+    /// # Safety
+    ///
+    /// Caller promises keep the timer structure alive until the timer is dead.
+    /// Caller can ensure this by not leaking the returned [`Self::TimerHandle`].
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;
+}
+
 /// Implemented by [`HrTimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `HrTimerPointer` to make it easier to specify trait bounds.

-- 
2.47.0



