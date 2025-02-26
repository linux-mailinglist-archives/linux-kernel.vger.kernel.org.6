Return-Path: <linux-kernel+bounces-534180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900B9A463DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE37117B423
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423C222582;
	Wed, 26 Feb 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMQtpBFq"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7209221DA6;
	Wed, 26 Feb 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581867; cv=none; b=hhd+TdoX3BAkYVcQKkJhi73zKBNf1f89xZeZLGwnEb4LiY2I2p9/njTwlez/fRAy91Ro9aJbKmysRb8Vxd5+12sKam9QpAeFKC8de6BPg8lQSR6CJex2vgYaxrf6z0ayV6HVCXTeHFgM/Ucdk7WEdF+Vmg4/KEgCkDTfPZJMLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581867; c=relaxed/simple;
	bh=exPTYl/G8xGMJ5KWmnWY4lMJepkIK8e+z9ezmnXgxK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mM63Q89nuKMseepWt17boNCmrJXkw2ejqKzQO7qr1F5BgzUj6a495rUl/cmu9Wc2cV4aIJ5VQJ8J2HjYFiENsZ9BozzPUcQ2Uces8r6gL0r8mbvxxRGTzIWPpBoQBXn0b8jYHnOt90JP2qVZf3ZDOoTlFQM1I2drDD2cofShomw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMQtpBFq; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5485646441cso2093504e87.2;
        Wed, 26 Feb 2025 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740581864; x=1741186664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmBQUH+CeL/df1c+D6bwSNj4KBzbPZ0tvqWc/Hm8TeE=;
        b=hMQtpBFqC0AGWQ+FzuJ5H95AJTgVkX2FpWxqSOJMbeBsUECTJESY2WYO7c3a5RdmmO
         Vzw/zd3zEKrVfZ2n5IVPAgRED0e9aBWb9EsU/txfL1/CW4m6NmTI+uwnTPMl4rjoRWaw
         PA+/sCpJK/AVXmLqTjLlDIgpvKm+NKkQ4+bL2RN5DbcSi/YjbeC0Ak7Bvh+1d1uCNdcN
         ONu8t7nGeyN4Qhd++3nHRONKyyydH7+srOagNWo3RkpAe+PTWZKVyIBR3k9F8BRHZfT9
         AC4xuQPCn9uzQd5leXSsgqqwEz+E5Ndb5tfEZFUSEAQQ7N4aRa8ek8YPYhHNPOMUGVrG
         ZSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581864; x=1741186664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmBQUH+CeL/df1c+D6bwSNj4KBzbPZ0tvqWc/Hm8TeE=;
        b=JGso3ssCHPY1GHtlt0WzDm5n5enLztw0n6qgFOZjpZv3jwWdDg11Gtp2d+SyypV0XC
         7KnWNHl6xP+HEMH9OivUHKQCkP6Of3u0vmbZpCGrRrBpSzLva0q3RZ6FvznKijf31iO+
         wFHTv8CtO2Z64sxGlQsiuFiIdRJWlP8t5WdY06eJvDXAoBeICCe85DlIMyyRrJQtgM7F
         uYAZ9yPAIf23m1oHJaglwDw3ImWGG5Mkp7YWszSvJOo4lYBNLaIUMfkQuIzAvAHn7gSQ
         6wv2en0CfsoOIJXeS0MUvU7WVVysAcFvWb6iv+BtGqhHYpHwTTkYk5QIukwidPwBf1Ac
         eJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUGyM4itOJ/hZELFGOjsMMA+b8vihLom6kFWwF7nfSLGmegkXhROdbYwHEYJXMCbGYWoA/SLPGh1TvmiRc=@vger.kernel.org, AJvYcCVSz+NSQtZu94xQZM0uowQ0OU+qWKB8NpoMqmKRhpuidovr95aZkWCHJYY7JgiJ0X60dogd0iQfWugMR9UrX74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXsJcvWYX17UN2xXRFshBDZwfQWzzJdxAaTZQdqU2nJJJqLIYx
	E0j2fzDkkk+z+B1BctLTKULJ1IGu1K6q9l4qVSlHDceo8L0cxCx8Ke2YeLPkfURUgnphP/xo9u8
	vuWCEsyzKZUn06mOKDUuncJWQA8c=
X-Gm-Gg: ASbGncu72LlU39Ner3SJVXDG5JCQz4SJirk9Ly7T0ML/SNuvwdVF5+CQ7UM1fMvunnV
	6U8FaclYSheQkVzm3/OxgR3HClWVfsT9CgwB9trHUg9dtKPYfSXHVLpK3c6/P+nDo268LySP6xw
	2bH2FrLVfj
X-Google-Smtp-Source: AGHT+IHGpxJyYcpdkSCW/SXyfWqVlUKVzz1DxVDanEf1VcEX2yQEWccPlzUMrzF1K0HO2xZ9I2fHAsrmagv051PGdWM=
X-Received: by 2002:a05:6512:68e:b0:545:3dd:aa5f with SMTP id
 2adb3069b0e04-548510ecfadmr4470175e87.36.1740581863683; Wed, 26 Feb 2025
 06:57:43 -0800 (PST)
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
 <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2> <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
In-Reply-To: <780ff858-4f8e-424f-b40c-b9634407dce3@ralfj.de>
From: Ventura Jack <venturajack85@gmail.com>
Date: Wed, 26 Feb 2025 07:57:29 -0700
X-Gm-Features: AQ5f1Jo9IzYuf4E5AC_RcTEU4bX39JC8MluDSFJpsvCTKdWgDEaxM6M0ch_TWZM
Message-ID: <CAFJgqgRN0zwwaNttS_9qnncTDnSA-HU5EgAXFrNHoPQ7U8fUxw@mail.gmail.com>
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

On Wed, Feb 26, 2025 at 4:34=E2=80=AFAM Ralf Jung <post@ralfj.de> wrote:
>
> Let me also reply to some statements made further up-thread by Ventura Ja=
ck (in
> <https://lore.kernel.org/rust-for-linux/CAFJgqgSqMO724SQxinNqVGCGc7=3DibU=
vVq-f7Qk1=3DS3A47Mr-ZQ@mail.gmail.com/>):
>
> > - Aliasing in Rust is not opt-in or opt-out,
> >     it is always on.
> >     https://doc.rust-lang.org/nomicon/aliasing.html
>
> This is true, but only for references. There are no aliasing requirements=
 on raw
> pointers. There *are* aliasing requirements if you mix references and raw
> pointers to the same location, so if you want to do arbitrary aliasing yo=
u have
> to make sure you use only raw pointers, no references. So unlike in C, yo=
u have
> a way to opt-out entirely within standard Rust.

Fair, though I did have this list item:

- Applies to certain pointer kinds in Rust, namely
    Rust "references".
    Rust pointer kinds:
    https://doc.rust-lang.org/reference/types/pointer.html

where I wrote that the aliasing rules apply to Rust "references".

>
> > - Rust has not defined its aliasing model.
>
> Correct. But then, neither has C. The C aliasing rules are described in E=
nglish
> prose that is prone to ambiguities and misintepretation. The strict alias=
ing
> analysis implemented in GCC is not compatible with how most people read t=
he
> standard (https://bugs.llvm.org/show_bug.cgi?id=3D21725). There is no too=
l to
> check whether code follows the C aliasing rules, and due to the aforement=
ioned
> ambiguities it would be hard to write such a tool and be sure it interpre=
ts the
> standard the same way compilers do.
>
> For Rust, we at least have two candidate models that are defined in full
> mathematical rigor, and a tool that is widely used in the community, ensu=
ring
> the models match realistic use of Rust.

But it is much more significant for Rust than for C, at least in
regards to C's "restrict", since "restrict" is rarely used in C, while
aliasing optimizations are pervasive in Rust. For C's "strict aliasing",
I think you have a good point, but "strict aliasing" is still easier to
reason about in my opinion than C's "restrict". Especially if you
never have any type casts of any kind nor union type punning.

And there have been claims in blog posts and elsewhere in the
Rust community that unsafe Rust is harder than C and C++.

>
> > - The aliasing rules in Rust are possibly as hard or
> >     harder than for C "restrict", and it is not possible to
> >     opt out of aliasing in Rust, which is cited by some
> >     as one of the reasons for unsafe Rust being
> >     harder than C.
>
> That is not quite correct; it is possible to opt-out by using raw pointer=
s.

Again, I did have this list item:

- Applies to certain pointer kinds in Rust, namely
    Rust "references".
    Rust pointer kinds:
    https://doc.rust-lang.org/reference/types/pointer.html

where I wrote that the aliasing rules apply to Rust "references".

> >     the aliasing rules, may try to rely on MIRI. MIRI is
> >     similar to a sanitizer for C, with similar advantages and
> >     disadvantages. MIRI uses both the stacked borrow
> >     and the tree borrow experimental research models.
> >     MIRI, like sanitizers, does not catch everything, though
> >     MIRI has been used to find undefined behavior/memory
> >     safety bugs in for instance the Rust standard library.
>
> Unlike sanitizers, Miri can actually catch everything. However, since the=
 exact
> details of what is and is not UB in Rust are still being worked out, we c=
annot
> yet make in good conscience a promise saying "Miri catches all UB". Howev=
er, as
> the Miri README states:
> "To the best of our knowledge, all Undefined Behavior that has the potent=
ial to
> affect a program's correctness is being detected by Miri (modulo bugs), b=
ut you
> should consult the Reference for the official definition of Undefined Beh=
avior.
> Miri will be updated with the Rust compiler to protect against UB as it i=
s
> understood by the current compiler, but it makes no promises about future
> versions of rustc."
> See the Miri README (https://github.com/rust-lang/miri/?tab=3Dreadme-ov-f=
ile#miri)
> for further details and caveats regarding non-determinism.
>
> So, the situation for Rust here is a lot better than it is in C. Unfortun=
ately,
> running kernel code in Miri is not currently possible; figuring out how t=
o
> improve that could be an interesting collaboration.

I do not believe that you are correct when you write:

    "Unlike sanitizers, Miri can actually catch everything."

Critically and very importantly, unless I am mistaken about MIRI, and
similar to sanitizers, MIRI only checks with runtime tests. That means
that MIRI will not catch any undefined behavior that a test does
not encounter. If a project's test coverage is poor, MIRI will not
check a lot of the code when run with those tests. Please do
correct me if I am mistaken about this. I am guessing that you
meant this as well, but I do not get the impression that it is
clear from your post.

Further, MIRI, similar to sanitizers, runs much more slowly than
regular tests. I have heard numbers of MIRI running 50x slower
than the tests when not run with MIRI. This blog post claims
400x running time in one case.

    https://zackoverflow.dev/writing/unsafe-rust-vs-zig/
        "The interpreter isn=E2=80=99t exactly fast, from what I=E2=80=99ve=
 observed
        it=E2=80=99s more than 400x slower. Regular Rust can run the tests
        I wrote in less than a second, but Miri takes several minutes."

This does not count against MIRI, since it is similar to some
other sanitizers, as I understand it. But it does mean that MIRI
has some similar advantages and disadvantages to sanitizers.

Best, VJ.

