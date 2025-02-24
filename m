Return-Path: <linux-kernel+bounces-528967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89EBA41E86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BC267A9E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554EE2571A0;
	Mon, 24 Feb 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wofc7sKN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96C194A44;
	Mon, 24 Feb 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398736; cv=none; b=aBBC6LSsgZbj8GlSP6yfbkLLfaU+FlRcJN3dacorfH1OCwv4MWvQwFHOVeWKCcm0GkKimRWwWmwwEmvaNbNfE6kQ5N0DlRkc3PsXZLWwOef96/LXby/TAiFQDmQGmaZxD7kPLbkoGbh9AeSfTxgoXfEAiR4brxkxOSKppAbvDYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398736; c=relaxed/simple;
	bh=6yblkzK1pz5dd37z4/n6G451i8mJWfMrogL9Rec+Zt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KChmlu+kE+zwq1a0r2zZdnpnCMKiaUypaq6E7jIJOQ/aRCiVksCL5ZNLJC+v1Niw9JR2WQKp0nFdOhd0dq0q5afAL+Kv2OFBMHJKH7woBATRnUKeQ04TpcE1V1/gZNuWpe3YnNjVTdvxOqBS944pcRyHKbnMrAAV1QQWWLwpHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wofc7sKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC96BC4CED6;
	Mon, 24 Feb 2025 12:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398736;
	bh=6yblkzK1pz5dd37z4/n6G451i8mJWfMrogL9Rec+Zt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Wofc7sKNo4JZJHjtKMojNqC59eA2mEzHwuO9BS6r6Ed6A4xeT7Hl9tPOuMIpdQJnL
	 WUhXYxiKiw1Ozgrs2hNnTQWC//0lq3oppl6bv5slxMAka2FlWS47YpKwfj0TiJ7Aag
	 wPLFlYngdB2ca9JoiA7Tr9Bi2dV/PnobPWlOgEMCHjcY6OKHL/OrQPkNj0oLd8e3IG
	 tw0YbXY4eF2GqS85JmXE0p1KTH7eS5jcO0i6VPLyKysmkcoZiQlmAkH2PLN0EuvUso
	 9XNGmGx95BGwQioDT6AmHq09Q25YqpSR7AUmNEhwx6gIooD5E2PXdJSAVWLG18YNn4
	 Olgir54j2iYXQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Feb 2025 13:03:39 +0100
Subject: [PATCH v9 05/13] rust: hrtimer: add `UnsafeHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-5-5bd3bf0ce6cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2172; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=6yblkzK1pz5dd37z4/n6G451i8mJWfMrogL9Rec+Zt4=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAg0WqlV8YFGx4153xbg6pvXPxIbjxwcjFW2
 +2bMVzYTheJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgIAAKCRDhuBo+eShj
 d4jmEACgoSWncK3Qf0rzl0Z3MjXoSzuL4+FEp6J9Psz4amLCPpp8wmKX0D92LyphsBmK8N1Cpul
 quW49w95B1X1VUNceOzdyd0WH072UIzGeUcN1ieHXbw7faP13oowr05cEgIlMcdFYMMF65SHS0D
 DeGOCCn97B68r+2V4I2GDz6RCgsMwfIo69Qott9Gm9Aq4IkaXkkRn1soEgp7WIpjSEWogB9SVLT
 idogELUQOxHtedKKogkvjXGHDtsoBbyOsbGjYnHb+8Vf6FEiT+3WBYf+4Kt5jHlcdKooFylS0LJ
 tJau7Vo7Kx8sA/udlt+L92Ta8CUPApSqS6cZh1JHmwHE6yX0HUXP3tSNDl3VCyyXq96V/W78HMB
 6VdFhosRB+mg2a0+sxLtQ0EckC1IlVC1t0FoxpXIxBPSCb3WI6aR0RIYfdw4P+O8FEPSPxy8gXe
 1sDP8DLtRC+G8QHIodzgZ9xn7XhN79PsJXiArfPR+kEsm21/xeUMUcANSh7f6U0sanuA6k4Lt+7
 1wbxAYOdZca97OgiqK1idz6S7axmKG118LirtMzEI0QM6VWYQo5CJ7tJFls/VW+99i84CY7b2z5
 LTsXH79dQQLBn7wSbeNUa8rjNeDnqgjGM0p/YcTE7L/4Ilrhg2iOoznEc0WdmOp4oB3CH54XEO2
 fqdLmULsIjSPh9g==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a trait to allow unsafely queuing stack allocated timers.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index a431c8b728ae..2cb40b011673 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -181,6 +181,37 @@ pub trait HrTimerPointer: Sync + Sized {
     fn start(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// Unsafe version of [`HrTimerPointer`] for situations where leaking the
+/// [`HrTimerHandle`] returned by `start` would be unsound. This is the case for
+/// stack allocated timers.
+///
+/// Typical implementers are pinned references such as [`Pin<&T>`].
+///
+/// # Safety
+///
+/// Implementers of this trait must ensure that instances of types implementing
+/// [`UnsafeHrTimerPointer`] outlives any associated [`HrTimerPointer::TimerHandle`]
+/// instances.
+pub unsafe trait UnsafeHrTimerPointer: Sync + Sized {
+    /// A handle representing a running timer.
+    ///
+    /// # Safety
+    ///
+    /// If the timer is running, or if the timer callback is executing when the
+    /// handle is dropped, the drop method of [`Self::TimerHandle`] must not return
+    /// until the timer is stopped and the callback has completed.
+    type TimerHandle: HrTimerHandle;
+
+    /// Start the timer after `expires` time units. If the timer was already
+    /// running, it is restarted at the new expiry time.
+    ///
+    /// # Safety
+    ///
+    /// Caller promises keep the timer structure alive until the timer is dead.
+    /// Caller can ensure this by not leaking the returned [`Self::TimerHandle`].
+    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;
+}
+
 /// Implemented by [`HrTimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `HrTimerPointer` to make it easier to specify trait bounds.

-- 
2.47.0



