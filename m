Return-Path: <linux-kernel+bounces-371355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14B89A39F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE0F1C21D8D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371571EF925;
	Fri, 18 Oct 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="orjs9Wyx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F2188A3A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243757; cv=none; b=czOFiqsfd4qv2D6C8qff+21dl4O6PVYTPXbi+cZfU16DOYN6YgvAHhS5SXkVcVnf7kF+R0yMbvw3Snz4UZfE/nWqOZOAXzaKVxFYpACt/a+xl/BFFDcEyQNs2tOdsAGnUosi7WGINGDfXMNbOChVkaCbguCeZBBwSMy9Lij3gS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243757; c=relaxed/simple;
	bh=7p1D/7aFRGRy9nORbY0bogM03UGavmZrL9HEMl4m2IM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZU/3PfwgIZI53RI9fK2Czu0S28sCGnaCqPo1a2uS7GFbU2/jZ6mXCWzON68f2dPsUhaI17tNzuckd48z4ZW0JfP7GAR9LiEXhl3Fqun6E2c0LqxGu5htwWqGBI9147DBg0tXCNpsusIizTqGkzUoUgtObjM/tCSfVzgmidi43uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=orjs9Wyx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I9M2r0027144;
	Fri, 18 Oct 2024 09:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RruHV/tPB925/7gXdo4lwFw257jpsBEdtI1FZeuatgA=; b=orjs9WyxEym9K8sL
	/qps6r2WZvSpCHDEW+eh5xUoSJ+LXJzXOaT8rrRIFXyEKFwpi/4+DqhwetYLmz4T
	j7SFRFDzyNJj9v+ceEFlJ/blrmzcq7jSTt6xkDYKIN6zncGiCxbrO3J0aOZbPJ1y
	PurQAjzcvN6hYRFPA2e8dh60+be/xeIMhjq6Vr43tcu+J/I8FXTWpaEIPy9DQpTm
	YlP2epCP6OrzflI8CgPlEBs1VsUhXvGRygyw7yZVYJaFRSOzRFiKIvp8aRhNdTI5
	XaVj6x9AWsFeAaP6yYq7n36vr6YC+EcDa+yuujDbr4lqkFej5gTr44n/w+XMlA9L
	63tSiA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ay8jbqv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:28:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49I9Sv45012758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 09:28:57 GMT
Received: from [10.253.35.131] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 18 Oct
 2024 02:28:56 -0700
Message-ID: <fa7268e4-24a9-4ddb-8477-e4959a6105ad@quicinc.com>
Date: Fri, 18 Oct 2024 17:28:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq/devres: Simplify API devm_free_irq()
 implementation
To: Thomas Gleixner <tglx@linutronix.de>, Zijun Hu <zijun_hu@icloud.com>
CC: <linux-kernel@vger.kernel.org>
References: <20241017-devres_kernel_fix-v1-1-4aa0d7c4fee4@quicinc.com>
 <87y12m8o76.ffs@tglx> <07f223e0-9a42-4637-a081-a057025e216f@icloud.com>
 <87sest94ag.ffs@tglx>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <87sest94ag.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BCrsb_fDRSkAFmuLCwR4lja9USqCE30J
X-Proofpoint-ORIG-GUID: BCrsb_fDRSkAFmuLCwR4lja9USqCE30J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1011
 mlxlogscore=702 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180060

On 10/18/2024 4:57 PM, Thomas Gleixner wrote:
> On Fri, Oct 18 2024 at 06:36, Zijun Hu wrote:
>> On 2024/10/18 04:33, Thomas Gleixner wrote:
>>>> It is simpler if devm_free_irq() is undoing what any devm_request_irq()
>>>> variant did, otherwise, it can avoid wrong and undesired free_irq().
>>>
>>> This is confusing at best. What's the wrong an undesired free_irq()?
>>>
>> for current devm_free_irq(..., irq_A, ...):
>> it is undesired if irq_A is requested by request_irq().
>> it is wrong and dangerous if irq_A was never requested.
> 
> There is nothing dangerous about it if it was never requested.
> free_irq() won't find a irq action which matches devid and do nothing
> than emitting a warning.
> 

you are right. it is not dangerous but a unnecessary call of free_irq().

> But that's not relevant either because there is no matching devres entry
> when the interrupt was not requested via devres_request_irq(), so
> free_irq() will not be reached because devres_destroy() will return
> -ENOENT.
> 
no, WARN_ON(devres_destroy()) doesn't return, the next free_irq() will
be still reached.

> So all this change does is changing the logic from:
> 
> devres_free_irq()
>     if (devres_destroy())
>         return;
>     free_irq();
>     
> to
>     devres_release()
> 

if irq to free was ever requested by devm_request_irq()
then both logic is exactly same.

otherwise, actually change devres_free_irq()'s logic from

if (irq is not requested by devm_request_irq() {
	warn;
}
free_irq()

To

if (irq is not requested by devm_request_irq() {
	warn;
	return;
}


> where devres_release() does the same thing as the above, i.e. it looks
> up the devres for a match and if found, it removes and frees the devres
> pointer and invokes the release function which in turn invokes
> free_irq().
> 
> So in terms of code logic this is exactly the same and does neither
> avoid or prevent anything.
> 
> All it does is sparing a single line of code.
> 
> Thanks,
> 
>         tglx
> 
> 
> 
> 


