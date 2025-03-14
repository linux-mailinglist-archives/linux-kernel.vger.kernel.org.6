Return-Path: <linux-kernel+bounces-561080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1325A60D52
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8326E19C3A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E0C19DF61;
	Fri, 14 Mar 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lczH0/RB"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4B126BF9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944643; cv=none; b=Ci682MRBBcZOyS0f4F30PeujkzXFQRF/JnSWWlMBGmS/zKmYttwNp/T5UA1dH2+wlkOC8CjcMj73KOkyobYT5O53wz2rBlvLFTrh1BShES1VTTRKxbgq50n4kWBvM4yNDZiJjtk+0Puebc31glzCDgwd+ODD/DCKc1byu1OcwhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944643; c=relaxed/simple;
	bh=CpCHinGXPXa+xJsSfA/4BlUzu7FAdnL8SVZ+x2ezFHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eb8+FEvq1MLbaihDNXXeNcVcCmN182mF0jCtCKR/L7E6OvRyE8w6iL3leum24zlza2bNO98C7gB/u+YecvPkN6JrPUFUqNe+YPAKekmldDRxevkCA8ypS6cgytxxKqKdDzeALtWxNn4vEqV8yyyRE2tHB+b3GM2mFAXZQwHJjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lczH0/RB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E3joJe019686;
	Fri, 14 Mar 2025 09:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0z9Fz6
	11KVkxjRCjoMRWDKqzm00u/P597760U7VRVFc=; b=lczH0/RBAoP3ow5/eGx7Wh
	vFl6rjx/VeV2hLnBTUzXiksLl6Eqb7hsX1IgnYKxTzU3JWnKEl8Wvt7RM+YSbxhM
	D3E/9B4xFNwcMs/7SYhcGEvZE1k5DeW5sZc4TpOP/Qpnzv0VwgsoIvcAklzRGmZI
	PYV3DbgcdbNn81rbE6utg0twiX8/c1iIGkCyMQkYaLB6PQBw7VKVjA9maeDE5bAH
	H2M7ZgV1C+Bg/Bnj6LLY/2RM/8Y+uvxUJ39g9c/IKTxP3hN56b6+6cv6GmLQmU60
	lsa3d1LCoH8Ec6MKiV5ybEIbAQSlh2bmvQj2FVKXf2xmYmE7jNh4ECK0xl67fJkA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ccu99d8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:30:26 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E9R3KJ021389;
	Fri, 14 Mar 2025 09:30:25 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ccu99d89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:30:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8F9at026047;
	Fri, 14 Mar 2025 09:30:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspp9g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 09:30:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E9UKuu33882844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 09:30:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADB372004E;
	Fri, 14 Mar 2025 09:30:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB27C2004B;
	Fri, 14 Mar 2025 09:30:17 +0000 (GMT)
Received: from [9.39.22.126] (unknown [9.39.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 09:30:17 +0000 (GMT)
Message-ID: <d6999d74-45f6-413a-8881-90473b322dfa@linux.ibm.com>
Date: Fri, 14 Mar 2025 15:00:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] powerpc: powenv: oxcl: use lock guard for mutex
To: ajd@linux.ibm.com
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        peterz@infradead.org, fbarrat@linux.ibm.com, mahesh@linux.ibm.com,
        oohall@gmail.com, hbathini@linux.ibm.com, dhowells@redhat.com,
        haren@linux.ibm.com, linux-kernel@vger.kernel.org, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
 <20250314054544.1998928-6-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250314054544.1998928-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h0Cja2C6vajM78wzlm82GdfRq8oqmFfd
X-Proofpoint-GUID: ZvhqgWL-NRe9f7ZJNClqRDnR7vkRLAgP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=852 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140071



On 3/14/25 11:15, Shrikanth Hegde wrote:
> use guard(mutex) for scope based resource management of mutex.
> This would make the code simpler and easier to maintain.
> 
> More details on lock guards can be found at
> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
> 
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/ocxl.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
> index 64a9c7125c29..f8139948348e 100644
> --- a/arch/powerpc/platforms/powernv/ocxl.c
> +++ b/arch/powerpc/platforms/powernv/ocxl.c
> @@ -172,12 +172,11 @@ static void pnv_ocxl_fixup_actag(struct pci_dev *dev)
>   	if (phb->type != PNV_PHB_NPU_OCAPI)
>   		return;
>   
> -	mutex_lock(&links_list_lock);
> +	guard(mutex)(&links_list_lock);
>   
>   	link = find_link(dev);
>   	if (!link) {
>   		dev_warn(&dev->dev, "couldn't update actag information\n");
> -		mutex_unlock(&links_list_lock);
>   		return;
>   	}
>   
> @@ -206,7 +205,6 @@ static void pnv_ocxl_fixup_actag(struct pci_dev *dev)
>   	dev_dbg(&dev->dev, "total actags for function: %d\n",
>   		link->fn_desired_actags[PCI_FUNC(dev->devfn)]);
>   
> -	mutex_unlock(&links_list_lock);
>   }
>   DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_ocxl_fixup_actag);
>   
> @@ -253,12 +251,11 @@ int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
>   {
>   	struct npu_link *link;
>   
> -	mutex_lock(&links_list_lock);
> +	guard(mutex)(&links_list_lock);
>   
>   	link = find_link(dev);
>   	if (!link) {
>   		dev_err(&dev->dev, "actag information not found\n");
> -		mutex_unlock(&links_list_lock);
>   		return -ENODEV;
>   	}
>   	/*
> @@ -274,7 +271,6 @@ int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
>   	*enabled   = link->fn_actags[PCI_FUNC(dev->devfn)].count;
>   	*supported = link->fn_desired_actags[PCI_FUNC(dev->devfn)];
>   
> -	mutex_unlock(&links_list_lock);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(pnv_ocxl_get_actag);
> @@ -293,12 +289,11 @@ int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count)
>   	 *
>   	 * We only support one AFU-carrying function for now.
>   	 */
> -	mutex_lock(&links_list_lock);
> +	guard(mutex)(&links_list_lock);
>   
>   	link = find_link(dev);
>   	if (!link) {
>   		dev_err(&dev->dev, "actag information not found\n");
> -		mutex_unlock(&links_list_lock);
>   		return -ENODEV;
>   	}
>   
> @@ -309,7 +304,6 @@ int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count)
>   			break;
>   		}
>   
> -	mutex_unlock(&links_list_lock);

Hi. Andrew,

After this change below dev_dbg will be called with mutex held still. Is 
that a concern? I don't see the mutex being used in that path.

Since using scoped_guard cause more code churn here, I would prefer not 
use it.

>   	dev_dbg(&dev->dev, "%d PASIDs available for function\n",
>   		rc ? 0 : *count);
>   	return rc;


