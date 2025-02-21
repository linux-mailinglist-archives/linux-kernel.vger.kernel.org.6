Return-Path: <linux-kernel+bounces-525461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE2A3F045
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E987A7026
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B7F204689;
	Fri, 21 Feb 2025 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngSkxSlA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98B204694;
	Fri, 21 Feb 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130201; cv=none; b=qbToUiGGrEkGoJL95p3uoJtA00ONnRQxVrbEtitcaudAjWF2KDVs2gwvSVWo21Xxw3kwSAIJ6zGt4785WZMOjnIFq+4wdVCMYaA9YXyBFFgXE7TIQdeV85UovcaEBa9Ctc6+JOyianej5vskCZYmXd14/KhoMTrCtex88odkOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130201; c=relaxed/simple;
	bh=eqLK3ra14XLYrfaqhIcYJC/a9P28HWXtZP1xIyta5/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idBnpfCdHeiev82zbgML+Pt1BaQecHUbjS2Xd/zYXJhMQhq8xyHglb5tfBeJPOdrVVQWEjymT+M+PXGb/vOt80WSTdRMFK1reXWcWSxISmQIDxkYI0Fphldfh0C+ja1rnWn1Y5R1/zOgCU9UnZMFLvZP5oR9JMKR50Mz157n/+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngSkxSlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D5CC4CED6;
	Fri, 21 Feb 2025 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130200;
	bh=eqLK3ra14XLYrfaqhIcYJC/a9P28HWXtZP1xIyta5/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ngSkxSlAwaYUSgJEaTdTOF7e/F+17fYvfjCR3PI5Fgb7+EuNdz2SWgKYTNtvpnyjQ
	 gh340MYkMg6JgSJGDbLjY574qZCYnWdRgsJjun78pkW8KkhVuTlzKe/YRHJFuy3UwA
	 xTl7A1Jawgrgmsdut8oraueW1cVVQpz6B52fxUFQfl491XbCZVoNbSdmN8RKgZgjzu
	 3bZZ9019WgfA763qPXoKhxNQ1pa2unjB32BDztT47iGxg/SLr26kkiLKNaVj9IrLJD
	 VcktQB7tDjv0XXGzQJ++eQSAxujXs5Sa8+Bls9fxdjAywCldg38sJJ1w/NCEq7EEgf
	 E6YggpKIge25g==
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
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 05/14] rust: hrtimer: allow timer restart from timer
 handler
In-Reply-To: <8e32c3e1-0b55-4809-92ad-f968252a05f8@proton.me> (Benno Lossin's
	message of "Thu, 20 Feb 2025 23:47:30 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-5-48dedb015eb3@kernel.org>
	<F56YWuamHrpLM1KaPiwECr4Ta19VkAWdbhcMhII5pfM1kSjl3_RAR6elrNAjL6ZqVurGdjj1Fn-0wyfZNDHKRg==@protonmail.internalid>
	<8e32c3e1-0b55-4809-92ad-f968252a05f8@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 10:09:15 +0100
Message-ID: <87y0xzfyv8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.02.25 14:27, Andreas Hindborg wrote:
>> This patch allows timer handlers to report that they want a timer to be
>> restarted after the timer handler has finished executing.
>>
>> Also update the `hrtimer` documentation to showcase the new feature.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs     | 28 +++++++++++++++++++++++++++-
>>  rust/kernel/time/hrtimer/arc.rs |  4 +---
>>  2 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index b2a3130bc21d7..e342193f985eb 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -183,7 +183,7 @@ pub trait HrTimerCallback {
>>      type CallbackTargetParameter<'a>;
>>
>>      /// Called by the timer logic when the timer fires.
>> -    fn run(this: Self::CallbackTargetParameter<'_>)
>> +    fn run(this: Self::CallbackTargetParameter<'_>) -> HrTimerRestart
>>      where
>>          Self: Sized;
>>  }
>> @@ -278,6 +278,32 @@ unsafe fn start(self_ptr: *const Self, expires: Ktime) {
>>      }
>>  }
>>
>> +/// Restart policy for timers.
>> +pub enum HrTimerRestart {
>> +    /// Timer should not be restarted.
>> +    NoRestart,
>> +    /// Timer should be restarted.
>> +    Restart,
>> +}
>> +
>> +impl From<bindings::hrtimer_restart> for HrTimerRestart {
>> +    fn from(value: u32) -> Self {
>> +        match value {
>> +            bindings::hrtimer_restart_HRTIMER_NORESTART => Self::NoRestart,
>> +            _ => Self::Restart,
>> +        }
>> +    }
>> +}
>> +
>> +impl From<HrTimerRestart> for bindings::hrtimer_restart {
>> +    fn from(value: HrTimerRestart) -> Self {
>> +        match value {
>> +            HrTimerRestart::NoRestart => bindings::hrtimer_restart_HRTIMER_NORESTART,
>> +            HrTimerRestart::Restart => bindings::hrtimer_restart_HRTIMER_RESTART,
>> +        }
>> +    }
>> +}
>
> Do drivers need these impls? If no, I would prefer a private conversion
> function just for the abstraction.

No, drivers would not need these. I can hide them.


Best regards,
Andreas Hindborg



