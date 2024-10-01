Return-Path: <linux-kernel+bounces-345185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8C98B2E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA41F2399F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76F1B07DC;
	Tue,  1 Oct 2024 03:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DYRvVsCh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BB1B07BF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727755140; cv=none; b=bD77xPowrRk6UiD16o+WWgs/z6Mzdqp5I8KfMC1V0LvcsAEnL1vQPvHB8YxWH3tN8eeDqiCBuW2Ba+Mg6NNY17+rvqrQmafwbnGpN+B/BP8/JnrDCvgP+lEQN3zF4zaX1oMcF4DQGD527q9Iab0jbXWdeHP5MjxEkcp/FmhKYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727755140; c=relaxed/simple;
	bh=VH8itMMXzvb6GB6o4Eu5hHrxXnN8iab2AcL4GxFAfwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mqa5alSIzOgQbHsdfElZ2KnFYp+bjtnIx6vXrmBUWIUvZohyhgwZX54KUiOUI2PNSuipCT7vAPE24ln2O5apifYTbTtT8W7+H/+hESr/Cqi8bVnRzQGFo5pR4C/FFw6DfbpkIsd1p5gPPjwVF/TqOrOLJsNTGt0Gte2rj0+nRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DYRvVsCh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UJrS1m018007;
	Tue, 1 Oct 2024 03:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zisCk4iCNypnBIDc1dbcxECIvPV2BzbakMxkwNsZyMk=; b=DYRvVsChcIshN/d7
	urzqjwjOj/Km/qQG172NYtWEGaYZBrhv/NOy4Yke1e3WcpGqj0lLWV4sPhKuz0Q7
	Vtn7iIMwZy8SA246QmXEzZDGPcaniqDZOznqOowx3kOSA3VNlwRiKXT1GaSm2OuI
	NGUJQxLwHuqFR1UnCzSKE/fydEP2gjEtwkvg5Zd5DjKIsU3XaPO7lUZbdggkBu1O
	QknwvWd6pRk/Q6E6H74/AiR5g3guk8rWqDl9VK6gCiZQTbPcXUptdZWkHQmwffkB
	DsT4gf8jywEsO2otesyoMgPkmBkzqDQooMrnwsqxw8NRg3sCUvtUuMTzjCoVrw6V
	jgzTnA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41x7ge72q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 03:58:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4913wnwv024895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 03:58:49 GMT
Received: from [10.204.86.168] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Sep
 2024 20:58:44 -0700
Message-ID: <5c3ff10e-0dec-56de-048c-5d5f4d0605f3@quicinc.com>
Date: Tue, 1 Oct 2024 09:28:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1] arm64: defconfig: enable WCD937x driver as module
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240916052352.1819088-1-quic_mohs@quicinc.com>
Content-Language: en-US
From: Rohit Kumar <quic_rohkumar@quicinc.com>
In-Reply-To: <20240916052352.1819088-1-quic_mohs@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nx0DIEL_GY_DNffglRdJkcZD3f-jC1Qy
X-Proofpoint-GUID: Nx0DIEL_GY_DNffglRdJkcZD3f-jC1Qy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=789 lowpriorityscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010026


On 9/16/2024 10:53 AM, Mohammad Rafi Shaik wrote:
> Enable the Qualcomm WCD937x codec driver as module as
> is now used on the QCM6490 platform.
>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Rohit Kumar <quic_rohkumar@quicinc.com>
> ---
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5fdbfea7a5b2..c4746e3412f8 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1036,6 +1036,8 @@ CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
>   CONFIG_SND_SOC_TLV320AIC3X_I2C=m
>   CONFIG_SND_SOC_WCD9335=m
>   CONFIG_SND_SOC_WCD934X=m
> +CONFIG_SND_SOC_WCD937X=m
> +CONFIG_SND_SOC_WCD937X_SDW=m
>   CONFIG_SND_SOC_WCD939X=m
>   CONFIG_SND_SOC_WCD939X_SDW=m
>   CONFIG_SND_SOC_WM8524=m

