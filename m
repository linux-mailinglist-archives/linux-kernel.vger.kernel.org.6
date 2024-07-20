Return-Path: <linux-kernel+bounces-257877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EB938004
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AEFB1F22131
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F22C1AC;
	Sat, 20 Jul 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqb+l858"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCC310A0C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721464556; cv=none; b=n8BwSL6xUThS8PDVqnj7qQ7SNxr8x/xlOGvfM4poZMiIY5zxyKfE+yTreYPL49e2XSWs9dAjyHxHJgMYNaIyD6q1B3ll3yntA4e7b/LZ7TD0YXBBKbhDJVWgq1Vi2t5f3XXu1CAMA1rZGBYC6ffnD4rirolBvmg6MSjc4NrQ+aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721464556; c=relaxed/simple;
	bh=d/LB1GIRHiVxnj8ccpWKQLKhVIgY3GB3xVo7jOT/wc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHANIX9G0DYCxEZmKLaAbBmtf4Xg7qxN3dZ9pHwc22pqjWTlV+EgfGCYaRNMehu6HpfjeVJTlSonh+f8aNZGn+Aa4fuC8GcWVEZ9zvzHkwqtMncQv73/NQs+SkwNbNZwRFZhZn2Y7RX1tHSOVTvuTYp4r2e8tyfaT4P9mDgr8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqb+l858; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ee920b0781so31783691fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721464552; x=1722069352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGCfDhWrSDDF6efXxgbMZtz6I8URiVFJKbg5WVY54Jw=;
        b=gqb+l858RXfE+g0mAuP7qXDsybPUcBaEI+9bjuAx40TCYyG57RIgNQimCY6LYXk7lp
         iT7n2hBZ7Tom0sOkKNM7mzLjiSkM7TW3Kj40OfKsugCSau27uj9vIOpbJwNrG1rFPagq
         HPU2nAujupTAgqHVdCXkrC4e8JVUtGM93tc1WVffZWkY2dWglN2iFMb6CnSwlyRl3sAd
         WZCKMypqS208Xhfbi/KsCe3cZP8463sE9WbAJvW7cGe9gk9/J39TX/1MURsJU3DWbr53
         uDpSACftSq4K8pQ7T/4PDqawqYH1aVJtorzXGbFTGCWGLqrrbmjbcPsmjxiFp5C4pb3B
         al3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721464552; x=1722069352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGCfDhWrSDDF6efXxgbMZtz6I8URiVFJKbg5WVY54Jw=;
        b=Hx+OKf6CmwyfdujYBZkKsbKPy7qIxMVJDCgLmf29Kjd3c2Kiz7fsf5horBA8BtyqbA
         m8tlpK+YN+WPq+AqRhUrW9lI5I/XvEHBNqJflm6nBX37xVByLgXV5inwN/nVFsDDgCIg
         sbRiwUEo/w3pQn8qjc/5sXBOLuLmSITw2Xwo5v0SJ3c89fcxJfEdt9HNo7zPuHssTUxz
         xg/RVKb99KfleF1++6pEjVPSAxQ/MP9cJGKzDeKA5iNR0GKMtWUnykRdhvniU+N1hzI3
         Wi2rCbZrgku/3OF1lWX+K6tWe8sWNwnHtq3JHti73tdI7uCwbmvy1QYbG8534JNcdv+e
         lBCw==
X-Forwarded-Encrypted: i=1; AJvYcCXtmOlJOKX2Rgd7VJHc5ObwycuMO3UE3kWOjc34w0zrOyxF8waoAxg3EZOeLnHu0shCZWABETC2ubfPKIDomMlmTh/cjK85u9fa8Glr
X-Gm-Message-State: AOJu0Yy5KFldFQBY87m2w8vq7HzLrwvG4uS1UvYg0QaNMVDtSJhZCf1B
	7rVsboLVpVO5zbbD1TmmCFdiD5mB8B1THWQxo7LF7EcyYJg7st6iJb1bjE93kgXtk/qASqIUPME
	5wgFn787mbGnNwAaoZnASlUBDsEg=
X-Google-Smtp-Source: AGHT+IGZfwSxTifh+IgNYvv24Guo5bdu3tFRoSAUxT8/Jsc3/A9WuULPFlkDX46SQeRL5Vo5WjxBWkN8bR/OVN5QUgs=
X-Received: by 2002:a2e:978a:0:b0:2ec:541b:4b4e with SMTP id
 38308e7fff4ca-2ef1684d49bmr12269411fa.32.1721464552221; Sat, 20 Jul 2024
 01:35:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719024010.3296488-1-maobibo@loongson.cn> <CAFULd4bt5oiQq4_3jSDe+3P=1xtAhZ=34vLREqPVT9njjdWKSA@mail.gmail.com>
 <ZpqR4qkFUNgkJj0x@boqun-archlinux>
In-Reply-To: <ZpqR4qkFUNgkJj0x@boqun-archlinux>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 20 Jul 2024 10:35:52 +0200
Message-ID: <CAFULd4aUoQf5CmUVEg5A7vKMz0CjrgSyZj=GyuhLkFviOPbGpg@mail.gmail.com>
Subject: Re: [PATCH] locking/atomic: scripts: Fix type error in macro try_cmpxchg
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Bibo Mao <maobibo@loongson.cn>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 6:18=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Fri, Jul 19, 2024 at 12:15:28PM +0200, Uros Bizjak wrote:
> > On Fri, Jul 19, 2024 at 4:40=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> =
wrote:
> > >
> > > When porting pv spinlock function on LoongArch system, there is
> > > compiling error such as:
> > >                  from linux/include/linux/smp.h:13,
> > >                  from linux/kernel/locking/qspinlock.c:16:
> > > linux/kernel/locking/qspinlock_paravirt.h: In function 'pv_kick_node'=
:
> > > linux/include/linux/atomic/atomic-arch-fallback.h:242:34: error: init=
ialization of 'u8 *' {aka 'unsigned char *'} from incompatible pointer type=
 'enum vcpu_state *' [-Wincompatible-pointer-types]
> > >   242 |         typeof(*(_ptr)) *___op =3D (_oldp), ___o =3D *___op, =
___r; \
> > >       |                                  ^
> > > linux/atomic/atomic-instrumented.h:4908:9: note: in expansion of macr=
o 'raw_try_cmpxchg_relaxed'
> > >  4908 |         raw_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARG=
S__); \
> > >       |         ^~~~~~~~~~~~~~~~~~~~~~~
> > > linux/kernel/locking/qspinlock_paravirt.h:377:14: note: in expansion =
of macro 'try_cmpxchg_relaxed'
> > >   377 |         if (!try_cmpxchg_relaxed(&pn->state, &old, vcpu_hashe=
d))
> >
> > This points to the mismatch between "pn->state" and "old" variable.
> > The correct fix is:
> >
> > --cut here--
> > diff --git a/kernel/locking/qspinlock_paravirt.h
> > b/kernel/locking/qspinlock_paravirt.h
> > index f5a36e67b593..ac2e22502741 100644
> > --- a/kernel/locking/qspinlock_paravirt.h
> > +++ b/kernel/locking/qspinlock_paravirt.h
> > @@ -357,7 +357,7 @@ static void pv_wait_node(struct mcs_spinlock
> > *node, struct mcs_spinlock *prev)
> > static void pv_kick_node(struct qspinlock *lock, struct mcs_spinlock *n=
ode)
> > {
> >        struct pv_node *pn =3D (struct pv_node *)node;
> > -       enum vcpu_state old =3D vcpu_halted;
> > +       u8 old =3D vcpu_halted;
> >        /*
>
> Looks reasonable to me, we should also add static_assert() for
> try_cmpxhg_*() to make sure the old has the same size of the cmpxchged
> field.

This is what -Wincompatible-pointer-types should detect, and it does
for the LoongArch target. Apparently, x86_64 targets use
-fshort-enums, so the mismatch was not detected on this particular
target.

Bibo Mao, does the proposed change works for you, so I can propose a
formal patch submission with the fix?

Thanks,
Uros.

