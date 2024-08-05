Return-Path: <linux-kernel+bounces-274644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D0947B01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158DB1C20AAB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA428158A15;
	Mon,  5 Aug 2024 12:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUwFZmet"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40676158877
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860685; cv=none; b=Rp0TusiBaJwaMRtvPgVKTcJsxC30gAvKenArTnQ8YYVc+8yO+wjY9RN/WsNXH+UsaKTexJZFgEW1twgxcRIdgrlQ1EEoEKSOxUz1xe4G9JGlWOcH6qhHUFlwQynqUWrrIGUteC0CUxA3nWBi3mom08JinVPN6iIRH9Q4A5SsDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860685; c=relaxed/simple;
	bh=+BKAp62oodYSoD3VpJ2R2gz1qTpHNvqq5ELkq+akqkA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=A5HFgPg6/CD8yXEzakyFH3aTBPW7eQ3CKpnm8cY34xTjZiPNCGcrjPPov7A45wFn4NbuqszgKb+H02VmKQdJgLgk1sudblzhEmCwqgMdEIo+sSsSF0AxSa2+ClH4cVsWUyadA8wDsecus1hSteW8Ekj7nOjMzCD4m28SQDFgNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUwFZmet; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a20b8fa6dcso322740385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722860683; x=1723465483; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yENhCzzX+FLqQ742gRj2htbWMm55cM9TEHxlrjk1nzk=;
        b=ZUwFZmetVMQGCSQy7kE8I2dOqXLOOiKK0J7I+X7AIekZ/Tx+mUVJBEkFRC02aJ2VFa
         emPjSTsA1l4LoqWyZiTMOylhnHBh5uzkZNjgidjcTrOs8OHTCDIeb0lv6fV9044byP+Z
         s4hbtwEX6Ba+SK+Qcs/gVyDOqMwLjqqoq3/2pt0bRNHlVqFZ5F6VOiFvMbBy9YeNU7LR
         8vZ6VeZQRgZvip4frRdE3iarBesNBSXKIQmWhH3NmkHVqCSZQmoTl5Lc5uQIDUtNp1ll
         I1phiU4Wjgvoa0dqYFYW+bx4qZv16Tp9Dx40/lo20jwK0/a5SFJ6Hoe826zQpLIljhUV
         pH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722860683; x=1723465483;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yENhCzzX+FLqQ742gRj2htbWMm55cM9TEHxlrjk1nzk=;
        b=ln2TjD5jJgteti7U6fKV8W/PM0yUiL7fGWc02gNuSuBYMgfA/2sU4pemLSkAyFDdjc
         njYjtOX0syFuTSWA5cOBHmDJCB6xcRMiz9k/r4/KSvY2ejGgcPk+GHEaYk8tPCI3UQKT
         3NYDMsPH51otyIAVWZUo1y7Ast6AnPmZUiHJ/0otJGjhhW5hIeE1+ITfU09m9lP/gQgk
         MS2IgoQnL0337e8qX9EU0W5mcriFHREm5EDGT3MiUK86DUilXTjNAL9gCD8Sp9r1NYXI
         lL3ak6iLomdWLbyp1ayELC9ctHaHn7mwPKwEywc3aYGc53L7v3rI6DIDSqnm8jbg3WMI
         R9nw==
X-Forwarded-Encrypted: i=1; AJvYcCWMDdvKuteLoq8ZNZrzNPRtazabHXkTBGFDpzU97u/eVmU+IKSxIoypOBe2reumL7CneNnScAB65eoYfGPOXbLw35CV9WwLoe3rrGG9
X-Gm-Message-State: AOJu0YxqY1m9U6tnvPs4tJtWaKkaqQJtWE8jkq7XC5JREyDFy9sacTid
	b0nskBjxcIB+wfHgV4X7aWFYOh1n3UaMwYeLmBTFodE7RDUIfRwN
X-Google-Smtp-Source: AGHT+IHY0NC79tsozaYs5g1vWHwTMdOSjey2wziWYNMNC+isUoXPg8FUldoVGkoznRlLPg/5ujiG2g==
X-Received: by 2002:a05:620a:3714:b0:7a2:d73:ae7d with SMTP id af79cd13be357-7a34efdd0f1mr1392502985a.59.1722860682807;
        Mon, 05 Aug 2024 05:24:42 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dc894sm346714085a.4.2024.08.05.05.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2024 05:24:42 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 21/24] sched/eevdf: Allow shorter slices to wakeup-preempt
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <20240727105030.735459544@infradead.org>
Date: Mon, 5 Aug 2024 20:24:24 +0800
Cc: mingo@redhat.com,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 Mike Galbraith <efault@gmx.de>,
 Mike Galbraith <umgwanakikbuti@gmail.com>,
 Chunxin Zang <zangchunxin@lixiang.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1955C728-8266-41B6-92CA-CD0A13A0B79C@gmail.com>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.735459544@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jul 27, 2024, at 18:27, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> Part of the reason to have shorter slices is to improve
> responsiveness. Allow shorter slices to preempt longer slices on
> wakeup.
>=20
>   Task                  |   Runtime ms  | Switches | Avg delay ms    | =
Max delay ms    | Sum delay ms     |
>=20
> 100ms massive_intr 500us cyclictest NO_PREEMPT_SHORT
>=20
> 1 massive_intr:(5)      | 846018.956 ms |   779188 | avg:   0.273 ms | =
max:  58.337 ms | sum:212545.245 ms |
> 2 massive_intr:(5)      | 853450.693 ms |   792269 | avg:   0.275 ms | =
max:  71.193 ms | sum:218263.588 ms |
> 3 massive_intr:(5)      | 843888.920 ms |   771456 | avg:   0.277 ms | =
max:  92.405 ms | sum:213353.221 ms |
> 1 chromium-browse:(8)   |  53015.889 ms |   131766 | avg:   0.463 ms | =
max:  36.341 ms | sum:60959.230  ms |
> 2 chromium-browse:(8)   |  53864.088 ms |   136962 | avg:   0.480 ms | =
max:  27.091 ms | sum:65687.681  ms |
> 3 chromium-browse:(9)   |  53637.904 ms |   132637 | avg:   0.481 ms | =
max:  24.756 ms | sum:63781.673  ms |
> 1 cyclictest:(5)        |  12615.604 ms |   639689 | avg:   0.471 ms | =
max:  32.272 ms | sum:301351.094 ms |
> 2 cyclictest:(5)        |  12511.583 ms |   642578 | avg:   0.448 ms | =
max:  44.243 ms | sum:287632.830 ms |
> 3 cyclictest:(5)        |  12545.867 ms |   635953 | avg:   0.475 ms | =
max:  25.530 ms | sum:302374.658 ms |
>=20
> 100ms massive_intr 500us cyclictest PREEMPT_SHORT
>=20
> 1 massive_intr:(5)      | 839843.919 ms |   837384 | avg:   0.264 ms | =
max:  74.366 ms | sum:221476.885 ms |
> 2 massive_intr:(5)      | 852449.913 ms |   845086 | avg:   0.252 ms | =
max:  68.162 ms | sum:212595.968 ms |
> 3 massive_intr:(5)      | 839180.725 ms |   836883 | avg:   0.266 ms | =
max:  69.742 ms | sum:222812.038 ms |
> 1 chromium-browse:(11)  |  54591.481 ms |   138388 | avg:   0.458 ms | =
max:  35.427 ms | sum:63401.508  ms |
> 2 chromium-browse:(8)   |  52034.541 ms |   132276 | avg:   0.436 ms | =
max:  31.826 ms | sum:57732.958  ms |
> 3 chromium-browse:(8)   |  55231.771 ms |   141892 | avg:   0.469 ms | =
max:  27.607 ms | sum:66538.697  ms |
> 1 cyclictest:(5)        |  13156.391 ms |   667412 | avg:   0.373 ms | =
max:  38.247 ms | sum:249174.502 ms |
> 2 cyclictest:(5)        |  12688.939 ms |   665144 | avg:   0.374 ms | =
max:  33.548 ms | sum:248509.392 ms |
> 3 cyclictest:(5)        |  13475.623 ms |   669110 | avg:   0.370 ms | =
max:  37.819 ms | sum:247673.390 ms |
>=20
> As per the numbers the, this makes cyclictest (short slice) it's
> max-delay more consistent and consistency drops the sum-delay. The
> trade-off is that the massive_intr (long slice) gets more context
> switches and a slight increase in sum-delay.
>=20
> [mike: numbers]
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> ---
> kernel/sched/fair.c     |   64 =
++++++++++++++++++++++++++++++++++++++++++------
> kernel/sched/features.h |    5 +++
> 2 files changed, 61 insertions(+), 8 deletions(-)
>=20
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -973,10 +973,10 @@ static void clear_buddies(struct cfs_rq
> * XXX: strictly: vd_i +=3D N*r_i/w_i such that: vd_i > ve_i
> * this is probably good enough.
> */
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
> @@ -993,10 +993,7 @@ static void update_deadline(struct cfs_r
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
> @@ -1134,6 +1131,38 @@ static inline void update_curr_task(stru
> dl_server_update(p->dl_server, delta_exec);
> }
>=20
> +static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct =
sched_entity *curr)
> +{
> + if (!sched_feat(PREEMPT_SHORT))
> + return false;
> +
> + if (curr->vlag =3D=3D curr->deadline)
> + return false;
> +
> + return !entity_eligible(cfs_rq, curr);
> +}

Hi perter=20

Can this be made more aggressive here? Something like , in the =
PREEMPT_SHORT
+ NO_RUN_TO_PARITY combination, it could break the first deadline of the =
current
task. This can achieve better latency benefits in certain embedded =
scenarios, such as
high-priority periodic tasks.

+static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct =
sched_entity *curr)
+{
+ if (!sched_feat(PREEMPT_SHORT))
+ return false;
+
+ if (sched_feat(RUN_TO_PARITY) && curr->vlag =3D=3D curr->deadline)
+ return false;
+
+ return !entity_eligible(cfs_rq, curr);
+}

Additionally, if possible, could you please include my name in this =
patch? I spent over a
month finding this solution and conducting the tests, and I hope to =
leave some trace of
my efforts during that time. This is also one of the reasons why I love =
Linux and am eager
to contribute to open source. I would be extremely grateful.
https://lore.kernel.org/lkml/20240613131437.9555-1-spring.cxz@gmail.com/

thanks
Chunxin


> +
> +static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
> +    struct sched_entity *pse, struct sched_entity *se)
> +{
> + if (!sched_feat(PREEMPT_SHORT))
> + return false;
> +
> + if (pse->slice >=3D se->slice)
> + return false;
> +
> + if (!entity_eligible(cfs_rq, pse))
> + return false;
> +
> + if (entity_before(pse, se))
> + return true;
> +
> + if (!entity_eligible(cfs_rq, se))
> + return true;
> +
> + return false;
> +}
> +
> /*
> * Used by other classes to account runtime.
> */
> @@ -1157,6 +1186,7 @@ static void update_curr(struct cfs_rq *c
> struct sched_entity *curr =3D cfs_rq->curr;
> struct rq *rq =3D rq_of(cfs_rq);
> s64 delta_exec;
> + bool resched;
>=20
> if (unlikely(!curr))
> return;
> @@ -1166,7 +1196,7 @@ static void update_curr(struct cfs_rq *c
> return;
>=20
> curr->vruntime +=3D calc_delta_fair(delta_exec, curr);
> - update_deadline(cfs_rq, curr);
> + resched =3D update_deadline(cfs_rq, curr);
> update_min_vruntime(cfs_rq);
>=20
> if (entity_is_task(curr)) {
> @@ -1184,6 +1214,14 @@ static void update_curr(struct cfs_rq *c
> }
>=20
> account_cfs_rq_runtime(cfs_rq, delta_exec);
> +
> + if (rq->nr_running =3D=3D 1)
> + return;
> +
> + if (resched || did_preempt_short(cfs_rq, curr)) {
> + resched_curr(rq);
> + clear_buddies(cfs_rq, curr);
> + }
> }
>=20
> static void update_curr_fair(struct rq *rq)
> @@ -8611,7 +8649,17 @@ static void check_preempt_wakeup_fair(st
> cfs_rq =3D cfs_rq_of(se);
> update_curr(cfs_rq);
> /*
> - * XXX pick_eevdf(cfs_rq) !=3D se ?
> + * If @p has a shorter slice than current and @p is eligible, =
override
> + * current's slice protection in order to allow preemption.
> + *
> + * Note that even if @p does not turn out to be the most eligible
> + * task at this moment, current's slice protection will be lost.
> + */
> + if (do_preempt_short(cfs_rq, pse, se) && se->vlag =3D=3D =
se->deadline)
> + se->vlag =3D se->deadline + 1;
> +
> + /*
> + * If @p has become the most eligible task, force preemption.
> */
> if (pick_eevdf(cfs_rq) =3D=3D pse)
> goto preempt;
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -18,6 +18,11 @@ SCHED_FEAT(PLACE_REL_DEADLINE, true)
> * 0-lag point or until is has exhausted it's slice.
> */
> SCHED_FEAT(RUN_TO_PARITY, true)
> +/*
> + * Allow wakeup of tasks with a shorter slice to cancel RESPECT_SLICE =
for
> + * current.
> + */
> +SCHED_FEAT(PREEMPT_SHORT, true)
>=20
> /*
> * Prefer to schedule the task we woke last (assuming it failed
>=20
>=20
>=20


