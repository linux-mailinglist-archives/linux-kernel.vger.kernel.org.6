Return-Path: <linux-kernel+bounces-576387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF3A70E91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D407918916B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1404B433CB;
	Wed, 26 Mar 2025 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W2cTTUfA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61147DA8C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953511; cv=none; b=LE7r4yTD3g1EI41DS3loVF1prEHJOn/rXFSEZh+9frf6IOZBsSFWkSKu+xVd/1f8drFAtpU549kGxV1sbSRz2x4ACu45c2tktUHArzdKrx0qq5N3PHZYaq6IDIXlo2Jrgl5SyJBsqES0aN1lyjlPCG4tpzPEwM9zsFrXX+d2hAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953511; c=relaxed/simple;
	bh=AR0i3fnXRHnzKLCNCJz8BksqziPjecBI9ZQBZ09/f8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OD37F96STak3aNf74U4Lk4oX4x9/O7JIUhGgkzXPDOFos0y7+6k276m+gYDnkfs0rRsxAhvWO5L5rFmG+d1BdmhaW6Ad7Mrz2nyBrCDJxH68BFCrjmx+b4MgPkjeNZitK8x6rynHm4P1xRiubCJJcjwrq22cBLjGxNpDevqeqVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W2cTTUfA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PLagFm005368;
	Wed, 26 Mar 2025 01:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bzx9ac
	KEj01nwPiaOBsmDrTzp1VYYY+QC8BCPU0DGQk=; b=W2cTTUfAIsREITsPM13AjC
	0UO8HEEiSbXVE/w9qZrgU7FG1y8f+Q+lz8myp3pXybMuLdQdSRToFD5IJsjQF+j8
	OCXsvtcAFJq1RY8jlcU0BEHyrR+H0TFNwB5xkRX2GgbrKxlgNiZH/+jmYEqKT8o9
	ciRSUAdpnDNUkoAW/amO8IDoKYa6WFgAAqWKhZV2TVx9KT7+faMjnnD8FsdqnZFM
	029CJcMlEl4cZJr38fouRMJB00CJD4FmilG1RrkT4PJBVNp+xHIClMJeUWLHD1Pw
	pe+HCIJ2E9ZX97Z0sPY8S6Xp/lAIfREGnOOdQG85fJxEuh81OhMYMfz5F958dWPQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx03dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:44:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q102pL020029;
	Wed, 26 Mar 2025 01:44:55 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j8hnx6pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:44:55 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52Q1itDY56557876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:44:55 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FEB05803F;
	Wed, 26 Mar 2025 01:44:55 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98A4258060;
	Wed, 26 Mar 2025 01:44:50 +0000 (GMT)
Received: from [9.43.87.161] (unknown [9.43.87.161])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 01:44:49 +0000 (GMT)
Message-ID: <554356f9-1672-4c15-a2f2-8cdc16042e3d@linux.ibm.com>
Date: Wed, 26 Mar 2025 07:14:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc64/ftrace: fix module loading without patchable
 function entries
To: Adam Williamson <awilliam@redhat.com>, Naveen N Rao <naveen@kernel.org>,
        Anthony Iliopoulos <ailiop@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        jforbes@redhat.com, kevin@scrye.com
References: <20250204231821.39140-1-ailiop@suse.com>
 <wlscshbqan2svtqkz5xc6v47tzndfnsvge7h4lbfn67zoplekl@elt2oxwhrp6f>
 <89748fc85c6ca477f64e1a5cc1852e74c68b493c.camel@redhat.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <89748fc85c6ca477f64e1a5cc1852e74c68b493c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yjTrq7dCbHb8NRRgYp4AfuJxyLr7MBpP
X-Proofpoint-ORIG-GUID: yjTrq7dCbHb8NRRgYp4AfuJxyLr7MBpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1011 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=914 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260004



On 3/26/25 6:46 AM, Adam Williamson wrote:
> On Thu, 2025-02-13 at 22:29 +0530, Naveen N Rao wrote:
>> On Wed, Feb 05, 2025 at 12:18:21AM +0100, Anthony Iliopoulos wrote:
>>> get_stubs_size assumes that there must always be at least one patchable
>>> function entry, which is not always the case (modules that export data
>>> but no code), otherwise it returns -ENOEXEC and thus the section header
>>> sh_size is set to that value. During module_memory_alloc() the size is
>>> passed to execmem_alloc() after being page-aligned and thus set to zero
>>> which will cause it to fail the allocation (and thus module loading) as
>>> __vmalloc_node_range() checks for zero-sized allocs and returns null:
>>>
>>> [  115.466896] module_64: cast_common: doesn't contain __patchable_function_entries.
>>> [  115.469189] ------------[ cut here ]------------
>>> [  115.469496] WARNING: CPU: 0 PID: 274 at mm/vmalloc.c:3778 __vmalloc_node_range_noprof+0x8b4/0x8f0
>>> ...
>>> [  115.478574] ---[ end trace 0000000000000000 ]---
>>> [  115.479545] execmem: unable to allocate memory
>>
>> Ugh, that's nasty.
>>
>>>
>>> Fix this by removing the check completely, since it is anyway not
>>> helpful to propagate this as an error upwards.
>>>
>>> Fixes: eec37961a56a ("powerpc64/ftrace: Move ftrace sequence out of line")
>>> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
>>> ---
>>>  arch/powerpc/kernel/module_64.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>
>> Thanks for fixing this. It might also be good to add a check in 
>> setup_ftrace_ool_stubs(). Something like this:
>>
>> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
>> index 34a5aec4908f..c10a9c66cfe3 100644
>> --- a/arch/powerpc/kernel/module_64.c
>> +++ b/arch/powerpc/kernel/module_64.c
>> @@ -1125,6 +1125,10 @@ static int setup_ftrace_ool_stubs(const Elf64_Shdr *sechdrs, unsigned long addr,
>>         unsigned int i, total_stubs, num_stubs;
>>         struct ppc64_stub_entry *stub;
>>  
>> +       /* Bail out early if no traceable functions */
>> +       if (!me->arch.ool_stub_count)
>> +               return 0;
>> +
>>         total_stubs = sechdrs[me->arch.stubs_section].sh_size / sizeof(*stub);
>>         num_stubs = roundup(me->arch.ool_stub_count * sizeof(struct ftrace_ool_stub),
>>                             sizeof(struct ppc64_stub_entry)) / sizeof(struct ppc64_stub_entry);
>>
>>
>> Regardless of that, for this patch:
>> Acked-by: Naveen N Rao (AMD) <naveen@kernel.org>
>>
>>
>> - Naveen
>>
> Is there anything that can be done to get this bumped along? It
> completely breaks networking on Fedora's power9 boxes, as it affects
> the i40e module which they use.
> 

Sorry missed this, Will pull it in.

Thanks.
Maddy

> Thanks!


