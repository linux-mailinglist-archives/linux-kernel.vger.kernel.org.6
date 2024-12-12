Return-Path: <linux-kernel+bounces-442527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC8D9EDDCA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC1A281083
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E86E14F136;
	Thu, 12 Dec 2024 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C0lAudPK"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA213541B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733972396; cv=none; b=VNVVoKV4OkIWelDBEBg8E9iJ97UAnoPRzSXPXzU0rvuleTWTfEwObh5H465VvC9LsaA9RqGREJU9mU/Xbl45oqS+1MY95fwCvx/gRnh69fGl/l/0YQn9Slu9uJEOoyQU0LHhzDuAbqkrij7jDNvvPNPFCSEMbHhXVVePPeVffFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733972396; c=relaxed/simple;
	bh=Kx9QR3KeWvBCfLAQqB1k3jJM68Z6T2qxjTgyOVui+og=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKQgzQGuCG0PMbcX58WueUNkyne5Z9UFQi6244ltjYOja96Bfxpz2EB8JgU48kmCw+vtSmcV2UXUkwDSUB/TZKSIkxwnAeP63r2HhBGaDCIM9ul8pcs3tFMoudmL3v4+/pqHXhyi+bJUoxubiJe/yAEC9ZuLbD34IJRJ/sK/iHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C0lAudPK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBK3o2w004130;
	Thu, 12 Dec 2024 02:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sz2LwS
	l/boxagL/G99gMkSY83O4TLOki/0YjWQPvsig=; b=C0lAudPKZdA2B7LjkLQJPS
	1t8GnsFN9C5HYBNo5Lrkhyw0j2eFJiKA/Fer9DZdJjEqvFNddGU6nhPeT8LyDsaL
	Xu9fc+AFyGcUvwwvUbr6gOxBmgM8FOBKqEsU3CFsR4y6DeTuwVVhvHEYpLLOk0pn
	xosXuwVxoHVza6TPY3h08R/0U8E+PI665A8mnLqQIaR/p3J6xPPGr4ls2laUvmA5
	ybYoVcCnofGb6rfXGXqAMwsrKcOyZgM3tEN4E+YCqVn4KqlOn2OTrUCPio9ChKGH
	+BV5tNaqLjwkwdMcUKpOj1a6a3/an/RuBAgLi05eFj00PIlgvwISslQjnOkoF6zw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv91hrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 02:59:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC0WNji016930;
	Thu, 12 Dec 2024 02:58:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12ydwj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 02:58:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BC2wp0k60555520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 02:58:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62D1E20043;
	Thu, 12 Dec 2024 02:58:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DB8F20040;
	Thu, 12 Dec 2024 02:58:49 +0000 (GMT)
Received: from [9.109.204.94] (unknown [9.109.204.94])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 02:58:49 +0000 (GMT)
Message-ID: <ed53108f-29e3-4d8a-bcf3-f602011918f3@linux.ibm.com>
Date: Thu, 12 Dec 2024 08:28:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: Initialize ELF lowest address to ULONG_MAX
To: Baoquan he <bhe@redhat.com>
Cc: ebiederm@xmission.com, Hari Bathini <hbathini@linux.ibm.com>,
        akpm@linux-foundation.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20241210091314.185785-1-sourabhjain@linux.ibm.com>
 <Z1pQoh7IwtERIWe5@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <Z1pQoh7IwtERIWe5@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yrx1KC4-pPj3pWd1OB3VrXvb-MrgZQKx
X-Proofpoint-ORIG-GUID: Yrx1KC4-pPj3pWd1OB3VrXvb-MrgZQKx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120021


On 12/12/24 08:25, Baoquan he wrote:
> On 12/10/24 at 02:43pm, Sourabh Jain wrote:
>> kexec_elf_load() loads an ELF executable and sets the address of the
>> lowest PT_LOAD section to the address held by the lowest_load_addr
>> function argument.
>>
>> To determine the lowest PT_LOAD address, a local variable lowest_addr
>> (type unsigned long) is initialized to UINT_MAX. After loading each
>> PT_LOAD, its address is compared to lowest_addr. If a loaded PT_LOAD
>> address is lower, lowest_addr is updated. However, setting lowest_addr
>> to UINT_MAX won't work when the kernel image is loaded above 4G, as the
>> returned lowest PT_LOAD address would be invalid. This is resolved by
>> initializing lowest_addr to ULONG_MAX instead.
>>
>> This issue was discovered while implementing crashkernel high/low
>> reservation on the PowerPC architecture.
>>
>> Fixes: a0458284f062 ("powerpc: Add support code for kexec_file_load()")
>> Cc: Baoquan he <bhe@redhat.com>
>> Cc: Hari Bathini <hbathini@linux.ibm.com>
>> CC: Madhavan Srinivasan <maddy@linux.ibm.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: kexec@lists.infradead.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   kernel/kexec_elf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/kexec_elf.c b/kernel/kexec_elf.c
>> index d3689632e8b9..3a5c25b2adc9 100644
>> --- a/kernel/kexec_elf.c
>> +++ b/kernel/kexec_elf.c
>> @@ -390,7 +390,7 @@ int kexec_elf_load(struct kimage *image, struct elfhdr *ehdr,
>>   			 struct kexec_buf *kbuf,
>>   			 unsigned long *lowest_load_addr)
>>   {
>> -	unsigned long lowest_addr = UINT_MAX;
>> +	unsigned long lowest_addr = ULONG_MAX;
> Great catch.
>
> Acked-by: Baoquan He <bhe@redhat.com>

Thanks for the Ack Baoquan.

- Sourabh Jain

