Return-Path: <linux-kernel+bounces-234772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB8B91CACD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 05:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874661F225F2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1D1D556;
	Sat, 29 Jun 2024 03:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JR3LT8Jl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87522086;
	Sat, 29 Jun 2024 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719630624; cv=none; b=TOcgRktdaGtDrsMcXO7dHrWxi1AotZZy3hq9g0wH6w229JSDIdqM+i2mzCFd7uuz2flrP/a0u1wPxnsyKT12UqJ4fabViqbRrOnEUFtb7OPM65t0xO4CpvYAB/Usx4kEVJTSr/sYg1K8IaTeOk9kf7UWXBKHcQnM/jdHaEPPPTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719630624; c=relaxed/simple;
	bh=ecaQLAgzhBzzmTT5df0SGRynpgMqFN50zOvlg6650X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ihc/NKuh0lnxZm8eJelcjZQYjqvw460RqV3oeRgG0d4mgMNkEIv5jb57AQv/6vkwB/61lSKdq6XkJ+cB19DwGt++mkZ69xjA9lJUqMIj4KUBK/LZihAEBhadw7DH0b1vvUeHtnGH1dwfOEeh7KACWXeVwtdofAlGw823RXoUtBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JR3LT8Jl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SG2YDn015339;
	Sat, 29 Jun 2024 03:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1uNs3pB+IC28ZfqQi+oFquJimoPG805ibakF1kqPOyw=; b=JR3LT8JlQWNPPoxU
	Gfmq7yU6X6Lbi7qLLPZppwky/kY9EeEy1iYkMEE3P5l7/sRHjBGmInos29ao6gmv
	9CB/KqU+Fkko3YQ69vjZ5a2RIaX4aq3pHPklUiDJFoh226qWAznfpMXAdbxxtsdD
	ZPoiIiJH6YE28UBe+crs3x9V374SrXEKu5Hx9ygUxd1oO1AQZfqU4sTuMZXmkXMr
	JUsp1EVbehpiw67TjO4CaiJjZMCMOigEqQ2Bx+3SYvPd3dGRP4YtFNIqF/Exm/Jy
	bFSEdrTMVUXtozEylp6z55P05hz7KY+RZkCyjr0rRFVZblO824d5s4SlvB+NqHCL
	cVTIfQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcmgru9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:10:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T3AIZ0011474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 03:10:18 GMT
Received: from [10.48.245.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 20:10:18 -0700
Message-ID: <3f8bb9ef-059e-4ef1-9e03-f90ddc8e612f@quicinc.com>
Date: Fri, 28 Jun 2024 20:10:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/goldfish: goldfish_pipe: add missing
 MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240615-goldfish_pipe-md-v2-1-b4323a969594@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240615-goldfish_pipe-md-v2-1-b4323a969594@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BjjZf5qqqRVpiT9HbV2mGXDwOJHuL_dP
X-Proofpoint-ORIG-GUID: BjjZf5qqqRVpiT9HbV2mGXDwOJHuL_dP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290023

On 6/15/2024 2:34 PM, Jeff Johnson wrote:
> With arch=x86, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/platform/goldfish/goldfish_pipe.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
> Changes in v2:
> - Rebased to v6.10-rc3
> - Updated commit text to use a more recent boilerplate
> - Since there are no matching entries in MAINTAINERS, added Andrew & Greg
>   to see if this can go through one of their misc trees
> - Link to v1: https://lore.kernel.org/r/20240509-goldfish_pipe-md-v1-1-acb513276263@quicinc.com
> ---
>  drivers/platform/goldfish/goldfish_pipe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
> index 061aa9647c19..c2aab0cfab33 100644
> --- a/drivers/platform/goldfish/goldfish_pipe.c
> +++ b/drivers/platform/goldfish/goldfish_pipe.c
> @@ -946,4 +946,5 @@ static struct platform_driver goldfish_pipe_driver = {
>  
>  module_platform_driver(goldfish_pipe_driver);
>  MODULE_AUTHOR("David Turner <digit@google.com>");
> +MODULE_DESCRIPTION("Goldfish virtual device for QEMU pipes");
>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240509-goldfish_pipe-md-1dec20bd3a90

Following up to see if anything else is needed from me. Hoping to see this in
linux-next so I can remove it from my tracking spreadsheet :)

/jeff

