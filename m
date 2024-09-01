Return-Path: <linux-kernel+bounces-310054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DA396742A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A5282CE9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFA22625;
	Sun,  1 Sep 2024 01:55:59 +0000 (UTC)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4A1859
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725155758; cv=none; b=gzSuBLljTg5ITYFcCDdUpnZdi3lL0OgCR5SuhUK5DkMSrqA6YJpDIzOx66b0pUmWbOK+SK0BKyGuPrbFdnXD07vrwazQUWQXOHl1KF4HgDHhUBON3SkfsSOUFHAEm540ft7dXtvQOG6Kn1ukvIyYwYrernmA/pdrDxm3zB/Ff5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725155758; c=relaxed/simple;
	bh=F8R4LLFmsi/Nbq/w004u4GlnGkKxvb1HkvdJbFxBD2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFXxU+9b9tdfeMnwqMJPhKZNSfQZkG0LTlKe9bTTWVVz+jY+N3UW0e0L2pnqrc/KvBUEq4GmAIXS5zw8nWdEKAE0Oa0C65516Kn+bwTtmJQ1vS7PoLyw04rEjrNty11IHiMNp346UnN07+DZCB2THwHhNjrSuHFbsBeRj8Xkhgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c352bcb569so8231086d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 18:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725155756; x=1725760556;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSo7z37Sf6DuEZBOXjgDDSwq9qunClKp37tC96bPVNU=;
        b=qfOdEY8tik0G9G8uObRFLfFMb7XM2G5hDOQYn/xlgEvAgdDRb7bTeLXaxpRgQWqjMY
         slPJva1/PtZzLRlvP66ZzV3qhkYnlbfmk/2FksNls17qZsfJ0chnkJ4Fyes1zdUKdjZp
         G0Fs/sLkupH82Nx6JSjoV36XQuP3WOMFpROjfQ0fkQr6F7d9Ia8DLM8uUEda7oGohlpY
         X5NjZSSCtqB17FZJGrXQCYmBa+dTcUdzJulyjpHFw3LUc2OjjJiJyJRndeyL/fOn6Ll/
         nAuzY2Rw9E4fGzrlzsCKPATD7BdlPdRQx0U4PwkmlQdiDSXcKbt2DZo6Fn86tmdT1v+1
         ex/w==
X-Forwarded-Encrypted: i=1; AJvYcCVa5P4q8x5ZsJlv3qRKY4oEgzcy4xNkGobLsuB5LmhLCll518xhtOkodoN4Lxol7xLCVq/22oOcZV3HIuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Uu+JHJUt6NVGZ7Z3TUWhAsuitoviN7gFrR4kHeze1egNwKzV
	tt8I2FislpTmnvWKhzd9xhUCgCCndBS3LArG5Bn3XmVclsX5zOWEPDVxaAJ0
X-Google-Smtp-Source: AGHT+IEzCUKQTuxynyZDcutCBSbJtEPBzz/JD3hY581ewI1MJdgnrOQkoOBYAx2Us4gvQLuVSl3Shw==
X-Received: by 2002:a05:6214:4948:b0:6c3:5663:81b5 with SMTP id 6a1803df08f44-6c3566381efmr28785526d6.5.1725155755971;
        Sat, 31 Aug 2024 18:55:55 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340ca6a89sm29053256d6.113.2024.08.31.18.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 18:55:55 -0700 (PDT)
Date: Sat, 31 Aug 2024 20:55:53 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] sched_ext: Replace consume_local_task() with
 move_local_task_to_local_dsq()
Message-ID: <20240901015553.GJ70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-10-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CfTem88Kzab91uKz"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-10-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--CfTem88Kzab91uKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:53AM -1000, Tejun Heo wrote:
> - Rename move_task_to_local_dsq() to move_remote_task_to_local_dsq().
>=20
> - Rename consume_local_task() to move_local_task_to_local_dsq() and remove
>   task_unlink_from_dsq() and source DSQ unlocking from it.
>=20
> This is to make the migration code easier to reuse.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/ext.c | 42 ++++++++++++++++++++++++++----------------
>  1 file changed, 26 insertions(+), 16 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 51d141602a11..df33524d68f3 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2103,23 +2103,30 @@ static bool yield_to_task_scx(struct rq *rq, stru=
ct task_struct *to)
>  		return false;
>  }
> =20
> -static void consume_local_task(struct task_struct *p,
> -			       struct scx_dispatch_q *dsq, struct rq *rq)
> +static void move_local_task_to_local_dsq(struct task_struct *p, u64 enq_=
flags,
> +					 struct scx_dispatch_q *src_dsq,
> +					 struct rq *dst_rq)
>  {
> -	lockdep_assert_held(&dsq->lock);	/* released on return */
> +	struct scx_dispatch_q *dst_dsq =3D &dst_rq->scx.local_dsq;
> +
> +	/* @dsq is locked and @p is on @dst_rq */
> +	lockdep_assert_held(&src_dsq->lock);
> +	lockdep_assert_rq_held(dst_rq);
> =20
> -	/* @dsq is locked and @p is on this rq */
>  	WARN_ON_ONCE(p->scx.holding_cpu >=3D 0);
> -	task_unlink_from_dsq(p, dsq);
> -	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
> -	dsq_mod_nr(&rq->scx.local_dsq, 1);
> -	p->scx.dsq =3D &rq->scx.local_dsq;
> -	raw_spin_unlock(&dsq->lock);
> +
> +	if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
> +		list_add(&p->scx.dsq_list.node, &dst_dsq->list);
> +	else
> +		list_add_tail(&p->scx.dsq_list.node, &dst_dsq->list);
> +
> +	dsq_mod_nr(dst_dsq, 1);
> +	p->scx.dsq =3D dst_dsq;
>  }
> =20
>  #ifdef CONFIG_SMP
>  /**
> - * move_task_to_local_dsq - Move a task from a different rq to a local D=
SQ
> + * move_remote_task_to_local_dsq - Move a task from a foreign rq to a lo=
cal DSQ
>   * @p: task to move
>   * @enq_flags: %SCX_ENQ_*
>   * @src_rq: rq to move the task from, locked on entry, released on return
> @@ -2127,8 +2134,8 @@ static void consume_local_task(struct task_struct *=
p,
>   *
>   * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
>   */
> -static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> -				   struct rq *src_rq, struct rq *dst_rq)
> +static void move_remote_task_to_local_dsq(struct task_struct *p, u64 enq=
_flags,
> +					  struct rq *src_rq, struct rq *dst_rq)
>  {
>  	lockdep_assert_rq_held(src_rq);
> =20
> @@ -2251,7 +2258,7 @@ static bool consume_remote_task(struct rq *this_rq,=
 struct task_struct *p,
>  	raw_spin_rq_unlock(this_rq);
> =20
>  	if (unlink_dsq_and_lock_task_rq(p, dsq, task_rq)) {
> -		move_task_to_local_dsq(p, 0, task_rq, this_rq);
> +		move_remote_task_to_local_dsq(p, 0, task_rq, this_rq);
>  		return true;
>  	} else {
>  		raw_spin_rq_unlock(task_rq);
> @@ -2282,7 +2289,9 @@ static bool consume_dispatch_q(struct rq *rq, struc=
t scx_dispatch_q *dsq)
>  		struct rq *task_rq =3D task_rq(p);
> =20
>  		if (rq =3D=3D task_rq) {
> -			consume_local_task(p, dsq, rq);
> +			task_unlink_from_dsq(p, dsq);
> +			move_local_task_to_local_dsq(p, 0, dsq, rq);
> +			raw_spin_unlock(&dsq->lock);
>  			return true;
>  		}
> =20
> @@ -2362,13 +2371,14 @@ static void dispatch_to_local_dsq(struct rq *rq, =
struct scx_dispatch_q *dst_dsq,
>  		/*
>  		 * If @p is staying on the same rq, there's no need to go
>  		 * through the full deactivate/activate cycle. Optimize by
> -		 * abbreviating the operations in move_task_to_local_dsq().
> +		 * abbreviating move_remote_task_to_local_dsq().
>  		 */
>  		if (src_rq =3D=3D dst_rq) {
>  			p->scx.holding_cpu =3D -1;
>  			dispatch_enqueue(&dst_rq->scx.local_dsq, p, enq_flags);
>  		} else {
> -			move_task_to_local_dsq(p, enq_flags, src_rq, dst_rq);
> +			move_remote_task_to_local_dsq(p, enq_flags,
> +						      src_rq, dst_rq);
>  		}
> =20
>  		/* if the destination CPU is idle, wake it up */
> --=20
> 2.46.0
>=20

--CfTem88Kzab91uKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtPJqQAKCRBZ5LhpZcTz
ZMFdAP9QYntEEMQDNdolbGOv5hp4T5TNe17r8cOHaBnSCO52xwD/eJ04w1E2BUCI
MAbEpn/Ki//oDuQ8NGSB8YKVXUyO0Aw=
=tH2r
-----END PGP SIGNATURE-----

--CfTem88Kzab91uKz--

