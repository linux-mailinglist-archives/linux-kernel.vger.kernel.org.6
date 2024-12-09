Return-Path: <linux-kernel+bounces-438005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FED9E9B83
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914AD281776
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33821448E3;
	Mon,  9 Dec 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RCt5nFu6"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B585835954;
	Mon,  9 Dec 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761458; cv=none; b=EIplhfLd6UPYQy9jDfljBy+m4afua287zruzqsmBil5Pj+cIlx56/hB+AMuW3qRfMXvMAJ/9GI0HJ2VhiuHrKQUNLATkD/5b7R1hk4qWCekVUvDCyd4qdwZoPzLNBKsKfr2fTG0CzuIDFTcNOBFzGmQG9u8QRrsI4AFDeqMWYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761458; c=relaxed/simple;
	bh=FKT3VRsF9qMgFk9lyPSvXb+1Mpy6B4jsJEIPt6dh+84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TmuOEzGxs8B+ZxWj1R3E+LAL73CodXAfZPPJ6OSsNBoOLJTL+SKniv5kkQSBNXq2yLhNIOjTn1gUv5Tl2k/xsJ4BxJIQgSOohcJBBuQ3g/aOj9YzHBJqw+r9ZbXLsyMFBpNPetbgyzqG+nJOUb6wVU3aVA8ItHCPTcQv5mP92+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RCt5nFu6; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9F6MjX011896;
	Mon, 9 Dec 2024 17:24:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	tLYbGt0hoBREp9nuzUjHJqQgP5LBORvzofcGEX3ZeW4=; b=RCt5nFu61IbB9R+d
	uSSmR4Lb9COdG6D0DuY8PbS1DKv6DfZhdFesrw8Yyt1lt9zY5WPXoGr7hPQN5lNz
	ul1540+f92YjOoVCBGPxZ+cR/eNpefCmy7v67QEoF4DPLUXYHPtKgrN+atv7SO3s
	Z3DBU3X2ULqlPZ3a05HVH1MmtNqrpDKX2lymoTyffpSmk5TDbKFIww5EpPGCy8+J
	TncOXwxMgDHbNUbm1JaXKgIYfHIijKlsw57WBW/c/TCzPutCIwc8AYdrnQMmFM/J
	J0TkYZm6F6v6XHhnC+jedlzietvQyFSeBitLPXMa+oEX/5VoE2iFUQXHcPxiCmvj
	9xyeWA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43e2w9ga1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:24:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A94FF4005D;
	Mon,  9 Dec 2024 17:23:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70EC72A278D;
	Mon,  9 Dec 2024 17:18:23 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 17:18:22 +0100
Message-ID: <4075e04d-dab3-40f2-9a64-760081cf47ee@foss.st.com>
Date: Mon, 9 Dec 2024 17:18:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: st: add spdifrx support on stm32mp251
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241105162141.712073-1-olivier.moysan@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241105162141.712073-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Oliver

On 11/5/24 17:21, Olivier Moysan wrote:
> Add S/PDIFRX support to STM32MP25 SoC family.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 6fe12e3bd7dd..34970be2e0b3 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -267,6 +267,20 @@ spi3: spi@400c0000 {
>   				status = "disabled";
>   			};
>   
> +			spdifrx: audio-controller@400d0000 {
> +				compatible = "st,stm32h7-spdifrx";
> +				#sound-dai-cells = <0>;
> +				reg = <0x400d0000 0x400>;
> +				clocks = <&rcc CK_KER_SPDIFRX>;
> +				clock-names = "kclk";
> +				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> +				dmas = <&hpdma 71 0x43 0x212>,
> +				       <&hpdma 72 0x43 0x212>;
> +				dma-names = "rx", "rx-ctrl";
> +				access-controllers = <&rifsc 30>;
> +				status = "disabled";
> +			};
> +
>   			usart2: serial@400e0000 {
>   				compatible = "st,stm32h7-uart";
>   				reg = <0x400e0000 0x400>;

Applied on stm32-next.

Thanks!!
Alex

