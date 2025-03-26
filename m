Return-Path: <linux-kernel+bounces-576494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE86A70FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1373B85C8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359C4137930;
	Wed, 26 Mar 2025 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bd/j6VUh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09504EEBB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742964627; cv=none; b=Sj6uKye9wBbTDApODiJdeTgjJ981ev4lg4Ruas48zQKVCfHEEEijel4F40MFu03/af2meXREZHBHXNdJGBOuP/KHD6oJ+j/HrIz8C4qy23e4aCw/1lYB/JdLUqH2pXedLsxQZEQP7fLXM34S8znb5Y1Su/x3WuUdAe6EVm4NDzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742964627; c=relaxed/simple;
	bh=HxEqycPP9HinSyYeSHR46VuVCTfZ52flfMnn6myBy50=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=PrtPQ6H+E0pWscQtsWf9VQOxvvDwZyp9UV0fmZbGMF2zx6RNjZesIbKWWSVhcrlKcN6E6mSEwh/uPDRwFEhx87GT+ovePFL710S29iCIwBwvhEgybeMCyh1cZQ8enp2sFxQPOwQFPie0fWay3TrWOsGgjTFOZtO27I+pkkHWFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bd/j6VUh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PGaWfv008053
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U2vV/YNuPMazCXGTha4yHCmP5M+2x7nFoXODhO281M8=; b=bd/j6VUhLR411mxX
	q8XGlOLfd2Mb1Tr3MG2bbIoK6/uJ4ozK2xvOIJA6Ft9FeWcVEqw8sH6v9xV1F1D8
	Oh8VKET3Vr4K1/zdESRPGi09MJZJxjv4xvIjnGAFYs4xT5PmEYaCubcV6OZOpVVz
	TkhtQgdfOnHD5lr8Brg5pVqc/IsO5ZMNlBJWk4WeXIzyJ1CoOZPOi/Hprfse+GP9
	BBt6PSKpFmheilAvotPaVhEODutKqE1KRSErVX8s0BefgWHh1pMV5R9M0jM5c/7O
	KdhwWd8gs8oMvbnBSHQh+8Bs66GX5HHE6cugbem8PpNABtxRWEjAawGXruEIFk9L
	o5LusQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd33m3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 04:29:36 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2254e500a73so78554935ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742963375; x=1743568175;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2vV/YNuPMazCXGTha4yHCmP5M+2x7nFoXODhO281M8=;
        b=XjT+PrGe8NX1H6NXnk82/7Ww05aWkymsxnxMFs4toU28kXi7H3gAnPvfX664PDg1lt
         5tM0iwyQ0xt5X+1sLZSpRIGwkUbe8kULlc1AqQVf+6LQ0tXJCsdkZH/9Hk0n+oFL35vW
         kV+RgN5Z6nGXhdGAkzduHVOBfwaQReijB75gldvgKZVkuADclSWZBfpyltVFvbkzLO2A
         1O2ua1G0BVsFtYV/ayKz12oWOpTZ1E3c3SWp7cHI/4MmJxP71jluXgpPe//G+f2e6Pwz
         lXwIFQcd4qung+3PUN80DscC54il3dfqdqOFBe0ElepQo9vp2LbylfLtb5yoHN0XSddf
         aGzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQZ8BeWnVK0NWvwZV3urKLftyNBJa10raRuP+7gYLmCM+iIAh89hol9ITJAERQs3IWfYIam98nK3t+mxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4g6gLcaEPIoGh85YXUu7QYgGoACHa4z7KIh0pL0tzs28kDOP
	rjEGdQbq//NNmeFjWc5eOBXJiI8vWC+81MPA45QX8UVK4xy/CMg3JJscwq3eiX4a3xE39T2Ymq1
	GASb7lLQLwOs9jUx9pxuGWY/d1SeUDRJUDyfl/8qyu5IA+6s5jgkXzvPzEhrZo3QGgaEUDlI=
X-Gm-Gg: ASbGncu3iHs/HLIOlVO0F+4w+7547bM/JK+syxRycTQfDrLB4nlc/CbHCNEr8OaOBaH
	QqguprA10jDZIBMB/1LTZMFOzq44ZoNtA0vgc5yB+DsZdr2owX+MrkUCp3a76E80wp+NHHBLg68
	d55AivU7J/LV0z6PYHTo0+4d6tMi9SkzXJ5WeupavoRe3LcOzSmhy6tj/UnZbwJ2zzxv1KhtrK+
	N6ty3lZ+0GKQPMfAaB07r8OAXLVQ3/MzmpiEXMAknMe8hZfURJSKaL73bXVXuRuoY31m7V+YyHt
	4fF92ZYHrMEcjhH3OJThsC8v5ij5dDyObwBnR4IfTUYc+WapNDXshcPoql3DeBb9
X-Received: by 2002:a17:902:d4ca:b0:223:4537:65b1 with SMTP id d9443c01a7336-22780e10a22mr293314175ad.36.1742963375309;
        Tue, 25 Mar 2025 21:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu9uKVox+HgHgxuBVealSCpl1kM6cDkzy79Gz9VEoiNRLHgTsPn59JlgKifX6/ISeyS9dHLw==
X-Received: by 2002:a17:902:d4ca:b0:223:4537:65b1 with SMTP id d9443c01a7336-22780e10a22mr293313975ad.36.1742963374987;
        Tue, 25 Mar 2025 21:29:34 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.123.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f5b7823sm11343675a91.10.2025.03.25.21.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 21:29:34 -0700 (PDT)
Message-ID: <50395ba6-8954-66fc-9d94-a58d22606a85@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 09:59:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ath12k: extend dma mask to 36 bits
Content-Language: en-US
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>, ath12k@lists.infradead.org
References: <20250321162331.19507-1-johan+linaro@kernel.org>
 <b1e44988-a80c-4e60-a093-434e0834aa1a@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <b1e44988-a80c-4e60-a093-434e0834aa1a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Sr0aUBqXakq1BEZXbrQ2vDY20Z45YPRw
X-Proofpoint-ORIG-GUID: Sr0aUBqXakq1BEZXbrQ2vDY20Z45YPRw
X-Authority-Analysis: v=2.4 cv=P646hjAu c=1 sm=1 tr=0 ts=67e382b0 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fyovRE7uNSHUze5DQk8o8A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=BeArKKMxub_AxtE4Z8IA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=842 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260024

Adding original to and cc list back.

When replying please keep all the email addresses as in the original mail.

On 3/25/2025 12:34 PM, Raj Kumar Bhagat wrote:
> On 3/21/2025 9:53 PM, Johan Hovold wrote:
>> Extend the DMA mask to 36 bits to avoid using bounce buffers on machines
>> without an iommu (under OS control) similar to what was done for ath11k
>> in commit dbd73acb22d8 ("wifi: ath11k: enable 36 bit mask for stream
>> DMA").
>>
>> This specifically avoids using bounce buffers on Qualcomm Snapdragon X
>> Elite machines like the Lenovo ThinkPad T14s when running at EL1.
>>
>> Note that the mask could possibly be extended further but unresolved DMA
>> issues with 64 GiB X Elite machines currently prevents that from being
>> tested.
>>
>> Also note that the driver is limited to 32 bits for coherent
>> allocations and that there is no need to check for errors when setting
>> masks larger than 32 bits.
>>
>> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Tested-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> 
> Validated iperf traffic on QCN9274 with FW version -
> WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 

