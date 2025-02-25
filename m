Return-Path: <linux-kernel+bounces-531604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53305A442A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D868B1895D19
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25E26B2A6;
	Tue, 25 Feb 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tB6gpsOp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CF26B0B6;
	Tue, 25 Feb 2025 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493246; cv=none; b=nGPyXPo1vgV7R12MrcrwVjQPhHwkYW+wmUw4vOtK4KWqBT+D1Uc1LS+Q+8PyRDm6p++9ZZplFGjgp1vwkU7XSaixkgXZ6y/0laXzelqAJ79Twh8BqtllrhCJGwo8wK3Znh/CXfW5zOhMQvnXmnxnL3S/U4o87v9ZH7vPPWRYdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493246; c=relaxed/simple;
	bh=eDBxPB2ey6CEl5Fn4xbiSGUKr6VohrZZtt7brOucJf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7YgSu23OeSXrgEYmBTcusfSWxKCw/H/ikJWFaAvdkbp33iLRffeUm1VXMWbEZhVOvsjXo8LsamRbKBdUGE7cLWRAPkvgndSAQDRcmsR0CzjzqU//4o8gtAulv3vYHQvdTgIN7xEF9zRUfsm+MLYcF9O8VOFKZ9Rb7UzzCNIBSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tB6gpsOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AC2C4CEDD;
	Tue, 25 Feb 2025 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740493246;
	bh=eDBxPB2ey6CEl5Fn4xbiSGUKr6VohrZZtt7brOucJf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tB6gpsOpZKp5aTOboDdyxR0i9eLXFNrNmyJ2DQAcxZG7y0ROWfd86e0ofq4/C3GmW
	 EoCE+8hsHyQGRO/TQXvZQdoSp9FTZkRL/VMEmLJjvofLyy3tzlQwy+CQJ45ZX/HxYM
	 qYoEvZyo6xCSG6gT0xlwTda3Y6XBPkTinf/6qbuTQCzHwPgfynS90twSPxcsBZI+Pq
	 G09SKxwrVNnJdcStCTcZBUYGHwHDk6SFEZsdeEasBb73x2fyoBXbk5v6ca2PkcAj0N
	 pwBFnmEMnFTVvBKPYPiKIQUcq9Fi8M1eepSTS3PR0XBqAycnnW8jxPdnfYbo13+5WQ
	 b0QY4QMg0kaAw==
Date: Tue, 25 Feb 2025 08:20:43 -0600
From: Rob Herring <robh@kernel.org>
To: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Sam Ravnborg <sam@ravnborg.org>, Liu Ying <victor.liu@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 05/14] dt-bindings: trivial-devices: add GOcontroll
 Moduline IO modules
Message-ID: <20250225142043.GA2173114-robh@kernel.org>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
 <20250224-initial_display-v1-5-5ccbbf613543@gocontroll.com>
 <20250224204428.GA4050751-robh@kernel.org>
 <PA4PR04MB763009E88F6406CD84ACBD33C5C32@PA4PR04MB7630.eurprd04.prod.outlook.com>
 <20250225-smart-industrious-groundhog-41deb2@krzk-bin>
 <PA4PR04MB76306D77C93FF2C51524BD95C5C32@PA4PR04MB7630.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PA4PR04MB76306D77C93FF2C51524BD95C5C32@PA4PR04MB7630.eurprd04.prod.outlook.com>

On Tue, Feb 25, 2025 at 12:24:09PM +0000, Maud Spierings | GOcontroll wrote:
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Tuesday, February 25, 2025 12:52 PM
>  
> >On Tue, Feb 25, 2025 at 07:39:52AM +0000, Maud Spierings | GOcontroll wrote:
> >> From: Rob Herring <robh@kernel.org>
> >> Sent: Monday, February 24, 2025 9:44 PM
> >>  
> >> >On Mon, Feb 24, 2025 at 02:50:55PM +0100, Maud Spierings wrote:
> >> >> The main point of the Moduline series of embedded controllers is its
> >> >> ecosystem of IO modules, these currently are operated through the spidev
> >> >> interface. Ideally there will be a full dedicated driver in the future.
> >> >>
> >> >> Add the gocontroll moduline-module-slot device to enable the required
> >> >> spidev interface.
> >> >>
> >> >> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> >> >> ---
> >> >>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >> >>  1 file changed, 2 insertions(+)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> >> >> index 8255bb590c0cc619d15b27dcbfd3aa85389c0a54..24ba810f91b73efdc615c7fb46f771a300926f05 100644
> >> >> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >> >> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >> >> @@ -107,6 +107,8 @@ properties:
> >> >>            - fsl,mpl3115
> >> >>              # MPR121: Proximity Capacitive Touch Sensor Controller
> >> >>            - fsl,mpr121
> >> >> +            # GOcontroll Moduline module slot for spi based IO modules
> >> >
> >> >I couldn't find anything about SPI for GOcontroll Moduline. Can you
> >> >point me to what this hardware looks like. Based on what I did find,
> >> >this seems incomplete and not likely a trivial device.
> >>
> >> I'll give some more details, if there is a v2 of this patch I will also
> >> add more information in the commit message.
> >>
> >> The module slots have a number of pins, a lot of them currently unused as
> >> they have not found a function yet, this is very much still a developing
> >> product. The currently used interfaces to the SoC are:
> >> 1. SPI bus as a spidev to ease developing new modules and quickly
> >> integrate them. This is the main communication interface for control and
> >> firmware updates.
> >> 2. A reset pin, this is/was driven with the gpio-led driver but I doubt
> >> that would get accepted upstream so I intend to switch to the much better
> >> suited libgpio.
> >
> >reset-gpios is not in trivial devices, so that's already a hint you
> >cannot use this binding.
> >
> >> 3. An interrupt pin, this is currently only used in the firmware update
> >> utility [2] to speed up the update process. Other communication is done at
> >> a regular interval.
> >>
> >> What is unused:
> >> 1. A potentially multi-master i2c bus between all the module slots and
> >> the SoC
> >> 2. An SMBus alert line is shared between the modules, but not the SoC.
> >> 3. A shared line designated as a clock line, intended to in the future
> >> aid with synchronizing modules to each other for time critical control.
> >>
> >> current software that is used to work with the modules can be found at
> >> [2] and [3], one of them is a Node-RED module the other is a blockset for
> >> Matlab/Simulink generated code.
> >>
> >> If you know a better way I could describe this in the devicetree then I
> >
> >You need dedicated binding where you describe entire device, entire
> >hardware, not what your driver supports in current release.
> 
> I see now that I also forgot the patch that adds this compatible to the
> spidev driver. Didn't check for the spidevs in testing I guess.
> 
> Could I write bindings for this device, and then add the compatible to the
> spidev driver for now? So it probes that driver, and then later when there
> is a driver remove the compatible there and keep it only in the purpose
> built driver?
> 
> So I'll write gocontroll,moduline-module-slot.yaml, don't quite know where
> that would go. Define all these attributes in there and then add the 
> compatible to drivers/spi/spidev.c
> 
> Is that okay?

Yes. Bindings are forever, but drivers change. ;)

Perhaps put it in connector/ as this looks a bit like a connector. Do 
you envision DT overlays for the IO modules? Or modules don't have 
sub-devices you need to describe? There's some effort to on connector 
bindings (for mikrobus in particular) in order to de-couple host 
buses/signals from the modules (i.e. so a DT overlay can be applied to 
any DT defining the connector).

Rob

