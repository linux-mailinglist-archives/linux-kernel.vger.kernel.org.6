Return-Path: <linux-kernel+bounces-531272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE34A43E61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB5A1656E8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F09A26868B;
	Tue, 25 Feb 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axOr7SQB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA01B267B8B;
	Tue, 25 Feb 2025 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484373; cv=none; b=poWIJSvVKy2TehaaHLsRIb0GfHPjoAYPdMMXLXnwfWpxIrcFmBwZk2+sL5I3dAfQ6l9VA5vDBl+aiF8OVZvLhQoMQ0a8ehoLBV9B8t6HZoHnZ9RCruTLE2s6Cz8crmG3DXdGsnuglQKlfWH+0TKjoPxf7monH/77rzv7QsTKKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484373; c=relaxed/simple;
	bh=hSHb3rOa9k5tsPmaPPeA5bikJl+Av+tcshX5VjzhvP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsLABwmXe1J+yhMKrJc8f3Q5qutjXkpuhtyyADhtk12pCIeILZLy64GOD4UEFAgNOrWPdwTg1G4S9rbwIdFVvG9bVb9EBoIFJvQxtCnrcgXmjXmF0rxvY+E9r8MXeGgoq13hfm1yJ2VeiIxcCPBfeqNi3ANvuXvD3pQ76wLOKjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axOr7SQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803AEC4CEDD;
	Tue, 25 Feb 2025 11:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740484373;
	bh=hSHb3rOa9k5tsPmaPPeA5bikJl+Av+tcshX5VjzhvP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axOr7SQBeGTA3q1VBqZiED6W6FPt3G7EHRdpdlPTJ0aengiP2RL4qJAdZWRpjahev
	 cDz78xYjfg9QCWpj4+1wn4OPbZxS/oPm5lQvVulupYW2VrnWu9g0+hl1zvPCcEKwPQ
	 GjQqtL0Wl1GPrV/BonDqWLaNdgTD+pl8eAhReFDmL5VD2aAJSHg4aKnwmao35N6n9h
	 srvpA/g6CXOqMvbFoVB4cuSwEPPw3JCFxB8A8W23s/NxTasqq/ZWVVGLJddeeDW0iH
	 2EMxexvwXOQr7cbFohPt+WksCavde2D181k0HtfIMi7HlNJY1s1ia5TziH+sey/x+B
	 DfF36Ne7eCc5Q==
Date: Tue, 25 Feb 2025 12:52:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
Cc: Rob Herring <robh@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 05/14] dt-bindings: trivial-devices: add GOcontroll
 Moduline IO modules
Message-ID: <20250225-smart-industrious-groundhog-41deb2@krzk-bin>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-5-5ccbbf613543@gocontroll.com>
 <20250224204428.GA4050751-robh@kernel.org>
 <PA4PR04MB763009E88F6406CD84ACBD33C5C32@PA4PR04MB7630.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PA4PR04MB763009E88F6406CD84ACBD33C5C32@PA4PR04MB7630.eurprd04.prod.outlook.com>

On Tue, Feb 25, 2025 at 07:39:52AM +0000, Maud Spierings | GOcontroll wrote:
> From:=C2=A0Rob Herring <robh@kernel.org>
> Sent:=C2=A0Monday, February 24, 2025 9:44 PM
> =C2=A0
> >On Mon, Feb 24, 2025 at 02:50:55PM +0100, Maud Spierings wrote:
> >> The main point of the Moduline series of embedded controllers is its
> >> ecosystem of IO modules, these currently are operated through the spid=
ev
> >> interface. Ideally there will be a full dedicated driver in the future.
> >>
> >> Add the gocontroll moduline-module-slot device to enable the required
> >> spidev interface.
> >>
> >> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> >> ---
> >>=C2=A0 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >>=C2=A0 1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/=
Documentation/devicetree/bindings/trivial-devices.yaml
> >> index 8255bb590c0cc619d15b27dcbfd3aa85389c0a54..24ba810f91b73efdc615c7=
fb46f771a300926f05 100644
> >> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >> @@ -107,6 +107,8 @@ properties:
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fs=
l,mpl3115
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 # MPR121: Proximity Capacitive Touch Sensor Controller
> >>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fs=
l,mpr121
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # =
GOcontroll Moduline module slot for spi based IO modules
> >
> >I couldn't find anything about SPI for GOcontroll Moduline. Can you
> >point me to what this hardware looks like. Based on what I did find,
> >this seems incomplete and not likely a trivial device.
>=20
> I'll give some more details, if there is a v2 of this patch I will also
> add more information in the commit message.
>=20
> The module slots have a number of pins, a lot of them currently unused as
> they have not found a function yet, this is very much still a developing
> product. The currently used interfaces to the SoC are:
> 1. SPI bus as a spidev to ease developing new modules and quickly
> integrate them. This is the main communication interface for control and
> firmware updates.
> 2. A reset pin, this is/was driven with the gpio-led driver but I doubt
> that would get accepted upstream so I intend to switch to the much better
> suited libgpio.

reset-gpios is not in trivial devices, so that's already a hint you
cannot use this binding.

> 3. An interrupt pin, this is currently only used in the firmware update
> utility [2] to speed up the update process. Other communication is done at
> a regular interval.
>=20
> What is unused:
> 1. A potentially multi-master i2c bus between all the module slots and
> the SoC
> 2. An SMBus alert line is shared between the modules, but not the SoC.
> 3. A shared line designated as a clock line, intended to in the future
> aid with synchronizing modules to each other for time critical control.
>=20
> current software that is used to work with the modules can be found at
> [2] and [3], one of them is a Node-RED module the other is a blockset for
> Matlab/Simulink generated code.
>=20
> If you know a better way I could describe this in the devicetree then I

You need dedicated binding where you describe entire device, entire
hardware, not what your driver supports in current release.

Best regards,
Krzysztof


