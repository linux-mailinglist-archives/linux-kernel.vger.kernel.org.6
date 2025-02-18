Return-Path: <linux-kernel+bounces-519517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5228A39DA7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEF8177EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063B5269AE8;
	Tue, 18 Feb 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh3EjmsE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E41269836;
	Tue, 18 Feb 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885323; cv=none; b=Ii0BfOsdmRYPhxSEpcjZsQ1M5GHUzsyvExwj8h7dSrtdlsiEiXpeqgNAiow6X1deF6k4y7hcrSehZTOF9M7gHnJzocpY2NtiJ5Oy7i50w1Jz6x8nDT1jAf9mx32qLAvjJ8K50wvite169YwibdNHp9LL1uoGV5K9W8GCFxA8rS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885323; c=relaxed/simple;
	bh=GeVoHgN4g9suu3ZWHUakKEFm2O49qSurYACSKMyug+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eH7gfIO6oz3vbjZGRwzk/VGowklGGMvoupGyYzON2iPf/F6ycSUQG/+022QGnXuxe4deqlBhEj8UDVCD+krOq0fefu4CD7wHsSELzc9ceT/q6hltKqIJStDlTPvlyMqlQFJPZilfqV7ws6l9JlM+Z973NbIqIU7q5FAtfm1C20U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh3EjmsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7ACC4CEE2;
	Tue, 18 Feb 2025 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885322;
	bh=GeVoHgN4g9suu3ZWHUakKEFm2O49qSurYACSKMyug+o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hh3EjmsEl5JBHcyhzSfib9DadqpWWMBhZhqpyS0rkgVx8Noyf1BV3VionZDhoXBIK
	 fEs4oxUAImFyaJ704bQRFdkiZGvjCc0aUYrMkH3anoGbczRL0AgwZph5gYm9bOppVa
	 IlgXS6jUfjH04uidz5ik0NDUsYqC+ua1A0w7cjcqSOSZOUqBi7MbZdTwwbxI/uPGJe
	 ZwtGpxMLiIVjTvUfFNvC0xm7mU+7bbgy0MB0/nBWYcAhyZZZ+aYZTLDmEUBZZR2dxp
	 xdGvcpdCtFko+EWK4xAXY2ypsQd0zu6Py2+XlrfpcrzQdU9zKw+k2tsYKBdPnJ/2An
	 3y5P2BxayxfqQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 18 Feb 2025 14:27:09 +0100
Subject: [PATCH v8 04/14] rust: hrtimer: implement `HrTimerPointer` for
 `Arc`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-4-48dedb015eb3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4076; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=GeVoHgN4g9suu3ZWHUakKEFm2O49qSurYACSKMyug+o=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIqyPSprRcDJC8rDFTSKiIRTWYQuo8q+38Q/e
 ghJGmX0yryJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKsgAKCRDhuBo+eShj
 d2mwD/wIQ7sSWSehJj2wttz7HaIe0AUXtOL9lqmvGay/UxadIjkAGikE7VXNoAL/UHvwqELnBPn
 u0w/IX/iG4hdva79x2hQ+gozcSiSFWYzJeoqDAQXZ2lxnj8NYkiq4pHY7iQfwut2xQIc253rwPm
 W6TMcpYSXIH3awsRRpAPYkGLuUCxthYnWOTVpyAe+n6q7YL3CJg5NvVyIOx/MucQmpvUdUIABoB
 wMru6KoXbZTBaU7t4e/VeyFiUW7b3N2TZyw678NIqRMDb+QojWHpRiJhIylJD+srgiLScYwL9Fy
 ZteyJYu6ELCyJsyIG4LuavLPw1/z6ULUfTphTkU96/bGq34DkeZwJFC7LUrT57+3ncfDvLc/tte
 5DTzKJnB3uv0VY6lQtjRoMYOD1FITHKUaPoue8YUhoLnWx9ohcVzX3ODJL9Ue/up9OF9KlOTRVy
 Wh0qKkvy7BCx4R3FAFCRdGglYOewg86jh4CcNvJnODrMjc7KW06B8ymUxoRwZ+Nsoxm5n83DXnY
 sgzy46QtyQcKZ+dNwbDmlhkmuNDR0gIuhf9tGxI/TOuKCI2XjE44XvXERLu0MjEBPeiJomEo7wK
 YjUzeXSjT1nb/1WzeDQcYtHkbf6TQ0mfE8YglNPTNIEVK+kku7C3uBUdqOHKhUYhxbbFNJxeEDA
 Fp6SYsa7Bt8tGNg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This patch allows the use of intrusive `hrtimer` fields in structs that are
managed by an `Arc`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs     |  4 +-
 rust/kernel/time/hrtimer/arc.rs | 89 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index a6332924efabd..b2a3130bc21d7 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -119,7 +119,6 @@ unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
     /// # Safety
     ///
     /// `self_ptr` must point to a valid `Self`.
-    #[allow(dead_code)]
     pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
         // SAFETY: timer_ptr points to an allocation of at least `HrTimer` size.
         let c_timer_ptr = unsafe { HrTimer::raw_get(self_ptr) };
@@ -310,3 +309,6 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
         }
     }
 }
+
+mod arc;
+pub use arc::ArcHrTimerHandle;
diff --git a/rust/kernel/time/hrtimer/arc.rs b/rust/kernel/time/hrtimer/arc.rs
new file mode 100644
index 0000000000000..d1c90631d0036
--- /dev/null
+++ b/rust/kernel/time/hrtimer/arc.rs
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use super::HasHrTimer;
+use super::HrTimer;
+use super::HrTimerCallback;
+use super::HrTimerHandle;
+use super::HrTimerPointer;
+use super::RawHrTimerCallback;
+use crate::sync::Arc;
+use crate::sync::ArcBorrow;
+use crate::time::Ktime;
+
+/// A handle for an `Arc<HasHrTimer<T>>` returned by a call to
+/// [`HrTimerPointer::start`].
+pub struct ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    pub(crate) inner: Arc<T>,
+}
+
+// SAFETY: We implement drop below, and we cancel the timer in the drop
+// implementation.
+unsafe impl<T> HrTimerHandle for ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    fn cancel(&mut self) -> bool {
+        let self_ptr = Arc::as_ptr(&self.inner);
+
+        // SAFETY: As we obtained `self_ptr` from a valid reference above, it
+        // must point to a valid `T`.
+        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self_ptr) };
+
+        // SAFETY: As `timer_ptr` points into `T` and `T` is valid, `timer_ptr`
+        // must point to a valid `HrTimer` instance.
+        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
+    }
+}
+
+impl<T> Drop for ArcHrTimerHandle<T>
+where
+    T: HasHrTimer<T>,
+{
+    fn drop(&mut self) {
+        self.cancel();
+    }
+}
+
+impl<T> HrTimerPointer for Arc<T>
+where
+    T: Send + Sync,
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<CallbackTarget<'a> = Self>,
+{
+    type TimerHandle = ArcHrTimerHandle<T>;
+
+    fn start(self, expires: Ktime) -> ArcHrTimerHandle<T> {
+        // SAFETY: Since we generate the pointer passed to `start` from a
+        // valid reference, it is a valid pointer.
+        unsafe { T::start(Arc::as_ptr(&self), expires) };
+
+        ArcHrTimerHandle { inner: self }
+    }
+}
+
+impl<T> RawHrTimerCallback for Arc<T>
+where
+    T: HasHrTimer<T>,
+    T: for<'a> HrTimerCallback<CallbackTarget<'a> = Self>,
+    T: for<'a> HrTimerCallback<CallbackTargetParameter<'a> = ArcBorrow<'a, T>>,
+{
+    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
+        // `HrTimer` is `repr(C)`
+        let timer_ptr = ptr.cast::<super::HrTimer<T>>();
+
+        // SAFETY: By C API contract `ptr` is the pointer we passed when
+        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
+        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
+
+        // SAFETY: `data_ptr` points to the `T` that was used to queue the
+        // timer. This `T` is contained in an `Arc`.
+        let receiver = unsafe { ArcBorrow::from_raw(data_ptr) };
+
+        T::run(receiver);
+
+        bindings::hrtimer_restart_HRTIMER_NORESTART
+    }
+}

-- 
2.47.0



