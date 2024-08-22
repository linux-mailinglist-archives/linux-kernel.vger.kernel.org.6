Return-Path: <linux-kernel+bounces-296736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A844495AE58
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCBC01C22B20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222C13CA81;
	Thu, 22 Aug 2024 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Ru06Pgh4"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E323CB;
	Thu, 22 Aug 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310105; cv=none; b=aqaAP0VAToRjwUZH4r2kfmDRLq7l8yc8XtEU3MyF2rfvoTId/UAKbGdDgFd9jwcpzGbqdKwze8OQIZB8rbdeJVn3NkPjRfT2+gNlnwmFuJ9lxIKR6F6imYCy1StyOnreDXzkGbQzkFOeGr7RLfR8UGkpgGSWIGRLGbg89nwHHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310105; c=relaxed/simple;
	bh=0bmcDzznZLKsIw03EVC1Z4PlxpRrGsq/rZ+kPPtpj+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoVshEPSn9vRtSGOUdjrzeiDPVMsem4GmK1enRhzFmbRm/cpcUqPz4ZHJmtA5+H59UKd3J6c2kZG1OO7yCutLeOTSmm4+CMbUQ3kVO8ZNSPxmKBvYDyYSvaR1C6DUQJhzhjT/PU4uB3+Y/PqUE2gL4tXWYwjAJlR7z/7DP5jWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Ru06Pgh4; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tuxt7GCqLf7xh3mnFjDC4fgCkiXHtZKNJyBCK2VSy6k=; b=Ru06Pgh4K8ho1mUnytGolB07m9
	UndgQkYW/ugIGGOUwcJVoArjGBOCz5ajtJGLvRqmPVoYbvXFoE6zxhxvrdjjChtK76FGxWcJruJLk
	N8H7z6OQ2w37lGDQF/X6cWxBUHFw/I6a5sRC/CUO3zNfY8Zznqw/OdCBr65tl63ormlrFXAFNS0Vs
	YCioeiBVe8qHOKRqGCAkr35AhuCnnY7Dngf7xKv5NzAXcKsN5Dg07+EGOyN16OM5/ovS5W9HmbEbz
	HiJEDiqDzUqB9NDsa5lWFtGi6PKN0YCaehQHRpk8Ei3uOt465sFzKFl5U6ahyZ8a/LVc2oOeqRtGh
	1i316JZw==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sh1od-0003XW-MI; Thu, 22 Aug 2024 09:01:03 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Conor Dooley <conor@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 kernel@collabora.com, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>
Subject:
 Re: [PATCH v4 3/4] dt-bindings: display: rockchip: Add schema for RK3588 HDMI
 TX Controller
Date: Thu, 22 Aug 2024 09:01:34 +0200
Message-ID: <4167579.6PsWsQAL7t@diego>
In-Reply-To: <2085e998-a453-4893-9e80-3be68b0fb13d@collabora.com>
References:
 <20240819-b4-rk3588-bridge-upstream-v4-0-6417c72a2749@collabora.com>
 <7E8109D4-A353-4FE3-9152-3C3C6CB7D634@sntech.de>
 <2085e998-a453-4893-9e80-3be68b0fb13d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Donnerstag, 22. August 2024, 01:22:16 CEST schrieb Cristian Ciocaltea:
> On 8/22/24 12:38 AM, Heiko Stuebner wrote:
> > 
> > 
> > Am 21. August 2024 23:28:55 MESZ schrieb Conor Dooley <conor@kernel.org>:
> >> Cristian, Heiko,
> >>
> >> On Wed, Aug 21, 2024 at 11:38:01PM +0300, Cristian Ciocaltea wrote:
> >>> On 8/21/24 6:07 PM, Conor Dooley wrote:
> >>>> On Tue, Aug 20, 2024 at 11:12:45PM +0300, Cristian Ciocaltea wrote:
> >>>>> On 8/20/24 7:14 PM, Conor Dooley wrote:
> >>>>>> On Tue, Aug 20, 2024 at 03:37:44PM +0300, Cristian Ciocaltea wrote:
> >>>>>>> On 8/19/24 7:53 PM, Conor Dooley wrote:
> >>>>>>>> On Mon, Aug 19, 2024 at 01:29:30AM +0300, Cristian Ciocaltea wrote:
> >>>>>>>>> +  rockchip,grf:
> >>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>>>>>>> +    description:
> >>>>>>>>> +      Most HDMI QP related data is accessed through SYS GRF regs.
> >>>>>>>>> +
> >>>>>>>>> +  rockchip,vo1-grf:
> >>>>>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>>>>>>>> +    description:
> >>>>>>>>> +      Additional HDMI QP related data is accessed through VO1 GRF regs.
> >>>>>>>>
> >>>>>>>> Why are these required? What prevents you looking up the syscons by
> >>>>>>>> compatible?
> >>>>>>>
> >>>>>>> That is for getting the proper instance:
> >>>>>>
> >>>>>> Ah, that makes sense. I am, however, curious why these have the same
> >>>>>> compatible when they have different sized regions allocated to them.
> >>>>>
> >>>>> Good question, didn't notice.  I've just checked the TRM and, in both
> >>>>> cases, the maximum register offset is within the 0x100 range.  Presumably
> >>>>> this is nothing but an inconsistency, as the syscons have been added in
> >>>>> separate commits.
> >>>>
> >>>> Is that TRM publicly available? I do find it curious that devices sound
> >>>> like they have different contents have the same compatible. In my view,
> >>>> that is incorrect and they should have unique compatibles if the
> >>>> contents (and therefore the programming model) differs.
> >>>
> >>> Don't know if there's an official location to get it from, but a quick
> >>> search on internet shows a few repos providing them, e.g. [1].
> >>>
> >>> Comparing "6.14 VO0_GRF Register Description" at pg. 777 with "6.15 VO1_GRF
> >>> Register Description" at pg. 786 (from Part1) reveals the layout is mostly
> >>> similar, with a few variations though.
> >>
> >> Page references and everything, thank you very much. I don't think those
> >> two GRFs should have the same compatibles, they're, as you say, similar
> >> but not identical. Seems like a bug to me!
> >>
> >> Heiko, what do you think?
> > 
> > Yes, while the register names sound similar, looking at the bit
> > definitions this evening revealed that they handle vastly different
> > settings.
> > 
> > So I guess we should fix the compatibles. They are all about graphics
> > stuff and HDMI actually is the first output, so right now WE can at least
> > still claim the no-users joker ;-)
> 
> I couldn't find any driver doing a lookup for them by compatible, so I
> think it's fine to fix them - should we go for "rockchip,rk3588-vo0-grf" and
> "rockchip,rk3588-vo1-grf", respectively?

yep. While things like the MIPICDPHY{0,1}_GRF really are identifcal and
serve two separate controllers ... vo0 and vo1 are very different entities,
so fixing the compatible to reflect that makes a lot of sense.


> vo0_grf seems to be used by the usbdp phy nodes:
> 
>     usbdp_phy0: phy@fed80000 {
>         compatible = "rockchip,rk3588-usbdp-phy";
>         [...]
>         rockchip,vo-grf = <&vo0_grf>;
>         [...]
> 
> Same for "usbdp_phy1: phy@fed90000".
> 
> While vo1_grf is present in:
> 
>     vop: vop@fdd90000 {
>         compatible = "rockchip,rk3588-vop";
>         [...]
>         rockchip,vo1-grf = <&vo1_grf>;
>         [...]
> 
> I guess it's too late to drop them while updating the related drivers
> accordingly, hence I wonder if we should keep using the phandles for this
> HDMI thing as well, for consistency reasons.

For the property naming, I guess it just tells the driver which "vo"-grf
to use, so the vop is more explicit in naming it vo1-grf even the vo-grf
in the usbdp phy won't hurt too much.

Of course we can still look up the grf by compatible and deprecate the
phandle references.


@Conor: just for me, did some shift happen in our understanding of dt-
best-practices in terms of syscon via phandle vs. syscon via compatible?

Because Rockchip boards are referencing their GRFs via phandes forever
but similar to the soc vs non-soc node thing, I'd like to stay on top of
best-practices ;-)


Heiko


> > Heiko
> > 
> >>
> >>> [1] https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet
> >>>
> >>>>>
> >>>>>>> 	vo0_grf: syscon@fd5a6000 {
> >>>>>>> 		compatible = "rockchip,rk3588-vo-grf", "syscon";
> >>>>>>> 		reg = <0x0 0xfd5a6000 0x0 0x2000>;
> >>>>>>> 		clocks = <&cru PCLK_VO0GRF>;
> >>>>>>> 	};
> >>>>>>>
> >>>>>>> 	vo1_grf: syscon@fd5a8000 {
> >>>>>>> 		compatible = "rockchip,rk3588-vo-grf", "syscon";
> >>>>>>> 		reg = <0x0 0xfd5a8000 0x0 0x100>;
> >>>>>>> 		clocks = <&cru PCLK_VO1GRF>;
> >>>>>>> 	};
> >>>>
> > 
> 





