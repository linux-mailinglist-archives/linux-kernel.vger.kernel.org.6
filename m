Return-Path: <linux-kernel+bounces-409162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F059C8844
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C488B2D5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CAB1F81AC;
	Thu, 14 Nov 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ublcbiJG"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF111F76B8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731581726; cv=none; b=s0237j591zZpKahitZIcXKa4QPouU4yf0FMLezOulq2zVgki6+W2cgR+rPP6YFPa4FTNmnrh9/n2AUpEHLiYdTa2ktuza9rhKRiG05T263wo52qMAnZBEld2B/1QzuM6dILuys1w3uGrKFDims8R7VauvGYhUOOhkHZHHnmJ23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731581726; c=relaxed/simple;
	bh=NYxWfk8mVy/rUYcxd5bdgKpq2sQo2ey+wzT0WrMNqLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifF3vm8UPeBwxKXlSgla/hEzv0P0h4ZvyloPSZeC02CaiP3aCj763SBVyBS+DlUjsNNOo6IoFURWRUKFhqXV89qCLmRyFWPJpDP+5teFEWLUuiVctcfPL6NDbTl/kdjyH7+8ONL+qhDYdT2ZAoxWlYBy33AEJ8jstujr2qNy5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ublcbiJG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53da5511f3cso393522e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 02:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731581723; x=1732186523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3NlQOXP3Q/OO0DFt7/Dq2kYzaxWbzmuBF83VLCkwPXM=;
        b=ublcbiJGgNKobhSExvRau7pLI03/ExF9RwY+FyAWi85Bl4NBYPAIkk5nOzPWBrYjs6
         JisG2xEB5xqXTywNt3WVnIPxxFDZ7cWzJW+chcaMYRzRLLcN6BKUDQ9I8v9NUOmB/MIF
         3yPGsXNNCB6rpi1P7uuKLFIvnyDEK3zo9jFk3OeTiZZ/ndZYaLpZj63HpKww0bPZw2l+
         LM0B8tUN4Tni7oWlGWeuBH3dkUEsKQuFjlQZmnvYVj859c3y15yWBQyrH+5PCEOgoU1f
         8eU9QuPhn+kZYl/k2s0PcD04RDSuAy/t/VxomBDL/ouoplQuFa1PD3uxVkZisMjiLVt3
         /baw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731581723; x=1732186523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NlQOXP3Q/OO0DFt7/Dq2kYzaxWbzmuBF83VLCkwPXM=;
        b=A13E5mjQ+zxkGD36TRBmqm4NlT5cTgqjeHkf3u2iZphzcQeOkVzT96z2EGLFsJHIXK
         aVs0iDar4tQRX5Bh+LS4x0SX5oDWrWS8S5gZgIoAsoPEha8Aocl75m5SKkyGkx0B9MVD
         nM3JM6DL+x+wRLjRRpn9sM9O094BtP1rsSttx/gsxrW2EjQkVu+XmTyOjSXKgcusrfBV
         Z9bjh7A4llb+18XFPqazLlqqVpdysMihWHcqeNUZ5TzGD2NsvqTo5WcvaXaJqzzhudbp
         fE4pSyz+uaF7os34mdNVRF9BnlbDkYxcLw5kT1zKLUhwWLPTBJI4KOwkwslRLO9Tc1cK
         e/LA==
X-Forwarded-Encrypted: i=1; AJvYcCWuNUVO7guVm9kxYH+dBy9h3+w5uaDhQZpW44+M0VxC9xggksJhHLYz7aRcJKRZozmzsv8Nbh3eRlJMIDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbnaREu7uDql5dlc7YgzkPAKHVIvu/OpjRXTHNTTyhhevIJEFS
	Vamfq2lx8eCKhZTwFXQk9V74G2t4o1JU1xeyUsZiYXYWdBtrFVVDeSfg4z9zEXki3Jg8dymDcjX
	3
X-Google-Smtp-Source: AGHT+IEN8qYX+K9P/ob9zUmzEJEm3r0MO1CA/Aytofo99k4uE2ohOUtAy5jKk2p3lDxw/QWlGEKmmw==
X-Received: by 2002:a2e:a5c4:0:b0:2f6:62a1:25fe with SMTP id 38308e7fff4ca-2ff426c1f51mr60251911fa.23.1731581722967;
        Thu, 14 Nov 2024 02:55:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff5977954bsm1362431fa.33.2024.11.14.02.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:55:21 -0800 (PST)
Date: Thu, 14 Nov 2024 12:55:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, 
	linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev, jthies@google.com, 
	akuchynski@google.com, pmalani@chromium.org, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] platform/chrome: cros_ec_typec: Thunderbolt
 support
Message-ID: <lxu6yktosg57g4qpjua7kfqcg6x27qbojftozkeuzc2wmpsxjb@mgid32lssihf>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org>
 <20241107112955.v3.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid>
 <zbtwtfywopvuh5b6skzxf53if7s7lxf53x6uxqnenpe3mipsdg@zdk7wfp7mqbg>
 <CANFp7mVDpi_g=9LiDZ1mu+GHwkmLVXf7_MnOewFs-Zvu9gqLUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mVDpi_g=9LiDZ1mu+GHwkmLVXf7_MnOewFs-Zvu9gqLUQ@mail.gmail.com>

On Wed, Nov 13, 2024 at 08:01:57PM -0800, Abhishek Pandit-Subedi wrote:
> On Fri, Nov 8, 2024 at 10:41 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, Nov 07, 2024 at 11:29:59AM -0800, Abhishek Pandit-Subedi wrote:
> > > Add support for entering and exiting Thunderbolt alt-mode using AP
> > > driven alt-mode.
> > >
> > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > ---
> > >
> > > Changes in v3:
> > > - Fix usage of TBT sid and mode.
> > > - Removed unused vdm operations during altmode registration
> > >
> > > Changes in v2:
> > > - Refactored thunderbolt support into cros_typec_altmode.c
> > >
> > >  drivers/platform/chrome/Makefile             |  3 +
> > >  drivers/platform/chrome/cros_ec_typec.c      | 23 +++---
> > >  drivers/platform/chrome/cros_typec_altmode.c | 85 ++++++++++++++++++++
> > >  drivers/platform/chrome/cros_typec_altmode.h | 14 ++++
> > >  4 files changed, 114 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> > > index 2f90d4db8099..b9b1281de063 100644
> > > --- a/drivers/platform/chrome/Makefile
> > > +++ b/drivers/platform/chrome/Makefile
> > > @@ -21,6 +21,9 @@ cros-ec-typec-objs                  := cros_ec_typec.o cros_typec_vdm.o
> > >  ifneq ($(CONFIG_TYPEC_DP_ALTMODE),)
> > >       cros-ec-typec-objs              += cros_typec_altmode.o
> > >  endif
> > > +ifneq ($(CONFIG_TYPEC_TBT_ALTMODE),)
> > > +     cros-ec-typec-objs              += cros_typec_altmode.o
> > > +endif
> >
> > Doesn't this also result in the object file being included twice and
> > thus in a duplicate symbols declaration?
> 
> I was trying to figure out how to add this file if either of those
> config options existed in
> https://docs.kernel.org/kbuild/makefiles.html#built-in-object-goals-obj-y
> and it says, "Duplicates in the lists are allowed: the first instance
> will be linked into built-in.a and succeeding instances will be
> ignored."
> 
> Is there a preferred way of doing the following in the Makefile:
>     if (defined(CONFIG_TYPEC_TBT_ALTMODE) ||
> defined(CONFIG_TYPEC_DP_ALTMODE)) {...}
> 
> I briefly considered the following and dropped it because it is
> terrible readability-wise:
>   ifneq ($(CONFIG_TYPEC_TBT_ALTMODE)$(CONFIG_TYPEC_DP_ALTMODE),)

The usual way would to define new Kconfig symbol:

config CROS_EC_TYPEC_ALTMODES
	bool # Note, no description here, don't show in menuconfig
	help
	  Selectable symbol to enable altmodes

config CROS_EC_TYPEC
	...
	select CROS_EC_TYPEC_ALTMODES if CONFIG_TYPEC_DP_ALTMODE
	select CROS_EC_TYPEC_ALTMODES if CONFIG_TYPEC_TBT_ALTMODE
	...

----

cros-ec-typec-$(CONFIG_CROS_EC_TYPEC_ALTMODES) += cros_typec_altmode.o

> 
> >
> > >  obj-$(CONFIG_CROS_EC_TYPEC)          += cros-ec-typec.o
> > >
> > >  obj-$(CONFIG_CROS_EC_LPC)            += cros_ec_lpcs.o
> > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > > index 3a6f5f2717b9..558b618df63c 100644
> > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > @@ -302,18 +302,19 @@ static int cros_typec_register_port_altmodes(struct cros_typec_data *typec,
> > >
> > >       /*
> > >        * Register TBT compatibility alt mode. The EC will not enter the mode
> > > -      * if it doesn't support it, so it's safe to register it unconditionally
> > > -      * here for now.
> > > +      * if it doesn't support it and it will not enter automatically by
> > > +      * design so we can use the |ap_driven_altmode| feature to check if we
> > > +      * should register it.
> > >        */
> > > -     memset(&desc, 0, sizeof(desc));
> > > -     desc.svid = USB_TYPEC_TBT_SID;
> > > -     desc.mode = TYPEC_ANY_MODE;
> > > -     amode = typec_port_register_altmode(port->port, &desc);
> > > -     if (IS_ERR(amode))
> > > -             return PTR_ERR(amode);
> > > -     port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
> > > -     typec_altmode_set_drvdata(amode, port);
> > > -     amode->ops = &port_amode_ops;
> > > +     if (typec->ap_driven_altmode) {
> > > +             memset(&desc, 0, sizeof(desc));
> > > +             desc.svid = USB_TYPEC_TBT_SID;
> > > +             desc.mode = TBT_MODE;
> > > +             amode = cros_typec_register_thunderbolt(port, &desc);
> > > +             if (IS_ERR(amode))
> > > +                     return PTR_ERR(amode);
> > > +             port->port_altmode[CROS_EC_ALTMODE_TBT] = amode;
> > > +     }
> > >
> > >       port->state.alt = NULL;
> > >       port->state.mode = TYPEC_STATE_USB;
> > > diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
> > > index 3598b8a6ceee..9cf2cef6c277 100644
> > > --- a/drivers/platform/chrome/cros_typec_altmode.c
> > > +++ b/drivers/platform/chrome/cros_typec_altmode.c
> > > @@ -8,6 +8,7 @@
> > >  #include "cros_ec_typec.h"
> > >
> > >  #include <linux/usb/typec_dp.h>
> > > +#include <linux/usb/typec_tbt.h>
> > >  #include <linux/usb/pd_vdo.h>
> > >
> > >  #include "cros_typec_altmode.h"
> > > @@ -67,6 +68,8 @@ static int cros_typec_altmode_enter(struct typec_altmode *alt, u32 *vdo)
> > >
> > >       if (data->sid == USB_TYPEC_DP_SID)
> > >               req.mode_to_enter = CROS_EC_ALTMODE_DP;
> > > +     else if (data->sid == USB_TYPEC_TBT_SID)
> > > +             req.mode_to_enter = CROS_EC_ALTMODE_TBT;
> > >       else
> > >               return -EOPNOTSUPP;
> > >
> > > @@ -196,6 +199,53 @@ static int cros_typec_displayport_vdm(struct typec_altmode *alt, u32 header,
> > >       return 0;
> > >  }
> > >
> > > +static int cros_typec_thunderbolt_vdm(struct typec_altmode *alt, u32 header,
> > > +                                   const u32 *data, int count)
> > > +{
> > > +     struct cros_typec_altmode_data *adata = typec_altmode_get_drvdata(alt);
> > > +
> > > +     int cmd_type = PD_VDO_CMDT(header);
> > > +     int cmd = PD_VDO_CMD(header);
> > > +     int svdm_version;
> >
> > I suppose that with the current approach this misses the ap_mode_entry
> > check. If it gets moved to cros_typec_altmode_vdm(), then it should be
> > okay.
> 
> We don't register the thunderbolt port driver if ap_mode_entry is
> false so it's an unnecessary check.

Why don't you register it? It would allow userspace to understand, what
is happening, e.g. that the Type-C has switched to the TBT mode.

> 
> >
> > > +
> > > +     svdm_version = typec_altmode_get_svdm_version(alt);
> > > +     if (svdm_version < 0)
> > > +             return svdm_version;
> > > +
> > > +     switch (cmd_type) {
> > > +     case CMDT_INIT:
> > > +             if (PD_VDO_SVDM_VER(header) < svdm_version) {
> > > +                     typec_partner_set_svdm_version(adata->port->partner,
> > > +                                                    PD_VDO_SVDM_VER(header));
> > > +                     svdm_version = PD_VDO_SVDM_VER(header);
> > > +             }
> > > +
> > > +             adata->header = VDO(adata->sid, 1, svdm_version, cmd);
> > > +             adata->header |= VDO_OPOS(adata->mode);
> > > +
> > > +             switch (cmd) {
> > > +             case CMD_ENTER_MODE:
> > > +                     /* Don't respond to the enter mode vdm because it
> > > +                      * triggers mux configuration. This is handled directly
> > > +                      * by the cros_ec_typec driver so the Thunderbolt driver
> > > +                      * doesn't need to be involved.
> > > +                      */
> > > +                     break;
> > > +             default:
> > > +                     adata->header |= VDO_CMDT(CMDT_RSP_ACK);
> > > +                     schedule_work(&adata->work);
> > > +                     break;
> > > +             }
> > > +
> > > +             break;
> > > +     default:
> > > +             break;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +
> > >  static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
> > >                                     const u32 *data, int count)
> > >  {
> > > @@ -204,6 +254,9 @@ static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32 header,
> > >       if (adata->sid == USB_TYPEC_DP_SID)
> > >               return cros_typec_displayport_vdm(alt, header, data, count);
> > >
> > > +     if (adata->sid == USB_TYPEC_TBT_SID)
> > > +             return cros_typec_thunderbolt_vdm(alt, header, data, count);
> > > +
> > >       return -EINVAL;
> > >  }
> > >
> > > @@ -273,3 +326,35 @@ cros_typec_register_displayport(struct cros_typec_port *port,
> > >       return alt;
> > >  }
> > >  #endif
> > > +
> > > +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
> > > +struct typec_altmode *
> > > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> > > +                             struct typec_altmode_desc *desc)
> > > +{
> > > +     struct typec_altmode *alt;
> > > +     struct cros_typec_altmode_data *data;
> > > +
> > > +     alt = typec_port_register_altmode(port->port, desc);
> > > +     if (IS_ERR(alt))
> > > +             return alt;
> > > +
> > > +     data = devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL);
> > > +     if (!data) {
> > > +             typec_unregister_altmode(alt);
> > > +             return ERR_PTR(-ENOMEM);
> > > +     }
> > > +
> > > +     INIT_WORK(&data->work, cros_typec_altmode_work);
> > > +     data->alt = alt;
> > > +     data->port = port;
> > > +     data->ap_mode_entry = true;
> > > +     data->sid = desc->svid;
> > > +     data->mode = desc->mode;
> > > +
> > > +     typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
> > > +     typec_altmode_set_drvdata(alt, data);
> > > +
> > > +     return alt;
> > > +}
> > > +#endif
> > > diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
> > > index c6f8fb02c99c..810b553ddcd8 100644
> > > --- a/drivers/platform/chrome/cros_typec_altmode.h
> > > +++ b/drivers/platform/chrome/cros_typec_altmode.h
> > > @@ -31,4 +31,18 @@ static inline int cros_typec_displayport_status_update(struct typec_altmode *alt
> > >       return 0;
> > >  }
> > >  #endif
> > > +
> > > +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
> > > +struct typec_altmode *
> > > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> > > +                             struct typec_altmode_desc *desc);
> > > +#else
> > > +static inline struct typec_altmode *
> > > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
> > > +                             struct typec_altmode_desc *desc)
> > > +{
> > > +     return typec_port_register_altmode(port->port, desc);
> > > +}
> > > +#endif
> > > +
> > >  #endif /* __CROS_TYPEC_ALTMODE_H__ */
> > > --
> > > 2.47.0.277.g8800431eea-goog
> > >
> >
> > --
> > With best wishes
> > Dmitry

-- 
With best wishes
Dmitry

