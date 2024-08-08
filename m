Return-Path: <linux-kernel+bounces-279984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6132594C427
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B9F287337
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF4146A7A;
	Thu,  8 Aug 2024 18:19:34 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF0F78281
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141173; cv=none; b=GKTZWAn/AvTrrYPe2UVqhursiGkYjWHtgvBZvX6i4qdksqoRQjqGEzpUbW1mztTVXV4arrYVOm5rc2M3ClS8UIj0Y53YqLIAqnRGVObTK5sfpjcBJay7fnZJicqQ7e7m0zIOnvPBO7mqg4tJcgOFMxTEdhwtf06vjCa0KM5UUdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141173; c=relaxed/simple;
	bh=eX0NccdwTCvkYRYBoX+cyAF2+5W8RRBZrb3Zm72W86o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHH2nFTQl9E+1CG9SSUW9kdMt6Jqs26MnlVd2Gib3Gi96JWLdJwTqiLcxEoLMtmN9SQWiPVIcWsuBzDYVk/YzYGLxQscKQ3sYTTfDP7MfCZ8j7vLSlcDp2IEmcSDBvP7XE3giWKBppIkCeZWfM1MI7b6ke+gDqozRVVT5peL7G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ff9281e93so6604561cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141170; x=1723745970;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56gEFcQ+7FsmWGX5zf5waZqtpTKHFwpGyqer14r3mAA=;
        b=F1mrr/b3nxUCnhlZfyoQP/4PIKxRLQlaA6Bzhgw3gZBbxxfH4XwBnowC5Ytx+9F200
         lXKaxu6OROuKNHUnYp8ZeRUtX1r4rnAEoEJ+KLxzsv8a/3Os3PIq2h8wknvbXgy4ZiWr
         3yFpEat7KthDWEUtEtlLJD4Ds8rrpxfDT34reBp7AYuDHYxtmX5+2+7qQJD7JFa05ewK
         fQPzq8PO6dl00Q91Zi49Ju59KH2/D07p5cA7e+zE2AsTn/J8OvBHSAERNNEKcKurg75X
         a+k7ZuTLxqH23ZBRVY2PfBoaWQySbytpo6EOPvhOA1z5WBZHPR0OO1PrllVbbPR26qk2
         XDew==
X-Gm-Message-State: AOJu0Yz8VS7NwS/msjLUXaDNpdvHyHriXxrhrkflf0/VhQBCi2uOTb0C
	zUW0deByoMiKMracMImK+edjKY5AXAtObVTOQgKJRoNr9/zhYWg6DopUzQ==
X-Google-Smtp-Source: AGHT+IFu1hdnCuQzXZNpgIn8h/1FGOX+w9Q/sGtwD429aPynBVaGjK3wkHxw2feTVbhULUXw1VM1BA==
X-Received: by 2002:ad4:5490:0:b0:6bd:7389:2bb3 with SMTP id 6a1803df08f44-6bd73892ccbmr7609396d6.33.1723141169886;
        Thu, 08 Aug 2024 11:19:29 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8a9379sm68327806d6.145.2024.08.08.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:19:29 -0700 (PDT)
Date: Thu, 8 Aug 2024 13:19:27 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND sched_ext/for-6.12] sched_ext: Don't use double
 locking to migrate tasks across CPUs
Message-ID: <20240808181927.GE6223@maniforge>
References: <ZrP_zUjrTcrfdHDe@slm.duckdns.org>
 <ZrQAB_d1WSqgYQmB@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xOWZwxtfQAqOkla0"
Content-Disposition: inline
In-Reply-To: <ZrQAB_d1WSqgYQmB@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--xOWZwxtfQAqOkla0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 01:15:19PM -1000, Tejun Heo wrote:

Hi Tejun,

[...]

> -static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
> -				   u64 enq_flags)
> +static bool move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> +				   struct rq *src_rq, struct rq *dst_rq)
>  {
> -	struct rq *task_rq;
> -
> -	lockdep_assert_rq_held(rq);
> +	lockdep_assert_rq_held(src_rq);
> =20
>  	/*
> -	 * If dequeue got to @p while we were trying to lock both rq's, it'd
> -	 * have cleared @p->scx.holding_cpu to -1. While other cpus may have
> -	 * updated it to different values afterwards, as this operation can't be
> +	 * If dequeue got to @p while we were trying to lock @src_rq, it'd have
> +	 * cleared @p->scx.holding_cpu to -1. While other cpus may have updated
> +	 * it to different values afterwards, as this operation can't be
>  	 * preempted or recurse, @p->scx.holding_cpu can never become
>  	 * raw_smp_processor_id() again before we're done. Thus, we can tell
>  	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
>  	 * still raw_smp_processor_id().
>  	 *
> +	 * @p->rq couldn't have changed if we're still the holding cpu.
> +	 *
>  	 * See dispatch_dequeue() for the counterpart.
>  	 */
> -	if (unlikely(p->scx.holding_cpu !=3D raw_smp_processor_id()))
> +	if (unlikely(p->scx.holding_cpu !=3D raw_smp_processor_id()) ||
> +	    WARN_ON_ONCE(src_rq !=3D task_rq(p))) {
> +		raw_spin_rq_unlock(src_rq);
> +		raw_spin_rq_lock(dst_rq);
>  		return false;
> +	}
> =20
> -	/* @p->rq couldn't have changed if we're still the holding cpu */
> -	task_rq =3D task_rq(p);
> -	lockdep_assert_rq_held(task_rq);
> -
> -	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(rq), p->cpus_ptr));
> -	deactivate_task(task_rq, p, 0);
> -	set_task_cpu(p, cpu_of(rq));
> -	p->scx.sticky_cpu =3D cpu_of(rq);
> +	/* the following marks @p MIGRATING which excludes dequeue */
> +	deactivate_task(src_rq, p, 0);
> +	set_task_cpu(p, cpu_of(dst_rq));
> +	p->scx.sticky_cpu =3D cpu_of(dst_rq);
> +
> +	raw_spin_rq_unlock(src_rq);
> +	raw_spin_rq_lock(dst_rq);
> =20
>  	/*
>  	 * We want to pass scx-specific enq_flags but activate_task() will
>  	 * truncate the upper 32 bit. As we own @rq, we can pass them through
>  	 * @rq->scx.extra_enq_flags instead.
>  	 */
> -	WARN_ON_ONCE(rq->scx.extra_enq_flags);
> -	rq->scx.extra_enq_flags =3D enq_flags;
> -	activate_task(rq, p, 0);
> -	rq->scx.extra_enq_flags =3D 0;
> +	WARN_ON_ONCE(!cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr));

Hmmm, what's to stop someone from issuing a call to
set_cpus_allowed_ptr() after we drop the src_rq lock above?  Before we
held any relevant rq lock so everything should have been protected, but
I'm not following how we prevent racing with the cpus_allowed logic in
core.c here.

> +	WARN_ON_ONCE(dst_rq->scx.extra_enq_flags);
> +	dst_rq->scx.extra_enq_flags =3D enq_flags;
> +	activate_task(dst_rq, p, 0);
> +	dst_rq->scx.extra_enq_flags =3D 0;
> =20
>  	return true;
>  }

Thanks,
David

--xOWZwxtfQAqOkla0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZrUMLwAKCRBZ5LhpZcTz
ZPWpAP99+7Zi6xS14yOfXnji0FSCQn7FZRtIdXAoF3cvBo4JfgEAq2Hj//6Ne9MD
QyZeGtwgJomOg9PxWiM6GQFIHvniqQM=
=r18G
-----END PGP SIGNATURE-----

--xOWZwxtfQAqOkla0--

