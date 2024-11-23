Return-Path: <linux-kernel+bounces-418999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 504CB9D6833
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 09:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFE6B21CDC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA18187325;
	Sat, 23 Nov 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="gftNjYFK"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C117C21C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732351529; cv=none; b=G8qGfpRtz5+EEBFzVHI00udpZgMMv0Sr+Ka+4EbLIGJHtBWqKirX86Gnh21IPvNGOw/6nf1WqQSIl3M8MSP8QN1ZzWLHUN0euVbCUlAEz8yTl0pPL+LS2z4PC1+YtB4Sq1CpE8IAJImzNj3iyROenN5F2BT2cKCiqqAiIPSASFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732351529; c=relaxed/simple;
	bh=nSHZzcS0V7G5yKuSLqAgEMNOnxI0KuZYWSlNsNGha+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J3PSSZJrlVISOz8KDLL9Tn9z8NwmvXPpG1TpWF3O4AF3CpsC7vPL1odtTtPKzV7FVR4WgsLUWUmreXbtw0/+NFp+idLNcgy0pP7KZllWhVTSvD8OI7eWSUo9LIahQKuMANNEINWTBPdWN0utqK+/rt8aNV9+84edTEn6dH7Ifm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=gftNjYFK; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732351484; x=1732956284; i=efault@gmx.de;
	bh=VL+nucj0tfd2TtxDV5VRRH5WaFmAZ2Eyl6ioCPyf4Ek=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gftNjYFKJKvHsmHWF4KOLCZi8F+oA6FLsFq3rDG9qePCnGx/WlPG6p3fNShz13d5
	 9NHRdmNgLd/eReiHHdxFeSrCxgbIacok8dd57B+xtl9pTDoSi/XSZju1mVQduwxPw
	 9Dq63ZVQIVXIRjTwbRHrbsZ16S8M6lO4AVT9POZMhYyQ3ubsWwy3/0oxIcZqBJgmG
	 Ee4F8vJ/kdT1CK8QXFTfVEVQlx2atIkBaOm2cHNNUP56NDUfZVvycnGm1TzFeGKG2
	 UlXXknYa0vEViH2UXxpNlfVLLcq4jictxLfd53BTUmcHTLMOVf/O0heuj0ssVPEu6
	 o/URazmfl4HnD4FD9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.176]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeMG-1t7AUK2I4q-00Qm40; Sat, 23
 Nov 2024 09:44:44 +0100
Message-ID: <bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de>
Subject: [PATCH V2] sched/fair: Dequeue sched_delayed tasks when waking to a
 busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Sat, 23 Nov 2024 09:44:40 +0100
In-Reply-To: <20241121115628.GB394828@pauld.westford.csb>
References: <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
	 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
	 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
	 <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
	 <20241114112854.GA471026@pauld.westford.csb>
	 <20241119113016.GB66918@pauld.westford.csb>
	 <bede25619ef6767bcd38546e236d35b7dadd8bd4.camel@gmx.de>
	 <915eab00325f2bf608bcb2bd43665ccf663d4084.camel@gmx.de>
	 <20241121115628.GB394828@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kwtnty8X/BXn28Jkf0xjNXcHqt4+HAiHoB1POoHiMtZZDDGhYp8
 YpQgVw2VGdo3CM1MchmlyiHDTq1gaiFQvsfFLtYELFde5wTzihoO4o09pV3rNGp5/qe+oJi
 Y9zmmpoZy77+EPekMxxL36ryzMAhpayAo3L1v5kSEXeMPn9EU6g+gFdeJzyJ6Pj6G53q6Yv
 5guq4JWLbrDQIKEsEV3dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PqnGhNMI+Ws=;wQkdl40YTDxqWiOLa2L88Q2NRZQ
 eZAWYGHFV5pDE4yVkWE5atEuU8AZMCG29bpMiHqx/8umxaXJvgl3C63YVrHO6Q3REGxd+scAq
 rTqcheAAozzGgDVuRmM3mVyJGxosP1BTD+5HBAh4BS6Gqv0OoRuak0k6SqKXA3OUuDviN2z0x
 /F+zczh309nY+mj5jHRblwMRjIqpg1uuIo5KgYltXVhSc0stXrUccw/bQIf405YO4oV5J3DaS
 Ew+paW+XCkD0fS25nlD5MHc+vyUGfazGFr5c21bzcTnGTwQCM/C2IR+MhQpvy4E1g0Ets4fAi
 2fVWA1l4IGcUSfFGmIKnr4x/415gaQMGYG1gw0LVEwU+j+wWmjeUJ+LAH8yBli+3nogRDM75m
 RP3hCZbCjzVyLxH8/w53E764YLzwLFcM6jAAIPQwoBCvSopEHcV6yH3I39hEwFKXnZALJl7w8
 WuCJZjh3vDAdgSHGhbDmhQn66Y4REK9/QQJhsnBPJ+8SjFZ5UB+Ezy4e/Sz4c05wG9+Y1HpRJ
 uACJ8AIOQUEma8qGEansGGqTsulXpYNb+O+yB1QJUaQULobkmFYPB7Wjb3SPyZoEp7Pr33x5B
 qi5x/9YX5I62Mx/u5UXmlwq1Jfj69lUPWQRz1PYIXe3HT0cbwmTPXPMMkiyBeN9RSJRLw1zaR
 bYmM/M+HXNvAnlY9opUh78y2NUyF7kO2alodle3jWvFiSePKVbKgX2qlVpj5USgyuInxiWtrH
 NbdpW1DUq0l5Uiy5xngjEoVjIMiURcI72g4XmCZSSRW4ba71oc1IH+3VfHdQfGZiD+uerWxGa
 vvG60wv+xXoXoHxIFnNwCgbhJC0LpE/gtlrXMziixxQIZyI49J9H/+uPC/DPYohpDaXILztda
 yQ7ineCt1GqweexGleiPHFX05AjHzYMMVPki/kozOpaJ3lMpRx9cna5SZVNUsLYQZ5l31wqAJ
 o0PFGp3Rx5QMFIGS1HY8jLha08J39F9EmOcM/5/CeDSohtNQvZWk5nQzThW7rdHyAjMgNwTFB
 cI0yHGEzl6eQy73wlYGE96NGsXPCIy/DkPnMaif2tj5yBnLHA2kUqdYM1F9+B3Ydgn17cSvWX
 IQWK/gq8GXOQ/Sd6tfh2XVLTy3SCGq

On Thu, 2024-11-21 at 06:56 -0500, Phil Auld wrote:
> On Wed, Nov 20, 2024 at 07:37:39PM +0100 Mike Galbraith wrote:
> > On Tue, 2024-11-19 at 12:51 +0100, Mike Galbraith wrote:
> > > On Tue, 2024-11-19 at 06:30 -0500, Phil Auld wrote:
> > > >
> > > > This, below, by itself, did not do help and caused a small slowdow=
n on some
> > > > other tests.=C2=A0 Did this need to be on top of the wakeup change=
?
> > >
> > > No, that made a mess.
> >
> > Rashly speculating that turning mobile kthread component loose is what
> > helped your write regression...
> >
> > You could try adding (p->flags & PF_KTHREAD) to the wakeup patch to
> > only turn hard working kthreads loose to try to dodge service latency.
> > Seems unlikely wakeup frequency * instances would combine to shred fio
> > the way turning tbench loose did.
> >
>
> Thanks, I'll try that.

You may still want to try that, but my box says probably not.  Playing
with your write command line, the players I see are pinned kworkers and
mobile fio instances.

Maybe try the below instead. The changelog is obsolete BS unless you
say otherwise, but while twiddled V2 will still migrate tbench a bit,
and per trace_printk() does still let all kinds of stuff wander off to
roll the SIS dice, it does not even scratch the paint of the formerly
obliterated tbench progression.

Question: did wiping off the evil leave any meaningful goodness behind?

=2D--

sched/fair: Dequeue sched_delayed tasks when waking to a busy CPU

Phil Auld (Redhat) reported an fio benchmark regression having been found
to have been caused by addition of the DELAY_DEQUEUE feature, suggested it
may be related to wakees losing the ability to migrate, and confirmed that
restoration of same indeed did restore previous performance.

V2: do not rip buddies apart, convenient on/off switch

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/sched/core.c     |   51 ++++++++++++++++++++++++++++++------------=
------
 kernel/sched/features.h |    5 ++++
 kernel/sched/sched.h    |    5 ++++
 3 files changed, 42 insertions(+), 19 deletions(-)

=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3783,28 +3783,41 @@ ttwu_do_activate(struct rq *rq, struct t
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
+		int dequeue =3D sched_feat(DEQUEUE_DELAYED);
+
+		/*
+		 * Since sched_delayed means we cannot be current anywhere,
+		 * dequeue it here and have it fall through to the
+		 * select_task_rq() case further along in ttwu() path.
+		 * Note: Do not rip buddies apart else chaos follows.
+		 */
+		if (dequeue && rq->nr_running > 1 && p->nr_cpus_allowed > 1 &&
+		    !(rq->curr->last_wakee =3D=3D p || p->last_wakee =3D=3D rq->curr)) =
{
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
=2D-- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -47,6 +47,11 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
  */
 SCHED_FEAT(DELAY_DEQUEUE, true)
+/*
+ * Free ONLY non-buddy delayed tasks to wakeup-migrate to avoid taking.
+ * an unnecessary latency hit.  Rending buddies asunder inflicts harm.
+ */
+SCHED_FEAT(DEQUEUE_DELAYED, true)
 SCHED_FEAT(DELAY_ZERO, true)

 /*
=2D-- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1783,6 +1783,11 @@ task_rq_unlock(struct rq *rq, struct tas
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


