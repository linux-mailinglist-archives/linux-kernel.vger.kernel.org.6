Return-Path: <linux-kernel+bounces-284620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8685295032A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4801C2187A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 11:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808BE183CA6;
	Tue, 13 Aug 2024 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YrwrtnfV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238C16A955
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 11:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546881; cv=none; b=FjwmyoQiUD3WpoKfEmDZ9eskPPBZlaLFhSnb8UZURdgwgFQ2xCKJiE4p63CtzXqAlR3cVC9+vdzStPDSOReTlen5Qy41dn4x/UC/0Sm8guJA6mXLyYEl7E8VARkbFsj1iRR1uSnm14Ie02VanYARsMmaKXaOB9bhMDVPribbzw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546881; c=relaxed/simple;
	bh=6lHaE0m/oPwTv5L/xAq9M6y/JDkyNT3pGLIpruk5QRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WFRu6KUjFyXfUmcp73M5k/isVqJvKmXvmXF6jr5b/ZZxufKofk8NMfvT4ItKJiSa98WcgxRRgbOPbv/MXZ9mML91MoT7QMj+v2j/Q7sRSQy6kElYtFUgReGhvKf7GB1Ibp8DFg3dLEWv3m+ONs7vpeJpsoIO78GPzQc7cJZdS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YrwrtnfV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D487YC006648;
	Tue, 13 Aug 2024 11:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WkAveaGeqkkfRT+GOIG4FDIlORSjsPiET/gXAHUcMzM=; b=YrwrtnfVMMwIVwCp
	KdAdejVT5IQkwNGcGhMe8L5IS11KUje+ChF66uw9cLlYobuHJUVxAtTGlBVAJ1jH
	GYND7VoXel2EZzcdZbflX1W8fPCY06QDbkjAvpIQ6n8bK6gqOzwg30sDihnhWB8k
	XlV0WP0KcclrV6dxFGG6FlWOEUZElWIUPvURSNQEKEKVbGvC3jfYYdpWVLyFaesW
	Yz1WJM0Wf3eZTlwJRauYL0mQf5zV6s2FgVSj7ZDrqLXqmFVGrL7K14xCEge2Jpvr
	uLvkR+G/2Os14rWWJGgdgdAAUxE5zUQTK6NK2kMueHV9+yaNB8oscXhADeTmSQIK
	a/fUDg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x15e7ae6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 11:01:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DB19O9018934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 11:01:09 GMT
Received: from [10.253.34.30] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 04:01:08 -0700
Message-ID: <e3f8fe62-71ae-4fde-9274-62fcbcf7dcb9@quicinc.com>
Date: Tue, 13 Aug 2024 19:01:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/base: Introduce device_match_t for device
 finding APIs
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zijun Hu
	<zijun_hu@icloud.com>
CC: Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240811-dev_match_api-v2-1-dd22ff555a30@quicinc.com>
 <2024081322-moneyless-gruffly-c540@gregkh>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <2024081322-moneyless-gruffly-c540@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Jru_2tTaS_gtovAvQVkO04Vkf5GrW6WK
X-Proofpoint-ORIG-GUID: Jru_2tTaS_gtovAvQVkO04Vkf5GrW6WK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130079

On 8/13/2024 5:52 PM, Greg Kroah-Hartman wrote:
> On Sun, Aug 11, 2024 at 10:15:16AM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> There are several drivers/base APIs for finding a specific device, and
>> they currently use the following good type for the @match parameter:
>> int (*match)(struct device *dev, const void *data)
>>
>> Since these operations do not modify the caller-provided @*data, this
>> type is worthy of a dedicated typedef:
>> typedef int (*device_match_t)(struct device *dev, const void *data)
>>
>> Advantages of using device_match_t:
>>  - Shorter API declarations and definitions
>>  - Prevent further APIs from using a bad type for @match
>>
>> So introduce device_match_t and apply it to the existing
>> (bus|class|driver|auxiliary)_find_device() APIs.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
>> Changes in v2:
>> - Git rebase over the following commit:
>>   bfa54a793ba7 ("driver core: bus: Fix double free in driver API bus_register()")
>> - Link to v1: https://lore.kernel.org/r/20240802-dev_match_api-v1-1-51e16d3bf031@quicinc.com
>> ---
>>  drivers/base/auxiliary.c      | 2 +-
>>  drivers/base/bus.c            | 2 +-
>>  drivers/base/class.c          | 3 +--
>>  drivers/base/driver.c         | 2 +-
>>  include/linux/auxiliary_bus.h | 2 +-
>>  include/linux/device/bus.h    | 5 +++--
>>  include/linux/device/class.h  | 2 +-
>>  include/linux/device/driver.h | 2 +-
>>  8 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
>> index 54b92839e05c..7823888af4f6 100644
>> --- a/drivers/base/auxiliary.c
>> +++ b/drivers/base/auxiliary.c
>> @@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(__auxiliary_device_add);
>>   */
>>  struct auxiliary_device *auxiliary_find_device(struct device *start,
>>  					       const void *data,
>> -					       int (*match)(struct device *dev, const void *data))
>> +					       device_match_t match)
>>  {
>>  	struct device *dev;
>>  
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index abf090ace833..657c93c38b0d 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -391,7 +391,7 @@ EXPORT_SYMBOL_GPL(bus_for_each_dev);
>>   */
>>  struct device *bus_find_device(const struct bus_type *bus,
>>  			       struct device *start, const void *data,
>> -			       int (*match)(struct device *dev, const void *data))
>> +			       device_match_t match)
>>  {
>>  	struct subsys_private *sp = bus_to_subsys(bus);
>>  	struct klist_iter i;
>> diff --git a/drivers/base/class.c b/drivers/base/class.c
>> index 7b38fdf8e1d7..ae22fa992c04 100644
>> --- a/drivers/base/class.c
>> +++ b/drivers/base/class.c
>> @@ -433,8 +433,7 @@ EXPORT_SYMBOL_GPL(class_for_each_device);
>>   * code.  There's no locking restriction.
>>   */
>>  struct device *class_find_device(const struct class *class, const struct device *start,
>> -				 const void *data,
>> -				 int (*match)(struct device *, const void *))
>> +				 const void *data, device_match_t match)
>>  {
>>  	struct subsys_private *sp = class_to_subsys(class);
>>  	struct class_dev_iter iter;
>> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
>> index 88c6fd1f1992..b4eb5b89c4ee 100644
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -150,7 +150,7 @@ EXPORT_SYMBOL_GPL(driver_for_each_device);
>>   */
>>  struct device *driver_find_device(const struct device_driver *drv,
>>  				  struct device *start, const void *data,
>> -				  int (*match)(struct device *dev, const void *data))
>> +				  device_match_t match)
>>  {
>>  	struct klist_iter i;
>>  	struct device *dev;
>> diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
>> index 662b8ae54b6a..31762324bcc9 100644
>> --- a/include/linux/auxiliary_bus.h
>> +++ b/include/linux/auxiliary_bus.h
>> @@ -271,6 +271,6 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv);
>>  
>>  struct auxiliary_device *auxiliary_find_device(struct device *start,
>>  					       const void *data,
>> -					       int (*match)(struct device *dev, const void *data));
>> +					       device_match_t match);
>>  
>>  #endif /* _AUXILIARY_BUS_H_ */
>> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
>> index 807831d6bf0f..970de5ee5562 100644
>> --- a/include/linux/device/bus.h
>> +++ b/include/linux/device/bus.h
>> @@ -126,6 +126,8 @@ struct bus_attribute {
>>  int __must_check bus_create_file(const struct bus_type *bus, struct bus_attribute *attr);
>>  void bus_remove_file(const struct bus_type *bus, struct bus_attribute *attr);
>>  
>> +/* Matching function type for drivers/base APIs to find a specific device */
>> +typedef int (*device_match_t)(struct device *dev, const void *data);
>>  /* Generic device matching functions that all busses can use to match with */
> 
> Extra new-line after the typedef please.
> 
okay, let me correct it with v2.
> And shouldn't this be in device.h instead?
> 
there is the good location to place with below reasons:

1) place this typedef and various match functions with the type
together, these functions immediately follow the type.

2) this type are also used by bus.c/class.c/driver.c which include bus.h
but don't include device.h

3) device.h have included bus.h

> thanks,
> 
> greg k-h


