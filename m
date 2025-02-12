Return-Path: <linux-kernel+bounces-512066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA95A3339B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735FA3A80BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3067520ADEF;
	Wed, 12 Feb 2025 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHN/72TF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0D825A2C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403914; cv=none; b=GYO9s3h+s7Q640AKBLGEmwDXy1MwcyRSmkL7bmB4f4BsGhO0SyVWQmo+FD/nEXFvPh31gFygzwXYemoC+zcuBLm1Af0yBvQofCUQ8ze5goo0RXi9hOB/0bu38Y5bLFkIxUVPVVXpus/7prwdZDkZzsCzf271ALD+r59MQGq3nsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403914; c=relaxed/simple;
	bh=pISEIH1Hgm1ebhPn1Af3Igag6b5WaEXZXIPkb7MG8Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzRTyM6r7abSwapDucdXwrrqHxxesFazl1gFBi+M2vw/6L0tuXiBkvt5xpwomSkm7JufYT2kdZc1VCqbPDcSvBbueOzFWIZMW6robKeKLpUR8J4Sq0StxqISWmqsL9FsFZmCW741MfLhMRYy4ftF0WoxMuLh5VcHkb6Y+BRL8Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHN/72TF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CHKKOd007790
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9hBUx02+DO2rqZGD8AyCtAGPZWGxGGVd2BFh1CEpmGE=; b=XHN/72TFUl760NPH
	l2CtKPY1AiRfQGp83hKOghligpP8eL1YSeDQKuW7mky0WFrHVy2rtOCR21JGvINI
	ddu+dZLlgYwSw2HLw8lTHMD1SKV1fu5piv0bBIl5CsdoUMQkVXR8VBRxBKNRm8Z4
	L1Dd/QiOV2LQU5CuX8B1KLT4yHBZH82yZcvJRBWkH5gRsZScc3xQ95ViS5bYwWSL
	xH5UnkFvrYKUHm0BP+JOGhJnWvMXLrmdzaccG2SSWXLNeEDUPDeso3zownIH08+v
	o2s/yCX40KgCiNM0PA3BuTgQMQ8q+3qeg9fAYP8gH4o8zImIIGMcZ9rxQrDNucU7
	2irhnA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rr1qt63g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:45:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-46e4842dbd0so391621cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:45:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739403911; x=1740008711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9hBUx02+DO2rqZGD8AyCtAGPZWGxGGVd2BFh1CEpmGE=;
        b=lOVk6mjInDlEyGw8K6mLMCAOdgIcuNXbr+Knwf3E2X3Ed44toXtkPSG/40bh4zylZQ
         n/JZKy9UmdqVMlQ+juGxMwM94N52aZM+d1a8wIfm+LE8Itm6Gums0gX+4a2Fz6++8Wws
         B4VtoQNijLQN/v45tSHN/2I0a7x7IlqIbQvvHwJMq77RnAsZmtFi3/LZypJEdytmqq0X
         YSN7eLRoTR719bb3QMA9JFfiHyPNxf/R4OSSuF05mJnHSm/z8V8BKN5XFEbwqwwGzDXU
         26fivpOtePPbbD0tTNF7BvHl+XcaqhpkV9S0y8FkdmrxM1LuZYc42Qgoa855DWE6IEWD
         XCIg==
X-Forwarded-Encrypted: i=1; AJvYcCXWf1798eJfTjkQWhsb9OFsbbZ0pxHg6mhQVZ1vp+ErleCAVBHTBpmSrKQx1SGArsTp11rO/AT0mWl2G4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwweQDJ8cPAeNgMl0i/qsDLC2MxAlTeWqj6eQc5lUAw1Y1cGBqG
	+Jq/UJd/BEL8f2jmnN5jw8+u+ElEGLsh6+2PXHHe8n+U0+7u7BDkS/3IhOhvHGCWLgYW0oZO/+p
	zrK7MpbzywkO3YZ8vw6m5Um+sN1RtHFO1t3LNNgp9iZztTWhuE8jBYfgylc2PqtI=
X-Gm-Gg: ASbGnctLelV+1OckfdPrxmhT4lwfrALEH/te/QFdZWi3ylQJ8APpuTSJK+MJ7D86ZQo
	a5LefeDmkeIOBbxmiDvVsVMFspXPtblFLikUG324141a7XI5b6oWqzicX+w+lQw51do1YCfllCT
	1T7F+diIHkl1xlaCv3fRm4GQhin9adYVE5JFLQdE7ZmkN7CqhCAU6HAYF0UcKVpoETrYmDTxOs5
	Ud+peQ5uzNJJsSU8XRlnmeEq3YVCQl5r2UY1v/izksj5JNYqaBrkLNn/hPkTvDl1OafBdVFSofN
	XEFhSmzlxJSrOuU+uMiYY84uO+GSrgu2QRC3BWUFy7O0J3G6FoXNtbZStqc=
X-Received: by 2002:ac8:7f86:0:b0:471:92fb:7b6f with SMTP id d75a77b69052e-471afe4e2d1mr29685431cf.8.1739403910843;
        Wed, 12 Feb 2025 15:45:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZBbAM9Rfat+qt0Iy9OnSiRwVlgMt4KfOiA9bSD+573lkKNBEBgs8o9+PItWL0wgmfwvh8MA==
X-Received: by 2002:ac8:7f86:0:b0:471:92fb:7b6f with SMTP id d75a77b69052e-471afe4e2d1mr29685241cf.8.1739403910552;
        Wed, 12 Feb 2025 15:45:10 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339d94asm14393566b.143.2025.02.12.15.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 15:45:09 -0800 (PST)
Message-ID: <e2b31450-c428-43c3-b25c-3ec130171011@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 00:45:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: qcom: msm8960: Add BAM
To: Rudraksha Gupta <guptarud@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sam Day <me@samcday.com>
References: <20250209-expressatt-bam-v2-1-e6c01c5d8292@gmail.com>
 <e0ef29dd-afe4-4ad7-95db-d21326744c92@oss.qualcomm.com>
 <CABhZbsXo69FL-xUfg3a20RybO_uRmsOKyMJ2w3qnpk+8pYyUqw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CABhZbsXo69FL-xUfg3a20RybO_uRmsOKyMJ2w3qnpk+8pYyUqw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Jbh0lzRgQHUPI9pUwFCRU-Fsy32Axn4l
X-Proofpoint-ORIG-GUID: Jbh0lzRgQHUPI9pUwFCRU-Fsy32Axn4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=813 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120167

On 12.02.2025 2:59 AM, Rudraksha Gupta wrote:
>>> +             sdcc3bam: dma-controller@12182000 {
>>> +                     compatible = "qcom,bam-v1.3.0";
>>> +                     reg = <0x12182000 0x2000>;
>>
>> The BAM controller is 0x4000-long
> 
> 
> Seems like my device splats with this requested change:
> 
> Diff: https://pastebin.com/AwzHPCLG
> Log: https://pastebin.com/WQswkndX

Did you keep your changes that shortened the sd controllers address space?

Konrad

