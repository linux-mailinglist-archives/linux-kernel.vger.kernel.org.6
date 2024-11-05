Return-Path: <linux-kernel+bounces-395871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 268D39BC430
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338581C20FF2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D15918873A;
	Tue,  5 Nov 2024 04:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="lnewGWQb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2BB18EAD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779575; cv=none; b=mOJ3LBIgn7IJz6GhReLywlyLYhsWhzI7tVo+QqyHfz80xsO0iVgJxcMiNqxX8vF35jPWkUTmHnGe/eaDDB8Eu3oaVX9kdiie5jANlRqBxAnOcQnPkMFGtj3IOFk7MhfChM00VD9hiSfw5A90SqjSmdnh+wz+40CLyvl5Wf2HlNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779575; c=relaxed/simple;
	bh=236FA6gVsA2ca4bpgGX7/StUglm1NcufFqXjrpI1sl4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYf4lZQaK5Ie74r5uFzrKiGauzLQOVu7/AijgwAUIUpV1AgdmGAV/mqtXa6Ula6Dttb8gBLHynf0J44BDagek+GuszCNguXmCusO14ql7UPjqAQSxmpBxj3G75p/VN1BtCmgJxEx3SZi2YMvv90WxmwQdlWfj/yxjEenZ+pysNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=lnewGWQb; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1730779514; x=1731384314; i=efault@gmx.de;
	bh=Xs9dYtOqfcNianSGzYCGl0mUW/GJpNP62DR8/iiYY4Q=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lnewGWQbZPu7E732F9IdZZ/J0wnSalGoxMwDxu5ETCAkjBnqXZOSi2Cg7EPc+x2B
	 BL9oHqSWlFlVBTLeXuacQOozRdMk/Ko93FWFN6Vj00LMMEmGmc3MTEDfwp+HA+9M4
	 EWLAmotu2gcE2YZcpbz7tq3ooxOl8tDg9+3sbMNVKzB03cTeFkhQb4FzVo7lh2Ta8
	 uiUuoiA6yEzmEH9Pw+VsAD7aC/27dNPvgWwki8Bi2PRHCuRpThieH6wOwIcNGaAzX
	 UO3xAImzSCxVbkgHZ1Z3RVJ39I72upoa08Hxj+4zLOdQx4jGBPrF4X+/Y/jNOcxM2
	 fdIitADF3STi9T+sUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.240]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1tXuuS2JMU-00hy2h; Tue, 05
 Nov 2024 05:05:14 +0100
Message-ID: <1bffa5f2ca0fec8a00f84ffab86dc6e8408af31c.camel@gmx.de>
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Tue, 05 Nov 2024 05:05:12 +0100
In-Reply-To: <20241104130515.GB749675@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
	 <20240727105030.226163742@infradead.org>
	 <20241101124715.GA689589@pauld.westford.csb>
	 <20241101125659.GY14555@noisy.programming.kicks-ass.net>
	 <20241101133822.GC689589@pauld.westford.csb>
	 <20241101142649.GX9767@noisy.programming.kicks-ass.net>
	 <20241101144225.GD689589@pauld.westford.csb>
	 <a59a1a99b7807d9937e424881c262ba7476d8b6b.camel@gmx.de>
	 <20241101200704.GE689589@pauld.westford.csb>
	 <59355fae66255a92f2cbc4d7ed38368ff3565140.camel@gmx.de>
	 <20241104130515.GB749675@pauld.westford.csb>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/uMU+z/bajSDWTiDjG5/RcPE3rBpR0PuJP41TEtsnQi+p66KmQd
 u0mVLrO/hZc9gRnrjNcRe+PbakzVUxxvCJ/BCj2a5EllqsEO4PRMurwca3FWkdzGDkzZIHu
 aGd7GZqMuMHo42EzaBAzNBdPBKK9tx6iH/oMv7KV6AzrBaaaR8T+bN7Iv7f87Jckbemayps
 B/JGzCX7nB86kGIgPJQnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6TKOyZQpYJg=;RRPdIMOrgwT1dJ9xKDLtSfE2T+W
 4g+fiKN6orbDOndDv/VlI7A2GA9x6y2LY54RAeAG6YmHvxZgv+wn8UTwG05anvx+sAiMww3dL
 9VwuSzqSsdeKzCnjY1qPzs8Zbj9bjQHWE9iTKUl49+eRt/rfkyVAbWRlI/U4pw40QLWVK/Krv
 jTXQ6xOo0FOoSjR8Zmr6g3obFev9Be9q81CjYllHSJTggas9v86zArR7nEvYYwiEL/yH1WDtH
 BXtey+U8APMuRYF+yR0Ghq5Dv1wMbDV25BkrBT3WC9/deyNGfnPOx/ES1ZOVbBNgL7ZH50hb/
 Ycr7+AKf5Hi/Ov037Svvq2v3XH21O4g/7Aj7+b1wRHIFrdJzycsCwPos+MgyzTkz0t1ibvrcr
 CiHl1PLsv00jgzPHcdAwQz3oZVHGfTieZCwy8PtQcgqGOCJFjSA7MpZjAJGLzcnsPOzSEBGg6
 In40qTreZcl6ZhyI9W4phSCvbQ0J8RK5CwEEUzgQfyINWtNCmBwP4H7qqt/SxqD09er885bel
 9+6c3eZK3a/+Qz2NI2pKSnbHaoAZWPlhCdSLCl1MfcN4y7BGflu7wfBtmxg18g96fmgEV1cjI
 Khk6zUQvTTiFppa1BMU7VSTn34w4wyJZhfUePEDMBufXfmT58XO9G4R3d4UAKLySX+TIFfSa8
 3xUXSB0faXFcEulfDFEnplG6jloDNjPASCPKssiC0+VW6VSmbESJY0HCPZ9i3bihd23Xc6N+x
 veIVLqQs/wVoikF+STEOnIVy1Bv2upRSI73L8cxam/yRfS3oBjpc9T+tXW+8mJMDXx8HWc+Ji
 YZ1GitRJHoXvslWoCG6CBF/A==

On Mon, 2024-11-04 at 08:05 -0500, Phil Auld wrote:
> On Sat, Nov 02, 2024 at 05:32:14AM +0100 Mike Galbraith wrote:
>
> >
> > The buddy being preempted certainly won't be wakeup migrated...
>
> Not the waker who gets preempted but the wakee may be a bit more
> sticky on his current cpu and thus stack more since he's still
> in that runqueue.

Ah, indeed, if wakees don't get scraped off before being awakened, they
can and do miss chances at an idle CPU according to trace_printk().

I'm undecided if overall it's boon, bane or even matters, as there is
still an ample supply of wakeup migration, but seems it can indeed
inject wakeup latency needlessly, so <sharpens stick>...

My box booted and neither become exceptionally noisy nor inexplicably
silent in.. oh, minutes now, so surely yours will be perfectly fine.

After one minute of lightly loaded box browsing, trace_printk() said:

  645   - racy peek says there is a room available
   11   - cool, reserved room is free
  206   - no vacancy or wakee pinned
38807   - SIS accommodates room seeker

The below should improve the odds, but high return seems unlikely.

=2D--
 kernel/sched/core.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

=2D-- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3790,7 +3790,13 @@ static int ttwu_runnable(struct task_str
 	rq =3D __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
 		update_rq_clock(rq);
-		if (p->se.sched_delayed)
+		/*
+		 * If wakee is mobile and the room it reserved is occupied, let it try =
to migrate.
+		 */
+		if (p->se.sched_delayed && rq->nr_running > 1 && cpumask_weight(p->cpus=
_ptr) > 1) {
+			dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK)=
;
+			goto out_unlock;
+		} else if (p->se.sched_delayed)
 			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
 		if (!task_on_cpu(rq, p)) {
 			/*
@@ -3802,6 +3808,7 @@ static int ttwu_runnable(struct task_str
 		ttwu_do_wakeup(p);
 		ret =3D 1;
 	}
+out_unlock:
 	__task_rq_unlock(rq, &rf);

 	return ret;



