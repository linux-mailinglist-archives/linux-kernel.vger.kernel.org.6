Return-Path: <linux-kernel+bounces-306320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02298963D44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274311C24136
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B0A189BB6;
	Thu, 29 Aug 2024 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fNGMJM8e"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC1188CBD;
	Thu, 29 Aug 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724917062; cv=none; b=IckjCANnaAGo9wbr3tud/k08i2dAt6ZfhfJlVCsoaMGv/Fr9ltwBT6uOSSrUvAnY26L8vwyweVRwYQACG8zrsqZV79ksjUtkRlJY3UEFE9yNfOwsKXNGE4u76Ukh2OrAqwApw+ZBKXFBfNBP0OMi4BWTrTlQDXf0FC35UHHwkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724917062; c=relaxed/simple;
	bh=V/zHvR45g8mcSGd5kh42BmkDeiwg3QM7lDnkbVBtWdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vbb0hloBAZ8KomKdgYR+xNjjo6/Dhj+5RCl40J+yqzZjH7SA6jt4rbnTE0M/3jBZB+WJtls2tgg0z8xjviVtstAIZMNjvk4Bprk9I9Geq8UROWlnr3Jlap/0rnkT8NX1incCa0RbYWtTGqC+9c1GxyCKCA0kMcRwR6GUFaKPDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fNGMJM8e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJME7Y013576;
	Thu, 29 Aug 2024 07:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gfrvWEpkIUn23pupaLdBQulSFP2HY/j3+24BDjYnz7A=; b=fNGMJM8e7+oiV57P
	LvZ3dxyAXAWbNb2opWfUbEK5qtfheB2qb0qi7BeS6NDLp88I5wJ7Z9NE+lF33oFi
	MCJsQFHbq2yC4X+SK2QeXtbXc8jY6hALs3ySJb9lXRvGWNBIpVTmypNTHfWxx/e+
	cBErK7WcZUp0cEbRj4+9tDkdLCz5wuOdgnD16n/VTyR/5zFy9QtrZIkq1AqsE7jP
	uzk0SCZzvbRRap0xjH0g8orrgXEdJo4WplZP/deRbn7YUCqO5nZxxVUlbAqY7fyw
	YAolqq+qvo4uuLLNDy/dmCYTAlNTpkgWNDivLOBJ+KnBtbuHbB+B908gYTlT0CX9
	dTbE0w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419px5m9q8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 07:37:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T7bKb0008560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 07:37:20 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 29 Aug
 2024 00:37:13 -0700
Message-ID: <aebb87ab-d57e-4cb3-8cdb-835678f31154@quicinc.com>
Date: Thu, 29 Aug 2024 13:07:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: gadget: Fix TX FIFO size for HS ISOC endpoints
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng
	<jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham
	<quic_jackp@quicinc.com>,
        "kernel@quicinc.com" <kernel@quicinc.com>,
        "Wesley
 Cheng" <quic_wcheng@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240827054956.28241-1-quic_akakum@quicinc.com>
 <20240827231552.7yokoe7jqdm3wduu@synopsys.com>
 <93955b6d-0ce1-42cb-ad18-a82e2e8cfca9@quicinc.com>
 <20240828234554.lw4hzeajneee7n55@synopsys.com>
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20240828234554.lw4hzeajneee7n55@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Fl07akVfgMyx9T4UE5Uq6fRglCnSiRL2
X-Proofpoint-GUID: Fl07akVfgMyx9T4UE5Uq6fRglCnSiRL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408290055

Hi Thinh,

On 8/29/2024 5:15 AM, Thinh Nguyen wrote:
> On Wed, Aug 28, 2024, AKASH KUMAR wrote:
>> Hi Thinh,
>>
>> On 8/28/2024 4:45 AM, Thinh Nguyen wrote:
>>> On Tue, Aug 27, 2024, Akash Kumar wrote:
>>>> Use 2K TX FIFO size for low-resolution UVC cameras to support the
>>>> maximum possible UVC instances. Restrict 2K TX FIFO size based on
>>>> the minimum maxburst required to run low-resolution UVC cameras.
>>>>
>>>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>>>> ---
>>>>    drivers/usb/dwc3/gadget.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 89fc690fdf34..f342ccda6705 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -788,6 +788,10 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>>>    	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
>>>>    		num_fifos = dwc->tx_fifo_resize_max_num;
>>>> +	if (dep->endpoint.maxburst <= 1 &&
>>>> +	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>>>> +		num_fifos = 2;
>>>> +
>>>>    	/* FIFO size for a single buffer */
>>>>    	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
>>>> -- 
>>>> 2.17.1
>>>>
>>> These settings are starting to get too specific for each application.
>>> Can we find a better calculation?
>>>
>>> Perhaps something like this? (code not tested)
>>>
>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>> index 9a18973ebc05..d54b08f92aea 100644
>>> --- a/drivers/usb/dwc3/gadget.c
>>> +++ b/drivers/usb/dwc3/gadget.c
>>> @@ -908,15 +908,10 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>>    	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>>> -	if ((dep->endpoint.maxburst > 1 &&
>>> -	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
>>> +	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>>>    	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>>> -		num_fifos = 3;
>>> -
>>> -	if (dep->endpoint.maxburst > 6 &&
>>> -	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>>> -	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
>>> -		num_fifos = dwc->tx_fifo_resize_max_num;
>>> +		num_fifos = min_t(unsigned int, dep->endpoint.maxburst + 1,
>>> +				  dwc->tx_fifo_resize_max_num);
>>>    	/* FIFO size for a single buffer */
>>>    	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
>>>
>> should be fine for me, as earlier there was no case handling for maxburst <=
>> 1, by allocating fifo based on maxburst itself
>>
>> should be a good solution and will work for all as they customize based on
>> maxburst through init scripts, let me test and update.
>>
> As I noted in the follow up response, you need to also account for
> additional transaction opportunities for isoc if operating in highspeed.
> (ie. use usb_endpoint_maxp_mult()).
yeah i think that we can control with maxpacket size for high speed cams 
and we can
work with maxburst requested only to allocate fifo as both are 
configurable entity and one
should be free to adjust fifo as per his environment and not add any 
additional limitation.
Let me know if we aligned and go ahead with above suggestion only.


Thanks,
Akash

