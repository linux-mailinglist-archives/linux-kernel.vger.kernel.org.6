Return-Path: <linux-kernel+bounces-554297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5CCA595EB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970A77A635B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEE22A4DC;
	Mon, 10 Mar 2025 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="2Hw0ok2x"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF0022A1CD;
	Mon, 10 Mar 2025 13:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612485; cv=none; b=DLvXT68I6CJ8DnL0oyv5GMnBEJ7VL0KifKR+5aHvBxLQkekhmDJjuSNbL3ci+QiIkxdM6jjgVbTvtWjzy5K02nTz/y4dajBL8RsdwYe/TTEQg+Wi4bGtZJsZQUkrZwQZh1BYfGkMgOrjKRCCEFsFCNMQ3a1BKUlqw3+a7KKawUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612485; c=relaxed/simple;
	bh=4n2/9w6j4P6KRECJWNAZngYMXcrS/ecwUcklAwlDgXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RAApUq1PH3oBkqulQE1Waz4wDSvY24fQ1naOSbqsklHkIuLheBpsclSGfI8jh5sYySzCRvPRuZI+RQkbs3PzWaiI9QSwRQNjvpfVGhVnyNLEqE46yigh3vu6K8eZNfONLUK6IwjXEj8f8kwxQOiX84RBkkoCuQCpYk6KpNGZf7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=2Hw0ok2x; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52ACqr1I032195;
	Mon, 10 Mar 2025 14:14:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	YEH/1gxIk510Nqct1xMg/A/MiupcMO3/eGizj/qCq8U=; b=2Hw0ok2xiRUCGTVk
	3ZLzBswqFGoVzIwoLTz4mfpwk/vpdLN7K7hD1r33l0Fu7Mr04uYvZ3HGyg5FiBM0
	xrwR8Tp4azVEURP8wcUx3OJ6SidBq7AogkO9S87iBWOAbEArTrh5OwOVPvl/c5uY
	iJUFgUzp0M7hP6CODjA6FQ8YRVZheRDeH4QCdzs27WnS6kegJxoxIwJ5oYTsJ13l
	shZ7Wur3nkVRlgG4YD5UVWyhx44H/cM/0lCGY1CfBhxYs9DJ8pjUMIbUfLnmiNB3
	8JAzYib25h6ddPT5Tm2wqNj5OytbPCgjV6JwbD64ypwBz2VGTAIkodYk8IT3H1T4
	gTp55g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 458f573me0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 14:14:28 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2F7394005E;
	Mon, 10 Mar 2025 14:13:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9E8B4DD53D;
	Mon, 10 Mar 2025 14:12:22 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 14:12:22 +0100
Message-ID: <37d0b2f0-05c9-4e52-9fa9-d73ed0c56ec0@foss.st.com>
Date: Mon, 10 Mar 2025 14:12:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: stm32: use IRQ_TYPE_EDGE_FALLING on
 stm32mp157c-dk2
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-amarula@amarulasolutions.com>,
        Antonio Borneo
	<antonio.borneo@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250310122402.8795-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250310122402.8795-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_05,2025-03-07_03,2024-11-22_01

Hi Dario

On 3/10/25 13:23, Dario Binacchi wrote:
> Replace the number 2 with the appropriate numerical constant defined in
> dt-bindings/interrupt-controller/irq.h.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reviewed-by: Antonio Borneo <antonio.borneo@foss.st.com>
> 
> ---
> 
> Changes in v2:
> - Drop inclusion of dt-bindings/interrupt-controller/irq.h header
> - Add Reviewed-by tag of Antonio Borneo
> 
>   arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> index 5f9c0160a9c4..324f7bb988d1 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> +++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
> @@ -67,7 +67,7 @@ &i2c1 {
>   	touchscreen@38 {
>   		compatible = "focaltech,ft6236";
>   		reg = <0x38>;
> -		interrupts = <2 2>;
> +		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>   		interrupt-parent = <&gpiof>;
>   		touchscreen-size-x = <480>;
>   		touchscreen-size-y = <800>;

Applied on stm32-next.

Thanks
Alex

