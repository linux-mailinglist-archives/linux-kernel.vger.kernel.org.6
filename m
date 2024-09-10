Return-Path: <linux-kernel+bounces-323794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC31C974392
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0858C1C2542D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154281A76A0;
	Tue, 10 Sep 2024 19:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EJeq2aYk"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF417C7B1;
	Tue, 10 Sep 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725997054; cv=none; b=g/Rz89A0w95+UyMCutUl3pa70UAbgz/6oweCZlOPSch9WmuoDkb0wDjDkjnADFrUrCdImzPp8Q82MHOsgkIpC2KKOAgpwPoE9dLQ9hYIP6m2wwSB3b0nauS3bCYVZcrNCL94uap6nf+mkpM/NSHsmFqBrv1wF8yd185Nwcb66VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725997054; c=relaxed/simple;
	bh=EZIpDs7zDzaQfrc7/Nqi0dlJx2YqqkEcwb/gmWT/uvM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tto4rY3ggghy1oSeOTS/Dgxso860/GGshJFs/0xLPlPQMSC0VeLPlMGBC+Ax9GZF+XsF3iUttfwk9mv5Q/BuMPN2MjKUIvB7yQjpKUZNftjhns/ohf8s5HMh40AxpTGXW5z06apc4oJcTd8KB8qWMANL8U+IbBih5/+f1/ODuMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EJeq2aYk; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1725997051; x=1726256251;
	bh=2vhIboT8ME/071QA9HFuaYGAReumSa+MmRICSuZMu6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EJeq2aYkTtSxcaKY09Y/x+THrtwR0fMeOOfR3rqtjwDzx8AFbiodhNJkuBX8WygaA
	 KoGbjoQoWcAwkENMBMqyWqUT4lSALm2DIfLgdTnHt7rhuuy48PH1UV/51WEk2Yk4of
	 tD0Ccc8vU8x9cAaKrHLGJmguBv1N6KVcL5DEJ7T/NzPsxtT6K8yjEboA7c3P9MU975
	 mapkFILrtOPjKGCoLkj7Brh8SgmnI+IIyJfvEoYc/puiPHOXA61CVxFmL9KuYDM3+z
	 rc/yksqXXv8MASpnbo2Yo3M5eix0RMqCwenpTgdBoTj9GwlZzzwHEiIinnoOxi/nD3
	 2aF4ytiiwpEeQ==
Date: Tue, 10 Sep 2024 19:37:24 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 01/26] rust: alloc: add `Allocator` trait
Message-ID: <3309d946-c513-4c0b-baf4-d65cba04832a@proton.me>
In-Reply-To: <ZuBIYNrwIiGXx8Uw@cassiopeiae>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-2-dakr@kernel.org> <60253988-37e7-4acb-b2ae-748b30a4ac21@proton.me> <ZtDuf0QGfhiy5X_I@pollux.localdomain> <44b80095-8b03-4558-967e-138ea712f780@proton.me> <Ztb5arBBX2LsrFKo@pollux> <d5761d8e-8e17-42a5-9793-92edb121428e@proton.me> <ZuBIYNrwIiGXx8Uw@cassiopeiae>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3f2cbc8058bb0b3e4f0868a85c58b7d733780848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.09.24 15:23, Danilo Krummrich wrote:
> On Tue, Sep 10, 2024 at 01:03:48PM +0000, Benno Lossin wrote:
>> On 03.09.24 13:56, Danilo Krummrich wrote:
>>> On Fri, Aug 30, 2024 at 01:06:00PM +0000, Benno Lossin wrote:
>>>> On 29.08.24 23:56, Danilo Krummrich wrote:
>>>>> On Thu, Aug 29, 2024 at 06:19:09PM +0000, Benno Lossin wrote:
>>>>>> On 16.08.24 02:10, Danilo Krummrich wrote:
>>>>>>> Add a kernel specific `Allocator` trait, that in contrast to the on=
e in
>>>>>>> Rust's core library doesn't require unstable features and supports =
GFP
>>>>>>> flags.
>>>>>>>
>>>>>>> Subsequent patches add the following trait implementors: `Kmalloc`,
>>>>>>> `Vmalloc` and `KVmalloc`.
>>>>>>>
>>>>>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>>>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>>>>
>>>>>> We discussed this in our weekly meeting (I think ~one week ago?). If=
 you
>>>>>> give me a draft version of the comment that you plan to add regardin=
g
>>>>>> the `old_layout` parameter, I can see if I am happy with it. If I am=
, I
>>>>>> would give you my RB.
>>>>>
>>>>> May I propose you let me know what you would like to see covered, rat=
her than
>>>>> me trying to guess it. :-)
>>>>
>>>> I was hoping that we put that in our meeting notes, but I failed to fi=
nd
>>>> them... I would put this in a normal comment, so it doesn't show up in=
 the
>>>> documentation. Preface it like implementation decision/detail:
>>>> - Why do `Allocator::{realloc,free}` not have an `old_layout` paramete=
r
>>>>   like in the stdlib? (the reasons you had for that decision, like we
>>>>   don't need it etc.)
>>>
>>> Ok.
>>>
>>>> - Then something along the lines of "Note that no technical reason is
>>>>   listed above, so if you need/want to implement an allocator taking
>>>>   advantage of that, you can change it"
>>>
>>> I don't really want to set the conditions for this to change in the
>>> documentation. It really depends on whether it's actually needed or the
>>> advantage of having it is huge enough to leave the core kernel allocato=
rs with
>>> unused arguments.
>>>
>>> This can really only be properly evaluated case by case in a discussion=
.
>>
>> Agreed, but I don't want people to think that we have a reason against
>> doing it in the future. Do you have an idea how to convey this?
>=20
> I understand (and agree with) your intention. But I don't think it's nece=
ssary
> to document, because, ideally, this is already true for the whole kernel.
>=20
> Generally, I think it's valid to assume that people are willing to change=
 the
> code if the advantages outweigh the disadvantages.

Sure, but for certain areas you might need a very, very good reason to
do so.
In this case, I fear that people might believe that this is the case,
even though it isn't (one of course still needs a good reason).

> So, we could write something like "This may be changed if the advantages
> outweigh the disadvantages.", but it'd be a bit random, since we could pr=
obably
> sprinkle this everywhere.

Sure, that works for me. I don't think that we can sprinkle this
everywhere (but of course a in lot of places).

---
Cheers,
Benno


