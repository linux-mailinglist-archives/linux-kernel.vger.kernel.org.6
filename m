Return-Path: <linux-kernel+bounces-444123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E162A9F012A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC382867D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7FF507;
	Fri, 13 Dec 2024 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ajKfVmdk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732ED610C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050116; cv=none; b=E/LN73mX9S7E/CPB2CuvolEIDqBqfblInrR0t4HoDbUkHRCK+P8B8q325dchO19JZxngffk4D9GWMgP4IUnjIO06/QHNI9oku3bkVSvuQnwd+df6qGPNWog4EqlYoun93+ggSgDnONMvNagcWx5m+QMVo6+828c9WJYcSdrvGjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050116; c=relaxed/simple;
	bh=C1OmHTKMqj6ZyG3Qgh1f216yP5FMglwHPg8jL/N65MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/g6xGVLzKvrNmeDIPI3g2g4Ex1AP0JVtdwGZPDIKsgnAFzLmpR8HVUIO0JQcyoU6tjQXN0bAdUpv4lGzZhT5Uqpf29GQO4uk4CdaDT/meCJgpB1sX89x95ZRrVUlhgy4ne+gmHVffxBFU5ZYW0ep71pcRr2ZBgZifDJFKN4qLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ajKfVmdk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCH7luY026834
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k4/hjPmcafZUlY4Ld9J6krmjotFTLTKt0ZqTJYFEDnU=; b=ajKfVmdkeLq3ub1r
	v7ZQam+QRotUWzVt8CZuByHdERmyd4Fkw8vGJ6XdQAme7ctLCHsS4yoK9YgnH4WI
	WSEW75Jbtsegv/ZMnjnKwwHUt+1th8kTmCzwoWqos2MqnNsAR4O1aYFnx6grPtQ+
	mJSGg5+RIt/rN7eiyp+hlAuTkJfJZXZHTBDGfePebyzYT3nyakv5Xpy6GaNsgwdO
	led1iDuMviBAQvGQSYSxYd8/DOsEA+tZg8yuqthDw9ND/8M0A3N53ozCDlQoSLtf
	Nu8Djo+mKylzFNYrPoXW3TCJt6Q5qGuNzZXLrwaFo8bhahKE0K0dHWsJCmBwRUnA
	ZeN1JA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fd40mmdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:35:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-467a437e5feso802461cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050113; x=1734654913;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4/hjPmcafZUlY4Ld9J6krmjotFTLTKt0ZqTJYFEDnU=;
        b=TIXQm2JuZMCviHs9yD3ccaLUcEqsHlYSeByZEn6PL1o44TLAjRZmC2O3kljU3yLYXh
         cT7ZgjKJsx0pgECugFLnNfWTpkBXCXYHHA6nyCciWALG3WumQI4PoQGcn8HZvX+cC+eN
         MWwXPsiTM049JkIJgG35J2gbTIdCmsYunThpjb+c+aEyhhBHRkI0FT1fBzLI0XMhnPf2
         kBXKpCSqHfyrEU8uI0mBGFLhKB+oZaZ+GBSCLdbdeqo8R5DTOCQsicc8f7DQgqd92/Ly
         z8VYPhft2SS+Aa14xUxGCODS/cQrAJSsleyliEBd0A8dqiENqez9NGybsyA2cOJ9RCex
         GSjw==
X-Forwarded-Encrypted: i=1; AJvYcCXGVDogY6bEUGeDObuhEZPrvvEi1beViRog1gNUedxwwq+bq8Ii1WLCsgTREi7WrU7SVrnzA2e943IKZ2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lieY9pq7STT5/DNWrhL6V8r4yjoXHBHABWzgodK6kqfYOyTl
	0GB7tcdXYYJNuPoheXkMLRJjY3DyBMVmr/gaB2vQbNmqbBp1ql0u5NwbosZeMMxKuvH/4knYUMC
	fg/PoEywxvt0LaZSH5p9v780Vnwu0ocEdZzUdD8hMAGncjSw2oTGcFuHOAsncCxc=
X-Gm-Gg: ASbGncu0IpYqoGQl4hDdKdrhmvv7T0ImmJeJ875PekCBmlztyqoT/oFaKmv6/KNYah3
	2GXw7FvC4gL5BJl1oegCuiGmbG4LAlNZClIpK5Ooz/tCMw+OXDkg+x5shNl1DmI/jKsbVV/Y7Fy
	8PX8m1kiGKkxoZtD4BH7GjDATNOCCvYV2+hHs6dR2DenehGLFzQ6119pfTbw0cYTDog5wy9QHGl
	Rjv7//VIoegUd7QTpyRU9AaQC72Y2eFP8IRXBi+SQ7v4s2hZBXhMtecIwbQaoD9zwlZFSk86ece
	Sy8pqc5qxDq07hIvUZmXaR4AwOMlLtJI6YuZ
X-Received: by 2002:a05:622a:1306:b0:467:5eaf:7d23 with SMTP id d75a77b69052e-467a5720eebmr4326241cf.2.1734050113160;
        Thu, 12 Dec 2024 16:35:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCRcA24YH+lngVm2gGOGtnM1SuWe0DhJ4BCmyW8qiqcvMK8GKw87YjeMZ0iDDOKqF/YGtJ3A==
X-Received: by 2002:a05:622a:1306:b0:467:5eaf:7d23 with SMTP id d75a77b69052e-467a5720eebmr4326141cf.2.1734050112821;
        Thu, 12 Dec 2024 16:35:12 -0800 (PST)
Received: from [192.168.58.241] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3db53b828sm8362477a12.74.2024.12.12.16.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 16:35:11 -0800 (PST)
Message-ID: <04d23c55-9167-4e8a-9e5b-6dcf66b02b8f@oss.qualcomm.com>
Date: Fri, 13 Dec 2024 01:35:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: Add coresight nodes for QCS8300
To: Jie Gan <quic_jiegan@quicinc.com>,
        "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20241205084418.671631-1-quic_jiegan@quicinc.com>
 <16efb6a8-ecaf-4097-ac5f-368ebab177a8@quicinc.com>
 <25a410a7-2418-45bd-be06-3672a9fb1928@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <25a410a7-2418-45bd-be06-3672a9fb1928@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AuneOFZMTiDikuT2hGXh4zF2OSqCs572
X-Proofpoint-ORIG-GUID: AuneOFZMTiDikuT2hGXh4zF2OSqCs572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130003

On 9.12.2024 3:01 AM, Jie Gan wrote:
> 
> 
> On 12/8/2024 12:28 AM, Aiqun Yu (Maria) wrote:
>>
>>
>> On 12/5/2024 4:44 PM, Jie Gan wrote:
>>> Add following coresight components for QCS8300 platform.
>>> It includes CTI, dummy sink, dynamic Funnel, Replicator, STM,
>>> TPDM, TPDA and TMC ETF.
>>>
>>> Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
>>> ---
>>> Changes in V2:
>>> 1. Rebased on tag next-20241204.
>>> 2. Padding the register address to 8 bits.
>>> Link to V1 - https://lore.kernel.org/linux-arm-msm/20240929-add_coresight_devices_for_qcs8300-v1-1-4f14e8cb8955@quicinc.com/
>>> ---
>>>   arch/arm64/boot/dts/qcom/qcs8300.dtsi | 2150 +++++++++++++++++++++++++
>>>   1 file changed, 2150 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>>> index 73abf2ef9c9f..eaec674950d8 100644
>>> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
>>> @@ -293,6 +293,18 @@ system_sleep: domain-sleep {
>>>           };
>>>       };
>>>   +    dummy_eud: dummy-sink {
>>> +        compatible = "arm,coresight-dummy-sink";
>>> +
>>> +        in-ports {
>>> +            port {
>>> +                eud_in: endpoint {
>>> +                    remote-endpoint = <&swao_rep_out1>;
>>> +                };
>>> +            };
>>> +        };
>>> +    };
>>> +
> 
> [...]
> 
>>> +
>>> +        tpdm@482c000 {
>>> +            compatible = "qcom,coresight-tpdm", "arm,primecell";
>>> +            reg = <0x0 0x0482c000 0x0 0x1000>;
>>> +
>>> +            clocks = <&aoss_qmp>;
>>> +            clock-names = "apb_pclk";
>>> +
>>> +            qcom,dsb-element-bits = <32>;
>>> +            qcom,dsb-msrs-num = <32>;
>>> +            status = "disabled";
>>
>> Could you please provide more detailed information on why some TPDM
>> nodes are disabled by default while others are not?
> Some of TPDM nodes are disabled by default because the one of the following reasons:
> 1. TPDM device are designed to generate HW events, it needs a clock source to read&write its registers. Coresight driver cannot control the clock source ouside AP core, so those TPDM devices without enabled clock source will crash device in probe.
> 2. Some of TPDM devices can't bootup with fused devices.
> 3. Some of TPDM devices have known hardware issues that not resolved.
> 
> I put those disabled TPDM devices in DT in case some of them may be "fixed" in future.

Please mark them as

/* Hardware issues */
status = "fail";

Konrad

