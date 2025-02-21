Return-Path: <linux-kernel+bounces-525740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7D8A3F40F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEC97AC92B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176A120E009;
	Fri, 21 Feb 2025 12:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP1JpUxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8FD20CCC2;
	Fri, 21 Feb 2025 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740140257; cv=none; b=YxSvFGKhPBTzQrqtwG/sl/s2KU8YHj5mUhOoCR9CyxgA60zNwbYL0c4ofbSJ1d0A7xC/sZSJPIeRd7IKac46sLO1LI7vU1lq3BKVE2FNRHzYnsoUasXcyTUNH154laWuFjMDoa7u3Kx/miZzrMQEW4U9qV/8hIKCeAlw/QO+JyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740140257; c=relaxed/simple;
	bh=d0EZ8AIRgkOLBSjVhKOQndgqjPGwY+YU5giFgsgg1UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dI35DUl8zGcUmH/a7oJhFLgGi0BMVBGfVbZ+iVb/+gLXHUxeD1jl7KuNRVs/4W6DHWJ65uyhPdAzy7NO4iziPTIugZDrY7KO4pK625uSwCZe5smgn9gqfs4i49KBHSYgPoA5qloXtWgIqxYhBhxhVZ5XW0e6JcrbeMUObOUDIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP1JpUxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF3FC4CED6;
	Fri, 21 Feb 2025 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740140256;
	bh=d0EZ8AIRgkOLBSjVhKOQndgqjPGwY+YU5giFgsgg1UA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VP1JpUxbDezZwyqc+F67UmvasObSZYnG6RVj4BRJoSM0VYeIZOG7bCDR22I9Bj76Y
	 JY6DAdOgKWmoQdpumRfCVmvYksnbBGx7sZu+pWpVAs/HqhwkQZH+v3v3/mWscnuTeb
	 imn6YVQeMS0BsdCEM9Z5gpea+LtdmNJkeZJjIeRF66Wht1+gkA/UPRrpZxn3WNXDSs
	 WrNdH/yT5EtwtJ5E4A3YcPzhjizPz85cC+cnAJ/o+ZlUJjO776+wtQsC5UoiB2/5ZR
	 8O/wPS4yd8V+fHoFBwdPXWYvkNSHoIUNaEjd56PnUAiFdGbzWD+S1SHKt7gmJC31rf
	 WzY914uM5lDcw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  "Timothy G."
 <c6qchwbke@relay.firefox.com>
Subject: Re: [PATCH v8 12/14] rust: hrtimer: add `HrTimerMode`
In-Reply-To: <59728663-3baf-449a-b0af-931e9490db19@proton.me> (Benno Lossin's
	message of "Fri, 21 Feb 2025 10:19:34 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-12-48dedb015eb3@kernel.org>
	<ysjzL6zVfMAm7OLlJMCtBkEnfdFAS2VeO4PYUFzUxcRZvKNxuRlLWPA29gJQOWa8QaH-S5K1WElhtuwWMBF4EA==@protonmail.internalid>
	<a87ef54e-9a09-4cf6-bfe8-4bb98850cdda@proton.me>
 <87mseffyh7.fsf@kernel.org>
	<Qc288_gOFSgerx6GNw2kPqnwcTqQzGUTOlONfJMr2mOAsOQ7j5V5zr_lT2v5GLGN7s7HFl0_WkJD3VRgwJBNOg==@protonmail.internalid>
	<59728663-3baf-449a-b0af-931e9490db19@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 12:39:39 +0100
Message-ID: <87zfifedc4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 21.02.25 10:17, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>>> +/// Operational mode of [`HrTimer`].
>>>> +#[derive(Clone, Copy)]
>>>> +pub enum HrTimerMode {
>>>> +    /// Timer expires at the given expiration time.
>>>> +    Absolute,
>>>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>>>> +    Relative,
>>>> +    /// Timer does not move between CPU cores.
>>>> +    Pinned,
>>>> +    /// Timer handler is executed in soft irq context.
>>>> +    Soft,
>>>> +    /// Timer handler is executed in hard irq context.
>>>> +    Hard,
>>>> +    /// Timer expires at the given expiration time.
>>>> +    /// Timer does not move between CPU cores.
>>>> +    AbsolutePinned,
>>>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>>>> +    /// Timer does not move between CPU cores.
>>>> +    RelativePinned,
>>>> +    /// Timer expires at the given expiration time.
>>>> +    /// Timer handler is executed in soft irq context.
>>>> +    AbsoluteSoft,
>>>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>>>> +    /// Timer handler is executed in soft irq context.
>>>> +    RelativeSoft,
>>>> +    /// Timer expires at the given expiration time.
>>>> +    /// Timer does not move between CPU cores.
>>>> +    /// Timer handler is executed in soft irq context.
>>>> +    AbsolutePinnedSoft,
>>>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>>>> +    /// Timer does not move between CPU cores.
>>>> +    /// Timer handler is executed in soft irq context.
>>>> +    RelativePinnedSoft,
>>>> +    /// Timer expires at the given expiration time.
>>>> +    /// Timer handler is executed in hard irq context.
>>>> +    AbsoluteHard,
>>>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>>>> +    /// Timer handler is executed in hard irq context.
>>>> +    RelativeHard,
>>>> +    /// Timer expires at the given expiration time.
>>>> +    /// Timer does not move between CPU cores.
>>>> +    /// Timer handler is executed in hard irq context.
>>>> +    AbsolutePinnedHard,
>>>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>>>> +    /// Timer does not move between CPU cores.
>>>> +    /// Timer handler is executed in hard irq context.
>>>> +    RelativePinnedHard,
>>>> +}
>>>
>>> At some point we probably want to move this to bitfields, or do you
>>> think it's better to keep it like this?
>>
>> Yes, eventually the would transition. The main difficulty is that not
>> all flag combinations are legal, and the zero value is also a flag.
>> There was some promising work being shared on Zulip for this [1], but I
>> don't think it is completed yet. Added Timothy to CC.
>>
>> [1] https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/Best.20way.20to.20handle.20enum.2Fflags.20situation
>
> Ah yeah I remember that. And also the complication about certain
> combinations not being allowed.
>
>>>> +
>>>> +impl From<HrTimerMode> for bindings::hrtimer_mode {
>>>> +    fn from(value: HrTimerMode) -> Self {
>>>> +        use bindings::*;
>>>> +        match value {
>>>> +            HrTimerMode::Absolute => hrtimer_mode_HRTIMER_MODE_ABS,
>>>> +            HrTimerMode::Relative => hrtimer_mode_HRTIMER_MODE_REL,
>>>> +            HrTimerMode::Pinned => hrtimer_mode_HRTIMER_MODE_PINNED,
>>>> +            HrTimerMode::Soft => hrtimer_mode_HRTIMER_MODE_SOFT,
>>>> +            HrTimerMode::Hard => hrtimer_mode_HRTIMER_MODE_HARD,
>>>> +            HrTimerMode::AbsolutePinned => hrtimer_mode_HRTIMER_MODE_ABS_PINNED,
>>>> +            HrTimerMode::RelativePinned => hrtimer_mode_HRTIMER_MODE_REL_PINNED,
>>>> +            HrTimerMode::AbsoluteSoft => hrtimer_mode_HRTIMER_MODE_ABS_SOFT,
>>>> +            HrTimerMode::RelativeSoft => hrtimer_mode_HRTIMER_MODE_REL_SOFT,
>>>> +            HrTimerMode::AbsolutePinnedSoft => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_SOFT,
>>>> +            HrTimerMode::RelativePinnedSoft => hrtimer_mode_HRTIMER_MODE_REL_PINNED_SOFT,
>>>> +            HrTimerMode::AbsoluteHard => hrtimer_mode_HRTIMER_MODE_ABS_HARD,
>>>> +            HrTimerMode::RelativeHard => hrtimer_mode_HRTIMER_MODE_REL_HARD,
>>>> +            HrTimerMode::AbsolutePinnedHard => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_HARD,
>>>> +            HrTimerMode::RelativePinnedHard => hrtimer_mode_HRTIMER_MODE_REL_PINNED_HARD,
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +impl From<HrTimerMode> for u64 {
>>>> +    fn from(value: HrTimerMode) -> Self {
>>>> +        Into::<bindings::hrtimer_mode>::into(value) as u64
>>>> +    }
>>>> +}
>>>
>>> Hmm do drivers really need these impls? If not, then you could also just
>>> have a private function that does the conversion and use it only in the
>>> abstraction layer.
>>
>> Similar to the other impls you commented on, I can move them private. I
>> would prefer using `From` rather than some other function.
>
> What's the reason for you preferring `From`? I don't think it's
> important to forbid access from the drivers, but if it's unnecessary,
> why would we give them access in the first place?

TIL trait implementations cannot be hidden. I like `From` because every
single rust developer seeing a `From` implementation will immediately know
what it does. It is more idiomatic in that way than having another
conversion function. I think using existing traits with well defined
semantics is preferable to a local function.

But since driver implementer do not need it, I'm undecided. If you want
them converted to a private function I can do that, for all the ones you
called out. But I am also OK with keeping as is. You decide.


Best regards,
Andreas Hindborg




