Return-Path: <linux-kernel+bounces-424332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA37C9DB325
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A75AB21D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DF11482E1;
	Thu, 28 Nov 2024 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="il/n+5bt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11160142903
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778842; cv=none; b=H6JeaXrPy3vGFDLwWEKCEZLuNga2RLQPbez1RYL6Xdb+ppPeU1hMCwo3o6nL4mko4EeQhWjiVTnEsaDS3XFBTrDmcbA/FvFs1RJjqzkweGe/HhOBsENR08Jy39IFlWVbM6/1ZI5DefqSfi78z4DXJoGiuAMGVueNazObZvRaLLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778842; c=relaxed/simple;
	bh=geaDxRX5utcRI8/veV19B0DiBH3v/kaHcknsmZljnsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tLGnIjdh3c5UP2HLdjP1KDPYlrBViszQC17U4y92OEiAMejNYpmxkgShUM2+I1sDZzrZdByUNUurl5NrKThCPDYiygx4P4chr5g430PJ6hv6cqJEHkO1BgfVJmyyoS/s8rp1U3FmT/IwJ/AvguTMTf9ODg9B7Iq014SyGbN1uJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=il/n+5bt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARGR8Fv024167;
	Thu, 28 Nov 2024 07:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3K1P4b8KBl1qDii4hPP/bgdz22Lfo1k7jg9aSgfAbqI=; b=il/n+5btjmwrgWxp
	ddGtF70zq9PKvfmeNOf2NU54L4mMhyyTvxNranaLA7QmhCyee1TYPME7gHrGnzUF
	oyjqPSxqpWfN/tQk8koCjalr2ZeVnxxcGpGAlGufJBkp4xixMttNCi8K4qSIR4BI
	VsMTXbvaTP/ct6MihAo06ECFOAWdncWfGQn1O0GSw8kzwOaGQp5iK8vl/DdVEvU/
	nNdUoJO9RX9A3UwvExhsrOdP8QuL15ROarhsCV1JKa+RZI/JDPcDyo/7DDtugHLr
	xZc6CqrP2TbdrEAeU9MLCCzTRiBttEmKbmvZB3zh8is0w7GHYGcPF2JtV/B2j5RG
	1ACezA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xwhpc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 07:26:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AS7Qs4Y018120
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 07:26:54 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 27 Nov
 2024 23:26:51 -0800
Message-ID: <eb4d6674-494a-4a84-bade-481b0c89eb93@quicinc.com>
Date: Thu, 28 Nov 2024 15:26:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix subsection vmemmap_populate logic
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WMTWPFmKufcMPFkprVEDL-Bng1aquBX9
X-Proofpoint-GUID: WMTWPFmKufcMPFkprVEDL-Bng1aquBX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 mlxlogscore=841
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280058



On 2024/11/21 15:12, Zhenhua Huang wrote:
> To perform memory hotplug operations, the memmap (aka struct page) will be
> updated. For arm64 with 4K page size, the typical granularity is 128M,
> which corresponds to a 2M memmap buffer.
> Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise vmemmap_populate_hugepages()")
> optimizes this 2M buffer to be mapped with PMD huge pages. However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> which supports 2M subsection hotplug granularity, causes other issues
> (refer to the change log of patch #1). The logic is adjusted to populate
> with huge pages only if the hotplug address/size is section-aligned.

Could any expert please help review ?

> 
> Zhenhua Huang (2):
>    arm64: mm: vmemmap populate to page level if not section aligned
>    arm64: mm: implement vmemmap_check_pmd for arm64
> 
>   arch/arm64/mm/mmu.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 


