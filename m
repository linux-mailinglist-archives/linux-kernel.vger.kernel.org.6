Return-Path: <linux-kernel+bounces-369820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D69A232A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BAFFB21852
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91741DE4FC;
	Thu, 17 Oct 2024 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApwFrYsc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DB1DE4F0;
	Thu, 17 Oct 2024 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729170565; cv=none; b=Si5A4CrBK2jx7mBsOs6Aymlh1m/wrKxEOX2jD+/YcmuZzxPf04NJ5e9x7YU2XYgq8yr0LjHcEBBj0Io/fkjeIGa+4KcVFIMIpuHZR6DZ31DKB2a2KnAAwXV/q4vIA3962S6NuF4/kcyCKtyJlfWsnhv+n52sPiEWAP7UlzOwrTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729170565; c=relaxed/simple;
	bh=s6jxjOVJp3+eEwOhixAxr/81JYIVMWQe/1u58mF/aqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jp2Tl3Jv+/EsRfynlHJAT51VRYPwaIyT5Pzw4JF3xXaAiJzz4WaaIcA7sOQV1ATlexv0dJZbpX6deQQaMxCGF48ElE7NgHf9j2KIYxzd9hK+nOooEKapY3gPnCbh/MAXJLzjNxvFWiFOofqFH0jiCrbXP9WVoiUABjcCICM6TOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApwFrYsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE7DC4CEC3;
	Thu, 17 Oct 2024 13:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729170564;
	bh=s6jxjOVJp3+eEwOhixAxr/81JYIVMWQe/1u58mF/aqU=;
	h=From:Subject:Date:To:Cc:From;
	b=ApwFrYscAHmMkC9tniVSpLxnPjk067ZFwWPkB7IVkb031NOEhZtCZOWIyDoqwYQKg
	 rvakxhvxPAsLx+KPYJUBUqB0Tzcm0qVj89iY4cWhXEQsSA/6ustWr5glldvC6XhCVs
	 mTh2C0ObE05VlaYWzBTmVayw9yCTiEVMX6/ORvzr+J2xB+y8BE4n74waXcWTPrIzG3
	 DODEw1BRQCanvBAAXa8jH4VG2BM0Gt4OJvz8E3rtMpXle1GGBMnGJsB+eGfGl87LKo
	 bM1srw40hnJNDIv+IGVc2i9cIw9/k3sslSveZqg77FodHLg4S5lPN4PJXf8/W45R4/
	 SEV3o3esrt8wg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v3 00/13] hrtimer Rust API
Date: Thu, 17 Oct 2024 15:04:27 +0200
Message-Id: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFsLEWcC/0WNS27DMAxErxJoXQomLUtVVrlHkYU/TEyklgPKE
 FoEvnsVb7qbN8CbeZnMKpzN+fQyykWyrKlC+3Ey49ynO4NMlQ015LDBALNusrBCaaF4QAIdCQi
 7afQD+jjcTFWfyjf5OWa/rpVnyduqv8dLwXd7DDaOuiY63zpLnnxwgJAWuSy89fnZj2ynh3n7h
 f6diIGIQhstUvyk0FWpt7OkaVj1fnmwJv62NZrrvu9/Wp356OEAAAA=
X-Change-ID: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf
To: Miguel Ojeda <ojeda@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2

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
Andreas Hindborg (12):
      rust: hrtimer: introduce hrtimer support
      rust: sync: add `Arc::as_ptr`
      rust: hrtimer: implement `TimerPointer` for `Arc`
      rust: hrtimer: allow timer restart from timer handler
      rust: hrtimer: add `UnsafeTimerPointer`
      rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&T>`
      rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&mut T>`
      rust: hrtimer: add `hrtimer::ScopedTimerPointer`
      rust: hrtimer: implement `TimerPointer` for `Pin<Box<T>>`
      rust: hrtimer: add `TimerMode`
      rust: hrtimer: add clocksource selection through `ClockSource`
      rust: hrtimer: add maintainer entry

Lyude Paul (1):
      rust: time: Add Ktime::from_ns()

 MAINTAINERS                    |  10 +
 rust/kernel/hrtimer.rs         | 530 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/hrtimer/arc.rs     |  87 +++++++
 rust/kernel/hrtimer/pin.rs     |  97 ++++++++
 rust/kernel/hrtimer/pin_mut.rs |  99 ++++++++
 rust/kernel/hrtimer/tbox.rs    |  95 ++++++++
 rust/kernel/lib.rs             |   1 +
 rust/kernel/sync/arc.rs        |  13 +-
 rust/kernel/time.rs            |   8 +
 9 files changed, 938 insertions(+), 2 deletions(-)
---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



