Return-Path: <linux-kernel+bounces-435528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC19E7908
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B1F162476
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A0E2135C9;
	Fri,  6 Dec 2024 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAd9SOtB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD9192B76;
	Fri,  6 Dec 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513728; cv=none; b=iD6Zx0tGB5hJWi963I+Te/axY0siuQG0C5jcW0ro3b+xssTLHGfPuTBQ0F9bRrujCtrpHWdNASfgfEWeweHExXCgq4PmtrWrtNEJkSEf4UzHTrTasX47HvI5ZQHuneOkgQqnYmEIpS1SLO8BaqAHl6ojZ0RUeWcJHOd158x1+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513728; c=relaxed/simple;
	bh=wVTamzZSe1kQ6JYXAaG0jogPsO5/dwiimgZfFD4yVyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kRVYxrCmEajILKn5iLpyuVtQMG8KL3ZS71rngNISUhJvVQ0Ba4kuLEnXM7kYFTKzQwx7T2X0BxN/92op5wUvab0dNng/pANBJm0Yhlg1CBtfdPLFSGRWU99BF/ky0lnICBjWG9XAdnxUwG0y/GuPj6vh7sFLqlIvSs4xzEgNqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAd9SOtB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B2FC4CED1;
	Fri,  6 Dec 2024 19:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513727;
	bh=wVTamzZSe1kQ6JYXAaG0jogPsO5/dwiimgZfFD4yVyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gAd9SOtBcJWoNPOzI8PpHba3W/7n6M+rNJ9aRsXjv6p7CI5jpL1BXD5LAsyT1PWGK
	 ZJ9VN3VA8Hkcms5GdfReU5nHRtIDUVx+pvXGpsUhYHXPFMS29jXv0ITdOO5jSXUX0v
	 g9KguKtp6zw34rfvW+JI+wM4uZQds7wpAqyPKsw+iQZgqh6kRPPwgFNwKJxdiRdAN0
	 nxbtFb0VAIhJ89irmf9/kfDOXu2IpgJ55zjUv2y9b0qHunrXe6IBGOCzSmYvE8vKVM
	 wT+fPNW0az8l8A7lbrEI6dIob60zQkuUW/2+H8yVTWB2iIAeMP9VqoVd/kOgsLEKp8
	 b7eF2MeYqzVQg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:32:57 +0100
Subject: [PATCH v4 05/14] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-5-6cb8c3673682@kernel.org>
References: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
In-Reply-To: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2659; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=wVTamzZSe1kQ6JYXAaG0jogPsO5/dwiimgZfFD4yVyw=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVd5NE0va045V1N6R2kyanlkcndBVG9sClRwZWg1N3R2ZFFkVlVXdUtl
 ME1ZTjRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnN
 BQW9KRU9HNEdqNTVLR04zSnRZUCtnSnRRSmduUDJad0s4Q2N3Wm1IQlNaeWRZbHVSbDF2TGpQeg
 pFMHdTSlkwMGFxTGJvU3dHQ29mTXJBUWJocW1odEF0N2kyOVpzRVlJaUluSVNhTDBBK1VXS3JkU
 XhXcjR6QkN5CjMwcWprOVZqVWVUUmNKZHFnY3k4MW9GZlBZWGVFUHZURzVZenBucXhaaUNaTW51
 QmZ3bEd5NlE2OW9nRHFaV1IKZ2c2VmtCYUZTRVNLUHhGYnNMR25nNUdRNXluUlVHTmdnUDZDd0V
 jL2JaUUdLMlExeSs1RVZCdE5hbVVENjY0RgpKZW8yMXRQbTZRd2lFT3p4ckI4MVhJandBLyt0WV
 V3UHM5UGlqQTllWEJRNi83bGNkc2k2ekdlZTk4MjZsVmcyCjA1bWlFS1VjYWYrY3EwUnhSYmZoY
 0ZFT3lTa1pMMU5vTmJKbEtGT210VUtXazZqZWt1SzZZbUVidnNwZG9PZXUKZ3NrNGRPMXdOUWpm
 MnoydklpaEYycFhQVGRVcEx1eEZ2eGphZnNDN2x3U0FUSmtXU2FaUDMvZVluSDZkZzZKcQpCamh
 XWmcrblFkZm5ES2ZlazBxdWJpU1NIR2xjT1ZqSUt6ZXJoR3BVQzVyZzBTQzdHNEU3eVVVajhzNU
 xmQXRjCnVQbHdiM3FsL2M0aXJydm5LWnc5bWdJYU0vdE4rTlkzUjBBcHJtdi8rcS83dldNdE1wc
 2hLVVJZQS9BQ3RYUlkKbEFuaWV5a1hsbGZ4aFBZUkc1QU4rbmwvK2ZvTkFvTXVPdEZrcGZjV0Mw
 b1ZMeHBSSWc5RkhOMDNQeW5VOHBLQwpOdTA4cjhkWlRDMmdhWDZJMFJKWmhUWERnRFBvYUowZ0l
 qd21nRDc0RzhJcWpRVlVqbStqcllNRXFobmhJVEh4Cm5sM0lWS0RnN0NJWHRRPT0KPURZSTQKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
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
index e76b864f3435667f56ed607fd3bf029317eb1332..632b28a8a6338e2841c59412f22268ff86410a8f 100644
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
2.46.0



