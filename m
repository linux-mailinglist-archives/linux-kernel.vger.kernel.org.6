Return-Path: <linux-kernel+bounces-550857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD93A56507
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1A188B1E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2A21639A;
	Fri,  7 Mar 2025 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCkKY6zZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC39E212FBA;
	Fri,  7 Mar 2025 10:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342730; cv=none; b=WchP9mNktZlebXEX/P2/z97r6kXJzr6gInjTzq9/ty/1OeGPH0s3yxderG5JuvoYhM+YdVboDKHtYKHoLJXZkB9LZEWQ9w1f8JlBcgx07tPWy3PPfR3ZUeccCfapEOn1ACEk+nthBfaIkRzuGLAmrBv9bYJfm4Nsft2o4GdDHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342730; c=relaxed/simple;
	bh=T6KOOXFxy3UMTrMhhUiOPICGLa/UPKpN1ZCfmB1gDS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+/wBvUSAelmiRHiRuYN792218Rz5vQ9mbd7VB2u1orGGKJ6oU2A5AeH5WieRgR0gilcIi5ap05HAAl+/Zo6l9ckQG0onZ9Hq09VAtM1oilraEtFzzKU2hqWAmsn/JQwmOFo50/wo/w8S2l1fH4XHozv5ZoGjmwWPZVTEcCFd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCkKY6zZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BF6C4CED1;
	Fri,  7 Mar 2025 10:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342730;
	bh=T6KOOXFxy3UMTrMhhUiOPICGLa/UPKpN1ZCfmB1gDS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dCkKY6zZKdL3EW2JvEspVfHI0zRUbHptE4QHhnk0TK5fbGLQCbVZgPi0FG6nxkYIq
	 hHexP3hZr0aG13kbfhW+Oxw7lT8nsqblAorLabeIf53vedclR6i8CiYOq+U2iKIrBx
	 W5GmoFlgqW7zR0SsJB9cTxNTqaPh7Q6Gmor6zv30Pkw+xCV1r7OG84aRf5XDCj6hRv
	 sn2ljxxN/HIQ2h5A36axL2Ksocl1/qhxR5L5KLL0D91cO0n0mb3wilZAhnKtKXVAs+
	 IGms1rK42tNFCAaDWxpQIc5Kpnmvm6kOrcE+JzyaHriIsUoErPhIITJCWXHGsq1/Jo
	 cbCIaSRABezEw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 07 Mar 2025 11:11:50 +0100
Subject: [PATCH v10 05/13] rust: hrtimer: add `UnsafeHrTimerPointer`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-5-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
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
 h=from:subject:message-id; bh=T6KOOXFxy3UMTrMhhUiOPICGLa/UPKpN1ZCfmB1gDS0=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZ6PjYY56f523hO8lLY8ro6ZU08Swet4wfS4
 f4fqsj5VYmJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGegAKCRDhuBo+eShj
 d/TrEACyjI6eJpJgbfjTfRV4c5FLe4meutvZUpqmHlEtBKuKxtSXNH6gorXxdXhEnPukJ5z20XO
 9GAfXe0iErI5MOuxXFDydqhb34DOuxNDRYKzM3O8AnYAbXq9PwH4KkqvcTa6J76uG80pKH15DfX
 4nqrAwqx7q8IwojNQJ9WnVOYN8kxp9ici3ope9e8940Khf0tINOZLrBjMqQVFWES4O+Vd2Jrvg6
 UdinKVpZZKCoVBcAtSu6OMxWxAijDOFdkoHAGWpuekZ9UPzHiHiEECiR28+6OH/5lHylQvQSdBJ
 Wl5MEpPntlEu6QTwHX8n3y7oaA773AmG9XeS5/m+kAkRrAP9LrcxrkbUXc/oKEEulDs90O4iJAh
 2NKTB+4vbB0+o3ERIT3FHEz3RjMUmm3dbgxDEPymavSQmJIkEaeQYKAdRaf2WD8q6KoTzKoEYsG
 2CwlNg29P+Y7ZDspk4mx+tRDUq0rNIBXU+jHLal8gxwTBIuUrisC2zJpkPBmdpZFqVj5+vQxTy7
 V6NIFThhzII2JA4PpQjcesLIkpqrTttoQEPQ5Az6mFRxJpR+K7X+om7Ska0nXcAZ9NhOHPs0M8T
 uEvRS71pOD46jMfMGG6fyz2Q4nKHv2OqtURwJpZ9TFvivz8qMbPDKKhvY3t9ZAuWu6cL2tIgVT+
 roOg7DFC3HhZY2Q==
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
index 7317ba4f71c4..1fe25c271e0d 100644
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



