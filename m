Return-Path: <linux-kernel+bounces-528976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826D5A41E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965823A1003
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099A624501D;
	Mon, 24 Feb 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogzYDBOx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3608023BD10;
	Mon, 24 Feb 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398777; cv=none; b=qAs82I56F4Fi+KkoEsAqvlNk2zr5IZILQRWEqeLsJ9C4FmhZusvUjUop/m0CoHFl3tcxe40AA0KteYeN8BEk63Bm9skjXki3jrORdknxNph5JbojSdPf9N/RYMIWlomGAKI+HyEx+6f+XoJcsOiWkeRNzd3384p23Fq2nLLNxho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398777; c=relaxed/simple;
	bh=/JaOC4TFV5X4zFYetazeGIvP+quvcKis81d/V/pcOww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W2NTDdAuSNCpZ57E/Yu9uUvqSqqW0uKLYP4CQWTnm4JCg2tOm7l+kgffIEKVM+WeGaqk6yA6sL8pcv5el9E30yoWB/w0AYzxWXtnwEgucqzF9PqoQtC/2GkqbDCCxjp3pvbTsvyD19Q/S/+HS290z7VhzBNdRVnKlpmOIUgZtqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogzYDBOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6489C4CEE6;
	Mon, 24 Feb 2025 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398777;
	bh=/JaOC4TFV5X4zFYetazeGIvP+quvcKis81d/V/pcOww=;
	h=From:Subject:Date:To:Cc:From;
	b=ogzYDBOxoUvwjHexeOKMBFkaHZpaeQBkBsqA2Z8XRh+Nqp+jiBY1u6KJY4eNuT9bS
	 CW7t9LOpoG0C3FkfQP22j2Ol+kvIrRBxBwSguQ1eGy1raKfURZYmZ0N0fbSfxQL36S
	 NUcYE3T4Tp8RwSuhmUuqexjb2HYicoRmlchwXfP4I615Nogq0Jg1Jc3gI9Vd3y2oBX
	 4Q2tbSUitN9NC0w0dvH1kiBoMPGaPxoVPlIVv4nJ3gPdxk4Hj/jYFeJU8Hw7dG5jiS
	 e8qklVdECZB+cU0UpsJkiQsjpXPZx0GBzcUqTJafxFebjXF1CDipQi0+jPRytjUK+L
	 zcSYlZQdghOhg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v9 00/13] hrtimer Rust API
Date: Mon, 24 Feb 2025 13:03:34 +0100
Message-Id: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZgvGcC/3XSwU7DMAwG4FeZeiZV7CROshPvgTgkqbtF0G6kp
 QIh3p2wCTY0essf6f/sgz+aiUvmqdluPprCS57yYazB322atA/jjkXuam5QogYJVuzLnAcuYlF
 iIQEoSkKBYLpEEcjHvqnVY+E+v53Yh8ea93maD+X9NGWB798TKDUa6TUp3SIhWS1AjEO+H3gO0
 zEkbrun5ru/4KXjwSKiVb4F9A6tqaXQ7vPYxUPZ3T9xGfm5rc9zU/0219evQQrjgzUpRq27cKP
 oi4KSVhRdFUrRJUVWkcMbxVwpq7uYqkSlE8qQMEV7o9CPYiSAXFGoKr2FzsgeSP+zi70oKNWKY
 qsCzoPWFo3y/kZxVwq4FcVVRbuOuyjBcFR/lM/zuRR+ea3HN59vpolhYpEOw5Dn7QYl6ORN6Dk
 xK7aUgg6GvKHgFTEqdKqXJlbs8wtlRokx0QIAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6321; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=/JaOC4TFV5X4zFYetazeGIvP+quvcKis81d/V/pcOww=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBnvGAYaeo9Bvj9b1GajagTXksAjjwEe52Tqvypn
 XbaQLggC3iJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCZ7xgGAAKCRDhuBo+eShj
 d+sXD/43AaRAM/nN4J8xQ41FceKI1FROK0yYBxIlmWVtW6Zhd9WbSjqTGh1Md+E9jyKCJOPCXA6
 x91uytWfntJeSV7uivUMWgQwndBukxeX6AuTScvbbSzDgc9x8y5GpVjRqOe6vDecOM9UPRntqR0
 OGhTLOXyacubTKvihyZPArmp/UzPJTRMPxJlufJbW36rFZF+4KFPV/H0gDMTgS0j+A763Vj6uhf
 0YvDs6xkFO97vmWXnstM6D2EMBzplj7mRiStWK8TuvA6/j3riXEujjohuNyfsg/sOQC46fdcUuu
 OCVrVtzcQy1W1iJOFNk8qzRa1cqrQMIB/6RLpM0N6KR593Re4ARETiUO128R2MunYWkqlOOYXUP
 XJz79XIvoPC11iDjeEPDVMtziIGnV1pE3bNnT6ae5+0ZeeVTnY9mVxe1TRLfDpVwrkvWBHDz2S5
 Ogv6tg6S8N660qh6b34FWjKEWj+lS1iaG3nSp7zjGjaY7tEOJHnOBapdMqupsbzuriXWiY+bGxQ
 tDNHX7DMJMPm+zy6SGrDmkhJdHV1a/9NRxEcsuRdhBNNwq6OUw4G/knbtZPGcRgp8jXDkA9plq2
 aOSHW23SLq7C5L628tK0gEHXQxQHr9E2swOwH4hmo6HbFdNxPxvXnk4rMsnbAxknkNRy3MBPJ93
 K4DL9htaLi3PyEA==
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
      rust: hrtimer: add clocksource selection through `ClockSource`
      rust: hrtimer: add maintainer entry

 MAINTAINERS                         |  10 +
 kernel/time/Kconfig                 |  13 +
 rust/kernel/alloc/kbox.rs           |   6 +
 rust/kernel/sync/arc.rs             |  13 +-
 rust/kernel/time.rs                 |   3 +
 rust/kernel/time/hrtimer.rs         | 566 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     |  92 ++++++
 rust/kernel/time/hrtimer/pin.rs     |  99 +++++++
 rust/kernel/time/hrtimer/pin_mut.rs | 101 +++++++
 rust/kernel/time/hrtimer/tbox.rs    | 109 +++++++
 10 files changed, 1010 insertions(+), 2 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20241017-hrtimer-v3-v6-12-rc2-215dc6b169bf

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



