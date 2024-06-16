Return-Path: <linux-kernel+bounces-216235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A84DA909CF4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 490ED1F212E2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34927186E49;
	Sun, 16 Jun 2024 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B/5goS/J"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30473481A3
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718533374; cv=none; b=Ai5IrZ2upP0XZFeFOFWOg8yDZK0vvVhYxbBPLssgRN1mira3rKXdEFYs2qFO3w67i0mW95y7hkFEJ6mrYZzvtd5PWu92ZxVA6E5b9n90vHLioA19n/66+4okH71+SB0w0kWjqztZ3PD772IXiu5N6m4FQRkxIDXPVwHzRkNJykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718533374; c=relaxed/simple;
	bh=sYO9NeuJqNKBID+k3qRtHms51St0HKMyUiFaTskoEzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YWbtW3TPrMO1dvqYE7yHO+CVLm40Q2eum2Dvar9H+GF74i7OkQWOn6bYMtuyMRkTw96RC5/wgTJ5QTdbD5C8yIckCRCgk3dFL/nyqzLH6gkdHpaPRRuOx5zpTzflL2FpTSlTREuCj98DL5wm25KqNzG0F44vEmtGkuWHmAyQhHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B/5goS/J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45GA8vRI014614;
	Sun, 16 Jun 2024 10:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dasFv6R7c0+QXKfO+eNPGokRdSJhsZCbslrcFO/dyBE=; b=B/5goS/J/4EVQW+a
	bOIYToWApvHsgUpl1md0JwRIUHfTxTrEwq9tcRRZYeq+qSgdwqbOGQZpfk/pRFLi
	zluY3bOtIh5F16faYFXPXkPmR4Nkm+EKqgJ6JzNF/gfFmi21+W8wurlJgbq1RPvi
	h0kGjBvNhaKo2cxamAx+XelLix4AAPbBhJ+Fazf/AdJZD4rWaDql+jKQMPd50xCU
	cDgpGV4Q11lypbmgJhnbjqCZ9ycDRqhn0FW7k1DDQ0s0WFLFAIhx5N6EPolhaSZr
	k4KDadSsC9A4zlgUh8SgIzAIEB52hGylD3IthMoSnPx7P77Gs9SweT+3nQqPFaB4
	BPqMMw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys1wr1t0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 10:22:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45GAMln6020607
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 10:22:47 GMT
Received: from [10.253.10.202] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 16 Jun
 2024 03:22:45 -0700
Message-ID: <d2679169-4334-4939-8ec8-3af142ebbb3f@quicinc.com>
Date: Sun, 16 Jun 2024 18:22:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] devres: Fix devm_krealloc() allocating memory with
 wrong size
To: Greg KH <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <andriy.shevchenko@linux.intel.com>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>
References: <1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024061609-breezy-magnitude-8edf@gregkh>
 <4f691c9c-8882-4bd7-ba60-3fc665d0808c@quicinc.com>
 <2024061611-cyclist-hardiness-c15f@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024061611-cyclist-hardiness-c15f@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: prZn7W4KzlMrOTz7rlZufs-jAKy8bGPv
X-Proofpoint-ORIG-GUID: prZn7W4KzlMrOTz7rlZufs-jAKy8bGPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406160081

On 6/16/2024 6:17 PM, Greg KH wrote:
> On Sun, Jun 16, 2024 at 06:10:02PM +0800, quic_zijuhu wrote:
>> On 6/16/2024 6:02 PM, Greg KH wrote:
>>> On Sun, Jun 16, 2024 at 05:54:15PM +0800, Zijun Hu wrote:
>>>> Kernel API devm_krealloc() calls alloc_dr() with wrong argument
>>>> @total_new_size, and it will cause more memory to be allocated
>>>> than required, fixed by using @new_size as alloc_dr()'s argument.
>>>>
>>>> Fixes: f82485722e5d ("devres: provide devm_krealloc()")
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>>  drivers/base/devres.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>>>> index 3df0025d12aa..1cf87ddf1f55 100644
>>>> --- a/drivers/base/devres.c
>>>> +++ b/drivers/base/devres.c
>>>> @@ -898,7 +898,7 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
>>>>  	 * taking the lock as most probably the caller uses GFP_KERNEL.
>>>>  	 */
>>>>  	new_dr = alloc_dr(devm_kmalloc_release,
>>>> -			  total_new_size, gfp, dev_to_node(dev));
>>>> +			  new_size, gfp, dev_to_node(dev));
>>>
>>> Wait, are you sure?  Did you properly test this?  What is the actual
>>> savings and how do you handle the fact that you are now not allocating
>>> the space reserved for the devres structure itself?
>>>
>> sure even if i did not test it.
>> beware that alloc_dr() will call check_dr_size() to reserve space for
>> devres structure.
>>
>> it will reserve the devres structure two times if using wrong
>> @total_new_size. it is obvious wrong.
> 
> Ah, I missed that, that is tricky.  Please document this better when you
> resubmit a new version.
> 
okay. will send v2.
> And of course, please test it.
okay.
> 
> thanks,
> 
> greg k-h


