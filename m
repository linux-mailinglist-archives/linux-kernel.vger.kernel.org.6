Return-Path: <linux-kernel+bounces-533992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DEA46131
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C696918901C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EBA21CC44;
	Wed, 26 Feb 2025 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6cR4tOn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF2341C71;
	Wed, 26 Feb 2025 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740577442; cv=none; b=otPU6DrqiFVhoBCJR46UcBZTldy0Htid2DzPo2UIr832iEEePB0NUX35VqwpPgCxDjbV8XHp9jsDAZr5E+VnqzJVJNVLIjHnSBDqvgd0mSopJ158hV4neIr20kM3hzQfoijAG+rvYUYU3xjXcFcFB9hBkAHC5E6rIif25I4df7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740577442; c=relaxed/simple;
	bh=Tep2lPN+rpct37RYjZ6pG1IE0OH1XeA8ffgdNjYTmdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DusDiAofp+0b7MHAkjzDt9x1tmhaS/UEttDeosTNMJyIubmCgWTqrMYiaRep9wfwSURsIdqg+qxktqHZ0//sA9xFl4ZXJXC9RQyyagXAy79vsj4FjkaMMh2y2dLSgr2/km21FYIMXkrvckdCXwcZBSpV9IxR2CNQsX3STtdHd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6cR4tOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E91BC4CED6;
	Wed, 26 Feb 2025 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740577441;
	bh=Tep2lPN+rpct37RYjZ6pG1IE0OH1XeA8ffgdNjYTmdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B6cR4tOnA/dc6AUxmnq8mg22Rxr4zD1iC9tp//6N2Xq7pVIkHYTRr7/6oKtgsdnA+
	 Gfni78fLcV6fRZ4tC9VjliGOnxVdM0G4YnfExsDn7DVrEVpq2dnv4ns4nQ7filLPUS
	 TJ9ASSSS50WBHscudXgtQY91oFy8JozPLfuYggSD/ousMA5ii/3xQKcWiL3GWIOW3M
	 YhJmUhCi3iXIuNYNFJj1LYAc44TT6TJPLH1yI5JJPzUrEZc+LZi45rxRLJzTjh/aKz
	 buVaT/PugBHmpz96g4rnfgo7Ep3OpVuYknshYmF+m7g2taLbxmnzcKFAKKoSWX5An5
	 fSnLo+WRvGw2g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 04/13] rust: hrtimer: allow timer restart from timer
 handler
In-Reply-To: <6c2a299ec594fbaae294037e36c78cb37aaa7f33.camel@redhat.com>
	(Lyude Paul's message of "Tue, 25 Feb 2025 16:46:56 -0500")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-4-5bd3bf0ce6cc@kernel.org>
	<bbtTga1W7J8Ur61sLLE4K8a3B0oe5iDhuHVNs9dTAf8EX2PUf_jloAt7U3xki4WZB3IkWyPHErVMMLx_vwXXlg==@protonmail.internalid>
	<0fb37c2b2d1a28d2096ffdb08df15404d870d68a.camel@redhat.com>
	<877c5exuwu.fsf@kernel.org>
	<ei-wpaJk-37J66majBflBYe_VA0QU4gcT2mJiTXB-kkkGHDXKoWZN2DVpKkKxCtmVFBcaVsCSZvHweJMEupknQ==@protonmail.internalid>
	<6c2a299ec594fbaae294037e36c78cb37aaa7f33.camel@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Feb 2025 14:43:49 +0100
Message-ID: <878qpsvn1m.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Tue, 2025-02-25 at 09:58 +0100, Andreas Hindborg wrote:
>> "Lyude Paul" <lyude@redhat.com> writes:
>>
>> > On Mon, 2025-02-24 at 13:03 +0100, Andreas Hindborg wrote:
>> >
>> > Also, I feel like I might have asked this a few versions ago so hopefully i'm
>> > not asking again: but what's the reason for us not just using the
>> > discriminants of `HrTimerRestart` here:
>> >
>> > /// Restart policy for timers.
>> > #[repr(u32)]
>> > pub enum HrTimerRestart {
>> >     /// Timer should not be restarted.
>> >     NoRestart = bindings::hrtimer_restart_HRTIMER_NORESTART,
>> >     /// Timer should be restarted.
>> >     Restart = bindings::hrtimer_restart_HRTIMER_RESTART,
>> > }
>>
>> I forget if we discussed this, but it does not make much of a
>> difference, does it?
>>
>> With a Rust enum, we get a smaller storage type maybe with better
>> support for niche optimizations? And then pay a bit more for conversion.
>> All in all, I don't think it makes much difference.
>
> No idea about performance wise, but I -think- it would actually cut down on
> the code that you need - particularly for the larger enums here. Mainly
> because you only would need to manually specify each variant for converting
> from bindings::hrtimer_restart to HrTimerRestart, but not the other way
> around:
>
>    /// Restart policy for timers.
>    #[repr(u32)]
>    pub enum HrTimerRestart {
>        /// Timer should not be restarted.
>        NoRestart = bindings::hrtimer_restart_HRTIMER_NORESTART,
>        /// Timer should be restarted.
>        Restart = bindings::hrtimer_restart_HRTIMER_RESTART,
>    }
>
>    impl From<bindings::hrtimer_restart> for HrTimerRestart {
>        fn from(value: u32) -> Self {
>            match value {
>                bindings::hrtimer_restart_HRTIMER_NORESTART => Self::NoRestart,
>                _ => Self::Restart,
>            }
>        }
>    }
>
>    impl From<HrTimerRestart> for bindings::hrtimer_restart {
>        fn from(value: HrTimerRestart) -> Self {
>            value as Self
>        }
>    }

I was implementing this, and it is fine for `HrTimerRestart`, but for
`HrTimerMode` it does not work out. We have multiple flags with the same
value:

  error[E0081]: discriminant value `2` assigned more than once
    --> /home/aeh/src/linux-rust/hrtimer/rust/kernel/time/hrtimer.rs:689:1
      |
  689 | pub enum HrTimerMode {
      | ^^^^^^^^^^^^^^^^^^^^
  ...
  695 |     Pinned = bindings::hrtimer_mode_HRTIMER_MODE_PINNED,
      |              ------------------------------------------ `2` assigned here
  ...
  702 |     AbsolutePinned = bindings::hrtimer_mode_HRTIMER_MODE_ABS_PINNED,
      |                      ---------------------------------------------- `2` assigned here


Which is unfortunate. I'll keep the old style for this one and convert
the others where applicable.


Best regards,
Andreas Hindborg



