Return-Path: <linux-kernel+bounces-223045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7FB910CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3901C23FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CAD1BBBCA;
	Thu, 20 Jun 2024 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oNM38v87"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A44A1BB6BD;
	Thu, 20 Jun 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900695; cv=none; b=qt2tROekD7Pxhc+5OxAqhjVzYH3FQY2AgI6Cab2WEEXlfFT5M0r76AlJ4mHcvY2Pvr+HcN1ZmkenhCptWeARrCqRO9/HwYDP/LC3CWtkYO09KcCtwbcIZQQkuHVT+mcrwjIIGF26ic4dwbvnp4x4bsBevzQXPjNrMu/iBElSNSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900695; c=relaxed/simple;
	bh=ZR9u+Rn7gRKiftpayglHWwSEeMmQtCmavcQ6j+lEoMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cBMu8KLM8TrZ6N/wQVcLK6It7ZNhDQ++qE1SvH+x8X3EwoJ4l0NA+xvMBp4vmJeUF3KeM5tw0fbo5GBgsvXZHz/9IddnQ8AgZWbOaQa5uK3Yq8Gj8r3OkT1aK4C3T6dtYUyNSZ4jz8GBYVPQurg9TnDN+89G19merrzq8WMOaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oNM38v87; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K9vQs2031091;
	Thu, 20 Jun 2024 16:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	esuJPcWCYL3IQgo8NRCql7W2vxOR0OVEN/Audo0PIG8=; b=oNM38v87TgEdmJLe
	VRk+bKIyMB8NrPWkOjMQ9A1BUvcF+yXtQHYhzQMeZ/3wn7VQJnOhR3z/szKtVN7N
	zhIcWM8vCd2aR/4m/rZAmaJuaFfiC/3ZygMsUvMoVbUDg2A8NTorQ+5OHY+GIGya
	aSY9ahYXgTauqcrthDYvyqZP+EN+DImAWde4Ivs9nfBTV9SUed14ey7/ApM7z7vj
	LGsYopQIgH+WV0PpuPNZB6cbqoTQRyVqBrEzX8CzAkD6BnN1Ilht8lLJCQIJXhPk
	qh/45HSSRMY0UeRa8YP3dAOnZ9e17MIcck7IgeX3A+8b85zmoZtk2e38+hVmFgyu
	ebsDQA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yv6hn2d3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:24:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45KGOnJg030701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 16:24:49 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 20 Jun
 2024 09:24:48 -0700
Message-ID: <6ad04afd-bc38-4e25-8c59-3c660c213f49@quicinc.com>
Date: Thu, 20 Jun 2024 09:24:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource: Add missing MODULE_DESCRIPTION()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240529-md-kernel-resource_kunit-v1-1-bb719784b714@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240529-md-kernel-resource_kunit-v1-1-bb719784b714@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pyvlolg2SDeefvxd7dszQ5PQkn-vbryZ
X-Proofpoint-GUID: Pyvlolg2SDeefvxd7dszQ5PQkn-vbryZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 mlxlogscore=999 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200118

On 5/29/2024 4:31 PM, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/resource_kunit.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  kernel/resource_kunit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/resource_kunit.c b/kernel/resource_kunit.c
> index 58ab9f914602..0e509985a44a 100644
> --- a/kernel/resource_kunit.c
> +++ b/kernel/resource_kunit.c
> @@ -149,4 +149,5 @@ static struct kunit_suite resource_test_suite = {
>  };
>  kunit_test_suite(resource_test_suite);
>  
> +MODULE_DESCRIPTION("I/O Port & Memory Resource manager unit tests");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240529-md-kernel-resource_kunit-0457d0010b70
> 

Following up to see if anything else is needed to get this merged.

