Return-Path: <linux-kernel+bounces-324449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D568974C99
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0789E286190
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF94914F136;
	Wed, 11 Sep 2024 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MQf2jMCj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDF13D8A8
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726043248; cv=none; b=Kj3ZS/ec363vwgqn/iT7nOZUR9zspfakyu2DOT4G9rOWCodjCVTjZOU5jUXQI13ss6eRSwFpPFVX9DU5ErSDT3YEfqZF6qXXJbpwS45gYN+QKQkoDjpg1zYmLArV6xmlzp6OrG+EOg/+aTS+FvRB9+lh+FRz5I8N7xKVshqkaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726043248; c=relaxed/simple;
	bh=n1GNolWErtI6Vz1MhhASlsKDPDe2Y3EuFOsO206ZTzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RuzGQivPUMZpxhdZ5moiEpySJqn9MjJpaxntcjXNbcTuv8oTyx+Ciyl47WUWXnn5J9s+vd8aBly1g05aWx18nRQumFyQk1EDgL0KB+AZQUpCuHPlG2GNJxjFQZUMadzKJ/iQzfOGThGiLiYR70h5Ncyt1NnfCZIKr5aZlW/SK+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MQf2jMCj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48B7nJV5015709;
	Wed, 11 Sep 2024 08:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	ssnzh5qKm1xvE0WTWPULCvOguZUt85ByjMnSSyo2S0s=; b=MQf2jMCjnBEDcAP6
	u3mWiuEDpsq+ja5yHybRyIxtbTYSF6nzmtqn0FxIdXjNfoegsKqAKNz4FCAmJuIq
	ROyQ42ZoPS4G0AHt9bYGM6Xr7hojajmV2uo19zQkS+NIrkqjM72FLgPsVcZ14TwX
	Ju83gHeiW6NgOqLPJzvWdGf37850Ib2SRIsCagBFUp0zZZUGdrGTfpOm9GHJv+yP
	J07qyNQKR/Tw5RFJUk+XM1hpbAxhIFRB5deynhAVNpq3X+D91KLPXJVCfQI8UmQU
	GQNtH6PP1njTRmXi2WS/RjtFzzutAhQ+0Uwi/W4FHlpJbh17w7eO9j544ecTjLgs
	y+3/Lw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebace4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:27:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48B8Nqkm012518;
	Wed, 11 Sep 2024 08:27:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gebace4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:27:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48B8DIV7013458;
	Wed, 11 Sep 2024 08:27:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cm7xbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 08:27:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48B8RCBQ44892468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Sep 2024 08:27:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6C3420049;
	Wed, 11 Sep 2024 08:27:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82B1D20040;
	Wed, 11 Sep 2024 08:27:12 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.155.211.168])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 11 Sep 2024 08:27:12 +0000 (GMT)
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
In-Reply-To: <CAJhGHyBVq84_q5FevmpHPeseAudyf2gOX2LcWt0fMhNddkiz1w@mail.gmail.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
 <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com> <87wmjj971b.fsf@linux.ibm.com>
 <87tten8obm.fsf@linux.ibm.com>
 <CAJhGHyCWh4QJ6db1vLpt=CJLUrR4pTCt2o4fhYLDVBG6HDyK8Q@mail.gmail.com>
 <CAJhGHyBVq84_q5FevmpHPeseAudyf2gOX2LcWt0fMhNddkiz1w@mail.gmail.com>
Date: Wed, 11 Sep 2024 10:27:11 +0200
Message-ID: <87ikv28ujk.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AxsTscz6KYFHfPwsnjdBGZl2QiVf6Idt
X-Proofpoint-GUID: GCcFAGY7mKJiWFqTLnIj1AjxFfQrbfvC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_12,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409110060

On Wed, Sep 11, 2024 at 11:32 AM +0800, Lai Jiangshan <jiangshanlai@gmail.c=
om> wrote:
> On Wed, Sep 11, 2024 at 11:23=E2=80=AFAM Lai Jiangshan <jiangshanlai@gmai=
l.com> wrote:
>>
>> Hello, Marc
>>

Hi Lai,

[=E2=80=A6snip=E2=80=A6]

>>
>> I'm not familiar with s390 asm code, but it might be the case that
>> `worker->pool` is NULL in the in worker_thread() since detach_worker()
>> resets worker->pool to NULL.
>>
>> If it is the case, READ_ONCE(worker->pool) should be used in worker_thre=
ad()
>> to fix the problem.
>>
>> (It is weird to me if worker->pool is read multi-time in worker_thread()
>> since it is used many times, but since READ_ONCE() is not used, it can
>> be possible).
>
> Oh, it can be possible that the worker is created and then destroyed befo=
re
> being waken-up. And if it is the case, READ_ONCE() won't help. I'm going =
to
> explore if "worker->pool =3D NULL;" can be moved out from
> detach_worker().

I=E2=80=99ll double check if my assumption is true or not (worker->poll =3D=
=3D
NULL). It may well be that my assumption is wrong.

Thanks for having a look!

>
> Thanks
> Lai
--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

