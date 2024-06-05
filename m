Return-Path: <linux-kernel+bounces-202022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3CF8FC6B4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334311C22F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454811946CA;
	Wed,  5 Jun 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oNWrSzIQ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9A1946B7;
	Wed,  5 Jun 2024 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576733; cv=none; b=tJJgUw4oy7zCzhkvzksY5kNv98omQE7XlTX4atNJ0D54zmNInaReYtpUQxQjTp+Bg530+sqAjTFq7thdDuScwdbnFES8gOUxrmetZBjIlGutqFIJ9O251xBIW2cXOtcoy2O0isVY/8QmaBb4wFePoavHKBr9jW+82TKPJKVTyGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576733; c=relaxed/simple;
	bh=qlOpXvbASDfkh/Lpi1x8RqrNwZ3csqeZVevUiIghWtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m6m7nQspSO8PJ+3EK4OnyEgG6aO6FzomoVd/NIm4oN0ElVl3kK5YICAC4EmL5haZz8Kf+DeqZdlKkxhIIWD2g0QaBsuPa8l9PpZNzVFABtPAGGeBcgQV79H6Nn6vK+dmoiHD/wKVcRRmDdPYOmT0lRX2ikjerBQXK6G3j+xRZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oNWrSzIQ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4557pqhU012938;
	Wed, 5 Jun 2024 10:38:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yblqeVgdzJlkjjtIvKSnunjf6uXDlyqBWLVo+p3FKHA=; b=oNWrSzIQOFm31ylc
	7vtZZVTb1TAo9pOCH/+LEN0GQ4QQNU000CSGyQ2KV1xmicC/+bDIf/kHOjFLBuMl
	W0WxWGqNbRxNdjGVH0mB01fSUPcMT4EYL7pAlLgG+cdn3iPEtslo0SQe+Bba1yan
	A1X4DVNiW4/6fBTRznTIMvKRUhCK0HhtBQS1K/EYEIynvBq0+gIxKJrTZpwO2nzv
	6ZhLZ4Pr32aG7Z3rBGUDshStC7UFUXgIV8ZPDkzYrvruAHpN//EHLW8XRLAAkI7j
	kKn3eE70NgCAJ/G0oTz9q4ZnPeabbB2uPemCffPIwiBZ5ODrbzb9qzK8dSrav2lv
	U147hQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yfw3wquse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 10:38:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3E9FE40045;
	Wed,  5 Jun 2024 10:37:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 37C352132CD;
	Wed,  5 Jun 2024 10:37:11 +0200 (CEST)
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:37:10 +0200
Message-ID: <90eca010-2992-4fc4-99dc-2265610c4615@foss.st.com>
Date: Wed, 5 Jun 2024 10:37:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: add goodix touchscreen on stm32mp135f-dk
To: Yannick Fertre <yannick.fertre@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240506144945.293966-1-yannick.fertre@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20240506144945.293966-1-yannick.fertre@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-05_01,2024-05-17_01

Hi Yannick

On 5/6/24 16:49, Yannick Fertre wrote:
> Touchscreen reset needs to be configured
> via the pinctrl not the driver (a pull-down resistor
> has been soldered onto the reset line which forces
> the touchscreen to reset state).
> Interrupt line must have a pull-down resistor
> in order to freeze the i2c address at 0x5D.
> 
> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>   arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 22 +++++++++++++++++++++
>   arch/arm/boot/dts/st/stm32mp135f-dk.dts     | 14 +++++++++++++
>   2 files changed, 36 insertions(+)
> 

Applied on stm32-next.

Cheers!
alex

