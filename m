Return-Path: <linux-kernel+bounces-569147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615A0A69F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 05:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C351898E98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0F1DE2CD;
	Thu, 20 Mar 2025 04:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tmtmkfEr"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B733E1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742445688; cv=none; b=oqkqUtOLSUPawYe6wqXFOp6aJdo9+6spwGHw9VrvPyMZodjf1SlcC/D9VBMa9biVDJ0IJIc8pSPedxXL1T621xUxPkuM2CFLdb95i424MG4uoWB5JlUCzRpScmRirsqQRW/i/n8Jqt0JpMxrJd2D2jRpvv4dPoZBXtLTcfg0nsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742445688; c=relaxed/simple;
	bh=iu2sOwFKvHsAyw6rkzDBUlqOQj32aHgAVhlKggBWESo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrAAk0S+5owD/ExV1DrKwlSVy80zetLCybtPyLXz3gXbtUGTxgr9cnM6qzm3zIpZirZB+OqJcldRNGosrIo1DnGi0LbAwoDH/Zc11c5qqbfqJ+axQRDVOEe0XEPdsjnr4jyZDm57z115fREREH3Qtw7D9OAC0SIgUH/CCRkbXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tmtmkfEr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JNZKZL027546;
	Thu, 20 Mar 2025 04:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=249j2d
	nUvuAhHakwr4avBEP0g5cFzhcQ0fJYm46dmCA=; b=tmtmkfErnoDJPh0ib93cfV
	uNJ58G7SbxQIvrSLr/o85rhNa9k4mV9bVDs7zyFZ4qhT2O4C++vCkZf7WaZMsjrO
	mrhkeqE5OiDoe9LGrn3AuRBCeOKitU6pdrhONUEXQU/Fm7GorBDA1ah0HnOvecxJ
	kJMgqIVd6d8MTipkWbMdX2AVaxnX5YgE64jmYjEhWsM22W3DP6rWdOPBEO5vOb+E
	4AHM2LTOxNSjS5/bO2D6mHG5MW4ZtopttJ11TQ9t0TiKgtTMK2wvi7VjWBJTH0XV
	OjQEm3VfEZuzbMHustnNxP8QxiCSIHjTjVQpbjFAPVUkaw/PXRznerWQKRql20jg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fybpv34u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 04:41:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52K1Nh0l012351;
	Thu, 20 Mar 2025 04:41:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dmvp5x95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 04:41:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52K4f3IT35717436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 04:41:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 004E02004E;
	Thu, 20 Mar 2025 04:41:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3048720043;
	Thu, 20 Mar 2025 04:41:01 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 04:41:01 +0000 (GMT)
Message-ID: <2ea3687e-b5a9-4de3-99d2-261bccb06c0b@linux.ibm.com>
Date: Thu, 20 Mar 2025 10:11:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Dietmar Eggemann
 <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20250317104257.3496611-1-mingo@kernel.org>
 <83c3bd7f-3ff9-4d3c-ab3e-981b73b95141@linux.ibm.com>
 <Z9szt3MpQmQ56TRd@gmail.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <Z9szt3MpQmQ56TRd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SNqInFPAy9Es7wewUvTo29yIw4tqvX3s
X-Proofpoint-GUID: SNqInFPAy9Es7wewUvTo29yIw4tqvX3s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_01,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503200026



On 3/20/25 02:44, Ingo Molnar wrote:
> 
> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> 
>>
>>
>> On 3/17/25 16:12, Ingo Molnar wrote:
>>> For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
>>> in all the major Linux distributions:
>>>
>>>      /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y
>>>
>>> The reason is that while originally CONFIG_SCHED_DEBUG started
>>> out as a debugging feature, over the years (decades ...) it has
>>> grown various bits of statistics, instrumentation and
>>> control knobs that are useful for sysadmin and general software
>>> development purposes as well.
>>
>> A tunable like base_slice which is the only tunable available for EEVDF is under the debug.
>> So an option is to get rid of CONFIG_SCHED_DEBUG and make it available to all.
>>
>> We had seen performance regression when domains folder was built with cpu hotplug.
>> Later that was moved iff verbose was enabled. Maybe something like that can be done
>> if something is hurting performance.
>>
>>>
>>> But within the kernel we still pretend that there's a choice,
>>> and sometimes code that is seemingly 'debug only' creates overhead
>>> that should be optimized in reality.
>>>
>>> So make it all official and make CONFIG_SCHED_DEBUG unconditional.
>>> This gets rid of a large amount of #ifdefs, so good riddance ...
>>>
>>
>> There are some references in selftest like these, maybe remove them as well?
>>
>> tools/testing/selftests/sched_ext/config:CONFIG_SCHED_DEBUG=y
>> tools/testing/selftests/sched/config:CONFIG_SCHED_DEBUG=y
>> tools/testing/selftests/wireguard/qemu/debug.config:CONFIG_SCHED_DEBUG=y
> 
> Indeed - fixed.
> 
> I left out all the defconfigs from the patches, because there's a lot
> of them (~79 reference CONFIG_SCHED_DEBUG ...) and they get refreshed
> naturally in any case.
> 
>> Also ran unixbench and hackbench on 80 CPU system (1NUMA) with and
>> without CONFIG_SCHED_DEBUG. hackbench numbers are almost the same.
>>
>> for unixbench, process creation/Context Switching show 1-2%
>> improvement with CONFIG_SCHED_DEBUG=n
> 
> Thank you for the testing! I'll add:
> 
>    Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> to the series if you don't mind.

It was minimal testing. If that suffices i am okay with the tag.

> 
> And irrespectively of this series we should probably look at that 1-2%
> overhead in unixbench context switching overhead, maybe there's a few
> low hanging fruits in the debug code.
> 
> 	Ingo

ok. Let me see perf record and see what shows up.

