Return-Path: <linux-kernel+bounces-247884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3209092D5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA56A288374
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41A7198A2E;
	Wed, 10 Jul 2024 16:10:34 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C1198A21
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627834; cv=none; b=Lhz+DB0OQ3cnWqM6ZbaSHp7UtbcBllxQHypbYKnYl7x29Vcjj+ggw98cDum/68y1MwFScVTfW+adJ/WtmViXn5rWhDw6HV3xS7q6lLtjujH5yiG2aTeEFG33DoLSq/40c1pObIA/wr91piMVn6FlriGL91VAID3x0LcsvA9UwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627834; c=relaxed/simple;
	bh=4d7flW0GBJxl2SzYgrUWz8HkaqydvWbMoTN0i4FaSdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1NyoczpuSNQHu0Br97GljOGKdjbioX5Lp9yaIgh6W6r+ZJyAyqjbXg8cxNvuiV9GuJnozorVxLMXecPMphq05oPmwDLLdTG+ehT4837yH5eEzl/szxmuZZWt6Sv2wt0dRidEFughXJNw6bbSFlBMOfLboSPKjX+Y+/bSgc/ihI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f06c9c929so87664785a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627829; x=1721232629;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYPWb1c0ECtn7Pt9XOC7cF4z8lBQ1ICO4FUl2Uo/A2c=;
        b=l+hD/O/KlOdxqotZeOBLWFsAYdcJn/acaf9sy7FMEjyjovAnFS2V9unlN+9mmzupru
         AHvVlG7PDHp0RDhiIRDsOyc1vAKhD2R7H5dx9M9CiJe4se8FBFS1zEiCzocDnv+kWNeJ
         KuB6ENSbzMmzg/jsMRPRRKyZ/wiMM0z6Oy4KDTGAoqOSAAhljCcSg8o3qqEODwUw8PXO
         0g2BFf2qSr1vXA12kKf4iOZ/wYvywhTiDyUg9mgcukhSFUPKsb8dBMhU7O4t2RjJnsW5
         Jvd1+xQqEe0m13ThjJPL0vzMap/NgQ3wNNFwHXtosYie5HQP4CDIToDLLy6SUhnCi3ce
         6l1Q==
X-Gm-Message-State: AOJu0Yzfu5ppO/OL87vx7rNBupwKyrLzATdSINPOgWmn48telHzcFuru
	JYZIQ87jVV1C2CP9CtMlRvksAiSpZGe1TXOKH0hQbdArgfrv9hk+
X-Google-Smtp-Source: AGHT+IFA8oR1bzTAbO5KaNU5u/83jg/dGuz6nI1xxBBqrH/BqUPI8429cej+TbSOa05ovszQCSS1Cg==
X-Received: by 2002:a05:620a:29d6:b0:79e:ffae:cdc6 with SMTP id af79cd13be357-7a1469fa075mr18559685a.32.1720627829118;
        Wed, 10 Jul 2024 09:10:29 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff6a7esm208318685a.1.2024.07.10.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 09:10:28 -0700 (PDT)
Date: Wed, 10 Jul 2024 11:10:25 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 3/6] sched_ext: Make @rf optional for
 dispatch_to_local_dsq()
Message-ID: <20240710161025.GA317151@maniforge>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eDsdreE1x3GNCjOf"
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-4-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--eDsdreE1x3GNCjOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:21:09AM -1000, Tejun Heo wrote:
> dispatch_to_local_dsq() may unlock the current rq when dispatching to a
> local DSQ on a different CPU. This function is currently called from the
> balance path where the rq lock is pinned and the associated rq_flags is
> available to unpin it.
>=20
> dispatch_to_local_dsq() will be used to implement direct dispatch to a lo=
cal
> DSQ on a remote CPU from the enqueue path where it will be called with rq
> locked but not pinned. Make @rf optional so that the function can be used
> from a context which doesn't pin the rq lock.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> ---
>  kernel/sched/ext.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 52340ac8038f..e96727460df2 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2040,7 +2040,7 @@ static bool move_task_to_local_dsq(struct rq *rq, s=
truct task_struct *p,
>  /**
>   * dispatch_to_local_dsq_lock - Ensure source and destination rq's are l=
ocked
>   * @rq: current rq which is locked
> - * @rf: rq_flags to use when unlocking @rq
> + * @rf: optional rq_flags to use when unlocking @rq if its lock is pinned
>   * @src_rq: rq to move task from
>   * @dst_rq: rq to move task to
>   *
> @@ -2052,17 +2052,20 @@ static bool move_task_to_local_dsq(struct rq *rq,=
 struct task_struct *p,
>  static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *r=
f,
>  				       struct rq *src_rq, struct rq *dst_rq)
>  {
> -	rq_unpin_lock(rq, rf);
> +	if (rf)
> +		rq_unpin_lock(rq, rf);
> =20
>  	if (src_rq =3D=3D dst_rq) {
>  		raw_spin_rq_unlock(rq);
>  		raw_spin_rq_lock(dst_rq);
>  	} else if (rq =3D=3D src_rq) {
>  		double_lock_balance(rq, dst_rq);
> -		rq_repin_lock(rq, rf);
> +		if (rf)
> +			rq_repin_lock(rq, rf);
>  	} else if (rq =3D=3D dst_rq) {
>  		double_lock_balance(rq, src_rq);
> -		rq_repin_lock(rq, rf);
> +		if (rf)
> +			rq_repin_lock(rq, rf);

It feels kind of weird to have the callee need to know about pinning
requirements in the caller instead of vice versa. I mean, I guess it's inhe=
rent
to doing an unpin / repin inside of a locked region, but it'd be nice if we
could minimize the amount of variance in that codepath regardless. I think =
what
you have is correct, but maybe it'd simpler if we just pinned in the caller=
 on
the enqueue path? That way the semantics of when locks can be dropped is
consistent in dispatch_to_local_dsq().

>  	} else {
>  		raw_spin_rq_unlock(rq);
>  		double_rq_lock(src_rq, dst_rq);
> @@ -2072,7 +2075,7 @@ static void dispatch_to_local_dsq_lock(struct rq *r=
q, struct rq_flags *rf,
>  /**
>   * dispatch_to_local_dsq_unlock - Undo dispatch_to_local_dsq_lock()
>   * @rq: current rq which is locked
> - * @rf: rq_flags to use when unlocking @rq
> + * @rf: optional rq_flags to use when unlocking @rq if its lock is pinned
>   * @src_rq: rq to move task from
>   * @dst_rq: rq to move task to
>   *
> @@ -2084,7 +2087,8 @@ static void dispatch_to_local_dsq_unlock(struct rq =
*rq, struct rq_flags *rf,
>  	if (src_rq =3D=3D dst_rq) {
>  		raw_spin_rq_unlock(dst_rq);
>  		raw_spin_rq_lock(rq);
> -		rq_repin_lock(rq, rf);
> +		if (rf)
> +			rq_repin_lock(rq, rf);
>  	} else if (rq =3D=3D src_rq) {
>  		double_unlock_balance(rq, dst_rq);
>  	} else if (rq =3D=3D dst_rq) {
> @@ -2092,7 +2096,8 @@ static void dispatch_to_local_dsq_unlock(struct rq =
*rq, struct rq_flags *rf,
>  	} else {
>  		double_rq_unlock(src_rq, dst_rq);
>  		raw_spin_rq_lock(rq);
> -		rq_repin_lock(rq, rf);
> +		if (rf)
> +			rq_repin_lock(rq, rf);
>  	}
>  }
>  #endif	/* CONFIG_SMP */
> @@ -2214,7 +2219,7 @@ enum dispatch_to_local_dsq_ret {
>  /**
>   * dispatch_to_local_dsq - Dispatch a task to a local dsq
>   * @rq: current rq which is locked
> - * @rf: rq_flags to use when unlocking @rq
> + * @rf: optional rq_flags to use when unlocking @rq if its lock is pinned
>   * @dsq_id: destination dsq ID
>   * @p: task to dispatch
>   * @enq_flags: %SCX_ENQ_*
> --=20
> 2.45.2
>=20

--eDsdreE1x3GNCjOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo6ycQAKCRBZ5LhpZcTz
ZPYRAQC+o704AkKhUwkQYcK1eBYs/wT8w+JTjp5z9dLvV3t2ngD/QCW+WxqMLOD/
uz7yMovSRGMsG4S8yU9FtQXoS48zYg0=
=He7C
-----END PGP SIGNATURE-----

--eDsdreE1x3GNCjOf--

