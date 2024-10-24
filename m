Return-Path: <linux-kernel+bounces-380393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28FA9AEDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049BCB27AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C254F1FC7EB;
	Thu, 24 Oct 2024 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JMioIBhJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3BF1FBF63
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790538; cv=none; b=qY9YpHhPOJyoI9P3f6jSRoFdVuiu0II5Q6/DMIiWuDpwtKlOpeHwilRF6Rm7uhQ8BRx0XtIfBnyUUHQb7C1AKDBDcsWIJzWWDtIZMrVArLgsWMxRxwppTIP0V/Cv7JLZY/pjFjRqejwNaj97Ck7PPSrO+DbkLpjCf7MVZSaym+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790538; c=relaxed/simple;
	bh=xvh0qobSKEeDTd9UXVzqjHTneCS4N9iZojwKHXERKN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f7LQfQJEDBXW3g2kCAe3q9lRDSU3t+rV6shh82ZMBpSjoHl5kiLkQBgz/SBkNA35OV8ANLetMDeqkVCZ3iD79mbWncMh3V1QB08ESo0ttAYuS9lCoLcd2RUXtkhmpGZFq9azZH5FPk2u/ZWz5vT0Fh35dMyjvOWtFJXRciHULCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JMioIBhJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OACr7X019590
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xmVEUo/xABf7aaYqxBjxjdmRkGZGXBcqXrb3toHDVYI=; b=JMioIBhJuSq3cCQI
	HoCmlzvjHhLaERswC8WRy2RrY6SdtQ/f+CH7XhBWAYRMWLCyXHFVjuRznquDJ5OO
	gbneUnpZMCUlw4BiewSiT9G2aODo2jwYiTepo0sg5bArwlaXoCqC/Bri863KUj4E
	YA2wqAQ2AGbXur4eeSdSchPPd2qcgmEnU9Dgz0NAA+tnjh7FU4rYenCp0FgcCwTz
	fSnqkZdH9RWegeVtrdpa876Befn/YWgopalZLRMLoIHQe6pt4On40E4Xjq5u7+PU
	aInmLGWr+XgYuDSa39KCq1IYZr194g+CQBUuDLa78VFfSeYjk6otbjmO4Tc3AIH3
	ppiA4A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3weet7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:22:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbd0a3f253so1558046d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790534; x=1730395334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmVEUo/xABf7aaYqxBjxjdmRkGZGXBcqXrb3toHDVYI=;
        b=FD+A56cCrF9rORwV0bHHxGb8aKHlih8Ac1KhYJ8v2gGQAihNuexQo7KTlyM+FsIXVt
         7Cx2Ah7eAJrZtHyMv5PGZdmdx9aUlytsCgxAbeFL6NlLIlAtg8/vGXPFsWdNiqMpVUjW
         wO4BExXRwCXXvQvLBYTE17Z7WQzDfwEKfrVBcthlVPKlnvV0LfHgCh6e4CSM6lbxu2S7
         W8hamrKH6gfIOPha8xu9icgBOkgjg1zPRbYLwk8dLCQGlbl1j98xSmaFxbIZ1dkNVteg
         YU96fJISpp/IUuRGidWiTG1Bkel6ehsbu849ofqDjEgzOX324a9q2IVV5dEMTo0QgI4M
         7UHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdsZ5h1zpJUDZzm0wa0CbTHKmzOVw5K+6uhiJuaKQmiUbLMEtmlQaGbc1jPcXJJVpS+hkOqciidzfciTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNC9iAkYzLxA82D99g+5aj9E0McuztUqvaWomwy+uWGHU9IIjl
	OfFVT8DrVtz17S0aZZ5gWmBQ2PR5h+jxjvIIsUdF60RBgiPBfWKt1jQm7RGg7biI6S/1IWWbc21
	PlLoq6TX1T93BoOWhrg6Wx2Z84PrfYXMF82K0nuLLhdiFxWBlleOnqEpf+v41+UY=
X-Received: by 2002:ad4:5d67:0:b0:6bf:6d90:c084 with SMTP id 6a1803df08f44-6ce3413aee0mr45567436d6.3.1729790533885;
        Thu, 24 Oct 2024 10:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmDElvF4WY48ZSYmmi6ZIlDkPoW8/hW61PfyViulWHB9Uu9cc4VmhgeqWWdIDvsMeYtmFOgg==
X-Received: by 2002:ad4:5d67:0:b0:6bf:6d90:c084 with SMTP id 6a1803df08f44-6ce3413aee0mr45567156d6.3.1729790533451;
        Thu, 24 Oct 2024 10:22:13 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912d63b1sm645658266b.42.2024.10.24.10.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 10:22:13 -0700 (PDT)
Message-ID: <3ca1f7e8-1204-4898-9e7e-cb6423c122cc@oss.qualcomm.com>
Date: Thu, 24 Oct 2024 19:22:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] dts: qcom: Introduce SM8750 device trees
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>
References: <20241021232114.2636083-1-quic_molvera@quicinc.com>
 <172978739477.623395.5604249801475913676.robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <172978739477.623395.5604249801475913676.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SvctAhMcDn3U2BkWJjtJOvcXgvx2Ouv9
X-Proofpoint-ORIG-GUID: SvctAhMcDn3U2BkWJjtJOvcXgvx2Ouv9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=632 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410240143

On 24.10.2024 6:33 PM, Rob Herring (Arm) wrote:
> 
> On Mon, 21 Oct 2024 16:21:09 -0700, Melody Olvera wrote:
>> This series adds the initial device tree support for the SM8750 SoCs
>> needed to boot to shell. This specifically adds support for clocks,
>> pinctrl, rpmhpd, regulators, interconnects, and SoC and board
>> compatibles.
>>

[...]

> New warnings running 'make CHECK_DTBS=y qcom/sm8750-mtp.dtb qcom/sm8750-qrd.dtb' for 20241021232114.2636083-1-quic_molvera@quicinc.com:
> 
> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: domain-idle-states: cluster-sleep-0: 'idle-state-name' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/power/domain-idle-state.yaml#
> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: domain-idle-states: cluster-sleep-0:compatible:0: 'domain-idle-state' was expected
> 	from schema $id: http://devicetree.org/schemas/power/domain-idle-state.yaml#
> arch/arm64/boot/dts/qcom/sm8750-qrd.dtb: domain-idle-states: cluster-sleep-0: 'idle-state-name' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/power/domain-idle-state.yaml#
> arch/arm64/boot/dts/qcom/sm8750-qrd.dtb: domain-idle-states: cluster-sleep-0:compatible:0: 'domain-idle-state' was expected
> 	from schema $id: http://devicetree.org/schemas/power/domain-idle-state.yaml#

These were recently dropped across the board, please drop them
here as well.

> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: pmic@7: 'eusb2-repeater@fd00' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'
> 	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
> arch/arm64/boot/dts/qcom/sm8750-qrd.dtb: pmic@7: 'eusb2-repeater@fd00' does not match any of the regexes: '(.*)?(wled|leds)@[0-9a-f]+$', '^adc-tm@[0-9a-f]+$', '^adc@[0-9a-f]+$', '^audio-codec@[0-9a-f]+$', '^battery@[0-9a-f]+$', '^charger@[0-9a-f]+$', '^led-controller@[0-9a-f]+$', '^mpps@[0-9a-f]+$', '^nvram@[0-9a-f]+$', '^pbs@[0-9a-f]+$', '^rtc@[0-9a-f]+$', '^temp-alarm@[0-9a-f]+$', '^typec@[0-9a-f]+$', '^usb-detect@[0-9a-f]+$', '^usb-vbus-regulator@[0-9a-f]+$', '^vibrator@[0-9a-f]+$', 'gpio@[0-9a-f]+$', 'phy@[0-9a-f]+$', 'pinctrl-[0-9]+', 'pon@[0-9a-f]+$'

phy@ (as seen in x1e80100-pmics.dtsi)

> 	from schema $id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: rsc@16500000: regulators-0: Unevaluated properties are not allowed ('vdd-l1-supply', 'vdd-l10-supply', 'vdd-l4-supply' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: rsc@16500000: regulators-0: Unevaluated properties are not allowed ('vdd-l1-supply', 'vdd-l10-supply', 'vdd-l4-supply' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: rsc@16500000: regulators-4: Unevaluated properties are not allowed ('vdd-s7-supply', 'vdd-s8-supply' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#
> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: rsc@16500000: regulators-4: Unevaluated properties are not allowed ('vdd-s7-supply', 'vdd-s8-supply' were unexpected)
> 	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#

These need bindings updates

> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: rsc@16500000: 'power-domains' is a required property
> 	from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,rpmh-rsc.yaml#

This I'll address when reviewing the dt

[...] (skipping a bunch of duplicates)

> arch/arm64/boot/dts/qcom/sm8750-mtp.dtb: timer@16800000: #size-cells: 1 was expected
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer_mmio.yaml#
> arch/arm64/boot/dts/qcom/sm8750-qrd.dtb: timer@16800000: #size-cells: 1 was expected
> 	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer_mmio.yaml#

#address-cells <2> is fine, #size-cells must be 1, apparently

Konrad

