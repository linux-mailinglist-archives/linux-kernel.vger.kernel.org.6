Return-Path: <linux-kernel+bounces-284124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E275994FD38
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840D71F21B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321E923774;
	Tue, 13 Aug 2024 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ITmNG1XJ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65062233A
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723526919; cv=none; b=u12y4Q3B+sc6oF6M0JZhw3TQaGSxBEBocseIlf+OZRo1o92CugsyoJI1b8jOfj4mn23hqCRgTHIHq5WjTGrx1ys3pp78z+WUj/hQTOPW1HvAoJIT4SXinHe30l9x6l5l8DSFTi4NIdu2Ea6a/iwIHMP4ADFXZk7oOcxnojkpuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723526919; c=relaxed/simple;
	bh=K9hio/8gcsf/IEmAE/9MPpkMG8SuEhrXUVT5wkXRwHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tto386ZN0Vaq6DafYwxyxRxWLn1xZIQ92e5KhlmLGoIRlNR7LmvibWmUKt7oyAgzOykYVBX6W2Zn4Uj05olzkoCLzBu0l0eTch98J0ObxPiKfq7+o3/Pb2UKon9cvBrWSVRdPZhQoRvzedqRJh23LXEOW83Ak7VZMGK8Ygdl8EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ITmNG1XJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CNlZcL009210;
	Tue, 13 Aug 2024 05:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	/lNn5nU6xFoZkgBpvGqy1oEMvMo3TWepI8F/OAlN3uQ=; b=ITmNG1XJQUhMGpOI
	iCKpSLHyMYfLEarrxX9AUkiRSKaA6xU/3UmDMvLWvu5nBJBPbjwBjhFhHdZSvcYO
	XknWB+ib+sT/iMuFnZA+FqmXNYiWMpFwTnX4doaksAh7M8eLvlyJyOi8QEjrlgzG
	AXqGjZP8gumnKQygyxJesHEVAm8A4q0j3MfXGPCiRHg5I1Hu5lVozASXCNAxnAUt
	dlpvlD3lRo40ClkAs4BYZ0Z4vF76GTKVfrwIKzH6Tr1Z2hCZyjGV6l6DfIWpcFPz
	sHKqgVZB0KQPl4XNE1gpH3cGBsoBypIDTkNneQclTj9S5xhH4v4Af19R0zU+I56I
	Z2C34A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wy0rpn1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:28:21 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47D5SL68008157;
	Tue, 13 Aug 2024 05:28:21 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wy0rpn1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:28:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47D3oiH3016309;
	Tue, 13 Aug 2024 05:28:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhphyxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 05:28:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47D5SGaO48955810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 05:28:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4437820049;
	Tue, 13 Aug 2024 05:28:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D478C2004D;
	Tue, 13 Aug 2024 05:28:13 +0000 (GMT)
Received: from [9.43.76.60] (unknown [9.43.76.60])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 05:28:13 +0000 (GMT)
Message-ID: <4cbbf314-5134-4a1a-8a4d-f6f8c09104d3@linux.ibm.com>
Date: Tue, 13 Aug 2024 10:58:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Document/kexec: Generalize crash hotplug description
To: Baoquan He <bhe@redhat.com>
Cc: Petr Tesarik <petr@tesarici.cz>, Hari Bathini <hbathini@linux.ibm.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
References: <20240812041651.703156-1-sourabhjain@linux.ibm.com>
 <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Zrrpcn7cnCigNfWd@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _t_Jy8gzm8GRubRgPR8-NNNKZC7NI_iL
X-Proofpoint-GUID: y3oYdxfQXZBJ9XHE2X8Vd_g5qQcQ6-aA
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
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=897 adultscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130034

Hello Baoquan,

On 13/08/24 10:34, Baoquan He wrote:
> On 08/12/24 at 09:46am, Sourabh Jain wrote:
> ......
>> ---
>>
>> Changelog:
>>
>> Since v1: https://lore.kernel.org/all/20240805050829.297171-1-sourabhjain@linux.ibm.com/
>>    - Update crash_hotplug sysfs document as suggested by Petr T
>>    - Update an error message in crash_handle_hotplug_event and
>>      crash_check_hotplug_support function.
>>
>> ---
> ......
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 63cf89393c6e..c1048893f4b6 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -505,7 +505,7 @@ int crash_check_hotplug_support(void)
>>   	crash_hotplug_lock();
>>   	/* Obtain lock while reading crash information */
>>   	if (!kexec_trylock()) {
>> -		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
>> +		pr_info("kexec_trylock() failed, kdump image may be inaccurate\n");
> Wondering why this need be updated.

In some architectures, additional kexec segments become obsolete during 
a hotplug event,
so simply calling out the `elfcorehdr may be inaccurate` may not be 
sufficient.
Therefore, it has been generalized with the kdump image.


Thanks,
Sourabh Jain

