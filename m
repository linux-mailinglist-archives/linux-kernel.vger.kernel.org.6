Return-Path: <linux-kernel+bounces-561274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D2A60F87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BD81B634DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC1A1F03DA;
	Fri, 14 Mar 2025 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ChG3IXmP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7411DF963
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741950208; cv=none; b=aj5hu4UGH6Ow0Vr4u4cl57QYU2+sgOmngRIwBaDAKRbPAETVbIW53u0VLRj02PMUiVLfMt5H8IHSS4lL5M4vnhXiMFNrfV9TQ7ZqxvZNpe0VNkZTDYpPHhH+qHLjmYp6MnO6KbFnOk0BE6VMCrBe2kZUHoDYgLuMMqpDEQyhI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741950208; c=relaxed/simple;
	bh=uA7SPFr2eoMlKnEljinAiTQM0TacXxYpJ2X25QQZlM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuaYPzuVU3wAaMlBjc2slfmGa6juu/smzPYsRaw9WHnJev3IN5ricrs9zHDhhA/EdoNHDHVkREoNuzkSienvUl6ZCIDE6/r1E0i4ghfGs3wQEJAZenPSPPfEwnvnzQtDkWob66pZq0+Xq1JjdgdFkg7UmS5WQ1c1PwV2aM5b+Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ChG3IXmP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E9S5wg027836
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6HkQ+P7il5VrophlCzDt0ZOE
	0/DNYrGnQI57BKZz4bQ=; b=ChG3IXmPVdh/vnNcrHJr183ibBw1s07x84MEYMzO
	qpGs3aUtg54y4LrSPd5aYxtfvNo0TtTEx1iovhAUD3A+7UeaJy9qU/7q1zaexXZ1
	QZ5JY3ZHrwk4z8l/VLx3NPlglp/KTSXZj8E8UT8OtAgEg7h5G4OGLq4TXfweXKWI
	7hah9/Kq0kk0c+6yk7X4OAAfNrvFSi97G/em6jIndVDcrxo0+AZ9oMHzBGQAvAYu
	b5cKbHfvh5isUIxIE/DZb48fk4QmC3xpOtcITK3ZeIELn5PXoQ7JQ5Elcja/aXjU
	xLYNBSG3szL9+N7lKtcajbY8i5bl5YfcN75kR5xBdZmTSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45c6731x1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:03:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b6450ed8so328041185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 04:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741950199; x=1742554999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HkQ+P7il5VrophlCzDt0ZOE0/DNYrGnQI57BKZz4bQ=;
        b=ipxA8DyQVKHvm35q4QLtVVjyFfdfOAyoRHT1iE+zN9Bt16pyaTs6qXeorP87++vWRc
         msQQi2VeOpSCc6jj9iIoEuurFDKgXz9lvDSvT4I/ziJkvMfQF7HLi4dEoymjuTrnr3+9
         Y9MQM4ECxylYCKlAQhpj1yzHwLhh/yfKbBN0X3BmGLmqnKD+a7PwU8po2M6ttl5GMoLD
         swaPjyeB+JOjj5wMYwdCt21/ptRWw0tU6C6SlrCTdQAuqBHHOwBH0cMV+M22ZtlwSr2W
         AXVbwfBmGzom1a0r+Dl1vESJbINGhqoErAvWs53eb3Oki1fYh8bG7hEJ3mxhqCMk1ePN
         wdag==
X-Forwarded-Encrypted: i=1; AJvYcCUX8L2xe8cI2l4SphLU5YzwAA9TwYN1KuxWLdiCXBUXNXcCw6nYqqy3nssiY4m5nVJ+qGWqj0Sw3n94iPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3QpUcbi/LujCDbjcFx9V7ObJQfPUEYkomJgrPyQPDM5kOWYb7
	An2JS0EihJEQ+bRXvLVpmkdO3eXLMSPr+Po0AVngZZNhVO39Wmb5CE3uVw8G+RoJ6fdDP906yYm
	3hLPt0aBFCdrcUzeS9aB2xyg2Ct9nWyujTxMdCP5SaLlPPQE0a4C2ttw96jpgbdY=
X-Gm-Gg: ASbGnctkdKdH7UmgoExQg/Po772q6RjWKO//1hyTUq1vGr42T7W0/bQVsTdI0w0ZIUy
	YfhmJvTO0DyWuDQRiFr75nelmWgW+N5TZVgDNN6oFS5jZaml2F1/Z7WWc8xGgSP0P0oxjYG7ju3
	7/NknpqXXlfqzMp5oc1Tfci5rDPQeHlGiyMwDVVP7kd65ZYIsMzIuv/L7sCajPK9rU9HHnVQkxF
	T3bh/5RK8QumUArOyMX3ugJETjBfitT8LI+iy5uJTVEEbIDRw3XlQEQKoZeeN32/Lt7oi92t80/
	vdyvIXKVHKFUGj/Og0nI8ej/dRA74vDT9wKBFJDcVAuw6jachocmBjCoctRPyzuxlHNaM1Oxeje
	F2Xc=
X-Received: by 2002:a05:620a:6607:b0:7c5:42c3:995b with SMTP id af79cd13be357-7c57c51fb5amr273679685a.0.1741950199195;
        Fri, 14 Mar 2025 04:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJqv0A6/GgCBpRWkFeSW9R9b930vCjhHsUHqsb6uc1hKHQSzgO4HVnGX+yBQWMs0N7NthbpA==
X-Received: by 2002:a05:620a:6607:b0:7c5:42c3:995b with SMTP id af79cd13be357-7c57c51fb5amr273675685a.0.1741950198812;
        Fri, 14 Mar 2025 04:03:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba88213esm486573e87.175.2025.03.14.04.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 04:03:16 -0700 (PDT)
Date: Fri, 14 Mar 2025 13:03:13 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <acqkh4isxn5e7pxbd22pvb2rbs7zhjnrcjaojomilvqaxwfz5o@kqkr4cn7qovs>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=67d40cf8 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=v3gW0WraWtuZ-AJ_RegA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ghKSydxCzaZJ_5lEYjgiYdyCI2xCgwmh
X-Proofpoint-ORIG-GUID: ghKSydxCzaZJ_5lEYjgiYdyCI2xCgwmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140087

On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> Add a node for the TC956x PCIe switch, which has three downstream ports.
> Two embedded Ethernet devices are present on one of the downstream ports.
> 
> Power to the TC956x is supplied through two LDO regulators, controlled by
> two GPIOs, which are added as fixed regulators. Configure the TC956x
> through I2C.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
>  2 files changed, 117 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 7a36c90ad4ec..13dbb24a3179 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -218,6 +218,31 @@ vph_pwr: vph-pwr-regulator {
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_NTN_0P9";
> +		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <899400>;
> +		regulator-max-microvolt = <899400>;
> +		enable-active-high;
> +		pinctrl-0 = <&ntn_0p9_en>;
> +		pinctrl-names = "default";
> +		regulator-enable-ramp-delay = <4300>;
> +	};
> +
> +	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VDD_NTN_1P8";
> +		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		pinctrl-0 = <&ntn_1p8_en>;
> +		pinctrl-names = "default";
> +		regulator-enable-ramp-delay = <10000>;
> +	};
> +
>  };
>  
>  &apps_rsc {
> @@ -735,6 +760,75 @@ &pcie1_phy {
>  	status = "okay";
>  };
>  
> +&pcie1_port {
> +	pcie@0,0 {
> +		compatible = "pci1179,0623", "pciclass,0604";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		device_type = "pci";
> +		ranges;
> +		bus-range = <0x2 0xff>;
> +
> +		vddc-supply = <&vdd_ntn_0p9>;
> +		vdd18-supply = <&vdd_ntn_1p8>;
> +		vdd09-supply = <&vdd_ntn_0p9>;
> +		vddio1-supply = <&vdd_ntn_1p8>;
> +		vddio2-supply = <&vdd_ntn_1p8>;
> +		vddio18-supply = <&vdd_ntn_1p8>;
> +
> +		i2c-parent = <&i2c0 0x77>;
> +
> +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;

Please add pinctrl blck for this reset line.

-- 
With best wishes
Dmitry

