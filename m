Return-Path: <linux-kernel+bounces-232612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1B991ABBA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB5E1F21BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1D41991AD;
	Thu, 27 Jun 2024 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sz+AACdn"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D02193064
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503129; cv=none; b=suaP69dNh+F4C4l2xVrJj4VB7v03mXexmme6yiIjJbHrR3LJO0HrznPb5BUY3yQUZfuANcdKc4QIOBRtZY6wSXoePpOGALapZ8qd3TbeyJVR0tZMcnVriH6IU4tz09h/RQp58JSHs93HKV3P0X9Dblss/xsxj/+BF057msdMjio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503129; c=relaxed/simple;
	bh=VlGIoBgmPBXZYwv9yBvzaBKlNHR3dE4a13zRwR6wR+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+Sixv+fHJJUyzBI2ZnUlno6OSld+7US8I0ctQoobUgGvlOvOl0DKGVxWUyEiRWpxfQHX/yIyMGCrCZqXZyqr+01ddF4SEh7mHinkw1qmmTejQTzLRl3GiR/WT8t62nPClOm2xbGly2qohDRM6bnfiS5yl5jbjBwMBlLNm+hjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sz+AACdn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFiLOW028953;
	Thu, 27 Jun 2024 15:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=D
	4ySQYbjzjh3T+Ge7SPBU/YV4zMcePzrhtgXDg0O4To=; b=Sz+AACdnH/YShhwO5
	TTz5/4zPCfb/W0ReCq58JhJCRx4apaZupRMgag9mRdsa3PHJUFGuKYf7Afhb6yMq
	+cWEsNdetIV8JKR/85VtriAKQAmzn0fR3klqS0jFTDc49VLJ9ekRxmzqUX1pfBG4
	9DgPapv/bF4rAPEfcpzo096sQVhjW9LnVTTNTSD/fJj+u6vl5bRFKXvvW529IvXp
	bIf/TEnVdOMIY9emmJI/MShXEQbApo3FKg5EWXKCUUxOcH4TDIjJLwoACbPGcqyz
	SaV5IJy4JimW1MVSzOOIxS0pHgbFMasnWtqc9PncCRRsMishaUGTMGpulKg92gFv
	YfKTA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4013qg97fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:44:57 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45RFiucZ029691;
	Thu, 27 Jun 2024 15:44:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4013qg97fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:44:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45RFfFC0000674;
	Thu, 27 Jun 2024 15:44:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaenbctj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:44:55 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45RFiqea50463264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 15:44:54 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CBE058068;
	Thu, 27 Jun 2024 15:44:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5856258059;
	Thu, 27 Jun 2024 15:44:47 +0000 (GMT)
Received: from [9.124.220.56] (unknown [9.124.220.56])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Jun 2024 15:44:47 +0000 (GMT)
Message-ID: <e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com>
Date: Thu, 27 Jun 2024 21:14:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
To: Michael Ellerman <mpe@ellerman.id.au>,
        Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
 <871q4td59k.fsf@oracle.com>
 <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
 <87msn785f0.fsf@oracle.com> <87sewzkjy5.fsf@mail.lhotse>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <87sewzkjy5.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7frStqPAvfwjZndIYb2JzqG685th5xCU
X-Proofpoint-ORIG-GUID: Yzxv_52Rkah6Gpd5UEJYkm3DtGwLQ6tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270117



On 6/27/24 11:26 AM, Michael Ellerman wrote:
> Ankur Arora <ankur.a.arora@oracle.com> writes:
>> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
>>> ...
>>> This was the patch which I tried to make it per cpu for powerpc: It boots and runs workload.
>>> Implemented a simpler one instead of folding need resched into preempt count. By hacky way avoided
>>> tif_need_resched calls as didnt affect the throughput. Hence kept it simple. Below is the patch
>>> for reference. It didn't help fix the regression unless I implemented it wrongly.
>>>
>>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>>> index 1d58da946739..374642288061 100644
>>> --- a/arch/powerpc/include/asm/paca.h
>>> +++ b/arch/powerpc/include/asm/paca.h
>>> @@ -268,6 +268,7 @@ struct paca_struct {
>>>  	u16 slb_save_cache_ptr;
>>>  #endif
>>>  #endif /* CONFIG_PPC_BOOK3S_64 */
>>> +	int preempt_count;
>>
>> I don't know powerpc at all. But, would this cacheline be hotter
>> than current_thread_info()::preempt_count?
>>
>>>  #ifdef CONFIG_STACKPROTECTOR
>>>  	unsigned long canary;
>>>  #endif
> 
> Assuming stack protector is enabled (it is in defconfig), that cache
> line should quite be hot, because the canary is loaded as part of the
> epilogue of many functions.

Thanks Michael for taking a look at it.  

Yes. CONFIG_STACKPROTECTOR=y 
which cacheline is a question still if we are going to pursue this. 
> Putting preempt_count in the paca also means it's a single load/store to 
> access the value, just paca (in r13) + static offset. With the
> preempt_count in thread_info it's two loads, one to load current from
> the paca and then another to get the preempt_count.
> 
> It could be worthwhile to move preempt_count into the paca, but I'm not
> convinced preempt_count is accessed enough for it to be a major
> performance issue.

With PREEMPT_COUNT enabled, this would mean for every preempt_enable/disable. 
That means for every spin lock/unlock, get/set cpu etc. Those might be 
quite frequent. no? But w.r.t to preempt auto it didn't change the performance per se. 

> 
> cheers

