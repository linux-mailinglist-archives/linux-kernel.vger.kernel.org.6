Return-Path: <linux-kernel+bounces-561074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82565A60D43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5624719C5E97
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BEC1EF09A;
	Fri, 14 Mar 2025 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SnWVPt2a"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC01E633C
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944459; cv=none; b=SmQUh/lAmXjTv4mt30lPCdR8z5QslYtmxRh18zjeFJ1uEVOyPnlNUTh/HqJapDPJ6EZmeDq6uxDAOXbv5P+rKiTWoITnSf70X6T+zAmqWip90GZS4NGaEyhBux3mWOiH+XUbq8SUqJNPABoC9LAELWUGxTid3bI+s0tcxdb7AZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944459; c=relaxed/simple;
	bh=jQDsQqTY0ANjlYPW3RrZ5yBUcoXhcrCjKyE6V9LyOFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA4b/npCRcJDjx2NZJca4OZtr+lPa3Q9gEYhCek9F7JR5TCBp/Qw5CxlC/Gd01LKmb4x5oppw2h8bS6IVYLC+j0mSNhZcFEypAdWnMZnOD5Vz8h8u+aormgiFxfDjlxpxTtvBxAfQGRhNiHS5rPJn9f9t4+WLR5LypVUlvPDFqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SnWVPt2a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPn0w031989;
	Fri, 14 Mar 2025 09:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zaxcah
	9quOMJZnravjPwqR6x4fcDjYrPpq1b73P4XP4=; b=SnWVPt2a+xZd9eS8IiCLy3
	CEsjfIgPxBCVrdag18O2vvXXTU64VgKWBKBzl7PZYdPQboQd91Id8CKThpKYIpRU
	X/fymQS3sPiZM7UeGMpqgJ2LlZD8sO4VvTg91bDfm/LreW2IudzYYKakDXztEb7O
	AEIyxs91mPHPCZ/BRPiC4xeEpscPPhRFCtAiizAubjWY19orkPlQTAEY59IKQ45G
	2D93vCDvg53sznKMwq2vkAQ0ilNXQ871yqGjJJ3e4bfuj1ti38O7HPEZXWh14mao
	2eEXxnaioJ9cbrzgvR70e3Hut0HcTsIOgSMKszmWb2orSaskPVVD+VqIvDdoLeRg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8wes1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:27:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E9RLr6027634;
	Fri, 14 Mar 2025 09:27:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8werx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:27:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8F9aD026047;
	Fri, 14 Mar 2025 09:27:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspp96d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:27:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E9RGKA17301806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 09:27:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E033C20040;
	Fri, 14 Mar 2025 09:27:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 239AE2004E;
	Fri, 14 Mar 2025 09:27:14 +0000 (GMT)
Received: from [9.39.22.126] (unknown [9.39.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 09:27:13 +0000 (GMT)
Message-ID: <333198fd-e028-42cb-8847-bd5ddd2a623b@linux.ibm.com>
Date: Fri, 14 Mar 2025 14:57:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] powerpc: book3s: vas: use lock guard for mutex
To: Peter Zijlstra <peterz@infradead.org>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, mpe@ellerman.id.au, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
 <20250314054544.1998928-5-sshegde@linux.ibm.com>
 <20250314082527.GU5880@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250314082527.GU5880@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bhqGI1arLrSR6zhLyvrGoDlQ2tlLnGbB
X-Proofpoint-ORIG-GUID: Pq9BzbBph-GplGKCkLgSvvH7E4Ys25bm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=896 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140075



On 3/14/25 13:55, Peter Zijlstra wrote:
> On Fri, Mar 14, 2025 at 11:15:42AM +0530, Shrikanth Hegde wrote:
>> use guard(mutex) for scope based resource management of mutex.
>> This would make the code simpler and easier to maintain.
>>
>> More details on lock guards can be found at
>> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
>>
>> There is also an example of using scoped_guard.
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/book3s/vas-api.c | 19 ++++++-------------
>>   1 file changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
>> index 0b6365d85d11..eb1a97271afb 100644
>> --- a/arch/powerpc/platforms/book3s/vas-api.c
>> +++ b/arch/powerpc/platforms/book3s/vas-api.c
>> @@ -425,7 +425,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
>>   		return VM_FAULT_SIGBUS;
>>   	}
>>   
>> -	mutex_lock(&txwin->task_ref.mmap_mutex);
>> +	guard(mutex)(&txwin->task_ref.mmap_mutex);
>>   	/*
>>   	 * The window may be inactive due to lost credit (Ex: core
>>   	 * removal with DLPAR). If the window is active again when
>> @@ -437,11 +437,9 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
>>   		if (paste_addr) {
>>   			fault = vmf_insert_pfn(vma, vma->vm_start,
>>   					(paste_addr >> PAGE_SHIFT));
>> -			mutex_unlock(&txwin->task_ref.mmap_mutex);
>>   			return fault;
>>   		}
>>   	}
>> -	mutex_unlock(&txwin->task_ref.mmap_mutex);
> 
> I had to open up this file to check, but this seems incorrect since you
> now also run do_fail_paste() with the lock held, where previously you
> did not.
> 

Yes. Got it. let me use scoped_guard for it as well. There is get_user 
and other things in the fail parse and having it with mutex will not be 
good.

I went through the rest of the patches too. It is mostly return after 
mutex.

Only in Patch 5/6 there is additional debug statement. Let me put a 
comment there.

> 
>>   	/*
>>   	 * Received this fault due to closing the actual window.


