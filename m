Return-Path: <linux-kernel+bounces-220022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2163890DB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D6F1C2255F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DBE15E5C9;
	Tue, 18 Jun 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kl6lmJZd"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82A13DDDF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718735262; cv=none; b=T+pHQ2U3XHBfjwg2w+IjpPw/YPmD8uicChD8ohMwRgzmISPPZ8/987Jx5BlmJumoPBc6XsgciZ+soK/NYSQvnt6qf4zxbOKbMlCCMAcgWv+cYZ55zUfQ2aXZfuS4We8PF8KP5JAWjbI8s1f8Woa3kPSNduyvpq3a7BRl2y3+wg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718735262; c=relaxed/simple;
	bh=YceC5bBnKEC6aHUDP2oDZ+Mn0euoK29akkz6UYQlpbI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lg68dWKrrePNjLGmyu4tVvH5E5JGYjryJRFw8Xp/x7hLMOLGOqWLyxoF7EiELAV3vkRBOfluvV4GXR2xvW9nlKQlliGwR2hhpAltF2GDduNdDCadxIOE70W6E0NYsV1ht8Aj8KmFm6RT9ZnABghNYd7023wwPxD2mcP860aTKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kl6lmJZd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IHu7lm010556;
	Tue, 18 Jun 2024 18:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=M
	1iAGlrsA1Xd3EhMSg5oejou65JPVEJdAdC1ah+n+K4=; b=Kl6lmJZdIM+SkKGm6
	wqneQZKEoAAMW4K2wlKg42vafvH/LlLHafCSuG+CNnJkDZ/PW0FNorAnjyaakKYP
	PfU/b0RGckQf5aMx6c0KnblIEwJKQZLuVQT2SO2yLpmlV4tPX6hwfStk3CTilKqw
	6kbqcGs8j8pEB6Bph7hQNf0C5MVJCoz0LVhlMYJN7M96FXNMKuxAPn57vXtWTsmD
	HXTSsOtJf2WyufY6vhx421D3pvMCw5UdaxDd1RSoIXYGrzd+B4f3lSaC8G6A0N4n
	Tp8GtMqxARF3Pmc4Xbg3fttJae3P+tznRBDQRxnQpK6SS4iatIn/DwifUMTx08kj
	C1t/w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuecs86rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:27:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45IIOlIp023090;
	Tue, 18 Jun 2024 18:27:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuecs86rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:27:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45IIR4fY019545;
	Tue, 18 Jun 2024 18:27:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysnp160y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 18:27:09 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45IIR7FI31720144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 18:27:09 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7F3658063;
	Tue, 18 Jun 2024 18:27:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81C2658066;
	Tue, 18 Jun 2024 18:27:03 +0000 (GMT)
Received: from [9.195.33.34] (unknown [9.195.33.34])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Jun 2024 18:27:03 +0000 (GMT)
Message-ID: <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
Date: Tue, 18 Jun 2024 23:57:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLyKlXaKHJ9IgerIA54ZWFwU40i8cKqk
X-Proofpoint-GUID: D9KUM6pl9CPJwvaRFXuKPoB3tBX8Z4wE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=790 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180136



On 6/15/24 8:34 PM, Shrikanth Hegde wrote:
> 
> 
> On 6/10/24 12:53 PM, Ankur Arora wrote:
>>
> _auto.
>>>
>>> 6.10-rc1:
>>> =========
>>> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 09:45:23 AM  all    4.14    0.00   77.57    0.00   16.92    0.00    0.00    0.00    0.00    1.37
>>> 09:45:24 AM  all    4.42    0.00   77.62    0.00   16.76    0.00    0.00    0.00    0.00    1.20
>>> 09:45:25 AM  all    4.43    0.00   77.45    0.00   16.94    0.00    0.00    0.00    0.00    1.18
>>> 09:45:26 AM  all    4.45    0.00   77.87    0.00   16.68    0.00    0.00    0.00    0.00    0.99
>>>
>>> PREEMPT_AUTO:
>>> ===========
>>> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
>>> 10:09:56 AM  all    3.11    0.00   72.59    0.00   21.34    0.00    0.00    0.00    0.00    2.96
>>> 10:09:57 AM  all    3.31    0.00   73.10    0.00   20.99    0.00    0.00    0.00    0.00    2.60
>>> 10:09:58 AM  all    3.40    0.00   72.83    0.00   20.85    0.00    0.00    0.00    0.00    2.92
>>> 10:10:00 AM  all    3.21    0.00   72.87    0.00   21.19    0.00    0.00    0.00    0.00    2.73
>>> 10:10:01 AM  all    3.02    0.00   72.18    0.00   21.08    0.00    0.00    0.00    0.00    3.71
>>>
>>> Used bcc tools hardirq and softirq to see if irq are increasing. softirq implied there are more
>>> timer,sched softirq. Numbers vary between different samples, but trend seems to be similar.
>>
>> Yeah, the %sys is lower and %irq, higher. Can you also see where the
>> increased %irq is? For instance are the resched IPIs numbers greater?
> 
> Hi Ankur,
> 
> 
> Used mpstat -I ALL to capture this info for 20 seconds. 
> 
> HARDIRQ per second:
> ===================
> 6.10:
> ===================
> 18		19		22		23		48	49	50	51	LOC		BCT	LOC2	SPU	PMI	MCE	NMI	WDG	DBL
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 417956.86	1114642.30	1712683.65	2058664.99	0.00	0.00	18.30	0.39	31978.37	0.00	0.35	351.98	0.00	0.00	0.00	6405.54	329189.45
> 
> Preempt_auto:
> ===================
> 18		19		22		23		48	49	50	51	LOC		BCT	LOC2	SPU	PMI	MCE	NMI	WDG	DBL
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 609509.69	1910413.99	1923503.52	2061876.33	0.00	0.00	19.14	0.30	31916.59	0.00	0.45	497.88	0.00	0.00	0.00	6825.49	88247.85
> 
> 18,19,22,23 are called XIVE interrupts. These are IPI interrupts. I am not sure which type of IPI are these. will have to see why its increasing. 
> 
> 
> SOFTIRQ per second:
> ===================
> 6.10:
> =================== 
> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU	
> 0.00	3966.47	0.00	18.25	0.59	0.00		0.34		12811.00	0.00		9693.95
> 
> Preempt_auto:
> ===================
> HI	TIMER	NET_TX	NET_RX	BLOCK	IRQ_POLL	TASKLET		SCHED		HRTIMER		RCU	
> 0.00	4871.67	0.00	18.94	0.40	0.00		0.25		13518.66	0.00		15732.77
> 
> Note: RCU softirq seems to increase significantly. Not sure which one triggers. still trying to figure out why. 
> It maybe irq triggering to softirq or softirq causing more IPI. 
> 
> 
> 
> Also, Noticed a below config difference which gets removed in preempt auto. This happens because PREEMPTION make them as N. Made the changes in kernel/Kconfig.locks to get them 
> enabled. I still see the same regression in hackbench. These configs still may need attention?
> 		
> 					6.10				       | 					preempt auto 
>   CONFIG_INLINE_SPIN_UNLOCK_IRQ=y                                              |  CONFIG_UNINLINE_SPIN_UNLOCK=y                                               
>   CONFIG_INLINE_READ_UNLOCK=y                                                  |  ----------------------------------------------------------------------------
>   CONFIG_INLINE_READ_UNLOCK_IRQ=y                                              |  ----------------------------------------------------------------------------
>   CONFIG_INLINE_WRITE_UNLOCK=y                                                 |  ----------------------------------------------------------------------------
>   CONFIG_INLINE_WRITE_UNLOCK_IRQ=y                                             |  ----------------------------------------------------------------------------
> 
> 

Did an experiment keeping the number of CPU constant, while changing the number of sockets they span across. 
When all CPU belong to same socket, there is no regression w.r.t to PREEMPT_AUTO. Regression starts when the CPUs start 
spanning across sockets. 

Since Preempt auto by default enables preempt count, I think that may cause the regression. I see Powerpc uses generic implementation
which may not scale well. Will try to shift to percpu based method and see. will get back if I can get that done successfully. 

