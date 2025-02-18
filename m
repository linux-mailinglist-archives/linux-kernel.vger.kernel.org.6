Return-Path: <linux-kernel+bounces-519512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F727A39D82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5F11886C68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE46B26D5AF;
	Tue, 18 Feb 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grx3FH3N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A24269CE3;
	Tue, 18 Feb 2025 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885303; cv=none; b=dg5i9/OJdw15pU8S1Oj6d+4AM2H4IopZtutVHaEkwbSkCmkJz3KbP/yo4/3QFSK5KCjL7jYUs6vZQGAz7oHWVxmXZLbw5q5mxYz1KEWO7/iD9RFI4PTp7z/tYQCV/shqG0UYXKVozE3tPLJniQ11np67iy009qEeeN7/zcGJW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885303; c=relaxed/simple;
	bh=3Ft4pTQRAMp8Q2HQW1M4IOo3tvpqkrYGalc5YpRcw+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SbbCPrLjTOnZmcDFhSToPVYoV487pn/O8SFr2KOL8Qnx1wTFiBKPm7IrobdEvUGQhrQoc4Uz2CSJOuUs47yQFY32YxZgPduVKlTuCsy5HaUWCRGGp7tjgf4clQBdSA8UO0b+j4dC6Kz2kbXm6/P1Gr0SwtDQR4hv01Hq/NyhxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grx3FH3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D80BC4CEE2;
	Tue, 18 Feb 2025 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885302;
	bh=3Ft4pTQRAMp8Q2HQW1M4IOo3tvpqkrYGalc5YpRcw+c=;
	h=From:Subject:Date:To:Cc:From;
	b=grx3FH3NMiLYvvz5QJHXtuakj2T1YjPOi005TsOwyIVBu7M1tY2wfsSONXgK2Hsyg
	 Jb7FWvJiAHxvZZTRW6BcKn4mVj1ADwghiFjsPyy6UnmnVY0OLdh8xw9KuKNEqRkCj4
	 1f0k8KTeX95j4kg52LQjLrtKQq7OduZLTtIk0Q5CHgsjV77APpjX+L3bzc8LtfrHDm
	 h4Ft+LdHtQRjz9I6mk5OuMPHhgqpK85RAxFv55Z9H0NoaTliqDl+U//rum8Cj50yW4
	 ip12FyjVFCz/M/YT5ORDKmYOqXE6rqwmo7LH6GXxAFkvCzg3KrMOiP5nBgLzqM2wuB
	 s2ASVfY8HQrBA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v8 00/14] hrtimer Rust API
Date: Tue, 18 Feb 2025 14:27:05 +0100
Message-Id: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmKtGcC/3XSQW7DIBAF0KtErIsFAwwmq9yj6gLwOEap7RS7V
 qsody9J1KZV6h0f6T9GGk5sopxoYtvNiWVa0pTGoYT6acNi54c98dSUzECAlkJa3uU59ZT5ovi
 CXALPEThI00QMEl1oWakeM7Xp48o+v5TcpWke8+f1lUVebq+g0GCE06h0BQhoNZd86NOup9lPR
 x+pag7s0l/g3nHSAoBVrpLgarCmlHzVpaEJY97vDpQHeq3K8dZUP8318UsQ3DhvTQxB68Y/KPq
 ugMAVRRcFY6ijQquwhgfF/FJWZzFFCUpHED5CDPZBwW/FCCnFioJFaa1sjGgl6n9msXcFhFpRb
 FFk7aTWFoxy7o9yvi0609t7+Tbzbdss+Il4HPs+zdsNCKmjM76lSKTIYvTaG3QGvVNIoKBWrTC
 hYOcvOOmvWYsCAAA=
X-Change-ID: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5620; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=3Ft4pTQRAMp8Q2HQW1M4IOo3tvpqkrYGalc5YpRcw+c=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBntIqrvuVHsYrSZpcigQSxCPkZxazxAX0Kbsiou
 hXTChgCQt+JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7SKqwAKCRDhuBo+eShj
 d50GEAC8V6IGVBbJWUhjOGKx6xeuBHN/VL/QJW9jrLfyaqOMkjhr8c3bwxtndFF3TRMlWEpF8jB
 jIRwiE/HR9CwXIrfAU+1b1A5zFQp5LR9lywUgAc3mTrUGxkNh8J3DRCgTJB69ns/qfpxoldK0QE
 G8mlkog7c7N8SjwvFQ3XuzRz+tqk5mw+4RXWIFJu4ur/ZSQeHKe+PmBIb7GZATP5wQo+lS5YcmQ
 OKvzXpdOgkArC+PSFR84xiLZqNIztcIf0gQDQ0XpBQ7muYb2wlEK0opOiI/kZ9/p2q+G+n/MF4f
 kqMfGEGFxLeoUgm4oFNoXru07fekyTXqUre6ilhxY2DK1W5o0xvgikfRK8QEFpSJD6rTU77kGkQ
 D/tIoVCrwAvKPlHwedLYL4UGBGCxJ4WR/QVVGAWESHAeXy4gHL1JQV0PEDzu8aW3iKmqgNjQcr7
 57CCnQ+hA0OdlKAm9Q26juSyK98MDuFVm1nFPVouABqHTAlN1Bw73mIN7JJwqX4773nx6EvGo9D
 w5rGSOiTopcNgXC7C3eGK+rPjmN9v+s+CyFyWWNqsso6YTXpDSub6uEwY2p8VJIvv0nY/sHPit7
 cWwoB5UUCwoUv5rRFpUOf4B+JRPlNR0DjQbPSWScwcMVOgZiM1FXkbO8CUJ47sWQaaFl+lID1q+
 Etb7a1buH18e3dA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series adds support for using the `hrtimer` subsystem from Rust code.

The series adds support for timer mode and clock source configuration during
timer initialization. Examples and functionality to execute closures at timer
expiration has been removed, as these depend on either atomics [3] or
`SpinLockIrq` [4], which are still being worked on.

This series is a dependency for unmerged features of the Rust null block driver
[1], and for rkvms [2].

Link: https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git/log/?h=rnull-v6.11-rc2 [1]
Link: https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-wip [2]
Link: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/ [3]
Link: https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/ [4]
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v8:
- Publicly expose timer handles.
- Link to v7: https://lore.kernel.org/r/20250203-hrtimer-v3-v6-12-rc2-v7-0-189144725399@kernel.org

Changes in v7:
- fix a typo in commit message for "rust: time: Add Ktime::from_ns()"
- fix a typo in safety comment in `HrTimer::new`
- fix a typo in `HrTimer::raw_cancel`
- fix a typo in the vocabulary
- fix a typo in `HrTimerCallback` docs
- refactor module documentation
- add an ascii state diagram to module documentation
- specify reason for adding `Arc::as_ptr`'
- change `boxed` to `this` in `Box::into_pin`
- change `from_ns` to `from_nanos` to align with std
- imporove safety comment for `impl Send for HrTimer`
- remove useless paragraph in docs for `HrTimerPointer`
- rephrase docs for `HrTimerPointer::TimerHandle`
- update docs for `HrTimerCallback::CallbackTarget`
- explain how users should use safe functions for cancelling a timer
- rename generics for consistency
- remove a note about storing mode in `HrTimer` - this is still required
- rebase on v6.14-rc1
- Link to v6: https://lore.kernel.org/r/20250110-hrtimer-v3-v6-12-rc2-v6-0-f71d50f16482@kernel.org

Changes in v6:
- prefix all hrtimer related type names with `Hr`
- add a few links for type names in the documentation
- Link to v5: https://lore.kernel.org/r/20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org

Changes in v5:
- Fix a typo in `impl_has_timer`
- Implement `Box::into_pin` in terms of `impl From<Box> for Pin<Box>`
- Link to v4: https://lore.kernel.org/r/20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org

Changes in v4:
- rebase on v6.13-rc1 and adapt to kernel `Box`
- add a missing safety comment to `hrtimer::start`
- use `hrtimer_setup`
- fix a build issue when `bindings::hrtimer_restart` is signed
- fix a memory leak where box was not destroyed
- fix a documentation typo
- remove `as` coercion at multiple locations
- use fully qualified syntax when invoking `deref`
- move `hrtimer` into `time` module
- Link to v3: https://lore.kernel.org/r/20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org

Changes in v3:
- support timer mode selection
- support clock source selection
- eliminate `Arc::clone_from_raw` in favor of using `ArcBorrow`
- make `Arc::as_ptr` an associated method
- update safety requirement for `ArcBorrow::from_raw`
- remove examples (pending `SpinLockIrq` and `CondVar` patches)
- remove `start_function` (v2 `schedule_function`, pending `SpinLockIrq` and `CondVar` patches)
- change function naming from schedule/armed to start/running
- add vocabulary to documentation
- update safety comment in `Arc::as_ptr`
- Link to v2: https://lore.kernel.org/r/20240917222739.1298275-1-a.hindborg@kernel.org

Changes in v2:
- use a handle to own the timer callback target
- add ability to for callback to reschedule timer
- improve `impl_has_timer` to allow generics
- add support for stack allocated timers
- add support for scheduling closures
- use `Ktime` for setting expiration
- use `CondVar` instead of `AtomicBool` in examples
- rebase on 6.11
- improve documentation
- Link to v1: https://lore.kernel.org/r/20240425094634.262674-1-nmi@metaspace.dk

---
Andreas Hindborg (13):
      rust: hrtimer: introduce hrtimer support
      rust: sync: add `Arc::as_ptr`
      rust: hrtimer: implement `HrTimerPointer` for `Arc`
      rust: hrtimer: allow timer restart from timer handler
      rust: hrtimer: add `UnsafeHrTimerPointer`
      rust: hrtimer: add `hrtimer::ScopedHrTimerPointer`
      rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&T>`
      rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&mut T>`
      rust: alloc: add `Box::into_pin`
      rust: hrtimer: implement `HrTimerPointer` for `Pin<Box<T>>`
      rust: hrtimer: add `HrTimerMode`
      rust: hrtimer: add clocksource selection through `ClockSource`
      rust: hrtimer: add maintainer entry

Lyude Paul (1):
      rust: time: Add Ktime::from_ns()

 MAINTAINERS                         |  10 +
 rust/kernel/alloc/kbox.rs           |   6 +
 rust/kernel/sync/arc.rs             |  13 +-
 rust/kernel/time.rs                 |  10 +
 rust/kernel/time/hrtimer.rs         | 539 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     |  87 ++++++
 rust/kernel/time/hrtimer/pin.rs     |  95 +++++++
 rust/kernel/time/hrtimer/pin_mut.rs |  97 +++++++
 rust/kernel/time/hrtimer/tbox.rs    | 102 +++++++
 9 files changed, 957 insertions(+), 2 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



