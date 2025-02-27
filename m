Return-Path: <linux-kernel+bounces-535847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03254A47809
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B2B188750B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A922227563;
	Thu, 27 Feb 2025 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xdkbs63L"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A910A22578D;
	Thu, 27 Feb 2025 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645626; cv=none; b=RWXtHlEG9k3+RJdGKMBrxE/+mQEpXm6JY++nFWnAcEUjm1eqy1KVVV9eY5GTvgHX32pQpTol1i1LcDdIBGkJuX09f1gTSDw6aeMg4nMVcdxhprVY2EPCK+lhn0K1SrIzcpxEn8fUERkW48jATEvykjkgWl9SJkZpQGhm+Mj4fBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645626; c=relaxed/simple;
	bh=O8K4ObB9GqDeU/XSMeATzwNYULYb7ijIsjkPWPX75a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AgED98WStOPr45wpfBrl9IVaaN+M3VUahUCRseAHQ2qp+PTQxSWnTMB6d4susVoGaXbZufabvcxA+tAstd6ThBnIOMPppqHPLGae+lCSfx7wmMj3ALy+m6Xo4mWPbh4X7nhOjJTGuk9HVyXQI3Su2vZn3dfnV4Y2/bjyNO3JpUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xdkbs63L; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R53Rw5015424;
	Thu, 27 Feb 2025 09:40:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	s/BrDT6HDNlhYIGawveZn0l9RzyImOeLlokPy7GIcsk=; b=xdkbs63L8r9z0AqE
	J4UQC6e18L4aiHVcmWoO3+lareNu5cZoaFGEGXAah1u0BJATczOMLc/ShqGg01zq
	W7frUBh2zrelobq2bNiGwlmbSlNuB1xnn1BZ565h+Qau/JKv6L6PS3oV0xzNyKnB
	bj8xRRWxdVwTil/6zHhvcpXcKeCvF4JldJDuTVDUWHRGgBzqMLlkxI6wcG+5ZrMS
	cDjHZ4FKBt8cYGY3qXPEaSnKfA4z9k5VUM9BDlLAPM0RR+vr1C5HjqXvKhknyxM7
	Olw6W9SJA8716YWaX2Wf3Lxrtle5Ric+C9a3cX3Rms+hNOg4PeOoy5lQCAZpYCnu
	hsvJ0w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 451psuh1he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 09:40:12 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1E65D40050;
	Thu, 27 Feb 2025 09:39:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 15873381A90;
	Thu, 27 Feb 2025 09:38:29 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 09:38:28 +0100
Message-ID: <ea295010-136c-419a-80ff-3cdd0701fbd8@foss.st.com>
Date: Thu, 27 Feb 2025 09:38:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: stm32: add usr3 LED node to stm32f769-disco
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
References: <20250217114513.1098844-1-dario.binacchi@amarulasolutions.com>
 <20250217114513.1098844-2-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250217114513.1098844-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_04,2025-02-26_01,2024-11-22_01



On 2/17/25 12:45, Dario Binacchi wrote:
> As indicated by the board silkscreen, there are three user LEDs.
> Add the missing one.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   arch/arm/boot/dts/st/stm32f769-disco.dts | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
> index d52e36aedcfb..535cfdc4681c 100644
> --- a/arch/arm/boot/dts/st/stm32f769-disco.dts
> +++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
> @@ -86,6 +86,9 @@ led-usr2 {
>   		led-usr1 {
>   			gpios = <&gpioj 13 GPIO_ACTIVE_HIGH>;
>   		};
> +		led-usr3 {
> +			gpios = <&gpioa 12 GPIO_ACTIVE_HIGH>;
> +		};
>   	};
>   
>   	gpio-keys {

Series applied on stm32-next.

Thanks
Alex

