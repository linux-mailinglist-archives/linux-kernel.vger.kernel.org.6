Return-Path: <linux-kernel+bounces-553186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E7A58554
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03EC3A4701
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DDC1DE8BF;
	Sun,  9 Mar 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCJOO/i8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC31C5F1F;
	Sun,  9 Mar 2025 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741533741; cv=none; b=CWgyq69fgzEXUuDSNoT3SiPnv331eDlYwySTZosvvr636tLtkLkmer1270aak4k/x0NolvBFUoQ4e/fqzAyiZJ2I3Glb+Kphg7zW5uPc+qfIYxXfcOUY5Y0Z/1b62h2As7FxqPPWgHUn6fH7HnnCOCzp70PX8EcvRQ/aP/dKBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741533741; c=relaxed/simple;
	bh=QRJ7QTG5yNt6evMXhX7ixdnIHqL692llSEHd4bfPaIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tuYa9WfJN0BcMPsoutWHch8BTT6bgdosE2e6WmXqiM0vu3IBkmCTahgAvS5tfrAIy67ccsQMuho3ZKXV7l9YYCp6//7eM2ZMDt1IhvUWtymwFmCAQ1LNCepfgvxNQUuWztl0cbEbpjxGDYHWR5XE5Hi6Ed5VMKDnw2h7sr6Go2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCJOO/i8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11332C4CEED;
	Sun,  9 Mar 2025 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741533741;
	bh=QRJ7QTG5yNt6evMXhX7ixdnIHqL692llSEHd4bfPaIQ=;
	h=From:Subject:Date:To:Cc:From;
	b=gCJOO/i8nC+GVGSV/WYJhQM2CZmpwD/QiLwU/hlLYbmISumcMobY3Upwc8jRMXGe2
	 551bqpprBzZXn1TbtpUfGPWg9L7K3TJxdWJZx3BpwAS7YEBYPMpd4JFE9U+xn77FLk
	 +9MIk6k76PKTjZiNqDeo8qjkHOW8HlwnKPkoTu0NFR7CovB0ePXUSicI4sp768I11+
	 FlW1DQuspEkooQgc7wZULxA5z9u8CIvGNJ4drSG25tpwGdBlq9R0NyuM6Q4p98DZOC
	 GAC1BUMHSFzp3WEXoS+QXgZVpVXvav0uVuG5niYF2Oc2ap0ynfRfFxsOCmW2/JFudl
	 gOuqHBn/umnnA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v12 00/13] hrtimer Rust API
Date: Sun, 09 Mar 2025 16:18:51 +0100
Message-Id: <20250309-hrtimer-v3-v6-12-rc2-v12-0-73586e2bd5f1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFuxzWcC/43TzW7bMAwH8FcJfJ4MkaIks6e+x7CDPuhG6OJ0s
 mdsKPruUxJsyeAZGHQxBfx/omTwvZulFpm7p8N7V2UtczlPrQD8dOjSMUwvokpuGx1qJNDg1bE
 u5SRVrUatTgGqmlAh2JxcBMdx7Fr0rcpYflzdz19afSzzcq4/r8escNm9gprQaiZnqEeHzpMCN
 Z3K80mWML+FJH1+7S75Fe8ZBo+I3nAPyAN620KhP5Ypx3N9eX6VOsnXvn3ekuZPcr/9VmhlOXi
 bYiTKYaPQXUHtdhRqiktxSMZ54wbcKPZB2e3FNiUaSqhDwhT9RnG/FasB9I7imjJ6yFaP4Ogfv
 fi7gtrsKL4pMDAQebSGeaMMDwoMO8rQFBqy5KjBSjQbhR8UpB2FL/8oZhNHncSltFFA3xmj956
 3vVhbafTCxJADbR34Lwea49lQkDE75r9v9XEbgirfvreZWm6T0MUwi0rn06ksTwfUQIltGCWJG
 PEuBQrWsXWBjRM0OJhR29iwj1+oTD4YqAMAAA==
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
 Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9031; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=QRJ7QTG5yNt6evMXhX7ixdnIHqL692llSEHd4bfPaIQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnzbFiXfyS+TVncB9enLq4fV5i2ZvjZohvl1Ant
 26L6sRhtsyJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ82xYgAKCRDhuBo+eShj
 dwO0D/9Hsha3m0DspN9LL+WlLu+K+pqjPFZgtA9/7ZuVOPjzegKqmluzAGMaUvpduRHXVwiqwvN
 s/3xXaie3fsl8S36Y5IO46ykLt1cWvzh6h/i2s0PpkSFGZFFcl7b2JZCVXH8nC+p5rcXgv80gVh
 UrrZ7Q81okoqEHdCeRs9TgSjtbGvey/MQ1L0oe8pUJhU5DUG48eVXj7ADLItkn5/Be+MlR1dikx
 YF/5pgQUWke6Gpwne9mIbL/+k/CgphNSnCjsgHEuk8TJulauzdAUFSPF5eDl71tX+plRklcEI94
 LROyVWqCurzQOZDno8VqxLzLpPqImZARgfhw7YAe3/A6CAY6Lq66miSGxckXfTV86u+3JNsT8Px
 hjXwpNYsMU4SWl1lIqMvh0ebNdyykyDUz3lWmGfnOhYtb+BeXJq21uQBYc+4GATE3CoCiCfbL96
 O+BAwG6Zwwb45ybOnJV0H9Oc/59HrNXE/2o3Uo6WLEHeNHKrGmn8JU0mkevRoDMHBWdwPvaaEZi
 V6VUW3q7UufCUsv09uHF5MDGBJT1HLbqLINST/RWmRiF8MT0wgUJltaNr6aLv+kEpCjQe4peNvs
 E2sMsQu/u+Mete8CeibEdwfDA45CME9JBWRU05TffYZIJwTRZMMHBw92J08FK4ISsME6yMvuzmw
 X9YhGAt7//X6nuQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

Add support for using the `hrtimer` subsystem from Rust code.

Add support for timer mode and clock source configuration during timer
initialization. Do not add examples and functionality to execute closures at
timer expiration , as these depend on either atomics [3] or `SpinLockIrq` [4],
which are still being worked on.

This series is a dependency for unmerged features of the Rust null block driver
[1], and for rkvms [2].

Link: https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git/log/?h=rnull-v6.11-rc2 [1]
Link: https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-wip [2]
Link: https://lore.kernel.org/rust-for-linux/20240612223025.1158537-1-boqun.feng@gmail.com/ [3]
Link: https://lore.kernel.org/rust-for-linux/20240916213025.477225-1-lyude@redhat.com/ [4]
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v12:
- Fix `PantomData` type in `PinMutHrTimerHandle`.
- Fix safety requirement for `HasHrTImer`.
- Update safety comments in `RawTimerCallback` implementations.
- Link to v11: https://lore.kernel.org/r/20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org

Changes in v11:
- Change the way we invent a `Pin<&mut T>` in `Pin<Box<_> as
  RawHrTimerCallback>::run`.
- Use `Pin<&'a mut T>` as `CallbackTarget` for `RawHrTimerCallback`.
- Remove unnecessary trait bounds on `HrTimerPointer` impls.
- Use a pointer rather than a reference in `PinMutTimerHandle`.
- Properly format `impl_has_hr_timer`.
- Add invariant to `BoxHrTimerHandle`.
- Fix safety comment in `<Pin<&mut T> as RawHrTimerCallback>::run`.
- Use `Pin::get_unchecked_mut` rather than `Deref::deref` to get a pointer in
  `<Pin<&'a mut T> as UnsafeHrTimerPointer>::start`.
- Fix safety comment in `<Pin<&'a T> as RawHrTimerCallback<'a, T>>::run`.
- Use `Pin::get_ref` rather than `Deref::deref` in `<Pin<&'a T> as
  UnsafeHrTimerPointer>::start`.
- Fix safety comment in `<Arc<T> as RawHrTimerCallback>::run`.
- Fix a typo in docs for `HrTimerPointer::start`.
- Fix safety requirements for `HasHrTimer::raw_get_timer` and
  `HasHrTimer::c_timer_ptr`.
- Remove unused documentation link in `HasHrTimer` docs.
- Update documentation for `RawTimerCallback::CallbackTarget`.
- Link to v10: https://lore.kernel.org/r/20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org

Changes in v10:
- Use imperative language for all commit messages.
- Spelling and grammar fixes for documentation.
- Consistently use `this` as argument name for functions taking a pointer to
  `Self`.
- Correct module documentation describing states.
- Derive some standard traits for configuration enums.
- Rephrase documentation for function that refrain from crating references.
- Use "has returned" rather than "has finished executing" when describing
  handler termination.
- Simplify documentation of `HrTimer::cancel`.
- Fix a documentation bug in the description of `Sync` requirement for
  `HrTimerPointer`.
- Consistently use the wording "contains" about types that contain another type.
- Remove `OFFSET` from `HasHrTimer`.
- Use direct mapping for enumerations where applicable.
- Remove `RUST_HRTIMER` kconfig.
- Add Frederic Weisbecker and Lyude Paul as reviewers.
- Add Thomas Gleixner and Anna-Maria Behnsen as reviewers.
- Change `ClockSource` to `ClockId` and move to `time` module.
- Add scm tree to maintainer entry.
- Add a note about effects of timer operations concurrent with cancel operation.
- Update documentation for CLOCK_REALTIME and CLOCK_TAI.
- Link to v9: https://lore.kernel.org/r/20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org

Changes in v9:
- Hide `From` conversions for opaque enums.
- Add kconfig entry for rust hrtimer API.
- Move `CallbackTargetParameter` to `RawHrTimerPointer`
- Shorten first paragraphs for clock source descriptions.
- Link `HrTimerHandle::cancel` in docs.
- Clarify exclusive/shared access to callback parameter in docs.
- Improve documentation for functions that avoid creating references.
- Expand safety requirement for `HasHrTimer::start`.
- Update module level documentation and diagram.
- Use `NonNull` to store pointer in BoxHrTimerHandle.
- Add a note to `HrTimerHandle` safety requirement.
- Link to v8: https://lore.kernel.org/r/20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org

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
      rust: hrtimer: add clocksource selection through `ClockId`
      rust: hrtimer: add maintainer entry

 MAINTAINERS                         |  15 ++
 rust/kernel/alloc/kbox.rs           |   6 +
 rust/kernel/sync/arc.rs             |  13 +-
 rust/kernel/time.rs                 |  68 +++++
 rust/kernel/time/hrtimer.rs         | 518 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     | 100 +++++++
 rust/kernel/time/hrtimer/pin.rs     | 104 ++++++++
 rust/kernel/time/hrtimer/pin_mut.rs | 108 ++++++++
 rust/kernel/time/hrtimer/tbox.rs    | 120 +++++++++
 9 files changed, 1050 insertions(+), 2 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



