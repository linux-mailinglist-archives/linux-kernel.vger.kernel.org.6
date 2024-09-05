Return-Path: <linux-kernel+bounces-316626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 438C996D217
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6DC21F22BE0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85BC194AE2;
	Thu,  5 Sep 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c8qPTTUn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5860919340B;
	Thu,  5 Sep 2024 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524858; cv=none; b=SFi9CtlzI8plH5RE6Kjpbqx0bsjqkgmLcufKJf+nk9tZ6VTAEBkJgl/89a+Sx0L3AEBg95vc3eLgyPmpF4y5EDDU0itifyaJAFhHcxKoqX+XBVw5GV+8DgzX+UE+/oyueiP0lC9ppRzPuMK9nUltpy1+0GieDdv9xlMKSxDsO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524858; c=relaxed/simple;
	bh=6s3w/mr4RjQUeqVw1fQYw4YYZolhNZf51Eo2auGCCk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oXXWZtSV4LGAAM9i/oSVlRFfYLfIPsS1jhE+IiIYA3bdEQ+ueqL3/UQGVbip5aoP3wV1Pm6c7Wspbzfh17WIfkXDYZpdr2XL9AeSggB7RS9zekHwckO5XdAHyZCdi4JFi39bdphaaWiokkDTybCp95cHQtSGJ42Yl7LMswvGh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c8qPTTUn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4857FQpR020041;
	Thu, 5 Sep 2024 08:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gIh9O+9aJqZrfUs1Te0ir77tDja9hjeRzImtRg1v2IQ=; b=c8qPTTUn7aSNdE4s
	gcxK4cKVy4H3h7vzbdcybMSqy882HTxwZcMyhForRstCh0qsomJ92/donG7Oot0u
	OFxolAr2VNUfN4CBEPQG0JhapRerK59CL2gInwdtPBwr6pBntOHEegpIwFxv2exk
	/sCaKRCs92KzY/GMEt9ObKbIFjsopd6ZQNh7+TugrzyyrDKR7+LdgrNfkfZfWHVW
	3tvReYicu5SdcPh0x2AzJGKit/pp6b9u+IjEPYO0cbOM3NctGE5sIkkNIQIeHNMV
	cH/x3vxC1Kkov5m003P/iXsQHJMGIGUe7hEKfYmDWlJMlCQheMomTHDC+or2TZGU
	AtOCeg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41dxy26px9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Sep 2024 08:27:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4858RLPQ024530
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Sep 2024 08:27:21 GMT
Received: from [10.217.219.148] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Sep 2024
 01:27:14 -0700
Message-ID: <b2ffd1ec-2168-4e58-8aee-b43f1231d4ac@quicinc.com>
Date: Thu, 5 Sep 2024 13:57:11 +0530
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
 <b016abbb-7214-4892-b1d2-1bf3ba1b7560@quicinc.com>
 <20240904220632.35b4nvhmngt6akl6@synopsys.com>
Content-Language: en-US
From: AKASH KUMAR <quic_akakum@quicinc.com>
In-Reply-To: <20240904220632.35b4nvhmngt6akl6@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hLy_BZn3uW2-HeXq4If8xwnz9n0RI-7a
X-Proofpoint-ORIG-GUID: hLy_BZn3uW2-HeXq4If8xwnz9n0RI-7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409050061

Hi Thinh,

On 9/5/2024 3:36 AM, Thinh Nguyen wrote:
> On Wed, Sep 04, 2024, AKASH KUMAR wrote:
>> Hi Thinh,
>>
>> On 9/4/2024 3:41 AM, Thinh Nguyen wrote:
>>> On Tue, Sep 03, 2024, Akash Kumar wrote:
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
>>>> both the maxburst value and the maximum allowed number of FIFOs.
>>>>
>>>> Isochronous Transfers: Ensures that num_fifos is sufficient by
>>>> considering the maxburst value and the maximum packet multiplier.
>>>>
>>>> This change aims to optimize the allocation of Tx FIFOs for both bulk
>>>> and isochronous endpoints, potentially improving data transfer
>>>> efficiency and overall performance.
>>>> It also enhances support for all use cases, which can be tweaked
>>>> with DT parameters and the endpoint’s maxburst and maxpacket.
>>>>
>>>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>>>> ---
>>>> Changes for v2:
>>>> Redefine logic for resizing tx fifos.
>>>>
>>>> Changes for v1:
>>>> Added additional condition to allocate tx fifo for hs isoc eps,
>>>> keeping the other resize logic same.
>>>> ---
>>>>    drivers/usb/dwc3/gadget.c | 15 ++++++---------
>>>>    1 file changed, 6 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>> index 89fc690fdf34..49809a931104 100644
>>>> --- a/drivers/usb/dwc3/gadget.c
>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>> @@ -778,15 +778,12 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>>>>    	ram1_depth = DWC3_RAM1_DEPTH(dwc->hwparams.hwparams7);
>>>> -	if ((dep->endpoint.maxburst > 1 &&
>>>> -	     usb_endpoint_xfer_bulk(dep->endpoint.desc)) ||
>>>> -	    usb_endpoint_xfer_isoc(dep->endpoint.desc))
>>>> -		num_fifos = 3;
>>>> -
>>>> -	if (dep->endpoint.maxburst > 6 &&
>>>> -	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
>>>> -	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
>>>> -		num_fifos = dwc->tx_fifo_resize_max_num;
>>>> +	if (usb_endpoint_xfer_bulk(dep->endpoint.desc))
>>>> +		num_fifos = min_t(unsigned int, dep->endpoint.maxburst + 1,
>>>> +				  dwc->tx_fifo_resize_max_num);
>>>> +	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
>>>> +		num_fifos = max_t(unsigned int, dep->endpoint.maxburst,
>>>> +				  usb_endpoint_maxp_mult(dep->endpoint.desc));
>>> No. Don't mix usb_endpoint_maxp_mult with maxburst like this. Check base
>>> on operating speed. Also, now you're ignoring tx_fifo_resize_max_num for
>>> isoc.
>> Sure will add separate check based on speed.
>>
>> We have to support three versions of CAM support through same dt and image
>> SS/SS+ capable cam which needs 10k fifo
>> HS cams which needs 3K
>> multi UVC cams which needs 1k and 2k fifo
>>
>> Putting any dependency with tx_fifo_resize_max_num, we can't achieve 1k and
>> 10K,
> That doesn't make sense. The tx_fifo_resize_max_num is a configurable
> constraint through devicetree property. How can it not work?
i have tested and i don't have any problem in adding constraint with HS 
but for SS
i need to set fifo size of 1K for 1 cam and 10k for other.
if i add any boundary with tx_fifo_resize_max_num (either max or min ) 
one of tx fifo size
either 1k or 10K i won't be able to set. So i request you allow to for 
 >=SS , to decide fifo
size based on maxburst only. i will be pusing patchset3 with that. 
please approve consideration this.
>> it has to be decided by maxbursts itself which user can configure.
>> All uvc gadget applications supports configurable maxburst which they use
>> while opening,
>> so it should be better for isoc eps to decide fifo based on maxbursts.
>>
> We should not just look at maxburst. It's only applicable to usb3
> speeds. How the function driver configures maxp_mult* vs maxbursts is
> independent. So let's keep the check separate base on speed for isoc.
>
> Thanks,
> Thinh
>
> [*] Let's refer the mouthful "additional transaction opportunities" as
> maxp_mult.

yes of course i will add separate check for maxp_mult in patchset3 for 
<=HS speed devices.

Thanks,
Akash

