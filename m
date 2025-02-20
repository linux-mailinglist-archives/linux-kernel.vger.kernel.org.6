Return-Path: <linux-kernel+bounces-523946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9F2A3DD26
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B507AC042
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16871FCFFB;
	Thu, 20 Feb 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="szi5hDdF"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C248E1F8AE5;
	Thu, 20 Feb 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062452; cv=none; b=DpmfAVl3qP0frs8hS1cACsoMJ98bHg+0IM79HtHBPc976cfRq30c6JsEEXAR1hWEsDzOHxoDNqiHeZAk/GqwmnXVX5bpJ+5iaaOMPylZSxyQgBvliisn1SdwJWYUUfEd7tLIkf23Z69Z+PdqXOK7xYfAAu+K4dDFdZG4QOmQWOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062452; c=relaxed/simple;
	bh=IBHb0xhy/Vz/yCAtJf68B3zsc2IBnauKNXtm7Hq7SR8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DYcVZGBW/RPH0jeluTfvzBoG/csG71VpXClF9Yrwn/bm3KokR7Fwx6J075JiusR/fDklkbjnacCJ+JoUQDRNZGcTzA4CgP9HipT5/PgKKA1lYpLpQRkCQEDxr883At/AQaepAfdc+bnutpXyJhBum7idz8T37uRmfiROYbus74w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=szi5hDdF; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51KEcK4P2238927
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 20 Feb 2025 06:38:21 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51KEcK4P2238927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740062301;
	bh=09AX5hzejmVf61n1uIS4Ec7rPnID14l13a6oxb//yAU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=szi5hDdF/eY3Sns+sNZsPc1qCtGN0TNNz0Zhrr+oqfHpDINzHeWo8y9nCmqO/xJSx
	 dAWerVAi68XcQB+64pxJz0w0Wqtck0nvNc084eTPLcgk45hyGL6+EMKsiovT5P8uwQ
	 DI7dSWXtB81+xQ8+07N3MWuCfcdfacAqREXmWZFVrPZJj0bmi4NCzsoEAaEyCtMoHQ
	 GgwyTAb2ek4BiZziof1g0nAmtPzE+t4s28nqDlo96Tp0nu/C4dYVnXFqN/UDpUDbJG
	 FUQQSQecqKc4a9NhMPqPhM32sqK1QDR5XxlqXOUSlB4GndOZJWCpGwN/FbwbR0fC5o
	 JoCeD1azyHDpQ==
Date: Thu, 20 Feb 2025 06:38:20 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Martin Uecker <uecker@tugraz.at>, Dan Carpenter <dan.carpenter@linaro.org>
CC: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        ksummit@lists.linux.dev, Justin Stitt <justinstitt@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Rust kernel policy
User-Agent: K-9 Mail for Android
In-Reply-To: <1f31a16d3898e0e9b5d94f9bcc12a1b73ac97982.camel@tugraz.at>
References: <Z7SwcnUzjZYfuJ4-@infradead.org> <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com> <326CC09B-8565-4443-ACC5-045092260677@zytor.com> <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com> <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh> <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at> <2025022024-blooper-rippling-2667@gregkh> <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at> <962fa158-5315-4d93-afb1-8a1c08787ad8@stanley.mountain> <1f31a16d3898e0e9b5d94f9bcc12a1b73ac97982.camel@tugraz.at>
Message-ID: <58959F5F-2207-4FE0-A077-273493F2D9EF@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 20, 2025 6:09:21 AM PST, Martin Uecker <uecker@tugraz=2Eat> wro=
te:
>Am Donnerstag, dem 20=2E02=2E2025 um 16:46 +0300 schrieb Dan Carpenter:
>> On Thu, Feb 20, 2025 at 09:57:29AM +0100, Martin Uecker wrote:
>> > In particulary, I have a relatively concrete plan to have a memory sa=
fe
>> > mode for C that can be toggled for some region of code and would make
>> > sure there is no UB or memory safety issues left (I am experimenting =
with
>> > this in the GCC FE)=2E=C2=A0 So the idea is that one could start to a=
ctivate this
>> > for certain critical=C2=A0regions of code to make sure there is no si=
gned
>> > integer overflow or OOB access in it=2E
>>=20
>> I don't think diferentiating between signed and unsigned integer
>> overflows is useful=2E  In the kernel, most security issues from intege=
r
>> overflows are from unsigned integer overflows=2E  Kees says that we
>> should warn about "Unexpected" behavior instead of "Undefined"=2E  In f=
act,
>> Justin Stitt has done the opposite of what you're doing and only checks
>> for unsigned overflows=2E  He created a sanitizer that warns about inte=
ger
>> overflows involving size_t type (which is unsigned), because sizes are
>> so important=2E  (Checking only size_t avoids probably the largest sour=
ce
>> of harmless integer overflows which is dealing with time)=2E
>
>I agree with you=2E  We were also discussing an attribute that
>can be attached to certain unsigned types to indicate that
>wrapping is an error=2E=C2=A0
>
>My more limited aim (because my personal time is very limited)
>is to define a memory safe subset and in such a subset you can
>not have UB=2E  Hence, I am more focussed on signed overflow at
>the moment, but I agree that safety in general must go beyond=C2=A0
>this=2E
>
>But this is why I want the kernel community to be more involved,
>to get more resources and more experience into these discussions=2E
>
>>=20
>> The sanitizer has a list of exceptions like if (a < a + b) where the
>> integer overflow is idiomatic=2E  But the concern was that there might =
be
>> other deliberate integer overflows which aren't in the exception list s=
o
>> Justin also created a macro to turn off the santizer=2E
>>=20
>> 	x =3D wrapping_ok(a + b);
>
>Indeed=2E This is the main issue with unsigned wraparound=2E Exactly
>because it was always defined, simply screening for wraparound
>yields many false positives=2E=20
>
>(BTW: Rust is also not perfectly immune to such errors:
>https://rustsec=2Eorg/advisories/RUSTSEC-2023-0080=2Ehtml)
>
>
>>=20
>> What I would like is a similar macro so we could write code like:
>>=20
>> 	x =3D saturate_math(a + b + c + d * d_size);
>>=20
>> If anything overflowed the result would be ULONG_MAX=2E  In the kernel,
>> we have the size_add() and size_mul() macros which do saturation math
>> instead of wrapping math but we'd have to say:
>>=20
>> 	x =3D size_add(a, size_add(b, size_add(c, size_add(size_mul(d, d_size)=
))));
>>=20
>> Which is super ugly=2E  Maybe we could create something like this macro=
?
>>=20
>> #define saturate_math(x) ({             \
>>         unsigned long res;              \
>>         __trap_overflow(label_name));   \
>>         res =3D (x);                      \
>>         if (0) {                        \
>> lable_name:                             \
>>                 res =3D ULONG_MAX;        \
>>         }                               \
>>         res;                            \
>> })
>>=20
>
>We added checked arhithmetic to C23, we could add saturating
>math to C2Y if this is needed=2E  (although I admit I do not fully
>understand the use case of saturating math, a saturated value
>still seems to be an error? Statistics, where it does not matter?)
>
>In general, if people have good ideas what compilers or the language
>standard can do to help, please talk to us=2E It is possible to
>improve compilers and/or the language itself=2E
>
>
>Martin
>
>
>
>

This is exactly the sort of things quick is quite easy to do with C++ but =
requires ad hoc compiler extensions for C=2E

