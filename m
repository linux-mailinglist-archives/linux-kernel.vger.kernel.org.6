Return-Path: <linux-kernel+bounces-562598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D66A62DD7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 15:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F01F189DC26
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 14:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5FE202C55;
	Sat, 15 Mar 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hgx++xQL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E9F1F8BA6
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047504; cv=none; b=nGRbtOxMmcvCtCI85gQdCi5etlZlzSq2TSNmMxnXCz6rEdQA+Ac+VPsVO0wpQPKynzXGavOlrmxwT74bP2gLQfbJYE37cER2FS5mLhypGvtSHiG4USK9l+TkTn7rgYHhhQeJ/10WC324p3Z9dZAJHxKjwZG4/C6y1HhNBxsoawk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047504; c=relaxed/simple;
	bh=YfnsnyLlpurE1a++zCcgvEc6AWvYcBKTlVAoyEBchJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hoH+e47hPuNtjtZRgT3tL0PQnfPngmgWja0I68AmtgJFzzafdmB4u8+hNUH3JOCckQzTSZs0wCUdNaoScPm6zLhVMJ36BzuTU6e+ca7eVh+SB0waM1CNqKVBBeMxRAUmCcYMacp3Dx9QA1C0yVxqGCSQQ4bzHQHMe8z1Ttenlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hgx++xQL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52FDneOj013909
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 14:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UUAncCVozCVnivHbsq+9DBQDI1K0/A8x8y1E+4sWtHU=; b=Hgx++xQL8Di2wary
	8uMa2bK6aDp58xjjYHyFnzRsi08SDWn1E26qtnnzdRcrHyzBmPU/NAK2hmgeW2JD
	6vWmu3oKSQEEH1YJlwWA7Ja0pwHk1laVYs/3SK9LCOA3ziEVSPZWVX1EEMBe/vY7
	AJDtnCKYIYojLs3w5Pf9Dw86MJ91/kWHaK/yqXGTfIIlWf0RfYC0SAjIu37xlNhZ
	psR7FartVqZtzV0pxQ8qlyJMVKlEpYeGUtE1g2LkLUE3setUYv9tfDTUqqkI7Xnf
	F9WJy9lHT30QKX+QssXQL+2G6mv2bS/kMSpRoOCM9LHBWyi2EJSOwIvwkdTCp55f
	5zVBfQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1r10s2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 14:05:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c53d5f85c9so37285685a.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 07:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742047501; x=1742652301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUAncCVozCVnivHbsq+9DBQDI1K0/A8x8y1E+4sWtHU=;
        b=HvmVM/kMlECT6/y5VhwwDnW4SFVb4kWq+vvX/UXGwHS4GdsrwxjFAWmK5/eXs/CKHr
         FtmbgZ9Nr9J+MIUaxjB6yLUpTwTa4GlIkzg0jQFistzma6b1Cz4bFbXm+P6PjMGyT7ZZ
         5YphKgUGX0BDna+g00dkfbxHzOJ0xxS2rBbMmaL1GG1GAFUesU6kLZpmPcFJLnEXwiB/
         CKvqiUyHac5rADWxJdSjB1C2sGEjFrm+9yP+J34efcuTu3HnYzmKPq9OUmnxnNa9PrR3
         GlEqGKnKezWRScUwXbw3x+bPIR3TEEuuysBV6TpzOgS7ki0iDG96yj6QSqGt3w/1QF4W
         19bg==
X-Forwarded-Encrypted: i=1; AJvYcCUqjqPV1V7gbKKsmLrC3M+mOuobu9CiiH9gDU12PwzSrhuOzNJXNBSEyMCV/Mu0MNpOGVWFgpH06ZQhOxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL49UEorAEexK9uOGuDzGZtZEN9vskyNlH5mvoAPNHw0DkcrTX
	LHS/xRLRgy4Q34mIqAypYTNlucef8gW6N0OxMFw02heHyhAUlM8PZUJd7bmfIgziGJFXoXrgBjA
	LIJ9aEvwdEmpSgzD7uxdajHpD4MRYlEQd/IgYFGvRc4mut8gU6XUmzbSHdOqVejM=
X-Gm-Gg: ASbGncvccifRcYBe/cMNvK7yx/zL60AVP5GtF2cHGcyKpBdx5MRLO5/CALDADFqP3K0
	frMpAWRkL1dHgi96YszD8dRvTM+TjjXNL4i8h5tHKbubv+ZmlWwEJdCpl1DEgGStp0DJ9t4NwD5
	7+wAo7iVqBKiVkGeQRTEBRjyCLp74Cu6cF3q7ZXALvq9WcqFJW5xSjkm5y4mRDLU9FeI9mytvq6
	2816jS7ssHiNm97MKzWBlQ1ztxBdzh7RTPEKLhYk2isbPyA8nkGZ5JFo6xfTFtY6tNElN2Bl8Lt
	zBl8LALjA0jV5H8WWADd09PW7ZdYlcyDQCZy2eAAOF240iB2x8rfjTVRGX8zW8vKbMKHOA==
X-Received: by 2002:a05:620a:2416:b0:7c0:c024:d5 with SMTP id af79cd13be357-7c57c80ef86mr336345485a.8.1742047501241;
        Sat, 15 Mar 2025 07:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTRd1Ia2aDyV8PsrPTlCP6muG2Qdkuvkpuw2KdrP05cGmco0YbeElKaqwrAOB48+digijbtA==
X-Received: by 2002:a05:620a:2416:b0:7c0:c024:d5 with SMTP id af79cd13be357-7c57c80ef86mr336343185a.8.1742047500879;
        Sat, 15 Mar 2025 07:05:00 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea756sm9418031fa.35.2025.03.15.07.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Mar 2025 07:05:00 -0700 (PDT)
Message-ID: <6a652ced-1226-4ff3-8b26-9fb78b075ce2@oss.qualcomm.com>
Date: Sat, 15 Mar 2025 15:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8775p: add support for video node
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250311-dtbinding-v1-0-5c807d33f7ae@quicinc.com>
 <20250311-dtbinding-v1-3-5c807d33f7ae@quicinc.com>
 <3ec71075-b1ef-4366-b595-80fe41cd1e13@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3ec71075-b1ef-4366-b595-80fe41cd1e13@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=67d5890e cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=L28Ds1LcoDUPICagkq0A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: x9uJj4UfK9lQ11AwzM9YRHY-bTgoJ-hL
X-Proofpoint-ORIG-GUID: x9uJj4UfK9lQ11AwzM9YRHY-bTgoJ-hL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_05,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503150100

On 3/15/25 2:43 PM, Konrad Dybcio wrote:
> On 3/11/25 1:03 PM, Vikash Garodia wrote:
>> Video node enables video on Qualcomm SA8775P platform.
>>
>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 67 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 67 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> index 3394ae2d13003417a15e64c9e47833725ec779e6..09db8e2eb578f1cada0f4a15e3f844dc097bd46d 100644
>> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/clock/qcom,sa8775p-dispcc.h>
>>  #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
>>  #include <dt-bindings/clock/qcom,sa8775p-gpucc.h>
>> +#include <dt-bindings/clock/qcom,sa8775p-videocc.h>
>>  #include <dt-bindings/dma/qcom-gpi.h>
>>  #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>> @@ -3783,6 +3784,72 @@ llcc: system-cache-controller@9200000 {
>>  			interrupts = <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
>>  		};
>>  
>> +		iris: video-codec@aa00000 {
>> +			compatible = "qcom,sa8775p-iris";
>> +
>> +			reg = <0 0x0aa00000 0 0xf0000>;
>> +			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +			power-domains = <&videocc VIDEO_CC_MVS0C_GDSC>,
>> +					<&videocc VIDEO_CC_MVS0_GDSC>,
>> +					<&rpmhpd SA8775P_MXC>,
>> +					<&rpmhpd SA8775P_MMCX>;
>> +			power-domain-names = "venus",
>> +					     "vcodec0",
>> +					     "mx",
>> +					     "mmcx";
>> +			operating-points-v2 = <&iris_opp_table>;
>> +
>> +			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0C_CLK>,
>> +				 <&videocc VIDEO_CC_MVS0_CLK>;
>> +			clock-names = "iface",
>> +				      "core",
>> +				      "vcodec0_core";
>> +
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>> +					&config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ALWAYS>,
> 
> This path should use QCOM_ICC_TAG_ACTIVE_ONLY on both endpoints

Please also align the &s

Konrad

