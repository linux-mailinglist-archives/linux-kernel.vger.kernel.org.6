Return-Path: <linux-kernel+bounces-345614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E81798B815
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A038F1F22FC5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862519D8BC;
	Tue,  1 Oct 2024 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OlF07mwz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060B219D88B;
	Tue,  1 Oct 2024 09:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774108; cv=none; b=PhAxPRugOhll9DrkV9/FfSI0GnTVvlAPKsFe2T/a/RjfACMMnrdvjSL+8KqsTumlyQ8zg8hjnMyhflbl+jl4MqGfLlmHbnYqOkryAFXUFnQiSob22KsEDN/v1MwfTRaKejqX5f08CaSrNkcmOEZ/IMopZe2QDBZ6YapNEPJZK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774108; c=relaxed/simple;
	bh=giYJ35AOrn0zFCpJmSoFexnOsEKYn4cZXaWT+lDw4hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FMqfJmuz+5LoU6dcor758wCEL5dMuemilKFooYUnKuI+9cBYBJzLouhldKZwWQQ/v4aOWPx1QoQx/sd+Jnk/5vSMt1MPRQ8uAJ0cNQ9Q1NE5aqamMPHc92K8tCJy2A4WOE3jesNrLs9iBqcMvHhMmxK5J9rgwV7ocibbe3KebTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OlF07mwz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4910CcLt013905;
	Tue, 1 Oct 2024 09:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rwIyZe2MHKZTATDW3V8DS7rx5Bkiw/lF8Q4miP0xu/g=; b=OlF07mwzIki3CSUL
	lt+1UhVdp5RagyLlo4i/h+HULKCsqJ+0041vYiE7yLwUK8AdgijyoMsxWIUnE1hR
	3upbhbC+N6DWoFnAeqPVVb/GzPKi1mbdedByDkbuuOL48yZS0BnUS48WYk+YFSaD
	DzuK5nJXoDIUyuwFKLS/ZobcU8O+Dq90Aviai2tyHzdnVfZb+S+Hhr7nvmWfq1bI
	/HLMtS6b+lZ9VchOFEyZYDDKzEJ/NNPfRkzKSgQOw4Y3yE6Lb/rDV/3v15mfIuGH
	w2fx1Nw43aBUzCHMJq7i6deEARsPeQEmrUI8b1bprAI0PsC9gC83YeHjEWI60ngB
	DM/8qQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa677nfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:14:59 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4919EvUK010769
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Oct 2024 09:14:57 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 1 Oct 2024
 02:14:50 -0700
Message-ID: <ab09d5de-84bb-41c9-ae74-e62dd5d02d15@quicinc.com>
Date: Tue, 1 Oct 2024 14:44:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi
	<balbi@kernel.org>, Jack Pham <quic_jackp@quicinc.com>,
        "kernel@quicinc.com"
	<kernel@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Laurent
 Pinchart" <laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>,
        Vijayavardhan Vennapusa
	<quic_vvreddy@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240927195931.10404-1-quic_akakum@quicinc.com>
 <20241001012028.eoxwugdaisj2uw2j@synopsys.com>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20241001012028.eoxwugdaisj2uw2j@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: W0uo0GN2ryNhmUAUcC3BEDTFVunOmUvE
X-Proofpoint-ORIG-GUID: W0uo0GN2ryNhmUAUcC3BEDTFVunOmUvE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010060

Hi,

On 10/1/2024 6:50 AM, Thinh Nguyen wrote:
> On Sat, Sep 28, 2024, Akash Kumar wrote:
>> The current logic is rigid, setting num_fifos to fixed values.
>> 3 for any maxburst greater than 1.
>> tx_fifo_resize_max_num for maxburst greater than 6.
>> Additionally, it did not differentiate much between bulk and
>> isochronous transfers, applying similar logic to both.
>>
>> The updated logic is more flexible and specifically designed to meet
>> the unique requirements of both bulk and isochronous transfers. We
>> have made every effort to satisfy all needs and requirements,
>> verified on our specific platform and application.
>>
>> The updated logic is more flexible and specifically designed to meet
>> the unique requirements of both bulk and isochronous transfers. We
>> have made every effort to satisfy all needs and requirements, verified
>> on our specific platform and application.
> Was there a copy-and-paste issue with the above paragraph?
yeah my mistake, will fix.
>> Bulk Transfers: Ensures that num_fifos is optimized by considering both
>> the maxburst and DT property tx_fifo_resize_max_num for super speed and
>> above. For high-speed and below bulk endpoints, a 2K TxFIFO allocation
>> is used to meet efficient data transfer needs, considering
>> FIFO-constrained platforms.
>>
>> Isochronous Transfers: Ensures that num_fifos is sufficient by considering
>> the maximum packet multiplier for HS and maxburst for SS, along with a
>> constraint with the DT property tx_fifo_resize_max_num.
>>
>> This change aims to optimize the allocation of Tx FIFOs for both bulk
>> and isochronous endpoints, potentially improving data transfer efficiency
>> and overall performance. It also enhances support for all use cases,
>> which can be tweaked with DT parameters and the endpoint’s maxburst and
>> maxpacket.
>>
>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>> ---
>> Changes for v5:
>> Update Calculation for HS and below bulk and isoc eps based on
>> suggestion and fixed at 2k for bulk eps considering fifo
>> constrained platforms.
>>
>> Changes for v4:
>> Updated commit message as per review comments to clarify that it has
>> been tested on specific platforms only and tried best to match all
>> expectations.
>>
>> Changes for v3:
>> Redefine logic for resizing tx fifos,added check based on  operating
>> speed and used maxp for HS and maxburst for SS  and defined max
>> allocation based on dt property.
>>
>> Changes for v2:
>> Redefine logic for resizing tx fifos, handled fifo based on  minimum
>> of maxp and maxburts.
>>
>> Changes for v1:
>> Added additional condition to allocate tx fifo for hs isoc  eps,
>> keeping the other resize logic same.
>> ---
>>   drivers/usb/dwc3/gadget.c | 20 +++++++++++++-------
>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 291bc549935b..035d49155d57 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -771,15 +771,21 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   
>>   	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>>   
>> -	if ((dep->endpoint.maxburst > 1 &&
>> -	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
>> -	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>> -		num_fifos = 3;
>> +	if (dwc->gadget->speed <= USB_SPEED_HIGH) {
>> +		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
>> +			num_fifos = 2;
>> +		if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
>> +			num_fifos = min_t(unsigned int,
>> +					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
>> +					  dwc->tx_fifo_resize_max_num);
>> +	}
>>   
>> -	if (dep->endpoint.maxburst > 6 &&
>> +	if (dwc->gadget->speed > USB_SPEED_HIGH &&
>>   	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>> -	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
>> -		num_fifos = dwc->tx_fifo_resize_max_num;
>> +	     usb_endpoint_xfer_isoc(dep->endpoint.desc)))
>> +		num_fifos = min_t(unsigned int,
>> +				  dep->endpoint.maxburst,
>> +				  dwc->tx_fifo_resize_max_num);
>>   
> Do you have a default value for other endpoints?
num_fifos is initialized to 1 in beginning for other eps.
>
> Perhaps we can do something like this? What do you think?
yeah can used since we are using gadget speed only to decide and it will 
be faster as well.
>
> 	num_fifos = 1;
>
> 	switch (dwc->gadget->speed) {
> 	case USB_SPEED_SUPER_PLUS:
> 	case USB_SPEED_SUPER:
> 		if (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
> 		    usb_endpoint_xfer_isoc(dep->endpoint.desc))
> 			num_fifos = min_t(unsigned int,
> 					  dep->endpoint.maxburst,
> 					  dwc->tx_fifo_resize_max_num);
> 		break;
> 	case USB_SPEED_HIGH:
> 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
> 			num_fifos = min_t(unsigned int,
> 					  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
> 					  dwc->tx_fifo_resize_max_num);
> 			break;
> 		}
> 		fallthrough;
> 	case USB_SPEED_FULL:
> 		if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
> 			num_fifos = 2;
> 		break;
> 	default:
> 		break;
> 	}
>
> Thanks,
> Thinh
>
>>   	/* FIFO size for a single buffer */
>>   	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
>> -- 
>> 2.17.1
Thanks,
Akash

