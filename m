Return-Path: <linux-kernel+bounces-564041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6332EA64C85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C30857A3937
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1A2376E9;
	Mon, 17 Mar 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b3xYLOo0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35023536A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742210868; cv=none; b=A1rp3JDadM/x5VCHLR0SdvBG/mM3Ibns2fO80w49WZkCf84jbLjs4mpdMzyj05CylM/HaBiRdUWlGhIKKoMfiTrnIFWUkhHaDRf2cT88lSwIvsEzDCRnT/NGvwz+wZeFhYKLHqNbporZ+lAZ4ue+Vf+J2dQBWE8rC8y6l/7UBdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742210868; c=relaxed/simple;
	bh=JiU79bmCJxOwRp4oAbETla+RO60mQJSftJKMO9L+DTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsJCZt39m21JcHFTXDfV+hK1v4s5tmd8Icf/lTxZfSrDi5M9qJqhQphgTpIOjln+ji4Qb+ZmqJQ8U251ePHMj9uKdrk8tDihMuxUby29dMZWtcCdr1SoSoUtqKTuoAi9DN8gnZNcK1FX5qKvHtL2k8iM6DXKF9GNY4Jypsy/OpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b3xYLOo0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HAnI6J028624
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Ks6H1Qe4LqVgg5DG9PYOBphr
	rgmZjuWkDZ+NJuoP5cU=; b=b3xYLOo0wdLbXGQr07iIEukKPKy0hFn8wL0YPyNs
	nqGjRcsC2lSNX/7+wXy9tzpxJTvOFc3vENEb+dPZ6j7AA0RIU36UN2aPY4kyDilZ
	Vt8EO1SHDBhS3Uwe5ZSfVSyQhNk5cf5VwQfW+/chuXu+qG0MqZxmwVxnw6NUKy5J
	xm2fXaKR9cYjoJZ832RaQTauti/YNG1MeRcnwQv0644XuX722m6uky8qTqgQOgIp
	aFwrZvg+IxUOm4bUJSmY4qbCDDD8ezeJTsI2fzHQieEfP8dxJuKx86cCDtQKtTwv
	NM/4Ywr/it7G6mJAyGfllLDcYK0/HPOruyuA7uJAl53a8Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1sxvg35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:27:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c3b8b95029so623828385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742210858; x=1742815658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ks6H1Qe4LqVgg5DG9PYOBphrrgmZjuWkDZ+NJuoP5cU=;
        b=lE7dfLkgJWTnmQExC+KP+GdNRrSI1eRz1Md2PU6GBbeVYbxMpV52pmVfqL2ZgLSTVC
         Ke9FnAYF10u+RyX9R3pUWy3Kr61klCqUv2wxKoMoylrKRgV1MY8q1B3qQR/y8VPa0MNE
         VDVEZepVXNzuoXDW/nIz5YWrXEG+WgjmSU+mbAP4sdU3MsvywWNuyUoiPbZ8A76TuDo9
         uq+8VGLidCACyFYU7zX/IhLrkdHE3DM7zIUtP5ZUVL2C7Can/jtP2DxblbCr7jbfJkIx
         J1dLuyiFPWxqskwo9ZyjU7lXZu4NI+iaGLNBzyoAAx9fWj+NcDdYZ2da8UAsfKfRButX
         5ZUw==
X-Forwarded-Encrypted: i=1; AJvYcCVblr8sSYDFraKwFPQg16xSeLDp5nrtBiE+J6oVCogiy5VeD/j8hnCyDN//Puu7pKGLPC4UH5Yl99fzqu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyVkilc5u3736QPqhHwIx1n4Hnh1GypP/QJ9Z5yQ4SQiBBsu0O
	wlhLUHF19G8jQzwtcWORFCCoQ7a/k2wZhV20yLSDxWhKPjsCJRIOAn1h92rywXMF8LXE+P/AOxA
	+bxUBWcpmgQEdlWht+JzlUuI4Pdqu+xTxBi+fq2sjsGwIU5A0zSHij01aSxhw8fA=
X-Gm-Gg: ASbGncuYFmKeW3dFesqpjfMiLD6+6z2cCD+ekbNfX4OxnbhRur88TK4ARZWih/NwLo2
	qQvvZfhkOmuqobAp74RLnZVx0gsu+V6NqC6PNdUjsrKJGfQGrMpFYBEndX4F28oxew8qkVS+jOZ
	HRrSkzZRBGCxPsFN1sdbyirmBUZA+AThTZAhvm0vy8wt9/X9zHdvzV4IKYJ2kixgry1DoqKEfv2
	HN1/Jl8OFTYtKuDKNAXBK7+Dz35ahmNJRacrlRRa6WPcLq3dR81ThUWLhX8u8DxrnN/frRdr88s
	OZiixF/0boXFZSP6hdG5bgBb7Ccp4/DGnDiQ6cLmUJDm/cWXTZxwbhdX+lWJkQyPN/MnBDBkpbW
	tQPk=
X-Received: by 2002:a05:620a:372b:b0:7c5:3df0:48cf with SMTP id af79cd13be357-7c57c7b99edmr1608500985a.3.1742210857637;
        Mon, 17 Mar 2025 04:27:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgmKbqNlFcHOVK7QmTXPEEAfaypemgHDiFvZ5/SKCUl+uj1n4jhLXU7saD/jBY49l4D08veg==
X-Received: by 2002:a05:620a:372b:b0:7c5:3df0:48cf with SMTP id af79cd13be357-7c57c7b99edmr1608497685a.3.1742210857270;
        Mon, 17 Mar 2025 04:27:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f1dbb12sm15187661fa.95.2025.03.17.04.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 04:27:35 -0700 (PDT)
Date: Mon, 17 Mar 2025 13:27:33 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com,
        amitk@kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 02/10] arm64: dts: qcom: qcs6490-rb3gen2: Add TC956x
 PCIe switch node
Message-ID: <c4ompv3t256tl4qosapvtt5fkk5wwqxikclwwuyffvvbu6noig@y2y3hhf24mtf>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-2-e08633a7bdf8@oss.qualcomm.com>
 <ciqgmfi4wkvqpvaf4zsqn3k2nrllsaglbx7ve3g2nbecoj35d6@okgcsvfx27z5>
 <6e51e35f-78c3-5d2b-697e-ce4a7da7b15c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e51e35f-78c3-5d2b-697e-ce4a7da7b15c@quicinc.com>
X-Proofpoint-GUID: NTWnP6XQZl37tgp3o2QWphVL4oghxYTW
X-Proofpoint-ORIG-GUID: NTWnP6XQZl37tgp3o2QWphVL4oghxYTW
X-Authority-Analysis: v=2.4 cv=XKcwSRhE c=1 sm=1 tr=0 ts=67d80731 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=iBLCvXWk7JtlIUnLWUQA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_04,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503170084

On Mon, Mar 17, 2025 at 03:05:17PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 2/25/2025 5:19 PM, Dmitry Baryshkov wrote:
> > On Tue, Feb 25, 2025 at 03:03:59PM +0530, Krishna Chaitanya Chundru wrote:
> > > Add a node for the TC956x PCIe switch, which has three downstream ports.
> > > Two embedded Ethernet devices are present on one of the downstream ports.
> > > 
> > > Power to the TC956x is supplied through two LDO regulators, controlled by
> > > two GPIOs, which are added as fixed regulators. Configure the TC956x
> > > through I2C.
> > > 
> > > Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > > Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 116 +++++++++++++++++++++++++++
> > >   arch/arm64/boot/dts/qcom/sc7280.dtsi         |   2 +-
> > >   2 files changed, 117 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > index 7a36c90ad4ec..13dbb24a3179 100644
> > > --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> > > @@ -218,6 +218,31 @@ vph_pwr: vph-pwr-regulator {
> > >   		regulator-min-microvolt = <3700000>;
> > >   		regulator-max-microvolt = <3700000>;
> > >   	};
> > > +
> > > +	vdd_ntn_0p9: regulator-vdd-ntn-0p9 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "VDD_NTN_0P9";
> > > +		gpio = <&pm8350c_gpios 2 GPIO_ACTIVE_HIGH>;
> > > +		regulator-min-microvolt = <899400>;
> > > +		regulator-max-microvolt = <899400>;
> > > +		enable-active-high;
> > > +		pinctrl-0 = <&ntn_0p9_en>;
> > > +		pinctrl-names = "default";
> > > +		regulator-enable-ramp-delay = <4300>;
> > > +	};
> > > +
> > > +	vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "VDD_NTN_1P8";
> > > +		gpio = <&pm8350c_gpios 3 GPIO_ACTIVE_HIGH>;
> > > +		regulator-min-microvolt = <1800000>;
> > > +		regulator-max-microvolt = <1800000>;
> > > +		enable-active-high;
> > > +		pinctrl-0 = <&ntn_1p8_en>;
> > > +		pinctrl-names = "default";
> > > +		regulator-enable-ramp-delay = <10000>;
> > > +	};
> > > +
> > >   };
> > >   &apps_rsc {
> > > @@ -735,6 +760,75 @@ &pcie1_phy {
> > >   	status = "okay";
> > >   };
> > > +&pcie1_port {
> > > +	pcie@0,0 {
> > > +		compatible = "pci1179,0623", "pciclass,0604";
> > > +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > > +		#address-cells = <3>;
> > > +		#size-cells = <2>;
> > > +
> > > +		device_type = "pci";
> > > +		ranges;
> > > +		bus-range = <0x2 0xff>;
> > > +
> > > +		vddc-supply = <&vdd_ntn_0p9>;
> > > +		vdd18-supply = <&vdd_ntn_1p8>;
> > > +		vdd09-supply = <&vdd_ntn_0p9>;
> > > +		vddio1-supply = <&vdd_ntn_1p8>;
> > > +		vddio2-supply = <&vdd_ntn_1p8>;
> > > +		vddio18-supply = <&vdd_ntn_1p8>;
> > > +
> > > +		i2c-parent = <&i2c0 0x77>;
> > > +
> > > +		reset-gpios = <&pm8350c_gpios 1 GPIO_ACTIVE_LOW>;
> > > +
> > > +		pcie@1,0 {
> > 
> > PCIe bus can be autodetected. Is there a reason for describing all the
> > ports and a full topology? If so, it should be stated in the commit
> > message.
> > 
> As these ports are fixed we are defining them here, I will mention this
> in the commit message. It is similar to how we added pcieport for all
> the platforms, I tried to add full topology here. And if we want to
> configure any ports like l0s entry delay, l1 entry delay etc in future
> we need these full topology to be present.

Ack

> 
> - Krishna Chaitanya.
> > > +			reg = <0x20800 0x0 0x0 0x0 0x0>;
> > > +			#address-cells = <3>;
> > > +			#size-cells = <2>;
> > > +
> > > +			device_type = "pci";
> > > +			ranges;
> > > +			bus-range = <0x3 0xff>;
> > > +		};
> > > +
> > > +		pcie@2,0 {
> > > +			reg = <0x21000 0x0 0x0 0x0 0x0>;
> > > +			#address-cells = <3>;
> > > +			#size-cells = <2>;
> > > +
> > > +			device_type = "pci";
> > > +			ranges;
> > > +			bus-range = <0x4 0xff>;
> > > +		};
> > > +
> > > +		pcie@3,0 {
> > 

-- 
With best wishes
Dmitry

