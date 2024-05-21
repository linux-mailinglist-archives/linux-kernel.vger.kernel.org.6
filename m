Return-Path: <linux-kernel+bounces-184611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DF8CA993
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB893B2255C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38455E74;
	Tue, 21 May 2024 08:04:11 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACDD5490A;
	Tue, 21 May 2024 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278650; cv=none; b=UpymlUSwnX60vZRSj/5U0pcMRNGDIhjNLQ1csyAAy+HN+2JDc3VHY3BMaU50oGjq+GSmT1CgIgFBx3eyI+8coMIxQR+/ssrrHiI+zLTIdJSM6IxOITnGG6mrBCig66TWqU3bo9RIKjcpk3VtdyVT5ku7vPkWa48+67oMwNKzMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278650; c=relaxed/simple;
	bh=3ppxC9mGCjL0Jd9a6tjEAl+tSEy/SHN4VaC3i/duHIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzENww/MKBFeuPjBcPj8hGu7qo2rAgBb078SB7fbA5gDVXqJhTZ0K30wepHPNdtXHYfJgZFO1R63H+5RS5RXdXgZ/PR7HlMMgpRu9IvXuaUFUOSebwDwlqA7WZyX2VaesI+koplGm2Op1TrlKW12N3ZSqpXtksTBiprDRR1iqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875abf.versanet.de ([83.135.90.191] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1s9KSz-0007vG-WB; Tue, 21 May 2024 10:03:26 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hjc@rock-chips.com, andy.yan@rock-chips.com,
 xingyu.wu@starfivetech.com, p.zabel@pengutronix.de,
 jack.zhu@starfivetech.com, shengyang.chen@starfivetech.com,
 keith <keith.zhao@starfivetech.com>, Alex Bee <knaerzche@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 keith.zhao@starfivetech.com
Subject: Re: [PATCH v4 00/10] drm/verisilicon : support DC8200 and inno hdmi
Date: Tue, 21 May 2024 10:03:24 +0200
Message-ID: <3222561.5fSG56mABF@diego>
In-Reply-To: <20240521105817.3301-1-keith.zhao@starfivetech.com>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alex,

Am Dienstag, 21. Mai 2024, 12:58:07 CEST schrieb keith:
> Verisilicon/DC8200 display controller IP has 2 display pipes and each 
> pipe support a primary plane and a cursor plane . 
> In addition, there are four overlay planes as two display pipes common resources.
> 
> The first display pipe is bound to the inno HDMI encoder.
> The second display pipe is bound to a simple encoder, which is used to
> find dsi bridge by dts node. 
> 
> Patch 1 adds YAML schema for JH7110 display pipeline.
> 
> Patches 2 to 3 add inno common api and match the ROCKCHIP inno hdmi driver 
> by calling the common api. 
> The collating public interface is based on ROCKCHIP inno hdmi, 
> and it can be resused by JH7110 inno hdmi.
> Those common api are tested on rk-3128 SDK, which kernel version is 4.x. 

as you were working on the rk3128-inno-hdmi variant recently
and I don't really have a rk3036 or rk3128 in working condition
right now, could you give this series a try.

For reference, the full series is at lore:
https://lore.kernel.org/dri-devel/20240521105817.3301-1-keith.zhao@starfivetech.com/

and generalizes the inno-hdmi driver into the bridge model we
have in a number of other places already.


Thanks
Heiko



> step1, make sure the process is consistent with the latest kernel version.
> step2, just remove the interface and add a common interface. 
> 
> Patches 4 to 8 add kms driver for dc8200 display controller.
> 
> Patch 9 adds inno hdmi support for JH7110 display pipeline.
> 
> Patch 10 adds a simple encoder.
> 
> This patchset should be applied on next branch.
> 
> V1:
> Changes since v1:
> - Further standardize the yaml file.
> - Dts naming convention improved.
> - Fix the problem of compiling and loading ko files.
> - Use drm new api to automatically manage resources.
> - Drop vs_crtc_funcs&vs_plane_funcs, subdivide the plane's help interface.
> - Reduce the modifiers unused.
> - Optimize the hdmi driver code
> 
> V2:
> Changes since v2:
> - fix the error about checking the yaml file.
> - match drm driver GEM DMA API.
> - Delete the custom crtc property .
> - hdmi use drmm_ new api to automatically manage resources.
> - update the modifiers comments.
> - enabling KASAN, fix the error during removing module 
> 
> V3:
> Changes since v3:
> - Delete the custom plane property.
> - Delete the custom fourcc modifiers.
> - Adjust the calculation mode of hdmi pixclock.
> - Add match data for dc8200 driver.
> - Adjust some magic values.
> - Add a simple encoder for dsi output.
> 
> V4:
> Changes since v4:
> - Delete the display subsystem module as all crtcs and planes are a driver.
> - Delete the custom struct, directly use the drm struct data.
> - Tidy up the inno hdmi public interface.
> - Add a simple encoder for dsi output.
> 
> keith (10):
>   dt-bindings: display: Add YAML schema for JH7110 display pipeline
>   drm/bridge: add common api for inno hdmi
>   drm/rockchip:hdmi: migrate to use inno-hdmi bridge driver
>   drm/vs: Add hardware funcs for vs.
>   drm/vs: add vs mode config init
>   drm/vs: add vs plane api
>   drm/vs: add ctrc fun
>   drm/vs: add vs drm master driver
>   drm/vs: Innosilicon HDMI support
>   drm/vs: add simple dsi encoder
> 
>  .../display/bridge/innosilicon,inno-hdmi.yaml |   49 +
>  .../display/rockchip/rockchip,inno-hdmi.yaml  |   27 +-
>  .../starfive/starfive,dsi-encoder.yaml        |   92 ++
>  .../starfive/starfive,jh7110-dc8200.yaml      |  169 +++
>  .../starfive/starfive,jh7110-inno-hdmi.yaml   |   75 ++
>  .../soc/starfive/starfive,jh7110-syscon.yaml  |    1 +
>  MAINTAINERS                                   |   11 +
>  drivers/gpu/drm/Kconfig                       |    2 +
>  drivers/gpu/drm/Makefile                      |    1 +
>  drivers/gpu/drm/bridge/Kconfig                |    2 +
>  drivers/gpu/drm/bridge/Makefile               |    1 +
>  drivers/gpu/drm/bridge/innosilicon/Kconfig    |    6 +
>  drivers/gpu/drm/bridge/innosilicon/Makefile   |    2 +
>  .../gpu/drm/bridge/innosilicon/inno-hdmi.c    |  587 +++++++++
>  .../gpu/drm/bridge/innosilicon/inno-hdmi.h    |   97 ++
>  drivers/gpu/drm/rockchip/Kconfig              |    1 +
>  drivers/gpu/drm/rockchip/Makefile             |    2 +-
>  drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c |  517 ++++++++
>  .../{inno_hdmi.h => inno_hdmi-rockchip.h}     |   45 -
>  drivers/gpu/drm/rockchip/inno_hdmi.c          | 1073 -----------------
>  drivers/gpu/drm/verisilicon/Kconfig           |   23 +
>  drivers/gpu/drm/verisilicon/Makefile          |   11 +
>  .../gpu/drm/verisilicon/inno_hdmi-starfive.c  |  481 ++++++++
>  .../gpu/drm/verisilicon/inno_hdmi-starfive.h  |  152 +++
>  drivers/gpu/drm/verisilicon/vs_crtc.c         |  241 ++++
>  drivers/gpu/drm/verisilicon/vs_crtc.h         |   17 +
>  drivers/gpu/drm/verisilicon/vs_dc_hw.c        | 1060 ++++++++++++++++
>  drivers/gpu/drm/verisilicon/vs_dc_hw.h        |  493 ++++++++
>  drivers/gpu/drm/verisilicon/vs_drv.c          |  721 +++++++++++
>  drivers/gpu/drm/verisilicon/vs_drv.h          |   98 ++
>  drivers/gpu/drm/verisilicon/vs_modeset.c      |   36 +
>  drivers/gpu/drm/verisilicon/vs_modeset.h      |   10 +
>  drivers/gpu/drm/verisilicon/vs_plane.c        |  487 ++++++++
>  drivers/gpu/drm/verisilicon/vs_plane.h        |   26 +
>  drivers/gpu/drm/verisilicon/vs_simple_enc.c   |  190 +++
>  drivers/gpu/drm/verisilicon/vs_simple_enc.h   |   25 +
>  drivers/gpu/drm/verisilicon/vs_type.h         |   84 ++
>  include/drm/bridge/inno_hdmi.h                |   69 ++
>  38 files changed, 5840 insertions(+), 1144 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/innosilicon,inno-hdmi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,dsi-encoder.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-dc8200.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/starfive/starfive,jh7110-inno-hdmi.yaml
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/Makefile
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.c
>  create mode 100644 drivers/gpu/drm/bridge/innosilicon/inno-hdmi.h
>  create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
>  rename drivers/gpu/drm/rockchip/{inno_hdmi.h => inno_hdmi-rockchip.h} (85%)
>  delete mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
>  create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
>  create mode 100644 drivers/gpu/drm/verisilicon/Makefile
>  create mode 100644 drivers/gpu/drm/verisilicon/inno_hdmi-starfive.c
>  create mode 100644 drivers/gpu/drm/verisilicon/inno_hdmi-starfive.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_hw.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_drv.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_modeset.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.c
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_simple_enc.h
>  create mode 100644 drivers/gpu/drm/verisilicon/vs_type.h
>  create mode 100644 include/drm/bridge/inno_hdmi.h
> 
> 





