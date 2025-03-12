Return-Path: <linux-kernel+bounces-558119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C9A5E1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3320189ABC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA50F1F4CB7;
	Wed, 12 Mar 2025 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O4YuBNu4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3F1D5CF2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797630; cv=none; b=fzomwHfJeGz33iIu6DBFPmvzyE6QSCTyJnmNDoKXLYFF6e2azM3ZFFRj3b3D1vv7ZZ71V+F9gxtCi5NfwbU45LaiEQFZp9t7AtI4ZY9txF55M4jYAquvBCd0bPcymGXCBQlWu7m2UBhp0mkp2nB42Vc4xc6z19b9KGTylj19a0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797630; c=relaxed/simple;
	bh=Io0AKntdWzrLdKiB6rfL/z79Uc3mRHWtbCLzf5lZ9z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1vDgRoktyKEy/fN6guK8Cmkm3QXPD8pBVwI1EvcvlHCXMXmCdl9xayEAcKmdmotDe/qSHwrFmn388KKx+PXI5QrxyYDAqLeWQ9Myme+Zs9kxMGVWmFkXgAGePSGpnYdlgiG2smhdRsDnPId+rJLgW5O8cN9xxdFCDwEGQBkmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O4YuBNu4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CALYcE031333
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L2V3/SDVBJWSxkwFTuKAO8wNv03I98j9gLY2gIdk/Ow=; b=O4YuBNu4gB5aGw7X
	iDDT/iGYX2+PEiRaKv6gu72oFNIhYlE2hRx1dlicux/3avXSBLTVZyDxVpFcdEil
	0Jxb/Or7nFCIQtGVN/qrK5JXEU4ksUykRaVmbfR6FRDatbc8VQxV7wpermACaITa
	TsprgJz1uCpMcdoyQW2X9x4s/L25UvtLT1dAQoQ4M6+fA52pbI2ZDSk08+gjQrQ8
	odEX5arKEc3IMzon17vaZL4kgx6IXCan9aOMKgkaapIxJ0mFuXnbmKL8gmFXAR6r
	xoMARgKJnsOicq9iQSbAyyKGENhdtCCMVJmecIhZjb2xJwv7C72+hc79ohmyped1
	hAipaQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2qk261-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 16:40:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff6aaa18e8so110146a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741797626; x=1742402426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2V3/SDVBJWSxkwFTuKAO8wNv03I98j9gLY2gIdk/Ow=;
        b=VeZrxCzb/EpHr2QHeKjB5xbMmfDaxo5EclUnJa+O54Sq3oYpLEEZ/lIFNmAGsit26d
         UHUN67FxyD6uze8mpxcLaMS4AXOmgwpSVFKZ6jZsX+sBm6Lt8YiEqPlFI+9Qs9jqbPAZ
         5wRAn1iXRYZzJj9VUtfDrSw5FUXj9vEPTcN3GiGGfYzMDXMmfjOFGpCGY67nk30XQlXp
         Qcr2bfERWYFW8VkP2VKqWv8/FvHv6K1/tgjZrz/9njgXIYgha8hsfbBCZZzM6JmgOBkz
         3dwoY2O8Wchh3rV/T2+vxfcLdIdE0jLpxe4iIIkMVQxsQXX0dkO0/CJKd+oxxeLa1N5E
         eGFg==
X-Forwarded-Encrypted: i=1; AJvYcCVcvVZaMTBCvQ2V36oTQn198uqXqOCOn7IvMY7AIQDHGWwh1vPVcn1d8zwFwK6EI1Tr1ZpA4AnsCU2FcE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4ThD4y0IZSviS48sZZ4/Y8Dgank3655HPHnF4YxNmMy8729qS
	1fLCNoRzY9uco74DD4DZy5G0ZQAFHjjoebl7XIKIDX32BTnzKdAde1mdpU1pqQ2vaYc2t9L5wrs
	PdJcrvPud2c7UXH8y55HI/C0ExpOBMPUxBZDmhesWrgh3G4nYJKZ+N+MyaYQhA3Y=
X-Gm-Gg: ASbGncs6X+eflu5GeGNMMyWymyu7tQkw1zY5xUyWUxzDucJoL11Jt1DFL1ai4CiQomV
	wfnSYqAWYqRt4GALiEJhK46yS/lTF4JWTWFJj1opyAF9i9MCI7qGyrGQTvdHV/PuIgmnDwQUqCF
	EALcqebAqOzTiiXdFl75PtE9934X2gOsnfaoOYtQyB3v/9OJk/cEGlU50WjtEMUlOub92OaPXZ/
	7rZ1ccN2K2IlSn2H9cu76UDsUAITZT8p1phKvxaqAYVraWTvD6y/rduPTCk7eqpj9q6RpEYE1lo
	zeSxi+Vs9pTvm5TI/UWzhkHiIzj+0qMc/gfnkd2bU4cUm3luhs8/qnQZWQ==
X-Received: by 2002:a17:90b:2e42:b0:2f7:7680:51a6 with SMTP id 98e67ed59e1d1-300ff0a4593mr10559696a91.6.1741797624559;
        Wed, 12 Mar 2025 09:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWKLaYixh5c+sJMPTXs5ZZ3Cbo1u3HxPQsksE8CPOCmdqlu+PjljtTDCDElb5VxtwOAemsfg==
X-Received: by 2002:a17:90b:2e42:b0:2f7:7680:51a6 with SMTP id 98e67ed59e1d1-300ff0a4593mr10559656a91.6.1741797624076;
        Wed, 12 Mar 2025 09:40:24 -0700 (PDT)
Received: from [192.168.29.17] ([49.37.215.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30118249759sm2206897a91.25.2025.03.12.09.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 09:40:23 -0700 (PDT)
Message-ID: <8efdc560-d061-4f03-bed5-8571044119cc@oss.qualcomm.com>
Date: Wed, 12 Mar 2025 22:10:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: dts: qcom: ipq5424: fix and relocate uart1 gpio
 configurations
Content-Language: en-US
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250312091418.3265352-1-quic_mmanikan@quicinc.com>
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <20250312091418.3265352-1-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Lw87oAZBCge0ALKbnRUGZexbbn8N2AYH
X-Proofpoint-GUID: Lw87oAZBCge0ALKbnRUGZexbbn8N2AYH
X-Authority-Analysis: v=2.4 cv=TIhFS0la c=1 sm=1 tr=0 ts=67d1b8fb cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=d+lWxUpqeNYAcJEdQAshKg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=HwDeC_NjNoN76rn-rm0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=qBRm1UoaiinxN4wKqXP-:22 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=661 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120114

On 3/12/2025 2:44 PM, Manikanta Mylavarapu wrote:
> Update the bias configuration for UART1 TX and RX pins to ensure correct
> settings for RDP466.
>
> Additionally, move the UART1 GPIO configurations from the common .dtsi
> file to the RDP-specific .dts files to account for differing bias
> configurations across RDPs of IPQ5424.
>
> Fixes: 1a91d2a6021e ("arm64: dts: qcom: add IPQ5424 SoC and rdp466 board support")
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts | 16 +++++++++++++++-
>   arch/arm64/boot/dts/qcom/ipq5424.dtsi       |  7 -------
>   2 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> index b6e4bb3328b3..7b85aaa11ee8 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq5424-rdp466.dts
> @@ -147,10 +147,24 @@ data-pins {
>   			bias-pull-up;
>   		};
>   	};
> +
> +	uart1_tx_state: uart1-tx-state {
> +		pins = "gpio44";
> +		function = "uart1";
> +		drive-strength = <8>;
> +		bias-pull-down;
> +	};
> +
> +	uart1_rx_state: uart1-rx-state {
> +		pins = "gpio43";
> +		function = "uart1";
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
>   };
>   
>   &uart1 {
> -	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-0 = <&uart1_tx_state>, <&uart1_rx_state>;


Change LGTM. But can we define both TX and RX pin definition under one 
node like below, to align with the SPI and SDCC gpio definition layout?

qup_uart1_default_state: qup-uart1-default-state {

         uart1_tx_state: uart1-tx-state {

          ...

         };

         uart1_rx_state: uart1-rx-state {

          ...

         };

};

and refer it like pinctrl-0 = <&qup_uart1_default_state>;


>   	pinctrl-names = "default";
>   	status = "okay";
>   };
> diff --git a/arch/arm64/boot/dts/qcom/ipq5424.dtsi b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> index 7a7ad700a382..e190c43c1b11 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5424.dtsi
> @@ -262,13 +262,6 @@ tlmm: pinctrl@1000000 {
>   			gpio-ranges = <&tlmm 0 0 50>;
>   			interrupt-controller;
>   			#interrupt-cells = <2>;
> -
> -			uart1_pins: uart1-state {
> -				pins = "gpio43", "gpio44";
> -				function = "uart1";
> -				drive-strength = <8>;
> -				bias-pull-up;
> -			};
>   		};
>   
>   		gcc: clock-controller@1800000 {
>
> base-commit: 0a2f889128969dab41861b6e40111aa03dc57014

