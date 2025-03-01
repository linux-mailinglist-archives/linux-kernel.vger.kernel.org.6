Return-Path: <linux-kernel+bounces-539751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A92A4A821
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 03:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09C0189B1B8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 02:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99572135A53;
	Sat,  1 Mar 2025 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GUqUTuv4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89D35976;
	Sat,  1 Mar 2025 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740796425; cv=none; b=jPtH6dd2VAobkliSVfykEKGc6+DcQrTsYt1P1d6M0KlmCbtwDnDY4YW+8jgUyDsUqxtCOpg94TCuro4A0nmbAYmdq5F8Lj5JSa9RU8U/RCixyoFHsfK7Oy0Soe9lEHZjW3lo2LmCcoQ6WZfZDkdCKb291JVxbEYezPI9r1wJqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740796425; c=relaxed/simple;
	bh=j+nAxlIa8zrVOHInhC+fPrfi6cTnZ9jAP9nRoUvTYcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gOud/AIPM3XF2RkO2lOcrvAvtXwQgyFZdpbVaOsjgauH0esBMMweudb9oXLH+mOJvbzs+l5D+lOxARpr6y+O2/ayJTbqLWjMK4lBG1Ke+nv7LNet1xti+oD+yrJypLzAmDzWMKzyWDQpvHdfMelK+D0pGZ7Q4iw3WCPHknleFv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GUqUTuv4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5210gmKu002203;
	Sat, 1 Mar 2025 02:33:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83FS6EnfdClfnvfUQxbXHhXsBOrVg7fOHbXnT0FmYtg=; b=GUqUTuv45dj1zWwO
	u1u8wyhjCjAezTGkzlU91Axr9mheYE1YAz+emqetlN43PUH/5XUwVHOvfgvYYB+Q
	2eHAbILvK+RNcxCvhnHu5xMLZnUcHkcGw6Rc58WCB95Mrwp1Mlycr8Jj535G75Fs
	wLLio5bxWaiw/JijlKIsUI5dfmI3rVVTaaFvp35OYV/byg9zu2veYk/HSJSlWu1B
	5dYAhfYHrblOzr/6AX6Ep0Z+SKg6i4uxWKxa+gvrWojy2fjcbwjEwcD9AyZM6Jse
	mae2SgLb3Ph2Han8bPX5Kxigq6apFX8Vakf4AkVUVd40kudUz4RMtPyzgZagyP+j
	5QHkHw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453qxdr5g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Mar 2025 02:33:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5212XdwT004298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Mar 2025 02:33:39 GMT
Received: from [10.71.114.206] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Feb
 2025 18:33:38 -0800
Message-ID: <109547e4-fc2a-42b6-9f16-6e0979b9a49b@quicinc.com>
Date: Fri, 28 Feb 2025 18:33:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Revert "usb: dwc3: gadget: Fix incorrect UDC state
 after manual deconfiguration"
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20250301003452.2675360-1-quic_wcheng@quicinc.com>
 <20250301003452.2675360-2-quic_wcheng@quicinc.com>
 <20250301020131.z7osit3xcqhwrl3n@synopsys.com>
Content-Language: en-US
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <20250301020131.z7osit3xcqhwrl3n@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RlQqd01vPdaKZgBwN2cllCEy4UYpZ48_
X-Proofpoint-ORIG-GUID: RlQqd01vPdaKZgBwN2cllCEy4UYpZ48_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_01,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503010016

Hi Thinh,

On 2/28/2025 6:01 PM, Thinh Nguyen wrote:
> Hi,
> 
> On Fri, Feb 28, 2025, Wesley Cheng wrote:
>> This reverts commit 1ff24d40b3c3c673d833c546f898133b80dffc39.
>>
>> The following change creates a potential use after freed scenario within
>> the UDC core level.  When transitioning from peripheral to host mode, the
>> DWC3 DRD will remove the USB UDC using usb_del_gadget().  As part of the
>> UDC removal routine, the UDC core will issue a pullup disable call back to
>> the DWC3 gadget driver, which will now call usb_gadget_set_state(), and
>> queues gadget->work.  If gadget->work is unable to complete before the USB
>> gadget is freed, then we will run into the use after freed situation.
>>
>> Below is the callstack in question:
>>
>> dwc3_gadget_exit()
>>  --> usb_del_gadget()
>>  --> gadget_unbind_driver()
>>   --> device_del()
>>    --> gadget_unbind_driver()
>>     --> usb_gadget_disconnect_locked()
>>      --> pullup(0)
>>       --> dwc3_gadget_soft_disconnect()
>>        --> usb_gadget_set_state(UNATTACHED)
>>         --> queue_work(gadget->work) --> async
>>   --> device_unregister()
>>
>> Unfortunately, the flush_work() call within usb_del_gadget() doesn't work
>> in this situation, as it happens before the device_del() and soft
>> disconnect sequence.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>  drivers/usb/dwc3/gadget.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 5156fafbda6c..921f72995dbf 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -2781,8 +2781,6 @@ static int dwc3_gadget_soft_disconnect(struct dwc3 *dwc)
>>  	__dwc3_gadget_stop(dwc);
>>  	spin_unlock_irqrestore(&dwc->lock, flags);
>>  
>> -	usb_gadget_set_state(dwc->gadget, USB_STATE_NOTATTACHED);
>> -
>>  	return ret;
>>  }
>>  
> 
> Have you tried with this fix?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=399a45e5237ca14037120b1b895bd38a3b4492ea
> 

Thanks for pointing that out.  Looks like its working fine for me.  Bit odd
that we're still potentially utilizing the usb gadget after calling
device_del(), but I guess that should be fine.

Thanks
Wesley Cheng

