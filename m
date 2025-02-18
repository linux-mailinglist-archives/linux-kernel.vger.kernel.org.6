Return-Path: <linux-kernel+bounces-519518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE3A39D89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB36D7A4D12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A326E643;
	Tue, 18 Feb 2025 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oitTKfF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85A26E635;
	Tue, 18 Feb 2025 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885328; cv=none; b=kx74OSX8uO5ZajdWO2iAE9DMur8USxrJdlpgnW3uZGQptq+navsiuUQFcMrAw51MzLKhweWoc87SNn8tWZV202LBNR0Lu9wKe/Z3dcOlzfDPiQ74nscEyaq/GErE6vM5vLVFN2pfBYmB2gnUmer0Zk5xXRd7GRoawRcTlijoiz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885328; c=relaxed/simple;
	bh=5zKmv+EsEhW1FYM93252zgD+dCvrJvBVgpU7OYF8fdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EodF2rBkzRQ7k+zbNlIoKqYbQoo/WwHrcoKMmjGKfUT0MgGUzO0K8NPoIudg3e/THlcjXq2TRklKXBnFXZ6uZSc48OnH/4sWZtiR5w329Va0owW4xUqb2h0TH82977PDRqwluVwEjtUzKLhdd2Gg8U+ozAWj5WnxFE511FSNufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oitTKfF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E062C4CEE6;
	Tue, 18 Feb 2025 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885327;
	bh=5zKmv+EsEhW1FYM93252zgD+dCvrJvBVgpU7OYF8fdU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oitTKfF7Z/+2zadTAfeF9FNl5r2SHiM3vti+nv+Pkk9u3XtHbQwD1o9vYfCIOZ/9/
	 +m6+IMf2phg8uIXNqWX0O448Bavz0mnQ3WQhEpAgQ2hJd1o9IF8xOWIZ5Whmov+Nls
	 S9ccFK8bTv0ymFHwVL2x/XE4igYMnbhwEvdw4yvQrgwPiMNptKkH3tjAKd0g/4PUvt
	 k0DvrDu8MsLmeVqzoIHqBF/Igf6fxVSst6CoR6K6udhFHCgKEuD1upWYqBfwJZU9gN
	 Q/+T3l2KrdW9Z2D4wCDH1AAlgRZb6H+58lW5nnlhUiILvSlRCBM1Eexz5AmQAvp9n3
	 JCvaQZPvwU+Ig==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:11 +0100
Subject: [PATCH v8 06/14] rust: hrtimer: add `UnsafeHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-6-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=5zKmv+EsEhW1FYM93252zgD+dCvrJvBVgpU7OYF8fdU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIq0OJaXqxS62j07wi5/IylZb66zoyJOV8Xr4
 +bvuk2yc9+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKtAAKCRDhuBo+eShj
 d6YBEAC6aFhdy1ccGG1znaRc0mI3LCTPOEmpVuk7wTYbx3AqM8u8vggaUbWnT6XG8pr6oMH+Sx4
 q9KMrSATex8oC8fsR7WZ/prg7pTqJmLSxx8AbcElYxfu21+Ii3/OxP/TyGfP2TEGJfmmPhU14ba
 fPO8QmzIB573TE+tmmOdqgWzP3j1VVYrvT5lyQgWuOm7hDk2aH+bEb5E/szTSCUwO7FvBOhbbej
 Fq3BRBC3+ocq12uOE4sNCoPSC8ayhOhMbKGBitCMbuHmtbtgQaP7cgKRWrjU/m+9RF6DgfPtCGk
 CL+nWrn2ZmSdnijjZfGvOP1s0ARu8ldtbOdLNEcCP99lNraED1qkaEqUhhGF9zsANvGJObFj4xq
 +xRvC6Wl9aJSMXQ0OrnB2IqopbTVAgfO4Zctz5fc9ebUe495bPCFJrhJk0iKtKvPRNloo8WcvCX
 G2qnWvTptXZblxOUeQStnJEQnWxMN6uSmMmHO/dwwXwxEWBiKlshEGqscnerUm+jD0Lxge4Brna
 yJQHTbbqeNqhFCRYmS9g2PFah6sJahsf+JfQLiIG+R7LAYd/R8ifnARa8MjZT7lOnbz1azdk/oI
 NoYnfLSVEygEUEtGv95gdbnZcRls4bvOiYGmvoGCelef7BbveSGdxkIEZsfEiGT6uUvSOBbTIwD
 AF1ZCeLeb7BYCSA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add a trait to allow unsafely queuing stack allocated timers.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index e342193f985eb..196794089f033 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -157,6 +157,37 @@ pub trait HrTimerPointer: Sync + Sized {
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



