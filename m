Return-Path: <linux-kernel+bounces-382413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D0C9B0D43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6546F285AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0341820D517;
	Fri, 25 Oct 2024 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cZ0I2lAJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54966185E50
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880891; cv=none; b=Wg4F0VI+P9RxvJpFMSDUFWHOFcUvtVTeHfFxQQc9Hiesh6T3Wo1mgs5vtMhes1zE6vay3/2jrgh3A4SKk+Kblc+sptw4cJWgoT5qPwGRugkniRh2uhe06oRDufumCVQ91MJHAsZPRmDVGvhlwlnXzs2vJwRrQv/pTk83QsJokMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880891; c=relaxed/simple;
	bh=ay/unTmz3RlmR0Oc7muHUK0/WqNI6YafCoBKQ8LL+0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOmVGRMGYeKimfnO2ckgun+3MDnufkHyWF3U6EmkngPtePIZe556AMgzgjyMjXs6gQXd19VFonX8gHsB3aZbhFJim7iONcXYg+gsd3ZybHE2kUhuf//JDXda+i8Gm1ia1W9/GHc2JoFYn6IUE8gz/yd8OJoI+478bQvR8RRVmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cZ0I2lAJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAocTC007706
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+M+wg34L4uquxDCbvfWy/JS/d5sodtfeEgnnJma/Cf0=; b=cZ0I2lAJdyyAgpIo
	D5Jfnw4gxg6yRGfHuPbkDVBpP2MVLvG9v2j+rLdgpCDEUMXMWyQR1RQi6jlJEfiE
	tniPmSvGuYmbrXrfdQNpp183D3Cr/KTlEPsD9uhTmNeN9xz793wCxAN3LXe9i5E0
	PNA6cv8jSk3jUf9yPALQvOvCgD60xiPAFWsrRbPk7vp/YXnr4w0EDYjEgT+qcWaE
	B2EqN93oGlYqOXD21875r9clynSYHjbVa2XxVLrM/NTUu9SfBcsvgQqyDHntQRnx
	6xT0oM/MLDkDRfkuOzAyPZoeqDJQwG25hoZfL3X9mVIun3jtBLtvU2YJaVFg6DFs
	EwvhFw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g9x6hdh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:28:08 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4a476155894so54798137.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880887; x=1730485687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+M+wg34L4uquxDCbvfWy/JS/d5sodtfeEgnnJma/Cf0=;
        b=WRQ4xdlzJ5+vXKPolLdMeCcdtU4ifhVOQD+5oYAXfMGsmZzontBuEQxEls6phPOsf0
         W4S7Ezms9RFTkiFEbAqHzsRk1K5OrdXQJgs3AMS6FYQ5urass0aWMmspwDAwhHeDsk7w
         NKFoy6h17ziqIg6Vigqw0RTsh8Ol019Mz2IHflB8MMaSh9jvjOTIKz9eGdPYSUtfkrZc
         p1v98hAuxpkXQekxIt20VJ8X8kQG4o5yfDEKTe2TpXwj0lmNLXOn9KJK97AdRMPMsibU
         Gva5rVQh3r+reuQbtaDW2bGalkjqWGywAHk2uMZaoFNQMJc7GU8BMJCmrIqP8jZ88sFx
         asJQ==
X-Gm-Message-State: AOJu0YxFc9VLBjh8EVx379ot5GsWaZ03zbUzChoPW+jglFV+S+SZQrW2
	sDyDFIKN1DfVaNHcxybPC3z/yShMM0v+xMd8SMPN9XIQmdg9mUp/yeRmFZsNOI12YDEX6ZGp+GA
	hFLQ1rbHQmlmdYkWk/DTYOcGrm1EbKnA1I5Zi5ZmLHL6JhvU485CDZIzk4sRDFYo=
X-Received: by 2002:a05:6102:32ca:b0:4a5:b29f:35d with SMTP id ada2fe7eead31-4a8cfd5e033mr235880137.6.1729880887321;
        Fri, 25 Oct 2024 11:28:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXrUfduaXIqUDs1u9iVo5khKdDm9ObI9Teipfx3dGTO3lA7IuKpM8jH3vTjEiK33oTl/CeNg==
X-Received: by 2002:a05:6102:32ca:b0:4a5:b29f:35d with SMTP id ada2fe7eead31-4a8cfd5e033mr235863137.6.1729880885588;
        Fri, 25 Oct 2024 11:28:05 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f0697easm96440966b.94.2024.10.25.11.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 11:28:04 -0700 (PDT)
Message-ID: <297dbc48-4c34-4bac-822c-be3ae2d00d32@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 20:28:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: Add support for usb nodes on
 QCS8300
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com
References: <20241011074619.796580-1-quic_kriskura@quicinc.com>
 <20241011074619.796580-2-quic_kriskura@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241011074619.796580-2-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Fl7JxMawTOAmAmG9dbDIbXX7AxfA3ICu
X-Proofpoint-ORIG-GUID: Fl7JxMawTOAmAmG9dbDIbXX7AxfA3ICu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 mlxscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250141

On 11.10.2024 9:46 AM, Krishna Kurapati wrote:

The commit title should include a `qcs8300: ` part, like others in
the directory (see git log --oneline arch/arm64/boot/dts/qcom).

> Add support for USB controllers on QCS8300. The second
> controller is only High Speed capable.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 168 ++++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 2c35f96c3f28..4e6ba9f49b95 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -1363,6 +1363,174 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  				qcom,remote-pid = <5>;
>  			};
>  		};
> +
> +		usb_1_hsphy: phy@8904000 {
> +			compatible = "qcom,qcs8300-usb-hs-phy",
> +				     "qcom,usb-snps-hs-7nm-phy";
> +			reg = <0x0 0x8904000 0x0 0x400>;

Please pad the address parts to 8 hex digits with leading zeroes.

> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_USB2_PHY_PRIM_BCR>;
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_2_hsphy: phy@8906000 {
> +			compatible = "qcom,qcs8300-usb-hs-phy",
> +				     "qcom,usb-snps-hs-7nm-phy";
> +			reg = <0x0 0x08906000 0x0 0x400>;
> +
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "ref";
> +
> +			resets = <&gcc GCC_USB2_PHY_SEC_BCR>;
> +
> +			#phy-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
> +		usb_qmpphy: phy@8907000 {
> +			compatible = "qcom,qcs8300-qmp-usb3-uni-phy";
> +			reg = <0x0 0x8907000 0x0 0x2000>;
> +
> +			clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +				 <&gcc GCC_USB_CLKREF_EN>,
> +				 <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>,
> +				 <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +			clock-names = "aux", "ref", "com_aux", "pipe";

Please make this a vertical list like in the node below.

[...]

> +			interconnects = <&aggre1_noc MASTER_USB3_0 0 &mc_virt SLAVE_EBI1 0>,

QCOM_ICC_TAG_ALWAYS, see x1e80100.dtsi

> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB3_0 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";
> +
> +			wakeup-source;
> +
> +			status = "disabled";
> +
> +			usb_1_dwc3: usb@a600000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x0a600000 0x0 0xe000>;
> +				interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x80 0x0>;
> +				phys = <&usb_1_hsphy>, <&usb_qmpphy>;
> +				phy-names = "usb2-phy", "usb3-phy";
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;

That's a very low number of quirks.. Should we have some more?

Should it also be marked dma-coherent?

Identical comments for the second instance.

Konrad

