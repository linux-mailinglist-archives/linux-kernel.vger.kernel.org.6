Return-Path: <linux-kernel+bounces-201929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED718FC56B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E002B2821DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29618FDB1;
	Wed,  5 Jun 2024 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="InuT3Skt"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C0A13B5AE;
	Wed,  5 Jun 2024 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574958; cv=none; b=VGhizKr0R0sOToLKjuT1ckxiQhasaty6lqYPgi0XxM+HeNJKGWsl8mI5JpS5QhmwdQQbfeSl/qZ/hns1h1rshihfpRFefyCta4X0N24VrKoNK5l/xe3V5ilxJLp6g2L7WteGiUQuaIxta154usJC6e5pec2s+i+RAe8UXiiHHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574958; c=relaxed/simple;
	bh=2SDjKCbpQz/q/ljVsS/tdYj0W/mPevUHfWv7vea+EKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=luU4Uoc7sdcfK683g+7qgxoISEC3X8IixH3eeuzc2xYneQN5viMYhUnOzcmfQIcioPb/p1XzbFjnGBni1dITpLOKRrtm0yLTqam+HC9Fbexzb5/Nra17xfXBihf1NSgXyUrRFLXBf76ITQv4A4F5adwMYwNbu+FfAHYHjNGtw2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=InuT3Skt; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4557koNd013306;
	Wed, 5 Jun 2024 10:08:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	LeQEzYZve89QVXcn8RulqOlwly2vbEhfirVc4S0tvq0=; b=InuT3Skthn7AKw5j
	VvZORuChatpzNr2TAmakZJ5BIIINPGE1d8JIwTvaNmXtgYD/IJVia0eaG9rRw54H
	sdFTm1vyvh7/YtpfItJVGN2rlXyuAvFpqNJo2AINuuUay6YarvNqMa9K7F6hjNRS
	PXYdlAPBTeOFlmFftChE/8pSYtYodzAzrfycbK0a+ZZAsvA/UuCeF4e28cnY6ttD
	rjbo4sysR6MjH0sa5WR6fM8HBfjpKslagsHPuWjStUSECNGS8t7MOgVTkqGIWJ09
	PkMe3XLd40ur7E0q7lgOi2/FGwcMRuQdWR685bwxa262h2EyDqKXfeiBMaO7KAxk
	oPAIcA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw30fd55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 10:08:58 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 68D2940045;
	Wed,  5 Jun 2024 10:08:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CA9D7211F0C;
	Wed,  5 Jun 2024 10:08:21 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:08:21 +0200
Message-ID: <802522eb-c226-446c-b03a-ebe6f511ddcf@foss.st.com>
Date: Wed, 5 Jun 2024 10:08:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: st: add power domain on stm32mp25
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240425174519.1.I443a218decda670093bc621165e3052db14d4c02@changeid>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240425174519.1.I443a218decda670093bc621165e3052db14d4c02@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01

Hello Patrick

On 4/25/24 17:45, Patrick Delaunay wrote:
> Add power domains on STM32MP25x SoC for supported low power modes:
> - CPU_PD0/1: domain for idle of each core Cortex A35 (CStop)
> - CLUSTER_PD: D1 domain with Stop1 and LP-Stop1 modes support when
>    the Cortex A35 cluster and each device assigned to CPU1=CA35
>    are deactivated
> - RET_PD: D1 domain retention (VDDCore is reduced) to support
>            the LPLV-Stop1 mode
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 

Applied on stm32-next.

Thanks!!
Alex


>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 16 ++++++++++++++++
>   arch/arm64/boot/dts/st/stm32mp253.dtsi |  9 +++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index af1444bf9442..4beb0a0bef4f 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -18,6 +18,8 @@ cpu0: cpu@0 {
>   			device_type = "cpu";
>   			reg = <0>;
>   			enable-method = "psci";
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
>   		};
>   	};
>   
> @@ -104,6 +106,20 @@ intc: interrupt-controller@4ac00000 {
>   	psci {
>   		compatible = "arm,psci-1.0";
>   		method = "smc";
> +
> +		CPU_PD0: power-domain-cpu0 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +		};
> +
> +		CLUSTER_PD: power-domain-cluster {
> +			#power-domain-cells = <0>;
> +			power-domains = <&RET_PD>;
> +		};
> +
> +		RET_PD: power-domain-retention {
> +			#power-domain-cells = <0>;
> +		};
>   	};
>   
>   	timer {
> diff --git a/arch/arm64/boot/dts/st/stm32mp253.dtsi b/arch/arm64/boot/dts/st/stm32mp253.dtsi
> index af48e82efe8a..79c02ef2e51e 100644
> --- a/arch/arm64/boot/dts/st/stm32mp253.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp253.dtsi
> @@ -12,6 +12,8 @@ cpu1: cpu@1 {
>   			device_type = "cpu";
>   			reg = <1>;
>   			enable-method = "psci";
> +			power-domains = <&CPU_PD1>;
> +			power-domain-names = "psci";
>   		};
>   	};
>   
> @@ -20,4 +22,11 @@ arm-pmu {
>   			     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-affinity = <&cpu0>, <&cpu1>;
>   	};
> +
> +	psci {
> +		CPU_PD1: power-domain-cpu1 {
> +			#power-domain-cells = <0>;
> +			power-domains = <&CLUSTER_PD>;
> +		};
> +	};
>   };

