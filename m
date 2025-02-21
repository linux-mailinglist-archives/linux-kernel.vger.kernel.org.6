Return-Path: <linux-kernel+bounces-525741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B45A3F414
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67AF517B72C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2F820B814;
	Fri, 21 Feb 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiZbOIHB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C43D20A5D2;
	Fri, 21 Feb 2025 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140262; cv=none; b=p6yn9LjFeiau07tbS91f9kcymgsoSJlykni4o60TywxKQc4lKLxa79I9RInNZA46cwjwwmJ6UlzMsWZTU4ytIcbNeVYkKNfw+M6KaDIZaXcjRCXv0+OGPCW+qocKIICa3x0toeR5lRTZN/Sb0RGgRgkWIhVr/4VxLQR3HQaQ30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140262; c=relaxed/simple;
	bh=2wtTNZErjn1SqfWUbPF2f49AL1ImwjpkG6hFzaWY16o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z5jaZb3nlFoVP+E6uzJgYp1/WbLEMHrRnT3vQF0bNLOrKMWiXy9tijQqSZI/vmB1RgxHdrPdqrTezPI9Pj5cRDaq6FXyoHHLAosEKsOGWHVK2zDPPPELGFhJuIZfpFusI9iLG4yeTvEt/bUTmfE/J6hwjvdbWjzB33TiSTbslpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiZbOIHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D51C4CED6;
	Fri, 21 Feb 2025 12:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740140261;
	bh=2wtTNZErjn1SqfWUbPF2f49AL1ImwjpkG6hFzaWY16o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hiZbOIHBg+3gKpFdnS9fpc/4Gt1itvBGqGC2BBqIJHnX/JyspISk3/qrnK6ddxakz
	 q3BtBxLNzjtQIzeH581rkU3nVg8Ocne1thbGqIaT/EzQTFwSUWjswY3N0Iwn6EixB0
	 lSaq0z0A2N0grUvIqldxxV54OtSyJkP20jnhGS9/Qss+jmC6Gee5TY3Zr9DMQQKBRe
	 7yEVxtmJfcuBJ68sZOnJ8URl5ZI4wWPfFBSxdZY6FC1u6sQDH2yZbMrRF6CcYIKJSf
	 rfoIV/S8cdID30bdS3ulGpONsi34d+h21ft3HUZVTgqTQuJdxaPpvXnZECb39/xItO
	 BPEh0RWLUrZgQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Benno Lossin" <benno.lossin@proton.me>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <Z7hjrzyVNd5BIcEy@pavilion.home> (Frederic Weisbecker's message
	of "Fri, 21 Feb 2025 12:29:51 +0100")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<df748ac2-3551-460f-a16f-85d805671a3f@proton.me>
	<knRTiXibND0ILf7cUQ5sOLy-c9oVveVdLy2b4iN1kIh0_XPwARxjXset0ads8-7zJAaG2YnLHx3WK6vY-nXyEw==@protonmail.internalid>
	<Z7hjrzyVNd5BIcEy@pavilion.home>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 12:44:53 +0100
Message-ID: <87tt8ned3e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Frederic Weisbecker" <frederic@kernel.org> writes:

> Le Thu, Feb 20, 2025 at 11:46:10PM +0000, Benno Lossin a =C3=A9crit :
>> On 18.02.25 14:27, Andreas Hindborg wrote:
>> > This patch adds support for intrusive use of the hrtimer system. For n=
ow,
>> > only one timer can be embedded in a Rust struct.
>> >
>> > The hrtimer Rust API is based on the intrusive style pattern introduce=
d by
>> > the Rust workqueue API.
>> >
>> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> > ---
>> >  rust/kernel/time.rs         |   2 +
>> >  rust/kernel/time/hrtimer.rs | 312 +++++++++++++++++++++++++++++++++++=
+++++++++
>> >  2 files changed, 314 insertions(+)
>> >
>> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
>> > index 87e47f2f5618d..2cf365cfb412e 100644
>> > --- a/rust/kernel/time.rs
>> > +++ b/rust/kernel/time.rs
>> > @@ -10,6 +10,8 @@
>> >
>> >  use core::convert::Into;
>> >
>> > +pub mod hrtimer;
>> > +
>> >  /// The number of nanoseconds per millisecond.
>> >  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>> >
>> > diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> > new file mode 100644
>> > index 0000000000000..a6332924efabd
>> > --- /dev/null
>> > +++ b/rust/kernel/time/hrtimer.rs
>> > @@ -0,0 +1,312 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +//! Intrusive high resolution timers.
>> > +//!
>> > +//! Allows running timer callbacks without doing allocations at the t=
ime of
>> > +//! starting the timer. For now, only one timer per type is allowed.
>> > +//!
>> > +//! # Vocabulary
>> > +//!
>> > +//! States:
>> > +//!
>> > +//! * Stopped
>> > +//! * Running
>> > +//!
>> > +//! Operations:
>> > +//!
>> > +//! * Start
>> > +//! * Cancel
>> > +//! * Stop
>> > +//! * Restart
>> > +//!
>> > +//! Events:
>> > +//!
>> > +//! * Expire
>> > +//!
>> > +//! ## State Diagram
>> > +//!
>> > +//! ```text
>> > +//!                  <-- Stop ----
>> > +//!                  <-- Cancel --
>> > +//!                  --- Start -->
>> > +//!        +---------+        +---------+
>> > +//!   O--->| Stopped |        | Running |---o
>> > +//!        +---------+        +---------+   |
>> > +//!                                  ^      |
>> > +//!                  <- Expire --    |      |
>> > +//!                                  o------o
>> > +//!                                   Restart
>> > +//! ```
>> > +//!
>> > +//! A timer is initialized in the **stopped** state. A stopped timer =
can be
>> > +//! **started** with an **expiry** time. After the timer is started, =
it is
>> > +//! **running**. When the timer **expires**, the timer handler is exe=
cuted.
>> > +//! After the handler has executed, the timer may be **restarted** or
>> > +//! **stopped**. A running timer can be **canceled** before it's hand=
ler is
>>
>> This confuses me a bit, in the other thread you wrote that the handler
>> decides if the timer should restart or be stopped. But What happens when
>> I call `cancel` on the `HrTimerHandle` while the handler is running, but
>> finishes shortly after with a restart request? Will it be canceled?
>>
>> I also have a bit of a wording issue with "the timer is running" IIUC,
>> this means that the timer subsystem keeps track of the expiry time and
>> when the time is elapsed, it fires the code that you registered prior.
>> At first, I thought that "the timer is running" meant that the
>> registered code is running. Maybe we should have two different terms for
>> that? I personally would prefer "active timer" for "the timer subsystem
>> is currently tracking the time and when it is elapsed, it will run the
>> code" and "running timer" for "the timer's expiry time has elapsed and
>> the timer callback is currently being executed".
>
> Good point. "Running" in the hrtimer terminology is usually to
> describe a running callback and not just an elapsing (or say started) tim=
er.
>
> I would rather have:
>
> Stopped: initialized but not started, or cancelled, or not restarted
> Started: initialized and started or restarted
> Running: executing the callback

Alright, we can do that. That makes sense =F0=9F=91=8D



Best regards,
Andreas Hindborg



