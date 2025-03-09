Return-Path: <linux-kernel+bounces-553055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F372EA582E7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B45D164AE0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F79F1B3957;
	Sun,  9 Mar 2025 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQRt95xC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B0917A319;
	Sun,  9 Mar 2025 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514955; cv=none; b=BZmzy1hEFvqDCGwivI9X3goYlUrZweEJPdmpre12HKG0HPiQhe62mDhnaT9+WMejVZFMifm7LzM+3OJQk/jEykROH/4v7fNMrB6F9C+IMEW6pFsOFt/YzosF+VHe4J3lfBq0QLUmCXlgRgJPH6Z//5/TXPuL/4n3oClL4yhPHA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514955; c=relaxed/simple;
	bh=C+xJjy9a26xtFek9Ow+eRfDFQ+TSQpx/FEE82qaeMGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmiFx16t2N6nL2FSWzD3XprjQLgTXlu1DnfJ7aN0TVpKLz9XfAvZKiuB1TKSMpZ2CFQGhAhm5jMUKWdQwnqdbMz0rshNwz5LB6weHoa6BLVM1nBTIdjaZJGkt9RXJUu31TJ1vYbVmvuQe6DocVLJ8GnVOH6OGOSUJKSS7iXTD/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQRt95xC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7925C4CEE5;
	Sun,  9 Mar 2025 10:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741514955;
	bh=C+xJjy9a26xtFek9Ow+eRfDFQ+TSQpx/FEE82qaeMGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AQRt95xC+vKHVwna4eEQQbF3pqShSVfVlquCNh3I0Bg1FWTznowlP15s9nRDBD9Ct
	 rdCvuJUL84sqpIx3zNq2umd9Np3ZA7GAxqF0+yPsiUr0QL1s6RS67+V4SHwCYced1G
	 j2LHc4TEWH8kTdgE062oWVwDRduOZ4MBeAnGSDuSrqlBPQT3Uh/AL1fjFE8NIAbgkH
	 i7TjWbE4uiNNQqdFGc9dqTbSzzwTEhuYHX6C/vu7ORxyDvgjMFfvVLuFYQJQwIjj5S
	 JsTYkk3OzPtK08iBQaEfMkxIo26uSbkmGhrRrgKMxs2oLsEsB4VAsk3wkJW5541DOh
	 zI5JDH2NYyqsw==
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
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 08/13] rust: hrtimer: implement
 `UnsafeHrTimerPointer` for `Pin<&mut T>`
In-Reply-To: <D8BNFIK9U108.273II0I7NZUG1@proton.me> (Benno Lossin's message of
	"Sun, 09 Mar 2025 10:04:42 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v11-8-7934aefd6993@kernel.org>
	<bDmFMydggU4eq3yBLbESIOZQnfZkIfJiEPrrTwTTONi5iaT-ssC4Q0TQ1Wljr2k6PfTCfh2TYMEmj5KGN4FxGA==@protonmail.internalid>
	<D8BNFIK9U108.273II0I7NZUG1@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sun, 09 Mar 2025 11:08:59 +0100
Message-ID: <87frjmldms.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 10:38 PM CET, Andreas Hindborg wrote:
>> +impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
>> +where
>> +    T: HasHrTimer<T>,
>> +    T: HrTimerCallback<Pointer<'a> = Self>,
>> +{
>> +    type CallbackTarget<'b> = Self;
>> +
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
>> +        // `HrTimer` is `repr(C)`
>> +        let timer_ptr = ptr as *mut HrTimer<T>;
>> +
>> +        // SAFETY: By the safety requirement of this function, `timer_ptr`
>> +        // points to a `HrTimer<T>` contained in an `T`.
>> +        let receiver_ptr = unsafe { T::timer_container_of(timer_ptr) };
>> +
>> +        // SAFETY:
>> +        //  - By the safety requirement of this function, `timer_ptr`
>> +        //    points to a `HrTimer<T>` contained in an `T`.
>> +        //  - As per he safety requirements of the trait `HrTimerHandle`, the
>> +        //    `PinMutHrTimerHandle` associated with this timer is guaranteed to
>> +        //    be alive until this method returns. As the handle borrows from
>> +        //    `T`, `T` is also guaranteed to be alive for the duration of this
>> +        //    function.
>
> Ah one more thing, I don't think that the second part is needed (i.e.
> that `T` is alive). How about:
>
>         //  - As per the safety requirements of the trait `HrTimerHandle`, the `PinMutHrTimerHandle`
>         //  associated with this timer is guaranteed to be alive until this method returns. That
>         //  handle borrows the `T` behind `receiver_ptr` mutably thus guaranteeing the validity of
>         //  the reference created below.

OK.

>
> Can you also adjust the other instances of this in the other patches?
> Thanks!

Yes!


Best regards,
Andreas Hindborg



