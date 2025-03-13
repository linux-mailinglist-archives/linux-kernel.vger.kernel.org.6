Return-Path: <linux-kernel+bounces-558988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465CBA5EE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7963716EBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067741EA7E1;
	Thu, 13 Mar 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tHn90uYL"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7962AD22
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854668; cv=none; b=MMvH5if08zu/NDRA+6BK3fOAn+uZsx+GeaxV5ONUSi4NMDds1UGQ+TrLgO3qfPe/r7bB2f1azLFAh5M1G9gEfPZx4PvtZi0OcAp2rMhnYvcxibHy5rVbtc3fZivQ8SL7hDzZsX9FmWSxWtB8c35AVs/eZ+oGReYS8u9DRt0PK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854668; c=relaxed/simple;
	bh=mWbOTSol0MyDP27LIYjii2hqCECw/9Xax7O2bzqkVNc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pFpwyLmkpt12VwbnZ7U8S/ByyyHZNi1wPngI8N4INU2TreYJHnXb6leI/wzbOaGy7FpvOpFzvgkZVYU/wNEOpuRBWFqVh26/CFszePy5KGu45xLsd1zE/hUmbHIeiXn+/xVY0EmAB1IwhzdSG88NyePHAsqtGECHIaJStKczwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tHn90uYL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D3juqk006498;
	Thu, 13 Mar 2025 08:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZIxn5+
	UITCK9OeEIVawSSkakfVKn1aznBzydd/3IBGU=; b=tHn90uYLpYTA7q4WGaBsax
	ezmR1Nsm2U+xuuCULaKF0ZqBf+c/vPpW+/856b5WpDKFeHAc75JQFJacNLoi+U1v
	aWhR4bdetORAzqqwJy5wf6M+iJt3fBlyYZMnv8z5ORfs7YMUhOtJg9W1UGtxHb+0
	vvqkYKwk++svP8JLiPKQc8maQ/O75/z7/okiMgcXak4ZV7agzeeqGDtoJ+IxMDty
	X0x6qp+ARuWoyUvSyXjYhZSJiytZdbN4WtQttst/ff3jQ/W6YtKA/Pzq8OOkNVkw
	4N/VnysZlu0E538vXDo3N84l9wPCfU/wPh990ItWq2CxInOjEhN6bqhW8japraSw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr91464-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:30:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52D8S5ed000395;
	Thu, 13 Mar 2025 08:30:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bqr9145v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:30:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D5FgdT027045;
	Thu, 13 Mar 2025 08:30:41 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr0qj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 08:30:41 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52D8UdfC15729228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 08:30:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92ECF5805E;
	Thu, 13 Mar 2025 08:30:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1F1358043;
	Thu, 13 Mar 2025 08:30:35 +0000 (GMT)
Received: from [9.204.206.228] (unknown [9.204.206.228])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 08:30:35 +0000 (GMT)
Message-ID: <3e31e4b7-d4de-4e23-a208-50effb4894a5@linux.ibm.com>
Date: Thu, 13 Mar 2025 14:00:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] sched/fair: Update comments regarding last and
 skip buddy
To: Adam Li <adamli@os.amperecomputing.com>
Cc: peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, cl@linux.com, christian.loehle@arm.com,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20241127055610.7076-1-adamli@os.amperecomputing.com>
 <20241127055610.7076-4-adamli@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <20241127055610.7076-4-adamli@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2pSgbXXuHDKbgk0yVl5s-yGEY_U90MEC
X-Proofpoint-ORIG-GUID: 240dtEDCWCvb_LamnoVI6VcerzrLHjB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503130066

Hi Adam,

On 27/11/24 11:26, Adam Li wrote:
> Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed the "last"
> and "skip" buddy. Update comments in pick_next_entity().
> 
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
> Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  kernel/sched/fair.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d5a3b5589e4e..259c56dcdff6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5602,17 +5602,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  
>  static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
>  
> -/*
> - * Pick the next process, keeping these things in mind, in this order:
> - * 1) keep things fair between processes/task groups
> - * 2) pick the "next" process, since someone really wants that to run
> - * 3) pick the "last" process, for cache locality
> - * 4) do not run the "skip" process, if something else is available
> - */
>  static struct sched_entity *
>  pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
>  {
>  	/*
> +	 * Pick the "next" buddy, since someone really wants that to run.
>  	 * Enabling NEXT_BUDDY will affect latency but not fairness.
>  	 */
>  	if (sched_feat(NEXT_BUDDY) &&

There is one more reference to LAST_BUDDY in check_preempt_wakeup_fair.

Regarding pick_next_entity, the first two points are still valid, so only
points 3 and 4 could be removed?

Something like below

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9dafb374d76d..379dbcbb24e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5578,8 +5578,6 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
  * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
@@ -8780,9 +8778,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
         *
         * Note: this also catches the edge-case of curr being in a throttled
         * group (e.g. via set_curr_task), since update_curr() (in the
-        * enqueue of curr) will have resulted in resched being set.  This
-        * prevents us from potentially nominating it as a false LAST_BUDDY
-        * below.
+        * enqueue of curr) will have resulted in resched being set.
         */
        if (test_tsk_need_resched(rq->curr))
                return;

Thanks,
Madadi Vineeth Reddy

