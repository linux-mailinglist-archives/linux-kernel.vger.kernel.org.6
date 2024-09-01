Return-Path: <linux-kernel+bounces-310046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D415A967412
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 02:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19970B21D8C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 00:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB341E498;
	Sun,  1 Sep 2024 00:53:43 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1439F2FB6
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 00:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152023; cv=none; b=hCb03aM2HHaA3Mj/wepMKOnWNwT8fE9WFw0ry0WE3D2rEVGHLjs9AmlDMCNjnacVvsD3B/YsHpDMj4cIhLvXwxiff7/DBlte8TbCWizau0AV6SEnKOvQwpC8wrgyOOrFnYv+U4GPmS20UzK8TNwfFyxpWCv7QuvoPLkRcxY5VCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152023; c=relaxed/simple;
	bh=2FO5QbJhVrMuyeijLqPF7mMH7Ha/FbUWyqHilI2flXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9rEfXqbkyz89qZvW5zfO29+1MbOprrtwTxHwSZI68d5jE9BNMzwlX5Wf39DziAgn21MLxeBLReCHBvpb4pM3+5FCRVwLXb6fmnhYIw+yajE1Ixh7LETJ/Sy9haX65Xk7KEy5jZpwbuv/PVf/2w5e7spt8DstWakYRkCvrBAvfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-457ce5fda1aso1568851cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 17:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725152020; x=1725756820;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FobKAKFmslML2dJUyjp7kcIPl+DGKrNTEwLrd7qoM2k=;
        b=c1DkBY5jCICI2dzPPNkNZD5SYj7Dzs6innLfLk6zeH638+4+UcGwGj7P2sqfUUHJQv
         gmxGSMhE+wQQavXfudjhA2zqK9mY5xc0MOfhtLnPl7FZPQzz2DiFLpu7kq82AvWScvSy
         cIcuVy30N4xew8szKyghk+0+8bh9ajnnQW7TnC8OGoHM2q/UwUQp2BXF/nXwN6zovNYJ
         X5LDP2Hc8PQV2KOHJDyFHfahs4xr5SZgkacc0GzFb+ccKLel27aO5ph4imWnrwUTeZ5t
         H7EZhjRa1tkpYMjK+upt+apMtSK2ZJrTRbUBD+qYSgcwCnCtt58UkvTUWXP/qbFsPq7Q
         rpJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmBoB+8tmHdhs+qeUrsw/zyjm+PMnSWw2OZRQtYcmyMSlth3uezWX/j7WEa00OKNzeMOQO7sLigIp1JxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYCPJMqeCn15VybCB06Dkqs3UC13PEZx6HNcANwp/JWcQaVbxZ
	EDLlwE2YOq3MlZfSE9n87NvVRCSIMSLoLByzdP/jK+evsS1m7Sr7
X-Google-Smtp-Source: AGHT+IFEt9Q0vrOQ7jl22k6fP3Au9zpoibQNvk1ohyc56YenJWopLUJKk3TEAw1yvVL+NEFbWH4xuA==
X-Received: by 2002:a05:622a:4d4a:b0:456:6214:eaac with SMTP id d75a77b69052e-4574e824859mr36168991cf.19.1725152019785;
        Sat, 31 Aug 2024 17:53:39 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682cb02d5sm27549391cf.40.2024.08.31.17.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 17:53:39 -0700 (PDT)
Date: Sat, 31 Aug 2024 19:53:37 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] sched_ext: Fix processs_ddsp_deferred_locals() by
 unifying DTL_INVALID handling
Message-ID: <20240901005337.GD70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-5-tj@kernel.org>
 <ZtIFDmWxIO0nXCZA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6FqNqwAGIawetmjp"
Content-Disposition: inline
In-Reply-To: <ZtIFDmWxIO0nXCZA@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--6FqNqwAGIawetmjp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 07:44:46AM -1000, Tejun Heo wrote:
> With the preceding update, the only return value which makes meaningful
> difference is DTL_INVALID, for which one caller, finish_dispatch(), falls
> back to the global DSQ and the other, process_ddsp_deferred_locals(),
> doesn't do anything.
>=20
> It should always fallback to the global DSQ. Move the global DSQ fallback
> into dispatch_to_local_dsq() and remove the return value.
>=20
> v2: Patch title and description updated to reflect the behavior fix for
>     process_ddsp_deferred_locals().
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>

Acked-by: David Vernet <void@manifault.com>

FYI, I was able to trigger what I think is a benign pr_warn() by testing
the failure path for DSQ_LOCAL_ON in the direct dispatch path. If I
write a testcase that dispatches an instance of a ksoftirqd task to a
CPU that it's not allowed to run on, I get the following:

[   14.799935] sched_ext: BPF scheduler "ddsp_local_on_invalid" enabled
[   14.813738] NOHZ tick-stop error: local softirq work is pending, handler=
 #200!!!
[   14.829536] sched_ext: BPF scheduler "ddsp_local_on_invalid" disabled (r=
untime error)
[   14.829613] sched_ext: ddsp_local_on_invalid: SCX_DSQ_LOCAL[_ON] verdict=
 target cpu 1 not allowed for kworker/0:2[113]
[   14.829707]    dispatch_to_local_dsq+0x13b/0x1e0
[   14.829760]    run_deferred+0x9d/0xe0
[   14.829797]    ttwu_do_activate+0x10a/0x250
[   14.829834]    try_to_wake_up+0x28c/0x530
[   14.829882]    kick_pool+0xd6/0x160
[   14.829923]    __queue_work+0x3f7/0x530
[   14.829962]    call_timer_fn+0xcf/0x2a0
[   14.830001]    __run_timer_base+0x227/0x250
[   14.830039]    run_timer_softirq+0x45/0x60
[   14.830078]    handle_softirqs+0x120/0x400
[   14.830121]    __irq_exit_rcu+0x67/0xd0
[   14.830157]    irq_exit_rcu+0xe/0x20
[   14.830188]    sysvec_apic_timer_interrupt+0x76/0x90
[   14.830218]    asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   14.830254]    default_idle+0x13/0x20
[   14.830282]    default_idle_call+0x74/0xb0
[   14.830306]    do_idle+0xef/0x280
[   14.830335]    cpu_startup_entry+0x2a/0x30
[   14.830363]    __pfx_kernel_init+0x0/0x10
[   14.830386]    start_kernel+0x37c/0x3d0
[   14.830414]    x86_64_start_reservations+0x24/0x30
[   14.830445]    x86_64_start_kernel+0xb1/0xc0
[   14.830480]    common_startup_64+0x13e/0x147

This is from report_idle_softirq() in time/tick-sched.c, which has a
baked-in assumption that if there's a pending softirq and we're not in
an IRQ, then ksoftirqd must have been scheduled and we should therefore
expect to see a need_resched() on the current core if we're on the
can_stop_idle_tick() path.

I think this is safe because we're going to be reverting back to fair.c
at this point anyways, but we should figure out how to avoid confusing
the idle tick path regardless.

Thanks,
David

> ---
>  kernel/sched/ext.c |   41 ++++++++++-------------------------------
>  1 file changed, 10 insertions(+), 31 deletions(-)
>=20
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -2301,12 +2301,6 @@ retry:
>  	return false;
>  }
> =20
> -enum dispatch_to_local_dsq_ret {
> -	DTL_DISPATCHED,		/* successfully dispatched */
> -	DTL_LOST,		/* lost race to dequeue */
> -	DTL_INVALID,		/* invalid local dsq_id */
> -};
> -
>  /**
>   * dispatch_to_local_dsq - Dispatch a task to a local dsq
>   * @rq: current rq which is locked
> @@ -2321,9 +2315,8 @@ enum dispatch_to_local_dsq_ret {
>   * The caller must have exclusive ownership of @p (e.g. through
>   * %SCX_OPSS_DISPATCHING).
>   */
> -static enum dispatch_to_local_dsq_ret
> -dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
> -		      struct task_struct *p, u64 enq_flags)
> +static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *=
dst_dsq,
> +				  struct task_struct *p, u64 enq_flags)
>  {
>  	struct rq *src_rq =3D task_rq(p);
>  	struct rq *dst_rq =3D container_of(dst_dsq, struct rq, scx.local_dsq);
> @@ -2336,13 +2329,11 @@ dispatch_to_local_dsq(struct rq *rq, str
>  	 */
>  	if (rq =3D=3D src_rq && rq =3D=3D dst_rq) {
>  		dispatch_enqueue(dst_dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> -		return DTL_DISPATCHED;
> +		return;
>  	}
> =20
>  #ifdef CONFIG_SMP
>  	if (likely(task_can_run_on_remote_rq(p, dst_rq, true))) {
> -		bool dsp;
> -
>  		/*
>  		 * @p is on a possibly remote @src_rq which we need to lock to
>  		 * move the task. If dequeue is in progress, it'd be locking
> @@ -2367,10 +2358,8 @@ dispatch_to_local_dsq(struct rq *rq, str
>  		}
> =20
>  		/* task_rq couldn't have changed if we're still the holding cpu */
> -		dsp =3D p->scx.holding_cpu =3D=3D raw_smp_processor_id() &&
> -			!WARN_ON_ONCE(src_rq !=3D task_rq(p));
> -
> -		if (likely(dsp)) {
> +		if (likely(p->scx.holding_cpu =3D=3D raw_smp_processor_id()) &&
> +		    !WARN_ON_ONCE(src_rq !=3D task_rq(p))) {
>  			/*
>  			 * If @p is staying on the same rq, there's no need to
>  			 * go through the full deactivate/activate cycle.
> @@ -2398,11 +2387,11 @@ dispatch_to_local_dsq(struct rq *rq, str
>  			raw_spin_rq_lock(rq);
>  		}
> =20
> -		return dsp ? DTL_DISPATCHED : DTL_LOST;
> +		return;
>  	}
>  #endif	/* CONFIG_SMP */
> =20
> -	return DTL_INVALID;
> +	dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
>  }
> =20
>  /**
> @@ -2479,20 +2468,10 @@ retry:
> =20
>  	dsq =3D find_dsq_for_dispatch(this_rq(), dsq_id, p);
> =20
> -	if (dsq->id =3D=3D SCX_DSQ_LOCAL) {
> -		switch (dispatch_to_local_dsq(rq, dsq, p, enq_flags)) {
> -		case DTL_DISPATCHED:
> -			break;
> -		case DTL_LOST:
> -			break;
> -		case DTL_INVALID:
> -			dispatch_enqueue(&scx_dsq_global, p,
> -					 enq_flags | SCX_ENQ_CLEAR_OPSS);
> -			break;
> -		}
> -	} else {
> +	if (dsq->id =3D=3D SCX_DSQ_LOCAL)
> +		dispatch_to_local_dsq(rq, dsq, p, enq_flags);
> +	else
>  		dispatch_enqueue(dsq, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
> -	}
>  }
> =20
>  static void flush_dispatch_buf(struct rq *rq)

--6FqNqwAGIawetmjp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtO7EQAKCRBZ5LhpZcTz
ZGFtAQCNeWIHc/FFgJWnoB8G1XVg5O8iULBxZ/vFUTNbN186agEArbcnvqWT9pZP
6v0IpGTQFCT8tR7DfyUfJUdWxBiT7wI=
=7KZs
-----END PGP SIGNATURE-----

--6FqNqwAGIawetmjp--

