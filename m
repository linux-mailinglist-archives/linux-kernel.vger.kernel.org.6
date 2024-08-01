Return-Path: <linux-kernel+bounces-270703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533EC944454
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ECD2875FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493CC158540;
	Thu,  1 Aug 2024 06:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TSfb759i"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A713F456;
	Thu,  1 Aug 2024 06:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492939; cv=none; b=rCJedX93GXHWtzyYhSrXDM47d7y+qEzlABXlWnjq4KAmgaV1eEUF90hmjS1gbpEjn9GFrWwp8c8U3zv5s0itSNk42mYZjoKoDop0gA7jhXfBVuxiys4gUkeOFeA9vUAsBdA3M0wHDBl8WT9rOkKr6dF7BAHFLloz3Nwh3M1XerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492939; c=relaxed/simple;
	bh=UsUWr/4WbD2jnKP/Vn46wHrKb89vFqivDWjJvtbLhjk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=t4nnFDH4U8zGL4jNV7YdTiqR6HzWHGEBlfcYH5US+2Ts8KPH8BlSgybYoQrfdW+SEKXERxSjoZik2paCg2Tn9zWwwkgM/F0n1+UHnX86duSly0mzfm6cA8Ka23JP579RiGF/FA6G24MwJde7wZAn3vWwv1HmNui1OYm5CjPE6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TSfb759i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VNohPd024782;
	Thu, 1 Aug 2024 06:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YhrdK/Kb4g25+74l2tEHOzdEyNnQXoJu08Wq8JCuAmU=; b=TSfb759iMCzNpia+
	pawV1m63tBbYp8EJmVFVNs6fAbPS2+UCF0we8PKiZVFvXwdbbqMajVioFQ6Tu7Wx
	tfhx+leqVuIMYTZSov0ceBW+G8tha+LmskZOhbXWacvVSfsByik2iQqL4tw38cog
	EoqwzgUzEHApzyRz0SWretivkRXl7OPyd4h76mDFfDGwdqKzam/V4Htrc11G+RgB
	7tuy4EZO4gDSbss54MgU063AzqwhOeRLd6n2T2c8L1vL49APx0U2Yg3/ED+/XqSU
	jq+88RoBZLug22k13sySYBpNg2gpd+7PWGD9vuInXzlr7ve3OrEoNvck3uXf9a3L
	fG/KZA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pw457501-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:15:30 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4716FT3O031914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 06:15:29 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 31 Jul
 2024 23:15:22 -0700
Message-ID: <07d9e1f4-201f-47dc-b692-b1aa14511420@quicinc.com>
Date: Thu, 1 Aug 2024 11:45:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: uvc: Add H264 frame format support
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Scally
	<dan.scally@ideasonboard.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>
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
 <0f3fe4b4-5451-480e-a9e4-11ee921521b9@quicinc.com>
In-Reply-To: <0f3fe4b4-5451-480e-a9e4-11ee921521b9@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BAwODJNQtGnJyC7Wj_LReSDoNDxxDp_r
X-Proofpoint-ORIG-GUID: BAwODJNQtGnJyC7Wj_LReSDoNDxxDp_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_03,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=910 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408010035

Hi Greg,Daniel,Laurent,

On 7/11/2024 3:13 PM, AKASH KUMAR wrote:
>
> On 7/11/2024 2:37 PM, Greg Kroah-Hartman wrote:
>> On Thu, Jul 11, 2024 at 01:53:04PM +0530, Akash Kumar wrote:
>>> Add support for framebased frame format which can be used to support
>>> multiple formats like H264 or H265 other than mjpeg and YUV frames.
>>>
>>> Framebased format is set to H264 by default, which can be updated to
>>> other formats by updating the GUID through guid configfs attribute.
>>> Using Different structures for all 3 formats as H264 has different
>>> structure than mjpeg and uncompressed which will be paased to
>>> frame make func based on active format instead of common frame
>>> structure, have updated all apis in driver accordingly.
>>> h264 is not recognized by hosts machine during enumeration
>>> with common frame structure, so we need to pass h264 frame
>>> structure separately.
>>>
>>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>>> ---
>>>   .../ABI/testing/configfs-usb-gadget-uvc       |  88 ++-
>>>   drivers/usb/gadget/function/uvc_configfs.c    | 570 
>>> +++++++++++++++---
>>>   drivers/usb/gadget/function/uvc_configfs.h    |  34 +-
>>>   drivers/usb/gadget/function/uvc_v4l2.c        |  80 ++-
>>>   include/uapi/linux/usb/video.h                |  62 ++
>>>   5 files changed, 714 insertions(+), 120 deletions(-)
>>>
>>> Changes for v2:
>>> - Added H264 frame format Details in Documentation/ABI/
>>>    and new configsfs attribute path for mjpeg and
>>>    uncompresseed formats.
>>>
>>> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc 
>>> b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>> index 4feb692c4c1d..2580083cdcc5 100644
>>> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>> @@ -224,13 +224,13 @@ Description:    Additional color matching 
>>> descriptors
>>>                         white
>>>           ======================== 
>>> ======================================
>>>   -What: /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg
>>> -Date:        Dec 2014
>>> +What: 
>>> /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg/name
>> You are changing an existing api, how will all existing code handle 
>> this? Will it not break? What is ensuring that this will work as-is ok?
>> I have modified all existing apis in kernel and have handled it and 
>> all existing formats
> are working along with H264 in this change. Only user needs to change 
> configfs parameter
> path according to updated path in documentation in Userspace.Currently 
> H264 doesn't work with same
> structure and we need add it differently as a result these configfs 
> paths are getting updated.
> Daniel and Laurent can you suggest if it ok?
>>> -#define UVCG_FRAME_ATTR(cname, aname, bits) \
>>> -static ssize_t uvcg_frame_##cname##_show(struct config_item *item, 
>>> char *page)\
>>> +#define UVCG_FRAME_ATTR(cname, fname, bits) \
>>> +static ssize_t uvcg_frame_##fname##_##cname##_show(struct 
>>> config_item *item, char *page)\
>>>   {                                    \
>>>       struct uvcg_frame *f = to_uvcg_frame(item);            \
>>>       struct f_uvc_opts *opts;                    \
>>> @@ -1936,14 +1941,14 @@ static ssize_t 
>>> uvcg_frame_##cname##_show(struct config_item *item, char *page)\
>>>       opts = to_f_uvc_opts(opts_item);                \
>>>                                       \
>>>       mutex_lock(&opts->lock);                    \
>>> -    result = sprintf(page, "%u\n", f->frame.cname);            \
>>> +    result = scnprintf(page, PAGE_SIZE, "%u\n", 
>>> f->frame.fname.cname);\
>> sysfs_emit() is made for this.
>
> Sure, will change.
>
>
can you suggest how to support H264 format without changing userspace nodes,
as H264 format structure is different from mjpeg and uncompressed format 
and
using same structure show issue as host is not able to recognize H264 
format frames.

Thanks,
Akash

