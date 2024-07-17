Return-Path: <linux-kernel+bounces-255096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8D7933BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B06C1F21AE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B5B17F50B;
	Wed, 17 Jul 2024 11:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z7525m4h"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13A17F4F4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214487; cv=none; b=dril9cva4wn/oprd6Q2Fy6WhlMvJTX9aZgIXxzubZ3nUX0sRmjD0/d1gW4bpQuLxph6bVsaGvBeYlmthxn+DFuHubacX7w9rPi60tBQX67Ea2qq3GstidFIED1Rj64Lhs7IG0XkI9fHYeYevaGFIasqt56Bj59yjFFCEWL/Sejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214487; c=relaxed/simple;
	bh=0xtRiDcLRpbp3c4QTQ15UTUc5YjtrK0gkuZ2i0E6yPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/1NJu+Q53xQ9r/rXraUk+Qvm1NEq8OEqGkOGgcwyymMUDST7NUngHVgYc212NK/0mSA06tlsbbJc3KXq+RBMo4g4gywgZGG5wZMSUJThoGZMSxi26TtvNdoQlKVBTwptItWTfJ0B101MiID/uYE9ph0E925GDzx6HP3rzuV5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z7525m4h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HAxZn3015377;
	Wed, 17 Jul 2024 11:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ufLhQsXaGXmg1LtYzZJrj5G5Hh8
	YczERYy+8wEipvCw=; b=Z7525m4hckA+DXWMtfCy/T6Ep4nXXONApf525sRBEyI
	msQdDIrAv5f3bIawPGbEi39XB4cUh8sOHTDDyKmhNSXzwCSFK02DhEEo9j3vTadm
	Pa7OFQOVsYaIdRc44+fVKrVoz0y3416UuAWqpbFFjmczipxxD20rQ8TrN2oqihZS
	4JjAZjJcY8mtbXxL8zLh8uzn2CqoIRQHEpHhywwgq1PAzFQK9kLWy1yOBQITc92z
	2CCCIvSfttXZ2MYbiMxuX2szDCDMPH1QRNpAnq0Pj20qSDFAx7vVvGxQ1KbgBGOa
	s0Fx2iEAW8SdliJmQwDguzgWHVlLY6//bZT7scqC0cQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ecp8g0n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:07:36 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46HB7ZD2027729;
	Wed, 17 Jul 2024 11:07:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ecp8g0my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:07:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46H9paUv009549;
	Wed, 17 Jul 2024 11:07:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmku7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 11:07:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46HB7Vdl52035866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 11:07:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECDC22004D;
	Wed, 17 Jul 2024 11:07:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 057CA20043;
	Wed, 17 Jul 2024 11:07:29 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.22.40])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 17 Jul 2024 11:07:28 +0000 (GMT)
Date: Wed, 17 Jul 2024 16:37:26 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, chengming.zhou@linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
Message-ID: <Zpel7oyBNTpkLiPS@linux.ibm.com>
References: <20240716150634.21247-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716150634.21247-1-zhouchuyi@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kj8nf_K2NfzRdToMIeCuaVmgC-D3Y6R9
X-Proofpoint-ORIG-GUID: oVUcsdHVOuAUPqYKNxCd8j8gWqyWQvWE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170084

On Tue, Jul 16, 2024 at 11:06:34PM +0800, Chuyi Zhou wrote:
> cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
> eevdf. Remove them from struct cfs_rq.
> 

nr_spread_over tracks the number of instances where the difference
between a scheduling entity's virtual runtime and the minimum virtual
runtime in the runqueue exceeds three times the scheduler latency,
indicating significant disparity in task scheduling.  
Commit that removed its usage: 5e963f2bd: sched/fair: Commit to EEVDF


cfs_rq->exec_clock was used to account for time spent executing tasks.
Commit that removed its usage: 5d69eca542ee1 sched: Unify runtime
accounting across classes

> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>

Acked-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  kernel/sched/debug.c | 4 ----
>  kernel/sched/sched.h | 6 ------
>  2 files changed, 10 deletions(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index c1eb9a1afd13..90c4a9998377 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -641,8 +641,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>  	SEQ_printf(m, "\n");
>  	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
>  #endif
> -	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
> -			SPLIT_NS(cfs_rq->exec_clock));
>  
>  	raw_spin_rq_lock_irqsave(rq, flags);
>  	root = __pick_root_entity(cfs_rq);
> @@ -669,8 +667,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
>  			SPLIT_NS(right_vruntime));
>  	spread = right_vruntime - left_vruntime;
>  	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
> -	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
> -			cfs_rq->nr_spread_over);
>  	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
>  	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
>  	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4c36cc680361..8a071022bdec 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -599,7 +599,6 @@ struct cfs_rq {
>  	s64			avg_vruntime;
>  	u64			avg_load;
>  
> -	u64			exec_clock;
>  	u64			min_vruntime;
>  #ifdef CONFIG_SCHED_CORE
>  	unsigned int		forceidle_seq;
> @@ -619,10 +618,6 @@ struct cfs_rq {
>  	struct sched_entity	*curr;
>  	struct sched_entity	*next;
>  
> -#ifdef	CONFIG_SCHED_DEBUG
> -	unsigned int		nr_spread_over;
> -#endif
> -
>  #ifdef CONFIG_SMP
>  	/*
>  	 * CFS load tracking
> @@ -1158,7 +1153,6 @@ struct rq {
>  	/* latency stats */
>  	struct sched_info	rq_sched_info;
>  	unsigned long long	rq_cpu_time;
> -	/* could above be rq->cfs_rq.exec_clock + rq->rt_rq.rt_runtime ? */
>  
>  	/* sys_sched_yield() stats */
>  	unsigned int		yld_count;
> -- 
> 2.20.1
> 

