Return-Path: <linux-kernel+bounces-382257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1079B0B91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A0B1F27E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EAF20BB38;
	Fri, 25 Oct 2024 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pL14LhjP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72920BB3A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876826; cv=none; b=GO2O9/P3Y79/4TvZmRAIzUw4LjhwR0+mzATZKxNTXI5QFTpiGK1SSnZuXtvo54yD0sM82xI3Ci5ULC4oM1rwTiUxXi2KXmDwUJUjNOIlJNR+R0KxUgZN7J/RxOqK5j6F2/KYXvzS8bVMowRProsxPDSrcwYYYdUFi2UJhMQLyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876826; c=relaxed/simple;
	bh=JZLdGnvbLARIGe5ZTVOuslFOTi2s6s++7iwLcBEBFCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sl23QK2wdL62YMHBl9J2WqnllzZgZWcEt60UhKFeHusNF2VlgQg36TOYz7z6xJmj3NoklNQes+BSm/Vrf+CfVZGEyIJVr464GgFEUSQny5GhkytyjAj7OpuK8nx8voJO277+Lwh3oIpDOIr+jjsI5+WyKfy2QpOVfxHfYE/Ve2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pL14LhjP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PB3dVB019387
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ioJoqSdO3mYmi5MI3yxlXmhEsUY+jkvC0eBwhFf0TrU=; b=pL14LhjPj4eN6+Qj
	+r9vc02RTNoQC30/mBHJnrfr4gbiLNJJGPZY+NPeB2xhvZFI4pPjdH4oAKoqbuqF
	UG+bH/ZUudsrDc/y35DHBlvlaLFcfFKxesYJLNa5qq6l/9dXqeMqCM6CqTcmm9bI
	Ut4gFlFZ+5KmDxdeWCCl+Wgaas8Mh8+LaEqVlwoXUTKQhIpl0HiSpyEZjqgwH07O
	d32TUAWd2NG6TMH8UeovB1hzoXsUq88M0yc1pVEz3metR67BJR94AMjzItfy33Wx
	u6V7UxfUXWt6a3lUDmI8Z2Zj5JrmA2XAPspqvkTisUAzB6tC6KnpL1U7Ex1cX7Um
	82A6kg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3wj083-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:20:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbe6e6bcf2so6536856d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876822; x=1730481622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioJoqSdO3mYmi5MI3yxlXmhEsUY+jkvC0eBwhFf0TrU=;
        b=u3vlYdRu1C7k65zDs91kX4qIuvYgo5gI3u2yfx76YGUgoXyaECf1yNNsSmFti0yI66
         STuIwN9ILFhaprN3WjmNBGk6wPIYtyWMIymlCfJI7H20InGhWTpor9L7hfzPITmUFbUI
         sZ3PkkKB6X8Kgo1Fn7daqggsL1z0SBv1ZWuL3Ynbw0Jr6RbmNd3B47cXEpynn8WWxa/n
         ZRoJ2NWV+IfjUdE9k0ETmaj33D1YWH07DC6X5H17lfsr7zPbCYlu2VoVLuIICZsztQj7
         X/hgfESBUNvQlzatEWrc+y6FsvP1CBVWytHU4XG4qk5EHu+ZcCGJVUQLp0FX2CfmQw6P
         51BA==
X-Forwarded-Encrypted: i=1; AJvYcCX7tc4yD2jX+5vX7ZWajDDqTODcAwBO1KljZYBNc06PCYTYXgPWllLeXApV41eQcbLJh33mrCDPg5B6Oeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5BNWGTI5A4mWuGQLBGC/I7V5wJDfHTF6b8SrShr6V2ulm7cs1
	KOfRLTH4OxEdPLWEMF93r1YR7G1Y4EEG1XrJWBnUO+27fYjlCjMGCx02wDyHNW11xo1xRraz3G2
	DxN/tqTgW4mQBioUeLs0x5+dQiKN/qdn7z1b0jYPPfD5dUdSaXie6/T+XCJ5HvEs=
X-Received: by 2002:a0c:fc48:0:b0:6cc:2295:8724 with SMTP id 6a1803df08f44-6d185682eafmr1256676d6.5.1729876822069;
        Fri, 25 Oct 2024 10:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVRtOxwLAfBjXD25YCeJd2XrgSjviqO4RyNQJHomWQ/y7f5nG0bpuWE3oRUPkM3IbuyZoGog==
X-Received: by 2002:a0c:fc48:0:b0:6cc:2295:8724 with SMTP id 6a1803df08f44-6d185682eafmr1256506d6.5.1729876821721;
        Fri, 25 Oct 2024 10:20:21 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c4547sm813471a12.53.2024.10.25.10.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:20:20 -0700 (PDT)
Message-ID: <955e6f06-ab4c-49d9-bfe6-d96d2a81f656@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 19:20:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Keith Busch <kbusch@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
 <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>
 <ZxvOEOXzLIsbEbve@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ZxvOEOXzLIsbEbve@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: RnMzjntuyChF2DTfw4Db6mBmpnFATgG_
X-Proofpoint-ORIG-GUID: RnMzjntuyChF2DTfw4Db6mBmpnFATgG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250133

On 25.10.2024 6:57 PM, Keith Busch wrote:
> On Fri, Oct 25, 2024 at 06:40:23PM +0200, Konrad Dybcio wrote:
>> On 25.10.2024 6:12 PM, Keith Busch wrote:
>>> On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
>>>> before the platform can reach S3-like sleep states. This is very much
>>>> similar in nature to the issue described in [1].
>>>
>>> The "SIMPLE" quirk is only supposed to affect kernel managed runtime
>>> suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
>>> suspend?
>>
>> So on these platforms, all system sleep states (incl. S3) are entered
>> through what Linux sees as s2idle, with a separate MCU doing a lot
>> behind the scenes. s2idle of course also covers the runtime cpuidle
>> cases.
>>
>> All but the deepest state (which Linux doesn't differentiate as of
>> today) are effectively somewhat like s0ix.
>> It's a bit hard to draw accurate lines between Intel terminology and
>> what we have here, as there's way more things onboard than just the CPU
>> cluster that may be operating independently..
> 
> Gotcha.
> 
> Is there any sleep state on this where using the nvme managed power is
> advantageous, or is the simple suspend preferred in every scenario for
> this platform?

On the special snowflake SC8280XP, simple suspend is the only choice
that makes sense here. Otherwise, you'd need to keep the entire SoC
powered, which (even if most of it would be driver-suspended) ruins
battery life.

On other platforms (where we'll be able to sustain the PCIe link,
eventually), I can see both options being useful for different use
cases. But again, that's only for when we can actually get that working
on mainline.

Konrad

