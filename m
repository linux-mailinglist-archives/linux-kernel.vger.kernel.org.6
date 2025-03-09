Return-Path: <linux-kernel+bounces-553185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0109A58553
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1D416A7A3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FD1DE883;
	Sun,  9 Mar 2025 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uhmo34Eg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9074F46426;
	Sun,  9 Mar 2025 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533733; cv=none; b=HO+btwDxb3PZFnAvKWvMgGnRz10ZYGLwXC8qwAdGiqWWKVzWY3DOy7mp5VL9M5FixqeE9uQkEr7DsDHEPMh6JLwUOCsJCC91G4HY8kwDOqndtndeh+PLsMWMgeeBBo0aJpf6VXsd/2da3BsDGnZHfyfGwcgcq5GD/SlDHp6zRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533733; c=relaxed/simple;
	bh=rhf4QgkZueY9HFyMVTo8jhUZj4hOFxWhVw+dFxDVS9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QuVPIvLaKG75defX+ua5udTAKN+t1dRQ8l5B4Rp02VmGSmAqGoBpUb4vE0NSRYDWyYgCTBypFSqycylpnjqpNXqZEW9RP4Fou1VHD+c39iC48AjFg+7brqsyu3wYzc8mx4Lh/VHgL6R8MOq4Q7bESO7jkFXEdzpUPDMF4HZjBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uhmo34Eg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8AAC4CEEF;
	Sun,  9 Mar 2025 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533733;
	bh=rhf4QgkZueY9HFyMVTo8jhUZj4hOFxWhVw+dFxDVS9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Uhmo34EgLRzFS/Y6lolYe3EneZYp7Kf83xdZQgZA/t7QrEvEitTXCOdOMulpMsA+O
	 bjB4cSJZ6q3Kw97T+uadRscH+16PAW858jq3vySlSpFDVrEO04ZTv9zqGoa64doQEb
	 85vYScvN/zBMlGfI6lDrLQYN9Qwd2j2ZiuwIwSgfG2worJoTELyinCGWrzEtVLg53j
	 RuJ51bQzplU9u7vXoz/3Yxy2v3HM4P36EW8+8oMGR/EMwn7s/Y1ASNN4U0MNOVPCcd
	 OkvJGYFjHJS9dt3fNmswp4NpI2U+setULihPefyodn4nTj/dKEHbYYFxOP8zte1x6a
	 WhQYZb2n3M4sA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:18:55 +0100
Subject: [PATCH v12 04/13] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-4-73586e2bd5f1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=rhf4QgkZueY9HFyMVTo8jhUZj4hOFxWhVw+dFxDVS9k=;
 b=kA0DAAgB4bgaPnkoY3cByyZiAGfNsWqhMY17PgPAHsAra7TmTnaME+neyL5IqqbgA2/7t3O0r
 okCMwQAAQgAHRYhBBLB+UdWv3wqFdbAEuG4Gj55KGN3BQJnzbFqAAoJEOG4Gj55KGN3ix4P/2+J
 0E18AJ2hkNjD+Yd/K/hMKPA8n8K+SIqRmyxDcXLEnb9uPLpUrX8+nGsCPedlRT5Xvq3mSNul4Oj
 4TS9yMH44dMx4+0sfxpiMrPB+lu001ULUodmrsAmwpdWIRzggIIecpsmVErdog1Aq0YRgitiK+T
 jMQqFeYJ5URRq0d6+H2t67QxHigxzOsFLqHyHx/2P5TlMWsjrE9FNl4EE8TNgkuv8tzgqscX4zM
 D7RiY7IxCCpKLUrtKg5Cyln8OEsJbsO4eG3PK5XSU3C/DR0RMJFveKM+q69Dxg0BT9IAGmRSeVe
 jsW6FLcI6RZWO6QLY8GaadwSkCpGKG1M2GSIbpIt2RJhn/licoLarHdDGFjKWazjZlCXl9OLAx5
 yQ08cTF4+dXwBDtpyfNzlf7LXatErV2kUg/AS6K6nwYVGIvepKcOE6cyD20T4lI/KA3tCAvf8lX
 AeudGVMdmJ1s3Qe/FnUl6nD/DlilE9x9JZ99bx/MapqiChoeUjUJSgsVkutpMp6KZ7V+Zt1cJ0T
 NaMzQ6Y1jPrk+wKXK7WjH6a4ZrMi0eVrNX5g/fNqXj0j0Qg8rqeRNx/WNacCBUltbmaBeWCJjiW
 sKnP7hy/V/J7S9PFZsN8ssFHV92gI4aLhhPJgEFvjw91ze8kDld7xXutW67tINR0FQzPyRiE/ZN
 /kb/8
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow timer handlers to report that they want a timer to be restarted after
the timer handler has finished executing.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     | 18 +++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs |  4 +---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index c6d6eaed31aa..78afb093aee8 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -212,7 +212,7 @@ pub trait HrTimerCallback {
     type Pointer<'a>: RawHrTimerCallback;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>)
+    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>) -> HrTimerRestart
     where
         Self: Sized;
 }
@@ -312,6 +312,22 @@ unsafe fn start(this: *const Self, expires: Ktime) {
     }
 }
 
+/// Restart policy for timers.
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+#[repr(u32)]
+pub enum HrTimerRestart {
+    /// Timer should not be restarted.
+    NoRestart = bindings::hrtimer_restart_HRTIMER_NORESTART,
+    /// Timer should be restarted.
+    Restart = bindings::hrtimer_restart_HRTIMER_RESTART,
+}
+
+impl HrTimerRestart {
+    fn into_c(self) -> bindings::hrtimer_restart {
+        self as bindings::hrtimer_restart
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index df97fade0aa1..4a984d85b4a1 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -95,8 +95,6 @@ impl<T> RawHrTimerCallback for Arc<T>
         //    allocation from other `Arc` clones.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        T::run(receiver);
-
-        bindings::hrtimer_restart_HRTIMER_NORESTART
+        T::run(receiver).into_c()
     }
 }

-- 
2.47.0



