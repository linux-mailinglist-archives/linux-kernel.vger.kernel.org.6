Return-Path: <linux-kernel+bounces-539987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A0DA4ABA7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50EB1894155
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81804A936;
	Sat,  1 Mar 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL0Ag6CD"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D253F7082E;
	Sat,  1 Mar 2025 14:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838810; cv=none; b=hISeHwspeekotNhiGf/rVyxh0kTXOYzKWv405CG5jeCKS5FVRsSH5yLRvVanwgbZPiROrteoP0E+XaWGY1MSdsitiHwiahUENWOX1Me8OJriBSMkJ11ibtXAySbB8w8W9vTCzor12cy7xcazxWFWAJ9smCucA+VYqosqijgCLc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838810; c=relaxed/simple;
	bh=I9Baj9A+fsR5bFCEtrETbxXs9SC5drcgEX80avEOLcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXrw+nTYmJiDFNuulUQNup4j/ZhpftsWffy8dMwB4FUT3rYh/F6okYIk6dwzHrKHpqaC7b2/88uF6iJ/6J0KncJV/ZMMiNo9M2LftUIeuoyqzaa9ZutIYFStDmx6zUSS7QlOYQMEu0yz8qXeEcRWlpvCozsHkFt7xDeoDLxI7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL0Ag6CD; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so3310864e87.1;
        Sat, 01 Mar 2025 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740838806; x=1741443606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLS3jSE00sqMk37iDI4hkEvd9hI3hjjVW7ZU2pTcQFY=;
        b=VL0Ag6CDRmSbtNh0McAq3fVvZDdhyqnnw43Q/F0Kx6E9UEG4v5wXMYeZvavgqPHOLG
         Sp4/Y9LymMYTYk4JVpQiYTaU/C2zhpfF38CWwKuLvCx5AsxHseol3ykuAIqocHpnZ5Jr
         tc2Pw1pSGQsjw8b74Y1H+8lrWN18dtKGfndjnIMHmGuDXirYOMM8+Epe5JGBOi9XAa4X
         hQv1UiyAyRiodQ3AM+YTcjnnIZeI9Eh5hPm6ptYtTvHbmWJ9gsGlzAxWPMJHTkOs/ioI
         nCXZevtgEixjfx8gn5/9MUM8C5DMcCIG69+jfP29qtOIlVpwXBKKxNTF/OhPxy/zo83q
         tUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838806; x=1741443606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLS3jSE00sqMk37iDI4hkEvd9hI3hjjVW7ZU2pTcQFY=;
        b=WkgIlyS0Ua53Rf6/xaxgmb4/8Pljign92EhVUURZZE6TNe+dWRmhtiWdhJOnOlq75i
         3kNAY5woL9aFjBw2lxxjWoGGr12Z0+80zlo2JOsRfRH47U8QlQfaSQvbl0TZVACUX2Sq
         5Y809hNvrT6vtNchgsQhJ8klT21jPg09FxQNxVDk1G3HQvq/sASyw6tuafHk872z0vo3
         5w0DgFuJoEg4mckkrryovq20V6zhi08jHpN2//OlrTzwXptzrsTxvMxX6SEAc3hQ5utJ
         qEdah/gjPFZesS6adqD7F6b0YvGY10thCNoie5PRAQ1w1MX92VBohEksMMon4Z7cuBxA
         /JXg==
X-Forwarded-Encrypted: i=1; AJvYcCUFVjLpXuWD1+js5ywCL9EnP5q+q0s3R+sh7KasNHm91IXC/vG8wfbNcD8GyzMo8FUTIv0cjk+/v3odywU=@vger.kernel.org, AJvYcCUKvZr/aHZ76Ep8xpocEfKD1q+0fH1HXRoBdacYnfAaLcFMR7VIl9LYDtZY7db2VGo9RE56qTs5o/k1nD6msXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws1B9MWpv0z2hWAWwF62PaZKbwKpmxIbWFF8cDcDO2DzCv67CE
	w9fMAMi8rGRxpdmfP3YB9Ki14PkqpTpu1OEFvRBUcaUvP067PgNPPOmO1PBE16hxv8pMOAHv/uW
	NAror4VgZE5Nj3c9ETjO9njyOXiw=
X-Gm-Gg: ASbGncsGpF2Gb4U9gL7Ww/30VywXRrycTBEgWiaAsZzHwmGefDxC+t6JQNPQb5XCGXK
	SXyVnqzY9lsclvBWTZugqJ4lUMZUikKYMz8yaMMDoK/tj06kAK0dKLM3DhlRjMniRIXEC4Z2GJM
	1g8wXvnsn6ZPFG0JXa1G/KrWOc2s0=
X-Google-Smtp-Source: AGHT+IHm8ujVA4j/9NP7rgoMSl13X1DfD+gjbDGYTc/ywSKueUWwkmetMGccYlGU9pD0HRGNIS34j1p/ZGKXIU8W1+8=
X-Received: by 2002:a05:6512:b90:b0:545:a2f:22b4 with SMTP id
 2adb3069b0e04-5494c37d8e6mr2344135e87.40.1740838805373; Sat, 01 Mar 2025
 06:20:05 -0800 (PST)
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
 <651a087b-2311-4f70-a2d3-6d2136d0e849@ralfj.de> <CAFJgqgRFEvsyf9Hej-gccSdC-Ce8DbO5DgHatLoJ-aYi1_ZcyA@mail.gmail.com>
 <09acd087-ba88-4b8e-950b-dfede2f8bec3@app.fastmail.com>
In-Reply-To: <09acd087-ba88-4b8e-950b-dfede2f8bec3@app.fastmail.com>
From: Ventura Jack <venturajack85@gmail.com>
Date: Sat, 1 Mar 2025 07:19:50 -0700
X-Gm-Features: AQ5f1JogJdhZbg2NsxeMOL5Q7579L4yP9a3jDALSbB57ifvFLLhgTFi0OOu9N48
Message-ID: <CAFJgqgTmxeH+y8yir1WL2YvLXhemGE9WU0sDBnyx8yVz8OAxyw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Geoffrey Thomas <geofft@ldpreload.com>
Cc: Ralf Jung <post@ralfj.de>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 3:14=E2=80=AFPM Geoffrey Thomas <geofft@ldpreload.c=
om> wrote:
>
> On Fri, Feb 28, 2025, at 3:41 PM, Ventura Jack wrote:
> >
> > I did give the example of the time crate. Do you not consider
> > that a very significant example of breakage? Surely, with
> > as public and large an example of breakage as the time crate,
> > there clearly is something.
> >
> > I will acknowledge that Rust editions specifically do not
> > count as breaking code, though the editions feature,
> > while interesting, does have some drawbacks.
> >
> > The time crate breakage is large from what I can tell. When I
> > skim through GitHub issues in different projects,
> > it apparently cost some people significant time and pain.
> >
> >     https://github.com/NixOS/nixpkgs/issues/332957#issue-2453023525
> >         "Sorry for the inconvenience. I've lost a lot of the last
> >         week to coordinating the update, collecting broken
> >         packages, etc., but hopefully by spreading out the
> >         work from here it won't take too much of anybody
> >         else's time."
> >
> >     https://github.com/NixOS/nixpkgs/issues/332957#issuecomment-2274824=
965
> >         "On principle, rust 1.80 is a new language due
> >         to the incompatible change (however inadvertent),
> >         and should be treated as such. So I think we need
> >         to leave 1.79 in nixpkgs, a little while longer. We can,
> >         however, disable its hydra builds, such that
> >         downstream will learn about the issue through
> >         increased build times and have a chance to step up,
> >         before their toys break."
>
> There's two things about this specific change that I think are relevant
> to a discussion about Rust in the Linux kernel that I don't think got
> mentioned (apologies if they did and I missed it in this long thread).
>
> First, the actual change was not in the Rust language; it was in the
> standard library, in the alloc crate, which implemented an additional
> conversion for standard library types (which is why existing code became
> ambiguous). Before v6.10, the kernel had an in-tree copy/fork of the
> alloc crate, and would have been entirely immune from this change. If
> someone synced the in-tree copy of alloc and noticed the problem, they
> could have commented out the new conversions, and the actual newer rustc
> binary would have continued to compile the old kernel code.
>
> To be clear, I do think it's good that the kernel no longer has a copy
> of the Rust standard library code, and I'm not advocating going back to
> the copy. But if we're comparing the willingness of languages to break
> backwards compatibility in a new version, this is much more analogous to
> C or C++ shipping a new function in the standard library whose name
> conflicts with something the kernel is already using, not to a change in
> the language semantics. My understanding is that this happened several
> times when C and C++ were younger (and as a result there are now rules
> about things like leading underscores, which language users seem not to
> be universally aware of, and other changes are now relegated to standard
> version changes).

>[Omitted] But if we're comparing the willingness of languages to break
> backwards compatibility in a new version, this is much more analogous to
> C or C++ shipping a new function in the standard library whose name
> conflicts with something the kernel is already using, not to a change in
> the language semantics. [Omitted]

I am not sure that this would make sense for C++, since C++
has namespaces, and thus shipping a new function should
not be an issue, I believe. For C++, I suspect it would be more
analogous to for instance adding an extra implicit conversion
of some kind, since that would fit more with changed type
inference. Has C++ done such a thing?

However, for both C and C++, the languages and standard
libraries release much less often, at least officially. And the
languages and standard libraries do not normally change
with a compiler update, or are not normally meant to. For
Rust, I suppose the lines are currently more blurred
between the sole major Rust compiler rustc, the Rust
language, and the Rust standard library, when rustc has a new
release. Some users complained that this kind of change
that affected the Rust time crate and others, should have
been put in a new Rust edition. The 1.80 was a relatively
minor rustc compiler release, not a Rust language edition
release.

Different for Rust in that it was a minor compiler release that
broke a lot, not even a new Rust edition. And also different in that
it broke what did and did not compile from what I can tell.
And Rust has long ago reached 1.0.

I wonder if this situation would still have been able to happen
if gccrs was production ready Would projects just have been able
to swith to gccrs instead? Or more easily stay on an older
release/version of rustc? I am not sure how it would all pan out.

I do dislike it a lot if C has added functions that could cause
name collisions, especially after C matured. Though I
assume that these name collisions these days at
most happen in new releases/standard versions of
the C language and library, not in compiler versions. C could
have avoided all that with features like C++ namespaces or
Rust modules/crates, but C is intentionally kept simple.
C's simplicity has various trade-offs.

> Which brings me to the second point: the reason this was painful for,
> e.g., NixOS is that they own approximately none of the code that was
> affected. They're a redistributor of code that other people have written
> and packaged, with Cargo.toml and Cargo.lock files specifying specific
> versions of crates that recursively eventually list some specific
> version of the time crate. If there's something that needs to be fixed
> in the time crate, every single Cargo.toml file that has a version bound
> that excludes the fixed version of the time crate needs to be fixed.
> Ideally, NixOS wouldn't carry this patch locally, which means they're
> waiting on an upstream release of the crates that depend on the time
> crate. This, then, recursively brings the problem to the crates that
> depend on the crates that depend on the time crate, until you have
> recursively either upgraded your versions of everything in the ecosystem
> or applied distribution-specific patches. That recursive dependency walk
> with volunteer FOSS maintainers in the loop at each step is painful.
>
> There is nothing analogous in the kernel. Because of the no-stable-API
> rule, nobody will find themselves needing to make a release of one
> subsystem, then upgrading another subsystem to depend on that release,
> then upgrading yet another subsystem in turn. They won't even need
> downstream subsystem maintainers to approve any patch. They'll just make
> the change in the file that needs the change and commit it. So, while a
> repeat of this situation would still be visible to the kernel as a break
> in backwards compatibility, the actual response to the situation would
> be thousands of times less painful: apply the one-line fix to the spot
> in the kernel that needs it, and then say, "If you're using Rust 1.xxx
> or newer, you need kernel 6.yyy or newer or you need to cherry-pick this
> patch." (You'd probably just cc -stable on the commit.) And then you're
> done; there's nothing else you need to do.

My pondering in

>> Maybe NixOS was hit harder than others.

must have been accurate then. Though some others were
hit as well, presumably typically significantly less hard than NixOS.

> There are analogously painful experiences with C/C++ compiler upgrades
> if you are in the position of redistributing other people's code, as
> anyone who has tried to upgrade GCC in a corporate environment with
> vendored third-party libraries knows. A well-documented public example
> of this is what happened when GCC dropped support for things like
> implicit int: old ./configure scripts would silently fail feature
> detection for features that did exist, and distributions like Fedora
> would need to double-check the ./configure results and decide whether to
> upgrade the library (potentially triggering downstream upgrades) or
> carry a local patch. See the _multi-year_ effort around
> https://fedoraproject.org/wiki/Changes/PortingToModernC
> https://news.ycombinator.com/item?id=3D39429627

Is this for a compiler version upgrade, or for a new language and
standard library release? The former happens much more often for C
than the latter.

Implicit int was not a nice feature, but its removal was also
not nice for backwards compatibility, I definitely agree about that.
But are you sure that it was entirely silent? When I run it in Godbolt
with different versions of GCC, a warning is given for many
older versions of GCC if implicit int is used. And in newer
versions, in at least some cases, a compile time error is given.
Implicit int was removed in C99, and GCC allowed it with a warning
for many years after 1999, as far as I can see.

If for many years, or multiple decades (maybe 1999 to 2022), a
warning was given, that does mitigate it a bit. But I agree
it is not nice. I suppose this is where Rust editions could help
a lot. But Rust editions are used much more frequently, much
more extensively and for much deeper changes (including
semantic changes) than this as far as I can figure out. A
Rust editions style feature, but with way more careful
and limited usage, might have been nice for the C language,
and other languages. Then again, Rust's experiment with
Rust editions, and also how Rust uses its editions feature, is
interesting, experimental and novel as far as I can figure out.

> Within the Linux kernel, this class of pain doesn't arise: we aren't
> using other people's packaging or other people's ./configure scripts.
> We're using our own code (or we've decided we're okay acting as if we
> authored any third-party code we vendor), and we have one build system
> and one version of what's in the kernel tree.
>
> So - without denying that this was a compatibility break in a way that
> didn't live up to a natural reading of Rust's compatibility promise, and
> without denying that for many communities other than the kernel it was a
> huge pain, I think the implications for Rust in the kernel are limited.

In this specific case. But does the backwards compatibility
guarantees for the Rust language that allows type inference
changes, only apply to the Rust standard library, or also
to the language?

And there are multiple parts of the Rust
standard library, "core", "alloc", "std". Can the changes
happen to the parts of the Rust standard library that
everyone necessarily uses as I understand it? On the
other hand, I would assume that will not happen, "core"
is small and fundamental as I understand it.

And it did happen with a rustc release, not a new Rust
edition.

> > Another concern I have is with Rust editions. It is
> > a well defined way of having language "versions",
> > and it does have automated conversion tools,
> > and Rust libraries choose themselves which
> > edition of Rust that they are using, independent
> > of the version of the compiler.
> >
> > However, there are still some significant changes
> > to the language between editions, and that means
> > that to determine the correctness of Rust code, you
> > must know which edition it is written for.
> >
> > For instance, does this code have a deadlock?
> >
> >     fn f(value: &RwLock<Option<bool>>) {
> >         if let Some(x) =3D *value.read().unwrap() {
> >             println!("value is {x}");
> >         } else {
> >             let mut v =3D value.write().unwrap();
> >             if v.is_none() {
> >                 *v =3D Some(true);
> >             }
> >         }
> >     }
> >
> > The answer is that it depends on whether it is
> > interpreted as being in Rust edition 2021 or
> > Rust edition 2024. This is not as such an
> > issue for upgrading, since there are automated
> > conversion tools. But having semantic
> > changes like this means that programmers must
> > be aware of the edition that code is written in, and
> > when applicable, know the different semantics of
> > multiple editions. Rust editions are published every 3
> > years, containing new semantic changes typically.
>
> This doesn't seem particularly different from C (or C++) language
> standard versions. The following code compiles successfully yet behaves
> differently under --std=3Dc23 and --std=3Dc17 or older:
>
> int x(void) {
>     auto n =3D 1.5;
>     return n * 2;
> }
>
> (inspired by https://stackoverflow.com/a/77383671/23392774)
>

I disagree with you 100% here regarding your example.

First off, your example does not compile like you claim it does
when I try it.

    #include "stdio.h"

    int x(void) {

        auto n =3D 1.5;
        return n * 2;
    }

    int main() {

        printf("%d", x());

        return 0;
    }

When I run it with GCC 14.2 --std=3Dc17, or Clang 19.1.0 --std=3Dc17,
I get compile-time errors, complaining about implicit int.
Why did you claim that it would compile successfully?
When I run it with GCC 5.1 or Clang 3.5, I get compile-time
warnings instead about implicit int. Only with --std=3Dc23
does it compile and run.

Like, that example must have either given warnings or compile-time
errors for decades.

Second off, this appears to be a combination of two changes,
implicit int and storage-class specifier/type inference dual
meaning of `auto`.

- "Implicit int", removed in C99, compile-time warning in GCC
    from perhaps 1999 to 2022, gives a compile-time error
    from perhaps 2022.
- `auto` keyword in C, used originally as a storage-class
    specifier, like in `auto double x`. Since `auto` is typically the
    default storage-class for the cases where it can apply,
    as I understand it, it was probably almost never used in
    practice. In C23, they decided to reuse it for type inference
    as well. C23 keeps it as a storage-class specifier. The reason
    for reusing it here is probably due to the desire to avoid
    collisions and to keep as much backwards compatibility
    as possible, and because there were few keywords to use.
    And to be more consistent with C++.
- C++ might never have allowed implicit int, I am not sure.
    C++ did use the `auto` keyword as a storage-class specifier,
    but removed it for that purpose in C++11, and made its
    meaning to be type inference instead. But before C++11,
    `auto n =3D 1.5` was not allowed, since implicit int was
    not allowed in C++, possibly never allowed.

Even though there are probably very few programs out there
that use or used `auto` as a storage-class specifier for either
C or C++, I do dislike this change in some ways, since it could
as you say change language semantics. The combination in
your example is rare, however, and there might have been
decades of compile-time warnings or errors between. I do
not know whether it occurred in practice, since using `auto`
as a storage-class specifier must have been very rare, and
when used, the proper usage would have been more akin to
`auto int x` or `auto float x`.

And with decades of compile-time warnings, and removal from
the language for decades, this example you give here honestly
seems like an example against your points, not for your points.

I do dislike this kind of keyword reusage, even when done
very carefully, since it could lead to trouble. For C and C++,
they are heavily constrained in what they can do here,
while Rust has the option of Rust editions. But Rust editions
are used for much less careful and much deeper changes
like above, where the same code in one edition causes a
deadlock, in another does not cause a deadlock and runs.

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

For the specific example.

    https://doc.rust-lang.org/edition-guide/rust-2024/temporary-if-let-scop=
e.html

How to handle the issue of keywords, from the perspective of
programming language design? In C and C++,
the approach appears to be, to be very careful. In Rust,
there is Rust editions, which I honestly believe can be a
good approach if used in a minimal way, maybe like rare, tiny
changes that do not change semantics, like every 20 years. Rust
on the other hand uses Rust editions to make more frequent
(every 3 years) and much deeper changes, and to semantics.
The usage that Rust has with its editions feature reminds me
more of an experimental research language, or like Scala.
On the other hand, maybe I am wrong, and it is fine for Rust
to use its editions like this. But I am very wary of it, and it seems
experimental to me. Then there are other programming
language design approaches as well, like giving keywords their
own syntactic namespace, but that can only be done when
designing a new language.

Best, VJ.

