Return-Path: <linux-kernel+bounces-525580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEA4A3F19F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DF17A9F66
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93FD205E11;
	Fri, 21 Feb 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="llpjHVYH"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5E1FECC2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132926; cv=none; b=UIi7Xca/D4j87P953C16XgZX0vFqG5mB/401pxOOqqJiobuhC7RwBZjdmHPjEqjUv9gCJwB0/9bkxRpdTBxAWLW+k4bF+RSTYq4ET4gtLJz/TgC9whVVNngOMigX8acS40jsZ6iX82+C5AgKvZkeTEB6lJ1d/r9s1l8GvvUKFOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132926; c=relaxed/simple;
	bh=pYlG2WV/q5fgqaIrf4eiL8NfB35rdADEB88ims0ixMs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzQwVVZ0LkFzccA69pI8eGbl/rgmdgtJBA8LGDC0btvOBsDbvXiL1wjp9ulYPjpv6oxGBOBwQ9QmEGKlNVKjm156QLlT3VAhahk0wUvOYB6w70mztVWoeL604YaF+OlC+o7uarV1deNBUBdCsuNj6dDa7QSBME9ljrDvFiC7Nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=llpjHVYH; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740132921; x=1740392121;
	bh=utLG4Pvkh7OuzllYzzEViXcvOHNbmHD6EALvUcEmpus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=llpjHVYHqo+8Fpbh2ZQxl3c6jV1AX1pd4gDGXe5EFrGHsKrGA/vl2m9cu5cFgp4+h
	 ZGmKLsUeNjDJVinEOJZ3rGhaOESB4tWNatofQVmefIxj1KQOvdye2hQA0TyOCoTN5A
	 xcgtLMZgRS5nNB6QQI2h0oGQrxSSiGE5WRjTZtKSKm6K83IWg8ynq5gvfrkUJStpqW
	 epZZ4CpWakuIH1JEyhFEwr7ZSP61+b5j4QbiLaTcrng49rcrbKINu4xDmajejh5V5T
	 tuKCoXqbpyN212iavjvek8plF7iechTHnE6yMeld0BNWmAG4TNrLsrQHKI9CCY0RRB
	 T4Eo9f0oyYjHQ==
Date: Fri, 21 Feb 2025 10:15:16 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 05/14] rust: hrtimer: allow timer restart from timer handler
Message-ID: <7536dcf0-ed86-48ab-af35-bf86fcdc5601@proton.me>
In-Reply-To: <87y0xzfyv8.fsf@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-5-48dedb015eb3@kernel.org> <F56YWuamHrpLM1KaPiwECr4Ta19VkAWdbhcMhII5pfM1kSjl3_RAR6elrNAjL6ZqVurGdjj1Fn-0wyfZNDHKRg==@protonmail.internalid> <8e32c3e1-0b55-4809-92ad-f968252a05f8@proton.me> <87y0xzfyv8.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fbbba1720b3bf99016645cb74a0b38280a71e469
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.02.25 10:09, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>> This patch allows timer handlers to report that they want a timer to be
>>> restarted after the timer handler has finished executing.
>>>
>>> Also update the `hrtimer` documentation to showcase the new feature.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>  rust/kernel/time/hrtimer.rs     | 28 +++++++++++++++++++++++++++-
>>>  rust/kernel/time/hrtimer/arc.rs |  4 +---
>>>  2 files changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>> index b2a3130bc21d7..e342193f985eb 100644
>>> --- a/rust/kernel/time/hrtimer.rs
>>> +++ b/rust/kernel/time/hrtimer.rs
>>> @@ -183,7 +183,7 @@ pub trait HrTimerCallback {
>>>      type CallbackTargetParameter<'a>;
>>>
>>>      /// Called by the timer logic when the timer fires.
>>> -    fn run(this: Self::CallbackTargetParameter<'_>)
>>> +    fn run(this: Self::CallbackTargetParameter<'_>) -> HrTimerRestart
>>>      where
>>>          Self: Sized;
>>>  }
>>> @@ -278,6 +278,32 @@ unsafe fn start(self_ptr: *const Self, expires: Kt=
ime) {
>>>      }
>>>  }
>>>
>>> +/// Restart policy for timers.
>>> +pub enum HrTimerRestart {
>>> +    /// Timer should not be restarted.
>>> +    NoRestart,
>>> +    /// Timer should be restarted.
>>> +    Restart,
>>> +}
>>> +
>>> +impl From<bindings::hrtimer_restart> for HrTimerRestart {
>>> +    fn from(value: u32) -> Self {
>>> +        match value {
>>> +            bindings::hrtimer_restart_HRTIMER_NORESTART =3D> Self::NoR=
estart,
>>> +            _ =3D> Self::Restart,
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +impl From<HrTimerRestart> for bindings::hrtimer_restart {
>>> +    fn from(value: HrTimerRestart) -> Self {
>>> +        match value {
>>> +            HrTimerRestart::NoRestart =3D> bindings::hrtimer_restart_H=
RTIMER_NORESTART,
>>> +            HrTimerRestart::Restart =3D> bindings::hrtimer_restart_HRT=
IMER_RESTART,
>>> +        }
>>> +    }
>>> +}
>>
>> Do drivers need these impls? If no, I would prefer a private conversion
>> function just for the abstraction.
>=20
> No, drivers would not need these. I can hide them.

Sounds good, you can add:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


