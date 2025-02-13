Return-Path: <linux-kernel+bounces-512279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95392A336FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D85188A09B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 04:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837492063CE;
	Thu, 13 Feb 2025 04:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="imIUzwK7"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FD1C32
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739421861; cv=none; b=fYbIRCvN2PilhVfnJS5/5XFJzPYtyYnHsTTrKZIpDHp4Wy0pwwlF0+0va/IhjQoZ+SnQ/ErcsYU8mAj1f/kspPcqP0m7Cf+fG4EWLmDKQwnBXpzAUsfrTQPmfgrH/us0w6N40BfApPv9x+RzznGN+YHpsH5Bxt0kCcYDk6YJAjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739421861; c=relaxed/simple;
	bh=drVkAyePIIRVb3U78qtsE2GtN+5EMPW0W1zFx7IEdgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7FXTKstMXS9jfogaLGbRM97UbjSfedzA70u0Yfxs8KRjBid/Ze0D9Gw0LjyTBSJOvjM5IWeaVw9djPYHg+Of4kRJMgjSPYCyvmcc2R3xhUCteZoSSwIIWqC/cC/jSV0zOQpj7sfDVhhgBCp0iJbyDSYU6IVLJC+OdMXo6EubDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=imIUzwK7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CKGLrS001189;
	Thu, 13 Feb 2025 04:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/68Edk
	UNTsGgVfVSarjfx2wGB3lzY4WrNOHU1PhSVUc=; b=imIUzwK7hRrqP7c1FyKGzM
	3ou7IA7aEjf4DaXqQabAVkxhMu/zZ9RG2r0dxAC30T8lujLUTFAOaK/xnx//7fJ+
	27T1No7npPaVTJgD3ix5IYwq39QDJG3SAoDUa9+Q6I4PFNzT1SbRDOeLnelqxXiV
	BTL5/GhcFOziIR48bD3+p5pnUIrzMZLIX+VPx23lORVHzpRRBRD1O+FmtNJ8y0/z
	pep4Cewazo+Asonor2zjr/iOFVGCIt3NwzTu6VDr314954P3Hi/h7uUQPAhmB0iB
	qWm5s23MizLNBkDHtXuQXEMT7uUxL4wnXHrVQ0JBOnbeTbOqw0ToxUW3h8fE4sWg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rqbpe1uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 04:44:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51D3K2Ew000914;
	Thu, 13 Feb 2025 04:44:09 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkncgt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 04:44:09 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51D4i8am41419404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 04:44:08 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E2595805A;
	Thu, 13 Feb 2025 04:44:08 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A60F658051;
	Thu, 13 Feb 2025 04:44:05 +0000 (GMT)
Received: from [9.43.122.236] (unknown [9.43.122.236])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 04:44:05 +0000 (GMT)
Message-ID: <4a8d54e7-fa29-4ce4-9023-3cdffa0807e6@linux.ibm.com>
Date: Thu, 13 Feb 2025 10:14:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [CHANGE 1/2] sched/isolation: Make use of more than one
 housekeeping cpu
To: Phil Auld <pauld@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250211140104.420739-1-pauld@redhat.com>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20250211140104.420739-1-pauld@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pWCI2sAJPYZvnT0xzdidMqUIFp-YjQNV
X-Proofpoint-ORIG-GUID: pWCI2sAJPYZvnT0xzdidMqUIFp-YjQNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_01,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130032

Hi Phil Auld,

On 11/02/25 19:31, Phil Auld wrote:
> The exising code uses housekeeping_any_cpu() to select a cpu for
> a given housekeeping task. However, this often ends up calling
> cpumask_any_and() which is defined as cpumask_first_and() which has
> the effect of alyways using the first cpu among those available.
> 
> The same applies when multiple NUMA nodes are involved. In that
> case the first cpu in the local node is chosen which does provide
> a bit of spreading but with multiple HK cpus per node the same
> issues arise.
> 
> Spread the HK work out by having housekeeping_any_cpu() and
> sched_numa_find_closest() use cpumask_any_and_distribute()
> instead of cpumask_any_and().
> 

Got the overall intent of the patch for better load distribution on
housekeeping tasks. However, one potential drawback could be that by
spreading HK work across multiple CPUs might reduce the time that
some cores can spend in deeper idle states which can be beneficial for
power-sensitive systems.

Thoughts?

Thanks,
Madadi Vineeth Reddy

> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/sched/isolation.c | 2 +-
>  kernel/sched/topology.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 81bc8b329ef1..93b038d48900 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -40,7 +40,7 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
> -			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and_distribute(housekeeping.cpumasks[type], cpu_online_mask);
>  			if (likely(cpu < nr_cpu_ids))
>  				return cpu;
>  			/*
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index c49aea8c1025..94133f843485 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2101,7 +2101,7 @@ int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
>  	for (i = 0; i < sched_domains_numa_levels; i++) {
>  		if (!masks[i][j])
>  			break;
> -		cpu = cpumask_any_and(cpus, masks[i][j]);
> +		cpu = cpumask_any_and_distribute(cpus, masks[i][j]);
>  		if (cpu < nr_cpu_ids) {
>  			found = cpu;
>  			break;


