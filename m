Return-Path: <linux-kernel+bounces-547837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F2A50E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9BC18919E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D72263C9B;
	Wed,  5 Mar 2025 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="cZMa76wQ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E518E362
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211579; cv=pass; b=F57I1Wtm+34y83/zjbSZ8kuQqGK/CbVS5ZTxZyvRn0skd9DINeevX40s6t+cSLwYItBZxKJYWGgIOTGW4206kyFBTBKEMU/BkK//FLgPjDtVGU2uDIgQ6Ag5XY8Z8sDc0tsN7kw3tWAZWol8G9A1NhDsFMTP06xgHCEqkPhUmck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211579; c=relaxed/simple;
	bh=GaMaMg3VwbCFWstimVr6jj6x7MGRDFM+mLVf73o03w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBZikWCzSp+uqeM8egmfoIp5J4BWcYjPsAyvxPl9pzsKfAssRRb/oyhlk1ru0ml4TUwYLhcsG9TBQOyBvgUt0FZjwJ5j9BgxLQeKpQrjF4LprkZAMzQArEP+IESWkej+K8IN8bIXkxD6dVfbqgCCPLpwoWDSjeNPlwJY1sxBaFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=cZMa76wQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741211562; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bSYuxnUV/HlBSWa6+7SS5YTvWhp+Ct50cQeBrWYEQX1PzEMcsTgWTnZJIaynTXzpQga+MAFCFr7LTZRDwj380WIWlV4edsYpkysmjpmjzephoyehMA0Jvq2B+5rqbFA0a3ZxoZElJRA8bX9AT6+/C8Xukgy+YzTZxkvadZG8GVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741211562; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GaMaMg3VwbCFWstimVr6jj6x7MGRDFM+mLVf73o03w8=; 
	b=LmZUklc+fumaxBKpMqOD8YXBybgcx42/BGMFWi22TeQctlrvH5Ma6h/uGCzyobic0ii+IFAfkr9KDvKle+eOHuCTu6jXAWCGPD8nEfmkIimwQBKuGKfciJA1guDsvzNOKcGhTLLXzQ43ihQD/RcOGCJwrM0of8/m+M4amWFc5kw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741211562;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=GaMaMg3VwbCFWstimVr6jj6x7MGRDFM+mLVf73o03w8=;
	b=cZMa76wQUcbJQCaInUNdiMEscPAH5rlre70ucJ/is6YNhsBe7fJm67efDeBLtIHA
	I9v+8/IfeitwCAAxAWcMrXIc/nYSc27CnMMPROr5KX9SbvK7omVMXy09oG1Jj/3dqzD
	Zn3GRb1azwjKMPE8fYQ1iOL67GBYcNBHarZRccVk=
Received: by mx.zohomail.com with SMTPS id 1741211559978795.5927922700267;
	Wed, 5 Mar 2025 13:52:39 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 08608183465; Wed, 05 Mar 2025 22:52:36 +0100 (CET)
Date: Wed, 5 Mar 2025 22:52:36 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/2] phy: rockchip: usbdp: re-init the phy on
 orientation-change
Message-ID: <4mhobm5oxhjim6m2dwzmt63riuoruwaivmftnuaodwvplnleeg@w7yyv3zyxewe>
References: <20250226103810.3746018-1-heiko@sntech.de>
 <20250226103810.3746018-3-heiko@sntech.de>
 <02757b21-7599-4ee7-9f97-247b04ba646a@cherry.de>
 <dkjpudmzuuxvaotz4mx46yx7iacof7q6ck746j3rrqvlgbq3hk@6vtvy3gy3kff>
 <2af85aa0-96dc-43ea-9542-88f91b21a028@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iiki2smch4scccrq"
Content-Disposition: inline
In-Reply-To: <2af85aa0-96dc-43ea-9542-88f91b21a028@cherry.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/241.192.19
X-ZohoMailClient: External


--iiki2smch4scccrq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] phy: rockchip: usbdp: re-init the phy on
 orientation-change
MIME-Version: 1.0

Hi,

On Mon, Mar 03, 2025 at 10:27:31AM +0100, Quentin Schulz wrote:
> On 3/1/25 10:19 PM, Sebastian Reichel wrote:
> > On Wed, Feb 26, 2025 at 01:38:10PM +0100, Quentin Schulz wrote:
> > > Unrelated to this patch (but may be triggered by this patch?), I'm wo=
ndering
> > > how flip is really handled.
> > >=20
> > > It seems like we have flip store the orientation of the cable, but al=
so if
> > > rockchip,dp-lane-mux is set to <0 1>. But wouldn't that break if we i=
gnore
> > > that initial flipped lane-mux whenever a USB-C cable is inserted in r=
everse?
> > > Basically, shouldn't a reserve orientation of the cable when
> > > rockchip,dp-lane-mux is set to <0 1> mean "normal mux"?
> >=20
> > If a USB-C connector is involved, the TypeC controller is supposed to
> > setup the lane muxing based on the connector orientation. This
> > happens via the typec API and in this hardware setup the PHY should
> > not have the rockchip,dp-lane-mux DT property set.
> >=20
>=20
> I could see some HW routing "mistake" where the USB-C connector in normal
> orientation has DP lanes routed to RX1/TX1? Or is this expected to just be
> faulty HW we shouldn't attempt at supporting?

You mean somebody routing the RK3588 SSTX1 and SSRX1 pins to SSTX2
and SSRX2 of the TypeC connector and vice versa and thus effectively
inverting the orientation on their board? I would say let's worry
about that once somebody comes up with such a cursed hardware design.

Note, that rockchip,dp-lane-mux wouldn't be a good property for this
setup either. With USB-C you don't necessarily have 2 lanes USB3 and
2 lanes DP. You can also have 4 lanes USB3 (not supported by RK3588)
or 4 lanes DP (should be supported by RK3588 hardware). So
hardwiring the mux is a bad idea. Probably would require some flag
for the TypeC orientation switch to handle the orientation
information inverted.

> > The rockchip,dp-lane-mux property is required if no USB-C connector
> > is involved. For example if the lanes are routed to a Displayport
> > connector. In that case the lane setup is fixed in hardware and
> > there is no TypeC controller involved, which could do any setup ;)
> >=20
>=20
> Yup I've seen that for the Rock 5 ITX and the evaluation board(s) do this.
> Quite interesting :)
>=20
> Cheers,
> Quentin

Greetings,

-- Sebastian

--iiki2smch4scccrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfIx58ACgkQ2O7X88g7
+pp5wQ//ekpa+pqaf5idL+GfqVxmJL7gdtHvObD3VNfYoGb7LNc6EE6qgaaQqaEf
CtyGW2XxjxkaWp2uJRrpQt8jAMy6kRI/gItvrFoa7pIZQaaJoqJyFPCSp9mL+eWf
b8FBt531ViEd7TGendoNL9cpVKmnO6UjgMKtd3dppB6K/hBcWeUljojGHjBt9uz6
AC0RhTR2+2P+IOoqWCS5Bb5VOqkPCX3VSdWrzKN/qMqynlOAk6o0Ar/qVyUaGztQ
ezcRh/C38WsOWVFey8xTX43yyfUg+e5axYVTYvBXcL52qlQbXwxIsiKr2kQIXpRM
0UAhywLTgeo5ZfSTtXwidwAuX00qdGRUSlbH+0rcfB8wQESaoqhZDJ2Pr2sSgmZL
/lubA8hOtGjQ18L8rz87qjL8bugSk8ua15WDZq8wqY3CQ3u+3eQB8A1RNZOOJqd/
EoJ26yr4hciaGy9aaGRX4MEuMK4K5cJTIaHeOtidQvuACp96bnA9uXLB2lBdAp7S
1Ypyu6qH0xyOsMossSUg0ud+kWHLi/FPnifWo6aBIh3lrkSmfe6d5cyvVhMFOcYb
bHu0ArA7u9b7nyyj0Rs5G+No8s94aobpfgpUjHOSzJhhbCXy6vidrJZAzwtF1dWB
2e7ulm4IPup6C4fNBcWnC19XJaoepWF5BskB+BkLo+/Sa9BcErY=
=+9iz
-----END PGP SIGNATURE-----

--iiki2smch4scccrq--

