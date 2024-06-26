Return-Path: <linux-kernel+bounces-230012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E948A917740
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB171F23787
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC9613A26F;
	Wed, 26 Jun 2024 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="Faw7CNxH"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A5D1369B6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719375731; cv=none; b=Bt6RmDdSS06DtMD59lIgKN8Q1nKurls23QnlhMTTYr4oyVPQQZZ8dpJ53D/LDtAZbIlquQsieffR8L5AZENyYJmRehCnyo1wjQgsUH4Q4peeABiN5r7gTbo404jQrLqWfMpJY957qnfAJ3ccWy7uD8uBaJJXDRjOcYmHEl1eAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719375731; c=relaxed/simple;
	bh=EaZktLajRRvyHFpE3QIK1esnINVHjBE5k1B6PZXacPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j4pmWVzgkBb4FdYfcjoenp73LiM9cXYsZjXtKBp9cUzyCFyrresfTHDAaOlRLQ1KC2+KZVSKImjwt9nfpAJ+oKuqpEaIyg99LZ8mI4OvDKEnp4Iak5MAwv1mt85LXFQH9Jmu7t/SUJCn9HpFzi00gB3MXTxQGchv033Q77YBjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=Faw7CNxH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719375706; x=1719980506; i=efault@gmx.de;
	bh=vNkeRzlAnsB4h0gHPSVJ5VI58BfuNTM0O7Jgl5XoRZM=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Faw7CNxHVjL06T/ub/dgSAmhi1vm0OStsx5RW+CYhvSC9n+5NCRxjXFeaoqhY+34
	 3tle+k1IvOIa2vX0EvhGoQAnkkhwjaDaf9Tf+Y85M0PI7S8VGdDEaHIG06oAdKEVW
	 HTTl3MybELGqDq90AjhJeLh/4Xypqz9UblA8VukMz1TzgRVTmeE7x6Q0YyyiQIaJq
	 g+rRVLYGcXUS0rD/bJbXUzZ2V4NlU1GSPCQisD/eRQVdYUA0Oe6C/pVYn/VZM61rV
	 z9N5VOWS9ANvOWdgmn85m5R92LBhguFsFdfrMyrDEtZzn4G4O7IS6DqHR/n+AD+Tt
	 E9Wl0xmef7vkTnsd9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.148.24]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MO9z7-1rxuS03GkD-00SYnf; Wed, 26
 Jun 2024 06:21:45 +0200
Message-ID: <d922f7bf3965f4eaef5028177b886e2e1861742d.camel@gmx.de>
Subject: Re: [PATCH 1/2] sched/fair: Record the average duration of a task
From: Mike Galbraith <efault@gmx.de>
To: Chen Yu <yu.c.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>
Cc: Tim Chen <tim.c.chen@intel.com>, Yujie Liu <yujie.liu@intel.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, "Gautham R . Shenoy"
 <gautham.shenoy@amd.com>, Chen Yu <yu.chen.surf@gmail.com>,
 linux-kernel@vger.kernel.org
Date: Wed, 26 Jun 2024 06:21:43 +0200
In-Reply-To: <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
References: <cover.1719295669.git.yu.c.chen@intel.com>
	 <338ec61022d4b5242e4af6d156beac53f20eacf2.1719295669.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0G69A3SY4smZ7S/V5R+aWzVl0tYNrekhwDH1m2uGE9JwD3aF3ex
 cBlqcaDr0mfX8QsEXFrCU3J21UmWh5HLy14nSRabbZEuR2Ka360AeL+ObOa+eoOHb0UOaQ0
 8knuXDMgm1zw02P3uyE/K/fBcrLotcudzmVd8gUabYgAJpEtHCWnRZVvB743Z/MSgGTd3PT
 PcCcDyVUxpbwM0kwTlThA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WhZ+G0NFKEs=;wkgrSNijbyTU6Ubl8u/9//c34XM
 6i/VthvQb3RomVK286MFutMG2VrPPJ2QixCzd6BNUthqEe1kLCczr80J6rohweJSuKIqECkrN
 y9hCDfy7Nfh+vLJJyXO4l7UV799fUnGVeltQdp1gUXN6UTl/fO/9h8zBbwoAh40r1MYdsLpiD
 MP03gyCdWREF+FzKsAWvPzquOKAT2EG9Ka9lkRlHFBAPGW1OwV88C2Z/LSqFeAz6Lt020pHdO
 kbVuZfIWMozweueWoOTFLRzuLI23GvlhTJgIqfzhFTX1T5bZvpuGcDqomNhbi/poxxxRgD7Ww
 h7WllGZWIck7quJzu5C29xfpeCYzIq6bCNSUSG605lIW9xSSZoU2+RKmj8FL5/cMsf0/buAgZ
 8UDIH/omUYjbtAFruiuMu5cnM0LbS1vPiDf4zS9sOYPATJfxm+pqW9AcvMfbeZjyyQSDBrANK
 CRTJC/n4D5ueHM8Tw9f9Qw4CWYyn0mhB96ofdoptRUTR3R0AsX1tA2NPkGCi5H3hv/J3KXQVO
 JYgiMXKl98ymltX8vEZm8QqcgVSxqZPVHQ4pvmepg9b46hU8qzli9A8lA7xhSJfva0279xvQj
 PbVnbH4VbUIh0sPwmPpy+1PPtPFQWbebOeWFcibIyM2N1cGvf+uNpugCfCp0mKyO812wM1WXJ
 DqZyH1ejuGLp6aJBSVH39ynXf4BGW3FhjfWRmb63u1IPrnWUNS53S5jyH+4988AyMn4uR0Tjh
 347QIdsAPQDi26NL6WqK2jNbMBKSdoM/zCxT5Ps2TtxwBm9/d7tmBYGq2Oj9cmIcNQJx3g5Ub
 h9f506nZJcb/u+zPpvg7rxk245iih9ON1VAn+kdOIQO8Y=

On Tue, 2024-06-25 at 15:22 +0800, Chen Yu wrote:
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..7399c4143528 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4359,6 +4359,8 @@ static void __sched_fork(unsigned long clone_flags=
, struct task_struct *p)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->migration_pending =3D=
 NULL;
> =C2=A0#endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0init_sched_mm_cid(p);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->prev_sleep_sum_runtime =3D=
 0;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p->duration_avg =3D 0;
> =C2=A0}

Beginning life biased toward stacking?
 =C2=A0
> =C2=A0DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41b58387023d..445877069fbf 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
>
> @@ -6905,6 +6914,9 @@ static void dequeue_task_fair(struct rq *rq, struc=
t task_struct *p, int flags)
> =C2=A0
> =C2=A0dequeue_throttle:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0util_est_update(&rq->cfs=
, p, task_sleep);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (task_sleep)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dur_avg_update(p);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0hrtick_update(rq);
> =C2=A0}
>

That qualifier looks a bit dangerous.  Microbench components tend to
have only one behavior, but the real world goes through all kinds of
nutty gyrations, intentional and otherwise.

The heuristics in the next patch seem to exhibit a healthy level of
paranoia, but these bits could perhaps use a tad more.  Bad experiences
springs to mind when I stare at that - sleepers going hog, hogs meet
sleeping lock contention, preemption, sync hint not meaning much...

	-Mike

