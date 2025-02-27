Return-Path: <linux-kernel+bounces-535773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3203AA476F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 945ED188EBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBCA225793;
	Thu, 27 Feb 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oCYHv0qe"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB422576C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740643157; cv=none; b=aMUKwY0EKVRdk8pyEJpNT+OzHpESmlU5DeVcOmlanlmnXLIXwIV3rJE0yjbWBv/CsunmzzlF/ExPWGDYkw8geunY81ZUy4F2Dqy3wD/rRJYeoEWg03IQ2+JB2AgjzrRtS+gla9SgXrVUtAbHcNRvCikIdojP22kYMxJOS5te1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740643157; c=relaxed/simple;
	bh=C7XpAVDvvpP636PA4phPjbxfcO/dKnkhfIXAYN/dxTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DShIwZuLJugpIXYySQM1t6u+pQpbizEb7P12rlx2bKpL7svDXYlINsyh36FSO8dPJWBRAkNR7w0amTTaFhGjz4xPK+aB2MVFdvlWrwoKiRk1891kFGCO301Zqaz8ALSb5KxNTcluOTcvWYFVBRGG0M9PG0Eowlm+UnTve4wbTsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oCYHv0qe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R20mqA004420;
	Thu, 27 Feb 2025 07:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UHWZo9
	17tMyC1vbiVE+IknaJRjo3mFkJ+Nfxkv9J5zg=; b=oCYHv0qeml8XFExkgmR/N6
	UtdlACk2CgwXKZRuFuxEYSl7MUv3ivAI2zMmEAWN0S5FI5hJ52SbYqx577b99eCz
	BL6kVbHj5ce3/B6wWiC1o5Qf6VUMFhPtDMMrncT6ToZ+tMRoKDmOvUOa21+t40fg
	cfRQWN50/Qo2oF8FWcEj0OhI3vdyj5C0cIhL3lWsPUwLNtLw1vO6Sam2raVPSclO
	onduqOjUAwUcRLooSwhYUU44NNsYUDUzv/a8oqQu+rGs9Xrg/Pxl7LRQqsBKeTSx
	n6fb0g24nGsXGA/1OBTVuWAQB+a5SvwBPyfBnYZ2plm/h0UJyBGzgtus5EIrWa/g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452ew0h949-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 07:58:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R5mgNh026287;
	Thu, 27 Feb 2025 07:58:36 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnqdc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 07:58:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51R7wXRj48300432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 07:58:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4FC120043;
	Thu, 27 Feb 2025 07:58:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3751520040;
	Thu, 27 Feb 2025 07:58:32 +0000 (GMT)
Received: from [9.39.16.153] (unknown [9.39.16.153])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 07:58:32 +0000 (GMT)
Message-ID: <0d890fd4-5df0-4a19-a278-74c95aa19935@linux.ibm.com>
Date: Thu, 27 Feb 2025 13:28:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] sched/cputime: issue with time accounting using default
 configs
To: frederic@kernel.org
Cc: mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        maddy@linux.ibm.com, dietmar.eggemann@arm.com, riel@surriel.com,
        linux-kernel@vger.kernel.org
References: <20250211194558.803373-1-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250211194558.803373-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rQJ8iYbosvmqu5GpfB0K_2utamuKt3j7
X-Proofpoint-ORIG-GUID: rQJ8iYbosvmqu5GpfB0K_2utamuKt3j7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=675 lowpriorityscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270056



On 2/12/25 01:15, Shrikanth Hegde wrote:
> While experimenting with irq time accounting stumbled upon this issue
> with cputime accounting while running simple benchmarks.
> 
> This is very likely a common issue across different archs unless one turns
> on IRQ_TIME_ACCOUNTING. Took a look at src rpms of rhel and suse. Only
> rhel on x86 seems to enable it.
> 
> (default configs)
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> all    3.41    0.00   73.81    0.00   22.00    0.00    0.10    0.00    0.00    0.67
> all    3.39    0.00   73.30    0.00   22.71    0.01    0.01    0.00    0.00    0.58
> 
> (With CONFIG_IRQ_TIME_ACCOUNTING=y)
> CONFIG_VIRT_CPU_ACCOUNTING=y
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_IRQ_TIME_ACCOUNTING=y
> CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> all    3.64    0.00   94.26    0.00    1.77    0.06    0.05    0.00    0.00    0.21
> all    3.42    0.00   93.89    0.00    1.94    0.07    0.00    0.00    0.00    0.68
> 
> 
> Forced NATIVE to be enabled by removing conditional check in NO_HZ_FULL.
> CONFIG_VIRT_CPU_ACCOUNTING=y
> # CONFIG_TICK_CPU_ACCOUNTING is not set
> CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
> CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> all    5.78    0.00   92.55    0.00    1.56    0.00    0.00    0.00    0.00    0.11
> all    6.14    0.00   91.86    0.00    1.68    0.02    0.00    0.00    0.00    0.29
> 
> Given the code, NATIVE accounting seems most accurate,
> since it tracks enter/exit of user, hardirq, softirqs.
> Though it comes with its own overhead.
> 
> 
> Such a drastic difference w.r.t to *irq time*. That made me wonder why?
> This happens because of when NO_HZ_FULL is chosen, NATIVE accounting
> cannot be enabled and GENeric is the option.
> GEN -> account_process_tick ->
> 	-> if context tracking is enabled, do accounting based on it.
> 	-> if irq_time accounting is enabled, do that.
> 	-> If not, fall back to simple tick based accounting. With this
> 	   whole tick duration can be attributed to IRQ. Which is not true.
> 
> NATIVE -> account_process_tick ->
> 	vtime_flush - native based accounting.
> 
> 
> The main concern is, context tracking is enabled only if NO_HZ_FULL=y and
> (nohz_full= or isolcpus=) is set. Most of the kernels are built with
> NO_HZ_FULL, but many may not pass the nohz_full=. (correct me if i am
> wrong). This leads to context tracking isn't being enabled. Since irq
> time isn't enabled either, it falls into simple tick based accounting.
> 
> A few ways to fix. Some may not be sane. These are the hacks that i have
> tried.
> 
> 1. Looking at irq_time vs native accounting, seems like irq_time is
> lightweight and close enough to native. maybe that can be a middle
> ground. So enable it for the arch default configs. That way distros can
> enable it. below patch is with this method.
> NOTE: this needs more work still w.r.t to measuring the overhead.
> 
> 2. Select IRQ_TIME_ACCOUNTING in case of NO_HZ_FULL. This would fix this
> accounting issue for all archs. But given a slight overhead, some archs
> may not want it.
> 
> 3. If context tracking is not enabled, then do native way if archs
> supports it. since native and irq_time are exclusive only one of them
> can be enabled. This needs a lot of change given how the current code is
> with macros. Also this meant decoupling native from NO_HZ_FULL.
>   
> Is this a problem worth fixing? are there any better way to fix it?

Hi Frederic. Any comments on this?

This is a generic problem across different archs. Not sure whats the 
best way to fix it. Convincing people to enable it in their config may 
be one way.

> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/configs/ppc64_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
> index 465eb96c755e..9bc678d92384 100644
> --- a/arch/powerpc/configs/ppc64_defconfig
> +++ b/arch/powerpc/configs/ppc64_defconfig
> @@ -3,6 +3,7 @@ CONFIG_POSIX_MQUEUE=y
>   CONFIG_AUDIT=y
>   CONFIG_NO_HZ_FULL=y
>   CONFIG_NO_HZ=y
> +CONFIG_IRQ_TIME_ACCOUNTING=y
>   CONFIG_HIGH_RES_TIMERS=y
>   CONFIG_BPF_SYSCALL=y
>   CONFIG_BPF_JIT=y


