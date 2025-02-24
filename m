Return-Path: <linux-kernel+bounces-528968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70428A41E80
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBFE3BC508
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C5219306;
	Mon, 24 Feb 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC6ZLa7G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC952571B3;
	Mon, 24 Feb 2025 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398742; cv=none; b=ZNfRderSspkvDAT7G7NOzFID1E+HQ1n0ZcPK7R+4zMC5EF4jMfTNndSg0BjhKGJyOQlKhSXyebrvR7iAkjwazb1NrwzLrldAYlJ65X5AfO1kBGqj2d2e9cPoStJsUdNNdLJ7GuxIkI/9z6EiwR5yk37cwWl/3qU9lzHvsTVMEjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398742; c=relaxed/simple;
	bh=r0ULufztfH0jkbivZ6XHvmJt5U9rOvca14UhqyDENSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ly0VpEZOND/BDVFFHMvGwGZLwpI6VORg8Cq0+a5YDyNdYKZb/cfJBwV006BRbYN3yyTBtTqjCXpO6yXXA0d6hmI64rzPg+3oY+sSDiNdyIqkjkJ6U0WXTvEBSXCRkcSK0bB+cPnt6v7GrimIjdffkHGFPuh2tL9eX1aDw9fIP+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC6ZLa7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0A5C4CED6;
	Mon, 24 Feb 2025 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398741;
	bh=r0ULufztfH0jkbivZ6XHvmJt5U9rOvca14UhqyDENSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oC6ZLa7GGoGY16F7GmHz0aIYKHUIGGmogF6iJ2sEcp7YzFwaxLdbNqMQdbaYqsI1t
	 twBrXYq5CHrwE9XePu572URJa8UxAYxBHzyGdEsxl7XlISFWt5/gcmTZ/dboEPooQ3
	 oJHb1ajFbcQ5CLPcmXDf1h8682GELdFJm0k1xBB5H/jKgGzvMLv5oJZlhb37lNphEt
	 tamAwHNTyHB7IQgK+y8YMSZIXPCVtC7NZ/VoJ0OgmYAo2mRDrrtzO//jmJp0Ev3Hew
	 fV2gmzIWtM0hd2Kjgps07KkNVrd+38x1/0sW4DYV7hSqS8E78d3EGSO7GusZufW5d4
	 AFdO7FB7QmaWQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:38 +0100
Subject: [PATCH v9 04/13] rust: hrtimer: allow timer restart from timer
 handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-4-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2245; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=r0ULufztfH0jkbivZ6XHvmJt5U9rOvca14UhqyDENSQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAfZIY6GwQg1mkzYRtfYxHgkQOI9Q09DDGMC
 2uaCQ9wbzuJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgHwAKCRDhuBo+eShj
 d6a3EACOCNej3koLmz/QD0fxGY5xscFd80oYkF3TM+gwTB6/JKNBH+VyBOrh8+HrGGRuI291LGI
 B181Iw/0ovVIX0BwCOTwv2D/3qku4bWbvmnVQDWhlnQTndZkvsB4SihCp7N6bi01T/WwewmGo2Z
 Lm9XEQXzaSUQ4cnXIIma+yeD0BAMPb0Ku8QlNcJ9WSYzxWHMXOfS44hXNfAx5dKXMIoFuXu1yoD
 ksa5yHlHckKRSZEeFEm3GReuHOtFz/Gd+NbKx0mm/PC0HNzlyhI5+4nVIuQ9AeD6TIkOspjwqsQ
 wYIWWzUJ6X4P8ZDmuGXZkfjf4PTjZEQ7jA0aj1pXoWjVhLOurisYyaVMX7u7XWuXN3+uqtXoCyp
 uvLpqEhw+GJ2jYJJIPCm9e66uhRoQPzWeUh82nIkOowW35SV1Q86HFv4qv+E3EzexxiB2sNykQi
 olwvLNc9XC/wfcD53eorkPWR421Si99uxjkka4S701Y01n/UDJTQi07FoeTbY/Zl8Ea7JMrqdwx
 pfKWjSK673MZ5Mh8zgSrrcqz5x06cGZer991FByuxfA2Ar/z5iCdIMGp1UHQtu/TdK5yFfPjfbw
 Ns8zaQgPmJRE9CNUAyc1oesK4Ze/8qYEmdPjA5qGU4YsWpjq+6VBHUOaUS+UKs/cbyPQ9XhT3gR
 o4WDGRCAZBqKAug==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch allows timer handlers to report that they want a timer to be
restarted after the timer handler has finished executing.

Also update the `hrtimer` documentation to showcase the new feature.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     | 19 ++++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs |  4 +---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index d08fd7de158d..a431c8b728ae 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -207,7 +207,7 @@ pub trait HrTimerCallback {
     type Pointer<'a>: RawHrTimerCallback;
 
     /// Called by the timer logic when the timer fires.
-    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>)
+    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarget<'_>) -> HrTimerRestart
     where
         Self: Sized;
 }
@@ -313,6 +313,23 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
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
+impl HrTimerRestart {
+    fn into_c(self) -> bindings::hrtimer_restart {
+        match self {
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



