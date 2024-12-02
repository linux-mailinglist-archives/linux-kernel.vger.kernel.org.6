Return-Path: <linux-kernel+bounces-428259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4A9E0D86
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A7CB608D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D21DE3C8;
	Mon,  2 Dec 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="clugj15u"
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2D21B6D0A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.40.148.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733167509; cv=none; b=pzaSfPSV+QmL6KKHfaGBPPboOuqWEXvd0Ool4XwPkwr03yobUvTpLlqCsDAqn+KhLxUEvdPoTY0PaDoyyNqoHX/shzkWfv0WUBK0WOzxPix2UrV1IlYREylNeZY+Kj/r8lI+orod8kUgydLPgRZ85KgNpTRxKKqWQcU+wIkYfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733167509; c=relaxed/simple;
	bh=kWxiNq9BdSMaw0eJM0Y1m3uFBJJ9ss8RAyp/SIsCGZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBrVVUl6yWV9+3vY8Rc/YibOzdfF9S1m99bawLQw4BQBIQSVdx8IqbTGpmAOu6/Y+i5UF7WEDxlGdUht3XktQNaOHVGwrFZHlKx5+v9mAbQBzzW6u02Qb60dS1tVYuWMbdkamn8eB0pMY5z+KfCw/K52WVkwStHNIeFjfFpmOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=clugj15u; arc=none smtp.client-ip=78.40.148.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap5-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kWxiNq9BdSMaw0eJM0Y1m3uFBJJ9ss8RAyp/SIsCGZ4=; b=clugj15uQzjxSJX2O5BTIrtI8F
	cpOhwvc7fmV4AJ5piamhRnNBEYXTMeaZ7vPuGB1b7TkgUGOCtZdfMrGgOCjbY2lR+N4Fvgd5ixSAx
	YznSpOiF2opXATkIq3axpdCs3oa2+NYdhbedb4Pnvouyfqi7CHIeM67NarB42WsMzl2g1E+bLQ/ME
	oXBidMAy+tCHTP9qFqNhU9vuUGDWFTPVWIkXNhKLrjuD/ASZd1+VncAEbiILbtF+jMbA3K+YXKTbH
	DgXkwIce9GZq7AQIcVbyz/HeDhYHYb8DqZTVgrFlFMsk5odn9X+xEGV5AHPAFMthbTvBm+yxdJmiL
	d/6+/XLg==;
Received: from [167.98.27.226] (helo=[10.17.3.42])
	by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1tIBR7-00GaSi-Qr; Mon, 02 Dec 2024 18:46:23 +0000
Message-ID: <98294066b3a0a7a77220e18ab9db5d3c3cb57341.camel@codethink.co.uk>
Subject: Re: [REGRESSION] Re: [PATCH 00/24] Complete EEVDF
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, 	vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, 	wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, 	efault@gmx.de
Date: Mon, 02 Dec 2024 19:46:21 +0100
In-Reply-To: <20241129090843.GB15382@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
		 <16f96a109bec0b5849793c8fb90bd6b63a2eb62f.camel@codethink.co.uk>
		 <20241128105817.GC35539@noisy.programming.kicks-ass.net>
		 <4052c4e7ed0e02d11c2219915b08928677c88ab8.camel@codethink.co.uk>
		 <20241129090843.GB15382@noisy.programming.kicks-ass.net>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

Sorry for my late reply, I was traveling back from Manchester to Switzerlan=
d but I am all settled down again.

On Fri, 2024-11-29 at 10:08 +0100, Peter Zijlstra wrote:
> On Thu, Nov 28, 2024 at 12:37:14PM +0100, Marcel Ziswiler wrote:
>=20
> > > Oooh, that's something. So far the few reports have not been (easily)
> > > reproducible. If this is readily reproducible on arm64 that would
> > > help a lot. Juri, do you have access to an arm64 test box?
> >=20
> > As mentioned above, so far our scheduler stress test is not yet open so=
urce but Codethink is eager to share
> > anything which helps in resolving this.
>=20
> I was hoping you could perhaps share a binary with Juri privately or
> with RHT (same difference etc), such that he can poke at it too.

Sure, there is nothing secret about it, it is just that we have not gotten =
around open sourcing all parts of it
just yet.

The UEFI aarch64 embedded Linux image I am using may be found here [1]. Plu=
s matching bmap file should you
fancy using that [2]. And the SSH key may help when interacting with the sy=
stem (e.g. that is how I trigger the
failure as the console is quite busy with tracing) [3]. However, that was b=
uilt by CI and does not contain a
kernel with below patch applied yet. I manually dumped the kernel config an=
d compiled v6.12.1 with your patch
applied and deployed it (to /lib/modules, /usr/lib/kernel et. al.) in the b=
elow case where I provide the dump.

> Anyway, if you don't mind a bit of back and forth,=C2=A0

Sure.

> would you mind adding
> the below patch to your kernel and doing:
>=20
> (all assuming your kernel has ftrace enabled)
>=20
> =C2=A0 echo 1 > /sys/kernel/debug/tracing/options/stacktrace
> =C2=A0 echo 1 > /proc/sys/kernel/traceoff_on_warning
>=20
> running your test to failure and then dumping the trace into a file
> like:
>=20
> =C2=A0 cat /sys/kernel/debug/tracing/trace > ~/trace

Unfortunately, once I trigger the failure the system is completely dead and=
 won't allow me to dump the trace
buffer any longer. So I did the following instead on the serial console ter=
minal:

tail -f /sys/kernel/debug/tracing/trace

Not sure whether there is any better way to go about this. Plus even so we =
run the serial console at 1.5
megabaud I am not fully sure whether it was able to keep up logging what yo=
u are looking for.

> Then compress the file (bzip2 or whatever is popular these days)

xz or zstd (;-p)

> and
> send it my way along with a dmesg dump (private is fine -- these things
> tend to be large-ish).

As mentioned before, there is nothing secret about it. Please find it here =
[4].

> Hopefully, this will give us a little clue as to where the double
> enqueue happens.

Yes, and do not hesitate to ask for any additional information et. al. we a=
re happy to help. Thanks!

> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9d5a702f1a6..b9cd9b40a19f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1203,6 +1203,11 @@ static enum hrtimer_restart dl_server_timer(struct=
 hrtimer *timer, struct sched_
> =C2=A0 scoped_guard (rq_lock, rq) {
> =C2=A0 struct rq_flags *rf =3D &scope.rf;
> =C2=A0
> + if (dl_se =3D=3D &rq->fair_server) {
> + trace_printk("timer fair server %d throttled %d\n",
> + =C2=A0=C2=A0=C2=A0=C2=A0 cpu_of(rq), dl_se->dl_throttled);
> + }
> +
> =C2=A0 if (!dl_se->dl_throttled || !dl_se->dl_runtime)
> =C2=A0 return HRTIMER_NORESTART;
> =C2=A0
> @@ -1772,6 +1777,9 @@ static enum hrtimer_restart inactive_task_timer(str=
uct hrtimer *timer)
> =C2=A0 rq_lock(rq, &rf);
> =C2=A0 }
> =C2=A0
> + if (dl_se =3D=3D &rq->fair_server)
> + trace_printk("inactive fair server %d\n", cpu_of(rq));
> +
> =C2=A0 sched_clock_tick();
> =C2=A0 update_rq_clock(rq);
> =C2=A0
> @@ -1967,6 +1975,12 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struc=
t sched_dl_entity *dl_se,
> =C2=A0static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
> =C2=A0{
> =C2=A0 struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
> + struct rq *rq =3D rq_of_dl_se(dl_se);
> +
> + if (dl_se =3D=3D &rq->fair_server) {
> + trace_printk("enqueue fair server %d h_nr_running %d\n",
> + =C2=A0=C2=A0=C2=A0=C2=A0 cpu_of(rq), rq->cfs.h_nr_running);
> + }
> =C2=A0
> =C2=A0 WARN_ON_ONCE(!RB_EMPTY_NODE(&dl_se->rb_node));
> =C2=A0
> @@ -1978,6 +1992,12 @@ static void __enqueue_dl_entity(struct sched_dl_en=
tity *dl_se)
> =C2=A0static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
> =C2=A0{
> =C2=A0 struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
> + struct rq *rq =3D rq_of_dl_se(dl_se);
> +
> + if (dl_se =3D=3D &rq->fair_server) {
> + trace_printk("dequeue fair server %d h_nr_running %d\n",
> + =C2=A0=C2=A0=C2=A0=C2=A0 cpu_of(rq), rq->cfs.h_nr_running);
> + }
> =C2=A0
> =C2=A0 if (RB_EMPTY_NODE(&dl_se->rb_node))
> =C2=A0 return;

[1] https://drive.codethink.co.uk/s/N8CQipaNNN45gYM

[2] https://drive.codethink.co.uk/s/mpcPawXpCjPL8D3

[3] https://drive.codethink.co.uk/s/8RjHNTQQRpYgaLc

[4] https://drive.codethink.co.uk/s/MWtzWjLDtdD3E5i

Cheers

Marcel

