Return-Path: <linux-kernel+bounces-248178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FA892D91F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C586FB228DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766E8198E82;
	Wed, 10 Jul 2024 19:25:29 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C1197A99
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639528; cv=none; b=rcrT4Sr6yZs7tDC4yqwIiwBTdnD4CY7Qtj5jIcDycffMlktU5O+gXfY862spW5c/cE+lLB+eLNwyt7P1ArQwNlv3alNkhdUJOuPnO5kkEfSiDlIFsuec/nKqGYPh08b/jLuYOkr9TOd9uQ3v+Wu9yJjDbQJ6swmpj1QaMTAcc+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639528; c=relaxed/simple;
	bh=PFAg6SJ57fxsi+6mjemW/CflrBjAMPdAglLPhzyQwho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HILU4mn4N5iuuRxoMPkVoc9fbzBKXyMS/sVbqyildB9n1/5ipzrJI5Ab8WZnzStVIeF+q0vBFlaoAsbxhHhgI0pR8ZD1sGIUpravZm61Uo/129m9rEqzWgd+sPp/UZoAMVLoMXMfl5Kp80GME9FmDZipDyOFC6DrpmUcPLiCyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a05c755477so7314085a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639526; x=1721244326;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCWvci8IV7OplvrFwjkVv8OMdd+Q055fqz/RR0EqFqY=;
        b=qUMwJdrXXG1Q+hq3ofymjnZtJItdOJMOAGEveVj564En2ilW5ieT64lUUn8KNJW08/
         Ua+g9b4wrEW6A9UNwZ2MPVDyVGWVnP4kWiurOA55dHbojndAWA/4csw8v+v9aLuC3V3u
         p48N1xZ/qoJYRi/mSjKKh5o6xxSjMP/yuAFJbN5QFIhskyrxticZ3fasPNMJAyJq1o5E
         f9VSeGWbgPy9bWsWjzIqPbtJ/5ViiSOWHU/aIp1Ak4EQtRaeM549mIjujbiBfWifWYtu
         9a7OmmejHj6CeGjcDuZ1w7pRmwa11Wl2uwy4VvHZ/jipq7SnTho41IFgJBRfsaQXvFzR
         VZSg==
X-Gm-Message-State: AOJu0Yxprf7vgKV08ZWdeDZIJnCEX5OMVlPnP4U7GCf4t79MWOtOP7Ra
	h78UIt70mxDbhzbj2jX2nIJD5RwyABL+xqPgmdQYkzlsH7K4kibK
X-Google-Smtp-Source: AGHT+IGmhmNQ/FeU8tw/Jox9AR6KZdZPMbaL/ahz0VVaqtHAu4z4bTxtMzhzuQYQymKIuzlwHmnxRA==
X-Received: by 2002:a37:c40a:0:b0:79f:a82:51aa with SMTP id af79cd13be357-79f19ae5133mr741913785a.59.1720639526081;
        Wed, 10 Jul 2024 12:25:26 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1908adc7sm221554985a.72.2024.07.10.12.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 12:25:25 -0700 (PDT)
Date: Wed, 10 Jul 2024 14:25:23 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, righi.andrea@gmail.com
Subject: Re: [PATCH 6/6] sched_ext/scx_qmap: Pick idle CPU for direct
 dispatch on !wakeup enqueues
Message-ID: <20240710192523.GF317151@maniforge>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MdD7hTEMKDb7BSGH"
Content-Disposition: inline
In-Reply-To: <20240709212137.1199269-7-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--MdD7hTEMKDb7BSGH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:21:12AM -1000, Tejun Heo wrote:
> Because there was no way to directly dispatch to the local DSQ of a remote
> CPU from ops.enqueue(), scx_qmap skipped looking for an idle CPU on !wake=
up
> enqueues. This restriction was removed and schbed_ext now allows

s/schbed_ext/sched_ext

> SCX_DSQ_LOCAL_ON verdicts for direct dispatches.
>=20
> Factor out pick_direct_dispatch_cpu() from ops.select_cpu() and use it to
> direct dispatch from ops.enqueue() on !wakeup enqueues.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: David Vernet <void@manifault.com>
> Cc: Dan Schatzberg <schatzberg.dan@gmail.com>
> Cc: Changwoo Min <changwoo@igalia.com>
> Cc: Andrea Righi <righi.andrea@gmail.com>

Hi Tejun,

This LG as is, but I also left a comment below in case we want to tweak. Fe=
el
free to just apply the tag if you'd rather not iterate given that this is j=
ust
an example scheduler.

Acked-by: David Vernet <void@manifault.com>

> ---
>  tools/sched_ext/scx_qmap.bpf.c | 39 ++++++++++++++++++++++++++--------
>  tools/sched_ext/scx_qmap.c     |  5 +++--
>  2 files changed, 33 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bp=
f.c
> index 27e35066a602..892278f12dce 100644
> --- a/tools/sched_ext/scx_qmap.bpf.c
> +++ b/tools/sched_ext/scx_qmap.bpf.c
> @@ -120,11 +120,26 @@ struct {
>  } cpu_ctx_stor SEC(".maps");
> =20
>  /* Statistics */
> -u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued;
> +u64 nr_enqueued, nr_dispatched, nr_reenqueued, nr_dequeued, nr_ddsp_from=
_enq;
>  u64 nr_core_sched_execed;
>  u32 cpuperf_min, cpuperf_avg, cpuperf_max;
>  u32 cpuperf_target_min, cpuperf_target_avg, cpuperf_target_max;
> =20
> +static s32 pick_direct_dispatch_cpu(struct task_struct *p, s32 prev_cpu)
> +{
> +	s32 cpu;
> +
> +	if (p->nr_cpus_allowed =3D=3D 1 ||
> +	    scx_bpf_test_and_clear_cpu_idle(prev_cpu))
> +		return prev_cpu;
> +
> +	cpu =3D scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
> +	if (cpu >=3D 0)
> +		return cpu;
> +
> +	return -1;
> +}
> +
>  s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_struct *p,
>  		   s32 prev_cpu, u64 wake_flags)
>  {
> @@ -137,17 +152,14 @@ s32 BPF_STRUCT_OPS(qmap_select_cpu, struct task_str=
uct *p,
>  		return -ESRCH;
>  	}
> =20
> -	if (p->nr_cpus_allowed =3D=3D 1 ||
> -	    scx_bpf_test_and_clear_cpu_idle(prev_cpu)) {
> +	cpu =3D pick_direct_dispatch_cpu(p, prev_cpu);
> +
> +	if (cpu >=3D 0) {
>  		tctx->force_local =3D true;
> +		return cpu;
> +	} else {
>  		return prev_cpu;
>  	}
> -
> -	cpu =3D scx_bpf_pick_idle_cpu(p->cpus_ptr, 0);
> -	if (cpu >=3D 0)
> -		return cpu;
> -
> -	return prev_cpu;
>  }
> =20
>  static int weight_to_idx(u32 weight)
> @@ -172,6 +184,7 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct =
*p, u64 enq_flags)
>  	u32 pid =3D p->pid;
>  	int idx =3D weight_to_idx(p->scx.weight);
>  	void *ring;
> +	s32 cpu;
> =20
>  	if (p->flags & PF_KTHREAD) {
>  		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
> @@ -207,6 +220,14 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct=
 *p, u64 enq_flags)
>  		return;
>  	}
> =20
> +	/* if !WAKEUP, select_cpu() wasn't called, try direct dispatch */
> +	if (!(enq_flags & SCX_ENQ_WAKEUP) &&
> +	    (cpu =3D pick_direct_dispatch_cpu(p, scx_bpf_task_cpu(p))) >=3D 0) {
> +		__sync_fetch_and_add(&nr_ddsp_from_enq, 1);
> +		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, slice_ns, enq_flags);
> +		return;
> +	}

Hmm, will this be a typical pattern for how this is used? I'd expect
ops.select_cpu() and ops.enqueue() to quite often be nearly the same
implementation. Meaning you would e.g. try to find an idle core in both, an=
d do
SCX_DSQ_LOCAL_ON, with the difference being that you'd just return the cpu =
and
save the extra lock juggling if you did it on the ops.select_cpu() path. No=
t a
huge deal given that it's just an example scheduler, but it might be a good
idea to try and mirror typical use cases for that reason as well so readers=
 get
an idea of what a typical pattern would look like.

> +
>  	/*
>  	 * If the task was re-enqueued due to the CPU being preempted by a
>  	 * higher priority scheduling class, just re-enqueue the task directly
> diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
> index 304f0488a386..c9ca30d62b2b 100644
> --- a/tools/sched_ext/scx_qmap.c
> +++ b/tools/sched_ext/scx_qmap.c
> @@ -116,10 +116,11 @@ int main(int argc, char **argv)
>  		long nr_enqueued =3D skel->bss->nr_enqueued;
>  		long nr_dispatched =3D skel->bss->nr_dispatched;
> =20
> -		printf("stats  : enq=3D%lu dsp=3D%lu delta=3D%ld reenq=3D%"PRIu64" deq=
=3D%"PRIu64" core=3D%"PRIu64"\n",
> +		printf("stats  : enq=3D%lu dsp=3D%lu delta=3D%ld reenq=3D%"PRIu64" deq=
=3D%"PRIu64" core=3D%"PRIu64" enq_ddsp=3D%"PRIu64"\n",
>  		       nr_enqueued, nr_dispatched, nr_enqueued - nr_dispatched,
>  		       skel->bss->nr_reenqueued, skel->bss->nr_dequeued,
> -		       skel->bss->nr_core_sched_execed);
> +		       skel->bss->nr_core_sched_execed,
> +		       skel->bss->nr_ddsp_from_enq);
>  		if (__COMPAT_has_ksym("scx_bpf_cpuperf_cur"))
>  			printf("cpuperf: cur min/avg/max=3D%u/%u/%u target min/avg/max=3D%u/%=
u/%u\n",
>  			       skel->bss->cpuperf_min,
> --=20
> 2.45.2
>=20

--MdD7hTEMKDb7BSGH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo7gIwAKCRBZ5LhpZcTz
ZHuzAQDK60O4YRyEBe+GWd5GWsOmod1VpeC/bYNHvhTtFBkLoQEAikChMivxEQAE
sBX4dkfGc0S3xMiFSR3j6D3JBUv1IAA=
=+GFF
-----END PGP SIGNATURE-----

--MdD7hTEMKDb7BSGH--

