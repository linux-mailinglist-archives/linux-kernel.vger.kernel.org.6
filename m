Return-Path: <linux-kernel+bounces-527466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 377D4A40B88
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F15188DE76
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1879A202F61;
	Sat, 22 Feb 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="2bEvC5IS";
	dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b="WdoPDvm8"
Received: from haruka.juszkiewicz.com.pl (haruka.juszkiewicz.com.pl [185.243.53.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0E1EE013;
	Sat, 22 Feb 2025 20:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.243.53.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740255243; cv=none; b=jbb5y5FUtik+PiINEKYipAv29AqyCKC7Ct/cHWIr6iFBEW8jbNr5XiHbjyMsaUTwTEntPfIa3dVKCTiHMD89CRtB9fm4j3VH4DoI50SxezatOQtuoGCUYw3orjc26rx3dawNnp8paFH8N9bmKwJFZsss2LkSQgNfNvoIoll2DiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740255243; c=relaxed/simple;
	bh=EOIAAhnvAqcJAfcBLWXpvJ03F0LkIj4if1vHn1h9A1U=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=nriX2mslQV1a5jpd05Ajbyiiy27PU4r8ppHwtZBAIOhp4NEYmz33KjPr778yjOtIhIrNzH6nWWPy9rq6p0vOtPhU01ZJdkR2WgnZ1VbRrgKZwZIzssxQOgAHG5sQb/raczLXPRUHF8vRK72Yc6VvGGiFg2dvI0+fTaP2t3X7Q4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl; spf=pass smtp.mailfrom=juszkiewicz.com.pl; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=2bEvC5IS; dkim=pass (2048-bit key) header.d=juszkiewicz.com.pl header.i=@juszkiewicz.com.pl header.b=WdoPDvm8; arc=none smtp.client-ip=185.243.53.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juszkiewicz.com.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juszkiewicz.com.pl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=juszkiewicz.com.pl;
	s=mail; t=1740254719;
	bh=EOIAAhnvAqcJAfcBLWXpvJ03F0LkIj4if1vHn1h9A1U=;
	h=Date:To:Cc:References:Subject:From:In-Reply-To:From;
	b=2bEvC5ISzbx28STGms+5ITnG1jt2OPnuqY7nEjUja7+h2liMiezlffSZuUWyp9FOX
	 E/8sDUfbuNZHlrflSJM364ctRAIAiwxrQcQBJAgLpAtOITNac8g4G4WZW4jc0BwzMf
	 SJh3sDd9RSnD9vw0J3s3U8QI6k2UQJ3qu1WBeowBaL9LJ2zpHzpQRUSb4kCaNumFSM
	 KGHH+3XNIMdrfpdkcnkRh1B1tQhoBaHCUnns7GSwvYh0dY18+r+OjPb702nw+Ygh8O
	 /nclNCCrweu/6+RGrccjFmHgzDlYzeU+eGC2sXmGEDCOJ3/kI5Vqt39+dkkO/+ZmSX
	 r4/NwKu5FBPXg==
Received: from utena.juszkiewicz.com.pl (utena.juszkiewicz.com.pl [158.101.208.177])
	by haruka.juszkiewicz.com.pl (Postfix) with ESMTPSA id 8A28522AAC;
	Sat, 22 Feb 2025 21:05:19 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3ED1341E75;
	Sat, 22 Feb 2025 21:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juszkiewicz.com.pl;
	s=mail; t=1740254718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WfeTFtl8ycLeQAXrwF465oXgTTKRj57NhCJsCxPUGYw=;
	b=WdoPDvm8HKFKuut/56zMqqOEsGVIZHXtc3/BZ/250odZuxi2gGjWiYrVZkTYDbxDItcBaH
	taBshndSUM7s/2PAnNp0oJx+zZtZkx7127+QrHC7gZtiz9R881bAZnT7Ooio8tBrKkMY+F
	zxaiOPY8/eomQeddNgxUbIs9yYSGpMysOqzLMrpnZZTbOZ4yohNyd9HfCJT9exCLMcVyPz
	99EFrocwU2bFXWn+Ggr+QH4C7vwOrniG7bVegfWDEplgsXJNAx7Z8jJkTd+XKq2MOpZt+Q
	Fkk0pEQD2MILDwuilgt8VkknH6OtoV6nK2xy66dP1txokwplJYg90dICVzH0TA==
Message-ID: <068655e7-2ad7-4497-aca7-4100ad478d99@juszkiewicz.com.pl>
Date: Sat, 22 Feb 2025 21:05:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: peter.chen@cixtech.com
Cc: arnd@arndb.de, catalin.marinas@arm.com, cix-kernel-upstream@cixtech.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org, fugang.duan@cixtech.com,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, will@kernel.org
References: <20250220084020.628704-7-peter.chen@cixtech.com>
Subject: Re: [PATCH 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts support
From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250220084020.628704-7-peter.chen@cixtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

> diff --git a/arch/arm64/boot/dts/cix/sky1.dtsi b/arch/arm64/boot/dts/cix/sky1.dtsi
> new file mode 100644
> index 000000000000..d98735f782e0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/cix/sky1.dtsi
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright 2025 Cix Technology Group Co., Ltd.
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>

[..]

> +	arch_timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +		clock-frequency = <1000000000>;
> +		interrupt-parent = <&gic>;
> +		arm,no-tick-in-suspend;
> +	};

This is not Arm v8.0 SoC so where is non-secure EL2 virtual timer?

