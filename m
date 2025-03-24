Return-Path: <linux-kernel+bounces-573353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 813BAA6D625
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16A53B0143
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A437325D213;
	Mon, 24 Mar 2025 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MWGdIghh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F74125D1FB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805000; cv=none; b=lireCulL0ekpACBDDNWvP3CTPhV/xpqSa9SG3yc9rbAsix+XTsCWSRSvJySVBnvbjYSe14q0YW3vfh2XCj7MCa9Auwsw/n0C+cDOZF3/+sVRIyKGy9o37xblW2ilZelfRUxblg0f7A1UWq3GXE3PcDHSZf570L0v3rpMTcwt5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805000; c=relaxed/simple;
	bh=Sxi6QWEJ195DH+Y5ivOYbvDIfggMwiBXal7Xe7m1ghk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V2awLgLXVHjel61DgqJDxfSsIVl5x7PxixCN1lCN6EvXepi5ew0ZYUnGi+a0unEp17TNAJwgdJJnRZ8w93VFkkMwDZseka8prKj6Q5E7JrKE5dR48AfLFjDKQYZpZ8a+YzHxLzbLhZVyxQJgF8CLI5Q7InOB8CKRS+LJ+tgAcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MWGdIghh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O8NZXG015046;
	Mon, 24 Mar 2025 08:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rONCS7bB7sM/9ZUOYO4ll/WXA4TLwIOoxudfJLJCwnE=; b=MWGdIghhBaeDqX/k
	ThOjCTG2O4CYs+8hbRa18spT1+xgRxYfnHhq8iQauRuYSPGR1AcvCikab8KdiCa8
	uU8vd8lAFGNQ9MAzmBfNUrzBd7Yx8uyN5nH2KnYsIEeCnhCbmcO0M/S2BhA3/nY+
	eT4chSzIygZWgJ5a7YjtcLJHsMCoNFnZM+DzW7xaAO2XjTkVLYYj93HSA73bufw9
	DiDyb4g7pr9adMCUPk9c6kxTauIE8zIeX1Od2K9UapZ8+DC+F44RhkTf0WWXfVb5
	hm4OqIAs4Fkaf5ncUZ39w0aZNgt9SJFLpZ3WumXfhNDgt1L4rwcpbTs0m4iL1E9G
	pSqdEg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hpgbbgae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 08:29:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52O8TrI4004033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 08:29:53 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Mar
 2025 01:29:51 -0700
Message-ID: <a661f86c-7ecc-46fc-a3af-90ad05a0c603@quicinc.com>
Date: Mon, 24 Mar 2025 16:29:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
To: Johan Hovold <johan@kernel.org>
CC: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250321162331.19507-1-johan+linaro@kernel.org>
 <bc3601ae-5639-4ee4-bbcb-4e39b542bfbe@quicinc.com>
 <Z-EMgPg5Gp-JtTZp@hovoldconsulting.com>
 <a1aa02e8-7f58-46ae-b3df-ae43288cf683@quicinc.com>
 <Z-EV21KDfMHds73Q@hovoldconsulting.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <Z-EV21KDfMHds73Q@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=BoydwZX5 c=1 sm=1 tr=0 ts=67e11801 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=UeQ6FwR1gd7q9h-8i14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: r0qJsfyVh6xZTopEqkXPRjRqzQzd8leJ
X-Proofpoint-ORIG-GUID: r0qJsfyVh6xZTopEqkXPRjRqzQzd8leJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=760 lowpriorityscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240061



On 3/24/2025 4:20 PM, Johan Hovold wrote:
> On Mon, Mar 24, 2025 at 04:05:33PM +0800, Baochen Qiang wrote:
>> On 3/24/2025 3:40 PM, Johan Hovold wrote:
>>> On Mon, Mar 24, 2025 at 11:06:16AM +0800, Baochen Qiang wrote:
>>>> On 3/22/2025 12:23 AM, Johan Hovold wrote:
>>>>> Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
>>>>> without an iommu (under OS control) similar to what was done for ath11k
>>>>> in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
>>>>> DMA").
>>>>>
>>>>> This specifically avoids using bounce buffers on Qualcomm Snapdragon X
>>>>> Elite machines like the Lenovo ThinkPad T14s when running at EL1.
> 
>>>>> Note that the mask could possibly be extended further but unresolved DMA
>>>>> issues with 64 GiB X Elite machines currently prevents that from being
>>>>> tested.
>>>>
>>>> could you help elaborate how it could be extended?
>>>
>>> The mask should reflect the capability of the device. That may be
>>> 64 (or 40) bits, but I've only been able to test using 36 bits.
>>
>> are you talking about QCN9274? As far as I know, WCN7850 does not support 40 bits or more.
> 
> Or really all devices handled by ath12k since they at least currently
> use a common mask.
> 
> The T14s has a:
> 
> 	0004:01:00.0 Network controller: Qualcomm Technologies, Inc WCN785x Wi-Fi 7(802.11be) 320MHz 2x2 [FastConnect 7800] (rev 01)
> 
> 	ath12k_pci 0004:01:00.0: Hardware name: wcn7850 hw2.0
> 	ath12k_pci 0004:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0xff soc_id 0x40170200
> 
> Sounds like 36 bits is the correct choice for now then.

yes, let's keep it as 36 for now.

> 
> Johan


