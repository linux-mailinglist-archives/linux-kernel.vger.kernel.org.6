Return-Path: <linux-kernel+bounces-519510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC19EA39D80
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F511891721
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9385826B2A9;
	Tue, 18 Feb 2025 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oojFB0Up"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561A26B2A8;
	Tue, 18 Feb 2025 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885293; cv=none; b=YBqYvyagKRV5SiKlelVHorjkV6HROiajPzeJmhwPxd96zsxnpRP53ZKaerZkdafTFNpnFP2nPlQD6Ga00bef01Mx8Pks2JdtUOFjkGOIQ05ZhH89Zk0IQ168so8hhfpVIOyPQ/BfukxgS9dA5mEuv/BqN+dtZn5MYqZpdY7IBh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885293; c=relaxed/simple;
	bh=3m8fQyyEUwu/wXRv42ZRgQGKOJiZ2h/DVDw/+PrbPak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTxy25DdGyQ3SCphdhgNBhS1sbSF4fF9QxJ/D54H0VWUGx5SthTcR0EbCgsC6D2K9L43F0ZUERMoeaFmLBKH/V6t6KyhEo6EerdRmdvq0M9ydpKMnfQdOLP7UtVyjTCBVavhHsZwfhRNxs0f4hz7VmGLWSZXTy3UjcPK1AIVXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oojFB0Up; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26E2C4CEE9;
	Tue, 18 Feb 2025 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885292;
	bh=3m8fQyyEUwu/wXRv42ZRgQGKOJiZ2h/DVDw/+PrbPak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oojFB0Up4YkV669kWHdw7XaNbThpcKkyKlJyjcKvq3DJzGWz6w1sI2k25Nd39ovaf
	 NLTm2x7jMNWgBw5gW6lDCyxdvBHIFP/dB95AicR5XCmFiiux8JrJiZR68wmC0oFhtw
	 h4Q+9+09TIJvDSXcNUDtHKMdgtsmI1xZoYb3lnQKYkiokfdwc0wWdwkt1DK+E0deVF
	 mc2apgBOgsIdwRVJG1nAnr2lNDJMC541Z5KiGyGKfoJDOY/nYbN+jJKhxvvR3tQ6Mp
	 ui/cIWfHJB9F+q58M+Qigf/AeohH1Yp9AZOo+54tG6/1qDlqb5hEgXq2QMquktcLaO
	 1w2sn5fTXHq2A==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:10 +0100
Subject: [PATCH v8 05/14] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-5-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2433; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3m8fQyyEUwu/wXRv42ZRgQGKOJiZ2h/DVDw/+PrbPak=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIqz2gUH5s8VTdU5zwWYcKc8wrTt/Am6FW7RL
 b6BHWOfanaJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKswAKCRDhuBo+eShj
 d6lFD/9kF0CQioS0AzCQ9jYv5jIoGEJvPRrKkhsRm1QwQG/uSoszsFnhiCdya1B1XY15vO00wjA
 zuv67CLDNLj4eWPrWwbV4ViQAKrARkvFgSeUNsFP39NXs+44fcVlEjBnYF9XFvZOqDXygdjs0A/
 iEzxqMWJQJXPACbgWIc1tGFtz41UPdw4p+yII6EVM05IobbNEipKyW69dqf0j2fAuSZmCvasL9o
 TLNmASsydn64aOnS5bJV2jCwTgmn4udV064wojl3Yk/x2hQRXpj6ZmZGCuE2DT6gs2SyKH4Sbvm
 W7UMwJvIQJSRa3TKJcWxr+odpUOL5oFkDPCBx8TsCNNrojk/WGTpNV/6U9hXWpjHPOdYD6QaYYH
 2p4wq1H9AkN3r+/ItqxCPbvqwE8/6iMkW9z1A8muWsZmly/kVYV6S25uvnDqZkCaAqd1GnDTAK6
 ukUJCJuPuCNSb8NGlLX0V1HTtRqyke+3GtEvSueyy7XsChep/JwLXTmLEyDdIObYFhPqqQsnU18
 T4Ll6dSvPKQwJt2+K2Rd51bvpYSJGTXRcUmFXjIqrNlpY/1lXD0+Z8F46stRAheZ69v/47Nvjsq
 c2IIx+Zr6Fj1lReB4QQKQyagO6auqmLr+/CdK1lFDnyneRfEeMwNWEr/PDJkM+bPPJbpcuwItZg
 KX8LgXebRjkpd6Q==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch allows timer handlers to report that they want a timer to be
restarted after the timer handler has finished executing.

Also update the `hrtimer` documentation to showcase the new feature.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     | 28 +++++++++++++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs |  4 +---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index b2a3130bc21d7..e342193f985eb 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -183,7 +183,7 @@ pub trait HrTimerCallback {
     type CallbackTargetParameter<'a>;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: Self::CallbackTargetParameter<'_>)
+    fn run(this: Self::CallbackTargetParameter<'_>) -> HrTimerRestart
     where
         Self: Sized;
 }
@@ -278,6 +278,32 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
     }
 }
 
+/// Restart policy for timers.
+pub enum HrTimerRestart {
+    /// Timer should not be restarted.
+    NoRestart,
+    /// Timer should be restarted.
+    Restart,
+}
+
+impl From<bindings::hrtimer_restart> for HrTimerRestart {
+    fn from(value: u32) -> Self {
+        match value {
+            bindings::hrtimer_restart_HRTIMER_NORESTART => Self::NoRestart,
+            _ => Self::Restart,
+        }
+    }
+}
+
+impl From<HrTimerRestart> for bindings::hrtimer_restart {
+    fn from(value: HrTimerRestart) -> Self {
+        match value {
+            HrTimerRestart::NoRestart => bindings::hrtimer_restart_HRTIMER_NORESTART,
+            HrTimerRestart::Restart => bindings::hrtimer_restart_HRTIMER_RESTART,
+        }
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index d1c90631d0036..109eded0e73be 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -82,8 +82,6 @@ impl<T> RawHrTimerCallback for Arc<T>
         // timer. This `T` is contained in an `Arc`.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        T::run(receiver);
-
-        bindings::hrtimer_restart_HRTIMER_NORESTART
+        T::run(receiver).into()
     }
 }

-- 
2.47.0



