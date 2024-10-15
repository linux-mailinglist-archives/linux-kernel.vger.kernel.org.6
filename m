Return-Path: <linux-kernel+bounces-365968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869BD99EEB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F76A1C20D01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4737C1B2181;
	Tue, 15 Oct 2024 14:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNLHZLOv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C81AF0BD
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001203; cv=none; b=pxG9b05GR8L+a96JXSVdJspTzW3EI891tuXhpxJhz7XZzdeOg4ITrD+IU08TPUVXZSBKDO27qV/LgPVLEKFL7ktSMqEIc0JWUJLQ9xHnxt9jMebDhVxSj/0fpseLJZREHZD4VjToUarYPagXe6eGw+CFVDAqlrD+d1p1K7vpHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001203; c=relaxed/simple;
	bh=OtrGYsfKC47Q0hBoTW0JIkoS/civsTby1IFy3GXGV/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuZ7J7abMwlcfXdnvN8hI5FmDPTdA9m/koma0Rx3dp/U3rQVZ/V5LftRka2rHmv4Y5vygINK7ob/Q7XRu+JEK22wAmJjbTt0G5h+uPfQ0g701GHGimCrBEKX2SF4Otbikk9+dal6rNUGj1joaKikdEqSZ+jLP4XeO5wukdF/Zk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNLHZLOv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCOVKb011338;
	Tue, 15 Oct 2024 14:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gAMkFu
	urSKWsXKkavscpUQu+wnifZHhrSt0CodqSyYs=; b=rNLHZLOvukuSpUg1Ekt2fL
	nRFDj/FaYoew1FNr1Vq1VOwz2ihwX4dG+Be8Xhrd5c+rLJQ38kbSdFVyYX09g8bO
	15WqJL1CRzwgCeMKYy/3lCLrLuBRD2NptjwV3LJMIUXammT3VMeV/+C93Il7/GQ1
	6gR1pHl6Z5TJDoYXl8lxc2Oy1cqxAgr78Sncntxj8dlqUp3PI9QKbn0rDCtSqASP
	C7aWR/nwgan5G+Ba+yTIDShhDtKyh/1y01wAAR7tBtfNOHHhm2FYLMXJhP2N6r4Q
	oD9HpHLlXkCSjwsXVDAdHHAuRGiIq5qupwpO1NBiADFe0IFwYv8ouNFqibj1FUtA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rcerhuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:06:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49FE6OFp002259;
	Tue, 15 Oct 2024 14:06:24 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429rcerhu8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:06:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49FCFxle004988;
	Tue, 15 Oct 2024 14:06:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj3xsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:06:23 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49FE6Mwn44368244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 14:06:22 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C870958060;
	Tue, 15 Oct 2024 14:06:22 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B02258051;
	Tue, 15 Oct 2024 14:06:15 +0000 (GMT)
Received: from [9.43.42.92] (unknown [9.43.42.92])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 14:06:14 +0000 (GMT)
Message-ID: <7ae152f0-1887-4862-9173-fe2e9914dbe6@linux.ibm.com>
Date: Tue, 15 Oct 2024 19:36:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 3/3] fadump: Move fadump_cma_init to setup_arch() after
 initmem_init()
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
 <759d0fc37d9fedca6cfe78ea7061447ecbf1bc77.1728658614.git.ritesh.list@gmail.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <759d0fc37d9fedca6cfe78ea7061447ecbf1bc77.1728658614.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OrYDgTtVNxs83JroPRt-Qzl2IJZxzi09
X-Proofpoint-ORIG-GUID: yqy2g7rGIy8HZ1kHEvg7rlWCG3Zm2J3P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 phishscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150094



On 10/11/24 8:30 PM, Ritesh Harjani (IBM) wrote:
> During early init CMA_MIN_ALIGNMENT_BYTES can be PAGE_SIZE,
> since pageblock_order is still zero and it gets initialized
> later during initmem_init() e.g.
> setup_arch() -> initmem_init() -> sparse_init() -> set_pageblock_order()
> 
> One such use case where this causes issues is -
> early_setup() -> early_init_devtree() -> fadump_reserve_mem() -> fadump_cma_init()
> 
> This causes CMA memory alignment check to be bypassed in
> cma_init_reserved_mem(). Then later cma_activate_area() can hit
> a VM_BUG_ON_PAGE(pfn & ((1 << order) - 1)) if the reserved memory
> area was not pageblock_order aligned.
> 
> Fix it by moving the fadump_cma_init() after initmem_init(),
> where other such cma reservations also gets called.
> 
> <stack trace>
> ==============
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10010
> flags: 0x13ffff800000000(node=1|zone=0|lastcpupid=0x7ffff) CMA
> raw: 013ffff800000000 5deadbeef0000100 5deadbeef0000122 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: VM_BUG_ON_PAGE(pfn & ((1 << order) - 1))
> ------------[ cut here ]------------
> kernel BUG at mm/page_alloc.c:778!
> 
> Call Trace:
> __free_one_page+0x57c/0x7b0 (unreliable)
> free_pcppages_bulk+0x1a8/0x2c8
> free_unref_page_commit+0x3d4/0x4e4
> free_unref_page+0x458/0x6d0
> init_cma_reserved_pageblock+0x114/0x198
> cma_init_reserved_areas+0x270/0x3e0
> do_one_initcall+0x80/0x2f8
> kernel_init_freeable+0x33c/0x530
> kernel_init+0x34/0x26c
> ret_from_kernel_user_thread+0x14/0x1c
> 

Changes looks fine to me.
Reviewed-by: Madhavan Srinivasan <maddy@linux.ibm.com>

> Fixes: 11ac3e87ce09 ("mm: cma: use pageblock_order as the single alignment")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reported-by: Sachin P Bappalige <sachinpb@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/include/asm/fadump.h  | 7 +++++++
>  arch/powerpc/kernel/fadump.c       | 6 +-----
>  arch/powerpc/kernel/setup-common.c | 6 ++++--
>  3 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/fadump.h
> index ef40c9b6972a..3638f04447f5 100644
> --- a/arch/powerpc/include/asm/fadump.h
> +++ b/arch/powerpc/include/asm/fadump.h
> @@ -34,4 +34,11 @@ extern int early_init_dt_scan_fw_dump(unsigned long node, const char *uname,
>  				      int depth, void *data);
>  extern int fadump_reserve_mem(void);
>  #endif
> +
> +#if defined(CONFIG_FA_DUMP) && defined(CONFIG_CMA)
> +void fadump_cma_init(void);
> +#else
> +static inline void fadump_cma_init(void) { }
> +#endif
> +
>  #endif /* _ASM_POWERPC_FADUMP_H */
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index ffaec625b7a8..c42f89862893 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -78,7 +78,7 @@ static struct cma *fadump_cma;
>   * But for some reason even if it fails we still have the memory reservation
>   * with us and we can still continue doing fadump.
>   */
> -static void __init fadump_cma_init(void)
> +void __init fadump_cma_init(void)
>  {
>  	unsigned long long base, size, end;
>  	int rc;
> @@ -139,8 +139,6 @@ static void __init fadump_cma_init(void)
>  		fw_dump.boot_memory_size >> 20);
>  	return;
>  }
> -#else
> -static void __init fadump_cma_init(void) { }
>  #endif /* CONFIG_CMA */
>  
>  /*
> @@ -642,8 +640,6 @@ int __init fadump_reserve_mem(void)
>  
>  		pr_info("Reserved %lldMB of memory at %#016llx (System RAM: %lldMB)\n",
>  			(size >> 20), base, (memblock_phys_mem_size() >> 20));
> -
> -		fadump_cma_init();
>  	}
>  
>  	return ret;
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 4bd2f87616ba..9f1e6f2e299e 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -996,9 +996,11 @@ void __init setup_arch(char **cmdline_p)
>  	initmem_init();
>  
>  	/*
> -	 * Reserve large chunks of memory for use by CMA for KVM and hugetlb. These must
> -	 * be called after initmem_init(), so that pageblock_order is initialised.
> +	 * Reserve large chunks of memory for use by CMA for fadump, KVM and
> +	 * hugetlb. These must be called after initmem_init(), so that
> +	 * pageblock_order is initialised.
>  	 */
> +	fadump_cma_init();
>  	kvm_cma_reserve();
>  	gigantic_hugetlb_cma_reserve();
>  


