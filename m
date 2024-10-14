Return-Path: <linux-kernel+bounces-364018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F11B99C9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41DFB1C22C39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21591A7053;
	Mon, 14 Oct 2024 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XJSAPzJ7"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8501A4F34
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908503; cv=none; b=Badf9b60vATHz5YY9u6F5h3xvdQWFl8IYvtnDRXQQoAyG9BHuGkqpN7pBp7ZRcA/kTml17/46zkWCrcEu8EWeSV3fcE+B/jzmdqsjq8lmW6b2hjgWv3lNH6b29a9AuGVnmZx+Kdnvw+JiFIzrZ4cCS5NQ2g8N4AqCI3uAfQxiQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908503; c=relaxed/simple;
	bh=zIE02bZz6XinNpWaMMcnYCzBsrugCl9PGd65SuCMAkk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZmPIQX1zJqfRUBlUC3JWnU0eWmZ305NEMWiEKMxXRlwaw+p3Is/5o2FooRH+16kbOWsdDOncSUnTJC1i32sbqhhrpVlx2aC6tVcjXa37t6S2kP+wBjSNW4uCZIWKVwl/hoRBxDXBd7jfniN6kw3eqseSdnETfbW/wtKhzbzeWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XJSAPzJ7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E9ssNT005734;
	Mon, 14 Oct 2024 12:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	nYUq7adz2xqCBl+Ga8oFU+DVr40SauuZOQ0GZ3ecydE=; b=XJSAPzJ7NFg0Uy47
	Xou3n60PadCbcr/cXU7mKzHF9sAUDXVYmwteHAaayXNJKeG2u7gv+pL5wL6Odfa2
	QcnH4+miDCNKpZdK0Oojvght6xZIF4w0s/ieNsCj5YDmqyZ0YKgQvsgr6yKTPJqe
	qGYPLeVlYP7hI/HOBW3ZE280q5j1kpG6IcpfcxmJqyZ5pN17NxuwN66l8SYnIWkb
	rNs8U1Fomb9EIVJK5SFUivJMtUyrI77KSm+4/z1zbTEloEJzgh7KgXPRQ52COMJ3
	0nXgXXS8+OfJcYoRhDxWKtpMwi421MsmEC/Pn3EMCcqVbs8Qt994vz6QpmnZNIOa
	k/Va6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291330pex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 12:21:27 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ECJgRj002720;
	Mon, 14 Oct 2024 12:21:27 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4291330pet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 12:21:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49EBVSJu006401;
	Mon, 14 Oct 2024 12:21:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xjxb7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 12:21:26 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49ECLOrq45351440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Oct 2024 12:21:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D913D5804B;
	Mon, 14 Oct 2024 12:21:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CD3D58065;
	Mon, 14 Oct 2024 12:21:16 +0000 (GMT)
Received: from [9.43.116.47] (unknown [9.43.116.47])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Oct 2024 12:21:15 +0000 (GMT)
Message-ID: <55c554a2-fdf9-4a1b-acf4-c227786624ce@linux.ibm.com>
Date: Mon, 14 Oct 2024 17:51:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 1/3] fadump: Refactor and prepare fadump_cma_init for
 late init
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org, Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
        Donet Tom <donettom@linux.vnet.ibm.com>,
        LKML
 <linux-kernel@vger.kernel.org>,
        Sachin P Bappalige <sachinpb@linux.ibm.com>
References: <030b6d46fddac126a6cf7e119bea48055338f0ed.1728658614.git.ritesh.list@gmail.com>
 <941875f7-0d7f-4ba3-bc7c-7aedc3b20dae@linux.ibm.com>
 <87bjznyliv.fsf@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <87bjznyliv.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0qMBKVP7s2lJ0nmJZBXSfyMPAbPytZn_
X-Proofpoint-GUID: utFw1S-hiIhm1HWZkMo502AomZsmQ6d5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-14_10,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410140089



On 10/14/24 4:54 PM, Ritesh Harjani (IBM) wrote:
> Madhavan Srinivasan <maddy@linux.ibm.com> writes:
> 
>> On 10/11/24 8:30 PM, Ritesh Harjani (IBM) wrote:
>>> We anyway don't use any return values from fadump_cma_init(). Since
>>> fadump_reserve_mem() from where fadump_cma_init() gets called today,
>>> already has the required checks.
>>> This patch makes this function return type as void. Let's also handle
>>> extra cases like return if fadump_supported is false or dump_active, so
>>> that in later patches we can call fadump_cma_init() separately from
>>> setup_arch().
>>
>> Usually patches to this file are posted with title format of
>>
>> powerpc/fadump:<>
> 
> yes. I guess it is good to do it that way (I might have missed it)
> Although commit history of oldest few patches to fadump shows..
> 
> ebaeb5ae2437 fadump: Convert firmware-assisted cpu state dump data into elf notes.
> 2df173d9e85d fadump: Initialize elfcore header and add PT_LOAD program headers.
> 3ccc00a7e04f fadump: Register for firmware assisted dump.
> eb39c8803d0e fadump: Reserve the memory for firmware assisted dump.
> 
>>
>>
>>>
>>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>> v2 -> v3: Separated the series into 2 as discussed in v2.
>>> [v2]: https://lore.kernel.org/linuxppc-dev/cover.1728585512.git.ritesh.list@gmail.com/
>>>
>>>  arch/powerpc/kernel/fadump.c | 23 +++++++++--------------
>>>  1 file changed, 9 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>>> index a612e7513a4f..162327d66982 100644
>>> --- a/arch/powerpc/kernel/fadump.c
>>> +++ b/arch/powerpc/kernel/fadump.c
>>> @@ -78,27 +78,23 @@ static struct cma *fadump_cma;
>>>   * But for some reason even if it fails we still have the memory reservation
>>>   * with us and we can still continue doing fadump.
>>>   */
>>> -static int __init fadump_cma_init(void)
>>> +static void __init fadump_cma_init(void)
>>>  {
>>>  	unsigned long long base, size;
>>>  	int rc;
>>>
>>> -	if (!fw_dump.fadump_enabled)
>>> -		return 0;
>>> -
>>> +	if (!fw_dump.fadump_supported || !fw_dump.fadump_enabled ||
>>> +			fw_dump.dump_active)
>>> +		return;
>>
>> Is these checks even needed here? fadump_reserve_mem() checked for all
>> these already, also dont see any other caller for fadump_cma_init(). 
>>
>>
> 
> In the next patch we will move fadump_cma_init() call from within
> fadump_reserve_mem() to setup_arch(). Hence we need these extra checks
> in fadump_cma_init() as well. I mentioned the same in the commit msg of
> this patch too.
> 

yes, just saw that when looking at the patch 3, sorry for the noise.


>>>  	/*
>>>  	 * Do not use CMA if user has provided fadump=nocma kernel parameter.
>>> -	 * Return 1 to continue with fadump old behaviour.
>>>  	 */
>>> -	if (fw_dump.nocma)
>>> -		return 1;
>>> +	if (fw_dump.nocma || !fw_dump.boot_memory_size)
>>> +		return;
>>>
>>>  	base = fw_dump.reserve_dump_area_start;
>>>  	size = fw_dump.boot_memory_size;
>>>
>>> -	if (!size)
>>> -		return 0;
>>
>> So this is the only place where we return 0, which in turn will make the
>> "ret" in fadump_reserve_mem() as zero forcing to call reserve_crashkernel()
>> in early_init_devtree().
>>
>> we are removing it, becos we know "size" here will never be zero?
>>
>>
> 
> yes. Because we already check if boot_memory_size is less than
> bootmem_min in fadump_reserve_mem(). If it is less, then we fail and
> disable fadump (fadump_enabled = 0).
>

Thanks for the clarification.


 
> So then there is no need to check for !boot_memory_size in here.
> 
> fadump_reseve_mem( ) {
> <...>
> 	if (!fw_dump.dump_active) {
> 		fw_dump.boot_memory_size =
> 			PAGE_ALIGN(fadump_calculate_reserve_size());
> 
> 		bootmem_min = fw_dump.ops->fadump_get_bootmem_min();
> 		if (fw_dump.boot_memory_size < bootmem_min) {
> 			pr_err("Can't enable fadump with boot memory size (0x%lx) less than 0x%llx\n",
> 			       fw_dump.boot_memory_size, bootmem_min);
> 			goto error_out;
> 		}
>     <...>    
>     }
> <...>
> error_out:
> 	fw_dump.fadump_enabled = 0;
> 	fw_dump.reserve_dump_area_size = 0;
> 	return 0;
> }
> 
> 
> Thanks for the review!
> -ritesh


