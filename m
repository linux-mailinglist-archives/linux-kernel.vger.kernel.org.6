Return-Path: <linux-kernel+bounces-525462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16D2A3F048
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236FD1891269
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3086A204C10;
	Fri, 21 Feb 2025 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTRURrWn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660DF204582;
	Fri, 21 Feb 2025 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130207; cv=none; b=fzipwXiinSrknUREJt63bhh6Qv6t+OJ9RzFhQ5+nIkxkhd/BxaWkX3CxYPNIzAaP/HIyWvGmxIM32Gqw3ryhVmPrxCQERiSxSiXHpNqcyNG0BTMhskrU6C6uaTknY9gsdGDsfvTMMqlUQf5ZovomTwWsQ/8mAiI5RS5tEH73RJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130207; c=relaxed/simple;
	bh=/TRTM++2Nyi4h1NYSlRhaUan1RJwlkjtiN/tOj66uw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MjgWYNoWPFGW73GxCNPLT6bYtNnEt1wJVHSAmDcRYZbcVu2e6wie37O5feiIN1YBIBPny6UpCuGUi365oEJtaFx0sctjqrwlmWu4TS4P8dBsZ+Xq+V0clZRfUiLUqlepXz+Sn1NvKvsNrpUKGXvIKW5scc/ATSVC59GEX28S1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTRURrWn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A323C4CED6;
	Fri, 21 Feb 2025 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130205;
	bh=/TRTM++2Nyi4h1NYSlRhaUan1RJwlkjtiN/tOj66uw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kTRURrWnSjFYCD1pDgAIBiIEcy24OLXS31VbVpe2SkI4VbXUJpa6TT6Vq2ikkiVNp
	 37/9GBN92d+5i+Kv1mLDqh7RTv+VvyCNxejbL/gxD923mZGCHEXSvYO3WxDJvXPBXG
	 bfQJ3CCyYPNtWkO73zklXEeBGguzNIfYP8c9Q6drfEZydbaex/2XjOd/gA/s+nWKFJ
	 WruVTnkiR7jmrwqJLAyA3/GtvJgz3JUpx0L7rSXmSmyhJOu0YUbAfUUQ+e2Cq2WpM3
	 mOYiwMIy4sSryCPac8mnRhSy1+SUN0PqHKkTl6g3pDLZQsYDOc106NFDkx/iYyOWXC
	 D+8mbTF57lEFQ==
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
  <linux-kernel@vger.kernel.org>, "Timothy G."
 <c6qchwbke@relay.firefox.com>
Subject: Re: [PATCH v8 12/14] rust: hrtimer: add `HrTimerMode`
In-Reply-To: <a87ef54e-9a09-4cf6-bfe8-4bb98850cdda@proton.me> (Benno Lossin's
	message of "Thu, 20 Feb 2025 23:23:55 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-12-48dedb015eb3@kernel.org>
	<ysjzL6zVfMAm7OLlJMCtBkEnfdFAS2VeO4PYUFzUxcRZvKNxuRlLWPA29gJQOWa8QaH-S5K1WElhtuwWMBF4EA==@protonmail.internalid>
	<a87ef54e-9a09-4cf6-bfe8-4bb98850cdda@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 10:17:40 +0100
Message-ID: <87mseffyh7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.02.25 14:27, Andreas Hindborg wrote:
>> +/// Operational mode of [`HrTimer`].
>> +#[derive(Clone, Copy)]
>> +pub enum HrTimerMode {
>> +    /// Timer expires at the given expiration time.
>> +    Absolute,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    Relative,
>> +    /// Timer does not move between CPU cores.
>> +    Pinned,
>> +    /// Timer handler is executed in soft irq context.
>> +    Soft,
>> +    /// Timer handler is executed in hard irq context.
>> +    Hard,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    AbsolutePinned,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    RelativePinned,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer handler is executed in soft irq context.
>> +    AbsoluteSoft,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer handler is executed in soft irq context.
>> +    RelativeSoft,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in soft irq context.
>> +    AbsolutePinnedSoft,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in soft irq context.
>> +    RelativePinnedSoft,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer handler is executed in hard irq context.
>> +    AbsoluteHard,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer handler is executed in hard irq context.
>> +    RelativeHard,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in hard irq context.
>> +    AbsolutePinnedHard,
>> +    /// Timer expires after the given expiration time interpreted as a duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in hard irq context.
>> +    RelativePinnedHard,
>> +}
>
> At some point we probably want to move this to bitfields, or do you
> think it's better to keep it like this?

Yes, eventually the would transition. The main difficulty is that not
all flag combinations are legal, and the zero value is also a flag.
There was some promising work being shared on Zulip for this [1], but I
don't think it is completed yet. Added Timothy to CC.

[1] https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/Best.20way.20to.20handle.20enum.2Fflags.20situation

>> +
>> +impl From<HrTimerMode> for bindings::hrtimer_mode {
>> +    fn from(value: HrTimerMode) -> Self {
>> +        use bindings::*;
>> +        match value {
>> +            HrTimerMode::Absolute => hrtimer_mode_HRTIMER_MODE_ABS,
>> +            HrTimerMode::Relative => hrtimer_mode_HRTIMER_MODE_REL,
>> +            HrTimerMode::Pinned => hrtimer_mode_HRTIMER_MODE_PINNED,
>> +            HrTimerMode::Soft => hrtimer_mode_HRTIMER_MODE_SOFT,
>> +            HrTimerMode::Hard => hrtimer_mode_HRTIMER_MODE_HARD,
>> +            HrTimerMode::AbsolutePinned => hrtimer_mode_HRTIMER_MODE_ABS_PINNED,
>> +            HrTimerMode::RelativePinned => hrtimer_mode_HRTIMER_MODE_REL_PINNED,
>> +            HrTimerMode::AbsoluteSoft => hrtimer_mode_HRTIMER_MODE_ABS_SOFT,
>> +            HrTimerMode::RelativeSoft => hrtimer_mode_HRTIMER_MODE_REL_SOFT,
>> +            HrTimerMode::AbsolutePinnedSoft => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_SOFT,
>> +            HrTimerMode::RelativePinnedSoft => hrtimer_mode_HRTIMER_MODE_REL_PINNED_SOFT,
>> +            HrTimerMode::AbsoluteHard => hrtimer_mode_HRTIMER_MODE_ABS_HARD,
>> +            HrTimerMode::RelativeHard => hrtimer_mode_HRTIMER_MODE_REL_HARD,
>> +            HrTimerMode::AbsolutePinnedHard => hrtimer_mode_HRTIMER_MODE_ABS_PINNED_HARD,
>> +            HrTimerMode::RelativePinnedHard => hrtimer_mode_HRTIMER_MODE_REL_PINNED_HARD,
>> +        }
>> +    }
>> +}
>> +
>> +impl From<HrTimerMode> for u64 {
>> +    fn from(value: HrTimerMode) -> Self {
>> +        Into::<bindings::hrtimer_mode>::into(value) as u64
>> +    }
>> +}
>
> Hmm do drivers really need these impls? If not, then you could also just
> have a private function that does the conversion and use it only in the
> abstraction layer.

Similar to the other impls you commented on, I can move them private. I
would prefer using `From` rather than some other function.


Best regards,
Andreas Hindborg



