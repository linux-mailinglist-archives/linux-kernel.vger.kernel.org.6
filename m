Return-Path: <linux-kernel+bounces-532655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FEEA45063
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7A13B51B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C64821E08A;
	Tue, 25 Feb 2025 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gAmHrLj+"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBCA220685
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523134; cv=none; b=DOQFonuRmbDiCxIYuI3A9D7jBo2AwEckbg5kdm6Gqje0BEGALvqVDtFviKMHFMpdcL3sNotL6TMvmcvOwHPSdujurfwD25Kt75xTVIAaPi+oxONnCCb2uFXijjtUuN0ChuCAsK6tUgVBk7mb8HQtrG4vK99c2aQZvKdK7UINyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523134; c=relaxed/simple;
	bh=w5FW7h/yUxboAaOc5OmV7ZmGXIvSw/HF/DLPTQh4ppM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhfrhDdKjMeaFxymJi2kKDASPyCpluhgJ9W68c4XSO3OUpBy+0yRzPS+7obSQiaAAelfL8Uqst3V5bLS4OjzAIh8cY1L3Cs8J88+XUjrG11TSis6b1RxJhG1RAf7XTvvox55TTBvmFqo0/phz4CjbMq8G+2SrMQ5vWgn0wH992Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gAmHrLj+; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740523124; x=1740782324;
	bh=88Qb5r2k24m8btzn9eRsnUKvo0/OE1vp3DxskSMq4Qg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gAmHrLj+KfQkCTEdh+DOiXcCKFV5Ulsx0PaafwD45BjxA2iTzS7TStN11kEiKSXYA
	 NyrDhx1CZsEfgCo0PRw4AWufeOo8DblBe8rrS+WVREU11hNkMIxggLexoASEdkjep1
	 p/U89hmPzjzYFaJjqw66Ud+CkFENTU3UUN0og5V5kqdOxMva6H/wR+VKlBojn5Vw1K
	 /HwCQ66sz2RRKvZjy1fwUBBk++DHO8VmuR0D8qojxJH8c6hkwiGb4lkLp+6/ekZ0J1
	 d4Lur9lMwJ6vb5aMgnGxAMNR+y5wWqofeWJWVBXRWFFsOstGDdPgo2viiE3dgISHw+
	 aL2fo83/WdXTw==
Date: Tue, 25 Feb 2025 22:38:38 +0000
To: Ventura Jack <venturajack85@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Gary Guo <gary@garyguo.net>, Linus Torvalds <torvalds@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <137dd7ef-b8f6-43df-87e0-115f913d0465@proton.me>
In-Reply-To: <CAFJgqgTs3h5YagY1RU2AZf3wKWKfXiPTE2mx7CuWyzN=ee-k3g@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250224002745.7d7460a7.gary@garyguo.net> <CAFJgqgSNjF=LfrCNTH3GdYssXz9YG-AeCtpibejJ7Ywtx0m3HQ@mail.gmail.com> <4cb1d98b-f94b-410a-be90-4394c48bdbf2@proton.me> <CAFJgqgQ3P81-iskGu9R+T=c=wyB2K0JqUhx+Gj+6mkYeY8-ORg@mail.gmail.com> <a4b79751-f1c8-4476-98a5-c59fb2e545ad@proton.me> <CAFJgqgRdiQ29bWvwsu11yokZb4OFF7pYYUU=ES6CYv9847KgVg@mail.gmail.com> <c05cb400-969d-44a1-bd40-9b799ed894d7@proton.me> <CAFJgqgTs3h5YagY1RU2AZf3wKWKfXiPTE2mx7CuWyzN=ee-k3g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 259cf80a5554941d7ef56c78bfbc5d5f5e50fff5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.02.25 00:04, Ventura Jack wrote:
> On Mon, Feb 24, 2025 at 3:03=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 24.02.25 17:57, Ventura Jack wrote:
>>> One example I tested against MIRI:
>>>
>>>     use std::cell::UnsafeCell;
>>>
>>>     fn main() {
>>>
>>>         let val: UnsafeCell<i32> =3D UnsafeCell::new(42);
>>>         let x: & UnsafeCell<i32> =3D &val;
>>>         let y: & UnsafeCell<i32> =3D &val;
>>>
>>>         unsafe {
>>>
>>>             // UB.
>>>             //let pz: & i32 =3D & *val.get();
>>>
>>>             // UB.
>>>             //let pz: &mut i32 =3D &mut *val.get();
>>>
>>>             // Okay.
>>>             //let pz: *const i32 =3D &raw const *val.get();
>>>
>>>             // Okay.
>>>             let pz: *mut i32 =3D &raw mut *val.get();
>>>
>>>             let px: *mut i32 =3D x.get();
>>>             let py: *mut i32 =3D y.get();
>>>
>>>             *px =3D 0;
>>>             *py +=3D 42;
>>>             *px +=3D 24;
>>>
>>>             println!("x, y, z: {}, {}, {}", *px, *py, *pz);
>>>         }
>>>     }
>>>
>>> It makes sense that the Rust "raw pointers" `*const i32` and `*mut
>>> i32` are fine here, and that taking Rust "references" `& i32` and
>>> `&mut i32` causes UB, since Rust "references" have aliasing rules that
>>> must be followed.
>>
>> So it depends on what exactly you do, since if you just uncomment one of
>> the "UB" lines, the variable never gets used and thus no actual UB
>> happens. But if you were to do this:
>=20
> I did actually test it against MIRI with only one line commented in at
> a time, and the UB lines did give UB according to MIRI, I did not
> explain that.

I do not get UB when I comment out any of the commented lines. Can you
share the output of MIRI?

---
Cheers,
Benno

> It feels a lot like juggling with very sharp knives, but
> I already knew that, because the Rust community generally does a great
> job of warning people against unsafe. MIRI is very good, but it cannot
> catch everything, so it cannot be relied upon in general. And MIRI
> shares some of the advantages and disadvantages of sanitizers for C.
>=20
> Best, VJ.


