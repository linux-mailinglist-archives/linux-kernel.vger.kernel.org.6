Return-Path: <linux-kernel+bounces-269818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87741943724
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD1BB21B13
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD2156F30;
	Wed, 31 Jul 2024 20:33:51 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39671BDCF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458031; cv=none; b=vEBR9g8AsuxtzPASPygLXZecj+9tP81ug0zwN8liwukhX+E/DQdHd+e1sZcU79sk7NL2f0y8Tmrgbwkc11CugkrUM1qRzgxTVwDN2dVpdeYa/wDWj1zjEN8e1XnhqMLSppLmwxeOahV0P+62FHPMaM9iD0lKajJy885zUgdW8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458031; c=relaxed/simple;
	bh=DFfX55IKj4znznPDeISL95Z/hTlD5+OCGIfvyjScb1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VuR3KhUWzIVGUXcZD9ZclD28vgOa8q3MpwfgmCgxUvgBqAh+j8RV4lVoexIdGC3iRiRcw7yYqm78W2ya8bq5xrKEH86uTPeb/NQKIoXA5zN2CiecSUFwCbjkORXhUBZg3ZYSfkceDT8xY8AqqX8nwG8flACH/veWO7gRjJxvHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fe58fcf29so29498361cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 13:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722458029; x=1723062829;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8/I3vyT7Ow+s+s2LEf3bYETeE/gfaynDQKLs1nvX/8=;
        b=DPdzDkBbNl7095wvhgAg7l37Cvnj237nYqrv+UJd277wJpSci7DRSOx9UWAEHXoq0P
         a+a826/YPKYEHWmBxts6p1lR8Gv17DvUzEF/nXCtEGYO8BnBBV8OeIDT1+ArAiWbe2lV
         EUTtNqp1jiaiR75V3+IO6CF0YAz2vHRAaqKynGYMROpA+vn5rHSyWXTVRmgqsX2IxpzW
         pescHDIbVa4IgCx48fnMh1VT4RpNPBndz7as6dADMWWR45HkStkJSkhtTDW+V+MRnjlu
         j3yK12b1+98OIPAa3P1fSLRmRULy0hOS6c7y5/aTb9prtwYiocfbB1/SwWXJMb8jnDOb
         vobA==
X-Forwarded-Encrypted: i=1; AJvYcCWYg1OWK+AKwZg0BRVYmNEIJH/GEheiA2J51XV6tHxV8O49cSCN4O3V6PPPpCjH2ji+hNbqDFfokGwRZVz0/jx0TV21xSM9NVE6wEO3
X-Gm-Message-State: AOJu0Yz9VScXsYrG+qqQF3OvKFAwirL/kbAFMs0IKt7KrTFdOuu3xcxN
	zHHsJvI+nEt+GscaxwiLkBkeZKn9OPEJcqLrIjm9v3wi3rg7DOHY
X-Google-Smtp-Source: AGHT+IHrpIfQOfdO6Ly/NqJEdfl+B8/NlBsKUCmCmnZP++q7EXtZ2L/88TO0Dz0qSxTDxvTgtQIp0Q==
X-Received: by 2002:a05:622a:1907:b0:447:dbbc:7493 with SMTP id d75a77b69052e-4515eb6ebebmr4935151cf.24.1722458028532;
        Wed, 31 Jul 2024 13:33:48 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe814edc4sm63021391cf.28.2024.07.31.13.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 13:33:48 -0700 (PDT)
Date: Wed, 31 Jul 2024 15:33:44 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Allow p->scx.disallow only
 while loading
Message-ID: <20240731203344.GA42857@maniforge>
References: <20240711110720.1285-1-zhangqiao22@huawei.com>
 <ZpArK0qxZZI-0ykt@slm.duckdns.org>
 <ba2702f9-f66e-498b-853c-d23f1f9191bc@huawei.com>
 <ZpbclgFjf_q6PSd1@slm.duckdns.org>
 <cd3fa16d-5a70-4c85-a591-fa4fa481f50b@huawei.com>
 <ZpgERphu--gPn235@slm.duckdns.org>
 <7d39f26d-3c9f-4ee4-977c-87f9bed0bac1@huawei.com>
 <ZqqNLNWLfjsJ2E02@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xVXen2eiGIyaEs+S"
Content-Disposition: inline
In-Reply-To: <ZqqNLNWLfjsJ2E02@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--xVXen2eiGIyaEs+S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 09:14:52AM -1000, Tejun Heo wrote:
> p->scx.disallow provides a way for the BPF scheduler to reject certain ta=
sks
> from attaching. It's currently allowed for both the load and fork paths;
> however, the latter doesn't actually work as p->sched_class is already set
> by the time scx_ops_init_task() is called during fork.
>=20
> This is a convenience feature which is mostly useful from the load path
> anyway. Allow it only from the load path.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>
> Link: http://lkml.kernel.org/r/20240711110720.1285-1-zhangqiao22@huawei.c=
om
> Fixes: 7bb6f0810ecf ("sched_ext: Allow BPF schedulers to disallow specifi=
c tasks from joining SCHED_EXT")
> ---
>  include/linux/sched/ext.h |   11 ++++++-----
>  kernel/sched/ext.c        |   14 ++++++++------
>  2 files changed, 14 insertions(+), 11 deletions(-)
>=20
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -181,11 +181,12 @@ struct sched_ext_entity {
>  	 * If set, reject future sched_setscheduler(2) calls updating the policy
>  	 * to %SCHED_EXT with -%EACCES.
>  	 *
> -	 * If set from ops.init_task() and the task's policy is already
> -	 * %SCHED_EXT, which can happen while the BPF scheduler is being loaded
> -	 * or by inhering the parent's policy during fork, the task's policy is
> -	 * rejected and forcefully reverted to %SCHED_NORMAL. The number of
> -	 * such events are reported through /sys/kernel/debug/sched_ext::nr_rej=
ected.
> +	 * Can be set from ops.init_task() while the BPF scheduler is being
> +	 * loaded (!scx_init_task_args->fork). If set and the task's policy is
> +	 * already %SCHED_EXT, the task's policy is rejected and forcefully
> +	 * reverted to %SCHED_NORMAL. The number of such events are reported
> +	 * through /sys/kernel/debug/sched_ext::nr_rejected. Setting this flag
> +	 * during fork is not allowed.
>  	 */
>  	bool			disallow;	/* reject switching into SCX */
> =20
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -3399,18 +3399,17 @@ static int scx_ops_init_task(struct task
> =20
>  	scx_set_task_state(p, SCX_TASK_INIT);
> =20
> -	if (p->scx.disallow) {
> +	if (!fork && p->scx.disallow) {
>  		struct rq *rq;
>  		struct rq_flags rf;
> =20
>  		rq =3D task_rq_lock(p, &rf);
> =20
>  		/*
> -		 * We're either in fork or load path and @p->policy will be
> -		 * applied right after. Reverting @p->policy here and rejecting
> -		 * %SCHED_EXT transitions from scx_check_setscheduler()
> -		 * guarantees that if ops.init_task() sets @p->disallow, @p can
> -		 * never be in SCX.
> +		 * We're in the load path and @p->policy will be applied right
> +		 * after. Reverting @p->policy here and rejecting %SCHED_EXT
> +		 * transitions from scx_check_setscheduler() guarantees that if
> +		 * ops.init_task() sets @p->disallow, @p can never be in SCX.
>  		 */
>  		if (p->policy =3D=3D SCHED_EXT) {
>  			p->policy =3D SCHED_NORMAL;
> @@ -3418,6 +3417,9 @@ static int scx_ops_init_task(struct task
>  		}
> =20
>  		task_rq_unlock(rq, p, &rf);
> +	} else if (p->scx.disallow) {

Just to make it a bit easier on schedulers, should we do this:

} else if (p->scx.disallow && p->policy =3D=3D SCHED_EXT)

That way if you have a task that isn't running with SCHED_EXT and forks,
the scheduler can set p->scx.disallow without having to check that it's
being set in a fork. Seems unnecessary to enforce that given that the
end result is the same.

Otherwise this LG. Feel free to apply if you agree, and add my ack:

Acked-by: David Vernet <void@manifault.com>

Thanks,
David

--xVXen2eiGIyaEs+S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZqqfqAAKCRBZ5LhpZcTz
ZPGiAP4ran6mmEBTp+t2RcQt2xzipc4xB+I8Reom+RuG3Ks+/AEArUNl7h3EUYxu
Yd6pMUfAfyXhdCGxBxKyroA2MQIZKQo=
=Jd53
-----END PGP SIGNATURE-----

--xVXen2eiGIyaEs+S--

