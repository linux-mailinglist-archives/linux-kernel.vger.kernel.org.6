Return-Path: <linux-kernel+bounces-542342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77FDA4C8D0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE0D53B774D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E3D24CED6;
	Mon,  3 Mar 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="tcCzM1+o"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC224CED5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020211; cv=none; b=EGpy7pj2kQhRgK2HMHPtjuzSrpf+fihZbpJiYmiWXfUWwl8QUW/vwU8D94z7Iy5co7QnVzBf5+3qsAXQJoqrAlQI0jOkXJgGCYGTWzfEHIxe3oqvxUdQPnEGTiJFvHlWfPcOyKko69P95ZjySDBgqHeYN2EvDTRymQ8hfN3oU4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020211; c=relaxed/simple;
	bh=aHr0m6w2L3LX7OfWQEnvUgl5NG5+v/I574fWDNzzD5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuLu1tYoc16XVI+mkZKO4uV82aQzfJcwnOdZenW0ysAReDPVvLqk4hZ83Gkd5qw38ppyTCgvJcw+Heq4dLZgnXhvBZQEilFfMW6H4CUhP5+DKOaRPRFdtm+aVAV+viJSQi4bZxYvHHiR5XEvdOUuVu2AHPNBJo605h80L0GKP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=tcCzM1+o; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Mon, 3 Mar 2025 11:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741020197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0xN0OgCy3b1q5LuDbAE8X1hj9Ed53fv0LtyLgIvHWLw=;
	b=tcCzM1+oyyL625hQt8o31zf6qJpyDtm+6hpAXzLVKn+/ZxZTb9Q+WuR4NdZ0cXeFmwq6CB
	XNOdD4XSj7+1UviD4gsBYGkbLNrZExowUqMcwPB58T8FwPXfe5Y3+4lO8IWcJNcRIf8FSS
	Sl0gw+6ZKMZVxSPbxK1esQNoxAj3H4Eu/WGKT7nUKTuqziWx8nRw/roEeS1cgxNI8z2zJ7
	TsaoQhvUIucMFJRo3Ze4aB6/UiozFezKIOqpJrCMT+NhM6XullJbqA5Cv3v3+O2K/xvVjM
	EbJCFW77yP0ce+qQoHXbO/igKXviqatuHW1i9jZ6JrlqnaOyMJm1D3bFTyT3Fw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maxime Ripard <mripard@kernel.org>, fnkl.kernel@gmail.com,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
	Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neal Gompa <neal@gompa.dev>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH v7 0/5] Driver for pre-DCP apple display controller.
Message-ID: <Z8XcH7xoDC7TA7ZC@blossom>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
 <c3927b51-55ef-4a38-8931-18ff00caa8d8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3927b51-55ef-4a38-8931-18ff00caa8d8@linaro.org>
X-Migadu-Flow: FLOW_OUT

> > Sasha Finkelstein (5):
> >        dt-bindings: display: Add Apple pre-DCP display controller
> >        drm: adp: Add Apple Display Pipe driver
> >        drm: panel: Add a panel driver for the Summit display
> >        arm64: dts: apple: Add touchbar screen nodes
> >        MAINTAINERS: Add entries for touchbar display driver
> > 
> >   .../display/apple,h7-display-pipe-mipi.yaml        |  83 +++
> >   .../bindings/display/apple,h7-display-pipe.yaml    |  88 +++
> >   .../bindings/display/panel/apple,summit.yaml       |  58 ++
> >   MAINTAINERS                                        |  16 +
> >   arch/arm64/boot/dts/apple/t8103-j293.dts           |  31 ++
> >   arch/arm64/boot/dts/apple/t8103.dtsi               |  61 ++
> >   arch/arm64/boot/dts/apple/t8112-j493.dts           |  31 ++
> >   arch/arm64/boot/dts/apple/t8112.dtsi               |  61 ++
> >   drivers/gpu/drm/Kconfig                            |   2 +
> >   drivers/gpu/drm/Makefile                           |   1 +
> >   drivers/gpu/drm/adp/Kconfig                        |  17 +
> >   drivers/gpu/drm/adp/Makefile                       |   5 +
> >   drivers/gpu/drm/adp/adp-mipi.c                     | 276 +++++++++
> >   drivers/gpu/drm/adp/adp_drv.c                      | 617 +++++++++++++++++++++
> >   drivers/gpu/drm/panel/Kconfig                      |   9 +
> >   drivers/gpu/drm/panel/Makefile                     |   1 +
> >   drivers/gpu/drm/panel/panel-summit.c               | 132 +++++
> >   17 files changed, 1489 insertions(+)
> > ---
> > base-commit: b62cef9a5c673f1b8083159f5dc03c1c5daced2f
> > change-id: 20241124-adpdrm-25fce3dd8a71
> > 
> > 
> 
> All patches are reviewed, can we funnel patches 1, 2 & 5 via drm-misc-next now ?

I'm planning to do so today, just need to get dim setup first :)

