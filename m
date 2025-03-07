Return-Path: <linux-kernel+bounces-551268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9EBA56A48
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48718164DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503C21B9DA;
	Fri,  7 Mar 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Gv2ZUzEE"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F056B18DF65;
	Fri,  7 Mar 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357484; cv=none; b=qM2z83zDZanoKOs6lqXj01Nd8ViIRaFQ4DEPtbFZmX1ZbUOgUQbNuqtT+r2sQcYvocBvJYq5dII7ow3mYMQimpHoN91iYdgcUXx68bQrvU0qSxF3FampZ2VzP9BDti6oUYASzLTkN5JfOuEqLO5nlknWOYRnbyk7Cd/BPZEgNo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357484; c=relaxed/simple;
	bh=0ivBtm88OhtMMsvzZ6gveDwR1IczACnoVY8KLwPymM4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+rlKgMgZVUyRfIKEQxwv8SvlC4V3ukRbdQKzwC90QvOkuCAiU9GY+Ftb513wM4QfSkuY8e79R41i1jPIDeUqMmftvTToWr5yc6j13dhtOrmdmUeDvW5nIa0G6/xk6d/AKNL5DcRc/rKcZQaexfCUMGJZFLfnUVosMMekFc83bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Gv2ZUzEE; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741357480; x=1741616680;
	bh=KqthcJVrewmtu1xtlHXM3b3KzDBBgkcXCjltCDAKMr8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Gv2ZUzEEhNz24nrFdExvPJGxZrGl9yZQdPcjukALo+vcSuGSARQqR4bWDnktJ5HyW
	 NFyP9TIHP/EP6Tv2MWQ0pCpuCPVVWxdHDXzHU7a6t8qXR7Uo1KXBxvzsklaaL49BCY
	 UTEJR7U4Rx/qY7W1ZpF/BnQVGU2kK4hcXGsIY3X91FyuuSaoIzRwCcyIraIOw1/MUc
	 d3arcR8d3x7x9OlPN+wiqA18I0/9e/7pKTiC2OY9QeO0n5JzCSIUbIAuoKSlGst4EB
	 liXOBsrPhdF7E+FKhClwcpaB8rgCuDZM6iAvdYXU34C3T4eTH/h7vdmvXSpl4904gi
	 QILDEnxgSj/QQ==
Date: Fri, 07 Mar 2025 14:24:32 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/13] rust: hrtimer: implement `HrTimerPointer` for `Arc`
Message-ID: <D8A3PCB7F5L8.36WN92Y4Y9AP9@proton.me>
In-Reply-To: <87zfhx2afi.fsf@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-3-0cf7e9491da4@kernel.org> <b-T-Yv_oexMXaKG9kNNfbYz-Qaw1XhJw-VHerSPFp_sIMoztNyAj94_rH-uNYeG-Hc5WANUivDJW9WLmfZZHwA==@protonmail.internalid> <D8A1Z043VPGR.2OBGSBH1ALUL6@proton.me> <87senp3r9b.fsf@kernel.org> <4ZAkOKT4__IQstGGnVAvkCTx_eb_sQwehN8od8rozgp_hijMhU83a7AOm9PD2WV8AuamjQxz_U1abZVWKY-zDA==@protonmail.internalid> <D8A2O5QBXCRI.18W3W0EDI3UXZ@proton.me> <87zfhx2afi.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a5b9ed01667193288f8ed54b88ac9c8b3c1513c7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 3:16 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On Fri Mar 7, 2025 at 2:27 PM CET, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>>>> +impl<T> RawHrTimerCallback for Arc<T>
>>>>> +where
>>>>> +    T: 'static,
>>>>> +    T: HasHrTimer<T>,
>>>>> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Self>,
>>>>> +{
>>>>> +    type CallbackTarget<'a> =3D ArcBorrow<'a, T>;
>>>>> +
>>>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> binding=
s::hrtimer_restart {
>>>>> +        // `HrTimer` is `repr(C)`
>>>>> +        let timer_ptr =3D ptr.cast::<super::HrTimer<T>>();
>>>>> +
>>>>> +        // SAFETY: By C API contract `ptr` is the pointer we passed =
when
>>>>> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a =
`T`.
>>>>> +        let data_ptr =3D unsafe { T::timer_container_of(timer_ptr) }=
;
>>>>> +
>>>>> +        // SAFETY: `data_ptr` points to the `T` that was used to que=
ue the
>>>>> +        // timer. This `T` is contained in an `Arc`.
>>>>
>>>> You're not justifying all safety requirements of `ArcBorrow::from_raw`=
.
>>>
>>> How is this:
>>>
>>>         // SAFETY:
>>>         //  - `data_ptr` is derived form the pointer to the `T` that wa=
s used to
>>>         //    queue the timer.
>>>         //  - The `ArcTimerHandle` associated with this timer is guaran=
teed to
>>>         //    be alive for the duration of the lifetime of `receiver`, =
so the
>>
>> There is no `receiver` in this context?
>
> It's the value returned from the call, same line.

Ah my bad.

>
>> Is the reason for the handle staying alive that when it is dropped, it
>> calls `cancel` and that waits until the callback finishes? If so, did
>> you write that down somewhere here?
>
> Yes, it is in the safety requirement of the `HrTimerHandle` trait.
> Should I add that? It becomes quite a story.

Yeah, I think you should add it.

---
Cheers,
Benno

>>>         //    refcount of the underlying `Arc` is guaranteed to be nonz=
ero for
>>>         //    the duration.
>>>         //  - We own one refcount in the `ArcTimerHandle` associted wit=
h this
>>>         //    timer, so it is not possible to get a `UniqueArc` to this
>>>         //    allocation from other `Arc` clones.
>>
>> Otherwise this sounds good.
>
> Cool.
>
>
> Best regards,
> Andreas Hindborg



