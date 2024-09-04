Return-Path: <linux-kernel+bounces-314802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E1E96B938
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A7B247DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0191D0147;
	Wed,  4 Sep 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nCv3HGcu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4611865F0;
	Wed,  4 Sep 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446972; cv=none; b=C5juyK3X6zZb/wr83WJvGLvEbBKqSHyk1GMZVdQi2PeW7uSkLo/sITOGaNnsw8OBdKj+0jY9IovWHrOGcZXSN7SQXgOPWdoMymWDrFpHfFJS6oK1AG65EOxWGowEl5KUjnOzHY+oif1TWngUZZn2tVcCJ4xqBvEGGoMqYBSx+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446972; c=relaxed/simple;
	bh=0ijP+pVmbADabEuDyLRkpzrf3oC7O0FWuy5uCaOr28w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XblxuVXS6qcPEB4V0cWTplOgFkg8GowqtX9iWmnz6SsP+8Qb7zd/whDiW72Sfn8DVk/rHIY2yTVXDk+kZa0AF/TSL+W0bqp7apoi+/uwgkRRspsIs19tUC/QjSJPrIrhTuLGbDliVe4W6yIcwWq0dQOCbAskyi6zgWl2Vyhhl/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nCv3HGcu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4849h0Cb027357;
	Wed, 4 Sep 2024 10:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O98drQdkSode7+dkoFVrCnCB9AJPpOKGVsLRbhcDHbM=; b=nCv3HGcuEuQ5MVZ0
	tjkiNhZftb32t6TpxlT7Yf4EYjLTqevForavP4tXAkDhNEJDc3uMLI90MSH3r8aP
	0ioCg0lUgdvjKjGcMoqkTGzu3AXP1+0i36Nohf+4nLTVGtMryqFcGmKl4prHZToC
	LTtzaOg4YDzPrkSu6L0QUgWcUbodJQmJxdWDW4nNrEiqln0VC4Gb0ejDQLrjl1Ft
	ZjHET3JtgjwNtbsW5naDCwXM7E3LyLiM0ej9299h6CSGpXh6MfEtPspbvTGv7jsS
	HFinAwl9hUPcpvkoc9hJgpUM0/Saly82gCkDFqAp8LG4RXVSSOw/ONStucM64x51
	Yt6ujQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt672j4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 10:49:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484AnLZn000395
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 10:49:21 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 03:49:14 -0700
Message-ID: <b016abbb-7214-4892-b1d2-1bf3ba1b7560@quicinc.com>
Date: Wed, 4 Sep 2024 16:19:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: gadget: Refine the logic for resizing Tx
 FIFOs
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
References: <20240903132917.603-1-quic_akakum@quicinc.com>
 <20240903221055.s4gu6actfbrkonmr@synopsys.com>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20240903221055.s4gu6actfbrkonmr@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: R4vkwNhuaDIAm_x4aCxkuzty1zm6Uir0
X-Proofpoint-GUID: R4vkwNhuaDIAm_x4aCxkuzty1zm6Uir0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_09,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040081

Hi Thinh,

On 9/4/2024 3:41 AM, Thinh Nguyen wrote:
> On Tue, Sep 03, 2024, Akash Kumar wrote:
>> The current logic is rigid, setting num_fifos to fixed values:
>>
>> 3 for any maxburst greater than 1.
>> tx_fifo_resize_max_num for maxburst greater than 6.
>> Additionally, it did not differentiate much between bulk and
>> isochronous transfers, applying similar logic to both.
>>
>> The new logic is more dynamic and tailored to the specific needs of
>> bulk and isochronous transfers:
>>
>> Bulk Transfers: Ensures that num_fifos is optimized by considering
>> both the maxburst value and the maximum allowed number of FIFOs.
>>
>> Isochronous Transfers: Ensures that num_fifos is sufficient by
>> considering the maxburst value and the maximum packet multiplier.
>>
>> This change aims to optimize the allocation of Tx FIFOs for both bulk
>> and isochronous endpoints, potentially improving data transfer
>> efficiency and overall performance.
>> It also enhances support for all use cases, which can be tweaked
>> with DT parameters and the endpoint’s maxburst and maxpacket.
>>
>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>> ---
>> Changes for v2:
>> Redefine logic for resizing tx fifos.
>>
>> Changes for v1:
>> Added additional condition to allocate tx fifo for hs isoc eps,
>> keeping the other resize logic same.
>> ---
>>   drivers/usb/dwc3/gadget.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 89fc690fdf34..49809a931104 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -778,15 +778,12 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   
>>   	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
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
>> +	if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
>> +		num_fifos = min_t(unsigned int, dep->endpoint.maxburst + 1,
>> +				  dwc->tx_fifo_resize_max_num);
>> +	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
>> +		num_fifos = max_t(unsigned int, dep->endpoint.maxburst,
>> +				  usb_endpoint_maxp_mult(dep->endpoint.desc));
> No. Don't mix usb_endpoint_maxp_mult with maxburst like this. Check base
> on operating speed. Also, now you're ignoring tx_fifo_resize_max_num for
> isoc.
Sure will add separate check based on speed.

We have to support three versions of CAM support through same dt and image
SS/SS+ capable cam which needs 10k fifo
HS cams which needs 3K
multi UVC cams which needs 1k and 2k fifo

Putting any dependency with tx_fifo_resize_max_num, we can't achieve 1k 
and 10K,
it has to be decided by maxbursts itself which user can configure.
All uvc gadget applications supports configurable maxburst which they 
use while opening,
so it should be better for isoc eps to decide fifo based on maxbursts.

Thanks,
Akash


