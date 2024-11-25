Return-Path: <linux-kernel+bounces-420776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DA99D8389
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4E3B2A397
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABA8190662;
	Mon, 25 Nov 2024 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="buSGAAc/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBC118F2E2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528887; cv=none; b=XUT6fHGuKIY7clRb+atm5cpA6cO87C+AYzS3PS2GrxhJ5l67/P9JwOM0HCWlA5HQahAQISLetihtUA2zVB2u9/GSXvAHh5G131glPufyN/Q7MnGL4OggW5coZ4FRk8mJTqbejY11ze+CGnFik/4VMnUDbwnOwd3yUP5FpaRpsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528887; c=relaxed/simple;
	bh=Wgbgtg8sjdRBLRxt78eKSSakz6uLmRRMTP7ZmYCWTac=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lUib6ddFUhIQPxKFBC1gy0HtKYgv9zirQ96W+ymtRK50slTpxuBhEFVj6EOoCrDgfN+lwmN/HYV1PdHlwyVLxOSVeSbIjjGzQ7C7LNjVQmct2Sq1HQs9WQEl9DQt41X3nJNDdX7W+oCiUgsUfXyQBHMV6+TsbGGwPDnV3BD78e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=buSGAAc/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP71XoI006877;
	Mon, 25 Nov 2024 10:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=rX/X1aMqhrQSoNuMkroeOsXsZ/Cn0HrFLDNfnR6GEO8=; b=buSGAAc/TJ85
	rC740TU7Jn6U0uAcx2c6xlI06jDvVtEtwXi70tIVj1gS/n2ZUmNX4Zk3F7p0pdK7
	6abI4I4DCOBLq20YbwlVsVnPs+fkHFR8Brh+Hr3Ge7AuAjpxaLReO18rgyvymBbX
	G+T4elFrxN9UBY8WtSNGkKO40r4vAZ8qO1/iZlzGoSNORCC/dd81fbxQ1xB3BiRp
	CB6M3OhFwgzn41Wb5/IKyXRcNgFT47WxiOg2/UQr4INkbrOgP66fE3T/Tn9r058r
	uydHm/5AnEHATcC5ImhXW+IeovYWfABFfqkv1MTWqSUD7zabYUJcbVgYVkzS0nws
	kiq8bd2HRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jqex6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:01:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AP9X2Xb019275;
	Mon, 25 Nov 2024 10:01:07 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386jqex4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:01:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP94IRH000855;
	Mon, 25 Nov 2024 10:01:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433srxwp6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:01:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4APA15oE55771396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 10:01:06 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8EDF58062;
	Mon, 25 Nov 2024 10:01:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D28E58051;
	Mon, 25 Nov 2024 10:00:59 +0000 (GMT)
Received: from [9.43.78.113] (unknown [9.43.78.113])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 10:00:58 +0000 (GMT)
Message-ID: <244e174a-5449-4730-963e-424a5b3edc05@linux.ibm.com>
Date: Mon, 25 Nov 2024 15:30:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH 2/2] sched/fair: Update comments regarding last and skip
 buddy
Reply-To: 20241125021222.356881-3-adamli@os.amperecomputing.com
To: Adam Li <adamli@os.amperecomputing.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, cl@linux.com,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20241125021222.356881-1-adamli@os.amperecomputing.com>
 <20241125021222.356881-3-adamli@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <20241125021222.356881-3-adamli@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I3TFc39esPwcgfUuut8ghgHci1pMq67u
X-Proofpoint-GUID: PgviCzTQCtxVNw3ySoRWwVsKUHkPTvhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=960 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250085

Hi Adam Li,

On 25/11/24 07:42, Adam Li wrote:
> Commit 5e963f2bd465 ("sched/fair: Commit to EEVDF") removed the "last" and
> "skip" buddy. Update comments in pick_next_entity().
> 
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
> ---
>  kernel/sched/fair.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cd1188b7f3df..d8826a8e0c77 100644
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

Yes, the LAST_BUDDY and SKIP_BUDDY are obsolete now.

Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks,
Madadi Vineeth Reddy

>  	if (sched_feat(NEXT_BUDDY) &&


