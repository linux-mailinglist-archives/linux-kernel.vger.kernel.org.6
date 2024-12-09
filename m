Return-Path: <linux-kernel+bounces-436818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AF19E8B51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 220B11619E3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39272101A9;
	Mon,  9 Dec 2024 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XW0tSkW2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7986214AD0E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724278; cv=none; b=lDOlNyhKldZi4fHyx8ujTnc8sDHZcsrfOC7B2eifmgt9rEY5Wc9dym3mOxWQTYGd4Q8Lt/NN3aN9iDEshJISSUxbXXa4rbBNlYbktc38IMLs9XekUbkO9zsY+vWKkLt7TO6SF/huAXGeFEKWCjv6G3LtJfzKO8vy2ZJJ0piGJvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724278; c=relaxed/simple;
	bh=+s89du2I1O3eK1vO8Djp2gewKb7jhzOlLNNNkiSKQhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tB+GpaKez44dXOrqZYx24Jv3FLSewU/i6L5QooHERTRAAoPAq6xImR/CN0tWnV6/0CU098bfyA00RFvBbz7hcNh08wC0+ZbYob9KOioJ98HQWzosmb+tMirUr4Jo3qYIZAr1O8lL4eQhheaMFkajzYRkvfGcYBv/jM4YJSJbstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XW0tSkW2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8NYlwF019615;
	Mon, 9 Dec 2024 06:04:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Hk53dlOnxFhT175Tc9odzckpkKVFY8lcT0L264X/Vo=; b=XW0tSkW2BirxZJ4c
	BKX1M8OCmbGQ8HcC/xn2gxe0uz98f9M7iMekT/TRMGkdrS6DbPmNL1iUnnUDu6tS
	+C1yGR5nq9cTRcBfgZcZbn/p8SLOQR7yHVSntjEy3r9iTevwbrrLpON32DqtP8ss
	+JrMKsQhhznHR33kiFyE6YhCTuCreP0gbjyrq1x/ROydVs+8aKWczG/EyFrWEGpe
	/9dK0EOp7EtBTtGu4R87Ydi4urwEgQDNaRM2LRSOR6wlam0UGDSslqnyu4M5rUAj
	M8Zp/rYG8ASD99L/GxV0v9OiFuGc8qdV8bWm+GhhcLDWDmFZqsHE1qeAS19VK5w5
	mQGn0g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cek1ug9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 06:04:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B964Haf026792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 06:04:17 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 22:04:13 -0800
Message-ID: <fe47b1ad-b1e7-4f26-8973-f3c8568e15b8@quicinc.com>
Date: Mon, 9 Dec 2024 14:04:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: mm: vmemmap populate to page level if not
 section aligned
To: Catalin Marinas <catalin.marinas@arm.com>
CC: <will@kernel.org>, <ardb@kernel.org>, <ryan.roberts@arm.com>,
        <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>
References: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
 <20241121071256.487220-2-quic_zhenhuah@quicinc.com>
 <Z1Mwo5OajFZQYlOg@arm.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <Z1Mwo5OajFZQYlOg@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gzo9auymSZHfx25bjhj8O0q5nRMo4w0N
X-Proofpoint-ORIG-GUID: gzo9auymSZHfx25bjhj8O0q5nRMo4w0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090048

Thanks Catalin for review!

On 2024/12/7 1:13, Catalin Marinas wrote:
> On Thu, Nov 21, 2024 at 03:12:55PM +0800, Zhenhua Huang wrote:
>> Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
>> optimizes the vmemmap to populate at the PMD section level.
> 
> Wasn't the above commit just a non-functional change making the code
> generic? If there was a functional change, it needs to be spelt out. It
> also implies that the code prior to the above commit needs fixing.
> 

Oh... right. I looked up your change from over a decade ago, identified 
by commit c1cc1552616d ("arm64: MMU initialisation").
However, at that time, there was no support for subsection hotplug, 
which was later introduced by commit ba72b4c8cf60 ("mm/sparsemem: 
support sub-section hotplug").

>> However, if start
>> or end is not aligned to a section boundary, such as when a subsection is hot
>> added, populating the entire section is inefficient and wasteful. In such
>> cases, it is more effective to populate at page granularity.
> 
> Do you have any numbers to show how inefficient it is? We trade some
> memory for less TLB pressure by using huge pages for vmemmap.

I see.. thanks, yeah. TLB efficiency will benefit.
I want to express even one subsection hot-added, current code logic 
still populate 2M backup metadata, although only 2M/64 = 32K needs.

> 
>> This change also addresses misalignment issues during vmemmap_free(). When
>> pmd_sect() is true, the entire PMD section is cleared, even if only a
>> subsection is mapped. For example, if subsections pagemap1 and pagemap2 are
>> added sequentially and then pagemap1 is removed, vmemmap_free() will clear the
>> entire PMD section, even though pagemap2 is still active.
> 
> What do you mean by a PMD section? The whole PAGE_SIZE *
> PAGES_PER_SECTION range or a single pmd entry? I couldn't see how the

I am referring to a single pmd entry, but the buffer it points to manage 
whole PAGE_SIZE * PAGES_PER_SECTION physical memory. for arm64,4K pages:
pmd entry(2M, struct page metadata) -> PAGE_SIZE * 
PAGES_PER_SECTION(128M physical memory)

pagemap1(Where a subsection equals to 2M/64 = 32K) and pagemap2 are part 
of a single PMD entry. When pagemap1 is removed, vmemmap_free() will 
clear the entire PMD section. IOW, total 128M physical memory will 
become unusable.

> former happens in the core code but I only looked briefly. If it's just
> a pmd entry, I think it's fair to require a 2MB alignment of hotplugged
> memory ranges.

Agree that 2MB alignment of hotplugged memory is fair, commit 
ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug") supported it. 
The issue here I want to address is for its backup struct page metadata.

> 


