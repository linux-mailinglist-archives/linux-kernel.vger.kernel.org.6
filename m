Return-Path: <linux-kernel+bounces-551999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5862CA573DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29BA18961B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4450625C6ED;
	Fri,  7 Mar 2025 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLAj1Ean"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4182580CE;
	Fri,  7 Mar 2025 21:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383684; cv=none; b=MiBeLnaG+4mwXajxwekeJIEhc5xQ0s3UhMu7arn3mF5aVzMpG0c3M9D5fy6sTnm+hW1ENDniCr/5fDWDN9ZW4WGV60FJWNjmQmWTlpBYYvAtmx6sMOv2PKKJH7nff44cunHAinmPuupiAuaM6OQR28JuD3u3HfD15/9thO9e4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383684; c=relaxed/simple;
	bh=ASoQCki3bqk3buqrbvnnPUagvQUAYcUvR1YCaRZm1ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPaqfeQ0dBQ5lLwcOQSi0ufLfljyjkvUZHkCSH5gSBTzgW9/r9+tp6tDFlV8X+GWKA0gPj9NJ+GNfh5Nn9s71XKIwtVgwpSWcgYjyCCHJBI+btmbYTu74u+tQIHawQoOiUvQiiccCUIJfgFSHPLnzBwxcnvnIvxrnBAi5ZU2uw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLAj1Ean; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF6FC4CED1;
	Fri,  7 Mar 2025 21:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383684;
	bh=ASoQCki3bqk3buqrbvnnPUagvQUAYcUvR1YCaRZm1ac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vLAj1Ean51Au9eTYGHb5WhIKnLEO9imwbsMKfz7UAb9MCR6CvGEWIHvmKsoLmOnXK
	 KbS/wGdUgh3n1LSM+cl5txrQLpkXbOJAbViEcBGYwHSi3bzad77azzW2v248QQZyMo
	 i7D7XqaaAWErjalsG7BJ5GPxD/YGnTGCdv/1x2Z/eibWp+hROzU9EqXiR0D08h9R3z
	 sKJvmR4D+3gD8puBe+56TxibilNkAq8NWJWfDKJRsn4Q2iznNXmLtQXhsVJCJ+/fER
	 wmI7Ac03TJ59n3ghGG2ErmerSfH4xWhoAprDgV8wYQdopc7Pzv0wruLvCm8eFicBK+
	 UyudTj4RvDwJA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:45 +0100
Subject: [PATCH v11 04/13] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-4-7934aefd6993@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ASoQCki3bqk3buqrbvnnPUagvQUAYcUvR1YCaRZm1ac=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dszkkYpDC1CPW6snfVC3lOU/Nb8VA7wlxad
 d9sV5tv8veJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tnbAAKCRDhuBo+eShj
 dwptD/0acutbQ+b0CIn4lTOe0YHNNZmHxqoLDiZOyhF1J9oYHujRACGuJsIAmEcM6L+QfllV05p
 rMFJI4V6sEEHnosrq932IA1TiySa2fmtMt55Sn/X5RojkU4bEEsRWJdl9XHeSt76ne3nDdhSsVL
 Tdqwxlc1HSfR73IJM5uFfTMj9vlOz6sUcnNx2qNVgkh8jPtpYtyVOeuXfOxzAArjQRT28Jwn2JQ
 k0XHigQ5wiouCU3hVo5YeEplI0lOOprvsJvhOFDJ7Cxp15cGxfAMBGA1yQR/ZjiaFNL0qiR3ji8
 hQwhsboYY1rOyHlt640lvV2jWeQfpmHzxviceX/py8ooIfKqcD43qjB7GRuGY78jSiI/ANAbyIr
 UprRv3ycbeX+cbabEGa7dFDQp8XV10TRh5lgtFImRTOKKe0xY0PeDEUARQQ5ZcmCIqgLvpVxKh1
 WrO3dgjPSSKcHJ+mSBYPXp/f9Bh4SlDExhltEw9RPfOMIFKUI85sj8gcCCy4y/VBdaALU1V+gum
 LHHgHyy13enWhpLDtSVPAwK4HbZiC0k0Cc1vdxPUVOprAZwBuR+1FdbVyWZy1gnesZxLwOqEVIW
 Uyb70lnKZkcB9C/hX37q5ruk0ARVZg7/L2Fy0lHju666x203inOl2OpGeU+9oZfSGsa/QrXlfoa
 xnceeIOvudEuq4w==
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
index f69a8483d21f..1a2d05ae7f21 100644
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
@@ -311,6 +311,22 @@ unsafe fn start(this: *const Self, expires: Ktime) {
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
index fe3cb869bc9b..e149bd4db509 100644
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



