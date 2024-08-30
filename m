Return-Path: <linux-kernel+bounces-309257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EA0966831
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2AF282EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693D1C6A5;
	Fri, 30 Aug 2024 17:40:20 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750116C68F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039619; cv=none; b=BikygjMTDF/w6HM77vkNF9MxQty1i5bILXuRLMj1ksD3pKuCbC5XBVUrnMcfKqs6ASx7gRtMZw1I5se/plJmgabYynkzhmKww7Vnhq3qmgrFjI9eIbBoYoUHnQqopJvjzki1wV74f4oqg4kQgpNE5gTFicwNTw7eUizKnnrS6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039619; c=relaxed/simple;
	bh=GcBBNmQQMTCwDaatNOJtRczKiZ6xjV7fqAx1dx5hZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVXQfSJiGaHWYeynvCNrXWuS0TPvPTcIiWaNCl9sUDRR9J/tC2a/0sS1DQCapB9PSQtGwnqJkh7SI5upsp1llzrDqOgNKRl4agYa4kpHazHVdExT+panZ7rWRjija4eNEJen/8yOlLWhv2RyJn/J8nPVl4A6HtWxXWlhPs7LDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a803a4f6dfso130458285a.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725039617; x=1725644417;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gsmg95bSxAibnI8B0gMdMy/kFITZvDb/6Lbi3LEbNM4=;
        b=qeKI5rnmYEXBPUtVWIwwVmmxultiaGrGJSc+qNGaTVn9o1KkPVHDonOUHSAFAe3yhB
         5Y3hC0b0+i30DqtD2KZvKprBhMhJjXZ4uPA74ufRgAy791QQ5eHDflYgk2LNEShHQ9W9
         Cq2hJLjbta/i7EmpsdXFusA/2O2oZ/C4Vtgd/dG3U1SUHZj5vd+dRxdf55ejvp5LEpJs
         hUD+bqmUrbeJyrhiB0yAkeKIQLAoRFfwg115XE7HKespFMTWZQIfuTKGuHAOUKXFW/3e
         wVbGtGbbb+Y5CxxM30EUBbKjNv+bX4QIYaz7AC6yD6Ke2UHnxuqud7PoKgTSXaNFozkC
         5cnQ==
X-Gm-Message-State: AOJu0Yygc4+XdE/0M9jvoq8f7ppaJNa2bOM+anBX8jpfbGH7KY+GEyAL
	sev6LW3DqAvTnpiDpFRAgTabHRLTW3qt49uCmfpGw6p0ekpcw8H+
X-Google-Smtp-Source: AGHT+IF2UpLkm4kMOyjuvG1Y/sLYnPvokBSjVFnCv5D7Z7LAECJfQ9PBzAi+pwASfpkiw8XAhbp8Bw==
X-Received: by 2002:ad4:542b:0:b0:6c3:3e48:d53e with SMTP id 6a1803df08f44-6c33e616472mr67798806d6.21.1725039617120;
        Fri, 30 Aug 2024 10:40:17 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca68a6sm16500066d6.122.2024.08.30.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:40:16 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:40:14 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: Re: [PATCH 2/2 sched_ext/for-6.12] sched_ext: Use ktime_get_ns()
 instead of rq_clock_task() in touch_core_sched()
Message-ID: <20240830174014.GD5055@maniforge>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
 <ZtGkgCEkgNLzjxUC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NPWEbPEFoLS/H1Pe"
Content-Disposition: inline
In-Reply-To: <ZtGkgCEkgNLzjxUC@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--NPWEbPEFoLS/H1Pe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:52:48AM -1000, Tejun Heo wrote:
> Since sched_ext: Unpin and repin rq lock from balance_scx(), sched_ext's
> balance path terminates rq_pin in the outermost function. This is simpler
> and in line with what other balance functions are doing but it loses cont=
rol
> over rq->clock_update_flags which makes assert_clock_udpated() trigger if
> other CPUs pins the rq lock.
>=20
> The only place this matters is touch_core_sched() which uses the timestamp
> to order tasks from sibling rq's. For now, switch to ktime_get_ns(). Late=
r,
> it'd be better to use per-core dispatch sequence number.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 3cf78c5d01d6 ("sched_ext: Unpin and repin rq lock from balance_scx=
()")
> Cc: Peter Zijlstra <peterz@infradead.org>
> ---
>  kernel/sched/ext.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1453,13 +1453,20 @@ static void schedule_deferred(struct rq
>   */
>  static void touch_core_sched(struct rq *rq, struct task_struct *p)
>  {
> +	lockdep_assert_rq_held(rq);
> +
>  #ifdef CONFIG_SCHED_CORE
>  	/*
>  	 * It's okay to update the timestamp spuriously. Use
>  	 * sched_core_disabled() which is cheaper than enabled().
> +	 *
> +	 * TODO: ktime_get_ns() is used because rq_clock_task() can't be used as
> +	 * SCX balance path doesn't pin the rq. As this is used to determine
> +	 * ordering between tasks of sibling CPUs, it'd be better to use
> +	 * per-core dispatch sequence instead.
>  	 */
>  	if (!sched_core_disabled())
> -		p->scx.core_sched_at =3D rq_clock_task(rq);
> +		p->scx.core_sched_at =3D ktime_get_ns();

Should we just use sched_clock_cpu()? That's what rq->clock is updated
=66rom, and it's what fair.c does on the balance path when the rq lock is
unpinned.

Thanks,
David

>  #endif
>  }
> =20
> @@ -1476,7 +1483,6 @@ static void touch_core_sched(struct rq *
>  static void touch_core_sched_dispatch(struct rq *rq, struct task_struct =
*p)
>  {
>  	lockdep_assert_rq_held(rq);
> -	assert_clock_updated(rq);
> =20
>  #ifdef CONFIG_SCHED_CORE
>  	if (SCX_HAS_OP(core_sched_before))

--NPWEbPEFoLS/H1Pe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtID/gAKCRBZ5LhpZcTz
ZBR7AQDI5DzYxN7mgTjZvCiuVB9yoJuRvrD5mWyybS03B0SedAD/dbcjtAu7J6lb
boYL+8f0k8ahmiZbwrD0bggVxy+yhwA=
=xNK+
-----END PGP SIGNATURE-----

--NPWEbPEFoLS/H1Pe--

