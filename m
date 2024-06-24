Return-Path: <linux-kernel+bounces-227563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B3291533E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25A61F2196F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6174919D8BB;
	Mon, 24 Jun 2024 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rAuiIYhT"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28644142625
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245757; cv=none; b=JhyQt8fVyDksiDzPx0e5OXWakk5I00Xr6MQF7ZFliwRQsBwveiN5vM+LL2Lahjq/oEoEDib9NdyiP3Rnxj2w+voOgRGihBvTCnWndaWIRxpzdTbpbxH81NKolKGQmrhpLS1O26f4F1SoyatKo7pBl4eByY3b+IDm8U/obs997mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245757; c=relaxed/simple;
	bh=ekauXiAtBVr5GfQrcmb2k8SroxRH9xWkTJjHjRTKHMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho0zLWa9v6DYWIv91q6g1q21A0/VcTe7w4gtlRo/Drqm8yPRjst0nReLC/nqpKpDmNFZ7v0oMmq+tsNeTQFeX2+cX+tUsYU+QamYVFPBy1IZ2bGSYP7WOjQ0JJOmTeZjkJayUBHJp/UyQHOJ1ix7yQ5qu/O2ZxOTPL6vRN+u5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rAuiIYhT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719245744;
	bh=ekauXiAtBVr5GfQrcmb2k8SroxRH9xWkTJjHjRTKHMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAuiIYhTLn8Vb9lXRzeM8SN+hp4c+MW/ilnpvb5DiasQQW7Us+Jp31wGLeZwqV1DZ
	 Mb3duKqXTFzwwT1dzAKBtgWA3mn7AAOg2mWXMNLA4gEFTBgVcVzAaqL7e1oO5g6O/3
	 ECuHd/MnadJ2ZLn0NH5bx0DTmzpAD3drjqFJuwbE=
Date: Mon, 24 Jun 2024 18:15:44 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Matt Hartley <matt.hartley@gmail.com>, Kieran Levin <ktl@framework.net>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Dustin Howett <dustin@howett.net>
Subject: Re: [PATCH v2 0/3] drm: backlight quirk infrastructure and lower
 minimum for Framework AMD 13
Message-ID: <51f68b3b-dd21-44ef-8ec8-05bea5db6e55@t-8ch.de>
References: <20240623-amdgpu-min-backlight-quirk-v2-0-cecf7f49da9b@weissschuh.net>
 <e61010e4-cb49-44d6-8f0d-044a193d29b2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e61010e4-cb49-44d6-8f0d-044a193d29b2@redhat.com>

Hi Hans!

thanks for your feedback!

On 2024-06-24 11:11:40+0000, Hans de Goede wrote:
> On 6/23/24 10:51 AM, Thomas Weißschuh wrote:
> > The value of "min_input_signal" returned from ATIF on a Framework AMD 13
> > is "12". This leads to a fairly bright minimum display backlight.
> > 
> > Add a generic quirk infrastructure for backlight configuration to
> > override the settings provided by the firmware.
> > Also add amdgpu as a user of that infrastructure and a quirk for the
> > Framework 13 matte panel.
> > Most likely this will also work for the glossy panel, but I can't test
> > that.
> > 
> > One solution would be a fixed firmware version, but given that the
> > problem exists since the release of the hardware, it has been known for
> > a month that the hardware can go lower and there was no acknowledgment
> > from Framework in any way, I'd like to explore this alternative
> > way forward.
> 
> There are many panels where the brightness can go lower then the advertised
> minimum brightness by the firmware (e.g. VBT for i915). For most users
> the minimum brightness is fine, especially since going lower often may lead
> to an unreadable screen when indoors (not in the full sun) during daylight
> hours. And some users get confused by the unreadable screen and find it
> hard to recover things from this state.

There are a fair amount of complaints on the Framework forums about this.
And that specific panel is actually readable even at 0% PWM.

> So IMHO we should not be overriding the minimum brightness from the firmware
> using quirks because:
> 
> a) This is going to be an endless game of whack-a-mole

Indeed, but IMO it is better to maintain the list in the kernel than
forcing all users to resort to random forum advise and fiddle with
lowlevel system configuration.

> b) The new value may be too low for certain users / use-cases

The various userspace wrappers already are applying a safety
threshold to not go to "0".
At least gnome-settings-daemon and brightnessctl do not go below 1% of
brightness_max. They already have to deal with panels that can go
completely dark.

> With that said I realize that there are also many users who want to have
> a lower minimum brightness value for use in the evening, since they find
> the available minimum value still too bright. I know some people want this
> for e.g. various ThinkPad models too.

From my experience with ThinkPads, the default brightness range there
was fine for me. But on the Framework 13 AMD it is not.

> So rather then quirking this, with the above mentioned disadvantages I believe
> that it would be better to extend the existing video=eDP-1:.... kernel
> commandline parsing to allow overriding the minimum brightness in a driver
> agnostic way.

I'm not a fan. It seems much too complicated for most users.

Some more background to the Framework 13 AMD case:
The same panel on the Intel variant already goes darker.
The last responses we got from Framework didn't indicate that the high
minimum brightness was intentional [0], [1].
Coincidentally the "12" returned from ATIF matches
AMDGPU_DM_DEFAULT_MIN_BACKLIGHT, so maybe the firmware is just not set
up completely.

> The minimum brightness override set this way will still need hooking up
> in each driver separately but by using the video=eDP-1:... mechanism
> we can document how to do this in driver independent manner. since
> I know there have been multiple requests for something like this in
> the past I believe that having a single uniform way for users to do this
> will be good.
> 
> Alternatively we could have each driver have a driver specific module-
> parameter for this. Either way I think we need some way for users to
> override this as a config/setting tweak rather then use quirks for this.

This also seems much too complicated for normal users.

[0] https://community.frame.work/t/25711/26
[1] https://community.frame.work/t/47036/7

