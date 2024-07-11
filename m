Return-Path: <linux-kernel+bounces-248773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBCE92E1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 451291F257B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD6157E6C;
	Thu, 11 Jul 2024 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fboff7G0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F374963F;
	Thu, 11 Jul 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685651; cv=none; b=PIXSqqg16INr2syFDFoWr1bRLHYP9izBFFIoGFFrWbyg9wePXunkzhT0akCyVAK4Zc+mre+4nvVp4v5uhpGvtJEXyCWhQy52R1KhrP9fcrZ8NBV3TPk9Z/njphSgnttVlH2D0UJstd4VF0D1g/eO/TA210QlKZkGGSiNqAuW5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685651; c=relaxed/simple;
	bh=ODRBh1j5JOL23CNW0NPbioHV5i2u27rEl/C70xk/qAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LnnUSKcP+14teCBokzbQR6vBs8Fr/YV6+5JgQJbZSF4c4Rb/o7OKNHa6ufbzB/kY4YyIZkfy+fAQcfIsjbvZRjWMDSEwAAjQFtHDnlOdT9KbfcUDZ5zqMGFF9nOla82X9Y29DWl49+XCnSivxgNk9o7InT9I2izPuTBO9dnuns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fboff7G0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B4mlX1019994;
	Thu, 11 Jul 2024 08:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DX+WWo53/HpJBzzJRou4FUISP0oOuCAi1n81bqWUF7w=; b=Fboff7G0y+NA7/ps
	W7kDb4oLBHRakjHfMxIvPFkoS5e3Y9/JL2XbkIS3/asB3ijeF7iMDv4wNiYAcsmN
	DS+Yi9tLC4UplXEaxmgnVQTCHKBvJ5H8CofPyczsa/Ftp8t9CLKKuWpKDTzBazKh
	/GuLf+yWX7en4HxL/eZX4jv8qmYgY2Gop4nwE2SELFbOoAHjflZpR1x87VwRXLak
	OQyrh4TjdM5uCB7WcEwl/QnCJIVujp+x/kj6eU1ucmhWNc1YwhXDy/5+7U+6SyK7
	0rq0zMnPw6sY4+iOty7jjw6GoAagLqGWnBgKx+W/S58vadAHKjZ5n+rHN7eSZ31M
	RsigdA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmuu8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 08:13:58 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46B8DvSG025373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 08:13:57 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Jul
 2024 01:13:50 -0700
Message-ID: <5dc07ab0-0332-4c4b-8627-fdb2662b0ef2@quicinc.com>
Date: Thu, 11 Jul 2024 13:43:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: uvc: Add H264 frame format support
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Jing Leng <jleng@ambarella.com>,
        Felipe Balbi <balbi@kernel.org>, Jack Pham <quic_jackp@quicinc.com>,
        <kernel@quicinc.com>, Wesley Cheng <quic_wcheng@quicinc.com>,
        "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240708041328.1942-1-quic_akakum@quicinc.com>
 <2024071054-anatomist-purchase-1e98@gregkh>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <2024071054-anatomist-purchase-1e98@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n2_Tga6ZxRR6ZF-F-edWEDkbn-hie9Vt
X-Proofpoint-ORIG-GUID: n2_Tga6ZxRR6ZF-F-edWEDkbn-hie9Vt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=574
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407110056

Sure greg adding the details in documentation and yeah it is needed as i 
have changed uvc frame structure
from single to separate for mjpeg, uncompressed and h264.
Updating the details in next patchset.
> On Mon, Jul 08, 2024 at 09:43:28AM +0530, Akash Kumar wrote:
>> Add support for framebased frame format which can be used to support
>> multiple formats like H264 or H265 other than mjpeg and YUV frames.
>>
>> Framebased format is set to H264 by default, which can be updated to
>> other formats by updating the GUID through guid configfs attribute.
>>
>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>> ---
>>   drivers/usb/gadget/function/uvc_configfs.c | 570 ++++++++++++++++++---
>>   drivers/usb/gadget/function/uvc_configfs.h |  34 +-
>>   drivers/usb/gadget/function/uvc_v4l2.c     |  80 ++-
>>   include/uapi/linux/usb/video.h             |  62 +++
>>   4 files changed, 638 insertions(+), 108 deletions(-)
> DOn't you need to add the new configfs entries to Documentation/ABI/?
>
> And how is anyone going to know about this new api or format if there
> are not new files?  WHere is it now documented?
>
> thanks,
>
> greg k-h
Thanks,
Akash

