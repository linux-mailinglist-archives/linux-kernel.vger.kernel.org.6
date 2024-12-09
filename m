Return-Path: <linux-kernel+bounces-437993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90B59E9B60
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE78281EDE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CEA13C82E;
	Mon,  9 Dec 2024 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xr4n+JNi"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B67F48C;
	Mon,  9 Dec 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761036; cv=none; b=izIXub503zwfiKk9Doxu6EcOrUOvA0lya5hrcAyUz/lkplenexHcVQGj1GwtXYq5DRLf8YjL5Wtu9lBx625aJtpBNo1hXk0LzBLiN7vJqNetY0UJARH+TdYxv7zDKlIfeoWLnyX/0M8npiYMABpOLCm/iN0o1Q9vODT33GD6gAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761036; c=relaxed/simple;
	bh=lFOTcE1CXCv0NBUJob/AgpYVHemXHsRJM7dLM1lwgOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RX1RZaGj1xbJT5xJEC5lpPr9qcpasd5k3F0e7gHDl3VFgWUv3/eWzziZKrit+TunI8ETz1UoXpr1tfc4S+mdwSWOtBIUSZC2HsfMP6wwOwlr617emW8mnVCpGr6+bfJ8pNnrQsMrvFSqJdP249o9ajYxQBKMmXAtU0bG62sdRoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xr4n+JNi; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9B54vn012403;
	Mon, 9 Dec 2024 17:17:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Zaqz0lhJMujS9j5Ch3cOtvcUwmJM6m8N0ZjnzaY3Af0=; b=xr4n+JNikDGiVuk8
	R5baLlxHgD4CukoiD8zyKybdkZXIAjqWZhx0JpTL7PNQ0DQVtSVCy5Nrr7Vo0Yx3
	CBi+afzmczrMZmnmdx2chVDKFID8VHRAxAYs/a2wTZGw84pWPex4BalmqURmIOrn
	nxgvweLMQ9ggqvG/Xfn3jhn/HCeTD2gL4Yd+Ht0luEO3hng8xdTfSCv1xcH+EcTW
	7Q+e8CEJvWzfYGme0gb8wYeMs30uY0u4J2FbkSJwbl9vmJB6SZp5nufXM6r08hRS
	lMt2j3l77cFLQw9hXwjlJw2srbZRcPXFWyiXMNLQowqn0rluVF2CGXT1Hp0g6Ljc
	/b1evg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccc8rrhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 17:17:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0A31840062;
	Mon,  9 Dec 2024 17:16:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1DC68294C05;
	Mon,  9 Dec 2024 17:15:22 +0100 (CET)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 9 Dec
 2024 17:15:21 +0100
Message-ID: <543e0df6-5719-41b7-a986-724f6fe6557d@foss.st.com>
Date: Mon, 9 Dec 2024 17:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: st: add sai support on stm32mp251
To: Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241113092047.2359487-1-olivier.moysan@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20241113092047.2359487-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Hi Olivier

On 11/13/24 10:20, Olivier Moysan wrote:
> Add SAI support to STM32MP25 SoC family.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>   arch/arm64/boot/dts/st/stm32mp251.dtsi | 136 +++++++++++++++++++++++++
>   1 file changed, 136 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> index 6fe12e3bd7dd..e9db486b988a 100644
> --- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
> +++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
> @@ -484,6 +484,108 @@ spi5: spi@40280000 {
>   				status = "disabled";
>   			};


Applied on stm32-next.

Cheers!
Alex

