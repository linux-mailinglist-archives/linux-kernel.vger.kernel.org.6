Return-Path: <linux-kernel+bounces-231150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E429186DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438E128142D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6EE190674;
	Wed, 26 Jun 2024 16:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UfdZj7pj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D118EFCC;
	Wed, 26 Jun 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417915; cv=none; b=hIm6cC8VCmbQfPzzNhJslUwpCxzIKDwItP+goJ4KurqrvCMrPJaP3TYEFGBAjW8PBAIL2vifYHvjZLDrL1NlEXaQyixcjxIzldGtBT7r1tIBXtRMUYmKOUD/YKjO20t7TPc02jHwALyS0KAT3XmCEi/mgpk1/LpbNReZ3X6kAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417915; c=relaxed/simple;
	bh=PA5oNQKseHeifX+TmtJH+qhwEpeNW1Dck9bJz62Oo0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ay0sHPahekXE8vLG3ZEMlfD5acypyG3STTlFLp5m9e6iKCpiPECsQqjR10ht7IfaFj31E/PF7vkE8J1lzOWK3/9JYJ+EPX5IORJ89//0l5AmkeZ6cZWLpTzbvh5pd4WtYggBisUorucS8mgiI6rYjdfFqMQwSsxuNjhfTZ2ZnuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UfdZj7pj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfa5Y029266;
	Wed, 26 Jun 2024 16:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SP0Z/riTEA3aysdgIqwT0ua236dKkY1TkPD4qdytLQE=; b=UfdZj7pj9bQTYF/N
	TxNCUv3bSIvo8e1tIeFhDWa4CBJBNBxrZHLeqog5OmFjjvCNssNmMi8Z97A2ulYT
	llNuulQ3JcaHIWw5kGpwyDUgpXaASbZ9SzFkPjefLBP1fEOJxrbPviMdM4gNP0A6
	JU1FycaKx0a0OY27DMesIb2wCJV4z8Rw9szhvPsKfanIv0BeNylDxt8yNCp0C7pM
	KFkRbRpLu6nUcpJDIXyM0vWiTfPEEdVpFIfv7DC/iQynF4J4cYlbRc4LMkJxF8YG
	zCCy/lYIUHGW5AzLnL3O/YSMr0V41cr5B5s7mllfIagm/3ItH/TRysHNGq6NSlby
	MAqi8Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6srgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:05:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QG55Vj010780
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 16:05:05 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 09:05:05 -0700
Message-ID: <fec0d711-ea96-4f94-9a9e-5d1b16d29d0f@quicinc.com>
Date: Wed, 26 Jun 2024 09:05:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <greybus-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240607-md-drivers-greybus-v1-1-31faa0b21105@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240607-md-drivers-greybus-v1-1-31faa0b21105@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fBk-TPsg2gkDr-FPVlHw_IM-_LUCcRlo
X-Proofpoint-ORIG-GUID: fBk-TPsg2gkDr-FPVlHw_IM-_LUCcRlo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406260117

On 6/7/2024 1:56 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o
> 
> Add all missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/greybus/core.c | 1 +
>  drivers/greybus/es2.c  | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
> index 95c09d4f3a86..c28bb973f67c 100644
> --- a/drivers/greybus/core.c
> +++ b/drivers/greybus/core.c
> @@ -375,5 +375,6 @@ static void __exit gb_exit(void)
>  	tracepoint_synchronize_unregister();
>  }
>  module_exit(gb_exit);
> +MODULE_DESCRIPTION("Greybus 'core' driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index 1ee78d0d90b4..db4d033925e6 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -1456,5 +1456,6 @@ static struct usb_driver es2_ap_driver = {
>  
>  module_usb_driver(es2_ap_driver);
>  
> +MODULE_DESCRIPTION("Greybus 'AP' USB driver for 'ES2' controller chips");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
> 
> ---
> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
> change-id: 20240607-md-drivers-greybus-a13b64e41256
> 

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

