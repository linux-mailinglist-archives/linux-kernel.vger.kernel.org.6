Return-Path: <linux-kernel+bounces-545061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FE3A4EA97
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31858A6FF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E5E27E1C8;
	Tue,  4 Mar 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EWOkJjNt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E42080D0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107408; cv=none; b=Nd3M794GjVJWFseMqMRbH/cVTKaviEBGcghTmHC8vsSsIBfZ17iTlb7yqnqJupAKgcNKTTpokGu3MDl/qSBFlwgoi+0nPRgjrQV36+FGAVXqsRoTxJ44o4k36fgblLPCJoBDS97lNGB3JrCw8f0BNCOkmmDN3A/O/jqBDc9IQ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107408; c=relaxed/simple;
	bh=faMsthIU2rKzizBdyenPntp3DnH3cLvnQOLcOERjhWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOZbabcN1EjP0z2kRi9MSt3YRAFll8VcId4D7r9MNcjLBg/Ltyzm3P0OpOEPzwnBBquYWmLjr7eS0+v0B/AU0my5ipwSA/nkzSARmLn0y5NaEqGfwoXe7oJXBlxn6A+acRO/iFcoeNuz2mAy+i7C1PZn1Gbw87Z/Sf7AsCcIYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EWOkJjNt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524ASNTi021151
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 16:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jeCtW4lbMa2wB+pGkNjK1YgYQBzXYFl+3yQ06H7E5zI=; b=EWOkJjNtxIFjQ2eg
	2r+6rmRZk9ersAfadkfjYaLhNPKslDpcv+l0wAkSriCyflsNJUbq3UlYnzINh9wA
	E6l2EDcNgAolWD9fohEzRFfSMo8ow17+x3Lz2T73zrs26kezraiGmdNImQlMowom
	v250Tj4ijwBdMfGcyOo60Pb5vbi6v3DdgQkBUIsF5PvjuAS1HLqh+1AVo3/bBRnj
	CnRe88k1bMaUtzJ70xRyDZvwh8cMIt3PjcGc3GHH/5WG3i+lYb2rvE21Z3DjQoM8
	SWGaLL4d21YqKFkyNglRNjhODj6H6s12LyO+gf3XcGXFeuo/EKRvoEdpCRcw9mfu
	w1HYkw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tth7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 16:56:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e1b2251f36so11157936d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107405; x=1741712205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jeCtW4lbMa2wB+pGkNjK1YgYQBzXYFl+3yQ06H7E5zI=;
        b=XOvciO15OYirSuohP0p7jErMCwI2nBWiscVciuutYNpEPpJwYkEC9/HPuxXLPlP5zA
         3Z8BS1f5AAbKCEDBko3V3QXft2+Zg0aXvf5vNLqInrxj7l4zTFv6Ed8LSgJ1U2YMHDJY
         kV5G0WJcG5Gt+wE2ofXKOYRPsqG2Fyd5Mmqn+NKHiCziiHpv2wS2axaL4m80e7WOub0B
         p+kDHrBIW6GxVm5ZKYK3JH2WAE1UJqmmvzk5zX1iJcQvmFXs8ht1h8qDebMoM1RJs3YX
         o1H5hOlJJQrYkcJuGT7aty+ZJMOKkBFMfmYXoN2/XWR3AhtZxhvGwmKPYkedAnkNo00g
         IUUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVulGIXPVbdts3C1SvjF2DlZVolutQKNLkY4WRShEhfU0ubA9wbaz0ncgEQmbw4H0DrfMPIGv5db+I/EvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzozAqT+a0ExLD+H//8mXLdhwU3IvvtSRA/RmJWvz0SSl5j5XOL
	/mjacuurFR6RrzR+gcY1tyxzkqPMDYZ/Uqga57+hpZ8SYftbUTOCoQRs5Em9h6LZYCi7Qxq+ayc
	0s5rJsNqnlMcbSgpxE5GSJeiB7aOdYn7kKhKrG3rz7j0JYtkJ3ESMmDoR/CghEGQ=
X-Gm-Gg: ASbGnctg24PVoIHzgJExELmCSSJNN+sCApsri5MlmkyxoTM4xwAMX1V9csE10fUV7r/
	tMltg5X1Pf/EUD3np/V8Ya4chShNBQDfHsLZJ4OmET4C1XqdFHEz+VhRe4Cw6clVM0z8PwxPVrl
	BsOD8JI4IfasKBx7is+9csA9iu7DXeD7BoFj+m+x4p8WhI6vQjFg/AlfOdMWD+xHZhbPc4fzZGA
	lucQCca3bAUvP63CfuMk6RC++fFW7VD/PQ84wtKhmn+WLlmcmRZiEoccgF0A23MsNk8TIBZL+lG
	6lHYyz1iRePBQUhoHbAXV6pbBP6hfM1PwmYyKOF115FijkUSIrDKVL5vvYNsQc4TtnpStA==
X-Received: by 2002:a05:6214:518c:b0:6d8:f750:b2f1 with SMTP id 6a1803df08f44-6e8dc2904ffmr15699356d6.11.1741107405194;
        Tue, 04 Mar 2025 08:56:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDvPwCooBjtFZFTrypVsEc1Pzi5aDYHsuSLfjAg+hqO1PNWsuhlUJTPfRjPAcb4z7sb1bj8A==
X-Received: by 2002:a05:6214:518c:b0:6d8:f750:b2f1 with SMTP id 6a1803df08f44-6e8dc2904ffmr15699166d6.11.1741107404824;
        Tue, 04 Mar 2025 08:56:44 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb6067sm8319687a12.50.2025.03.04.08.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:56:44 -0800 (PST)
Message-ID: <58d32bd4-d854-4233-89c9-22c37bddfaa1@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 17:56:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: qrb2210-rb1: add HDMI/I2S audio
 playback support
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20250302-rb1_hdmi_sound_first-v1-0-81a87ae1503c@linaro.org>
 <20250302-rb1_hdmi_sound_first-v1-5-81a87ae1503c@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250302-rb1_hdmi_sound_first-v1-5-81a87ae1503c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6rUg3hGMUTDDa_CmbMjom2u4lQffW_cG
X-Proofpoint-ORIG-GUID: 6rUg3hGMUTDDa_CmbMjom2u4lQffW_cG
X-Authority-Analysis: v=2.4 cv=Sf4NduRu c=1 sm=1 tr=0 ts=67c730cd cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1NR_YFCaA4PxXnam7p8A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040135

On 2.03.2025 3:49 AM, Alexey Klimov wrote:
> Add sound node and dsp-related pieces to enable HDMI+I2S audio playback
> support on Qualcomm QR2210 RB1 board. That is the only sound output
> supported for now.
> 
> The audio playback is verified using the following commands:
> amixer -c0 cset iface=MIXER,name='SEC_MI2S_RX Audio Mixer MultiMedia1' 1
> aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 49 ++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> index 7a789b41c2f1887f0c41ae24da2e2fe8915ab13c..e547537cffdbc13cfd21b8b8b7210b62996ff431 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> @@ -186,6 +186,47 @@ vph_pwr: regulator-vph-pwr {
>  		regulator-always-on;
>  		regulator-boot-on;
>  	};
> +
> +	sound {
> +		compatible = "qcom,qrb2210-rb1-sndcard", "qcom,qrb4210-rb2-sndcard";
> +		pinctrl-0 = <&lpi_i2s2_active>;
> +		pinctrl-names = "default";
> +		model = "Qualcomm-RB1-WSA8815-Speakers-DMIC0";
> +		audio-routing = "MM_DL1", "MultiMedia1 Playback",
> +				"MM_DL2", "MultiMedia2 Playback";
> +
> +		mm1-dai-link {
> +			link-name = "MultiMedia1";
> +
> +			cpu {
> +				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +			};
> +		};
> +
> +		mm2-dai-link {
> +			link-name = "MultiMedia2";
> +
> +			cpu {
> +				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
> +			};
> +		};
> +
> +		hdmi-i2s-dai-link {
> +			link-name = "HDMI/I2S Playback";
> +
> +			cpu {
> +				sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
> +			};
> +
> +			platform {
> +				sound-dai = <&q6routing>;
> +			};
> +
> +			codec {
> +				sound-dai = <&lt9611_codec 0>;
> +			};

"codec" < "cpu" < "platform"

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

