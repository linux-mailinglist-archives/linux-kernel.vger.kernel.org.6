Return-Path: <linux-kernel+bounces-225993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16CE9138D1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E3CB21019
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3E847F7F;
	Sun, 23 Jun 2024 07:48:49 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A11EB25
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719128928; cv=none; b=aFizhqp30ZAByV4bh/0mMdoduMj4wM89GNBop2TWNZ9Wslik5UUL5gJG/H7PtsvKskUI3QHW8ZO9S9g+PVwATJ9dYuc6/di0YHyD1tRREAjofAAJRI8dKiPvKsu9HyDc+R8O7Y8ARxYyDsfu0WB17ZXznj+TuOHxIaARPQG1syE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719128928; c=relaxed/simple;
	bh=coOMRq5fTST8LYd77S91I9wiK2F3JtXxu070au7GsSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjVadm07mn+6kJKFqUrie7vG0T73V+Cgr0CwJpS+mpl9P1dwOywXvoUqLk6vXnrJYXAW/8tZVflmcuXOuY5eS02nuXmEt9t80EiVqc99DkxicAMvmCT+9vtCM57aBXpfIozcjoP/h/Mc77wE5rXyoXqwJu6y3fmAW426asIAYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0272692096so2919803276.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719128925; x=1719733725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZq/r1TbBOI5gLtbJc1wM+YT8czo+6EVFEPTcj/rL0Y=;
        b=GiCn+8YRrWqbm+o9lCQSVuyq55IAB5jy4E1HXVr5FmNJ2BnJFUDHo/WlB9A6DvK5Ur
         GPjQzj5exC8PBMJnmb0U7lx3xKe2IBOkG2gELxT9QoMFj4u2sEbDfD25SFmD5fucwAKg
         mwJ7j2pidlrZGE2GXSpWavE7KsLAFJhzMf4Agfd/xq0u/3xkG3cvVOjpYrzsqjKreD4I
         DzopAUAwMep6p6rVj4coDEhbF7Km8pbpxwgfJ9aBqq9hweyqIPxMnll1F0+kBFG5RZba
         ebQ45euglR1SJKcAZWSSzkaurEVtFHM5z3ApJvMoXoV5rDVEwj+UEklS4eE1/ekvfuSX
         HH9g==
X-Forwarded-Encrypted: i=1; AJvYcCXOAT7uj4QoldGteMo4noV2TNtRu7+Z65xrfngqVZzAaXpxfQ4nNu1Px0Aqa69zBT876FpN4jr2YdhzYoQOIOp4kvQm8MtPk9S+x8G2
X-Gm-Message-State: AOJu0YwQhpbnvBWtFmOM5JxILmW41odq8fkNNTjm03oOvAMQLKonJgud
	QLXJNwQtLgF41Q0AxnGUqOhmVkjchii8w6dFj2s9+xtwrZ0Jy2A8
X-Google-Smtp-Source: AGHT+IH0ys2ETvAz2lSnGEUuV05Its9ATxfUBMG3tw4wgfyHxZxlGsOsnM0SZAor6vvjUBqVdn/Qug==
X-Received: by 2002:a05:690c:368f:b0:644:b209:4de1 with SMTP id 00721157ae682-644b2094e4fmr254117b3.2.1719128925495;
        Sun, 23 Jun 2024 00:48:45 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b6b048sm29559651cf.38.2024.06.23.00.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:48:44 -0700 (PDT)
Date: Sun, 23 Jun 2024 02:48:42 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 3/3] sched, sched_ext: Move some declarations from
 kernel/sched/ext.h to sched.h
Message-ID: <20240623074842.GD6519@maniforge>
References: <20240623015057.3383223-1-tj@kernel.org>
 <20240623015057.3383223-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nJOT9ZKSYPT/pzLc"
Content-Disposition: inline
In-Reply-To: <20240623015057.3383223-4-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--nJOT9ZKSYPT/pzLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 03:50:22PM -1000, Tejun Heo wrote:

Hello Tejun,

> While sched_ext was out of tree, everything sched_ext specific which can =
be
> put in kernel/sched/ext.h was put there to ease forward porting. However,
> kernel/sched/sched.h is the better location for some of them. Relocate.
>=20
> - struct sched_enq_and_set_ctx, sched_deq_and_put_task() and
>   sched_enq_and_set_task().
>=20
> - scx_enabled() and scx_switched_all().
>=20
> - for_active_class_range() and for_each_active_class(). sched_class
>   declarations are moved above the class iterators for this.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---

[...]

Bringing everything above this into sched.h seems reasonable. See below for
some thoughts about sched_deq_and_put_task() and sched_enq_and_set_task().

> =20
>  static inline bool sched_stop_runnable(struct rq *rq)
>  {
> @@ -3698,6 +3733,24 @@ static inline void balance_callbacks(struct rq *rq=
, struct balance_callback *hea
> =20
>  #endif
> =20
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +/*
> + * Used by SCX in the enable/disable paths to move tasks between sched_c=
lasses
> + * and establish invariants.
> + */
> +struct sched_enq_and_set_ctx {
> +	struct task_struct	*p;
> +	int			queue_flags;
> +	bool			queued;
> +	bool			running;
> +};
> +
> +void sched_deq_and_put_task(struct task_struct *p, int queue_flags,
> +			    struct sched_enq_and_set_ctx *ctx);
> +void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);

I'm not opposed to bringing these into sched.h, but they're implementing a
pattern that's used almost verbatim in a few other places in core.c, so it
would be nice if we could figure out some way to just have every caller use=
 the
same API for doing the whole dequeue/save -> update state -> re-enqueue/res=
tore
dance. We had SCHED_CHANGE_BLOCK [0] way back in v2, but IIRC we dropped it
because upstream was moving towards a more generic implementation. It looks
like that hasn't materialized yet, so maybe we should resurrect that?

[0]: https://lore.kernel.org/all/20230128001639.3510083-3-tj@kernel.org/

Anyways, no objection from me in moving this into sched.h (as long as Peter,
Thomas and Ingo are OK with it). But it does feel kind of unfortunate to st=
ick
it there in its current form given that it's only used by ext.c, despite be=
ing
95% of the way there for quite a few potential callsites in core.c.

Thanks,
David

--nJOT9ZKSYPT/pzLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZnfTWgAKCRBZ5LhpZcTz
ZLbMAQCQ4IbR2vKZ1Ru86/TU6s8eytIL3zE3tSwlmfDzWvuZlAD9FPREjeeBz0/R
FI2HXwyIO7MSj1x+kEp2hfaZN8l/Ugc=
=QLi0
-----END PGP SIGNATURE-----

--nJOT9ZKSYPT/pzLc--

