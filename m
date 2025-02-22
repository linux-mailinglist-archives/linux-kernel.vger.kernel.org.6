Return-Path: <linux-kernel+bounces-527409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF01A40AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0053616FCDE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60171C84B9;
	Sat, 22 Feb 2025 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H/F4ZrU5"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41618C0C
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248243; cv=none; b=XK10/XMwhE+qNCzFfR43wdvAkGBlNVlyfVKgGSP4B0YgOV7RT51y3P1Os4w1QPiRveZrMqzqW0hglpEuALivHumKideuTY2qr4B/WIVylVla7njZw02XVtX5pUaLlsFU0k9kjGYMePpQKEGaYk9bIHkem/q4XrfrKObdNnsrLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248243; c=relaxed/simple;
	bh=GsN+h6ZhfzlxVH7eBgnYxP85GBb1OzUSVbCf3MFLJDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ms43LM3frJ0XiJjL3HF/8ikVb3hCFWxB2I4HqTtQfu7Ygf+N6Wvpa9qp1+BKmbSk5kDSzxEWD3bZyOpgViyWnPfNH8WvEcNbbecKCj+QCudhIncqEvgFGePR2EpqfGk9Gc9SQLcMH+ITaoOsZfk6dNg4r+q+BlqXWccXtwVXGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H/F4ZrU5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MFpLNb003778;
	Sat, 22 Feb 2025 18:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=Xu6HbFa4lr6KGqSU4TjjWPpiItPcBMPksPUjhxMAbcU=; b=H/F4ZrU5cRur
	D061BE0kKzrq8ZbYfuK/206iY3ME7EonJYH5UB2Zavu+BG5l+GZmIghE70WodiCR
	wYZ946g2rRJ1rVz+LekMiL4FcKxWhNlDuexQ7Pn1hDNl1faOxDFvfFWOQvPfkKld
	JhgF/dyfKYaHkaErnODv5mz031AKbPw9VyLLV5Njp+bCTFuskMqrO+msUby+t4n4
	HuqtpQoYrvJvXVcs/A1v8AIsMMiLk+rTkLRMq+4f5hiEYid4BENHHHJdhh8Ye97v
	SM2/+We8s5bzKYWWeLkTIcp4to/KUt6S0SrXHBvA7b5CstYb2Vkxnlu06q/H+krt
	r/cEwObzQQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y846t361-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 18:16:58 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51MIGvjb016811;
	Sat, 22 Feb 2025 18:16:57 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44y846t35s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 18:16:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51MGU3Fx030158;
	Sat, 22 Feb 2025 18:16:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xpf1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 18:16:56 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51MIGtcm29426210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 18:16:55 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8B8258056;
	Sat, 22 Feb 2025 18:16:55 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C47958052;
	Sat, 22 Feb 2025 18:16:50 +0000 (GMT)
Received: from [9.43.65.232] (unknown [9.43.65.232])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Feb 2025 18:16:49 +0000 (GMT)
Message-ID: <e1cfabab-1326-4cd8-a8a4-4b3fc4c1f7ec@linux.ibm.com>
Date: Sat, 22 Feb 2025 23:46:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Fix premature check of WAKEUP_PREEMPTION
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Josh Don <joshdon@google.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20250221111226.64455-1-wuyun.abel@bytedance.com>
 <20250221111226.64455-3-wuyun.abel@bytedance.com>
 <CAKfTPtBzsX6GKZP_NGTONrkp96qx9uOHr0+XG7tC6ELy4tbHBg@mail.gmail.com>
 <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
Content-Language: en-US
Reply-To: 6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <6097164a-aa99-4869-b666-9dc7018c1f96@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mPFQltAE3Z1ylSYKawqTppDW1ftmkAQK
X-Proofpoint-GUID: nqDFx0o-LHIruEXvFI2D_k0tcFQwynAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxscore=0
 mlxlogscore=787 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502220144

On 21/02/25 21:27, Abel Wu wrote:
> On 2/21/25 7:49 PM, Vincent Guittot Wrote:
>> On Fri, 21 Feb 2025 at 12:12, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>
>>> Idle tasks are by definition preempted by non-idle tasks whether feat
>>> WAKEUP_PREEMPTION is enabled or not. This isn't true any longer since
>>
>> I don't think it's true, only "sched_idle never preempts others" is
>> always true but sched_feat(WAKEUP_PREEMPTION) is mainly there for
>> debug purpose so if WAKEUP_PREEMPTION is false then nobody preempts
>> others at wakeup, idle, batch or normal
> 
> Hi Vincent, thanks for your comment!
> 
> The SCHED_IDLE "definition" of being preempted by non-idle tasks comes
> from commit 6bc912b71b6f ("sched: SCHED_OTHER vs SCHED_IDLE isolation")
> which said:
> 
>     - no SCHED_IDLE buddies
>     - never let SCHED_IDLE preempt on wakeup
>     - always preempt SCHED_IDLE on wakeup
>     - limit SLEEPER fairness for SCHED_IDLE
> 
> and that commit let it be preempted before checking WAKEUP_PREEMPTION.
> The rules were introduced in 2009, and to the best of my knowledge there
> seemed no behavior change ever since. Please correct me if I missed
> anything.

As Vincent mentioned, WAKEUP_PREEMPTION is primarily for debugging. Maybe
it would help to document that SCHED_IDLE tasks are not preempted by non-idle
tasks when WAKEUP_PREEMPTION is disabled. Otherwise, the intent of having no
preemptions for debugging would be lost.

Thoughts?

Thanks,
Madadi Vineeth Reddy

> 
> Best Regards,
>     Abel
> 


