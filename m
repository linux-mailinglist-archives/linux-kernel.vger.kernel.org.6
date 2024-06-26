Return-Path: <linux-kernel+bounces-230239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD13917A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5011C235CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2315EFC6;
	Wed, 26 Jun 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoP5V6Fk"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EE15CD63
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388488; cv=none; b=LWLDTGd+QjW1Aof2/7YGDrlYZVoJgiLNIp1tZ9gx7e9J3qLkPqzNpAzBtEKTuRNc83njDkL8Qam1yvrpU9gOJkVtk7j3TuqARATiYp9lZeuMLMtrnbS8smWTgsy6mEvXQAUFyW1dJH+2nfqb6N3HDqCiFzCtiD9A7/RGKdzaNK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388488; c=relaxed/simple;
	bh=3lM7Krd3eubuTSd3weFykcxesluFoVIhP2qOjhiNjTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVE4VHAuSLRfeVWCT+daZUNX+LiRUmaRAL0Hdcpvvl+a0m3FtC7R8Y35g2cECPOOuoeLKrk01MphRZu+c/B23PfyzhtId/sz4yhIfBxQQpvWiqJ1pG7q86fLZSyX4hn4CKJJgkQ5cb+0i+iDW0r9OGmh+ksszjwpZjtXvGk+MqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoP5V6Fk; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso66250761fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719388484; x=1719993284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9l4PBSU230KyF+70o0NVWXuUQoiQQyfQa7UJiR8ZC4=;
        b=FoP5V6FkC2f4DaphdtBZca6xFoNcS6UUbmUJ7yIUG6XJ+4VaZTL1/fBjDEQEJzX++n
         Q6tS4/oNfQbjpgZBTtSlTns8BfMKBh/yvJVSTkLiPym1Hk5RQ43ybfZ4wIEPnV4fRfVN
         n3cu3f59D6xwzY2v9nS4tXA29vEcbYRkvrc5xZ2fhrLQ4cG1I7naIIurJdBs6e8GX2R8
         c8vMD8tDNdTCcnUpaa4+kkXcei8EOCnlJzCAJqc2Kp65/2DfK4ZK+C1zYmsrZ510DAaS
         R9w1KjKqWbc7x+m2/R+jd3MscEqKDUAXkdzVrPMdRwqKCn0O1/P8H5vMU7CvtrlUMP89
         uPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388484; x=1719993284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9l4PBSU230KyF+70o0NVWXuUQoiQQyfQa7UJiR8ZC4=;
        b=phHAI3oMMcB7S22BYOA5+3XJFyBy06HH+6oJPOLKPjfHU9Y5W84t1VmrPcqGSY4a+d
         rnLv7dYkAlvRy3HeQTktzopTo1dR2ovA2m2sF5fzKrMZMGanrOw/217nhmleWNesVHaK
         dZSXUZFLURUyPBfmz8GqaFOKTRdq0kcmJ6TLLvNLtBbEhM4w5P5QuCDla6q8Pf3wgwGG
         5bbii/5N6BQ6QGHAYAzaAhM8AkJ9rqftEDT15dv5BHPbqNoremc7DQZfCZaKzOJQwfRD
         eva8BZuvFUWchEcYHUIAAjZjQx2VyXKblwuc4jqeuQhPt5pGjqY2Cz4i9IwHL42dBLF/
         +E8A==
X-Forwarded-Encrypted: i=1; AJvYcCVkxf0B0WKEHtCGg1bwXFTIDo26LS9lfdVViDNBX9spIHMXKNnprBTG8hi2ASnUK5IYAKMrMws2c6vdnJ+xqUhpA5DZcIjn47Bh6t6O
X-Gm-Message-State: AOJu0Yw0EIvJV71rPSHonx/XgQ8t9RT8tO5d29LW27Aief9cIsJ1SQg3
	Aje0G5ZP8m0wKhPWaFoKe8wtWjMPuny3+oGy++L/scaBswj7VQfAdRzqOZEsXMXEpOflsM7zUDA
	fYKlEJAOxjYXhP24JtQFKf+PdzPQkdlKH3M4=
X-Google-Smtp-Source: AGHT+IEdM7BL7IYNDJYZSWFp4SHg4gOScBa35KINGjDg3kZVWZCHM2JlMQa+zfdTbKK0IvAx79DqhoCjSlT8PLVH1aI=
X-Received: by 2002:a2e:86cb:0:b0:2ec:4de9:7332 with SMTP id
 38308e7fff4ca-2ec593c296bmr56063661fa.2.1719388483724; Wed, 26 Jun 2024
 00:54:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com>
 <CAHk-=whPqqZVSeJiQsMvsAxtAmtR9iAuB4gg_1sUK2D-uBPpLw@mail.gmail.com>
 <CAFULd4YAeF7=q7DYUh016kabxS8b32qRbFqDBJQrvLq6RjwEVg@mail.gmail.com>
 <CAHk-=wiHo2YeA=TOUf8vxFLOc0+BoH8USaiT25fnX2ynXbrZkg@mail.gmail.com>
 <CAHk-=wgdCs0883dpvZpyna76q9eVcTMvvUVAaBuJMPyrgOhNig@mail.gmail.com>
 <CAFULd4ZW23_RNye6YGbsT0Uo-vOQBM_tBbSJRhh=0HZzXuC_8Q@mail.gmail.com> <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
In-Reply-To: <CAHk-=wiWEgSo2Tb_bih7mnS27zAPL+RGg_7yX4qK1f710-j-Ng@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 26 Jun 2024 09:54:32 +0200
Message-ID: <CAFULd4YyamnC5D9SAo0w4EhbawJeS1K2ZqPt9CPUL4+S5uAOZA@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 8:31=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Sorry for not being hugely responsive the last few days - I was on
> the road for a family get-together on the east coast, so I spent time
> on airplanes and hotels and I don't particularly enjoy working with a
> laptop ]
>
> On Mon, 24 Jun 2024 at 08:42, Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > >
> > > I'm sending the patch out in the hope that another set of eyes will
> > > make it actually better.
> >
> > + _lock "cmpxchg8b 0(%[ptr])", X86_FEATURE_CX8) \
> >
> > This can be just:
> >
> > + _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
>
> Thanks, yup, will fix.
>
> > - if (unlikely(!ret)) \
> > - *(_oldp) =3D o.full; \
> > + *(_oldp) =3D o; \
> >
> > This one should really update only when cmpxchg fails.
>
> The thing is, when cmpxchg doesn't fail, then oldp should already be "old=
", no?

Also replying here with the reply to your proposed patch, to document
a subtle issue with try_cmpxchg:

You probably want to look at 44fe84459faf1 ("locking/atomic: Fix
atomic_try_cmpxchg() semantics") [1] and the long LKML discussion at
[2].

--quote--
This code is broken with the current implementation, the problem is
with unconditional update of *__po.

In case of success it writes the same value back into *__po, but in
case of cmpxchg success we might have lose ownership of some memory
locations and potentially over what __po has pointed to. The same
holds for the re-read of *__po.
--/quote--

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=
=3D44fe84459faf1a7781595b7c64cd36daf2f2827d
[2] https://lore.kernel.org/lkml/CACT4Y+bG+a0w6j6v1AmBE7fqqMSPyPEm4QimCzCou=
icmHT8FqA@mail.gmail.com/

Uros.

>
> I mean, by the very definition, atomic_try_cmpxchg() can *not* be
> successful if the new value didn't match the old one.
>
> I mean, just look at the very doc you point to - the "definition" is
>
>   bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
>   {
>     int ret, old =3D *oldp;
>     ret =3D atomic_cmpxchg(ptr, old, new);
>     if (ret !=3D old)
>       *oldp =3D ret;
>     return ret =3D=3D old;
>   }
>
> iow, it only returns success of "ret =3D=3D old", and "old" by definition
> is "the contents of oldp".
>
> (Here "oldp" is a local variable, not something that can be changing).
>
> So I *think* the whole
>
>     if (ret !=3D old)
>       *oldp =3D ret;
>
> is actually counter-productive, and could/should be just that simpler
> unconditional *oldp =3D ret, because you have two cases:
>
>  - ret =3D=3D old: the assignment doesn't change anything and is a no-op
>
>  - ret !=3D- old: the assignment needs to be done
>
> but doing it *unconditionally* means that now as fat as the compiler
> is concerned, the original *oldp value is unconditionally dead, which
> sounds to me like it should be good for register allocation (the
> context here being that it _looks_ like a pointer access, but it's
> really meant to be a "in-out argument in a register").
>
> Now, in practice, I suspect that everybody checks the return value and
> "old" is never used afterwards in the success case, so in that sense
> this doesn't matter and it's all dead regardless.
>
> But it seems to be a complication in the docs and the implementation.
>
> Of course, I may be missing something completely obvious, and/or you
> have some subtle code generation reason why you prefer the conditional
> there. Feel free to explain,
>
>              Linus

