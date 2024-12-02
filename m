Return-Path: <linux-kernel+bounces-427768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F679E07BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F3CB85F3B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4A207A3E;
	Mon,  2 Dec 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="K4XJfP9w"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC2207A1C;
	Mon,  2 Dec 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150561; cv=pass; b=oobdbVTAJGuC9Gj9y4C5O1OjrWwBdH7MJlRHOA2OqLt4wXZYizaDtDiVBRvgdQqmm5OZKiSYODrxJ4lJGfExXQXZIBJug2EjoPltBvm058ZXmGfMeshKkQMfWPiybiQu9s2kiVGAH/Zc5cGt9QbvAdqMw/jhDtJ4tXlbAaXPtXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150561; c=relaxed/simple;
	bh=FKu2C5I4ZzzEZcVt0DYQa08NfShMuxDYJ69UNsolG6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmTx45ISZWC20zybJwoRX2+cBYaOKELNKREgs4jeRO/Ni8df8ovfAMBhOc+HVgSrHcBIr+DZdqK8yC44HnTjIbzfnP26EWVUd6kvrKgG6hUkg4m/o6MlU0FKsotTEQC8XXo81UlPJ6/57BRkbShpoyaFzfYId0Mn+1Veexou9/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=K4XJfP9w; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1733150530; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kzIJqdKPHsE+h/I1bVb4WwROt1JmRDQXvovJ7VAW9HYw13UuMinvlVQrrnY4zOEUmwT8bbRFL4HFh77iOh9/jM61WSIBYwE0UREpblGiyujpifQRWAzBndKljiYjA1F2A8gL0GPQdZ/Po34+P4ebdMaZzhWeJByJxL22v9B0+cs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1733150530; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PyoyGOlmk+ezHmLvq5i2fa6R0sXOpfhduauleI3aZu8=; 
	b=Qcg2qA+p3qls92P7rCygyJuLmklGFQCAWiOY61F57HlUGNi/+ZjA313BOhQhWTh1EGeVtX+wthDYPfbDuDuhNLxvkiMW59Hlm7f7ofdAfFokQfcZtmhpahwmVWC9aiTOw8c+j9lxvtGEvw+UFEhlcfnVPEVjIoY5yRN3X71Iu9U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1733150524;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PyoyGOlmk+ezHmLvq5i2fa6R0sXOpfhduauleI3aZu8=;
	b=K4XJfP9wymON87VKaDhOVYFPndiX+gggtIAZT25OJg5kf9wNwwMg4+d5DXK+BI1Z
	FZclUN5/K3WKu0QNrto1pHFHpJCIJJUoR3YYIFsoSMJLLQsFJL/DHvGsZFhtWIee/Mx
	K+pj353TTEL4R61UBpXWjzmjWSpPBpcLhQS9POjU=
Received: by mx.zohomail.com with SMTPS id 1733150513461951.7229974767481;
	Mon, 2 Dec 2024 06:41:53 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id B8AC010604CF; Mon, 02 Dec 2024 15:41:47 +0100 (CET)
Date: Mon, 2 Dec 2024 15:41:47 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, rfoss@kernel.org, vkoul@kernel.org, 
	cristian.ciocaltea@collabora.com, l.stach@pengutronix.de, andy.yan@rock-chips.com, 
	hjc@rock-chips.com, algea.cao@rock-chips.com, kever.yang@rock-chips.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v1 04/10] phy: phy-rockchip-samsung-hdptx: Add support
 for eDP mode
Message-ID: <abzu2chif2g3urxoqbm3gbe6cciexbmqvn44qezrx4hgllfkkn@7bzi5jl3stqe>
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
 <2131853.KlZ2vcFHjT@diego>
 <6e1f35c0-5ea8-414f-b3ea-4e7222c605ef@rock-chips.com>
 <2886747.Y6S9NjorxK@diego>
 <h4giob7bcrh7qmtepti6huym2llw4ujfmeff76vrgpahb5zy6x@dz6zghsifww5>
 <2342f342-672c-447e-90d8-674b748af6a4@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6udmcollucmigcpf"
Content-Disposition: inline
In-Reply-To: <2342f342-672c-447e-90d8-674b748af6a4@rock-chips.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.3.1/233.118.59
X-ZohoMailClient: External


--6udmcollucmigcpf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 04/10] phy: phy-rockchip-samsung-hdptx: Add support
 for eDP mode
MIME-Version: 1.0

Hi,

On Mon, Dec 02, 2024 at 11:28:13AM +0800, Damon Ding wrote:
> Hi,
>=20
> On 2024/12/2 6:59, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Sat, Nov 30, 2024 at 09:25:12PM +0100, Heiko St=FCbner wrote:
> > > Am Freitag, 29. November 2024, 03:43:57 CET schrieb Damon Ding:
> > > > On 2024/11/27 19:04, Heiko St=FCbner wrote:
> > > > > Am Mittwoch, 27. November 2024, 12:00:10 CET schrieb Damon Ding:
> > > > > > On 2024/11/27 17:29, Heiko St=FCbner wrote:
> > > > > > > Am Mittwoch, 27. November 2024, 08:51:51 CET schrieb Damon Di=
ng:
> > > > > > > > +static int rk_hdptx_phy_set_mode(struct phy *phy, enum phy=
_mode mode,
> > > > > > > > +				 int submode)
> > > > > > > > +{
> > > > > > > > +	return 0;
> > > > > > > > +}
> > > > > > > analogix_dp_phy_power_on
> > > > > > > I think it might make sense to go the same way as the DCPHY a=
nd also
> > > > > > > naneng combophy, to use #phy-cells =3D 1 to select the phy-mo=
de via DT .
> > > > > > >=20
> > > > > > > See [0] for Sebastians initial suggestion regarding the DC-PH=
Y.
> > > > > > > The naneng combophy already uses that scheme of mode-selectio=
n too.
> > > > > > >=20
> > > > > > > There is of course the issue of backwards-compatibility, but =
that can be
> > > > > > > worked around in the binding with something like:
> > > > > > >=20
> > > > > > >     '#phy-cells':
> > > > > > >        enum: [0, 1]
> > > > > > >        description: |
> > > > > > >          If #phy-cells is 0, PHY mode is set to PHY_TYPE_HDMI
> > > > > > >          If #phy-cells is 1 mode is set in the PHY cells. Sup=
ported modes are:
> > > > > > >            - PHY_TYPE_HDMI
> > > > > > >            - PHY_TYPE_DP
> > > > > > >          See include/dt-bindings/phy/phy.h for constants.
> > > > > > >=20
> > > > > > > PHY_TYPE_HDMI needs to be added to include/dt-bindings/phy/ph=
y.h
> > > > > > > but PHY_TYPE_DP is already there.
> > > > > > >=20
> > > > > > > That way we would standardize on one form of accessing phy-ty=
pes
> > > > > > > on rk3588 :-) .
> > > > > > >=20
> > > > > > > Also see the Mediatek CSI rx phy doing this too already [1]
> > > > > > >=20
> > > > > > >=20
> > > > > > > Heiko
> > > > > > >=20
> > > > > > > [0] https://lore.kernel.org/linux-rockchip/udad4qf3o7kt45nuz6=
gxsvsmprh4rnyfxfogopmih6ucznizih@7oj2jrnlfonz/
> > > > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/=
linux.git/tree/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx=
=2Eyaml
> > > > > > >=20
> > > > > >=20
> > > > > > It is really a nice way to separate HDMI and DP modes.
> > > >=20
> > > > I apologize for reopening the discussion about the phy-types settin=
g.
> > >=20
> > > there is definitly no need to apologize. We're trying to find the best
> > > solution afterall :-) .
> > >=20
> > > > With the .set_mode() of struct phy_ops, the HDMI and eDP dynamic
> > > > switching can be achieved, which just depends on the right setting =
of
> > > > enum phy_mode in include/linux/phy/phy.h. So the previous way of
> > > > configuring phy mode may be also good.
> > >=20
> > > I think the deciding factor is, is there a use-case for needing to sw=
itch
> > > modes at runtime.
> > >=20
> > > I do think the mode for the dc-phy and also the hdptx-phy is pretty m=
uch
> > > decided by the board design.
> > >=20
> > > I.e. when you end up in a DP-connector (or eDP-panel) on your board y=
ou
> > > need DP mode, and when you end up in a hdmi-connector you need the
> > > HDMI phy mode.
> > >=20
> > > So I think the phy-mode for the hdptx-phy is largely dictated by the =
static
> > > board definition (like devicetree), hence going with the dt-argument =
for
> > > the mode.
> > >=20
> > > Like similar to the Naneng combophy, selecting its mode via argument
> > > because deciding if it ends up in a sata port is a board-design thing.
> > >=20
> > > Is there a use-case where you need to switch at runtime between
> > > HDMI and eDP? Like starting the phy in eDP mode but then needing
> > > to switch to HDMI mode, while the device is running?
>=20
> Indeed, we have the board as you described, on which the DP-connector and
> HDMI-connector both have been configured.
>=20
> And the dynamic switching is more useful for RK3576, which has the same
> eDP/HDMI design as RK3588 but only one eDP controller/HDMI controller/HDP=
TX
> phy. We can only enable both of eDP/HDMI by this way.
>=20
> >=20
> > I believe the eDP controller can only use the PHY in eDP mode and
> > the HDMI controller can only use it in HDMI mode. So in order to
> > support runtime switching, the following options are possible:
> >=20
> > 1. Enable both controllers, the PHY decides which one is really
> >     used, the other one is basically a non-functional dummy device
> >     until the PHY is reconfigured. This requires the set_mode()
> >     callback, since the HDMI and eDP drivers both expect their
> >     PHY to be enabled.
> >=20
> > 2. Properly enable / disable the used controller, so that only one
> >     controller is active at the same time. In this case the switching
> >     is handled one layer above and the PHY has nothing to do with it.
> >     The phy_enable call from each controller would just set it up in
> >     the right mode.
> >=20
> > I guess option 1 is the hacked solution, which is easier to
> > implement as DRM's hotplug abilities are quite limited at the moment
> > as far as I know. I think the second solution looks much cleaner and
> > should be prefered for upstream. That solution does not require
> > calling set_mode() for runtime switching making this whole argument
> > void :)
> >=20
>=20
> Your friendly and detailed analysis has brought me some valuable insights.
> :)
>=20
> The option 2 is really a better way to support the dynamic switching, and=
 we
> still need the .set_mode() to select the configurations for either eDP or
> HDMI in HDPTX phy at the controller level. Would you mind
> elaborating on the useful way to choose the phy mode for the second
> solution?

The xlate function to handle the arguments is called when the PHY
device is looked up. So the devm_phy_get(dp->dev, "dp") call in
analogix_dp_probe() would setup the PHY in DP mode.

Similarily the call to devm_of_phy_get_by_index() in
dw_hdmi_qp_rockchip_bind() would set the PHY in HDMI mode.

So the PHY mode is correct as long as only one controller driver
is bound at the same time.

Greetings,

-- Sebastian

> > FWIW I think the DT argument based mode setting and the runtime set_mode
> > are not necessarily mutual exclusive. In theory one could support both
> > and adding set_mode support later does not change any ABI as far as
> > I can see. Basically handle it like pin mux/configuration settings,
> > which are usually automatically handled by the device core based on
> > DT information, except for some drivers which have special needs.
> >=20
>=20
> > > > And other phys may want to support dynamic switching too, like the
> > > > Rockchip USBDP combo phy.
> > >=20
> > > I guess USBDP is special in that in also does both modes dynamical
> > > depending on its use (like type-c with option DP altmode)
> >=20
> > The USBDP PHY is indeed quite different from the PHYs in your list
> > above, but for a different reason: All the combined PHYs you listed
> > above only support one mode at the same time. E.g. you need to
> > decide between PCIe, SATA and USB3 mode for the Naneng combophy.
> >=20
> > For the USBDP PHY the modes are not mutually exclusive. The USB
> > controller can request the USBDP PHY in USB mode at the same time
> > as the DP controller requests it in DP mode. Some additional
> > registers configure how the lanes are being muxed. A typcial setup
> > would be 2 lanes for USB3 and 2 lanes for DP.
> >=20
> > Greetings,
> >=20
> > -- Sebastian
>=20
> Best regards,
> Damon
>=20

--6udmcollucmigcpf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmdNxyUACgkQ2O7X88g7
+ppNBg/+OodeJz9zzOuukrua6cpAm7TmVJxnPSs0TMsHKsY+ZHlUpFvLBzCgtOJT
0Uzs1ae7DnwwOaZjqhm9eRjx3at63sy7LMSKl0LWb1wHMyr9Gg0yLouhvRj9O8NT
3G9ZgGLK2IfhL5y5e0MQhBVDD8Ib/Q5OS5qzhxfQA9fKPpkji0NnJHVfiEDJzDTp
vUxKZi635aPI/2FbsEMbiMgeItxHF1HyOSuccBhvA342l1R9bB5IXoK41rTKZQ3d
9NsUpvB7KN62oDfLC6iZit0/fZzy4eH1iv9zEAGrA18h9E42EHVOJFey8OMRVBX+
dL++z1draffk+MzsL+T5pnMvumqZdoHIgFp6avMxSgC9ppOYjPXNZ4JUJYNA6u3Z
oivDNCr0z960fsI9ynZNXr9aS2u5eXPRVJfOL9WRic9AWpdscrAonBYFZJ1eUeeU
C9dxORl8uWri/K6FUXc9SWWSVq34eY+DiRT8rOviH4ridpH0M71Dzpw8GfabWvjT
z5233amu9arUqf5O6vySvqmwB7TvcXyzAZSJ2XYieHvDsuUEwoebAEl2WdFcwgFJ
97TNcxCCGE0xJNzZ6QsQTCDKHA4DMza1ioo8YWGRuZEqwphpMZY7GapSUWXCVNGG
L3RpcHdmehiyNg7ikKc2P8U3EU/3MBL8B9Qi2WV4Ufc+DIhmlfA=
=Oin5
-----END PGP SIGNATURE-----

--6udmcollucmigcpf--

