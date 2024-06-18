Return-Path: <linux-kernel+bounces-219141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B926790CAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481C0B20EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DF613B596;
	Tue, 18 Jun 2024 11:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a14oTl9w"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F913A26E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710211; cv=none; b=StKgjJPFh9k4hxyvuDAhvauEHj5k1TOcPruITpS9R/DF2s4HgzT+T+OWBv0MQpXC4t/Fic8FTNHxeXNzRf/nzLwCVbBlDbbNEQd7+nSUB99VeGEmrGwQD99ACh6jXXGrrfv5tvD/j/AS1rIX3IzAMUW3nteE4estmcOpCyJIbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710211; c=relaxed/simple;
	bh=SdZl0lzNFA6+bFoy69xrA0z4UuPAdPlQ9xOSKSdBNms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vC/kzgqsqFdYhVc8mhLCbR90NxMLhIeK+DOTHhj6A22YsO78FDJYcCbBp0UURE+pFdGwjK7qVP1xOyzHJ9Tcs0t5E1JvyFtmpG2L6gEfD9+c0ScFekkoLlmGGrlIQeo6tPriMeQKDyesT22cFIUjIlSTooNANaxLe3bNkOBLLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a14oTl9w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7UI2S005163;
	Tue, 18 Jun 2024 11:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8o2KhfJ6rcu8IFy/SAe3tszB0Qixa4y7+JbhSmiHSeI=; b=a14oTl9wYzsJSu0P
	ccHRX2kzzmt1GWUAljELnmpA1gYY2KwG3PiCuNDGlERDp9LFkLc79P/HsskbTcsa
	zjEJGasEt4EJ151jvWuz9jH/8TXRUnGuDY+7wcg3S4vp1JJPe6wm/gl+yTstz9NA
	qoQCE9hS0eJ7wWxTFgpE33ew1wWFDWyY7mon1P/Wr8gcmaHMgKEf9iCiulMLxEYM
	GrQ0rP3aTbLU3SGBsckTKvGUS76DqWfwWwgVP/ttkDtS6P8bcAxXjVKhsY+Sw7jw
	QeTZKrPdUQePtHVlkze4Bnd60B0DwRm4qVSQ5yI7QyQChCdOZAnrRH6jWsoVsgfe
	mFUyWA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ytt37a07a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:30:05 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45IBU3L5004002
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:30:04 GMT
Received: from [10.253.13.202] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 04:30:02 -0700
Message-ID: <d029d754-aeb7-493a-8e48-6acaa53fee1e@quicinc.com>
Date: Tue, 18 Jun 2024 19:29:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] devres: Initialize a uninitialized struct member
To: Greg KH <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024061726-payment-editor-7431@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024061726-payment-editor-7431@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jBHCvr99YttQpzs_DCg9OfOZwec00My1
X-Proofpoint-GUID: jBHCvr99YttQpzs_DCg9OfOZwec00My1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=714 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180085

On 6/18/2024 2:14 AM, Greg KH wrote:
> On Mon, Jun 17, 2024 at 09:09:25PM +0800, Zijun Hu wrote:
>> Use memset() after kmalloc() a struct devres_group to initialize
>> potential uninitialized members such as @color within kernel API
>> devres_open_group() as alloc_dr() does.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/devres.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>> index 3df0025d12aa..ba3e4603cd77 100644
>> --- a/drivers/base/devres.c
>> +++ b/drivers/base/devres.c
>> @@ -558,6 +558,10 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
>>  	if (unlikely(!grp))
>>  		return NULL;
>>  
>> +	/* No need to clear memory twice */
>> +	if (!(gfp & __GFP_ZERO))
>> +		memset(grp, 0, sizeof(*grp));
> 
> Is this an actual bugfix (i.e. do we have uninitialized fields today?)
> 
no, maybe take it as code optimization instead of bugfix.
yes, field grp->color is NOT initialized.
> If so, what commit does this fix?
> 
> thanks,
> 
> greg k-h


