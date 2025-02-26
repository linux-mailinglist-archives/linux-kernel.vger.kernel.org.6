Return-Path: <linux-kernel+bounces-534752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6063A46AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A918616E317
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5B22E3F1;
	Wed, 26 Feb 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k66JEu/y"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFB21C9E9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597357; cv=none; b=ouXzewmQbJWfwh7IdxFaazC89Tg/zKDMybAb7drVA/8ck69bFTxGlv+Md789CHr/XeQXXBjiM7QpNu+aht+qGIIYts6bTirXX3usI7fjDm2Pe2Bg6JGEkxAM4Pzbef+mudP5+TD3bv7MbwO8fMJPSqZ6pYQgOfYFE/UpSJg0EJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597357; c=relaxed/simple;
	bh=As6OxTeJhPouBmBNGhdoOv4nWwMagu7s3NTVp5XhxiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EU4d8aWLiMwdOGeRxjToXEm7CMIUA4mfHtFruWAk6nXOaTNCUUh3S4BxIVRCq+BthMSbNKR64paHYNCO6ACZPHVGhAMg9Ea7K1u2zCI77KuQSSnulWnwC0k4ELgjO4EdIas2dhYp7MppGYYxnd9Vm++mLbEDU6KmBoKdOwn54X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k66JEu/y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFiISf030077;
	Wed, 26 Feb 2025 19:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Rh+7FrBmpNz1yXENMtO0geByWP1Ppi
	aBeFyAjPYlDs0=; b=k66JEu/yaSWmWJBrC2RKlf24uLsQnUqO77nn+s08cTiA7q
	jZV1boRB+eX0MvSTEdcq6qOCKBE3ICQ0LF/gmxJC/1VxZ2fHTuEeAU7J0SZHjSOw
	991RKv9bx/Q2IoeNZ3wDEGIsgYULY1egBBtIty9emBDqW0eBeVYiDvCDLIZZulFE
	IU6bx+/vduhelHtrWD70njR/VUqzYf1v8BEuA5ipKPCGaHpnFrKZNAmJPUYVezMd
	jzzUbp//G4NHMUmRAiGdZSaij3NtmysTUuD2Eywz2KOKwWXj1TOBfoWnc9JlcqpQ
	zYOUuM06kCTBYwyjLq9i9Q8sb9FpMAH6buLfG9zQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451wp6bpq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 19:15:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGpT7R002595;
	Wed, 26 Feb 2025 19:15:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4jv6c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 19:15:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QJFYYb56689122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 19:15:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1550A20043;
	Wed, 26 Feb 2025 19:15:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A314F20040;
	Wed, 26 Feb 2025 19:15:32 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com (unknown [9.39.31.225])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Feb 2025 19:15:32 +0000 (GMT)
Date: Thu, 27 Feb 2025 00:45:28 +0530
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com,
        kernel-dev@igalia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
Message-ID: <7aoh7i4gfz6kxl2tzouevyu72toucqsdebkw4iwibrfgg7tw3u@h56bnyeddyz7>
References: <20250226143327.231685-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226143327.231685-1-changwoo@igalia.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 54q4114nhjEblTC4AkKDDYIUW4Dg6xYc
X-Proofpoint-ORIG-GUID: 54q4114nhjEblTC4AkKDDYIUW4Dg6xYc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260149

On Wed, Feb 26, 2025 at 11:33:27PM +0900, Changwoo Min wrote:
> Add tracing support, which may be useful for debugging sched_ext schedulers
> that trigger a certain event.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  include/trace/events/sched_ext.h | 21 +++++++++++++++++++++
>  kernel/sched/ext.c               |  4 ++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
> index fe19da7315a9..88527b9316de 100644
> --- a/include/trace/events/sched_ext.h
> +++ b/include/trace/events/sched_ext.h
> @@ -26,6 +26,27 @@ TRACE_EVENT(sched_ext_dump,
>  	)
>  );
>  
> +TRACE_EVENT(sched_ext_add_event,
> +	    TP_PROTO(const char *name, int offset, __u64 added),
> +	    TP_ARGS(name, offset, added),
> +
> +	TP_STRUCT__entry(
> +		__string(name, name)
> +		__field(	int,		offset		)
> +		__field(	__u64,		added		)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name);
> +		__entry->offset		= offset;
> +		__entry->added		= added;
> +	),
> +
> +	TP_printk("name %s offset %d added %llu",
> +		  __get_str(name), __entry->offset, __entry->added
> +	)
> +);
> +
>  #endif /* _TRACE_SCHED_EXT_H */
>  
>  /* This part must be outside protection */
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 986b655911df..825e79863057 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1554,6 +1554,8 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>   */
>  #define scx_add_event(name, cnt) do {						\
>  	this_cpu_add(event_stats_cpu.name, cnt);				\
> +	trace_sched_ext_add_event(#name,					\
> +				  offsetof(struct scx_event_stats, name), cnt);	\
>  } while(0)
>  
>  /**
> @@ -1565,6 +1567,8 @@ static DEFINE_PER_CPU(struct scx_event_stats, event_stats_cpu);
>   */
>  #define __scx_add_event(name, cnt) do {						\
>  	__this_cpu_add(event_stats_cpu.name, cnt);				\
> +	trace_sched_ext_add_event(#name,					\
> +				  offsetof(struct scx_event_stats, name), cnt);	\
>  } while(0)
>  
>  /**
LGTM
Reviewed-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
> -- 
> 2.48.1
> 

