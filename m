Return-Path: <linux-kernel+bounces-577210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DCA719E8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21E23AE136
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808911DD539;
	Wed, 26 Mar 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cyHaxAnJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1CB19CC3E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001620; cv=none; b=i0ViIuhMKEpIWNacIUtubc27h56h0I9Y115CGmodd2K+ZjNpmKliWuy1OkW7hKhv+BbpdxDtbuuIWEWJ/IFyQXpfKXWf0VZYZm/CbHFN36nABGKZhF7hz5Yjlvp5iozGC+nfeS+rG5z6SE+F+GIesf2gmWlWXfpXoHngVXqbeKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001620; c=relaxed/simple;
	bh=R8rSD+DG0bPmgXPuHskIcNTGJwE/gDFXZDyQvLIn2dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSTPXaXlFBVBZwiTcWjIfyBAJ9411h78Jh1e6Ht+i2yDpedzlVmNpKK4yell+vkKE/VYs0IXLlwfyfxZdqQ0JbPUn+oBbNwDhvLkNToUi6GNHc32EmIngHIVgE4Wmu89LwrNP5w6eD1ck7wBiS2pYzY7rqUgrfRUYX0Vr1auM98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cyHaxAnJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QCS1n8001728;
	Wed, 26 Mar 2025 15:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CPQIfb
	QSReZtjK+ha/HqbAw7bS7MoPmv7Qb3SccMAgY=; b=cyHaxAnJWFnm8whnfLxbS+
	MGm9X17I593nw4qTOZIZP9HWW25gNGpT1Uoa/lMu1QhR09DtUhSJEWa181e0tfll
	NL1vhBz6Z5dBWA2BtxsEi0nsgwM5iKhpaPO0tKDqpi/9fWevrx8dGpwleFOvNAQy
	lgWR4bAZ3YRXoy0zy1EJRsJdQm9kJlJrBYAejsmYV7Wwb+Lgcc2ZHda6pQWJSgA8
	idyQzkVZA+4p/FR36JH7SOEr60edJGIw2fCeP+3EoAXl3itmMhTl6nZZxrnFqnCm
	oANE1Wt+odP0HOsIw0/Vp40ysLQ1Usan2gZ8VdghbsNnh5XS5oxBmLdSKHtqkSYQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mhm3rtv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 15:06:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52QBeklp009585;
	Wed, 26 Mar 2025 15:06:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkrn64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 15:06:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52QF6BYO57999848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 15:06:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A3472004B;
	Wed, 26 Mar 2025 15:06:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4102520043;
	Wed, 26 Mar 2025 15:06:09 +0000 (GMT)
Received: from [9.124.217.36] (unknown [9.124.217.36])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 15:06:09 +0000 (GMT)
Message-ID: <89bb1d0e-4835-43d4-9e63-0b1717a9921e@linux.ibm.com>
Date: Wed, 26 Mar 2025 20:36:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-21-bigeasy@linutronix.de>
 <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>
 <20250325225600.GP36322@noisy.programming.kicks-ass.net>
 <4d0059f1-d834-44d5-bc57-7425980f5a97@linux.ibm.com>
 <20250326133736.GF25239@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250326133736.GF25239@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oqDYTGkS1p-zjuK_461LF_IMRfeai3V_
X-Proofpoint-GUID: oqDYTGkS1p-zjuK_461LF_IMRfeai3V_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_07,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=666
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260091



On 3/26/25 19:07, Peter Zijlstra wrote:
> On Wed, Mar 26, 2025 at 06:27:20PM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 3/26/25 04:26, Peter Zijlstra wrote:
>>> On Wed, Mar 26, 2025 at 01:22:19AM +0530, Shrikanth Hegde wrote:
>>>
>>>>> +	return &futex_queues[node][hash & futex_hashmask];
>>>
>>>                               ^^^^^^^
>>>
>>>>> +	hashsize = 256 * num_possible_cpus();
>>>>> +	hashsize /= num_possible_nodes();
>>>>
>>>> Wouldn't it be better to use num_online_nodes? each node may get a bigger
>>>> hash bucket which means less collision no?
>>>
>>> No. There are two problems with num_online_nodes, and both are evident
>>> above.
>>>
>>> Consider the case of a sparse set.
>>
>> I am sorry, i didn't understand. Could you please explain?
> 
> I was confused; I should've just gone sleep :-)
> 
> The futex_queues[] array is sized MAX_NUMNODES, such that every possible
> node_id has a spot. I thought we did dynamic sizing, but not so.
> 
> Anyway, using online here would lead to having to deal with hotplug,
> which in turn either leads to more over-all hash buckets in the system,
> or having to resize and rehash everything.
> 
> Neither are really attractive options.
> 

Ok. got it. Thanks.
Keeping with possible nodes seems simpler.

