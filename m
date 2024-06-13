Return-Path: <linux-kernel+bounces-213359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF390742A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468EC1F23449
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CCB142654;
	Thu, 13 Jun 2024 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0gTMvQR"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BF4A07
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286400; cv=none; b=ZB2H/pTwvww1b3GaModO+W8Zcv5ZZBBtsn9uLrFGDRSoMDTs2d06Yx6olDgDCCGn3gBgSyh6uk2V9Le94ykXlzSwmcaYtGW/78bJkaKWln4WxOj4EDjIbV2zBVJ8EUrvpLilUXWcC+ldin4RPsfyPuQIjk/l1+VyVJ6LtLjZpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286400; c=relaxed/simple;
	bh=oP1spO3fFb//giJecXJAXY7exbAQza4adDESaxV0NLs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eNmOyeCEi8VJsiKp3Ezh6c2U4YyZ9BWTEtg51iO530oKwLhSRDyHFJliwzDB2gRcSvahDSGVusPyJ/z3F6cb7id2weK1lv9/K2WmlVK52bSNpgZjpkbAguaXejdjgC1B9Vg+vMiXdPcHEzLi7gDVB9hJOugpWXW4sfRmt/tOrVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0gTMvQR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b06e63d288so5472556d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718286397; x=1718891197; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+PAaGurCK53XLDrRPGSFXkgAfT6gdmkYQ/VaMNIQcA=;
        b=G0gTMvQRE2BKtUgCe6OUT30vG6TbaBnc75JE1rVDzrElggtBod4M6CYzUZiVYLxPho
         HsuBibX2iidGuK/eqh4B1Ju/ChKmdrY6SkidoqNJfc8G1EI4y7QCo185uPY/RY+6jNsZ
         yhj03rolAFUcR21q2GNDgMnijEpfat6dBIaYUqKaKWmZt2w7NH0nGOmuPDcgvtgrPMx2
         m+yj3G4yWCS3DL/bM4BKAu+LfRPQwSdXe29vi8WIUBOTHPCkDQbo9C/5ZNlsHYJgXsUC
         lSjIcv0aVsE4RnHIix6hq3qKpgSUDePh5WOINsQ0wonmHr56wyu9LoPxoYpLATfOzRkw
         I+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718286397; x=1718891197;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+PAaGurCK53XLDrRPGSFXkgAfT6gdmkYQ/VaMNIQcA=;
        b=QTH86c9KZjY1BCZYRpDB82X++oU5SuM36aEqvVvNDLTjDAEHzRlhFiwhiTQ16ioJ6F
         uVK3sNQSZ9UxbVFtg/gmFvTa2ftThKmHzM53wTLfXaNx0NmuI9a4YbpoK+LmcYX/2vd+
         IeQj74lGTQ1Mta8xnBIdfBsOSTEos61MWi4Ay6bx9pF7SYCGojhKFnoSACUsrRPtalhS
         oIJY2DGlcZdpOlRbHMdSeeqQGedIknTBqLMPCaEP+6iLgovNA/GsKJFi+6gGuUHTAny8
         BzDcdMJFlWio9VZBelAhI/Y+225LX0Dkir1/AeZQPyRHE64oEsbJjDJM7824lEyQShoH
         tA3g==
X-Forwarded-Encrypted: i=1; AJvYcCVmNzRh1Zh6FO9G6tch1WqGwIsp68BN5EaP1g+8ObKpvxWAW0syvyUpCIXtzmGHUrK2BkooDYK0ERmmoy6890Yc5tNDU60s0VzUhq+q
X-Gm-Message-State: AOJu0YzaGJZ/5N6p7VQCBUoZ1ZcL36Ja1RQjE8wnEEij4jHOsR5ZHc90
	xEZ/6xuZRfjO9yLI0lU2cFiN2daJJNHLdcNIklVkOMcfsrPV96zi
X-Google-Smtp-Source: AGHT+IGJPa/tBCoqDWjdGGqMBUdUeLIL2IeuVO1ZDTSwyR/Y7ESUArWK96zsCkdzS79Do2mwSERRVQ==
X-Received: by 2002:ad4:5102:0:b0:6b2:adc9:d1e0 with SMTP id 6a1803df08f44-6b2adc9d2e8mr2227916d6.64.1718286397425;
        Thu, 13 Jun 2024 06:46:37 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5eb4806sm6841756d6.92.2024.06.13.06.46.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2024 06:46:36 -0700 (PDT)
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


