Return-Path: <linux-kernel+bounces-533937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A058FA46085
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20D13A8A88
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371A87464;
	Wed, 26 Feb 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="i/maGwMa"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32006433B1;
	Wed, 26 Feb 2025 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575879; cv=none; b=CSh5YlNHUYeVKdBA9qnfyrWlBC53bOI71MKRGICBcnovEbjsMos5dqqCJZi1CCbDUEuDdCFmGbfRt6E3iT+cD5TVLZQNmGCwhYYlRheQhbtRyJc6DOTDmNESJ0qOHw4esC/mIc7gF+o+r5cFqLJOuN20pWozsbTfg9bewejygGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575879; c=relaxed/simple;
	bh=2c7Bzmuc/iWViF51kYjotUVZN+DgZxmkN9bCCgaD3BI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XXdG600BDYoQeIgTbvtzUQ5B7uRGV4bU7yiz0FAutFL1xWCHEla1koystopzLiOZJalBHlw9bmcN7QMY/Jwdd1sLdSOnHjZg3aSQLlj4D8l/TWGZUY0UE71s4bllr/S+Bc+HLdzx8rl+8cl5V167RkVzcyDcXYmr9wpfx4qjMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=i/maGwMa; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1740575875; bh=2RKtFbPe77le4NhfF/Nc+zYGDNhfDzDomVRfDUW9gM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=i/maGwMaFjn1V6YERlL0drSgp9jO8F0vnh5i9aRFQWCEIHEnEn+1WWeY6wC2e/b9R
	 8S3nZZJGMlxj0wkEI3EEtY4nLyHnwnbtVzXe+pFN86UrdITYqr+zB2bCjfad5hK61T
	 nDDsppFl98X6RlqJat6Z5RLUEfYx5OyAlDKb3VLE=
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,  rust-for-linux
 <rust-for-linux@vger.kernel.org>,  Linus Torvalds
 <torvalds@linux-foundation.org>,  Greg KH <gregkh@linuxfoundation.org>,
  David Airlie <airlied@gmail.com>,  linux-kernel@vger.kernel.org,
  ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
In-Reply-To: <Z7iav4U7k9AJDzay@phenom.ffwll.local> (Simona Vetter's message of
	"Fri, 21 Feb 2025 16:24:47 +0100")
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	<Z7SwcnUzjZYfuJ4-@infradead.org>
	<CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	<Z7bO1jT2onZFZwgH@infradead.org>
	<CANiq72mM3tVmT6MQZqpzGEW4hJABVHRiODL0SnP2u+0ES4=pjw@mail.gmail.com>
	<Z7iav4U7k9AJDzay@phenom.ffwll.local>
Date: Wed, 26 Feb 2025 14:17:54 +0100
Message-ID: <m234g0lu9p.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simona Vetter <simona.vetter@ffwll.ch> writes:

> Hi Miguel
>
> Disregarding the specific discussion here, but this just felt like a good
> place to thank you for your work to bring rust to linux. Your calm and
> understanding approach to figure out what fits best in each case, from "go
> away, don't bother me with rust" through "I like this, but I have no clue"
> all the way to "uh so we have four drivers now in progress, this is
> getting messy" has and continues to enormously help in making this all a
> success.
>
> Thank you!
>
> Obviously not diminishing everyone else's work here, just that Miguel's
> effort on the culture and people impact of r4l stands out to me.

Also big thanks from me here. With coming via the rust side and having
only briefly worked on the kernel before rust, having you (Miguel) to ask a=
bout
some ways on how can I aproach this to upstream my work is really really
helpful and makes my working on the rust side much much easier.

Thanks a lot for all the burocracy things that you also do next to also
writing code.
Thanks,
Fiona

>
> Cheers, Sima
>
> On Fri, Feb 21, 2025 at 12:44:31AM +0100, Miguel Ojeda wrote:
>> On Thu, Feb 20, 2025 at 7:42=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
>> >
>> > The document claims no subsystem is forced to take Rust.  That's proven
>> > to be wrong by Linus.  And while you might not have known that when
>> > writing the document, you absolutely did when posting it to the list.
>> >
>> > That is a very dishonest way of communication.
>> >
>> > And while you might not have known that when
>> > writing the document, you absolutely did when posting it to the list.
>>=20
>> I did know -- Linus told both of us in the private thread. I am not
>> sure what that has to do with anything.
>>=20
>> As I told you in the previous reply, please read the next paragraph of
>> the document:
>>=20
>>     Now, in the Kernel Maintainers Summit 2022, we asked for flexibility
>>     when the time comes that a major user of Rust in the kernel requires
>>     key APIs for which the maintainer may not be able to maintain Rust
>>     abstractions for it. This is the needed counterpart to the ability
>>     of maintainers to decide whether they want to allow Rust or not.
>>=20
>> The point is that maintainers decide how to handle Rust (and some have
>> indeed rejected Rust), but that flexibility is needed if a maintainer
>> that owns a core API does not want Rust, because otherwise it blocks
>> everything, as is your case.
>>=20
>> In summary: you were in that meeting, you own a core API, you do not
>> want Rust, you are blocking everything. So flexibility is needed. Thus
>> we asked you what can be done, how we can help, etc. You did not
>> accept other maintainers, did not want to have the code anywhere in
>> the tree, nor wanted to work on a compromise at all. You, in fact,
>> said "I will do everything I can do to stop this.". So that is not
>> providing flexibility, quite the opposite of it. So Linus eventually
>> had to make a decision to provide that flexibility.
>>=20
>> I am not sure how that contradicts the document -- the document is
>> precisely talking about this situation.
>>=20
>> By the way, I do not take lightly that you accuse me of dishonesty.
>>=20
>> > Which given the binding creep means every single non-leaf subsystem
>> > eventually.
>>=20
>> If Rust keeps growing in the kernel, then obviously more and more
>> non-leaf maintainers get affected.
>>=20
>> But that just means more people is getting involved and more
>> subsystems are accepting Rust for their use cases. So that would just
>> mean it was, indeed, a good idea in the end.
>>=20
>> > I'm not sure how that matters.  Of course your Rust testimonials are
>> > going to like it, otherwise you would not have quoted it.  They
>>=20
>> Not at all. As I say in the talk, I included every single quote I got,
>> even up to the night before the keynote.
>>=20
>> It is nevertheless very biased, because I asked people we interacted
>> with, which were mostly positive or neutral. I acknowledged this bias
>> in the talk too.
>>=20
>> However, just so that others are aware, I did email others that are
>> negative about it too, such as you. And you did not reply.
>>=20
>> > Well, obviously you do.  But as in many other things I would usually
>> > not count corporate pressure as a good thing.
>>=20
>> Corporate pressure is not good. Corporate support is.
>>=20
>> And we need that support to accomplish something like this.
>>=20
>> Cheers,
>> Miguel

