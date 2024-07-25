Return-Path: <linux-kernel+bounces-261993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B1C93BF12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F5F1F2467F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6033198E90;
	Thu, 25 Jul 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OjukQg7y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DEE198A01
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721899532; cv=none; b=ctTiAd+7pzhMqZgYSBfNkFmrCyCkSGAhcsPLvsUdXig7EINqP0q67s8biZ/O1sQKDtuIOfFx1NSfKwfWXhc80HT+rUBinEocVFVyUW1SDj2midWKW8k/bau8al4/+o8N2hhBZCVZQB184THiV1Lmrix3yXjU7W1D2AoovZ9fQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721899532; c=relaxed/simple;
	bh=W15txsPTe9TCHFyfiRv/b2eKkBA7BJ2ARA357N2McdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VvybVQH26BDLSbBY0MEuZ3/Nwo4Z/Xr/wGyhPqWgFp7rIPEBObQL0n36Qs+NL07oCEINNMWybm6m5exFKdEB1q4jsS9S4F//qvjbVN9/cp4/Hq6UknhcRHlad0M0dJSUdU83aGCX5BdXFbN0Mw0R7d13u3txOXqn8qN7mfhMlMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OjukQg7y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OM4AQh011243;
	Thu, 25 Jul 2024 09:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P4hPJtddPLad7131fjAv+TwrCcQC43nifLTthCEdNiY=; b=OjukQg7yNimCtgNH
	vidjaeCUboUvRTdNd74UafriIxLUMDSyRMGQ6BjRaZcn6n53UrJagPQhxTTE1fr3
	LuLkbq5WglsdTIVs9NesSdFieRzyAKd1te9cg7aV19q9uu610KznaWfN/I0p850M
	VXJV1vamZicg4Y6+k08ZgG7WBzrNpNxKbNuQZD0So0fJJbyrqgTQepYmgZdtfj5/
	Can9DsXmi5AmjhHfgrMGuFBpLsbiFBzho3vYDzb82eKS17tlZvT2AbAqUn4RpT2N
	jW82VWVPdPYTPO9M/2SLkvcd4csgrV5gCGo/r6EFH8Zxh4ChwoXV/lyN+MOsoE8z
	yq+vZA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40jyrfjyxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:25:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46P9PENo031576
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 09:25:14 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Jul
 2024 02:25:12 -0700
Message-ID: <9aa64dfc-46ac-2e26-51a9-50875cc3c739@quicinc.com>
Date: Thu, 25 Jul 2024 14:55:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] mailbox: qcom-cpucp: fix 64BIT dependency
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
References: <20240719100247.4012087-1-arnd@kernel.org>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240719100247.4012087-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 54HnbSW0xa2VMOho1qxKGaMoowV3nmSN
X-Proofpoint-ORIG-GUID: 54HnbSW0xa2VMOho1qxKGaMoowV3nmSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_09,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=625 malwarescore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250063



On 7/19/24 15:32, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This newly added driver fails compile testing on 32-bit architectures
> because it relies on 64-bit MMIO register access:
> 
> drivers/mailbox/qcom-cpucp-mbox.c: In function 'qcom_cpucp_mbox_irq_fn':
> drivers/mailbox/qcom-cpucp-mbox.c:54:18: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Wimplicit-function-declaration]
>     54 |         status = readq(cpucp->rx_base + APSS_CPUCP_RX_MBOX_STAT);
>        |                  ^~~~~
>        |                  readb
> drivers/mailbox/qcom-cpucp-mbox.c:65:17: error: implicit declaration of function 'writeq'; did you mean 'writeb'? [-Wimplicit-function-declaration]
>     65 |                 writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
>        |                 ^~~~~~
>        |                 writeb
> 
> Change the Kconfig dependency to disallow that configuration as well.
> 
> Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/mailbox/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index d1f6c758b5e8..4eed97295927 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -278,7 +278,7 @@ config SPRD_MBOX
>   
>   config QCOM_CPUCP_MBOX
>   	tristate "Qualcomm Technologies, Inc. CPUCP mailbox driver"
> -	depends on ARCH_QCOM || (COMPILE_TEST && 64BIT)
> +	depends on (ARCH_QCOM || COMPILE_TEST) && 64BIT

Hey Arnd,

Thanks for the patch. This was first reported by Nathan [1] and I
was planning on re-posting the series after the merge window. Thanks
again.

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

[1] https://lore.kernel.org/lkml/20240715031451.GA2940276@thelio-3990X/

>   	help
>   	  Qualcomm Technologies, Inc. CPUSS Control Processor (CPUCP) mailbox
>   	  controller driver enables communication between AP and CPUCP. Say

