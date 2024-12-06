Return-Path: <linux-kernel+bounces-435533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44B39E790F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF7AD161340
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330521B198;
	Fri,  6 Dec 2024 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDjspctc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D481DE2D8;
	Fri,  6 Dec 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513745; cv=none; b=E6SYOr+Iwic3fT76UTL9PAKRFQUx258A/AK0uPmfDWsOw88FwZfAKPpbZPI+xBsmjaJv1mnHbpVxtN2RCTawWTUxmPuHP3mse4hJZu+0jgmm7gmdfRw0YmoV+aNKz7o+uSPnTCvGzP9B98y7cW1peP8BWk8COFOGGixcs+HslCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513745; c=relaxed/simple;
	bh=7UU+ipOMOuiJ8xkFahl/xso1Cc0+gYatVlSHOevXJqs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tuvUv/eLwmjGp+sm189kxh57nUXIfQRwqLaR78yKjwAciov+fvdvx2j0teVGgj/l4BeznbF2Sq3Yj9ZndqeiYw3eTbfLdD1XN7lhoMHEMNCyrE3lChXCmMyGv39n51W9O52B/CPuPv2brE4yef0Ek+ZuJ3i0GOT/X5MrUi8MA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDjspctc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017C7C4CED1;
	Fri,  6 Dec 2024 19:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733513744;
	bh=7UU+ipOMOuiJ8xkFahl/xso1Cc0+gYatVlSHOevXJqs=;
	h=From:Subject:Date:To:Cc:From;
	b=sDjspctc2KUDG5ZKwZGaoUt3k99bN9YCGY1zzorV+q98ZQUkwVpswoRVnEsRp8dYc
	 +VFTyirymNJPpsVzm5VoGMWQwSo1yrQ2CzaS+KuYfhKHr0LPVK1WpPghBO8w8uS7iM
	 4SpxuxXeu+AoIx3/H3pLy+RFtEl6YlEmt1w+ACLenwMsJIfo4MOAc3tDn1+lIPWICy
	 cSM2sPOjaiL550HSw5iXFr41E4ia8MSUWDLp6LPLFx1v9mUhq8xDmieSAd++mninpI
	 Z+tkFOZvegpx2WzOMkWWjVw9jJ1XJU60+6jsEBV4J/TP5oQcsZ7bbwxkj7S0KjlIg8
	 Sx3rY5YO2L5fg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v4 00/14] hrtimer Rust API
Date: Fri, 06 Dec 2024 20:32:52 +0100
Message-Id: <20241206-hrtimer-v3-v6-12-rc2-v4-0-6cb8c3673682@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGRRU2cC/3WOy27DIBAAfyXi3EWw5lF6yn9UOWDYxCg1jsBCq
 SL/e4krteqht52VZnYfrFJJVNnb4cEKtVTTkjuolwMLk88XghQ7MxSopJAWprKmmQq0AZoBiVA
 CAkodgxmlceOZdfVW6Jzue/b91HlKdV3K536lyed2DwqFWjhlBsXRoLEKJOQ5HWdafb35QDxe2
 dNv+Os4aRHRDo5LdK9odZc8n1KO41IuxyuVTB+8j9/m8GP+/34HAdp5q8M4KhX9n8q2bV9vQ3h
 RJwEAAA==
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
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4009; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=7UU+ipOMOuiJ8xkFahl/xso1Cc0+gYatVlSHOevXJqs=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb
 mtvWTNjQnl5WmlBR2RUVVdqQ3JFZnZCRFdaVm1oV3RsSUs2UnBDCjM3U1BQQisrSk9ORGdObzRD
 dlFVN0lrQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKblUxRm9
 BQW9KRU9HNEdqNTVLR04zZWhVUC8yemkxYWtVZVJFYjZGMmcrWTlFVitPSlpvOHZRb3ZGbUp0dA
 ozaExqR0dlTXBtclhrVkx4WlZxWXlramZSd1pUK1ZleGNYUDl3WkJqKzRVb1pDbWpoRjA2RHZjM
 EYxaGdWNU5jCnU5bmF5ZWVXbnNzSWh2blVZYmg1WVZVTEFSL01xZ0hDSFBteWRyZVRMU2QvRklP
 eGs2UDRKOTZwZllUTzlRTUgKandLOUljOGhtMmpsRi9wOVlkeE93NW9KMFIxVUxkTHNBL2hEVHp
 qMndaTXlBbm91UFpMOHI1TmQxMmpkdTJZTwo2NHdSN3VXN2NOclRuZXZhWVZkY1o1aTNlcEtuQ0
 ZsbXNVTzVuWGFmcEp1L1BjUWk4azNVOCtwR3RyVm5ZR2VYCmQwV3FlYUJTZ0VhTmpGWnc3QVd1Z
 3l2M3pLTHFydVRJY3grdSt4cnRaUWduSkZ0WjVVTVVEK3lqZzFSR1k0Z3YKbHk3ZGxPZ1ZSZ1ZX
 akVEWE1nSzdMWTlWU01ORC9Md2ZQc3BzbHFjQldnQUg5NjFpeDVYOVJYU0hodVBpZUVxdwo4akk
 waytyYTBOSEtzOTMyNEpzbzdUN2dPYVNCVG5vczlZTzJFSW9HTDlldnp3Z3ZaSmxaelIzbFlHZ3
 NQL2NlClVyOElCL0pPNXZBWURyWVF0Mlh0VnUzVWhjaC83Y2JDSGZwODJtMFhteSt1MWh4WGptV
 XlNeGJBM1FBd3lDMVkKQVcwZnU5WmI2YlBtT1AzMnBYZytDRnJxK0FqaGp5MG02U0hBdUx0VDBQ
 eEFtL1ZuYllmU0w1OHpvS2hnWWJaYgptQlVqT3M4V0h1OEFtMmd6L3BOSGVDbTl5WXhURjVFSyt
 nMXBnYVlhZ0Zka1I4UUlNQ3FPeXFlNFRRT1htNjRnClNvZVIyZ290NzVBb01RPT0KPXNzQ2sKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
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
      rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&T>`
      rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&mut T>`
      rust: hrtimer: add `hrtimer::ScopedTimerPointer`
      rust: alloc: add `Box::into_pin`
      rust: hrtimer: implement `TimerPointer` for `Pin<Box<T>>`
      rust: hrtimer: add `TimerMode`
      rust: hrtimer: add clocksource selection through `ClockSource`
      rust: hrtimer: add maintainer entry

Lyude Paul (1):
      rust: time: Add Ktime::from_ns()

 MAINTAINERS                         |  10 +
 rust/kernel/alloc/kbox.rs           |  10 +
 rust/kernel/sync/arc.rs             |  13 +-
 rust/kernel/time.rs                 |  10 +
 rust/kernel/time/hrtimer.rs         | 532 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     |  87 ++++++
 rust/kernel/time/hrtimer/pin.rs     |  95 +++++++
 rust/kernel/time/hrtimer/pin_mut.rs |  97 +++++++
 rust/kernel/time/hrtimer/tbox.rs    | 102 +++++++
 9 files changed, 954 insertions(+), 2 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



