Return-Path: <linux-kernel+bounces-416189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5499A9D41D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BEEB25D47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FCD19E97F;
	Wed, 20 Nov 2024 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="heq4V9Zh"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AF31E515
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732126239; cv=none; b=WtwDm+29+2V4GwhuQ0w6eQTolFC89RRqPo8P5R2Y7jU3RBB4kytW435OpzkvUtmZNrlm7Go0940YzvAMlzkqiRycWnuSkvlYjWNzYeD/UE8IhWIFVFsbzlA71SS/BoZ6TO6fOdDBD5+4kHc/sPX+tlrtzgmeoFDRn7U3N235bQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732126239; c=relaxed/simple;
	bh=U6loonQFa7Hi91Brgh5Jb3vpSqBaAKt4zLCvlHhTbcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMRYn0wgbn/Zau6uAw2t4YrqLRKB4syQB9ZorCeN4uhTpnaTyifEa0QTOrrtYUXC9JAON8v4M2dEWk4fSFfCVqx6dbi0W2XnemY/pw0r4WV82S2zar2VMN9+pWHdHRr4jPMzyiQfSzi3E+9PhNaLS/xk2VZf9lK4ZSlLiTkmRaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=heq4V9Zh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AK82NZ7008481;
	Wed, 20 Nov 2024 18:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SUfQZC
	WYXODzuuIo14/FBJYtySvBgY9P7Ynrc0sg77o=; b=heq4V9ZhfTMHRd2JwPXOLc
	0qPp0jWYmfTEB1eS7rV80YhblvNAKrhgVAoWQVowmn5BA3Kvvz6uppy1SFNL2FM1
	kCILnrKnmV5wRdhiST5KcuN1e6FB3NIm4ksLE9fBt+NG+Nk7BUHsFf+XFfMPqj2l
	P7dOksiK/t2yV/9brf75/ShSrvWz9lMttUUjeplN0kadcatU/lFFdFCDcfhTaU6L
	suHjT8QvuLd9UTonMWqll6u/24/kFioOv0q8EgksH0/Vm74BtoFLMjY0o2MUCiPs
	64zXKXmWTyKb9HNxWgMMN3d/rre91yjaWtBVAvr3ndWdoTDAmhHe++Dvj/GsWEEg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk216cd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 18:10:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AKHxZdG019706;
	Wed, 20 Nov 2024 18:10:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk216cd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 18:10:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AKH8LAZ030970;
	Wed, 20 Nov 2024 18:10:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y63yx7hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Nov 2024 18:10:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AKIA6AD33817104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Nov 2024 18:10:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1081820043;
	Wed, 20 Nov 2024 18:10:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2205F20040;
	Wed, 20 Nov 2024 18:10:04 +0000 (GMT)
Received: from [9.39.17.146] (unknown [9.39.17.146])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Nov 2024 18:10:03 +0000 (GMT)
Message-ID: <5733e508-f503-46cd-8874-d0c82355ae11@linux.ibm.com>
Date: Wed, 20 Nov 2024 23:40:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powerpc: Large user copy aware of full:rt:lazy
 preemption
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        ankur.a.arora@oracle.com, linux-kernel@vger.kernel.org
References: <20241116192306.88217-1-sshegde@linux.ibm.com>
 <20241116192306.88217-3-sshegde@linux.ibm.com>
 <20241120080041.aNFNqWCz@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241120080041.aNFNqWCz@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IK3UphI6nllhhhVGFQWdEnBf_ObDnm6Y
X-Proofpoint-GUID: y09NOR_0zNxj7KvIFErNtz_TijExyeub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411200124



On 11/20/24 13:30, Sebastian Andrzej Siewior wrote:
> On 2024-11-17 00:53:06 [+0530], Shrikanth Hegde wrote:
>> Large user copy_to/from (more than 16 bytes) uses vmx instructions to
>> speed things up. Once the copy is done, it makes sense to try schedule
>> as soon as possible for preemptible kernels. So do this for
>> preempt=full/lazy and rt kernel.
>>
>> Not checking for lazy bit here, since it could lead to unnecessary
>> context switches.
>>
>> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/lib/vmx-helper.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
>> index d491da8d1838..58ed6bd613a6 100644
>> --- a/arch/powerpc/lib/vmx-helper.c
>> +++ b/arch/powerpc/lib/vmx-helper.c
>> @@ -45,7 +45,7 @@ int exit_vmx_usercopy(void)
>>   	 * set and we are preemptible. The hack here is to schedule a
>>   	 * decrementer to fire here and reschedule for us if necessary.
>>   	 */
>> -	if (IS_ENABLED(CONFIG_PREEMPT) && need_resched())
>> +	if (IS_ENABLED(CONFIG_PREEMPTION) && need_resched())
>>   		set_dec(1);
> 
> Now looking at this again there is a comment why preempt_enable() is
> bad. An interrupt between preempt_enable_no_resched() and set_dec() is
> fine because irq-exit would preempt properly?

I think so. AFAIU the comment says issue lies with amr register not being saved across
context switch. interrupt_exit_kernel_prepare saves it and restore using kuap_kernel_restore.

  Regular preemption works
> again once copy_to_user() is done? So if you copy 1GiB, you are blocked
> for that 1GiB?


yes, regular preemption would work on exit of copy_to_user. Since the preempt_disable was done
before copy starts, i think yes, it would be blocked until it is complete.

> 
>>   	return 0;
>>   }
> 
> Sebastian

nick, mpe; please correct me if i am wrong.


