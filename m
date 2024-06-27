Return-Path: <linux-kernel+bounces-232026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C438391A1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B93E1F21B08
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7580C12DDA2;
	Thu, 27 Jun 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="uBm3J+/H"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63D770F9;
	Thu, 27 Jun 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477859; cv=none; b=Pbze438fJAbzoc4CIwhsriparBuy9QTW0ZjhRYnENAZNJvhist0jUKEjl6eKqONt9ozddSTffctOGuCI9JiDB/GEAii1OKUAE+MK6p6b5jRTdBncn0H+VvOefLnEDsLXPAULM0AC+7bU1hb6SJlgcW+i52EF+NnepmVA5LHVStI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477859; c=relaxed/simple;
	bh=dumyCkcsofHuL88k0WRJagi7o1SjCH55NxqoXi7s4bU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sm5x0NY247adztfpj0YDy+kGefJzlcoomruA6Fya7VNH2QyeKLg16sk9zR9PR3WruHysPit39EOdhngSqKErZmG/drwO9+NaNV5XwdtfaIlThLt/mEf020fHwRaP8wohQMEQ/N3gmLNDyg+tq8fSmgsZSN2mZm6wUPEsvxbyP8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=uBm3J+/H; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7QdQP008977;
	Thu, 27 Jun 2024 10:42:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	kWxMJjKQM9I6Gk9ILBK+IGxxgn6IDXY2t3G/9batKYk=; b=uBm3J+/HsagIqUij
	mYXqPezyGW/pwVbf8EHD+x3+tUioHMlmxLg/Am4sFCNvYFlELjaL6tGxx4T9hI+o
	A2o73J5bs059opaORlp9Nep1YjOZyPL2VHykCSVlZ4zaBqQlZblz6hmA+QfFNgoE
	WUYTJMzIml1GIVBW15rH+rnvR4gV3khZk0cEO7Jbpw7lbqUc0AfU91c/S55kN20I
	lajWLScaOJFd+wcL2F+YfJfYEzkjfSjZ8sqd/vWiLdiOlpMdpeVCOb5E1EBHLDzd
	UXktShujpWu3dqpRvpNygata02vwY268mc3jfDoDb0OKTEtS+FQck7/LYpT1/eGt
	Rlbm6g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yx860tab6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 10:42:54 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E014440047;
	Thu, 27 Jun 2024 10:42:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 94E772128B2;
	Thu, 27 Jun 2024 10:42:50 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 27 Jun
 2024 10:42:50 +0200
Message-ID: <1ebf1150-e2de-40f9-866f-b08d13a231e9@foss.st.com>
Date: Thu, 27 Jun 2024 10:42:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: dts: Missing clocks for stm32f429's syscfg.
To: Yanjun Yang <yangyj.ee@gmail.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
References: <20240614010012.25443-1-yangyj.ee@gmail.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240614010012.25443-1-yangyj.ee@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_04,2024-06-25_01,2024-05-17_01

hi

On 6/14/24 03:00, Yanjun Yang wrote:
> Without clock definition, SYSCFG will not work, EXTI interrupt for
> port other than GPIOA will fail to operate.
> 
> Signed-off-by: Yanjun Yang <yangyj.ee@gmail.com>
> ---
>   arch/arm/boot/dts/st/stm32f429.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32f429.dtsi b/arch/arm/boot/dts/st/stm32f429.dtsi
> index 8efcda9ef8ae..ad91b74ddd0d 100644
> --- a/arch/arm/boot/dts/st/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/st/stm32f429.dtsi
> @@ -579,6 +579,7 @@ spi4: spi@40013400 {
>   		syscfg: syscon@40013800 {
>   			compatible = "st,stm32-syscfg", "syscon";
>   			reg = <0x40013800 0x400>;
> +			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SYSCFG)>;
>   		};
>   
>   		exti: interrupt-controller@40013c00 {

Applied on stm32-next.

Thanks
Alex

