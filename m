Return-Path: <linux-kernel+bounces-250763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF12192FC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9404C282706
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7F917166D;
	Fri, 12 Jul 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DFHTzslK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86428F58;
	Fri, 12 Jul 2024 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794128; cv=none; b=OOTPNg8RdwldvYu4xlhCuXxAXWLmoRJK5eoa+/zO+BBVbbknLE6QqyY8mlUgFVoTqaajYcd+kXYUJRmUXVs/xBoJmYXAbxq5id2Z2cd2+usJ9y1hISiJOn7UMMWbw2vcJFdPjVtzTcLNWy0zZY7vbctVbhwonuMXFmuTUjOQY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794128; c=relaxed/simple;
	bh=1X2h1pP3P9bEY0dhKtPEte/MDMdHXeYYEYq0BALA4wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aGdNcuVzTopJ4nDuon9IqQO62H0OwXHg42UUNi9Pa1fYddgGy5AcpJkKkeqKILM50aSK1QmdzgeWNfVLSCx9p+K7iKA/RUNZJwPWAwbBHUbH6/vYFsJu/czXddLZxEsHzZvHJWS0D/GqxJZG6myuBHao+AyWaawm2aJRMDzm7pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DFHTzslK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46C5eSW2017618;
	Fri, 12 Jul 2024 14:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q4dCjN7RFCWVafWDh+lIi4XYXTLCjqM699IDxs58Tmc=; b=DFHTzslKRy8niAYB
	sfp1jlSj9rawPFAMdVTA1RuYiYjlMQwFpSwsrhVqopQt/r4GhqKFrLUobv7ecfBW
	xs0u3bc6zSkMLZ1xjBnmeU6rtzN3VvU2sJDiEe7jVoyvgvwYMjjFROYiOb7hnRx/
	8blL0hbLfkBYh8Bohaotm7VNFL5NMnQL1FAV9C9hJitU12ofiqmdJrUm6rahYeun
	u21Jchrp0e6jgkU4rA2uGAXnojMbZfFPGRJ89Zqt3Zu+Z1D19Akn/RKKv8nEUK37
	aCuKrKDdecIFCJ/7tpr04PzmM60s66zhth+ZMc7Ur5R+lskeYk86JqlBMhjBYFEi
	uK+eVw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40a8uhv9dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 14:22:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46CEM1vl002959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 14:22:01 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Jul
 2024 07:22:00 -0700
Message-ID: <7a01ee4b-73af-3818-ecd5-cce5e270eeb6@quicinc.com>
Date: Fri, 12 Jul 2024 08:22:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] agp: uninorth: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jeff Johnson <quic_jjohnson@quicinc.com>,
        David Airlie
	<airlied@redhat.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240615-md-powerpc-drivers-char-agp-v1-1-b79bfd07da42@quicinc.com>
 <99d6c483-9291-4bd0-8e62-76022abb762c@quicinc.com>
 <7b7e2952-fb54-48b0-93bc-f96c04e5cdd3@quicinc.com>
 <ce7863a7-f84e-42f0-9aa5-54b43edcd260@quicinc.com>
 <2024071209-squatting-nacho-60b0@gregkh>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <2024071209-squatting-nacho-60b0@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i4nPaeiFe4MMA_TcMwjt-3Hm4iydEraN
X-Proofpoint-ORIG-GUID: i4nPaeiFe4MMA_TcMwjt-3Hm4iydEraN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-12_10,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407120097

On 7/12/2024 1:31 AM, Greg Kroah-Hartman wrote:
> On Thu, Jul 11, 2024 at 01:27:23PM -0600, Jeffrey Hugo wrote:
>> On 7/11/2024 12:19 PM, Jeff Johnson wrote:
>>> On 6/28/24 20:14, Jeff Johnson wrote:
>>>> On 6/15/2024 2:01 PM, Jeff Johnson wrote:
>>>>> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
>>>>> WARNING: modpost: missing MODULE_DESCRIPTION() in
>>>>> drivers/char/agp/uninorth-agp.o
>>>>>
>>>>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>>>>
>>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>>> ---
>>>>>    drivers/char/agp/uninorth-agp.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/char/agp/uninorth-agp.c
>>>>> b/drivers/char/agp/uninorth-agp.c
>>>>> index 84411b13c49f..b8d7115b8c9e 100644
>>>>> --- a/drivers/char/agp/uninorth-agp.c
>>>>> +++ b/drivers/char/agp/uninorth-agp.c
>>>>> @@ -726,4 +726,5 @@ MODULE_PARM_DESC(aperture,
>>>>>             "\t\tDefault: " DEFAULT_APERTURE_STRING "M");
>>>>>    MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
>>>>> +MODULE_DESCRIPTION("Apple UniNorth & U3 AGP support");
>>>>>    MODULE_LICENSE("GPL");
>>>>>
>>>>> ---
>>>>> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
>>>>> change-id: 20240615-md-powerpc-drivers-char-agp-db644db58c24
>>>>
>>>> Following up to see if anything else is needed from me. Hoping to
>>>> see this in
>>>> linux-next so I can remove it from my tracking spreadsheet :)
>>>
>>> I still don't see this in linux-next.
>>> Adding Greg KH since he's picked up many of these fixes.
>>> Hope to have all of these warnings fixed tree-wide in 6.11.
>>
>> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>
>> Dave, this seems like a trivial fix that is stuck, but normally routed
>> through DRM.  I hope I'm not over stepping, but I think I'll drop this in
>> drm-misc-next on the 19th if there isn't any other activity.
> 
> I can take it now, otherwise you will miss the 6.11-rc1 merge window.

Works for me.  Thanks Greg!

-Jeff

