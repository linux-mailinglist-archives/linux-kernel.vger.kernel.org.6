Return-Path: <linux-kernel+bounces-202002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 753EE8FC666
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED67F284B4B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1DC190055;
	Wed,  5 Jun 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Bj/1vgdQ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DF14A0A2;
	Wed,  5 Jun 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576067; cv=none; b=uy2tDAZHL5mGtYIwIT7lOKaMSTw8kDUbf5ENv7BiMbeJvBMDIlDy3NDQbgcA/dYDWEiJiaGSghZIwApvkLhCVaRKisXCflj+sVwaRqVS5U8Vnt0f9d8u5yhWGfPYJyCek2XOwPBZ7C9ztynEM/XRkQusbV6dCIHAEmxzyB8ZC70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576067; c=relaxed/simple;
	bh=v6vKcNrwlF1YV5oPQIVqsaK1xL/La3UrIoMqlx9UA2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uNkFk+BbOQxeDj3RY0CcYxhTqNOGFcxhMcYLHuZi2SZvU+9uVPSMEyWxf5pgjDnGTPmC5UlmWZVYM4KSvTNbnoWuWAvpvt3ljfkky6aDwkJnN5t4UP8kIu4vDWjYGG0KOxWD5Pdn5BgeslRJXSlp5fZB2FHCkIaw3Wzl00JuRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Bj/1vgdQ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4558AUSB012942;
	Wed, 5 Jun 2024 10:27:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1tY7P/7RLXmlasenVSZvjVXgDBbBIxSy111uUswvdmA=; b=Bj/1vgdQz0x0AJWX
	9ET8IcnyqkiEFC0nAD6DUV40UHzo/ClPSg/QiGrBZJxs6Ww3lXdDPSgXol3s+mCa
	wdZYHBhxHDMahDbZCx18I4ID5YrF8xiwfCsZEgUKfS1qc2RdyiZx0xeJ1hiogsaL
	tvArWnVKiaNvJa/b8/CnjcacMB90pMA2OfO17UxtdBE8opU/LEFb+3k0SKqdUHe7
	hntN/+gzutziLa2iDFkxRNJ1p/E2YUt6omTHS8ziMfTH/yvwXwNO2E0c4WOabXwc
	qfHLQ9bRToMDE6iD7zJXNUuCQGJ5Okj8kb45JdqbFn9JsJMCDsbc/HDSpnuDQ5Kr
	81AyhQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw3wqswh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 10:27:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2BC5840044;
	Wed,  5 Jun 2024 10:27:21 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A73A3212FC1;
	Wed,  5 Jun 2024 10:26:46 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:26:46 +0200
Message-ID: <3a29de9d-183a-4aac-a8da-f380d6e13c97@foss.st.com>
Date: Wed, 5 Jun 2024 10:26:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: dts: stm32: enable camera on stm32mp135f-dk
To: Alain Volmat <alain.volmat@foss.st.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240426150526.3094607-1-alain.volmat@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240426150526.3094607-1-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01

Hi Alain

On 4/26/24 17:05, Alain Volmat wrote:
> This serie enable the camera on the stm32mp135f-dk board.
> It adds pinctrl configuration for dcmipp parallel input and add
> gc2145/st-mipid02/dcmipp nodes within stm32mp135f-dk.dts
> 
> Alain Volmat (2):
>    ARM: dts: stm32: add DCMIPP pinctrl on STM32MP13x SoC family
>    ARM: dts: stm32: enable camera support on stm32mp135f-dk board
> 
>   arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 33 ++++++++
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts     | 87 +++++++++++++++++++++
>   2 files changed, 120 insertions(+)
> 

Series applied on stm32-next.

Thanks
Alex

