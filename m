Return-Path: <linux-kernel+bounces-448444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 873129F402C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 960ED7A3ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49F2E630;
	Tue, 17 Dec 2024 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Oz8jIU2b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014344A3E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400058; cv=none; b=pOip0T2V6G11NWHTIfra6njfDKLWPW8j3m8GCsEy6Kgucj0UsfDHpmFN7rwzJE6AvmWHahywrkA45GUSAn0zY4FJoDR8YnQEMUdiMV4CDK9v4vvkMv3IIpmfvuZ/Fq31A8v3Y+LmPZ4uFjhUfVOXA4+N24DuY+MDwm7c9P7TAaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400058; c=relaxed/simple;
	bh=MZCXg/H4wOMDV86Lafieg5rfciJXowYNZ4+hEzcgBnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YkMJ6XaWd/TAshOpgfrS6JpquCXlQlr7uVDvuFGaUC2FGZymTURjmwbezWVAXWatYSTkGVlAKvaqI94oriNP8EwaZifnpY4Sc+ytNXNWBocPYBFqCg1dH4u7ucqU4EkvYx9E6MTAzejz4G3+M+jliGOQZ04BqVD90fSkBS/Dz2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Oz8jIU2b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGH9b3i017135;
	Tue, 17 Dec 2024 01:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9C8ECPChj/kO42Kh7aZ8HaZuA9HeVtP3mujj6Fu/4Uk=; b=Oz8jIU2bzTDQHykJ
	GQ8QVHO1CtqzqOGOWcP0J3fUuExxdSDejqkr5k8ih1IZa8bmJukoYiPW836lD7Pz
	/HxF5Sa+ReB4Kq7BRA5A5n7mLvKVIG6qKEUCz2O/nCIbNgsjOkrPCSx+/M4szpWa
	/FIf1FZlX4sQtbT9k00KX3AZ2QfIEjjVKx10XJQcJAZ4nBM266ZOSi0iZPy0Nr/t
	Ayzx7oG6RC+HYixfWILunh/3PMh7QOArqDPSA0fkVDMnQeAiGHKPX4vBpjCWaLBI
	PUZLmDsJuxStJBt8QG2WNNhnTsi4grMzMEcS5WDYdBLMepv04jzruuv1ZXcYl0lU
	ShWiTA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43jrc1s20e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 01:47:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BH1lEiI008979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 01:47:14 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Dec
 2024 17:47:11 -0800
Message-ID: <9e5104c0-99ba-4519-b6b1-3b8e8196c9a5@quicinc.com>
Date: Tue, 17 Dec 2024 09:47:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix subsection vmemmap_populate logic
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>
References: <20241209094227.1529977-1-quic_zhenhuah@quicinc.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20241209094227.1529977-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZYf_3rAPsrMpjL867nUo4NRNpp8O-9R5
X-Proofpoint-ORIG-GUID: ZYf_3rAPsrMpjL867nUo4NRNpp8O-9R5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxlogscore=821 mlxscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412170012



On 2024/12/9 17:42, Zhenhua Huang wrote:
> To perform memory hotplug operations, the memmap (aka struct page) will be
> updated. For arm64 with 4K page size, the typical granularity is 128M,
> which corresponds to a 2M memmap buffer.
> Commit c1cc1552616d ("arm64: MMU initialisation")
> optimizes this 2M buffer to be mapped with one single PMD entry. However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> which supports 2M subsection hotplug granularity, causes other issues
> (refer to the change log of patch #1). The logic is adjusted to populate
> with huge pages only if the hotplug address/size is section-aligned.
> 

Could any expert help review please?

> Changes since v1:
>    - Modified change log to make it more clear which was based on Catalin's
>      comments.
> 
> Zhenhua Huang (2):
>    arm64: mm: vmemmap populate to page level if not section aligned
>    arm64: mm: implement vmemmap_check_pmd for arm64
> 
>   arch/arm64/mm/mmu.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 


