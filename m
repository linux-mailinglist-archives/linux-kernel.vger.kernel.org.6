Return-Path: <linux-kernel+bounces-227828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB379156EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 21:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1F71F257B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642F19F461;
	Mon, 24 Jun 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Iabx3xQs"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95438143C42
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719256023; cv=none; b=UJM5XuN0rsdb+EEAMkMrj213n5rbPQkrSFOKvsmSbG1qhgczgPXX5V/+Ftl1K6CwhIm7DgeTmZDyy7xdoPvZZgpfIS9nuT8QysW9BxMu1H5mcHw3DCZl/LuiO5eHxpPRhKogrfOJTyQ6WTNHr4Qsj25DWFvrbEbBQ/WR8cT8ArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719256023; c=relaxed/simple;
	bh=W6G+Q1tg7TlhM7SoVS9zsTvhMIzdziIrIDzgHW7QOWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pg1NdNjNnK4fLeJh06f4J4ozjc1i16Kk/tr2mslytpFx9xR7dVFg3HKPJJFXGRETFN4jb/V6hpuII6Itw0NRL4fsQgZJmXxQrJypPdMRuX26fDSN8gBqZo07vPijc8iW+N8DjAW+mM/ot1hNIyNsbBIE1AEwN90VnRFLqPkj2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Iabx3xQs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OIwsJJ003611;
	Mon, 24 Jun 2024 19:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=J
	QEkpOQYUKFNBRFaVU1A31CflhoQEmOK65Jsv4CqjkE=; b=Iabx3xQsZFmUQp3Qe
	9Ty2HWQ6xi/0n0T9LxaIfVha4VO4UicTX3UWlwAVj68E/I3brha5uVQ4iaqefOeV
	vJHmDSfw1feIB5/1wv+Y0gLT1Oz06TnWxWw0a1yUAk0eVJkLNZWvRunT2wvvmPNi
	hN5+InKY55kozaAxl83gdlUqYcdQgi8OVRvQ4ckFh/unSjYBMSI7KB9/P6GECkj4
	p4Kn7WsUDAjCwXNjwcAWIGKdvurTdN51yLINSqCZVttFcMbjlZthvV+AdEF8KuPc
	VjJ/+FcgSaV98eGg1njcquFhZ3HNPEJp9eehJdO4LrGeiMkXhPEeyBidu9KkPyz+
	g5yRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyehy80n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 19:06:42 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45OJ6gZq015773;
	Mon, 24 Jun 2024 19:06:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyehy80n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 19:06:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45OFq5og019533;
	Mon, 24 Jun 2024 19:06:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yx9xptdq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 19:06:41 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45OJ6clc14680686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 19:06:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BF9858043;
	Mon, 24 Jun 2024 19:06:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0760558059;
	Mon, 24 Jun 2024 19:06:35 +0000 (GMT)
Received: from [9.124.215.163] (unknown [9.124.215.163])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Jun 2024 19:06:34 +0000 (GMT)
Message-ID: <985e10dd-230b-4325-856f-1229361205d2@linux.ibm.com>
Date: Tue, 25 Jun 2024 00:36:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] powerpc/topology: Check if a core is online
To: "Nysal Jan K.A." <nysal@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michal Suchanek
 <msuchanek@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour
 <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
 <20240612185046.1826891-3-nysal@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20240612185046.1826891-3-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8CnmPtPf1ckobgKt-cowbh8L9dENGwb7
X-Proofpoint-ORIG-GUID: lXK-XR7efh7iYDJc7JT_EX6dUskqOI4D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_15,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1011 mlxlogscore=971 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240150



On 6/13/24 12:20 AM, Nysal Jan K.A. wrote:
> From: "Nysal Jan K.A" <nysal@linux.ibm.com>
> 
> topology_is_core_online() checks if the core a CPU belongs to
> is online. The core is online if at least one of the sibling
> CPUs is online. The first CPU of an online core is also online
> in the common case, so this should be fairly quick.
> 
> Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/topology.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
> index f4e6f2dd04b7..16bacfe8c7a2 100644
> --- a/arch/powerpc/include/asm/topology.h
> +++ b/arch/powerpc/include/asm/topology.h
> @@ -145,6 +145,7 @@ static inline int cpu_to_coregroup_id(int cpu)
>  
>  #ifdef CONFIG_HOTPLUG_SMT
>  #include <linux/cpu_smt.h>
> +#include <linux/cpumask.h>

Is this header file needed? 
I don't see any reference to cpumask related code. 

>  #include <asm/cputhreads.h>
>  
>  static inline bool topology_is_primary_thread(unsigned int cpu)
> @@ -156,6 +157,18 @@ static inline bool topology_smt_thread_allowed(unsigned int cpu)
>  {
>  	return cpu_thread_in_core(cpu) < cpu_smt_num_threads;
>  }
> +

This is defined only if CONFIG_HOTPLUG_SMT is true. But this could be 
generic function which might be used to check if a core is offline in other cases. 
Would that make sense to keep it out of CONFIG_HOTPLUG_SMT ?

> +#define topology_is_core_online topology_is_core_online
> +static inline bool topology_is_core_online(unsigned int cpu)
> +{
> +	int i, first_cpu = cpu_first_thread_sibling(cpu);
> +
> +	for (i = first_cpu; i < first_cpu + threads_per_core; ++i) {
> +		if (cpu_online(i))
> +			return true;
> +	}
> +	return false;
> +}
>  #endif
>  
>  #endif /* __KERNEL__ */

