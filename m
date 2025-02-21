Return-Path: <linux-kernel+bounces-525668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050BA3F2EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957F14218AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E02080F5;
	Fri, 21 Feb 2025 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DroJ5kOb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C62066F4;
	Fri, 21 Feb 2025 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137395; cv=none; b=D6k3EuEhyqzCil/RWdGiRm3zoHeMjvujqoTunxtbcctjmmbEJAA3u9Hl1qTqbBwkjGLR/uubZA5wtRisRjSe9avWH/FYik1fFXkwlgnI+mEXQBMQK5HgxSjMc5+NV0P2wLwcAWP7KXEUuqDncQ9EupwAmQ5rxNoUfse9j3ezD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137395; c=relaxed/simple;
	bh=IH3OpXE+ypHgIXe/4FhMfuMZ2At7xnoqqHXA6TJ/Qj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM3adHHuTXBQlufRaQruGn0DJ0kbAWpQ3dYvB9GjQXgP2ymF2Yypu48Yjcx09C1LWVHbGJKtR/GbM2eSIA5OLtGE6BsYd2CfvUgOD2eBF+g1B3OymhiJDqxfxRNcIWjVM3mRb86VHoTIkQbwRniChPYkSLS5EM+em5y1tBLYsug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DroJ5kOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DD1C4CED6;
	Fri, 21 Feb 2025 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740137394;
	bh=IH3OpXE+ypHgIXe/4FhMfuMZ2At7xnoqqHXA6TJ/Qj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DroJ5kObeXnjc/XlaSgZTqF1LgwuiTHKtLYArfYQ2TFwKmQNrFYbPATOHD/u32hIv
	 5d6xoamJN2Q/hs7PlkzP2nUb7o5cta5auedyFAtdKMwLBlIZui0cNucc79gTbhBziH
	 07n39vTnOtVIrp3NlyD258SHmKKSyI6wqSENtataVmn6jXo7Uj4nPm6msRVPTSI1j9
	 qPmGo5NQjbXm/aShBdQdweGxlZm0gQp75Arq+c7qD7qLAQ+RHsyTjyQLStH9l0y5p8
	 /AWSKC2X7sZBPZnRO4abOX5vdonKnrcZZMG3nnHm9EUPhC8+cA0QTiC+jTb7D6Llxy
	 14fEWXVYFiqzA==
Date: Fri, 21 Feb 2025 12:29:51 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <Z7hjrzyVNd5BIcEy@pavilion.home>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
 <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
 <df748ac2-3551-460f-a16f-85d805671a3f@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df748ac2-3551-460f-a16f-85d805671a3f@proton.me>

Le Thu, Feb 20, 2025 at 11:46:10PM +0000, Benno Lossin a écrit :
> On 18.02.25 14:27, Andreas Hindborg wrote:
> > This patch adds support for intrusive use of the hrtimer system. For now,
> > only one timer can be embedded in a Rust struct.
> > 
> > The hrtimer Rust API is based on the intrusive style pattern introduced by
> > the Rust workqueue API.
> > 
> > Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> > ---
> >  rust/kernel/time.rs         |   2 +
> >  rust/kernel/time/hrtimer.rs | 312 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 314 insertions(+)
> > 
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index 87e47f2f5618d..2cf365cfb412e 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -10,6 +10,8 @@
> > 
> >  use core::convert::Into;
> > 
> > +pub mod hrtimer;
> > +
> >  /// The number of nanoseconds per millisecond.
> >  pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
> > 
> > diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> > new file mode 100644
> > index 0000000000000..a6332924efabd
> > --- /dev/null
> > +++ b/rust/kernel/time/hrtimer.rs
> > @@ -0,0 +1,312 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Intrusive high resolution timers.
> > +//!
> > +//! Allows running timer callbacks without doing allocations at the time of
> > +//! starting the timer. For now, only one timer per type is allowed.
> > +//!
> > +//! # Vocabulary
> > +//!
> > +//! States:
> > +//!
> > +//! * Stopped
> > +//! * Running
> > +//!
> > +//! Operations:
> > +//!
> > +//! * Start
> > +//! * Cancel
> > +//! * Stop
> > +//! * Restart
> > +//!
> > +//! Events:
> > +//!
> > +//! * Expire
> > +//!
> > +//! ## State Diagram
> > +//!
> > +//! ```text
> > +//!                  <-- Stop ----
> > +//!                  <-- Cancel --
> > +//!                  --- Start -->
> > +//!        +---------+        +---------+
> > +//!   O--->| Stopped |        | Running |---o
> > +//!        +---------+        +---------+   |
> > +//!                                  ^      |
> > +//!                  <- Expire --    |      |
> > +//!                                  o------o
> > +//!                                   Restart
> > +//! ```
> > +//!
> > +//! A timer is initialized in the **stopped** state. A stopped timer can be
> > +//! **started** with an **expiry** time. After the timer is started, it is
> > +//! **running**. When the timer **expires**, the timer handler is executed.
> > +//! After the handler has executed, the timer may be **restarted** or
> > +//! **stopped**. A running timer can be **canceled** before it's handler is
> 
> This confuses me a bit, in the other thread you wrote that the handler
> decides if the timer should restart or be stopped. But What happens when
> I call `cancel` on the `HrTimerHandle` while the handler is running, but
> finishes shortly after with a restart request? Will it be canceled?
> 
> I also have a bit of a wording issue with "the timer is running" IIUC,
> this means that the timer subsystem keeps track of the expiry time and
> when the time is elapsed, it fires the code that you registered prior.
> At first, I thought that "the timer is running" meant that the
> registered code is running. Maybe we should have two different terms for
> that? I personally would prefer "active timer" for "the timer subsystem
> is currently tracking the time and when it is elapsed, it will run the
> code" and "running timer" for "the timer's expiry time has elapsed and
> the timer callback is currently being executed".

Good point. "Running" in the hrtimer terminology is usually to
describe a running callback and not just an elapsing (or say started) timer.

I would rather have:

Stopped: initialized but not started, or cancelled, or not restarted
Started: initialized and started or restarted
Running: executing the callback

Thanks.

