Return-Path: <linux-kernel+bounces-231470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6B919919
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B71C225B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6820819306C;
	Wed, 26 Jun 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N6MSsfdo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5092192B86;
	Wed, 26 Jun 2024 20:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433703; cv=none; b=WAW6PV8moeNqEChx+toD89xVJsVHwUC6yiXr4GReKemEF5C715XK4SSLs5oG0pzIV/QA68C/DzR3RUbRjiNGhluxU/UI67RrFlpxHj4g1GMeFYj+06zqSFKxruyaAcwjIRGV1zMWBa+oS82p07E/2PCCGdRtvArvYQ2R7HG4yJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433703; c=relaxed/simple;
	bh=v2Pn6jDUh8/+T+CxVdwZTDUcmeatg3e/w1LXRKtyNUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MAeugQmMaJVTX7ozu0Vey8A+Kxp9uZrBtPBcKQStCZJzTJMcDJUfuhPOr0MvIhaBE26T0Aw/YNu3qqKcvmbCpcOqaOauvwX4bYodwPZeZi4vuhihUvxF/zg3rzBykHqe7/uXxdbudKRuX7b9e80p5sQeAnqWRUNjuUXNabaufb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N6MSsfdo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfNaB015295;
	Wed, 26 Jun 2024 20:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	z8DskCEILdjj+vXb/2QVw44H3Ar9No/KdokEiE/dJjQ=; b=N6MSsfdo9NSKJEin
	0lPnQ+O8Hbg8GD2V+RGrAliax0xSsjMPEBUqatY+PEUCrX8aRKsVdlngAySWJJMN
	A4XF89hjU7+bnwxlpQ50nOiqVfO88y+2U8527cPvTfLz+T6bHI1GYeSjg3jBayb5
	ECVh3F9MbDnpbbiSbobLzknRbRzoIDFr9bRX6ZmrH4/MopwiBjLYunl8F68Cuopk
	sUJRkTQfRwsEKYoaaqiks/2o76XR/AA4QcGnm3SSf5U5/yoZuURPUHNlJ646n1Je
	sZIDQzR3zFxaRKIw/TzisWTBsWW3ce3IcL+8oyKqPbAIdlwZeyzzV33WoR3xYbBk
	pqDOVw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcm9hva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 20:28:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QKS9pa006381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 20:28:09 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 13:28:08 -0700
Message-ID: <d1c0abfc-bc14-4327-83de-88dcf07f15f1@quicinc.com>
Date: Wed, 26 Jun 2024 13:28:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: add missing MODULE_DESCRIPTION() macros
Content-Language: en-US
To: Alex Elder <elder@ieee.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder
	<elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <greybus-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240607-md-drivers-greybus-v1-1-31faa0b21105@quicinc.com>
 <a132dc0b-2b2c-41db-9d09-4676a3f88535@ieee.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <a132dc0b-2b2c-41db-9d09-4676a3f88535@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IrITrbaihxF-bHx_7eeZLHo34IXy3ADQ
X-Proofpoint-ORIG-GUID: IrITrbaihxF-bHx_7eeZLHo34IXy3ADQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_13,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260149

On 6/26/2024 1:18 PM, Alex Elder wrote:
> On 6/7/24 3:56 PM, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/greybus.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/greybus/gb-es2.o
>>
>> Add all missing invocations of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> I would drop the single quotes, but I don't feel very strongly about it.
> Greg can offer a second opinion (taking the patch or not).
> 
> Acked-by: Alex Elder <elder@kernel.org>

Those were copy/paste from the file prolog, swapping double to single quotes:
 * Greybus "Core"
 * Greybus "AP" USB driver for "ES2" controller chips

I'll spin a v2 dropping the quoting entirely

> 
>> ---
>>   drivers/greybus/core.c | 1 +
>>   drivers/greybus/es2.c  | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/greybus/core.c b/drivers/greybus/core.c
>> index 95c09d4f3a86..c28bb973f67c 100644
>> --- a/drivers/greybus/core.c
>> +++ b/drivers/greybus/core.c
>> @@ -375,5 +375,6 @@ static void __exit gb_exit(void)
>>   	tracepoint_synchronize_unregister();
>>   }
>>   module_exit(gb_exit);
>> +MODULE_DESCRIPTION("Greybus 'core' driver");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
>> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
>> index 1ee78d0d90b4..db4d033925e6 100644
>> --- a/drivers/greybus/es2.c
>> +++ b/drivers/greybus/es2.c
>> @@ -1456,5 +1456,6 @@ static struct usb_driver es2_ap_driver = {
>>   
>>   module_usb_driver(es2_ap_driver);
>>   
>> +MODULE_DESCRIPTION("Greybus 'AP' USB driver for 'ES2' controller chips");
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_AUTHOR("Greg Kroah-Hartman <gregkh@linuxfoundation.org>");
>>
>> ---
>> base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
>> change-id: 20240607-md-drivers-greybus-a13b64e41256
>>
> 


