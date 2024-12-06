Return-Path: <linux-kernel+bounces-434694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C058A9E69DB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A703B165093
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF001E2007;
	Fri,  6 Dec 2024 09:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cfnX3sLH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD801DED74
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476441; cv=none; b=la1NDautKvcjc6jZqM0qLYANUeLjrCN+lfjGenEB5uj6juTtG6aXKucEUt6Qvuof7O9UcMB3ZwhrF8KZlvKs/MsQRBgQWp55yl4FHOi26n0dBtC5f9Ll+NeOd4+wQw3ocwxO0ANqjcAfu4zn/dv5lB+O/C0NIF86yvggX9YjHHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476441; c=relaxed/simple;
	bh=SQHTspuI61a+BRZ2Rs+qevbHwnUDrCY8ib7PqrvBRt0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=YA7Wo6sKHu/1sZc892BZ4L6WtGWN/qDgLPt7ZoEIKNbVfQ63aVmPbmVg4V1NxIy27+E7VhVqUNb9H9zkwt0UDETM60sQPoCjwThH+jfcPYoriOb5un/UsVBDC6P/9kSOyBFJwPj9nw4Qk/vwmIWSTGP8gp0/wygsN0ckfqrd1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cfnX3sLH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B62S3aU004109;
	Fri, 6 Dec 2024 09:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5Uix+VCsP1VBVV3kQGGxY0VSVw2QtLTARl47+MKnGM=; b=cfnX3sLHE10bV914
	Uuk0L0LgU9C6mkCBRPgzi7YSnF+M0uT/nnGWZVe+yaUV/s/AGrB23zmrWFyjaH+e
	XiLz3UMjB9O3qxP5nvkCMa9SK1HikSY5JAiFjAELGMPcTKQZrZfGzs7YMCw0oNz5
	vKlDZHjjgWTlw87yAVhjj6sezfUcbqiKwWdhiJGVE1hCoCZvW0i/OV74GxuoDS+U
	BtI8lHCaYAqu3bYU8kbH+sJ2BrmMpzUcRjaZHXxc+0k/16zQyZW0YtMmFpfUMo/f
	Mob9y+QdFUiT3OsAswbVb6SBehrv82n7Y336VrTxpFBz39iMLeACwZYb1E2rtcHQ
	NRIK/Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43brgp0ywa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 09:13:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B69Di28011160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 09:13:44 GMT
Received: from [10.239.132.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Dec 2024
 01:13:41 -0800
Message-ID: <b2681eed-d4d5-43c9-90e0-3e706db3e201@quicinc.com>
Date: Fri, 6 Dec 2024 17:13:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix subsection vmemmap_populate logic
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <ardb@kernel.org>,
        <ryan.roberts@arm.com>, <mark.rutland@arm.com>, <joey.gouly@arm.com>,
        <dave.hansen@linux.intel.com>, <akpm@linux-foundation.org>,
        <chenfeiyang@loongson.cn>, <chenhuacai@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241121071256.487220-1-quic_zhenhuah@quicinc.com>
 <eb4d6674-494a-4a84-bade-481b0c89eb93@quicinc.com>
Content-Language: en-US
In-Reply-To: <eb4d6674-494a-4a84-bade-481b0c89eb93@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ke0QfRXNNZCzln0AqyLBSOkfZUD_FBEX
X-Proofpoint-ORIG-GUID: ke0QfRXNNZCzln0AqyLBSOkfZUD_FBEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=866
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060066



On 2024/11/28 15:26, Zhenhua Huang wrote:
> 
> 
> On 2024/11/21 15:12, Zhenhua Huang wrote:
>> To perform memory hotplug operations, the memmap (aka struct page) 
>> will be
>> updated. For arm64 with 4K page size, the typical granularity is 128M,
>> which corresponds to a 2M memmap buffer.
>> Commit 2045a3b8911b ("mm/sparse-vmemmap: generalise 
>> vmemmap_populate_hugepages()")
>> optimizes this 2M buffer to be mapped with PMD huge pages. However,
>> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>> which supports 2M subsection hotplug granularity, causes other issues
>> (refer to the change log of patch #1). The logic is adjusted to populate
>> with huge pages only if the hotplug address/size is section-aligned.
> 
> Could any expert please help review ?

Gentle reminder for review..

> 
>>
>> Zhenhua Huang (2):
>>    arm64: mm: vmemmap populate to page level if not section aligned
>>    arm64: mm: implement vmemmap_check_pmd for arm64
>>
>>   arch/arm64/mm/mmu.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
> 


