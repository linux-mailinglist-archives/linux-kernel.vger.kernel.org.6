Return-Path: <linux-kernel+bounces-309683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DD9966F2E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0828283C10
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 04:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CD061FDA;
	Sat, 31 Aug 2024 04:05:22 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F8129A5
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 04:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725077122; cv=none; b=Q8h1CvI6cLG0uqwFW6/d45MbbTncjshJ3BhS+WJ5rXrTc+OkDqyGEXD/ul9kpHEIASkar6ya2sEY62AgCgnVJ5PcLnjw6KDkyis8sa1s7u9dfiW0GEFHZvuP1Ll2JzdwSgrEJH7gL8ORnhROdLXbkSYbiWA7sxn50Zsmmtccs0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725077122; c=relaxed/simple;
	bh=22yaXCgmZaEXkS/5GcxaE8zRlFRkawNLXPTdvbbw+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCU2f1YtxlY579rcEPhQnT6KgnCQXogPH0/rrzsKGwXwG1uUntrpQMJQHW2K3fw89aobPeuww/8T49xnxuDaDXJ4wjGQwrnusJ2DlH160peu5gy6NWZ3/jH5FHxz2Dq2C9/atbEUlp0Umu5vNGtjJHWyQMjNLo/j6wxsHKq5+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a8125458e4so83218985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 21:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725077119; x=1725681919;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qq2hKG2sMe5GCMpSJ20hzANZPrGnu4QldbXA8iUTzJs=;
        b=HnFwuGgHggUrV4P3/6Xi06N05h28dFj5gxyeXWj69ZThpMfjeuhGDrxUYV/t2agQoP
         F46mQGeym6lxLHQSMvM0YcNr7jpViPKsVJziA8uHYSlNRXyUn7bOzTv3l2US7qTtDsDc
         vkDe3UufWpUvxNbHMe2GHkXyoxtdzVnw9mBeM3vaafN4K2c1yWSdDFok2PAoM8wi61cw
         I/ZLmcHiISNEn7vEHYWwipbplbono7ICnzg5kjSfLi18Haro74weEkBxMqOabmGefWD/
         6Mb+3X6JSgAheugDeSsHK9q1WG8kcdph1sRxDTginLDAae+GKYYhopcBpyXiaaRmWKuc
         YeIA==
X-Forwarded-Encrypted: i=1; AJvYcCVGDpW9EZxNUL27QFR6w39NNP19xB16AZmDlYRWJjh9WhT3ZUAmHQmDaiNjm5WTJQVlgh7wtR3WI3UNm98=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR/Yn3A9e2MemscVhOQSyqJ+9QRbumkakPgv1oalAtv9xpBQ6u
	KacAueJY0S8KaXvBsI1uWi0a2ijm7OL+ey7gUd8m8pvJmOxVqJuFBLfVVNu7
X-Google-Smtp-Source: AGHT+IEG6LAFuHF1foKRVCQxeanW0xfo7o7Rl6iUorLB+6h3xOH35tMN0A4doryDmR4RnhsLRS5zYQ==
X-Received: by 2002:a05:620a:2494:b0:79f:670:7635 with SMTP id af79cd13be357-7a902f6ad25mr125141085a.62.1725077118943;
        Fri, 30 Aug 2024 21:05:18 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bf6d7asm209834685a.13.2024.08.30.21.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 21:05:18 -0700 (PDT)
Date: Fri, 30 Aug 2024 23:05:16 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched_ext: Refactor consume_remote_task()
Message-ID: <20240831040516.GA70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Rpve2RAyStyK6OK"
Content-Disposition: inline
In-Reply-To: <20240830110415.116090-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--4Rpve2RAyStyK6OK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 01:03:46AM -1000, Tejun Heo wrote:
> The tricky p->scx.holding_cpu handling was split across
> consume_remote_task() body and move_task_to_local_dsq(). Refactor such th=
at:
>=20
> - All the tricky part is now in the new unlink_dsq_and_lock_task_rq() with
>   consolidated documentation.
>=20
> - move_task_to_local_dsq() now implements straightforward task migration
>   making it easier to use in other places.
>=20
> - dispatch_to_local_dsq() is another user move_task_to_local_dsq(). The
>   usage is updated accordingly. This makes the local and remote cases more
>   symmetric.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext.c | 145 ++++++++++++++++++++++++---------------------
>  1 file changed, 76 insertions(+), 69 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 5423554a11af..3facfca73337 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2109,49 +2109,13 @@ static bool yield_to_task_scx(struct rq *rq, stru=
ct task_struct *to)
>   * @src_rq: rq to move the task from, locked on entry, released on return
>   * @dst_rq: rq to move the task into, locked on return
>   *
> - * Move @p which is currently on @src_rq to @dst_rq's local DSQ. The cal=
ler
> - * must:
> - *
> - * 1. Start with exclusive access to @p either through its DSQ lock or
> - *    %SCX_OPSS_DISPATCHING flag.
> - *
> - * 2. Set @p->scx.holding_cpu to raw_smp_processor_id().
> - *
> - * 3. Remember task_rq(@p) as @src_rq. Release the exclusive access so t=
hat we
> - *    don't deadlock with dequeue.
> - *
> - * 4. Lock @src_rq from #3.
> - *
> - * 5. Call this function.
> - *
> - * Returns %true if @p was successfully moved. %false after racing deque=
ue and
> - * losing. On return, @src_rq is unlocked and @dst_rq is locked.
> + * Move @p which is currently on @src_rq to @dst_rq's local DSQ.
>   */
> -static bool move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
> +static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
>  				   struct rq *src_rq, struct rq *dst_rq)
>  {
>  	lockdep_assert_rq_held(src_rq);
> =20
> -	/*
> -	 * If dequeue got to @p while we were trying to lock @src_rq, it'd have
> -	 * cleared @p->scx.holding_cpu to -1. While other cpus may have updated
> -	 * it to different values afterwards, as this operation can't be
> -	 * preempted or recurse, @p->scx.holding_cpu can never become
> -	 * raw_smp_processor_id() again before we're done. Thus, we can tell
> -	 * whether we lost to dequeue by testing whether @p->scx.holding_cpu is
> -	 * still raw_smp_processor_id().
> -	 *
> -	 * @p->rq couldn't have changed if we're still the holding cpu.
> -	 *
> -	 * See dispatch_dequeue() for the counterpart.
> -	 */
> -	if (unlikely(p->scx.holding_cpu !=3D raw_smp_processor_id()) ||
> -	    WARN_ON_ONCE(src_rq !=3D task_rq(p))) {
> -		raw_spin_rq_unlock(src_rq);
> -		raw_spin_rq_lock(dst_rq);
> -		return false;
> -	}
> -
>  	/* the following marks @p MIGRATING which excludes dequeue */
>  	deactivate_task(src_rq, p, 0);

Not a functional change from the prior patch, but it occurred to me that
if we just deactivate like this then we'll also fire the ops.quiescent()
callback in dequeue_task_scx(). Should we add a check to skip the
dequeue callbacks if p->scx.holding_cpu >=3D 0?

Cleanup looks great otherwise.

Thanks,
David

>  	set_task_cpu(p, cpu_of(dst_rq));
> @@ -2170,8 +2134,6 @@ static bool move_task_to_local_dsq(struct task_stru=
ct *p, u64 enq_flags,
>  	dst_rq->scx.extra_enq_flags =3D enq_flags;
>  	activate_task(dst_rq, p, 0);
>  	dst_rq->scx.extra_enq_flags =3D 0;
> -
> -	return true;
>  }
> =20
>  #endif	/* CONFIG_SMP */
> @@ -2236,28 +2198,69 @@ static bool task_can_run_on_remote_rq(struct task=
_struct *p, struct rq *rq,
>  	return true;
>  }
> =20
> -static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *ds=
q,
> -				struct task_struct *p, struct rq *task_rq)
> +/**
> + * unlink_dsq_and_lock_task_rq() - Unlink task from its DSQ and lock its=
 task_rq
> + * @p: target task
> + * @dsq: locked DSQ @p is currently on
> + * @task_rq: @p's task_rq, stable with @dsq locked
> + *
> + * Called with @dsq locked but no rq's locked. We want to move @p to a d=
ifferent
> + * DSQ, including any local DSQ, but are not locking @task_rq. Locking @=
task_rq
> + * is required when transferring into a local DSQ. Even when transferrin=
g into a
> + * non-local DSQ, it's better to use the same mechanism to protect again=
st
> + * dequeues and maintain the invariant that @p->scx.dsq can only change =
while
> + * @task_rq is locked, which e.g. scx_dump_task() depends on.
> + *
> + * We want to grab @task_rq but that can deadlock if we try while lockin=
g @dsq,
> + * so we want to unlink @p from @dsq, drop its lock and then lock @task_=
rq. As
> + * this may race with dequeue, which can't drop the rq lock or fail, do =
a little
> + * dancing from our side.
> + *
> + * @p->scx.holding_cpu is set to this CPU before @dsq is unlocked. If @p=
 gets
> + * dequeued after we unlock @dsq but before locking @task_rq, the holdin=
g_cpu
> + * would be cleared to -1. While other cpus may have updated it to diffe=
rent
> + * values afterwards, as this operation can't be preempted or recurse, t=
he
> + * holding_cpu can never become this CPU again before we're done. Thus, =
we can
> + * tell whether we lost to dequeue by testing whether the holding_cpu st=
ill
> + * points to this CPU. See dispatch_dequeue() for the counterpart.
> + *
> + * On return, @dsq is unlocked and @task_rq is locked. Returns %true if =
@p is
> + * still valid. %false if lost to dequeue.
> + */
> +static bool unlink_dsq_and_lock_task_rq(struct task_struct *p,
> +					struct scx_dispatch_q *dsq,
> +					struct rq *task_rq)
>  {
> -	lockdep_assert_held(&dsq->lock);	/* released on return */
> +	s32 cpu =3D raw_smp_processor_id();
> +
> +	lockdep_assert_held(&dsq->lock);
> =20
> -	/*
> -	 * @dsq is locked and @p is on a remote rq. @p is currently protected by
> -	 * @dsq->lock. We want to pull @p to @rq but may deadlock if we grab
> -	 * @task_rq while holding @dsq and @rq locks. As dequeue can't drop the
> -	 * rq lock or fail, do a little dancing from our side. See
> -	 * move_task_to_local_dsq().
> -	 */
>  	WARN_ON_ONCE(p->scx.holding_cpu >=3D 0);
>  	task_unlink_from_dsq(p, dsq);
>  	dsq_mod_nr(dsq, -1);
> -	p->scx.holding_cpu =3D raw_smp_processor_id();
> -	raw_spin_unlock(&dsq->lock);
> +	p->scx.holding_cpu =3D cpu;
> =20
> -	raw_spin_rq_unlock(rq);
> +	raw_spin_unlock(&dsq->lock);
>  	raw_spin_rq_lock(task_rq);
> =20
> -	return move_task_to_local_dsq(p, 0, task_rq, rq);
> +	/* task_rq couldn't have changed if we're still the holding cpu */
> +	return likely(p->scx.holding_cpu =3D=3D cpu) &&
> +		!WARN_ON_ONCE(task_rq !=3D task_rq(p));
> +}
> +
> +static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_=
q *dsq,
> +				struct task_struct *p, struct rq *task_rq)
> +{
> +	raw_spin_rq_unlock(this_rq);
> +
> +	if (unlink_dsq_and_lock_task_rq(p, dsq, task_rq)) {
> +		move_task_to_local_dsq(p, 0, task_rq, this_rq);
> +		return true;
> +	} else {
> +		raw_spin_rq_unlock(task_rq);
> +		raw_spin_rq_lock(this_rq);
> +		return false;
> +	}
>  }
>  #else	/* CONFIG_SMP */
>  static inline bool task_can_run_on_remote_rq(struct task_struct *p, stru=
ct rq *rq, bool trigger_error) { return false; }
> @@ -2361,7 +2364,8 @@ dispatch_to_local_dsq(struct rq *rq, u64 dsq_id, st=
ruct task_struct *p,
>  		 * As DISPATCHING guarantees that @p is wholly ours, we can
>  		 * pretend that we're moving from a DSQ and use the same
>  		 * mechanism - mark the task under transfer with holding_cpu,
> -		 * release DISPATCHING and then follow the same protocol.
> +		 * release DISPATCHING and then follow the same protocol. See
> +		 * unlink_dsq_and_lock_task_rq().
>  		 */
>  		p->scx.holding_cpu =3D raw_smp_processor_id();
> =20
> @@ -2374,28 +2378,31 @@ dispatch_to_local_dsq(struct rq *rq, u64 dsq_id, =
struct task_struct *p,
>  			raw_spin_rq_lock(src_rq);
>  		}
> =20
> -		if (src_rq =3D=3D dst_rq) {
> +		/* task_rq couldn't have changed if we're still the holding cpu */
> +		dsp =3D p->scx.holding_cpu =3D=3D raw_smp_processor_id() &&
> +			!WARN_ON_ONCE(src_rq !=3D task_rq(p));
> +
> +		if (likely(dsp)) {
>  			/*
> -			 * As @p is staying on the same rq, there's no need to
> +			 * If @p is staying on the same rq, there's no need to
>  			 * go through the full deactivate/activate cycle.
>  			 * Optimize by abbreviating the operations in
>  			 * move_task_to_local_dsq().
>  			 */
> -			dsp =3D p->scx.holding_cpu =3D=3D raw_smp_processor_id();
> -			if (likely(dsp)) {
> +			if (src_rq =3D=3D dst_rq) {
>  				p->scx.holding_cpu =3D -1;
> -				dispatch_enqueue(&dst_rq->scx.local_dsq, p,
> -						 enq_flags);
> +				dispatch_enqueue(&dst_rq->scx.local_dsq,
> +						 p, enq_flags);
> +			} else {
> +				move_task_to_local_dsq(p, enq_flags,
> +						       src_rq, dst_rq);
>  			}
> -		} else {
> -			dsp =3D move_task_to_local_dsq(p, enq_flags,
> -						     src_rq, dst_rq);
> -		}
> =20
> -		/* if the destination CPU is idle, wake it up */
> -		if (dsp && sched_class_above(p->sched_class,
> -					     dst_rq->curr->sched_class))
> -			resched_curr(dst_rq);
> +			/* if the destination CPU is idle, wake it up */
> +			if (sched_class_above(p->sched_class,
> +					      dst_rq->curr->sched_class))
> +				resched_curr(dst_rq);
> +		}
> =20
>  		/* switch back to @rq lock */
>  		if (rq !=3D dst_rq) {
> --=20
> 2.46.0
>=20

--4Rpve2RAyStyK6OK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtKWfAAKCRBZ5LhpZcTz
ZHsXAQDyXEGoahbxVWKhKeWPucWq9gCghmNM0ywGpZvkZgkVWAD/TW0mUDkgouRs
VImOhjrzDYSLIoD+8Ryshd3EG6u6ZAU=
=+82y
-----END PGP SIGNATURE-----

--4Rpve2RAyStyK6OK--

