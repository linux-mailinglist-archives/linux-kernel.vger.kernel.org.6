Return-Path: <linux-kernel+bounces-536987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD38A486B3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C073B5CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6796A1E51EC;
	Thu, 27 Feb 2025 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpZDD3Eo"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C31DF274;
	Thu, 27 Feb 2025 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677649; cv=none; b=Z+zQ/Kfc/UxGnBTUY1wigI4XCMOSmTZ+Yj45rLIGcyo5zaOvpPVr25Pnj9jMuGG0Ldn4GM/R8U4WP9PriXKE979kMK6tKyxkpMU50tO5Jwu76mHgoME0BHWd8vsmd1hRivr01kde1I11GAlyuy75l1i/itgoqRRuC02RM3jvmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677649; c=relaxed/simple;
	bh=5io/u43OHyQ2ai/jTUAdQxiaUovK4D7VNZCRIf2uOfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K10XfSx/J8LmqtB0yAbHEgWeBdu0Y7D+CT3rBxwoqWzi1j6JGcD8Ju43Vo8KmVYevFLINxBvFhRtK27iByRuHzwkT4+ZftbWkHgjdSsPCw1E4NQARnpaqA4E49uq3nXNXnoHHJfkCiUOIXy9/OnA5wLwm+d1OC7knEKt7qH3EWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpZDD3Eo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3091fecb637so10735011fa.1;
        Thu, 27 Feb 2025 09:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740677645; x=1741282445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV0HMykXZypVpGQkkQGaLeN+qp7pfqOToj9ZBxVcMKY=;
        b=TpZDD3EoKE/fFeDf65LrhsV/V66TYLUEhXNpWI6GR2hlt/MnEk9UElYLaLhXj6D7cl
         XRIZhqFO8iral01J9eYXIbvhrLciq8qaERcvrHI6ashutsk5WfD3GxTcRRTRF1ZnYkhI
         D1Q8OOyd9vweV2TrhccrVZG44TcWaVYtGZsKKGeWDZeJt1Xn95JyAtMenR28u2g7O5Fn
         NXIwPKkHTq/lG0ZKG1fQmsIMfVNBtxEK7RZ8ONhCdllRYn07clqiqzQgjloBkSYjq6Yv
         0Rz0uqvv/YorHksr9a8lodEliQjHKphsneQac2aCRtwVDUZ3rCPkba1ppj+uS88s154g
         qPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740677645; x=1741282445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV0HMykXZypVpGQkkQGaLeN+qp7pfqOToj9ZBxVcMKY=;
        b=H/Sav+Fi77NBK1SNHjkNodBM6yiRrT9l1Y0HHB+fkOshQp9dItiWrQ2iYWgtukLzJv
         R+BuUycLnqQqyz33wOBJTH4mKh7Pk8Gfv7/iVkWHdZ7zw9ayKCzOHkmpaQcaF9CYeAzc
         GLgsqvQZj3QuSkwwQoBA8ydNJtk4F3cNmHCe6a77N09MUjtDumCSE5Y8RTGiO9RhPdcS
         mNgpXGqEolEql8LsbccW0NCly7rB1WQNqMkj97Jp/1GTMEY0vlPZNegat2RMGrP65goI
         S1DOuv2r8az22lIcsaff0OYzaMc1lwAEqqcEM+Uq6kOqQztZE0LDjR1RXsStp4FftK94
         8DgA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/mh8ow03bO87BcqOA/v67O0QmHEOrOMAdIKJLdt00CQPlSZZzoKTfNROi+6T3bvuJnGjZNobGXTBVeo=@vger.kernel.org, AJvYcCXV2FPjE83UIYGPyh5x6VFPo+qc1KUfgwTX2N5dBt5QGWBdoNmf5B45K9VDcmZ/IGV2eermofoA5lcvWXYsY6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AWochlhp5HWAl/LxeMTJ+Jb8qvrGSoecJDbX2Tu7/y8AWoqE
	ZamH/NzJvBgVe9BtHcr1eA6wQuanD9HS57fvoLk3dGz9Wd69Rfi+wIHVZsSIhQvva2N0y8oNLtc
	S7de/1yaRlAySfrZD8ItnUF2AuWY=
X-Gm-Gg: ASbGncs5mDZkXIPbtNvgEGhOSLSg6bpBMKnVWWJlgGmbChy23rmdOVsNtk8AfOeoyXY
	55GZ78KmwmbiSTRv9AKiOqmWnK4pbWyzAcJEQKmQsKWL2U+P3BJZc8WCFEcY8sbCLLSCfPm1AB1
	H37NXTWvLo
X-Google-Smtp-Source: AGHT+IE2BH/1NSXRzDXlElgcsEfByXyUcbKRKGR78hEZv7EvEhyk5TgAq8IxZXZq0wHhsseeHK9uPd1WEEbhefpqOR4=
X-Received: by 2002:a2e:3c0b:0:b0:308:ffa1:890b with SMTP id
 38308e7fff4ca-30a80be24bdmr57978641fa.2.1740677644588; Thu, 27 Feb 2025
 09:34:04 -0800 (PST)
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
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
In-Reply-To: <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
From: Ventura Jack <venturajack85@gmail.com>
Date: Thu, 27 Feb 2025 10:33:51 -0700
X-Gm-Features: AQ5f1JqN3AWgV8meR08A05wz9Nzi0d-mCixv49weqXaO89Jr7-WdZ80Dn-oXMRY
Message-ID: <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
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

On Wed, Feb 26, 2025 at 3:28=E2=80=AFPM Ralf Jung <post@ralfj.de> wrote:
>
> Hi all,
>
> On 26.02.25 19:09, Ventura Jack wrote:
> > Is Miri the only one of its kind in the programming world?
> > There are not many system languages in mass use, and
> > those are the languages that first and foremost deal
> > with undefined behavior. That would make Miri extra impressive.
>
> I am not aware of a comparable tool that would be in wide-spread use, or =
that is
> carefully aligned with the semantics of an actual compiler.
> For C, there is Cerberus (https://www.cl.cam.ac.uk/~pes20/cerberus/) as a=
n
> executable version of the C specification, but it can only run tiny examp=
les.
> The verified CompCert compiler comes with a semantics one could interpret=
, but
> that only checks code for compatibility with CompCert C, which has a lot =
less
> (and a bit more) UB than real C.
> There are also two efforts that turned into commercial tools that I have =
not
> tried, and for which there is hardly any documentation of how they interp=
ret the
> C standard so it's not clear what a green light from them means when comp=
iling
> with gcc or clang. I also don't know how much real-world code they can ac=
tually run.
> - TrustInSoft/tis-interpreter, mostly gone from the web but still availab=
le in
> the wayback machine
> (https://web.archive.org/web/20200804061411/https://github.com/TrustInSof=
t/tis-interpreter/);
> I assume this got integrated into their "TrustInSoft Analyzer" product.
> - kcc, a K-framework based formalization of C that is executable. The pub=
lic
> repo is dead (https://github.com/kframework/c-semantics) and when I tried=
 to
> build their tool that didn't work. The people behind this have a company =
that
> offers "RV-Match" as a commercial product claiming to find bugs in C base=
d on "a
> complete formal ISO C11 semantics" so I guess that is where their efforts=
 go now.
>
> For C++ and Zig, I am not aware of anything comparable.
>
> Part of the problem is that in C, 2 people will have 3 ideas for what the
> standard means. Compiler writers and programmers regularly have wildly
> conflicting ideas of what is and is not allowed. There are many different=
 places
> in the standard that have to be scanned to answer "is this well-defined" =
even
> for very simple programs. (https://godbolt.org/z/rjaWc6EzG is one of my f=
avorite
> examples.) A tool can check a single well-defined semantics, but who gets=
 to
> decide what exactly those semantics are?
> Formalizing the C standard requires extensive interpretation, so I am ske=
ptical
> of everyone who claims that they "formalized the C standard" and built a =
tool on
> that without extensive evaluation of how their formalization compares to =
what
> compilers do and what programmers rely on. The Cerberus people have done =
that
> evaluation (see e.g. https://dl.acm.org/doi/10.1145/2980983.2908081), but=
 none
> of the other efforts have (to my knowledge). Ideally such a formalization=
 effort
> would be done in close collaboration with compiler authors and the commit=
tee so
> that the ambiguities in the standard can be resolved and the formalizatio=
n
> becomes the one canonical interpretation. The Cerberus people are the one=
s that
> pushed the C provenance formalization through, so they made great progres=
s here.
> However, many issues remain, some quite long-standing (e.g.
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_260.htm and
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_451.htm, which in my =
eyes
> never got properly resolved by clarifying the standard). Martin and a few=
 others
> are slowly pushing things in the right direction, but it takes a long tim=
e.
> Rust, by having a single project in charge of the one canonical implement=
ation
> and the specification, and having an open process that is well-suited for
> incorporating user concerns, can move a lot quicker here. C has a huge
> head-start, Rust has nothing like the C standard, but we are catching up =
-- and
> our goal is more ambitious than that; we are doing our best to learn from=
 C and
> C++ and concluded that that style of specification is too prone to ambigu=
ity, so
> we are trying to achieve a formally precise unambiguous specification. Wa=
sm
> shows that this can be done, at industry scale, albeit for a small langua=
ge --
> time we do it for a large one. :)
>
> So, yes I think Miri is fairly unique. But please let me know if I missed=
 something!
>
> (As an aside, the above hopefully also explains why some people in Rust a=
re
> concerned about alternative implementations. We do *not* want the current
> de-factor behavior to ossify and become the specification. We do *not* wa=
nt the
> specification to just be a description of what the existing implementatio=
ns at
> the time happen to do, and declare all behavior differences to be UB or
> unspecified or so just because no implementation is willing to adjust the=
ir
> behavior to match the rest. We want the specification to be prescriptive,=
 not
> descriptive, and we will adjust the implementation as we see fit to achie=
ve that
> -- within the scope of Rust's stability guarantees. That's also why we ar=
e so
> cagey about spelling out the aliasing rules until we are sure we have a g=
ood
> enough model.)

Very interesting, thank you for the exhaustive answer.

Might it be accurate to categorize Miri as a
"formal-semantics-based undefined-behavior-detecting interpreter"?

>https://godbolt.org/z/rjaWc6EzG

That example uses a compiler-specific attribute AFAIK, namely

    __attribute__((noinline))

When using compiler-specific attributes and options, the
original language is arguably no longer being used, depending
on the attribute. Though a language being inexpressive and
possibly requiring compiler extensions to achieve some goals,
possibly like in this C example, can be a disadvantage in itself.

> [On formalization]

I agree that Rust has some advantages in regards to formalization,
but some of them that I think of, are different from what you
mention here. And I also see some disadvantages.

C is an ancient language, and parsing and handling C is made
more complex by the preprocessor. Rust is a much younger
language that avoided all that pain, and is easier to parse
and handle. C++ is way worse, though might become closer
to Rust with C++ modules.

Rust is more willing to break existing code in projects, causing
previously compiling projects to no longer compile. rustc does this
rarely, but it has happened, also long after Rust 1.0.

From last year, 2024.

    https://internals.rust-lang.org/t/type-inference-breakage-in-1-80-has-n=
ot-been-handled-well/21374
        "Rust 1.80 broke builds of almost all versions of the
        very popular time crate (edit: please don't shoot the
        messenger in that GitHub thread!!!)

        Rust has left only a 4-month old version working.
        That was not enough time for the entire Rust
        ecosystem to update, especially that older
        versions of time were not yanked, and users
        had no advance warning that it will stop working.

        A crater run found a regression in over 5000 crates,
        and that has just been accepted as okay without
        any further action! This is below the level of stability
        and reliability that Rust should have."

If C was willing to break code as much as Rust, it would be easier to
clean up C.

There is the Rust feature "editions", which is interesting,
but in my opinion also very experimental from a
programming language theory perspective. It does
help avoid breakage while letting the languages developers
clean up the language and improve it, but has some other
consequences, such as source code having different
semantics in different editions. Automated upgrade
tools help with this, but does not handle all consequences.

If C was made from scratch today, by experts at type theory,
then C would likely have a much simpler type system and type
checking than Rust, and would likely be much easier to formalize.
Programs in C would likely still often be more complex than
in C++ or Rust, however.

>[Omitted] We do *not* want the
> specification to just be a description of what the existing implementatio=
ns at
> the time happen to do, and declare all behavior differences to be UB or
> unspecified or so just because no implementation is willing to adjust the=
ir
> behavior to match the rest. [Omitted]

I have seen some Rust proponents literally say that there is
a specification for Rust, and that it is called rustc/LLVM.
Though those specific individuals may not have been the
most credible individuals.

A fear I have is that there may be hidden reliance in
multiple different ways on LLVM, as well as on rustc.
Maybe even very deeply so. The complexity of Rust's
type system and rustc's type system checking makes
me more worried about this point. If there are hidden
elements, they may turn out to be very difficult to fix,
especially if they are discovered to be fundamental.
While having one compiler can be an advantage in
some ways, it can arguably be a disadvantage
in some other ways, as you acknowledge as well
if I understand you correctly.

You mention ossifying, but the more popular Rust becomes,
the more painful breakage will be, and the less suited
Rust will be as a research language.

Using Crater to test existing Rust projects with, as you
mention later in your email, is an interesting and
possibly very valuable approach, but I do not know
its limitations and disadvantages. Some projects
will be closed source, and thus will presumably
not be checked, as I understand it.

Does Crater run Rust for Linux and relevant Rust
kernel code?

I hope that any new language at least has its
language developers ensure that they have a type
system that is formalized and proven correct
before that langauge's 1.0 release.
Since fixing a type system later can be difficult or
practically impossible. A complex type system
and complex type checking can be a larger risk in this
regard relative to a simple type system and simple
type checking, especially the more time passes and
the more the language is used and have code
written in it, making it more difficult to fix the language
due to code breakage costing more.

Some languages that broke backwards compatibility
arguably suffered or died because of it, like Perl 6
or Scala 3. Python 2 to 3 was arguably successful but painful.
Scala 3 even had automated conversion tools AFAIK.

> > There are some issues in Rust that I am curious as to
> > your views on. rustc or the Rust language has some type
> > system holes, which still causes problems for rustc and
> > their developers.
> >
> >      https://github.com/lcnr/solver-woes/issues/1
> >      https://github.com/rust-lang/rust/issues/75992
> >
> > Those kinds of issues seem difficult to solve.
> >
> > In your opinion, is it accurate to say that the Rust language
> > developers are working on a new type system for
> > Rust-the-language and a new solver for rustc, and that
> > they are trying to make the new type system and new solver
> > as backwards compatible as possible?
>
> It's not really a new type system. It's a new implementation for the same=
 type
> system. But yes there is work on a new "solver" (that I am not involved i=
n) that
> should finally fix some of the long-standing type system bugs. Specifical=
ly,
> this is a "trait solver", i.e. it is the component responsible for dealin=
g with
> trait constraints. Due to some unfortunate corner-case behaviors of the o=
ld,
> organically grown solver, it's very hard to do this in a backwards-compat=
ible
> way, but we have infrastructure for extensive ecosystem-wide testing to j=
udge
> the consequences of any given potential breaking change and ensure that a=
lmost
> all existing code keeps working. In fact, Rust 1.84 already started using=
 the
> new solver for some things
> (https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html) -- did you notic=
e?
> Hopefully not. :)

If it is not a new type system, why then do they talk about
backwards compatibility for existing Rust projects?
If the type system is not changed, existing projects would
still type check. And in this repository of one of the main
Rust language developers as I understand it, several
issues are labeled with "S-fear".

    https://github.com/lcnr/solver-woes/issues

They have also been working on this new solver for
several years. Reading through the issues, a lot of
the problems seem very hard.

Best, VJ.

