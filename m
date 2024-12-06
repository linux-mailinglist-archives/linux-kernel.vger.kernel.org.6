Return-Path: <linux-kernel+bounces-435537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C89E7918
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784B3161C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D321E198;
	Fri,  6 Dec 2024 19:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh9ZGDGm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D136620CCE4;
	Fri,  6 Dec 2024 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513761; cv=none; b=QaPewrBEeFf+ZZ2NG3QOExgiZmjaNymIR7JfyZdtWaLO9kTPSGmNMgf+mhvJwLq1gaUb+n6Q7FnP8hxZiJyoCWV1hpxpYC+TRYXtwMTjEc/AFhrSoCS71oaEDHm6cQJm7VtuguzZJyesOukAc2e32brjiTDjJSWdLirtWjbZb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513761; c=relaxed/simple;
	bh=7uXW0SpCswZ2a/a1jzmEzIBnEU4EedW+Z6gf3Sitb04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rpkSjaWSb3FZ4HqOP1rHeKpO+F/3oRsVBcwaY7VnYgmXVxCs5EZHKOs1RPJL48DGRr7jPr6onmcR5nEMTqoDvj0QH3oDZ06oMfs+8eZ29dPqj1B/i5wp5uulEEE7z9zLaCcL5On9Lu6HlyiLCwFA2Xi7//RZQ/8j3JwOHKARYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh9ZGDGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADEDC4CED1;
	Fri,  6 Dec 2024 19:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513761;
	bh=7uXW0SpCswZ2a/a1jzmEzIBnEU4EedW+Z6gf3Sitb04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vh9ZGDGmbpl1vstPHVQ556bpaWnIN+f7DWfA9u9BnaxtbW29hRHED6IjQmCxB0vl/
	 h7NQebZyIGqKNbX5UO1bEEsUES5BgaPdI0M2nGm/6ICf6xByCDoxfN33tdVGxcxnLe
	 sGuZfpJZRHdw/ss2CwGRVXpBl7Baf1p6FjKbofydNDXYSPte30LemI4mFxhes4vIyU
	 9egY+y8nY/x9HBzIXsHHBeJOTOreY+kQ+73hKC9PUbJ81UVT4UJgx1F+CTHFLo99pm
	 rPfH0P6Y9nFYnG8Lus0OI1ahk0FWVu9WN4GD78vKpazEmYSHHBxw3lfoSFzc0bLmNQ
	 w49gCcQl4xTYg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 06 Dec 2024 20:33:01 +0100
Subject: [PATCH v4 09/14] rust: hrtimer: add `hrtimer::ScopedTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-9-6cb8c3673682@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=7uXW0SpCswZ2a/a1jzmEzIBnEU4EedW+Z6gf3Sitb04=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVhERzRBc2N3SzhMMHQvbzRLelpKT1BFCnhQMXlta2lFWDk0a3kvMk90
 MFBPUFlrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRnd
 BQW9KRU9HNEdqNTVLR04zd2NjUUFMOEVJUC9kQnY2TVBwaGdyb3c1ajlXdFgyVkQrWENvSU9vYg
 pUeW4wYmVsVExsVWRwWWtiL2FFQ2FkcFhWSmw3MWtNZ3NETnVXOTg4VlVTeU5LcE9zd2I5K1dOa
 Upmc3pIYnE2CjZYUjRhMlhodkE5ellYdDFpeUNtdU9NeWtQR2xBMS9LT0xKVmpQOWF3TTNaRUp0
 M0cxMitGaXlOS3FRVWVxUGQKMkxreEsvN2kzWUhaTXN3dFRkcFI3RWozZGJKNG5qR0tOUUlCS3o
 raC9XQ2lxcURRRmlUVmJZcjNIbEt6U1B0RQo3UE5VUmdiWXFMdTBNN2FId0JXOWkvanlRUWQ5aG
 Q4cy85UmlmVnNLWkp6bXJaLzVPcm5GeTBISXhJbzQ3VUV3CnVvYkJuNTZ2c29VanJHZ1FZMVRRe
 VRUUUJXb0JKWlVpdlZhbVcrV0Fxa3o5NUFreWlqYW51cWdwWGF3SGZhdWcKRUxyUGZuTmplYlZI
 bVY1dHFnUVpEdHZPK2Z6Y25ZUXo1U1RHa1huRzNjWXJkSGpZYmV5WVJ1UThIakFSR3JlbwpsVDg
 rMXdKRWtUMTVXcVhPbnpDZGNuTjFiUHQwZ2dGc0s0VkdDdGNSeXFXTjU5NndVZVVJVFMvSHdwT3
 BNNFNnCkx5V3N4REFqRU1sN3NlQ3RMejFMT1FjL0ZBMFN3MUNEenZmMFJjT2pPL1VhMHZoeWpXd
 E1QVnV6VDhHaWVKTWgKSDFWZmVTcUdwK09lNjlCejVtbFljVXRVQVFWaVlKam9iUkl4dkIremxm
 T3NFU290WXNrSmgxQUxNRXUyMWFPLwpuNHVUdFBxK0ViQ0lFWjcyVEVXY2VhbnJ5aHdXY3k4N2N
 OYzNPeVJuNVg2bld1emwzcitwbDh1TnM3MDkwWFRPCmNRQUt0R3hheVhFcUFBPT0KPVVBMzMKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
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
index efcb5e44a0dc3660a09f230c01cca998b763e8d9..7835a33677ec32999c495d5b874ded2ff0786c9e 100644
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
2.46.0



