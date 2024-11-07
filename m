Return-Path: <linux-kernel+bounces-399391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479D29BFE5A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F274B1F228A3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD1194A64;
	Thu,  7 Nov 2024 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lkuNCTVM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45418192D7E;
	Thu,  7 Nov 2024 06:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960262; cv=none; b=SR/s+Gz5Q4tO3nGnY7dPLs6nLXbtzr1R/B2rOTVaOaJQSadqcUaNlv1VgSs+1ri9AyJeryFDMf7ieEiQHVZ9qaPQGxKW7OKPWXEPfUotf69RI9gBGDh9lLJsdLt6Dpz5EA/4edkq+1JPDufAtciLjm24E6bobPfoxNaRfDQjqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960262; c=relaxed/simple;
	bh=Lcd87M6/Gc7wKV0eGqeEbc5b8cege8gnv1IKK0N4DKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bJcFvFZwnsay/lWC4wFnrANB+ex49hsbN5hpQm61DHIwmZRA5hFji1Sz71MzOrrvPewhn/7NIo45XwppQgF4EoC+iby1HdyXkf9dy8PZh9dAeSqC6JgxZcwsiGTos66vuWvru2ZvZdzBoBk34qUM8adt/FRKe+tKVRyhNDLelQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lkuNCTVM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6G9DRd028492;
	Thu, 7 Nov 2024 06:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pt8i0eEfIpkL9Duhpru2rPlJlEJZ2RbBvR99uKTgRko=; b=lkuNCTVMRq3bSeqM
	j0QF9gkl3Ns+DTepZKy3oExNwtu73GAZand7Z2bwvNm+MJY8vsLl/Wxi8lNJQGeN
	CLt8RzXTYYGsVyR0B+wvnxkiMy8jS+csAlbz7WP06+X6otRUYbepFdzr0eyAmtIq
	J+TMgHPS4a7qO0MWrob0woAMjYFhFYjXWaOzUkV81aUNLBM9DAonOZF9MABtvntW
	XTpR1BknDFMpjp3aYhxun1kSwumqBUHdLjYJPQJp6S8eOGVnkNbi/g6fpgIAdutj
	uBeIY866jSmI70jg7XCeKHR9RITT08h8/Jxpp+M+rt5Px1nX9ZifukR8bRnrc0Dy
	jDaRag==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42r3c1bbd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 06:17:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A76HWiB029074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 06:17:32 GMT
Received: from [10.216.63.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 6 Nov 2024
 22:17:22 -0800
Message-ID: <1129e0a7-6bd0-416e-8c56-6b8d75600c4e@quicinc.com>
Date: Thu, 7 Nov 2024 11:47:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Add
 snps,filter-se0-fsls-eop quirk
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Uttkarsh Aggarwal
	<quic_uaggarwa@quicinc.com>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>
References: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
 <20241017114055.13971-2-quic_uaggarwa@quicinc.com>
 <gclvciv5cmrcut6qvo3kh3ycutqt5sot5k4i2nwics6myhuxvq@cf6ajwflxdlc>
Content-Language: en-US
From: Krishna Kurapati <quic_kriskura@quicinc.com>
In-Reply-To: <gclvciv5cmrcut6qvo3kh3ycutqt5sot5k4i2nwics6myhuxvq@cf6ajwflxdlc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BcZeyWLFOw1xxl1s6ucnZCO6c25cRzE-
X-Proofpoint-ORIG-GUID: BcZeyWLFOw1xxl1s6ucnZCO6c25cRzE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=944 clxscore=1011
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070046



On 10/18/2024 11:57 AM, Krzysztof Kozlowski wrote:
> On Thu, Oct 17, 2024 at 05:10:54PM +0530, Uttkarsh Aggarwal wrote:
>> Adding a new 'snps,filter-se0-fsls-eop quirk' DT quirk to dwc3 core to set
>> GUCTL1 BIT 29. When set, controller will ignore single SE0 glitch on the
>> linestate during transmission. Only two or more SE0 is considered as
>> valid EOP on FS/LS port. This bit is applicable only in FS in device mode
>> and FS/LS mode of operation in host mode.
> 
> Why this is not device/compatible specific? Just like all other quirks
> pushed last one year.

Hi Krzysztof,

  Apologies for a late reply from our end.

  In DWC3 core/dwc3-qcom atleast, there have been no compatible specific 
quirks added. Also since this is a property of the Synopsys controller 
hardware and not QC specific one, can we add it in bindings itself. 
Because this is a property other vendors might also use and adding it 
via compatible might not be appropriate.

  Let us know your thoughts on this.

Regards,
Krishna,

> 
>>
>> Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> index 1cd0ca90127d..d9e813bbcd80 100644
>> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>> @@ -180,6 +180,12 @@ properties:
>>       description: When set core will set Tx de-emphasis value
>>       type: boolean
>>   
>> +  snps,filter-se0-fsls-eop-quirk:
>> +    description:
>> +      When set controller will ignore single SE0 glitch on the linestate during transmit
> 
> Does not look like wrapped according to coding style (checkpatch is not
> a coding style document).
> 
> Best regards,
> Krzysztof
> 
> 

