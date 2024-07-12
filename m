Return-Path: <linux-kernel+bounces-250240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EB592F596
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB537B22117
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FB413D533;
	Fri, 12 Jul 2024 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n4GG/gYM"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F9C567D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765910; cv=none; b=F4PxPI0x2XojSqEt7Tk9JyY8SBk50vBvJEf8iyjQATRqAEu6uVJIzB0OVMOi72jkSptXNjIolPtk8d95C32JjoArexq1TANVGuLqiFQaLNceR+JLzeJhI9mD+3f6pKVzLK9U1TW5urUEHUOWASXi7v0Ob4rMHaAZ908A3Ux7CSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765910; c=relaxed/simple;
	bh=zpY+UVU94VKdc8D0KxSNqg+2SlHP/2dcksO7/44UbIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocB/tK3UVN8QjIhyJqe56c61Cqu7WNIJMKjH03+IT1VPIHu0FjKHCkkbPWxiWu/3Ivji0T1YJrbukdbFxjWBiSPE+nh5iNAJDThSJtJb6IGp1At7Nc7IaN8XdXT7Qwj2TOMuPTqXFkhnEoNFXCD7D2Ec+/mEM4Hr/2RVMstB8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n4GG/gYM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C5whPp002254;
	Fri, 12 Jul 2024 06:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=O
	f4dh5UXKm99ecBhcvSkEVAHjDHk5e8n3A4iqjKjDqI=; b=n4GG/gYMtPXGHRT5y
	3Wpt8KpznFhdkRJpV9shWoImEBtSpg2gh4D/BgnLhZbxqYARZuXAlmPfck7T/l91
	Icg945UzC6AhuOsiQCMBMRtV691tGP8sNA0nbMxpQ/jG7VByjfVy+nDOEGG40+mO
	aCIJL5kk7qEppMznQyP8238iV7WoiIqF3C5muKJuxYUqsOXgsL9v2JsmHRavwNWx
	IRFG6uAjtfgt5jVSf37Q8zuQKBElPtQj0jbMlk3TxYQAqIky10Kd9k8S7mbAIWH8
	7/ErsqeNAGQC04Uf1P2qWYgMYORQ1p050bnexkAuzogOWfLEvwyGXXU9DrAI57Pl
	wEC8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40axtbr1wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:31:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46C6UiWh024680;
	Fri, 12 Jul 2024 06:31:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8un9bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 06:31:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46C6VVb952953550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 06:31:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA4BD20040;
	Fri, 12 Jul 2024 06:31:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A9C620049;
	Fri, 12 Jul 2024 06:31:30 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Jul 2024 06:31:30 +0000 (GMT)
Message-ID: <06c0d61f-8dcb-46f6-8710-db1c6163907b@linux.ibm.com>
Date: Fri, 12 Jul 2024 12:01:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysfs/cpu: Make crash_hotplug attribute world-readable
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Petr Tesarik <ptesarik@suse.com>
References: <20240711103409.319673-1-petr.tesarik@suse.com>
 <59d88de7-369a-44e8-a965-109c8690869e@linux.ibm.com>
 <20240712082124.272e079f@meshulam.tesarici.cz>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240712082124.272e079f@meshulam.tesarici.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bbK5wqvobk6pCsIRPXdZ0dLcnW4TbT0F
X-Proofpoint-ORIG-GUID: bbK5wqvobk6pCsIRPXdZ0dLcnW4TbT0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=747
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120042

Hello Petr,

On 12/07/24 11:51, Petr Tesařík wrote:
> On Fri, 12 Jul 2024 10:00:09 +0530
> Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>
>> Hello Petr,
>>
>> Just want to mentioned few points about the commit message. No strong
>> opinion on changing the commit message.
>>
>> On 11/07/24 16:04, Petr Tesarik wrote:
>>> From: Petr Tesarik <ptesarik@suse.com>
>>>
>>> There is no reason to restrict access to this attribute, as it merely
>>> reports whether crash elfcorehdr is automatically updated on CPU hot
>>> plug/unplug and/or online/offline events.
>> Now, it is not just elfcorehdr; there could be multiple kexec segments
>> based on the architecture's needs.
>> For example, on PowerPC, it is elfcorehdr and FDT.
> Right. I am even working with a PowerVM LPAR on an L922 system now. ;-)
>
> OTOH I was just too lazy to invent my own description, so I took it
> from Documentation/ABI/testing/sysfs-devices-system-cpu. That one
> could be improved. And a couple of other places... Expect a patch.
Thanks for point it out, I will send a patch to fix the ABI document for 
crash_hotplug and other places in the kernel. Thanks,
Sourabh Jain

