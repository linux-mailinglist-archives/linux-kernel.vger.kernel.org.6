Return-Path: <linux-kernel+bounces-550845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A5CA564F6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FBF18860F1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E16213246;
	Fri,  7 Mar 2025 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifN9keS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AD21018A;
	Fri,  7 Mar 2025 10:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342687; cv=none; b=ZiCON1dQ3lDpt8CNTVo6sRk27HsojLaGdf5SvwYUAy+EiBO04Ztgz3BI08zqa/7ixQJO+y/mLB8MDTlvwkfd8t0DzRniQVBb1VNy8doRKa4OCpjVXNexe4L38ZfNRDraeuVTlWhqUDBChtuTYsxCrzv28lMTaWH2X3hSI4J+LV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342687; c=relaxed/simple;
	bh=ABhGBikH9BCW0TLtmE6DMbgMrWsR5JvOtiwNDeB6gPw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aZMDMwLEejdWXAjCnuseh2wvkjJhoDrUOm/5yHwPnTnqDmjF076bJyow2jCRcS9/OimAZzNB9wkmKPam9jKjF4bWRTPg8XNfbCvNXpiZKR+lqxG/nm07eRbi7h93P+jDonkRxQF7gB2OTUQTQDjpzbT2K4gSu+ME91dcjF1vjtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifN9keS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4C8C4CED1;
	Fri,  7 Mar 2025 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741342686;
	bh=ABhGBikH9BCW0TLtmE6DMbgMrWsR5JvOtiwNDeB6gPw=;
	h=From:Subject:Date:To:Cc:From;
	b=ifN9keS7r1dCImkvt2UXPzk3zYkE/yhO8/hKA3JALWQMELONrox5b1RFkDpySZOTA
	 OwICFXN+Oqzu/gzf56rZTDayM2i+j2qRTORXxGok1n0+noCUTeaq5kLS/2Xq8fvMuX
	 XNbvvQKIC2w/CRmaZm0Sg+wTmydm74j6AAvQXSeB6z3v7JXAEDeWOSnvmq2iio+Sk3
	 NPOSJBcKo5gVDRhkxqAAvF36oLteLvd8PoDOrgFkS7tJWH28i9Sf5oEKshaiZZ1qX1
	 Vh/aSfeLyo7zxP+m97yzpIp5olmiGSLAONJWdhb6HiAisEIZKuM1kHgEZQfdSd7aEf
	 hEtjBHPiNZb5w==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v10 00/13] hrtimer Rust API
Date: Fri, 07 Mar 2025 11:11:45 +0100
Message-Id: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGHGymcC/3XSzW7bMAwH8FcJfJ4MkZIoqae+R7GDPuhG6Oy0s
 mtsKPruUxK0yeD5JhL4/0SA/OhmroXn7uHw0VVey1xOUytA/jh06RimZxYlt0aHEjVIsOJYlzJ
 yFasSKwlAURMKBJMTRSAfh65FXysP5ffFffrZ6mOZl1P9c/lmhXP3AkqNRnpNSvdISFYLENNYH
 kdewvwaEvf5pTvnV7xlPFhEtMr3gN6hNS0U+mOZcjzV58cXrhP/6tvzmlTfyf3xWyGF8cGaFKP
 WOWwUfVNQ0o6im0IpuqTIKnK4UcydsjuLaUpUOqEMCVO0G4W+FCMB5I5CTRksZCMHIP2fWexNQ
 al2FNsUcB60tmiU9xvF3SngdhTXFO0y5yjBcFQbxd8pqHcUf95RzCoOMjGl9I/yeT26ym/v7Ya
 X6+V1Mcws0mkcy/JwQAk6eRMGTsyKLaWggyFvKHhFjAqdGqSJDfv8CznjHqsYAwAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7548; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=ABhGBikH9BCW0TLtmE6DMbgMrWsR5JvOtiwNDeB6gPw=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnysZy9oNu5RD5GxyCRQRQqc7AkJuPZ22o1C5WT
 GAKCkI2532JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ8rGcgAKCRDhuBo+eShj
 d1ujEACEwnJ/aD2jFO6tvnVKpX9Gj0AdtYWQ2jgxffjEJgMrm/j032h0A0N0KyqzF3ZYhvcFKBf
 mQ+e7lyAxVIEYg5OCup2qvcTkPj6eCJppEwq6N6Cde+sm147ySfcgi/DIJAc6lbAEkOJceKNw0b
 wgcYmLvwsswIj6AjwmYofGZnI475lW/vg50wa4MZeev5JswakG8qVqPefSGL0iSCp1Ps1P1nIIX
 Xc0/vro4Hs0fWDKrvsQcW/OEhB0DcqxbJ/64SzOLa9PQaHFDmO+NI5lrxPCST2OtgCWTXxf6Cmx
 X6+iUWsIOYAGRL9bQ63Jxms37Kq/uMuL3WapKlbPemKgYpdsAqm6lpvovI9hci4bD2X/yCHWKqq
 ghwiqOSoJWzoLh7jZTXoa7LmXL6WnB8Q6U4lUU9DRHRD/hVHI7lex8419nG9yIfATu5AieU5gVh
 5xsaIG2tgEmXwfYAJGnE9vu/05NOlEdrnK7amltKClocdYnfXJ1clzHJtc4Rq2LUWw19U3qEB7r
 qMOiJ3/RCVhUWn8sP7953l6qHR+Qb6662j8RflB1lgNogX7MyZfN+DRWcy+dZVbjc5qGIJR6u8N
 v5yFEwhz9W5e/vG8Oy1P7sFfeDqHYe+JrzccrwMLbYu2eoIujNE9W61fZkTKy3niacgiHyb373m
 kH6Dc9Mo51ugMmA==
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
 rust/kernel/time/hrtimer.rs         | 525 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     |  92 +++++++
 rust/kernel/time/hrtimer/pin.rs     |  99 +++++++
 rust/kernel/time/hrtimer/pin_mut.rs | 101 +++++++
 rust/kernel/time/hrtimer/tbox.rs    | 109 ++++++++
 9 files changed, 1026 insertions(+), 2 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



