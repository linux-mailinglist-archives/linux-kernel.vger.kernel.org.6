Return-Path: <linux-kernel+bounces-362891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC7699BAC4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5AB1F211C7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 18:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1896E148FE6;
	Sun, 13 Oct 2024 18:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xYDjiaJA"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A1813AD22;
	Sun, 13 Oct 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728843683; cv=none; b=rmP42q3OOb41ZsgMf4WRGE31Hkfu4U3MWA1bexDvfNhLLYhoC8lY48pwd+cwJyuJy6Z0mitSM47hi4zM4qYOd7YYXiu71TulwpzPHBitokdoJoQOVayhMFVdKUQrslZzjmIqTfj1hGGbvXsPYCKfL34aCe5Xbzg/5o6g8FbRIVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728843683; c=relaxed/simple;
	bh=N0bmPdOuLw0onEUb80WNSBMCdDG6SFhYsmdVUiAkgD0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQg0akxG0pov1pdQ2VEIKtiRsXT/II9rYfQG/ZHutF7zhJWhyCRL20Fp2XqcXuViZvfWii2tLhFhoys9Uo2PzRUKyJXQCLMVLvzIlItD2c3bY91mnyHp3VcYfjtEPCdi8y3BqCvhz/hTM7SiaH0mTLmfF/HHxUVBV0GLN20sEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xYDjiaJA; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=P95hhQv9EQTGpPqL3cZ9sFDz6v/d/ZsXagWbz/otrCs=; b=xYDjiaJAOFIhyaZwMcxn6Ta/WW
	RP9ZRqWAiE34BWiUeYDeDT1g2MgRC36HODTaCwRHC5xZO/URi0N4AZnG0c4udP3pgVwdExrGEDLui
	Yk4+glouMCI6szXes9wpTm5dQAXVUL9r9QScr0AlEJGyfLwXQK2kcRhkBsH2IbDHmdckjdeygtsVT
	UsVsTcA47t9z1SJp+TKb3/Ic+I+0w6qtXl9VHSJZd7I5crmcwbZ6M9iqjRxvB6Ro79Wxu4TYn2k1Z
	a417Ls3pl9qLHIBXd/1PaFUWvXBqoGQ91pOqwOTh3wz1+w9OOGjYMrLSE8bSi3cYjRDOZpCejyOvQ
	jApfeTbQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t03DA-0000r1-1Q; Sun, 13 Oct 2024 20:21:00 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Andy Yan <andyshrk@163.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Cenk Uluisik <cenk.uluisik@googlemail.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Cenk Uluisik <cenk.uluisik@googlemail.com>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Add board device tree for
 rk3588-orangepi-5b
Date: Sun, 13 Oct 2024 20:20:58 +0200
Message-ID: <4956547.31r3eYUQgx@diego>
In-Reply-To: <20241013155225.26259-1-cenk.uluisik@googlemail.com>
References: <20241013155225.26259-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Am Sonntag, 13. Oktober 2024, 17:52:18 CEST schrieb Cenk Uluisik:
> Add initial support for OPi5b that includes support for USB2, PCIe2, Sata,
> Sdmmc, SPI Flash, PMIC.

Please describe in a better way what actually makes this board different
from the original OrangePi 5.

I.e. it does look like the 5b does have an emmc where the 5 does not.

You also need a separate second patch to update
	Documentation/devicetree/bindings/arm/rockchip.yaml

You need to update the Xunlong Orange Pi 5 entry with an enum.
Please see for example the orange-pi-3 entry on how that should look.


> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |  1 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5b.dts | 26 +++++++++++++++++++
>
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 09423070c992..45249ce15175 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -154,3 +154,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-odroid-m2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5b.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> new file mode 100644
> index 000000000000..107b65a5e7ea
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +/dts-v1/;
> +
> +#include "rk3588s-orangepi-5.dts"

Please don't include the board dts.
Take a look for example at the rk3566-orangepi-3b on how to do this.

I.e. you want a rk3588s-orangepi-5.dtsi which then gets included
into both the original-5 as well as your 5b .


> +
> +/ {
> +	model = "Xunlong Orange Pi 5B";
> +	compatible = "rockchip,rk3588s-orangepi-5", "rockchip,rk3588";
> +};
> +
> +&sdhci {
> +	status = "okay";
> +};
> +
> +&sfc {
> +	status = "disabled";
> +};
> +
> +&wireless_bluetooth {
> +	status = "okay";
> +};
> +
> +&wireless_wlan {
> +	status = "okay";
> +};

both the wireless_bluetooth as well as the wireless_wlan phandles
are not part of the orange pi 5 in mainline. So this probably doesn't
even compile?


Heiko




