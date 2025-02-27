Return-Path: <linux-kernel+bounces-537021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC33A48720
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1928D3AB1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EE71F5822;
	Thu, 27 Feb 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b="b8XT2yGZ"
Received: from r-passerv.ralfj.de (r-passerv.ralfj.de [109.230.236.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E631E521C;
	Thu, 27 Feb 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.230.236.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679111; cv=none; b=Ii4ZhFpaSHsEpsKigicu2Y0h0XY8j5Z7ZN2Zrump03A2okFa8Si1yNxOsAeboRLrv0MoxZfh+I8qyYqFfROFoFmvfeQEErMPzu/YDZ8P+O4rF2Y2oCY6+X6G7HMRuPABzWsr80Lx08rc19A0TUB+indIHv3Aq9ih5WNzJO7S8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679111; c=relaxed/simple;
	bh=mZkkEvGR/PGpoQp4szUvHTH9Gi6uPwc66njoeEU+AE4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P4b4Lc9tdh8284z5Y6txdG/3YdITsr+x47DmqzOY+93Q/NcPKfMYYsZHkaLAG6qkfXkor4Q35ruzWfQ8AoEadEE5uGGMY80u0Mjv3S6Wy7KlBhsIfxHQZNKfxtPuVnTQfX+j7NMnNrP1AfaMB33i2eTunEdS1CUUCR7fnvXu1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de; spf=pass smtp.mailfrom=ralfj.de; dkim=pass (1024-bit key) header.d=ralfj.de header.i=@ralfj.de header.b=b8XT2yGZ; arc=none smtp.client-ip=109.230.236.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ralfj.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ralfj.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ralfj.de; s=mail;
	t=1740679107; bh=mZkkEvGR/PGpoQp4szUvHTH9Gi6uPwc66njoeEU+AE4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=b8XT2yGZRyjX52ZrMaai0Z3b/AEZjNCpawZh7JpvUtIKc5NDGIlzZDXDDqDYZ6ixG
	 1ZrR5OHask2lz8RDApuNKgQ0U3hTTHDkrmVFKzKwTTn3bb3zR/h7sni9tNLHdOX6Ds
	 C0E2Rp/fTkUur2y7vjAlQDrQTyJZcf5eszMr/88Q=
Received: from [IPV6:2001:67c:10ec:5784:8000::87] (2001-67c-10ec-5784-8000--87.net6.ethz.ch [IPv6:2001:67c:10ec:5784:8000::87])
	by r-passerv.ralfj.de (Postfix) with ESMTPSA id F3CC62052A91;
	Thu, 27 Feb 2025 18:58:26 +0100 (CET)
Message-ID: <d29ebda1-e6ca-455d-af07-ac1daf84a3d2@ralfj.de>
Date: Thu, 27 Feb 2025 18:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ralf Jung <post@ralfj.de>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Gary Guo <gary@garyguo.net>,
 torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com,
 david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
 hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
 <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
 <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
 <f3a83d60-3506-4e20-b202-ef2ea99ef4dc@ralfj.de>
 <CAFJgqgR4Q=uDKNnU=2yo5zoyFOLERG+48bFuk4Dd-c+S6x+N5w@mail.gmail.com>
 <7edf8624-c9a0-4d8d-a09e-2eac55dc6fc5@ralfj.de>
 <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
Content-Language: en-US, de-DE
In-Reply-To: <CAFJgqgS-S3ZbPfYsA-eJmCXHhMrzwaKW1-G+LegKJNqqGm31UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi VJ,

>> I am not aware of a comparable tool that would be in wide-spread use, or that is
>> carefully aligned with the semantics of an actual compiler.
>> For C, there is Cerberus (https://www.cl.cam.ac.uk/~pes20/cerberus/) as an
>> executable version of the C specification, but it can only run tiny examples.
>> The verified CompCert compiler comes with a semantics one could interpret, but
>> that only checks code for compatibility with CompCert C, which has a lot less
>> (and a bit more) UB than real C.
>> There are also two efforts that turned into commercial tools that I have not
>> tried, and for which there is hardly any documentation of how they interpret the
>> C standard so it's not clear what a green light from them means when compiling
>> with gcc or clang. I also don't know how much real-world code they can actually run.
>> - TrustInSoft/tis-interpreter, mostly gone from the web but still available in
>> the wayback machine
>> (https://web.archive.org/web/20200804061411/https://github.com/TrustInSoft/tis-interpreter/);
>> I assume this got integrated into their "TrustInSoft Analyzer" product.
>> - kcc, a K-framework based formalization of C that is executable. The public
>> repo is dead (https://github.com/kframework/c-semantics) and when I tried to
>> build their tool that didn't work. The people behind this have a company that
>> offers "RV-Match" as a commercial product claiming to find bugs in C based on "a
>> complete formal ISO C11 semantics" so I guess that is where their efforts go now.
>>
>> For C++ and Zig, I am not aware of anything comparable.
>>
>> Part of the problem is that in C, 2 people will have 3 ideas for what the
>> standard means. Compiler writers and programmers regularly have wildly
>> conflicting ideas of what is and is not allowed. There are many different places
>> in the standard that have to be scanned to answer "is this well-defined" even
>> for very simple programs. (https://godbolt.org/z/rjaWc6EzG is one of my favorite
>> examples.) A tool can check a single well-defined semantics, but who gets to
>> decide what exactly those semantics are?
>> Formalizing the C standard requires extensive interpretation, so I am skeptical
>> of everyone who claims that they "formalized the C standard" and built a tool on
>> that without extensive evaluation of how their formalization compares to what
>> compilers do and what programmers rely on. The Cerberus people have done that
>> evaluation (see e.g. https://dl.acm.org/doi/10.1145/2980983.2908081), but none
>> of the other efforts have (to my knowledge). Ideally such a formalization effort
>> would be done in close collaboration with compiler authors and the committee so
>> that the ambiguities in the standard can be resolved and the formalization
>> becomes the one canonical interpretation. The Cerberus people are the ones that
>> pushed the C provenance formalization through, so they made great progress here.
>> However, many issues remain, some quite long-standing (e.g.
>> https://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_260.htm and
>> https://www.open-std.org/jtc1/sc22/wg14/www/docs/dr_451.htm, which in my eyes
>> never got properly resolved by clarifying the standard). Martin and a few others
>> are slowly pushing things in the right direction, but it takes a long time.
>> Rust, by having a single project in charge of the one canonical implementation
>> and the specification, and having an open process that is well-suited for
>> incorporating user concerns, can move a lot quicker here. C has a huge
>> head-start, Rust has nothing like the C standard, but we are catching up -- and
>> our goal is more ambitious than that; we are doing our best to learn from C and
>> C++ and concluded that that style of specification is too prone to ambiguity, so
>> we are trying to achieve a formally precise unambiguous specification. Wasm
>> shows that this can be done, at industry scale, albeit for a small language --
>> time we do it for a large one. :)
>>
>> So, yes I think Miri is fairly unique. But please let me know if I missed something!
>>
>> (As an aside, the above hopefully also explains why some people in Rust are
>> concerned about alternative implementations. We do *not* want the current
>> de-factor behavior to ossify and become the specification. We do *not* want the
>> specification to just be a description of what the existing implementations at
>> the time happen to do, and declare all behavior differences to be UB or
>> unspecified or so just because no implementation is willing to adjust their
>> behavior to match the rest. We want the specification to be prescriptive, not
>> descriptive, and we will adjust the implementation as we see fit to achieve that
>> -- within the scope of Rust's stability guarantees. That's also why we are so
>> cagey about spelling out the aliasing rules until we are sure we have a good
>> enough model.)
> 
> Very interesting, thank you for the exhaustive answer.
> 
> Might it be accurate to categorize Miri as a
> "formal-semantics-based undefined-behavior-detecting interpreter"?

Sure, why not. :)

> 
>> https://godbolt.org/z/rjaWc6EzG
> 
> That example uses a compiler-specific attribute AFAIK, namely
> 
>      __attribute__((noinline))
> 
> When using compiler-specific attributes and options, the
> original language is arguably no longer being used, depending
> on the attribute. Though a language being inexpressive and
> possibly requiring compiler extensions to achieve some goals,
> possibly like in this C example, can be a disadvantage in itself.

That attribute just exists to make the example small and fit in a single file. 
If you user multiple translation units, you can achieve the same effect without 
the attribute. Anyway compilers promise (I hope^^) that that particular 
attribute has no bearing on whether the code has UB. So, the question of whether 
the program without the attribute has UB is still a very interesting one.

At least clang treats this code as having UB, and one can construct a similar 
example for gcc. IMO this is not backed by the standard itself, though it can be 
considered backed by some defect reports -- but those were for earlier versions 
of the standard so technically, they do not apply to C23.

>> [On formalization]
> 
> I agree that Rust has some advantages in regards to formalization,
> but some of them that I think of, are different from what you
> mention here. And I also see some disadvantages.
> 
> C is an ancient language, and parsing and handling C is made
> more complex by the preprocessor. Rust is a much younger
> language that avoided all that pain, and is easier to parse
> and handle. C++ is way worse, though might become closer
> to Rust with C++ modules.
> 
> Rust is more willing to break existing code in projects, causing
> previously compiling projects to no longer compile. rustc does this
> rarely, but it has happened, also long after Rust 1.0.
> 
>  From last year, 2024.
> 
>      https://internals.rust-lang.org/t/type-inference-breakage-in-1-80-has-not-been-handled-well/21374
>          "Rust 1.80 broke builds of almost all versions of the
>          very popular time crate (edit: please don't shoot the
>          messenger in that GitHub thread!!!)
> 
>          Rust has left only a 4-month old version working.
>          That was not enough time for the entire Rust
>          ecosystem to update, especially that older
>          versions of time were not yanked, and users
>          had no advance warning that it will stop working.
> 
>          A crater run found a regression in over 5000 crates,
>          and that has just been accepted as okay without
>          any further action! This is below the level of stability
>          and reliability that Rust should have."
> 
> If C was willing to break code as much as Rust, it would be easier to
> clean up C.

Is that true? Gcc updates do break code.

>> [Omitted] We do *not* want the
>> specification to just be a description of what the existing implementations at
>> the time happen to do, and declare all behavior differences to be UB or
>> unspecified or so just because no implementation is willing to adjust their
>> behavior to match the rest. [Omitted]
> 
> I have seen some Rust proponents literally say that there is
> a specification for Rust, and that it is called rustc/LLVM.
> Though those specific individuals may not have been the
> most credible individuals.

Maybe don't take the word of random Rust proponents on the internet as anything 
more than that. :)  I can't speak for the entire Rust project, but I can speak 
as lead of the operational semantics team of the Rust project -- no, we do not 
consider rustc/LLVM to be a satisfying spec. Producing a proper spec is on the 
project agenda.

> A fear I have is that there may be hidden reliance in
> multiple different ways on LLVM, as well as on rustc.
> Maybe even very deeply so. The complexity of Rust's
> type system and rustc's type system checking makes
> me more worried about this point. If there are hidden
> elements, they may turn out to be very difficult to fix,
> especially if they are discovered to be fundamental.
> While having one compiler can be an advantage in
> some ways, it can arguably be a disadvantage
> in some other ways, as you acknowledge as well
> if I understand you correctly.

The Rust type system has absolutely nothing to do with LLVM. Those are 
completely separate parts of the compiler. So I don't see any way that LLVM 
could possibly influence our type system.

We already discussed previously that indeed, the Rust operational semantics has 
a risk of overfitting to LLVM. I acknowledge that.

> You mention ossifying, but the more popular Rust becomes,
> the more painful breakage will be, and the less suited
> Rust will be as a research language.

I do not consider Rust a research language. :)

> Does Crater run Rust for Linux and relevant Rust
> kernel code?

Even better: every single change that lands in Rust checks Rust-for-Linux as 
part of our CI.

> I hope that any new language at least has its
> language developers ensure that they have a type
> system that is formalized and proven correct
> before that langauge's 1.0 release.
> Since fixing a type system later can be difficult or
> practically impossible. A complex type system
> and complex type checking can be a larger risk in this
> regard relative to a simple type system and simple
> type checking, especially the more time passes and
> the more the language is used and have code
> written in it, making it more difficult to fix the language
> due to code breakage costing more.

Uff, that's a very high bar to pass.^^ I think there's maybe two languages ever 
that meet this bar? SML and wasm.

>>> There are some issues in Rust that I am curious as to
>>> your views on. rustc or the Rust language has some type
>>> system holes, which still causes problems for rustc and
>>> their developers.
>>>
>>>       https://github.com/lcnr/solver-woes/issues/1
>>>       https://github.com/rust-lang/rust/issues/75992
>>>
>>> Those kinds of issues seem difficult to solve.
>>>
>>> In your opinion, is it accurate to say that the Rust language
>>> developers are working on a new type system for
>>> Rust-the-language and a new solver for rustc, and that
>>> they are trying to make the new type system and new solver
>>> as backwards compatible as possible?
>>
>> It's not really a new type system. It's a new implementation for the same type
>> system. But yes there is work on a new "solver" (that I am not involved in) that
>> should finally fix some of the long-standing type system bugs. Specifically,
>> this is a "trait solver", i.e. it is the component responsible for dealing with
>> trait constraints. Due to some unfortunate corner-case behaviors of the old,
>> organically grown solver, it's very hard to do this in a backwards-compatible
>> way, but we have infrastructure for extensive ecosystem-wide testing to judge
>> the consequences of any given potential breaking change and ensure that almost
>> all existing code keeps working. In fact, Rust 1.84 already started using the
>> new solver for some things
>> (https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html) -- did you notice?
>> Hopefully not. :)
> 
> If it is not a new type system, why then do they talk about
> backwards compatibility for existing Rust projects?

If you make a tiny change to a type system, is it a "new type system"? "new type 
system" sounds like "from-scratch redesign". That's not what happens.

> If the type system is not changed, existing projects would
> still type check. And in this repository of one of the main
> Rust language developers as I understand it, several
> issues are labeled with "S-fear".
> 
>      https://github.com/lcnr/solver-woes/issues
> 
> They have also been working on this new solver for
> several years. Reading through the issues, a lot of
> the problems seem very hard.

It is hard, indeed. But last I knew, the types team is confident that they can 
pull it off, and I have confidence in them.

Kind regards,
Ralf


