Return-Path: <linux-kernel+bounces-534608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887A2A4690D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3AA7AA4C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70373233145;
	Wed, 26 Feb 2025 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/OP1QJW"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38622D78A;
	Wed, 26 Feb 2025 18:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593364; cv=none; b=EvAtHkWxcsPGNbQohminihIp/upvAIxPeAJVA88zRZeUvyPBUMPx3D1fho1K014QY5nCC5ynnaBEFhX0vBhEhESoW0iqviTVFIuQaIJjDQUKKUcTjsYtp2c3HDhtYjr9JzGn1La8J5FCNMDiTlspC9I75nF6H4IaL/yLwxOr7/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593364; c=relaxed/simple;
	bh=ghaLJqFogOvVe+OLYpjWEiRrvLS3b1151qU4t9x9ggU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOMErP0+hYb142inhi5qSfd9/RiwGhlsvNagJx8RzChiz+/svTenkcS6e1nvzTkok8WbtAdctzDEYPignMxEBqzRIMw3neeLkupkPiWVrvCaGBNIz4KWC2w4sbyqdG3LdWUVa9N51ei/X6Xn9WN97sqz93AFWsH3pRkm7emAgXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/OP1QJW; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30a2dfcfd83so1135051fa.1;
        Wed, 26 Feb 2025 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593361; x=1741198161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6P8EkSd3yrtJe7fRrTsqN53CGSCMEbijuvinHNryBE=;
        b=E/OP1QJWb0EzH4ih5YXvRsuG8cAMFsTQCS/LmIxsSEN9S+j1f4V5P6f8cNq9CQY9Im
         zHu8Qlu33n/Dfw9k6m91fS7KlGYDNVPPiq4BQ7KF7AbkdYT13jMkY3Uix3raYxbRwxDJ
         QDVmnKfblHlCcFxdW61eAUjuM+DrAePsXuckDZWAtikm7eigRFc014MhOMEvgmT1XyUS
         g4KK5od1omzQW40tOTd4zwefWcpZCIO5BktxkEWgsU+WDQeYunF1JGUqXqRSy7ygFNOb
         5ZGdpEbY7YyRyU8QHRuIsVFKb8/0ydW6yfelZvTXdQthUcp12u/RAdWeQVnul6RZarMs
         bzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593361; x=1741198161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6P8EkSd3yrtJe7fRrTsqN53CGSCMEbijuvinHNryBE=;
        b=Pez/eLHu1yyK9r5DrdFVXbvqewEIvvoUypuvazsxHmg1DlSuqi3ss8oO1loI2ndNo1
         bmAqd5/g4SJ3QEG4JTUByw65jMkCOfrJLxy7LbbtwMFjKsMjHV0exheS5sbH0t11CD+W
         kGUa05p6heZ1l9X0LN7ZC1KjDpCLCAsFqABWIDAGHnywCy49aU7nWITuIChu//lxDztO
         WnkrEbY2KV2eknTwsucOr7WsLTQGBHHW0kCqqBrzLfkf3d7HuxKZ9N24jrbEcdDq6RFc
         U3fCXQXhtUa8deUUb8j6uHdxdti8A2B/EmoEgO9JZd50pk+wPtntbw3S1JilSQKsEFKO
         sakA==
X-Forwarded-Encrypted: i=1; AJvYcCU7/BCgj+zhiD8c7YxsWwJEHfQyxAkF84dkKRyQGSC1Oq5en9mZeySfN6j/9Y/Fq4K3MqlXg4JIJODnU1Q=@vger.kernel.org, AJvYcCXPKkqrLVcq0XVPcjHSZFDtvAaTAM8pnXo1boVU9X+FNUIyY51APHMUx6625ZdHpyo5AdnwV+flyI+l9fPjC/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmqMZvOlxwbhoUx9zJmjdjWyMHNtWvqf7xyifqkWkTvsOL9Jq8
	ddXILsyj8AbTYjC92dXyjE9LcRgw2XWjiXX3zfsEGY5Marc79CCgUXFpDfcxXftr0ArUssqazUt
	WY14WqsdUfxeyfyMkwJ3u+cQz18IIbmuh
X-Gm-Gg: ASbGncsFJdBsX6q/QQJdv/mf4IW4n3OGChcSeaC/bk5iWST0DPzkw2Jph4olnPpTS1a
	yCnU9y8tXf+9mccYqRS58tFqzvnLmF3YWOiDlxylq7mNWiEY91KyjakXyDfTsvcs7arwTlDyS2w
	E6x/2MHHp3
X-Google-Smtp-Source: AGHT+IGJNa+ri2Oao//go0VSlyRtOlg3wgaCSf6LWBeLXhaVuBr+YK/0oze/PXh/F38YbXkdqfmir870UMfoNc57uc8=
X-Received: by 2002:a2e:9590:0:b0:307:e498:1269 with SMTP id
 38308e7fff4ca-30a599a2963mr92116491fa.37.1740593360376; Wed, 26 Feb 2025
 10:09:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de> <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
In-Reply-To: <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
From: Ventura Jack <venturajack85@gmail.com>
Date: Wed, 26 Feb 2025 11:09:06 -0700
X-Gm-Features: AQ5f1JpKwr8B5qkGZ9Z_bzqjhe0vCBiX0W_T_JL0hCE3Frc9QZXyZjcDXlFrTOQ
Message-ID: <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ralf Jung <post@ralfj.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:32=E2=80=AFAM Ralf Jung <post@ralfj.de> wrote:
>
> Hi VJ,
>
> >>
> >>> - Rust has not defined its aliasing model.
> >>
> >> Correct. But then, neither has C. The C aliasing rules are described i=
n English
> >> prose that is prone to ambiguities and misintepretation. The strict al=
iasing
> >> analysis implemented in GCC is not compatible with how most people rea=
d the
> >> standard (https://bugs.llvm.org/show_bug.cgi?id=3D21725). There is no =
tool to
> >> check whether code follows the C aliasing rules, and due to the aforem=
entioned
> >> ambiguities it would be hard to write such a tool and be sure it inter=
prets the
> >> standard the same way compilers do.
> >>
> >> For Rust, we at least have two candidate models that are defined in fu=
ll
> >> mathematical rigor, and a tool that is widely used in the community, e=
nsuring
> >> the models match realistic use of Rust.
> >
> > But it is much more significant for Rust than for C, at least in
> > regards to C's "restrict", since "restrict" is rarely used in C, while
> > aliasing optimizations are pervasive in Rust. For C's "strict aliasing"=
,
> > I think you have a good point, but "strict aliasing" is still easier to
> > reason about in my opinion than C's "restrict". Especially if you
> > never have any type casts of any kind nor union type punning.
>
> Is it easier to reason about? At least GCC got it wrong, making no-aliasi=
ng
> assumptions that are not justified by most people's interpretation of the=
 model:
> https://bugs.llvm.org/show_bug.cgi?id=3D21725
> (But yes that does involve unions.)

For that specific bug issue, there is a GitHub issue for it.

    https://github.com/llvm/llvm-project/issues/22099

And the original test case appears to have been a compiler bug
and have been fixed, at least when I run on Godbolt against
a recent version of Clang. Another comment says.

    "The original testcase seems to be fixed now but replacing
    the union by allocated memory makes the problem come back."

And the new test case the user mentions involves a void pointer.

I wonder if they could close the issue and open a new issue
in its stead that only contains the currently relevant compiler
bugs if there are any. And have this new issue refer to the old
issue. They brought the old issue over from the old bug tracker.
But I do not have a good handle on that issue.

Unions in C, C++ and Rust (not Rust "enum"/tagged union) are
generally sharp. In Rust, it requires unsafe Rust to read from
a union.

> > [Omitted]
>
> Okay, fair. But it is easy to misunderstand the other items in your list =
in
> isolation.

I agree, I should have made it unambiguous and made each item
not require the context of other items, or have made the
dependencies between items clearer, or some other way.
I remember not liking the way I organized it, but did not
improve it before sending, apologies.

> >>
> >> [Omitted].
> >
> > I do not believe that you are correct when you write:
> >
> >      "Unlike sanitizers, Miri can actually catch everything."
> >
> > Critically and very importantly, unless I am mistaken about MIRI, and
> > similar to sanitizers, MIRI only checks with runtime tests. That means
> > that MIRI will not catch any undefined behavior that a test does
> > not encounter. If a project's test coverage is poor, MIRI will not
> > check a lot of the code when run with those tests. Please do
> > correct me if I am mistaken about this. I am guessing that you
> > meant this as well, but I do not get the impression that it is
> > clear from your post.
>
> Okay, I may have misunderstood what you mean by "catch everything". All
> sanitizers miss some UB that actually occurs in the given execution. This=
 is
> because they are inserted in the pipeline after a bunch of compiler-speci=
fic
> choices have already been made, potentially masking some UB. I'm not awar=
e of a
> sanitizer for sequence point violations. I am not aware of a sanitizer fo=
r
> strict aliasing or restrict. I am not aware of a sanitizer that detects U=
B due
> to out-of-bounds pointer arithmetic (I am not talking about OOB accesses;=
 just
> the arithmetic is already UB), or UB due to violations of "pointer lifeti=
me end
> zapping", or UB due to comparing pointers derived from different allocati=
ons. Is
> there a sanitizer that correctly models what exactly happens when a struc=
t with
> padding gets copied? The padding must be reset to be considered "uninitia=
lized",
> even if the entire struct was zero-initialized before. Most compilers imp=
lement
> such a copy as memcpy; a sanitizer would then miss this UB.
>
> In contrast, Miri checks for all the UB that is used anywhere in the Rust
> compiler -- everything else would be a critical bug in either Miri or the=
 compiler.
> But yes, it only does so on the code paths you are actually testing. And =
yes, it
> is very slow.

I may have been ambiguous again, or unclear or misleading,
I need to work on that.

The description you have here indicates that Miri is in many ways
significantly better than sanitizers in general.

I think it is more accurate of me to say that Miri in some aspects
shares some of the advantages and disadvantages of sanitizers,
and in other aspects is much better than sanitizers.

Is Miri the only one of its kind in the programming world?
There are not many system languages in mass use, and
those are the languages that first and foremost deal
with undefined behavior. That would make Miri extra impressive.

>

There are some issues in Rust that I am curious as to
your views on. rustc or the Rust language has some type
system holes, which still causes problems for rustc and
their developers.

    https://github.com/lcnr/solver-woes/issues/1
    https://github.com/rust-lang/rust/issues/75992

Those kinds of issues seem difficult to solve.

In your opinion, is it accurate to say that the Rust language
developers are working on a new type system for
Rust-the-language and a new solver for rustc, and that
they are trying to make the new type system and new solver
as backwards compatible as possible?

Best, VJ.

