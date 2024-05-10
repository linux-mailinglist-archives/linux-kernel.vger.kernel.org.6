Return-Path: <linux-kernel+bounces-176142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DE8C2AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 21:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19721C214BA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983145026E;
	Fri, 10 May 2024 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fuZfixy6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343564F602;
	Fri, 10 May 2024 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715369206; cv=none; b=EYrol6w643Qi7t/9h08QRVjRzB07EHxVV1wEs/siXclVDhwISqSuA0qxSnIOVAL5Jcj+iRFa9ubcrP9F2HsHUprzBl4Pso985IJ+uiK1EQoWYIF0btLsxvWwJapeWYgdKTso0uRSq8nqqcHivd/6LFwWf+u1VXCehnzUuhlX+4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715369206; c=relaxed/simple;
	bh=O1bd4+8p4WCFjblMydERN3yaGSWD7IAnIxOjLFqL4jE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e5YVE0m3Tpxv4AT1anJd5abqjeEtxYX6Zb/BEcRJKiXGXE7FkbVzImixIUf3YVfYrlv/8Sg86uSXLiyJU0UV1FSBayw41TqtuRyMXUcZ2pkJCvz2m0uiZMTJ46hFbPQ5j6171qq/1jJawVl+u/GyNWS1DiogmJYjV4E8XEDGRY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fuZfixy6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44ACsmNm019682;
	Fri, 10 May 2024 19:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nQ828hEtLQh1cmFR/y04iyD7xocBkfKV99vrLIVbNEs=; b=fu
	Zfixy6iVoDMTmXFvaL+1H6D5/aHAFHmkOQUPC1/rvFImeJrnPLNvDGh/B4Lib0Z5
	ic3bnMHnaxpqND8d1Jqz9HeeZDlqdtNM8GO8OW0dU0igDewe3pZZCOHz8FjVTMCw
	VxDBTMkl++tnrc/aqs8A7CaH35BNmkO2cJ5MEGnNVP+S4XnE4WNUmLG/4el2K6WO
	7UhqP5DUUIO2VmoulgmxgfuCftjbkGDBTACGXSXuNmbxU83pFEmehbiuz4xkTB2q
	K8KHYZxDVxnlcU/livdEb/JzDDLCVcSduVtF49i2xLVHE+jWUWwWQO67EuQBuS34
	pwhmvmvPLleaQTjPwT3A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w1jauy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:26:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44AJQa6s015732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 19:26:36 GMT
Received: from [10.216.5.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 12:26:33 -0700
Message-ID: <0f056ece-6d38-428e-bf18-edb053c90ca7@quicinc.com>
Date: Sat, 11 May 2024 00:56:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
        kernel test robot
	<lkp@intel.com>
References: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
 <20240508230839.utioi5i2c5kozm4d@synopsys.com>
 <2024051050-pantomime-sudden-a382@gregkh>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <2024051050-pantomime-sudden-a382@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 81rkDwsK38m6jfg7r_UFZ37oSdANddt8
X-Proofpoint-GUID: 81rkDwsK38m6jfg7r_UFZ37oSdANddt8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 mlxlogscore=816 mlxscore=0 impostorscore=0 clxscore=1011 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405100139



On 5/10/2024 2:58 PM, Greg Kroah-Hartman wrote:
> On Wed, May 08, 2024 at 11:08:43PM +0000, Thinh Nguyen wrote:
>> On Mon, May 06, 2024, Krishna Kurapati wrote:
>>> While fixing a merge conflict in linux-next, hw_mode variable
>>> was left unused. Remove the unused variable in hs_phy_setup call.
>>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/202405030439.AH8NR0Mg-lkp@intel.com/__;!!A4F2R9G_pg!aXN14tvkvwnNZ9N8-EDi-Seef9jgZBKlkZRYasINRgTOU2ijWbTvFIxkZIXOThGQQHmXc0FjiJPFI1cgdCOyAafAxB-70Q$
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>> ---
>>> Changes in v2:
>>> Added reported by and closes tags.
>>>
>>>   drivers/usb/dwc3/core.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index 8b6f7769fcd5..7f176ba25354 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -676,11 +676,8 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
>>>   
>>>   static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
>>>   {
>>> -	unsigned int hw_mode;
>>>   	u32 reg;
>>>   
>>> -	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
>>> -
>>>   	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
>>>   
>>>   	/* Select the HS PHY interface */
>>> -- 
>>> 2.34.1
>>>
>>
>> Looks like my response reporting the merge issue to Stephen fell through
>> the cracks.
>>
>> Thanks for the patch.
>>
>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> I think I already fixed this up when I did the merge a few hours ago, if
> not, please let me know.
> 

Hi Greg,

  I just checked usb-next and linux-next. The unused variable is still 
there. Can you pick this change up.

Regards,
Krishna,

