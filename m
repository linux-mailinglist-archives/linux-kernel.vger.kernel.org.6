Return-Path: <linux-kernel+bounces-545057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCD6A4E8F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032BB8E2572
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD327CCE8;
	Tue,  4 Mar 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niOmmo7I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854627CCEB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107359; cv=none; b=Fy6bEYmcIzeDkayecMvNebeOWuH0hLTSAjhie7tiX5BItzBhxNMCeWiz7Ewteg4Ur1+Wnvva4F1l4RLpEb8E9nYAHLMdZfW8IcOz8XslVT1o04AD5jEzlgGwWg42W6/5TFYxOIRlmTNwxloNtL8fdASBzrkMOpxDGeZGi8D/egA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107359; c=relaxed/simple;
	bh=r/DvbsjnuXtNkca7ayYBCnbQtj/RQP12nt2K/ZapVpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwtdIgseb3reYvd3wqzI808j3PvpOoaPxsuSQCBJ91CVTC2s67WoB1R2umhX8grcedPJjGB1NX2ArB0bz2uVM+X6/bzprA94r3X3OfCBrRah20CHV14cLwcvxMDy1a95VLysAFk+pTvmyoMzTWw7LKQ1fiSa6HbGSCUDL5qXpcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niOmmo7I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249kIPg019641
	for <linux-kernel@vger.kernel.org>; Tue, 4 Mar 2025 16:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rwpnOoisIGJ3BRBv2r/rXIZnOMVlOWndF4eZ4cwFlp8=; b=niOmmo7IpsxGmaTv
	+qgeN1IlxDnHG/w3Bs9rW9bIZL50H+O4YmfvbKKEQq1HkF/d3XFJOyZEyoxrjkn6
	MalRhXS3ThQcOxqOUZGdSrgJrIRMJ567daBAWCWbc5t/1y9zDVU1/w6lVmGF8zCw
	GXPnCm+huWVaVJnk9mXibdR/yQj5WW70+ypZ4buQCEJXQj/h/ha7PUhVUfmWJu0+
	Bs5F/vhOz2svWbwytKxOL/DiiFxQ41Y4ye+CuHtNy02hvf6okOtfbJ2VaFv0Nc3e
	6mfHHSWI5uzeQS2WEbAUyX8Ej9p6AaKGUAClP8bK8kPTATVGWve2v6WTD3neZ4UU
	z/zoiA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6t2hu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 16:55:57 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e88b3d5d8bso12857146d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 08:55:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107356; x=1741712156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwpnOoisIGJ3BRBv2r/rXIZnOMVlOWndF4eZ4cwFlp8=;
        b=kbdCGQmOh06kg1ESFq5S48pIHJB1fSfla/zeN/CAQhrOfNFdxZBhCvOXPcdblPgMER
         GL7DuOAK5oEWlMu1EXXDlyYH2C5rrpdV52SWyOLIJ4N3I5iUZbJfu77BUPUw/qq1qwmW
         r7Y/PRrYik/ODxZLPSaDdpAb03v2ZXIP6clm/ZRP+mqvA2qESx9pCG4k9rOYhpQR6K6V
         IrDNvYyTpwCsNkR0n4OAm3PdbwSd5Ca+cqis6kArPsBvegGTZHl0zBcS04/KnPXQjM+I
         PA30apSqz9+kaY1deI67mWaBMZjo4iTv4Bq8wn2oFJ7Gq08+VjqibhMM1OFmv2LJI7Hu
         KVMg==
X-Forwarded-Encrypted: i=1; AJvYcCXKB+x55+V8Y2qGmAYAZoFJ3q4NwTNhMGgg55wFOV0vj7LMxotqK2aD/3/ta9ZXrdjcbAnOKUhcvehipJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+zmpJnlYqmKnPysyAe0XyJEAOVtK0VnF3vEPeHXhWIuWsTOO
	Xsr/dEzsuG/msNl/sLNP6x4vT+UO14zrMe6VEj4iqaLSn5c2gcTgbDR7A61WXClZt/G2v4vJSwD
	9/z3xSSW9+GBPiZVUkzwjUwRKqQTKBxoBX3exVTnvB+2+BveW4jVc21nKP+oN+gs=
X-Gm-Gg: ASbGncuy9Nqke1jJ78o9R1o4899rHZS7gvZbUkpsVV6dqDvwj6XVUybKSlZ13Hw1tlN
	uNut3RTNpbaCokIX6KUFqZJe+mqtmm35rVeD2dN1dOdHShrYqLad46FQgxssTl6rbiQMaA4C9lr
	iRr6OoRByc2MAE9GsjlzsZarspOelnPPULHCKweo/njBtrWASCxtY9ox/ouPZJqmmXo7rGRqKYv
	/xiUdxia0lWoY+Dc0NoTHGfTqJI6fCQ2C/5AKXTVf5lmachekhI26dLt7WJSS7lxxuvUyeqJfsF
	xN0vlFiXVuHkMQuExXExRvCospq6uEedy+3Q3CxGr8owN2YClYBRIpUUUH5l4owQoJbswQ==
X-Received: by 2002:a05:6214:2aad:b0:6e4:2e03:c54c with SMTP id 6a1803df08f44-6e8a0d9dac7mr95886766d6.10.1741107356040;
        Tue, 04 Mar 2025 08:55:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq7ahIUoFMNjamlq8ir9GJJn9WalD116NggZ7aKriJAYx3f0Ea4t1Gl6p2rtknS5Dwsag77w==
X-Received: by 2002:a05:6214:2aad:b0:6e4:2e03:c54c with SMTP id 6a1803df08f44-6e8a0d9dac7mr95886526d6.10.1741107355648;
        Tue, 04 Mar 2025 08:55:55 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm366330566b.131.2025.03.04.08.55.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 08:55:55 -0800 (PST)
Message-ID: <f9ce1585-d3d5-460a-8374-4a5f1733bdd6@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 17:55:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: qcom: qcm2290: add LPASS LPI pin
 controller
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
 <20250302-rb1_hdmi_sound_first-v1-4-81a87ae1503c@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250302-rb1_hdmi_sound_first-v1-4-81a87ae1503c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DGYqa0iwyQiJnR-kmDxSaraOviybSrV_
X-Authority-Analysis: v=2.4 cv=KfMosRYD c=1 sm=1 tr=0 ts=67c7309d cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=3rbz0kGMDrCPfV1SW24A:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: DGYqa0iwyQiJnR-kmDxSaraOviybSrV_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxlogscore=985 adultscore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040135

On 2.03.2025 3:49 AM, Alexey Klimov wrote:
> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
> controller device node required for audio subsystem on Qualcomm
> QRB2210 RB1. QRB2210 is based on qcm2290 which is based on sm6115.
> 
> While at this, also add description of lpi_i2s2 pins (active state)
> required for audio playback via HDMI/I2S.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 41 +++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index 2c90047f7dd867580836284721c60ed5983f3f34..623046ba833b6da284ffa4e30e65ea4ae5fb77a2 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -18,6 +18,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,apr.h>
>  #include <dt-bindings/sound/qcom,q6asm.h>
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -650,6 +651,46 @@ data-pins {
>  			};
>  		};
>  
> +		lpass_tlmm: pinctrl@a7c0000 {
> +			compatible = "qcom,qcm2290-lpass-lpi-pinctrl",
> +				     "qcom,sm6115-lpass-lpi-pinctrl";
> +			reg = <0x0 0x0a7c0000 0x0 0x20000>,
> +			      <0x0 0x0a950000 0x0 0x10000>;

The nodes look good, but this addition isn't correctly sorted

Konrad

