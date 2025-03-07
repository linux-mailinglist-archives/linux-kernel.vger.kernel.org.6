Return-Path: <linux-kernel+bounces-550855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74986A56505
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB3503AD02D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238EC212D9D;
	Fri,  7 Mar 2025 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWKnjBBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE420E035;
	Fri,  7 Mar 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342719; cv=none; b=TIhU6duqMlTJjvp3izT1naEybed5pQcPCRK3J6Q4ZX7eiznAeRgDDMLjftnaUEchPHhz6DU1MbOAIXqhQtK0M1iPdlhliZl9H5InFFxe451v47VJmOsJfNBbeuHUoWu0ekoxhhTYeJJdYUprX/2HU/i3O2V7VwGOmIvassCCB4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342719; c=relaxed/simple;
	bh=TEGxbzI146R5lNyC1U5hsFQ7R+0lfRsS3I2W3WfAQQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tw/5Az/4JjxuazWMfhvgyj+tIAAHoO3v1gTrsRFkqp71511rsbmMrfUIsxg1lho2uRdnLZlkcpP/uZkrEJ96UEEApd/iq0Ag9u3kpU40x42juiRstFiX+eNSTbkOhsE4SrI2R1/MD68lhe2kUIRnytb6vPenPkPDH9OpTlJ25IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWKnjBBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C150C4CED1;
	Fri,  7 Mar 2025 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342719;
	bh=TEGxbzI146R5lNyC1U5hsFQ7R+0lfRsS3I2W3WfAQQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tWKnjBBgn7aFkgmzEi0IzEn4wSUsyhNXgD/TxSY0GC6V5o5/SVP9/YWcTURnwIAMH
	 zCZBIZ1OxEY/zZuP3dHa6/nwt1/PpxFR8x/zRSVdYDWY9KxHAKupDgTfz7X56Vq0bU
	 5lpBHDT210/4LYN0U6m2vsVGrT81SceYPTlPbApgztl6C4nmkzbtCtEUMLELMcslTN
	 kMUc1jPWqWKC8327IObcDV5n1HvEAgDImlOFd6qqYM4Okket0EDAOeM0dFd3v2FbPc
	 pEGbzcTBHc6NGox8dBagFn/9riYsujMFd0rGylNravyOiPiZxCeOnLZl61ng+WaTEF
	 6xaIgxeajcPyQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:49 +0100
Subject: [PATCH v10 04/13] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-4-0cf7e9491da4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=TEGxbzI146R5lNyC1U5hsFQ7R+0lfRsS3I2W3WfAQQc=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ5tXWwwxhvMZsRszWIPPbOE2I2j4qtqnb2p
 zSfmMaQW6aJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGeQAKCRDhuBo+eShj
 d+O2D/47MJ5FVKB8d/qhIyB9+ZFB7tMyef7DZWRH13vVt/cHZWURhUgssLFvRwrKzGmv1UiAhC1
 se/BRP6CW1sccze6A4lbJ9lkafKTLr5HUQHHS46ZImvuKBVa/+XNXw834ffIkpm0BpNYZF7+o8P
 dAdMBZp19E2WauoU1YJuA00rlhrh9j1q9yzFAO3Odqp0r0iYRCcMNBAHH2br4q08GxhNcpJq8Zq
 tAuAe8fLkxKcvMygHKTYx88wolRb/yIF3DRmPJ2dHY5w3dvckEX3kf+djnf84hlzxnGifWlRzbq
 tPder1bGKGOAAz/LD/M7vxINxTls2PB444kMf8+wf/xe686S31uHg7dDICPw+4XkxwIXBWXbroR
 JbAXcyEqvAWmNA0D50YUy30OQPeDPNFYLc3U5clSXIlK2j8alNoiiT0ALvZjkz48Zo6b8jkhzqQ
 xivIW0whieX0e5ttO8fDy5tRJrFFv7Sv/RRxOaoFI68GgRA4m2Ir/Fg6rVrIL43VEZOWdXQCpi1
 YozlYlBRw82HIhzvvqGsUfKV8M0bu6xP8VIvvi5zHUbJU3owKx7F5Ct7nvK2bYGO2+w7oKRr+GY
 zJSy7IBEVwtFQd9iZGDvvSShLJUzQal4wRusb0lvkEuSrli9Tazuu/Xx9rY7SCKvBAVPJcVKOwz
 0J+Hoyq92++BhIw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow timer handlers to report that they want a timer to be restarted after
the timer handler has finished executing.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     | 18 +++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs |  4 +---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index bb46602a7749..7317ba4f71c4 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -214,7 +214,7 @@ pub trait HrTimerCallback {
     type Pointer<'a>: RawHrTimerCallback;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>)
+    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>) -> HrTimerRestart
     where
         Self: Sized;
 }
@@ -315,6 +315,22 @@ unsafe fn start(this: *const Self, expires: Ktime) {
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
index 5c916489fc13..7152fa414b37 100644
--- a/rust/kernel/time/hrtimer/arc.rs
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -87,8 +87,6 @@ impl<T> RawHrTimerCallback for Arc<T>
         // timer. This `T` is contained in an `Arc`.
         let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
 
-        T::run(receiver);
-
-        bindings::hrtimer_restart_HRTIMER_NORESTART
+        T::run(receiver).into_c()
     }
 }

-- 
2.47.0



