Return-Path: <linux-kernel+bounces-202037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98528FC6F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E8A285920
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF0714B951;
	Wed,  5 Jun 2024 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BgdN7/82"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2C1946AC;
	Wed,  5 Jun 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577449; cv=none; b=AkTxI01uy4jQ3wWmmJhlAxKBesQS8dlgk4X190mhcpwrmDaIPeB25IPfkH6ilZFXAhaJpiYFIPKtdBVF6NGNS4rkQ4w18yHAZ9lYilrQDEfG2njaK5HiJf5TEBoEA9NXDVocDH1apdMKEgtaOSb0HLCmZXckWoNg+/WE+I3Vm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577449; c=relaxed/simple;
	bh=JPE4/7f61jruBnArBEjTgBBzSP7uina+qcI0jhiCx9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eJkLC/zQqKRmRS/1fZygjZLr5HUklfb1+sDhKY4awe8Opisjk7MyewMqjfYdfYKOTYd+xEUNLaDD1XVnxjPxD1VMLSzsvoy+rxq/LYP9gdOuIURKmEi9G8WlBvwkM9SWvo+0unlGuxIF+W+2nTnkyfSGe5WHXXpR4/XatR+jSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BgdN7/82; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4557rDAR017301;
	Wed, 5 Jun 2024 10:50:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	jX/ATTnGRAwHGTqSBdn8p4eXl6DWL+zybXP+Kahe5Rc=; b=BgdN7/82YOfncs/U
	Igkv2WoltsN7RgsiOTIiVU/57H4LA933/tELDUGOmHyq1b1UjdLro/Kw8ORnzGSm
	mYQ8EMqu+vTTLLdjWDvOvUc38wHSKhuq8nXIEuVLDqfG278ARYeAW5TJ3hN9lFWa
	FbrP7x1BgXg6TLa8A4dzCaEL5QW2FiTFFVXtlbnjr+3Pk9M9bnw60yY966oO8zMo
	KJaoqnumCKnkuO8B8p7baLM7m5k+yc+RDdfKwTRstbtxsTVUdKVR0zfbfUtB9b1q
	tqSQYKyXSqrNaRBmVRMuDB0DDvNtiu2a2dqntkirTOVzknqfiNfJ72yUtqzWhLFC
	rFWZUA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw91fy1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 10:50:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5A90B4004A;
	Wed,  5 Jun 2024 10:50:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0CB92132DE;
	Wed,  5 Jun 2024 10:49:26 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:49:26 +0200
Message-ID: <a217b253-81c6-48d1-966e-f78943700d04@foss.st.com>
Date: Wed, 5 Jun 2024 10:49:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: stm32: osd32: move pwr_regulators to common
To: Sean Nyekjaer <sean@geanix.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240522082332.2471337-1-sean@geanix.com>
 <20240522082332.2471337-2-sean@geanix.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240522082332.2471337-2-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01

Hi Sean

On 5/22/24 10:23, Sean Nyekjaer wrote:
> According to the OSD32MP1 Power System overview[1] pwr_regulators;
> vdd-supply and vdd_3v3_usbfs-supply are hard-wired internally in
> the SIP module to vdd and ldo4.
> 
> [1]:
> https://octavosystems.com/app_notes/osd32mp1-power-system-overview/#connections
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---

Both patches applied on stm32-next.

Regards
Alex

>   arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts | 5 -----
>   arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi     | 5 -----
>   arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi       | 5 +++++
>   3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
> index 854dfecd801f..36e6055b5665 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-osd32mp1-red.dts
> @@ -147,11 +147,6 @@ &m_can1 {
>   	status = "okay";
>   };
>   
> -&pwr_regulators {
> -	vdd-supply = <&vdd>;
> -	vdd_3v3_usbfs-supply = <&vdd_usb>;
> -};
> -
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
> index aa28043c30fb..c87fd96cbd91 100644
> --- a/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15xc-lxa-tac.dtsi
> @@ -379,11 +379,6 @@ regulators {
>   	};
>   };
>   
> -&pwr_regulators {
> -	vdd-supply = <&vdd>;
> -	vdd_3v3_usbfs-supply = <&vdd_usb>;
> -};
> -
>   &rtc {
>   	status = "okay";
>   };
> diff --git a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
> index ae01e7a5339e..2022a1fa31ca 100644
> --- a/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15xx-osd32.dtsi
> @@ -215,6 +215,11 @@ &rng1 {
>   	status = "okay";
>   };
>   
> +&pwr_regulators {
> +	vdd-supply = <&vdd>;
> +	vdd_3v3_usbfs-supply = <&vdd_usb>;
> +};
> +
>   &usbphyc_port0 {
>   	phy-supply = <&vdd_usb>;
>   };

