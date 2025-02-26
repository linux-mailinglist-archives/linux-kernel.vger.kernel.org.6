Return-Path: <linux-kernel+bounces-534178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A9A463DA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0D417A927
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62FA2222CB;
	Wed, 26 Feb 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="v/IsNpPF"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DF322171E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581769; cv=none; b=DApA5M1LiKG27ha6S0vbxKdtc5lXecM2D5eu7WprJZsjl3BtMsj8ead7kQ+wytNprHAcuFv7ArhUkEo3JTh4JR5yjlMYL1Xd2MkztJP+ityllr/Zepi0yiWX/6KFV2FLYlOY9nkLzr4SXx0LH05HU/s8iVcV8D1UFa0GdJ8wpMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581769; c=relaxed/simple;
	bh=3QcCZ3g5LBqlswQyOTHsTqpCneXCRv2OoVnlOv3oPv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWTAgjWTR7s7tUHMOfdXFK8Ey6SfMTtzhqVkma/5O20CLWUe1mtGXsPkqg5kWSi54uqdUOoQlhAGi6MRJVaZy4jvKiIeEGa09nj9zzGQ7Z6inlmtjN/8LdIrzK9nezjcFq1Asg9m3KZFwGfbCckEX19B8WSRFemKC9yixgQULUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=v/IsNpPF; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1740581171; bh=3QcCZ3g5LBqlswQyOTHsTqpCneXCRv2OoVnlOv3oPv4=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=v/IsNpPFIOzWQD/T+IHiEI77aY4ktraWpQGcNLc7spGOY+CDRZmMBH+fNvgB/vCRK
	 BILi59vxqqww/FgA9XEXDd+BECmNspLBfb83dvKeUnSRa1kmV74gKYKXQFW3EpIbnD
	 kitp3E7X/H24Er3ooOjuv2kJC9O9mEvp5Tks2b7I=
Date: Wed, 26 Feb 2025 15:46:11 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Heiko Stuebner <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	quentin.schulz@cherry.de, sebastian.reichel@collabora.com, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 2/2] phy: rockchip: usbdp: re-init the phy on
 orientation-change
Message-ID: <7q5yn466xd7emebhjze4ixkswgyxjjjt5rwvyww2hwbts6bamd@i5vwvegy2os6>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, 
	sebastian.reichel@collabora.com, Heiko Stuebner <heiko.stuebner@cherry.de>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250225184519.3586926-1-heiko@sntech.de>
 <20250225184519.3586926-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225184519.3586926-3-heiko@sntech.de>

Hi Heiko,

On Tue, Feb 25, 2025 at 07:45:19PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Until now the usbdp in the orientation-handler set the new lane setup in
> its internal state variables and adapted the sbu gpios as needed.
> It never actually updated the phy itself though, but relied on the
> controlling usb-controller to disable and re-enable the phy.
> 
> And while on the vendor-kernel, I could see that on every unplug the dwc3
> did go to its suspend and woke up on the next device plug-in event,
> thus toggling the phy as needed, this does not happen in all cases and we
> should not rely on that behaviour.

On RK3399 there's a similar issue with the equivalent type-c PHY driver.
The TRM (part 2) states that:

4.6.1 Some Special Settings before Initialization

- Set USB3.0 OTG controller AXI master setting.
- Clear USB2.0 only mode setting (bit 3 of register GRF_USB3PHY0/1_CON0 in Chapter GRF)
- USB3.0 OTG controller should be hold in reset during the initialization of the corresponding
  TypeC PHY until TypeC PHY is ready for USB operation.
- Set PHYIF to 1 to use 16-bit UTMI+ interface (see register GUSB2PHYCFG0)
- Clear ENBLSLPM to 0 to disable sleep and l1 suspend (see register GUSB2PHYCFG0)
  ...

The PHY for Superspeed signals is expected to be set up while the USB
controller is held in reset, which makes sense HW wise, and it's what downstream
kernel efectivelly does, via its RPM based hack.

RK3588 TRM doesn't have very detailed notes on this, but I expect it will be
similar.

So reconfiguring the phy here, while it's actively linked to the USB controller
without the controller driver driving the process so it reliably happens while
it's in reset, or at least so that USB controller reset happens afterwards, may
not be correct way to approach this.

Also moving this to the USB controller driver would fix the issue on both RK3399
and RK3588 and maybe elsewhere.

My own shot at this is:

https://codeberg.org/megi/linux/commit/2fee801eae4ca6c0e90e52f6a01caa3e6db28d7d

I turned out to be a bit too complicated, so I didn't submit that yet upstream,
hoping I could simplify it in the future.

I basically abused current_dr_role a bit to add a disconnected state, to get
__dwc3_set_mode() called when type-c controller updates the port state from
disconnected to connected with some orientation, and trigger phy reconfig from
there, while USB is in reset:

https://elixir.bootlin.com/linux/v6.13.4/source/drivers/usb/dwc3/core.c#L197

Kind regards,
	o.

> This results in the usb2 always working, as it's not affected by the
> orientation, but usb3 only working in one direction right now.
> 
> So similar to how the update works in the power-on callback, just re-init
> the phy if it's already running when the orientation-event happens.
> 
> Both the power-on/-off functions as well as the orientation-set callback
> work with the usbdp-mutex held, so can't conflict.
> 
> The behaviour is similar to how the qcom qmp phys handle the orientaton
> re-init - by re-initting the phy.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
> ---
>  drivers/phy/rockchip/phy-rockchip-usbdp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> index 7b17c82ebcfc..b63259a90d85 100644
> --- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
> +++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
> @@ -1277,6 +1277,7 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
>  				 enum typec_orientation orien)
>  {
>  	struct rk_udphy *udphy = typec_switch_get_drvdata(sw);
> +	int ret = 0;
>  
>  	mutex_lock(&udphy->mutex);
>  
> @@ -1292,6 +1293,12 @@ static int rk_udphy_orien_sw_set(struct typec_switch_dev *sw,
>  	rk_udphy_set_typec_default_mapping(udphy);
>  	rk_udphy_usb_bvalid_enable(udphy, true);
>  
> +	/* re-init the phy if already on */
> +	if (udphy->status != UDPHY_MODE_NONE) {
> +		rk_udphy_disable(udphy);
> +		ret = rk_udphy_setup(udphy);
> +	}
> +
>  unlock_ret:
>  	mutex_unlock(&udphy->mutex);
>  	return ret;
> -- 
> 2.47.2
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

