Return-Path: <linux-kernel+bounces-332483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1397BA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED2028128A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4C1891B5;
	Wed, 18 Sep 2024 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hGe4/q9e"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5833F188A2F;
	Wed, 18 Sep 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726652603; cv=none; b=NZUD07rG8bO5b/QMtCJzzu57dGXCPw+jBrGskVyoCvkXd3mXs6hXOiWycumzFKQoc32bw802MPtynTrZbMMLZYLU76IFKDYP298PwmtwhQJxPvYrBW5aAMMQsNEpn6mLAmq02Nv/SlPcJ8I5t4GxpgKMkrUBHUpTFwabGLJ3cQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726652603; c=relaxed/simple;
	bh=wfENwdPTOSnpks1YE1na4JDWh+0LgtfZCKP55/kYojg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=loCtG1u+LSa5aUv2hxC3D2aQxN75Kd/SIosOBkQNHeb8PKgvik3Ov4S0pfzFqz8KNZoUFbZGNpAZ/z5wU1yuLikIQMJN++fP3Bbw7BgpcHylaD0TlRDeufeaetakzQylPWvUVxWsj8lAltxJ7DYGlwcChvRHQAf0BV7pxIQFA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hGe4/q9e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I8wr4d032430;
	Wed, 18 Sep 2024 09:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	abgv+TJeo6d097LQLTf+yfLZj9xzro7h+12orvMbBTY=; b=hGe4/q9egkcsNPFm
	K+OXIget1CR66/KuopyWmbCMtZebaGh+52CVruhFvztACjMOq87uoewh+rxuGtWS
	RAbgUakBdO2BurZUnZENs1eBGwopn/BHhRUlhyTCUuPJh/P/TLONz4KrkisNdhpB
	kFG46PVGehQRPNGq2mQMcikJtpp6barDKXPW+kZQeomQhYEyx0idpLSCBSmsswKv
	Tyht+fgacgRpMoMKWfEOVWnky9RVyMFOPa2/R2PHW/yap4Z/yp6JxsDEQlC3aKtf
	3zcTXLSaQCOIVYcybE/iTw7BGg15TfDSi0VrI/MFNDV2iEjkhFTjOUSH9mnmGHrY
	et3fiA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jesjnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:43:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48I9hCTa015652
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:43:12 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Sep
 2024 02:43:06 -0700
Message-ID: <e2ff397e-b6a2-4991-8431-73aac7356e2b@quicinc.com>
Date: Wed, 18 Sep 2024 15:13:03 +0530
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
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20240917224026.qsewm3epwaubcgs6@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zsUyu87XCBNOY4_wgtRvpjxKwulTtMuh
X-Proofpoint-GUID: zsUyu87XCBNOY4_wgtRvpjxKwulTtMuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=986 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409180061

Hi Thinh,

On 9/18/2024 4:10 AM, Thinh Nguyen wrote:
> On Tue, Sep 17, 2024, Akash Kumar wrote:
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
>> both the maxburst value and the maximum allowed number of FIFOs
>> based on the DT property tx_fifo_resize_max_num and the maximum
>> packet multiplier for HS.
>>
>> Isochronous Transfers: Ensures that num_fifos is sufficient by
>> considering the maximum packet multiplier for HS and maxburst for SS,
>> along with a constraint with the DT property tx_fifo_resize_max_num.
>>
>> This change aims to optimize the allocation of Tx FIFOs for both bulk
>> and isochronous endpoints, potentially improving data transfer
>> efficiency and overall performance. It also enhances support for all
>> use cases, which can be tweaked with DT parameters and the
> You should clarify that this is only verified on your specific platform
> and specific application. It may not be applicable to all cases.
> However, we try our best to make it so. Please reword as such. The
> commit message makes it seems that this will work for all cases.
Sure will rephrase it, but i believe since it can be customized based on 
maxpacket and
maxburst , anyone can choose his desired fifo size and since we will be 
get maxp as 1 (for any streaming packet < 2048)  and additional +1 which 
we are appending which
makes minimum 2k fifo size for HS which should be  sufficient for HS 
transfers and it can increased with maxpacket when increased to 2k or 3k.
Similar with  maxburst for >= SS.
>
>> endpoint’s maxburst and maxpacket
>>
>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>> ---
>>   Changes for v3:
>>   Redefine logic for resizing tx fifos,added check based on
>>   operating speed and used maxp for HS and maxburst for SS
>>   and defined max allocation based on dt property.
>>
>>   Changes for v2:
>>   Redefine logic for resizing tx fifos, handled fifo based on
>>   minimum of maxp and maxburts.
>>
>>   Changes for v1:
>>   Added additional condition to allocate tx fifo for hs isoc
>>   eps, keeping the other resize logic same.
>> ---
>>   drivers/usb/dwc3/gadget.c | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 89fc690fdf34..7557bd0053a7 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -778,15 +778,19 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>   
>>   	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>>   
>> -	if ((dep->endpoint.maxburst > 1 &&
>> -	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
>> -	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>> -		num_fifos = 3;
>> +	if (dwc->gadget->speed <= USB_SPEED_HIGH &&
>> +	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>> +	     usb_endpoint_xfer_isoc(dep->endpoint.desc)))
>> +		num_fifos = min_t(unsigned int,
>> +				  usb_endpoint_maxp_mult(dep->endpoint.desc) + 1,
> This logic looks wrong. This implies maxp_mult is applicable to bulk and
> that it's also applicable to speed below highspeed, which it isn't.
This is to make it generic as 2k fifo should be suffiecient for bulk eps 
in HS as explained above
and we can increase maxpacket size when required which will incresse 
fifo size as well.
>
>> +				  dwc->tx_fifo_resize_max_num);
>>   
>> -	if (dep->endpoint.maxburst > 6 &&
>> +	if (dwc->gadget->speed > USB_SPEED_HIGH &&
>>   	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>> -	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
>> -		num_fifos = dwc->tx_fifo_resize_max_num;
>> +	     usb_endpoint_xfer_isoc(dep->endpoint.desc)))
>> +		num_fifos = min_t(unsigned int,
>> +				  dep->endpoint.maxburst,
> maxburst can be 0 right?
At composite layer we are incrementing maxburst by 1 so while allocating 
fifo maxburst can be as minimum as 1,
which is required and can be changed anytime with exposed configfs 
attribute.
>
>> +				  dwc->tx_fifo_resize_max_num);
>>   
>>   	/* FIFO size for a single buffer */
>>   	fifo = dwc3_gadget_calc_tx_fifo_size(dwc, 1);
>> -- 
>> 2.17.1
Thanks,
Akash

