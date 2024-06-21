Return-Path: <linux-kernel+bounces-224807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85164912710
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A826B1C260DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAAE63B9;
	Fri, 21 Jun 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6SsWb6l"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C8F4FA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718978066; cv=none; b=kSznMlBzJf9T8JlKbaWKeKR1UvQjiDRt8FgJmTRBXaN37skCb816VF22qXXCy9Ov25JGF6U2QzwoiIjA7gkJNJGs0NY/4hof202QztrqbA69iBX85K6ZMw4dNNriAMfIeY9wg5ElOJUDRccR35n1TuQLG9qNhLfl8ooEjTENREY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718978066; c=relaxed/simple;
	bh=6Uk9cpcOm4AdyLPz3ASTp7EH4Xo3vsplJVAa0wuVlYo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Jlie2RaPk+m7X/XhKv1kvmPTTi1yFINhldiz6MDRVbtUKF0YXYTiHvCQFJj5QgJe4ZwXlPsQ6tEzbeWHs30speIBsyeDozQmcpojvXW+lg3g5L0TKP2vYyoRJLWzlttKdKpj/awdImG/BIHYlZFm5D49WZC0FTPCMK4yHDcHArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6SsWb6l; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52cd717ec07so687598e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718978062; x=1719582862; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4n5M8UKGetewMNe8T2wUEWODtcK2qjS9mHMj2LaenA=;
        b=C6SsWb6l6+OOlP8srZCjXln/nwftH2skSuaSgrb4NGDvyoAqAFNvl3Xr03QtdkZipx
         LrtfzjvsEl2r3nI9Ny6vI3Jd6XPljqg+nKeja/Nc5j9a0iAGVOEuEKyRedPEgZT4vl4i
         lxaRvA+GNSHgQVF2mrANoNl1fRy9W7aTP1HvolDnCWYheHqsCySPylU2GYyVBt2a3pPn
         pQtbTSp6IsrkmnVa5WvUdxGiYO6s9Fmuory1m4+4tt4I3NcWzivnAUwqfadZUDv2mRe5
         cO9sNJ2FBBmqxP8CyIe3jgSgDx1mBYJTEZ6cYGemDop5g5x7C2surmq4GrbgIfygQhIZ
         Y8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718978062; x=1719582862;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4n5M8UKGetewMNe8T2wUEWODtcK2qjS9mHMj2LaenA=;
        b=FCyNMBDY5FxX+Okpxi0k/csRv8HVoceIEvmffhKq5yeyGYDBFRKotdiVajsUbYZ2BU
         qeC7iB/B5GltbAXgN9Di4LzMl2+EodClClVUprHus6lvx9XxUCeEKpHQNKExCjTyspmN
         J94PJ7ZuP3bsqs1/aCzBJ50fdw+N0PmH2l3wHnP3XOFC2dPEmXSDJS6o0GxwAFtlX1xv
         O7735d9MFB2RO3SXfK9UCvV/wIJk29RI3Hg5j21xly3o+2xWsvZnsCG7b87YwGODB+6f
         udMetVmYywiV2+10b5J2+XD2fZ9eXNj+niyywa7yuvFMn7vRvc6JDjTG3nlVmk4BmQtM
         OQ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaFfeuJuNd/soSjZ/5NNYt8LTf8Gmaj3u2P90hxvUrcsm7KEbKHoMLl+qvZJirvxk+Vv+T/Ki0EDD1Ex8rVbLAENhRP0A8YxMIbEkn
X-Gm-Message-State: AOJu0YwoVuGp4NsX3LPNC8hkHiEuTnPSZATEeLE1HpJLYdRF0vbznfyF
	T/pfRdTioZAg1uVteUF7utRwyh5a7ulp/KyPyrR7zWEzwqUYrUP5
X-Google-Smtp-Source: AGHT+IELCbtyX2mUx+64i/em7hl1z7vgiCuSLNpXqkDQ4KgPAc2XFUwZ37bYqxFX3QWBAla8eazpBQ==
X-Received: by 2002:a05:6512:3248:b0:52c:9846:3b8c with SMTP id 2adb3069b0e04-52ccaa6a01amr4962295e87.41.1718978062135;
        Fri, 21 Jun 2024 06:54:22 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf42a666sm87330566b.25.2024.06.21.06.54.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 06:54:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v3] sched/fair: Preempt if the current process is
 ineligible
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <20240620125155.GY31592@noisy.programming.kicks-ass.net>
Date: Fri, 21 Jun 2024 21:53:58 +0800
Cc: mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 Chen Yu <yu.c.chen@intel.com>,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 efault@gmx.de,
 kprateek.nayak@amd.com,
 jameshongleiwang@126.com,
 yangchen11@lixiang.com,
 zangchunxin@lixiang.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B4C4FA2-C261-4723-ABA4-2EF3CBBB2C0E@gmail.com>
References: <20240613131437.9555-1-spring.cxz@gmail.com>
 <20240620125155.GY31592@noisy.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jun 20, 2024, at 20:51, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Jun 13, 2024 at 09:14:37PM +0800, Chunxin Zang wrote:
>> ---
>> kernel/sched/fair.c | 28 +++++++++++++++++++++-------
>> 1 file changed, 21 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 03be0d1330a6..21ef610ddb14 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -745,6 +745,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>> return vruntime_eligible(cfs_rq, se->vruntime);
>> }
>>=20
>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>> +{
>> + if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <=3D 1 ||
>> +    entity_eligible(cfs_rq, se))
>> + return false;
>> +
>> + return true;
>> +}
>> +
>> static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
>> {
>> u64 min_vruntime =3D cfs_rq->min_vruntime;
>> @@ -974,11 +983,13 @@ static void clear_buddies(struct cfs_rq =
*cfs_rq, struct sched_entity *se);
>> /*
>>  * XXX: strictly: vd_i +=3D N*r_i/w_i such that: vd_i > ve_i
>>  * this is probably good enough.
>> + *
>> + * return true if se need preempt
>>  */
>> -static void update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>> +static bool update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>> {
>> if ((s64)(se->vruntime - se->deadline) < 0)
>> - return;
>> + return false;
>>=20
>> /*
>> * For EEVDF the virtual time slope is determined by w_i (iow.
>> @@ -995,10 +1006,7 @@ static void update_deadline(struct cfs_rq =
*cfs_rq, struct sched_entity *se)
>> /*
>> * The task has consumed its request, reschedule.
>> */
>> - if (cfs_rq->nr_running > 1) {
>> - resched_curr(rq_of(cfs_rq));
>> - clear_buddies(cfs_rq, se);
>> - }
>> + return true;
>> }
>>=20
>> #include "pelt.h"
>> @@ -1157,6 +1165,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>> {
>> struct sched_entity *curr =3D cfs_rq->curr;
>> s64 delta_exec;
>> + bool need_preempt;
>>=20
>> if (unlikely(!curr))
>> return;
>> @@ -1166,12 +1175,17 @@ static void update_curr(struct cfs_rq =
*cfs_rq)
>> return;
>>=20
>> curr->vruntime +=3D calc_delta_fair(delta_exec, curr);
>> - update_deadline(cfs_rq, curr);
>> + need_preempt =3D update_deadline(cfs_rq, curr);
>> update_min_vruntime(cfs_rq);
>>=20
>> if (entity_is_task(curr))
>> update_curr_task(task_of(curr), delta_exec);
>>=20
>> + if (need_preempt || check_entity_need_preempt(cfs_rq, curr)) {
>> + resched_curr(rq_of(cfs_rq));
>> + clear_buddies(cfs_rq, curr);
>> + }
>> +
>> account_cfs_rq_runtime(cfs_rq, delta_exec);
>> }
>=20
> Yeah sorry no. This will mess up the steady state schedule. At best we
> can do something like the below which will make PREEMPT_SHORT a little
> more effective I suppose.
>=20
>=20
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -985,10 +985,10 @@ static void clear_buddies(struct cfs_rq
>  * XXX: strictly: vd_i +=3D N*r_i/w_i such that: vd_i > ve_i
>  * this is probably good enough.
>  */
> -static void update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
> +static bool update_deadline(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
> {
> if ((s64)(se->vruntime - se->deadline) < 0)
> - return;
> + return false;
>=20
> /*
> * For EEVDF the virtual time slope is determined by w_i (iow.
> @@ -1005,10 +1005,7 @@ static void update_deadline(struct cfs_r
> /*
> * The task has consumed its request, reschedule.
> */
> - if (cfs_rq->nr_running > 1) {
> - resched_curr(rq_of(cfs_rq));
> - clear_buddies(cfs_rq, se);
> - }
> + return true;
> }
>=20
> #include "pelt.h"
> @@ -1168,6 +1165,8 @@ static void update_curr(struct cfs_rq *c
> {
> struct sched_entity *curr =3D cfs_rq->curr;
> s64 delta_exec;
> + struct rq *rq;
> + bool resched;
>=20
> if (unlikely(!curr))
> return;
> @@ -1177,13 +1176,23 @@ static void update_curr(struct cfs_rq *c
> return;
>=20
> curr->vruntime +=3D calc_delta_fair(delta_exec, curr);
> - update_deadline(cfs_rq, curr);
> + resched =3D update_deadline(cfs_rq, curr);
> update_min_vruntime(cfs_rq);
>=20
> if (entity_is_task(curr))
> update_curr_task(task_of(curr), delta_exec);
>=20
> account_cfs_rq_runtime(cfs_rq, delta_exec);
> +
> + rq =3D rq_of(cfs_rq);
> + if (rq->nr_running =3D=3D 1)
> + return;
> +
> + if (resched ||
> +    (curr->vlag !=3D curr->deadline && !entity_eligible(cfs_rq, =
curr))) {
> + resched_curr(rq);
> + clear_buddies(cfs_rq, curr);
> + }
> }
>=20
> static void update_curr_fair(struct rq *rq)

Hi peter

Got it. If I understand correctly, modifications to basic interfaces =
like update_curr
should be appropriate and not too aggressive. Additionally, these =
changes have
already shown significant improvements in scheduling delay (test results =
are at the
end). How about we limit this patch to these changes for now? Actually, =
I also want
to try a more aggressive preemption under NO_RUN_TO_PARITY, but it might =
be
better to consider this comprehensively after integrating the changes =
from your
latest branch.


Comparison of this modification with the mainline EEVDF in cyclictest.

                                 EEVDF      PATCH  EEVDF-NO_PARITY  =
PATCH-NO_PARITY

  LNICE(-19)    # Avg Latencies: 00191      00162      00089      00080

  LNICE(0)      # Avg Latencies: 00466      00404      00289      00285

  LNICE(19)     # Avg Latencies: 37151      38781      18293      19315

thanks=20
Chunxin




