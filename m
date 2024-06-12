Return-Path: <linux-kernel+bounces-211422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 327D390516F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CD1286B65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BFB16EBFB;
	Wed, 12 Jun 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvyOi2En"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA44915624C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718192145; cv=none; b=PTaZmQEulzkakXgBNbs/McjlNqjN9wJV3xmOvVNgq2AjWC0CsW37WYVspYcobTB4ovn0kNs64p6/mHydh5Cc1X0kzaIj3kHw52pu0kyVu8x9vEJcPWf9TiL3JPMDXq+K8UFBmVCOTMYHxt7zE+CvGZ6dageOAqDh9r9EoTb+5Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718192145; c=relaxed/simple;
	bh=NtYmsudCnauKzxu24L7twM2u69VqGSLsT+ZyYg5yd/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TN3HIjCQWXOdz91QblcwE/G6IVDojOpl1wNz7jI/zGkERTQCEKImJjeiqKGi4zk7U5g0VaUc5KWb8mex5wYOqdKLuRR4+0umm2dzU/+IAJO1zUeNjp8uvDdnOlsoyV4NS4BNhn/DaDhaPBBWGEzrtj8gE5wTGh1oTQ0M6dkFa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvyOi2En; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1283121a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718192141; x=1718796941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD3TcpOevdw4jGOGlfKKrgKgvEbgvcfQmdjNQhdMv58=;
        b=EvyOi2EnxqoeoGjHxRwzIq/0tlRor7IoBUyLvSwoR2M1d+p0SgKy/ucSnx/e70ml9P
         ig3j1zNLfvw4wjCiV/BsFy9Rna9UYr7/n5DhUcdfXtqBnC+9OVszKo7rCATMEYLlRnYz
         u12tuk0EskaTZ6TsOpyB+QSLHw0g/pYwEWFo4WFVta6WbNBHlslHc+RYIrvZI9iZlAKb
         42DIK1AUSecfvIb7Gqe4JVHemC4BYr5s7OMgi2rOeM09y9wJRMImp3pe0z1F0pC4wWoa
         5uTGrrUOvw4ugcj9iGBudUBnuRb92pWDvtAD9kLED+P4BRajPxufFMG1C97qq5GztTLX
         Zxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718192141; x=1718796941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD3TcpOevdw4jGOGlfKKrgKgvEbgvcfQmdjNQhdMv58=;
        b=ZmEBY9B6YH3OcssHLY3TQUqIXB6C3mhpBESic8RE0htAg69RoPBvymVeYTUO++aNTT
         n2+0Qay9t4HJ4+7sDDjOeaONa3rp8tLRAm8GTLXI6PHyG2gdiE35V4b437MC3SwtWHrN
         Q9cmj+l8VZOlZxsPUsbXTmGyrNH/WFHvGsrDz7f2kL1N6E7eflJh0xvankOB+IueA/7b
         aBBH5hr9n9O82h8sPmIwTshfT4pLeJ89qlqFRwaIXTltk+5apNtMDj7aEm6kitZhBzr3
         FeGtQPnhY6xMKuoxBcUc+OCkpuZ5nImBqyN3uBc1167TbdyWqabghalXJz7QtpSko9fm
         P02Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOgljcXoS3ur9F4GFHsgjE6RKDE82yG2poWowJTj9Wi1qDmazwLRJOOzSirzGOfGrOmI/HQ1ADly6pMOvmk2zzx6hpgPUfITPoGYLc
X-Gm-Message-State: AOJu0Ywjfv4RYIBezoflcnzBYVPHpFXrCXK7uQ/q/wIwLT6SNqV5W3pR
	49mzr1vQ444bryVvjtbWEDr2aLmnqRR2E/UqP231Rb6xQfzdhfn8NED+328lPxytlLPPlUgrcL/
	enyJp3kCeydQekncPQVoqih9FNJlaXvy6tsvlow==
X-Google-Smtp-Source: AGHT+IHF0IhhCx2xeDwJ/ZdFZF7I8cP0VovnP7pPzlFrR2emvRtt/3VInRcbWk/KX7Jd6RxnxZ2cpoPGp+PBoXwasT8=
X-Received: by 2002:a50:f68b:0:b0:57c:603a:6b2b with SMTP id
 4fb4d7f45d1cf-57ca8d31923mr1122667a12.21.1718192135287; Wed, 12 Jun 2024
 04:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240601084528.22502-3-lvzhaoxiong@huaqin.corp-partner.google.com>
 <94c80cae-4992-4cd2-9b06-93505a5ca799@gmail.com> <CA+6=WdTz0MJX7j-hwbT1u4XG=F8fvHDRy42USfcarMHR9+ye4Q@mail.gmail.com>
 <iqeloy365b4rrip4axgmgj5ogho4ueoxidsteqdyompkchzcyi@avzq3v3iunat> <c1229ff8-dfaa-4100-bc79-a2ac1415c606@gmail.com>
In-Reply-To: <c1229ff8-dfaa-4100-bc79-a2ac1415c606@gmail.com>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Wed, 12 Jun 2024 19:35:21 +0800
Message-ID: <CA+6=WdSbQVWyLW7oLqZ1D-o=qYOK0pUN5w_7s2H8yYygtYtmxg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] drm/panel: kd101ne3: add new panel driver
To: Alex Bee <knaerzche@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:41=E2=80=AFPM Alex Bee <knaerzche@gmail.com> wrote=
:
>
>
> Am 07.06.24 um 14:01 schrieb Dmitry Baryshkov:
> > On Fri, Jun 07, 2024 at 07:44:33PM +0800, zhaoxiong lv wrote:
> >> hi Alex Bee
> >>
> >> I compared these two drivers. Although the control IC is the same, the
> >> panel is different, and the init_cmd and timing are also slightly
> >> different, so I added a separate driver.
> > But it obviously uses the same structure as the panel-jadard. Please
> > use existing driver instead of creating a completely new one (which you
> > happily overload with an unrelated panel).
> >
> +1
>
> panel-jadard already supports different panels with different
> init-sequences and they can be set per panel-type (compatible). If you ne=
ed
> different reset-/enable timings (what I doubt) you'll have to extend stru=
ct
> jadard_panel_desc. In any case you'll have to put dsi->mode_flags in ther=
e
> as your panel uses MIPI_DSI_MODE_LPM what the currently supported don't
> need.

 hi Alex Bee/Dmitry Baryshkov

We found that when using the panel-kingdisplay-kd101ne3 driver to send
init code, it takes about 3.5s to complete the sending, but using the
new API (mipi_dsi_dcs_write_seq_multi) will not have this phenomenon,
which seems to affect the user experience.
I would like to ask how I can deal with this?

thanks

>
> Alex.
>
> >> thanks
> >>
> >> On Sun, Jun 2, 2024 at 1:07=E2=80=AFPM Alex Bee <knaerzche@gmail.com> =
wrote:
> >>> Am 01.06.24 um 10:45 schrieb Zhaoxiong Lv:
> >>>
> >>> Hi Zhaoxiong,
> >>>
> >>>> The bias IC of this kindisplay-kd101ne3 panel is placed
> >>>> on the panel side, so when the panel is powered on,
> >>>> there is no need to control AVDD and AVEE in the driver,
> >>>> only 3.3v and reset are needed.
> >>>>
> >>>> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.=
com>
> >>>> ---
> >>>>
> >>>> Chage since V2:
> >>>>
> >>>> -  1. Use the new mipi_dsi_dcs_write_seq_multi() function.
> >>>> -  2. Modify Move mipi_dsi_dcs_set_display_off() and mipi_dsi_dcs_en=
ter_sleep_mode() to disable(),
> >>>> -  and drop kingdisplay_panel_enter_sleep_mode().
> >>>> -  3. If prepare fails, disable GPIO before regulators.
> >>>> -  4. This function drm_connector_set_panel_orientation() is no long=
er used. Delete it.
> >>>> -  5. Drop ".shutdown =3D kingdisplay_panel_shutdown".
> >>>>
> >>>> ---
> >>>>    drivers/gpu/drm/panel/Kconfig                 |   9 +
> >>>>    drivers/gpu/drm/panel/Makefile                |   1 +
> >>>>    .../drm/panel/panel-kingdisplay-kd101ne3.c    | 533 +++++++++++++=
+++++
> >>>>    3 files changed, 543 insertions(+)
> >>>>    create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd101n=
e3.c
> >>>>
> >>>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/K=
config
> >>>> index e54f6f5604ed..71669e990e8e 100644
> >>>> --- a/drivers/gpu/drm/panel/Kconfig
> >>>> +++ b/drivers/gpu/drm/panel/Kconfig
> >>>> @@ -297,6 +297,15 @@ config DRM_PANEL_KINGDISPLAY_KD097D04
> >>>>          24 bit RGB per pixel. It provides a MIPI DSI interface to
> >>>>          the host and has a built-in LED backlight.
> >>>>
> >>>> +config DRM_PANEL_KINGDISPLAY_KD101NE3
> >>>> +     tristate "Kingdisplay kd101ne3 panel"
> >>>> +     depends on OF
> >>>> +     depends on DRM_MIPI_DSI
> >>>> +     depends on BACKLIGHT_CLASS_DEVICE
> >>>> +     help
> >>>> +       Say Y here if you want to enable support for the kingdisplay=
 kd101ne3
> >>>> +       4-lane 800x1280 MIPI DSI panel.
> >>>> +
> >>>>    config DRM_PANEL_LEADTEK_LTK050H3146W
> >>>>        tristate "Leadtek LTK050H3146W panel"
> >>>>        depends on OF
> >>>> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/=
Makefile
> >>>> index f0203f6e02f4..4576c9fe33d9 100644
> >>>> --- a/drivers/gpu/drm/panel/Makefile
> >>>> +++ b/drivers/gpu/drm/panel/Makefile
> >>>> @@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) +=3D panel=
-jdi-lpm102a188a.o
> >>>>    obj-$(CONFIG_DRM_PANEL_JDI_R63452) +=3D panel-jdi-fhd-r63452.o
> >>>>    obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) +=3D panel-khadas-ts050.o
> >>>>    obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) +=3D panel-kingdispl=
ay-kd097d04.o
> >>>> +obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD101NE3) +=3D panel-kingdisplay=
-kd101ne3.o
> >>>>    obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) +=3D panel-leadtek-l=
tk050h3146w.o
> >>>>    obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) +=3D panel-leadtek-l=
tk500hd1829.o
> >>>>    obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) +=3D panel-lg-lb035q02.o
> >>>> diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c b/dr=
ivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> >>>> new file mode 100644
> >>>> index 000000000000..8994a1c9afb5
> >>>> --- /dev/null
> >>>> +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> >>>> @@ -0,0 +1,533 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/* Panels based on the JD9365DA display controller.
> >>>> + * Author: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com=
>
> >>>> + */
> >>>> +
> >>>> +#include <linux/delay.h>
> >>>> +#include <linux/gpio/consumer.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/of.h>
> >>>> +#include <linux/regulator/consumer.h>
> >>>> +
> >>>> +#include <drm/drm_connector.h>
> >>>> +#include <drm/drm_crtc.h>
> >>>> +#include <drm/drm_mipi_dsi.h>
> >>>> +#include <drm/drm_panel.h>
> >>>> +
> >>>> +#include <video/mipi_display.h>
> >>>> +
> >>>> +struct kingdisplay_panel;
> >>>> +
> >>>> +struct panel_desc {
> >>>> +     const struct drm_display_mode *modes;
> >>>> +     unsigned int bpc;
> >>>> +
> >>>> +     /**
> >>>> +      * @width_mm: width of the panel's active display area
> >>>> +      * @height_mm: height of the panel's active display area
> >>>> +      */
> >>>> +     struct {
> >>>> +             unsigned int width_mm;
> >>>> +             unsigned int height_mm;
> >>>> +     } size;
> >>>> +
> >>>> +     unsigned long mode_flags;
> >>>> +     enum mipi_dsi_pixel_format format;
> >>>> +     const struct panel_init_cmd *init_cmds;
> >>>> +     int (*init)(struct kingdisplay_panel *kingdisplay);
> >>>> +     unsigned int lanes;
> >>>> +     bool discharge_on_disable;
> >>>> +     bool lp11_before_reset;
> >>>> +};
> >>>> +
> >>>> +struct kingdisplay_panel {
> >>>> +     struct drm_panel base;
> >>>> +     struct mipi_dsi_device *dsi;
> >>>> +
> >>>> +     const struct panel_desc *desc;
> >>>> +
> >>>> +     enum drm_panel_orientation orientation;
> >>>> +     struct regulator *pp3300;
> >>>> +     struct gpio_desc *enable_gpio;
> >>>> +};
> >>>> +
> >>>> +static int kingdisplay_kd101ne3_init(struct kingdisplay_panel *king=
display)
> >>>> +{
> >>>> +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D kingdispl=
ay->dsi };
> >>>> +
> >>>> +     /* T5:HWreset to init_code >=3D 50ms */
> >>>> +     msleep(50);
> >>>> +
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0x93);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe2, 0x65);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe3, 0xf8);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x03);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x01);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x74);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xc7);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xc7);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x01);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x28);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x12);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x7e);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x7f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x06);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1e);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0b);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x6a);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x2e);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x15);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x61);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x50);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x43);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x3f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x32);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x35);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x38);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x36);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x36);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x54);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x42);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x48);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x39);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x34);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x26);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x14);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x02);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x61);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x50);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x43);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x3f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x32);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x35);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x38);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x36);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x36);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x54);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x42);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x48);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x39);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x34);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x26);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x14);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x02);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x02);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x52);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x50);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x77);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x57);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x4e);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x4c);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x4a);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x48);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x46);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x44);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x40);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x53);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x51);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x77);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x57);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x4f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x4d);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x4b);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x49);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x47);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x45);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x41);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x13);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x01);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x17);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x17);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x0d);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x0f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x05);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x07);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x09);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x0b);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x11);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x12);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x17);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x17);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x0c);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x0e);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x04);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x06);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x08);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x0a);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x10);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x06);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x40);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x03);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x04);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x6c);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x6c);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x75);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x08);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0xb4);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x08);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x6c);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x6c);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x0c);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xbb);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x05);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x04);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x61);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0x00);
> >>> Looking at the init sequence, I'm pretty confident this panel uses a
> >>> Jadard JD 9365 driver IC. It's probably worth adding it to
> >>> panel-jadard-jd9365da instead of adding a completly new driver.
> >>>
> >>> Alex
> >>>> +     if (dsi_ctx.accum_err)
> >>>> +             return dsi_ctx.accum_err;
> >>>> +
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_EXIT_SLEEP_MOD=
E);
> >>>> +     if (dsi_ctx.accum_err)
> >>>> +             return dsi_ctx.accum_err;
> >>>> +
> >>>> +     msleep(120);
> >>>> +
> >>>> +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_DISPLAY_ON=
);
> >>>> +     if (dsi_ctx.accum_err)
> >>>> +             return dsi_ctx.accum_err;
> >>>> +
> >>>> +     msleep(20);
> >>>> +
> >>>> +     return 0;
> >>>> +};
> >>>> +
> >>>> +static inline struct kingdisplay_panel *to_kingdisplay_panel(struct=
 drm_panel *panel)
> >>>> +{
> >>>> +     return container_of(panel, struct kingdisplay_panel, base);
> >>>> +}
> >>>> +
> >>>> +static int kingdisplay_panel_disable(struct drm_panel *panel)
> >>>> +{
> >>>> +     struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel=
(panel);
> >>>> +     int err;
> >>>> +
> >>>> +     kingdisplay->dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
> >>>> +
> >>>> +     msleep(100);
> >>>> +
> >>>> +     err =3D mipi_dsi_dcs_set_display_off(kingdisplay->dsi);
> >>>> +     if (err < 0)
> >>>> +             dev_err(panel->dev, "failed to set display off: %d\n",=
 err);
> >>>> +
> >>>> +     msleep(50);
> >>>> +
> >>>> +     err =3D mipi_dsi_dcs_enter_sleep_mode(kingdisplay->dsi);
> >>>> +     if (err < 0) {
> >>>> +             dev_err(panel->dev, "failed to enter sleep mode: %d\n"=
, err);
> >>>> +             return err;
> >>>> +     }
> >>>> +
> >>>> +     msleep(120);
> >>>> +
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>> +static int kingdisplay_panel_unprepare(struct drm_panel *panel)
> >>>> +{
> >>>> +     struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel=
(panel);
> >>>> +     int err;
> >>>> +
> >>>> +     gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
> >>>> +
> >>>> +     /* T15: 2ms */
> >>>> +     usleep_range(1000, 2000);
> >>>> +
> >>>> +     err =3D regulator_disable(kingdisplay->pp3300);
> >>>> +     if (err < 0)
> >>>> +             return err;
> >>>> +
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>> +static int kingdisplay_panel_prepare(struct drm_panel *panel)
> >>>> +{
> >>>> +     struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel=
(panel);
> >>>> +     int err;
> >>>> +
> >>>> +     gpiod_set_value(kingdisplay->enable_gpio, 0);
> >>>> +
> >>>> +     err =3D regulator_enable(kingdisplay->pp3300);
> >>>> +     if (err < 0)
> >>>> +             return err;
> >>>> +
> >>>> +     /* T1:Vdd to mipi_lp >=3D 0ms */
> >>>> +     usleep_range(5000, 6000);
> >>>> +
> >>>> +     if (kingdisplay->desc->lp11_before_reset) {
> >>>> +             err =3D mipi_dsi_dcs_nop(kingdisplay->dsi);
> >>>> +             if (err < 0)
> >>>> +                     goto poweroff;
> >>>> +
> >>>> +             usleep_range(1000, 2000);
> >>>> +     }
> >>>> +
> >>>> +     /* T2: 10ms, T1 + T2 > 60ms */
> >>>> +     msleep(60);
> >>>> +
> >>>> +     gpiod_set_value_cansleep(kingdisplay->enable_gpio, 1);
> >>>> +
> >>>> +     err =3D kingdisplay->desc->init(kingdisplay);
> >>>> +     if (err < 0)
> >>>> +             goto poweroff;
> >>>> +
> >>>> +     return 0;
> >>>> +
> >>>> +poweroff:
> >>>> +     gpiod_set_value(kingdisplay->enable_gpio, 0);
> >>>> +             /* T6: 2ms */
> >>>> +     usleep_range(1000, 2000);
> >>>> +     regulator_disable(kingdisplay->pp3300);
> >>>> +
> >>>> +     return err;
> >>>> +}
> >>>> +
> >>>> +static int kingdisplay_panel_enable(struct drm_panel *panel)
> >>>> +{
> >>>> +     msleep(130);
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>> +static const struct drm_display_mode kingdisplay_kd101ne3_40ti_defa=
ult_mode =3D {
> >>>> +     .clock =3D 70595,
> >>>> +     .hdisplay =3D 800,
> >>>> +     .hsync_start =3D 800 + 30,
> >>>> +     .hsync_end =3D 800 + 30 + 30,
> >>>> +     .htotal =3D 800 + 30 + 30 + 30,
> >>>> +     .vdisplay =3D 1280,
> >>>> +     .vsync_start =3D 1280 + 30,
> >>>> +     .vsync_end =3D 1280 + 30 + 4,
> >>>> +     .vtotal =3D 1280 + 30 + 4 + 8,
> >>>> +     .type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
> >>>> +};
> >>>> +
> >>>> +static const struct panel_desc kingdisplay_kd101ne3_40ti_desc =3D {
> >>>> +     .modes =3D &kingdisplay_kd101ne3_40ti_default_mode,
> >>>> +     .bpc =3D 8,
> >>>> +     .size =3D {
> >>>> +             .width_mm =3D 135,
> >>>> +             .height_mm =3D 216,
> >>>> +     },
> >>>> +     .lanes =3D 4,
> >>>> +     .format =3D MIPI_DSI_FMT_RGB888,
> >>>> +     .mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC=
_PULSE |
> >>>> +                   MIPI_DSI_MODE_LPM,
> >>>> +     .init =3D kingdisplay_kd101ne3_init,
> >>>> +     .lp11_before_reset =3D true,
> >>>> +};
> >>>> +
> >>>> +static int kingdisplay_panel_get_modes(struct drm_panel *panel,
> >>>> +                            struct drm_connector *connector)
> >>>> +{
> >>>> +     struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel=
(panel);
> >>>> +     const struct drm_display_mode *m =3D kingdisplay->desc->modes;
> >>>> +     struct drm_display_mode *mode;
> >>>> +
> >>>> +     mode =3D drm_mode_duplicate(connector->dev, m);
> >>>> +     if (!mode) {
> >>>> +             dev_err(panel->dev, "failed to add mode %ux%u@%u\n",
> >>>> +                     m->hdisplay, m->vdisplay, drm_mode_vrefresh(m)=
);
> >>>> +             return -ENOMEM;
> >>>> +     }
> >>>> +
> >>>> +     mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
> >>>> +     drm_mode_set_name(mode);
> >>>> +     drm_mode_probed_add(connector, mode);
> >>>> +
> >>>> +     connector->display_info.width_mm =3D kingdisplay->desc->size.w=
idth_mm;
> >>>> +     connector->display_info.height_mm =3D kingdisplay->desc->size.=
height_mm;
> >>>> +     connector->display_info.bpc =3D kingdisplay->desc->bpc;
> >>>> +
> >>>> +     return 1;
> >>>> +}
> >>>> +
> >>>> +static enum drm_panel_orientation kingdisplay_panel_get_orientation=
(struct drm_panel *panel)
> >>>> +{
> >>>> +     struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel=
(panel);
> >>>> +
> >>>> +     return kingdisplay->orientation;
> >>>> +}
> >>>> +
> >>>> +static const struct drm_panel_funcs kingdisplay_panel_funcs =3D {
> >>>> +     .disable =3D kingdisplay_panel_disable,
> >>>> +     .unprepare =3D kingdisplay_panel_unprepare,
> >>>> +     .prepare =3D kingdisplay_panel_prepare,
> >>>> +     .enable =3D kingdisplay_panel_enable,
> >>>> +     .get_modes =3D kingdisplay_panel_get_modes,
> >>>> +     .get_orientation =3D kingdisplay_panel_get_orientation,
> >>>> +};
> >>>> +
> >>>> +static int kingdisplay_panel_add(struct kingdisplay_panel *kingdisp=
lay)
> >>>> +{
> >>>> +     struct device *dev =3D &kingdisplay->dsi->dev;
> >>>> +     int err;
> >>>> +
> >>>> +     kingdisplay->pp3300 =3D devm_regulator_get(dev, "pp3300");
> >>>> +     if (IS_ERR(kingdisplay->pp3300))
> >>>> +             return dev_err_probe(dev, PTR_ERR(kingdisplay->pp3300)=
,
> >>>> +                                  "Cannot get pp3300\n");
> >>>> +
> >>>> +     kingdisplay->enable_gpio =3D devm_gpiod_get(dev, "enable", GPI=
OD_OUT_LOW);
> >>>> +     if (IS_ERR(kingdisplay->enable_gpio))
> >>>> +             return dev_err_probe(dev, PTR_ERR(kingdisplay->enable_=
gpio),
> >>>> +                                  "Cannot get enable GPIO\n");
> >>>> +
> >>>> +     drm_panel_init(&kingdisplay->base, dev, &kingdisplay_panel_fun=
cs,
> >>>> +                    DRM_MODE_CONNECTOR_DSI);
> >>>> +
> >>>> +     err =3D of_drm_get_panel_orientation(dev->of_node, &kingdispla=
y->orientation);
> >>>> +     if (err < 0) {
> >>>> +             dev_err(dev, "%pOF: failed to get orientation %d\n", d=
ev->of_node, err);
> >>>> +             return err;
> >>>> +     }
> >>>> +
> >>>> +     err =3D drm_panel_of_backlight(&kingdisplay->base);
> >>>> +     if (err)
> >>>> +             return err;
> >>>> +
> >>>> +     kingdisplay->base.funcs =3D &kingdisplay_panel_funcs;
> >>>> +     kingdisplay->base.dev =3D &kingdisplay->dsi->dev;
> >>>> +
> >>>> +     drm_panel_add(&kingdisplay->base);
> >>>> +
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>> +static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
> >>>> +{
> >>>> +     struct kingdisplay_panel *kingdisplay;
> >>>> +     int ret;
> >>>> +     const struct panel_desc *desc;
> >>>> +
> >>>> +     kingdisplay =3D devm_kzalloc(&dsi->dev, sizeof(*kingdisplay), =
GFP_KERNEL);
> >>>> +     if (!kingdisplay)
> >>>> +             return -ENOMEM;
> >>>> +
> >>>> +     desc =3D of_device_get_match_data(&dsi->dev);
> >>>> +     dsi->lanes =3D desc->lanes;
> >>>> +     dsi->format =3D desc->format;
> >>>> +     dsi->mode_flags =3D desc->mode_flags;
> >>>> +     kingdisplay->desc =3D desc;
> >>>> +     kingdisplay->dsi =3D dsi;
> >>>> +     ret =3D kingdisplay_panel_add(kingdisplay);
> >>>> +     if (ret < 0)
> >>>> +             return ret;
> >>>> +
> >>>> +     mipi_dsi_set_drvdata(dsi, kingdisplay);
> >>>> +
> >>>> +     ret =3D mipi_dsi_attach(dsi);
> >>>> +     if (ret)
> >>>> +             drm_panel_remove(&kingdisplay->base);
> >>>> +
> >>>> +     return ret;
> >>>> +}
> >>>> +
> >>>> +static void kingdisplay_panel_remove(struct mipi_dsi_device *dsi)
> >>>> +{
> >>>> +     struct kingdisplay_panel *kingdisplay =3D mipi_dsi_get_drvdata=
(dsi);
> >>>> +     int ret;
> >>>> +
> >>>> +     ret =3D mipi_dsi_detach(dsi);
> >>>> +     if (ret < 0)
> >>>> +             dev_err(&dsi->dev, "failed to detach from DSI host: %d=
\n", ret);
> >>>> +
> >>>> +     if (kingdisplay->base.dev)
> >>>> +             drm_panel_remove(&kingdisplay->base);
> >>>> +}
> >>>> +
> >>>> +static const struct of_device_id kingdisplay_of_match[] =3D {
> >>>> +     { .compatible =3D "kingdisplay,kd101ne3-40ti",
> >>>> +       .data =3D &kingdisplay_kd101ne3_40ti_desc
> >>>> +     },
> >>>> +     { /* sentinel */ }
> >>>> +};
> >>>> +MODULE_DEVICE_TABLE(of, kingdisplay_of_match);
> >>>> +
> >>>> +static struct mipi_dsi_driver kingdisplay_panel_driver =3D {
> >>>> +     .driver =3D {
> >>>> +             .name =3D "panel-kingdisplay-kd101ne3",
> >>>> +             .of_match_table =3D kingdisplay_of_match,
> >>>> +     },
> >>>> +     .probe =3D kingdisplay_panel_probe,
> >>>> +     .remove =3D kingdisplay_panel_remove,
> >>>> +};
> >>>> +module_mipi_dsi_driver(kingdisplay_panel_driver);
> >>>> +
> >>>> +MODULE_AUTHOR("Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google=
.com>");
> >>>> +MODULE_DESCRIPTION("kingdisplay kd101ne3-40ti 800x1280 video mode p=
anel driver");
> >>>> +MODULE_LICENSE("GPL v2");

