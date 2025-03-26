Return-Path: <linux-kernel+bounces-577060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD7FA717D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC5816D33A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF80D1F03E6;
	Wed, 26 Mar 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2G1EAew"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB11E1DE0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997222; cv=none; b=drwtjBUjA1533lNAb6Dg7WCtnvUbnS0i4VKsF3rMYkj1b75WJRVrigOh84AK8OKleGYtgEqPAhGhhqMu2OHSnuoViVKE4Fo3FdYALgriq0pnzdCE+Ww8YXTkXuDd8eQaoYj3F9+E7v5CFQo6Y9OGNHhtYcwdLNShDVqD2tXaRNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997222; c=relaxed/simple;
	bh=9L4xyxr7xMH9Dp2nmEgv5JEeMQO/tlZYPdy5nK9XB7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctA6/e03NE6FMeZQPhrGUHXLYHENPQgNKarIYvTOX8FwVy8ZmxC8l3l8TnxntWUyOoo+HnwEfrCK9JWiQEVp4EfhfymAt2I9lvK3peX5xoUID8MZKdYxzHaSnwNrqJQXhqsoX+UDTICRfh+//FEYE/DU969b/LlUEJDab/ZGfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2G1EAew; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q73AgY024585
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7BA33c04zG/s0Ltuw12G0cx/mbnPEXUJh7lFeBxmokg=; b=F2G1EAewDGFCeXUe
	zYCYQ4MFvBNdSbLz1+sxBAGV1Fvb2D74YEjtBVRXVpwdp6tyIRuQnKsH6TYxzohh
	7TXFcPtpeO6L6mYN4m0w2u02BTvLU8ItT5nMlPL2JSdKkRkZHaIP/TTCn1afVpxF
	avNnVqgowFb+IXIag40RSd8wdJScS0y8OL6bYfG224bGRqICLwQhHsuWGthOu/Ev
	dSWFmo+a6Wj1r1O8sDdGsRIaQOqug6H7a88MuBWjOwKnQJ5462hsaMFpsacHjWs/
	6NQHt9LW0vCgMYQUdeigzDw6gBEkFLPfihAqa2PGV9iUrS0Qyt5TqCWUPuuR7Ati
	BnmhvQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmd353v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:53:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5af539464so225566685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997218; x=1743602018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BA33c04zG/s0Ltuw12G0cx/mbnPEXUJh7lFeBxmokg=;
        b=ZDlfpHFjnwiGGHImXR1ifflLqiQjWNIYYfa3VqqNukL9SoUGpEOA8XkYd9x2VITdEJ
         dHxsLkyTYeoGHjGjhp1jlWhGjIjCirEoqkTURApHX/Mn1yMoAu4Vjq+rMtOoTb1Vor2U
         t1UdGVOd17xs8egrx+lQDb7vsOGo2fmo5kMANCx5ifqzD5rPaGjqkmdJgH+fDdbWBV3Q
         QtXID36VVI5yC7kKwx3laqq+E3KIlkrKRR6YEu+AJVKKgajn/ttOAd3YAvKFpnsbMGOD
         AXqpjgUNeai8Lwh138wpA7opFy49LIB3aTHtndz6qIeUp3ng9G6yvuL+Phlpv/SWDKHF
         jsNw==
X-Forwarded-Encrypted: i=1; AJvYcCWWAS2CzJDVF/9biTHXetbuiNgulKB4lM7pAXmLQfjp59iXGTlch4tHYLfw6puIuqXqMIviKIyG2VyfSBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vQXXC5fcG11yGR0dwJgbQnkrCBVYChN+oVRLRn6sqT6y+CxU
	bKvlDhfjyDeVYLhhF9cIKOGCOA2MuzGd82bty3tur7Yz5VjznJiCqV2Ob1wnlOZegZOSM/4TJs8
	jOHcYQjy1CNuzf5YEFITE1vxO9ZU6E+sH4uV6ea/bgp15P89vIXaSrWuNL6+rrew=
X-Gm-Gg: ASbGncsl7dMk23EP/1u8Mxnw58O0IJhtV+YE2K/OKgRT1YoGZWnpf+k1g3hzRRRQmc5
	qAlNWs121l7eJFM93miZ6iTECZTbhV5fvzUjroELsURZlSX/5XU1T5Rt85p4XBcJj/1xRzGn2f0
	DDy3v885p+//u1a+/xEa+UQyLVCDsdQxLVlAMg5Rm6FQCMxWSMu/J+77XF/ER5Shu9gykWpwsoL
	D6PQEQy/26EhcLOsDH9jvAWvjYD7GkBA07bJjT0LRYWO1ZHab69+TMemCqgSJoYnpf+j7+vsmD+
	pAHiFIfnIYvoXGLeBigpWkjOwlMpi9XtTZZj9mR+2MbKxBCkOqak/XTTQPTFmWCQXhY5BA==
X-Received: by 2002:ac8:5894:0:b0:474:bc4a:edc8 with SMTP id d75a77b69052e-4775121d71dmr35379731cf.0.1742997218280;
        Wed, 26 Mar 2025 06:53:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHebjyONIhZv+DeY46JivB3zqnPTztA+Se1h9eQ9cmVWaA0E0xMl/fWl7R8P3vHJk6AzYv29A==
X-Received: by 2002:ac8:5894:0:b0:474:bc4a:edc8 with SMTP id d75a77b69052e-4775121d71dmr35379341cf.0.1742997217624;
        Wed, 26 Mar 2025 06:53:37 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c6f47sm9303266a12.52.2025.03.26.06.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 06:53:36 -0700 (PDT)
Message-ID: <5895ecc9-68c0-4ea2-b351-c48ed7a593a9@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 14:53:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] phy: qcom: Add M31 based eUSB2 PHY driver
To: Wesley Cheng <quic_wcheng@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250304-sm8750_usb_master-v2-0-a698a2e68e06@quicinc.com>
 <20250304-sm8750_usb_master-v2-6-a698a2e68e06@quicinc.com>
 <69fa7f33-e957-4dac-93dc-6fd40167873c@oss.qualcomm.com>
 <1956a94e-b231-4458-a1c1-6d9f158da669@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <1956a94e-b231-4458-a1c1-6d9f158da669@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: mSCx1ue6DYEYXP6LKOEzMb4ZSH5kWlF3
X-Proofpoint-ORIG-GUID: mSCx1ue6DYEYXP6LKOEzMb4ZSH5kWlF3
X-Authority-Analysis: v=2.4 cv=P646hjAu c=1 sm=1 tr=0 ts=67e406e3 cx=c_pps a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=O-TZl5gO0o4KVnlI8YMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260084

On 3/19/25 8:03 PM, Wesley Cheng wrote:
> Hi Konrad,
> 
> On 3/11/2025 4:19 AM, Konrad Dybcio wrote:
>> On 3/4/25 10:56 PM, Melody Olvera wrote:
>>> From: Wesley Cheng <quic_wcheng@quicinc.com>
>>>
>>> SM8750 utilizes an eUSB2 PHY from M31.  Add the initialization
>>> sequences to bring it out of reset and into an operational state.  This
>>> differs to the M31 USB driver, in that the M31 eUSB2 driver will
>>> require a connection to an eUSB2 repeater.  This PHY driver will handle
>>> the initialization of the associated eUSB2 repeater when required.
>>>
>>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>
>> [...]
>>
>>> +static int msm_m31_eusb2_write_readback(void __iomem *base, u32 offset,
>>> +					const u32 mask, u32 val)
>>> +{
>>> +	u32 write_val;
>>> +	u32 tmp;
>>> +
>>> +	tmp = readl_relaxed(base + offset);
>>> +	tmp &= ~mask;
>>> +	write_val = tmp | val;
>>> +
>>> +	writel_relaxed(write_val, base + offset);
>>> +
>>> +	tmp = readl_relaxed(base + offset);
>>> +	tmp &= mask;
>>> +
>>> +	if (tmp != val) {
>>> +		pr_err("write: %x to offset: %x FAILED\n", val, offset);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return 0;
>>
>> Is there a reason we need to read back every write?
>>
>> Does this have to do with some funny write buffering?
>>
> 
> Probably because its just a form of write synchronization, since we're
> using the relaxed variants.  If desired I can switch to just using writel
> and remove the readback.

non-relaxed variants are defined something like:


writel(foo) {
	writel_relaxed(foo);
	wmb();
}

with readbacks enforcing much stronger ordering (via a data/address
dependency) than a barrier, i.e. if you write to an address and read back the
register, the write must have arrived at the destination hardware (which is
not a given otherwise, see:

2f8cf2c3f3e3 ("clk: qcom: reset: Ensure write completion on reset de/assertion")

Konrad

