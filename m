Return-Path: <linux-kernel+bounces-536801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3782A48473
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8A3188820B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B211DC9A8;
	Thu, 27 Feb 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmnL121r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CBC19D07C;
	Thu, 27 Feb 2025 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740672229; cv=none; b=KA1VuhJeDpj3bzp442+MoVi4oCmeWdQYj4UqNEvD8b5+JUzCnwbMT0zagr6FVGrgMoDunQRRRjVdW53VnwDaoLDf4I3sSg4wuHSsv2HrmhD9dss0Zz9Ek5mE31s5eV3fSwPGps2m/OvwYzgWNpTU8A7iE9HFh2AsP71xeUiZUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740672229; c=relaxed/simple;
	bh=Vq9pRRc5BfHueS+vTDE4bALzNK4FWB32HuyBpbTBgdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KkYN57XOz+N1NuUqTiMU/tkejDIKk/RekOyhM2fKcOp1DlmNBPy9pms/D1+0UPwWp7g/5gBlKkzhmtCQNAYkpuvxN5czcJGx6mYrKyZnfLN4O7rF1FADbQcuCuMLbMXoGSOsHnX8tezDUFkydFAouZ1nI9jQ6HeXWw9gbF2uOGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmnL121r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF66C4CEDD;
	Thu, 27 Feb 2025 16:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740672229;
	bh=Vq9pRRc5BfHueS+vTDE4bALzNK4FWB32HuyBpbTBgdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gmnL121rW8R47lTupspwERJNJbDvdVhL4/y62HeM05S7CPEevMY1bcGQ+lnwAonVT
	 +Jch1Aj4bDCsJGIHeBbFhboM7LdvTYTTSLxZeugjvZg7tMB6EUlUGA7cvYywVXxmV/
	 FCubvBC+QWQFbUGlqsDlVmcR4FdW/c3eisWOKMdlTla9rvlcEnmNww+BJtoJ7CUBUh
	 govQU0hXtURtR/ay4DihJkJdpfm7N3A7NKqpTqA0NEtnjAiMQIYwm09vKGDwhyVKpM
	 QnD0yaZyhe09ADPLExAogUjg6jYxGxiUoaVOf0OfsROG7w0WHcJIMkA1uH0oUqCMTe
	 8+Id43A6p2SrA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/13] rust: hrtimer: add clocksource selection
 through `ClockSource`
In-Reply-To: <87bjuneabh.ffs@tglx> (Thomas Gleixner's message of "Thu, 27 Feb
	2025 15:22:58 +0100")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-12-5bd3bf0ce6cc@kernel.org>
	<6sz8JD2Jq54KZZ3nCKbMpvae2yHUmF2hHEP3qrQlbGY6RrWzS8BN5YxinlIQnIFkGfjAPauTxI8i3sZUhzoPiw==@protonmail.internalid>
	<87jz9beor7.ffs@tglx> <87zfi7prf2.fsf@kernel.org>
	<0ePSCNg5vlevhPRhflq3lvzk2YBD5-uA5M0VWGr5gb-BldbGA9KzHxwkgP5zPayOl4vg9rjEK_Ku5ago9Vp-tQ==@protonmail.internalid>
	<87bjuneabh.ffs@tglx>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 17:03:37 +0100
Message-ID: <87tt8fpe7a.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Thomas Gleixner" <tglx@linutronix.de> writes:

> On Thu, Feb 27 2025 at 12:18, Andreas Hindborg wrote:
>> "Thomas Gleixner" <tglx@linutronix.de> writes:
>>>> +/// The clock source to use for a [`HrTimer`].
>>>> +pub enum ClockSource {
>>>
>>> ClockSource is a confusing name as 'clocksource' is used in the kernel
>>> already for devices providing counters, which can be used for
>>> timekeeping.
>>>
>>> Also these clocks are not really hrtimer specific. These CLOCK ids are
>>> system wide valid and are used for other purposes obviously internally
>>> in timekeeping. hrtimers are built on top of timekeeping, which provides
>>> the underlying time.
>>
>> I see. How about renaming to `ClockId` and moving the type one level up
>> to `kernel::time`?
>
> Yes.
>
>>>> +    /// A settable system-wide clock that measures real (i.e., wall-clock) time.
>>>> +    ///
>>>> +    /// Setting this clock requires appropriate privileges. This clock is
>>>> +    /// affected by discontinuous jumps in the system time (e.g., if the system
>>>> +    /// administrator manually changes the clock), and by frequency adjustments
>>>> +    /// performed by NTP and similar applications via adjtime(3), adjtimex(2),
>>>> +    /// clock_adjtime(2), and ntp_adjtime(3). This clock normally counts the
>>>> +    /// number of seconds since 1970-01-01 00:00:00 Coordinated Universal Time
>>>> +    /// (UTC) except that it ignores leap seconds; near a leap second it is
>>>> +    /// typically adjusted by NTP to stay roughly in sync with UTC.
>>>
>>> That's not correct. It depends on the implementation/configuration of
>>> NTP. The default is that the leap second is actually applied at the
>>> requested time, by setting the clock one second forth or back.
>>>
>>> Though there are NTP configurations/implementations out there which use
>>> leap second "smearing" to avoid the jump. They adjust the conversion
>>> factors around the leap second event by slowing down or speeding up for
>>> a while. That avoids a few common issues, e.g. in data bases.
>>>
>>> But it brings all clocks out of sync with the actual progress of time, which
>>> is patently bad for systems which require strict synchronization.
>>>
>>> The problem is that the kernel uses the NTP/PTP frequency adjustment to
>>> steer the conversion of all clocks, except CLOCK_MONOTONIC_RAW. The
>>> kernel internal base clock is CLOCK_MONOTONIC. The other clocks are
>>> derived from that:
>>>
>>>         CLOCK_[X] = CLOCK_MONOTONIC + offset[X]
>>
>> I see. I lifted the text from `clock_getres(2)` in linux-man [1]. We
>> might consider updating that source with the info we collect here.
>
> Yup.
>
>> How about changing the text like so:
>>
>> .. by frequency adjustments performed by NTP ...
>>
>> to
>>
>> .. by frequency adjustments performed by some implementations of NTP ...
>>
>> ?
>
> Frequency is adjusted by _all_ implementations of NTP and also by PTP,
> PPS and GPS. That's how the time synchronization daemons steer the clock
> to align with the master clock. This adjustment is done via adjtimex(2).
>
> That affects all clocks except CLOCK_MONOTONIC_RAW, which is never
> adjusted and keeps the boot time frequency forever.
>
> CLOCK_REALTIME is not only frequency adjusted, it also can be set
> via settimeofday(2) and clock_settime((2), CLOCK_REALTIME).
>
> But CLOCK_REALTIME _and_ CLOCK_TAI can also be set via adjtimex(2). For
> CLOCK_TAI this is required to set the offset between CLOCK_REALTIME and
> CLOCK_TAI correctly (at least during boot).
>
> The last oddity are leap seconds. The standardized method is to actually
> jump the clock by one second at midnight of the day specified by the
> International Earth Rotation and Reference Systems Service (IERS).
>
> That obviously causes problems because a minute having 61 seconds is not
> only beyond the comprehension of computer programmers, but is
> problematic in many areas like astronomy, satellite navigation, control
> systems, telecommunications .... Those industries largely switched to
> clock TAI or GPS time, where TAI is always ahead of GPS by constant 19
> seconds.
>
> In the recent years big companies like Google, Facebook, Alibaba and
> others implemented leap smearing to address the remaining issues in
> applications, which have to use clock REALTIME. But of course it's
> neither standardized nor did those clowns talk to each other. So we have
> today:
>
>    Google:   24 h before the leap second
>    Facebook: 18 h after the leap second
>    Alibaba:  12 h before until 12 h after the leap second
>    ...       more incompatible variants of the same
>
> This obviously creates just a different set of inconsistency problems
> not only between the networks of these giants but also with the rest of
> the (non smearing) world around the leap second event. Their notion of
> time is only coherent within their own network.
>
> On Linux (and other OSes) it also affects the accuracy of all other
> clocks during that time. The actual slowdown is marginal, e.g. on
> average 192nsec per minute in the Google case, but the accumulated one
> second offset over 24 hours is way more than what certain applications
> can tolerate.

Rereading the original paragraph, I think that it is consistent with
what you write:


 - Setting this clock requires appropriate privileges.

 OK I assume.



 - This clock is affected by discontinuous jumps in the system time
   (e.g., if the system administrator manually changes the clock),

 OK as well.



 - and by frequency adjustments performed by NTP and similar
   applications via adjtime(3), adjtimex(2), clock_adjtime(2), and
   ntp_adjtime(3).

 This also seems to align with what you explain. Even though PTP and GPS
   is not mentioned, it does say "and similar applications".



 - This clock normally counts the number of seconds since 1970-01-01
   00:00:00 Coordinated Universal Time (UTC)

 Seems OK.



 - except that it ignores leap seconds;

 The clock does not count leap seconds in the number of seconds elapsed
   since epoch. A slightly confusing wording, but OK I guess?



 - near a leap second it is typically adjusted by NTP to stay roughly in
   sync with UTC

 Also aligns with your explanation. We could rephrase a bit:

 - near a leap second it may be adjusted by leap second smearing to stay
   roughly in sync with UTC. Leap second smearing applies frequency
   adjustments to the clock to speed up or slow down the clock to
   account for the leap second without discontinuities in the clock. If
   leap second smearing is not applied, the clock will experience
   discontinuity around leap second adjustment.

>
>>>> +    /// International Atomic Time.
>>>> +    ///
>>>> +    /// A nonsettable system-wide clock derived from wall-clock time but
>>>> +    /// counting leap seconds. This clock does not experience discontinuities or
>>>> +    /// frequency adjustments caused by inserting leap seconds as CLOCK_REALTIME
>>>> +    /// does.
>>>
>>> Only partially correct.
>>>
>>> CLOCK_TAI can be set as CLOCK_TAI is obviously coupled to CLOCK_REALTIME
>>> and vice versa.
>>
>> So it cannot be set directly, but if CLOCK_REALTIME is set, CLOCK_TAI
>> will update?
>>
>> In that case I would add the following paragraph:
>>
>>   This clock is coupled to CLOCK_REALTIME and will be set when
>>   CLOCK_REALTIME is set.
>
> It also can be set independently via adjtimex(2) by correcting the
> offset between REALTIME and TAI, which is done usually during system
> startup when the time synchronization deamon starts (ntpd, chrony,
> systemd-???, ....). Should not happen during normal operations, emphasis
> on *should*.


  This clock is coupled to CLOCK_REALTIME and will be set when
  CLOCK_REALTIME is set, or when the offset to CLOCK_REALTIME is changed
  via adjtimex(2). This usually happens during boot and **should** not
  happen during normal operations.

>
>>> Also if the NTP implementation does leap seconds smearing then the
>>> adjustment affects CLOCK_TAI as well. See above. That's compensated for
>>> by adjusting the TAI offset to be in sync with reality, but during the
>>> smear phase the readout is not precise.
>>
>> I would add the following paragraph then:
>>
>>   However, if NTP adjusts CLOCK_REALTIME by leap second smearing, this
>>   clock will not be precise during leap second smearing.
>
> Correct.
>
> The important part is that the selection of the clock depends on the
> actual use case. In some cases the usage of a particular clock is
> mandatory, e.g. in network protocols, filesystems ... In other cases the
> programmer has to decide which clock is best suited for the purpose. In
> most scenarios clock MONOTONIC is the best choice as it provides a
> accurate monotonic notion of time (leap second smearing ignored).

I'll grab this paragraph to use as a base for documentation on the
`ClockId` type.



Best regards,
Andreas Hindborg




