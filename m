Return-Path: <linux-kernel+bounces-248910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A889092E3AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08CB1C20C44
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C78C15748C;
	Thu, 11 Jul 2024 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PkaEpaNW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3776034;
	Thu, 11 Jul 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691026; cv=none; b=noagUcZTfC4ypww+s8jPtZrjXL9680184kgGAWozrDJVQ6BkiCAEXooo2NXK3J0+KhF6FgitxHjAYZLGDmhBwbfDSTUQ4kK9rNesMDx60MFqcBzkBwrZt3q+mFewqedDdKOZ7FRL4ILJ3kh+p8w2QL1lJR5p5V8YTVI1goF1uE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691026; c=relaxed/simple;
	bh=lxeC2HRksD/2EGtekqXvQBbesVtQRF93t8d10rL4PLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mf2Z97H7pJiKZDzAupbN3t3RJWXWT1ZAdyxRas0e11cI8/HdHeZS7VsZ4RmfEG6zHFVikyZYQeM5Ax5uG9BOkF3aq7MDHoyCN9h55ohlhV1BHW3Aeq+XH/csg31ziLME+5/kxzYZZj1sZCo/AeL087kS/c0GFn16XBELMeFubK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PkaEpaNW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4mjJb024418;
	Thu, 11 Jul 2024 09:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vBJCEU/0J5y5AI2xVAzJBP/pcTBiq107ZH5xXFu89Jw=; b=PkaEpaNW1rktVuRw
	OWlfeaCSYlyMzDE0CcHf5nAb17dS6nJHYEOXKa8ZDsxeT9v8UP3si7QUzV1d7zkN
	7WlePZuCfrnPgIeeAfeXBuWBmC+oXcv1ETtagARQuXOziqdNjBJN59EHvFjjxn5v
	kfM/EbptxZr57RfVxXl1iRTD4yDEf/BCDh5eIAAw7awIT47R/gu2h6FgsqBON2a9
	a/TAj3eNXNiZHnF7S86KZZhPz9QFMNIOY7+Uoil+BzTmvjUwHrFE5DKRzIjW8GsU
	/hzwVIoXFOfkg2zMIlLoF1XoczJASKNKb13RczcPeDMeCglwLWlHlrMsKjb2go5b
	ip6IqA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x0tc624-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 09:43:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B9hbYf008995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 09:43:37 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 02:43:30 -0700
Message-ID: <0f3fe4b4-5451-480e-a9e4-11ee921521b9@quicinc.com>
Date: Thu, 11 Jul 2024 15:13:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: uvc: Add H264 frame format support
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240711082304.1363-1-quic_akakum@quicinc.com>
 <2024071126-napped-cobbler-4693@gregkh>
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <2024071126-napped-cobbler-4693@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b8iaPYtXhLXRpz49BumE2R96or7rduPd
X-Proofpoint-ORIG-GUID: b8iaPYtXhLXRpz49BumE2R96or7rduPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=800 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110068


On 7/11/2024 2:37 PM, Greg Kroah-Hartman wrote:
> On Thu, Jul 11, 2024 at 01:53:04PM +0530, Akash Kumar wrote:
>> Add support for framebased frame format which can be used to support
>> multiple formats like H264 or H265 other than mjpeg and YUV frames.
>>
>> Framebased format is set to H264 by default, which can be updated to
>> other formats by updating the GUID through guid configfs attribute.
>> Using Different structures for all 3 formats as H264 has different
>> structure than mjpeg and uncompressed which will be paased to
>> frame make func based on active format instead of common frame
>> structure, have updated all apis in driver accordingly.
>> h264 is not recognized by hosts machine during enumeration
>> with common frame structure, so we need to pass h264 frame
>> structure separately.
>>
>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>> ---
>>   .../ABI/testing/configfs-usb-gadget-uvc       |  88 ++-
>>   drivers/usb/gadget/function/uvc_configfs.c    | 570 +++++++++++++++---
>>   drivers/usb/gadget/function/uvc_configfs.h    |  34 +-
>>   drivers/usb/gadget/function/uvc_v4l2.c        |  80 ++-
>>   include/uapi/linux/usb/video.h                |  62 ++
>>   5 files changed, 714 insertions(+), 120 deletions(-)
>>
>> Changes for v2:
>> - Added H264 frame format Details in Documentation/ABI/
>>    and new configsfs attribute path for mjpeg and
>>    uncompresseed formats.
>>
>> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>> index 4feb692c4c1d..2580083cdcc5 100644
>> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>> @@ -224,13 +224,13 @@ Description:	Additional color matching descriptors
>>   					  white
>>   		========================  ======================================
>>   
>> -What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg
>> -Date:		Dec 2014
>> +What:		/config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg/name
> You are changing an existing api, how will all existing code handle 
> this? Will it not break? What is ensuring that this will work as-is ok?
> I have modified all existing apis in kernel and have handled it and 
> all existing formats
are working along with H264 in this change. Only user needs to change 
configfs parameter
path according to updated path in documentation in Userspace.Currently 
H264 doesn't work with same
structure and we need add it differently as a result these configfs 
paths are getting updated.
Daniel and Laurent can you suggest if it ok?
>> -#define UVCG_FRAME_ATTR(cname, aname, bits) \
>> -static ssize_t uvcg_frame_##cname##_show(struct config_item *item, char *page)\
>> +#define UVCG_FRAME_ATTR(cname, fname, bits) \
>> +static ssize_t uvcg_frame_##fname##_##cname##_show(struct config_item *item, char *page)\
>>   {									\
>>   	struct uvcg_frame *f = to_uvcg_frame(item);			\
>>   	struct f_uvc_opts *opts;					\
>> @@ -1936,14 +1941,14 @@ static ssize_t uvcg_frame_##cname##_show(struct config_item *item, char *page)\
>>   	opts = to_f_uvc_opts(opts_item);				\
>>   									\
>>   	mutex_lock(&opts->lock);					\
>> -	result = sprintf(page, "%u\n", f->frame.cname);			\
>> +	result = scnprintf(page, PAGE_SIZE, "%u\n", f->frame.fname.cname);\
> sysfs_emit() is made for this.

Sure, will change.


Thanks,
Akash

