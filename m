Return-Path: <linux-kernel+bounces-384472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0599B2A80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F191F221EE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31091190692;
	Mon, 28 Oct 2024 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="czX3r4zJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768618FDDA
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104804; cv=none; b=KdHzoHFBCRgaUXy0LZMTCAJOQb1OqnTLINNmprGyIDNbF0U+mBBB1q0fAGxYH+RY9pfkrOH+ANyQ/N4+bCypOVF5ylu878voNz2DHPeegAS223wi7Y0EaywWD5q8isbXV2TiS5mKygvcKtQMY1gxz+Ic2IR02neudiDIOsqioBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104804; c=relaxed/simple;
	bh=U+bySkwdww0GjZS+fGCxIPS73iVLaSXe5m1HVzU/T/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQs+FSI4isoqhqeoYsROCzC+uvJHx88X3IrqpXEHgrl2dWp4Z3pgOVWXId5mfVWHNe1KkM9/AOPXsp1de4dxcrKDS7VPSuBnIM5zpFBXKVsUWEVyOpQOZXsNeugFzWpT0JOkSEmVEFzatDK5hiNU8deGhqXwgQKv+7ZOG2cU7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=czX3r4zJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49S4WcVr014786;
	Mon, 28 Oct 2024 08:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=J+hcpOsanEoe3/2BLjDP9qZWp5J4IOAH7YmrOHq2f5s=; b=czX3r4zJN9SO
	3uMBXOzjdNtoj3Oip1t3C2i3Ll1qM1WAXqq5DCj3cO6IoOvH0rscayW9L+77Iq0x
	ZfYZEJ/EecFAezkSrWFCd+jOPehdXTL6BaHD9lOc8ZKzYkE3a48R5X/3LwnMh+In
	1pb+6BDQ//UcIQ5efKMt5KF8nDEgB/yQTZ/SACxzdH4uoCqEYl4wB9nCDBGAiR7t
	Jv7Sv5oDniiA8q/dqyyP6JAIBF7CS45yBGbxYlxqIDyB69X0CiCI/v88pRB2NfEv
	SKbUBHdFLIW5IqgDIiDf2610vjo58DZOEZZNbKuIWLFUFrxh6OZIsnAzMAaHb+Ak
	khcebAxveA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nsh5na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:39:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49S8dorC003774;
	Mon, 28 Oct 2024 08:39:50 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42j3nsh5n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:39:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49S8QlXA018404;
	Mon, 28 Oct 2024 08:39:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42hc8jw9wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Oct 2024 08:39:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49S8dmLs31850756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 08:39:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6657C58058;
	Mon, 28 Oct 2024 08:39:48 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859C958059;
	Mon, 28 Oct 2024 08:39:45 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Oct 2024 08:39:45 +0000 (GMT)
Message-ID: <28280e94-3d2b-4687-aef2-24a9f5893f8e@linux.ibm.com>
Date: Mon, 28 Oct 2024 14:09:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Remove unused parameter from update_deadline()
To: Benjamin Tang <tangsong8264@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <c94702d2-c5db-42b3-9ff8-746be98ec2a7@gmail.com>
Content-Language: en-US
Reply-To: c94702d2-c5db-42b3-9ff8-746be98ec2a7@gmail.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <c94702d2-c5db-42b3-9ff8-746be98ec2a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jzJxFdP0mm2wkOgJpFik9Z0wnjqV14uy
X-Proofpoint-GUID: PTWoPp5hZUoANCkEPbishB7IjzcEtrrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 mlxlogscore=928 clxscore=1011 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280068

On 15/10/24 19:08, Benjamin Tang wrote:
> 
> After commit 85e511df3cec ("sched/eevdf: Allow shorter slices
> to wakeup-preempt"), the 'cfs_rq' argument is no longer used
> in update_deadline(). Remove it.
> 

Yes, cfs_rq argument is not used anymore.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

> Signed-off-by: Benjamin Tang <tangsong8264@gmail.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d9c33f6c1d54..882802d79720 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1004,7 +1004,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
>   * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>   * this is probably good enough.
>   */
> -static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +static bool update_deadline(struct sched_entity *se)
>  {
>     if ((s64)(se->vruntime - se->deadline) < 0)
>         return false;
> @@ -1228,7 +1228,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>         return;
> 
>     curr->vruntime += calc_delta_fair(delta_exec, curr);
> -   resched = update_deadline(cfs_rq, curr);
> +   resched = update_deadline(curr);
>     update_min_vruntime(cfs_rq);
> 
>     if (entity_is_task(curr)) {
> -- 
> 2.11.0


