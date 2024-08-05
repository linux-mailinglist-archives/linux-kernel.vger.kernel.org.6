Return-Path: <linux-kernel+bounces-274983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A6947F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52011F22EF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AF15B98E;
	Mon,  5 Aug 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFYP4S9P"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18D15B13B;
	Mon,  5 Aug 2024 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874831; cv=none; b=piQ/U+vmp1P9nwYgH9MkXRLeckd+EEGfp7gAK/pv08UxavL1uyW9dDZXVEQgcAn2zqdeK62Itob7FqoRjGLyQoJGTSFmOyR4qrPSkVVOzbGTDR5lnkEqLKWKL97g3z4Yc2fOllSSu4R55UELoc/uxzGKGlyC9MnvAcuIKPuzLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874831; c=relaxed/simple;
	bh=t+q3WbU7wIAsybWvWN5h0cBn7cQzNFnLNEyrabNbg2Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXQxr35bbVY0T+EsUgyji9tcSca44uTZhelSeyFPbgB0nuJFrMgVDwHuphBFq9UuECprnV/wal6nyuWlG2MFvdIME3SMFfaHl30qKk1JBDMdbfINRXKB4GbSOgh/0+qKwi9wta9Giu21T8DN12GIbWuRQMxMfirP5ZKcKmpWQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFYP4S9P; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db19caec60so7512986b6e.1;
        Mon, 05 Aug 2024 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722874829; x=1723479629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o/2gcRJhRF+q0oumC+8pyXKRI+ru5NZw7+q3z+G4VQE=;
        b=gFYP4S9P2Y/tBFBvV3qyWjyhbAIth6Xha8QIZUVz4ZzONqtzRReORiqwJAAbHyvHZn
         NCi8pGrd+vRiZrSSQRtECYIxBkZUetbVJj9SCOtFc1bwVgmxq+HnyxBc3b7eKPiymBS+
         EtK/W9xlnUdRZc2dxxt4EXBN107iqFklOw1mwfQA21oF2D2kbOaxNgNTeTA1YWWpgDnW
         fSadApa+flykft0q+5GwXjvx9/UaFPvCYkJkEp1zqmWsMVRDt0Ng9B+vjRa+x6clWO3g
         RQIKYQCTrorGSJqFl8jB+3Wb0zqWCIFcaHXqvw0SrK0DMeeC4vHNlXSyk8aPQT9lK7Qy
         XRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722874829; x=1723479629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o/2gcRJhRF+q0oumC+8pyXKRI+ru5NZw7+q3z+G4VQE=;
        b=fVnKXqSPWdLORTob5w02TZEc3pwtA/FHanH0TRaFytT/p0z5mV4q1dBpemGjTaFO47
         DW+fDQM9L7OoOelVr95iFmTrhPNkBDqDgD6WjZrKEadp+K9GTr/J/mnY35N10hw/c86J
         cJ0GBZA1J4CsTJ6pindbO6xWlGLqlJYPrBtgx6NqQ6Ifn/SuAmqA+HudP9kT+Ex02XoT
         wEZ0/T8q8TBgOa7IMDxJz2spO7qcp19VADvDorP8AlNpfodsnJKN/yGCChHElNENbtEV
         xfMWR6hiy0+0HwcLjIRh2kFzQyG4wWstmIISiBh1nKB2cFoe4mJup55wzbKoKrIkGQp1
         0Iwg==
X-Forwarded-Encrypted: i=1; AJvYcCVVEKSo6vcCCssHw514T4x7dtziigACtLn4vjIrduUyXpAwjYCOf67uD44gmgzG8W6iLPaAj191ALvvNVm6CEMZ5cR9MCCRL5pWoMnU0DJDZd5vMdCH/ls6fzc/7d9JOSdQ25Sr+IN0Xw==
X-Gm-Message-State: AOJu0YwghfdTm6p3BW3D1orO2pux9K7WDWGK09OKHFB9dFY89uAYevrj
	ycQ/CHbFHEW6S8R97APBzyfV2w3IuU6CyKHWvtNl3jFnC8WR1PAX
X-Google-Smtp-Source: AGHT+IGhrdCiVzHF4+sgL6JEIeJjR99KHrosaGVM3KVKN0FUNCYWFamuinYDjmTd4Ylqq3yvu2brxQ==
X-Received: by 2002:a05:6808:1b2b:b0:3db:22aa:f565 with SMTP id 5614622812f47-3db558095ccmr16759128b6e.11.1722874829090;
        Mon, 05 Aug 2024 09:20:29 -0700 (PDT)
Received: from neuromancer. ([2600:1700:fb0:1bcf::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db5637b487sm2728598b6e.29.2024.08.05.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 09:20:28 -0700 (PDT)
Message-ID: <66b0fbcc.050a0220.30fac7.71ce@mx.google.com>
X-Google-Original-Message-ID: <ZrD7y/cmGjV3Kpax@neuromancer.>
Date: Mon, 5 Aug 2024 11:20:27 -0500
From: Chris Morgan <macroalpha82@gmail.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Yao <markyao0591@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
	devicetree@vger.kernel.org, kernel@collabora.com,
	Alexandre ARNOUD <aarnoud@me.com>,
	Luis de Arquer <ldearquer@gmail.com>,
	Algea Cao <algea.cao@rock-chips.com>
Subject: Re: [PATCH v2 0/3] Add initial support for the Rockchip RK3588 HDMI
 TX Controller
References: <20240801-b4-rk3588-bridge-upstream-v2-0-9fa657a4e15b@collabora.com>
 <45B07EAF-4CBA-4DE4-A03B-109767D52B29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45B07EAF-4CBA-4DE4-A03B-109767D52B29@gmail.com>

On Sat, Aug 03, 2024 at 03:24:06PM +0200, Piotr Oniszczuk wrote:
> Hi Cristian,
> 
> Will you find some time and motivation to add CEC support to Quad-Pixel (QP) TX controller ?
> 
> Probably you recall - I added initial CEC support to yours v1 series and i’m stuck with timing issue (cec pulses are 3x too long).
> For me it looks like clock issue.
> I’m out of ideas how to move forward with this timming issue….

I wonder if using the cec-gpio on "GPIO4 RK_PC1" for the CEC gpio and
"GPIO1 RK_PA5" for the HPD gpio is a possibility? Just a thought.

Chris

>  
> 
> 
> > Wiadomość napisana przez Cristian Ciocaltea <cristian.ciocaltea@collabora.com> w dniu 01.08.2024, o godz. 04:25:
> > 
> > The Rockchip RK3588 SoC family integrates the Synopsys DesignWare HDMI
> > 2.1 Quad-Pixel (QP) TX controller [4], which is a new IP block, quite
> > different from those used in the previous generations of Rockchip SoCs.
> > 
> > This is the last component that needs to be supported in order to enable
> > the HDMI output functionality on the RK3588 based SBCs, such as the
> > RADXA Rock 5B. The other components are the Video Output Processor
> > (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for which basic
> > support has been already made available via [1] and [2], respectively.
> > 
> > Please note this is a reworked version of the original series, which
> > relied on a commonized dw-hdmi approach.  Since the general consensus
> > was to handle it as an entirely new IP, I dropped all patches related to
> > the old dw-hdmi and Rockchip glue code - a few of them might still make
> > sense as general improvements and will be submitted separately.
> > 
> > Additionally, as suggested by Neil, I've sent the reworked bridge driver
> > as a separate patchset [4], hence this series handles now just the new
> > Rockchip QP platform driver.
> > 
> > It's worth mentioning the HDMI output support is currently limited to
> > RGB output up to 4K@60Hz, without audio, CEC or any of the HDMI 2.1
> > specific features.  Moreover, the VOP2 driver is not able to properly
> > handle all display modes supported by the connected screens, e.g. it
> > doesn't cope with non-integer refresh rates.
> > 
> > A possible workaround consists of enabling the display controller to
> > make use of the clock provided by the HDMI PHY PLL. This is still work
> > in progress and will be submitted later, as well as the required DTS
> > updates.
> > 
> > To facilitate testing and experimentation, all HDMI output related
> > patches, including those part of this series, as well as the bridge
> > driver, are available at [3].
> > 
> > So far I could only verify this on the RADXA Rock 5B board.
> > 
> > Thanks,
> > Cristian
> > 
> > [1]: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> > [2]: 553be2830c5f ("phy: rockchip: Add Samsung HDMI/eDP Combo PHY driver")
> > [3]: https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commits/rk3588-hdmi-bridge-v6.11-rc1
> > [4]: https://lore.kernel.org/lkml/20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@collabora.com/
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> > ---
> > Changes in v2:
> > - Reworked the glue code for RK3588 into a new Rockchip platform driver
> > - Moved bridge driver patches to a separate series [4]
> > - Dropped all the patches touching to the old dw-hdmi and RK platform
> >  drivers
> > - Added connector creation to ensure the HDMI QP bridge driver does only
> >  support DRM_BRIDGE_ATTACH_NO_CONNECTOR
> > - Link to v1: https://lore.kernel.org/r/20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com
> > 
> > ---
> > Cristian Ciocaltea (3):
> >      dt-bindings: display: rockchip: Add schema for RK3588 HDMI TX Controller
> >      drm/rockchip: Explicitly include bits header
> >      drm/rockchip: Add basic RK3588 HDMI output support
> > 
> > .../display/rockchip/rockchip,dw-hdmi-qp.yaml      | 188 +++++++++
> > drivers/gpu/drm/rockchip/Kconfig                   |   8 +
> > drivers/gpu/drm/rockchip/Makefile                  |   1 +
> > drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 430 +++++++++++++++++++++
> > drivers/gpu/drm/rockchip/rockchip_drm_drv.c        |   2 +
> > drivers/gpu/drm/rockchip/rockchip_drm_drv.h        |   4 +-
> > 6 files changed, 632 insertions(+), 1 deletion(-)
> > ---
> > base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> > change-id: 20240601-b4-rk3588-bridge-upstream-a27baff1b8fc
> > 
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> 

