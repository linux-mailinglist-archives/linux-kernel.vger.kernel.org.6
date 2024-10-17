Return-Path: <linux-kernel+bounces-369941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75829A24AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8C21F22506
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEC41DEFD0;
	Thu, 17 Oct 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YTsIBuoU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40651DEFC8;
	Thu, 17 Oct 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174324; cv=none; b=mLsCPiPWuCn869HapFVz8gn1IO6dTGHfCZzAOkOrcPd7+K3qb/R22105fMfMkBHsUERSnxq0oZ4e7x/bSyhv/NZTE1+/Sj4asWBlXyvA7PQVYGuu6EGsiAMAUbykA57mVmQtb4krvYsvBf97w+1cfnOuBGTNm76YlTIzfrTAzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174324; c=relaxed/simple;
	bh=X3sd5hHizADI8faMaqib2IBECL2kowkQ3t7buyD5StA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqmX1/ys9z72XNbmG8BfL2nTDZs+L8Ii3k8aV75Zye3KmE00xeTHLWoKtxqDCXD+T3zWDhgGFKQWSZ5csTabQ4PAmMbyjmmyJCAw4fi115UEDgGb0Laf7fe8Z7TIe8o1Pq1zy0PhBVFRjNWB/ke4+0thUMq0dy3StLhkMr49qkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YTsIBuoU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HBnqMc002639;
	Thu, 17 Oct 2024 14:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=T7H4u2
	aenkwuBgJYTWb5ohJ8FMfKVJpa3khkvy8w2yU=; b=YTsIBuoU7RjVZDFADOc4Um
	4TGLGjlzvISwQ/bjSI/anbUFtj4jETSAIBxkaM3P/lpFbvUnXvvBt6x8OY/hBLsG
	KrMRCrmYxlnClQSCoSP0ISVRdEhp26rc7MZcKbuv8dGxyqX7TDmFVkKLnD2Qmsm+
	DUgZ/Ppp1eH3lZUyqDTT/d47AroELm3n9ah0SWe7vpQ6Y5SHRDaUkjDazgy6IZJg
	cp7VbOcdtsHWVOYb3MxV5J7+6k5H+sq9qwXeUn3LJLT6vMxpoXVroQNVGV0sQfZa
	aK0zbHLMrssH5VYKuGW3cWf/gUnevhBt52cFq8rrqPHDFpZRqjrhUSzo8VbNJHzg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u3bxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 14:11:45 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49HE8oSV018126;
	Thu, 17 Oct 2024 14:11:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ar0u3bxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 14:11:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49HDae84005374;
	Thu, 17 Oct 2024 14:11:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285njf2ve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 14:11:44 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49HEBeAF22807104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 14:11:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94E4F2004B;
	Thu, 17 Oct 2024 14:11:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ED5520043;
	Thu, 17 Oct 2024 14:11:35 +0000 (GMT)
Received: from [9.61.240.109] (unknown [9.61.240.109])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Oct 2024 14:11:34 +0000 (GMT)
Message-ID: <f9d3e1ce-9b43-4e12-8d0c-6e30a12174d8@linux.ibm.com>
Date: Thu, 17 Oct 2024 19:41:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] tools/perf/pmu-events/powerpc: Add support for
 compat events in json
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
        namhyung@kernel.org, hbathini@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, kjain@linux.ibm.com
References: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-GB
From: Disha Goel <disgoel@linux.ibm.com>
In-Reply-To: <20241010145107.51211-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BtHeLm8IZStEeRWZEcfiThbb-aaO-liC
X-Proofpoint-ORIG-GUID: Q5jCgTE8keNmh0JEKGZWAZNTElHQWOGu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170096

On 10/10/24 8:21 pm, Athira Rajeev wrote:

> perf list picks the events supported for specific platform
> from pmu-events/arch/powerpc/<platform>. Example power10 events
> are in pmu-events/arch/powerpc/power10, power9 events are part
> of pmu-events/arch/powerpc/power9. The decision of which
> platform to pick is determined based on PVR value in powerpc.
> The PVR value is matched from pmu-events/arch/powerpc/mapfile.csv
>
> Example:
>
> Format:
>          PVR,Version,JSON/file/pathname,Type
>
> 0x004[bcd][[:xdigit:]]{4},1,power8,core
> 0x0066[[:xdigit:]]{4},1,power8,core
> 0x004e[[:xdigit:]]{4},1,power9,core
> 0x0080[[:xdigit:]]{4},1,power10,core
> 0x0082[[:xdigit:]]{4},1,power10,core
>
> The code gets the PVR from system using get_cpuid_str function
> in arch/powerpc/util/headers.c ( from SPRN_PVR ) and compares
> with value from mapfile.csv
>
> In case of compat mode, say when partition is booted in a power9
> mode when the system is a power10, add an entry to pick the
> ISA architected events from "pmu-events/arch/powerpc/compat".
> Add json file generic-events.json which will contain these
> events which is supported in compat mode.
>
> Suggested-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

I have tested the patch on PowerPC by booting in different compat modes and
at base also, and it's working as expected.

For the series:
Tested-by: Disha Goel<disgoel@linux.ibm.com>

> ---
>
>   .../arch/powerpc/compat/generic-events.json   | 117 ++++++++++++++++++
>   .../perf/pmu-events/arch/powerpc/mapfile.csv  |   1 +
>   2 files changed, 118 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json b/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
> new file mode 100644
> index 000000000000..6f5e8efcb098
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
> @@ -0,0 +1,117 @@
> +[
> +  {
> +    "EventCode": "0x600F4",
> +    "EventName": "PM_CYC",
> +    "BriefDescription": "Processor cycles."
> +  },
> +  {
> +    "EventCode": "0x100F2",
> +    "EventName": "PM_CYC_INST_CMPL",
> +    "BriefDescription": "1 or more ppc insts finished"
> +  },
> +  {
> +    "EventCode": "0x100f4",
> +    "EventName": "PM_FLOP_CMPL",
> +    "BriefDescription": "Floating Point Operations Finished."
> +  },
> +  {
> +    "EventCode": "0x100F6",
> +    "EventName": "PM_L1_ITLB_MISS",
> +    "BriefDescription": "Number of I-ERAT reloads."
> +  },
> +  {
> +    "EventCode": "0x100F8",
> +    "EventName": "PM_NO_INST_AVAIL",
> +    "BriefDescription": "Number of cycles the ICT has no itags assigned to this thread."
> +  },
> +  {
> +    "EventCode": "0x100fc",
> +    "EventName": "PM_LD_CMPL",
> +    "BriefDescription": "Load instruction completed."
> +  },
> +  {
> +    "EventCode": "0x200F0",
> +    "EventName": "PM_ST_CMPL",
> +    "BriefDescription": "Stores completed from S2Q (2nd-level store queue)."
> +  },
> +  {
> +    "EventCode": "0x200F2",
> +    "EventName": "PM_INST_DISP",
> +    "BriefDescription": "PowerPC instruction dispatched."
> +  },
> +  {
> +    "EventCode": "0x200F4",
> +    "EventName": "PM_RUN_CYC",
> +    "BriefDescription": "Processor cycles gated by the run latch."
> +  },
> +  {
> +    "EventCode": "0x200F6",
> +    "EventName": "PM_L1_DTLB_RELOAD",
> +    "BriefDescription": "DERAT Reloaded due to a DERAT miss."
> +  },
> +  {
> +    "EventCode": "0x200FA",
> +    "EventName": "PM_BR_TAKEN_CMPL",
> +    "BriefDescription": "Branch Taken instruction completed."
> +  },
> +  {
> +    "EventCode": "0x200FC",
> +    "EventName": "PM_L1_ICACHE_MISS",
> +    "BriefDescription": "Demand instruction cache miss."
> +  },
> +  {
> +    "EventCode": "0x200FE",
> +    "EventName": "PM_L1_RELOAD_FROM_MEM",
> +    "BriefDescription": "L1 Dcache reload from memory"
> +  },
> +  {
> +    "EventCode": "0x300F0",
> +    "EventName": "PM_ST_MISS_L1",
> +    "BriefDescription": "Store Missed L1"
> +  },
> +  {
> +    "EventCode": "0x300FC",
> +    "EventName": "PM_DTLB_MISS",
> +    "BriefDescription": "Data PTEG reload"
> +  },
> +  {
> +    "EventCode": "0x300FE",
> +    "EventName": "PM_DATA_FROM_L3MISS",
> +    "BriefDescription": "Demand LD - L3 Miss (not L2 hit and not L3 hit)"
> +  },
> +  {
> +    "EventCode": "0x400F0",
> +    "EventName": "PM_LD_MISS_L1",
> +    "BriefDescription": "L1 Dcache load miss"
> +  },
> +  {
> +    "EventCode": "0x400F2",
> +    "EventName": "PM_CYC_INST_DISP",
> +    "BriefDescription": "Cycle when instruction(s) dispatched."
> +  },
> +  {
> +    "EventCode": "0x400F6",
> +    "EventName": "PM_BR_MPRED_CMPL",
> +    "BriefDescription": "A mispredicted branch completed. Includes direction and target."
> +  },
> +  {
> +    "EventCode": "0x400FA",
> +    "EventName": "PM_RUN_INST_CMPL",
> +    "BriefDescription": "PowerPC instruction completed while the run latch is set."
> +  },
> +  {
> +    "EventCode": "0x400FC",
> +    "EventName": "PM_ITLB_MISS",
> +    "BriefDescription": "Instruction TLB reload (after a miss), all page sizes. Includes only demand misses."
> +  },
> +  {
> +    "EventCode": "0x400fe",
> +    "EventName": "PM_LD_NOT_CACHED",
> +    "BriefDescription": "Load data not cached."
> +  },
> +  {
> +    "EventCode": "0x500fa",
> +    "EventName": "PM_INST_CMPL",
> +    "BriefDescription": "Instructions."
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> index 4d5e9138d4cc..cbd3cb443784 100644
> --- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
> @@ -16,3 +16,4 @@
>   0x004e[[:xdigit:]]{4},1,power9,core
>   0x0080[[:xdigit:]]{4},1,power10,core
>   0x0082[[:xdigit:]]{4},1,power10,core
> +0x00ffffff,1,compat,core

