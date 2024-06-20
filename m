Return-Path: <linux-kernel+bounces-223333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EA91113D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A748282A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305A1BE860;
	Thu, 20 Jun 2024 18:35:00 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750FD1B4C35;
	Thu, 20 Jun 2024 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908500; cv=none; b=Vy3X4vNGxasa0p2tZO4gB+gw1/UIeXuNiTf00SNfQnH42twIOe+9/Hj3OuWizlciqFraeODp0h3vqJ1CQ9aah6NU+lyq6GdIIiotJlUz1URnd3IoGPcTcGWVusdw3HONVSVhxN8zBMOg97iHufzO6GNiMeIlIBMYsaQxHlKXBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908500; c=relaxed/simple;
	bh=tPAZ0xHBfoomsrxImrhJ+gY9MeQqc/CDLx78nd8mDlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MK7yDEBgKpz6EPNq1q+tMmP3guWDbhLRmwlfwtX29ZzihzvSAjZhqyRH8smlCrt8WEI3Wcxdjy7npKESZ+w+fWMeLL88ninUGmVMJdu1IsRGKHvJpftOuNZPZgDGjo0nuJ2S1M7cdhCGfWX6lF8iciDmSSaOO4jn39gfL7hr8t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cc8.versanet.de ([94.134.12.200] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sKMcT-0000Sm-1A; Thu, 20 Jun 2024 20:34:49 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Sebastian Kropatsch <seb-dev@mail.de>
Cc: linux-rockchip@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 1/5] arm64: dts: rockchip: Add common definitions for NanoPi R6C
 and R6S
Date: Thu, 20 Jun 2024 20:34:47 +0200
Message-ID: <3392879.RL5eaSpR8r@diego>
In-Reply-To: <20240612205056.397204-2-seb-dev@mail.de>
References:
 <20240612205056.397204-1-seb-dev@mail.de>
 <20240612205056.397204-2-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 12. Juni 2024, 22:48:10 CEST schrieb Sebastian Kropatsch:
> The FriendlyElec NanoPi R6C and R6S are quite similar boards,
> although they differ in:
> - M.2 M-Key connector vs second RTL8125BG Ethernet port
> - One of the LEDs has a different function on each board
> - 12-pin GPIO FPC vs 30-pin GPIO header
> - R6S has a PWM-based IR receiver while the R6C has not
> - R6S has a 5V fan connector while the R6C has not
> 
> Refactor their DT files by adding a common definitions file to
> improve differentiation clarity between both boards and to make
> hardware-specific DT changes easier in the long run.
> Do not introduce any functional changes.
> 
> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
> ---
>  ...-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} |   7 +-
>  .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |   2 +-
>  .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 756 +-----------------
>  3 files changed, 7 insertions(+), 758 deletions(-)
>  copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} (99%)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
> similarity index 99%
> copy from arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> copy to arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
> index 4fa644ae510c..e68d4071400e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6.dtsi
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Common devicetree definitions for the NanoPi R6C and R6S
> + */
>  
>  /dts-v1/;
>  
> @@ -8,9 +11,6 @@
>  #include "rk3588s.dtsi"
>  
>  / {
> -	model = "FriendlyElec NanoPi R6S";
> -	compatible = "friendlyarm,nanopi-r6s", "rockchip,rk3588s";
> -
>  	aliases {
>  		ethernet0 = &gmac1;
>  		mmc0 = &sdmmc;
> @@ -74,7 +74,6 @@ lan1_led: led-2 {
>  		};
>  
>  		lan2_led: led-3 {
> -			label = "lan2_led";
>  			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&lan2_led_pin>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
> index 497bbb57071f..ccc5e4627517 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6c.dts
> @@ -2,7 +2,7 @@
>  
>  /dts-v1/;
>  
> -#include "rk3588s-nanopi-r6s.dts"
> +#include "rk3588s-nanopi-r6.dtsi"
>  
>  / {
>  	model = "FriendlyElec NanoPi R6C";

you didn't add a label for that led here.

Though I think it might very well be much nicer to just define the led
with differing function in each board separately.

Especially as the phandle in the new dtsi now still reference the removed
label.


Heiko




