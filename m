Return-Path: <linux-kernel+bounces-426721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FB29DF701
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8102817F1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002A1D7E33;
	Sun,  1 Dec 2024 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RkwTc/kf"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0841C64
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733082389; cv=none; b=IQ2YlC0z+1xJV07RrODrIDc4NPfJwsP/XGVzughWggTASJ8Wf3MWtxZqNvKWTDZNBQrW45QqBhT5au1S7xv7sooepRy3J+tPsJcOFSPeQY/sLZ9sPPFTVj/s0bcWa/CpwFG6SCTmyNZ3sCGI5QJDgqnGskxkSrL5XqDUZhdle3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733082389; c=relaxed/simple;
	bh=fklaWmSS1Vk387X6SCCIp97b24qFPHLjjSJLpKZlIAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBZp7R8tqdWxXcvEnj2dMjb111ou77or8kOpd48eZnKM3gyXv5yELOY2X8yKww+r42xWj9vldgZFx426RoY4zHvVoVa4aeV1XrrlWaJHnEJa02wbauPLP1cbjefd68hImL0jIFHnAZVJW5jyU7KmzcRvVQeh8FLe10aA745iQnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RkwTc/kf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1EjL8Q006007;
	Sun, 1 Dec 2024 19:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0VFRnY
	Bj1HRVj7nh9umzkGJ2WDYz47FNXpEf0RmuZcc=; b=RkwTc/kfUYNULG6Vi7KD5O
	w3HCP6LAzaQheuwT/uH6Te4uAqBbAQlP6O20bUobiswDi84P2KO8Fx9zmsFtO2kH
	5e4bn+JZHZr76COmVzIg6oCX6nhgR1YAap/KJDMp0nJXvFK3ScTl1+s2SAgU4pCg
	P0iF4VXdNbOerB9DlT9xPbdwQXwSUXhNdq4isGvA3hpjj3lBBX8mX6QX/3DQnguH
	xkBo6VitMD4A5to+f4zBmcO9l1pAg35o/3KEDvw7sx1Q5IVQhT5DkJ64stQFeo5X
	DHBJihQA3YrqYia88qJNjQa8vywiaZLmjlJxopPGRixOcioHmzAwja0s8Q7KD8NQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tcv5qsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Dec 2024 19:45:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B1Jjlbp031441;
	Sun, 1 Dec 2024 19:45:47 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tcv5qsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Dec 2024 19:45:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1J5Zg1017943;
	Sun, 1 Dec 2024 19:45:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 438d1s15f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Dec 2024 19:45:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B1Jjj1u34275916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Dec 2024 19:45:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D1FB20043;
	Sun,  1 Dec 2024 19:45:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92F6C20040;
	Sun,  1 Dec 2024 19:45:42 +0000 (GMT)
Received: from [9.124.210.71] (unknown [9.124.210.71])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  1 Dec 2024 19:45:42 +0000 (GMT)
Message-ID: <ff4c586b-7be7-4c31-8b8c-5846ded486de@linux.ibm.com>
Date: Mon, 2 Dec 2024 01:15:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] powerpc: support dynamic preemption
To: Christophe Leroy <christophe.leroy@csgroup.eu>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-3-sshegde@linux.ibm.com>
 <5089fd16-bc8c-4231-a89b-2658445e04b7@csgroup.eu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <5089fd16-bc8c-4231-a89b-2658445e04b7@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gaRZyFHEsmIlAdk7Hpr9YHIRDyUZmx-s
X-Proofpoint-GUID: tKld-ENi4_ZTy5GdzrVSLnqpmF05dcQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412010168



On 11/27/24 12:14, Christophe Leroy wrote:
> 
> 
> Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
>> Once the lazy preemption is supported, it would be desirable to change
>> the preemption models at runtime. So this change adds support for dynamic
>> preemption using DYNAMIC_KEY.
>>
>> In irq-exit to kernel path, use preempt_model_preemptible for decision.
>> Other way would be using static key based decision. Keeping it
>> simpler since key based change didn't show performance improvement.
> 
> What about static_call, wouldn't it improve performance ?
> 
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 6d6bbd93abab..01c58f5258c9 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -270,6 +270,7 @@ config PPC
>>       select HAVE_PERF_EVENTS_NMI        if PPC64
>>       select HAVE_PERF_REGS
>>       select HAVE_PERF_USER_STACK_DUMP
>> +    select HAVE_PREEMPT_DYNAMIC_KEY
> 
> Can you use HAVE_PREEPT_DYNAMIC_CALL instead ? That should be more 
> performant.
> 
> I know static calls are not in for PPC64 yet, you can restart from 
> http://patchwork.ozlabs.org/project/linuxppc-dev/ 
> cover/20221010002957.128276-1-bgray@linux.ibm.com/ and https:// 
> github.com/linuxppc/issues/issues/416
> 

Thanks Christophe, I will take a look and understand.

May be stupid question, do the concerns of arm still valid for ppc64/ppc32 out-line static calls?
https://lore.kernel.org/all/20220214165216.2231574-6-mark.rutland@arm.com/

As I understood, that is the reason they went ahead with DYNAMIC_KEY.

> Christophe


