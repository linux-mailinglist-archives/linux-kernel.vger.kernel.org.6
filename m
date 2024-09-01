Return-Path: <linux-kernel+bounces-310047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A68596741D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 02:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED611C20AAE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 00:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232FD1E53A;
	Sun,  1 Sep 2024 00:56:46 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB655524F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152205; cv=none; b=hg7Zr5m4lMUWaze+m8WQ6sbu3BEoL5rLOr2aost0yqrC29WXl+q0Sbai0IXTffJip9fTSQvqDi+A3xOt+8UEd5vZCGmQMeMrXp4THo5+wdOw30PouOfXX8uqkF6zZPqMfMQlwa7u+8zvDYByLt6jAjsPoOsCgD8uG6sCR6/mKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152205; c=relaxed/simple;
	bh=s/u0qPfPPLs615rNM82yXQsocP98ybL2TjYu+lFQiWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggp4L18AeKRIr8/TccRvNMUD06I+1nQmjh3WKvLB9QIwfEOqY9GLODCXwPgQoxRLQW/grfC/NY/mrouEDwmcMxp2vWL49M8iKIQBJRzV0cR18ncn0my6zasaGigNdL2UXwn7wJwLrmTWVAurNBnhKMmsRqMl5CXSdxFj9i9RYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a819488e3so1773862276.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725152203; x=1725757003;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CTu24o2VbJTyc79NbajsAeH1u1loatrBqFS1PWQH3mQ=;
        b=WQjAky9e8vvPE+0zVoj2mUFG0PQaRV7GI0OmR1mvD6/7bQaF0CT5yXALY6kP1INwWc
         VZRFwCjn1gEpBAQRCD789wVSP4yVWn6GsIvjBNt2q5m/ebgLhf+62mxfJBi1HK75PyD3
         XitHmfFn89KcrnIDCQyQjLUVviIhbHqeFfYhQ6xUcm09CGlhv6AXH/A+d71EkLVCr9N7
         +PlWmDM5eSCBGITWlWuAc0YmyAWYiafFADvkNOWAny/KHoiZz8PUo6HY8Y5OLSKc/oq+
         Ds0bIPUKm55rt3F4JobzTt1wmSorsFgHxqIRam+2zrR+sT6MmwF1OFIC5W2xpfttSRO4
         52QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6xbKHzXBHDWXcwfRSBrZOeqAAwTtdbjDXcr+qehxn8ojTxRP2xVihnVHzw34LFi1QJT9gRuWsz5NLHFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz80pwYthIBdGkY/IgeCxYbaaoaC3qjGtUFkvHeY2X+wWFB1LRV
	E6XWQn/TX5iCc6TaHgvj0T46Uvx6ahpF6+y38ddTGK3CipKx5kht
X-Google-Smtp-Source: AGHT+IFP+DoL3AeOcAWfE4qPUAu3g51ySZdKCQgHI/vnH0+5Xj0YMOtPwb9IM/D5bJCj7q2SZ6e1pA==
X-Received: by 2002:a05:6902:11cc:b0:e13:d399:38cc with SMTP id 3f1490d57ef6-e1a7a1a4dc8mr6422345276.45.1725152202650;
        Sat, 31 Aug 2024 17:56:42 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c353173c45sm16022476d6.92.2024.08.31.17.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 17:56:41 -0700 (PDT)
Date: Sat, 31 Aug 2024 19:56:39 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] sched_ext: Fix processs_ddsp_deferred_locals() by
 unifying DTL_INVALID handling
Message-ID: <20240901005639.GE70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-5-tj@kernel.org>
 <ZtIFDmWxIO0nXCZA@slm.duckdns.org>
 <20240901005337.GD70166@maniforge>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7wRI6iYr6UQHx4kY"
Content-Disposition: inline
In-Reply-To: <20240901005337.GD70166@maniforge>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--7wRI6iYr6UQHx4kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024 at 07:53:37PM -0500, David Vernet wrote:
> On Fri, Aug 30, 2024 at 07:44:46AM -1000, Tejun Heo wrote:
> > With the preceding update, the only return value which makes meaningful
> > difference is DTL_INVALID, for which one caller, finish_dispatch(), fal=
ls
> > back to the global DSQ and the other, process_ddsp_deferred_locals(),
> > doesn't do anything.
> >=20
> > It should always fallback to the global DSQ. Move the global DSQ fallba=
ck
> > into dispatch_to_local_dsq() and remove the return value.
> >=20
> > v2: Patch title and description updated to reflect the behavior fix for
> >     process_ddsp_deferred_locals().
> >=20
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Cc: David Vernet <void@manifault.com>
>=20
> Acked-by: David Vernet <void@manifault.com>
>=20
> FYI, I was able to trigger what I think is a benign pr_warn() by testing
> the failure path for DSQ_LOCAL_ON in the direct dispatch path. If I
> write a testcase that dispatches an instance of a ksoftirqd task to a

Sorry, should have been more clear: the testcase dispatched all tasks to
the wrong CPU, which is why it's a kworker in the print output below. I
believe that ksoftiqrd hit the same path as well and just wasn't printed
in the output because it lost the race to scx_bpf_error(). Let me know
if you want the testcase to repro and I can send it, or send a separate
patch to add it to selftests.

Thanks,
David

> CPU that it's not allowed to run on, I get the following:
>=20
> [   14.799935] sched_ext: BPF scheduler "ddsp_local_on_invalid" enabled
> [   14.813738] NOHZ tick-stop error: local softirq work is pending, handl=
er #200!!!
> [   14.829536] sched_ext: BPF scheduler "ddsp_local_on_invalid" disabled =
(runtime error)
> [   14.829613] sched_ext: ddsp_local_on_invalid: SCX_DSQ_LOCAL[_ON] verdi=
ct target cpu 1 not allowed for kworker/0:2[113]
> [   14.829707]    dispatch_to_local_dsq+0x13b/0x1e0
> [   14.829760]    run_deferred+0x9d/0xe0
> [   14.829797]    ttwu_do_activate+0x10a/0x250
> [   14.829834]    try_to_wake_up+0x28c/0x530
> [   14.829882]    kick_pool+0xd6/0x160
> [   14.829923]    __queue_work+0x3f7/0x530
> [   14.829962]    call_timer_fn+0xcf/0x2a0
> [   14.830001]    __run_timer_base+0x227/0x250
> [   14.830039]    run_timer_softirq+0x45/0x60
> [   14.830078]    handle_softirqs+0x120/0x400
> [   14.830121]    __irq_exit_rcu+0x67/0xd0
> [   14.830157]    irq_exit_rcu+0xe/0x20
> [   14.830188]    sysvec_apic_timer_interrupt+0x76/0x90
> [   14.830218]    asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [   14.830254]    default_idle+0x13/0x20
> [   14.830282]    default_idle_call+0x74/0xb0
> [   14.830306]    do_idle+0xef/0x280
> [   14.830335]    cpu_startup_entry+0x2a/0x30
> [   14.830363]    __pfx_kernel_init+0x0/0x10
> [   14.830386]    start_kernel+0x37c/0x3d0
> [   14.830414]    x86_64_start_reservations+0x24/0x30
> [   14.830445]    x86_64_start_kernel+0xb1/0xc0
> [   14.830480]    common_startup_64+0x13e/0x147
>=20
> This is from report_idle_softirq() in time/tick-sched.c, which has a
> baked-in assumption that if there's a pending softirq and we're not in
> an IRQ, then ksoftirqd must have been scheduled and we should therefore
> expect to see a need_resched() on the current core if we're on the
> can_stop_idle_tick() path.
>=20
> I think this is safe because we're going to be reverting back to fair.c
> at this point anyways, but we should figure out how to avoid confusing
> the idle tick path regardless.
>=20
> Thanks,
> David
>=20
> > ---
> >  kernel/sched/ext.c |   41 ++++++++++-------------------------------
> >  1 file changed, 10 insertions(+), 31 deletions(-)
> >=20
> > --- a/kernel/sched/ext.c
> > +++ b/kernel/sched/ext.c
> > @@ -2301,12 +2301,6 @@ retry:
> >  	return false;
> >  }
> > =20
> > -enum dispatch_to_local_dsq_ret {
> > -	DTL_DISPATCHED,		/* successfully dispatched */
> > -	DTL_LOST,		/* lost race to dequeue */
> > -	DTL_INVALID,		/* invalid local dsq_id */
> > -};
> > -
> >  /**
> >   * dispatch_to_local_dsq - Dispatch a task to a local dsq
> >   * @rq: current rq which is locked
> > @@ -2321,9 +2315,8 @@ enum dispatch_to_local_dsq_ret {
> >   * The caller must have exclusive ownership of @p (e.g. through
> >   * %SCX_OPSS_DISPATCHING).
> >   */
> > -static enum dispatch_to_local_dsq_ret
> > -dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
> > -		      struct task_struct *p, u64 enq_flags)
> > +static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q=
 *dst_dsq,
> > +				  struct task_struct *p, u64 enq_flags)
> >  {
> >  	struct rq *src_rq =3D task_rq(p);
> >  	struct rq *dst_rq =3D container_of(dst_dsq, struct rq, scx.local_dsq);
> > @@ -2336,13 +2329,11 @@ dispatch_to_local_dsq(struct rq *rq, str
> >  	 */
> >  	if (rq =3D=3D src_rq && rq =3D=3D dst_rq) {
> >  		dispatch_enqueue(dst_dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> > -		return DTL_DISPATCHED;
> > +		return;
> >  	}
> > =20
> >  #ifdef CONFIG_SMP
> >  	if (likely(task_can_run_on_remote_rq(p, dst_rq, true))) {
> > -		bool dsp;
> > -
> >  		/*
> >  		 * @p is on a possibly remote @src_rq which we need to lock to
> >  		 * move the task. If dequeue is in progress, it'd be locking
> > @@ -2367,10 +2358,8 @@ dispatch_to_local_dsq(struct rq *rq, str
> >  		}
> > =20
> >  		/* task_rq couldn't have changed if we're still the holding cpu */
> > -		dsp =3D p->scx.holding_cpu =3D=3D raw_smp_processor_id() &&
> > -			!WARN_ON_ONCE(src_rq !=3D task_rq(p));
> > -
> > -		if (likely(dsp)) {
> > +		if (likely(p->scx.holding_cpu =3D=3D raw_smp_processor_id()) &&
> > +		    !WARN_ON_ONCE(src_rq !=3D task_rq(p))) {
> >  			/*
> >  			 * If @p is staying on the same rq, there's no need to
> >  			 * go through the full deactivate/activate cycle.
> > @@ -2398,11 +2387,11 @@ dispatch_to_local_dsq(struct rq *rq, str
> >  			raw_spin_rq_lock(rq);
> >  		}
> > =20
> > -		return dsp ? DTL_DISPATCHED : DTL_LOST;
> > +		return;
> >  	}
> >  #endif	/* CONFIG_SMP */
> > =20
> > -	return DTL_INVALID;
> > +	dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> >  }
> > =20
> >  /**
> > @@ -2479,20 +2468,10 @@ retry:
> > =20
> >  	dsq =3D find_dsq_for_dispatch(this_rq(), dsq_id, p);
> > =20
> > -	if (dsq->id =3D=3D SCX_DSQ_LOCAL) {
> > -		switch (dispatch_to_local_dsq(rq, dsq, p, enq_flags)) {
> > -		case DTL_DISPATCHED:
> > -			break;
> > -		case DTL_LOST:
> > -			break;
> > -		case DTL_INVALID:
> > -			dispatch_enqueue(&scx_dsq_global, p,
> > -					 enq_flags | SCX_ENQ_CLEAR_OPSS);
> > -			break;
> > -		}
> > -	} else {
> > +	if (dsq->id =3D=3D SCX_DSQ_LOCAL)
> > +		dispatch_to_local_dsq(rq, dsq, p, enq_flags);
> > +	else
> >  		dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> > -	}
> >  }
> > =20
> >  static void flush_dispatch_buf(struct rq *rq)



--7wRI6iYr6UQHx4kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtO7xwAKCRBZ5LhpZcTz
ZK4IAP9o8bozlkRyox5EOKgA7oZO+hAL8l3vYBcqg4JVKVaJVgEAz6Es+u3UrF4p
K6zdlpM0eKOEKZCASYdrsMOrugVh1Qo=
=EL1n
-----END PGP SIGNATURE-----

--7wRI6iYr6UQHx4kY--

