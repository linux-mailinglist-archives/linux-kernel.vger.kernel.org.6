Return-Path: <linux-kernel+bounces-168801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EF88BBDCA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA3B21437
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82337839F5;
	Sat,  4 May 2024 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hcxafYks"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875BD74416
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714849893; cv=none; b=c5r+YOpSCLPqaE6wpzNGU33bjVIEHug6Hd5RVbCTT7iCj7fgwTEwtC0iQtipu/2rG4N84kp8PaXVQ/gMOdvETMAd2F1JXRzBjRDsluP9d1kp5dV28Pj0wOGVqQlhWvceRobH0o5r/P6Y2vo7B4424LMYD66sDbnb85v1216kHmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714849893; c=relaxed/simple;
	bh=uwVeOcnVhzY7OEyAVXKEVZE/33D8ZHl/GKiYg4bKd9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/t3tMMFYvMpe/LYRQiMUydbamjba0q8O1XfPAg+8VSVsxShUXyIPqzx70lx8jF7gYtKK05gw0IgMx5JMyKmx6QZhIks6ZhheFHwGV5do/xzS7u82UxYW5Clr66Gxc0wEU9/VqsWrjqhLMpmw04Po6P2TlnJfpCgTJnRXQdvNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hcxafYks; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so9598701fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714849889; x=1715454689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sH4iwQ2iu+GKtUYFQ/3K3AWqut/7uGh4gA5peG6q0AY=;
        b=hcxafYksfNzi7byQqoC1uD+2OF1O6C5GTu6/GIiTQRU4ysVu/NWg7QibepMaVdv+LL
         6Wwl7Oza/oL27YNtHTwR+UYwhm//HVjxY34kMJ0uBFXxkuhCEqCiXgLPLh1gjJOA7K1g
         X/0rT3Lh1buEsznSxaMX29Xf20+53mjYZywnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714849889; x=1715454689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sH4iwQ2iu+GKtUYFQ/3K3AWqut/7uGh4gA5peG6q0AY=;
        b=QV5KzVcQkwciF9dvz6GWst6VdcQF74q+E5vy4xRoOKxQCVUwc3vobhDRwYfy5P7rVL
         VUx/tL2fJq4yGm9aS0lDlaw8V5CPYlQgdVE8nPKklb4bD/kzuXoLl7jwKHCipLNwoEwz
         84rNLWzNldbbbPcuYBY6iosYfg4KQgXLdGu2FV8WCexoCkqCepHcLP2/sb/puoERwWHT
         lYDbpOWxaS4vrJh7BfNa78uDsVL0n7hnP1DGiAUdWAZDgUEpoaAUYV3/JSLPh+6LAJmn
         rbuUplzIkFqpFK4ZUzPYICmFuSYOdQcibAVAicMrQYS0IdO9tDC/FhvVvpF10hY5sDcg
         eNYw==
X-Forwarded-Encrypted: i=1; AJvYcCXxoPM7Qa0hluNXGGX2digp+jjaN1+KBR5Uxwxvj/5ATY21n1I+duswhCMGJR9jDXVhQnTZHkvT2E2o0KMEtrIi2wem0ENo/Z+MqIsd
X-Gm-Message-State: AOJu0YyoxCtb4tDE+vNF4N1ZCd66WrBMpr0abDtQbXSvgwalz2dmEiYl
	gfnYmqlKIZoP60GI3XMQPjxUcwTPQTNGzRQD34rJ7ZDODudQFNXO7ZbsCkITf7fFjiamxO5UZ+f
	ZQfT7ag==
X-Google-Smtp-Source: AGHT+IFEp6gFmb+rQBx7GoBpqcQaH52uYZOVnkk7DaLAoGG+KnpSWFttclbtKa+XAJ4Amdz4itdB0A==
X-Received: by 2002:a2e:beac:0:b0:2de:8197:4cfe with SMTP id a44-20020a2ebeac000000b002de81974cfemr3989844ljr.42.1714849888818;
        Sat, 04 May 2024 12:11:28 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id g17-20020a056402091100b00571bbaa1c45sm3174352edz.1.2024.05.04.12.11.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 12:11:28 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a8f0d941so132898766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 12:11:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3Goaq4zkOASytV5s83Q7xy8tygHWHsVtMYOrnL/PeSroQE+gSnpbZiiSW3PgcSqzy1v+VWSDUdhO5UV19vStrcdMSoW+ZeYIczM9V
X-Received: by 2002:a17:906:1b58:b0:a59:b37d:da4c with SMTP id
 p24-20020a1709061b5800b00a59b37dda4cmr665216ejg.55.1714849887591; Sat, 04 May
 2024 12:11:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANpmjNOY=Qpm3hBu-eN4Xk8n-2VXQRvcQ3_PfwPwNw9MmC8ctw@mail.gmail.com>
 <CAHk-=whTakjVGgBC5OtoZ5Foo=hd4-g+NZ79nkMDVj6Ug7ARKQ@mail.gmail.com>
 <CAHk-=wiGzmJXZwHxCE6P0jVBqU4gHEm=zcfj3v+zM_S_9RF4_Q@mail.gmail.com>
 <1c886023-ae61-46ba-bb3c-b460c30de937@paulmck-laptop> <b3b81374-a19d-4bf5-abb3-15e48c72f01a@paulmck-laptop>
 <ZjPBPWSSdE_VcH_V@boqun-archlinux> <2beaba9f-6f83-4a7c-8835-fe5fe88a006c@paulmck-laptop>
 <CAHk-=wg4iAjQb_Na_1rf_EHxe7rsN24he6cjKgdOAPmn7N9oVw@mail.gmail.com>
 <3f2c415d-dc7e-4647-9002-4beb804d885c@paulmck-laptop> <CAHk-=whz-pFHfC4nNdrBtWs4KOm7Q2d2quHmFFYzz1Dz7d7LnQ@mail.gmail.com>
 <7aab574e-b6ba-4038-802f-2d64af09d802@paulmck-laptop>
In-Reply-To: <7aab574e-b6ba-4038-802f-2d64af09d802@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 12:11:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi8mArAxxkO78CTSVRCyjim4hpGbzf2NFxNMAdXWR3oJA@mail.gmail.com>
Message-ID: <CAHk-=wi8mArAxxkO78CTSVRCyjim4hpGbzf2NFxNMAdXWR3oJA@mail.gmail.com>
Subject: Re: [PATCH v3] tty: tty_io: remove hung_up_tty_fops
To: paulmck@kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Marco Elver <elver@google.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, 
	syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 11:18, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Here is my current thoughts for possible optimizations of non-volatile
> memory_order_relaxed atomics:
>
> o       Loads from the same variable that can legitimately be
>         reordered to be adjacent to one another can be fused
>         into a single load.

Let's call this "Rule 1"

I think you can extend this to also "can be forwarded from a previous store".

I also think you're too strict in saying "fused into a single load".
Let me show an example below.

> o       Stores to the same variable that can legitimately be
>         reordered to be adjacent to one another can be replaced
>         by the last store in the series.

Rule 2.

Ack, although again, I think you're being a bit too strict in your
language, and the rule can be relaxed.

> o       Loads and stores may not be invented.

Rule 3.

I think you can and should relax this. You can invent loads all you want.

> o       The only way that a computation based on the value from
>         a given load can instead use some other load is if the
>         two loads are fused into a single load.

Rule 4.

I'm not convinced that makes sense, and I don't think it's true as written.

I think I understand what you are trying to say, but I think you're
saying it in a way that only confuses a compiler person.

In particular, the case I do not think is true is very much the
"spill" case: if you have code like this:

    a = expression involving '__atomic_load_n(xyz, RELAXED)'

then it's perfectly fine to spill the result of that load and reload
the value. So the "computation based on the value" *is* actually based
on "some other load" (the reload).

I really *REALLY* think you need to explain the semantics in concrete
terms that a compiler writer would understand and agree with.

So to explain your rules to an actual compiler person (and relax the
semantics a bit) I would rewrite your rules as:

 Rule 1: a strictly dominating load can be replaced by the value of a
preceding load or store

 Ruie 2: a strictly dominating store can remove preceding stores

 Rule 3: stores cannot be done speculatively (put another way: a
subsequent dominating store can only *remove* a store entirely, it
can't turn the store into one with speculative data)

 Rule 4: loads cannot be rematerialized (ie a load can be *combined*
as per Rule 1, but a load cannot be *split* into two loads)

Anyway, let's get to the examples of *why* I think your language was
bad and your rules were too strict.

Let's start with your Rule 3, where you said:

 - Loads and stores may not be invented

and while I think this should be very very true for stores, I think
inventing loads is not only valid, but a good idea. Example:

    if (a)
        b = __atomic_load_n(ptr) + 1;

can perfectly validly just be written as

    tmp = __atomic_load_n(ptr);
    if (a)
        b = tmp+1;

which in turn may allow other optimizations (ie depending on how 'b'
is used, the conditional may go away entirely, and you just end up
with 'b = tmp+!!a').

There's nothing wrong with extra loads that aren't used.

And to make that more explicit, let's look at Rule 1:

Example of Rule 1 (together with the above case):

    if (a)
        b = __atomic_load_n(ptr) + 1;
    else
        b =  __atomic_load_n(ptr) + 2;
    c = __atomic_load_n(ptr) + 3;

then that can perfectly validly re-write this all as

    tmp = __atomic_load_n(ptr);
    b = a ? tmp+1 : tmp+2;
    c = tmp + 3;

because my version of Rule 1 allows the dominating load used for 'c'
to be replaced by the value of a preceding load that was used for 'a'
and 'b'.

And to give an example of Rule 2, where you said "reordered to be
adjacent", I'm saying that all that matters is being strictly
dominant, so

    if (a)
        __atomic_store_n(ptr,1);
    else
        __atomic_store_n(ptr,2);
    __atomic_store_n(ptr,3);

can be perfectly validly be combined into just

    __atomic_store_n(ptr,3);

because the third store completely dominates the two others, even if
in the intermediate form they are not necessarily ever "adjacent".

(Your "adjacency" model might still be valid in how you could turn
first of the first stores to be a fall-through, then remove it, and
then turn the other to be a fall-through and then remove it, so maybe
your language isn't _tecnically_ wrong, But I think the whole
"dominating store" is how a compiler writer would think about it).

Anyway, the above are all normal optimizations that compilers
*already* do, and the only real issue is that with memory ordering,
the "dominance" thing will need to take into account the ordering
requirements of other memory operations with stricter memory ordering
in between. So, for example, if you have

    __atomic_store_n(ptr,1, RELAXED);
    __atomic_load_n(otherptr,2, ACQUIRE);
    __atomic_store_n(ptr,2, RELAXED);

then the second store doesn't dominate the first store, because
there's a stricter memory ordering instruction in between.

But I think the *important* rule is that "Rule 4", which is what
actually gives us the true "atomicity" rule:

 Loads cannot be rematerialized

IOW, when we do a

    a = __atomic_load_n(ptr);

and use the value of 'a' at any point later, it can *never* have
turned into a re-load of that ptr value. Yes, the load might have been
combined with an earlier one, and the load may have been moved up
earlier (by the "you can invent loads and then  combine them with the
later real one" rule).

So even atomic loads can be combined, they can be moved to outside of
loops etc. BUT THEY CANNOT BE RE-DONE.

I think that's really the fundamnetally different rule, and the one
that makes us use 'volatile' in many cases.

So we have a "READ_ONCE()" macro, but in many cases it's really
"READ_AT_MOST_ONCE()". It's usually not that you can't optimize the
read away - you can - but you absolutely must not turn it into two
reads.

Turning a read into two reads is what makes those TOCTOU issues problematic.

Honestly, I'd love to just have that "Rule 4" be there for *all*
variable accesses. Not just __atomic ones. If we had a compiler flag
like "-fno-TUCTOU", I'd enable it.

                    Linus

