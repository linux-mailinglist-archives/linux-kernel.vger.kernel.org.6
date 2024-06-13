Return-Path: <linux-kernel+bounces-213360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB5790742B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3281F23681
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE06D145323;
	Thu, 13 Jun 2024 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmdgCDO+"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8A26AF1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286402; cv=none; b=MHwDqD02mMq/eaO2cfPsDl9kp8m9WU8Rzl81CWAAEHcjRq1Xvy3NMrNuu4LrjO4tPkPlubO/pWC6IYOgtJiY+XjJ0o1DvRJY2J5tz4ClhkcB/4wySp7+d2Ofl2y3ePJbgHflgK0E8kIOTXsm73z471pa8KVFrx2sGIsOCxgF2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286402; c=relaxed/simple;
	bh=oP1spO3fFb//giJecXJAXY7exbAQza4adDESaxV0NLs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BGafPYcyVgxUGOD13WB00yMQFM3s550OVhRWA0WqW9BtUMZCHX+ITkg/LsFRFdQtPB12ga1mYHkqM/cJAqRiGClkeOGbGUO38x1erCL9i9wBVqsNa1t4PyZJmPd+RzNa0P3HbtWwTmpkNDFumudVYpWTKVZtAfYCN582NfOwcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmdgCDO+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6f96f8489feso608011a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286399; x=1718891199; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+PAaGurCK53XLDrRPGSFXkgAfT6gdmkYQ/VaMNIQcA=;
        b=bmdgCDO+fxVLkOQ1waaH0BFc4P8hXBh+kDyOHhmzmSGSbp20hM4pwrUkaioelsXQ/V
         yMDx6skArvW47kXnL+20Xxa/FiEBvjRlyXfdLxCBvPJ8Da+B0faFVwTbM4ZQpoKC98j9
         UgMxG8NXwjDIFr7oeqxlOi3yu5JKxpbJer+D41y3/YEkbuAG6JvwnxkVitWE+jUsLONk
         Knt6PIsR3u78JrhDWdP6PQRXfq+4TIoz6UwmYA/xy+jQ59q23OioX/EoYhY2SFzJYI3z
         ARcs6p7MaYGR6xjgjsXWu+LRMe+b3qAJStPRlXnBaUWuFcnPZ4fZCyKhi00pAkcAbe/1
         0ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286399; x=1718891199;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+PAaGurCK53XLDrRPGSFXkgAfT6gdmkYQ/VaMNIQcA=;
        b=pZ5b18PeYfIeFU/FIYtT1POBVJ9xfrYsuouT+4qyf8J9g11uJLUijd14fGz/lWYyr4
         IuQZJPurIPQX/KXOaobJW2yhm5gMexywppbEBAMhF9F5hgevKsbmKzMqOxUWalWWzIBr
         ex98Ruj5BGcLwkJTkHwEP+h5j9YWl/NMvlonQVeYdiILYe+ef+4drhiBHzMgxmp8pht9
         QozdM+HxLZIn6nJ/S7J8r32jnhrRqOzPZ0JqJVkoPpTHfHyd93Ae/HEHApbZjIiGw2wn
         weKH13z4oqeQOOfp86wUYr/grpbEHsuDkX0+z0LgVVWlWQyttkRduONGJvRwW/MZNaw9
         3Cyw==
X-Forwarded-Encrypted: i=1; AJvYcCWJQtCPkiMtrGPneuNUeQxwyjgW9MEj9cYAmxMmuwwduPJ7QIFvqcytaobEZEubm3hdvZ2v1BGMR17BmlY+61kFfMNWG4tcxezr32Zl
X-Gm-Message-State: AOJu0YyQyF/YosgvfKO3O5GOTB3cbkcUZNzOxwdUaTpLKSPQeEOs499o
	mtl+f69p76Uo+2gKpFxoqvdm4oGFKMtR8mIs2yWVf7FmBCh4xIaQ
X-Google-Smtp-Source: AGHT+IGXPE7FgI09FX5iZpBz8AqBiP4R43ig/vQaleNrLEM7HMoolyxN5AqeNOvT3tEy0WODf6YyFg==
X-Received: by 2002:a9d:7cc5:0:b0:6fa:e19:6c01 with SMTP id 46e09a7af769-6fa1c222ca6mr4927376a34.29.1718286399552;
        Thu, 13 Jun 2024 06:46:39 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441f2ff9418sm6239301cf.86.2024.06.13.06.46.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2024 06:46:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH v2] sched/fair: Reschedule the cfs_rq when current is
 ineligible
From: Chunxin Zang <spring.cxz@gmail.com>
In-Reply-To: <ZmryuDqw2fEhHNni@chenyu5-mobl2>
Date: Thu, 13 Jun 2024 21:46:13 +0800
Cc: Honglei Wang <jameshongleiwang@126.com>,
 mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 Mike Galbraith <efault@gmx.de>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 linux-kernel@vger.kernel.org,
 yangchen11@lixiang.com,
 Jerry Zhou <zhouchunhua@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAE80459-55EE-4BE5-B41D-8F68337782A4@gmail.com>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
 <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
 <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
 <Zmrd2hwqHB8RQjqB@chenyu5-mobl2>
 <112FECA8-5D21-406F-814C-ACBE63351CBB@gmail.com>
 <ZmryuDqw2fEhHNni@chenyu5-mobl2>
To: Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jun 13, 2024, at 21:23, Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> On 2024-06-13 at 20:02:37 +0800, Chunxin Zang wrote:
>>=20
>>=20
>>> On Jun 13, 2024, at 19:54, Chen Yu <yu.c.chen@intel.com> wrote:
>>>=20
>>> On 2024-06-12 at 18:39:11 +0800, Chunxin Zang wrote:
>>>>=20
>>>>=20
>>>>> On Jun 7, 2024, at 13:07, Chen Yu <yu.c.chen@intel.com> wrote:
>>>>>=20
>>>>> On 2024-05-29 at 22:18:06 +0800, Chunxin Zang wrote:
>>>> The purpose of the modification is to increase preemption =
opportunities without breaking the
>>>> RUN_TO_PARITY rule. However, it clearly introduces some additional =
preemptions, or perhaps
>>>> there should be a check for the eligibility of the se. Also, to =
avoid overwriting the scheduling
>>>> strategy in entity_tick, would a modification like the following be =
more appropriate?
>>>>=20
>>>=20
>>> I wonder if we can only take care of the NO_RUN_TO_PARITY case? =
Something like this,
>>>=20
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 03be0d1330a6..5e49a15bbdd3 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -745,6 +745,21 @@ int entity_eligible(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>>>>       return vruntime_eligible(cfs_rq, se->vruntime);
>>>> }
>>>>=20
>>>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>>>> +{
>>> if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <=3D 1 ||
>>>    !entity_eligible(cfs_rq, se))
>>> return false;
>>>=20
>>> return true;
>>>=20
>>> Thoughts?
>>>=20
>>=20
>> This does indeed look better. In that case, do I need to make the =
changes this way and send
>> out a version 3?
>=20
> If you mean the following changes, maybe we can continue the =
discussion here.
> This is just my 2 cents, not sure what others think of it. Anyway, I =
can launch some tests.

Since the latest changes are completely different from version 2, so I =
have just released version 3.
Additionally, my testing environment is limited, and it indeed requires =
more testing to verify the
benefits it can provide. If possible, could you conduct tests using =
version 3?
=
https://lore.kernel.org/lkml/20240613131437.9555-1-spring.cxz@gmail.com/T/=
#u

thanks=20
Chunxin

>=20
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 8a5b1ae0aa55..c0fdb25f0695 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -744,6 +744,15 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
> return vruntime_eligible(cfs_rq, se->vruntime);
> }
>=20
> +static bool check_curr_preempt(struct cfs_rq *cfs_rq, struct =
sched_entity *curr)
> +{
> + if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <=3D 1 ||
> +    !entity_eligible(cfs_rq, curr))
> + return false;
> +
> + return true;
> +}
> +
> static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
> {
> u64 min_vruntime =3D cfs_rq->min_vruntime;
> @@ -5536,6 +5545,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct =
sched_entity *curr, int queued)
> hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
> return;
> #endif
> +
> + if (check_curr_preempt(cfs_rq, curr))
> + resched_curr(rq_of(cfs_rq));
> }
>=20
>=20
> @@ -8415,7 +8427,7 @@ static void check_preempt_wakeup_fair(struct rq =
*rq, struct task_struct *p, int
> /*
> * XXX pick_eevdf(cfs_rq) !=3D se ?
> */
> - if (pick_eevdf(cfs_rq) =3D=3D pse)
> + if (check_curr_preempt(cfs_rq, se) || pick_eevdf(cfs_rq) =3D=3D pse)
> goto preempt;
>=20
> return;
> --=20
> 2.25.1
>=20
>=20
>=20


