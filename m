Return-Path: <linux-kernel+bounces-551271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E76A56A50
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C99189B52C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E13D21C17F;
	Fri,  7 Mar 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j3t4W7sl"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF6B21ADD6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357535; cv=none; b=O1qKZDJKQtl20xSz7n01bhKNKJlT/gWlBEy1fKHScuFU/RGXJb1SyPAbTWBGJl9gcvJ7RN4LSu/BCrxby4ibTNmvI5xeyF2TZ8R9M+7JxHIGT3Bgh2LJOIJ0VUkyWSizJnosrW08PSAmGbDsSNq/tUzJsEhRihBpxZnJykbU3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357535; c=relaxed/simple;
	bh=2Lz/YT0dAJcIe3LvHXqUJ+5fEKYlZ7dzJES1cIVQqzM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFWiD0+MAjS6jarMUmLXI/X/mWqnx50yorQ3VyeXHbADfgRjXrO1CwP0PiNi5NtY3uKbZsP+v8UTofKy6UxQggpplMuBgroVrViAgIcmsjtED2W3PQprFl9gXnLH5ri21erqTT0yzLV8cYrQTaSFHcXpHB5xLCrv4mnHjbMkhN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j3t4W7sl; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=37m4ecngtjhfpi7pjsnirjaagq.protonmail; t=1741357530; x=1741616730;
	bh=XLr7YhQshyfQf6d3k7XvIYgwSMk4ZzLpOKlpv74Y9B0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=j3t4W7slXIuOZ1wLVjU9zNfUfTkF+4u3PHySvksAxaDa/lqy6ZSJVaewYv92MTyvg
	 d6Nu4BgIjZdGU8mMTCz54h2UYNZbMWSPimiGWbXJ9NdXHbSphQlFhnKIxV9XCgxiIj
	 TjacaSNcogRjQyUvR2upZTOzjpx9i1thAO9zioRIxGQevcoV1EegzYSWj92kS24FfV
	 TR4I+ZvNCB+kjX/b+7oabJHoCfWMy7oZ7uCDfV0xwPUrtE/Vs1eumn77GXCPecW49F
	 jnd5NA0rV6SwxEiPRf+ZTgFmSUn/ogsSRVE8M2RRXlTm9OGPA17Ijbj03XWXSSSxXh
	 weNp0LJoOvnwQ==
Date: Fri, 07 Mar 2025 14:25:24 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&T>`
Message-ID: <D8A3PZPLKPA0.1CWNFJG4RSWKE@proton.me>
In-Reply-To: <87ikok3or8.fsf@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-7-0cf7e9491da4@kernel.org> <6-QyjoxR_6TYuJVEXwdFAZrhFz52ZDU_4-r64epTLFpOAMc3jM_REWS-v_7TzdcgYmq1j74UmTnhYW5HdT98bQ==@protonmail.internalid> <D8A25UNDIJHK.216EX6YG4EJ6E@proton.me> <87msdx3qsg.fsf@kernel.org> <MAOSH8H2lF5xrSfp-bnsmnF6Cw0BeJaotLwkrEDKvOki2VxkUP4yazYV7vRrxa1DZhg2g_Enxlkb9lF_mC2TiQ==@protonmail.internalid> <D8A2ZPH3TSGK.IZ41SSRCL37@proton.me> <87ikok3or8.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3ad981e282e5dd4f5618e482cb50cd67cfa9df8b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 3:21 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On Fri Mar 7, 2025 at 2:37 PM CET, Andreas Hindborg wrote:
>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>>>> +impl<'a, T> RawHrTimerCallback for Pin<&'a T>
>>>>> +where
>>>>> +    T: HasHrTimer<T>,
>>>>> +    T: HrTimerCallback<Pointer<'a> =3D Self>,
>>>>> +{
>>>>> +    type CallbackTarget<'b> =3D Self;
>>>>> +
>>>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> binding=
s::hrtimer_restart {
>>>>> +        // `HrTimer` is `repr(C)`
>>>>> +        let timer_ptr =3D ptr as *mut HrTimer<T>;
>>>>> +
>>>>> +        // SAFETY: By the safety requirement of this function, `time=
r_ptr`
>>>>> +        // points to a `HrTimer<T>` contained in an `T`.
>>>>> +        let receiver_ptr =3D unsafe { T::timer_container_of(timer_pt=
r) };
>>>>> +
>>>>> +        // SAFETY: By the safety requirement of this function, `time=
r_ptr`
>>>>> +        // points to a `HrTimer<T>` contained in an `T`.
>>>>
>>>> This justification seems wrong it talks about `HrTimer<T>`, but here w=
e
>>>> have a `*const T`... Also see [1] (I am mainly interested in your
>>>> justification for the lifetime).
>>>>
>>>> [1]: https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference=
-conversion
>>>
>>> How is this:
>>>
>>>         // SAFETY:
>>>         //  - By the safety requirement of this function, `timer_ptr`
>>>         //    points to a `HrTimer<T>` contained in an `T`.
>>>         //  - The `PinHrTimerHandle` associated with this timer is guar=
anteed to
>>>         //    be alive until this method returns. As the handle borrows=
 from
>>>         //    `T`, `T` is also guaranteed to be alive for the duration =
of this
>>>         //    function.
>>
>> Sounds good, if you can also explain (probably somewhere else, as every
>> `RawHrTimerCallback` implementer will rely on this) why the handle lives
>> for the duration of the callback.
>
> It is in the safety requirement for the `HrTimerHandle` trait already.
> Should I reference it here?

Yes please!

---
Cheers,
Benno


