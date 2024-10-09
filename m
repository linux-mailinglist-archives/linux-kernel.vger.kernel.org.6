Return-Path: <linux-kernel+bounces-357559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E305A997288
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFF31C21D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9B1DF730;
	Wed,  9 Oct 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gFOESffi"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56D1ABEA3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493353; cv=none; b=W+C6tFiEfEIgrOLBN2fuxz9k2r7VLhMOOHynSs9rgbrlhpPJloRJfC4eeMRi8BGxfkOabfAUKd21aWKPIwfpr/WgBXtAFtdI7MOH2C/aXvFRbP1fxwANvPZqB9mCvwY20S7sL0Zo7K7mcaAphMSG9+u//9slmBiMLA2YLYohOv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493353; c=relaxed/simple;
	bh=mttAN8gAmug/WRCXWXBwzZJGipM6jp7d4/fcUaRhKZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hnm+GRtGEDb8wKI6KlN5Yr7uzPMvUa7B9ymmRhymwmrL8KI2V/sLFooRjuChcgqUoR3vq4qbX43mzIEVq70kdfq7P63aS8B9G4e7VGR4VnUMaPacf63GVDVabHllzapDvaXXoOTPcgOThO8MFMEdY2nUYK4M0+x5aeM6mjbIDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gFOESffi; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e2e4d16c2fso704627b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728493349; x=1729098149; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HmuJ+4jaJhsbU4VCD5RiKGdf+RUhWMvkOyzmzLrv8CM=;
        b=gFOESffiZZjOXYHgM6e5fVR8F4TlVE0l5P7zOIpKpqavQKauZhvby3CStwHoE1+M87
         Z4BbGx/ihf8W6IzYTYO6EuBmFV1lFMgSxfvh/fvQyuaL0u1/Z75jJojua1Y0ZS6vAlaw
         spRgk2InVOPwlE/bt3dyCXCL9lFO6Vbmkomq3KDuKITCg8Q50t/z42Co2Dp5bArs2lv3
         +2mDkDskm9ITBMF3cs4WOwzskM/0PiGh0IXQVP48m6FfRGRQB3S90ygknrF22r+Q7d37
         j2qRFYjEDilzFMD+HxtfaSH7iwA++Y0aWWc+XecvNonGYLp6uHjEUgnVfy2n3oQAm2qA
         DtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493349; x=1729098149;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmuJ+4jaJhsbU4VCD5RiKGdf+RUhWMvkOyzmzLrv8CM=;
        b=IdSU0b4yMC34fg74pbxWlnvV7ZwUaOCSLJMcpLB39h3Q9Bw1Xgx0wlsVXs4/YSUr50
         O08aepeLsQ1h6jlYzLMiARA4nWo9qcGRxBg84aM4AXVU9CsgnHLePAb/JwnXzEkL+TQ0
         TVI99q/D4vVmnhvF1kbtcb22Eq/4TVucDqyBFq2X3zemkz1esO10ly1vjxzLOlNkLaJE
         qN7tZMbl/WTr33c4QsLlbWzjoGlpqKVmWmNZ4dVw7jGcGAYUyr6YuYWmNXSg2avzvZjU
         igz+ESn2TxSX4StgjFJ0bZfCYU3Z1U3NiHl1/5LaA12uNthuPYIUewnd8dHaY3V2NCG3
         lTmA==
X-Forwarded-Encrypted: i=1; AJvYcCWlHhLM+/vCOenevRaTTj1KasobhFgtMRtvY1rRch4o62Rn3QWVI0+yy1pLKvI1I/z0sDKLqaB08ufpUUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIIBudcefBwpEH/RGObMm0tYSkrVlWjvFT43PCsCJlxhfHbmwR
	l32rB+qrbraro5KTPo6G4fZ8CeGbvuLa7ED7nCcx5xd9nNvdPCMMS9j/zP+zoB6hM98oA/z0qMT
	8sNBHdXe2nnB9XtLjtC3UnU+35JYbnja/oqsHBg==
X-Google-Smtp-Source: AGHT+IGpwZ/+dUYhXRQlfPdW/RwT8VXJQq3bNL8UgtyUiCncGNeTv9xNf2Ud6KNMnpy4IU9p8eGA7Krc8a56if0MfRE=
X-Received: by 2002:a05:690c:93:b0:65f:a0e5:8324 with SMTP id
 00721157ae682-6e32210e2e0mr36161627b3.4.1728493348978; Wed, 09 Oct 2024
 10:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930052903.168881-1-victor.liu@nxp.com> <20240930052903.168881-7-victor.liu@nxp.com>
 <TYWPR01MB11343E3DE82874B557B537B6186762@TYWPR01MB11343.jpnprd01.prod.outlook.com>
 <TY3PR01MB113465DEDB647BA45908802AA86762@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <1f5a321e-6f95-4eeb-80e4-24d96d5034ef@nxp.com>
In-Reply-To: <1f5a321e-6f95-4eeb-80e4-24d96d5034ef@nxp.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 9 Oct 2024 20:02:17 +0300
Message-ID: <CAA8EJppMzNu9yuWhwoQJp4y=Q=0c_HCzT9ng-iLTZ6juAEVGug@mail.gmail.com>
Subject: Re: [PATCH 6/8] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
To: Liu Ying <victor.liu@nxp.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org" <rfoss@kernel.org>, 
	"laurent.pinchart" <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "arnd@arndb.de" <arnd@arndb.de>, 
	"nfraprado@collabora.com" <nfraprado@collabora.com>, 
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, "y.moog@phytec.de" <y.moog@phytec.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 11:32, Liu Ying <victor.liu@nxp.com> wrote:
>
> On 09/30/2024, Biju Das wrote:
> > Hi Liu,
>
> Hi Biju,
>
> >
> >> -----Original Message-----
> >> From: Biju Das
> >> Sent: Monday, September 30, 2024 10:16 AM
> >> Subject: RE: [PATCH 6/8] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
> >>
> >> Hi Liu,
> >>
> >> Thanks for the patch.
> >>
> >>> -----Original Message-----
> >>> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>
> >>> On Behalf Of Liu Ying
> >>> Sent: Monday, September 30, 2024 6:29 AM
> >>> Subject: [PATCH 6/8] drm/bridge: Add ITE IT6263 LVDS to HDMI converter
> >>>
> >>> Add basic HDMI video output support. Currently, only RGB888 output
> >>> pixel format is supported.  At the LVDS input side, the driver
> >>> supports single LVDS link and dual LVDS links with "jeida-24" LVDS mapping.
> >>>
> >>> Product link:
> >>> https://www.ite.com.tw/en/product/cate1/IT6263
> >>>
> >>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> >>> ---
> >>>  drivers/gpu/drm/bridge/Kconfig      |   8 +
> >>>  drivers/gpu/drm/bridge/Makefile     |   1 +
> >>>  drivers/gpu/drm/bridge/ite-it6263.c | 829
> >>> ++++++++++++++++++++++++++++
> >>>  3 files changed, 838 insertions(+)
> >>>  create mode 100644 drivers/gpu/drm/bridge/ite-it6263.c
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/Kconfig
> >>> b/drivers/gpu/drm/bridge/Kconfig index
> >>> 3eb955333c80..93f99682a090 100644
> >>> --- a/drivers/gpu/drm/bridge/Kconfig
> >>> +++ b/drivers/gpu/drm/bridge/Kconfig
> >>> @@ -90,6 +90,14 @@ config DRM_FSL_LDB
> >>>     help
> >>>       Support for i.MX8MP DPI-to-LVDS on-SoC encoder.
> >>>
> >>> +config DRM_ITE_IT6263
> >>> +   tristate "ITE IT6263 LVDS/HDMI bridge"
> >>> +   depends on OF
> >>> +   select DRM_KMS_HELPER
> >>> +   select REGMAP_I2C
> >>> +   help
> >>> +     ITE IT6263 LVDS to HDMI bridge chip driver.
> >>> +
> >>>  config DRM_ITE_IT6505
> >>>     tristate "ITE IT6505 DisplayPort bridge"
> >>>     depends on OF
> >>> diff --git a/drivers/gpu/drm/bridge/Makefile
> >>> b/drivers/gpu/drm/bridge/Makefile index 7df87b582dca..f3776dd473fd
> >>> 100644
> >>> --- a/drivers/gpu/drm/bridge/Makefile
> >>> +++ b/drivers/gpu/drm/bridge/Makefile
> >>> @@ -6,6 +6,7 @@ obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
> >>>  obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
> >>>  obj-$(CONFIG_DRM_DISPLAY_CONNECTOR) += display-connector.o
> >>>  obj-$(CONFIG_DRM_FSL_LDB) += fsl-ldb.o
> >>> +obj-$(CONFIG_DRM_ITE_IT6263) += ite-it6263.o
> >>>  obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
> >>>  obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
> >>>  obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o diff --git
> >>> a/drivers/gpu/drm/bridge/ite-it6263.c
> >>> b/drivers/gpu/drm/bridge/ite-it6263.c
> >>> new file mode 100644
> >>> index 000000000000..886588497bc1
> >>> --- /dev/null
> >>> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> >>> @@ -0,0 +1,829 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright 2024 NXP
> >>> + */
> >>> +
> >>> +#include <linux/bitfield.h>
> >>> +#include <linux/bits.h>
> >>> +#include <linux/delay.h>
> >>> +#include <linux/gpio/consumer.h>
> >>> +#include <linux/i2c.h>
> >>> +#include <linux/media-bus-format.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/regmap.h>
> >>> +#include <linux/regulator/consumer.h>
> >>> +
> >>> +#include <drm/drm_atomic.h>
> >>> +#include <drm/drm_atomic_helper.h>
> >>> +#include <drm/drm_atomic_state_helper.h> #include <drm/drm_bridge.h>
> >>> +#include <drm/drm_connector.h> #include <drm/drm_crtc.h> #include
> >>> +<drm/drm_edid.h> #include <drm/drm_of.h> #include
> >>> +<drm/drm_probe_helper.h>
> >>> +
> >>> +/*
> >>> +---------------------------------------------------------------------
> >>> +--
> >>> +------
> >>> + * LVDS registers
> >>> + */
> >>> +
> >>> +/* LVDS software reset registers */
> >>> +#define LVDS_REG_05                        0x05
> >>> +#define  REG_SOFT_P_RST                    BIT(1)
> >>> +
> >>> +/* LVDS system configuration registers */
> >>> +/* 0x0b */
> >>> +#define LVDS_REG_0B                        0x0b
> >>> +#define  REG_SSC_PCLK_RF           BIT(0)
> >>> +#define  REG_LVDS_IN_SWAP          BIT(1)
> >>> +
> >>> +/* LVDS test pattern gen control registers */
> >>> +/* 0x2c */
> >>> +#define LVDS_REG_2C                        0x2c
> >>> +#define  REG_COL_DEP                       GENMASK(1, 0)
> >>> +#define  BIT8                              FIELD_PREP(REG_COL_DEP, 2)
> >>> +#define  OUT_MAP                   BIT(4)
> >>> +#define  JEIDA                             0
> >>> +#define  REG_DESSC_ENB                     BIT(6)
> >>> +#define  DMODE                             BIT(7)
> >>> +#define  DISO                              BIT(7)
> >>> +#define  SISO                              0
> >>> +
> >>> +#define LVDS_REG_3C                        0x3c
> >>> +#define LVDS_REG_3F                        0x3f
> >>> +#define LVDS_REG_47                        0x47
> >>> +#define LVDS_REG_48                        0x48
> >>> +#define LVDS_REG_4F                        0x4f
> >>> +#define LVDS_REG_52                        0x52
> >>> +
> >>> +/*
> >>> +---------------------------------------------------------------------
> >>> +--
> >>> +------
> >>> + * HDMI registers are separated into three banks:
> >>> + * 1) HDMI register common bank: 0x00 ~ 0x2f  */
> >>> +
> >>> +/* HDMI genernal registers */
> >>> +#define HDMI_REG_SW_RST                    0x04
> >>> +#define  SOFTREF_RST                       BIT(5)
> >>> +#define  SOFTA_RST                 BIT(4)
> >>> +#define  SOFTV_RST                 BIT(3)
> >>> +#define  AUD_RST                   BIT(2)
> >>> +#define  HDCP_RST                  BIT(0)
> >>> +#define  HDMI_RST_ALL                      (SOFTREF_RST | SOFTA_RST | SOFTV_RST | \
> >>> +                                    AUD_RST | HDCP_RST)
> >>> +
> >>> +#define HDMI_REG_SYS_STATUS                0x0e
> >>> +#define  HPDETECT                  BIT(6)
> >>> +#define  TXVIDSTABLE                       BIT(4)
> >>> +
> >>> +#define HDMI_REG_BANK_CTRL         0x0f
> >>> +#define  REG_BANK_SEL                      BIT(0)
> >>> +
> >>> +/* HDMI System DDC control registers */
> >>> +#define HDMI_REG_DDC_MASTER_CTRL   0x10
> >>> +#define  MASTER_SEL_HOST           BIT(0)
> >>> +
> >>> +#define HDMI_REG_DDC_HEADER                0x11
> >>> +
> >>> +#define HDMI_REG_DDC_REQOFF                0x12
> >>> +#define HDMI_REG_DDC_REQCOUNT              0x13
> >>> +#define HDMI_REG_DDC_EDIDSEG               0x14
> >>> +
> >>> +#define HDMI_REG_DDC_CMD           0x15
> >>> +#define  DDC_CMD_EDID_READ         0x3
> >>> +#define  DDC_CMD_FIFO_CLR          0x9
> >>> +
> >>> +#define HDMI_REG_DDC_STATUS                0x16
> >>> +#define  DDC_DONE                  BIT(7)
> >>> +#define  DDC_NOACK                 BIT(5)
> >>> +#define  DDC_WAITBUS                       BIT(4)
> >>> +#define  DDC_ARBILOSE                      BIT(3)
> >>> +#define  DDC_ERROR                 (DDC_NOACK | DDC_WAITBUS | DDC_ARBILOSE)
> >>> +
> >>> +#define HDMI_DDC_FIFO_BYTES                32
> >>> +#define HDMI_REG_DDC_READFIFO              0x17
> >>> +#define HDMI_REG_LVDS_PORT         0x1d /* LVDS input control I2C addr */
> >>> +#define HDMI_REG_LVDS_PORT_EN              0x1e
> >>> +#define LVDS_INPUT_CTRL_I2C_ADDR   0x33
> >>> +
> >>> +/*
> >>> +---------------------------------------------------------------------
> >>> +--
> >>> +------
> >>> + * 2) HDMI register bank0: 0x30 ~ 0xff  */
> >>> +
> >>> +/* HDMI AFE registers */
> >>> +#define HDMI_REG_AFE_DRV_CTRL              0x61
> >>> +#define  AFE_DRV_PWD                       BIT(5)
> >>> +#define  AFE_DRV_RST                       BIT(4)
> >>> +
> >>> +#define HDMI_REG_AFE_XP_CTRL               0x62
> >>> +#define  AFE_XP_GAINBIT                    BIT(7)
> >>> +#define  AFE_XP_ER0                        BIT(4)
> >>> +#define  AFE_XP_RESETB                     BIT(3)
> >>> +
> >>> +#define HDMI_REG_AFE_ISW_CTRL              0x63
> >>> +
> >>> +#define HDMI_REG_AFE_IP_CTRL               0x64
> >>> +#define  AFE_IP_GAINBIT                    BIT(7)
> >>> +#define  AFE_IP_ER0                        BIT(3)
> >>> +#define  AFE_IP_RESETB                     BIT(2)
> >>> +
> >>> +/* HDMI input data format registers */
> >>> +#define HDMI_REG_INPUT_MODE                0x70
> >>> +#define  IN_RGB                            0x00
> >>> +
> >>> +/* HDMI general control registers */
> >>> +#define HDMI_REG_HDMI_MODE         0xc0
> >>> +#define  TX_HDMI_MODE                      BIT(0)
> >>> +
> >>> +#define HDMI_REG_GCP                       0xc1
> >>> +#define  AVMUTE                            BIT(0)
> >>> +#define  HDMI_COLOR_DEPTH          GENMASK(6, 4)
> >>> +#define  HDMI_COLOR_DEPTH_24               FIELD_PREP(HDMI_COLOR_DEPTH, 4)
> >>> +
> >>> +#define HDMI_REG_PKT_GENERAL_CTRL  0xc6
> >>> +#define  ENABLE_PKT                        BIT(0)
> >>> +#define  REPEAT_PKT                        BIT(1)
> >>> +
> >>> +/*
> >>> +---------------------------------------------------------------------
> >>> +--
> >>> +------
> >>> + * 3) HDMI register bank1: 0x130 ~ 0x1ff (HDMI packet registers)  */
> >>> +
> >>> +/* AVI packet registers */
> >>> +#define HDMI_REG_AVI_DB1           0x158
> >>> +#define  AVI_DB1_COLOR_SPACE               GENMASK(6, 5)
> >>> +#define  AVI_COLOR_SPACE_RGB               FIELD_PREP(AVI_DB1_COLOR_SPACE, 0)
> >>> +
> >>> +#define MAX_PIXEL_CLOCK_KHZ                150000
> >>> +#define HIGH_PIXEL_CLOCK_KHZ               80000
> >>> +
> >>> +struct it6263 {
> >>> +   struct device *dev;
> >>> +   struct i2c_client *hdmi_i2c;
> >>> +   struct i2c_client *lvds_i2c;
> >>> +   struct regmap *hdmi_regmap;
> >>> +   struct regmap *lvds_regmap;
> >>> +   struct drm_bridge bridge;
> >>> +   struct drm_bridge *next_bridge;
> >>> +   struct drm_connector connector;
> >>> +   struct gpio_desc *reset_gpio;
> >>> +   bool lvds_dual_link;
> >>> +   bool lvds_link12_swap;
> >>> +};
> >>> +
> >>> +static inline struct it6263 *bridge_to_it6263(struct drm_bridge
> >>> +*bridge) {
> >>> +   return container_of(bridge, struct it6263, bridge); }
> >>> +
> >>> +static inline struct it6263 *connector_to_it6263(struct drm_connector
> >>> +*conn) {
> >>> +   return container_of(conn, struct it6263, connector); }
> >>> +
> >>> +static bool it6263_hdmi_writeable_reg(struct device *dev, unsigned
> >>> +int
> >>> +reg) {
> >>> +   switch (reg) {
> >>> +   case HDMI_REG_SW_RST:
> >>> +   case HDMI_REG_BANK_CTRL:
> >>> +   case HDMI_REG_DDC_MASTER_CTRL:
> >>> +   case HDMI_REG_DDC_HEADER:
> >>> +   case HDMI_REG_DDC_REQOFF:
> >>> +   case HDMI_REG_DDC_REQCOUNT:
> >>> +   case HDMI_REG_DDC_EDIDSEG:
> >>> +   case HDMI_REG_DDC_CMD:
> >>> +   case HDMI_REG_LVDS_PORT:
> >>> +   case HDMI_REG_LVDS_PORT_EN:
> >>> +   case HDMI_REG_AFE_DRV_CTRL:
> >>> +   case HDMI_REG_AFE_XP_CTRL:
> >>> +   case HDMI_REG_AFE_ISW_CTRL:
> >>> +   case HDMI_REG_AFE_IP_CTRL:
> >>> +   case HDMI_REG_INPUT_MODE:
> >>> +   case HDMI_REG_HDMI_MODE:
> >>> +   case HDMI_REG_GCP:
> >>> +   case HDMI_REG_PKT_GENERAL_CTRL:
> >>> +   case HDMI_REG_AVI_DB1:
> >>> +           return true;
> >>> +   default:
> >>> +           return false;
> >>> +   }
> >>> +}
> >>> +
> >>> +static bool it6263_hdmi_readable_reg(struct device *dev, unsigned int
> >>> +reg) {
> >>> +   if (it6263_hdmi_writeable_reg(dev, reg))
> >>> +           return true;
> >>> +
> >>> +   switch (reg) {
> >>> +   case HDMI_REG_SYS_STATUS:
> >>> +   case HDMI_REG_DDC_STATUS:
> >>> +   case HDMI_REG_DDC_READFIFO:
> >>> +           return true;
> >>> +   default:
> >>> +           return false;
> >>> +   }
> >>> +}
> >>> +
> >>> +static bool it6263_hdmi_volatile_reg(struct device *dev, unsigned int
> >>> +reg) {
> >>> +   switch (reg) {
> >>> +   case HDMI_REG_SW_RST:
> >>> +   case HDMI_REG_SYS_STATUS:
> >>> +   case HDMI_REG_DDC_STATUS:
> >>> +   case HDMI_REG_DDC_READFIFO:
> >>> +           return true;
> >>> +   default:
> >>> +           return false;
> >>> +   }
> >>> +}
> >>> +
> >>> +static const struct regmap_range_cfg it6263_hdmi_range_cfg = {
> >>> +   .range_min = 0x00,
> >>> +   .range_max = HDMI_REG_AVI_DB1,
> >>> +   .selector_reg = HDMI_REG_BANK_CTRL,
> >>> +   .selector_mask = REG_BANK_SEL,
> >>> +   .selector_shift = 0,
> >>> +   .window_start = 0x00,
> >>> +   .window_len = 0x100,
> >>> +};
> >>> +
> >>> +static const struct regmap_config it6263_hdmi_regmap_config = {
> >>> +   .name = "it6263-hdmi",
> >>> +   .reg_bits = 8,
> >>> +   .val_bits = 8,
> >>> +   .writeable_reg = it6263_hdmi_writeable_reg,
> >>> +   .readable_reg = it6263_hdmi_readable_reg,
> >>> +   .volatile_reg = it6263_hdmi_volatile_reg,
> >>> +   .max_register = HDMI_REG_AVI_DB1,
> >>> +   .ranges = &it6263_hdmi_range_cfg,
> >>> +   .num_ranges = 1,
> >>> +   .cache_type = REGCACHE_MAPLE,
> >>> +};
> >>> +
> >>> +static bool it6263_lvds_writeable_reg(struct device *dev, unsigned
> >>> +int
> >>> +reg) {
> >>> +   switch (reg) {
> >>> +   case LVDS_REG_05:
> >>> +   case LVDS_REG_0B:
> >>> +   case LVDS_REG_2C:
> >>> +   case LVDS_REG_3C:
> >>> +   case LVDS_REG_3F:
> >>> +   case LVDS_REG_47:
> >>> +   case LVDS_REG_48:
> >>> +   case LVDS_REG_4F:
> >>> +   case LVDS_REG_52:
> >>> +           return true;
> >>> +   default:
> >>> +           return false;
> >>> +   }
> >>> +}
> >>> +
> >>> +static bool it6263_lvds_readable_reg(struct device *dev, unsigned int
> >>> +reg) {
> >>> +   return it6263_lvds_writeable_reg(dev, reg); }
> >>> +
> >>> +static bool it6263_lvds_volatile_reg(struct device *dev, unsigned int
> >>> +reg) {
> >>> +   return reg == LVDS_REG_05;
> >>> +}
> >>> +
> >>> +static const struct regmap_config it6263_lvds_regmap_config = {
> >>> +   .name = "it6263-lvds",
> >>> +   .reg_bits = 8,
> >>> +   .val_bits = 8,
> >>> +   .writeable_reg = it6263_lvds_writeable_reg,
> >>> +   .readable_reg = it6263_lvds_readable_reg,
> >>> +   .volatile_reg = it6263_lvds_volatile_reg,
> >>> +   .max_register = LVDS_REG_52,
> >>> +   .cache_type = REGCACHE_MAPLE,
> >>> +};
> >>> +
> >>> +static const char * const it6263_supplies[] = {
> >>> +   "ivdd", "ovdd", "txavcc18", "txavcc33", "pvcc1", "pvcc2",
> >>> +   "avcc", "anvdd", "apvdd"
> >>> +};
> >>> +
> >>> +static int it6263_parse_dt(struct it6263 *it) {
> >>> +   struct device *dev = it->dev;
> >>> +   struct device_node *port0, *port1;
> >>> +   int ret = 0;
> >>> +
> >>> +   it->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> >>> +   if (IS_ERR(it->next_bridge))
> >>> +           return dev_err_probe(dev, PTR_ERR(it->next_bridge),
> >>> +                                "failed to get next bridge\n");
> >>> +
> >>> +   port0 = of_graph_get_port_by_id(dev->of_node, 0);
> >>> +   port1 = of_graph_get_port_by_id(dev->of_node, 1);
> >>> +   if (port0 && port1) {
> >>> +           if (of_property_read_bool(port0, "dual-lvds-even-pixels") &&
> >>> +               of_property_read_bool(port1, "dual-lvds-odd-pixels")) {
> >>> +                   it->lvds_dual_link = true;
> >>> +                   it->lvds_link12_swap = true;
> >>> +           } else if (of_property_read_bool(port0, "dual-lvds-odd-pixels") &&
> >>> +                      of_property_read_bool(port1, "dual-lvds-even-pixels")) {
> >>> +                   it->lvds_dual_link = true;
> >>> +           }
> >>> +
> >>> +           if (!it->lvds_dual_link) {
> >>> +                   dev_err(dev,
> >>> +                           "failed to get LVDS dual link pixel order\n");
> >>> +                   ret = -EINVAL;
> >>> +           }
> >>> +   } else if (port1) {
> >>> +           ret = -EINVAL;
> >>> +           dev_err(dev, "single input LVDS port1 is not supported\n");
> >>
> >>              Are you supporting single input LVDS port0??
> >>
> >>> +   } else if (!port0) {
> >>> +           ret = -EINVAL;
> >>> +           dev_err(dev, "no input LVDS port\n");
> >>> +   }
> >>> +
> >>> +   of_node_put(port0);
> >>> +   of_node_put(port1);
> >>> +
> >>> +   return ret;
> >>> +}
> >>> +
> >>> +static inline void it6263_reset(struct it6263 *it) {
> >>> +   if (!it->reset_gpio)
> >>> +           return;
> >>> +
> >>> +   gpiod_set_value_cansleep(it->reset_gpio, 0);
> >>> +   fsleep(1000);
> >>> +   gpiod_set_value_cansleep(it->reset_gpio, 1);
> >>> +   /* The chip maker says the low pulse should be at least 40ms. */
> >>> +   fsleep(40000);
> >>> +   gpiod_set_value_cansleep(it->reset_gpio, 0);
> >>> +   /* addtional time to wait the high voltage to be stable */
> >>> +   fsleep(5000);
> >>
> >> What about other resets ??
> >>
> >> /* AFE PLL reset and  pclk reset */
> >>
> >>> +}
> >>> +
> >>> +static inline int it6263_lvds_set_i2c_addr(struct it6263 *it) {
> >>> +   int ret;
> >>> +
> >>> +   ret = regmap_write(it->hdmi_regmap, HDMI_REG_LVDS_PORT,
> >>> +                      LVDS_INPUT_CTRL_I2C_ADDR << 1);
> >>> +   if (ret)
> >>> +           return ret;
> >>> +
> >>> +   return regmap_write(it->hdmi_regmap, HDMI_REG_LVDS_PORT_EN, BIT(0));
> >>> +}
> >>> +
> >>> +static inline void it6263_lvds_reset(struct it6263 *it) {
> >>> +   /* AFE PLL reset */
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_3C, BIT(0), 0x0);
> >>> +   fsleep(1000);
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_3C, BIT(0), BIT(0));
> >>> +
> >>> +   /* software pixel clock domain reset */
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_05, REG_SOFT_P_RST,
> >>> +                     REG_SOFT_P_RST);
> >>> +   fsleep(1000);
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_05, REG_SOFT_P_RST, 0x0);
> >>> +   fsleep(10000);
> >>> +}
> >>> +
> >>> +static inline void it6263_lvds_set_interface(struct it6263 *it) {
> >>> +   /* color depth */
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_2C, REG_COL_DEP, BIT8);
> >>> +   /* output mapping */
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_2C, OUT_MAP, JEIDA);
> >>> +
> >>> +   if (it->lvds_dual_link) {
> >>> +           regmap_write_bits(it->lvds_regmap, LVDS_REG_2C, DMODE, DISO);
> >>> +           regmap_write_bits(it->lvds_regmap, LVDS_REG_52, BIT(1), BIT(1));
> >>> +   } else {
> >>> +           regmap_write_bits(it->lvds_regmap, LVDS_REG_2C, DMODE, SISO);
> >>> +           regmap_write_bits(it->lvds_regmap, LVDS_REG_52, BIT(1), 0);
> >>> +   }
> >>> +}
> >>> +
> >>> +static inline void it6263_lvds_set_afe(struct it6263 *it) {
> >>> +   regmap_write(it->lvds_regmap, LVDS_REG_3C, 0xaa);
> >>> +   regmap_write(it->lvds_regmap, LVDS_REG_3F, 0x02);
> >>> +   regmap_write(it->lvds_regmap, LVDS_REG_47, 0xaa);
> >>> +   regmap_write(it->lvds_regmap, LVDS_REG_48, 0x02);
> >>> +   regmap_write(it->lvds_regmap, LVDS_REG_4F, 0x11);
> >>> +
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_0B, REG_SSC_PCLK_RF,
> >>> +                     REG_SSC_PCLK_RF);
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_3C, 0x07, 0);
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_2C, REG_DESSC_ENB,
> >>> +                     REG_DESSC_ENB);
> >>> +}
> >>> +
> >>> +static inline void it6263_lvds_sys_cfg(struct it6263 *it) {
> >>> +   regmap_write_bits(it->lvds_regmap, LVDS_REG_0B, REG_LVDS_IN_SWAP,
> >>> +                     it->lvds_link12_swap ? REG_LVDS_IN_SWAP : 0); }
> >>> +
> >>> +static inline void it6263_lvds_config(struct it6263 *it) {
> >>> +   it6263_lvds_reset(it);
> >>> +   it6263_lvds_set_interface(it);
> >>> +   it6263_lvds_set_afe(it);
> >>> +   it6263_lvds_sys_cfg(it);
> >>> +}
> >>> +
> >>> +static inline void it6263_hdmi_config(struct it6263 *it) {
> >>> +   regmap_write(it->hdmi_regmap, HDMI_REG_SW_RST, HDMI_RST_ALL);
> >>> +   regmap_write(it->hdmi_regmap, HDMI_REG_INPUT_MODE, IN_RGB);
> >>> +   regmap_write_bits(it->hdmi_regmap, HDMI_REG_GCP, HDMI_COLOR_DEPTH,
> >>> +                     HDMI_COLOR_DEPTH_24);
> >>> +   regmap_write_bits(it->hdmi_regmap, HDMI_REG_AVI_DB1,
> >>> +                     AVI_DB1_COLOR_SPACE, AVI_COLOR_SPACE_RGB); }
> >>> +
> >>> +static enum drm_connector_status it6263_detect(struct it6263 *it) {
> >>> +   unsigned int val;
> >>> +
> >>> +   regmap_read(it->hdmi_regmap, HDMI_REG_SYS_STATUS, &val);
> >>> +   if (val & HPDETECT)
> >>> +           return connector_status_connected;
> >>> +   else
> >>> +           return connector_status_disconnected; }
> >>> +
> >>> +static enum drm_connector_status
> >>> +it6263_connector_detect(struct drm_connector *connector, bool force) {
> >>> +   struct it6263 *it = connector_to_it6263(connector);
> >>> +
> >>> +   return it6263_detect(it);
> >>> +}
> >>> +
> >>> +static const struct drm_connector_funcs it6263_connector_funcs = {
> >>> +   .detect = it6263_connector_detect,
> >>> +   .fill_modes = drm_helper_probe_single_connector_modes,
> >>> +   .destroy = drm_connector_cleanup,
> >>> +   .reset = drm_atomic_helper_connector_reset,
> >>> +   .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> >>> +   .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> >>> +};
> >>> +
> >>> +static int it6263_read_edid(void *data, u8 *buf, unsigned int block,
> >>> +size_t len) {
> >>> +   struct it6263 *it = data;
> >>> +   struct regmap *regmap = it->hdmi_regmap;
> >>> +   unsigned int start = (block % 2) * EDID_LENGTH;
> >>> +   unsigned int segment = block >> 1;
> >>> +   unsigned int count, val;
> >>> +   int ret;
> >>> +
> >>> +   regmap_write(regmap, HDMI_REG_DDC_MASTER_CTRL, MASTER_SEL_HOST);
> >>> +   regmap_write(regmap, HDMI_REG_DDC_HEADER, DDC_ADDR << 1);
> >>> +   regmap_write(regmap, HDMI_REG_DDC_EDIDSEG, segment);
> >>> +
> >>> +   while (len) {
> >>> +           /* clear DDC FIFO */
> >>> +           regmap_write(regmap, HDMI_REG_DDC_CMD, DDC_CMD_FIFO_CLR);
> >>> +
> >>> +           ret = regmap_read_poll_timeout(regmap, HDMI_REG_DDC_STATUS,
> >>> +                                          val, val & DDC_DONE,
> >>> +                                          2000, 10000);
> >>> +           if (ret) {
> >>> +                   dev_err(it->dev, "failed to clear DDC FIFO:%d\n", ret);
> >>> +                   return ret;
> >>> +           }
> >>> +
> >>> +           count = len > HDMI_DDC_FIFO_BYTES ? HDMI_DDC_FIFO_BYTES : len;
> >>> +
> >>> +           /* fire the read command */
> >>> +           regmap_write(regmap, HDMI_REG_DDC_REQOFF, start);
> >>> +           regmap_write(regmap, HDMI_REG_DDC_REQCOUNT, count);
> >>> +           regmap_write(regmap, HDMI_REG_DDC_CMD, DDC_CMD_EDID_READ);
> >>> +
> >>> +           start += count;
> >>> +           len -= count;
> >>> +
> >>> +           ret = regmap_read_poll_timeout(regmap, HDMI_REG_DDC_STATUS, val,
> >>> +                                          val & (DDC_DONE | DDC_ERROR),
> >>> +                                          20000, 250000);
> >>> +           if (ret && !(val & DDC_ERROR)) {
> >>> +                   dev_err(it->dev, "failed to read EDID:%d\n", ret);
> >>> +                   return ret;
> >>> +           }
> >>> +
> >>> +           if (val & DDC_ERROR) {
> >>> +                   dev_err(it->dev, "DDC error\n");
> >>> +                   return -EIO;
> >>> +           }
> >>> +
> >>> +           /* cache to buffer */
> >>> +           for (; count > 0; count--) {
> >>> +                   regmap_read(regmap, HDMI_REG_DDC_READFIFO, &val);
> >>> +                   *(buf++) = val;
> >>> +           }
> >>> +   }
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +
> >>> +static int it6263_connector_get_modes(struct drm_connector
> >>> +*connector) {
> >>> +   struct it6263 *it = connector_to_it6263(connector);
> >>> +   const struct drm_edid *drm_edid;
> >>> +   int count;
> >>> +
> >>> +   drm_edid = drm_edid_read_custom(connector, it6263_read_edid, it);
> >>> +
> >>> +   drm_edid_connector_update(connector, drm_edid);
> >>> +   count = drm_edid_connector_add_modes(connector);
> >>> +
> >>> +   drm_edid_free(drm_edid);
> >>> +
> >>> +   return count;
> >>> +}
> >>> +
> >>> +static const struct drm_connector_helper_funcs it6263_connector_helper_funcs = {
> >>> +   .get_modes = it6263_connector_get_modes, };
> >>> +
> >>> +static int it6263_bridge_atomic_check(struct drm_bridge *bridge,
> >>> +                                 struct drm_bridge_state *bridge_state,
> >>> +                                 struct drm_crtc_state *crtc_state,
> >>> +                                 struct drm_connector_state *conn_state) {
> >>> +   struct drm_display_mode *mode = &crtc_state->adjusted_mode;
> >>> +
> >>> +   return mode->clock > MAX_PIXEL_CLOCK_KHZ ? -EINVAL : 0; }
> >>> +
> >>> +static void
> >>> +it6263_bridge_atomic_disable(struct drm_bridge *bridge,
> >>> +                        struct drm_bridge_state *old_bridge_state) {
> >>> +   struct it6263 *it = bridge_to_it6263(bridge);
> >>> +
> >>> +   regmap_write_bits(it->hdmi_regmap, HDMI_REG_GCP, AVMUTE, AVMUTE);
> >>> +   regmap_write(it->hdmi_regmap, HDMI_REG_PKT_GENERAL_CTRL, 0);
> >>> +   regmap_write(it->hdmi_regmap, HDMI_REG_AFE_DRV_CTRL,
> >>> +                AFE_DRV_RST | AFE_DRV_PWD);
> >>> +}
> >>> +
> >>> +static void
> >>> +it6263_bridge_atomic_enable(struct drm_bridge *bridge,
> >>> +                       struct drm_bridge_state *old_bridge_state) {
> >>> +   struct drm_atomic_state *state = old_bridge_state->base.state;
> >>> +   struct it6263 *it = bridge_to_it6263(bridge);
> >>> +   const struct drm_crtc_state *crtc_state;
> >>> +   struct regmap *regmap = it->hdmi_regmap;
> >>> +   const struct drm_display_mode *mode;
> >>> +   struct drm_connector *connector;
> >>> +   bool is_stable = false;
> >>> +   struct drm_crtc *crtc;
> >>> +   unsigned int val;
> >>> +   bool pclk_high;
> >>> +   int i, ret;
> >>> +
> >>> +   connector = drm_atomic_get_new_connector_for_encoder(state,
> >>> +                                                        bridge->encoder);
> >>> +   crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
> >>> +   crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> >>> +   mode = &crtc_state->adjusted_mode;
> >>> +
> >>> +   regmap_write(regmap, HDMI_REG_HDMI_MODE, TX_HDMI_MODE);
> >>> +
> >>> +   /* HDMI AFE setup */
> >>> +   pclk_high = mode->clock > HIGH_PIXEL_CLOCK_KHZ ? true : false;
> >>> +   regmap_write(regmap, HDMI_REG_AFE_DRV_CTRL, AFE_DRV_RST);
> >>> +   if (pclk_high)
> >>> +           regmap_write(regmap, HDMI_REG_AFE_XP_CTRL,
> >>> +                        AFE_XP_GAINBIT | AFE_XP_RESETB);
> >>> +   else
> >>> +           regmap_write(regmap, HDMI_REG_AFE_XP_CTRL,
> >>> +                        AFE_XP_ER0 | AFE_XP_RESETB);
> >>> +   regmap_write(regmap, HDMI_REG_AFE_ISW_CTRL, 0x10);
> >>> +   if (pclk_high)
> >>> +           regmap_write(regmap, HDMI_REG_AFE_IP_CTRL,
> >>> +                        AFE_IP_GAINBIT | AFE_IP_RESETB);
> >>> +   else
> >>> +           regmap_write(regmap, HDMI_REG_AFE_IP_CTRL,
> >>> +                        AFE_IP_ER0 | AFE_IP_RESETB);
> >>> +
> >>> +   /* HDMI software video reset */
> >>> +   regmap_write_bits(regmap, HDMI_REG_SW_RST, SOFTV_RST, SOFTV_RST);
> >>> +   fsleep(1000);
> >>> +   regmap_write_bits(regmap, HDMI_REG_SW_RST, SOFTV_RST, 0);
> >>> +
> >>> +   /* reconfigure LVDS and retry several times in case video is instable */
> >>> +   for (i = 0; i < 3; i++) {
> >>> +           ret = regmap_read_poll_timeout(regmap, HDMI_REG_SYS_STATUS, val,
> >>> +                                          val & TXVIDSTABLE,
> >>> +                                          20000, 500000);
> >>> +           if (!ret) {
> >>> +                   is_stable = true;
> >>> +                   break;
> >>> +           }
> >>> +
> >>> +           it6263_lvds_config(it);
> >>> +   }
> >>> +
> >>> +   if (!is_stable)
> >>> +           dev_warn(it->dev, "failed to wait for video stable\n");
> >>> +
> >>> +   /* HDMI AFE reset release and power up */
> >>> +   regmap_write(regmap, HDMI_REG_AFE_DRV_CTRL, 0);
> >>> +
> >>> +   regmap_write_bits(regmap, HDMI_REG_GCP, AVMUTE, 0);
> >>> +
> >>> +   regmap_write(regmap, HDMI_REG_PKT_GENERAL_CTRL, ENABLE_PKT |
> >>> +REPEAT_PKT); }
> >>> +
> >>> +static enum drm_mode_status
> >>> +it6263_bridge_mode_valid(struct drm_bridge *bridge,
> >>> +                    const struct drm_display_info *info,
> >>> +                    const struct drm_display_mode *mode) {
> >>> +   return mode->clock > MAX_PIXEL_CLOCK_KHZ ? MODE_CLOCK_HIGH :
> >>> +MODE_OK; }
> >>> +
> >>> +static int it6263_bridge_attach(struct drm_bridge *bridge,
> >>> +                           enum drm_bridge_attach_flags flags) {
> >>> +   struct it6263 *it = bridge_to_it6263(bridge);
> >>> +   int ret;
> >>> +
> >>> +   ret = drm_bridge_attach(bridge->encoder, it->next_bridge, bridge,
> >>> +                           flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> >>> +   if (ret < 0)
> >>> +           return ret;
> >>> +
> >>> +   if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
> >>> +           return 0;
> >>> +
> >>> +   it->connector.polled = DRM_CONNECTOR_POLL_CONNECT |
> >>> +                          DRM_CONNECTOR_POLL_DISCONNECT;
> >>> +
> >>> +   ret = drm_connector_init(bridge->dev, &it->connector,
> >>> +                            &it6263_connector_funcs,
> >>> +                            DRM_MODE_CONNECTOR_HDMIA);
> >>> +   if (ret)
> >>> +           return ret;
> >>> +
> >>> +   drm_connector_helper_add(&it->connector,
> >>> +                            &it6263_connector_helper_funcs);
> >>> +   drm_connector_attach_encoder(&it->connector, bridge->encoder);
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +
> >>> +static enum drm_connector_status it6263_bridge_detect(struct
> >>> +drm_bridge
> >>> +*bridge) {
> >>> +   struct it6263 *it = bridge_to_it6263(bridge);
> >>> +
> >>> +   return it6263_detect(it);
> >>> +}
> >>> +
> >>> +static const struct drm_edid *
> >>> +it6263_bridge_edid_read(struct drm_bridge *bridge,
> >>> +                   struct drm_connector *connector)
> >>> +{
> >>> +   struct it6263 *it = bridge_to_it6263(bridge);
> >>> +
> >>> +   return drm_edid_read_custom(connector, it6263_read_edid, it); }
> >>> +
> >>> +static u32 *
> >>> +it6263_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
> >>> +                                   struct drm_bridge_state *bridge_state,
> >>> +                                   struct drm_crtc_state *crtc_state,
> >>> +                                   struct drm_connector_state *conn_state,
> >>> +                                   u32 output_fmt,
> >>> +                                   unsigned int *num_input_fmts)
> >>> +{
> >>> +   u32 *input_fmts;
> >>> +
> >>> +   input_fmts = kmalloc(sizeof(*input_fmts), GFP_KERNEL);
> >>> +   if (!input_fmts) {
> >>> +           *num_input_fmts = 0;
> >>> +           return NULL;
> >>> +   }
> >>> +
> >>> +   input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
> >>
> >> Why is it hardcoded? What about supporting VESA??
> >>
> >>> +   *num_input_fmts = 1;
> >>> +
> >>> +   return input_fmts;
> >>> +}
> >>> +
> >>> +static const struct drm_bridge_funcs it6263_bridge_funcs = {
> >>> +   .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> >>> +   .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> >>> +   .atomic_reset = drm_atomic_helper_bridge_reset,
> >>> +   .attach = it6263_bridge_attach,
> >>> +   .mode_valid = it6263_bridge_mode_valid,
> >>> +   .atomic_disable = it6263_bridge_atomic_disable,
> >>> +   .atomic_enable = it6263_bridge_atomic_enable,
> >>> +   .atomic_check = it6263_bridge_atomic_check,
> >>> +   .detect = it6263_bridge_detect,
> >>> +   .edid_read = it6263_bridge_edid_read,
> >>> +   .atomic_get_input_bus_fmts =
> >>> +it6263_bridge_atomic_get_input_bus_fmts,
> >>> +};
> >
> > Like [1]
> > static const struct drm_bridge_funcs it6263_bridge_funcs = {
> >       .attach = it6263_bridge_attach,
> >       .mode_set = it6263_bridge_mode_set,
> >       .disable = it6263_bridge_disable,
> >       .enable = it6263_bridge_enable,
> >       .get_edid = it6263_bridge_get_edid,
> >       .detect = it6263_bridge_detect,
> > };
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c?h=v6.12-rc1#n998
> >
> > Is it not sufficient for your use case??
>
> If we decide to document the LVDS data mapping in dt-binding,
> then it is practically ok to use the non-atomic callbacks like
> the adv7511 driver, otherwise, the atomic callbacks are required
> due to the bus format negotiation.

Please use atomic callbacks, it's better even if it means more code.

>
> >
> > Cheers,
> > Biju
> >
> >>> +
> >>> +static int it6263_probe(struct i2c_client *client) {
> >>> +   struct device *dev = &client->dev;
> >>> +   struct it6263 *it;
> >>> +   int ret;
> >>> +
> >>> +   it = devm_kzalloc(dev, sizeof(*it), GFP_KERNEL);
> >>> +   if (!it)
> >>> +           return -ENOMEM;
> >>> +
> >>> +   it->dev = dev;
> >>> +   it->hdmi_i2c = client;
> >>> +
> >>> +   it->hdmi_regmap = devm_regmap_init_i2c(client,
> >>> +                                          &it6263_hdmi_regmap_config);
> >>> +   if (IS_ERR(it->hdmi_regmap))
> >>> +           return dev_err_probe(dev, PTR_ERR(it->hdmi_regmap),
> >>> +                                "failed to init I2C regmap for HDMI\n");
> >>> +
> >>> +   it->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> >>> +   if (IS_ERR(it->reset_gpio))
> >>> +           return dev_err_probe(dev, PTR_ERR(it->reset_gpio),
> >>> +                                "failed to get reset gpio\n");
> >>> +
> >>> +   ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it6263_supplies),
> >>> +                                        it6263_supplies);
> >>> +   if (ret)
> >>> +           return dev_err_probe(dev, ret, "failed to get power supplies\n");
> >>> +
> >>> +   ret = it6263_parse_dt(it);
> >>> +   if (ret)
> >>> +           return ret;
> >>> +
> >>> +   it6263_reset(it);
> >>> +
> >>> +   ret = it6263_lvds_set_i2c_addr(it);
> >>> +   if (ret)
> >>> +           return dev_err_probe(dev, ret, "failed to set I2C addr\n");
> >>> +
> >>> +   it->lvds_i2c = devm_i2c_new_dummy_device(dev, client->adapter,
> >>> +                                            LVDS_INPUT_CTRL_I2C_ADDR);
> >>> +   if (IS_ERR(it->lvds_i2c))
> >>> +           dev_err_probe(it->dev, PTR_ERR(it->lvds_i2c),
> >>> +                         "failed to allocate I2C device for LVDS\n");
> >>
> >> Maybe use action_or_reset and call i2c_unregister_device();
> >>
> >>> +
> >>> +   it->lvds_regmap = devm_regmap_init_i2c(it->lvds_i2c,
> >>> +                                          &it6263_lvds_regmap_config);
> >>> +   if (IS_ERR(it->lvds_regmap))
> >>> +           return dev_err_probe(dev, PTR_ERR(it->lvds_regmap),
> >>> +                                "failed to init I2C regmap for LVDS\n");
> >>
> >>> +
> >>> +   it6263_lvds_config(it);
> >>> +   it6263_hdmi_config(it);
> >>
> >>> +
> >>> +   i2c_set_clientdata(client, it);
> >>> +
> >>> +   it->bridge.funcs = &it6263_bridge_funcs;
> >>> +   it->bridge.of_node = dev->of_node;
> >>> +   it->bridge.ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
> >>
> >>      it->bridge.type = DRM_MODE_CONNECTOR_HDMIA; ??
> >>
> >>> +   drm_bridge_add(&it->bridge);
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +
> >>> +static void it6263_remove(struct i2c_client *client) {
> >>> +   struct it6263 *it = i2c_get_clientdata(client);
> >>> +
> >>> +   drm_bridge_remove(&it->bridge);
> >>
> >>> +}
> >>> +
> >>> +static const struct of_device_id it6263_of_match[] = {
> >>> +   { .compatible = "ite,it6263", },
> >>> +   { }
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, it6263_of_match);
> >>> +
> >>> +static const struct i2c_device_id it6263_i2c_ids[] = {
> >>> +   { "it6263", 0 },
> >>> +   { }
> >>> +};
> >>> +MODULE_DEVICE_TABLE(i2c, it6263_i2c_ids);
> >>> +
> >>> +static struct i2c_driver it6263_driver = {
> >>> +   .probe = it6263_probe,
> >>> +   .remove = it6263_remove,
> >>> +   .driver = {
> >>> +           .name = "it6263",
> >>> +           .of_match_table = it6263_of_match,
> >>> +   },
> >>> +   .id_table = it6263_i2c_ids,
> >>> +};
> >>> +module_i2c_driver(it6263_driver);
> >>> +
> >>> +MODULE_DESCRIPTION("ITE Tech. Inc. IT6263 LVDS/HDMI bridge");
> >>> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
> >>> +MODULE_LICENSE("GPL");
> >>> --
> >>> 2.34.1
> >>>
> >
>
> --
> Regards,
> Liu Ying
>


-- 
With best wishes
Dmitry

