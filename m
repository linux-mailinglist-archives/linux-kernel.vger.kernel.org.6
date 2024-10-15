Return-Path: <linux-kernel+bounces-365678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9EB99E5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9652284D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3AE15099D;
	Tue, 15 Oct 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G4UrvigG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C0B1E7669
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992084; cv=none; b=sLQWuxyAT/ua+v/qTOH2w+Uf7DhOVF4ufQ9S0tZeLK+KdqS3UZeKNBfyT42JP+irLR1Mc/dRTKFTla70SgknHwjWLkDPLtgDkmYxX0pR37mHxp2ymFp5ru0pqqNm8Qh0o2LbWCp+2TcYokzMVg1jUTMGkao+Hlb5D02nMeMGCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992084; c=relaxed/simple;
	bh=u4eFcPXrv7bXt4JZS1E9NN0bFa4UqBT7cXhxcwTz8Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/2IXmEnCJo3XySSi5OGV2vOIJnFTXaxIxwjOfQL3aMYiPz9GPqH1LQAzYtyZLeIJII1oQVRzp6rx4l3hGGoYO65jrorWpAjcROYAJnYeTUk8cnUl12v6hjAlJJP3uo/ZPuQfAJydJU5HeRMqPcHko/Z7MiOcSgxwbqkfbdF/8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G4UrvigG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FAtf86013475;
	Tue, 15 Oct 2024 11:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c69cTs
	lBIDcPA3cDCJjH6VoeJG0oJsXagvXewdckmtc=; b=G4UrvigGVysgYqKyXGpbIl
	4oqWnPInuHUpNReoBb9tJ2k3JG6oW9X0rl6wKVRec6RJY7T+kPADWfsMlT1olu6s
	a8WLeP47EpJdTJ+SI6Wx7FEqFivxaMRytzqOX32DAVmEP3xeRmy+pdUocRojmBep
	/IQU2FfUG7t9gEAh5+rFWTB+NgBQZVB8emWFis9PPgnjiyX/D6ICpE1FcRHQTf4p
	IskOSf8QdEsAh/xNBS7pJ3ejYK6NMib3qRcgrrH55xKF0XUe2Jr9t3KmuXnHmv2F
	Y0Bty/zZnP8yJcH6jkVz+mZPRm3AZbZqiOSYHlF1yaESvsOd/tOJWvhi4VdV7Zzg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q2fg5sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:34:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FBV2Q7005449;
	Tue, 15 Oct 2024 11:34:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429q2fg5sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:34:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FB7sAT027464;
	Tue, 15 Oct 2024 11:34:22 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283txkkrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 11:34:22 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FBYLbw24183534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 11:34:21 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DB4858064;
	Tue, 15 Oct 2024 11:34:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F5415803F;
	Tue, 15 Oct 2024 11:34:13 +0000 (GMT)
Received: from [9.43.1.152] (unknown [9.43.1.152])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 11:34:12 +0000 (GMT)
Message-ID: <96241074-7b78-4b7a-a539-ef8a1055c198@linux.ibm.com>
Date: Tue, 15 Oct 2024 17:04:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/3] fadump: Reserve page-aligned boot_memory_size during
 fadump_reserve_mem
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
 <32496f6daeb4ed04c772ae484895241ab2ae1da1.1728658614.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <32496f6daeb4ed04c772ae484895241ab2ae1da1.1728658614.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SLW9cavwMcq6r2LFyWJAefiDDSWm_ram
X-Proofpoint-GUID: 4sJHYHgueqtmFBC4Se70VM021ToNv91C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150078



On 10/11/24 8:30 PM, Ritesh Harjani (IBM) wrote:
> This patch refactors all CMA related initialization and alignment code
> to within fadump_cma_init() which gets called in the end. This also means
> that we keep [reserve_dump_area_start, boot_memory_size] page aligned
> during fadump_reserve_mem(). Then later in fadump_cma_init() we extract the
> aligned chunk and provide it to CMA. This inherently also fixes an issue in
> the current code where the reserve_dump_area_start is not aligned
> when the physical memory can have holes and the suitable chunk starts at
> an unaligned boundary.
> 
> After this we should be able to call fadump_cma_init() independently
> later in setup_arch() where pageblock_order is non-zero.
> 
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/kernel/fadump.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 162327d66982..ffaec625b7a8 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -80,7 +80,7 @@ static struct cma *fadump_cma;
>   */
>  static void __init fadump_cma_init(void)
>  {
> -	unsigned long long base, size;
> +	unsigned long long base, size, end;
>  	int rc;
>  
>  	if (!fw_dump.fadump_supported || !fw_dump.fadump_enabled ||
> @@ -92,8 +92,24 @@ static void __init fadump_cma_init(void)
>  	if (fw_dump.nocma || !fw_dump.boot_memory_size)
>  		return;
>  
> +	/*
> +	 * [base, end) should be reserved during early init in
> +	 * fadump_reserve_mem(). No need to check this here as
> +	 * cma_init_reserved_mem() already checks for overlap.
> +	 * Here we give the aligned chunk of this reserved memory to CMA.
> +	 */
>  	base = fw_dump.reserve_dump_area_start;
>  	size = fw_dump.boot_memory_size;
> +	end = base + size;
> +
> +	base = ALIGN(base, CMA_MIN_ALIGNMENT_BYTES);
> +	end = ALIGN_DOWN(end, CMA_MIN_ALIGNMENT_BYTES);
> +	size = end - base;
> +
> +	if (end <= base) {
> +		pr_warn("%s: Too less memory to give to CMA\n", __func__);
> +		return;
> +	}
>  

just minor, other prints are all "cma", any reason for "CMA" here?


>  	rc = cma_init_reserved_mem(base, size, 0, "fadump_cma", &fadump_cma);
>  	if (rc) {
> @@ -116,11 +132,12 @@ static void __init fadump_cma_init(void)
>  	/*
>  	 * So we now have successfully initialized cma area for fadump.
>  	 */
> -	pr_info("Initialized 0x%lx bytes cma area at %ldMB from 0x%lx "
> +	pr_info("Initialized [0x%llx, %luMB] cma area from [0x%lx, %luMB] "
>  		"bytes of memory reserved for firmware-assisted dump\n",
> -		cma_get_size(fadump_cma),
> -		(unsigned long)cma_get_base(fadump_cma) >> 20,
> -		fw_dump.reserve_dump_area_size);
> +		cma_get_base(fadump_cma), cma_get_size(fadump_cma) >> 20,
> +		fw_dump.reserve_dump_area_start,
> +		fw_dump.boot_memory_size >> 20);
> +	return;
>  }
>  #else
>  static void __init fadump_cma_init(void) { }
> @@ -553,13 +570,6 @@ int __init fadump_reserve_mem(void)
>  	if (!fw_dump.dump_active) {
>  		fw_dump.boot_memory_size =
>  			PAGE_ALIGN(fadump_calculate_reserve_size());
> -#ifdef CONFIG_CMA
> -		if (!fw_dump.nocma) {
> -			fw_dump.boot_memory_size =
> -				ALIGN(fw_dump.boot_memory_size,
> -				      CMA_MIN_ALIGNMENT_BYTES);
> -		}
> -#endif
>  
>  		bootmem_min = fw_dump.ops->fadump_get_bootmem_min();
>  		if (fw_dump.boot_memory_size < bootmem_min) {


