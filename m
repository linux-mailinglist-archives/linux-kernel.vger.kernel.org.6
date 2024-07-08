Return-Path: <linux-kernel+bounces-244419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA09892A40D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3981F21977
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41DE13A400;
	Mon,  8 Jul 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PQUaODyn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9EA5381B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446661; cv=none; b=gTaWzys3oNTpLPMNy4602v3tZDG2OEwsayUN0FGgMRYqJCSNN0hqNQt38ImkGcvcpvNEEcF54gpV+CefHo8sLzKtvn0lAooq2/6o+O7zcCb/Zbh2TdcoPKY8skU4P5hKmnN6ljYI2SBpOW70r1gcrF5YGLt6z5FJ+bNb+P586x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446661; c=relaxed/simple;
	bh=ErfxnE1QtOx539jhVj0UMiBkfS53AdOyd10ZtlQwUXI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=I8+s4feO2G3g8zXG0ACtkCz9TrfZLgHqdLWxItISZT9GzkxXIByEGQlNEupuFZfNdCd0ke24UwiyQvHge3GyPZ8KAhz+qweMamKl2qotGGda/r59Nd1qPYRhQGFStmuNIpCmjFcpH0whj8DFnQysfaRVarxTXavVLSAdmAMA0e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PQUaODyn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468BPDae028546;
	Mon, 8 Jul 2024 13:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PnUPyQCMMPiqKaGefYWb1FkezKyHgZdvyDbiDlFOnA=; b=PQUaODynRUj8sd3a
	CCFf4wk1SyZZjG9ofSChPCN7nXnBTXMEnWoVqD/YivCzV28tf16cC4boAtXRpPjN
	RvkyqMex8Z+XOltOPT3bszgQ3Wohlp9W0vaM9XyWKHTzfr1/WPUVcIdKDyEvFx2M
	T1XwlkSJQElKqV3OXC/Tx0Jiq/6QPWjcY2ybLBCmhVKsSlx9p5Y26Bujayq+037Q
	39lTNM/bvUTxrIvI7xOmjB7xBbWeepzjeBk47MtmHKzRY2KN4t5Ln+3WObbKhFKJ
	mQdCcNukBLGNySKWAalIEo/2ATeMyIziAF0zQg4VR6p+8L3Ko7rcNa6tkGqis0eR
	wN5MXQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wjn3u94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 13:50:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 468DoqSo013515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 13:50:52 GMT
Received: from [10.253.36.134] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 06:50:50 -0700
Message-ID: <12e5dade-8ef3-4532-aff6-b78b87dc0147@quicinc.com>
Date: Mon, 8 Jul 2024 21:50:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] devres: Simplify devm_percpu_match()
 implementation
From: quic_zijuhu <quic_zijuhu@quicinc.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <madalin.bucur@nxp.com>
References: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
 <1719931914-19035-5-git-send-email-quic_zijuhu@quicinc.com>
 <2024070424-deplete-dangling-bcc6@gregkh>
 <4ecbe215-6b73-48ea-8e8d-831e3682754c@quicinc.com>
Content-Language: en-US
In-Reply-To: <4ecbe215-6b73-48ea-8e8d-831e3682754c@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uYlsu01m3opJpryJ0_jlo9oAZMoC6GrA
X-Proofpoint-GUID: uYlsu01m3opJpryJ0_jlo9oAZMoC6GrA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080104

On 7/4/2024 9:17 PM, quic_zijuhu wrote:
> On 7/4/2024 6:34 PM, Greg KH wrote:
>> On Tue, Jul 02, 2024 at 10:51:53PM +0800, Zijun Hu wrote:
>>> Simplify devm_percpu_match() implementation by removing redundant
>>> conversions.
>>>
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> ---
>>> Previous discussion link:
>>> https://lore.kernel.org/lkml/1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com/
>>>
>>> Changes since the original one:
>>>  - Select the simplier solution
>>>
>>>  drivers/base/devres.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>>> index e9b0d94aeabd..2ad6dacb3472 100644
>>> --- a/drivers/base/devres.c
>>> +++ b/drivers/base/devres.c
>>> @@ -1176,9 +1176,8 @@ static void devm_percpu_release(struct device *dev, void *pdata)
>>>  
>>>  static int devm_percpu_match(struct device *dev, void *data, void *p)
>>>  {
>>> -	struct devres *devr = container_of(data, struct devres, data);
>>> -
>>> -	return *(void **)devr->data == p;
>>> +	/* @data is already and must be (void *)devr->data */
>>> +	return *(void **)data == p;
>>
>> The compiler output should be identical here, right?  And container_of()
> yes, you are right.
>> enforces the placement so I'd prefer the original here as a comment
>> isn't going to enforce anything :)
>>
> i would like to show 2 different points related to the comments below:
> 
> 1) the comments is applicable for *ALL* kinds of devres match()s, and is
> *NOT* specific to devm_percpu_match() and also does *NOT* enforce anything.
> 
> may i remove the comments?
> 
> 2) the original implementation is *NOT* normative as explained below:
> include/linux/device.h:
> typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
> void *devres_find(struct device *dev, dr_release_t release,
> 		  dr_match_t match, void *match_data);
> 
> devres API users maybe need to write their match() functions, for
> example, user of API devres_find(), but struct devres is a devres
> internal implementation defined within devres.c and is *NOT* exposed to
> API user by device.h, so API user should not use struct devres when
> implement their devres match() normally.
> but original devm_percpu_match() uses the struct devres.
> 

thanks for your code review.
may i know which of below options is your final preference?

A) remain current kernel design, namely, no changes.

B) changes shown by this [PATCH v1 4/5]

C) below changes we ever discussed by below link
https://lore.kernel.org/all/1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com/

 static int devm_percpu_match(struct device *dev, void *data, void *p)
 {
-	struct devres *devr = container_of(data, struct devres, data);
+	void __percpu *ptr = *(void __percpu **)data;

-	return *(void **)devr->data == p;
+	return ptr == (void __percpu *)p;
 }

>> thanks,
>>
>> greg k-h
> 


