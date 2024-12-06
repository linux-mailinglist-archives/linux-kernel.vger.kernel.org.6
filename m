Return-Path: <linux-kernel+bounces-435536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435539E7917
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040892814A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783D21D01A;
	Fri,  6 Dec 2024 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcuPaAQU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E48D20CCE4;
	Fri,  6 Dec 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513757; cv=none; b=WWNdFfWTcHi4ECPuq8uhHNwKdAlt59gzhPnM/xY8uEr3+VE6EPe46OYNcJu5LKaC/H4Q1zittOHHYxzS6OuLmBJZXpq+ERuYRhI88cK6PI5uXofA8ZUlH/utwj3XPLi0EL0nfnZRRediK6TZfU16VGwWBeuReFg/iNJo8/X9+fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513757; c=relaxed/simple;
	bh=YPhq18Bquk8BuL/sZQan8btRfhn1YbXyifWT40yfIzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlyZRhJuZQiKGBzey8/U6CpEAD7dDa7EXDroSgupC0tDc/pmekXKGY+O5YSE8uwpoVf2rFkWdYFOiLgt1yFWSYsoFpB1cKlfvvUwDo0wIdjZNUXCjePk4fgD7g1RsCZS3GT0MT5V4bDnelLN029+rFd0tv9wD64VaDzn12igVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcuPaAQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77867C4CEDD;
	Fri,  6 Dec 2024 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513757;
	bh=YPhq18Bquk8BuL/sZQan8btRfhn1YbXyifWT40yfIzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HcuPaAQUjUXeIy/Kw+o+9DNdR8nJRw5NYO5NqWu3ZbWsKzHECnGldFbGOvMJivl70
	 20mPoPMBSjxeINpXR/o/io3t5MqHhe1bF8DdPJhmGPD927ooeEd7cG1d4W64Zdl793
	 RLv1FU28Uj3CLOPklAhiOpERFrzntO/wWykaz0Zwp0VC3TaffsPgnm83WLPwM8D+1x
	 NShe2AHgtZf0Q5yQLFZC/0+gNZ6Snj0nf89IQlpqJWPPWoE68YA+nl2zdjlUDx6s7T
	 548K31mFiXKwg5WqxAFC4C7Rta4sPKLA2bfZABgbHp4etRVDAWmxQKRWsfZrJTFHz0
	 xQEJJpt9dQ+ng==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:32:58 +0100
Subject: [PATCH v4 06/14] rust: hrtimer: add `UnsafeTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-6-6cb8c3673682@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=YPhq18Bquk8BuL/sZQan8btRfhn1YbXyifWT40yfIzQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVcwR1NQaE11cEZsdGVpeGtJYjkycElyClNOK01wQ216UWtjOXZZUWtP
 dzVGdDRrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnR
 BQW9KRU9HNEdqNTVLR04zM1NBUCt3YlRUTFE5WnZyUTI3V211MzYzNDJIcU0vRUxmZUM5MzBaTA
 pHRnl1MHM1VDdjSmpFemdtSy94NXU3akNHRGZTMHVkUnNoU3hDR0I5cnQ3MUx5TlN2Z0J0eXdiK
 29IdHpyUEYvCnUrKzBYTGZqODhlWlNBb1hRNFl0MHRpbjlGOUdJY0ozYUhKVzh1ejZIWlU5TStr
 UnpEVEp4Z0xONFFVaGRUQlUKYXVLaTlWc1FYczJWTzg1ZHJxYlZGS3NsNGtuSndTU3NsYmNUbWJ
 Ka0RQWkR6RW4zeGZqV3UyVjgyc1NIc2t6WAp4b0x0NlY1ZHZpWGJJTEUvUjZ6MzRXY1FKMjBHSn
 JtZ1p5QXEwUDFWc1JndjE3akR1aktxd1BwN21JU0RBWElPCk1xek9sN0I5Q1VhRW5SWm1LOGlOd
 TByQlhndllFTHJDUTNPMnFubkcva3orakFnZUI4b0Y2KzlzdWVTakJBdFEKWURYUmwwT1M3L0JQ
 d002QWpMa00xNlZSV212SjdBL1poM2tMa0N0Q1JzMVMyNDIybEhtQjB4bVlrTXRNQnI1MgowQnN
 KVGdRcWFhR2Y3RW5POUxQYjdxY3BQVEVtcHkzOG5Kd3Z2VW9UOXFtdFdxdGFjbndlalJUa3dOYm
 1lbHU2CkltcCs4blNaWlVEcDBkQ0hrSkNjWExQOTdhem02M3RacEoweWV0TnZZSUpvM05CQUVlY
 kw3aXdTK3dvR2U1cWgKbENxTWhNQjh5VVBDSkNBQTNOTzgzUWViS3YwZmJzRk9LS3U4eHJ0ZEly
 QVIySUc0eC9GTUVlTW5OMzU1T3F1QwpicUF6VmpPVjdvUmlWQjRwTnNIeTFmZkFscEk4UWhpcyt
 lTTBJSjF6REpPWUkxWDQxb2VCUW1SL2h5bjVUUXhWCmNXMk9MeHZmb01ZeHZBPT0KPXV5RWEKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a trait to allow unsafely queuing stack allocated timers.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 632b28a8a6338e2841c59412f22268ff86410a8f..fab9bf2612ceaa1ce936ab9b9bc31b018a1a9aef 100644
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
2.46.0



