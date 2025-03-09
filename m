Return-Path: <linux-kernel+bounces-553196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A274AA5855F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DF867A4098
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CD21EF38D;
	Sun,  9 Mar 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8P4e8c7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450D91DEFCC;
	Sun,  9 Mar 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533827; cv=none; b=Fjqkdoee6ifHnC5CEN8Cgn2XVoBfmEFEd0zyzxXTtjsm6pOVat7ElaOJIU6Bvrew762R3hXJXTpvyQc1M2GfEYOA50KhkKIeYiaubw15SHA4zFK4+ZznI43sm1wZk7B/8vjT4kuZCZe7JAwx/6gqYxLBYUrOIACCfn2rueA9qxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533827; c=relaxed/simple;
	bh=HSLjqfjdBIhaXMsLbsdst2hy06e5MEpZKeMpRKHgG8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwpXEoRMztnMAzHJpLGXMAlOm6GIRRIAJuVZBQ+UGq4q54kMC7Aok1cxzXoFZKYc4cyf0XC1y8NbjlPUWOsEUbN/Ggs+70m9OuVPLbZdb6DLfaISo2IBVx2nmrmvGmKGjAekgbxFS/4vYAUlN1hprx5Nri8fNC8LsyZxcTdB5mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8P4e8c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E90C4AF09;
	Sun,  9 Mar 2025 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533826;
	bh=HSLjqfjdBIhaXMsLbsdst2hy06e5MEpZKeMpRKHgG8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e8P4e8c7OtuLO8GpGUcaTxqibQMveaq3ZnfA7WxzgUSM4xQ0hg69D07RZARUDYuqi
	 HBlP72aJtrIW72AHEM9yEf8aiIP2S/je1lgIEsusPed7TeCph9imTr9EVPGQGF+Wok
	 Tz1gV5ACH0suNMfxvVEAfu+zFFJdl1mGDfdeooea1YYFJNaHz/ZZtKYFZ4tEyZiDXC
	 GFo+EalkVbrcbWv9OdNsnkyvEcUk0rmgwPdP1XSx7MvAGg+Kx290KWTx1J3YNE6Hxv
	 e1NgP42+ekUS+WvZccksp4gRUMp6eTkoL1YVSvcgpFs2EtbzA07VmOaFLsukE1U3u8
	 Fmhc10E6ZzLkA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Sun, 09 Mar 2025 16:19:02 +0100
Subject: [PATCH v12 11/13] rust: hrtimer: add `HrTimerMode`
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-11-73586e2bd5f1@kernel.org>
References: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
In-Reply-To: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5724; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=HSLjqfjdBIhaXMsLbsdst2hy06e5MEpZKeMpRKHgG8U=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFxgdVUI8t3tDsgFgU1BpO34+SPpbGIikJj9
 3m1TsLERTGJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xcQAKCRDhuBo+eShj
 dxPhD/0bBQhSlw8P4a8Q/M3fsnN0UsB4HXRV8x3KVK3dg632NQPAUNC7fpFA/Psp4sRj1vQ/3Vt
 B/5m0oh/+Z50IpR33NTIMaTMiTletYB0BDFDR1I+9N8+Z4SsHRSbcysmvCdJYSJkha5PXMRbvLr
 328NrIz2XWmhS28pQ6/+VoDyA+QaaPFJs7Woiksqkk3vSwV84v+F+dVQC1P+NZ5T61M2f0E9zBe
 zoDNzw/l1jmgH8U0++UQj6S4ye7LkQivuVQ9h2/+wGFJOqQjTX6PWg59l92WYmpXpcIJ3p7kUee
 +L16VUgpq3+8fQ5SgwC+Zi8Wyf27z1Ku8krKooShRg2GslJ43T8zYUDqs4RyHFRye7ERndCsio1
 iFKvu40bo6un8onHcOua/KK8PJvM8wfKxGf3chDAZnWUjZ80HWmEqS/GjC9IdtMnqWcrzA5o5OM
 WKzqrDKyhLP/3XE1R+qFSCd+QgfeA7lIuPj18YsPwyhy/kzMBsMISURU5Kuetoy5p5AIi2Z9L4b
 8a/alOu18wkWwxnrlTs7ohrt7Zkd45f3VtkETwE46lFBpKw+jqwq9iXkBAqTTPTSVhcQJp1Eql8
 T9DnmZuCi/+Ni3Cxw0JHFtucjW6XR9S6NNG+4GgygtVM8p6zz8YBVKQqhPtlJM8cGhLAPfubTLT
 CtviW1HnorosHmg==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Allow selection of timer mode by passing a `HrTimerMode` variant to
`HrTimer::new`.

Acked-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/time/hrtimer.rs | 82 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 2436f04d02c7..9dde7ec14619 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -80,6 +80,7 @@
 pub struct HrTimer<T> {
     #[pin]
     timer: Opaque<bindings::hrtimer>,
+    mode: HrTimerMode,
     _t: PhantomData<T>,
 }
 
@@ -93,7 +94,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
 
 impl<T> HrTimer<T> {
     /// Return an initializer for a new timer instance.
-    pub fn new() -> impl PinInit<Self>
+    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
     where
         T: HrTimerCallback,
     {
@@ -108,10 +109,11 @@ pub fn new() -> impl PinInit<Self>
                         place,
                         Some(T::Pointer::run),
                         bindings::CLOCK_MONOTONIC as i32,
-                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                        mode.into_c(),
                     );
                 }
             }),
+            mode: mode,
             _t: PhantomData,
         })
     }
@@ -370,7 +372,7 @@ unsafe fn start(this: *const Self, expires: Ktime) {
                 Self::c_timer_ptr(this).cast_mut(),
                 expires.to_ns(),
                 0,
-                bindings::hrtimer_mode_HRTIMER_MODE_REL,
+                (*Self::raw_get_timer(this)).mode.into_c(),
             );
         }
     }
@@ -392,6 +394,80 @@ fn into_c(self) -> bindings::hrtimer_restart {
     }
 }
 
+/// Operational mode of [`HrTimer`].
+// NOTE: Some of these have the same encoding on the C side, so we keep
+// `repr(Rust)` and convert elsewhere.
+#[derive(Clone, Copy, PartialEq, Eq, Debug)]
+pub enum HrTimerMode {
+    /// Timer expires at the given expiration time.
+    Absolute,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    Relative,
+    /// Timer does not move between CPU cores.
+    Pinned,
+    /// Timer handler is executed in soft irq context.
+    Soft,
+    /// Timer handler is executed in hard irq context.
+    Hard,
+    /// Timer expires at the given expiration time.
+    /// Timer does not move between CPU cores.
+    AbsolutePinned,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer does not move between CPU cores.
+    RelativePinned,
+    /// Timer expires at the given expiration time.
+    /// Timer handler is executed in soft irq context.
+    AbsoluteSoft,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer handler is executed in soft irq context.
+    RelativeSoft,
+    /// Timer expires at the given expiration time.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in soft irq context.
+    AbsolutePinnedSoft,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in soft irq context.
+    RelativePinnedSoft,
+    /// Timer expires at the given expiration time.
+    /// Timer handler is executed in hard irq context.
+    AbsoluteHard,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer handler is executed in hard irq context.
+    RelativeHard,
+    /// Timer expires at the given expiration time.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in hard irq context.
+    AbsolutePinnedHard,
+    /// Timer expires after the given expiration time interpreted as a duration from now.
+    /// Timer does not move between CPU cores.
+    /// Timer handler is executed in hard irq context.
+    RelativePinnedHard,
+}
+
+impl HrTimerMode {
+    fn into_c(self) -> bindings::hrtimer_mode {
+        use bindings::*;
+        match self {
+            HrTimerMode::Absolute => hrtimer_mode_HRTIMER_MODE_ABS,
+            HrTimerMode::Relative => hrtimer_mode_HRTIMER_MODE_REL,
+            HrTimerMode::Pinned => hrtimer_mode_HRTIMER_MODE_PINNED,
+            HrTimerMode::Soft => hrtimer_mode_HRTIMER_MODE_SOFT,
+            HrTimerMode::Hard => hrtimer_mode_HRTIMER_MODE_HARD,
+            HrTimerMode::AbsolutePinned => hrtimer_mode_HRTIMER_MODE_ABS_PINNED,
+            HrTimerMode::RelativePinned => hrtimer_mode_HRTIMER_MODE_REL_PINNED,
+            HrTimerMode::AbsoluteSoft => hrtimer_mode_HRTIMER_MODE_ABS_SOFT,
+            HrTimerMode::RelativeSoft => hrtimer_mode_HRTIMER_MODE_REL_SOFT,
+            HrTimerMode::AbsolutePinnedSoft => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_SOFT,
+            HrTimerMode::RelativePinnedSoft => hrtimer_mode_HRTIMER_MODE_REL_PINNED_SOFT,
+            HrTimerMode::AbsoluteHard => hrtimer_mode_HRTIMER_MODE_ABS_HARD,
+            HrTimerMode::RelativeHard => hrtimer_mode_HRTIMER_MODE_REL_HARD,
+            HrTimerMode::AbsolutePinnedHard => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_HARD,
+            HrTimerMode::RelativePinnedHard => hrtimer_mode_HRTIMER_MODE_REL_PINNED_HARD,
+        }
+    }
+}
+
 /// Use to implement the [`HasHrTimer<T>`] trait.
 ///
 /// See [`module`] documentation for an example.

-- 
2.47.0



