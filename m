Return-Path: <linux-kernel+bounces-439931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D83089EB653
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C85188880B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73A81BBBFE;
	Tue, 10 Dec 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="Pu+to0OZ"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138A23DEAD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733847992; cv=none; b=D3wNeU/1x8c1Uxz4/sHY6pLz3EFDNoYxdnm6c+5dUFG1hfe+dTfdjeRcIGiGnvHIBSdbYo5q9B1WDv/n+2DlkImZOaeMJ/rwGhboW4blxGGeHVQZCeT7fZca/WIOS/qxQ6x1Zb6Q8ynymxDFqqPRuVImWkqx9HadjMmY231j9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733847992; c=relaxed/simple;
	bh=9of5D4BejRZvwLNVueS7EB2zoeUXttSXUXfxYjxpE6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VcT7oEFzqJ7IrGDsdnVDysCkxI7g+qb54C4Ng93Lb4OSwj+Hqy6wKYig2tvx+DCEKa0P9SY5hk9wTlip1tXX1Aghzjk4i41gAIlxXecsjlegNN8W58AQOS9mmHNTr+gEwuQtdzgOecvwLEz3ZmJxlZnO5KArQ2l3mAyIOoLlPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=Pu+to0OZ; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7mRw1tFzI7pHRcOhHePYnb1IfwsWLRbzEbm5rusRSaA=; b=Pu+to0OZ6cLQgwH35j23tiYRDw
	yq52soiHKFDrruRUohfh57LZIPUUh9tanPqHgBBz/tAkGaXXFpCkadvIPHb9gPT12m58rLUIb+xqZ
	7S3/TaMZzpoKZPqX0n3+UQRObKkK1Mc8cXbm/3cN5m2WLAkyvddwB42GwX5MAmys9HO8lCT2honJ+
	RKREQC+BYYkoGHCQmHyWulNJvk146eVsdQHkPAJfCvBYmDAx7AJmhr55zU3RS7zoa61N5Z0R6Rac7
	Ie3kdN9fF46lsxIGw2/IHXpcbx6CpW6+/jcWT66mqraRYObr2UH3Cxi6zx/XlvjyUzP1jBr4EGuk1
	kr0GNypg==;
Received: from [194.230.241.203] (helo=[10.10.1.195])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tL2k9-001RsD-RC; Tue, 10 Dec 2024 16:05:49 +0000
Message-ID: <594620de83a3fea6cad87e642ce79ae878465d49.camel@codethink.co.uk>
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, 	vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, 	wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, 	efault@gmx.de
Date: Tue, 10 Dec 2024 17:05:48 +0100
In-Reply-To: <20241209094941.GF21636@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
	 <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
	 <20241128105817.GC35539@noisy.programming.kicks-ass.net>
	 <4052c4e7ed0e02d11c2219915b08928677c88ab8.camel@codethink.co.uk>
	 <20241129090843.GB15382@noisy.programming.kicks-ass.net>
	 <98294066b3a0a7a77220e18ab9db5d3c3cb57341.camel@codethink.co.uk>
	 <20241209094941.GF21636@noisy.programming.kicks-ass.net>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

On Mon, 2024-12-09 at 10:49 +0100, Peter Zijlstra wrote:
>=20
> Sorry for the delay, I got laid low by snot monsters :/
>=20
> On Mon, Dec 02, 2024 at 07:46:21PM +0100, Marcel Ziswiler wrote:
>=20
> > Unfortunately, once I trigger the failure the system is completely dead=
 and won't allow me to dump the
> > trace
> > buffer any longer. So I did the following instead on the serial console=
 terminal:
> >=20
> > tail -f /sys/kernel/debug/tracing/trace
> >=20
> > Not sure whether there is any better way to go about this. Plus even so=
 we run the serial console at 1.5
> > megabaud I am not fully sure whether it was able to keep up logging wha=
t you are looking for.
>=20
> Ah, that is unfortunate. There is a ftrace_dump_on_oops option that
> might be of help. And yes, dumping trace buffers over 1m5 serial lines
> is tedious -- been there done that, got a t-shirt and all that.
>=20
> Still, let me see if perhaps making that WARN in enqueue_dl_entity()
> return makes the whole thing less fatal.
>=20
> I've included the traceoff_on_warning and ftrace_dump in the code, so
> all you really need to still do is enable the stacktrace option.
>=20
> =C2=A0=C2=A0 echo 1 > /sys/kernel/debug/tracing/options/stacktrace
>=20
> > Yes, and do not hesitate to ask for any additional information et. al. =
we are happy to help. Thanks!
>=20
> Could I bother you to try again with the below patch?

Sure, here you go.

https://drive.codethink.co.uk/s/HniZCtccDBMHpAK

> There are two new hunks vs the previous one, the hunk in
> enqueue_dl_entity() (the very last bit) will stop tracing and dump the
> buffers when that condition is hit in addition to then aborting the
> double enqueue, hopefully leaving the system is a slightly better state.
>=20
> The other new hunk is the one for dl_server_stop() (second hunk), while
> going over the code last week, I found that this might be a possible
> hole leading to the observed double enqueue, so fingers crossed.
>=20
> ---
>=20
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 33b4646f8b24..bd1df7612482 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1223,6 +1223,11 @@ static enum hrtimer_restart dl_server_timer(struct=
 hrtimer *timer, struct sched_
> =C2=A0	scoped_guard (rq_lock, rq) {
> =C2=A0		struct rq_flags *rf =3D &scope.rf;
> =C2=A0
> +		if (dl_se =3D=3D &rq->fair_server) {
> +			trace_printk("timer fair server %d throttled %d\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 cpu_of(rq), dl_se->dl_throttled);
> +		}
> +
> =C2=A0		if (!dl_se->dl_throttled || !dl_se->dl_runtime)
> =C2=A0			return HRTIMER_NORESTART;
> =C2=A0
> @@ -1674,6 +1679,12 @@ void dl_server_start(struct sched_dl_entity *dl_se=
)
> =C2=A0
> =C2=A0void dl_server_stop(struct sched_dl_entity *dl_se)
> =C2=A0{
> +	if (current->dl_server =3D=3D dl_se) {
> +		struct rq *rq =3D rq_of_dl_se(dl_se);
> +		trace_printk("stop fair server %d\n", cpu_of(rq));
> +		current->dl_server =3D NULL;
> +	}
> +
> =C2=A0	if (!dl_se->dl_runtime)
> =C2=A0		return;
> =C2=A0
> @@ -1792,6 +1803,9 @@ static enum hrtimer_restart inactive_task_timer(str=
uct hrtimer *timer)
> =C2=A0		rq_lock(rq, &rf);
> =C2=A0	}
> =C2=A0
> +	if (dl_se =3D=3D &rq->fair_server)
> +		trace_printk("inactive fair server %d\n", cpu_of(rq));
> +
> =C2=A0	sched_clock_tick();
> =C2=A0	update_rq_clock(rq);
> =C2=A0
> @@ -1987,6 +2001,12 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struc=
t sched_dl_entity *dl_se,
> =C2=A0static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
> =C2=A0{
> =C2=A0	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
> +	struct rq *rq =3D rq_of_dl_se(dl_se);
> +
> +	if (dl_se =3D=3D &rq->fair_server) {
> +		trace_printk("enqueue fair server %d h_nr_running %d\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0 cpu_of(rq), rq->cfs.h_nr_running);
> +	}
> =C2=A0
> =C2=A0	WARN_ON_ONCE(!RB_EMPTY_NODE(&dl_se->rb_node));
> =C2=A0
> @@ -1998,6 +2018,12 @@ static void __enqueue_dl_entity(struct sched_dl_en=
tity *dl_se)
> =C2=A0static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
> =C2=A0{
> =C2=A0	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
> +	struct rq *rq =3D rq_of_dl_se(dl_se);
> +
> +	if (dl_se =3D=3D &rq->fair_server) {
> +		trace_printk("dequeue fair server %d h_nr_running %d\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0 cpu_of(rq), rq->cfs.h_nr_running);
> +	}
> =C2=A0
> =C2=A0	if (RB_EMPTY_NODE(&dl_se->rb_node))
> =C2=A0		return;
> @@ -2012,7 +2038,11 @@ static void __dequeue_dl_entity(struct sched_dl_en=
tity *dl_se)
> =C2=A0static void
> =C2=A0enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
> =C2=A0{
> -	WARN_ON_ONCE(on_dl_rq(dl_se));
> +	if (WARN_ON_ONCE(on_dl_rq(dl_se))) {
> +		tracing_off();
> +		ftrace_dump(DUMP_ALL);
> +		return;
> +	}
> =C2=A0
> =C2=A0	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);

