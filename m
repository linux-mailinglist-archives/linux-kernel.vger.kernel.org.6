Return-Path: <linux-kernel+bounces-225986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB1A9138BA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6CB1F2370C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A712EBD6;
	Sun, 23 Jun 2024 07:17:27 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE812E1C6
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719127046; cv=none; b=YG+XmvT0xhaCn48Rs5TUTzN8IueKSAE3rTLhrBCRL+Lux91NX2CqM9WBq6Sv3ZhYoM9zWjDIV0e/coBwbFKiGyk9tIoxF2vQVV/W5mX0QT1I0cZmq5dIh4OKxX163nQgEg78tURn1QyHO0VvmDW+JXGF2q96jRpX/cIigiN9+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719127046; c=relaxed/simple;
	bh=kiYSWgaACC/HEzTdVdCm5gAy45b37OAq0iG/CNF5qfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RO64BEzN0SorDSV/cfIiAyEtdHy70EL75RfkdY7xrk2qKKOcAt7eZYhn1oDG2jdiZ4qWc+AqegMFIsTFXk28llcbySumAGJZsYbVbt2NoU7rK8KQSHuO0qgaqZ23VKtvW1grgfGsZ5ZBl5XF0nD9Vs2x2jZMWq4QYesJDeGyOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25cc6962c24so1436970fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 00:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719127044; x=1719731844;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9weIu+p6DIIVEgrw1mdMGAPov2kCoAIO1cRnqx1ltAE=;
        b=RXkDoOEp6lYOERlT2RVv7DmfWreDb51FCUtUT1kQR4MnG05YWVvKLTGV93PIfb7Nxr
         gj0KWM8XcMKbBlptf2e4+H4LvMpzUu6J/opp53JRlnRFHvKiIs3ziWevKE0wzdTWpQmL
         j5AvqhPcfO4fb3DKlozvqFXJuePVqWLqdQ6MiT09vd4HPmAMTk7HZGws6tic33hMcto7
         g90BVvum0UQNsBkEvjkpciOT2CpaFcdGuHGGJ9HhZqx36JiEnCDbM3lh51gnCeRjesbV
         B5TMb8TaBoOZhr8aV7iY+topeYdTGJRd+Dmgpg+5k0Jm52+5R7fH/wfNLRRGpAMAVLHU
         23iA==
X-Forwarded-Encrypted: i=1; AJvYcCVb9ih6lHB4nzfX33F6YoGRqs/QAMWxRR1ksGxkvPhUXpNYLLuooDvjpfpuFHxcZuekq7kMVUxRcLaYVRsUn5hiL37Fp0rpXvOtQvXe
X-Gm-Message-State: AOJu0YxLy4mBsPw8Cm3S2v0vo4TaseXVul1Ykw5B3JSjCQ6L2RS8HVpo
	BwWpQemc/IvQUKrZBwv6JFLIfiiPrLeYt/2fxg0JEQXcaQD3XuFN
X-Google-Smtp-Source: AGHT+IGlScQoWeztWBIkbHwNQocGZNTmni5DgH+Wv+YcPQ7pKdzK6jW+JoAeDwxYSwf7R4WQrWIPTg==
X-Received: by 2002:a05:6870:82aa:b0:25c:b2bf:221d with SMTP id 586e51a60fabf-25d06ebd7b4mr1286506fac.55.1719127043934;
        Sun, 23 Jun 2024 00:17:23 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b2f90sm215575485a.52.2024.06.23.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:17:23 -0700 (PDT)
Date: Sun, 23 Jun 2024 02:17:21 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 2/3] sched, sched_ext: Open code for_balance_class_range()
Message-ID: <20240623071721.GC6519@maniforge>
References: <20240623015057.3383223-1-tj@kernel.org>
 <20240623015057.3383223-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sNQb8PGpwdXATRwA"
Content-Disposition: inline
In-Reply-To: <20240623015057.3383223-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--sNQb8PGpwdXATRwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 03:50:21PM -1000, Tejun Heo wrote:
> For flexibility, sched_ext allows the BPF scheduler to select the CPU to
> execute a task on at dispatch time so that e.g. a queue can be shared acr=
oss
> multiple CPUs. To enable this, the dispatch path is executed from balance=
()
> so that a dispatched task can be hot-migrated to its target CPU. This mea=
ns
> that sched_ext needs its balance() method invoked before every
> pick_next_task() even when the CPU is waking up from SCHED_IDLE.
>=20
> for_balance_class_range() defined in kernel/sched/ext.h implements this
> selective iteration promotion. However, the indirection obfuscates more t=
han
> helps. Open code the iteration promotion in put_prev_task_balance() and
> remove for_balance_class_range().
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/core.c | 14 +++++++++++++-
>  kernel/sched/ext.h  |  9 ---------
>  2 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1092955a7d6e..827e0dc78ea0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5834,7 +5834,19 @@ static void put_prev_task_balance(struct rq *rq, s=
truct task_struct *prev,
>  				  struct rq_flags *rf)
>  {
>  #ifdef CONFIG_SMP
> +	const struct sched_class *start_class =3D prev->sched_class;
>  	const struct sched_class *class;
> +
> +#ifdef CONFIG_SCHED_CLASS_EXT
> +	/*
> +	 * SCX requires a balance() call before every pick_next_task() including
> +	 * when waking up from SCHED_IDLE. If @start_class is below SCX, start
> +	 * from SCX instead.
> +	 */
> +	if (sched_class_above(&ext_sched_class, start_class))
> +		start_class =3D &ext_sched_class;
> +#endif
> +
>  	/*
>  	 * We must do the balancing pass before put_prev_task(), such
>  	 * that when we release the rq->lock the task is in the same
> @@ -5843,7 +5855,7 @@ static void put_prev_task_balance(struct rq *rq, st=
ruct task_struct *prev,
>  	 * We can terminate the balance pass as soon as we know there is
>  	 * a runnable task of @class priority or higher.
>  	 */
> -	for_balance_class_range(class, prev->sched_class, &idle_sched_class) {
> +	for_active_class_range(class, start_class, &idle_sched_class) {
>  		if (class->balance(rq, prev, rf))
>  			break;
>  	}
> diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
> index 229007693504..1d7837bdfaba 100644
> --- a/kernel/sched/ext.h
> +++ b/kernel/sched/ext.h
> @@ -68,14 +68,6 @@ static inline const struct sched_class *next_active_cl=
ass(const struct sched_cla
>  #define for_each_active_class(class)						\
>  	for_active_class_range(class, __sched_class_highest, __sched_class_lowe=
st)
> =20
> -/*
> - * SCX requires a balance() call before every pick_next_task() call incl=
uding
> - * when waking up from idle.
> - */
> -#define for_balance_class_range(class, prev_class, end_class)			\
> -	for_active_class_range(class, (prev_class) > &ext_sched_class ?		\
> -			       &ext_sched_class : (prev_class), (end_class))
> -
>  #ifdef CONFIG_SCHED_CORE
>  bool scx_prio_less(const struct task_struct *a, const struct task_struct=
 *b,
>  		   bool in_fi);
> @@ -100,7 +92,6 @@ static inline bool task_on_scx(const struct task_struc=
t *p) { return false; }
>  static inline void init_sched_ext_class(void) {}
> =20
>  #define for_each_active_class		for_each_class
> -#define for_balance_class_range		for_class_range
> =20
>  #endif	/* CONFIG_SCHED_CLASS_EXT */
> =20
> --=20
> 2.45.2
>=20

--sNQb8PGpwdXATRwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZnfMAAAKCRBZ5LhpZcTz
ZGxGAP9S2NJmwJkOvqmAuXPxVVjCK7RLYZ10sMP6WpK+/0BkewEA2JTKlGOGpE+1
C/EZ2hxxx1NB7otm0Thw4xovHmkENQo=
=gv+j
-----END PGP SIGNATURE-----

--sNQb8PGpwdXATRwA--

