Return-Path: <linux-kernel+bounces-341914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA69E98883F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFDE1C203C1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977161C173C;
	Fri, 27 Sep 2024 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IjLG+y2n"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB45142621;
	Fri, 27 Sep 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727450719; cv=none; b=u75EBsiWErwuEJvrFYubAGStsBk4hdA0lpHV+IMrMxa1qJAfhEwRR2yNqbn8TVCKituhKQGSpWuWaecqRitkjHWph+p7N/cFZNnWKaCRIP1ZInq3ka05Dqx9oESsMuFCjvL55k7ypTu9+DyWwqal8/AHsTJTD35RPw3Nh/nfQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727450719; c=relaxed/simple;
	bh=GtNdGifLkPldQy2T3XZfPK88T3aK3GpNxQTvKn06b2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mf9r2pfT4ePsNjRCB8+S19zpUm1r2/ppeui5/zTcfXsl0/nOwnYDckctwF9tAoaZsjUIG41Quvw/ezkyVhFdUdjQixcRNXqGZH/3RVPLzTljQaasAL5lsIZg5b7qFdIz40jvSLJhzPZExQD7jvhDxLYYierE/uhhMd6VctALqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IjLG+y2n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R6srQD003871;
	Fri, 27 Sep 2024 15:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eCQ0nZWQ6bFN+sQbzjr6uh+znWLOume8x97OiDhPaOk=; b=IjLG+y2nbZeX50ZJ
	ScPMDL32lLtscKOgYTd/tGi3IYXt9BQmk+IhrxmdFrBUDuTzTYNKRhgD8UyCJCgG
	s9zGPrnieIHTDjd78vUf9HktI0X4Vwg7Sobavfp9Wrrh/Ofcea9klHaWHwR9K8L9
	S2JfoKJazIlwyisaoYCc7wofgQlpHNONPiT6ysS66YoRP7vKR1tTuyV/iDw7tL0h
	qgPqQITNg7i4OIfNuG9e8iwfxoUww0e+OHU0dWgbaBQ/oLllo95RbwaR8wLojchF
	3lZ8xhbUHw4/wksz6Q6cPZH8O/TFtTJZ5u63vkXHEws3R8cMU8fPpeWcuRdqZMfr
	AivLNA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sqaktygm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 15:25:11 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48RFPAiI005572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Sep 2024 15:25:10 GMT
Received: from [10.216.5.217] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 27 Sep
 2024 08:25:03 -0700
Message-ID: <04885952-caa3-46b5-bd20-7e10897d8aaa@quicinc.com>
Date: Fri, 27 Sep 2024 20:55:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: gadget: Refine the logic for resizing Tx
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
References: <20240917101355.15580-1-quic_akakum@quicinc.com>
 <20240917224026.qsewm3epwaubcgs6@synopsys.com>
 <e2ff397e-b6a2-4991-8431-73aac7356e2b@quicinc.com>
 <20240926221635.63flfmtrryfr25cu@synopsys.com>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20240926221635.63flfmtrryfr25cu@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kIO_r1_WsfFAXSEo-5BAmvq6Z5SHv4Jw
X-Proofpoint-GUID: kIO_r1_WsfFAXSEo-5BAmvq6Z5SHv4Jw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=961
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409270110

Hi Thinh,

On 9/27/2024 3:46 AM, Thinh Nguyen wrote:
> Hi Akash,
>
> Sorry for the delay response.
>
> On Wed, Sep 18, 2024, AKASH KUMAR wrote:
>> Hi Thinh,
>>
>> On 9/18/2024 4:10 AM, Thinh Nguyen wrote:
>>> On Tue, Sep 17, 2024, Akash Kumar wrote:
>>>> The current logic is rigid, setting num_fifos to fixed values:
>>>>
>>>> 3 for any maxburst greater than 1.
>>>> tx_fifo_resize_max_num for maxburst greater than 6.
>>>> Additionally, it did not differentiate much between bulk and
>>>> isochronous transfers, applying similar logic to both.
>>>>
>>>> The new logic is more dynamic and tailored to the specific needs of
>>>> bulk and isochronous transfers:
>>>>
>>>> Bulk Transfers: Ensures that num_fifos is optimized by considering
>>>> both the maxburst value and the maximum allowed number of FIFOs
>>>> based on the DT property tx_fifo_resize_max_num and the maximum
>>>> packet multiplier for HS.
>>>>
>>>> Isochronous Transfers: Ensures that num_fifos is sufficient by
>>>> considering the maximum packet multiplier for HS and maxburst for SS,
>>>> along with a constraint with the DT property tx_fifo_resize_max_num.
>>>>
>>>> This change aims to optimize the allocation of Tx FIFOs for both bulk
>>>> and isochronous endpoints, potentially improving data transfer
>>>> efficiency and overall performance. It also enhances support for all
>>>> use cases, which can be tweaked with DT parameters and the
>>> You should clarify that this is only verified on your specific platform
>>> and specific application. It may not be applicable to all cases.
>>> However, we try our best to make it so. Please reword as such. The
>>> commit message makes it seems that this will work for all cases.
>> Sure will rephrase it, but i believe since it can be customized based on
>> maxpacket and
>> maxburst , anyone can choose his desired fifo size and since we will be get
> The logic depends on what the endpoint's setting will be. The endpoint
> setting is not some runtime field that the user can set. The point I
> want to make is that this is validated on your platform, but it may not
> work for all cases. (e.g. this may use up more available txfifo for
> other endpoints on a more fifo constraint platform)
Ack.
>
>> maxp as 1 (for any streaming packet < 2048)  and additional +1 which we are
>> appending which
>> makes minimum 2k fifo size for HS which should be  sufficient for HS
>> transfers and it can increased with maxpacket when increased to 2k or 3k.
>> Similar with  maxburst for >= SS.
>>>> endpoint’s maxburst and maxpacket
>>>>
>>>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>>>> ---
>>>>    Changes for v3:
>>>>    Redefine logic for resizing tx fifos,added check based on
>>>>    operating speed and used maxp for HS and maxburst for SS
>>>>    and defined max allocation based on dt property.
>>>>
>>>>    Changes for v2:
>>>>    Redefine logic for resizing tx fifos, handled fifo based on
>>>>    minimum of maxp and maxburts.
>>>>
>>>>    Changes for v1:
>>>>    Added additional condition to allocate tx fifo for hs isoc
>>>>    eps, keeping the other resize logic same.
>>>> ---
>>>>    drivers/usb/dwc3/gadget.c | 18 +++++++++++-------
>>>>    1 file changed, 11 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 89fc690fdf34..7557bd0053a7 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -778,15 +778,19 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>>>    	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>>>> -	if ((dep->endpoint.maxburst > 1 &&
>>>> -	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
>>>> -	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>>>> -		num_fifos = 3;
>>>> +	if (dwc->gadget->speed <= USB_SPEED_HIGH &&
>>>> +	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>>>> +	     usb_endpoint_xfer_isoc(dep->endpoint.desc)))
>>>> +		num_fifos = min_t(unsigned int,
>>>> +				  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
>>> This logic looks wrong. This implies maxp_mult is applicable to bulk and
>>> that it's also applicable to speed below highspeed, which it isn't.
>> This is to make it generic as 2k fifo should be suffiecient for bulk eps in
>> HS as explained above
>> and we can increase maxpacket size when required which will incresse fifo
>> size as well.
> I think you missed my point here. The maxp_mult should only be checked
> against isoc and only for highspeed. Please split it out. Make it clear
> that the bulk uses 2k txfifo for highspeed and below.

Sure let me update.

>
>>>> +				  dwc->tx_fifo_resize_max_num);
>>>> -	if (dep->endpoint.maxburst > 6 &&
>>>> +	if (dwc->gadget->speed > USB_SPEED_HIGH &&
>>>>    	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>>>> -	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
>>>> -		num_fifos = dwc->tx_fifo_resize_max_num;
>>>> +	     usb_endpoint_xfer_isoc(dep->endpoint.desc)))
>>>> +		num_fifos = min_t(unsigned int,
>>>> +				  dep->endpoint.maxburst,
>>> maxburst can be 0 right?
>> At composite layer we are incrementing maxburst by 1 so while allocating
>> fifo maxburst can be as minimum as 1,
>> which is required and can be changed anytime with exposed configfs
>> attribute.
> Ok.
>
>>>> +				  dwc->tx_fifo_resize_max_num);
>>>>    	/* FIFO size for a single buffer */
>>>>    	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
>>>> -- 
>>>> 2.17.1
Thanks,
Akash

