Return-Path: <linux-kernel+bounces-440547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578789EC0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE4164EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7E72451D6;
	Wed, 11 Dec 2024 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Bq3n+ZfI"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A95672
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 00:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876500; cv=none; b=CM/2W0j5cxJ1MhUOwnFU6xMHilMUY9QY8xJYqyEByTOrwZEoexLh1j+VSnlYqwB4SiSNm803gu+08dcliSPIpEFJcwKZQg+h9l/9zpagYlr9TRGOkEG+oN7WqwbmdkQZN7awKIkAC+3NPCzakNzxTdRyvMI6txgDgdE3L/U9RhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876500; c=relaxed/simple;
	bh=OWmQK4mdAC2rsDsOX6KDW+e5ZhEGuNmSp8+cOvw6Kvw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyD/iNKqcVRdo/IxraDQuJ/8BRN1wjqs9X2ihuLSEPJSC3hIO/N00XSpfSVpZXUlgf5Vm0s+n8EGs4QsYlxeHudOiZaS2UC4M7Q9ZAOsWo9+8iJeh2SV3Z/38VTRflVkYsPznQGbB8T+MDcVwdIlnskRFn+bgMelRE0IN3IfBbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Bq3n+ZfI; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8a3e99e32so49351686d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733876497; x=1734481297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWDcmReVyivg93WOqDDuc7D90camgnTTGO+3ppNmzqc=;
        b=Bq3n+ZfIJUYMvU1gJ+noZ44D2CauCleyQLbnqvJJHGqRLRaKHa0pvgxvLU0Nvg7PWA
         fPyh5nPJQqX37tCmNz6kYnOVvanllTzxZYq0y0MlLi0aRLlmZZw0P0Ckg1vUyTF+h46E
         qpTzqGoOBYROuF3c0OBj9EP4ONITYwozUNkOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733876497; x=1734481297;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWDcmReVyivg93WOqDDuc7D90camgnTTGO+3ppNmzqc=;
        b=U7WGcxRPZviql7UWQPuz7sm8qUgbvsXJGM6RqK7Hm9aR+aV6Z0TZJRrTc/zW4YXT2k
         SJE3IanjSSk9SiExhczzKtLhvfcy/a0st0hIRARLX6T/KKTmIayy9MGseQVEKkYf2GGb
         9MgYUBjYCBVMHVsB0WBU75peFxvZCcD6las5hfXGhbVIFRePRFD63ySrhixelxGJVsFJ
         ChfCn93GvGUVUi6zGO4sYTxJe+ORGcENwvJB1mb5Ag5ZF5pr3QhlZqQrXovLzSK0FMmX
         LvAtXvui/SWJQ022b+pSyy4LNCnh96twWIk0MuJe/13q+341e/wJdj3Eee3b9/ipTIRh
         uAGA==
X-Forwarded-Encrypted: i=1; AJvYcCUnAy+Q0EKlFvoWFn/XqZNOfWN7DSsnsQ4F9brxqO1qdWZU8QbVYOr/2sTf2u396dtO+/8Wmyoiwm8XhJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVzVD1TEyDhn4iUJp1edjQOb6t/e3JWsm3Bm7RCsUSz6gZr54
	SL7fzo9KrLu7XmR4xosfqTscHT/vcGA7FbMHQuePuBnS3qx6Fy5Wkd3MM0eVMITb/3lVsrwYPA4
	KOEZfjRDYeky+wZWnmho6jPeFdDPZE51koRVG
X-Gm-Gg: ASbGncswH13xSrhQ7P6Fu3j7JK6ldQOOoPgkW4LD3xsdcJlgzACnglS8JKl8QZKrHdT
	iOW9SkgbIJZMM5TjjNRn5vfzILg8oMIiByGCYxJs1RM93tTVFDmEC/8pNGD+fPO0=
X-Google-Smtp-Source: AGHT+IEL9FSUxZd8urwyaWH2ZmQcZhmdV84d1xSdeeNalGcCpZvJCl0ppYxtw2ZYFG5Pb1IwwxipFcIo+xJAxBwEMEM=
X-Received: by 2002:a05:6214:d4c:b0:6d8:a84b:b508 with SMTP id
 6a1803df08f44-6d934b0b8e9mr18358386d6.12.1733876497083; Tue, 10 Dec 2024
 16:21:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Dec 2024 16:21:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241206153813.v4.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
References: <20241206233830.2401638-1-abhishekpandit@chromium.org> <20241206153813.v4.2.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.12.dev1+gaa8c22fdeedb
Date: Tue, 10 Dec 2024 16:21:36 -0800
Message-ID: <CAE-0n52KWd5twmXk5fHf=kfdNm27QTJMPLrU3CRb9SnrtAF_UA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev, 
	heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	tzungbi@kernel.org
Cc: akuchynski@google.com, pmalani@chromium.org, jthies@google.com, 
	dmitry.baryshkov@linaro.org, badhri@google.com, rdbabiera@google.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Abhishek Pandit-Subedi (2024-12-06 15:38:13)
> diff --git a/drivers/usb/typec/altmodes/thunderbolt.c b/drivers/usb/typec/altmodes/thunderbolt.c
> new file mode 100644
> index 000000000000..14e89e9a7691
> --- /dev/null
> +++ b/drivers/usb/typec/altmodes/thunderbolt.c
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**

Remove extra *, this isn't kerneldoc.

> + * USB Typec-C Thuderbolt3 Alternate Mode driver
> + *
> + * Copyright (C) 2019 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + */
> +
> +#include <linux/delay.h>

Is this include used?

> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_tbt.h>

Please include workqueue.h

> +
> +enum tbt_state {
> +       TBT_STATE_IDLE,
> +       TBT_STATE_SOP_P_ENTER,
> +       TBT_STATE_SOP_PP_ENTER,
> +       TBT_STATE_ENTER,
> +       TBT_STATE_EXIT,
> +       TBT_STATE_SOP_PP_EXIT,
> +       TBT_STATE_SOP_P_EXIT
> +};
> +
> +struct tbt_altmode {
> +       enum tbt_state state;
> +       struct typec_cable *cable;
> +       struct typec_altmode *alt;
> +       struct typec_altmode *plug[2];
> +       u32 enter_vdo;
> +
> +       struct work_struct work;
> +       struct mutex lock; /* device lock */

What does it protect? The whole struct tbt_altmode?

> +};
[...]
> +
> +/* MUST HOLD tbt->lock.

Use lockdep_assert_held(tbt->lock) and remove the comment?

> + *
> + * If SOP' is available, enter that first (which will trigger a VDM response
> + * that will enter SOP" if available and then the port). If entering SOP' fails,
> + * stop attempting to enter either cable altmode (probably not supported) and
> + * directly enter the port altmode.
> + */
> +static int tbt_enter_modes_ordered(struct typec_altmode *alt)
> +{
> +       struct tbt_altmode *tbt = typec_altmode_get_drvdata(alt);
> +       int ret = 0;
> +
> +       if (!tbt_ready(tbt->alt))
> +               return -ENODEV;
> +
> +       if (tbt->plug[TYPEC_PLUG_SOP_P]) {
> +               ret = typec_cable_altmode_enter(alt, TYPEC_PLUG_SOP_P, NULL);
> +               if (ret < 0) {
> +                       for (int i = TYPEC_PLUG_SOP_PP; i > 0; --i) {
> +                               if (tbt->plug[i])
> +                                       typec_altmode_put_plug(tbt->plug[i]);
> +
> +                               tbt->plug[i] = NULL;
> +                       }
> +               } else {
> +                       return ret;
> +               }
> +       }
> +
> +       return tbt_enter_mode(tbt);
> +}
> +
> +static int tbt_cable_altmode_vdm(struct typec_altmode *alt,
> +                                enum typec_plug_index sop, const u32 hdr,
> +                                const u32 *vdo, int count)
> +{
[...]
> +               case CMD_EXIT_MODE:
> +                       /* Exit in opposite order: Port, SOP", then SOP'. */
> +                       if (sop == TYPEC_PLUG_SOP_PP)
> +                               tbt->state = TBT_STATE_SOP_P_EXIT;
> +                       break;
> +               }
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       if (tbt->state != TBT_STATE_IDLE)
> +               schedule_work(&tbt->work);
> +
> +

Nitpick: Why two newlines?

> +       mutex_unlock(&tbt->lock);
> +       return 0;
> +}
> +
[...]
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index febe453b96be..b5e67a57762c 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -458,7 +458,8 @@ static umode_t typec_altmode_attr_is_visible(struct kobject *kobj,
>         struct typec_altmode *adev = to_typec_altmode(kobj_to_dev(kobj));
>
>         if (attr == &dev_attr_active.attr)
> -               if (!adev->ops || !adev->ops->activate)
> +               if (!is_typec_port(adev->dev.parent) &&
> +                   (!adev->ops || !adev->ops->activate))
>                         return 0444;
>
>         return attr->mode;
> @@ -563,7 +564,7 @@ typec_register_altmode(struct device *parent,
>
>         if (is_port) {
>                 alt->attrs[3] = &dev_attr_supported_roles.attr;
> -               alt->adev.active = true; /* Enabled by default */
> +               alt->adev.active = !desc->inactive; /* Enabled by default */
>         }
>
>         sprintf(alt->group_name, "mode%d", desc->mode);
> diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> index d616b8807000..252af3f77039 100644
> --- a/include/linux/usb/typec.h
> +++ b/include/linux/usb/typec.h
> @@ -140,6 +140,7 @@ int typec_cable_set_identity(struct typec_cable *cable);
>   * @mode: Index of the Mode
>   * @vdo: VDO returned by Discover Modes USB PD command
>   * @roles: Only for ports. DRP if the mode is available in both roles
> + * @inactive: Only for ports. Make this port inactive (default is active).
>   *
>   * Description of an Alternate Mode which a connector, cable plug or partner
>   * supports.
> @@ -150,6 +151,7 @@ struct typec_altmode_desc {
>         u32                     vdo;
>         /* Only used with ports */
>         enum typec_port_data    roles;
> +       bool                    inactive;
>  };
>
>  void typec_partner_set_pd_revision(struct typec_partner *partner, u16 pd_revision);

These two files look like they can be a different patch? Or the commit
text can describe these changes.

