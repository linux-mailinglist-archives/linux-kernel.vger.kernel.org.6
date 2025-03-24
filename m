Return-Path: <linux-kernel+bounces-573332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF81A6D5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8790516FAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13725C706;
	Mon, 24 Mar 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kQm5eO3I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7C82512D8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742803546; cv=none; b=Z3mZY08urI7Qqo+PUkITmdH/pr8pGYWFif4fqQ+iRY8C7fCtPpLl0AV+iOSmY0LI8ATnNogImLQ44GsIQF7swJ3Z3KaOSY1lm9sj/QudEsw3OTqldzSWpwjGvIyGOh333RiAHC0A9W4X6ag6ykybsEtahPIKXRa/kC6yVd+b3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742803546; c=relaxed/simple;
	bh=S/Q/cmvjORyllVqkKmvXSGVShiTGxtyrAPfuuXoaXP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WPM87FM1lvNhTIBywPDCaQK9y+6FXpTZnkFLR37SpG3GYuzu+vQnxJH42s9FT2sk2VNlX+qe75a8ogPW1c/z0rjeh7oWZ6WIWt96yb8uBjssraV+FVVwF6wBLuLHXswqHGi2E1ZlgdT00daVCfglHwPAAE+JjpwG0sjhWDPFkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kQm5eO3I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O6c3a0001787;
	Mon, 24 Mar 2025 08:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GiZikm6IvzzQWX6CT9gL5kOPLfz2b9r0DDzgSO0bZyo=; b=kQm5eO3I3oNcWYSL
	sK/nlPLVwfrjXEaFj54BQUKK7mTTmHc8iA+nUK7Ic1mzbdY69qPKEp5VQC4OkaG5
	tT7G0Jn82IhzY3vSHyNsRfbrY9T91hxkdZejL2MYNoCbMTYw3AjYj84UDr1HAPMC
	+divdF43wt5zVQ21eKMx17oLg1IQ6tLV0BntAqA01Tzjp/A1wAppgbawvarnY4hR
	zihgv+yPwSnwfPoUUzUtwBo9XaA0hmpeYmICcjEEv4TuerEej1AwPebQXYQwujm+
	NGXdau6OEo82huNZp3DKxqFMMm/wF8XI2K8rkR/4e6nt7LH9kUrkiFmqJK677yAZ
	W/muIA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm5uumu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 08:05:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52O85dbU011050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 08:05:39 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Mar
 2025 01:05:37 -0700
Message-ID: <a1aa02e8-7f58-46ae-b3df-ae43288cf683@quicinc.com>
Date: Mon, 24 Mar 2025 16:05:33 +0800
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
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <Z-EMgPg5Gp-JtTZp@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jyA0r0eLjHC-X6nZZ87De9CCb1vuhA17
X-Proofpoint-GUID: jyA0r0eLjHC-X6nZZ87De9CCb1vuhA17
X-Authority-Analysis: v=2.4 cv=AJKH5mlP c=1 sm=1 tr=0 ts=67e11254 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=2XIbIgQLYS011rX2vRkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=888 adultscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240058



On 3/24/2025 3:40 PM, Johan Hovold wrote:
> On Mon, Mar 24, 2025 at 11:06:16AM +0800, Baochen Qiang wrote:
>> On 3/22/2025 12:23 AM, Johan Hovold wrote:
>>> Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
>>> without an iommu (under OS control) similar to what was done for ath11k
>>> in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
>>> DMA").
>>>
>>> This specifically avoids using bounce buffers on Qualcomm Snapdragon X
>>> Elite machines like the Lenovo ThinkPad T14s when running at EL1.
>>
>> why bounce buffer is used at EL1? is it because IOMMU is not working at EL1?
>> or even because IOMMU is not present on Elite machines?
> 
> As I mentioned above, the IOMMU is not under OS control. The boot
> firmware / hypervisor has configured the IOMMU in by-pass mode and it's
> effectively missing from the OS POV.
> 
> Note that this is also the case on Qualcomm platforms like sc8280xp
> (e.g. the Lenovo ThinkPad X13s which already benefits from the extended
> DMA mask for ath11k).
> 
>>> Note that the mask could possibly be extended further but unresolved DMA
>>> issues with 64 GiB X Elite machines currently prevents that from being
>>> tested.
>>
>> could you help elaborate how it could be extended?
> 
> The mask should reflect the capability of the device. That may be
> 64 (or 40) bits, but I've only been able to test using 36 bits.

are you talking about QCN9274? As far as I know, WCN7850 does not support 40 bits or more.

> 
>>> Also note that the driver is limited to 32 bits for coherent
>>> allocations and that there is no need to check for errors when setting
>>> masks larger than 32 bits.
>>
>> why is it not necessary to check error?
> 
> The DMA-API documentation was recently updated to clarify that there is
> no need to check for errors when settings DMA mask with 32 bits or more
> as the call will never fail in that case. See commit
> 
> 	f7ae20f2fc4e ("docs: dma: correct dma_set_mask() sample code")

thanks for the info.

> 
> Johan


