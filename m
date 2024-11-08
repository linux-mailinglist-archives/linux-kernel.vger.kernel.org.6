Return-Path: <linux-kernel+bounces-400850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6859C1331
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D341282AEC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425F01BD9E2;
	Fri,  8 Nov 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="bogicNuA"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C4B661
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731025522; cv=none; b=JffnrDUW0vhqvhjpTCjwBUu3tn/lPZeeDteM7L40Keu1zc+gABw/tAWFu6VtdGCLzufhofJEBND/GcXSoXlhifL3lQ6PIutR9Kxxcle5SjZX8kAH/1ogUjWdXkOXF0qgojAwAicFkfo9PXng1D3sOvDz/eVHlIQKYJTqcatkpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731025522; c=relaxed/simple;
	bh=Yu0ZVqa4VL8nwWUskUGCY1WzArYZ0sKKfWDIKTwLbIQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKVaqvsYYHRL4rG+Nk6aqLIunr8skvnwsrksUILbdQ8ztKPW3uQramuM8kqqP2JsMrSVuhoB1ebIGsXay85TGuzEe+sGj3QTuUbGdi6N3kimqoB9A4XxdJC6VvpoPJbw6Bl+Sp2Jn/HASEDYSHAyqPG/v6eeiUsVPugM/bC7CSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=bogicNuA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731025477; x=1731630277; i=efault@gmx.de;
	bh=y868n/rZTW1q1WLAeN0V1ocmz++K3iIcT5QYB1Z9XJs=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bogicNuAi2W8X8gQdFbskekwAcZvIAogwn2x7udwluD/wu5B4pWAzzL5T5ZyBHnk
	 9rzsOSjVNPiTT4TzBi7gwCk8ZiGKKk61Y9jB3XUSqk3k/zKtrM6BwPl4W38bWePV2
	 z0iUXnoRVgjSRNCwlYPe66VN4ai1/jyrru734xvAKp3Gt703+0IuK2MUrfBhiuWFZ
	 DMCG3wxWIosDs2RdEdqFyrxq23nNPGF8XdjonYmWzjJksgHMlbQwxuPQ1Gm/vKOFz
	 KLZ0lGxcRNNuxl1UYc9M7bZ0dgBe+cmkdnEm89gnjHLI9tnzKH2FmR+Q40T7xmc8+
	 daReexbaZ/34aiRmsg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.61]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MzhnH-1u4BD228BN-013yp9; Fri, 08
 Nov 2024 01:24:37 +0100
Message-ID: <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
Subject: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,  youssefesmat@chromium.org, tglx@linutronix.de
Date: Fri, 08 Nov 2024 01:24:35 +0100
In-Reply-To: <20241107140945.GA34695@noisy.programming.kicks-ass.net>
References: <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
	 <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
	 <20241106135346.GL24862@noisy.programming.kicks-ass.net>
	 <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
	 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
	 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
	 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
	 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KnGLQMykz0NEmOSiiZvdKOSY8KwUbc99pQkS7ywEGhEnOtIyftp
 9TE9OzZKwcbLuBKm09OK1Yo+wOhXKp7QZF91Aszs5y4cY0eTdftNsbweKUDOCMgavPGIttR
 IHx5ZU7LV/XBAIALIQrElY7xBfT0ZABid4k+XXNStokr5P/0y6/jVj4Kuw8kE0Ztg8i6Obs
 9h8wRirxiGPqykUWidSdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9j08qpmsKxw=;+6riMbB8fkcN2IJybKOtZtG70j1
 /EiW7Pl9FlqyC9mqGZrqZai78X3vjJNzBshHoIIXGQ/gWMnumqHNuvj3nFtdyAgRmiCBwTwp9
 /oOrTUdSWFZNbp3r5GuYpeXQzUB1UZAqRBTnp+x0fbQPMJ9nNwei+85CWbmVoqupOywwEYwvV
 +PmSUnbEzGDL9iYpe/EA+EAzh3t7w4lm9ccsluUF2eNIq64oa0wzNrY3BB1GY1dogK9w+qBOM
 jNKoKkvRAmCKbeL33tIrCnSFKYn4cmA3w52Lfa3pDIolzzhsEmOG+C/MagNjhKcarOGu3B4ei
 V3mbPlpDOtNE8KloZv6Lzs3snz0aCw2/NlWmLBc94jOixfPWjU4VO3krjADjmJ/NAl03/Ci2s
 yHZLd34vXLawPd6ePxVoRSxOpR/V0hvR9C3zXOWyIwN1LlCBBGd89AC5IEas2YRc5SYnPwsJ8
 zf+BCEI12ElEJAOUAg3ny3xA5eEMUe1i8OLDiZhBiQicROFPD+hgEG+YWI5/sa3aBi+PKVyZl
 xgY3n6qPz+hD0oWeFB5SfqSXcsNnpw+tS9heRWOQ5crcAsBeqyvO4JmgkiZYwIatbMQRP8Rl+
 uXZOSz3Ar6DCkEjdcqW3zz67qfe9pt2F9IXfUpLUIopd31J3YQgSP/HA6mnbUfUgmcqed+vHN
 xHlwY3oGRWNno5FWVJ/pyIcFW4MSErTZ392XAFB+rbORY70o3ZDEzg0IhnHWesE22c2jT8QQf
 YXbOTxAJAOEzRH9YsE9FFayR/yBAJLCr78pCq9WAcSIu+LqDmx62Z3glceXSD73WJrDt0kUxk
 I3rlbfThXKaCW5mngDy//3DAhPcPHnjo/0771ppCIU6i5fVgFESDACOTQL+yXZP5VQ5r/EW7D
 r87W4YbH4XGwbwn5XPGlT6/fLDt/78ZMlKkdYHNec2kFy4Mg2ugyJSEFB

On Thu, 2024-11-07 at 15:09 +0100, Peter Zijlstra wrote:
> On Thu, Nov 07, 2024 at 03:02:36PM +0100, Mike Galbraith wrote:
> > On Thu, 2024-11-07 at 10:46 +0100, Mike Galbraith wrote:
> > > On Thu, 2024-11-07 at 05:03 +0100, Mike Galbraith wrote:
> > > >
> > > > I built that patch out of curiosity, and yeah, set_next_task_fair(=
)
> > > > finding a cfs_rq->curr ends play time pretty quickly.
> > >
> > > The below improved uptime, and trace_printk() says it's doing the
> > > intended, so I suppose I'll add a feature and see what falls out.
> >
> > From netperf, I got.. number tabulation practice.=C2=A0 Three runs of =
each
> > test with and without produced nothing but variance/noise.
>
> Make it go away then.
>
> If you could write a Changelog for you inspired bit and stick my cleaned
> up version under it, I'd be much obliged.

Salut, much obliged for eyeball relief.

=2D--snip---

Phil Auld (Redhat) reported an fio benchmark regression having been found
to have been caused by addition of the DELAY_DEQUEUE feature, suggested it
may be related to wakees losing the ability to migrate, and confirmed that
restoration of same indeed did restore previous performance.

(de-uglified-a-lot-by)

Reported-by: Phil Auld <pauld@redhat.com>
Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Link: https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.=
csb/
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/core.c  |   48 +++++++++++++++++++++++++++++----------------=
---
 kernel/sched/sched.h |    5 +++++
 2 files changed, 34 insertions(+), 19 deletions(-)

=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3783,28 +3783,38 @@ ttwu_do_activate(struct rq *rq, struct t
  */
 static int ttwu_runnable(struct task_struct *p, int wake_flags)
 {
-	struct rq_flags rf;
-	struct rq *rq;
-	int ret =3D 0;
-
-	rq =3D __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		update_rq_clock(rq);
-		if (p->se.sched_delayed)
-			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
-		if (!task_on_cpu(rq, p)) {
-			/*
-			 * When on_rq && !on_cpu the task is preempted, see if
-			 * it should preempt the task that is current now.
-			 */
-			wakeup_preempt(rq, p, wake_flags);
+	CLASS(__task_rq_lock, rq_guard)(p);
+	struct rq *rq =3D rq_guard.rq;
+
+	if (!task_on_rq_queued(p))
+		return 0;
+
+	update_rq_clock(rq);
+	if (p->se.sched_delayed) {
+		int queue_flags =3D ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
+
+		/*
+		 * Since sched_delayed means we cannot be current anywhere,
+		 * dequeue it here and have it fall through to the
+		 * select_task_rq() case further along the ttwu() path.
+		 */
+		if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
+			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
+			return 0;
 		}
-		ttwu_do_wakeup(p);
-		ret =3D 1;
+
+		enqueue_task(rq, p, queue_flags);
+	}
+	if (!task_on_cpu(rq, p)) {
+		/*
+		 * When on_rq && !on_cpu the task is preempted, see if
+		 * it should preempt the task that is current now.
+		 */
+		wakeup_preempt(rq, p, wake_flags);
 	}
-	__task_rq_unlock(rq, &rf);
+	ttwu_do_wakeup(p);

-	return ret;
+	return 1;
 }

 #ifdef CONFIG_SMP
=2D-- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1779,6 +1779,11 @@ task_rq_unlock(struct rq *rq, struct tas
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }

+DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
+		    _T->rq =3D __task_rq_lock(_T->lock, &_T->rf),
+		    __task_rq_unlock(_T->rq, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    _T->rq =3D task_rq_lock(_T->lock, &_T->rf),
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),



