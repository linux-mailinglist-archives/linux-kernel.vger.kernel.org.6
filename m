Return-Path: <linux-kernel+bounces-304586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA926962228
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DA61F24C15
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D715B0F4;
	Wed, 28 Aug 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EA3/9y6j"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B4156C76;
	Wed, 28 Aug 2024 08:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833084; cv=none; b=begriN3s8QJD6R0UPIzkB3i67+SuFYjKRJkrwxs0Dex7pB1xyuZXf/Czh3QBrRhKObstrkfaVVpaEM6uaYGdG7JfexX1AzHlFJct+pwW3qlkYXzn7vBj2hkDkgAtYo2YKusPu2Hpvd6WhW3HLAfvx3FSD7a5tmAJ6risXsV5KMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833084; c=relaxed/simple;
	bh=46LoxCZKSwP1X+UxipxmkDh/n2gnxzNlfu7gHlOHcIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQcbR1qOI3LIs+9IbMqhrQAYo6KAEG0ahJhPJEu7w0JOENExKPbHL1YQHrBdj2C+kDSlIWXj35OIuwhRF4H2jmbHP6p13BnlK6cgGgOLbfjRiMMbWtfxuClzsZ3NCV7k5gswjZ2yJpgNs9TmmD59/am2HyMoJoOeUwV1h/tbHkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EA3/9y6j; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G16Cw7bgMc7vHgddMhzU1OMDwhZPTsB9GNDj45toMmk=; b=EA3/9y6jLVDQ69JXYFMNe5CJ/b
	WVoPHoD6Q+2ZmX6uJKp3I78VVUC2+YSYXafqNQVnFGkCFIQA66rJZW16wFhI5u/gsgtZQ3Do34G2E
	M7PrCZjr6GxTLQMBJ3nWJWuwNFgu0PMu2dudypYHpcbNyLbPQrs2aoyjiZwI76fomvyYSOKe+UCLr
	XGHc7wMqjfAYwTxIc+4rMytC/geQVWc7M1ZfodEWZr1ViYZ53QSup/cJLA/O9xqPzep7u8T73NtT1
	Vk7ymorqCro1MFf6rYSAXJG7+Ea77Zs86jxiu2Q6BGrFWkEWKRft7bxTJBed07hcJ9cmLZR+2LjLz
	mjtshd6Q==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjDs1-0003fe-SE; Wed, 28 Aug 2024 10:17:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Jacobe Zang <jacobe.zang@wesion.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev, Jacobe Zang <jacobe.zang@wesion.com>,
 Muhammed Efe Cetin <efectn@protonmail.com>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH v12 0/2] (no cover subject)
Date: Wed, 28 Aug 2024 10:18:46 +0200
Message-ID: <2106034.K71DO8KEF6@diego>
In-Reply-To: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
References: <20240828-dts-v12-0-80b6f240f67f@wesion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Mittwoch, 28. August 2024, 09:58:48 CEST schrieb Jacobe Zang:
> Add basic Wi-Fi support on Khadas Edge2. Wireless driver need to check "brcm,bcm4329-fmac"
> compatible so add it to Apple's devices.
> 
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> Changes in v12:

I think that did go wrong?
The earlier version was already a v12?

Was this sent accidentially?


Heiko

>  - Add fallback compatible for Apple's devices
> 
>  - Link to v11: https://lore.kernel.org/all/20240816015214.1271162-1-jacobe.zang@wesion.com/
> 
> Changes in v11:
>  - Split DTS and submit separately
> 
>  - Link to v10: https://lore.kernel.org/all/20240813082007.2625841-1-jacobe.zang@wesion.com/
> 
> Changes in v10:
>  - Use ret instead unused probe_attach_result in sdio.c 
> 
>  - Link to v9: https://lore.kernel.org/all/20240810035141.439024-1-jacobe.zang@wesion.com/
> 
> Changes in v9:
>  - Add return -ENODEV error pointer from brcmf_sdio_probe as the default for the fail path
>  - Add if statement for brcmf_of_probe in common.c
>  - Retain modifications to of.c other than the return values
> 
>  - Link to v8: https://lore.kernel.org/all/20240805073425.3492078-1-jacobe.zang@wesion.com/
> 
> Changes in v8:
>  - Add appropriate errno's for return values that will be
>     send to bus when error occurred.
>  
>  - Link to v7: https://lore.kernel.org/all/20240802025715.2360456-1-jacobe.zang@wesion.com/
> 
> Changes in v7:
>  - Change brcmf_of_probe prototypes from void to int, add appropriate errno's for return
>     value, move clock check to the end of brcmf_of_probe
>  - Add "brcm,bcm4329-fmac" compatible for wifi node
> 
>  - Link to v6: https://lore.kernel.org/all/20240731061132.703368-1-jacobe.zang@wesion.com/
> 
> Changes in v6:
>  - Move "brcm,bcm4329-fmac" check to the top of brcmf_of_probe in of.c
>  - Add return if clk didn't set in DTS
> 
>  -Link to v5: https://lore.kernel.org/all/20240730033053.4092132-1-jacobe.zang@wesion.com/
> 
> Changes in v5:
>  - Add more commit message to the clock in bindings
>  - Use IS_ERR_OR_NULL as a judgment condition of clk
> 
>  - Link to v4: https://lore.kernel.org/all/20240729070102.3770318-1-jacobe.zang@wesion.com/
> 
> Changes in v4:
>  - Change clock description in dt-bindings
>  - Move enable clk from pcie.c to of.c
>  - Add compatible for wifi node in DTS
>  - Add random seed flag for firmware download
> 
>  - Link to v3: https://lore.kernel.org/all/20240630073605.2164346-1-jacobe.zang@wesion.com/
> 
> Changes in v3:
>  - Dropped redundant parts in dt-bindings.
>  - Change driver patch title prefix as 'wifi: brcmfmac:'.
>  - Change DTS Wi-Fi node clock-name as 'lpo'.
>  
>  - Link to v2: https://lore.kernel.org/all/20240624081906.1399447-1-jacobe.zang@wesion.com/
> 
> Changes in v2:
>  - Add SoB tags for original developer.
>  - Add dt-bindings for pci14e4,449d and clocks.
>  - Replace dev_info to brcmf_dbg in pcie.c
> 
>  - Link to v1: https://lore.kernel.org/all/20240620020015.4021696-1-jacobe.zang@wesion.com/
> 
> ---
> Jacobe Zang (2):
>       arm64: dts: rockchip: Add AP6275P wireless support to Khadas Edge 2
>       arm64: dts: apple: add "brcm,bcm4329-fmac" fallback compatible
> 
>  arch/arm64/boot/dts/apple/t8103-jxxx.dtsi             |  2 +-
>  arch/arm64/boot/dts/apple/t8112-j413.dts              |  2 +-
>  arch/arm64/boot/dts/apple/t8112-j493.dts              |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts | 16 ++++++++++++++++
>  4 files changed, 19 insertions(+), 3 deletions(-)
> ---
> base-commit: dabcfd5e116800496eb9bec2ba7c015ca2043aa0
> change-id: 20240828-dts-1b163375c49c
> 
> Best regards,
> 





