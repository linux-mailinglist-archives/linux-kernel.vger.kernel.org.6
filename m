Return-Path: <linux-kernel+bounces-542933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C2A4CF90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6973A2D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0227466;
	Tue,  4 Mar 2025 00:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4oW7hKk"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07A529A9
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741046476; cv=none; b=ESmBF3bshTxcykuiZI89EsPVDmjNvJ5/xsBOK11JRlKT6JcYARvGRKus7e+S4vkW1v5z98X99udWEP0QcRpDmjqXS7dNBG4KJPpMPZJBpSByRSxWyPnoipIL7RKC0kfDCHTMvvOSdzHhG7gIcnM66p/1uStEa5okkFMIBxS9Ws0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741046476; c=relaxed/simple;
	bh=9+pEkwg2vuoEzMhL5Cl/B8uzhCiG5riWIsKZ/O2ZmG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5sgLYbQxJKVJpKCB89PmNJlRw4lvzxeKb5U9mZmN3Z0V9mv7CPDHcuyRobgCJm8xpRwPI1CE7sWcvJJueq4WYDABBMWHsE9/VK32jaazVuqWxpShQ0L3LAUYMg4+8azpI359MPykkksfYn3V2veJBNapzcQqodHpYABZ8uIRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4oW7hKk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54955222959so3625324e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 16:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741046472; x=1741651272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkqxBKG8Qf6FiNEdeYYpYgDqec2n3GJdXjk7zy/AcfA=;
        b=L4oW7hKkNdPbLc3YEYxfQKZXt7dw9dyMP94iLnu6Hv1JA30UnNrCqxfSp1SLYbtDvd
         SMuBZagCi6OOA4mv5TMCGJuz4MdW0+f3DFS5WU7jR+DK8v245NbFFJxQtfrLWs52ebs+
         /ZjVFhCqgigHz74aOeWpB5Mk4SB29KKCtGmeSh/lK+yqAczJ2MiRGO1X1Zi4dLTuHkyH
         B/tjUw2peUC7AuJh43L66KOF/FPBcXubzA7ths+5fUJHMEBYhX+sn3S4LEKKivyYsqeK
         k7quxmnGbMTRtj5SmeXtDFpRBGHWuylLP0NCT96wLbYpqhgBJ9TRSPFBkbFRhdX04cuZ
         Zwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741046472; x=1741651272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkqxBKG8Qf6FiNEdeYYpYgDqec2n3GJdXjk7zy/AcfA=;
        b=lqCrNU2Tqc11EaXe6jWfBeWh1t5I48rJCr1QrJYPgh8KUb/QR+THjz+/NNd1YdeK5D
         WYH4W+xieD7LcqMCJQzTb0TQIRHFi/EOyrvEimkRcEH4agu7e04AZV+/xjVeEr/jxMSI
         v4TBGaNfyijjAVzJz5iXvD1LnDEfS3ymPEmDeYJ8pf5xCIEfNSm/6FvaaTrPTLCPac/f
         gOzDdOLT0yqLaZoCyDELd+AJT5GWkUo6qLAqi4DCOAQQ6sHAzyfEAjjBWXFSwHPyRjIy
         i+rKHCT4c/YpazRSQlNWHDj4S8FvJYXRJTHBxDQWQDM7+u37j7TnJPcvG7+HzEfdrE2m
         g8fw==
X-Forwarded-Encrypted: i=1; AJvYcCUu6Emjiscnp7MC9DX+6HGCdgJQFyS+TlbDuPvUluD+UyDUOgMpFumJnNLyKbXlJk7iBImAiojYEUUWm6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBE8s67DS6HUGxsGyXbyzrRFcSrHCA3dCK9PeO5/On+7FbCv2Q
	S+l/ef9lFp8nNHm9OTnLwBtUGziBfSYTnplGLjU+hChgQ3JLwexOj6B7nJhSglQ=
X-Gm-Gg: ASbGnctDULWmbIidXl4rvHyVa8lLUXrB79AE6xwVJ9DFOu+1OPkpNDx9lEwSYTNMThd
	vBOZEcEhmxDvsruTCLNyu16rMrqKNxK9JvpvrFbpZd69W3MYOi6YL5+0bCXtzWaga2jeOf5pH1j
	CryM39G2ek330ZD7MpLmgA8kj0t5cZ8pGOJnu9QeKs1duhal+g4MEjnYWNWT5uq1zSYdLMsvAU7
	UsEvHgvXZBpyZzqiQCbd+LyVJeY3DeB2r8BlwIlGobg92E+ozh1cOVT8aQjD1uMElMMi17R4tUg
	FJwBa7Kt8E7aqzhrTXH8XohfM+XgJ7LCB0mBtVNPZjEAR9rzQ3YZUyvq1SoTmB1MBUcTDBwrJ3H
	GLY8VDihl4ZFyKBKUp03/lZ0b
X-Google-Smtp-Source: AGHT+IGAn6gM1TyoFfcxy1mqC0F4XhADSkCvoUeeALC8/A3I1KfzwKl6LMwy2iUWuocM+y/26k7tHw==
X-Received: by 2002:a05:6512:234f:b0:549:6451:7ea0 with SMTP id 2adb3069b0e04-54964517fb8mr2749118e87.19.1741046471766;
        Mon, 03 Mar 2025 16:01:11 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443cd03dsm1427182e87.244.2025.03.03.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:01:10 -0800 (PST)
Date: Tue, 4 Mar 2025 02:01:07 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Maxime Ripard <mripard@kernel.org>, fnkl.kernel@gmail.com, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, Janne Grunau <j@jannau.net>, 
	linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Neal Gompa <neal@gompa.dev>, Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH v7 0/5] Driver for pre-DCP apple display controller.
Message-ID: <dn7zskhxgdgr25nvbnsjyn5brc3yoc446dxz3vqgbiwoccvlcr@5l6f4byj53fo>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
 <c3927b51-55ef-4a38-8931-18ff00caa8d8@linaro.org>
 <Z8XcH7xoDC7TA7ZC@blossom>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XcH7xoDC7TA7ZC@blossom>

On Mon, Mar 03, 2025 at 11:43:11AM -0500, Alyssa Rosenzweig wrote:
> > > Sasha Finkelstein (5):
> > >        dt-bindings: display: Add Apple pre-DCP display controller
> > >        drm: adp: Add Apple Display Pipe driver
> > >        drm: panel: Add a panel driver for the Summit display
> > >        arm64: dts: apple: Add touchbar screen nodes
> > >        MAINTAINERS: Add entries for touchbar display driver
> > > 
> > >   .../display/apple,h7-display-pipe-mipi.yaml        |  83 +++
> > >   .../bindings/display/apple,h7-display-pipe.yaml    |  88 +++
> > >   .../bindings/display/panel/apple,summit.yaml       |  58 ++
> > >   MAINTAINERS                                        |  16 +
> > >   arch/arm64/boot/dts/apple/t8103-j293.dts           |  31 ++
> > >   arch/arm64/boot/dts/apple/t8103.dtsi               |  61 ++
> > >   arch/arm64/boot/dts/apple/t8112-j493.dts           |  31 ++
> > >   arch/arm64/boot/dts/apple/t8112.dtsi               |  61 ++
> > >   drivers/gpu/drm/Kconfig                            |   2 +
> > >   drivers/gpu/drm/Makefile                           |   1 +
> > >   drivers/gpu/drm/adp/Kconfig                        |  17 +
> > >   drivers/gpu/drm/adp/Makefile                       |   5 +
> > >   drivers/gpu/drm/adp/adp-mipi.c                     | 276 +++++++++
> > >   drivers/gpu/drm/adp/adp_drv.c                      | 617 +++++++++++++++++++++
> > >   drivers/gpu/drm/panel/Kconfig                      |   9 +
> > >   drivers/gpu/drm/panel/Makefile                     |   1 +
> > >   drivers/gpu/drm/panel/panel-summit.c               | 132 +++++
> > >   17 files changed, 1489 insertions(+)
> > > ---
> > > base-commit: b62cef9a5c673f1b8083159f5dc03c1c5daced2f
> > > change-id: 20241124-adpdrm-25fce3dd8a71
> > > 
> > > 
> > 
> > All patches are reviewed, can we funnel patches 1, 2 & 5 via drm-misc-next now ?
> 
> I'm planning to do so today, just need to get dim setup first :)

Nice! As a heads up, it would be really-really nice if you can send any
kind of 'applied' message. If you are using 'dim b4-shazam', then
'b4 ty -a' might do that for you. Otherwise just a simple 'hey, applied'
email is useful enough.

-- 
With best wishes
Dmitry

