Return-Path: <linux-kernel+bounces-439075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EBC9EAA77
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 315C3164DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1256D22F3B9;
	Tue, 10 Dec 2024 08:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="j8KEIdAS"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980F722CBD0;
	Tue, 10 Dec 2024 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818848; cv=none; b=EP0Ak0eGENsVSHGheeDIDNFE43mmb+55ie7mjSktkRbH1Ksq+X0+62sqVtFio5FqIT+w2JDD3PgyDxsStNVk4g/MhDsI4D6jtO/WTB6j+SPCsEbwis0QhJ0AfzRGDV9lNGy8q5sEbB6hLqNDdF3GHz71Xi9796t65m0U43kkXAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818848; c=relaxed/simple;
	bh=7A8qpw/niGxVxuqiGzUQpsJr1r3C/SMr6DaHb/2kUEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IAYduxh+3pkREGRyOWzK5SN+ZPl5PY1/EPhkoVr+dWR3/00xu59LfyjpPGm6vm9uvS6doVmKDH8jzSezGA/Rv+u2QguaRfO0hvKyjqZQZQVxA6o8nchHbx5yGrmkwC3K+Hfm2GmblL5/FIeGZlqQCYLKH3nbZjRAymu4gNYtf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=j8KEIdAS; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA1j9qH011970;
	Tue, 10 Dec 2024 09:20:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	07Fd8DkwCPGnXqaDXNFNioTlMvSHdNYm3+AlnpXUsyU=; b=j8KEIdASWSUHpF4z
	jd0uFUpTuHZ18OSkyat11UB6tfPsMrMuYGGVefLXkbjNPdkOJlaLHNaADNpHHZrV
	PT/H2yE7F+qOO8HfMwMb9mc/miQ/CyoqqrkBTxZPNnqxzRHLlRjCgyrbxRwofIc+
	UFAFGkhxXdBKslAFP3OwbefvLfZ+sq/7kE38n4D/iY0v7Ye9P7RvhlLPBUXWBE72
	aoh80H6uULVoUf8MARzXouXotk6os6qnU6YlxQ1CFaP+oJUYHJ5lafrfycCxYZii
	ejodAnpCvshi4bjjrYW817twNqgzU29y/nxCSLdlXqLc4vswmScUScL9P/bXjTi1
	4tCzxg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43e2w9jwp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 09:20:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6214E40044;
	Tue, 10 Dec 2024 09:18:52 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 953E422AA44;
	Tue, 10 Dec 2024 09:16:00 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 10 Dec
 2024 09:16:00 +0100
Message-ID: <ce05c6db-7baa-4268-96c5-fbefeee2e77f@foss.st.com>
Date: Tue, 10 Dec 2024 09:15:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Fix IPCC EXTI declaration on stm32mp151
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Fabien
 Dessenne <fabien.dessenne@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241206171759.135342-1-arnaud.pouliquen@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241206171759.135342-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Arnaud

On 12/6/24 18:17, Arnaud Pouliquen wrote:
> The GIC IRQ type used for IPCC RX should be IRQ_TYPE_LEVEL_HIGH.
> Replacing the interrupt with the EXTI event changes the type to
> the numeric value 1, meaning IRQ_TYPE_EDGE_RISING.
> 
> The issue is that EXTI event 61 is a direct event.The IRQ type of
> direct events is not used by EXTI and is propagated to the parent
> IRQ controller of EXTI, the GIC.
> 
> Align the IRQ type to the value expected by the GIC by replacing
> the second parameter "1" with IRQ_TYPE_LEVEL_HIGH.
> 
> Fixes: 7d9802bb0e34 ("ARM: dts: stm32: remove the IPCC "wakeup" IRQ on stm32mp151")
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>   arch/arm/boot/dts/st/stm32mp151.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp151.dtsi b/arch/arm/boot/dts/st/stm32mp151.dtsi
> index b28dc90926bd..e7e3ce8066ec 100644
> --- a/arch/arm/boot/dts/st/stm32mp151.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp151.dtsi
> @@ -129,7 +129,7 @@ ipcc: mailbox@4c001000 {
>   			reg = <0x4c001000 0x400>;
>   			st,proc-id = <0>;
>   			interrupts-extended =
> -				<&exti 61 1>,
> +				<&exti 61 IRQ_TYPE_LEVEL_HIGH>,
>   				<&intc GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
>   			interrupt-names = "rx", "tx";
>   			clocks = <&rcc IPCC>;

Applied on stm32-next.

Alex

