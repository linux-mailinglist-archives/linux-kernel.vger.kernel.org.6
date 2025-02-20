Return-Path: <linux-kernel+bounces-523270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 685A6A3D48D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C787A3B91
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021A1EDA1F;
	Thu, 20 Feb 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DZku1WR4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE691EE7A1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043320; cv=none; b=n+2KIT66sqV+rXS5yCJEVzb+4ngMKX8RwvK9DQaE3ycOhT3qkYPglj4m52Y+XxMAQNfv6TmiBGw7pt1MQnHMiv9i3H562EkohnCsqJXe9e/v92BpPbtgVwVHsbs6jW0179isXdWu9+/YehlVUTVntHIgomtkFmEVx0DgkaDIOPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043320; c=relaxed/simple;
	bh=gdVv0S4Jr0XUx2WgV77fCRKeiGKsRzP9xXdA8AtPhJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsvKPUj2Qedw9hZLYvJpx9pRErFQ7fFS77eKBE9xR9b8TX/QdMq21pjJS0UONhI0H/3Pfr29HzLyMtk6539BrLy+HJHRMk47E/XBAAUkD4BZBy27qcVQKZu5UC2nvnddZHsnVwpRaWT+oy8Q7TKB6rGbExfh/tbfOAAhkc9Mn1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DZku1WR4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K190BZ003228;
	Thu, 20 Feb 2025 09:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=YUiKeOIJfkqR7L1A5Wr5JL2A04+Juu
	dfcgaiPv0ln8M=; b=DZku1WR4eYQx4TgDy0eDUeVTx48zKT8rbdG/yDhAdL6dQq
	xUyt06/8WHfQe53GZ9yJJGDNu5GF6oZ1xCWqfXKyo1++6RjgLwqAYkPvHRUZp/8d
	NE6HvBZSee/8eT+j9+pesdlRsAfFm6Xym4PcbP1yDvuMOK2JjoOtArP1HqiiifBo
	yOzhnvokJpK/1nAMwPTNkd/Gm8W/XeCdRYfsVzMl+gk00CwTj5RYgUgRbzdy+VL2
	ktRfIEq8R6Its1kpCVi02peeNksk69yNtWA0PhHLqEDFaXqy6PrbTv2Wpk+T65NB
	9l9MXIAHQUXRcwLQaccRd825nl5joYHLu2oyAWow==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wtfa1vx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:21:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51K7u9QT009772;
	Thu, 20 Feb 2025 09:21:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y95q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 09:21:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51K9LnwJ20250994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 09:21:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1E5420043;
	Thu, 20 Feb 2025 09:21:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C588A20040;
	Thu, 20 Feb 2025 09:21:47 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.208.191])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Feb 2025 09:21:47 +0000 (GMT)
Date: Thu, 20 Feb 2025 14:51:44 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH v2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <Z7b0KPqtwGX4ffY7@linux.ibm.com>
References: <20250218184618.1331715-1-pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218184618.1331715-1-pauld@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NBiBl4b6etUpEseDvm0PklRgQQwxpnQv
X-Proofpoint-GUID: NBiBl4b6etUpEseDvm0PklRgQQwxpnQv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=704
 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200065

On Tue, Feb 18, 2025 at 06:46:18PM +0000, Phil Auld wrote:
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
> We have numerous cases where a single HK cpu just cannot keep up
> and the remote_tick warning fires. It also can lead to the other
> things (orchastration sw, HA keepalives etc) on the HK cpus getting
> starved which leads to other issues.  In these cases we recommend
> increasing the number of HK cpus.  But... that only helps the
> userspace tasks somewhat. It does not help the actual housekeeping
> part.
> 
> Spread the HK work out by having housekeeping_any_cpu() and
> sched_numa_find_closest() use cpumask_any_and_distribute()
> instead of cpumask_any_and().
> 
LGTM.

Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>

> Signed-off-by: Phil Auld <pauld@redhat.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20250211141437.GA349314@pauld.westford.csb/
> 
> ---
> 
> v2: Fix subject line. Update commit message. No code change. 
> 
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
> -- 
> 2.47.1
> 

