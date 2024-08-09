Return-Path: <linux-kernel+bounces-280783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B694CF28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B244D2842AF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 11:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4926192B66;
	Fri,  9 Aug 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SAz2rH4j"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE517993
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723201432; cv=none; b=CCk91UtjTUtsW6etN+cF813GWyWigl9LncbB2UQ7i5CMdQ7q8R+NSSraqjjw+SuNZBV7rFrzW8R2yaclDonk7WuCZKLRq5NBgK1BdzLY8srY1fdgNM4ohTS15pBWuEZjie+5UHScEIp5qxSvy4KBGREMt/i2xX/eAj6fo0+NWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723201432; c=relaxed/simple;
	bh=0D+U1vnKibwU/cxx3NOwezp6OPK1IDnV4mEk5hIFuYQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SXcDKMEg/ly93AEuAq75YE37b7iuef1Y65as4wiemwjD5WqbDMaAnpnyicqx+SuhK6Sd9DDXUeYteuV8vO2oUe4QUXOsYRn+LPXq4RNOhqQuQ+t1NVNxsH5BRJ9tgOdpwNZSwuNVeeuNampJv+4jbj/UywPhi2DPgW30sYukQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SAz2rH4j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4793o1gb016037;
	Fri, 9 Aug 2024 11:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	nJqdIO0p9YPVRh8ZpNHZjkYc5An8vfwCyjwbvPnd+W8=; b=SAz2rH4jD+cwHj5b
	D4UfBmBnCVX6aVVKXwgUDW2l3PJOI3q8hiavJK2WyaXuCrZSSeajqqHAQWIs6mqT
	EibNjY8NEsPRzG6Z6CIwMJ7jyfMzUobYg4lBzhYkENKte1tXEwFU2A4eJHwN44Kh
	v8xVNSNKvXF9vES6e5TYvITVQTCjfBKLroAJ0nViF0vsoSpDCVSsKxYhfDAZv82h
	lGSaPeTCf0hRGxptzUseuGGwjhrUbwSB3sysNMkXZkLBZovBTOZd8/cJJtqBpQcu
	OvMtACoyqtQQrPUQpwQcGKV+o58CdBhyWTcTiFTz0B9GlfCxITjQ4Ml0qSLWjXvM
	t8zFFQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkd2m8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 11:03:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 479B3Vkh029468;
	Fri, 9 Aug 2024 11:03:31 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40vwkd2m8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 11:03:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4799XVRF030246;
	Fri, 9 Aug 2024 11:03:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40t1k3jtfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 11:03:30 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 479B3QQi52167120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 11:03:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9B7B20043;
	Fri,  9 Aug 2024 11:03:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8B3B20040;
	Fri,  9 Aug 2024 11:03:14 +0000 (GMT)
Received: from [9.43.4.15] (unknown [9.43.4.15])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Aug 2024 11:03:12 +0000 (GMT)
Message-ID: <10624524-a078-404e-a5ba-c250de81c36f@linux.ibm.com>
Date: Fri, 9 Aug 2024 16:33:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Document/kexec: Generalize crash hotplug description
To: Baoquan He <bhe@redhat.com>, Petr Tesarik <petr@tesarici.cz>
Cc: Hari Bathini <hbathini@linux.ibm.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org
References: <20240805050829.297171-1-sourabhjain@linux.ibm.com>
 <ZrV1V4QzDShYJSsI@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ZrV1V4QzDShYJSsI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G3dNSs9_K1sjeYx6XFYqMwIVVVXLlSAp
X-Proofpoint-ORIG-GUID: HeiXgEUdtAaoaB5J6mr7b5erk5Y9HC1i
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_07,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090077

Hello Baoquan,

On 09/08/24 07:18, Baoquan He wrote:
> On 08/05/24 at 10:38am, Sourabh Jain wrote:
>> Commit 79365026f869 ("crash: add a new kexec flag for hotplug support")
>> generalizes the crash hotplug support to allow architectures to update
>> multiple kexec segments on CPU/Memory hotplug and not just elfcorehdr.
>> Therefore, update the relevant kernel documentation to reflect the same.
>>
>> No functional change.
>>
>> Cc: Petr Tesarik <petr@tesarici.cz>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> Cc: kexec@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: x86@kernel.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>
>> Discussion about the documentation update:
>> https://lore.kernel.org/all/68d0328d-531a-4a2b-ab26-c97fd8a12e8b@linux.ibm.com/
>>
>> ---
>>   .../ABI/testing/sysfs-devices-memory          |  6 ++--
>>   .../ABI/testing/sysfs-devices-system-cpu      |  6 ++--
>>   .../admin-guide/mm/memory-hotplug.rst         |  5 ++--
>>   Documentation/core-api/cpu_hotplug.rst        | 10 ++++---
>>   kernel/crash_core.c                           | 29 ++++++++++++-------
>>   5 files changed, 33 insertions(+), 23 deletions(-)
> The overall looks good to me, except of concern from Petr. Thanks.

Thanks for the review. I will make the suggested changes in v2.

Additionally I will also generalize the error message
"kexec_trylock() failed, elfcorehdr may be inaccurate " from
functions crash_handle_hotplug_event() and crash_check_hotplug_support()
to "kexec_trylock() failed, kdump image may be inaccurate"

- Sourabh Jain

>
>> diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
>> index a95e0f17c35a..421acc8e2c6b 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-memory
>> +++ b/Documentation/ABI/testing/sysfs-devices-memory
>> @@ -115,6 +115,6 @@ What:		/sys/devices/system/memory/crash_hotplug
>>   Date:		Aug 2023
>>   Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>>   Description:
>> -		(RO) indicates whether or not the kernel directly supports
>> -		modifying the crash elfcorehdr for memory hot un/plug and/or
>> -		on/offline changes.
>> +		(RO) indicates whether or not the kernel update of kexec
>> +		segments on memory hot un/plug and/or on/offline events,
>> +		avoiding the need to reload kdump kernel.
>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> index 325873385b71..f4ada1cd2f96 100644
>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>> @@ -703,9 +703,9 @@ What:		/sys/devices/system/cpu/crash_hotplug
>>   Date:		Aug 2023
>>   Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
>>   Description:
>> -		(RO) indicates whether or not the kernel directly supports
>> -		modifying the crash elfcorehdr for CPU hot un/plug and/or
>> -		on/offline changes.
>> +		(RO) indicates whether or not the kernel update of kexec
>> +		segments on CPU hot un/plug and/or on/offline events,
>> +		avoiding the need to reload kdump kernel.
>>   
>>   What:		/sys/devices/system/cpu/enabled
>>   Date:		Nov 2022
>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
>> index 098f14d83e99..cb2c080f400c 100644
>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>> @@ -294,8 +294,9 @@ The following files are currently defined:
>>   ``crash_hotplug``      read-only: when changes to the system memory map
>>   		       occur due to hot un/plug of memory, this file contains
>>   		       '1' if the kernel updates the kdump capture kernel memory
>> -		       map itself (via elfcorehdr), or '0' if userspace must update
>> -		       the kdump capture kernel memory map.
>> +		       map itself (via elfcorehdr and other relevant kexec
>> +		       segments), or '0' if userspace must update the kdump
>> +		       capture kernel memory map.
>>   
>>   		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>>   		       configuration option.
>> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
>> index dcb0e379e5e8..a21dbf261be7 100644
>> --- a/Documentation/core-api/cpu_hotplug.rst
>> +++ b/Documentation/core-api/cpu_hotplug.rst
>> @@ -737,8 +737,9 @@ can process the event further.
>>   
>>   When changes to the CPUs in the system occur, the sysfs file
>>   /sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
>> -updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
>> -or '0' if userspace must update the kdump capture kernel list of CPUs.
>> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr and
>> +other relevant kexec segment), or '0' if userspace must update the kdump
>> +capture kernel list of CPUs.
>>   
>>   The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>>   option.
>> @@ -750,8 +751,9 @@ file can be used in a udev rule as follows:
>>    SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>   
>>   For a CPU hot un/plug event, if the architecture supports kernel updates
>> -of the elfcorehdr (which contains the list of CPUs), then the rule skips
>> -the unload-then-reload of the kdump capture kernel.
>> +of the elfcorehdr (which contains the list of CPUs) and other relevant
>> +kexec segments, then the rule skips the unload-then-reload of the kdump
>> +capture kernel.
>>   
>>   Kernel Inline Documentations Reference
>>   ======================================
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 63cf89393c6e..64dad01e260b 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -520,18 +520,25 @@ int crash_check_hotplug_support(void)
>>   }
>>   
>>   /*
>> - * To accurately reflect hot un/plug changes of cpu and memory resources
>> - * (including onling and offlining of those resources), the elfcorehdr
>> - * (which is passed to the crash kernel via the elfcorehdr= parameter)
>> - * must be updated with the new list of CPUs and memories.
>> + * To accurately reflect hot un/plug changes of CPU and Memory resources
>> + * (including onling and offlining of those resources), the relevant
>> + * kexec segments must be updated with latest CPU and Memory resources.
>>    *
>> - * In order to make changes to elfcorehdr, two conditions are needed:
>> - * First, the segment containing the elfcorehdr must be large enough
>> - * to permit a growing number of resources; the elfcorehdr memory size
>> - * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
>> - * Second, purgatory must explicitly exclude the elfcorehdr from the
>> - * list of segments it checks (since the elfcorehdr changes and thus
>> - * would require an update to purgatory itself to update the digest).
>> + * Architectures must ensure two things for all segments that need
>> + * updating during hotplug events:
>> + *
>> + * 1. Segments must be large enough to accommodate a growing number of
>> + *    resources.
>> + * 2. Exclude the segments from SHA verification.
>> + *
>> + * For example, on most architectures, the elfcorehdr (which is passed
>> + * to the crash kernel via the elfcorehdr= parameter) must include the
>> + * new list of CPUs and memory. To make changes to the elfcorehdr, it
>> + * should be large enough to permit a growing number of CPU and Memory
>> + * resources. One can estimate the elfcorehdr memory size based on
>> + * NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES. The elfcorehdr is
>> + * excluded from SHA verification by default if the architecture
>> + * supports crash hotplug.
>>    */
>>   static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu, void *arg)
>>   {
>> -- 
>> 2.45.2
>>


