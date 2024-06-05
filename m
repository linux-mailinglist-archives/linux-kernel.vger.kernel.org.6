Return-Path: <linux-kernel+bounces-201848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F32AB8FC438
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC5A2865EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06C918C336;
	Wed,  5 Jun 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DnjKjRhK"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F82190473;
	Wed,  5 Jun 2024 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571638; cv=none; b=GYSqeur23ZDdwGUgcsTl4rD4qgn+0DZQKvWlm6Vk6CUCHPrYeUQUPO7inVBdPuV3dLUmAWkaBPInZZg12VRT1e45bvB0p93NrED5izkItpkpKaibVryfsG3TIJnRU04yRks7s2F0+0rr8WJBQVMvmRIekkqaGZG/65eds72iqZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571638; c=relaxed/simple;
	bh=xv2yHse5wYiCIpS1QkXIwSPeek7ooAsMqrgbwuNRmZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Fds2i+IpkGoWsVLnmtIQVBngRc2AejHsAcMTXJ4EWLO6j1zK896/N/0K7nTKDUtf3rfOxNe8jNQ+wVhPOhKj/dCoMOwaAywoiAX0/Gg83o3S8u+yJsFLh55NSWPraj0IXQVtuqoelqyTIoSYCFCx9/x1lvqgZYJpScKd49LIfWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DnjKjRhK; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455035hg017301;
	Wed, 5 Jun 2024 09:13:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	8a+3EKBu55kmccJ+MjWqICbYzukEqrQwk1Qsid7INes=; b=DnjKjRhK4XY5Jp7Q
	LjfH77IPpO2PyLRg9BzacSrSlmaaQo+Hwr616ztduTZRZ3qVZcKPDzmDI0yP/6ue
	qcJ2HEbM4K0wNTPV1voTbgfWMObhqSXi73TLM0wYT8sSXeUqpm6u0gT9IvfI8Tia
	6XMXBZQ1E3SZWncK67i64R+K3IJKc2HNhlhLwWAwyBX0E9g3jaeOid2tZPKR+Pin
	Mv5pPBGoE6km0XtGBoj245PGppwyr08kiPG72ameGXCENlkmJJUaSHWiUgvEYIl5
	ssxs8QUBCY1XTU5y6hM8Lo9dEzanVSmU5eNJqGEbCsA0Oa16VnlrYE0n+MG/gh7s
	9XBitg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw91fddt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 09:13:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A1F0740045;
	Wed,  5 Jun 2024 09:13:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D2B9A210F86;
	Wed,  5 Jun 2024 09:12:49 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 09:12:49 +0200
Message-ID: <a4b8947a-f17a-4f78-bb94-a5c7b2514b24@foss.st.com>
Date: Wed, 5 Jun 2024 09:12:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: st: OP-TEE async notif on PPI 15 for
 stm32mp25
To: Pascal Paillet <p.paillet@foss.st.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240521080131.473447-1-p.paillet@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240521080131.473447-1-p.paillet@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01

Hi

On 5/21/24 10:01, Pascal Paillet wrote:
> From: Etienne Carriere <etienne.carriere@foss.st.com>
> 
> Define GIC PPI 15 (aka GIC interrupt line 31) for OP-TEE asynchronous
> notification.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> Signed-off-by: Pascal Paillet <p.paillet@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 4 +++-
>   arch/arm64/boot/dts/st/stm32mp253.dtsi | 4 ++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 4b48e4ed2d28..d0e10dda96b6 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -51,9 +51,11 @@ clk_rcbsec: clk-rcbsec {
>   	};
>   
>   	firmware {
> -		optee {
> +		optee: optee {
>   			compatible = "linaro,optee-tz";
>   			method = "smc";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
>   		};
>   
>   		scmi {
> diff --git a/arch/arm64/boot/dts/st/stm32mp253.dtsi b/arch/arm64/boot/dts/st/stm32mp253.dtsi
> index 029f88981961..69001f924d17 100644
> --- a/arch/arm64/boot/dts/st/stm32mp253.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp253.dtsi
> @@ -28,3 +28,7 @@ timer {
>   			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
>   	};
>   };
> +
> +&optee {
> +	interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
> +};

Applied on stm32-next.

Thanks
Alex

