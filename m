Return-Path: <linux-kernel+bounces-420810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516EC9D833B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B0C28D2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295818FC70;
	Mon, 25 Nov 2024 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UpYxK9BK"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4CE2AD17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529796; cv=none; b=jUpNVsUeIubvL7WCApHaMGiVz370AVhL8/ADXDJT6mbREFPCt3xcFau46sbo3u/moB9oOS5dU3/m5y/nPEdSKUeHGfN9PjUrhFeBACBuAo4reWecTzWgFUA4NXIF95x9rVFPHkc77NNPWpG4/KKjaqhVwbsdWUxbzmcd/4owovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529796; c=relaxed/simple;
	bh=H4deENrNZ2wxl2jJIOO4HAf4Xk7gBm5y3HiAeogTAtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TacKVo4ZvW3S8WKcrPxsIh5x9HpKcPA3vRji15Q0JtKiRUVq7QTSxokVmVvNtZ+Gi86zOtxoDjePAgFFPH8Z/D8hOghFG5TjB4lslUoC/0Zmva+Nq4AiDreQI/FKpD6tfkxjMt8MkXKsDirVu4/tJTWGLZ5E26gHOzsUQWjQo+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UpYxK9BK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AOLj2wb003188;
	Mon, 25 Nov 2024 10:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=DGytBQR1hBvD7+KjjxebOGaIS0ug/9+sLdrKFHULgd0=; b=UpYxK9BKAR29
	LEHsdY1qDn2kvN8ux075s1vQuB00NSEyc30vbua9qRikEslG13v0ar4zGOHQ6SsA
	D/iOsSaq1HAfMfe57VieNwB2eMczq18Am7Q/tF5Kc75Ia+iCGYD/xtj868XRxk2K
	dDg/SF2rZoyfNQxJ4PfDbvpz9BYbL2I8Mq/IQ11+5DL+bz00CXU0XK1pj+KoPo55
	+T0/8hTsIAl4dJghwVCIsE1s1MvdHKkI4j96yaV8MyvhmJ+Z6paeoe1u7UILqp7j
	xzJ516Mp91XY3Bv8CLhM8vngiFYSG3d1iZ8s7l6rEBbtgqncJEGpO9fw059EFT6D
	mdHaONAuUw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d1ygt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:16:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APAFrYK020571;
	Mon, 25 Nov 2024 10:16:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d1ygt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:16:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP94Ibm000855;
	Mon, 25 Nov 2024 10:16:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433srxwu39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 10:16:16 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4APAGGT825756304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 10:16:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D77B5805C;
	Mon, 25 Nov 2024 10:16:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3A4058051;
	Mon, 25 Nov 2024 10:16:08 +0000 (GMT)
Received: from [9.43.78.113] (unknown [9.43.78.113])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 10:16:08 +0000 (GMT)
Message-ID: <70dfefef-aaa3-43be-9f8a-85adc07942fc@linux.ibm.com>
Date: Mon, 25 Nov 2024 15:46:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sched/fair: Fix panic if NEXT_BUDDY enabled
Content-Language: en-US
To: Adam Li <adamli@os.amperecomputing.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
        patches@amperecomputing.com, cl@linux.com,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20241125021222.356881-1-adamli@os.amperecomputing.com>
 <20241125021222.356881-2-adamli@os.amperecomputing.com>
Reply-To: 20241125021222.356881-2-adamli@os.amperecomputing.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20241125021222.356881-2-adamli@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BUA2UfnhMiMA5ls-7Mxg8636LPz0lXRA
X-Proofpoint-ORIG-GUID: TDVFoqJgC9nnFzPEaUIydKAR76TG_DTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=846
 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250085

On 25/11/24 07:42, Adam Li wrote:
> Enabling NEXT_BUDDY may trigger warning and kernel panic:
> 
> [  124.977300] cfs_rq->next->sched_delayed
> [  124.977310] WARNING: CPU: 51 PID: 2150 at kernel/sched/fair.c:5621 pick_task_fair+0x130/0x150
> <snip>
> [  297.371198] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000051
> [  297.406112] CPU: 116 UID: 0 PID: 10328 Comm: Grizzly-worker( Tainted: G        W   E      6.12.0.adam+ #1
> [  297.597362] Call trace:
> [  297.599795]  pick_task_fair+0x50/0x150 (P)
> [  297.603879]  pick_task_fair+0x50/0x150 (L)
> [  297.607963]  pick_next_task_fair+0x30/0x3c0
> [  297.612134]  __pick_next_task+0x4c/0x220
> [  297.616045]  pick_next_task+0x44/0x980
> [  297.619782]  __schedule+0x3d0/0x628
> [  297.623259]  do_task_dead+0x50/0x60
> [  297.626736]  do_exit+0x28c/0x410
> [  297.629955]  do_group_exit+0x3c/0xa0
> [  297.633518]  get_signal+0x8c4/0x8d0
> [  297.636996]  do_signal+0x9c/0x270
> [  297.640299]  do_notify_resume+0xe0/0x198
> [  297.644212]  el0_svc+0xf4/0x170
> [  297.647342]  el0t_64_sync_handler+0x10c/0x138
> [  297.651687]  el0t_64_sync+0x1ac/0x1b0
> [  297.655339] Code: d503201f 1400002a aa1403e0 97ffda0b (39414401)
> [  297.661439] ---[ end trace 0000000000000000 ]---
> [  297.726593] Kernel panic - not syncing: Oops: Fatal exception
> 
> Do not set next buddy if sched_delayed is set.
> 
> Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
> ---
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fbdca89c677f..cd1188b7f3df 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8748,6 +8748,8 @@ static void set_next_buddy(struct sched_entity *se)
>  			return;
>  		if (se_is_idle(se))
>  			return;
> +		if (se->sched_delayed)
> +			return;

IIUC, this happens due to a race condition between choosing the next_buddy and
dequeuing the task from the runqueue as soon as its lag becomes zero, thereby causing
task_of(se) to result in a null dereference in pick_task_fair?

Correct me if I am wrong.

Thanks,
Madadi Vineeth Reddy

>  		cfs_rq_of(se)->next = se;
>  	}
>  }


