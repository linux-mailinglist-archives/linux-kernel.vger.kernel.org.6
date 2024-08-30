Return-Path: <linux-kernel+bounces-308863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8A9662D7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E03F1F217CF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C312F1A4AC6;
	Fri, 30 Aug 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1pFTjjXk"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A418179652;
	Fri, 30 Aug 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725024353; cv=none; b=Z4acSPAF7t+6Pc6SNaMr0zVc8MS+Yk+rT4uPbuVqDP44KLM3XdD4W47cO9BJ/cKkIskxI3/IWssbn+vBKfdgpbMkZbLQidbyW/O243lTEvNHnnVHoC5JTvfJ4b4LZKexdF5bZVRICGjMDQR3B3FedI5sENdP5AOCtoWZ0UpTJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725024353; c=relaxed/simple;
	bh=x69fBkm8eJRx5Z/+fN7J0krl+e+zIMwV7HYfJCr5IYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PM68D+RdKPSucdR8e5U4yxqaYLKuoiV/iELGxTd4xucghTo6L83j5sGTq9m5e+cbDMwzVc9xqXgYqtFs0RcMYTJOqKy4f0jMdeTn3h0XPUjG733JChs/JSn3XdpXb7GwEqqjNDuDMN3W65o2nRaN43j1pJYAadtLTakkzeQTTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1pFTjjXk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UCSfch029881;
	Fri, 30 Aug 2024 15:25:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	o8btpO/cONHa3wl5inFcEt9BpKOPAQfxu+XbhlGEgtM=; b=1pFTjjXkj2hjXyBR
	wx+fKlVjN/2TSAXHk3z4YlXRpVRgpS+2jnJ8SPBq4WbvS85xHM/hN6NFfrI2OBdm
	jkWf9L7av8Bhb7/lQNmFW98ACaGnFXKF0dc16Wv5lID35CjzQSaUH1ANU4YPcugI
	3U0NJOtkengoyb1gPPx7yMnbjF1WXM7AvM1u2TMO+zZIcF1S6F4LM3wR/HD1vRlX
	oH3J7AQelWwoKEk0tOyffzEO4BmMnDJK24AfEaonzMmkzTTZ958ies+cZWbbZ2dD
	xxHIflAb2Aoux4jLPJXRYPmIFFQA0nmtotcAP0Goyy3uFnGKYG8JFl1LOcQZKtAw
	RPR7uA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41b14tb40r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 15:25:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 243BB4002D;
	Fri, 30 Aug 2024 15:25:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F2E4C2681BF;
	Fri, 30 Aug 2024 15:24:28 +0200 (CEST)
Received: from [10.252.31.165] (10.252.31.165) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 30 Aug
 2024 15:24:28 +0200
Message-ID: <9961070c-9e8e-454d-ae85-4759da4b4e79@foss.st.com>
Date: Fri, 30 Aug 2024 15:24:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Add missing gpio options for
 sdmmc2_d47_pins_d
To: Sean Nyekjaer <sean@geanix.com>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>,
        Marcin Sloniewski
	<marcin.sloniewski@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
CC: Alexandre Torgue <alexandre.torgue@st.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240709121619.1588520-1-sean@geanix.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240709121619.1588520-1-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_08,2024-08-30_01,2024-05-17_01

Hi Sean

On 7/9/24 14:16, Sean Nyekjaer wrote:
> This enables DDR50 mode for the eMMC on Octavo OSD32MP1-RED board.
> 
> Fixes: be78ab4f632c ("ARM: dts: stm32: add initial support for stm32mp157-odyssey board")
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>   arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> index ae83e7b10232..70e132dc6147 100644
> --- a/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp15-pinctrl.dtsi
> @@ -2229,6 +2229,9 @@ pins {
>   				 <STM32_PINMUX('A', 9, AF10)>, /* SDMMC2_D5 */
>   				 <STM32_PINMUX('E', 5, AF9)>, /* SDMMC2_D6 */
>   				 <STM32_PINMUX('C', 7, AF10)>; /* SDMMC2_D7 */
> +			slew-rate = <1>;
> +			drive-push-pull;
> +			bias-pull-up;
>   		};
>   	};
>   

Applied on stm32-next.

Thanks.
Alex

