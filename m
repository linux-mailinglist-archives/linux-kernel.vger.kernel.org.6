Return-Path: <linux-kernel+bounces-179620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94FD8C625C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D530BB21A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3352A4AEE0;
	Wed, 15 May 2024 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knHEnaMU"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FDC482CD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759956; cv=none; b=lerW/oqaqmc0VnbNH4odqZxTSdktCFT2Fqw0FuvAy97Pzndjz/kQQ06EdUxJo3oflKfgAkeWwJY5RJCNWEBvFjw+i96EI4UjB+2mTrnIIdwadr+Lw5erC45XLKDakALfnnNzmRpmmj1eLS9qf6y0HTaxuqubwYpd8TcUFV0TH3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759956; c=relaxed/simple;
	bh=rE6QtgB4pJV8baaXT7OsQtNS6Jx+xpsopoS6BTg2kRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK5fNez2fsHpj01uGYZFw9KM6zWOb0N9TZhcBQp9VTc6JW21Hveq+aIZq24tSWSmqAViAeEpyXtOECWEVO4X32l9hO2nSMo52CGyiROzI7iyCDUHGgcPAQpDO6mLiRaEj7KdSUFVatBfIRPECbx85GVFXbt3OeFgzUmlUxe3evo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knHEnaMU; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so2232537e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715759952; x=1716364752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=stvuLC23frfwxRFRW518FVRgKrESd+Az5OD98TQsSqo=;
        b=knHEnaMUmFtWfPmfQmxZ0PyQHSg4SwuLXsPEEHAw8BizuBNCpcK0ksM0+r1GI8jEqm
         esTnZn9ZcSIBiMoNNXkCq+3VIUn+1wTbNZBfDegoz0QM5z5GNV4IWKxUB2KPu6nztdAC
         nDAe254SJ5fHitrKE9OsN31f8XtkYGPyRUNCSEpmhfjdzOh8cU0N8dxEEb8DK+4Qs3Ik
         HcLns0Ct/9Y4c4WNQywIyTNDgcFO3PnB4PXAxZlHt9adgKI6aykjXglLGDUl1CE/Rc55
         k2CIrJtlfR07HTejEiUhu/ad1bD68o+0hQDfHH6pkYGdcL6kcAIeKRijbFS+qTE/+wAF
         0UkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715759952; x=1716364752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stvuLC23frfwxRFRW518FVRgKrESd+Az5OD98TQsSqo=;
        b=L21k9SAiURHkrcEEsKXcgPD4M1zg7+wbFEVJdNRamfgz4XgL8SzrFzSqt9U7jo/Qah
         YM0wNdDBymSOjXMU0V7WrzY2TmZvN9g8xU51QXVSR9fsN93PddwPWUUEMDIwPpqS1rT8
         jZg969gr8bAI0R8ryv9/Cgd4GJVAIDgNzSR8IfgmoHmDum24WBQyAUb9HiABAbxYLIYE
         WcO8LVTa/AiShlll75PwXGQntTrul1LyJS3hfA7VeA6nN4AVW6EhckncFwKCJPqDwGnV
         rzqdph6ywvyRH9/0oqFbYPlGNWqNpq42BOmO6f/3CFEdV4lUPqSSJLbyEME8F9pf1YOR
         gP+w==
X-Forwarded-Encrypted: i=1; AJvYcCWuYaEk5FTBC/umTKhoXh021KIiOxD9ZaSH/KRMG6jilhHsKO6cVXKk8ovyEBhF8wzcucQs89cMcE+9wX9rRZDnMaR+Z1xDwpBQso09
X-Gm-Message-State: AOJu0YxCvallI82zx+YQeGmvaetcV2W8mGfMCH78p/mbqZr6ufE/xLka
	vDPXThoC/YHqXr4TqbPvGnzqFjFMjk8vt337+QJvKAwIoGxn3uX/4UE21frE+kq/Sn3t3Upj3hZ
	fKwQXMTf9IdaJcVGZ+/4fMHhMeMM3ilq7mfmr
X-Google-Smtp-Source: AGHT+IFrk0jr8H15uv7ZhZdzYXIEBxJimfqRYa+asL8SJa1kirroYIbmvGHEcutKM8i1WDSp5mX2XcRA1m3SX+TWVAI=
X-Received: by 2002:a05:6122:17a0:b0:4d4:eff:454 with SMTP id
 71dfb90a1353d-4df8829ce08mr13514421e0c.1.1715759952329; Wed, 15 May 2024
 00:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510141921.883231-1-leitao@debian.org> <ef8c5f6d-17e3-4504-8560-b970912b9eae@acm.org>
 <de92101c-f9c4-4af4-95f4-19a6f59b636f@paulmck-laptop> <d037f37a-4722-4a1d-a282-63355a97a1a1@acm.org>
 <c83d9c25-b839-4e31-8dd4-85f3cb938653@paulmck-laptop> <4d230bac-bdb0-4a01-8006-e95156965aa8@acm.org>
 <447ad732-3ff8-40bf-bd82-f7be66899cee@paulmck-laptop> <ca7c2ef0-7e21-4fb3-ac6b-3dae652a7a0e@acm.org>
 <59ec96c2-52ce-4da1-92c3-9fe38053cd3d@paulmck-laptop> <CANpmjNMj9r1V6Z63fcJxrFC1v4i2vUCEhm1HT77ikxhx0Rghdw@mail.gmail.com>
 <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop>
In-Reply-To: <dd251dba-0a63-4b57-a05b-bfa02615fae5@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Wed, 15 May 2024 09:58:35 +0200
Message-ID: <CANpmjNMqRUNUs1mZEhrOSyK0Hk+PdGOi+VAs22qYD+1zTkwfhg@mail.gmail.com>
Subject: Re: [PATCH] block: Annotate a racy read in blk_do_io_stat()
To: paulmck@kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 01:47, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, May 13, 2024 at 10:13:49AM +0200, Marco Elver wrote:
> > On Sat, 11 May 2024 at 02:41, Paul E. McKenney <paulmck@kernel.org> wrote:
> > [...]
> > > ------------------------------------------------------------------------
> > >
> > > commit 930cb5f711443d8044e88080ee21b0a5edda33bd
> > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > Date:   Fri May 10 15:36:57 2024 -0700
> > >
> > >     kcsan: Add example to data_race() kerneldoc header
> > >
> > >     Although the data_race() kerneldoc header accurately states what it does,
> > >     some of the implications and usage patterns are non-obvious.  Therefore,
> > >     add a brief locking example and also state how to have KCSAN ignore
> > >     accesses while also preventing the compiler from folding, spindling,
> > >     or otherwise mutilating the access.
> > >
> > >     [ paulmck: Apply Bart Van Assche feedback. ]
> > >
> > >     Reported-by: Bart Van Assche <bvanassche@acm.org>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >     Cc: Marco Elver <elver@google.com>
> > >     Cc: Breno Leitao <leitao@debian.org>
> > >     Cc: Jens Axboe <axboe@kernel.dk>
> > >
> > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > index c00cc6c0878a1..9249768ec7a26 100644
> > > --- a/include/linux/compiler.h
> > > +++ b/include/linux/compiler.h
> > > @@ -194,9 +194,17 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > >   * This data_race() macro is useful for situations in which data races
> > >   * should be forgiven.  One example is diagnostic code that accesses
> > >   * shared variables but is not a part of the core synchronization design.
> > > + * For example, if accesses to a given variable are protected by a lock,
> > > + * except for diagnostic code, then the accesses under the lock should
> > > + * be plain C-language accesses and those in the diagnostic code should
> > > + * use data_race().  This way, KCSAN will complain if buggy lockless
> > > + * accesses to that variable are introduced, even if the buggy accesses
> > > + * are protected by READ_ONCE() or WRITE_ONCE().
> > >   *
> > > - * This macro *does not* affect normal code generation, but is a hint
> > > - * to tooling that data races here are to be ignored.
> > > + * This macro *does not* affect normal code generation, but is a hint to
> > > + * tooling that data races here are to be ignored.  If code generation must
> > > + * be protected *and* KCSAN should ignore the access, use both data_race()
> >
> > "code generation must be protected" seems ambiguous, because
> > protecting code generation could mean a lot of different things to
> > different people.
> >
> > The more precise thing would be to write that "If the access must be
> > atomic *and* KCSAN should ignore the access, use both ...".
>
> Good point, and I took your wording, thank you.
>
> > I've also had trouble in the past referring to "miscompilation" or
> > similar, because that also entirely depends on the promised vs.
> > expected semantics: if the code in question assumes for the access to
> > be atomic, the compiler compiling the code in a way that the access is
> > no longer atomic would be a "miscompilation". Although is it still a
> > "miscompilation" if the compiler generated code according to specified
> > language semantics (say according to our own LKMM) - and that's where
> > opinions can diverge because it depends on which side we stand
> > (compiler vs. our code).
>
> Agreed, use of words like "miscompilation" can annoy people.  What
> word would you suggest using instead?

Not sure. As suggested above, I try to just stick to "atomic" vs
"non-atomic" because that's ultimately the functional end result of
such a miscompilation. Although I've also had people be confused as in
"what atomic?! as in atomic RMW?!", but I don't know how to remove
that kind of confusion.

If, however, our intended model is the LKMM and e.g. a compiler breaks
a dependency-chain, then we could talk about miscompilation, because
the compiler violates our desired language semantics. Of course the
compiler writers then will say that we try to do things that are
outside any implemented language semantics the compiler is aware of,
so it's not a miscompilation again. So it all depends on which side
we're arguing for. Fun times.

> > > + * and READ_ONCE(), for example, data_race(READ_ONCE(x)).
> >
> > Having more documentation sounds good to me, thanks for adding!
> >
> > This extra bit of documentation also exists in a longer form in
> > access-marking.txt, correct? I wonder how it would be possible to
> > refer to it, in case the reader wants to learn even more.
>
> Good point, especially given that I had forgotten about it.
>
> I don't have any immediate ideas for calling attention to this file,
> but would the following update be helpful?

Mentioning __data_racy along with data_race() could be helpful, thank
you. See comments below.

Thanks,
-- Marco

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
> index 65778222183e3..690dd59b7ac59 100644
> --- a/tools/memory-model/Documentation/access-marking.txt
> +++ b/tools/memory-model/Documentation/access-marking.txt
> @@ -24,6 +24,12 @@ The Linux kernel provides the following access-marking options:
>  4.     WRITE_ONCE(), for example, "WRITE_ONCE(a, b);"
>         The various forms of atomic_set() also fit in here.
>
> +5.     ASSERT_EXCLUSIVE_ACCESS() and ASSERT_EXCLUSIVE_WRITER().

Perhaps worth mentioning, but they aren't strictly access-marking
options. In the interest of simplicity could leave it out.

> +6.     The volatile keyword, for example, "int volatile a;"

See below - I'm not sure we should mention volatile. It may set the
wrong example.

> +7.     __data_racy, for example "int __data_racy a;"
> +
>
>  These may be used in combination, as shown in this admittedly improbable
>  example:
> @@ -205,6 +211,27 @@ because doing otherwise prevents KCSAN from detecting violations of your
>  code's synchronization rules.
>
>
> +Use of volatile and __data_racy
> +-------------------------------
> +
> +Adding the volatile keyword to the declaration of a variable causes both
> +the compiler and KCSAN to treat all reads from that variable as if they
> +were protected by READ_ONCE() and all writes to that variable as if they
> +were protected by WRITE_ONCE().

"volatile" isn't something we encourage, right? In which case, I think
to avoid confusion we should not mention volatile. After all we have
this: Documentation/process/volatile-considered-harmful.rst

> +Adding the __data_racy type qualifier to the declaration of a variable
> +causes KCSAN to treat all accesses to that variable as if they were
> +enclosed by data_race().  However, __data_racy does not affect the
> +compiler, though one could imagine hardened kernel builds treating the
> +__data_racy type qualifier as if it was the volatile keyword.
> +
> +Note well that __data_racy is subject to the same pointer-declaration
> +rules as is the volatile keyword.  For example:

To avoid referring to volatile could make it more general and say "..
rules as other type qualifiers like const and volatile".


> +       int __data_racy *p; // Pointer to data-racy data.
> +       int *__data_racy p; // Data-racy pointer to non-data-racy data.
> +
> +
>  ACCESS-DOCUMENTATION OPTIONS
>  ============================
>
> @@ -342,7 +369,7 @@ as follows:
>
>  Because foo is read locklessly, all accesses are marked.  The purpose
>  of the ASSERT_EXCLUSIVE_WRITER() is to allow KCSAN to check for a buggy
> -concurrent lockless write.
> +concurrent write, whether marked or not.
>
>
>  Lock-Protected Writes With Heuristic Lockless Reads

