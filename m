Return-Path: <linux-kernel+bounces-316649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DCF96D25A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8DF61C22C71
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883B194AFB;
	Thu,  5 Sep 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LuyNdk5o"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDD194AD5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525514; cv=none; b=FtduQOs0civE9tT5Y713FZPL0GohcUYgwqGuzdXYTAVry8nz5JYqCVDxB8v5FXjTWZoLGlrsYtb9DpTPBWQIiwoeqieeOkAYQO+FmU8UQQw7XJTRlv6F8WfOLphmwvLsQmOtI2L9D5nbTB7kCv28slPgUSjPbREqRssRt0dBSmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525514; c=relaxed/simple;
	bh=O/1cVZDDpAvPIiC66Qhs1OiBuTq4cNLt6sZd3z4TOQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TA9rCNyhjjkO29jRM8s8UEK14I/0k67+69232gnHYJckvnyBg+RrXs3GVAZNFdAlT8KIcu4dqBPJWrPh1h7Tdf5YqQM9/cD9FHxcEv5v22QriTF4P+3muGzWt+NxSKXnjLgNJgXyUjcoPg6J2XWjD5G/5M1ohiVPZgSVFHc5E50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LuyNdk5o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4853NF5a018187;
	Thu, 5 Sep 2024 08:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=P
	9ADIHjRXj1WJsIRfcpdcdI+TM8EPlLvEY98Zxn8VVk=; b=LuyNdk5oCTEB4An5o
	jfiLCTtfzXlCIPovMi8tpFj+lroHcSdiPiURhwxuv+1wBvn5DwlGsXIaCZujFhAh
	BQmUqEzH8aqEnRCYzMHeTGEycBv8FYYRaG2XCZbVc62e/VpnhWvsJp+n6kBlcp6u
	nbIUf1XfJwjfOPIO5+0Bq0k0vM4nrQtEfKjfSOMKwys+258nDoWLi4Ti6hF7Hlzf
	u4AcT9XiIssb9EOSdpVqpSOVohSIsIOhhGABfOn8ypLxgBHbH3KH2akckOYDc1Hj
	62u8xk0e/AqN1e7dOAPSEbqAX0/m/+tIXO2EpzS6lrMjseO37IDSurCZiNRN1JnA
	PiWLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkr02mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:38:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4858U5SO023730;
	Thu, 5 Sep 2024 08:38:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41brkr02mg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:38:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4855vRsS018672;
	Thu, 5 Sep 2024 08:38:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41cdw1c0ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:38:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4858c5Uv15335874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Sep 2024 08:38:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9B9420063;
	Thu,  5 Sep 2024 08:38:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1EF320043;
	Thu,  5 Sep 2024 08:38:00 +0000 (GMT)
Received: from [9.43.125.148] (unknown [9.43.125.148])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Sep 2024 08:38:00 +0000 (GMT)
Message-ID: <c6f30e31-69fe-4ece-b251-c49f1ab59a04@linux.ibm.com>
Date: Thu, 5 Sep 2024 14:07:58 +0530
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
 <0dd94920-b13f-4da7-9ea6-4f008af1f4b3@linux.ibm.com>
 <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZtkkIoUIu8shp/ut@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3E_zICSznpiTbAsJp_vUj6gzJGxIoAtF
X-Proofpoint-ORIG-GUID: hIqrKRw-KLK960E0ks9WsRAv3WYC4C5x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 mlxscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=992 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050063

Hello Baoquan,

On 05/09/24 08:53, Baoquan He wrote:
> On 09/04/24 at 02:55pm, Sourabh Jain wrote:
>> Hello Baoquan,
>>
>> On 30/08/24 16:47, Baoquan He wrote:
>>> On 08/20/24 at 12:10pm, Sourabh Jain wrote:
>>>> Hello Baoquan,
>>>>
> ......snip...
>>>> 2. A patch to return early from the `crash_handle_hotplug_event()` function
>>>> if `kexec_in_progress` is
>>>>      set to True. This is essentially my original patch.
>>> There's a race gap between the kexec_in_progress checking and the
>>> setting it to true which Michael has mentioned.
>> The window where kernel is holding kexec_lock to do kexec boot
>> but kexec_in_progress is yet not set to True.
>>
>> If kernel needs to handle crash hotplug event, the function
>> crash_handle_hotplug_event()  will not get the kexec_lock and
>> error out by printing error message about not able to update
>> kdump image.
> But you wanted to avoid the erroring out if it's being in
> kernel_kexec().  Now you are seeing at least one the noising
> message, aren't you?

Yes, but it is very rare to encounter.

My comments on your updated code are inline below.

>
>> I think it should be fine. Given that lock is already taken for
>> kexec kernel boot.
>>
>> Am I missing something major?
>>
>>> That's why I think
>>> maybe checking kexec_in_progress after failing to retriving
>>> __kexec_lock is a little better, not very sure.
>> Try for kexec lock before kexec_in_progress check will not solve
>> the original problem this patch trying to solve.
>>
>> You proposed the below changes earlier:
>>
>> -	if (!kexec_trylock()) {
>> +	if (!kexec_trylock() && kexec_in_progress) {
>>   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>>   		crash_hotplug_unlock();
> Ah, I meant as below, but wrote it mistakenly.
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 63cf89393c6e..e7c7aa761f46 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -504,7 +504,7 @@ int crash_check_hotplug_support(void)
>   
>   	crash_hotplug_lock();
>   	/* Obtain lock while reading crash information */
> -	if (!kexec_trylock()) {
> +	if (!kexec_trylock() && !kexec_in_progress) {
>   		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>   		crash_hotplug_unlock();
>   		return 0;
>
>
>>
>> Once the kexec_in_progress is set to True there is no way one can get
>> kexec_lock. So kexec_trylock() before kexec_in_progress is not helpful
>> for the problem I am trying to solve.
> With your patch, you could still get the error message if the race gap
> exist. With above change, you won't get it. Please correct me if I am
> wrong.

The above code will print an error message during the race gap. Here's why:

Let’s say the kexec lock is acquired in the kernel_kexec() function,
but kexec_in_progress is not yet set to True. In this scenario, the code 
will print
an error message.

There is another issue I see with the above code:

Consider that the system is on the kexec kernel boot path, and 
kexec_in_progress
is set to True. If crash_hotplug_unlock() is called, the kernel will not 
only update
the kdump image without acquiring the kexec lock, but it will also 
release the
kexec lock in the out label. I believe this is incorrect.

Please share your thoughts.

Thanks,
Sourabh Jain



