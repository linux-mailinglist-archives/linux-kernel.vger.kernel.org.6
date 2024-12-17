Return-Path: <linux-kernel+bounces-449454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64039F4F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EB116DDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271DC1F8AF0;
	Tue, 17 Dec 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSIdhtta"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D001F7578;
	Tue, 17 Dec 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448807; cv=none; b=ezlKlutpzCF2lOgmKCrnFLiW/C6R/WpKrq1C8tbMPpRdhnEcbdej7T3Vi+SwHl49KBKcYa5McLHQkPGqZa88VjhyMmPvS2Da3E5Lby1Ui7IHXzmG94NkC4IjYdRTRaJ1HN9Yfxw6CZHCKG4DEczLQuMgHQbSlAqT8cD6Uaf/RxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448807; c=relaxed/simple;
	bh=a+16RE4oWB4CXjb0tnUwQPdz5BFsFTklO8F1PqwecHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8TVWEmmUNkLmpKcPmjui5RCCHVTEk7kitkh1WnWBA828WcpunJ0jgvKvq9xJM9slmoEQYKK8enaFHJ6gfpS4jTo36ebBVI7iEMm4cCUqOAremaZJYBeacm5r4NcRTzUibov++fmcuVoarqo8PKWOjTVeaWXgD/omiiCTRJH+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSIdhtta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC11C4CED3;
	Tue, 17 Dec 2024 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448806;
	bh=a+16RE4oWB4CXjb0tnUwQPdz5BFsFTklO8F1PqwecHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jSIdhttaeu+p8d5nta4JpW/RDOWU94uFygnp7t4qZoH49gX8zoNI/CQZ+zHvA9/Zm
	 LQTBXx55LldPTR7PgKb7S9S4fypy445Ztbq1ocDSIEaf8yP+O/auheJJNg3TLKHpDY
	 rc/0ouapwoK8SG/fQ8eJOq/3cSQMhPhvE/U8dbyeo9ImFG4F1j2/J7AdNfIaubkZfV
	 0bfUnru6xtC+QzoRCSixO1/rjyPS/1iw51KZcrre6MDn5Vl7Cwef5oxPUgN92QD20j
	 ZGNnbPUKCCzkEgiQDXGBy+c86B7CV5d+aHNrquOjyM8njt1OLkG8aiWzrPJuBLRWnt
	 2NI+33uO3zN1g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:36 +0100
Subject: [PATCH v5 05/14] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-5-b34c20ac2cb7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2659; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=a+16RE4oWB4CXjb0tnUwQPdz5BFsFTklO8F1PqwecHM=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYV2tRbCy289iAqUS0zjW5qVNIU0UUI3XqLJ
 TwMTBaMuQ6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWFQAKCRDhuBo+eShj
 d9wcEADCj6RftvFeqkqKmeiKYqIswROCsIXwS58U1U82frlcEmaYa+bR9pNQfP+ro8/XjV2ba7D
 Vsb6eNtPtxS5o1woQ8eAfYith30rhRkmNLPTUQJGMkO364VaTgn7GGPLo2OKzcnaItfIdYIVZhm
 NMQJ1JLHSXjKFVwZ5tO4ocwAnDUZKPbbjZdCO9MhxN9rHVF+j2awd4pTjDy6r4RSL49qAvgzKGC
 JAFXPu0/prOWKKSr6rNM+/gWPTDFMLktxS/C4XnuheoecP4nTgI1NO5v7W/BPmtbrzFLZEEUT5o
 y56BViEO9EeNgQaVg4jmIi6pK6wohZ69Hy6wK133DnT5aCLlb/EbdmHdihqr7WN+rBVlJ2/Hpa2
 EJibkSBd7tpgnMOOODsSOmjKUBT5YIyXz3VRQ63d9FScUoACTwFm9uBLvQCLJ2Tvn5DHFkTtsuw
 QlWZwlowxvZC6iyI57KrAO/wFDnJfybcPQCZtrV7Xwky69rEvuh/fxOjpaIzQwRsX11j/iBdlh6
 nSKITto/epjAf4WM7GwdwFNtNaU/eTlbrwHU1T37nrzZUX7s+ai2rIJC0TwOSHyc6tYw6i4Mu+6
 cd4PP8PBh7UVGS4q0ajaMqdKfo9J5TMLLA+vb4p/9NbWy3Np964/4HfKEL+VmDoS0w0J9TGyPXZ
 6JbyyvQiIx6QK7A==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch allows timer handlers to report that they want a timer to be
restarted after the timer handler has finished executing.

Also update the `hrtimer` documentation to showcase the new feature.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     | 37 ++++++++++++++++++++++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs |  4 +---
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 178e33c1f656d2f834e45b004486f6e5fe1813dd..38a8251ea6ba4d84dadad009ed540c150bea4775 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -167,7 +167,7 @@ pub trait TimerCallback {
     type CallbackTargetParameter<'a>;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: Self::CallbackTargetParameter<'_>)
+    fn run(this: Self::CallbackTargetParameter<'_>) -> TimerRestart
     where
         Self: Sized;
 }
@@ -262,6 +262,41 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
     }
 }
 
+/// Restart policy for timers.
+pub enum TimerRestart {
+    /// Timer should not be restarted.
+    NoRestart,
+    /// Timer should be restarted.
+    Restart,
+}
+
+impl From<u32> for TimerRestart {
+    fn from(value: u32) -> Self {
+        match value {
+            0 => Self::NoRestart,
+            _ => Self::Restart,
+        }
+    }
+}
+
+impl From<i32> for TimerRestart {
+    fn from(value: i32) -> Self {
+        match value {
+            0 => Self::NoRestart,
+            _ => Self::Restart,
+        }
+    }
+}
+
+impl From<TimerRestart> for bindings::hrtimer_restart {
+    fn from(value: TimerRestart) -> Self {
+        match value {
+            TimerRestart::NoRestart => bindings::hrtimer_restart_HRTIMER_NORESTART,
+            TimerRestart::Restart => bindings::hrtimer_restart_HRTIMER_RESTART,
+        }
+    }
+}
+
 /// Use to implement the [`HasTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
index 3b256292bc86160a495f7b192b3eda92f2dfcb31..1711b41ab32aef0c6f5263eab38bc61d6c2a189c 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -82,8 +82,6 @@ impl<U> RawTimerCallback for Arc<U>
         // timer. This `U` is contained in an `Arc`.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        U::run(receiver);
-
-        bindings::hrtimer_restart_HRTIMER_NORESTART
+        U::run(receiver).into()
     }
 }

-- 
2.47.0



