Return-Path: <linux-kernel+bounces-334613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EB497D99B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5AF9B223D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAED17B402;
	Fri, 20 Sep 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N9WmEKGk"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9518641
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726857020; cv=none; b=ftKYHz7X4fKM38bAFYgh85buX8JW0eT2oXV0Rk8+oPNp1mkbNfmoiSJSIStxLONRFVL9+wuFxGzUP3y1TvCGCmLrNeuMjwQhT8Mz2jWjSrvOknolhD3YbtkMnleMLdPpHm0xNRCHDZWHI5G7cWbOHnpUVrN4ZECxRtSmoKiwSC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726857020; c=relaxed/simple;
	bh=m1JeyLMagv5N6ndAt6bgO4a9MpH4oFwkkzPqw6TwYjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5+bg1PmULBZDGLijKcXh17x/ltCLk6cP8y7M35v3SY06GV+eLI8Zw3bt46DctNmFc6Fg/V2rZY4iOnKow8Pl1MSkfcb9kP0jyCScE/MEBVlbV/DQ/9SxJx3k14G0ZBWGo1vAfI+ZLyxfPxL4S6yLfaLn6b+uze16ZlqK0IQ0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N9WmEKGk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48KAMbVn031526;
	Fri, 20 Sep 2024 18:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=bk6MU1qpTKpGbSZsXDw0Oj/6PQ6
	XwNWrRhFJRFrI14U=; b=N9WmEKGkdna//WyZtoqM7KqIlZbe2khj5NgZ6zd0+Wu
	eVnjmtjYuRdO+zrtc7KNFxJzHWGErKe+vynC1/mc1OMyJ1VVs4lNRmQhxnuThJhm
	BsYSNXB593/vuwWvUrvT1nTyJ/1VTLwkOH8xnioMid+AV5HhOU8tcix7D0AFAJFT
	Lw3G+8smE/AK8S2RbYt/8Jw7tzHbcB2VvskPvDJIBptAw9f5wOQ9PdAjAzVEBjPN
	5I9iT6PcpxX5P93BzbTWvqDcGcAZONS1PI1SpDiCbrf9mmlL/BtM1odp57TDyz3Q
	TuADI8UuKDSH/61tFQ21kiP32U/m8N3mxKS7O/iQXjg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ve3avp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 18:30:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48KI1NLJ024627;
	Fri, 20 Sep 2024 18:30:07 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1ngpsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 18:30:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48KIU2p351118370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 18:30:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 833CF20043;
	Fri, 20 Sep 2024 18:30:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4380720040;
	Fri, 20 Sep 2024 18:30:00 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown [9.124.219.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Sep 2024 18:30:00 +0000 (GMT)
Date: Fri, 20 Sep 2024 23:59:55 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Kajol Jain <kjain@linux.ibm.com>
Cc: mpe@ellerman.id.au, atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com,
        disgoel@linux.ibm.com, hbathini@linux.ibm.com, adubey@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: Fix typo in the kvm functions
Message-ID: <20240920235857.f538f4a4-a3-amachhiw@linux.ibm.com>
Mail-Followup-To: Kajol Jain <kjain@linux.ibm.com>, mpe@ellerman.id.au, 
	atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com, disgoel@linux.ibm.com, 
	hbathini@linux.ibm.com, adubey@linux.ibm.com, gautam@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240920113801.424651-1-kjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920113801.424651-1-kjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AEbDGwVz6Jz4fnhDfR6p5H_2C8FbSRJv
X-Proofpoint-GUID: AEbDGwVz6Jz4fnhDfR6p5H_2C8FbSRJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_08,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 impostorscore=0
 spamscore=100 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 mlxscore=100 malwarescore=0 mlxlogscore=-999 priorityscore=1501
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200132

On 2024/09/20 05:08 PM, Kajol Jain wrote:
> Fix typo in the following kvm function names from:
> 
> kmvhv_counters_tracepoint_regfunc -> kvmhv_counters_tracepoint_regfunc
> kmvhv_counters_tracepoint_unregfunc -> kvmhv_counters_tracepoint_unregfunc
> 

Nice catch!

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> Fixes: e1f288d2f9c6 ("KVM: PPC: Book3S HV nestedv2: Add support for reading VPA counters for pseries guests")
> Reported-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s_64.h | 4 ++--
>  arch/powerpc/kvm/book3s_hv.c             | 4 ++--
>  arch/powerpc/kvm/trace_hv.h              | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
> index 2ef9a5f4e5d1..11065313d4c1 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_64.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_64.h
> @@ -684,8 +684,8 @@ int kvmhv_nestedv2_set_ptbl_entry(unsigned long lpid, u64 dw0, u64 dw1);
>  int kvmhv_nestedv2_parse_output(struct kvm_vcpu *vcpu);
>  int kvmhv_nestedv2_set_vpa(struct kvm_vcpu *vcpu, unsigned long vpa);
>  
> -int kmvhv_counters_tracepoint_regfunc(void);
> -void kmvhv_counters_tracepoint_unregfunc(void);
> +int kvmhv_counters_tracepoint_regfunc(void);
> +void kvmhv_counters_tracepoint_unregfunc(void);
>  int kvmhv_get_l2_counters_status(void);
>  void kvmhv_set_l2_counters_status(int cpu, bool status);
>  
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index ba0492f9de65..c36d036d7155 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4154,7 +4154,7 @@ void kvmhv_set_l2_counters_status(int cpu, bool status)
>  		lppaca_of(cpu).l2_counters_enable = 0;
>  }
>  
> -int kmvhv_counters_tracepoint_regfunc(void)
> +int kvmhv_counters_tracepoint_regfunc(void)
>  {
>  	int cpu;
>  
> @@ -4164,7 +4164,7 @@ int kmvhv_counters_tracepoint_regfunc(void)
>  	return 0;
>  }
>  
> -void kmvhv_counters_tracepoint_unregfunc(void)
> +void kvmhv_counters_tracepoint_unregfunc(void)
>  {
>  	int cpu;
>  
> diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
> index 77ebc724e6cd..35fccaa575cc 100644
> --- a/arch/powerpc/kvm/trace_hv.h
> +++ b/arch/powerpc/kvm/trace_hv.h
> @@ -538,7 +538,7 @@ TRACE_EVENT_FN_COND(kvmppc_vcpu_stats,
>  	TP_printk("VCPU %d: l1_to_l2_cs_time=%llu ns l2_to_l1_cs_time=%llu ns l2_runtime=%llu ns",
>  		__entry->vcpu_id,  __entry->l1_to_l2_cs,
>  		__entry->l2_to_l1_cs, __entry->l2_runtime),
> -	kmvhv_counters_tracepoint_regfunc, kmvhv_counters_tracepoint_unregfunc
> +	kvmhv_counters_tracepoint_regfunc, kvmhv_counters_tracepoint_unregfunc
>  );
>  #endif
>  #endif /* _TRACE_KVM_HV_H */
> -- 
> 2.43.5
> 
> 

