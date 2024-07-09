Return-Path: <linux-kernel+bounces-246600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C1D92C429
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3585D1F232CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949BA185601;
	Tue,  9 Jul 2024 19:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W1ORiQUz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F87180023;
	Tue,  9 Jul 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720554915; cv=none; b=MgcA7b2L4CgsK6aB7HrK9kS70DJiPOsKOgB8rV/xp4lcOCE+YipJAxrK3u2h60xHWFIB7UBKQCIZu7E9CveiJl2TmEODlAZNBJn9lUb4rEl0G1Uoqz4qWXbEc6nm8TRPK3AZxpOz+3dVDxeGyORrUY6TERfPo3ftpWYMwpAU0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720554915; c=relaxed/simple;
	bh=h2lVOvtLaDBKhkSYD1LtqT7kAgJd2Lb3XtiGmENvitY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZqVguvq62ZCLBcmuTUzi0s/yD5pvIMRNQVjn/tuBRhb0W1zncoBogqmxyeWTpKRHhi47dNKz5ZOMm2QsMWyeoE4QrvpsAg4Rqp2ye66ctz+9VfbS+eumUUlv/iQsstx74BHUdHiFaQji2SXsnoYyzy6Wvr7rQ+DqvgWS9s5XSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W1ORiQUz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BH3Bu024964;
	Tue, 9 Jul 2024 19:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AzYMoQCg5qeai68mMMgWENZWpLvUfMKeYvN0jvnswX8=; b=W1ORiQUzND3LneQY
	7at6N3OKng8TyXyiCiQOIiNVkn/XRvcuHq5xAWGP5fXGua/9Qy9fgEYrW12CPK02
	g0kaUFQutVB773gOIy8sase0hd+8Qgnnk7zOG/5sacDlp4tdVjqiDm8v/13oVJT/
	Q0+bJYPlnHEXf29cXxFYU6aAFs47pYDkdIRvaTZPcUue5RqViBTWn4EOIpRBElPR
	eu8h8+U2F2vpFMSbXWlgtKCMBqtUlR3C8b05q8MQyX12WkLukOA1VtGwgHMK6OwG
	naw5+F4vRKiy1PnbiMVF03q6RDYzCxWeFqkclxXiU9zClDiRFCAW9+vyz1inL33I
	QnBOtQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwqeq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 19:52:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469JqPVk013564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 19:52:25 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 12:52:25 -0700
Message-ID: <683c654f-5a87-41f6-bea1-05937dab4678@quicinc.com>
Date: Tue, 9 Jul 2024 12:52:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: arm/xor - add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Russell King <linux@armlinux.org.uk>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240622-md-arm-arch-arm-lib-v1-1-056ad25fe236@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240622-md-arm-arch-arm-lib-v1-1-056ad25fe236@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rlhvNnNaEuUDze9S2sEzACdODm6bRijN
X-Proofpoint-ORIG-GUID: rlhvNnNaEuUDze9S2sEzACdODm6bRijN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=854 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090134

On 6/22/2024 9:16 PM, Jeff Johnson wrote:
> With ARCH=arm and CONFIG_KERNEL_MODE_NEON=y, make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/lib/xor-neon.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  arch/arm/lib/xor-neon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index 522510baed49..cf57fca97908 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -8,6 +8,7 @@
>  #include <linux/raid/xor.h>
>  #include <linux/module.h>
>  
> +MODULE_DESCRIPTION("NEON accelerated XOR implementation");
>  MODULE_LICENSE("GPL");
>  
>  #ifndef __ARM_NEON__
> 
> ---
> base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
> change-id: 20240622-md-arm-arch-arm-lib-9b1fb344923c
> 

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.


