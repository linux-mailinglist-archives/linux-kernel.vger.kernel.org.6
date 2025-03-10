Return-Path: <linux-kernel+bounces-554027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD536A591F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A15D7A40B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B265522A7E1;
	Mon, 10 Mar 2025 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ko9A3bkK"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C345227B83;
	Mon, 10 Mar 2025 10:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603851; cv=none; b=aoA8xJ1sdMdaYyxmiUo8BvMzBuTZDKJA9Tyy4uYf2ZrU0fcyhQGhibSCxknQzGzGAoPOKl0RpL3bDqRNSU4jee1LIXYca2nD3IAGOfOhSFrw1amq7h9ZkzbSPrn0JGnmowcBTbSe4iQkSA1Utscbbp4cP8ESjs7lL7CZ5usoyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603851; c=relaxed/simple;
	bh=a4LHUipB9qkEfTODFAbdGuOOi65tkmIXS/JoJ86bPFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E+N3Fwl+4UR9iVO9SEQb3vNzRgv0QslDix+0nQOnLHWSvibmWsHwA4oqQhDukjL90CL6LYVu5Z0YDiiGjRvw0D4G5ZQS4srPs/BGdz3kSloBzDn2u2cKG4dw2BUNPMP1jcldfPxe1LLLRTa5UThyA5ZLzYLgDWd5Cr2MHhd09FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ko9A3bkK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52A9G8gL017253;
	Mon, 10 Mar 2025 11:50:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dfbmKwc6v1yeOOE9JCszYxgrUac0n2yNInRPRE4qjhw=; b=ko9A3bkKtA24VlrH
	kBrInCzGMbc4p6W9TWc+ruaxkYw5Q7OnYOa2X466UnvXzzEbUPIMegQiHSRnwBgd
	8F3W5l9bE3VuWTdsPcZcZOPwOjZ6xaAHaqIZ9MrmyYSMN7tgU6/EjQr6/0O/Pd+K
	PbDr1N0RlYzTry9IXisVbuJ0gCRUbazozF3tUv3CEijRX4zS7TWdwwNIc627QMBF
	yn/bwId8jPVcoOiypBuE7hE16cVmRkgC5r7IB/4KsjbRIr5K8YS6VlmDBBWIZhyo
	gv7IP6y4rZgm/ifysDFv493rnbw6a48ISxAfEruYHXnugrCDBnyoBZvMzploIIHN
	W574Xg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4590b8v7t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 11:50:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9377640057;
	Mon, 10 Mar 2025 11:49:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 543A54235AC;
	Mon, 10 Mar 2025 11:48:37 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 11:48:36 +0100
Message-ID: <e5a5dd9b-475b-4c66-a580-08f11a80e5a3@foss.st.com>
Date: Mon, 10 Mar 2025 11:48:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: use IRQ_TYPE_EDGE_FALLING on
 stm32mp157c-dk2
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-amarula@amarulasolutions.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250301115116.2862353-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250301115116.2862353-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_04,2025-03-07_03,2024-11-22_01

Hi Dario

On 3/1/25 12:51, Dario Binacchi wrote:
> Replace the number 2 with the appropriate numerical constant defined in
> dt-bindings/interrupt-controller/irq.h.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 
> ---
> 
>   arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> index 5f9c0160a9c4..dcf17c493022 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> @@ -11,6 +11,7 @@
>   #include "stm32mp15-pinctrl.dtsi"
>   #include "stm32mp15xxac-pinctrl.dtsi"
>   #include "stm32mp15xx-dkx.dtsi"
> +#include <dt-bindings/interrupt-controller/irq.h>

really needed ? as it comes also with 
dt-bindings/interrupt-controller/arm-gic.h

>   / {
>   	model = "STMicroelectronics STM32MP157C-DK2 Discovery Board";
> @@ -67,7 +68,7 @@ &i2c1 {
>   	touchscreen@38 {
>   		compatible = "focaltech,ft6236";
>   		reg = <0x38>;
> -		interrupts = <2 2>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>   		interrupt-parent = <&gpiof>;
>   		touchscreen-size-x = <480>;
>   		touchscreen-size-y = <800>;

