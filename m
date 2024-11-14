Return-Path: <linux-kernel+bounces-409183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE79C886D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11951281DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206251F8931;
	Thu, 14 Nov 2024 11:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="QSgJSCE6"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E131F80DF
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582471; cv=none; b=tPseBeiP9iTY1IdeeM/MQ2lYaqBd4jVs6lhrabNCpFvdb9Zh3Pwa8G3cf7UTj6XFQ8Jnl6xdVz5z/SuXlbD0H1N/VwWH7Zfikm62aU0SgmobG9UgWJSUzOCzrpk2bX9GglE4krwhxW9ArK9RNxmuaAA98WR8f4opvasTcwEgplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582471; c=relaxed/simple;
	bh=qA8zkd1+vrbVXKr/bpaFiGyX5M8eITuzHSOafFXGmSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nMRhgFviTY8VgwNdhr1xFnXh1/uQxdnTkxOcFX7myQ3xWniJ7VAu/7gADmC6Bms3SKm2C7fHAZg5Bce0MtJHYAJlZE9yfispQQ5ZUrjwpN1RZxJZtr9Ou99y1G8UA4tDvHJM+myatt6chMj2+jKew4H1df7/X2JYtT9lkkzYBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=QSgJSCE6; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731582427; x=1732187227; i=efault@gmx.de;
	bh=j3ult6DVVN70fu7qdOCxtutfm73BPRCatXhV6WQhcJ8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QSgJSCE6oBO5sLyvsTuBlW8TNdidWOKQxBJ91N1Z2pKJe3tBzExjbPfqdbBbJMKh
	 D13SYaeQdstf1mdF3jUfziCdAWqrsAA9XHuaqGWj+GTTFomaOPaURbF00Le7B/cle
	 nkc0+vxdK4vw4OQYrBMO9YBXwzsEGOWBP7eowBKmfeUhgPQ2Ff0dGXaJoIculyLhC
	 U+86LkdXvPFVyNnNbG5cQN3bZsYz44KRmkfhBQlcAGu+vRIThZzGc4jD2bkwNsU3I
	 ovw+2oxym5gx6Cw/GQD+r+0dYE934gijMtkf4ymhGhwCmwiqTAumes88pYRALmz3z
	 LJUlFtqcL8fPcqb8uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.202]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1Hdw-1tEHmD1YhW-00FWUT; Thu, 14
 Nov 2024 12:07:07 +0100
Message-ID: <95ff75cacab4720bbbecd54e881bb94d97087b45.camel@gmx.de>
Subject: Re: [PATCH] sched/fair: Dequeue sched_delayed tasks when waking to
 a busy CPU
From: Mike Galbraith <efault@gmx.de>
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,  rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, 
 youssefesmat@chromium.org, tglx@linutronix.de
Date: Thu, 14 Nov 2024 12:07:03 +0100
In-Reply-To: <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
References: <20241106141420.GZ33184@noisy.programming.kicks-ass.net>
	 <d2b90fa283d1655d73576eb392949d9b1539070d.camel@gmx.de>
	 <bd737a9a498638b253d6e273cbbea108b6c5a4b0.camel@gmx.de>
	 <982456f0abca321b874b7974bdf17d1a605c3d38.camel@gmx.de>
	 <5280774bce7343c43904ae3df4403942092f5562.camel@gmx.de>
	 <20241107140945.GA34695@noisy.programming.kicks-ass.net>
	 <750542452c4f852831e601e1b8de40df4b108d9a.camel@gmx.de>
	 <5a4cb3e4ab698fe2d8419e28d61e292dcd0c8fad.camel@gmx.de>
	 <20241112124117.GA336451@pauld.westford.csb>
	 <0befc9ed8979594d790a8d4fe7ff5c5534c61c3c.camel@gmx.de>
	 <20241112154140.GC336451@pauld.westford.csb>
	 <81de2f710d8922a47364632335ff5ba1a45625b3.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uYVbsA7vvyAEviHQiubJQBxvNgiOYrhCQ3FxKNuwmUaMTz5gNro
 saRSPK6cyH9FtDrz72vYE6etAciAPWCgC9xH5EY+jkD/+3Ugpge2PRG6wQ/ARN8PWDmGh3b
 XVoq0Y4Xh/+budpaOZiPvv7HJoU8w2p48BrcuCV2yW2uCoiRvR7w+Msr9lYO16Yov92NmRv
 PPO34jk0xzB6hbwoh7ZJA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xcYyS/F4+i8=;ua+EqFXQngJA5FaE0xOegFts8uB
 lDaNY78lMFaSvxBIc45mbga0LRRLsfqOZlwL+cQ0D1LbXcfra1c8Ac8ZxKjMfa67gTfBbZpdZ
 M+NTjxzDw6Pzi9zWhsXE02CR+/gaii/t4oLZbkDCkhKAvMir6FRrMgwpbSvV6F2WZHfYGo6sO
 Ghr793dqGCUBP4IlRj4VKz2lckq7c1vEyV1u79Z+DZlcemHAJRDwtBSLtjUguqLDdnzS/sxGS
 3geGF/Cui1CLZ4MuaIE+duWj7i9vskbEDoqo+gVWn/UMzoZ6jVpRI+OPIBNmbb7j6bqC4DJk7
 beD/PdkCTMNh1Dz1iSJB7bEa5RIbApD2H76XPPPAaR7EEFfz62JGU0JSNtCUlWkQcmkiCZVaa
 hwecJuo+1r3Yuu7KxxVUiai5OuQ8N5YopjbowPrtOMxlo8ou9ArJJhGiecJ7YGVQqroCGA3Z3
 rD9RCDDf/arnLBSo8Zd44JEYz85rMDBmJ6k+TvMKgw+cD52b+CmRTgsN7fR6ofvrxruXqi680
 1prumKtmkLibB16YKWIjuFqDgBq0+QByWwbaEglCp74q6CTez8KGiT6XolZY1fpbuJ+JBef8R
 +WkVY5wJF/b7Evcn6zDsffeF1tpMk8ea3NFlONVcFRth66LFEXUU0iObHDeBELGXt0nFLGMuW
 PcWXGwswn8XvSCMEsK6xxeGh4Dm+n8zo43qKWQIWOcMlTPlLFq9LSaSQUh0fDGO+Nb/JQmGFJ
 Z9GJj4z7YVT44xx/4nKCZ6xXvzh9RDwIEv92exIKrlQBlvNPVHQMY77KUfhOjXygF9rzl2VWR
 7WLAVYEaRsb9CkiB5rXvrC/a8mtN7D0zfYwt4eskF2/O4VzE908urOJwsKM1fTVbkmStjw5Ri
 Ic8NSfEQhkpsRpADf3tbEReosLWiKmQT14v102mHXOf2uTHREraxIyqjp

On Tue, 2024-11-12 at 17:15 +0100, Mike Galbraith wrote:
> On Tue, 2024-11-12 at 10:41 -0500, Phil Auld wrote:
> > On Tue, Nov 12, 2024 at 03:23:38PM +0100 Mike Galbraith wrote:
> >
> > >
> > > We don't however have to let sched_delayed block SIS though.=C2=A0 R=
endering
> > > them transparent in idle_cpu() did NOT wreck the progression, so
> > > maaaybe could help your regression.
> > >
> >
> > You mean something like:
> >
> > if (rq->nr_running > rq->h_nr_delayed)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >
> > in idle_cpu() instead of the straight rq->nr_running check?
>
> Yeah, close enough.

The below is all you need.

Watching blockage rate during part of a netperf scaling run without, a
bit over 2/sec was the highest it got, but with, that drops to the same
zero as turning off the feature, so... relevance highly unlikely but
not quite impossible?

=2D--
 kernel/sched/fair.c |    4 ++++
 1 file changed, 4 insertions(+)

=2D-- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9454,11 +9454,15 @@ int can_migrate_task(struct task_struct

 	/*
 	 * We do not migrate tasks that are:
+	 * 0) not runnable (not useful here/now, but are annoying), or
 	 * 1) throttled_lb_pair, or
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 3) running (obviously), or
 	 * 4) are cache-hot on their current CPU.
 	 */
+	if (p->se.sched_delayed)
+		return 0;
+
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;



