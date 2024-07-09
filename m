Return-Path: <linux-kernel+bounces-245043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F292AD7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AB21C213C1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 01:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B532AE95;
	Tue,  9 Jul 2024 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gWnEutDF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47827269
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720487095; cv=none; b=uncPRRZXFIctyaSHoI/Mb3D4SgFbZ1v6YHZCwAwVLXW4zPjevEFVuPQhkhe0M2NH+dpx2tdFgj+2Cn+ECfj4buJsl/YudWtKoKJ1JXKDinnArhsEDt6SWJvOAPiJQa+ImQcrGOnRQ3E6ihnUXDJCsazEC8rijVziKGK7m4VdDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720487095; c=relaxed/simple;
	bh=GKrX/SAlf/AthAEOO9Vue4N/gi7OxPo3+l209YVXGbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YYQYLXQUQZFy+z5EVndcQp45AljH8Dq6JY4G7SdJIXIO8a6/t60iRpEDqm28UP1G9eyZYvve6MQrJcIGkPGHSAHOBrDlXnu4WNP5UlTZd1qZ18vFqCOo9cKW2hlTtXkUCWQwTVvi/j1ZdyznVUJUmBwXr3ndVA8O/nq5D2Q+Sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gWnEutDF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468NorAi018665;
	Tue, 9 Jul 2024 01:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BS5I75+H8x13f1B8KfKwBuZ0YFzz42LgQKig2a3ZeIU=; b=gWnEutDFsOtuOz06
	ZJEvkXcuw4B4v9ehD7a5AKn8Xv6kR7V8PoGoJTIy+UrB6z5fuvHFrXA8G38w6AqO
	s0c+B+sewD8LLvEHlA8w7aarMhCVyzpXWxvqyHwzwINbCXjNcVgD9uQo+2kYm7G8
	ix2Heq8ohJ9WVMbTHLIk9WV/jF6xC4w98oP+b2Bv6eiPs0XYiZQlUqb0C7tAnJJf
	7ccbyjZnjNdRWfbsx2xemyHPg4i3pVi7bP8Z1qG1ER5t+iQwfKYe6JBTtosgdp66
	BVtfDe7LSfjlSNUS2BR9x1riaT41kEqEPXbDXspDPnYwg6uHkJjn1Dqx+duyNtLd
	vYsvGg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y77n0h2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 01:04:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46914d8s020522
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 01:04:39 GMT
Received: from [10.253.14.85] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 18:04:37 -0700
Message-ID: <b8e704f9-7392-4925-9593-e4a9da045e86@quicinc.com>
Date: Tue, 9 Jul 2024 09:04:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: Fix size calculation of symlink name for
 devlink_(add|remove)_symlinks()
To: Saravana Kannan <saravanak@google.com>, Zijun Hu <zijun_hu@icloud.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240707-devlink_fix-v1-1-623acb431cd8@quicinc.com>
 <CAGETcx8YwD-cWYFJ72rfSfmrnoY=rv9oc_2KCK9_AF34Evw7wg@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CAGETcx8YwD-cWYFJ72rfSfmrnoY=rv9oc_2KCK9_AF34Evw7wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6-VJnI2IdQVP54T7cDJIXMeBVVAtDj13
X-Proofpoint-ORIG-GUID: 6-VJnI2IdQVP54T7cDJIXMeBVVAtDj13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_14,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090005

On 7/9/2024 6:43 AM, Saravana Kannan wrote:
> On Sun, Jul 7, 2024 at 6:24 AM Zijun Hu <zijun_hu@icloud.com> wrote:
>>
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> devlink_(add|remove)_symlinks() wants to kzalloc() memory to save symlink
>> name for either supplier or consumer, but forget to consider consumer
>> prefix when calclulate memory size, fixed by considering prefix for both
>> supplier and consumer.
> 
> No, I didn't forget to take "consumer" into account :) Both supplier
> and consumer are the same length. So I didn't bother doing both. I
> don't see a point behind this patch.
> 
it is not obvious for code readers that "supplier:" and "consumer:" have
the same string length.

code readers maybe need to count characters one by one for both strings
to confirm both have the same length.
>>
>> Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> 
> It's definitely not "Fixing" anything because nothing is broken.
>this change maybe fix algorithm or procedures to calculate the size to
kzalloc() even if it don't change the resulted size.

> Nack.
>> If you really want this in, remove this tag and send it again. I won't
> ack or review it though as I don't think it adds much value. Greg can
> take it if he thinks he likes it.
> 
okay, will send v2 which will remove the fix tag, i feels this change is
worthy due to below reasons:

1) readers is easier to understand the algorithm or procedures to
calculate the resulted size.

2) readers don't need to take extra effort to confirm that fact that
both string have the same length.

let us wait for Greg's opinions.
> -Saravana
> 
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/core.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 2b4c0624b704..f14cfe5c97b7 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -572,7 +572,7 @@ static int devlink_add_symlinks(struct device *dev)
>>         len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>>         len += strlen(":");
>> -       len += strlen("supplier:") + 1;
>> +       len += max(strlen("supplier:"), strlen("consumer:")) + 1;
>>         buf = kzalloc(len, GFP_KERNEL);
>>         if (!buf)
>>                 return -ENOMEM;
>> @@ -623,7 +623,7 @@ static void devlink_remove_symlinks(struct device *dev)
>>         len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>>         len += strlen(":");
>> -       len += strlen("supplier:") + 1;
>> +       len += max(strlen("supplier:"), strlen("consumer:")) + 1;
>>         buf = kzalloc(len, GFP_KERNEL);
>>         if (!buf) {
>>                 WARN(1, "Unable to properly free device link symlinks!\n");
>>
>> ---
>> base-commit: c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
>> change-id: 20240707-devlink_fix-0fa46dedfe95
>>
>> Best regards,
>> --
>> Zijun Hu <quic_zijuhu@quicinc.com>
>>


