Return-Path: <linux-kernel+bounces-306130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3411D96398F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D851C23AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5F31474AF;
	Thu, 29 Aug 2024 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wm+Dinpj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1923C482;
	Thu, 29 Aug 2024 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907344; cv=none; b=oV4jWu6158PFWbYGXiqtvoFTMjvl0OKFScrcA3+V3qyv+JrdhywUbgrxGvz7p/Qvq+RzNj9wfci1yCDVldEzLRmt2wxDgaFMUQH05qUmOFvixSkz4DcDNx2hnvZIekR7piDfllescIScmYPDNw3HQqqm5qo+MCGlLb5SHTHiRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907344; c=relaxed/simple;
	bh=uWcHlEvJ7ed6HcFVr1GcUG1JbA4ZaKV+OkgCApJLB7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O7VsEoJyzEe1z3jhJYs1JA/f87dRb4aReMDHAlzQTsUunlqJvJG3nJ0wbwGyrEXkZY9YwgCJLQFT3+NXLcd4j358fjcSZcgoJeB6Jv5qZHnKyNWfJp+C2+AoJGbrhn8WDfzYGBHepouj7+GMhAkwF6FAf+xPlCqumfMqv9Gh+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wm+Dinpj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJM9or020195;
	Thu, 29 Aug 2024 04:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DRMYA8nZD3wfsy+K2qIWo7JASNThTUlmgSjiUMdKroM=; b=Wm+Dinpjsvs+/T+l
	ISB0jQuW/+0vaf9RL+TCYKef+6giH7aQqMT+SF7vqN6DdBWlvr51VqWVo/NDQrdu
	Okc74N79hj/DbgIhD7S9FUce2ZuZoLLDwWBPG6qop+IyA3UX722NJFcU7DW1bX+6
	6oQpFXe/VBZkwT9oB0sgsKiGGQnexDoUeX4PkeS5wIW6KULUZ+PSwZfGoCax7LhG
	LZVv/9Xwyp0Puk6liAduhQ6wZ7WCb0LT8Pz9IZR685YJQa3ifJais2GuKX3KzMfA
	MsO48OqqwjpZsIdeB5O2XHdfFw/dIfiCzY8Dh/ZRcEZXHNlZoB9CjJ/ZZsa2rR6u
	T1yzdQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419q2xux3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 04:55:38 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47T4tahv023781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 04:55:36 GMT
Received: from [10.218.39.189] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 21:55:35 -0700
Message-ID: <3a8d5bc4-1e3f-df6c-280f-873f0e31af5a@quicinc.com>
Date: Thu, 29 Aug 2024 10:25:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] usb: dwc3: core: Set GUCTL1[29] to ignore single SE0
 glitch for FS/LS operation
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20240823055642.27638-1-quic_uaggarwa@quicinc.com>
 <20240828021058.dxzzvrdqat4gwut2@synopsys.com>
Content-Language: en-US
From: UTTKARSH AGGARWAL <quic_uaggarwa@quicinc.com>
In-Reply-To: <20240828021058.dxzzvrdqat4gwut2@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: svzJdDATeMoed2_i6gSmqxzsiy4UFkJK
X-Proofpoint-GUID: svzJdDATeMoed2_i6gSmqxzsiy4UFkJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_02,2024-08-29_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408290034


On 8/28/2024 7:41 AM, Thinh Nguyen wrote:
> On Fri, Aug 23, 2024, Uttkarsh Aggarwal wrote:
>> Currently in few of Qualcomm chips USB LS mouse not detected
>> showing following errors:
>>
>> [ 81.585361] usb 1-1: Device not responding to setup address.
>> [ 81.798676] usb 1-1: device not accepting address 2, error -71
>> [ 81.928378] usb 1-1: new low-speed USB device number 3 using xhci-hcd
>> [ 82.076248] usb 1-1: Device not responding to setup address.
>> [ 82.290630] usb 1-1: Device not responding to setup address.
>> [ 82.503877] usb 1-1: device not accepting address 3, error -71
>> [ 82.512548] usb usb1-port1: attempt power cycle
>>
>> Based on the Logic analyzer waveforms, It has been identified that
>> there is skew of about 8nS b/w DP & DM linestate signals
>> (o/p of PHY & i/p to controller) at the UTMI interface,
>> Due to this controller is seeing SE0 glitch condition,
>> this is causing controller to pre-maturely assume that PHY
>> has sent all the data & is initiating next packet much early,
>> though in reality PHY is still busy sending previous packets.
>>
>> Enabling the GUCTL1.FILTER_SE0_FSLS_EOP bit29 allows the controller
>> to ignore single SE0 glitches on the linestate during transmission.
>> Only two or more SE0 signals are recognized as a valid EOP.
>>
>> When this feature is activated, SE0 signals on the linestate
>> are validated over two consecutive UTMI/ULPI clock edges for EOP detection.
>>
>> Device mode (FS): If GUCTL1.FILTER_SE0_FSLS_EOP is set,
>> then for device LPM handshake, the controller ignores single
>> SE0 glitch on the linestate during transmit. Only two or more
>> SE0 is considered as a valid EOP on FS port.
>>
>> Host mode (FS/LS): If GUCTL1.FILTER_SE0_FSLS_EOP is set, then
>> the controller ignores single SE0 glitch on the linestate during transmit.
>> Only two or more SE0 is considered as a valid EOP on FS/LS port.
>>
>> Signed-off-by: Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 10 ++++++++++
>>   drivers/usb/dwc3/core.h |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 3e55838c0001..1edb16d2940c 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -194,6 +194,16 @@ static void __dwc3_set_mode(struct work_struct *work)
>>   
>>   	switch (desired_dr_role) {
>>   	case DWC3_GCTL_PRTCAP_HOST:
>> +
>> +		/*
>> +		 * Setting GUCTL1 bit 29 so that controller
>> +		 * will ignore single SE0 glitch on the linestate
>> +		 * during transmit.
>> +		 */
>> +		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
>> +		reg |= DWC3_GUCTL1_FILTER_SE0_FSLS_EOP;
>> +		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
>> +
>>   		ret = dwc3_host_init(dwc);
>>   		if (ret) {
>>   			dev_err(dwc->dev, "failed to initialize host\n");
>> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
>> index e3eea965e57b..73e90daafecf 100644
>> --- a/drivers/usb/dwc3/core.h
>> +++ b/drivers/usb/dwc3/core.h
>> @@ -271,6 +271,7 @@
>>   #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
>>   #define DWC3_GUCTL1_PARKMODE_DISABLE_HS		BIT(16)
>>   #define DWC3_GUCTL1_RESUME_OPMODE_HS_HOST	BIT(10)
>> +#define DWC3_GUCTL1_FILTER_SE0_FSLS_EOP		BIT(29)
>>   
>>   /* Global Status Register */
>>   #define DWC3_GSTS_OTG_IP	BIT(10)
>> -- 
>> 2.17.1
>>
> This is your platform specific quirk. Please add proper checks to target
> your platform only.
>
> Thanks,
> Thinh

Thanks Thinh for the comments. I will push v2 with a quirk check.

Thanks,

Uttkarsh


