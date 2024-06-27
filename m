Return-Path: <linux-kernel+bounces-232467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7E691A935
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75881F24FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F95195803;
	Thu, 27 Jun 2024 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cq2P8lm5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F12139A8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719498592; cv=none; b=KKQdtmixCazt4qeyBijamjBMM5ACmW51OXVypxJsLifH846frt71kTqyYo0nDyTCe39GOm1rfIaofuuw662sc4BQqJ4OJezpx4rWO+95F/J29VjbdL6rNDZyP+AMONedgdRiaXeYxy6sEe6MxfZwUNfjch8HA2kvckm72D6Dtco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719498592; c=relaxed/simple;
	bh=GjbNCX4hUDbB4PVuq5yD/mukdZ7hDTBj3OOb9DJoeo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gFFiK1xW42uXAdUtxBwWOaJG+cOtm6nNv4ynrXMecEonxwjFXJDG27xuOEvHoZTgPfwWRobdRcUOvjYnAWOvqsCvLM04dPz4/E0SkiknJFurquWKX09pSGe8ZYzwwZBYgZfNlJiH08O3Kq0CvHGfsnlzF1pZXaz6N4YVpU1nZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cq2P8lm5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RA52il015330;
	Thu, 27 Jun 2024 14:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hm1svVagmePIW3YaP3+uICqYE4oqtwcdlzx6F6VnUDs=; b=cq2P8lm5yJfdf0al
	u53n0tYRA1EmLOHeW/AJcjxINW8SFdYueOJGmQsj4eaX95aZ1V/NErG5aW3hem8t
	v2aJLgVcpaaMOL8Q9Rtn4D3PUHFko4GSUJcYy7DMvteLVK7/Nx2OZT4JM8ZblB71
	eq0TySKgearso4tNQN1pZjfaFH+IvJVPtgNmVAc+VHTc+ULflgJJteZ8Sd8V7j8O
	IC3ud5mdfH1RSU6N6UncfRJvnqN7PZfjPXieqiU5pQhjkHWeaMbA1wIaS0R+0Uje
	oIQuK38cgGfXQRnvH7j3LQyzdFG+xFmgDd3eoWIMgNNTAvtutxFLr7pU2QoGxbxh
	oPy90w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcmbp3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:29:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RETkOK013559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:29:46 GMT
Received: from [10.253.8.118] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 07:29:45 -0700
Message-ID: <179b5505-f64b-4c29-b2df-2eec9e276904@quicinc.com>
Date: Thu, 27 Jun 2024 22:29:43 +0800
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
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024062750-hubcap-parish-7bda@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: apDcWUgaT_1jEV0pNrYaaEu6Qn4o2r-s
X-Proofpoint-ORIG-GUID: apDcWUgaT_1jEV0pNrYaaEu6Qn4o2r-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270109

On 6/27/2024 9:54 PM, Greg KH wrote:
> On Thu, Jun 27, 2024 at 09:47:16PM +0800, Zijun Hu wrote:
>> Initialize an uninitialized struct member for devres_open_group()
>> and simplify devm_percpu_match() implementation.
> 
> Huge hint, when you say "and" or "also" in a patch, it's a good idea to
> split it up into different commits, right?
> 
you are right.
i would like to split this change into two changes within a patchset
even if this change is *very* simple.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> This change is intend to replace below one:
>> https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/#t
> 
> Why?  SHouldn't this be v2 instead?
> 
this change has different title and maybe be identified as different
patch, so i send it as v1.
>>  drivers/base/devres.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
>> index 3df0025d12aa..5b1d498e83ab 100644
>> --- a/drivers/base/devres.c
>> +++ b/drivers/base/devres.c
>> @@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
>>  	grp->id = grp;
>>  	if (id)
>>  		grp->id = id;
>> +	grp->color = 0;
>>  
>>  	spin_lock_irqsave(&dev->devres_lock, flags);
>>  	add_dr(dev, &grp->node[0]);
>> @@ -1172,9 +1173,9 @@ static void devm_percpu_release(struct device *dev, void *pdata)
>>  
>>  static int devm_percpu_match(struct device *dev, void *data, void *p)
>>  {
>> -	struct devres *devr = container_of(data, struct devres, data);
>> +	void __percpu *ptr = *(void __percpu **)data;
>>  
>> -	return *(void **)devr->data == p;
>> +	return ptr == (void __percpu *)p;
> 
> What exactly is being "optimized" here?
> 
1) remove redundant container_of() and devr->data operations
   pointer parameter @data already is address of devr->data.
2) compare with right data type
    original type of @p is void __percpu * returned by
__devm_alloc_percpu().

@data is storing a pointer type void __percpu * as shown by below
statement within __devm_alloc_percpu().
*(void __percpu **)p = pcpu;

> And where did the container_of go?  You just lost all type-safeness.
> 
see above comments 1) and 2).
> thanks,
> 
> greg k-h


