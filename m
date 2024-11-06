Return-Path: <linux-kernel+bounces-397881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AE69BE1D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B8DB23260
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2281DB55D;
	Wed,  6 Nov 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nREYB2BR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F431D54D1;
	Wed,  6 Nov 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883907; cv=none; b=Se1VTC9zjDx+4NPcPx8rHb+biFK5pkYB7BiqaZQDndaBR9nyTm15oCFThG8FmcIEvAF72YYAyOBl2N/KAjAgCquJpegzdB+dImZrzy5Gv2CirEBa8wT1VF9z5jXnWDoanAUIvQ3o3EzJKDCFqhBLGEq7M0rKTlH0/szqLA/SSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883907; c=relaxed/simple;
	bh=qGMeTcHry1kO0g73SvBH5kdKJdM5fhx+RelSTyex7hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dCC1ZS6pB+YeHCoe2noJRSM/sO7fPeNHWsC42PMO2csNuQ9XLgTlxTRUR/054G8QdTHoQyov0gFpfY71cbfaTOOgrKEXo/vimtTOaduKvpqDrI8bKhTsdTr41+uE2idKUDZCNCgX9CfSiTCfPutTqwb0GkF3f4C8yTj/IFzUnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nREYB2BR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A68gink028763;
	Wed, 6 Nov 2024 09:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	POaWiniNM8/imvYENi1W++7BY64ZmrEvCOH4Rjg7DQM=; b=nREYB2BRaIm+OtCG
	yCeFPkeBaYnbeEVid4RiTfjvgRRjNg0DBPdltu5wBVNkKpvBrn8VgfVfzRcDqmqy
	s+uXfgbzXGGHkLZdaUY3pkGstVaAlRHTcAwCZcFrKhKJuw1OAfBKueG4d8nWP4yY
	+Z9b+6o6RgpcWngzgrxE7GaIItoYT1I+/iFYiKqTTKZ8Xm0YiXxSFqyfygYXaRt8
	EQPK0E0A/PBnztb1vX4YqH+RaCbB2J3OHuYguVKJJMEB3oPkd0I7z954eJ/XCvQ1
	X7KTw92y4bVeooKn6L0upKMIRcsjQvQXg+hEjAVhEIvbT1Nt3axnziSyv+KtXkzF
	gYfaNw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd28amuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 09:04:54 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A694rFQ028749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 09:04:53 GMT
Received: from [10.218.13.161] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 01:04:44 -0800
Message-ID: <e0e6875c-0979-41a3-964c-f3741bdcde6e@quicinc.com>
Date: Wed, 6 Nov 2024 14:34:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
To: Selvarasu Ganesan <selvarasu.g@samsung.com>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
        Jack Pham
	<quic_jackp@quicinc.com>, <kernel@quicinc.com>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>
CC: Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jh0801.jung@samsung.com>, <dh10.jung@samsung.com>,
        <naushad@samsung.com>, <akash.m5@samsung.com>, <rc93.raju@samsung.com>,
        <taehyun.cho@samsung.com>, <hongpooh.kim@samsung.com>,
        <eomji.oh@samsung.com>, <shijie.cai@samsung.com>
References: <CGME20241017064506epcas5p4fd10695c100c84c659d4124d2f77e6a8@epcas5p4.samsung.com>
 <20241017064423.7056-1-quic_akakum@quicinc.com>
 <c1f6377f-5ddf-4617-bc69-9a4975c271e8@samsung.com>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <c1f6377f-5ddf-4617-bc69-9a4975c271e8@samsung.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5ig6VvvZg7LxsXy4kMFDCDjIU8KmrNU0
X-Proofpoint-GUID: 5ig6VvvZg7LxsXy4kMFDCDjIU8KmrNU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060073

Hi Selvarasu,

On 11/6/2024 12:29 PM, Selvarasu Ganesan wrote:
> On 10/17/2024 12:14 PM, Akash Kumar wrote:
>> The current logic is rigid, setting num_fifos to fixed values.
>> 3 for any maxburst greater than 1.
>> tx_fifo_resize_max_num for maxburst greater than 6.
>> Additionally, it did not differentiate much between bulk and
>> isochronous transfers, applying similar logic to both.
>>
>> The updated logic is more flexible and specifically designed to meet
>> the unique requirements of both bulk and isochronous transfers. We
>> have made every effort to satisfy all needs and requirements, verified
>> on our specific platform and application.
>>
>> Bulk Transfers: Ensures that num_fifos is optimized by considering both
>> the maxburst and DT property "tx-fifo-max-num" for super speed and
>> above. For high-speed and below bulk endpoints, a 2K TxFIFO allocation
>> is used to meet efficient data transfer needs, considering
>> FIFO-constrained platforms.
>>
>> Isochronous Transfers: Ensures that num_fifos is sufficient by
>> considering the maximum packet multiplier for HS and below and maxburst
>> for Super-speed and above eps, along with a constraint with the DT
>> property "tx-fifo-max-num".
>>
>> This change aims to optimize the allocation of Tx FIFOs for both bulk
>> and isochronous endpoints, potentially improving data transfer efficiency
>> and overall performance. It also enhances support for all use cases,
>> which can be tweaked with DT parameters and the endpoint’s maxburst and
>> maxpacket. This structured approach ensures that the appropriate number
>> of FIFOs is allocated based on the endpoint type and USB speed.
>>
>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>> ---
>> Changes for v7:
>> fixed indentations for if checks.
>>
>> Changes for v6:
>> The code has been refactored to replace multiple if checks with a
>> switch-case structure based on the USB speed. This change improves
>> readability and maintainability by clearly defining behavior for
>> different USB speeds. This structured approach ensures that the
>> appropriate number of FIFOs is allocated based on the endpoint
>> type and USB speed.
>>
>> Changes for v5:
>> Update Calculation for HS and below bulk and isoc eps based on
>> suggestion and fixed at 2k for bulk eps considering fifo constrained
>> platforms.
>>
>> Changes for v4:
>> Updated commit message as per review comments to clarify that it has
>> been tested on specific platforms only and tried best to match all
>> expectations.
>>
>> Changes for v3:
>> Redefine logic for resizing tx fifos,added check based on  operating
>> speed and used maxp for HS and maxburst for SS  and defined max allocation
>> based on dt property.
>>
>> Changes for v2:
>> Redefine logic for resizing tx fifos, handled fifo based on  minimum of
>> maxp and maxburts.
>>
>> Changes for v1:
>> Added additional condition to allocate tx fifo for hs isoc  eps, keeping
>> the other resize logic same
>> ---
>>    drivers/usb/dwc3/gadget.c | 33 ++++++++++++++++++++++++---------
>>    1 file changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 10178e5eda5a..af3d5b2f7b67 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -771,15 +771,30 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>    
>>    	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>>    
>> -	if ((dep->endpoint.maxburst > 1 &&
>> -	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
>> -	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>> -		num_fifos = 3;
>> -
>> -	if (dep->endpoint.maxburst > 6 &&
>> -	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>> -	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
>> -		num_fifos = dwc->tx_fifo_resize_max_num;
>> +	switch (dwc->gadget->speed) {
>> +	case USB_SPEED_SUPER_PLUS:
>> +	case USB_SPEED_SUPER:
>> +		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>> +		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>> +			num_fifos = min_t(unsigned int,
>> +					  dep->endpoint.maxburst,
>> +					  dwc->tx_fifo_resize_max_num);
>> +		break;
>> +	case USB_SPEED_HIGH:
>> +		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
>> +			num_fifos = min_t(unsigned int,
>> +					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
> Hi Akash,
>
> We are currently working on enabling UVC functionality on supports USB
> HS and below speeds with using a single port RAM configuration.
>
> In order to better understand the logic behind resizing HS ISO transfers
> when using a streaming packet size of 3072 in the UVC use case, we would
> like to know if there is a specific reason for using
> (usb_endpoint_maxp_mult(dep->endpoint.desc) + 1) to determine the number
> of FIFOs. This calculation could result in having 4 FIFOs instead of 3,
> even though 3 FIFOs should be sufficient for handling the 3072 streaming
> packet size. In our specific use case, this could potentially lead to an
> insufficient RAM issue, as we are limited by the amount of RAM available
> in the single port RAM configuration and supports upto HS-speed.
the reason for using maxp +1 is to use higher fifo size to support 1080 
mjpeg uvc streaming in HS or any uvc instances using less maxpacket like 
512 for UVC usecase,
can use 2k fifo. For any fifo constraint environment we have suggested 
to use dt property "tx-fifo-max-num" which can set accordingly, for your 
case you can set to
2 or 3.
>
>> +					  dwc->tx_fifo_resize_max_num);
>> +			break;
>> +		}
>> +		fallthrough;
>> +	case USB_SPEED_FULL:
>> +		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
>> +			num_fifos = 2;
>
> And we need to understand on above logic as well. Why using num_fifos =2
> for bulk transfer for HS and FULL speed?. It can ending with 2k (4 *
> Maxpacktsize).
> As per our understanding (2 x Maxpacketsize) is sufficient for bulk. Its
> means that num_fifos = 1 is sufficient for bulk. As i mentioned above
> this could potentially lead to an insufficient RAM issue in our platform.
2k Fifo is useful for bulk eps incase of multiple bulk operations 
simultaneously to avoid buffer underrrun issues,
Like i shared above DT property can be used to limit max fifo per ep to 
support platforms with less RAM size.
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>    
>>    	/* FIFO size for a single buffer */
>>    	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
Thanks,
Akash

