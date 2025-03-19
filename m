Return-Path: <linux-kernel+bounces-568030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A305A68D2B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054D57A3530
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445C6253F0A;
	Wed, 19 Mar 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AddUe3Op"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B01A5BBA
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388542; cv=none; b=TwelXkFr7CUlYaPzF0Trh3FEOTKdLSqbPra9PKi/lcFim17VliIdGlqvztJPpbeYXI6R6kvEWVoVUoztIlSwm+/zNhX/0gVkOZcE4cLEaj9gKD27Rwbz5FaHLSMtkwwi1wNLKIKJKEGc72D6uu+VrQoQbXWr7fTsmqMzS6uULoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388542; c=relaxed/simple;
	bh=bqeF17pNxOmNsfz2ow3ULmE4bY65ueR+thatvt8Z30I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZ+KE1Jyhf+tzgYC003mqp9VV1RCx+Qus/up+A6nrfXIpMVZ1oqiDK/twO0ulvgd3bPrZrmD0zwuEaMKpqNPVOS4B8U3E43Ja0Vgm3YQrCpAiF14rdOefttsMUg6fwXU4vYceCa0Qer5mJ6N1ubPE7uyLbv+L1Uji26+d2gwHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AddUe3Op; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8XDQc014136;
	Wed, 19 Mar 2025 12:48:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yvDGze
	KcLlHeM99R8uCwcgRXc+k4psnBSQcpqN03iXQ=; b=AddUe3Op6mZbAvxy4L0YUU
	yS2koiCHOI7NYLgVnFKeXr7iWrlocFLarNg8yDUPMcngpTfwKfuEvPgdsjmsAN6/
	xRGVjrIdZZiNww6cSIJMwj6TT9IXR3S91OIksTWNi249z/TJbHwMDY+jSyDFMCYM
	kxio0fEcBbSwVM6HRFkfN8THTc/JVTi/QxqmkwEcQupQpAefC5vP4dGLiPW61Oit
	ZTBsmDWHcquwsRuVDnha3j0kQ0si+LL6NRhGr5CP4h3Yjao8mjKGrsF6nkSXwGJ5
	xmLkLNtm5krIl+OQH6XP3SWMxnDqDI0xIwWYukIQZ/bIUGmYp9XDTp7CwwxNb6LQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0pup9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:48:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JBorVe031974;
	Wed, 19 Mar 2025 12:48:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvthuf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 12:48:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JCmhQm17301902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 12:48:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 262B62005A;
	Wed, 19 Mar 2025 12:48:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15A8E20040;
	Wed, 19 Mar 2025 12:48:41 +0000 (GMT)
Received: from [9.124.211.21] (unknown [9.124.211.21])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 12:48:40 +0000 (GMT)
Message-ID: <83c3bd7f-3ff9-4d3c-ab3e-981b73b95141@linux.ibm.com>
Date: Wed, 19 Mar 2025 18:18:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] sched: Make CONFIG_SCHED_DEBUG features unconditional
To: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20250317104257.3496611-1-mingo@kernel.org>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250317104257.3496611-1-mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Wc4qlyw491x6gc2GN8xIJD0sdtR6bXUB
X-Proofpoint-ORIG-GUID: Wc4qlyw491x6gc2GN8xIJD0sdtR6bXUB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=711 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190085



On 3/17/25 16:12, Ingo Molnar wrote:
> For more than a decade, CONFIG_SCHED_DEBUG=y has been enabled
> in all the major Linux distributions:
> 
>     /boot/config-6.11.0-19-generic:CONFIG_SCHED_DEBUG=y
> 
> The reason is that while originally CONFIG_SCHED_DEBUG started
> out as a debugging feature, over the years (decades ...) it has
> grown various bits of statistics, instrumentation and
> control knobs that are useful for sysadmin and general software
> development purposes as well.

A tunable like base_slice which is the only tunable available for EEVDF is under the debug.
So an option is to get rid of CONFIG_SCHED_DEBUG and make it available to all.

We had seen performance regression when domains folder was built with cpu hotplug.
Later that was moved iff verbose was enabled. Maybe something like that can be done
if something is hurting performance.

> 
> But within the kernel we still pretend that there's a choice,
> and sometimes code that is seemingly 'debug only' creates overhead
> that should be optimized in reality.
> 
> So make it all official and make CONFIG_SCHED_DEBUG unconditional.
> This gets rid of a large amount of #ifdefs, so good riddance ...
> 

There are some references in selftest like these, maybe remove them as well?

tools/testing/selftests/sched_ext/config:CONFIG_SCHED_DEBUG=y
tools/testing/selftests/sched/config:CONFIG_SCHED_DEBUG=y
tools/testing/selftests/wireguard/qemu/debug.config:CONFIG_SCHED_DEBUG=y


Also ran unixbench and hackbench on 80 CPU system (1NUMA) with and without CONFIG_SCHED_DEBUG.
hackbench numbers are almost the same.
for unixbench, process creation/Context Switching show 1-2% improvement with CONFIG_SCHED_DEBUG=n


