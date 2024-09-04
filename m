Return-Path: <linux-kernel+bounces-314666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599C96B694
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55FD28971F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE631CCEC7;
	Wed,  4 Sep 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PPG3j0gG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D036189911
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441946; cv=none; b=F2heTV3knTyNG2EZuMgKLWbUStMXhIf/L6Na5/rW3zvaTwiIfhnoEd+MyWZZ8J/3WtWyH+WT15s5wwPjPUeWRejNimzzKJpybD1TKYIq01jEQZzVoE701EWoR+wWBOgXwAtpNT1oLdW59I5jzUzLZnC5XkN6VG5lo/Wt3sLHO1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441946; c=relaxed/simple;
	bh=56r1j35Q2RjfApThJytiNFwJTK5WFd10iBBuC8BvttU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+IQvjNLh3wir5E2445EB6N6DQtVLKZrA7gs6HoENXixYt7KaU2gZI89JN1tuBmy+8L+F/o3blyoAUgdQFV3FBAJmLZkc9pl/fTsqd6WZeoX16u8Vk3bTprw62dGE5G7ahugW184UObfb8tTiTXuSWB7yqGx+/kwRnY8dd56IDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PPG3j0gG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483NL8AY028870;
	Wed, 4 Sep 2024 09:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=w
	fUAADQz465dY49+LelFIq/3GUmstF7YsBpH18AnJfU=; b=PPG3j0gGikQGvDZ61
	eSVKEfQHqYSybHyCwMCugyIot9xV8V9mIuuil0eciQUxn7kaQPQNoRRLcx6qZeMZ
	OZ7saliI0jYwQxOFbyubCI2O7jbponzk/teoF11EqMU5Rb1h07I+OUxMcd7TprrA
	968nYGCHssmmJ2Jj7E2E8bGpSXaGXzhghs6YVJvH4d/Tx9LQ8E+iei18S8uqerzR
	mvOm5sxYrCjodQ9QI+ik53SPB9VivUCvypMSM3LhtcR3lcnHNOhurw820mSVliU1
	3IJLjB87UGw93Z0s9u5DZ6XwrLcF4jcpt3cp7qBmeucSwettWkw8djUYocSXNGEJ
	0bF2g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqtnbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:25:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4849PTBc003485;
	Wed, 4 Sep 2024 09:25:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkqtnb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:25:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48484NBS000957;
	Wed, 4 Sep 2024 09:25:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cdguq8ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 09:25:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4849PO4T31588942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 09:25:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84E412004D;
	Wed,  4 Sep 2024 09:25:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165B320040;
	Wed,  4 Sep 2024 09:25:19 +0000 (GMT)
Received: from [9.43.31.118] (unknown [9.43.31.118])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 09:25:18 +0000 (GMT)
Message-ID: <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
Date: Wed, 4 Sep 2024 14:55:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec/crash: no crash update when kexec in progress
To: Baoquan He <bhe@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Sachin P Bappalige <sachinpb@linux.vnet.ibm.com>
References: <20240731152738.194893-1-sourabhjain@linux.ibm.com>
 <87v80lnf8d.fsf@mail.lhotse>
 <10c666ae-d528-4f49-82e9-8e0fee7099e0@linux.ibm.com>
 <355b58b1-6c51-4c42-b6ea-dcd6b1617a18@linux.ibm.com>
 <ZsLjGJvAUIaxrG6x@MiWiFi-R3L-srv>
 <1e4a8e18-cda9-45f5-a842-8ffcd725efc9@linux.ibm.com>
 <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZtGqTSMvx6Ljf5Xi@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -fL4bXMBe2073WQZzvHxXRdpZK2kbqcd
X-Proofpoint-ORIG-GUID: 8aB4jZWTqqZ63vSBki47gDH_EiBmPZ1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_07,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040067

Hello Baoquan,

On 30/08/24 16:47, Baoquan He wrote:
> On 08/20/24 at 12:10pm, Sourabh Jain wrote:
>> Hello Baoquan,
>>
>> On 19/08/24 11:45, Baoquan He wrote:
>>> On 08/19/24 at 09:45am, Sourabh Jain wrote:
>>>> Hello Michael and Boaquan
>>>>
>>>> On 01/08/24 12:21, Sourabh Jain wrote:
>>>>> Hello Michael,
>>>>>
>>>>> On 01/08/24 08:04, Michael Ellerman wrote:
>>>>>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>>>>>> The following errors are observed when kexec is done with SMT=off on
>>>>>>> powerpc.
>>>>>>>
>>>>>>> [  358.458385] Removing IBM Power 842 compression device
>>>>>>> [  374.795734] kexec_core: Starting new kernel
>>>>>>> [  374.795748] kexec: Waking offline cpu 1.
>>>>>>> [  374.875695] crash hp: kexec_trylock() failed, elfcorehdr may
>>>>>>> be inaccurate
>>>>>>> [  374.935833] kexec: Waking offline cpu 2.
>>>>>>> [  375.015664] crash hp: kexec_trylock() failed, elfcorehdr may
>>>>>>> be inaccurate
>>>>>>> snip..
>>>>>>> [  375.515823] kexec: Waking offline cpu 6.
>>>>>>> [  375.635667] crash hp: kexec_trylock() failed, elfcorehdr may
>>>>>>> be inaccurate
>>>>>>> [  375.695836] kexec: Waking offline cpu 7.
>>>>>> Are they actually errors though? Do they block the actual kexec from
>>>>>> happening? Or are they just warnings in dmesg?
>>>>> The kexec kernel boots fine.
>>>>>
>>>>> This warning appears regardless of whether the kdump kernel is loaded.
>>>>>
>>>>> However, when the kdump kernel is loaded, we will not be able to update
>>>>> the kdump image (FDT).
>>>>> I think this should be fine given that kexec is in progress.
>>>>>
>>>>> Please let me know your opinion.
>>>>>
>>>>>> Because the fix looks like it could be racy.
>>>>> It seems like it is racy, but given that kexec takes the lock first and
>>>>> then
>>>>> brings the CPU up, which triggers the kdump image, which always fails to
>>>>> update the kdump image because it could not take the same lock.
>>>>>
>>>>> Note: the kexec lock is not released unless kexec boot fails.
>>>> Any comments or suggestions on this fix?
>>> Is this a little better?
>>>
>>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>>> index 63cf89393c6e..0355ffb712f4 100644
>>> --- a/kernel/crash_core.c
>>> +++ b/kernel/crash_core.c
>>> @@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
>>>    	crash_hotplug_lock();
>>>    	/* Obtain lock while reading crash information */
>>> -	if (!kexec_trylock()) {
>>> +	if (!kexec_trylock() && kexec_in_progress) {
>>>    		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>>>    		crash_hotplug_unlock();
>>>    		return 0;
>>> @@ -539,7 +539,7 @@ static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu,
>>>    	crash_hotplug_lock();
>>>    	/* Obtain lock while changing crash information */
>>> -	if (!kexec_trylock()) {
>>> +	if (!kexec_trylock() && kexec_in_progress) {
>>>    		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>>>    		crash_hotplug_unlock();
>>>    		return;
>> Ideally, when `kexec_in_progress` is True, there should be no way to acquire
>> the kexec lock.
>> Therefore, calling `kexec_trylock()` before checking `kexec_in_progress` is
>> not helpful.
>> The kernel will print the error message "kexec_trylock() failed, elfcorehdr
>> may be inaccurate."
>> So, with the above changes, the original problem remains unsolved.
>>
>> However, after closely inspecting the `kernel/kexec_core.c:kernel_kexec()`
>> function, I discovered
>> an exceptional case where my patch needs an update. The issue arises when
>> the system returns
>> from the `machine_kexec()` function, which indicates that kexec has failed.
>>
>> In this scenario, the kexec lock is released, but `kexec_in_progress`
>> remains True.
>>
>> I am unsure why `kexec_in_progress` is NOT set to False when kexec fails.
>> Was this by design,
>> or was it an oversight because returning from the `machine_kexec()` function
>> is highly unlikely?
>>
>> Here is my proposal to address the original problem along with the
>> exceptional case I described
>> above.
>>
>> Let's implement two patches:
>>
>> 1. A patch that sets `kexec_in_progress` to False if the system returns from
>> `machine_kexec()` before
> I don't think we have chance to return from machine_kexec() after
> triggering kexec/kdump jumping. The KEXEC_JUMP could return, but I'v
> never heard people using it.

Agree, on most arch there is no return from machine_kexec function.
So lets drop the above idea of resetting kexec_in_progress.


>
>>     unlocking the kexec lock in the `kernel_kexec()` function.
>>
>>     ```
>>     diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>     index c0caa14880c3..b41277183455 100644
>>     --- a/kernel/kexec_core.c
>>     +++ b/kernel/kexec_core.c
>>     @@ -1069,6 +1069,7 @@ int kernel_kexec(void)
>>     #endif
>>
>>      Unlock:
>>     +      kexec_in_progress = false;
>>             kexec_unlock();
>>             return error;
>>      ```
>>
>> 2. A patch to return early from the `crash_handle_hotplug_event()` function
>> if `kexec_in_progress` is
>>     set to True. This is essentially my original patch.
> There's a race gap between the kexec_in_progress checking and the
> setting it to true which Michael has mentioned.

The window where kernel is holding kexec_lock to do kexec boot
but kexec_in_progress is yet not set to True.

If kernel needs to handle crash hotplug event, the function
crash_handle_hotplug_event()  will not get the kexec_lock and
error out by printing error message about not able to update
kdump image.

I think it should be fine. Given that lock is already taken for
kexec kernel boot.

Am I missing something major?

> That's why I think
> maybe checking kexec_in_progress after failing to retriving
> __kexec_lock is a little better, not very sure.

Try for kexec lock before kexec_in_progress check will not solve
the original problem this patch trying to solve.

You proposed the below changes earlier:

-	if (!kexec_trylock()) {
+	if (!kexec_trylock() && kexec_in_progress) {
  		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
  		crash_hotplug_unlock();


Once the kexec_in_progress is set to True there is no way one can get
kexec_lock. So kexec_trylock() before kexec_in_progress is not helpful
for the problem I am trying to solve.


Thanks,
Sourabh Jain




