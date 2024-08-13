Return-Path: <linux-kernel+bounces-284570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D1950297
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47ECA1C21935
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20634194083;
	Tue, 13 Aug 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F+AuUSQ5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912718A95E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545601; cv=none; b=jIpT5n71URjIE6ovjUAgY0Y+tl+diQOZVkdKJreAOII03C3fcOu7MkJoSdXQMnGA1mXH0+dk2f+oq7Vm+ExJ+n7f5uEkwiTSNgnrHzkkJ+r+Zu2ZQiityGKtOuDgVdnnz9icG4TfQ+Mf9oMiIiLy3RZe5WWMMrELpc4kRL0zfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545601; c=relaxed/simple;
	bh=JFh90kbBWBwh8qaX/DCsvm5ish7a4ZDUXtiPuT0x89M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FPoqtSTIU3AvaKKkkq+cYydp58b+S8GkZ0y9qvwOKc+E7MSbvCi5GhYrYq9onnFV9AIQduyiqpzn/gY3Y0FZxiGucBcL7rB4HrEyv1NdrncqPuGDA7W7Zmg8odcq5M2uzz67A2U7ulxYe1TCoPuu9DXGtX1uX6ddy9vVL6Ttnns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F+AuUSQ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D8Miod004767;
	Tue, 13 Aug 2024 10:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8PhfdFuR+qxOd97ORVRNkohsTrefC2OY0raC7HcFnbg=; b=F+AuUSQ5q9oQB7zi
	kUS8vQScuZBHVxhAoia2IAiKUb1Ui1r3I6iQtg3XBf8vegvc1xkh0gvWP8KJPqPa
	+4YgNagoYtuYf+Xz/4zs0RVkgDGrmUd6zFWEuK7WeRtN3uIunFz8chD60Ehccbhl
	IUU/V+3UxTbZbmuaNRgDa7bzhfxFIFTiQMS3bVsVe/hZLaL9oYIdqDEfM0XICTZh
	oE+a02QJhwpH69LzuuxcVUCni7ZnMRaEiEiDLU1xWmhOGEzoKkRQmCINrbTYmYaY
	BzBXI72h9qzi7hXoaxu81D4b4XwhnZnpOwQqYJU/iVXAlPcmxjQSkKZuPss3dUkG
	zxI4Ew==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103ws0dej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:39:52 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DAdpxo008219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 10:39:51 GMT
Received: from [10.253.34.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 03:39:50 -0700
Message-ID: <f9cdd4eb-7c2c-403b-bfd2-06b48a7ca92c@quicinc.com>
Date: Tue, 13 Aug 2024 18:39:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] driver core: Constify driver API
 device_find_child()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com>
 <20240811-const_dfc_done-v1-1-9d85e3f943cb@quicinc.com>
 <2024081359-dart-transpire-8143@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024081359-dart-transpire-8143@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BDQDRENdM0Za-wc_rbX4nTJ41QRu1pUt
X-Proofpoint-ORIG-GUID: BDQDRENdM0Za-wc_rbX4nTJ41QRu1pUt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130076

On 8/13/2024 5:48 PM, Greg Kroah-Hartman wrote:
> On Sun, Aug 11, 2024 at 10:24:52AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> Constify the following driver API:
>> struct device *device_find_child(struct device *dev, void *data,
>> 		int (*match)(struct device *dev, void *data));
>> to
>> struct device *device_find_child(struct device *dev, const void *data,
>>                                  device_match_t match);
>> typedef int (*device_match_t)(struct device *dev, const void *data);
>> Since it should not modify caller's match data @*data.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>>  drivers/base/core.c    | 11 +++--------
>>  include/linux/device.h |  4 ++--
>>  2 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>> index 3f3ebdb5aa0b..f152e0f8fb03 100644
>> --- a/drivers/base/core.c
>> +++ b/drivers/base/core.c
>> @@ -4062,8 +4062,8 @@ EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
>>   *
>>   * NOTE: you will need to drop the reference with put_device() after use.
>>   */
>> -struct device *device_find_child(struct device *parent, void *data,
>> -				 int (*match)(struct device *dev, void *data))
>> +struct device *device_find_child(struct device *parent, const void *data,
>> +				 device_match_t match)
>>  {
>>  	struct klist_iter i;
>>  	struct device *child;
>> @@ -4108,11 +4108,6 @@ struct device *device_find_child_by_name(struct device *parent,
>>  }
>>  EXPORT_SYMBOL_GPL(device_find_child_by_name);
>>  
>> -static int match_any(struct device *dev, void *unused)
>> -{
>> -	return 1;
>> -}
>> -
>>  /**
>>   * device_find_any_child - device iterator for locating a child device, if any.
>>   * @parent: parent struct device
>> @@ -4124,7 +4119,7 @@ static int match_any(struct device *dev, void *unused)
>>   */
>>  struct device *device_find_any_child(struct device *parent)
>>  {
>> -	return device_find_child(parent, NULL, match_any);
>> +	return device_find_child(parent, NULL, device_match_any);
>>  }
>>  EXPORT_SYMBOL_GPL(device_find_any_child);
>>  
>> diff --git a/include/linux/device.h b/include/linux/device.h
>> index b2423fca3d45..76f10bdbb4ea 100644
>> --- a/include/linux/device.h
>> +++ b/include/linux/device.h
>> @@ -1073,8 +1073,8 @@ int device_for_each_child(struct device *dev, void *data,
>>  			  int (*fn)(struct device *dev, void *data));
>>  int device_for_each_child_reverse(struct device *dev, void *data,
>>  				  int (*fn)(struct device *dev, void *data));
>> -struct device *device_find_child(struct device *dev, void *data,
>> -				 int (*match)(struct device *dev, void *data));
>> +struct device *device_find_child(struct device *dev, const void *data,
>> +				 device_match_t match);
>>  struct device *device_find_child_by_name(struct device *parent,
>>  					 const char *name);
>>  struct device *device_find_any_child(struct device *parent);
>>
>> -- 
>> 2.34.1
>>
> 
> This patch breaks the build:
> 
> ./include/linux/device.h:1077:6: error: unknown type name 'device_match_t'
>  1077 |                                  device_match_t match);
>       |                                  ^
> 1 error generated.
> make[2]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
> make[1]: *** [/mnt/fast_t2/linux/work/driver-core/Makefile:1193: prepare0] Error 2
> 
> How did you test it?
> 
> And as you are changing the parameters here, doesn't the build break
> also because of that?
> 

it seems these dependency patches listed within [PATCH 00/27] are not
picked up.

let me summarize my recently patch serials

A)
Subject: [PATCH v2] drivers/base: Introduce device_match_t for device
finding APIs
https://lore.kernel.org/all/20240811-dev_match_api-v2-1-dd22ff555a30@quicinc.com/

B)
[PATCH 0/5] driver core: Prevent device_find_child() from modifying
caller's match data
https://lore.kernel.org/all/20240811-const_dfc_prepare-v1-0-d67cc416b3d3@quicinc.com/

C)  // this depends on both A) and B)
Subject: [PATCH 00/27] driver core: Make device_find_child()'s match
function take a const pointer
https://lore.kernel.org/all/20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com/

D)
Subject: [PATCH v2] driver core: Simplify driver API
device_find_child_by_name() implementation
https://lore.kernel.org/all/20240811-simply_api_dfcbn-v2-1-d0398acdc366@quicinc.com/


ALL these patch serials are based on driver-core tree with branch
driver-core-next, ALL of them can be built PASS.

> thanks,
> 
> greg k-h


