Return-Path: <linux-kernel+bounces-535845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AD6A47802
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 353693AEA52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA5225785;
	Thu, 27 Feb 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="473uiRl9"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B613A3F2;
	Thu, 27 Feb 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645589; cv=none; b=MU/9IDGT9G22KrRb3qAprJM0Bo9LmCMPbDXJ2N+XVgyIDvSiFGPKkcQH5TafIQ5Uh5oOgs0wGgbZU3KbAyZfdDQTEb7dxOa118iHUDxAucu+62ArtqtbVgMAGkVIxki3Z0jtzOxczGAY+2hPYpwmVXTPYrss7hJCLwfJks3e47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645589; c=relaxed/simple;
	bh=EP8zBcr2BvDOfGdaOTg2Ci1XdII8Fy1NWPqurrLMNQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=f66yqA3/+IwQBOhueNOq2Mbna4U3ajiWUqUtzpXigeogj71GKu8M3adAKR0KRuDap7e64zyoUawzOt/O/Yy3RBPKQxBxqsegMQuu14bmG+wVB/Taa7FEeBMoHcQ8gIeC3dkuWPdCVtQrU8kWLOBpr9bnSWjM1E0e1g1ALcLQr9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=473uiRl9; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R3i9mS022215;
	Thu, 27 Feb 2025 09:39:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	jOxsqz5lmxXPH64l2epflbTQhqz10HA2W4ktSeXgbXE=; b=473uiRl9Y1yCMnX3
	DofNQhz/bYfvPlQ3IhdHea3NbcOFdIxBmZPRVlvDKdxrqUBU6FKRhvKVKDW0OIJA
	4YAzwEHYTfZ2KXhUK1FtpKyIdXqhIlnCA2lz5seH+5Kk6e7bsZ2NV+ncYeIjph8F
	5bIytUs1ivYqZwML4rOIFTVJ+JFNoLjE09uPLTpDzUK2Y8RQPZVuTFFoNMFHVbq/
	MbX+CaODUh15mZdxLZ8cvtK5ObMiNZXmVNHfqW/8ZFw9Fm1heGoCI2dKpvjkUS12
	ddnuOTYcj69xOhOUMW2eh5gNtHeOFWlYM20e4Nb8QFOMaT9JE46TMw9tfnKlIVqs
	6aei3g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 451psrhd2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 09:39:34 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 66C5840063;
	Thu, 27 Feb 2025 09:38:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7426D37F76F;
	Thu, 27 Feb 2025 09:37:53 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 09:37:52 +0100
Message-ID: <59e547fd-8301-4757-9343-8919f5625d0e@foss.st.com>
Date: Thu, 27 Feb 2025 09:37:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: stm32: add push button to stm32f746
 Discovery board
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob
 Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250217114332.1098482-1-dario.binacchi@amarulasolutions.com>
 <20250217114332.1098482-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250217114332.1098482-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01



On 2/17/25 12:43, Dario Binacchi wrote:
> Add node for user push button.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   arch/arm/boot/dts/st/stm32f746-disco.dts | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
> index 8bdd10644bf1..b57dbdce2f40 100644
> --- a/arch/arm/boot/dts/st/stm32f746-disco.dts
> +++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
> @@ -86,6 +86,16 @@ led-usr {
>   		};
>   	};
>   
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +		button-0 {
> +			label = "User";
> +			linux,code = <KEY_HOME>;
> +			gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
>   	usbotg_hs_phy: usb-phy {
>   		#phy-cells = <0>;
>   		compatible = "usb-nop-xceiv";

Series applied on stm32-next.

thanks
Alex

