Return-Path: <linux-kernel+bounces-268597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14EC9426A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582932870C1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101E616C85D;
	Wed, 31 Jul 2024 06:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kz9dgrQ9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97223166315
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407203; cv=none; b=k/NRe6hLNU367Py8/sR4siEpakC2OK+/oLfjJjbCu9S+qoud55pglnoq7w+HKmTKQaULZQJLi88dU2TkaApeOD9duT36rYZhqX3CZOFzhkIslibBb+lZhp9o5a81FAHzKTaoiTgJxAoPndXdK4XpBhzrzGu8z2aJGjYzS+f18y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407203; c=relaxed/simple;
	bh=6pqChnftTAgEz5L/ZTUZc8baYAd9u1DGBsM/1RERyWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0+fiT8VWiMDz86ikXmKFhggop+t6bYvERdBnktBl1WUKrXPZ25faF6CSH9xHUE4EEcxA5rKhpzVIfAo9SHYQ5Q1uxDJA09UcN0MbuqBiCDP9Khn+0AIHnZaPyiTUcgcr0x0kQhG3+E9nooA4klYAx69Y+Iw9TxWXpriVZlneZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kz9dgrQ9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V5ttBN001275;
	Wed, 31 Jul 2024 06:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=P
	ajDTk01Ie6ZSWOInwBQzxcSJnyBwYBRHPUNKjUJL0c=; b=Kz9dgrQ9buGgXqB63
	dqrjO3Sxxoi+NtHwJSlCIHrC2p/6z/+BaoQG+D/3MsRC6L6dv6eAtYE2FnlpdgGA
	md331mIkbmiHheT0n+Rr4ac+cHHjBETiJP66LsIKYMvKxZIRYWa6xTnfXJZ74oTx
	a8PAo7PjiZ/ybsw8Y8y7+7qk0WYBgdabRRlvvJxGhVtNAHjoot6O0MpOK/L1e1Uq
	SVjPC2k7vi5PCCeMlOTg3EIu282XcnZPgaFkdG8NVVr9ixPwvgE4TducCCyjGOJw
	G6dHD9z5kfG6COVUNGaM1WRmzG4L9zVshuO0kjqM8ZAzfKbZ4WWBKRhlo3qMof+7
	Xg+XA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qcgvgdfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 06:25:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46V6PZ7h021340;
	Wed, 31 Jul 2024 06:25:35 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40qcgvgdfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 06:25:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46V6HQMI011295;
	Wed, 31 Jul 2024 06:25:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqmspcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 06:25:33 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46V6PUUC25297540
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 06:25:32 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57CDA58068;
	Wed, 31 Jul 2024 06:25:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2711F58059;
	Wed, 31 Jul 2024 06:25:25 +0000 (GMT)
Received: from [9.124.31.50] (unknown [9.124.31.50])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 06:25:24 +0000 (GMT)
Message-ID: <35f07ff4-62c5-4602-986d-1d5a1d7fe47b@linux.ibm.com>
Date: Wed, 31 Jul 2024 11:55:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powerpc/topology: Check if a core is online
To: "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michal Suchanek
 <msuchanek@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Laurent Dufour <ldufour@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20240731030126.956210-1-nysal@linux.ibm.com>
 <20240731030126.956210-3-nysal@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240731030126.956210-3-nysal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XnzHPJLYwUgEz1f5pi0rFjxQOS9n-e9P
X-Proofpoint-GUID: AhVZH6xN9WCGvit_YUdVhnCxlpIDWZJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_03,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407310046



On 7/31/24 8:31 AM, Nysal Jan K.A. wrote:
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
>  #include <asm/cputhreads.h>
>  
>  static inline bool topology_is_primary_thread(unsigned int cpu)
> @@ -156,6 +157,18 @@ static inline bool topology_smt_thread_allowed(unsigned int cpu)
>  {
>  	return cpu_thread_in_core(cpu) < cpu_smt_num_threads;
>  }
> +
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

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

