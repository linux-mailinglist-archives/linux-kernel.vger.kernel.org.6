Return-Path: <linux-kernel+bounces-340285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367AF987103
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AF91C22C61
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD11AB6E8;
	Thu, 26 Sep 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRv4pYww"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD141A42D3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345235; cv=none; b=QB4KVWtaiMVSep3cRPtdtOdcaCsrRX1hZYXzOOQFFGgJ2Zl3EsYnvZnFQv4oHCNdVa4LekdoZWMAKXSRw183y68M3TI4+gUZdTVoebRclVkovmaa2SwGjrSLFcLoZp2Z4IYFtrRFgagH21UDdKKlmQQ8xHZFpnYMg+TQj7CJNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345235; c=relaxed/simple;
	bh=8y3lUDcrTbxInC8EPBwyN+dia3ZC9g0bg4Yfqds4BGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NdXw+/aaWVrrTQSaI5hd4aQrVG+PkZu5pJR25fPNmX+JiUZx27gwUoMqausl/Ed1HU97SYSgrl6SCf+yCXSeFMPtWBG3za0qzwn02uzSUvyOY4MwQDc/JetZeeNAUf19akWqOUOrQNGyUazgJFsVnvgJ4d77r1ye0e7ZHYYmVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRv4pYww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD16C4CECF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727345234;
	bh=8y3lUDcrTbxInC8EPBwyN+dia3ZC9g0bg4Yfqds4BGM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mRv4pYwwD95/Lv3ewjMJOmuWM10bgWBV78sipeCJz++oDYz23xp5kmTDBY7Pw4ex3
	 r2QHCbqdEiVFhefgMP4duGnPYXK1aREwsgKvaHwDyG5o/WPncYlwh8jKoDffW5+37y
	 F3bJE16U3uMS5F+ssHy3ROEY0LQ8dIMUhhTZXYubnBpq/q1w3v6ar5PtR+YS4V/m6i
	 oNmEjBv3m+nZUnErQBqWSYUw9Lgxkm/SPKAcyqyOh22sZ1No7D0utpjdX49HCc8ttp
	 +q2SkCiOPeWv5EpaQBoHP19qC81YDevj53jbKaN2TXWEsPsoyxowKze93IRzlXx+EJ
	 dhaoqA8nuStFw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75129b3a3so7538891fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:07:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVTm/QwiEJIoyMwbDraruukVuIhXPiSR2mbh+braplQHNUlQ39zTaRw1PYNtVhqCsg4lPwuxDsWFEyRvLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQsPdjkP+BJq8p/UiVs3/HOL0E2lMeFn/BfNWrZgMwG3F7C5v
	wvlgESai6KLdAVGaypKqHy4qs06vmqxj6Ibm2hOwljI3tB7QJ7+x2J9fcP1w7Fk7pG/JfGG/3eG
	r0ZiS4igb9RK9yantqQO+0l4wf4s=
X-Google-Smtp-Source: AGHT+IHg1jrE+kIIolFSaMP+UApi218sH3Tp1LSOi7m5rvJIcoyvnerjEh4MPn9D4AQRWuJzFiVO+P2QDa88u2CDk/Y=
X-Received: by 2002:a05:651c:1988:b0:2f6:6576:ae6e with SMTP id
 38308e7fff4ca-2f915ff5913mr36302761fa.21.1727345232907; Thu, 26 Sep 2024
 03:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
 <20240925150059.3955569-55-ardb+git@google.com> <87ikuj30g8.fsf@linux.intel.com>
 <CAMj1kXEQJraatFuA1CVwQz6Uos-0LbVVyCa=FgkHgEAQBCn=TQ@mail.gmail.com> <ZvUf7pkvq3m9wYjr@tassilo>
In-Reply-To: <ZvUf7pkvq3m9wYjr@tassilo>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 26 Sep 2024 12:07:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGMBaD5sVaMyJMKBnMhQ2jD1GE1CXdVKi+KPciv0x5RcQ@mail.gmail.com>
Message-ID: <CAMj1kXGMBaD5sVaMyJMKBnMhQ2jD1GE1CXdVKi+KPciv0x5RcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 25/28] x86: Use PIE codegen for the core kernel
To: Andi Kleen <ak@linux.intel.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, hjl.tools@gmail.com, 
	hubicka@ucw.cz
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Sept 2024 at 10:48, Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On Wed, Sep 25, 2024 at 11:23:39PM +0200, Ard Biesheuvel wrote:
> > > What matters is what it does to general performance.
> > >
> > > Traditionally even on x86-64 PIC/E has a cost and the kernel model
> > > was intended to avoid that.
> > >
> >
> > Is the x86_64 kernel C model specified anywhere, to your knowledge?
>
> The basics are in the ABI. Maybe some of the details of TLS / stack
> protector are missing (I guess that could be fixed, adding HJ)
>
> Some of the motivation was also in early papers like
> https://www.ucw.cz/~hubicka/papers/amd64/amd64.html
>
> I'm copying Honza Hubicka who did the original work.
>

Thanks.

So the psABI has

Kernel code model:
The kernel of an operating system is usually rather small but runs in
the negative half of the address space.

plus an explanation on the ranges of symbolic references.

The problem here is that it is inherently a position dependent code
model, where 'the virtual address of code executed is known at link
time' as per the psABI.

We currently violate that assumption in two different ways:
- the decompressor applies KASLR by using the static ELF relocations
(which are intended for consumption by the linker not the loader) and
use them to relocate the executable to its randomized virtual address;
those static relocations can go out of sync with the actual code when
relaxations are applied;
- some of the startup code is now written in C, but is called via the
1:1 mapping; absolute symbol references don't work in that context,
and we rely on faith and a whole pile of hacks to ensure that this
does not break.

> >
> > > From my perspective this patch kit doesn't fix a real problem,
> > > it's all risk of performance regression with no gain.
> > >
> >
> > It's all in the cover letter and the commit logs so I won't rehash it
> > here, but I understand that your priorities may be different from
> > mine.
>
> It sounded fairly nebulous to me. If Linux wanted to support a third tool chain
> and it didn't support the kernel model yet it would be somehow easier.
> Apart from the kernel model likely being one of the minor issues
> in such a endeavour, I don't see a third tool chain othan than gcc and llvm
> anywhere on the horizon?
>

I was referring to Rust, which is llvm based but will also have a GCC
based alternative (gcc-rs) in the future. I am aware that these will
most likely reuse most of the existing backends, where these concerns
have the most impact, but they still need wider consideration than
they used to in the past.

So the tl;dr for the rationale behind this series is that it is better
to use a code model and a relocation model that
a) matches the reality of how our code operates, and
b) deviates as little as possible from how code is generally
constructed for user space.

On top of that, it would be better to use relocation metadata that is
intended for consumption by a runtime loader, rather than rolling our
own based on a relocation format that is intended for consumption by
the build time linker.

> >
> > I'll provide some numbers about the impact on code size. Are there any
> > other performance related aspects that you think might be impacted by
> > the use of position independent code generation?
>
> Code size isn't a sufficient metric either.
>
> Linux sometimes goes to great length for small gains, for example
> there was a huge effort to avoid frame pointers, even though it's a
> small percentage delta. PIC could well be larger than frame pointers.
>
> You need to run it with some real workloads, e.g. some of the kernel
> oriented workloads in 0day or phoronix, and see if there are
> performance regressions.
>
> Unfortunately for an intrusive change like this this might also vary for
> different CPUs, so may need some more coverage.
>

I'll spend some time to look into this in more detail (and get some
help internally at Google to measure the real-world impact)

