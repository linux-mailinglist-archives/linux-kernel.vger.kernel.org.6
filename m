Return-Path: <linux-kernel+bounces-319373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6C796FBB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5881F2B29E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B99F1D2F4F;
	Fri,  6 Sep 2024 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nGzoBhte"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F081CDFB9;
	Fri,  6 Sep 2024 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649262; cv=none; b=kl1/ubir4z6BiAC74Yz3lBGoMrHVnGTf0QOtVgE+Sihv34UcdsbQyNviv7WKWZMVd8jSutgFlk0CKPu1+XhdPoSzZdSkdi38iPQpCrbfaG45S1ocIaUk6qvspU8dND4cpR/kHCchb87kEy6T2B5FDaiU9drPm99frg7f++EBong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649262; c=relaxed/simple;
	bh=MBheYMgkA5qGpwmU72DCTMjWh7V1mZEzokLZpE93+4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cu0+wgb5kzkSqRLssRrgM7JYMEtPjXmJr3f8N3cWaNIBhKIv21KuwTZiuD4oaD+N+4skUDk61OgGZDL/ZtOweKl5dVAwhGd7h/Gz53Yl/pBS8of+n8ugP8kuHYAxNHw6pgbPLnqpoVSp8etGhIsZsN64DdNFv57lGr/NG1WgGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nGzoBhte; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4869FtIG024728;
	Fri, 6 Sep 2024 19:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3B/B/jEjj7A2SnkMh/OmdNNfCMBlWqRybVMMKu3/DtU=; b=nGzoBhteWSSAFO4p
	l1MVcjHR7W7Kg7vYA3SMj2S90AEhk0NQWYQ435/lelZPEqckSsnnqpIGkH7ljIx/
	AfdBWc7JAahHD9hvDTr4QgwD1t/VrPCMQs/Z3CsslyJkxFo46W0zEiZAqHuylD0i
	c3GANKeChYi64TFFpa++4+Nv8V1gkcNNg+WDSVYCY8twzxsFNsbyRm7KZcn02tqk
	N6IqOq3OfgzU/gFnXkRYllDudVKgf9KWwP8lUlGCI1qdEWZWJzAc2Qksiehbdr+O
	nzj0WEKu8jFQNh0c4nEWababK9M0lmI2trCwFDC8VhR2vIgk+sc0+OqkbOX0jLTR
	hT2awA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fj03b41h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 19:00:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 486J0RVe032434
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 19:00:27 GMT
Received: from [10.110.5.155] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Sep 2024
 12:00:23 -0700
Message-ID: <fad80ac4-0be4-410e-bd58-9a086f356c74@quicinc.com>
Date: Fri, 6 Sep 2024 12:00:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] Dynamic Allocation of the reserved_mem array
To: Aisheng Dong <aisheng.dong@nxp.com>, "robh@kernel.org" <robh@kernel.org>
CC: "andy@black.fi.intel.com" <andy@black.fi.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "hch@lst.de"
	<hch@lst.de>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        "klarasmodin@gmail.com"
	<klarasmodin@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "saravanak@google.com" <saravanak@google.com>,
        "will@kernel.org"
	<will@kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jacky Bai
	<ping.bai@nxp.com>, Pengfei Li <pengfei.li_1@nxp.com>
References: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
 <DU0PR04MB92999E9EEE959DBC3B1EAB6E80932@DU0PR04MB9299.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <DU0PR04MB92999E9EEE959DBC3B1EAB6E80932@DU0PR04MB9299.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C5RgBfe-gd83bwBlLU-hjEN6NJ7TH8Ql
X-Proofpoint-ORIG-GUID: C5RgBfe-gd83bwBlLU-hjEN6NJ7TH8Ql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_04,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409060140


On 9/3/2024 1:56 AM, Aisheng Dong wrote:
>> From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
>> Sent: 2024年8月31日 0:29
>> Subject: [PATCH v8 0/2] Dynamic Allocation of the reserved_mem array
>>
>> The reserved_mem array is used to store data for the different reserved
>> memory regions defined in the DT of a device.  The array stores information
>> such as region name, node reference, start-address, and size of the different
>> reserved memory regions.
>>
>> The array is currently statically allocated with a size of
>> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
>> number of reserved memory regions greater than
>> MAX_RESERVED_REGIONS(64) will not have enough space to store the
>> information for all the regions.
>>
>> This can be fixed by making the reserved_mem array a dynamically sized array
>> which is allocated using memblock_alloc() based on the exact number of
>> reserved memory regions defined in the DT.
>>
>> On architectures such as arm64, memblock allocated memory is not writable
>> until after the page tables have been setup.
>> This is an issue because the current implementation initializes the reserved
>> memory regions and stores their information in the array before the page
>> tables are setup. Hence, dynamically allocating the reserved_mem array and
>> attempting to write information to it at this point will fail.
>>
>> Therefore, the allocation of the reserved_mem array will need to be done after
>> the page tables have been setup, which means that the reserved memory
>> regions will also need to wait until after the page tables have been setup to be
>> stored in the array.
>>
>> When processing the reserved memory regions defined in the DT, these regions
>> are marked as reserved by calling memblock_reserve(base, size).
>> Where:  base = base address of the reserved region.
>> 	size = the size of the reserved memory region.
>>
>> Depending on if that region is defined using the "no-map" property,
>> memblock_mark_nomap(base, size) is also called.
>>
>> The "no-map" property is used to indicate to the operating system that a
>> mapping of the specified region must NOT be created. This also means that no
>> access (including speculative accesses) is allowed on this region of memory
>> except when it is coming from the device driver that this region of memory is
>> being reserved for.[1]
>>
>> Therefore, it is important to call memblock_reserve() and
>> memblock_mark_nomap() on all the reserved memory regions before the
>> system sets up the page tables so that the system does not unknowingly
>> include any of the no-map reserved memory regions in the memory map.
>>
>> There are two ways to define how/where a reserved memory region is placed
>> in memory:
>> i) Statically-placed reserved memory regions i.e. regions defined with a set
>> start address and size using the
>>      "reg" property in the DT.
>> ii) Dynamically-placed reserved memory regions.
>> i.e. regions defined by specifying a range of addresses where they can
>>      be placed in memory using the "alloc_ranges" and "size" properties
>>      in the DT.
>>
>> The dynamically-placed reserved memory regions get assigned a start address
>> only at runtime. And this needs to  be done before the page tables are setup
>> so that memblock_reserve() and memblock_mark_nomap() can be called on
>> the allocated region as explained above.
>> Since the dynamically allocated reserved_mem array can only be available
>> after the page tables have been setup, the information for the
>> dynamically-placed reserved memory regions needs to be stored somewhere
>> temporarily until the reserved_mem array is available.
>>
>> Therefore, this series makes use of a temporary static array to store the
>> information of the dynamically-placed reserved memory regions until the
>> reserved_mem array is allocated.
>> Once the reserved_mem array is available, the information is copied over from
>> the temporary array into the reserved_mem array, and the memory for the
>> temporary array is freed back to the system.
>>
>> The information for the statically-placed reserved memory regions does not
>> need to be stored in a temporary array because their starting address is
>> already stored in the devicetree.
>> Once the reserved_mem array is allocated, the information for the
>> statically-placed reserved memory regions is added to the array.
>>
> I tested with MX8ULP that remoteproc became unwork after applying this patchset.
> The same issue exist in linux-next with tag next-20240819.
>
> Root cause is that this patchset breaks the API of_reserved_mem_device_init_by_idx()
> used by coherent dma (kernel/dma/contiguous.c) due to rmem->ops was not
> properly saved in fdt_init_reserved_mem_node() after calling reserved memory
> setup function. e.g. rmem_dma_setup.
>
> Regards
> Aisheng
>
Hi Aisheng,

I have uploaded another version of the patches with this
issue addressed. Please help test and confirm if the problem
is resolved on your board.
https://lore.kernel.org/all/20240906185400.3244416-1-quic_obabatun@quicinc.com/

Thank you!
Oreoluwa

