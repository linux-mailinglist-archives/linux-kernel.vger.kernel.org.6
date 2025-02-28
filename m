Return-Path: <linux-kernel+bounces-539447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF1CA4A45D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EFE3B42F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1B23F36A;
	Fri, 28 Feb 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnu8sf4z"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1623F396;
	Fri, 28 Feb 2025 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740775283; cv=none; b=sPqHsgRsYAArNW9u8aYznI8i9SFz58JQDZB+KFcGwxKSTCyhExvzTxNEUXemauxtrc7uoBpcR8IKfJCJOZxdsgZoy6SQNlEgqdFL3MHvUhyjlFK3H9GH8FXD//prTaRNgMXgl+r9NkzedJ7MJD0Bzew0vFOrf8H3qhDgZpqlyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740775283; c=relaxed/simple;
	bh=NyoxD5FM4MyfifUH/TlyijlcyvzAGaA7dBWQ5fmKH/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv/5t0BwP1InKgy6SOfl1R06RBsXOJW2ipqQwuu8az5T1PHTJWKlPK+0A3+pRN6QB+jGm7kvJ7o6VvaptDBQ5+RXAa2nMmlc19zm3AxyF8HwwXCixizeJvtz9a1y/7CS6rzLFWP150+Sz7OoozbKF/RpnaTvb8l08dQu6WO+RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnu8sf4z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54605bfcc72so4120816e87.0;
        Fri, 28 Feb 2025 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740775279; x=1741380079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ka+qpefvaYCndZeG6fscUB20UShtau6GzZnUcPiIdQ=;
        b=Vnu8sf4z+qTd6fV4IVWNHAfWhcMLSglUsCPFIu7aL4Zb5URpLRjbUA6IVrQyj9l1XW
         glwNbqhFm6R97pxf2INlDxcZCDDslrl5TtushNzMYQGqnf2qhqsHU3CMsLS76/SgjSOX
         fRxyMtGKIb6txVNyRt903a/2pOkdqwrfw0RmePNWAWKoIGsvLExNzuRH8IEwuctQJ+zb
         GdOywqBzGgnvD2N7Ni9tFlGbb511gAJ2uxhoQrbPJmpUAy0IQMGQHQybqjtUaNtcnp3t
         zIY3QPj7FEm/8c3L85tE42NaO/v//hz9MoomT6/oKkaTEoLJr66APSi1ZufXocioc9Lm
         mduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740775279; x=1741380079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Ka+qpefvaYCndZeG6fscUB20UShtau6GzZnUcPiIdQ=;
        b=IRaJOpYXPKCxh5vLBYuL6nei09yVMrPYGdYkn0dRmbz0gAKNYIu+6p7G1MxD6PyvO+
         X6ADUhNWWKqYDM40akITHd/+N878Vz2Ztjf8VvHaWOd5w5uhavlxNmeGRQdsc6k2OyYn
         k/mFH/X3teHL/DDf2/h5Zyv+K+Nvyoh/Z4zP8RNQ5KkkY5ANn/y3U1jUdiaP6qr/Y5wB
         J/5Nuf1AK+wDq3vq2kNMeWj74RAtRqDRPHKvJjgDjBjNCMPGyILDrlJVqRe+F3nOMpJq
         E3j9Ku7N0l/Ub2mVkEdN+s1Wt8oWQnL6t+e3gjJ02R4ZqqkcpLkIxF/wBiZeZ6uWiHo4
         R+Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV7vWt7svbjPqTM7EB8QLxd2/hF3CvZFE2l/GXh0Mz7cmjJbdrYNG/6G6KBIY2LGaWCKJb0doIMdWCFM5D2YB8=@vger.kernel.org, AJvYcCW7XOqubNrDQufDAHlf+GCEIlgRvOQWLvH+jqALTvPVxiR0Bn8bSKD7cOoc2HfROsN2stmIZ2RXpYSgR3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYuxz8VTlw3RAbHf5//KnFIdkRfhMLCl/P7TwmijctLi2b8FcA
	N23t4fBdeD42tgu09jgrgMuqIqJACI0T70In7r7WtH3DtSIvY/ObsQvYQTCd+fJGfZXrBdoFs4c
	ceX8h24M0YBceHeJxKq18Gvmditk=
X-Gm-Gg: ASbGnctPPbh4nWcQgyaA0lNFqXRSj9gHsgxe0m92BEgx0o1Qiiev0qSH1PEGMnBAi9w
	/WtHB4/e7OPhYOBn1AVqVzaAeALYoqtGOgxfTjktPOdmDCsdL1kHx56KYBe/IcyRQIzgKs2g6oM
	x68cee4pdg
X-Google-Smtp-Source: AGHT+IE343ZsG6URo4IRhQD7BvVekBbL2Qb93StuNoTGwfkNAY5UKRBk3qRaIi8+OpCzNNF3e3OlpsyKsnqhKH8UQRI=
X-Received: by 2002:a05:6512:158f:b0:545:550:83e6 with SMTP id
 2adb3069b0e04-5494c107f7cmr1522453e87.5.1740775278882; Fri, 28 Feb 2025
 12:41:18 -0800 (PST)
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
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de> <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de> <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
 <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de> <CAFJgqgQ=dJk7Jte-aaB55_CznDEnSVcy+tEh83BwmrMVvOpUgQ@mail.gmail.com>
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
In-Reply-To: <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de>
From: Ventura Jack <venturajack85@gmail.com>
Date: Fri, 28 Feb 2025 13:41:05 -0700
X-Gm-Features: AQ5f1JrAbA6K6JebhOeWZy3fiMcSsvoqLjzuz3CjRiPPweW9ZITnovK2-gGD5SU
Message-ID: <CAFJgqgRFEvsyf9Hej-gccSdC-Ce8DbO5DgHatLoJ-aYi1_ZcyA@mail.gmail.com>
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

On Thu, Feb 27, 2025 at 12:45=E2=80=AFPM Ralf Jung <post@ralfj.de> wrote:
>
> Hi,
>
> >>> If C was willing to break code as much as Rust, it would be easier to
> >>> clean up C.
> >>
> >> Is that true? Gcc updates do break code.
> >
> > Surely not as much as Rust, right? From what I hear from users
> > of Rust and of C, some Rust developers complain about
> > Rust breaking a lot and being unstable, while I instead
> > hear complaints about C and C++ being unwilling to break
> > compatibility.
>
> Stable Rust code hardly ever breaks on a compiler update. I don't know wh=
ich
> users you are talking about here, and it's hard to reply anything concret=
e to
> such a vague claim that you are making here. I also "hear" lots of things=
, but
> we shouldn't treat hear-say as facts.
> *Nightly* Rust features do break regularly, but nobody has any right to c=
omplain
> about that -- nightly Rust is the playground for experimenting with featu=
res
> that we know are no ready yet.

I did give the example of the time crate. Do you not consider
that a very significant example of breakage? Surely, with
as public and large an example of breakage as the time crate,
there clearly is something.

I will acknowledge that Rust editions specifically do not
count as breaking code, though the editions feature,
while interesting, does have some drawbacks.

The time crate breakage is large from what I can tell. When I
skim through GitHub issues in different projects,
it apparently cost some people significant time and pain.

    https://github.com/NixOS/nixpkgs/issues/332957#issue-2453023525
        "Sorry for the inconvenience. I've lost a lot of the last
        week to coordinating the update, collecting broken
        packages, etc., but hopefully by spreading out the
        work from here it won't take too much of anybody
        else's time."

    https://github.com/NixOS/nixpkgs/issues/332957#issuecomment-2274824965
        "On principle, rust 1.80 is a new language due
        to the incompatible change (however inadvertent),
        and should be treated as such. So I think we need
        to leave 1.79 in nixpkgs, a little while longer. We can,
        however, disable its hydra builds, such that
        downstream will learn about the issue through
        increased build times and have a chance to step up,
        before their toys break."

Maybe NixOS was hit harder than others.

If you look at.

    https://github.com/rust-lang/rust/issues/127343#issuecomment-2218261296

It has 56 thumbs down.

Some Reddit threads about the time crate breakage.

    https://www.reddit.com/r/programming/comments/1ets4n2/type_inference_br=
eakage_in_rust_180_has_not_been/

        "That response reeks of "rules for thee, but
        not for me" ... a bad look for project that wants
        to be taken seriously."
    https://www.reddit.com/r/rust/comments/1f88s0h/has_rust_180_broken_anyo=
ne_elses_builds/

        "I'm fine with the Rust project making the call that
        breakage is fine in this case, but I wish they would
        then stop using guaranteed backwards compatibility
        as such a prominent selling point. One of the most
        advertised features of Rust is that code that builds
        on any version will build on any future version
        (modulo bugfixes). Which is simply not true (and
        this is not the only case of things being deemed
        acceptable breakage)."

Some of the users there do complain about Rust breaking.
Though others claim that since Rust 1.0, Rust breaks very
rarely. One comment points out that Rust is allowed to
break backwards compatibility in a few cases,
according to its pledge, such as type inference changes.
This does not refer to Rust editions, since those are
clearly defined to have language changes, and have automated
tools for conversion, and Rust projects compile against
the Rust edition specified by the project independent
of compiler version.

rustc/Rust does have change logs.

    https://releases.rs/

and each of the releases have a "Compatibility Notes"
section, and in many of the GitHub issues, crater is
run on a lot of projects to see how many Rust libraries,
if any, are broken by the changes. Though, for bug fixes
and fixing holes in the type system, such breakage
I agree with is necessary even if unfortunate.

> > Rust does admittedly a lot of the time have tools to
> > mitigate it, but Rust sometimes go beyond that.
> > C code from 20 years ago can often be compiled
> > without modification on a new compiler, that is a common
> > experience I hear about. While I do not know if that
> > would hold true for Rust code. Though Rust has editions.
>
> Well, it is true that Rust code from 20 years ago cannot be compiled on t=
oday's
> compiler any more. ;)  But please do not spread FUD, and instead stick to
> verifiable claims or cite some reasonable sources.

Sorry, but I did not spread FUD, please do not accuse
me of doing so when I did not do that. I did give an
example with the time crate, and I did give a source
regarding the time crate. And you yourself acknowledge
my example with the time crate as being a very significant
one.

> > The time crate breaking example above does not
> > seem nice.
>
> The time issue is like the biggest such issue we had ever, and indeed tha=
t did
> not go well. We should have given the ecosystem more time to update to ne=
wer
> versions of the time crate, which would have largely mitigated the impact=
 of
> this. A mistake was made, and a *lot* of internal discussion followed to
> minimize the chance of this happening again. I hope you don't take that a=
ccident
> as being representative of regular Rust development.

Was it an accident? I thought the breakage was intentional,
and in line with Rust's guarantees on backwards
compatibility, since it was related to type inference,
and Rust is allowed to do breaking changes for that
according to its guarantees as I understand it.
Or do you mean that it was an accident that better
mitigation was not done in advance, like you describe
with giving the ecosystem more time to update?

>

Another concern I have is with Rust editions. It is
a well defined way of having language "versions",
and it does have automated conversion tools,
and Rust libraries choose themselves which
edition of Rust that they are using, independent
of the version of the compiler.

However, there are still some significant changes
to the language between editions, and that means
that to determine the correctness of Rust code, you
must know which edition it is written for.

For instance, does this code have a deadlock?

    fn f(value: &RwLock<Option<bool>>) {
        if let Some(x) =3D *value.read().unwrap() {
            println!("value is {x}");
        } else {
            let mut v =3D value.write().unwrap();
            if v.is_none() {
                *v =3D Some(true);
            }
        }
    }

The answer is that it depends on whether it is
interpreted as being in Rust edition 2021 or
Rust edition 2024. This is not as such an
issue for upgrading, since there are automated
conversion tools. But having semantic
changes like this means that programmers must
be aware of the edition that code is written in, and
when applicable, know the different semantics of
multiple editions. Rust editions are published every 3
years, containing new semantic changes typically.

There are editions Rust 2015, Rust 2018, Rust 2021,
Rust 2024.

Best, VJ.

