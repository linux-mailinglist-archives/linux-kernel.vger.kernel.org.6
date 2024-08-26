Return-Path: <linux-kernel+bounces-301754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D080695F51A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3586DB21966
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1019341D;
	Mon, 26 Aug 2024 15:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iRL/dea7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2316D191F81;
	Mon, 26 Aug 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686244; cv=none; b=SDB5xGnmPD9htSiLKHIUEn2KfI0+OqlymAlMX564OzT5rvi27+0GCOKkcEqvZWo5Wvo2mw2tqM0fWLeomSviAZfsQ9PF6BRQ7nJZqg31xyya9bQjQ60E85/5zqdMXkcU9Eus7FR9LjxRN1H1PriYEyFSrnBpdGNchs3/gBE8h0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686244; c=relaxed/simple;
	bh=waCFBInKCgr3fjghz/KTpMmb1BUwOX3RU89Ze1FxgrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AoAAAuzAKzT4WMzreiwvQzjf0POFgPrzuQO3yf9B0/H/2RCe595fJPLlO8BMUoVdszzZqHugF33fAbYdqSjIUCzN0mKkUhgpGP6qWV6LjIlXYLhJN8kga5m2L23POhwQQ7XErzSRGnIqK+FdPGgSpXcA1tMvdlvgG7MWQrxiIGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iRL/dea7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q8MR9C021818;
	Mon, 26 Aug 2024 15:30:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3UlnzQdlD2biWQeL/xGoUZGUrre5RLUHhlOMVI/Zssg=; b=iRL/dea74mnxIAi1
	QJuAVOYwcnr6JOrcm3eIDnBkbAhV6p+dH/arFIqgXoGfopi8vQ/KKDtATqBok77B
	dTcMuTRipay8P/7SuJw0ata6R2K7KrmPgTBFKrk1SbBeCmmuFBLBnHEEJUVmXkPp
	JVQ6eAAo4NUzKCNlXGSXO0WWFaSvM4D/9Boag3wmtBxlftD3pGBz0/fwGnqBzRS4
	OrvTPUxM16o0rdvwUPsJjx6DAYoJA/IIoQjIoQdYJKJDKxH2lg/6sVXI5F1vKGOM
	7U10uz0TtHdFaamjp5HRvDkiAc5pcZa4mvblfm8fXi+vCS5M1gAbv2nMVHKSd/sP
	Otbfww==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41798kc2bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 15:30:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47QFUEAw025610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 15:30:14 GMT
Received: from [10.216.62.85] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 26 Aug
 2024 08:30:07 -0700
Message-ID: <6ec972b0-a971-4d35-9d8f-4a0fe3660514@quicinc.com>
Date: Mon, 26 Aug 2024 21:00:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: uvc: Add H264 frame format support
To: Michael Riesch <michael.riesch@wolfvision.net>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham <quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240711082304.1363-1-quic_akakum@quicinc.com>
 <2024071126-napped-cobbler-4693@gregkh>
 <0f3fe4b4-5451-480e-a9e4-11ee921521b9@quicinc.com>
 <07d9e1f4-201f-47dc-b692-b1aa14511420@quicinc.com>
 <acb0bcba-82de-4d67-9000-7c50a8456ff1@wolfvision.net>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <acb0bcba-82de-4d67-9000-7c50a8456ff1@wolfvision.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PlFYmix_A_5zoFO-onk-Y6WElAQInJcn
X-Proofpoint-ORIG-GUID: PlFYmix_A_5zoFO-onk-Y6WElAQInJcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_12,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408260119

Hi Michael,

On 8/26/2024 3:06 PM, Michael Riesch wrote:
> Hi Akash,
>
> Thanks for your patches. Very interesting to see H.264 UVC gadget
> support coming to life. May I ask how you tested your patches? What does
> the user space stack on the gadget side look like? And what is the USB
> host in your setup (OS, application, ...)?
We have added support in our application code which opens uvc node 
during enumeration,
e2e application POTPLAYER can be used to test which has h264 decoder 
support, with my changes
you can see in device setting option along with mjpeg,uncompressed , 
h264 and all frames and fps
which we can be added in any init service, which can create and populate 
uvc properties.
You need to create sysfs entries as shared in Documentation,
With format names, driver creates parameters and we need to populate all 
paramters which are writable.
we have validated in linux, android and ubuntu OS.
>
> On 8/1/24 08:15, AKASH KUMAR wrote:
>> Hi Greg,Daniel,Laurent,
>>
>> On 7/11/2024 3:13 PM, AKASH KUMAR wrote:
>>> On 7/11/2024 2:37 PM, Greg Kroah-Hartman wrote:
>>>> On Thu, Jul 11, 2024 at 01:53:04PM +0530, Akash Kumar wrote:
>>>>> Add support for framebased frame format which can be used to support>>>> multiple formats like H264 or H265 other than mjpeg and YUV frames.
>>>>>
>>>>> Framebased format is set to H264 by default, which can be updated to
>>>>> other formats by updating the GUID through guid configfs attribute.
>>>>> Using Different structures for all 3 formats as H264 has different
>>>>> structure than mjpeg and uncompressed which will be paased to
>>>>> frame make func based on active format instead of common frame
>>>>> structure, have updated all apis in driver accordingly.
>>>>> h264 is not recognized by hosts machine during enumeration
>>>>> with common frame structure, so we need to pass h264 frame
>>>>> structure separately.
>>>>>
>>>>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>>>>> ---
>>>>>    .../ABI/testing/configfs-usb-gadget-uvc       |  88 ++-
>>>>>    drivers/usb/gadget/function/uvc_configfs.c    | 570
>>>>> +++++++++++++++---
>>>>>    drivers/usb/gadget/function/uvc_configfs.h    |  34 +-
>>>>>    drivers/usb/gadget/function/uvc_v4l2.c        |  80 ++-
>>>>>    include/uapi/linux/usb/video.h                |  62 ++
>>>>>    5 files changed, 714 insertions(+), 120 deletions(-)
>>>>>
>>>>> Changes for v2:
>>>>> - Added H264 frame format Details in Documentation/ABI/
>>>>>     and new configsfs attribute path for mjpeg and
>>>>>     uncompresseed formats.
>>>>>
>>>>> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>> b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>> index 4feb692c4c1d..2580083cdcc5 100644
>>>>> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>> @@ -224,13 +224,13 @@ Description:    Additional color matching
>>>>> descriptors
>>>>>                          white
>>>>>            ========================
>>>>> ======================================
>>>>>    -What: /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg
>>>>> -Date:        Dec 2014
>>>>> +What:
>>>>> /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg/name
>>>> You are changing an existing api, how will all existing code handle
>>>> this? Will it not break? What is ensuring that this will work as-is ok?
>>>> I have modified all existing apis in kernel and have handled it and
>>>> all existing formats
>>> are working along with H264 in this change. Only user needs to change
>>> configfs parameter
>>> path according to updated path in documentation in Userspace.Currently
>>> H264 doesn't work with same
>>> structure and we need add it differently as a result these configfs
>>> paths are getting updated.
>>> Daniel and Laurent can you suggest if it ok?
>>>>> -#define UVCG_FRAME_ATTR(cname, aname, bits) \
>>>>> -static ssize_t uvcg_frame_##cname##_show(struct config_item *item,
>>>>> char *page)\
>>>>> +#define UVCG_FRAME_ATTR(cname, fname, bits) \
>>>>> +static ssize_t uvcg_frame_##fname##_##cname##_show(struct
>>>>> config_item *item, char *page)\
>>>>>    {                                    \
>>>>>        struct uvcg_frame *f = to_uvcg_frame(item);            \
>>>>>        struct f_uvc_opts *opts;                    \
>>>>> @@ -1936,14 +1941,14 @@ static ssize_t
>>>>> uvcg_frame_##cname##_show(struct config_item *item, char *page)\
>>>>>        opts = to_f_uvc_opts(opts_item);                \
>>>>>                                        \
>>>>>        mutex_lock(&opts->lock);                    \
>>>>> -    result = sprintf(page, "%u\n", f->frame.cname);            \
>>>>> +    result = scnprintf(page, PAGE_SIZE, "%u\n",
>>>>> f->frame.fname.cname);\
>>>> sysfs_emit() is made for this.
>>> Sure, will change.
>>>
>>>
>> can you suggest how to support H264 format without changing userspace
>> nodes,
>> as H264 format structure is different from mjpeg and uncompressed format
>> and
>> using same structure show issue as host is not able to recognize H264
>> format frames.
>>
>> Thanks,
>> Akash
>>
> After only a quick look at the USB Video Payload H264 1.5 document, I
> think there should be a folder
>    /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/
> with the formats
>    /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/name
> and the frames
>    /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/name/name
> in analogy to the other payloads, namely mjpeg and uncompressed.
> Naturally, the attributes will be different to the existing formats.
>
> What exactly does not work with this approach?
We need to add additional name for mjpeg and uncompressed due to 
different structure
as we cannot support all 3 formats with same frame struct type.
This name can be any dummy word and formats are added inside this dummy 
name instead
of mjpeg and uncompressed.
>
> Best regards,
> Michael
Thanks,
Akash

