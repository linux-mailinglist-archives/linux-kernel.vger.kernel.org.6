Return-Path: <linux-kernel+bounces-416034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04679D3F66
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456C01F23AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62D715534B;
	Wed, 20 Nov 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrbMvjyx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F02B155303;
	Wed, 20 Nov 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117935; cv=none; b=pDHSF4a0jt33h3AlFBE1P2b6QdpD26XTWY17JDyJcDS/v0C7/I7jEQvUV7c517T+2iK7VZXp/Pd6iAQPQdc6mkk8diveKKn6vjwaPlWxYSzmrloZdniboMzz08dcxVSccvKhVG2sLxriKVNJII3s59d/p673E7z4UjiLjMLNdPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117935; c=relaxed/simple;
	bh=n8TDtoDD+tY39h2LivsDQa4bXgXGn/UExsse2WuBgxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=URaKp4b5FR2fLI+rusoyft3JIVWIFSVbipOQqK2gWLNw7bDXrCPZlKGXLu61ifP1big6YUn/+91QVToGxuQjoHGCZ6oeLfQ4ruWCeYLaiWo+kSWLaLH0CsLgg50+RzKLIowvhnVxDHsaCk68Fsis8lTKh45wIM06T7cGdrc3wd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrbMvjyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89423C4CED1;
	Wed, 20 Nov 2024 15:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732117934;
	bh=n8TDtoDD+tY39h2LivsDQa4bXgXGn/UExsse2WuBgxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PrbMvjyxDM0sLc5hnKcDHnO4ldyXvy9h29JWu1Pgh9oqJOF1JIA+nkhFgYZtcaXIA
	 P7fHGCvAlliXsixRsqDLhEBu65Lt7gvkk3jGkeBEIdbMjWQlrgjxGJHFm1ZnWCzhUB
	 /1bu0ZcxSZ5pY0Jt5ZXtroa1xwI3ailVJgRqWFfbvOXGZd44XHgQZIwoVE0FP9mfH8
	 2ObtxV7yKQBkDs7AMbEFoF334ML+3JHBdViNBv+8tfQvY6icik5ROHs17Iug+YeYCu
	 15oxCIbbMFF5Q4YMQ3+jPYR7K6g5NF5FkhPfyOQ62gObIUFSQmaRzV6eQdMDF3Hu2c
	 F9B8a2DoN/o8A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 06/13] rust: hrtimer: add `UnsafeTimerPointer`
In-Reply-To: <3a94c12f91964c5c89476bb2376a7489ccc0d154.camel@redhat.com>
	(Lyude Paul's message of "Wed, 13 Nov 2024 18:27:32 -0500")
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
	<20241017-hrtimer-v3-v6-12-rc2-v3-6-59a75cbb44da@kernel.org>
	<BODmd-cUvAXxw85e-6--Q9NlnO46gnUA1rG7m0h_FlQun_CcEYHCLMHV8VhjTkF1Cv5rAtridN3PNhqip0mBFw==@protonmail.internalid>
	<3a94c12f91964c5c89476bb2376a7489ccc0d154.camel@redhat.com>
Date: Wed, 20 Nov 2024 16:25:07 +0100
Message-ID: <87zflu2ai4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Thu, 2024-10-17 at 15:04 +0200, Andreas Hindborg wrote:
>> Add a trait to allow unsafely queuing stack allocated timers.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/hrtimer.rs | 33 +++++++++++++++++++++++++++++++++
>>  1 file changed, 33 insertions(+)
>>
>> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
>> index eeed2afd501b64b94d57cc658616659e28785078..e97d7b8ec63ce6c9ac3fe9522192a28fba78b8ba 100644
>> --- a/rust/kernel/hrtimer.rs
>> +++ b/rust/kernel/hrtimer.rs
>> @@ -151,6 +151,39 @@ pub trait TimerPointer: Sync + Sized {
>>      fn start(self, expires: Ktime) -> Self::TimerHandle;
>>  }
>>
>> +/// Unsafe version of [`TimerPointer`] for situations where leaking the
>> +/// `TimerHandle` returned by `start` would be unsound. This is the case for
>> +/// stack allocated timers.
>> +///
>> +/// Typical implementers are pinned references such as [`Pin<&T>].
>
> Missing a `

Thanks! I wonder why this is not caught when building the docs.


Best regards,
Andreas Hindborg




