Return-Path: <linux-kernel+bounces-398934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E589BF837
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A97C4B232B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65120C48F;
	Wed,  6 Nov 2024 20:51:30 +0000 (UTC)
Received: from luna.linkmauve.fr (luna.linkmauve.fr [82.65.109.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF64204F76;
	Wed,  6 Nov 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.65.109.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926290; cv=none; b=DpiEXuw1IvVBDkcPl0VC8cmgH/IbD6LYx25v2JXvugcjJWC6YHkA/dPAyQ9kGiB9eAIxVbsQjfaIeeLYqocr71Dso8yhd4wsrNKwk0rMU8RDnnQ/GRuavVzKACB1Q2yuxCkGA+cMqWNFZ9hGUWGI3br+qjqVYQfWwtN9jVl85cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926290; c=relaxed/simple;
	bh=pazZYmXayDoYxY475x7F24mNnNY7L+4yLGzHWazIAEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tgp9bqh/7JiM/4GMeLqLFmsEw/NUa0SMla1988E6bMQx6iShaDvxKV/8AHHNFQNsDvDeaOQuC8J4YMNU2dmj4EWcA2hFeaAl5xtscyA9ES1tEofhKFwLGY5pF0ia9kI0HC7NWYESjqctBe5cRqQiWOJ0UVxFxNvIxaHkdoC7FSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass smtp.mailfrom=linkmauve.fr; arc=none smtp.client-ip=82.65.109.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linkmauve.fr
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 7CC2F15E5A9A; Wed, 06 Nov 2024 21:42:25 +0100 (CET)
Date: Wed, 6 Nov 2024 21:42:25 +0100
From: Link Mauve <linkmauve@linkmauve.fr>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Alexandre ARNOUD <aarnoud@me.com>, kernel@collabora.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Enable HDMI0 on rock-5b
Message-ID: <ZyvUsdc8ZhiD8-DY@desktop>
References: <20241019-rk3588-hdmi0-dt-v2-0-466cd80e8ff9@collabora.com>
 <20241019-rk3588-hdmi0-dt-v2-2-466cd80e8ff9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241019-rk3588-hdmi0-dt-v2-2-466cd80e8ff9@collabora.com>
Jabber-ID: linkmauve@linkmauve.fr

Hi,

I’ve tested this series on a Radxa Rock 5B using Weston, and thus
patches 1 and 2 are:
Tested-by: Link Mauve <linkmauve@linkmauve.fr>

On a TV which erroneously reports 1360×768 as its preferred mode,
nothing gets displayed.  Only setting a 1920×1080 mode will display
things correctly, every other mode stays black.

Also, before starting Weston, drm_info reports Status: unknown, 0×0 mm,
no modes, and no EDID blob.  After starting Weston all of these property
get loaded properly, aside from the physical size which gets set to the
obviously invalid 1600×900 mm.

The first start of Weston after reboot takes a total of 7.4s, which
seems very long just to (I believe) probe the screen and parse the EDID,
if that’s what the driver is doing.  Subsequent launches complete in
about 400 ms, which is closer to my expectation.

Thanks a lot for this series!

On Sat, Oct 19, 2024 at 01:12:11PM +0300, Cristian Ciocaltea wrote:
> Add the necessary DT changes to enable HDMI0 on Radxa ROCK 5B.
> 
> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 47 +++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index d6fff5b86b87020f115ce64795aee90c002a2255..0c3baf74981b714eb2a1edbc3fbbb69cd688cfc2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -4,6 +4,7 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>  #include "rk3588.dtsi"
>  
>  / {
> @@ -37,6 +38,17 @@ analog-sound {
>  		pinctrl-0 = <&hp_detect>;
>  	};
>  
> +	hdmi0-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi0_con_in: endpoint {
> +				remote-endpoint = <&hdmi0_out_con>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> @@ -192,6 +204,26 @@ &gpu {
>  	status = "okay";
>  };
>  
> +&hdmi0 {
> +	status = "okay";
> +};
> +
> +&hdmi0_in {
> +	hdmi0_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi0>;
> +	};
> +};
> +
> +&hdmi0_out {
> +	hdmi0_out_con: endpoint {
> +		remote-endpoint = <&hdmi0_con_in>;
> +	};
> +};
> +
> +&hdptxphy_hdmi0 {
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0m2_xfer>;
> @@ -858,3 +890,18 @@ &usb_host1_xhci {
>  &usb_host2_xhci {
>  	status = "okay";
>  };
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vop {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi0_in_vp0>;
> +	};
> +};
> 
> -- 
> 2.47.0
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

-- 
Link Mauve

