Return-Path: <linux-kernel+bounces-324611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A83974EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162EF1C21BA7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B7E39FF3;
	Wed, 11 Sep 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HgQhXwxq"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC9155346
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047464; cv=none; b=YDRcShZYoMzpXXm7T4ZjbRO5Z5/GQMTeUPVMGnW7imuChslxC+DgeNrEo7cY7Pda54npMknI2hM1rLpIW97uNwJ63wWJEjLT8TSCeQesAW46pUCMb+PyoBMuMWdApKl475ORazuH79O0wq40j7IVIbY5C5B+kL2d2yyILuVZBLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047464; c=relaxed/simple;
	bh=JfUr/j+EV4t0OkC1MsSIZTfqAHGiBPZHq5gAv8p87WI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=V2vHftCkzrj4mpZAxSsyYMt2vEWmnDPMgKTLz4T9Kt9PdHjQfAGxk6a+wEwFt1i1jCL89a+US3lh72pCLYl0vD16DHoCWCjzlQilv8rfL0FFCBTl+2km3tQ6YfmUkJxxm2zgHQbHBiPntlxIj3Fqk2xniZxekh76NBaYoOFWEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HgQhXwxq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B8mqDO020931;
	Wed, 11 Sep 2024 09:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	1EyHvAJeX49fgz4eOGxPZQtAOHH+zxC6Pv4z+rg5A4w=; b=HgQhXwxqF93T992E
	RW6+EEVkUnYHTXPEp34F3ek3V/wyT6uK1RWD64oKkd+WxmwpYVxAq4aIYHJB9phv
	OW2laqbSyCewzEuVp11WoSRQNofCjRt+5U7rT0JLzuAK4LCIjEA95k+4/SLSmeiw
	fExsrBAQfbF3wE4z8TzFq9vNemJfkTQKJxC/UjbpmMvGFJMgZhBasLqfFoqF3aLY
	y/BuWh1QW4mzKIaCPjWqNL/yY7BJLx0r2frVw0nTxEorCZ9X+t2ZEhoO+UcA7enm
	lwOuEUCMPuaptD8TaJM3+/yPd+8FNKtCdgRLYNz4ieF1tIiraV67XIYgI7XGe1QH
	+Q6JXA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefymhbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:37:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48B9aWZi030515;
	Wed, 11 Sep 2024 09:37:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefymhbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:37:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B72pWN032611;
	Wed, 11 Sep 2024 09:37:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h1j0rnrc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 09:37:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B9bTij50528664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 09:37:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 850D02004D;
	Wed, 11 Sep 2024 09:37:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E46E20049;
	Wed, 11 Sep 2024 09:37:29 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.152.224.248])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Sep 2024 09:37:29 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan
 <jiangshan.ljs@antgroup.com>,
        Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and
 remove detach_completion
In-Reply-To: <87ikv28ujk.fsf@linux.ibm.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
 <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com> <87wmjj971b.fsf@linux.ibm.com>
 <87tten8obm.fsf@linux.ibm.com>
 <CAJhGHyCWh4QJ6db1vLpt=CJLUrR4pTCt2o4fhYLDVBG6HDyK8Q@mail.gmail.com>
 <CAJhGHyBVq84_q5FevmpHPeseAudyf2gOX2LcWt0fMhNddkiz1w@mail.gmail.com>
 <87ikv28ujk.fsf@linux.ibm.com>
Date: Wed, 11 Sep 2024 11:37:29 +0200
Message-ID: <87cyla8rae.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ky5ufcHxGXh7G7hJDkrm6OZm_i5mYAJ0
X-Proofpoint-ORIG-GUID: bee1X-64F5EurXBECFKHTGGTE64N1dSm
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110072

On Wed, Sep 11, 2024 at 10:27 AM +0200, "Marc Hartmayer" <mhartmay@linux.ib=
m.com> wrote:
> On Wed, Sep 11, 2024 at 11:32 AM +0800, Lai Jiangshan <jiangshanlai@gmail=
.com> wrote:
>> On Wed, Sep 11, 2024 at 11:23=E2=80=AFAM Lai Jiangshan <jiangshanlai@gma=
il.com> wrote:
>>>
>>> Hello, Marc
>>>
>
> Hi Lai,
>
> [=E2=80=A6snip=E2=80=A6]
>
>>>
>>> I'm not familiar with s390 asm code, but it might be the case that
>>> `worker->pool` is NULL in the in worker_thread() since detach_worker()
>>> resets worker->pool to NULL.
>>>
>>> If it is the case, READ_ONCE(worker->pool) should be used in worker_thr=
ead()
>>> to fix the problem.
>>>
>>> (It is weird to me if worker->pool is read multi-time in worker_thread()
>>> since it is used many times, but since READ_ONCE() is not used, it can
>>> be possible).
>>
>> Oh, it can be possible that the worker is created and then destroyed bef=
ore
>> being waken-up. And if it is the case, READ_ONCE() won't help. I'm going=
 to
>> explore if "worker->pool =3D NULL;" can be moved out from
>> detach_worker().
>
> I=E2=80=99ll double check if my assumption is true or not (worker->poll =
=3D=3D
> NULL). It may well be that my assumption is wrong.

I applied the following patch on top of commit bc83b4d1f086 ("Merge tag
'bcachefs-2024-09-09' of git://evilpiepirate.org/bcachefs")

From 9cd804f8e3183422b05a1b36e2544d1175736519 Mon Sep 17 00:00:00 2001
From: Marc Hartmayer <mhartmay@linux.ibm.com>
Date: Wed, 11 Sep 2024 09:11:41 +0000
Subject: [PATCH] Add printk-debug statements

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
---
 kernel/workqueue.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index e7b005ff3750..d4c5c68457f7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3338,11 +3338,16 @@ static void set_pf_worker(bool val)
 static int worker_thread(void *__worker)
 {
        struct worker *worker =3D __worker;
-       struct worker_pool *pool =3D worker->pool;
+       if (unlikely(!worker))
+               printk(KERN_ERR "OOOOOHHHH NOOOOOOO, WE DO NOT HAVE A WORKE=
R.\n");
+
+       struct worker_pool *pool =3D READ_ONCE(worker->pool);

        /* tell the scheduler that this is a workqueue worker */
        set_pf_worker(true);
 woke_up:
+       if (unlikely(!pool))
+               printk(KERN_ERR "OOOOOHHHH NOOOOOOO, WE DO NOT HAVE A POOL.=
\n");
        raw_spin_lock_irq(&pool->lock);

        /* am I supposed to die? */
--
2.43.0

And it shows that pool is NULL in case of the crash. Hope this helps.

>
> Thanks for having a look!
>
>>
>> Thanks
>> Lai
> --=20
> Kind regards / Beste Gr=C3=BC=C3=9Fe
>    Marc Hartmayer
>
> IBM Deutschland Research & Development GmbH
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
> Sitz der Gesellschaft: B=C3=B6blingen
> Registergericht: Amtsgericht Stuttgart, HRB 243294
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

