Return-Path: <linux-kernel+bounces-552001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C26DA573E0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05737A7C4C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1C425CC70;
	Fri,  7 Mar 2025 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aCZcdMlB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EB259CA9;
	Fri,  7 Mar 2025 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383695; cv=none; b=ePXCsdT+BAV4ALMNje9uWHgCI7xC3Z7X82bigKBelAr/r4HLiLt0YOAFO15mXMqP3Rbhczxf8z5yFPZhVy/xvbIgAGC9Rb4fi9dBx62MtmRKgIMzCheyZXGi/pMbTTctftjJGzWCCcY6LtBE6afqedyDBSaDLQn9ghPwEQTlpus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383695; c=relaxed/simple;
	bh=3bxVBo82ddemMxGZRW0VqOyDMzHVGczdwTPgSxPEcss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=exEf/8yrOT35WmU1F7C9NdEsrJdo2vc3Fb0Rv7HCHcHOfMArvJxSNrL8nyAG70pXTglOTO8B8KS9Zuot7YlMEt8eZ73f/CuyPhdBK/ISVfNxbOFUn5bBRCTxMqKlWpbWpd145GCZlFYFp2bspkaxc1ugYKYBPj8BMv9sECLe2Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aCZcdMlB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8E8C4CED1;
	Fri,  7 Mar 2025 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741383695;
	bh=3bxVBo82ddemMxGZRW0VqOyDMzHVGczdwTPgSxPEcss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aCZcdMlBrfoJ29BfxV4h/jzhmS839sxKnXiRfSdZjKaDZT/Yl0jz2NgVFL/EoJqCe
	 dU6fn9TP4GHyRNUisxmz2zD7uemF0udjTIvRreRma6XFs2wCw0O/3SV+F4X4vCBx40
	 NdCLI9xAH/aa83C02ub+UqPiMLvxfXb1x6jEwkfHh6A7d1DBFMr37mLixHho0P8pyg
	 Ks9SDdrGDwG2gHnEI9HVyrVmq3fp+vVD1GZPOjQmsNcDwi/+Y6lMJfmwYRxlCbuZ+7
	 dJlj/4WbZcz+0ALsZ9HWqsWV/Yul+BN1wDsSop0hCVBAKLNntyqf3XnSKTghkoBf2R
	 YRoF7Rguh34Hg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 22:38:46 +0100
Subject: [PATCH v11 05/13] rust: hrtimer: add `UnsafeHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v11-5-7934aefd6993@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2216; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3bxVBo82ddemMxGZRW0VqOyDMzHVGczdwTPgSxPEcss=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBny2dt4+osDGoFPXRGn6+5hNbfHKA7/e86FGCl8
 yi7XB6rl/KJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8tnbQAKCRDhuBo+eShj
 d5CxD/9Pe+iycansJ0N165MY67d8ZujTH2HIENnV+3zB2ieJQkG6rIlkP9tPZAuXyE2OSWv5OTa
 GJFmhz6gyrQ08iPDDtxadqE3+hxgdyNzuQPk/Urvot6wz9jrLv/LFubgIKeFZDcQuvqmuEgvdlu
 b84RnVyKcOF2jUTmnaZlyD3irUwtXpXutwN2FaC0cDlzclcdsbw9Gn+UBvUIP92k3U/RatlmsCF
 iv0tOu/qyf8esns6Ys8dxvhLXSgB+wdHn9N1FF4M9b93hV74AQTxwGzYIp31OUQO2VaXH820OAj
 8IYVPFFy/eu6QdZTFNDRuGv8tbunGZ6bRssDV0IomfeXw9PA1qFy1uc39QVfmb2qsqSdCPaytJc
 ASR3Gz7USeZ0KNAmydz3DNQ16nUdTvx37bOozG9uJKGJ4XPGz6k8NeiapmBrg+D64pQh1fG+6TE
 RuVqHrsQlH6lnHavFzOBFqTZdSui9SPr5TN2HCTxzrFxxSkoad407R81xVS91wgs8ai5lzCKPP4
 YWpFEjTMZdDe4JjBSgIa8794LzfNAa5FD1GdyrFN5OsLkOfZAK/6XdgbivpzRuxp0rTSBilhos3
 pZqu3Ey8qVQ1GBLjHFRtUN1KiwRig9PaBaUPP5ryZNol+yP6DlCoMDHMrzFkrxGCHi/pS4iucEt
 u9Q7h2WQdKkt3kg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a trait to allow unsafely queuing stack allocated timers.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 1a2d05ae7f21..07709c795022 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -188,6 +188,37 @@ pub trait HrTimerPointer: Sync + Sized {
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



