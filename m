Return-Path: <linux-kernel+bounces-532194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D578FA449F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F280E7ACDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD119CD16;
	Tue, 25 Feb 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uBBdwVA6"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B42D176FB0;
	Tue, 25 Feb 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507405; cv=none; b=rahhZNS/teNQhhVRYVZb4gJXtB8FX3KEy9gtJMaDYZuO7BJ6uwfvkgAB1PiE1/lL6Fc1QOWaLTyVNgcqINiTZiTOnYPdQLjkcjYytzy2DopqsTZDBf/cVJIrEXIO1eiqF0fG8otf1L1eKYVkb4LgWiSnXeFCafL3Ot+qqOV2oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507405; c=relaxed/simple;
	bh=eoJLsORUr3+sG19g827exZFY9w4G8hTvu/Hliq9HRVk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TpaFDXIsnbzRsq/jrhLfN2JLRBJq4lNJZzeppJq1UL3LykYiTNZcu5vOff4xm8RnDKAXJy78STzAVBUSt/AIE91CrV8gUXiIcA9nmqj4s8X16CyoA/w9JL1LXlmjGMUopbXF0ANW/mMMeNXejiye8f+fNPyysSLEMIJu8xh3yiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=uBBdwVA6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PIGJhK1382724
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 10:16:20 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PIGJhK1382724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740507382;
	bh=mXZUNxkU+u+ykvS8KwB7Tu/GeSnEZCinpL/GVgJGwu8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uBBdwVA6JNXCBEE2cKEl5kXQV/tOVS6CQ1kl3UkuukMMYET8Jzu2YIi9YxWbEU7xv
	 vVPRpgQp+oOUvvW99F3m74dXHWrjCMbTflsIcRMdqWbH1amqKgvNUM7gSvft8Vjhro
	 BMC/hPaySRIhOlOYgDoU8CxyH9mh6fwRMRrtyocIDMtkOqIgzNX2H8HQFfekw/eh9W
	 bVwO590dNpZtT6WlMApSxVI6GzrvBfNTecoeIKYZgKRnIgBr5VTTeqH9cmAIA5kw+p
	 MFGEC12BpDZEY4XDL8iu82mXNiMIQxHFcQnPH3753aiD7TC40GFNbh5f5WWya58lm6
	 uxs/Lkfq4T7Sw==
Date: Tue, 25 Feb 2025 10:16:17 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alice Ryhl <aliceryhl@google.com>, Ventura Jack <venturajack85@gmail.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com,
        david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
        hch@infradead.org, ksummit@lists.linux.dev,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
        rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com> <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com> <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c> <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com> <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com> <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com> <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
Message-ID: <5E3FEDC4-DBE3-45C7-A331-DAADD3E7EB42@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 9:36:07 AM PST, Alice Ryhl <aliceryhl@google=2Ecom> wr=
ote:
>On Tue, Feb 25, 2025 at 6:21=E2=80=AFPM Ventura Jack <venturajack85@gmail=
=2Ecom> wrote:
>>
>> On Tue, Feb 25, 2025 at 9:12=E2=80=AFAM Alice Ryhl <aliceryhl@google=2E=
com> wrote:
>> >
>> > On Sun, Feb 23, 2025 at 4:30=E2=80=AFPM Ventura Jack <venturajack85@g=
mail=2Ecom> wrote:
>> > >
>> > > Just to be clear and avoid confusion, I would
>> > > like to clarify some aspects of aliasing=2E
>> > > In case that you do not already know about this,
>> > > I suspect that you may find it very valuable=2E
>> > >
>> > > I am not an expert at Rust, so for any Rust experts
>> > > out there, please feel free to point out any errors
>> > > or mistakes that I make in the following=2E
>> > >
>> > > The Rustonomicon is (as I gather) the semi-official
>> > > documentation site for unsafe Rust=2E
>> > >
>> > > Aliasing in C and Rust:
>> > >
>> > > C "strict aliasing":
>> > > - Is not a keyword=2E
>> > > - Based on "type compatibility"=2E
>> > > - Is turned off by default in the kernel by using
>> > >     a compiler flag=2E
>> > >
>> > > C "restrict":
>> > > - Is a keyword, applied to pointers=2E
>> > > - Is opt-in to a kind of aliasing=2E
>> > > - Is seldom used in practice, since many find
>> > >     it difficult to use correctly and avoid
>> > >     undefined behavior=2E
>> > >
>> > > Rust aliasing:
>> > > - Is not a keyword=2E
>> > > - Applies to certain pointer kinds in Rust, namely
>> > >     Rust "references"=2E
>> > >     Rust pointer kinds:
>> > >     https://doc=2Erust-lang=2Eorg/reference/types/pointer=2Ehtml
>> > > - Aliasing in Rust is not opt-in or opt-out,
>> > >     it is always on=2E
>> > >     https://doc=2Erust-lang=2Eorg/nomicon/aliasing=2Ehtml
>> > > - Rust has not defined its aliasing model=2E
>> > >     https://doc=2Erust-lang=2Eorg/nomicon/references=2Ehtml
>> > >         "Unfortunately, Rust hasn't actually
>> > >         defined its aliasing model=2E
>> > >         While we wait for the Rust devs to specify
>> > >         the semantics of their language, let's use
>> > >         the next section to discuss what aliasing is
>> > >         in general, and why it matters=2E"
>> > >     There is active experimental research on
>> > >     defining the aliasing model, including tree borrows
>> > >     and stacked borrows=2E
>> > > - The aliasing model not being defined makes
>> > >     it harder to reason about and work with
>> > >     unsafe Rust, and therefore harder to avoid
>> > >     undefined behavior/memory safety bugs=2E
>> >
>> > I think all of this worrying about Rust not having defined its
>> > aliasing model is way overblown=2E Ultimately, the status quo is that
>> > each unsafe operation that has to do with aliasing falls into one of
>> > three categories:
>> >
>> > * This is definitely allowed=2E
>> > * This is definitely UB=2E
>> > * We don't know whether we want to allow this yet=2E
>> >
>> > The full aliasing model that they want would eliminate the third
>> > category=2E But for practical purposes you just stay within the first
>> > subset and you will be happy=2E
>> >
>> > Alice
>>
>> Is there a specification for aliasing that defines your first bullet
>> point, that people can read and use, as a kind of partial
>> specification? Or maybe a subset of your first bullet point, as a
>> conservative partial specification? I am guessing that stacked
>> borrows or tree borrows might be useful for such a purpose=2E
>> But I do not know whether either of stacked borrows or tree
>> borrows have only false positives, only false negatives, or both=2E
>
>In general I would say read the standard library docs=2E But I don't
>know of a single resource with everything in one place=2E
>
>Stacked borrows and tree borrows are attempts at creating a full model
>that puts everything in the two first categories=2E They are not
>conservative partial specifications=2E
>
>> For Rust documentation, I have heard of the official
>> documentation websites at
>>
>>     https://doc=2Erust-lang=2Eorg/book/
>>     https://doc=2Erust-lang=2Eorg/nomicon/
>>
>> And various blogs, forums and research papers=2E
>>
>> If there is no such conservative partial specification for
>> aliasing yet, I wonder if such a conservative partial
>> specification could be made with relative ease, especially if
>> it is very conservative, at least in its first draft=2E Though there
>> is currently no specification of the Rust language and just
>> one major compiler=2E
>>
>> I know that Java defines an additional conservative reasoning
>> model for its memory model that is easier to reason about
>> than the full memory model, namely happens-before
>> relationship=2E That conservative reasoning model is taught in
>> official Java documentation and in books=2E
>
>On the topic of conservative partial specifications, I like the blog
>post "Tower of weakenings" from back when the strict provenance APIs
>were started, which I will share together with a quote from it:
>
>> Instead, we should have a tower of Memory Models, with the ones at the =
top being =E2=80=9Cwhat users should think about and try to write their cod=
e against=E2=80=9D=2E As you descend the tower, the memory models become in=
creasingly complex or vague but critically always more permissive than the =
ones above it=2E At the bottom of the tower is =E2=80=9Cwhatever the compil=
er actually does=E2=80=9D (and arguably =E2=80=9Cwhatever the hardware actu=
ally does=E2=80=9D in the basement, if you care about that)=2E
>> https://faultlore=2Ecom/blah/tower-of-weakenings/
>
>You can also read the docs for the ptr module:
>https://doc=2Erust-lang=2Eorg/stable/std/ptr/index=2Ehtml
>
>> On the topic of difficulty, even if there was a full specification,
>> it might still be difficult to work with aliasing in unsafe Rust=2E
>> For C "restrict", I assume that "restrict" is fully specified, and
>> C developers still typically avoid "restrict"=2E And for unsafe
>> Rust, the Rust community helpfully encourages people to
>> avoid unsafe Rust when possible due to its difficulty=2E
>
>This I will not object to :)
>
>Alice
>
>

I do have to say one thing about the standards process: it forces a real s=
pecification to be written, as in a proper interface contract, including th=
e corner cases (which of course may be "undefined", but the idea is that ev=
en what is out of scope is clear=2E)

