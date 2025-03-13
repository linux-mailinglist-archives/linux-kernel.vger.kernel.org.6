Return-Path: <linux-kernel+bounces-559569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DB0A5F599
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC5E16AF97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240D1267AF5;
	Thu, 13 Mar 2025 13:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJnPTJ3J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3E267701;
	Thu, 13 Mar 2025 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871456; cv=none; b=LXa6uAYBA+lB908ec7wSch+OL4uvuzdSaowmqHeq3fY3SWQ6g90ZES3udED55r6xvOje6wlLW6wSnTgeh/i6L93f9AZOnm6bLAsSAMAhmyZr+c9Tm04tuaHzst4PlBBAa0fUvvBpFJNZRUFlwr9zu+ZIA8gO+L2hr2P3NxgLT+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871456; c=relaxed/simple;
	bh=W+OBDKk5Mn4qkgSGbiXhBmlr+I5LJlLvCiSgkiyVEsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r6QBtxLGNXPJUEaCxcRlxrbPdwThnwGQZmHr4qERsEAG+26elRFmFz0P2oMS9q8BtC+qu7V86u000ykm6kaXUIsSAb2MhtVPnD8uSn+NU07XHzD5BWj4yF5vdtxCF+ybN9z50ndKWSMD/sWZXFilnmbxgjD1hxVJrxS7hhGNuDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJnPTJ3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EDFC4CEDD;
	Thu, 13 Mar 2025 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741871456;
	bh=W+OBDKk5Mn4qkgSGbiXhBmlr+I5LJlLvCiSgkiyVEsU=;
	h=From:To:Cc:Subject:Date:From;
	b=RJnPTJ3JnZouJdGdm+NHmJzXRpurMzjS1eY33REci5uRL3rv8q6DMko88R5yn4GPH
	 umjHmOwsRB5Ompg/+/ch+Ms1za6OLaQml1cpOQ9vSBMAKpA5Wn1gDx5IG07l4ZD2Oq
	 LyFy7/zIzgQwVhQ5CLsRTLW3JND7y/nPH1oMhbkfgORy5qeA5WEQDEnvKDRxGKhmk+
	 XYQKp18EkaZVZELaVoclzm7ePL9OdmaF/jEI3yqON+VVfM2BYJVkKV7WVGZ2H+ZxxT
	 AJRDh15lOfQgbi5cgUdoRXvcG5Xiy+xByQV2QuFpgMNQzCtnk3vUYFQuMzbSGyeP+V
	 LIJ2y4Fvnbxyg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
	"Frederic Weisbecker" <frederic@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
  linux-kernel@vger.kernel.org,
  "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Rust `hrtimer` support for v6.15
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 13 Mar 2025 14:09:21 +0100
Message-ID: <87pliljcvy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Miguel,

Please pull the Rust support for hrtimer for v6.15.

This initial support allows for intrusive use of timers without
allocating when starting a timer. We support `Pin<Box<T>>`, `Arc<T>`,
`Pin<&T>` and `Pin<&mut T>` pointer types for working with these
intrusive timers. We support at most one `HrTimer` field in a struct for
use with this API.

For now, the primary users will be the Rust null block driver, `rnull`,
and the Rust kernel mode setting driver `rkvms`. I expect us to add more
features to the API as the demands from users grow.

The PR also includes two changes for the core rust and rust/alloc
subsytems that are dependencies of the hrtimer Rust API: `Arc::as_ptr`
and `Box::into_pin`. The alloc change was Ack'd by Danilo.

The commits were in linux-next since next-20250313.

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://github.com/rust-for-linux/linux.git tags/rust-hrtimer-for-v6.15

for you to fetch changes up to 15a3c03ca02b6caec995de178904ab8c637d584c:

  rust: hrtimer: add maintainer entry (2025-03-11 21:00:43 +0100)


Best regards,
Andreas Hindborg

----------------------------------------------------------------
Rust hrtimer API for v6.15

Introduce Rust support for the `hrtimer` subsystem:

 - Add a way to use the `hrtimer` subsystem from Rust. Rust code can now set up
   intrusive timers without allocating when starting the timer.

 - Add support for `Pin<Box<_>>`, `Arc<_>`, `Pin<&_>` and `Pin<&mut _>` as
   pointer types for use with timer callbacks.

 - Add support for setting clock source and timer mode.

`kernel` crate:

 - Add `Arc::as_ptr` for converting an `Arc` to a raw pointer. This is a
   dependency for the `hrtimer` API.

 - Add `Box::into_pin` for converting a `Box<_>` into a `Pin<Box<_>>` to align
   with Rust `alloc`. This is a dependency for the `hrtimer` API.

----------------------------------------------------------------
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
 rust/kernel/time/hrtimer.rs         | 517 ++++++++++++++++++++++++++++++++++++
 rust/kernel/time/hrtimer/arc.rs     | 100 +++++++
 rust/kernel/time/hrtimer/pin.rs     | 104 ++++++++
 rust/kernel/time/hrtimer/pin_mut.rs | 108 ++++++++
 rust/kernel/time/hrtimer/tbox.rs    | 120 +++++++++
 9 files changed, 1049 insertions(+), 2 deletions(-)
 create mode 100644 rust/kernel/time/hrtimer.rs
 create mode 100644 rust/kernel/time/hrtimer/arc.rs
 create mode 100644 rust/kernel/time/hrtimer/pin.rs
 create mode 100644 rust/kernel/time/hrtimer/pin_mut.rs
 create mode 100644 rust/kernel/time/hrtimer/tbox.rs


