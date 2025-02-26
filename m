Return-Path: <linux-kernel+bounces-533042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A226A4551A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007D9189B886
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D59725E45B;
	Wed, 26 Feb 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C2ikENMY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4B27702
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549092; cv=none; b=Kqufh+V1T40483IYJZNg57o5AhgXFoLpOtPAvgJ5hW+p/1WzLnjVAmfPFKOwm85sDS768AIzFjRMQ4tKdLz2sWcISTzkdp5IBaL2C2KHO5wggoOYesKebWsiPpstcriKJJ+mQUd/yPveytPlRJRymQaSHspo5f8JzttUQu5OI6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549092; c=relaxed/simple;
	bh=IeJVwbCbE5P91licqnFXoefwVpnMOxtIkMli1JEBuEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Phw+QTZyRRcDl4ZaLrFBBDf+lpzPidmmoURy3zhHyosn5CpoMDpzoBsj0aafAphYdHjuYkH+woFqdDdcxPl2j1yemNDyQTGgyrlS5hV2dJZTu/2bXcHO2/6GEkfMuCzt0XweKKu7W9ja8HEoJN8FRIUI0luZJEVXXC6Fx98tG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C2ikENMY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWqar011761;
	Wed, 26 Feb 2025 05:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pq0VnmDD2J5WUBS9njZY7rvRpMdayjGUpkeBScg3ekM=; b=C2ikENMYRACnTxuw
	bI/s+EQQCe6OpTLIWYOJsv6HCa7zV09RbPZx/wkOn2YcqHNZgnyRIeP/ZnxoiuYB
	pjv8TjEM12072me4GgMFpQqnJ7JFfvf8xrBCwN7N5sg+WN59fDr+ZNynS4tvqbwO
	veC+P+9+/FPKVFEQZibOIIT+5ZwzuFjhpWDura5wnuLBb95iuSUeCzNh3yHy5JA3
	kyc/rxLXAhs3ID+dyWH9a8kvJdjFloa5u1AF7lt2uepf31Cywg6a2f0wcwrD10AX
	0C9aUOf4ucQ5Viij0+YTXz2banZQgW01LxFkZgq3cRIlC72g5H21fpYTN4u/aWVf
	s9AqhQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmgv9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 05:51:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q5pGFx023779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 05:51:16 GMT
Received: from [10.50.7.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Feb
 2025 21:51:14 -0800
Message-ID: <786af13e-942a-09ff-49c4-2a3d7e9be7c9@quicinc.com>
Date: Wed, 26 Feb 2025 11:21:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: defconfig: Enable iris video driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
References: <20250225-enable-iris-defconfig-v1-1-1ed49c8396bb@quicinc.com>
 <2bfb37fe-6e6a-4f9a-82be-5776935563cc@kernel.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <2bfb37fe-6e6a-4f9a-82be-5776935563cc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z8aScgOngP9vRzdKumFFZDUQ-X238CDA
X-Proofpoint-GUID: z8aScgOngP9vRzdKumFFZDUQ-X238CDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 mlxlogscore=714 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260044



On 2/25/2025 6:36 PM, Krzysztof Kozlowski wrote:
> On 25/02/2025 11:09, Dikshita Agarwal wrote:
>> Enable the building of the iris video driver by default.
> 
> 
> 1. Why?
> 
> 2. This was already sent by Neil...
> 
Apologies, I wasn't aware of that. May be I should subscribe to
linux-kernel mailing list for such patches.

Please ignore this patch.

> Best regards,
> Krzysztof

