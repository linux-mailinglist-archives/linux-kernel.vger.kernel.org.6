Return-Path: <linux-kernel+bounces-561233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8077AA60F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F074F189ED85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B321F4C8C;
	Fri, 14 Mar 2025 10:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G59gc53B"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3441F4706
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948430; cv=none; b=sta9HjDU1ZFGtH+j8dM6r+WV472L6ZGV6dJki4QU4ZRbr6+fwfByPBwojh/JfmyGTzGsd7hCrYx7D4B01ymRcq3uKsmsXx4Z6yUlYSqdxzLktnVLH+5s6p21624n1tNtPoJJR7+ZeoqaatAjjJvF4HyQ/jzAazEwxEfr7bvx+KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948430; c=relaxed/simple;
	bh=aQLlXrttfK31I4nKtYJwsOtdyKxq7TTKsZlO1pCU+aU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IeQmipnxVKkdoDpg3e9epRfjRt4sz4BfUEunWfBiqYJCZfirSv0DpEoDGA3tVWeLU5BLAFVTrtGMovJa0qjdVL7v/fo11FrkFM2RCrQc/okEOlW64TnU4Imln0dbtJOiyWUCvrfW/N/s9SojZaaeDUFie3EvroaBGA8N+HIWUEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G59gc53B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPAP6032478;
	Fri, 14 Mar 2025 10:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zehx15
	J+Iu9s0WruS0o895sbHmnpA1v5UGFy+CYZIYs=; b=G59gc53BK418TbwPRKEUVX
	hlWSymuhEc/i9H6i5B8k/7oTfRhi5yp5RjpCdTCH8zZSSmoUsHSixysIsgqFQHft
	sPAXuSvYlJE9gENlcfob8tLkXol3pBx9fVkTrb6CHZcpl/h+nxz0FXWnhtBC5uCf
	WRdd/2DDZQUG+Hln4+vsfLFlOeBgsST0kNge4p4T0VxPpI6YmgwoQOXY+1to2qHI
	Z0+bDbsf+BKI2KMRpvGE4h6aqUFlsNQ+LtM78NgHsx7PBWVBzWhux/YHGpSWsU7n
	MMEHbiGRZryhJZmJMiEPt7PtoiPm3N4kxtn02/tsjyI39bnlDZbwzg8gagsOgAUA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpu4sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 10:33:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EAV1gT022665;
	Fri, 14 Mar 2025 10:33:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6hpu4se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 10:33:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8WSwZ015357;
	Fri, 14 Mar 2025 10:33:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atsppfwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 10:33:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EAXOVt46268764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 10:33:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3B7E20043;
	Fri, 14 Mar 2025 10:33:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13F2D2004E;
	Fri, 14 Mar 2025 10:33:22 +0000 (GMT)
Received: from [9.39.22.126] (unknown [9.39.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 10:33:21 +0000 (GMT)
Message-ID: <cb0c10be-2c86-4b14-9f2b-5e00e4d8ae4d@linux.ibm.com>
Date: Fri, 14 Mar 2025 16:03:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] powerpc: powenv: oxcl: use lock guard for mutex
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: ajd@linux.ibm.com
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        peterz@infradead.org, fbarrat@linux.ibm.com, mahesh@linux.ibm.com,
        oohall@gmail.com, hbathini@linux.ibm.com, dhowells@redhat.com,
        haren@linux.ibm.com, linux-kernel@vger.kernel.org, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
 <20250314054544.1998928-6-sshegde@linux.ibm.com>
 <d6999d74-45f6-413a-8881-90473b322dfa@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <d6999d74-45f6-413a-8881-90473b322dfa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IgaT5YasunpTLXjhRCLnVAvnQ9Mh7IHA
X-Proofpoint-ORIG-GUID: F-LiitUIB4IY-Iw_HplT5YqSh7kdHWj1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140082



On 3/14/25 15:00, Shrikanth Hegde wrote:
> 
> 
> On 3/14/25 11:15, Shrikanth Hegde wrote:
>> use guard(mutex) for scope based resource management of mutex.
>> This would make the code simpler and easier to maintain.
>>
>> More details on lock guards can be found at
>> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
>>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/ocxl.c | 12 +++---------
>>   1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/ 
>> platforms/powernv/ocxl.c
>> index 64a9c7125c29..f8139948348e 100644
>> --- a/arch/powerpc/platforms/powernv/ocxl.c
>> +++ b/arch/powerpc/platforms/powernv/ocxl.c
>> @@ -172,12 +172,11 @@ static void pnv_ocxl_fixup_actag(struct pci_dev 
>> *dev)
>>       if (phb->type != PNV_PHB_NPU_OCAPI)
>>           return;
>> -    mutex_lock(&links_list_lock);
>> +    guard(mutex)(&links_list_lock);
>>       link = find_link(dev);
>>       if (!link) {
>>           dev_warn(&dev->dev, "couldn't update actag information\n");
>> -        mutex_unlock(&links_list_lock);
>>           return;
>>       }
>> @@ -206,7 +205,6 @@ static void pnv_ocxl_fixup_actag(struct pci_dev *dev)
>>       dev_dbg(&dev->dev, "total actags for function: %d\n",
>>           link->fn_desired_actags[PCI_FUNC(dev->devfn)]);
>> -    mutex_unlock(&links_list_lock);
>>   }
>>   DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_ocxl_fixup_actag);
>> @@ -253,12 +251,11 @@ int pnv_ocxl_get_actag(struct pci_dev *dev, u16 
>> *base, u16 *enabled,
>>   {
>>       struct npu_link *link;
>> -    mutex_lock(&links_list_lock);
>> +    guard(mutex)(&links_list_lock);
>>       link = find_link(dev);
>>       if (!link) {
>>           dev_err(&dev->dev, "actag information not found\n");
>> -        mutex_unlock(&links_list_lock);
>>           return -ENODEV;
>>       }
>>       /*
>> @@ -274,7 +271,6 @@ int pnv_ocxl_get_actag(struct pci_dev *dev, u16 
>> *base, u16 *enabled,
>>       *enabled   = link->fn_actags[PCI_FUNC(dev->devfn)].count;
>>       *supported = link->fn_desired_actags[PCI_FUNC(dev->devfn)];
>> -    mutex_unlock(&links_list_lock);
>>       return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(pnv_ocxl_get_actag);
>> @@ -293,12 +289,11 @@ int pnv_ocxl_get_pasid_count(struct pci_dev 
>> *dev, int *count)
>>        *
>>        * We only support one AFU-carrying function for now.
>>        */
>> -    mutex_lock(&links_list_lock);
>> +    guard(mutex)(&links_list_lock);
>>       link = find_link(dev);
>>       if (!link) {
>>           dev_err(&dev->dev, "actag information not found\n");
>> -        mutex_unlock(&links_list_lock);
>>           return -ENODEV;
>>       }
>> @@ -309,7 +304,6 @@ int pnv_ocxl_get_pasid_count(struct pci_dev *dev, 
>> int *count)
>>               break;
>>           }
>> -    mutex_unlock(&links_list_lock);
> 
> Hi. Andrew,
> 
> After this change below dev_dbg will be called with mutex held still. Is 
> that a concern? I don't see the mutex being used in that path.
> 
> Since using scoped_guard cause more code churn here, I would prefer not 
> use it.

I see current code in pnv_ocxl_fixup_actag calls dev_dbg with mutex 
held. So likely not a concern of using just guard in 
pnv_ocxl_get_pasid_count as well.

Assuming that, let me send out v2 with corrected commit subject. :w

> 
>>       dev_dbg(&dev->dev, "%d PASIDs available for function\n",
>>           rc ? 0 : *count);
>>       return rc;
> 


