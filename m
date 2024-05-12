Return-Path: <linux-kernel+bounces-176939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BFC8C379C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41014281334
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65FC47784;
	Sun, 12 May 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="xiS8wpMG"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8233985;
	Sun, 12 May 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715532286; cv=none; b=fZOukxGsyWKNu9KWViFd28toZS958tGE2Xl16NW0PqVeo4Q1Nw7B+3YOD/+bQLBr6XjhFIR04sHHYOWnA1KD1Hs7LhIjiOcp/prD9IdHInft8GLkj1nQaosVL/kEWxsvbZW5qjgsXkihDxnYUDKoVkzbUyoIetwSeUCUHPPaMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715532286; c=relaxed/simple;
	bh=c56SAsIRlV6GLObSq1hH1Rvq8m0Fmhd1QaC7JH93tCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMXls7maCSOVkHgWxbXdwefg7RlZw4zLyW4R4V0qCt9HObT6QiqFxpqQYi7hfuaJYbe4MyRQMGnOOLW3l36dH1bs/VOk5xikGf5Iy2UfEayAE9LJKoqSXagIMnQ988SkUMrPupm8tZ1GBvWXV6VZGxnVe6biAGIFjOw8MK0PMhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=xiS8wpMG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 940691FC1D;
	Sun, 12 May 2024 18:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1715532279;
	bh=y8g4w0GWcQosP0yLlaIzTp7hrfG0+IeoYR8ymAM4Vxo=;
	h=Received:From:To:Subject;
	b=xiS8wpMGPkUeYKLKwocNyJlF6WEEYRBVZbItYRlLNVqh4a1OerBOWHoOVmUuZN+p1
	 2vn8Rbmkx0jxnA93kuwApaqQZhV2jbrjnwCfySKjCcxvGa1R7Ey5Jyyse7lPsa1Xzj
	 YiGhVauggOe3xV63kePyF0s6kWsfhrlu/NiRPkSen3eKEPxS077LalvY/Cuw9v1TVL
	 H+cyX+tvk1LfM4pXaDWCHveaMMxDXfs5LJ4w4g9UVo1t6uxU0WKwu6eALYcm30Pz/C
	 3AB/b88rRfmr+GpGYGBz2UoqOe8y31y0JXfeHgKILtU+ekeRNz1DRi73YjYmBh/z/J
	 Y51gbgNmln/WQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 3FBF97F9B8; Sun, 12 May 2024 18:44:39 +0200 (CEST)
Date: Sun, 12 May 2024 18:44:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Aradhya Bhatia <a-bhatia1@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	DRI Development List <dri-devel@lists.freedesktop.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Randolph Sapp <rs@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: Re: [PATCH 4/4] drm/tidss: Add OLDI bridge support
Message-ID: <ZkDx94qEVv65FquF@gaggiata.pivistrello.it>
References: <20240511193055.1686149-1-a-bhatia1@ti.com>
 <20240511193055.1686149-5-a-bhatia1@ti.com>
 <ZkCsfH1qeSsXyQz4@gaggiata.pivistrello.it>
 <e34dc434-7922-4b47-bc41-c06f13366194@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34dc434-7922-4b47-bc41-c06f13366194@ti.com>

Hello Aradhya,

On Sun, May 12, 2024 at 08:53:12PM +0530, Aradhya Bhatia wrote:
> On 12/05/24 17:18, Francesco Dolcini wrote:
> > On Sun, May 12, 2024 at 01:00:55AM +0530, Aradhya Bhatia wrote:
> >> Up till now, the OLDI support in tidss was integrated within the tidss dispc.
> >> This was fine till the OLDI was one-to-mapped with the DSS video-port (VP).
> >> The AM62 and AM62P SoCs have 2 OLDI TXes that can support dual-lvds / lvds-clone
> >> modes.
> >>
> >> Add OLDI TXes as separate DRM bridge entities to better support the new LVDS
> >> configurations.
> >>
> >> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> >> ---
> >>  drivers/gpu/drm/tidss/Makefile      |   3 +-
> >>  drivers/gpu/drm/tidss/tidss_dispc.c |  11 +-
> >>  drivers/gpu/drm/tidss/tidss_dispc.h |   4 +
> >>  drivers/gpu/drm/tidss/tidss_drv.c   |  13 +-
> >>  drivers/gpu/drm/tidss/tidss_drv.h   |   4 +
> >>  drivers/gpu/drm/tidss/tidss_oldi.c  | 568 ++++++++++++++++++++++++++++
> >>  drivers/gpu/drm/tidss/tidss_oldi.h  |  73 ++++
> >>  7 files changed, 673 insertions(+), 3 deletions(-)
> >>  create mode 100644 drivers/gpu/drm/tidss/tidss_oldi.c
> >>  create mode 100644 drivers/gpu/drm/tidss/tidss_oldi.h
> >>
> >> diff --git a/drivers/gpu/drm/tidss/tidss_oldi.h b/drivers/gpu/drm/tidss/tidss_oldi.h
> >> new file mode 100644
> >> index 000000000000..5ad02ddea11a
> >> --- /dev/null
> >> +++ b/drivers/gpu/drm/tidss/tidss_oldi.h
> >> @@ -0,0 +1,73 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> >> +/*
> >> + * Copyright (C) 2023 - Texas Instruments Incorporated
> >> + *
> >> + * Aradhya Bhatia <a-bhati1@ti.com>
> >> + */
> >> +
> >> +#ifndef __TIDSS_OLDI_H__
> >> +#define __TIDSS_OLDI_H__
> >> +
> >> +#include <linux/media-bus-format.h>
> >> +
> >> +#include "tidss_drv.h"
> >> +#include "tidss_dispc.h"
> >> +
> >> +struct tidss_oldi;
> > 
> > why do you need this here? 
> 
> So that struct tidss_device can store pointers to struct tidss_oldi
> instances.

on this and ...

> >> +#define OLDI_IDLE_CLK_HZ	25000000 /*25 MHz */
> > this is used only on a single C files, move it there?
> > 
> > I would consider this comment in general for this header file,
> > from a quick check most of this is used only in tidss_oldi.c.
> 
> Apart from struct tidss_device being able to access struct tidss_oldi,
> there is no direct access to any of the above.
> 
> Perhaps I can move the idle clock definition into the C file.
> 
> However, before tidss_oldi.h, all the register definitions have been
> stored in tidss_dispc_regs.h. It just seemed right to keep them out in
> the header file and maintain the status quo.

.. this they are probably more of a personal taste topic, just go
for whatever you and the actual maintainer (tomi?) prefer.

Thanks,
Francesco


