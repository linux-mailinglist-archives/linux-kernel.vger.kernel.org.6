Return-Path: <linux-kernel+bounces-168642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8F68BBB27
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60BA21C210A8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A0F21342;
	Sat,  4 May 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lksMPrXZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187E200C3
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825109; cv=none; b=m633VlcwM3re+OiQ6/Pb/FJItsHOZHa+gT5Hv+92XJ2bkmo+QMoBnx9pwFZAWfplaFcHrQ87H5iVxD7TwVEVeaqHdN9IpwIokcGXBbJtp7HdT7qmkjXlgTS+W06i9M+/2xpqeSGQFERhSqWd4R/FTWbZiKcawkkbwYs6xmo19SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825109; c=relaxed/simple;
	bh=7GXPWwTHqmRLsgDCIdVZZfwub4LNZ8k88BfM8ndw6IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2bksYCNjjzrE9gQZb/5ajkszCddeN+hoDTA65g7edpxVbui4W20O+2cUTpeXqDhvCg4DQoJuAC2Jh/Agc+hiwASfFSoW7ifDVC4Rh1BkX0vNwabjqqi+ZDVA2xzpUvS4MfwmYzVrOaokuUCUNjEzuG0YzxQrOtPCRieaBNYxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lksMPrXZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 444C49NP005559;
	Sat, 4 May 2024 12:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : reply-to : from :
 in-reply-to : content-type : content-transfer-encoding; s=pp1;
 bh=zN3t8sUelDUkstauCCZiRQa4SMjai6Pqy6Y7OcpCsRY=;
 b=lksMPrXZ/bN2ensk7PtgB9O9Wi0vbdjg6c4wVAdzTyu7RvsHCBV4j58MAZFe83bZlaLp
 kdj79E5c/raW5jWa8c+9iyy0nNVuryBfZ4P3yjCdEbwqAG/lAWWDbvTCLJ8KycB0neHC
 5rSMG4VAepd0ThcNA3ynnyhUa4+eoOTRJaP9cEeU0MfZZh4VnYYAGa36hwFpCgbjJoRU
 6VFoi0PspRzFRqwki8LqPxWOJLnqJc8HY7JJhMs2aMn/8SMu3PmkiEauCyZJluodc2aa
 KE8g6Nshe3eXrb10jdtCwuVqyT5homXlwQaYShfAFdBkoMH0TZxFwAT3FabYkAT4lWW+ lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xwmpp80tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 12:18:12 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 444CIBXa025690;
	Sat, 4 May 2024 12:18:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xwmpp80tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 12:18:11 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 444BKrtu006198;
	Sat, 4 May 2024 12:18:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpq3ary-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 May 2024 12:18:10 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 444CI7xW22807106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 May 2024 12:18:09 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81D0C58043;
	Sat,  4 May 2024 12:18:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 668525805D;
	Sat,  4 May 2024 12:18:00 +0000 (GMT)
Received: from [9.43.80.202] (unknown [9.43.80.202])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 May 2024 12:17:59 +0000 (GMT)
Message-ID: <ba8c7408-2b8a-45e6-b5d0-87a815f37dde@linux.ibm.com>
Date: Sat, 4 May 2024 17:47:57 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Add stats update for cfs_rq->exec_clock in
 update_curr() again
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira
 <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20240503104605.1871571-1-dietmar.eggemann@arm.com>
Content-Language: en-US
Reply-To: 20240503104605.1871571-1-dietmar.eggemann@arm.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20240503104605.1871571-1-dietmar.eggemann@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NebUhbNkmKf7CA9hLj2IElqMJsu3dm2i
X-Proofpoint-ORIG-GUID: Bd3nZjIZDUoytlJV2QV2KMzcj1vkXoa7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-04_08,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405040088

Hi Dietmar Eggemann,

On 03/05/24 16:16, Dietmar Eggemann wrote:
> Commit 5d69eca542ee ("sched: Unify runtime accounting across classes")
> removed it and since then:
> 
>   echo 1 > /proc/sys/kernel/sched_schedstats
>   cat /sys/kernel/debug/sched/debug | grep exec_clock
> 
> returns:
> 
>   .exec_clock                    : 0.000000
> 
> for all cfs_rq's.
> 
> Put the schedstat_add() back to be able to watch the cfs_rq runtime
> statistic.
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9eb63573110c..37bb3cee6fec 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1158,6 +1158,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
>  	if (unlikely(delta_exec <= 0))
>  		return;
> +	schedstat_add(cfs_rq->exec_clock, delta_exec);
>  
>  	curr->vruntime += calc_delta_fair(delta_exec, curr);
>  	update_deadline(cfs_rq, curr);

Able to see the stats now with the patch.

Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Thanks and Regards
Madadi Vineeth Reddy



