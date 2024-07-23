Return-Path: <linux-kernel+bounces-259676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D8939B61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B93A1F22295
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CBB14A614;
	Tue, 23 Jul 2024 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mqbj6bbq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052613A865;
	Tue, 23 Jul 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721718345; cv=none; b=FiEhnfw3ZUjNVh0SPGv4VcOAdhCL9g1mqklgiV5W7xOuIuPelzctJXH2HAh9Es5+zDWbbkdj9zZx9n3b7efioNc+lPOkBw6AkQLAPpppx0tK1zqopC1cknPzbpdaRaVHLjIJTegF27ENU2AKGHx+BgywiuEDp6kt+RHbjFEAa6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721718345; c=relaxed/simple;
	bh=OdChwglmTm4XZDH0iJfniYjnXsXZlyB0Lyqc6Mqh4pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lTsrtNfJBcKSoRjAm2yVwyiyPzCiy+4Z+Y0n2mgumV3D824zYi9+UKojmMpTxXf+ITvTQ3IvFZo4/v0C95CaSVScb2iX080virKbRP5HP/LOsozGMR0o6KZnv9i4TYA0tn0R7+OC/Jf9OF3ntqhSqFq3l+rC0VKlMmPamW+rl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mqbj6bbq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N3uWBi021882;
	Tue, 23 Jul 2024 07:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=/
	L0bLC9Wxty8S0S0fHI+nEfJVqoONx3J0d/1CnrCRCA=; b=mqbj6bbqrXSq6NDFf
	F9Ob8DRy1vGz5ioseh+9qNsWMmbt5M42TkZiOFxFmIjIt+aZgMX/eQhtrfxK46qL
	oa6exJZ/bHzh0CHO2Vp7lOdb4tgQ4RltHkEcC//BgJYurCB27I97hsn6AChOCTm3
	SNSfPaavn7WUTn7J0M/w0a2ZO75sgmv++bT2mmnOMMTnN4Aq+JUfWBtQDKr7PLTX
	8Ko19SPAuzUHHx2UHabpdedL1K2y1McyWkidu3aqZF5WLqJ5y1Qvs1itQ2bBaiIQ
	feZVQ/o32noGNHt2vLQFLxvhCjovDiNQ5wVAthaSvOZTQ1houU1QaJIYn9LrWPzQ
	ACOng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rvresa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 07:05:26 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N75Q4t024830;
	Tue, 23 Jul 2024 07:05:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40j3rvres9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 07:05:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N51xcg009131;
	Tue, 23 Jul 2024 07:05:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93a4p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 07:05:25 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N75KmZ15925748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 07:05:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 204A92006A;
	Tue, 23 Jul 2024 07:05:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 262E52006E;
	Tue, 23 Jul 2024 07:05:18 +0000 (GMT)
Received: from [9.109.252.211] (unknown [9.109.252.211])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 07:05:17 +0000 (GMT)
Message-ID: <7ccf31b5-7eaf-4b42-bf9c-b48d1fa5c2cf@linux.ibm.com>
Date: Tue, 23 Jul 2024 12:35:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events power10: Update JSON/events
To: Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        hbathini@linux.ibm.com, disgoel@linux.vnet.ibm.com
References: <20240723052154.96202-1-kjain@linux.ibm.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20240723052154.96202-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iSrEeDzTdA2ZObxTFiQtYRxNmjL9GBbV
X-Proofpoint-GUID: Uj-47-lCE80N20ztH-Jdh4xyQQcR2WG4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 clxscore=1011 spamscore=0 phishscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230050

On 23/07/24 10:51 am, Kajol Jain wrote:

> Update JSON/events for power10 platform with additional events.
> Also move PM_VECTOR_LD_CMPL event from others.json to
> frontend.json file.
>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>

I have tested the patch on power10 machine. Looks good to me.

Tested-by: Disha Goel <disgoel@linux.ibm.com>

> ---
>   .../arch/powerpc/power10/frontend.json        |   5 +
>   .../arch/powerpc/power10/others.json          | 100 +++++++++++++++++-
>   2 files changed, 100 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> index 5977f5e64212..53660c279286 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/frontend.json
> @@ -74,6 +74,11 @@
>       "EventName": "PM_ISSUE_KILL",
>       "BriefDescription": "Cycles in which an instruction or group of instructions were cancelled after being issued. This event increments once per occurrence, regardless of how many instructions are included in the issue group."
>     },
> +  {
> +    "EventCode": "0x44054",
> +    "EventName": "PM_VECTOR_LD_CMPL",
> +    "BriefDescription": "Vector load instruction completed."
> +  },
>     {
>       "EventCode": "0x44056",
>       "EventName": "PM_VECTOR_ST_CMPL",
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> index fcf8a8ebe7bd..53ca610152fa 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> @@ -94,11 +94,6 @@
>       "EventName": "PM_L1_ICACHE_RELOADED_ALL",
>       "BriefDescription": "Counts all instruction cache reloads includes demand, prefetch, prefetch turned into demand and demand turned into prefetch."
>     },
> -  {
> -    "EventCode": "0x44054",
> -    "EventName": "PM_VECTOR_LD_CMPL",
> -    "BriefDescription": "Vector load instruction completed."
> -  },
>     {
>       "EventCode": "0x4D05E",
>       "EventName": "PM_BR_CMPL",
> @@ -108,5 +103,100 @@
>       "EventCode": "0x400F0",
>       "EventName": "PM_LD_DEMAND_MISS_L1_FIN",
>       "BriefDescription": "Load missed L1, counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x00000038BC",
> +    "EventName": "PM_ISYNC_CMPL",
> +    "BriefDescription": "Isync completion count per thread."
> +  },
> +  {
> +    "EventCode": "0x000000C088",
> +    "EventName": "PM_LD0_32B_FIN",
> +    "BriefDescription": "256-bit load finished in the LD0 load execution unit."
> +  },
> +  {
> +    "EventCode": "0x000000C888",
> +    "EventName": "PM_LD1_32B_FIN",
> +    "BriefDescription": "256-bit load finished in the LD1 load execution unit."
> +  },
> +  {
> +    "EventCode": "0x000000C090",
> +    "EventName": "PM_LD0_UNALIGNED_FIN",
> +    "BriefDescription": "Load instructions in LD0 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline using the load gather buffer. This typically adds about 10 cycles to the latency of the instruction. This includes loads that cross the 128 byte boundary, octword loads that are not aligned, and a special forward progress case of a load that does not hit in the L1 and crosses the 32 byte boundary and is launched NTC. Counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C890",
> +    "EventName": "PM_LD1_UNALIGNED_FIN",
> +    "BriefDescription": "Load instructions in LD1 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline using the load gather buffer. This typically adds about 10 cycles to the latency of the instruction. This includes loads that cross the 128 byte boundary, octword loads that are not aligned, and a special forward progress case of a load that does not hit in the L1 and crosses the 32 byte boundary and is launched NTC. Counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C0A4",
> +    "EventName": "PM_ST0_UNALIGNED_FIN",
> +    "BriefDescription": "Store instructions in ST0 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline. This typically adds about 10 cycles to the latency of the instruction. This only includes stores that cross the 128 byte boundary. Counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C8A4",
> +    "EventName": "PM_ST1_UNALIGNED_FIN",
> +    "BriefDescription": "Store instructions in ST1 port that are either unaligned, or treated as unaligned and require an additional recycle through the pipeline. This typically adds about 10 cycles to the latency of the instruction. This only includes stores that cross the 128 byte boundary. Counted at finish time."
> +  },
> +  {
> +    "EventCode": "0x000000C8B8",
> +    "EventName": "PM_STCX_SUCCESS_CMPL",
> +    "BriefDescription": "STCX instructions that completed successfully. Specifically, counts only when a pass status is returned from the nest."
> +  },
> +  {
> +    "EventCode": "0x000000D0B4",
> +    "EventName": "PM_DC_PREF_STRIDED_CONF",
> +    "BriefDescription": "A demand load referenced a line in an active strided prefetch stream. The stream could have been allocated through the hardware prefetch mechanism or through software."
> +  },
> +  {
> +    "EventCode": "0x000000F880",
> +    "EventName": "PM_SNOOP_TLBIE_CYC",
> +    "BriefDescription": "Cycles in which TLBIE snoops are executed in the LSU."
> +  },
> +  {
> +    "EventCode": "0x000000F084",
> +    "EventName": "PM_SNOOP_TLBIE_CACHE_WALK_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which the data cache is being walked."
> +  },
> +  {
> +    "EventCode": "0x000000F884",
> +    "EventName": "PM_SNOOP_TLBIE_WAIT_ST_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which older stores are still draining."
> +  },
> +  {
> +    "EventCode": "0x000000F088",
> +    "EventName": "PM_SNOOP_TLBIE_WAIT_LD_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which older loads are still draining."
> +  },
> +  {
> +    "EventCode": "0x000000F08C",
> +    "EventName": "PM_SNOOP_TLBIE_WAIT_MMU_CYC",
> +    "BriefDescription": "TLBIE snoop cycles in which the Load-Store unit is waiting for the MMU to finish invalidation."
> +  },
> +  {
> +    "EventCode": "0x0000004884",
> +    "EventName": "PM_NO_FETCH_IBUF_FULL_CYC",
> +    "BriefDescription": "Cycles in which no instructions are fetched because there is no room in the instruction buffers."
> +  },
> +  {
> +    "EventCode": "0x00000048B4",
> +    "EventName": "PM_BR_TKN_UNCOND_FIN",
> +    "BriefDescription": "An unconditional branch finished. All unconditional branches are taken."
> +  },
> +  {
> +    "EventCode": "0x0B0000016080",
> +    "EventName": "PM_L2_TLBIE_SLBIE_START",
> +    "BriefDescription": "NCU Master received a TLBIE/SLBIEG/SLBIAG operation from the core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
> +  },
> +  {
> +    "EventCode": "0x0B0000016880",
> +    "EventName": "PM_L2_TLBIE_SLBIE_DELAY",
> +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG command was held in a hottemp condition by the NCU Master. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_TLBIE_SLBIE_SENT to obtain the average time a TLBIE/SLBIEG/SLBIAG command was held. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
> +  },
> +  {
> +    "EventCode": "0x0B0000026880",
> +    "EventName": "PM_L2_SNP_TLBIE_SLBIE_DELAY",
> +    "BriefDescription": "Cycles when a TLBIE/SLBIEG/SLBIAG that targets this thread's LPAR was in flight while in a hottemp condition. Multiply this count by 1000 to obtain the total number of cycles. This can be divided by PM_L2_SNP_TLBIE_SLBIE_START to obtain the overall efficiency. Note: ’inflight’ means SnpTLB has been sent to core(ie doesn’t include when SnpTLB is in NCU waiting to be launched serially behind different SnpTLB). The NCU Snooper gets in a ’hottemp’ delay window when it detects it is above its TLBIE/SLBIE threshold for process SnpTLBIE/SLBIE with this core. Event count should be multiplied by 2 since the data is coming from a 2:1 clock domain and the data is time sliced across all 4 threads."
>     }
>   ]

