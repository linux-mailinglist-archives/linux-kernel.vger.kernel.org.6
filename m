Return-Path: <linux-kernel+bounces-345983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB3E98BDCC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AA8B23CCC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EA11C3F32;
	Tue,  1 Oct 2024 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PBBFJMsq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A608A6AA7
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789616; cv=none; b=CcP/srpVRhpxS1zgIS/jy8j0ubAtKwYORWtqwzFfA8QkPwodnLKD1NBhhK3wNk+FhfYSbyzw5Vug0Yf7or7vYM/aNEgUGFs+7SGgl8YX2rMwD9my9+ncuQ8SVf55rOpbYHNT1uXZVC01rSOUVUV8e/mgunmKlblZX8+o/hDP4k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789616; c=relaxed/simple;
	bh=WMeii1iN1FQBcjCoHkjdsERJxvQaRAlDwxlVWzZam3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AU6oVxS3C0Hhai9p8dXItu2tz+32PmxsiMeNhjz5h2PQ5vXagEXJj+YPknXoHDUNep1lNo3zd0VisAjjksLRJhNJpIq/1njGmpoblkurAV3FXVlLpvFQ5Bd6E4vf1whPFX6EgFVBOEcex8xUIHTSTmo8NIcuHlW8IIDzRFl7pi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PBBFJMsq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917K2ZU007046;
	Tue, 1 Oct 2024 13:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=Xg3I4220KjQm/hI8se1hZUVba/R
	M6XlWZR+Skdwg85M=; b=PBBFJMsqN4CjOBNDDg5ObJubwN/nn6HdbWh99ZTkqhi
	m4LuaCezrwtBLhx5j/tIN0V4C09nDU7Q4q+OeKXFk54QmNEVmYgbG1jAHN7q34Kw
	/LU9YEa9LBSEpLBmk6TWIqJEt7Ubw6Jbwa/9UWUTUjPzNkflG8pUQ15hVSugnfVg
	BoJaqnOKced1+gbDHHuGayth1MuyXMekJxmcUe8CTIDQpvS7gx08AKfDinmvXL3B
	YhoFXYXPon4E8YMMcywt2RplTEykMiUeL2XTKTMdmlAnN+XZgF2oHsx3NAgiYcC5
	UQdIIzGGwJ0pcWT7VaQUChz2iLMuqHmDhtDSMl6NzRQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckj9wj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:33:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491DVeYl025888;
	Tue, 1 Oct 2024 13:33:03 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckj9wj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:33:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491CZJHD017845;
	Tue, 1 Oct 2024 13:33:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mvmxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:33:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491DWxqk56623450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 13:32:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B760D20043;
	Tue,  1 Oct 2024 13:32:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEF6420040;
	Tue,  1 Oct 2024 13:32:56 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.29.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Oct 2024 13:32:56 +0000 (GMT)
Date: Tue, 1 Oct 2024 19:02:53 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        patches@amperecomputing.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] sched/fair: remove the DOUBLE_TICK feature
Message-ID: <Zvv6BdRIlg3QUzoy@linux.ibm.com>
References: <20241001065451.10356-1-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001065451.10356-1-shijie@os.amperecomputing.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZR75hVWwP39BG0vatSRE8U7Rk5_QD9lJ
X-Proofpoint-GUID: mQsEbDt1KKY2MceFe_3SoiVAuZBevIPk
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_09,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=722 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010084

On Tue, Oct 01, 2024 at 02:54:51PM +0800, Huang Shijie wrote:
> The patch "5e963f2bd46 sched/fair: Commit to EEVDF"
> removed the code following the DOUBLE_TICK:
> 	-
> 	-       if (!sched_feat(EEVDF) && cfs_rq->nr_running > 1)
> 	-               check_preempt_tick(cfs_rq, curr);
> 
> The DOUBLE_TICK feature becomes dead code now, so remove it.
> 
> Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>

Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>

[1] https://lore.kernel.org/all/20240308052304.1835792-2-vishalc@linux.ibm.com
> ---
>  kernel/sched/fair.c     | 6 ------
>  kernel/sched/features.h | 1 -
>  2 files changed, 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 19afc2253c4d..1812c9cc079d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5680,12 +5680,6 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  		resched_curr(rq_of(cfs_rq));
>  		return;
>  	}
> -	/*
> -	 * don't let the period tick interfere with the hrtick preemption
> -	 */
> -	if (!sched_feat(DOUBLE_TICK) &&
> -			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
> -		return;
>  #endif
>  }
>  
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 0ae351974e49..a3d331dd2d8f 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -56,7 +56,6 @@ SCHED_FEAT(WAKEUP_PREEMPTION, true)
>  
>  SCHED_FEAT(HRTICK, false)
>  SCHED_FEAT(HRTICK_DL, false)
> -SCHED_FEAT(DOUBLE_TICK, false)
>  
>  /*
>   * Decrement CPU capacity based on time not spent running tasks
> -- 
> 2.40.1
> 

