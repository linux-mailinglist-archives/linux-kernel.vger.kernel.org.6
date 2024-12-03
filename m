Return-Path: <linux-kernel+bounces-429612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728BA9E200C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB1B0B29080
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAC81F130A;
	Tue,  3 Dec 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d2q93GpE"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46C1CF8B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234481; cv=none; b=UHRm4mEm4lJBa1Kg38/F/LZ1IbuzDJCPG/f99IKrwRgYyFxWF6PyoTa32Cn2pN0S+U+T1LY7I3QKQSn+IVMJOnS3yCB3mTQjCwm6tOk7FUsUqKbLj436Vl8/TKdd/F/cz/LTnuDPuzZTqcHD2anJrGc4NRxlTfAPqHKivut6qEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234481; c=relaxed/simple;
	bh=VHxdyF1t8Pb4TKUsORZ1LiwBWkN6y3Mi26umP5IcMBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1M51gicJ39hja9eKN1fW04QnTUmlFnPsMxUh3QtxCii0rcc/BOmMpnot0CslLFJgeb3lIm/b+kW72okdND4yaKxfzD2ZABtZq824UL4WqcBF6lWN1obYCxmfMdn68OL65OWltn3o6xhmIq92ZcSWofdHdg6GVsEORae2ClWh1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d2q93GpE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3CpwEX009568;
	Tue, 3 Dec 2024 14:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IN+RB0
	zLXbRxgzA2VNRjOvofy5Rv13Wnv4i3uGnWw6s=; b=d2q93GpEj7r3Geu2di6kOw
	H1ROaQmhYPHZ+6ETk9xXjxvfXnqIxRr5F1DLMp0CP0CTbGguK4A7+8iZgNxy/Vcs
	2ixba6oY14s0zBFVcbC6WtPnNBk4HGA1Sq/KKHnH4TeF8q9bejBNcmsfl707sfMK
	Ur58B3gvZpU+YRjEoCKQn3EKo3QcqwcChUlhSJ60pDUoE/bJ8V2YGV7OIcTKS8H/
	CRgM1zz6bkMx8d66lnQUJBsNwPW0i7wf1tGFShuGe5hZzbjrEJS9hSnmlbmCzPTM
	iZlwjyROutOW7+x1r0FBfXfjl4fgOaHN9BVgbNRzBaXXa4EMMqs6+zYtwVN9ctwg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgpvg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 14:00:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B3Dq4Yv003383;
	Tue, 3 Dec 2024 14:00:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfgpvft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 14:00:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3D9HxY005226;
	Tue, 3 Dec 2024 14:00:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxg1d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 14:00:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3E0PDn53281058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 14:00:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1BFF20043;
	Tue,  3 Dec 2024 14:00:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A49D120040;
	Tue,  3 Dec 2024 14:00:23 +0000 (GMT)
Received: from [9.39.25.90] (unknown [9.39.25.90])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 14:00:23 +0000 (GMT)
Message-ID: <8715eb95-e142-4b42-83d1-7e4cc2fa8650@linux.ibm.com>
Date: Tue, 3 Dec 2024 19:30:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] powerpc: copy preempt.h into arch/include/asm
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: npiggin@gmail.com, maddy@linux.ibm.com, bigeasy@linutronix.de,
        ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, vschneid@redhat.com, peterz@infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20241125042212.1522315-1-sshegde@linux.ibm.com>
 <20241125042212.1522315-2-sshegde@linux.ibm.com>
 <b5c152a3-d459-4744-84ec-846153de1652@csgroup.eu>
 <026ad776-a889-4213-8e0e-1da9065dc5ef@linux.ibm.com>
 <3de6bf25-fb3c-49a9-b06b-5e2e527ec90c@csgroup.eu>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <3de6bf25-fb3c-49a9-b06b-5e2e527ec90c@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ATa0YLbNsuUd5vcZRWUJlyZc1ptob-9s
X-Proofpoint-GUID: HWiY1GPopAyIe0NNbTvOCcW3KikpscZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=570 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030116



On 12/2/24 23:47, Christophe Leroy wrote:
> 
> 
> Le 02/12/2024 à 15:05, Shrikanth Hegde a écrit :
>>
>>
>> On 11/27/24 12:07, Christophe Leroy wrote:
>>>
>>>
>>> Le 25/11/2024 à 05:22, Shrikanth Hegde a écrit :
>>>> PowerPC uses asm-generic preempt definitions as of now.
>>>> Copy that into arch/asm so that arch specific changes can be done.
>>>> This would help the next patch for enabling dynamic preemption.
>>>
>>
>> The reason I want the content instead was to allow future patches 
>> where I thought of making preempt count per paca for ppc64 atleast. 
>> generic code assumes it is per thread. If this change is to be done at 
>> that point, that is fair too. I am okay with it.
> 
> I think it is better to keep series minimal and consistent. If you have 
> a futur plan, no problem, keep it future and do everything at once 
> unless it is heavy and better done in two steps.
> 
> As we say in French, a lot of water will have flowed under the bridge by 
> then.
> 
> I'm sure there will be a lot of discussion when you do that and maybe at 
> the end you will end up with something completely different than what 
> you have in mind at the moment.
> 

ok.

>>
>>
>>> Instead of copying all the content of asm-generic version, can you 
>>> just create a receptacle for your new macros, that will include asm- 
>>> generic/ preempt.h ?
>>>
>>> Look at arch/powerpc/include/asm/percpu.h for exemple.
>>>
>>
>> You mean something like below right?
>>
>>
>> #ifndef __ASM_POWERPC_PREEMPT_H
>> #define __ASM_POWERPC_PREEMPT_H
>>
>> #include <asm-generic/preempt.h>
>>
>> #if defined(CONFIG_PREEMPT_DYNAMIC) && 
>> defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
>> DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
>> #endif
>>
>> #endif /* __ASM_POWERPC_PREEMPT_H */
> 
> Yes exactly.
> 
> 

Should I send v2 with this and using DYNAMIC_KEY?

