Return-Path: <linux-kernel+bounces-534489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38014A4675A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81EA7AA52C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00EF21C9E9;
	Wed, 26 Feb 2025 17:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="gQHXn0zn"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8F41DE2A9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740589429; cv=none; b=jqKFpN8vfh8GuepCpPyOdwttZ0Bbk3I9Ih7wsiH9tol0/+W5X782YQeBz5C9E2ez/1ofe53T4xYpMt8XMOoWSxVJAa1s/hqTFh8f76iTDfxOrKjGrwIxHasPiJnt3LeT17Oo3FOYkoN9PP9NmUcWwi+uKXHKdviBApWeZR6AIA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740589429; c=relaxed/simple;
	bh=lRgrbi89RAPj6wGopHjUn9XlnG+mldWaZKc9kQI81BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpixYdfZiKym6v2LTcyEhkel44BVviQXdUgaJvXipQbfM4gtWb/QvBtOO3dQqDYQ6oTm0rZuDyRprUpJowZf2m3fqBxl/xBOcHY9zYU5fXFnteg9qia6Fr/CBn/nxzSbkV1SFVLIuSZ9Q42KB/Sz6iXybuPvfgzjIX6u3EL4Hk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=gQHXn0zn; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1740589423; bh=lRgrbi89RAPj6wGopHjUn9XlnG+mldWaZKc9kQI81BM=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=gQHXn0znSp/8ZBlIxfHyCNCgpKK4cR5SioN6O6ISpdQq2+jwSLvwqhHHv0NfKjhtb
	 rU2LJzexQAyi1Q5GmcWGeBqqB+QQglxxprhsuHyKPhDwnjwI4LH5bz+i3T/+LJTPoF
	 d+Wb5Qh68dK5uQ9KHQoi/LbGct10+71omlWOVBj8=
Date: Wed, 26 Feb 2025 18:03:42 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	quentin.schulz@cherry.de, sebastian.reichel@collabora.com, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 2/2] phy: rockchip: usbdp: re-init the phy on
 orientation-change
Message-ID: <h57ok2hw6os7bcafqkrqknfvm7hnu25m2oe54qmrsuzdwqlos3@m4och2fcdm7s>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, 
	sebastian.reichel@collabora.com, Heiko Stuebner <heiko.stuebner@cherry.de>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250225184519.3586926-1-heiko@sntech.de>
 <20250225184519.3586926-3-heiko@sntech.de>
 <7q5yn466xd7emebhjze4ixkswgyxjjjt5rwvyww2hwbts6bamd@i5vwvegy2os6>
 <1878927.BzM5BlMlMQ@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1878927.BzM5BlMlMQ@diego>

Hi Heiko,

On Wed, Feb 26, 2025 at 04:53:45PM +0100, Heiko Stübner wrote:
> Hey Ondřej,
> 
> Am Mittwoch, 26. Februar 2025, 15:46:11 MEZ schrieb Ondřej Jirman:
> > On Tue, Feb 25, 2025 at 07:45:19PM +0100, Heiko Stuebner wrote:
> > > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > > 
> > > Until now the usbdp in the orientation-handler set the new lane setup in
> > > its internal state variables and adapted the sbu gpios as needed.
> > > It never actually updated the phy itself though, but relied on the
> > > controlling usb-controller to disable and re-enable the phy.
> > > 
> > > And while on the vendor-kernel, I could see that on every unplug the dwc3
> > > did go to its suspend and woke up on the next device plug-in event,
> > > thus toggling the phy as needed, this does not happen in all cases and we
> > > should not rely on that behaviour.
> > 
> > On RK3399 there's a similar issue with the equivalent type-c PHY driver.
> > The TRM (part 2) states that:
> > 
> > 4.6.1 Some Special Settings before Initialization
> > 
> > - Set USB3.0 OTG controller AXI master setting.
> > - Clear USB2.0 only mode setting (bit 3 of register GRF_USB3PHY0/1_CON0 in Chapter GRF)
> > - USB3.0 OTG controller should be hold in reset during the initialization of the corresponding
> >   TypeC PHY until TypeC PHY is ready for USB operation.
> > - Set PHYIF to 1 to use 16-bit UTMI+ interface (see register GUSB2PHYCFG0)
> > - Clear ENBLSLPM to 0 to disable sleep and l1 suspend (see register GUSB2PHYCFG0)
> >   ...
> > 
> > The PHY for Superspeed signals is expected to be set up while the USB
> > controller is held in reset, which makes sense HW wise, and it's what downstream
> > kernel efectivelly does, via its RPM based hack.
> > 
> > RK3588 TRM doesn't have very detailed notes on this, but I expect it will be
> > similar.
> > 
> > So reconfiguring the phy here, while it's actively linked to the USB controller
> > without the controller driver driving the process so it reliably happens while
> > it's in reset, or at least so that USB controller reset happens afterwards, may
> > not be correct way to approach this.
> 
> the function here, is using infrastructure from the type-c framework.
> 
> The function in question tcpm_mux_set(), which then ends up in the
> usbdp_phy only gets called from tcpm_reset_port() .
>
> Which I think will do the right already - judging by its name ;-) .

No. This function has nothing to do with USB controller reset. And while  dwc3
driver consumes usb_role_switch interface, calling set_role on that interface
just translates to calling dwc3_set_mode(), which will do nothing if the mode
did not change from what it was previously. (and it stays the same if you just
re-plug the same device in same mode but just in different cable orientation)

Only time DWC3 reset seems to happen currently is sometimes in dwc3_set_mode()
depending on driver state, and then in dwc3_init()/exit() which is called only
at driver probe/remove time and in suspend/resume.

So if PHY driver reconfigures/"power-cycles" the PHY on its own, DWC3 driver
will not issue any reset to the controller HW, at least not based on the
set_role signal from usb_role_switch alone most of the time.

Also tcpm_orientation interface you use for PHY reset is called from many places
in TCPM driver, based on many events, mainly from tcpm_set_roles(), so you'll
be resetting the PHY quite a bit in uncoordinated manner with the dwc3 MAC
interface it's connected to in HW.

> [and also by the fact that the referenced qcom phy behaves similarly
>  when talking to the type-c framework]
> 
> 
> For the rk3399 I would think converting the old typec-phy-driver over to
> use the actual kernel type-c framework, might just magically solve the
> issue you have on it.

It will not. The problem is not getting the information about roles between the
drivers. extcon works fine for that. Problem is that your proposed solution
doesn't coordinate the PHY reset with USB controller to ensure proper ordering,
or even ensuring that any USB controller reset happens, or the controller knows
about the PHY reset.

Resulting issues may happen only occasionally, dunno. I guess it depends on
whether SS MAC will happen to be accessing USBDP PHY at the time when you're
turning off the PHY, and if this messes up the internal state of the MAC pipe
interface, so after PHY comes back up from reset state, whether that locks up
the MAC interface logic or not will depend on luck. :)

You can ask Rockchip what they think about uncoordinated PHY reset, while DWC3
is up and ready. Maybe it's ok on RK3588, but they're not doing it in their
vendor driver this way, and they forbid it on RK3399, so perhaps it's not? From
HW point of view it looks sketchy.

Kind regards,
	o.

> Rockchip actually has converted the rk3399 typec-phy to use the type-c
> framework in their vendor kernel.
> 
> 
> Heiko
> 
> 

