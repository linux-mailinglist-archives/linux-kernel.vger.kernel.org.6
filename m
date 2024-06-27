Return-Path: <linux-kernel+bounces-232549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E291AAD6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91761B29236
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37024198827;
	Thu, 27 Jun 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dxDZNlOj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5291990DC
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501205; cv=none; b=fNp60UJ6ZF4pOr3/b0UUMjQAUKLYYH/+gcieOx2z4mBcvkyKbYG+7+yPjsOhwPacfxheSMlRZ53bcQR7uaFC9vdSz4cnGxfgwJS1IZ+fJcheBY7qeHiO8fPZAkT3saAQD6DFcGvgt3C4RL4H4oKsI6otwUhKavuun1HtrICEGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501205; c=relaxed/simple;
	bh=b0Bl3I7ZyZJmDdRgd0Oofe8d/xU1aITCIzFHtf8eK5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tF86VFunTCkXBBDjPmLf7KMXcU6tF9irWfAuIk6+CoVlJUnr7BWFws/l6NOO/u35uD/wx2sFRVp/e6kwbaORN9Z5JKB/N8Ugu2AmqyUpYfS2l1EnbL8wF8sfQUcvoiancL6poBO46N69yRRTF7NAd0xIbtUtW09ls7bKBpDULdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dxDZNlOj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RAmfps018807;
	Thu, 27 Jun 2024 15:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rK+7UYf8PNqgnM274LQjyDEBBGtV0npEEz4LDNIfdNs=; b=dxDZNlOj+5RkueBY
	sXHOi2v5NbmdqImdexocnT0dfU2qX7fq05Ikf+BchxtpcI01/hQjyoyqPAJawAlM
	u8wLMCsyaVE3sTfDEyIUzIFMUCbqnYXEGfYmgeS/yr/hze25wZuvJD1IH0SVULIl
	iXQ5MYRLtKi8E3nZKkZVPVRIP/zwc+weK85r6mBz6lojk2T7ZgkmT9eMtrRNPJgq
	yd4AfHiDZyNGzyyQc7MtJMqNx8ElMuNJN+pWwbW94B1RU0UqthJ7GSnedjR1+YXY
	4mol6m5EsxujC678U4a/XpQMnx+0FRn0oqHAJJ5Rgtz0CYyGl0BoJiKxU7WhtYsp
	O7S8Vw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400f90kyy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:13:19 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RFDI8t030959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:13:18 GMT
Received: from [10.253.8.118] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 08:13:17 -0700
Message-ID: <37978ed1-5f28-40c1-8396-24f4aa6a7a23@quicinc.com>
Date: Thu, 27 Jun 2024 23:13:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] devres: Simple code optimization
To: Greg KH <gregkh@linuxfoundation.org>
CC: <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <d029d754-aeb7-493a-8e48-6acaa53fee1e@quicinc.com>
 <1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com>
 <2024062750-hubcap-parish-7bda@gregkh>
 <179b5505-f64b-4c29-b2df-2eec9e276904@quicinc.com>
 <2024062724-bunion-swept-23b9@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024062724-bunion-swept-23b9@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1D4SDSzD2msh5c5y0fVul0r5qT1CeLdS
X-Proofpoint-GUID: 1D4SDSzD2msh5c5y0fVul0r5qT1CeLdS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270115

On 6/27/2024 10:35 PM, Greg KH wrote:
> On Thu, Jun 27, 2024 at 10:29:43PM +0800, quic_zijuhu wrote:
>> On 6/27/2024 9:54 PM, Greg KH wrote:
>>> On Thu, Jun 27, 2024 at 09:47:16PM +0800, Zijun Hu wrote:
>>>> Initialize an uninitialized struct member for devres_open_group()
>>>> and simplify devm_percpu_match() implementation.
>>>
>>> Huge hint, when you say "and" or "also" in a patch, it's a good idea to
>>> split it up into different commits, right?
>>>
>> you are right.
>> i would like to split this change into two changes within a patchset
>> even if this change is *very* simple.
>>>>
>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>> ---
>>>> This change is intend to replace below one:
>>>> https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/#t
>>>
>>> Why?  SHouldn't this be v2 instead?
>>>
>> this change has different title and maybe be identified as different
>> patch, so i send it as v1.
>>>>  drivers/base/devres.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>>>> index 3df0025d12aa..5b1d498e83ab 100644
>>>> --- a/drivers/base/devres.c
>>>> +++ b/drivers/base/devres.c
>>>> @@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
>>>>  	grp->id = grp;
>>>>  	if (id)
>>>>  		grp->id = id;
>>>> +	grp->color = 0;
>>>>  
>>>>  	spin_lock_irqsave(&dev->devres_lock, flags);
>>>>  	add_dr(dev, &grp->node[0]);
>>>> @@ -1172,9 +1173,9 @@ static void devm_percpu_release(struct device *dev, void *pdata)
>>>>  
>>>>  static int devm_percpu_match(struct device *dev, void *data, void *p)
>>>>  {
>>>> -	struct devres *devr = container_of(data, struct devres, data);
>>>> +	void __percpu *ptr = *(void __percpu **)data;
>>>>  
>>>> -	return *(void **)devr->data == p;
>>>> +	return ptr == (void __percpu *)p;
>>>
>>> What exactly is being "optimized" here?
>>>
>> 1) remove redundant container_of() and devr->data operations
>>    pointer parameter @data already is address of devr->data.
> 
> But do we really know that ahead of time?  If so, how, just by virtue of
> this being the first field?  If so, then no, keep the container_of.
> 
yes. the 2nd parameter for match() must be devr->data by below reasons:
1) devres.c only call match() by this way match(dev, dr->data, match_data).
2) all implements of match() don't do such redundant operations to get
dr->data. such as devm_action_match()/devm_pages_match()/....
3) API user should only know address devr->data and known nothing about
devres internal struct devres. so they should not write their match() by
involving the struct.

for below match() type definition, the 1st parameter @dev have already
have fixed meaning.
typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);

suppose your 3rd question have typo error.
>> 2) compare with right data type
>>     original type of @p is void __percpu * returned by
>> __devm_alloc_percpu().
> 
> It's pointer math, no need for types, right?
> 
yes, it is more simpler for no need for types.
but it think it is more normative to compare with user original types as
this change do.
>> @data is storing a pointer type void __percpu * as shown by below
>> statement within __devm_alloc_percpu().
>> *(void __percpu **)p = pcpu;
> 
> Again, it's not very obvious so you better document the heck out of it
> in your changelog text.
> 
okay, will add comments after code review done.
> thanks,
> 
> greg k-h


