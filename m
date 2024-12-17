Return-Path: <linux-kernel+bounces-449456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23089F4F54
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6344D1671F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60B1F7578;
	Tue, 17 Dec 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClTxW8Ts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C051F7564;
	Tue, 17 Dec 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448818; cv=none; b=VYYxKWq02eB77muS+EK8uLazu+1RiNKHYS9mGpY6hZZ6RUFGlBTIEMx6Eb65g4LC84sW3gugTJvivDegnbWzZN0Z2dyF+MJaXGMeeS1FZX0RAAIyThuOd5H6+VlQPNZpbQkE7r2ltH7a+CdfvpSure044tyMwbUpDSRQEj3KYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448818; c=relaxed/simple;
	bh=F8fHHiPIwGJJkmQTQhR8tSNJzBkPpwYBHUBQlyRvMm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q/Z9JZZcqfF3LUzd+NiBg188+wwX+GBN6ZXXFq5xkwW3wUhPqkcTOFser1JXTywTibiNNTbSwq2Jo9gEK/uC+RprYMFji2wIg1XomRB/PM3eigeZARstrYj8/JGPQSXSxwPm1CV02tySqUbJ91VtuSQaV1d8xgzp19qouVNG61o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClTxW8Ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9804BC4CED3;
	Tue, 17 Dec 2024 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448818;
	bh=F8fHHiPIwGJJkmQTQhR8tSNJzBkPpwYBHUBQlyRvMm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ClTxW8Tsi4z0q49zURu50Jsffe93qkuehziWHvt28jiV1kqqQe7K2CSpDnO5zqCCn
	 07iGUsNVlhPjaJSBJBmXjILStxT/ctKSqDU//f97D7AIT/Oxb69EDKMN8K10osQB9x
	 LSkwJSUE5ZxLzbtBx7slUIeTNQi/zeSH1K5l/ZEwslfacxxu+xzgGnq7IFIIFZ7F9M
	 VKRpuV5wfVFZF6h+vsf+MHfQF2H54pBNNER6bA08OdpgRI5HwWnhpCt4mMTNlwjdqi
	 sWzkdhS4gqyOVja32FHMdbHZwJV7QIESmjX9yKreuvnzmQ/4eFtlP5zQ+3zNnD3Pqp
	 TMcQqvklBcbxA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 17 Dec 2024 16:17:38 +0100
Subject: [PATCH v5 07/14] rust: hrtimer: add `hrtimer::ScopedTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-7-b34c20ac2cb7@kernel.org>
References: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
In-Reply-To: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=F8fHHiPIwGJJkmQTQhR8tSNJzBkPpwYBHUBQlyRvMm0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYX6L4mGMd7FXY2UgbYulFj0HfvBqmyrdxAT
 Pa4fZ8TtgeJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWFwAKCRDhuBo+eShj
 d3IuD/9eYidi//zkKWvmxTuQp0NIf4d1fcJPotJ5gAlDxM6SbBM+CQDsCQ4QJUqZB59F6TdrAfa
 d6wmchZhQ7hpFlnhQgqCyZdQ5DyCdEoK+yYWfHGFg3/C+rKVfsK3Kd5NlFY3rqbM1Tawaxn17y/
 TSUGZYGPZgHsvym5ri351KFmjm/i63zbERCfl4jZECKmYifOf6NQ+LAZ2ZIF+bNfFTN0/k84EvQ
 WDvOWuddVNJkDFi7SrmfXH8v80/Tff3twaP98yzj9wHhD8xxHLNx3mBMUEQFXdQEggQ6+OhikFn
 2ErF+IDGArLMZ739AYF6EjytqD7abrLU3oeZps1bJnlDzVX9FOvwGAKQFbopJpwTxhae9oH0iHx
 vHRbXVOs2JTf2RTvSUiTIy1rRQOm4ULyzB3KuZByUBMEwhmOIGhFbb+KWtMp5UDXY20b2zmfgUI
 iJax/7Jv4N0dWQIrNGVomTSE29cOsGkbSCCNtfNba8DH8YrFFZPTiH3mYmM4CRbm0e0IpLwIbQy
 R6KASYKEHRM3QKtYby3QX+Sk1Lt6mIUd0VgxCTpEiczYjS+4Ri1zd9ioEq6nJ2LshOFt46A/Kgf
 x+AATYo45naDx1zsXIHleZiTyi5mTe3+91QmvykGV4vkqtRngqHsw9Vnn6XMvvBo+Q7XuAzjpN7
 Fq1cp+Cr1z69kCw==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add the trait `ScopedTimerPointer` to allow safe use of stack allocated
timers. Safety is achieved by pinning the stack in place while timers are
running.

Implement the trait for all types that implement `UnsafeTimerPointer`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index df0f6e720f1644ca31e0b64cd0f05a4a46098ec4..6b03eb4b42dbd6447728c42949a2f93d736dc3b0 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -175,6 +175,39 @@ pub unsafe trait UnsafeTimerPointer: Sync + Sized {
     unsafe fn start(self, expires: Ktime) -> Self::TimerHandle;
 }
 
+/// A trait for stack allocated timers.
+///
+/// # Safety
+///
+/// Implementers must ensure that `start_scoped` does not return until the
+/// timer is dead and the timer handler is not running.
+pub unsafe trait ScopedTimerPointer {
+    /// Start the timer to run after `expires` time units and immediately
+    /// after call `f`. When `f` returns, the timer is cancelled.
+    fn start_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    where
+        F: FnOnce() -> T;
+}
+
+// SAFETY: By the safety requirement of `UnsafeTimerPointer`, dropping the
+// handle returned by [`UnsafeTimerPointer::start`] ensures that the timer is
+// killed.
+unsafe impl<U> ScopedTimerPointer for U
+where
+    U: UnsafeTimerPointer,
+{
+    fn start_scoped<T, F>(self, expires: Ktime, f: F) -> T
+    where
+        F: FnOnce() -> T,
+    {
+        // SAFETY: We drop the timer handle below before returning.
+        let handle = unsafe { UnsafeTimerPointer::start(self, expires) };
+        let t = f();
+        drop(handle);
+        t
+    }
+}
+
 /// Implemented by [`TimerPointer`] implementers to give the C timer callback a
 /// function to call.
 // This is split from `TimerPointer` to make it easier to specify trait bounds.

-- 
2.47.0



