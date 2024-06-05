Return-Path: <linux-kernel+bounces-202131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8038FC81C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791DC1F22C4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C61922FD;
	Wed,  5 Jun 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlcUulu7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6821B18FC92;
	Wed,  5 Jun 2024 09:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580391; cv=none; b=PA/Fpfmkk6jGsXpI3Q0snul+Aq5ERcqIcgyAroG2Wt38QyDGNdXycUWsPlO2VnpwJx93PsAi1bSohZT3KDky97CN+E7PiAXyad/JlcJ5eq+M+1nN5hNGMqQWazYs3P9TwjZKCFY4CaHH/MCdRMuRC/3RECuxmicqnYi+tFB29og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580391; c=relaxed/simple;
	bh=J7yRwF0afgwLgQZjPbXaZOXLYV2ukwM/posUTXQ8C5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7QQ9Wwr8EUWiLiEILZ29SxnyoCD4qNk1ZK9kUdttb+v8HlBqHwyPexNMY5Bi7Gis1ob0Y1gcPkGO5VxUBOmb6tD2/4f5BRWF6tZYchUDBtHLuiDSW5v8Be5ls1uLHaHkLb9odDh+P5a9320K7HAyNRh7R3TKQGHuQABJs/WxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlcUulu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EC7C3277B;
	Wed,  5 Jun 2024 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717580391;
	bh=J7yRwF0afgwLgQZjPbXaZOXLYV2ukwM/posUTXQ8C5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlcUulu7IAzlmvbgh4sCqt7VcDrZrIkd7siZ3UYGrUQ2f9g+CNuiuVsCX7CDMG81C
	 6h2AWNO0uyGG+gq6YxEJd3yLCiPiSXamxkvWu8ZBZaSGUAQu0uOEIEUFodLJ5P0UFx
	 y8nD6ZpSdYt3t/RnSvbdhoFkBboFv83FR+XyyIwOS7QRacG3XNg9pUzAh0UdOdFb7l
	 tpQhuvO4VWVJ6nzSqybpve6CuXCq74yAjlDV5ME+T7PAfSHF5TO63NuNKaxzhjFM5I
	 HCukHj9uzXsUa2t94UMNuWGO5kRct2bQHn16RS/GeSjg+3f12/j/5LstjqJuzLthZy
	 JWaa4TnqcLi6w==
Date: Wed, 5 Jun 2024 11:39:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: neil.armstrong@linaro.org
Cc: Andy Yan <andyshrk@163.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Heiko Stuebner <heiko@sntech.de>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Yao <markyao0591@gmail.com>, Andy Yan <andy.yan@rock-chips.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>, 
	Luis de Arquer <ldearquer@gmail.com>, Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH 00/14] Add initial support for the Rockchip RK3588 HDMI
 TX Controller
Message-ID: <20240605-logical-piculet-of-democracy-6bc732@houat>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <a4b22708-e85d-448a-8145-244b49bca053@linaro.org>
 <ab0a6372-091b-4293-8907-a4b3ff4845c0@rock-chips.com>
 <11359776.NyiUUSuA9g@phil>
 <ef60403f-078f-411a-867b-9b551e863f56@linaro.org>
 <b8066150-c147-4eb6-9f7a-2bd0268c274e@collabora.com>
 <4456bc5a.9b2d.18fe7b76790.Coremail.andyshrk@163.com>
 <01bde68a-88a7-46eb-860c-1375aa730bec@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="4lab3i7lwv5psiqg"
Content-Disposition: inline
In-Reply-To: <01bde68a-88a7-46eb-860c-1375aa730bec@linaro.org>


--4lab3i7lwv5psiqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2024 at 11:28:41AM GMT, neil.armstrong@linaro.org wrote:
> Hi,
>=20
> On 05/06/2024 11:25, Andy Yan wrote:
> >=20
> > Hi,
> >=20
> > At 2024-06-05 04:33:57, "Cristian Ciocaltea" <cristian.ciocaltea@collab=
ora.com> wrote:
> > > On 6/3/24 4:08 PM, neil.armstrong@linaro.org wrote:
> > > > Hi,
> > > >=20
> > > > On 03/06/2024 15:03, Heiko Stuebner wrote:
> > > > > Am Montag, 3. Juni 2024, 14:14:17 CEST schrieb Andy Yan:
> > > > > > Hi Neil:
> > > > > >=20
> > > > > > On 6/3/24 16:55, Neil Armstrong wrote:
> > > > > > > Hi Christian,
> > > > > > >=20
> > > > > > > On 01/06/2024 15:12, Cristian Ciocaltea wrote:
> > > > > > > > The RK3588 SoC family integrates a Quad-Pixel (QP) variant =
of the
> > > > > > > > Synopsys DesignWare HDMI TX controller used in the previous=
 SoCs.
> > > > > > > >=20
> > > > > > > > It is HDMI 2.1 compliant and supports the following feature=
s, among
> > > > > > > > others:
> > > > > > > >=20
> > > > > > > .
> > > > > > >=20
> > > > > > > ..
> > > > > > >=20
> > > > > > > > * SCDC I2C DDC access
> > > > > > > > * TMDS Scrambler enabling 2160p@60Hz with RGB/YCbCr4:4:4
> > > > > > > > * YCbCr4:2:0 enabling 2160p@60Hz at lower HDMI link speeds
> > > > > > > > * Multi-stream audio
> > > > > > > > * Enhanced Audio Return Channel (EARC)
> > > > > > > -> Those features were already supported by the HDMI 2.0a com=
pliant
> > > > > > > HW, just
> > > > > > > list the _new_ features for HDMI 2.1
> > > > > > >=20
> > > > > > > I did a quick review of your patchset and I don't understand =
why you
> > > > > > > need
> > > > > > > to add a separate dw-hdmi-qp.c since you only need simple var=
iants
> > > > > > > of the I2C
> > > > > > > bus, infoframe and bridge setup.
> > > > > > >=20
> > > > > > > Can you elaborate further ? isn't this Quad-Pixel (QP) TX con=
troller
> > > > > > > version
> > > > > > > detectable at runtime ?
> > > > > > >=20
> > > > > > > I would prefer to keep a single dw-hdmi driver if possible.
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > The QP HDMI controller is a completely different variant with t=
otally
> > > > > > different
> > > > > > registers layout, see PATCH 13/14.
> > > > > > I think make it a separate driver will be easier for developmen=
t and
> > > > > > maintenance.
> > > > >=20
> > > > > I'm with Andy here. Trying to navigate a driver for two IP blocks=
 really
> > > > > sounds taxing especially when both are so different.
> > >=20
> > > Thank you all for the valuable feedback!
> > >=20
> > > > I agree, I just wanted more details than "variant of the
> > > > Synopsys DesignWare HDMI TX controller", if the register mapping is=
 100%
> > > > different, and does not match at all with the old IP, then it's ind=
eed time
> > > > to make a brand new driver, but instead of doing a mix up, it's tim=
e to
> > > > extract
> > > > the dw-hdmi code that could be common helpers into a dw-hdmi-common=
 module
> > > > and use them.
> > >=20
> > > Sounds good, will handle this in v2.
> > >=20
> > > > As I see, no "driver" code can be shared, only DRM plumbings, so pe=
rhaps
> > > > those
> > > > plumbing code should go into the DRM core ?
> > > >=20
> > > > In any case, please add more details on the cover letter, including=
 the
> > > > detailed
> > > > HW differrence and the design you chose so support this new IP.
> > >=20
> > > Andy, could you please help with a summary of the HW changes?
> > > The information I could provide is rather limited, since I don't have
> > > access to any DW IP datasheets and I'm also not familiar enough with =
the
> > > old variant.
> > >=20
> >   Accurately, we should refer to it as an entirely new IP=EF=BC=8Cit ha=
s nothing in common with
> > the current mainline dw-hdmi=E3=80=82 The only  commonality is that the=
y both come from
> > Synopsys DesignWare=EF=BC=9A
> > =EF=BC=881=EF=BC=89It has a 100% different register mapping
> > =EF=BC=882=EF=BC=89It supports FRL and DSC
> > =EF=BC=883=EF=BC=89different configuration flow in many places=E3=80=82
> >=20
> > So I have the same feeling with Heiko and Maxime=EF=BC=9A
> > The DW_HDMI_QP should have a  separate driver and with it's  own CONFIG=
  such as DRM_DW_HDMI_QP  in Kconfig.
> > and the rockchip part should also be split from dw_hdmi-rockchip.c.
> > I am sorry we mixed them in dw_hdmi-rockchip.c when we develop the bsp =
driver=EF=BC=8Cbut we really regretted this decision
> > when  we repeatedly broke compatibility with dw-hdmi on other socs=E3=
=80=82
>=20
> Yes please, and as I say, if there's code common with the old dw-hdmi, pl=
ease add a common
> module if this code can't be moved in core bridge helpers.

And chances are that the common code is actually there to deal with HDMI
spec itself and not really the hardware, which is solved by moving both
drivers to the HDMI helpers that just got merged.

Maxime

--4lab3i7lwv5psiqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZmAyYAAKCRAnX84Zoj2+
dvaqAX4y01HbYFGYRCxGaafC276+nuXwpR95Ld6A8is239CcMgThYuCv5bGLZuLM
Y5UKnKkBf3NBz6lmlnwNKqUuPwmYn9qW/A7HeWtMIN7NIryQcd925sIKivtFZ0PF
L1JgyrfHwA==
=KSkS
-----END PGP SIGNATURE-----

--4lab3i7lwv5psiqg--

