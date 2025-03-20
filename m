Return-Path: <linux-kernel+bounces-569304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F414A6A135
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C220461FBE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92CE21D5A9;
	Thu, 20 Mar 2025 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgpYjy7l"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6020B81E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742458918; cv=none; b=mFz7+KQ7Sxuc909y2owzHFlSONyC2s1HFe/e8hUH/q0E8HyRZBwfYXv3sVf8JupM7SuqZWVgdAIQvg3Xn7TyWk8NZWdo5+WZbR1Irze0QDyoVXxXO2Vo/UcjtTZ03cHOJbEnRoC72WnSwnE2KcR821KJgH5HIM6Ay6ByH7TItXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742458918; c=relaxed/simple;
	bh=vorqxZqGcnCcB5TxntyvB83Bivt97gSn6RBhEWhdbYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oLSs2XsALTCESb/d+NihGwgrllLpUv8IGkrx3bLfrOJtFsuOM0QCkEw8tCTkDGXFCtBDiOLGQt0mJNI3QBM+QWQykMeMLkStrLqfXEGVdNhzIdY3vM1801lFJJyGmn7xYgCNky2TIC0Dtjv/pTiJL2xfBZgwLQdKrOlGxzObwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgpYjy7l; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-307325f2436so5508601fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742458914; x=1743063714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9GpDSA8tbhAx7dWPzDPx3e1xZuvi/1QhmKobUShUeI=;
        b=CgpYjy7lZQnoUj3m/SpD1rZ19VL2bz7MqK06GKEY2f+c1MBC3W9XfFNz/cWeZ5XMwo
         J1fkndii7av7zqAMOKjIeX4Iic5O7YikO6P060hzDcOx2zk2vWlK2Jy7zXx5TPXzlP0B
         xGwhf+Hfr8GhwRWYsb+mnU1W9R91zC3BOrcMfbPGGJ/8rS2xK55KERXMEdd+Y9PNUbBX
         riGo5yivoSUg6ZzNg8RQG7ZpiMrQZuYsBft2wmkuMG1SQIwbMovEvydZHZphhyVvD+Py
         IUUhBvZvEz4ehgnV1qYuFdSTe1aKPydTg6pSBhcX4/WFMFfGmOGb04tV8ZWIuYbyapnw
         eAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742458914; x=1743063714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9GpDSA8tbhAx7dWPzDPx3e1xZuvi/1QhmKobUShUeI=;
        b=rsYlrdMg87oygasGer7XB6OyR2B6NDz16oF8r+hrUPWTnVk0rYYtez1fl08952g75G
         mN4z6YADafd/CKddlmiMa34Ji47943EmyEt7BY6Q0ZClA4ZjDLPGZMMAkHStLasD9hAa
         lox8Cn/acZ624zhPH4O0vR4/GAaV3c/BI/e52ojT71F47VflIkCZjc19snBzTpOqG8Of
         za1YjrKqkEMOpkpTlwHaDQcaE7UytGyQRelgbCL2kt5III29Kyu8BW5lgOXOJrBw5TGA
         BZbUIHU8hi6mbEGoZblhNEayJsu8sNLT1vtoDTvnvNRFTf6YLu1ySkkb3ahJnstgi6+I
         p1Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWeWSPl3qapkMAch6tv/2T1jwcJrVOmuq6/K1ajgVSQTAPDZz+oQgmYiM9XvqlP0o35U0KvoZaN5XgGFTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMseAl7rXy3PqYwajeTZuqk1ob2wo0Etm1HkwDHnNzQuw9IkXH
	293NC7wy/jfdHu4OT9oGt0hIGnKuE113K41KMVAvuIHSpFXM9slXnJFa1WuPxtG3Sjz9Y/v69Xn
	ddV3yWRWcYNzR27wp7bqofEtmqLQ=
X-Gm-Gg: ASbGnctWVgRp+EMl/ArL6bzxTpZc60qOJFPMdNghtLLkBzPrClvB0E7W1dJt4aWITNv
	8r5J7Io/jA3hoV8uZiURIjgM4oB+BAMKJdxjtambGLFn5h+njjqXuupVPek7oZiBSea4AQ4qagz
	VPBA91sn/zz/hBsRZHaOE+H0APXRUrcvEBCOSg
X-Google-Smtp-Source: AGHT+IHOAg1VoSxHUmiZUEnEI667vD5qEpfH27rDxwE0cYqY16c9R4tlE+CjHmffWGY3xDXAvOFx2LBIIyqlHLiAKA4=
X-Received: by 2002:a2e:8093:0:b0:30c:2e21:9958 with SMTP id
 38308e7fff4ca-30d72b0f28bmr6765871fa.32.1742458913945; Thu, 20 Mar 2025
 01:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317221824.3738853-1-mingo@kernel.org> <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com> <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com> <Z9nTfFiPv0-Lxm-_@gmail.com> <CAFULd4aFUun7+1izxbDM8nTEEta5PApysyTGsn1hjvQND=2UtQ@mail.gmail.com>
 <Z9tGh0Fa96gACmpQ@gmail.com>
In-Reply-To: <Z9tGh0Fa96gACmpQ@gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 20 Mar 2025 09:21:42 +0100
X-Gm-Features: AQ5f1Jo9Y7npF6sEPVGmsNAzw1m3JPlyOO-d293hvIOJZV1rvkVdDJCf5ZCpOnM
Message-ID: <CAFULd4bxUOiPLQ9aaZFx2jsLUwEPH0h=XiCOtxYn+Z8JEAeHUw@mail.gmail.com>
Subject: Re: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by default
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, "Ahmed S . Darwish" <darwi@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, John Ogness <john.ogness@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 11:34=E2=80=AFPM Ingo Molnar <mingo@kernel.org> wro=
te:
>
>
> * Uros Bizjak <ubizjak@gmail.com> wrote:
>
> > On Tue, Mar 18, 2025 at 9:11=E2=80=AFPM Ingo Molnar <mingo@kernel.org> =
wrote:
> >
> > >  #ifdef CONFIG_CC_HAS_ASM_INLINE
> > >  # define asm_inline __asm__ __inline
> > >  # define asm(...) asm_inline(__VA_ARGS__)
> > >  #else
> > >  # define asm_inline asm
> > >  #endif
> > >
> > > And I fixed up the places where this isn't syntactically correct:
> > >
> > >  35 files changed, 82 insertions(+), 79 deletions(-)
> > >
> > > I haven't looked at code generation much yet, but text size changes a=
re
> > > minimal:
> > >
> > >       text         data     bss      dec            hex filename
> > >   29429076      7931870 1401196 38762142        24f769e vmlinux.befor=
e
> > >   29429631      7931870 1401200 38762701        24f78cd vmlinux.after
> > >
> > > Which is promising, assuming I haven't messed up anywhere.
> >
> > Please use bloat-o-meter, it is more precise.
>
> Here's the bloat-o-meter output between vanilla and patched vmlinux:

[...]

> A lot fewer functions are affected than I expected from such a
> large-scope change.

Interestingly, I got *many* more changes just from converting atomic
locking functions to asm_inline, as reported in [1].

[1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42A=
VOWSnfKsg@mail.gmail.com/

> > Actually, functions with the most impact (x86 locking functions and
> > __arch_hweight) were recently converted to asm_inline, so besides
> > __untagged_addr, the remaining have very little impact, if at all
> > (c.f. amd_clear_divider() ). There is also no need to convert asm()
> > without directives inside.
>
> I did the test with Linus-vanilla (81e4f8d68c66) to maximize the
> potential effect, which doesn't have those changes yet.
>
> See tip:WIP.x86/core.
>
> > My proposal would be to convert the remaining few cases (the remaining
> > asms involving ALTERNATIVE and exceptions) "by hand" to asm_inline()
> > and stick a rule in checkpatch to use asm_inline() in the code
> > involving asm(), like we have the rule with asm volatile.
> >
> > I don't think redefining an important C keyword is a good approach, it
> > obfuscates its meaning too much. And as has been shown by Ingo's
> > experiment, there is a substantial effort to fix false positives.
> > Instead of fixing these, we can trivially convert the remaining cases
> > to asm_volatile() as well, without obfuscating asm(). Checkpatch can
> > take care of future cases.
>
> This would work for me too. The cross-arch impact and churn seems
> substantial.

Perhaps we should also coordinate the effort with Josh, so we won't
step on each other's toes. From my analysis, gains from converting the
remaining asm() that involve ALTERNATIVE would be minor. It is also
questionable if asm() involving exceptions is worth converting at all,
I have to analyse them case-by-case some more during the next
development window.

Thanks,
Uros.

