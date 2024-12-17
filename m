Return-Path: <linux-kernel+bounces-449455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7CD9F4F51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0B3170AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF261F8EF1;
	Tue, 17 Dec 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Appv1MRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6346F1F7578;
	Tue, 17 Dec 2024 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448812; cv=none; b=TjRe0TDmlNX+ktQWrxmj/S+jOCJG77gYbe5w8szRe1We+fl5Sdhlw1uM5IoR2ijkVhU3YHhnfhH1tJdD7C3GG+fNNjg+4J1ld7fd5XXKv12NwkCSZ4uQwGwjVPeU+g6aezkbMZ2yuYt/1B4bdqyCA2+5O8X8PIs43poG63DOIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448812; c=relaxed/simple;
	bh=NSSVkTUc0/NiyAMC9qyEk4jEQc+ziDX0UJOdfOpxgIg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PIACKVasC1wRTBuoLPHOWgIn7XoxEAFBogNvTDDv6VFKbqxlZCLZr/kkzoJgERS8bXlsHIEdbAHdjLqsOMRBKCbB8oNem3ZxU9rQfKjKLEaJFfxFO9cim6+aUBGhNdL/JIT8N9ZHo9U5wADEwZvC2mcqM03NQenUFjYM0hSyYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Appv1MRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D96C4CEDE;
	Tue, 17 Dec 2024 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448812;
	bh=NSSVkTUc0/NiyAMC9qyEk4jEQc+ziDX0UJOdfOpxgIg=;
	h=From:Subject:Date:To:Cc:From;
	b=Appv1MRtBVsNbBTTtbf2QKt5Jaj+z/HbCeZptyxoG7AI/bhDZcbxUAqMnI3QN+goO
	 jpdQXrc8NCpBMM1uhEwygzutOf7oOCn0WpVHO3usTGYdE9m4YDmX/F0X/FwRsyTHzO
	 caR2IWUIBPvPxAI3j5LpnOJ5flrIrC0vF+mvA1QeU+9++y2Tt5IuykujA0NOU+xeqi
	 MPbJlyFPcRjtR2GXqNz8TMH2x0fSQUrR3ymHl94ylrDBzkgvUp7FmeGuTWmfsJiy9W
	 0nRW1umeruV3SAn6VB5WHr9f6O83vHY9bo7ZXDaGwR+JlVcFxx0iUnulXZ31AWAIYi
	 LZHkbIe6ady2g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v5 00/14] hrtimer Rust API
Date: Tue, 17 Dec 2024 16:17:31 +0100
Message-Id: <20241217-hrtimer-v3-v6-12-rc2-v5-0-b34c20ac2cb7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAuWYWcC/3WO22oDIRBAfyX4XBcddVz7lP8offCWrKTrBl2kJ
 ey/12yhoZS8zRk4Z+ZGaiwpVvJ6uJESW6ppyR3Uy4H4yeZzpCl0JsBAcsY1ncqa5lhoE7Qh5UC
 LBwpcBY+Oo3En0tVriaf0uWff3jtPqa5L+dqvNH7f7kEmQTEjUcgBEFBLymme03GOq61X6+MQL
 uTuN3g4hmsA0MIMHMwIWnXJDlPKwS3lfLzEkuPH0McfU/yaz9/vwKgyVivvnJTB/qvIRwUYPqn
 IXkHvRi9QCxzhT2Xbtm9hUlmKbQEAAA==
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4232; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=NSSVkTUc0/NiyAMC9qyEk4jEQc+ziDX0UJOdfOpxgIg=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnYZYQCD3RNc2nrJdMDSVar9xTU+SKlr6nccNmA
 ylo/AILH2iJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ2GWEAAKCRDhuBo+eShj
 d7/iEAC2tV4H2UW/kD6rCXze2FOmV0mYt7aP3Q1UL/1lojfRJgU9e/AiWxZRjxNA0b5BAMZr/xT
 l440i7QDxXfUYPm5RiEovsU/1zqMHiStud9qgHvehDVByhyxE/B9TS/vBsDPY7PxyGGpt78L3RT
 tUNGcOWhwfxQAZCG5hKGGN5hs2RvNnHGj3j7ZaR9Q/JQ6Zzu2AmKh6CgaQFnMdbh9dLnzPty5uh
 SwzbmZynosplknzcuTUKt5IQ29LnQspuz5JVN63he4WFVvNg4OBFEGt9UXTNc2Sof99KsYeXRgV
 Fd/GNVoXw0KwqY8m/mHxE7z2O4A/fS4owOe3fzRw/rI0cwyWftor9sO1D31ylUCBpIcEqjEoth/
 tm6CyLGxebW1A5/U6WD7KNqtgKWGayqlnflwqdNqEyiQF4bbPUtrYXt9jNtGZgdpDuqpwwFk9cF
 WML4QStmF512PiUvz39UGLepE2hayVNcKL4oWNo6BBsO3QI6FnoANf9Ic+KUjN0rLBioV8bnQ1J
 WVIeaS84PHRtrFWXfiD8Oc8BG6ZHS3AtSZhkrJn/ukgDV3nAgNXhpE60wJUFFyj//cdVWP58fWi
 ZDG95aPrymJPKPm7QQMMBnhv4EYNuDCGdF0N36k+QyCjsW11CMbvJKaWlvOqFhrGbf4LLHTQPms
 gOqXpEbnYd5j2TQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series adds support for using the `hrtimer` subsystem from Rust code.

This version adds support for timer mode and clock source configuration during
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
      rust: hrtimer: implement `TimerPointer` for `Arc`
      rust: hrtimer: allow timer restart from timer handler
      rust: hrtimer: add `UnsafeTimerPointer`
      rust: hrtimer: add `hrtimer::ScopedTimerPointer`
      rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&T>`
      rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&mut T>`
      rust: alloc: add `Box::into_pin`
      rust: hrtimer: implement `TimerPointer` for `Pin<Box<T>>`
      rust: hrtimer: add `TimerMode`
      rust: hrtimer: add clocksource selection through `ClockSource`
      rust: hrtimer: add maintainer entry

Lyude Paul (1):
      rust: time: Add Ktime::from_ns()

 MAINTAINERS                         |  10 +
 rust/kernel/alloc/kbox.rs           |   6 +
 rust/kernel/sync/arc.rs             |  13 +-
 rust/kernel/time.rs                 |  10 +
 rust/kernel/time/hrtimer.rs         | 532 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     |  87 ++++++
 rust/kernel/time/hrtimer/pin.rs     |  95 +++++++
 rust/kernel/time/hrtimer/pin_mut.rs |  97 +++++++
 rust/kernel/time/hrtimer/tbox.rs    | 102 +++++++
 9 files changed, 950 insertions(+), 2 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



