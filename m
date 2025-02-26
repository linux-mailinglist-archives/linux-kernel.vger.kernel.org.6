Return-Path: <linux-kernel+bounces-534093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63946A462BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685AD16F56C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B861A01BF;
	Wed, 26 Feb 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq1iop7o"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A47721D3C7;
	Wed, 26 Feb 2025 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579996; cv=none; b=KtfOtaUmd25+LjT9DFg/P1YJpEUxKcquGXXQBCLBPVx90ItBBl1xNFrbof1RyLrXxd+bI5u2+Iaqm8OX/OGftILIrr/h5eDH5aBJA62edcdqoUba0FKHOsSGvNIGJQGihZ0C70X6Jy38+d36knERE2/6IIQbhta+83WdbMCbVxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579996; c=relaxed/simple;
	bh=kQKsgvJlW7fwbIf4qc0Ui53vS/6fSO5kmK/9cM5yhwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzOL71MD1+0Ilnsmpd2HzFtWjkqkc9BVLFctj5iMwAeFyFopjuddEqOtzTZAbU/Imjig+/0oi0viHanYl+/pr3b0KWuGHJPPLAwosldPASYAbzesSIGA/Yuzrpiza+qVROQrZTk6ZAASJn4+Drgc+3J9+5zgUAs4ZWpQVU+Bi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq1iop7o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452c29bacfso7392290e87.3;
        Wed, 26 Feb 2025 06:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740579992; x=1741184792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16o4HN72hUYT2BtQPQiZQKqtlfR66XFlqvWSGK9aab0=;
        b=Aq1iop7oLaoC2kc4b5RksbygihEjw5YcmqouGL9XLxiJn3PPQSZJXdRRJenlIP7hl+
         VGp+msARsP79tyFh1z4ESc8L+ADARI/vfRX7gfdUdr2Tssh06NjDCMqXLlK4nU3/BFRs
         1N9JWqkZxz2ZgWAOtwNrI1BYe/YzyhgMsY5qWlyMmcZO9G0gLTSfInDcGDzaR+oHFHRV
         KseH2Ss0gvn3h10K6GNnsXsP9NsyjomDkjjHdWFD6QIuDEbwntnR+SOTk4AG65A6mv27
         54uDFT0xp1NIItsZCtj29RdQwuoclhbsZ1gyQ7BqV1OeIdzu58m3pTbAbBj/A+OvJXg+
         77hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579992; x=1741184792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16o4HN72hUYT2BtQPQiZQKqtlfR66XFlqvWSGK9aab0=;
        b=WrBNmDtdcHLRIcQllPXl1mxsE8H4K6mNbN/5iJ0hJOjeu1k1vTQHOK8ZgKq9bvkwIx
         juQ1GVEJHjdA0YcPu6oQKle9INLoyjf956CgwN+a335Yx+XRdEEjfq3bHd19HdU5l7cD
         TG6ZQcq75Akegqk8Z6B9FVWBnWTH6xq1iInpycaR52UtKHv/wa9VLtS2qokN9DW1C0or
         H1PQSrr0CbivYRPc8sRWjuaLw15Lpq7Bupl+Cppol3x+Zjou0PO/tgE5sqB4uC+m4sQS
         DdB+JjmVPtFKL90/gMs/Y3CdSWQ8ZKrzbwF8ZJNHFFToEIOTawCLSyMZcC8B0ySxkg+g
         qldw==
X-Forwarded-Encrypted: i=1; AJvYcCUNutb0iKrAjS5Shq6Eeb/bEqSsn6krN0j+D4q+2So747cgylhwpUM0MyOLae2vCXmAAzii5Vu//z00juE=@vger.kernel.org, AJvYcCWn/O81VzJ2uQOhTXE4iYJbZ2p7VqPwlGtsoPeuPC6rg0UW60JNompUYL7xaw5hHlsHGCQwn2yaiCbI/JmEkCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtG1SHjhz8JhaN5+HaFe50V/72SAvTl4PzYnbq2v+FDEnSthnS
	ucJljrqvDbnouw6NXVc3nHX6veKLu9ovym6azCSS/K9uXj9n/ugMKfxeE/gbX6qF09AB75gqF2l
	Kg1WAGY4Xdph8wigYd3rDo2RVnKk=
X-Gm-Gg: ASbGncugQh1btFM8Zta+mT/4ycpoTa94lUsxY6GEZ9w2I1MAOL3jW2FN/rqeXT9zx9f
	KItnxsxsxdcG1D8C0xlMt6GQszFVMmuM+BtW7hBZLeL17qK5l6XmSUbfvtUBW8Qzp4Arhm61miC
	Xi2UpC9vF6
X-Google-Smtp-Source: AGHT+IHkO1Llez67mC0M5eVV8yVizYw1eFZ6DmRVypFV6eOIh+HBbj6vZLOPLMnm15b7ahCbYgRcRORSejhhwsHBOFY=
X-Received: by 2002:a05:6512:33d0:b0:545:c1e:65fb with SMTP id
 2adb3069b0e04-54839137693mr10401435e87.18.1740579991935; Wed, 26 Feb 2025
 06:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <gqw7cvclnfa7x4xdz4vkns2msf2bqrms5ecxp2lwzbws7ab6dt@7zbli7qwiiz6>
 <CAHk-=whGY2uYcXog8kmuAAAPJy4R84Jy9rEfXfoHBe-evmuYDQ@mail.gmail.com>
 <4l6xl5vnpulcvssfestsgrzoazoveopzupb32z5bv6mk23gazo@qn63k7rgsckv>
 <CAHk-=wgMnSOnaddFzfAFwjT-dGO9yeSkv6Lt21LgWmCKYCM7cg@mail.gmail.com> <hofm7mo46jzkevpr6fkqe2jnl3zrp5uxdux457hli3ywkneaij@yhhibsnuqfny>
In-Reply-To: <hofm7mo46jzkevpr6fkqe2jnl3zrp5uxdux457hli3ywkneaij@yhhibsnuqfny>
From: Ventura Jack <venturajack85@gmail.com>
Date: Wed, 26 Feb 2025 07:26:18 -0700
X-Gm-Features: AQ5f1JqD5Rih4-XKzlU4qwRX1PB3HFd6CtQtZzg0rKL0nTKIL0Zf2fRVsASt9Bs
Message-ID: <CAFJgqgTtR9MCU5nmhEbEB5oiEELCUGeFYy23jmxQXGDZ1Re3Rw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alice Ryhl <aliceryhl@google.com>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 4:34=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, Feb 25, 2025 at 01:24:42PM -0800, Linus Torvalds wrote:
> > What we do know works is hard rules based on provenance. All compilers
> > will happily do sane alias analysis based on "this is a variable that
> > I created, I know it cannot alias with anything else, because I didn't
> > expose the address to anything else".
>
> Yep. That's what all this is based on.
>
> > So *provenance*-based aliasing works, but it only works in contexts
> > where you can see the provenance. Having some way to express
> > provenance across functions (and not *just* at allocation time) might
> > be a good model.
>
> We have that! That's exactly what lifetime annotations are.
>
> We don't have that for raw pointers, but I'm not sure that would ever be
> needed since you use raw pointers in small and localized places, and a
> lot of the places where aliasing comes up in C (e.g. memmove()) you
> express differently in Rust, with slices and indices.
>
> (You want to drop from references to raw pointers at the last possible
> moment).

The Rust community in general warns a lot against unsafe Rust, and
encourages developers to write as little unsafe Rust as possible,
or avoid it entirely. And multiple blog posts have been written
claiming that unsafe Rust is harder than C as well as C++.
I will link some of the blog posts upon request, I have linked some
of them in other emails.

And there have been undefined behavior/memory safety bugs
in Rust projects, both in the Rust standard library (which has a lot
of unsafe Rust relative to many other Rust projects) and in
other Rust projects.

    https://nvd.nist.gov/vuln/detail/CVE-2024-27308

Amazon Web Services, possibly the biggest Rust developer employer,
initiated last year a project for formal verification of the Rust standard
library.

However, due to various reasons such as the general difficulty of
formal verification, the project is crowd-sourced.

    https://aws.amazon.com/blogs/opensource/verify-the-safety-of-the-rust-s=
tandard-library/
        "Verifying the Rust libraries is difficult because: 1/ lack of a
        specification, 2/ lack of an existing verification mechanism
        in the Rust ecosystem, 3/ the large size of the verification
        problem, and 4/ the unknowns of scalable verification. Given
        the magnitude and scope of the effort, we believe that a single
        team would be unable to make significant inroads. Our
        approach is to create a community owned effort."

All in all, unsafe Rust appears very difficult in practice, and tools
like MIRI, while very good, does not catch everything, and share
many of the advantages and disadvantages of sanitizers.

Would unsafe Rust have been substantially easier if Rust did not
have pervasive aliasing optimizations? If a successor language
to Rust also includes the safe-unsafe divide, but does not have
pervasive aliasing optimizations, that may yield an indication of
an answer to that question. Especially if such a language only
uses aliasing optimizations when the compiler, not the
programmer, proves it is safe to do those optimizations.

Rust is very unlikely to skip its aliasing optimizations, since it is one
major reason why Rust has often had comparable, or sometimes
better, performance than C and C++ in some benchmarks, despite
some runtime checks as I understand it in Rust.

> And besides, a lot of the places where aliasing comes up in C are
> already gone in Rust, there's a lot of little things that help.
> Algebraic data types are a big one, since a lot of the sketchy hackery
> that goes on in C where aliasing is problematic is just working around
> the lack of ADTs.

Algebraic data types/tagged unions, together with pattern matching,
are indeed excellent. But they are independent of Rust's novel features,
they are part of the functional programming tradition, and they have
been added to many old and new mainstream programming
languages. They are low-hanging fruits. They help not only with
avoiding undefined behavior/memory safety bugs, but also with
general correctness, maintainability, etc.

C seems to avoid features that would bring it closer to C++, and C
is seemingly kept simple, but otherwise it should not be difficult to
add them to C. C's simplicity makes it easier to write new C compilers.
Though these days people often write backends for GCC or LLVM,
as I understand it.

If you, the Linux kernel community, really want these low-hanging
fruits, I suspect that you might be able to get the C standards
people to do it. Little effort, a lot of benefit for all your new or
refactored C code.

C++ has std::variant, but no pattern matching. Neither of the two
pattern matching proposals for C++26 were accepted, but C++29
will almost certainly have pattern matching.

Curiously, C++ does not have C's "restrict" keyword.

> > But in the absence of knowledge, and in the absence of
> > compiler-imposed rules (and "unsafe" is by *definition* that absence),
> > I think the only rule that works is "don't assume they don't alias".
>
> Well, for the vast body of Rust code that's been written that just
> doesn't seem to be the case, and I think it's been pretty well
> demonstrated that anything we can do in C, we can also do just as
> effectively in Rust.
>
> treeborrow is already merged into Miri - this stuff is pretty far along.
>
> Now if you're imagining directly translating all the old grotty C code I
> know you have in your head - yeah, that won't work. But we already knew
> that.

Yet the Rust community encourages not to use unsafe Rust when
it is possible to not use it, and many have claimed in the Rust
community that unsafe Rust is harder than C and C++. And there
is still only one major Rust compiler and no specification, unlike
for C.

As for tree borrows, it is not yet used by default in MIRI as far as
I can tell, when I ran MIRI against an example with UB, I got a
warning that said that the Stacked Borrows rules are still
experimental. I am guessing that you have to use a flag to enable
tree borrows.

Best, VJ.

