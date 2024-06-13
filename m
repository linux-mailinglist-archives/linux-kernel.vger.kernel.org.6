Return-Path: <linux-kernel+bounces-213166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D9B906E25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326BF1F233F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DDD145FF5;
	Thu, 13 Jun 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaDcuE5E"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2851422AB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280183; cv=none; b=bTp7WPpJq0QzTBiZ2gYum+ZpHiMuzM2mP8Rpb5zvIrCEhf/nNs8JaCHdg8a1zJkLuWDkw5h6UEsKzzaL24DiiilIkre8ovCMIFMMT0DxaEghLT51LdE2pRdB3SsKy0sUg0DG6EcoPkM55TslNR/treB4wzv5H0eSjSyDUIuUYKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280183; c=relaxed/simple;
	bh=BOQnWw+R6xqgs1kCZYtL4uxwTR527cu00+c0814eQK0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PZft8iB+x6RT6WsqobTWmsYpOD/Prgoigc4EiN0w9GrSpsmvAFfnHP6AvADDDBK8nNKhZvZnEVtXdeT2AUBEYm/RMbzZLAIQtgmN/9+DUV5dw+Jgo2avk0xOct/sfoHzqxz56rP39IMjK8RrLYPRSvtX3HzUXVV0j6bwPwtXXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaDcuE5E; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4403bb543a4so5276251cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718280181; x=1718884981; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKA/VUM/a9F8ecl/GN0yeGv3buwPv6S6vu54++YIlkQ=;
        b=CaDcuE5E6LSky8Lz5xx+BdZnQb6Vp/mmciM6QceIcg8w5O6driYnbxhnlyT9k8RTc3
         jnHB9Z2F4aw5/RzCknvdCSuW3UwG5xBrVWUnB8e1LwTLKSPDUnIXPLyLqY++3Uru+lqP
         4dip5zTtdC/YCM/Gzrth/8qUyiOjiUldMYsg3xfeX/F/sozG2WlAn30870aF7LPlRe7r
         /qP3xnSZ3y/mYgsXYqGE6NKcF+p9R7FkaYXk6lEINvqxrZUBJ7bBZ3v7tmW6jkt/y2gk
         E3GCGotECEooHEY/CJlYaTYd/tNULwChVbA/YMwNjZohLnAA89PCH7vDZGgP/ZiwG130
         QVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280181; x=1718884981;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKA/VUM/a9F8ecl/GN0yeGv3buwPv6S6vu54++YIlkQ=;
        b=O5SrGpA07mlLW47+BP1zdJJe4q/uWrWZlbBfrIWiG4LgB4U4mA9M1Xwrdj2bBfcTH9
         Hr4DU85hmcknXpmpuIaentlwjvvHv4yVxl4ENmrZydszNNLxuPrl3A09X0Clbuv34jif
         9m5pC4ZDRN90rj3zpHGQIIXKxwZZW4SocZeRKD7HQs9UkizhYfJjlsSR3xK46XZqzC5f
         Fa9M//ejMaHm6CTFaQrjcHqqlk8bG6k6DKfDY3BDsHHvE1RMms1DXlmfuRJWNUWg1eJN
         8olpenyM9OVOxTKRuXR8bmkM+L9CHW41AHfRuNJ6kuGNSl4tdZDPqeeAeztjCzwQ8nJ9
         el7A==
X-Forwarded-Encrypted: i=1; AJvYcCUTtb52SmGkka/O5/a4QqVpIFcBBFTpr6Bsptio/goH72AFxetlnVe1ogPkHdIS32pP00ZWCjHuXwDKGm24BQvMFemDdfL4F0Kl0rli
X-Gm-Message-State: AOJu0YwxT2GQvWJ5yA70wui9ZxuV6zLkAMe7j5ci47nkLLyFHeQjOiqI
	wKQ4sYU2noLtPRLMM2e1ZNtwxMLh/GHsYtO/aoT/KMlPZI2kJ9K9
X-Google-Smtp-Source: AGHT+IGCdlBNx+UdD2COQJefxBq4y25R0s3uGI+GGxizPiw8cQb2P6BlSO90Fys7OfxecCi6G8rzoQ==
X-Received: by 2002:a05:6214:4903:b0:6b0:825b:2406 with SMTP id 6a1803df08f44-6b1a6b5dcffmr53055686d6.51.1718280180264;
        Thu, 13 Jun 2024 05:03:00 -0700 (PDT)
Received: from smtpclient.apple (174.137.59.200.16clouds.com. [174.137.59.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ec5e8esm5971466d6.88.2024.06.13.05.02.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2024 05:02:59 -0700 (PDT)
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
In-Reply-To: <Zmrd2hwqHB8RQjqB@chenyu5-mobl2>
Date: Thu, 13 Jun 2024 20:02:37 +0800
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
Message-Id: <112FECA8-5D21-406F-814C-ACBE63351CBB@gmail.com>
References: <20240529141806.16029-1-spring.cxz@gmail.com>
 <ZmKVjmuC4kGrUH5V@chenyu5-mobl2>
 <2E6EB0D6-D913-4205-B7DD-35EF4FA25667@gmail.com>
 <Zmrd2hwqHB8RQjqB@chenyu5-mobl2>
To: Chen Yu <yu.c.chen@intel.com>
X-Mailer: Apple Mail (2.3731.700.6)



> On Jun 13, 2024, at 19:54, Chen Yu <yu.c.chen@intel.com> wrote:
>=20
> On 2024-06-12 at 18:39:11 +0800, Chunxin Zang wrote:
>>=20
>>=20
>>> On Jun 7, 2024, at 13:07, Chen Yu <yu.c.chen@intel.com> wrote:
>>>=20
>>> On 2024-05-29 at 22:18:06 +0800, Chunxin Zang wrote:
>>>> I found that some tasks have been running for a long enough time =
and
>>>> have become illegal, but they are still not releasing the CPU. This
>>>> will increase the scheduling delay of other processes. Therefore, I
>>>> tried checking the current process in wakeup_preempt and =
entity_tick,
>>>> and if it is illegal, reschedule that cfs queue.
>>>>=20
>>>> When RUN_TO_PARITY is enabled, its behavior essentially remains
>>>> consistent with the original process. When NO_RUN_TO_PARITY is =
enabled,
>>>> some additional preemptions will be introduced, but not too many.
>>>>=20
>>>> I have pasted some test results below.
>>>> I isolated four cores for testing and ran hackbench in the =
background,
>>>> and observed the test results of cyclictest.
>>>>=20
>>>> hackbench -g 4 -l 100000000 &
>>>> cyclictest --mlockall -D 5m -q
>>>>=20
>>>>                                EEVDF      PATCH  EEVDF-NO_PARITY  =
PATCH-NO_PARITY
>>>>=20
>>>>               # Min Latencies: 00006      00006      00006      =
00006
>>>> LNICE(-19)    # Avg Latencies: 00191      00133      00089      =
00066
>>>>               # Max Latencies: 15442      08466      14133      =
07713
>>>>=20
>>>>               # Min Latencies: 00006      00010      00006      =
00006
>>>> LNICE(0)      # Avg Latencies: 00466      00326      00289      =
00257
>>>>               # Max Latencies: 38917      13945      32665      =
17710
>>>>=20
>>>>               # Min Latencies: 00019      00053      00010      =
00013
>>>> LNICE(19)     # Avg Latencies: 37151      25852      18293      =
23035
>>>>               # Max Latencies: 2688299    4643635    426196     =
425708
>>>>=20
>>>> I captured and compared the number of preempt occurrences in =
wakeup_preempt
>>>> to see if it introduced any additional overhead.
>>>>=20
>>>> Similarly, hackbench is used to stress the utilization of four =
cores to
>>>> 100%, and the method for capturing the number of PREEMPT =
occurrences is
>>>> referenced from [1].
>>>>=20
>>>> schedstats                          EEVDF       PATCH   =
EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
>>>> .stats.check_preempt_count          5053054     5045388    5018589  =
  5029585
>>>> .stats.patch_preempt_count          -------     0020495    -------  =
  0700670    -------
>>>> .stats.need_preempt_count           0570520     0458947    3380513  =
  3116966    1140821
>>>>=20
>>>> =46rom the above test results, there is a slight increase in the =
number of
>>>> preempt occurrences in wakeup_preempt. However, the results vary =
with each
>>>> test, and sometimes the difference is not that significant.
>>>>=20
>>>> [1]: =
https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kick=
s-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb
>>>>=20
>>>> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
>>>> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
>>>>=20
>>>> ------
>>>> Changes in v2:
>>>> - Make the logic that determines the current process as ineligible =
and
>>>> triggers preemption effective only when NO_RUN_TO_PARITY is =
enabled.
>>>> - Update the commit message
>>>> ---
>>>> kernel/sched/fair.c | 17 +++++++++++++++++
>>>> 1 file changed, 17 insertions(+)
>>>>=20
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 03be0d1330a6..fa2c512139e5 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -745,6 +745,17 @@ int entity_eligible(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>>>> return vruntime_eligible(cfs_rq, se->vruntime);
>>>> }
>>>>=20
>>>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>>>> +{
>>>> + if (sched_feat(RUN_TO_PARITY) && se->vlag !=3D se->deadline)
>>>> + return true;
>>>=20
>>> If I understand correctly, here it intends to check if the current =
se
>>> has consumed its 1st slice after been picked at set_next_entity(), =
and if yes do a reschedule.
>>> check_entity_need_preempt() is added at the end of entity_tick(), =
which could overwrite
>>> the police to reschedule current: =
(entity_tick()->update_curr()->update_deadline()), only there
>>> are more than 1 runnable tasks will the current be preempted, even =
if it has expired the 1st
>>> requested slice.
>>>=20
>>=20
>> The purpose of the modification is to increase preemption =
opportunities without breaking the
>> RUN_TO_PARITY rule. However, it clearly introduces some additional =
preemptions, or perhaps
>> there should be a check for the eligibility of the se. Also, to avoid =
overwriting the scheduling
>> strategy in entity_tick, would a modification like the following be =
more appropriate?
>>=20
>=20
> I wonder if we can only take care of the NO_RUN_TO_PARITY case? =
Something like this,
>=20
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 03be0d1330a6..5e49a15bbdd3 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -745,6 +745,21 @@ int entity_eligible(struct cfs_rq *cfs_rq, =
struct sched_entity *se)
>>        return vruntime_eligible(cfs_rq, se->vruntime);
>> }
>>=20
>> +static bool check_entity_need_preempt(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
>> +{
> if (sched_feat(RUN_TO_PARITY) || cfs_rq->nr_running <=3D 1 ||
>     !entity_eligible(cfs_rq, se))
> return false;
>=20
> return true;
>=20
> Thoughts?
>=20

This does indeed look better. In that case, do I need to make the =
changes this way and send
out a version 3?

thanks=20
Chunxin

> thanks,
> Chenyu
>=20
>> +       if (cfs_rq->nr_running <=3D 1)
>> +               return false;
>> +
>> +       if (sched_feat(RUN_TO_PARITY) && se->vlag !=3D se->deadline
>> +                                     && !entity_eligible(cfs_rq, =
se))
>> +               return true;
>> +
>> +       if (!sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, =
se))
>> +               return true;
>> +
>> +       return false;
>> +}
>> +



