Return-Path: <linux-kernel+bounces-264207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CFF93E031
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA5C1F21B94
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6BC1862B4;
	Sat, 27 Jul 2024 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7xZsoVa"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401B5579F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722098401; cv=none; b=KK1GWeQq7soFlKosqe01T+bI4Xr4kYxZUHj5v+jG35RmISom4ZnuU2QWQCQoHxA7eCu/H0hy4+6dkIYzGzAJ/2B3vTbav9xKPAQVVHDww1y83sXb/HjE1t91C1Pn/U+J3NU8k5QT5FfAq6Tp1uyQXEddE09wHc0WeTK1GtRaPCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722098401; c=relaxed/simple;
	bh=FUNE4JQOrI+mbE6a2Bb/3GxHEC37Whm4hYXMdfdGvWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkSXDB/vTsCNd/7GV/S2kgdSJzVuIYo3CA2JvRULwj3MknMdIT4751oeCH0MXZzR0oKKquuLbJdc4zSWoWXfWLUhhn9POLjLe+2UKaXrTbRfKUQ9WwjS4HjcSGbZ32WtzTtIUBXmk2DGHJcSvEQiy9mAD6JI3TzJxpaxCAxCWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B7xZsoVa; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f0277daa5so3412193e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722098398; x=1722703198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e37AhEISBQ02gc3ZCHLGCwU3mAG5uPYdG67GQd5E1Pk=;
        b=B7xZsoVaJUVPC+OANvgXyJ71UUHH4oDVwNeA+Kc59+89qS4FvKKC8RCVwaWPhXjSZw
         kNXUpR1w4/a7Geoij5wPJRrx63GZtvPjJYAFDW95M19j7RtX9vKjUi8SGuiagBroathR
         Rk3NZRS1FXFZ6GX/bJjYpbrJekkr8Nu53Nb5FDOs+b/MQ/SdF57gkGWpbo3KR69Ln2TB
         lEhlQfs/EKdo9NDht9OwPO4FFYqSPsNUN7wTxjCPpY3JbkC12JjtFihrS8ItcewwsmLZ
         /hDt6dKveR0jQShQq8I+zF5PBoYaMN1aizOLEhXungSjTQ/Eny9K8aXPsUpliyM1U/Pf
         aDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722098398; x=1722703198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e37AhEISBQ02gc3ZCHLGCwU3mAG5uPYdG67GQd5E1Pk=;
        b=ULoZAYMUilCJvbucm3BcD1uc+lnjnfc8mguMtcbqVaqfjxBNY5mELWaqGvdx3STFq6
         9HjwpePQOsMDUAOjYJv78B7KevS08DJkpNVWVGggcuLSM4CE7HMAbtKr//xQ8DOQOlzH
         glB+R0koyMLTxwbFUsrGtbx5D5xYj2H1V8iZgql5urryCgFwrIv1Objx0MCDNkpNyhOc
         0Gomf8xVyZ3kNZl/u80Zr2d2+o0IpzaQ4Y75TbhwCCqDwiqjL/UIVoiGpuBavhgCn3TF
         P1fDzFRmdceKZDcHcBz+hgsQMTdfYpA9igLKS9W2CGWWQiAD6Mm1dNJhcYbZaC/kBSuf
         ACOg==
X-Forwarded-Encrypted: i=1; AJvYcCXz65SxMaR+syxcW1yhiaDq2YKPReiIhV/LkdR+jJC+wOFKld92Ih1Iy4Y80GQS2iSqv7TZViYPAIf0QD//tHJvibFIotwVbNUluaSe
X-Gm-Message-State: AOJu0YwFzsg69jirFGMYOD1wMZXq78MffK17XyBaIHhAH7WpzijO+kJQ
	OF6ACiXA8lcm8peZnwsLoAChgVPBU2t5pV65tcC8eClvqL4WrspjaGzdKWCKnt4=
X-Google-Smtp-Source: AGHT+IGhwepcIOBfQ1zb5uvMu7DFH8peCt2X7vNb7TKdJEffIwJXb+SCw0b5V1egmjG7hA92CaUC2w==
X-Received: by 2002:a05:6512:524:b0:52c:8c4d:f8d6 with SMTP id 2adb3069b0e04-5309b2bcc06mr2028466e87.45.1722098397341;
        Sat, 27 Jul 2024 09:39:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c1a0d2sm805229e87.224.2024.07.27.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 09:39:56 -0700 (PDT)
Date: Sat, 27 Jul 2024 19:39:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, p.zabel@pengutronix.de, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, tglx@linutronix.de, vkoul@kernel.org, 
	kishon@kernel.org, aisheng.dong@nxp.com, agx@sigxcpu.org, francesco@dolcini.it, 
	frank.li@nxp.com
Subject: Re: [PATCH v3 00/19] Add Freescale i.MX8qxp Display Controller
 support
Message-ID: <wky3mjl7fn773myatyrdsea6oc2xebkvrgmigmmoj36eswgqry@2kox5ad5dynl>
References: <20240724092950.752536-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724092950.752536-1-victor.liu@nxp.com>

On Wed, Jul 24, 2024 at 05:29:31PM GMT, Liu Ying wrote:
> Hi,
> 
> This patch series aims to add Freescale i.MX8qxp Display Controller support.
> 
> The controller is comprised of three main components that include a blit
> engine for 2D graphics accelerations, display controller for display output
> processing, as well as a command sequencer.
> 
> Previous patch series attempts to do that can be found at:
> https://patchwork.freedesktop.org/series/84524/
> 
> This series addresses Maxime's comments on the previous one:
> a. Split the display controller into multiple internal devices.
>    1) List display engine, pixel engine, interrupt controller and more as the
>       controller's child devices.
>    2) List display engine and pixel engine's processing units as their child
>       devices.
> 
> b. Add minimal feature support.
>    Only support two display pipelines with primary planes with XR24 fb,
>    backed by two fetchunits.  No fetchunit dynamic allocation logic(to be done
>    when necessary).
> 
> c. Use drm_dev_{enter, exit}().
> 
> Since this series changes a lot comparing to the previous one, I choose to
> send it with a new patch series, not a new version.

I'm sorry, I have started reviewing v2 without noticing that there is a
v3 already.

Let me summarize my comments:

- You are using OF aliases. Are they documented and acked by DT
  maintainers?

- I generally feel that the use of so many small devices to declare
  functional blocks is an abuse of the DT. Please consider creating
  _small_ units from the driver code directly rather than going throught
  the components. Also please describe how everything fits together in
  the cover letter.

- I assume that there more functional units that you are cunrretly
  adding and there is more versatility. Please describe that in the
  commit messages.

- I see a lot of small functions, which can be inlined without the lost
  of code clarify. Please consider self-reviewing your code from this
  perspective.

- There were other small comments, but I think they are less important
  now. You might still consider them for v4.

> To follow up i.MX8qxp TRM, I changed the controller name to "Display Controller"
> instead of the previous "DPU".  "DPU" is only mentioned in the SoC block
> diagram and represents the whole display subsystem which includes the display
> controller and prefech engines, etc.
> 
> With an additional patch[1] for simple-pm-bus.c, this series facilitates
> testing a LVDS panel on i.MX8qxp MEK.
> 
> Please do NOT merge patch 14-19.
> 
> [1] https://lkml.org/lkml/2023/1/25/120
> 
> v3:
> * Collect Rob's R-b tag on the patch for adding fsl,imx8qxp-dc-intc.yaml.
> * Combine fsl,imx8qxp-dc-fetchunit-common.yaml,
>   fsl,imx8qxp-dc-fetchlayer.yaml and fsl,imx8qxp-dc-fetchwarp.yaml
>   into 1 schema doc fsl,imx8qxp-dc-fetchunit.yaml. (Rob)
> * Document all processing units, command sequencer, axi performance counter
>   and blit engine. (Rob)
> 
> v2:
> * Drop fsl,dc-*-id DT properties from fsl,imx8qxp-dc*.yaml. (Krzysztof)
> * Move port property from fsl,imx8qxp-dc-display-engine.yaml to
>   fsl,imx8qxp-dc-tcon.yaml. (Krzysztof)
> * Drop unneeded "|" from fsl,imx8qxp-dc-intc.yaml. (Krzysztof)
> * Use generic pmu pattern property in fsl,imx8qxp-dc.yaml. (Krzysztof)
> * Fix register range size in fsl,imx8qxp-dc*.yaml.
> * Use OF alias id to get instance id from display driver.
> * Find next bridge from TCon's port from display driver.
> * Drop drm/drm_module.h include from dc-drv.c.
> * Improve file list in MAINTAINERS. (Frank)
> * Add entire i.MX8qxp display controller device tree for review. (Krzysztof)
> * Add MIPI/LVDS subsystems device tree and a DT overlay for imx8qxp
>   MEK to test a LVDS panel as an example. (Francesco)
> 
> Liu Ying (19):
>   dt-bindings: display: imx: Add i.MX8qxp Display Controller processing
>     units
>   dt-bindings: display: imx: Add i.MX8qxp Display Controller blit engine
>   dt-bindings: display: imx: Add i.MX8qxp Display Controller display
>     engine
>   dt-bindings: display: imx: Add i.MX8qxp Display Controller pixel
>     engine
>   dt-bindings: display: imx: Add i.MX8qxp Display Controller AXI
>     performance counter
>   dt-bindings: display: imx: Add i.MX8qxp Display Controller command
>     sequencer
>   dt-bindings: interrupt-controller: Add i.MX8qxp Display Controller
>     interrupt controller
>   dt-bindings: display: imx: Add i.MX8qxp Display Controller
>   drm/imx: Add i.MX8qxp Display Controller display engine
>   drm/imx: Add i.MX8qxp Display Controller pixel engine
>   drm/imx: Add i.MX8qxp Display Controller interrupt controller
>   drm/imx: Add i.MX8qxp Display Controller KMS
>   MAINTAINERS: Add maintainer for i.MX8qxp Display Controller
>   dt-bindings: phy: mixel,mipi-dsi-phy: Allow assigned-clock* properties
>   dt-bindings: firmware: imx: Add SCU controlled display pixel link
>     nodes
>   arm64: dts: imx8qxp: Add display controller subsystem
>   arm64: dts: imx8qxp: Add MIPI-LVDS combo subsystems
>   arm64: dts: imx8qxp-mek: Enable display controller
>   arm64: dts: imx8qxp-mek: Add MX8-DLVDS-LCD1 display module support
> 
>  ...sl,imx8qxp-dc-axi-performance-counter.yaml |  57 ++
>  .../imx/fsl,imx8qxp-dc-blit-engine.yaml       | 204 +++++++
>  .../display/imx/fsl,imx8qxp-dc-blitblend.yaml |  41 ++
>  .../display/imx/fsl,imx8qxp-dc-clut.yaml      |  44 ++
>  .../imx/fsl,imx8qxp-dc-command-sequencer.yaml |  67 ++
>  .../imx/fsl,imx8qxp-dc-constframe.yaml        |  44 ++
>  .../imx/fsl,imx8qxp-dc-display-engine.yaml    | 152 +++++
>  .../display/imx/fsl,imx8qxp-dc-dither.yaml    |  45 ++
>  .../display/imx/fsl,imx8qxp-dc-extdst.yaml    |  72 +++
>  .../display/imx/fsl,imx8qxp-dc-fetchunit.yaml | 141 +++++
>  .../display/imx/fsl,imx8qxp-dc-filter.yaml    |  43 ++
>  .../display/imx/fsl,imx8qxp-dc-framegen.yaml  |  64 ++
>  .../display/imx/fsl,imx8qxp-dc-gammacor.yaml  |  32 +
>  .../imx/fsl,imx8qxp-dc-layerblend.yaml        |  39 ++
>  .../display/imx/fsl,imx8qxp-dc-matrix.yaml    |  44 ++
>  .../imx/fsl,imx8qxp-dc-pixel-engine.yaml      | 250 ++++++++
>  .../display/imx/fsl,imx8qxp-dc-rop.yaml       |  43 ++
>  .../display/imx/fsl,imx8qxp-dc-safety.yaml    |  34 ++
>  .../imx/fsl,imx8qxp-dc-scaling-engine.yaml    |  83 +++
>  .../display/imx/fsl,imx8qxp-dc-signature.yaml |  53 ++
>  .../display/imx/fsl,imx8qxp-dc-store.yaml     |  96 +++
>  .../display/imx/fsl,imx8qxp-dc-tcon.yaml      |  45 ++
>  .../bindings/display/imx/fsl,imx8qxp-dc.yaml  | 236 +++++++
>  .../devicetree/bindings/firmware/fsl,scu.yaml |  20 +
>  .../fsl,imx8qxp-dc-intc.yaml                  | 318 ++++++++++
>  .../bindings/phy/mixel,mipi-dsi-phy.yaml      |   5 -
>  MAINTAINERS                                   |   8 +
>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>  .../arm64/boot/dts/freescale/imx8-ss-dc0.dtsi | 408 +++++++++++++
>  .../imx8qxp-mek-mx8-dlvds-lcd1-lvds0-odd.dtso | 183 ++++++
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts |  34 ++
>  .../boot/dts/freescale/imx8qxp-ss-dc.dtsi     | 240 ++++++++
>  .../dts/freescale/imx8qxp-ss-mipi-lvds.dtsi   | 437 +++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    |  28 +-
>  drivers/gpu/drm/imx/Kconfig                   |   1 +
>  drivers/gpu/drm/imx/Makefile                  |   1 +
>  drivers/gpu/drm/imx/dc/Kconfig                |   8 +
>  drivers/gpu/drm/imx/dc/Makefile               |   7 +
>  drivers/gpu/drm/imx/dc/dc-cf.c                | 157 +++++
>  drivers/gpu/drm/imx/dc/dc-crtc.c              | 578 ++++++++++++++++++
>  drivers/gpu/drm/imx/dc/dc-crtc.h              |  67 ++
>  drivers/gpu/drm/imx/dc/dc-de.c                | 151 +++++
>  drivers/gpu/drm/imx/dc/dc-de.h                |  65 ++
>  drivers/gpu/drm/imx/dc/dc-drv.c               | 275 +++++++++
>  drivers/gpu/drm/imx/dc/dc-drv.h               |  54 ++
>  drivers/gpu/drm/imx/dc/dc-ed.c                | 266 ++++++++
>  drivers/gpu/drm/imx/dc/dc-fg.c                | 366 +++++++++++
>  drivers/gpu/drm/imx/dc/dc-fl.c                | 136 +++++
>  drivers/gpu/drm/imx/dc/dc-fu.c                | 241 ++++++++
>  drivers/gpu/drm/imx/dc/dc-fu.h                | 129 ++++
>  drivers/gpu/drm/imx/dc/dc-fw.c                | 149 +++++
>  drivers/gpu/drm/imx/dc/dc-ic.c                | 249 ++++++++
>  drivers/gpu/drm/imx/dc/dc-kms.c               | 143 +++++
>  drivers/gpu/drm/imx/dc/dc-kms.h               |  15 +
>  drivers/gpu/drm/imx/dc/dc-lb.c                | 300 +++++++++
>  drivers/gpu/drm/imx/dc/dc-pe.c                | 140 +++++
>  drivers/gpu/drm/imx/dc/dc-pe.h                |  91 +++
>  drivers/gpu/drm/imx/dc/dc-plane.c             | 227 +++++++
>  drivers/gpu/drm/imx/dc/dc-plane.h             |  37 ++
>  drivers/gpu/drm/imx/dc/dc-tc.c                | 137 +++++
>  60 files changed, 7598 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-axi-performance-counter.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blit-engine.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-blitblend.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-clut.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-command-sequencer.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-constframe.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-display-engine.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-dither.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-extdst.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-fetchunit.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-filter.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-framegen.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-gammacor.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-layerblend.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-matrix.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-pixel-engine.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-rop.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-safety.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-scaling-engine.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-signature.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-store.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc-tcon.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8qxp-dc.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,imx8qxp-dc-intc.yaml
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8-ss-dc0.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-mek-mx8-dlvds-lcd1-lvds0-odd.dtso
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-dc.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-ss-mipi-lvds.dtsi
>  create mode 100644 drivers/gpu/drm/imx/dc/Kconfig
>  create mode 100644 drivers/gpu/drm/imx/dc/Makefile
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-cf.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-crtc.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-crtc.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-de.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-de.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-drv.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-drv.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-ed.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-fg.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-fl.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-fu.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-fu.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-fw.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-ic.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-kms.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-kms.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-lb.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-pe.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-pe.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-plane.c
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-plane.h
>  create mode 100644 drivers/gpu/drm/imx/dc/dc-tc.c
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

