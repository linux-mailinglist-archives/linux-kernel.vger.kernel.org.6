Return-Path: <linux-kernel+bounces-421025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E09D85BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74EA169119
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B507118A6C1;
	Mon, 25 Nov 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mGjZoDlR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040AB567D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539651; cv=none; b=G5nW7R1Jmf2i8fGIOc1t6cMyfgfhbUiZWj8hz2ET7sU+8BUjUMVGt4h983IOFT/2Q6LW4k1B8mYccR0C4GL5JFkD4EeatZ5+IUfToXKUjy1Rn5zoe5JribYRpcZixWEkF5dWA1Ebgar/szf421cw2UH/XoRS3AeQYjt7Ud9redY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539651; c=relaxed/simple;
	bh=NwjyQTCbnenfqnsmwqF0/ylfPxCJwYG3TAx+vfS8p6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNb9NRWAJ9pgVo584Jy95j49maSftRMK4jVAlZsfSus0L291aB6IXcSjBHM0mpf25gVI0Y/grBjTSy3oojwaW66X/hGAY01cJpnwUYQHu3TOJAYS6GJ9t4PitwT/3RPIUr+EYHdQcqiLCjWqYB/utylI+1U6J/jVNFrr5JJK+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mGjZoDlR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP64ZN7017887;
	Mon, 25 Nov 2024 13:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ngSuQL
	l6Ea45yixM67aBREyeDOL50KpzEG7r08fbC7o=; b=mGjZoDlRbdQJ+W9rm8WYMm
	4P1axasdCqXtLu9ddIMBLWHeW0WY07CywY7L8cAjvK7LuW8i3HQAIZRduJL86Hye
	xaiPVkaUGrEMwY/JLm4bjd+8Fz/PlE/y9Zld5LA6RKTM/yc0gTJHf3u0qcOF3TKS
	Ce1ejl58pRrLvwai8+HrcKgzVjtMdVp/Lh2H3zE7asOvp4YkVeNMGnrWmk/8qkCg
	e/9ZZkHH/U0HXXJNEnl/hMtKhcHkpri31ZUytoOwrm8bgbYPEwgk9VJuzbYci9ML
	cRflDH9D4wgRnVrNu8z+a4+KPVCYOb6ib4Z8MDaWLgOBZWxS9RbOBGmCD9XyY12A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389c8fbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 13:00:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APD0UCH030956;
	Mon, 25 Nov 2024 13:00:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43389c8fbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 13:00:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP60Lir026326;
	Mon, 25 Nov 2024 13:00:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 433v30tcw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 13:00:29 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4APD0Sch18285018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Nov 2024 13:00:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 100F420043;
	Mon, 25 Nov 2024 13:00:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77F4320040;
	Mon, 25 Nov 2024 13:00:25 +0000 (GMT)
Received: from [9.39.21.98] (unknown [9.39.21.98])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 25 Nov 2024 13:00:25 +0000 (GMT)
Message-ID: <558763e0-5668-4bce-be93-70fc11050ab8@linux.ibm.com>
Date: Mon, 25 Nov 2024 18:30:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/core: Update kernel boot parameters for LAZY
 preempt.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
References: <20241122173557.MYOtT95Q@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241122173557.MYOtT95Q@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: knGKgXsN-GbcjIebXFLwv_QRXoIovdyK
X-Proofpoint-ORIG-GUID: tD1_W8vTP1tqv80oE_0fcmw-Duabt2Rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411250111



On 11/22/24 23:05, Sebastian Andrzej Siewior wrote:
> Update the documentation for the `preempt=' parameter which now also
> accepts `lazy'.
> 
> Fixes: 7c70cb94d29cd ("sched: Add Lazy preemption model")
> Reported-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9cd9cd06538bf..23d9bd5ea7e47 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4818,6 +4818,11 @@
>   			       can be preempted anytime.  Tasks will also yield
>   			       contended spinlocks (if the critical section isn't
>   			       explicitly preempt disabled beyond the lock itself).
> +			lazy - Scheduler controlled. Similar to full but instead
> +			       of preempting the task immediately, the task gets
> +			       one HZ tick time to yield itself before the
> +			       preemption will be forced. One preemption is when the
> +			       task returns to user space.
>   
>   	print-fatal-signals=
>   			[KNL] debug: print fatal signals

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

