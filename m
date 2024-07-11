Return-Path: <linux-kernel+bounces-249683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6328192EE7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15755284E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71E516E891;
	Thu, 11 Jul 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VucPSh08"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BE16CD18;
	Thu, 11 Jul 2024 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721371; cv=none; b=E9TpFigHgsmdqoC0MGT61xkaK2939P0IasuBRShWeYhKeQ8T4S6O6XTiK2LcNCtHmfyAkN5nFGtwhpaK4XfNCNTRlWwEYUler/ziNQRfEPWSJ1PT8u0j+QdsNUf4242emuUDp0gEQoOZ/Y33kd6BKEwKUmtmyy8eLB9D/JiWMDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721371; c=relaxed/simple;
	bh=0t0PrsffBjbOeXvSnfDiIlEcmh1iUXyE7PoS7skeuYM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=pXYxaccJaBoPTQNe6Ku7Jn+z+17Kf1+JfcjBZWMo9VmI+qFRnKCOEyla1plPwHbDCXj/t/gnbJZ5wLVyejNaUJTxDjCvmtrIGXM1t3Qi4BFYn//GQcwLPjIQWaSqWc2BXSTzGluWGz+rbhs0oeEmjVMSaPvFlwe3brJfH7dD3Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VucPSh08; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BEbgpe017987;
	Thu, 11 Jul 2024 18:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mldO7xnB9weHAdODr49QbumnsOmrBtTnPrjgojbegnc=; b=VucPSh08GkP8Jhu/
	17nAKrwtLPvwn1h8jb2YHgQd8YFuew5aZoZf/ACWCyPApRi6P4aHpj45wzWK9my0
	/ucucFUzequpAdNlMlL6mtHo/DEWdTCBET1nESkxrkQWOM54BhrbYykB9Ea3lxPZ
	TI1b6UCLxyjgBhycwZ7WZpIof1JeKXBmjw/r73MJ8NevG/Y8J7W9YkCqQXM4iE4f
	U1mEColiBWSP+EO8sqPKbKCt8YWGqXxpjksuAn/BBHfMOUIofXBBvEJwUwCtsQU7
	hjuWoSvIWavPkMmLFiuc63AbIGcvHv/bC9ArKUwb6335K+bY9vrWiDyKMF8tlUBD
	T5bVPg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmwby0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:09:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46BI9PTq015816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 18:09:25 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 11:09:24 -0700
Message-ID: <3fbab686-5a66-4b4e-b640-55426b2e1f57@quicinc.com>
Date: Thu, 11 Jul 2024 11:09:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spmi: add missing MODULE_DESCRIPTION() macros
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd
	<sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240609-md-drivers-spmi-v1-1-f1d5b24e7a66@quicinc.com>
 <88ab18bd-0700-46c6-9d74-5bd79a1f0fc1@quicinc.com>
Content-Language: en-US
In-Reply-To: <88ab18bd-0700-46c6-9d74-5bd79a1f0fc1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ydFMXoEkgLnJIJ5ce_mYQnUWQCgVyyjQ
X-Proofpoint-ORIG-GUID: ydFMXoEkgLnJIJ5ce_mYQnUWQCgVyyjQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110125

On 6/26/24 09:15, Jeff Johnson wrote:
> On 6/9/2024 5:40 PM, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/hisi-spmi-controller.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/spmi/spmi-pmic-arb.o
>>
>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>   drivers/spmi/hisi-spmi-controller.c | 1 +
>>   drivers/spmi/spmi-pmic-arb.c        | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
>> index fa068b34b040..3cafdf22c909 100644
>> --- a/drivers/spmi/hisi-spmi-controller.c
>> +++ b/drivers/spmi/hisi-spmi-controller.c
>> @@ -344,6 +344,7 @@ static void __exit spmi_controller_exit(void)
>>   }
>>   module_exit(spmi_controller_exit);
>>   
>> +MODULE_DESCRIPTION("Hisilicon 3670 SPMI Controller driver");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_VERSION("1.0");
>>   MODULE_ALIAS("platform:spmi_controller");
>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
>> index 791cdc160c51..f240fcc5a4e1 100644
>> --- a/drivers/spmi/spmi-pmic-arb.c
>> +++ b/drivers/spmi/spmi-pmic-arb.c
>> @@ -1891,5 +1891,6 @@ static struct platform_driver spmi_pmic_arb_driver = {
>>   };
>>   module_platform_driver(spmi_pmic_arb_driver);
>>   
>> +MODULE_DESCRIPTION("Qualcomm MSM SPMI Controller (PMIC Arbiter) driver");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_ALIAS("platform:spmi_pmic_arb");
>>
>> ---
>> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
>> change-id: 20240609-md-drivers-spmi-51a13baa2301
> 
> Following up to see if anything else is needed from me. Hoping to see this in
> linux-next so I can remove it from my tracking spreadsheet :)

I still don't see this in linux-next.
Adding Greg KH since seems he's been merging this driver.
My hope is to have these warnings fixed tree-wide in 6.11.

/jeff


