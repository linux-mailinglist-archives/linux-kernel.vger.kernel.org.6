Return-Path: <linux-kernel+bounces-513034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289FAA340D5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4E9188C693
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78D21487FA;
	Thu, 13 Feb 2025 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pKAsxd8P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09DC24BC1C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454827; cv=none; b=qWastL4+pUYDXfYJii/h/EIXJB6JxtsuiRM08FOXcvTpYrFW5uIuVftSTD+pQqExh204IRd8+GTGOtPyoMq21evLbTqRtgoTr71d5dtixLqEBIpIBSXq//LBuzJ7AG+l+zd6QVvVoez1xCPtnC2lhHh1eA8ipuFDrKWLGQ0v8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454827; c=relaxed/simple;
	bh=Eng2iBq6FvHc1yUhKMcUzLBmdUfoaMTs+ae3WTkaieQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgY+/iW5a8YEVOiHl3IWZk/cHzBzD2gqMzkAqQB7d847g07fQdi/Em4I+L4F5aZq0/stTxcqwjkZAysNTvOPzAKVxbqdkzoLwj3Q+dm3Mmh5K2JNYvqroLVtJMCKOam91oUSyOMINMNA2L8ThW2EO3qCGPS5ZAPkrSnr9o1my1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pKAsxd8P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DA2TiE002672
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G0T3NNL6yPWHi23ATwtvU4h45jKTgjlGN7+OXPZamIA=; b=pKAsxd8P6eu1LG+h
	Ee1B1nOcWiiCOrTWOoEC6MvIYUU6UQrjwwf/07tKOjsk3c5aznQHbzs5dL9Duay8
	p//qzUEJ5NZ4VEisarBD7W2XdavU+aI1hywDGOohTFI6EjWAoMygQKy8b/IFENEV
	hpQgRC3INzKlYKf6Z0ocWLKk8ALxIr9gAbjD7VYnKC9cnI979ujYpv3vPufv4fTI
	CX8BQlp6B2qd05lFl3f3KkOJHpGWgoiarHYf+VimNP0L5SRqqCUninZlDeL56lUB
	xqz2bIBwYv/z4rAm/KbvhfQ5LvbsFxp133TPuQNz21evan8qcJEBFnM8MsQW3LuP
	Hgk1vQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44semp8k7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:53:44 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c07ebd8de4so5473985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454823; x=1740059623;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0T3NNL6yPWHi23ATwtvU4h45jKTgjlGN7+OXPZamIA=;
        b=ZHjKv3UDZ8qTHkHbdrIDD1SjY9qk/nDPPIBKzkhXTn1TPFIWr7itg7dXg4kSIwFsGv
         PKpAg28ptLcVzCglVao43hvjlfFyGi7AAuFsK/8V3ZZFrlflNPw/H9xiw80uhQqm33Xg
         svNh+nu52APpl7n/OW0yMf1Ws7Sa+aY22/32A4VeNZoWZM81hb8voC4Zt5sIzVVaCHO0
         qm7OeXplaMcu9at0hQR+Fp3pNqsQJb5lEXHdu1nHIAUfmz7/gU8Rt3XYwhyTmR19w/x6
         Z5kHNA62Q0VB1PSGJjdrYrVTRAMdZxQlXd7JyFGFOoMudkiogGLxu+i42MvIts0cxsET
         jRlg==
X-Forwarded-Encrypted: i=1; AJvYcCUfXAIEF2Qjft1ro+61B3EzzyVmXf8ZiFD4kXDh36uSf0cJ8Vwb3y6HVWZWIAfd7cZ5OBXkQYvCJrc0NrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wb42sgu+KIx8AGCxL/zSRkvPy4cm6qGR4Pit8bWHETx0qFi4
	daH3j7m8dMq7SuyplDL3oCGSnH7UnrDRBaBjVe93M2kqrCl+s2rGaBcaJpcaHlYKicgwYTZm8Gs
	kH9TbdChcxbp8W3jJt1Kxrg/uR6krvU8aD5UFK9YP2bamNFxFVBMWFkwLvKUr3/w=
X-Gm-Gg: ASbGncvf7WNZchQzF5jScd1rDs5ZYnUJp3b2kRNkSjtviSZr2Djrjwk16oid/gNavt9
	ep50eqrd49w1cUCns2dKykX+C/TOhrW5rfBA36HdGU39t621dT5ESwrcq6m/3sh/Nz21XmNXSoB
	VVQGpiV4CmOw5a54boxJLtVNnQIeWaljPO7hK486rjgixzhM+7+YcbqrBzPgs+3s7ixmGZMZvde
	3Ie1dK3P7ippe9FGiErQYsWRNdlRlwtM2njME6yCwU+I49waBI+jXq4s0Woq15SwkVtzoO3a0Vd
	33koO93ANFA1x20HNshsIvxepwrq4cqc2SVCmvTv3DosI5qhPiV1xVYSCk4=
X-Received: by 2002:a05:620a:4793:b0:7c0:7753:9807 with SMTP id af79cd13be357-7c07753984fmr245804685a.2.1739454823003;
        Thu, 13 Feb 2025 05:53:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfRJnsuo/7alsc6cmW1TUv/j5i4/UelSoGDYSvEXPaZTGIzpCzI0MBm2/J7M+CkFWsBrPiFg==
X-Received: by 2002:a05:620a:4793:b0:7c0:7753:9807 with SMTP id af79cd13be357-7c07753984fmr245803185a.2.1739454822571;
        Thu, 13 Feb 2025 05:53:42 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1c4692sm1219859a12.31.2025.02.13.05.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 05:53:42 -0800 (PST)
Message-ID: <936dc0e7-bd24-4b20-892e-831b4e5ddfaf@oss.qualcomm.com>
Date: Thu, 13 Feb 2025 14:53:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: Add crypto engine
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Johan Hovold <johan@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250213-x1e80100-crypto-v1-1-f93afdd4025a@linaro.org>
 <Z63xEdcvCRHchHWu@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <Z63xEdcvCRHchHWu@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: HMw7n77YhHUKpZFxQtsaYqnbnBNPWDh7
X-Proofpoint-GUID: HMw7n77YhHUKpZFxQtsaYqnbnBNPWDh7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=914 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502130106

On 13.02.2025 2:18 PM, Stephan Gerhold wrote:
> On Thu, Feb 13, 2025 at 02:44:02PM +0200, Abel Vesa wrote:
>> On X Elite, there is a crypto engine IP block similar to ones found on
>> SM8x50 platforms.
>>
>> Describe the crypto engine and its BAM.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>> https://lore.kernel.org/all/20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org/
>> ---
>>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> index 9d38436763432892ceef95daf0335d4cf446357c..5a2c5dd1dc2950b918af23c0939a112cbe47398b 100644
>> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
>> @@ -3708,6 +3708,36 @@ pcie4_phy: phy@1c0e000 {
>>  			status = "disabled";
>>  		};
>>  
>> +		cryptobam: dma-controller@1dc4000 {
>> +			compatible = "qcom,bam-v1.7.0";
> 
> Hm, I would expect this is at least "qcom,bam-v1.7.4", "qcom,bam-v1.7.0"
> given that this is a pretty recent SoC. I don't think this makes any
> functional difference though, and we don't seem to have it on other
> recent SoCs...

It is v1.7.4 fwiw

Konrad

