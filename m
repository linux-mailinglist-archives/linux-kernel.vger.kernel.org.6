Return-Path: <linux-kernel+bounces-201885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED648FC49E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A3C1F221A7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE02B18C322;
	Wed,  5 Jun 2024 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1REWpAQW"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE3C1922DD;
	Wed,  5 Jun 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572830; cv=none; b=PDZkb/oQGYGZ9wOnEjiGJHs+l0Z8sEXjJXuHqbiZmQ4keiJlBpOs997nEXaht7RATNfUi/BWf/NAnpBsxb1I0jk89RAKOsG05MK9qz4hArJmI52l80cJHp5nLyOfix815lM9O+DdX+ZUvA8dOd/NrL5s/7KBNfxgpI9nj2NdPVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572830; c=relaxed/simple;
	bh=mEWFdK4wEb44Lkk5CxVRECsXbd6T/yzdhjXLOv+LiiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=frHtKVAbUbkm6nu5i1xqe//oleb11ONugdqLwPh7WDTzDBAsVCyMDs+w1gNuoKdoYlI6b4gzD4Jo2uoeYRGnM2U0gJIhfbAm0S/xFRORBYWED96HSBnZrPmTpCvOMVMabVbZkYdDjUv3/u2dquCfnqGQO1uSYvkbRX/b1qSagaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1REWpAQW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4556wo3X011636;
	Wed, 5 Jun 2024 09:33:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	A92N7DPum6K04dYwwSpN0JFQag+xU5B+2EfbUCGJxNg=; b=1REWpAQWm2p2T0On
	KccqSPZclAb+9kHh80SD9w4iLaDLQ2TuUka/m0AIabxG74+gLuQDQ0OT4pGZY1sk
	L5XlRBnq52WYRNk/8eaHWpzNFlhB6hYJhDuY2OQWzx2W//u2esWmnnJJMqqsxM0b
	Ub4Bw77wb5TNg170CZY1AOErIjKgnTRS9R+x+pMiNJOB0wIpSPbX3IJyowN4uwSK
	1bYhYFiwUv6s9BML8joNzmKas+BtcSxjhWa1AZVNq+PAsSGPfX7QY36Fp5wKXLFy
	wKtCh1RnkUF1QVWeoSmjAFikzD+UcGaXcfjopxLbIAI1eQt3nd8dvYl0CkKiBycn
	R20jqw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yg7r06bm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 09:33:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9CE2540045;
	Wed,  5 Jun 2024 09:33:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D8FE2115E2;
	Wed,  5 Jun 2024 09:32:36 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 09:32:35 +0200
Message-ID: <314f1f33-7f6b-4b10-a05e-f9e0d5456e31@foss.st.com>
Date: Wed, 5 Jun 2024 09:32:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: st: enable STM32 access controller for
 RCC
To: <gabriel.fernandez@foss.st.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Maxime Ripard
	<mripard@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.or6g>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240529131310.260954-1-gabriel.fernandez@foss.st.com>
 <20240529131310.260954-4-gabriel.fernandez@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240529131310.260954-4-gabriel.fernandez@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01

Hi Gabriel

On 5/29/24 15:13, gabriel.fernandez@foss.st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> 
> Use an STM32 access controller to filter the registration of clocks.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index dcd0656d67a8..602d02efc202 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -441,6 +441,7 @@ rcc: clock-controller@44200000 {
>   				<&scmi_clk CK_SCMI_TIMG2>,
>   				<&scmi_clk CK_SCMI_PLL3>,
>   				<&clk_dsi_txbyte>;
> +				access-controllers = <&rifsc 156>;
>   		};
>   
>   		exti1: interrupt-controller@44220000 {

Applied on stm32-next.

cheers
Alex

