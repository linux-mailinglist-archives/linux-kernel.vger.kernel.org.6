Return-Path: <linux-kernel+bounces-332126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1897B5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D373B29B46
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2850198E86;
	Tue, 17 Sep 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MY9HozzL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285E198E6F;
	Tue, 17 Sep 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612148; cv=none; b=Be0Vu5igIuGWNyr/elx8SDIRYG2VQCdfXodqNsGLmm+yGsfoz0xz7qBpnzCIxqYzZYAWi86V/CW1YNjOGDO9jLWm4yEi5/X7DummPPj3xXAUKVgZeDLHkQKBFUNyG+KkunnSOtKBU02h1flvMNdXfSsErDbDIv9DSWWzbfrk7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612148; c=relaxed/simple;
	bh=zFYDsWoZ9q7N00Ysvt0Htbb4HjfhO0N1xV16T7BjBOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJWazhZNHMTQZqvVq7AcYpe/suP2DMgCdJ8ZpYvec2kh5/MGhc7GzPLG9n00A/w+01vlNuIuolbFjYM7jRXCbbGThUCFzWmuClzlx6Cj9N8308LzT9Cib3OeNFNUAMnFQE+J54H/uT2uLPw6Aa5ZGsNiR8k9+e+J/YsNz+LOcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MY9HozzL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7577EC4CED4;
	Tue, 17 Sep 2024 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612148;
	bh=zFYDsWoZ9q7N00Ysvt0Htbb4HjfhO0N1xV16T7BjBOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MY9HozzLVit3INu12cpkz56jIJSSiNHYGpDUwonIYJ+8CHqvONc2cUMAYqNx735Hs
	 3pHyWpw6ctQF33/HOlxZao/N6uURsR0+0Ps/vxhSBt9NwaYyrjnUvd88vu1f0lAXMy
	 yaXGIEBjBX5RE1j5jzlI6GgxOYik/3DxWnkJTeDxbsaUI2jsXP7TQeHx7vDOgZIc7p
	 j8HwfkyJlqauJeDT21PjlVEmFm81rXT85XuTT+le+l3BcBGQQZXq36PZX05Bndp5J+
	 kzOr59bAhd/5iGwJ9yGy9xA2BzTGoVKSfP38H4kfGN69Ogh7KWy0oHU2ZNcMpP9nLg
	 chyT3bm2lfWTw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] rust: hrtimer: allow specifying a distinct callback parameter
Date: Wed, 18 Sep 2024 00:27:35 +0200
Message-ID: <20240917222739.1298275-12-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208; i=a.hindborg@kernel.org; h=from:subject; bh=zFYDsWoZ9q7N00Ysvt0Htbb4HjfhO0N1xV16T7BjBOg=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWY4bFcyUUtEbko3NU9QS1A2elNlWENNCkxFNmc3My9WMnd4blpnZWVT OHBIVFlrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSC9 BQW9KRU9HNEdqNTVLR04zUVlRUC8zWTYrbzR2ZURMZ2FnUFFLM3ZPM1NncHo1Z3g1VCs1WjVEUQ pSelFYY2pRM3ZQWDVITnJUbkhaVkR0UDExdkZGRTRVdWxZcXJyNmZLTDRMbm1lQU9uVXZHK1FFS FZKSFRGNmJwCi9GTE4yZ1plTzFwOVFuaEhQeWhxSFpJMEFqRXQrNjhKd25wdTFFc0FYcUFtL2Jz OVB0N0JXeXQ2dU1welBiNGcKNWhtY0oxUnJIcTdNUDNNK3F2dFJCWk54VGtHbGU3Mzhma0F5K0F jdXFBYjNZNmJpdTk5dnFsVm1YNHlORytzSwp0cmdBSEwrV050ZGIrN1lFQUZDU090dC9yVGZVMk J3QzUveHdwZTAzYzBxd0FxenJNekZMQjkyNEJKTFNEOVlGClQzMCt4ZDZkMGxqY2lBTElDQ28zS GFCQjloekwvemRVek1ROUFUeWVQOGhpQzU1a1M2UEo2WGs0MmVjNGhYVDEKU1E3MnJqZUZZQWZy ZVZkNEJZRkg1eUk2d2Mwem5GbzJkUDBDckI4TDdHOGswZ1lrYVhXUE1sQldqVjVpQ0JiZQpqc1I zeXduYWtsMTFLdVZlZ
 UxnRE91R1dKeGh0MXBJSktDN0QwMG5rRWpac3NIS2xKVWhyNXFqSnJKMn QrbmQ1CmQ4RHBCckFvNVdNQVhlMS9hMFlhWFdrNWlpbDBkUkFNUHB6Zis4Mkx3VjVkM3d4WWN6Y 2lqVi9ydTB3RDEvWnoKZCtRZHExSmJGOE82dEhHcXV1ZXJIOGk5UnZ1MXFyM1J1ZTZUWjgyWm5L OGlDbUVTT25MNk1QbDhmZzJUZ2ZvMwpENzI4UlREbTFBbEVzdWk4czBJMElMNkJTWHloemlUSE9 HTWZ1TmxyYnl2c1pyN2pXcjFUT2NDd0svR2RzaDlZCldTWHM2aERFY3U4aENnPT0KPUhuSUcKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

For some pointer types it is helpful to be able to differentiate between
the `TimerPointer` and the type passed to the timer callback.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs         | 7 ++++++-
 rust/kernel/hrtimer/arc.rs     | 1 +
 rust/kernel/hrtimer/pin.rs     | 1 +
 rust/kernel/hrtimer/pin_mut.rs | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index 6254fa584464..38160221f93e 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -38,6 +38,7 @@
 //!
 //! impl TimerCallback for ArcIntrusiveTimer {
 //!     type CallbackTarget<'a> = Arc<Self>;
+//!     type CallbackPointer<'a> = Arc<Self>;
 //!
 //!     fn run(this: Self::CallbackTarget<'_>) -> TimerRestart {
 //!         pr_info!("Timer called\n");
@@ -104,6 +105,7 @@
 //!
 //! impl TimerCallback for IntrusiveTimer {
 //!     type CallbackTarget<'a> = Pin<&'a Self>;
+//!     type CallbackPointer<'a> = Pin<&'a Self>;
 //!
 //!     fn run(this: Self::CallbackTarget<'_>) -> TimerRestart {
 //!         pr_info!("Timer called\n");
@@ -335,8 +337,11 @@ pub trait TimerCallback {
     /// The type that was used for scheduling the timer.
     type CallbackTarget<'a>: RawTimerCallback;
 
+    /// The type passed to the timer callback function.
+    type CallbackPointer<'a>;
+
     /// Called by the timer logic when the timer fires.
-    fn run(this: Self::CallbackTarget<'_>) -> TimerRestart
+    fn run(this: Self::CallbackPointer<'_>) -> TimerRestart
     where
         Self: Sized;
 }
diff --git a/rust/kernel/hrtimer/arc.rs b/rust/kernel/hrtimer/arc.rs
index fb8a40484add..ff04b0b75bb3 100644
--- a/rust/kernel/hrtimer/arc.rs
+++ b/rust/kernel/hrtimer/arc.rs
@@ -67,6 +67,7 @@ impl<U> RawTimerCallback for Arc<U>
 where
     U: HasTimer<U>,
     U: for<'a> TimerCallback<CallbackTarget<'a> = Self>,
+    U: for<'a> TimerCallback<CallbackPointer<'a> = Self>,
 {
     unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
         // `Timer` is `repr(transparent)`
diff --git a/rust/kernel/hrtimer/pin.rs b/rust/kernel/hrtimer/pin.rs
index f9ce0498a0d2..d34e0885f0f6 100644
--- a/rust/kernel/hrtimer/pin.rs
+++ b/rust/kernel/hrtimer/pin.rs
@@ -74,6 +74,7 @@ impl<'a, U> RawTimerCallback for Pin<&'a U>
 where
     U: HasTimer<U>,
     U: TimerCallback<CallbackTarget<'a> = Self>,
+    U: TimerCallback<CallbackPointer<'a> = Self>,
 {
     unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
         // `Timer` is `repr(transparent)`
diff --git a/rust/kernel/hrtimer/pin_mut.rs b/rust/kernel/hrtimer/pin_mut.rs
index e25c7158ae4f..2589720df233 100644
--- a/rust/kernel/hrtimer/pin_mut.rs
+++ b/rust/kernel/hrtimer/pin_mut.rs
@@ -76,6 +76,7 @@ impl<'a, U> RawTimerCallback for Pin<&'a mut U>
 where
     U: HasTimer<U>,
     U: TimerCallback<CallbackTarget<'a> = Self>,
+    U: TimerCallback<CallbackPointer<'a> = Self>,
 {
     unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
         // `Timer` is `repr(transparent)`
-- 
2.46.0



