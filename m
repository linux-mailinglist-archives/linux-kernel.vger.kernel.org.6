Return-Path: <linux-kernel+bounces-426279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CCA9DF129
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFBBFB21257
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2776F19CC20;
	Sat, 30 Nov 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBjRXOdS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D858A380
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977182; cv=none; b=bh/pkThv4+2kZv9CeJ56nrRR+HNnTYqjNUP8AgEisCPn1PUo9bAjSvSi5QQtzY5TJ2xIkDZja4HU2Wiv5WvSVxI32UnyF8fmXHOtZ1P5+EOVNGhjd7SQ4YOCPNP0pKw6dh0H9y6l40sjAXcXEhHV4DXTdoG353CFA14Z9C+Cs+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977182; c=relaxed/simple;
	bh=6GqbPExjUAJ9VrcQadcPVscC4PCI7xaJb9qtIZSeMb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YvNr7MASkdcjDrIDiaA52Mrv4xJLGnrsJGERsunSqidq1B5JCECHQZUIthm/Og1ScdfCfsqO/boIw8O04xQUoKYBo2Spjy+fiqpaUYAEf80C0rG7gX3mVqLF9vc3rtb/Zx/h/l26tSpRP9WlcN5gw447ZNC3982NRiUY2XB0HrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBjRXOdS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AU2Xl4d012540
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xJbaFLL5aqtaQaD1FY4HVdlrEAnea4exqxdujqkX504=; b=lBjRXOdSs+2T6F2G
	wnQrEQAFaoSRGX8m3D8Wt0aAVh07fW48eXqOEBamGQCaApKG3/Y/a/dxdStVdh5P
	efB6Rb3UZYffCyQ7uBr2fhqU9KFdYIiR8IjbUSsdHbKl9HYS58Vee70WRAz34rlK
	IvQeLULVQqy9UZgKzLflE8VRNHmLTNpXUlx4mnLIp7aIfLyMHG1WamAfa2sRw4Y3
	yzduV2uPXTijO+ZJ5NPg7iMY7XmfNp++NN92WMvfb2ZE31Ei2zm6a4111NNmkitX
	/tJA4ad5W95EMdY+kj3/ktKas4Lsd7q7JexCzxipejbl06zCkk3XBgAgBezujm4e
	gMWruQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437t1g8x3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:32:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b666345ea4so18161285a.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 06:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732977179; x=1733581979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJbaFLL5aqtaQaD1FY4HVdlrEAnea4exqxdujqkX504=;
        b=Mb3+OLCfC1oMn8E6h2cVbYpHslZrH8UmlMkWsG+4Ek5piekiaT/t5RgCvD0cPREd0+
         MOdTLBlO+ber7VOLS3rEkFRR53fwg+AH1rVVtnuCiZyKjASLbwucxSE27yVd/QFam+9n
         8FfpLubW3n8au+1BiGFqy3VLYDKzXFwHjG+5XPABWNqLJd5S5dUJG+A1SyfhHb0jb0R7
         1N7Wv39W6VUxGgZcskUZ+qqPVXsZjyaI10XdnssuYcR2cDaSo8fNPd962cpo8oO36ouS
         ItNs0XxXY6luJb1ENOThMIg2q4BGVE7lb0fCZ9G4eqPKdGUqsCtHiaOxSvuYIgUkWo8U
         P1tA==
X-Forwarded-Encrypted: i=1; AJvYcCVHi12UwX99wO3MRSGeJwKo0lRxAVX2XADjAddfPvyQ09Pd1j3nBYVxr+0NAMzzRooKBDAq8hYRsrAt7PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOri/5bXU7BmWUh++2x7TY7KzZ2Jxb1MDrbWj1N92xVi0I666O
	biQNeoFY2OLeCWlNg7ZRbeK4n+w8GkH4XC/yQBL+4nAFXFJj7vzWnzI56opfCIPEMJlqlSxccin
	2fB32kBJ1RlsECWO1pWObZbW4tn4QkZngezZ6ZUGcc2Iy8wSAzpMXWEZfD9Wm2xw=
X-Gm-Gg: ASbGncscTIwx6KfU4zMmkX0wTgf1696SILoke/nAyUbihqxo8vQlN2g5jSgmlW87vlf
	Z9BsUudDlBlES3vtQ3vru4KyJaL7dFfMHCABslsidrJe7sJj2CuLSUrGaJZTMCvHP8DfGI90gzm
	EqueXESqw4L1Q5BeZO/e/c4GYM8qFFa15AeqcdpuqDEQEHnzqsIdud+/t/iPzdZEAZr6mmEakE9
	vDmTZW0oAil4qhJLgUjmtenYWC3RRt5XgFhFqPZ2CYIw5UPJ2EPBwYkQRhnoUk3m9Hdz9eSrQcY
	5LKn0iBpTHTtpH4hhCiOsBub4CV0jMs=
X-Received: by 2002:a05:620a:394f:b0:7b6:72f6:210e with SMTP id af79cd13be357-7b67c27ccf8mr770039985a.3.1732977178995;
        Sat, 30 Nov 2024 06:32:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe8acvPq7z2y+gB3tEvJPLN5emhbcqDSk4YJJ9ZxSxV5DleRKDJsK1jhG11MFO3oshnAjcjw==
X-Received: by 2002:a05:620a:394f:b0:7b6:72f6:210e with SMTP id af79cd13be357-7b67c27ccf8mr770028785a.3.1732977175132;
        Sat, 30 Nov 2024 06:32:55 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa59990a83dsm284849766b.156.2024.11.30.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 06:32:54 -0800 (PST)
Message-ID: <5c3d91e3-e9d3-4e8d-bd4f-f7cbe765dddc@oss.qualcomm.com>
Date: Sat, 30 Nov 2024 15:32:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sa8775p: Add CPU OPP tables to
 scale DDR/L3
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Brian Masney <bmasney@redhat.com>, Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Shivnandan Kumar <quic_kshivnan@quicinc.com>
References: <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-0-074e0fb80b33@quicinc.com>
 <20241017-sa8775p-cpufreq-l3-ddr-scaling-v1-2-074e0fb80b33@quicinc.com>
 <ZxEwVShJuMH4J1Hp@x1> <9179759d-7af1-409f-8130-1136c9ae4ecd@quicinc.com>
 <daqa3krsp6emdha6h7tlcelsggb6qeilnojgtfxjbp5zw4n6ow@xzwdmu55ygjf>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <daqa3krsp6emdha6h7tlcelsggb6qeilnojgtfxjbp5zw4n6ow@xzwdmu55ygjf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: e2edi7QCl6NiyOgk2_3OIQ5AjaFKjzSF
X-Proofpoint-ORIG-GUID: e2edi7QCl6NiyOgk2_3OIQ5AjaFKjzSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411300120

On 14.11.2024 11:48 PM, Dmitry Baryshkov wrote:
> On Mon, Nov 11, 2024 at 06:39:48PM +0530, Jagadeesh Kona wrote:
>>
>>
>> On 10/17/2024 9:12 PM, Brian Masney wrote:
>>> On Thu, Oct 17, 2024 at 02:58:31PM +0530, Jagadeesh Kona wrote:
>>>> +	cpu0_opp_table: opp-table-cpu0 {
>>>> +		compatible = "operating-points-v2";
>>>> +		opp-shared;
>>>> +
>>>> +		cpu0_opp_1267mhz: opp-1267200000 {
>>>> +			opp-hz = /bits/ 64 <1267200000>;
>>>> +			opp-peak-kBps = <6220800 29491200>;
>>>> +		};
>>>> +
>>>> +		cpu0_opp_1363mhz: opp-1363200000 {
>>>> +			opp-hz = /bits/ 64 <1363200000>;
>>>> +			opp-peak-kBps = <6220800 29491200>;
>>>> +		};
>>>
>>> [snip]
>>>
>>>> +	cpu4_opp_table: opp-table-cpu4 {
>>>> +		compatible = "operating-points-v2";
>>>> +		opp-shared;
>>>> +
>>>> +		cpu4_opp_1267mhz: opp-1267200000 {
>>>> +			opp-hz = /bits/ 64 <1267200000>;
>>>> +			opp-peak-kBps = <6220800 29491200>;
>>>> +		};
>>>> +
>>>> +		cpu4_opp_1363mhz: opp-1363200000 {
>>>> +			opp-hz = /bits/ 64 <1363200000>;
>>>> +			opp-peak-kBps = <6220800 29491200>;
>>>> +		};
>>>
>>> There's no functional differences in the cpu0 and cpu4 opp tables. Can
>>> a single table be used?
>>>
>>> This aligns with my recollection that this particular SoC only has the
>>> gold cores.
>>>
>>> Brian
>>>
>>
>> Thanks Brian for your review. Sorry for the delayed response.
>>
>> We require separate OPP tables for CPU0 and CPU4 to allow independent
>> scaling of DDR and L3 frequencies for each CPU domain, with the final
>> DDR and L3 frequencies being an aggregate of both.
>>
>> If we use a single OPP table for both CPU domains, then _allocate_opp_table() [1]
>> won't be invoked for CPU4. As a result both CPU devices will end up in sharing
>> the same ICC path handle, which could lead to one CPU device overwriting the bandwidth
>> votes of other.

Oh that's a fun find.. clocks get the same treatment.. very bad,
but may explain some schroedingerbugs.

Taking a peek at some code paths, wouldn't dropping opp-shared
solve our issues? dev_pm_opp_set_sharing_cpus() overrides it

Konrad

