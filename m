Return-Path: <linux-kernel+bounces-532447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16020A44DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51AD188AED1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C5F20E32A;
	Tue, 25 Feb 2025 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="niBUKQLb"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B81632D9;
	Tue, 25 Feb 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515902; cv=none; b=q1e9C7SAZaryADvPgJDcal65yk/Ov8F4o6iYX9PAk2Yl+e/BN6Pxi7gz0MkoxWDiF+HagN8TwBdHqJ24PkoH38Kliy8SJNXNoLYSj1qOK2Y/m0Bxas4flUe4JVb4fH6kqKvWBb8eVhPX2zGEexQ1jlLV205/Q0fpOR4tFW7VG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515902; c=relaxed/simple;
	bh=Ix+Pwhn+RghNZ8TaQ8WxJiqhMR2Rf4rkdqUxWh1jhfc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pRLLxqre9x/7lqwZAl/1g115my3nxuJjlF7pMdUxsF2bzxlqNJKH/gIqrbfC9uyQspJrr4Dm/jEUjWrI3LaFpzw0XgKp52FupOqA86JUWapIbtU/Kjk8DzeVxiJKu8lZcZ6zzwsakI2Wx62kTOHMs3xWr1Bp0n5/VWQFXWx/L5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=niBUKQLb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PKbwEk1423536
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 12:37:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PKbwEk1423536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740515880;
	bh=Ix+Pwhn+RghNZ8TaQ8WxJiqhMR2Rf4rkdqUxWh1jhfc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=niBUKQLbNw4BzHZWrL+JvGm/sxQqSiekYMxHJSnrHoiw7f2vIAT8C19tLKi0ibe+h
	 RP05OF53QYQQBWhdLRdIqNg3+u3C32//+8N5U6PUOW9p4ELTX4JKPV/yVnZUuCQ/k1
	 975YR/2qgjikBUJ5FhEMKIrOqsXLmiCgXOijdRbBTQc4izrjJcMcaD4bezW9bTGhLs
	 /W0vqciXfNyoCq9fjSuX5LwJNQYOJQDUPOD+dPcd1lVlDQupingerQpJ1+mbtD4CAL
	 R3RoAiazG7iECnk/taiT80feB4fj2uP2YNjJaqbePC1y2couD68KTT6JNUNPlswxhe
	 zsE0OUVVrBgog==
Date: Tue, 25 Feb 2025 12:37:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
CC: Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
        david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
        hch@infradead.org, ksummit@lists.linux.dev,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
        rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
User-Agent: K-9 Mail for Android
In-Reply-To: <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com> <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com> <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com> <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com> <2rrp3fmznibxyg3ocvsfasfnpwfp2skhf4x7ihrnvm72lemykf@lwp2jkdbwqgm>
Message-ID: <D11A34F5-EA92-4B80-8498-F9764E47EA97@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 12:21:06 PM PST, Kent Overstreet <kent=2Eoverstreet@li=
nux=2Edev> wrote:
>On Tue, Feb 25, 2025 at 10:16:17AM -0800, H=2E Peter Anvin wrote:
>> On February 25, 2025 9:36:07 AM PST, Alice Ryhl <aliceryhl@google=2Ecom=
> wrote:
>> >On Tue, Feb 25, 2025 at 6:21=E2=80=AFPM Ventura Jack <venturajack85@gm=
ail=2Ecom> wrote:
>> >> On the topic of difficulty, even if there was a full specification,
>> >> it might still be difficult to work with aliasing in unsafe Rust=2E
>> >> For C "restrict", I assume that "restrict" is fully specified, and
>> >> C developers still typically avoid "restrict"=2E And for unsafe
>> >> Rust, the Rust community helpfully encourages people to
>> >> avoid unsafe Rust when possible due to its difficulty=2E
>> >
>> >This I will not object to :)
>> >
>> >Alice
>> >
>> >
>>=20
>> I do have to say one thing about the standards process: it forces a
>> real specification to be written, as in a proper interface contract,
>> including the corner cases (which of course may be "undefined", but
>> the idea is that even what is out of scope is clear=2E)
>
>Did it, though?
>
>The C standard didn't really define undefined behaviour in a
>particularly useful way, and the compiler folks have always used it as a
>shield to hide behind - "look! the standard says we can!", even though
>that standard hasn't meaninfully changed it decades=2E It ossified things=
=2E
>
>Whereas the Rust process seems to me to be more defined by actual
>conversations with users and a focus on practicality and steady
>improvement towards meaningful goals - i=2Ee=2E concrete specifications=
=2E
>There's been a lot of work towards those=2E
>
>You don't need a standards body to have specifications=2E

Whether a spec is "useful" is different from "ill defined=2E"

I know where they came from =E2=80=93 wanting to compete with Fortran 77 f=
or HPC, being a very vocal community in the compiler area=2E F77 had very f=
ew ways to have aliasing at all, so it happened to make a lot of things lik=
e autovectorization relatively easy=2E Since vectorization inherently relie=
s on hoisting loads above stores this really matters in that context=2E=20

Was C the right place to do it? That's a whole different question=2E

