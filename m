Return-Path: <linux-kernel+bounces-332124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB097B5C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E011F2340A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154B8197A8B;
	Tue, 17 Sep 2024 22:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM28Mg00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F4197A7E;
	Tue, 17 Sep 2024 22:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612137; cv=none; b=OiQhvOGMruUPRX56hhV/Af8WQ2Z7F7CRbMQYrtrJJg4jutY0KNykU34ZTSiZXPrsU0JLVYw0L4IeMedyoXKphm16q7hZjdHqfOQTuceCdg6B7JRMz4jUgN4FpNbBc+ho4o1Gzqo8lJJJfI+PvJRBIFBOsjhtVXVHokzpCOb1plQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612137; c=relaxed/simple;
	bh=7F6IwUa6gAZ2Wot7skn1+aM4FyXNbXssvNoIcRbAycI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOSwbwWeF04GfpxZge41RD6s3d0cEA0paXxf8S4SFz3LB9mpTc5Ynwv6Btqo9CjUJRjnhWj7mle0xFDHyz4uba7M5V9AmRRKme2P/uBK191lzJbuwgMaiXVETnqtjuJ6QdrKyk/7Ouo0C4WPlgJeb/tZjorkODSiojpNJ0fC/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM28Mg00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872CDC4CECF;
	Tue, 17 Sep 2024 22:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612137;
	bh=7F6IwUa6gAZ2Wot7skn1+aM4FyXNbXssvNoIcRbAycI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM28Mg00bcAAeAufli76hTeLb7GEaZSAZUJf7g3g0/lNzH79eyfzp5I2KUNqoRPG9
	 2Xj3rQJbdGkeuVMdiIfHY0xH5nODpeQyCvHaUfkkz+M/MULRL7N9tEJhHgRb41K1Ol
	 p7vfyp0UCktP+zqCEtodvm5d/mfTKyLQCnZtFVVcTfGebo7ZsdK/mn6InBnS2Worzh
	 jNft+3wIbdysYaZSugD3b0fFzMlMrQfI0pmHs2htKx/7xftguMCfCTp/K3ZXMDDHFN
	 l74rJcOjgcLWJW6DHmd1kAjSM4l0ZcE64QQhl8bVIuDoDDrPqmRoN2Qer+7f7RGkrB
	 6D36IBIycpNgA==
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
Subject: [PATCH v2 07/14] rust: hrtimer: add `UnsafeTimerPointer`
Date: Wed, 18 Sep 2024 00:27:31 +0200
Message-ID: <20240917222739.1298275-8-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240917222739.1298275-1-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=a.hindborg@kernel.org; h=from:subject; bh=7F6IwUa6gAZ2Wot7skn1+aM4FyXNbXssvNoIcRbAycI=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZ0Wm5rVDhyUUcwZVpjc3pUeFp1emtjCndQd3ZmdlRKbjRTSWlhOGE0 ektjd1lrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSDd BQW9KRU9HNEdqNTVLR04zWlBjUUFNTStkN0Q3MEw5bXlIUWZOTElNL2RlWkhqSjA0Rnh5ZEw0Rg o3NVU3Wlh5eHQyeEVLLzEzVFBSL0QzV3ByMDk4ZzBERjZqTENkZmwxSUhCUnFZSllSYmhYb0NGa ndGbkNWK0FrClRwQUVoTzQ5dWxPQzBGdjgyVUxDdlBUQUUvYUU1dFAwNDBZeXBBbjdmcmFhcjJm RGppa1NWQlhBcWRKeG94MlYKV0hheU1Ga3dacDg2VnJCeFh1bGhRRVdUbEFQYm13bSt2dndNZ2d 4endZTkRrcW91QitBK04rK0wxZ3dmWHpYUwplcXE1S2F3RkF4YzlEUlRabWpaRDcxVjNtUDM5Vn g0dWdtbUtsTUp3R3YyM2RLZE1Xb21uSWJhL3VYMjNLR2p5CjhYNml6R2c1a0N3YjhzaGcvZXVTb GxwR2YxazFnK2JZMGtacVk4VDFkYW1aZWlnZlcrc3hvcFcrWTdkUXY4ZW8KK25FcUMxSnBRNURp L3Q1SHkxMXZJcy92L0dUNVMzQTJNYy8rYUxZbktSK2g1Y3V1OVI1WFkrSlM3ZFdVSkVZegpWQlp 4VXYxSG5DNGRRYmNmO
 UZJVlBKa0ViQVh4UjZWQ051am5tTDk3bDRselZVYmJlY3J5aUpuYVZ2b3 FzVzdYCnVjQmJYV0xhRm9BSExMTFVVeE5telp2OUFpTUlPdFZGMjJPVTMxNDlwdk5DNTlNRFdXb Dh6bXpHV2R6cUlwU1kKOXQxQ2c3MVVvOW9Oc2k1Qjk2eVFDTVRDeTA5VXRIZ1NNM0hqbWE4bWZa N3pIT3FKV25Qdk4rOFlWVjdLS3VsTgoyS1ZLVkpSa1kvWWJ6WG0wR2NVaHFNVFVmQU1NOEVJM1p XVnl0ZnVtaktTbFY5VVB1UUZxQ29HdVJ6TDV6MjJUCkQyOTJXdjF2Si9vdVRRPT0KPWFJSlMKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Add a trait to allow unsafely queuing stack allocated timers.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
index d6c3fa89f77e..bb6349f440e2 100644
--- a/rust/kernel/hrtimer.rs
+++ b/rust/kernel/hrtimer.rs
@@ -191,6 +191,39 @@ pub trait TimerPointer: Sync + Sized {
     fn schedule(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// Unsafe version of [`TimerPointer`] for situations where leaking the
+/// `TimerHandle` returned by `schedule` would be unsound. This is the case for
+/// stack allocated timers.
+///
+/// Typical implementers are pinned references such as [`Pin<&T>].
+///
+/// # Safety
+///
+/// Implementers of this trait must ensure that instances of types implementing
+/// [`UnsafeTimerPointer`] outlives any associated [`TimerPointer::TimerHandle`]
+/// instances.
+///
+/// [`Pin<&T>`]: Box
+pub unsafe trait UnsafeTimerPointer: Sync + Sized {
+    /// A handle representing a scheduled timer.
+    ///
+    /// # Safety
+    ///
+    /// If the timer is armed, or if the timer callback is running when the
+    /// handle is dropped, the drop method of `TimerHandle` must not return
+    /// until the timer is unarmed and the callback has completed.
+    type TimerHandle: TimerHandle;
+
+    /// Schedule the timer after `expires` time units. If the timer was already
+    /// scheduled, it is rescheduled at the new expiry time.
+    ///
+    /// # Safety
+    ///
+    /// Caller promises keep the timer structure alive until the timer is dead.
+    /// Caller can ensure this by not leaking the returned `Self::TimerHandle`.
+    unsafe fn schedule(self, expires: Ktime) -> Self::TimerHandle;
+}
+
 /// Implemented by [`TimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `TimerPointer` to make it easier to specify trait bounds.
-- 
2.46.0



