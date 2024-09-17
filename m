Return-Path: <linux-kernel+bounces-332114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B20997B5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 00:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FF82893F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 22:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F782193062;
	Tue, 17 Sep 2024 22:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6cE/FRm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45F192D80;
	Tue, 17 Sep 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612109; cv=none; b=TMbspRrOoAe4w8zrCPIVwRpGav4SC6mxAcrtIq/2hiPAX6QYRjCi9MqhxU5SIn9UUxxqOns7iz9nHjki8W4c0QxOCIhaAUp8PH6jxqXPlmqroVCNyG1t5hm59BYYFPnmLNMNkjhN7j+oPQ/4CKlcH9EC7SZeDsqoBOucPj5QQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612109; c=relaxed/simple;
	bh=v8a0nJ/rc+OK18Wxq94GBNtOb5DtDJoxXv1oZUTW0wM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhAQ7SCE5PSV0b9Mc/x92PWNB5FHsNFNu9R6XVeAtn/YeljxhgPNIaTGRLOlIdGLqvqG2R+XzJSHCpSHt8kR4/RpH1ZDSkL9r0dfuY4UXCA+NNTPtj8c++GeQPCAyPiPB9Q2VpjMu57WIaJbAyJ3ooZc/p/qPtpx+YTuX79M9L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6cE/FRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B91C4CECE;
	Tue, 17 Sep 2024 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612109;
	bh=v8a0nJ/rc+OK18Wxq94GBNtOb5DtDJoxXv1oZUTW0wM=;
	h=From:To:Cc:Subject:Date:From;
	b=h6cE/FRmA24GKvvdS6JAFjorlADzEj2zyVDWQt9tvLr3hFb/pwTudioJRgT/KO112
	 37f0VMsgpNSkkgPSHXDuyeuXqLRaISxt/GqFZdVdUl9osNjKN0Z30ZxIrK+loC/fpz
	 i7h2ll+G2V+JuevpD/Xc14gkbJgiNQc8T4Zx5q6q2n/t0yoDkctCKYPeCU25uziEVr
	 B07hWx78oqRWyXXI7hDwNuugVxGAWK9Gn8eEi1YOyh7Hv6hb3uJwfriJxQbfoTftM2
	 a2K6R+jg8HgpSo3vETLJZOUWSoYfCd+Z3sYWhD53Ee+WHa5Nhp9Q3ATm+UKxN+hXaQ
	 P4/sHvtTFOBrA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] hrtimer Rust API
Date: Wed, 18 Sep 2024 00:27:24 +0200
Message-ID: <20240917222739.1298275-1-a.hindborg@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3771; i=a.hindborg@kernel.org; h=from:subject; bh=v8a0nJ/rc+OK18Wxq94GBNtOb5DtDJoxXv1oZUTW0wM=; b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQjRiZ2FQb mtvWTNjQnl5WmlBR2JxQWZHWExSeWNmQ3ZHR0Z6RS9XTFY4NmkwCjliRHVRRnhLTUNNbU5qSmxB REpORW9rQ013UUFBUW9BSFJZaEJCTEIrVWRXdjN3cUZkYkFFdUc0R2o1NUtHTjMKQlFKbTZnSHh BQW9KRU9HNEdqNTVLR04zc1hVUUFJUWl5MzQzRVlvN0ovbDc1eXRncU9zcGgvK1grVkh2T2tDUw pmMlVKVXZRcUZXSnpvcEJCVytWUEtaY2crb2grSzlGeHdOY3JXSFYvSFlsS1ByYThVdWhzdERoc ElSMWZRWFltClNKUGhIN01kM1hncUFpTFE2NW1OQTJsVkF3NFZBRE01NGJDQUNMVGV3NXROVkZQ NlBPWE9lanFVUk5CUzMzNnYKVHQ1cjVLTms3N05RelJoREJIUi9aWGo5alo0cGY0VU1DdEc4eWN GT3hOeDQ4ejZBZnd5Rm43THNGNCtyMzBLbQpDWWRMUGJwYlYzanI4ZmdESnYwUlZDUDJjOVBhQU ZCTFJrMFh5VGlTWmVueDdjVFFSYzZRaVplMk1kU0lnek1sCnZaNWdpb3RreHA5N3l6VENsOWZaQ khjSndaaW9LYmIyZ0dQYm1rSkUwcm1zMUs0WjFXQjdwYlFsSy92SmY5WHMKaFhHMGxrMG1rOGRK VWpETU5lT0loT3FKWC9hek41RHc4dDJERTh3RmJScE1FTDNkN0tZQW4yb0NiNW56b0xOTgprQ2Z obWVrbUJlenBua0NYV
 VZmczdLNERlbHVid3luUitBbVg4bDZuWlgxRGduMkJuVkIxR0ZlL2R3RX BVN3VvCjBKenQwbDhjZ29YMHZLOTB4NnhWQ0tvM0lDVTBIbFhsbnRYTEJia2RkSzc5eEVpbzQvV 2xTeVdjSUlTaXBaTzUKbDhza1NBR3FmOXFFUGs4YmEwRXlCVk9ucmtSYlpQa08zL2JLZWhhZnBD Z21iaytOcDltSjNwYkFJYjZuTmZqaQplTjF3cGhINGh2VmRQUnpOUWI5RzM4Yjlzb1EyRTQrUEd zQTgvK2V5bElzVGhmbnVBck41c3VEcmpQdE5NZnVvCnhyRlJSZnpqU1dFdFp3PT0KPWh6T0wKLS 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp; fpr=3108C10F46872E248D1FB221376EB100563EF7A7
Content-Transfer-Encoding: 8bit

Hi!

This series adds support for using the `hrtimer` subsystem from Rust code.

I tried breaking up the code in some smaller patches, hopefully that will
ease the review process a bit.

The major change in this series is the use of a handle to carry ownership
of the callback target. In v1, we used the armed timer to carry ownership
of the callback target. This caused issues when the live timer became the
last owner of the callback target, because the target would be dropped in
timer callback context. That is solved by using a handle instead.

A request from Thomas on v1 was to add a more complete API. While I did add
more features, we are still missing some. In the interest of getting the
patches on list prior to LPC 2024, I am leaving out the following planned
features:

 - hrtimer_sleeper, schedule_hrtimeout, hrtimer_nanosleep  and friends
 - introspection functions:
   - try_cancel
   - get_remaining
   - active
   - queued
   - callback_running
 - hrtimer_forward
 - access to timer callback target through timer handle

I plan to add these features in the comming months. Adding the above
features should not cause much churn, and pending positive review, I see no
reason to not pick up this series first.

To make it absolutely clear that I am willing to maintain the code I
submit, I added a mantainer entry in the last patch. Feel free to drop it,
if you want to make other arrangements.

---

Changes from v1:
 - use a handle to own the timer callback target
 - add ability to for callback to reschedule timer
 - improve `impl_has_timer` to allow generics
 - add support for stack allocated timers
 - add support for scheduling closures
 - use `Ktime` for setting expiration
 - use `CondVar` instead of `AtomicBool` in examples
 - rebase on 6.11
 - improve documentation

This series is a dependency for unmerged features of the Rust null block driver
[1], and for rkvms [2].

Link: https://git.kernel.org/pub/scm/linux/kernel/git/a.hindborg/linux.git/log/?h=rnull-v6.11-rc2 [1]
Link: https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-wip [2]

---

Andreas Hindborg (13):
  rust: hrtimer: introduce hrtimer support
  rust: sync: add `Arc::as_ptr`
  rust: sync: add `Arc::clone_from_raw`
  rust: hrtimer: implement `TimerPointer` for `Arc`
  rust: hrtimer: allow timer restart from timer handler
  rust: hrtimer: add `UnsafeTimerPointer`
  rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&T>`
  rust: hrtimer: implement `UnsafeTimerPointer` for `Pin<&mut T>`
  rust: hrtimer: add `hrtimer::ScopedTimerPointer`
  rust: hrtimer: allow specifying a distinct callback parameter
  rust: hrtimer: implement `TimerPointer` for `Pin<Box<T>>`
  rust: hrtimer: add `schedule_function` to schedule closures
  rust: hrtimer: add maintainer entry

Lyude Paul (1):
  rust: time: Add Ktime::from_ns()

 MAINTAINERS                    |  10 +
 rust/kernel/hrtimer.rs         | 550 +++++++++++++++++++++++++++++++++
 rust/kernel/hrtimer/arc.rs     |  86 ++++++
 rust/kernel/hrtimer/closure.rs |  72 +++++
 rust/kernel/hrtimer/pin.rs     |  97 ++++++
 rust/kernel/hrtimer/pin_mut.rs |  99 ++++++
 rust/kernel/hrtimer/tbox.rs    |  95 ++++++
 rust/kernel/lib.rs             |   1 +
 rust/kernel/sync/arc.rs        |  28 ++
 rust/kernel/time.rs            |   8 +
 10 files changed, 1046 insertions(+)
 create mode 100644 rust/kernel/hrtimer.rs
 create mode 100644 rust/kernel/hrtimer/arc.rs
 create mode 100644 rust/kernel/hrtimer/closure.rs
 create mode 100644 rust/kernel/hrtimer/pin.rs
 create mode 100644 rust/kernel/hrtimer/pin_mut.rs
 create mode 100644 rust/kernel/hrtimer/tbox.rs


base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.46.0



