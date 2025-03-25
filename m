Return-Path: <linux-kernel+bounces-575546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCFA703ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E1C1891187
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE9825B667;
	Tue, 25 Mar 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXVWegIH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459E25A355
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913561; cv=none; b=RLetN8g56hQm7jfx1+IzLIMn45umyREZbniutnKJI/TK5H0Y51j/WuKx2TCJIn3uuf/0WXkeezPakxZUM8LM2v+eSGSlPYVU2wmT7jFdqw8C2JuoG+QZ/g/6bDJ6AdrIk2nk9akguBD/bd06L3EqNmFZNwyIa+Ltqmmb+wwGvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913561; c=relaxed/simple;
	bh=BF/9SLoL0/eahxTrlHrP7+kk6jiwP3IV1YiE0RpH0aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBSDqgwqJKsc+dXIOFhHyWqRR2rw5EhU1OmoJoOMB+p5wrsX2xZcX4h6cBHd9uXGSm8xHJRiUY1XcwXA08+CTRVp6XKy2zx9IVtxqPujMZM1g+GC8U7kCeELSEwQsdzZb0oNlTsn84BsoE/ulWp5sD+J7aUKdYGStpnMtA6O3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXVWegIH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PE028G000588
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2AR9DLJxuAX5J+vUj9fnqNV1djjf7QFzxQNMwmMHS4A=; b=oXVWegIHey1D7hgo
	mRkBBDvrEh3YomsjH1AECYJXa3PCMVCFzndXKb1l2dzhimMHtvRcxtM8lIFdL4Mt
	g1cUvzhOZj4137q2hxw7GCPS0TgV7uzVS0UgOTT46SKIcJTYuZEsLoeUyi5GvM/h
	j8cEit6MisUlo3SNqKHqLYp5ZQIqMgxvENZhEMN0BUJ7VeM2VCsTmWN8QTzNL6f3
	payQVb0iXgpdb4FL8UyODIMlWBHBWHj2T9z2inD1BR+6IfL8aYQLfdev5ArrKEd6
	RFMN63VayVKplC8gdDqA8ckGC3pH1fFbW3iCZXtBc7RoO9UwBWPMOb/gABePN+bh
	G/Cjrg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45hm79r7tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:39:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4766654b0c3so14313661cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913556; x=1743518356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AR9DLJxuAX5J+vUj9fnqNV1djjf7QFzxQNMwmMHS4A=;
        b=FEkHeWn5TVFkz+pyYcz6rRNqKMiwUkoXhAUd+ri5d7B6Wsy8TVvDYM/fv40n9fc9cT
         CIM0MZlHw+a+9ajxiNyfPr1qSmcQfTLyvW4l9tx7Re6UXelq0NSh9Pe011rmHBQ8Yvge
         SLO2xhMxKpQugM6Bw8xFy1+AeTEdYXxj3WTh9V6OtjLf5WVN53NOI9jiXtHYoXWm0X+E
         uPxQhJS+VnYArW0awoXh1P73+MJZy0d9HgGIlId5GaMsp4Y18qx6mpnf5FMLkAZohzi6
         1eDSym7EOQ/MWL37IGprFqS81F8Rngn5513I/i791v4aUOfI12wpBe5pTrE9YQBZ8IGj
         yozQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMBX+SSHRaXLrJIlI6b2sbwasf/8G4604C3AIBzTsNkFqg8sMS0TtZVPsEs6Z8SRD2QPjYERa4aqv9oRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3bjv5HvlrqXbMXz6usZknUW8ANCQOfSWPPYaEGYBVCxx6/zc
	BvcqmZ5nY2HZlZmTpflgnC4XZ7UiJCUY93S483wOMHfi2eJNYZL8EnFlmpYsKZV4bl/T7BDX3Ns
	wUB2lOl9sT+tnoNQKEXNSHKumUV/zDmZzCNKzVgg0vFk4S5hVifq4y2SLomCIQZvOeVhU5SY=
X-Gm-Gg: ASbGncsjdXmDFG3c21GGrWJp8HReOHWosveg83chTb8gv/2msHiwE6+xpXk9P4h91Sr
	5YSlXQQiN+6uugFCqVuQaKvFiGObtHapbUmQfDVQXIK9G9B6iIfXdRoUliBaLt1YIPiuM1HmYT1
	cZh7BaGckcXHmXjBBIzxb1If5phZ+2su3Ws4Iyw0xy8vCfYeNFYiTfcMVzNOOL/z4B5rKZQ+Fp1
	ah4HOKK/rCZk8+pFMgrrawRWFoqGSwo916OOkVzrNI8XwpkH0zz59yle1umjPZMDoijrYg6+CMv
	RJzYoULnajQ/NKwfJoowjVp3ixS2CIcS5cljjgzsm4HaTmwhL34afB6yGB6SFPoMAnsY/A==
X-Received: by 2002:a05:622a:1a97:b0:476:af54:503f with SMTP id d75a77b69052e-4771dd6226bmr92953531cf.2.1742913556343;
        Tue, 25 Mar 2025 07:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR7ZJxcn2AD4UVzPlapOFAWeZjSCT60qNnDD/c5K+/WhuOlamYQaCR57BDtBgMf8xGuiCSWQ==
X-Received: by 2002:a05:622a:1a97:b0:476:af54:503f with SMTP id d75a77b69052e-4771dd6226bmr92953231cf.2.1742913555748;
        Tue, 25 Mar 2025 07:39:15 -0700 (PDT)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c7759sm7850418a12.51.2025.03.25.07.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 07:39:15 -0700 (PDT)
Message-ID: <0f700f59-3cbd-424a-84a0-0d23db0ca581@oss.qualcomm.com>
Date: Tue, 25 Mar 2025 15:39:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e001de-devkit: Add Wi-Fi and
 Bluetooth pwrseq
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250324-x1e001de-devkit-dts-pwrseq-v1-1-530f69b39a16@linaro.org>
 <Z-KuG0aOwEnxuhp9@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z-KuG0aOwEnxuhp9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KEXrF77AnCq-tFWvnNFZMiI41HdG3Fik
X-Proofpoint-ORIG-GUID: KEXrF77AnCq-tFWvnNFZMiI41HdG3Fik
X-Authority-Analysis: v=2.4 cv=IKYCChvG c=1 sm=1 tr=0 ts=67e2c015 cx=c_pps a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=RC_zNtMqMYb_0QXlmi0A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503250103

On 3/25/25 2:22 PM, Stephan Gerhold wrote:
> On Mon, Mar 24, 2025 at 04:24:01PM +0200, Abel Vesa wrote:
>> The Qualcomm X Elite Devkit comes with a WCN7850 combo chip which provides
>> Wi-fi and Bluetooth, similar to the CRD and QCP.
>>
>> Describe the nodes for the Wi-Fi, Bluetooth, the related regulators and
>> the PMU.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 144 +++++++++++++++++++++++++++
>>  1 file changed, 144 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> index 74911861a3bf2606add8cf4aaa3816542e837513..8f288a138c4cb6e21725fdf726eb2a2489bfbc38 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> +++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
>> @@ -17,6 +17,7 @@ / {
>>  
>>  	aliases {
>>  		serial0 = &uart21;
>> +		serial1 = &uart14;
>>  	};
>>  
>>  	wcd938x: audio-codec {
>> @@ -392,6 +393,42 @@ vph_pwr: regulator-vph-pwr {
>>  		regulator-boot-on;
>>  	};
>>  
>> +	vreg_wcn_0p95: regulator-wcn-0p95 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_0P95";
>> +		regulator-min-microvolt = <950000>;
>> +		regulator-max-microvolt = <950000>;
>> +
>> +		vin-supply = <&vreg_wcn_3p3>;
>> +	};
>> +
>> +	vreg_wcn_1p9: regulator-wcn-1p9 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_1P9";
>> +		regulator-min-microvolt = <1900000>;
>> +		regulator-max-microvolt = <1900000>;
>> +
>> +		vin-supply = <&vreg_wcn_3p3>;
>> +	};
> 
> Hm, on CRD and T14s there is a TODO comment above these two, which is
> also why I haven't posted these upstream yet:
> 
> We still haven't come to a conclusion unfortunately how to model the M.2
> WiFi/BT cards. QCP doesn't have M.2, which is why it is upstream
> already. These two regulators don't actually exist on the devkit itself,
> they are (probably) part of the M.2 card.
> 
> The devkit only provides the 3.3V and 1.8V supply to the M.2 card.
> 
> We should really find some way forward for this, but just omitting any
> mention of this is not the best way. :-)

Now that we have a PCI port pwrseq driver, perhaps that could work..

Konrad

