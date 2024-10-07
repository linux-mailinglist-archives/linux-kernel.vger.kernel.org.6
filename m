Return-Path: <linux-kernel+bounces-353472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370A5992E4A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004A028472B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFAF1D54D4;
	Mon,  7 Oct 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="WSHbpCP2"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FB1D47C1;
	Mon,  7 Oct 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309991; cv=none; b=hYVCqlFyZSLLrzHFpmqG3UXGlWfSbD0xdahVVaAKxLMpt+SMVoqJgmSgzGeFl9wL4fF4F/dhoj38evv6fctzGAGqkg9Rwwrf6W64NWkPpWh22Yk5SsmmIs3zNrDmwAlP/vKCxKifGJ+0o5yfnlswIQhWyzvdw9/4NKVxYg85Rbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309991; c=relaxed/simple;
	bh=s9SMvvrdQ4RrVH3QJPWvbPISUmvmagNskALBqzL2N3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8RdJ02zCB3TqYhJ94tFXG5UE3RNhJ1+4n7RdtlHl9C4sPnYIRejCqLwAQDIYmUzFgqVu5bXWjfFCz6J1ctJ/INC8whChwz6pPMiDmF99n5RRDgVp+jKMwewYquWHppn5SgM++/usNL96vA5+y9wtLthTw/UU0BpkL7BZkuKKnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=WSHbpCP2; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HiOsDH8bD3eEMDvsRSDIBuRwHXY1ZAV2zq7VMShOysU=; b=WSHbpCP2/o0YiUGRkFUWljcjVx
	cuexaRT32ZS63jq+m68dq42nDZgPZtBHQrproiGuESz+FdyNyDyQtTDIJoZ4XXhNxvAqcvcIG4JNB
	UkyX3yNcmhCR4dZswfAF0Bef4hRh1xyevfj210Fx9ON9BxRFoCvD21BT3H9kwilPDWzjJ9oIDB+ck
	dBMUt5sM/VrnxT0HFkjp2v8XJTrd0ZRAETfRUaJ/YB4CAZfViQf3GMBR2IcaF7a0UZhKyW59XfgyL
	l6C9kc0mnLXgGeiTH5OPdAwj4gUa8pubvb8Tk7rfJIvCaAAWvgyvpuVXCkU/Lu1t7ecNQKtchanT2
	2AWZhxIA==;
Received: from i5e860d18.versanet.de ([94.134.13.24] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sxoNU-0000tA-SA; Mon, 07 Oct 2024 16:06:24 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Diederik de Haas <didi.debian@cknow.org>
Cc: Diederik de Haas <didi.debian@cknow.org>,
 Dragan Simic <dsimic@manjaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 3/4] arm64: dts: rockchip: Fix wakeup prop names on brcm BT nodes
Date: Mon, 07 Oct 2024 16:06:24 +0200
Message-ID: <6096052.lOV4Wx5bFT@diego>
In-Reply-To: <20241007105657.6203-5-didi.debian@cknow.org>
References:
 <20241007105657.6203-2-didi.debian@cknow.org>
 <20241007105657.6203-5-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 7. Oktober 2024, 12:28:18 CEST schrieb Diederik de Haas:
> The "brcm,bluetooth.yaml" binding has 'device-wakeup-gpios' and
> 'host-wakeup-gpios' property names.
> Fix the ones where '*-wake-gpios' was used.
> 
> Note that the "realtek,bluetooth.yaml" binding does use the
> '*-wake-gpios' property names.
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

parts of the commit conflict with a previous one from me ;-) [0]


[0] https://lore.kernel.org/linux-arm-kernel/20240930210112.1993625-7-heiko@sntech.de/T/#m59bdb72d6c22f85fe79716761fedaea2a2e1c73e

> ---
>  arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts  | 4 ++--
>  arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> index 0c18406e4c59..16fd98698db3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
> @@ -450,8 +450,8 @@ bluetooth {
>  		compatible = "brcm,bcm43438-bt";
>  		clocks = <&pmucru CLK_RTC_32K>;
>  		clock-names = "ext_clock";
> -		device-wake-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> -		host-wake-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpio2 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio2 RK_PC0 GPIO_ACTIVE_HIGH>;
>  		shutdown-gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> index de4c082dce07..7381bb751852 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi
> @@ -684,8 +684,8 @@ bluetooth {
>  		compatible = "brcm,bcm43438-bt";
>  		clocks = <&rk817 1>;
>  		clock-names = "lpo";
> -		device-wake-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
> -		host-wake-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
> +		device-wakeup-gpios = <&gpio0 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
>  		reset-gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_LOW>;
>  		pinctrl-0 = <&bt_enable_h>, <&bt_host_wake_l>, <&bt_wake_h>;
>  		pinctrl-names = "default";
> 





