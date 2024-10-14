Return-Path: <linux-kernel+bounces-363680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D81599C590
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41DF1F238A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03C4156F39;
	Mon, 14 Oct 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0G8wPKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738C156879;
	Mon, 14 Oct 2024 09:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897964; cv=none; b=SaSFMldEfF07Tlh+ep3uwVhexI1mYAiS2YGbc7h/v+uAoGHCj3/RA/UwtXuPD1MZ+BEpfXuWA1v+59PeuHrmBSDCEhj6pybqyR7pej5Sa7W7Kn/i/MkJGVplv6KRSrW+3ojVcvv+xY+d0Opu6uFi8T4YjJyK7gsQTKyO9uuQB7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897964; c=relaxed/simple;
	bh=OkN6ntUSyjEd9BpNV184pisGSZLDJpArHZ11JjjqXMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=krlH3ULJKngXgR310aUOeZ8kzr4qbrEoJzyujtrQtMjF1fvrKD5RYpTFepuX+LDNMKaYa6LzpEJBs9CFf+FWwHRJ+ypMNycmW65drZaWQ+x36c9kR1u8NJZ5/hvUte5ZqzvG0v/r0ln0X6FZguL9obXEQ//0jMrAttjmU8sThBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0G8wPKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B8EC4CEC3;
	Mon, 14 Oct 2024 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728897963;
	bh=OkN6ntUSyjEd9BpNV184pisGSZLDJpArHZ11JjjqXMU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z0G8wPKzPaQno1/Uk1+Gyi9017Vs2F1LYNSH18Zj8oeLbGf5CXoTQx3DH9/Pbb9l+
	 /DNaP2OzTYwDtgWeYvjZO0OwdHUHaCkILW6cO5dRlfv44iQofOO18qinEYNLKngCQo
	 gl80bkKJWzftTo32/Sx6oCg5dkb7MuAIO24st226/xaPOuhSY7tHYBtLSja4dUlpeK
	 JSStaT8fmQa2r9MntTfethRmmYPKQlJrCxLdBIP1k0gnJCJloMWJCPsAMKFH7VP9uS
	 8Lo4JChaVh3W2ky9U07GB8oMVaPShx+C/26nHi2MHzRRHS/EPC8UwwTLVYmEIz2efX
	 UsRvMLZINhdlg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Dirk Behme" <dirk.behme@gmail.com>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  "Lyude Paul" <lyude@redhat.com>,
  "Dirk Behme" <dirk.behme@de.bosch.com>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Anna-Maria
 Behnsen" <anna-maria@linutronix.de>,  "Frederic Weisbecker"
 <frederic@kernel.org>,  "Thomas Gleixner" <tglx@linutronix.de>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Benno Lossin" <benno.lossin@proton.me>,  "Alice Ryhl"
 <aliceryhl@google.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/14] hrtimer Rust API
In-Reply-To: <9eb1504a-b306-4332-99ce-739bc016622e@gmail.com> (Dirk Behme's
	message of "Mon, 14 Oct 2024 08:58:00 +0200")
References: <e644aec7-02b3-4faf-9a80-629055c5a27a@de.bosch.com>
	<ZvwKTinnLckZm8aQ@boqun-archlinux> <87a5falmjy.fsf@kernel.org>
	<dae08234-c9ba-472d-b769-1d07e579a8ac@gmail.com>
	<Zwmy-2Yc7vGboYvl@boqun-archlinux>
	<d2ce38a3-9a32-4f4c-88f2-22864b66afe5@gmail.com>
	<ZwooHrqIiirl1so7@boqun-archlinux>
	<4dd93603-04fa-4da4-b867-bd12ece4b391@gmail.com>
	<Zwr3i4x7J5qyjFog@Boquns-Mac-mini.local>
	<c19edf2d-2b53-403f-abcc-a5e81e7613f8@gmail.com>
	<Zww2Vhsl9sutNm0s@Boquns-Mac-mini.local>
	<SNbF-P01b40nAmc5Dk3aQjrcNMqgf9hflytDtpeXkQslZJAhgSzctsfVhXb3MkfbGqx5HzA0devlwOybz7dQHw==@protonmail.internalid>
	<9eb1504a-b306-4332-99ce-739bc016622e@gmail.com>
Date: Mon, 14 Oct 2024 11:17:08 +0200
Message-ID: <87ttdfjb6z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dirk Behme" <dirk.behme@gmail.com> writes:

> On 13.10.24 23:06, Boqun Feng wrote:
>> On Sun, Oct 13, 2024 at 07:39:29PM +0200, Dirk Behme wrote:
>>> On 13.10.24 00:26, Boqun Feng wrote:
>>>> On Sat, Oct 12, 2024 at 09:50:00AM +0200, Dirk Behme wrote:
>>>>> On 12.10.24 09:41, Boqun Feng wrote:
>>>>>> On Sat, Oct 12, 2024 at 07:19:41AM +0200, Dirk Behme wrote:
>>>>>>> On 12.10.24 01:21, Boqun Feng wrote:
>>>>>>>> On Fri, Oct 11, 2024 at 05:43:57PM +0200, Dirk Behme wrote:
>>>>>>>>> Hi Andreas,
>>>>>>>>>
>>>>>>>>> Am 11.10.24 um 16:52 schrieb Andreas Hindborg:
>>>>>>>>>>
>>>>>>>>>> Dirk, thanks for reporting!
>>>>>>>>>
>>>>>>>>> :)
>>>>>>>>>
>>>>>>>>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>>>>>>>>
>>>>>>>>>>> On Tue, Oct 01, 2024 at 02:37:46PM +0200, Dirk Behme wrote:
>>>>>>>>>>>> On 18.09.2024 00:27, Andreas Hindborg wrote:
>>>>>>>>>>>>> Hi!
>>>>>>>>>>>>>
>>>>>>>>>>>>> This series adds support for using the `hrtimer` subsystem from Rust code.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I tried breaking up the code in some smaller patches, hopefully that will
>>>>>>>>>>>>> ease the review process a bit.
>>>>>>>>>>>>
>>>>>>>>>>>> Just fyi, having all 14 patches applied I get [1] on the first (doctest)
>>>>>>>>>>>> Example from hrtimer.rs.
>>>>>>>>>>>>
>>>>>>>>>>>> This is from lockdep:
>>>>>>>>>>>>
>>>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/locking/lockdep.c#n4785
>>>>>>>>>>>>
>>>>>>>>>>>> Having just a quick look I'm not sure what the root cause is. Maybe mutex in
>>>>>>>>>>>> interrupt context? Or a more subtle one?
>>>>>>>>>>>
>>>>>>>>>>> I think it's calling mutex inside an interrupt context as shown by the
>>>>>>>>>>> callstack:
>>>>>>>>>>>
>>>>>>>>>>> ]  __mutex_lock+0xa0/0xa4
>>>>>>>>>>> ] ...
>>>>>>>>>>> ]  hrtimer_interrupt+0x1d4/0x2ac
>>>>>>>>>>>
>>>>>>>>>>> , it is because:
>>>>>>>>>>>
>>>>>>>>>>> +//! struct ArcIntrusiveTimer {
>>>>>>>>>>> +//!     #[pin]
>>>>>>>>>>> +//!     timer: Timer<Self>,
>>>>>>>>>>> +//!     #[pin]
>>>>>>>>>>> +//!     flag: Mutex<bool>,
>>>>>>>>>>> +//!     #[pin]
>>>>>>>>>>> +//!     cond: CondVar,
>>>>>>>>>>> +//! }
>>>>>>>>>>>
>>>>>>>>>>> has a Mutex<bool>, which actually should be a SpinLockIrq [1]. Note that
>>>>>>>>>>> irq-off is needed for the lock, because otherwise we will hit a self
>>>>>>>>>>> deadlock due to interrupts:
>>>>>>>>>>>
>>>>>>>>>>> 	spin_lock(&a);
>>>>>>>>>>> 	> timer interrupt
>>>>>>>>>>> 	  spin_lock(&a);
>>>>>>>>>>>
>>>>>>>>>>> Also notice that the IrqDisabled<'_> token can be simply created by
>>>>>>>>>>> ::new(), because irq contexts should guarantee interrupt disabled (i.e.
>>>>>>>>>>> we don't support nested interrupts*).
>>>>>>>>>>
>>>>>>>>>> I updated the example based on the work in [1]. I think we need to
>>>>>>>>>> update `CondVar::wait` to support waiting with irq disabled.
>>>>>>>>>
>>>>>>>>> Yes, I agree. This answers one of the open questions I had in the discussion
>>>>>>>>> with Boqun :)
>>>>>>>>>
>>>>>>>>> What do you think regarding the other open question: In this *special* case
>>>>>>>>> here, what do you think to go *without* any lock? I mean the 'while *guard
>>>>>>>>> != 5' loop in the main thread is read only regarding guard. So it doesn't
>>>>>>>>> matter if it *reads* the old or the new value. And the read/modify/write of
>>>>>>>>> guard in the callback is done with interrupts disabled anyhow as it runs in
>>>>>>>>> interrupt context. And with this can't be interrupted (excluding nested
>>>>>>>>> interrupts). So this modification of guard doesn't need to be protected from
>>>>>>>>> being interrupted by a lock if there is no modifcation of guard "outside"
>>>>>>>>> the interupt locked context.
>>>>>>>>>
>>>>>>>>> What do you think?
>>>>>>>>>
>>>>>>>>
>>>>>>>> Reading while there is another CPU is writing is data-race, which is UB.
>>>>>>>
>>>>>>> Could you help to understand where exactly you see UB in Andreas' 'while
>>>>>>> *guard != 5' loop in case no locking is used? As mentioned I'm under the
>>>>>>
>>>>>> Sure, but could you provide the code of what you mean exactly, if you
>>>>>> don't use a lock here, you cannot have a guard. I need to the exact code
>>>>>> to point out where the compiler may "mis-compile" (a result of being
>> [...]
>>>>> I thought we are talking about anything like
>>>>>
>>>>> #[pin_data]
>>>>> struct ArcIntrusiveTimer {
>>>>>         #[pin]
>>>>>         timer: Timer<Self>,
>>>>>         #[pin]
>>>>> -      flag: SpinLockIrq<u64>,
>>>>> +      flag: u64,
>>>>>         #[pin]
>>>>>         cond: CondVar,
>>>>> }
>>>>>
>>>>> ?
>>>>>
>>>>
>>>> Yes, but have you tried to actually use that for the example from
>>>> Andreas? I think you will find that you cannot write to `flag` inside
>>>> the timer callback, because you only has a `Arc<ArcIntrusiveTimer>`, so
>>>> not mutable reference for `ArcIntrusiveTimer`. You can of course use
>>>> unsafe to create a mutable reference to `flag`, but it won't be sound,
>>>> since you are getting a mutable reference from an immutable reference.
>>>
>>> Yes, of course. But, hmm, wouldn't that unsoundness be independent on the
>>> topic we discuss here? I mean we are talking about getting the compiler to
>>
>> What do you mean? If the code is unsound, you won't want to use it in an
>> example, right?
>
> Yes, sure. But ;)
>
> In a first step I just wanted to answer the question if we do need a
> lock at all in this special example. And that we could do even with
> unsound read/modify/write I would guess. And then, in a second step,
> if the answer would be "we don't need the lock", then we could think
> about how to make the flag handling sound. So I'm talking just about
> answering that question, not about the final example code. Step by step :)
>
>
>>> read/modify/write 'flag' in the TimerCallback. *How* we tell him to do so
>>> should be independent on the result what we want to look at regarding the
>>> locking requirements of 'flag'?
>>>
>>> Anyhow, my root motivation was to simplify Andreas example to not use a lock
>>> where not strictly required. And with this make Andreas example independent
>>
>> Well, if you don't want to use a lock then you need to use atomics,
>> otherwise it's likely a UB,
>
> And here we are back to the initial question :) Why would it be UB
> without lock (and atomics)?

It is UB at the language level. Miri will yell at you. If you do this,
the compiler will give you zero guarantees.

> Some (pseudo) assembly:
>
> Lets start with the main thread:
>
> ldr x1, [x0]
> <work with x1>
>
> x0 and x1 are registers. x0 contains the address of flag in the main
> memory. I.e. that instruction reads (ldr == load) the content of that
> memory location (flag) into x1. x1 then contains flag which can be
> used then. This is what I mean with "the main thread is read only". If
> flag, i.e. x1, does contain the old or new flag value doesn't matter.
> I.e. for the read only operation it doesn't matter if it is protected
> by a lock as the load (ldr) can't be interrupted.
>
> Now to the TimerCallback:
>
> ldr x1, [x0]
> add x1, x1, #1
> str x1, [x0]
>
> This is what I mean with read/modify/write. And this needs to be
> ensured that it is not interruptable. I.e. that we are scheduled
> between ldr and add or between add and str. Yes, I *totally* agree
> that for this a lock is needed:
>
> <lock>
> ldr x1, [x0]
> add x1, x1, #1
> str x1, [x0]
> <unlock>
>
> But:
>
> In this this special example we know that we are executing this code
> in interrupt context. I.e.:
>
> <interrupts are disabled>
> ldr x1, [x0]
> add x1, x1, #1
> str x1, [x0]
> <interrupts are still disabled>
>
> So this read/modify/write can't be interrupted because the interrupts
> are off. I.e. the interrupt off prevents the scheduling here. And in
> this sense replaces the lock. And as mentioned, which value is read by
> the main thread doesn't matter.

You can have the interrupt handler running on one core and the process
on another core. For uni-processor systems you are right. I actually
think spinlock operations collapse to no-ops on non-SMP configurations.
Bur for SMP configurations, this would be broken.

I don't think the rust language cares that though. Doing this kind of
modification from multiple execution contexts without synchronization is
always UB in rust.


BR Andreas


