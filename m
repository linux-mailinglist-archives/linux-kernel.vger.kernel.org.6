Return-Path: <linux-kernel+bounces-436819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7B69E8B52
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1D4281575
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAB72135CD;
	Mon,  9 Dec 2024 06:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EwVdjHka"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413915B115
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724288; cv=none; b=EPQnKmdg1rLJKHFPsZWzrwa4Qd1MjgLVdU+NiUjTjJ23rqTaMtINBCMsFZrZaY1TmK5Exsxx2HkQVvwJco6sRDorRjoVu2ZWf0iYzyHXWis4N1qdINNlix3Y4c5uEpReb9a8UkBs5+fSRzvHtWpO62kLrtFTesUuQz79dwFO5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724288; c=relaxed/simple;
	bh=99pe9ksJU69ub4rhHqc+3iWA6ySe6oKqqJXc7JbC3C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OeEjVFwMOuUQtVVb2SBB1f+YhJde10bJDnJMp84wpInqqGuitvLMpyIsUGa/ZhrUaSo52jKUhfEMWSk5jJFIRykGHfROo3BOCANpxTedfEjLXlvdG0vuWX/VjbE1EVkGAHa3dFc/lguo6d2JlkpOaCm3Ot6PB/2aHmo2nrHF1jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EwVdjHka; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MbAle007595;
	Mon, 9 Dec 2024 06:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l9PuvcdJwOfZRRtqfiDwVA80nV3LXQEx4Lzfhz9vGo8=; b=EwVdjHkatrI5GG3H
	N73j41v6k6JdMM1M6jCSsmnaSCX9PMvhvR2tlAd6+0VQnqW3oI0MTFnWJn7m5U7q
	84uhVoHBnH2n/qDOQBjYb6Ekc4VieJ+7SurGa6XCkY1KI84if3LWegxO5NSFlEVI
	yI0txNFG27Tpp7l3CKQGUgnzdSLSbQMELZsC4xpKqTYp+EKguaKYWvVPY6e7HR/7
	/ZiSMxKJSf2mU28l4mqXV/PmnT//NcouqEVKF7MqLN4ueay0ooo5Zyir9eMxA7l5
	co51QRFInPP/RgVCETSByJ/CIcZOLzEWDZaWw6j0J2jBH7JUHUChoOtLCOb2Wda2
	GGW1ZQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43cdc6bk5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 06:04:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B964PZD024630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 06:04:25 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 8 Dec 2024
 22:04:22 -0800
Message-ID: <4d2f42fc-26b3-4924-b855-86bea92c03b0@quicinc.com>
Date: Mon, 9 Dec 2024 14:04:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix subsection vmemmap_populate logic
To: Andrew Morton <akpm@linux-foundation.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <chenfeiyang@loongson.cn>,
        <chenhuacai@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
 <eb4d6674-494a-4a84-bade-481b0c89eb93@quicinc.com>
 <b2681eed-d4d5-43c9-90e0-3e706db3e201@quicinc.com>
 <20241206221446.e5e8ea4ed85d0f2884216b82@linux-foundation.org>
Content-Language: en-US
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <20241206221446.e5e8ea4ed85d0f2884216b82@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gEA3ebkkEJ32vvvchaRD_vnBfXDIDlXW
X-Proofpoint-GUID: gEA3ebkkEJ32vvvchaRD_vnBfXDIDlXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=951 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090048



On 2024/12/7 14:14, Andrew Morton wrote:
> On Fri, 6 Dec 2024 17:13:39 +0800 Zhenhua Huang <quic_zhenhuah@quicinc.com> wrote:
> 
>>
>>
>> On 2024/11/28 15:26, Zhenhua Huang wrote:
>>>
>>>
>>> On 2024/11/21 15:12, Zhenhua Huang wrote:
>>>> To perform memory hotplug operations, the memmap (aka struct page)
>>>> will be
>>>> updated. For arm64 with 4K page size, the typical granularity is 128M,
>>>> which corresponds to a 2M memmap buffer.
>>>> Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise
>>>> vmemmap_populate_hugepages()")
>>>> optimizes this 2M buffer to be mapped with PMD huge pages. However,
>>>> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>>> which supports 2M subsection hotplug granularity, causes other issues
>>>> (refer to the change log of patch #1). The logic is adjusted to populate
>>>> with huge pages only if the hotplug address/size is section-aligned.
>>>
>>> Could any expert please help review ?
>>
>> Gentle reminder for review..
>>
> 
> 
> MM developers work on the linux-mm mailing list, which was not cc'ed.
> 
> Please address Catalin's review comment
> (https://lkml.kernel.org/r/Z1Mwo5OajFZQYlOg@arm.com) then resend a v2
> series with the appropriate cc's.

Thanks Andrew! Will do. I was realizing I couldn't fully rely on 
get_maintainers script :)

> 
> 


