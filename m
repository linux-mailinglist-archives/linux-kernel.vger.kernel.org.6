Return-Path: <linux-kernel+bounces-273925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E1946FC5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B1D1C20BC5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93B377F11;
	Sun,  4 Aug 2024 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/5p4RUH"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF84C627
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722788024; cv=none; b=XZGbsHTbqDB99ttvwu/tBjKN2LB3ZTC+Tg9cTZXXDavJ8I6cN6hG6hkz3kA+xP1KxU9zF8MW83SyQrFO4g7Zr+pvBemzsPCaQTDDKDMETjxDfsPov7bPaidxaz6bE+5tIIbPa0cmOeELFmMb8hAVByCKdpazwp1UsFGZin99IZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722788024; c=relaxed/simple;
	bh=zCav4P04PzaVNPTcrP6X0WthzUIwL6ZygkpC+kiCuio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEF1SuLhc0b9HiemSxmvhk2kDp9jzoyXQrpkGpYbG9Kwyw9PkwXgxhEFqT98TpRDYo+npPjekxYysy5Q8gS/n8mFzCZGC17r94h8FThC0HfIoxtE/WhyWJ0vnkb9bMa7Hg/Oe6Qbi8qtSD5GP1EdoAwwNeGKvVYoF5LEBdbWveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/5p4RUH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cfcbdfa572so3917923a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 09:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722788021; x=1723392821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yMZewbMifmbe0Qa3oRDl7x/yrBUgKL17MTl/9FiQ/U=;
        b=p/5p4RUHfcMDXxfm/E2MKrjG7uaDjnM3QirMyutqQ6aRLm5DsttTG7DmqC0GuWMHEW
         7c4ifcxxwJxDb0LqznT7qBI18gigUOcROumBSoYIWst/0jURkfy6uvfXaQxXNtAGAtnA
         OHpUPY67c0P90PagwppA7uSEEf6fQAJPNOc6BSUetk51Y+aKPkxDohsjDwPccyrJ4BxY
         7ZUTTo//j/suIll58MNQDjUBV+aqtMthkehE39Uao3Tn2oR6FXxGmH7pfn/SK2/9y6lR
         weF5ZGFp1q+ySK7K5/3pfgRc4hZzUN6uoLq81U7bZHMAff2Mdg357+u0X0wvfRD7a1uY
         gCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722788021; x=1723392821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yMZewbMifmbe0Qa3oRDl7x/yrBUgKL17MTl/9FiQ/U=;
        b=sGLkjSVqsxGa2juTFgAODRphJhD8OxJMqfgSrWYfEGBGhRKtGUusM/8jH5lGJtkyGf
         q/ITMYwKKOHayAVipTsEuyCZ7sXKLr3hgXnCSrDlZjo/HD81vJkOBq4U5E1dkr86lm6Y
         1GPYLsA61ovQA2+a2JCh38uAJDcZwwdHUb9PQTugZ+HOAoJyd54+KIBAPl6S4z4guZHX
         wYVjb60I+8GwHUug2NgpxqPutBN9m4fvWDuwYEcUALcuO73JvSN4PFW96NQlfFGF44Sz
         STUbCgSBHAIopTfLLqUAHptFLioL8uuKDfK+Gl7YrYlMiYr7mfqeNoJyuQeK1f0p8cUf
         gNQw==
X-Forwarded-Encrypted: i=1; AJvYcCWLO787UJFfnqq/fGWEJLW0xhN31D381Ay4utPRruGMyPkVcQQsll+5oKjxYFHPnafcwXyTncY1e2XL2h0gYNI4028eLBfeG84Tu0eC
X-Gm-Message-State: AOJu0Yxr9e4UFw4pWQKCJWDOxEF22x4JM0W4FI3sDk0DcXI1hsptI9wf
	nBhu8Y7AzG4l5bVwGL9r/a4tmNaVR/i5dB8sYjcziLJTowZklfTu0z5Brabv00OYoXfTG6b/og7
	y7/w+klf1OVzHKCgleWaWpykv6vCCgSbeMz1G
X-Google-Smtp-Source: AGHT+IGPofaSNk6aSPLiL/tJCLTIXHoHy/UIkcJ/HiY2qCTBrKYHhpac7S76LIb8WeaPrxsNMe4b5Td3KVsxcZR3Skw=
X-Received: by 2002:a17:90a:a784:b0:2cd:3331:ebc7 with SMTP id
 98e67ed59e1d1-2cff93db999mr8180884a91.2.1722788020742; Sun, 04 Aug 2024
 09:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org> <ZqtIztzIS/M+duYT@kuha.fi.intel.com>
In-Reply-To: <ZqtIztzIS/M+duYT@kuha.fi.intel.com>
From: Badhri Jagan Sridharan <badhri@google.com>
Date: Sun, 4 Aug 2024 09:13:03 -0700
Message-ID: <CAPTae5KNQUk2_x_P+i+M+KQvFxu9uugBD=jcLwdMj3sHUmfWzA@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: fix non-contaminant CC handling
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, RD Babiera <rdbabiera@google.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:35=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Andr=C3=A9,
>
> On Wed, Jul 10, 2024 at 07:28:32AM +0100, Andr=C3=A9 Draszik wrote:
> > tcpci_maxim currently never triggers the TCPM state machine when CC
> > status has not changed due to a contaminant but due to a real
> > connection event, i.e. a genuine plug event, meaning the system will
> > stay idle and not notify any subscribers.
> >
> > The reason is that the initial state of the port is 'toggling', which
> > causes _max_tcpci_irq() to only drive the contamination part of the
> > TCPM state machine (via tcpm_port_clean()).
> >
> > What should happen instead is that if no contamination was detected,
> > the TCPM should be notified of the CC change in this case.
> >
> > To fix this, we update ...is_contaminant() to also allow its caller to
> > determine if more CC processing is required and then call into the TCPM
> > as required.
> >
> > While at it, add a kernel-doc for max_contaminant_is_contaminant().
> >
> > Note: the code has an issue where I2C errors during contaminant
> > detection also cause the TCPM state machine to not be updated. This
> > commit doesn't change this behaviour and should be addressed by
> > follow-up commit(s).
>
> This looks okay to me, but just in case, let's wait for comments from
> Badhri, or maybe RD can take a look at this. One nitpick below.
>
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> >  drivers/usb/typec/tcpm/maxim_contaminant.c |  7 +++++--
> >  drivers/usb/typec/tcpm/tcpci_maxim.h       | 15 ++++++++++++++-
> >  drivers/usb/typec/tcpm/tcpci_maxim_core.c  | 12 ++++++++----
> >  3 files changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/t=
ypec/tcpm/maxim_contaminant.c
> > index f8504a90da26..e7fa3e36f8ae 100644
> > --- a/drivers/usb/typec/tcpm/maxim_contaminant.c
> > +++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
> > @@ -322,11 +322,14 @@ static int max_contaminant_enable_dry_detection(s=
truct max_tcpci_chip *chip)
> >       return 0;
> >  }
> >
> > -bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool =
disconnect_while_debounce)
> > +bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool =
disconnect_while_debounce,
> > +                                 bool *cc_handled)
> >  {
> >       u8 cc_status, pwr_cntl;
> >       int ret;
> >
> > +     *cc_handled =3D true;
> > +
> >       ret =3D max_tcpci_read8(chip, TCPC_CC_STATUS, &cc_status);
> >       if (ret < 0)
> >               return false;
> > @@ -368,7 +371,6 @@ bool max_contaminant_is_contaminant(struct max_tcpc=
i_chip *chip, bool disconnect
> >                               return true;
> >                       }
> >               }
> > -             return false;
> >       } else if (chip->contaminant_state =3D=3D DETECTED) {
> >               if (STATUS_CHECK(cc_status, TCPC_CC_STATUS_TOGGLING, 0)) =
{
> >                       chip->contaminant_state =3D max_contaminant_detec=
t_contaminant(chip);
> > @@ -379,6 +381,7 @@ bool max_contaminant_is_contaminant(struct max_tcpc=
i_chip *chip, bool disconnect
> >               }
> >       }
> >
> > +     *cc_handled =3D false;
> >       return false;
> >  }
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/t=
cpm/tcpci_maxim.h
> > index 78ff3b73ee7e..9c7f714d2c21 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_maxim.h
> > +++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
> > @@ -85,6 +85,19 @@ static inline int max_tcpci_write8(struct max_tcpci_=
chip *chip, unsigned int reg
> >       return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8))=
;
> >  }
> >
> > -bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool =
disconnect_while_debounce);
> > +/**
> > + * max_contaminant_is_contaminant - Test if CC was toggled due to cont=
aminant
> > + *
> > + * @chip: Handle to a struct max_tcpci_chip
> > + * @disconnect_while_debounce: Whether or not to sleep as debouncing m=
easure

The description should rather be "Whether the disconnect was detected
when CC pins were debouncing".

> > + * @cc_handled: Returns whether or not CC toggling was handled here

Can we name it cc_update_handled  and update the description to
"Returns whether or not update to CC status was handled here" as it
more accurately describes what you are doing here.

> > + *
> > + * Determine if a contaminant was detected.
> > + *
> > + * Returns: true if a contaminant was detected, false otherwise. cc_ha=
ndled
> > + * is updated to reflect whether or not further CC handling is require=
d.
> > + */
> > +bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool =
disconnect_while_debounce,
> > +                                 bool *cc_handled);
> >
> >  #endif  // TCPCI_MAXIM_H_
> > diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/ty=
pec/tcpm/tcpci_maxim_core.c
> > index eec3bcec119c..55d931672ecd 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
> > @@ -357,12 +357,15 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpc=
i_chip *chip, u16 status)
> >               tcpm_vbus_change(chip->port);
> >
> >       if (status & TCPC_ALERT_CC_STATUS) {
> > +             bool cc_handled =3D false; /* CC toggle handled by contam=
inant detection */
> > +
> >               if (chip->contaminant_state =3D=3D DETECTED || tcpm_port_=
is_toggling(chip->port)) {
> > -                     if (!max_contaminant_is_contaminant(chip, false))
> > +                     if (!max_contaminant_is_contaminant(chip, false,
> > +                                                         &cc_handled))
>
> One line is enough for that.
>
> >                               tcpm_port_clean(chip->port);
> > -             } else {
> > -                     tcpm_cc_change(chip->port);
> >               }
> > +             if (!cc_handled)
> > +                     tcpm_cc_change(chip->port);
> >       }
> >
> >       if (status & TCPC_ALERT_POWER_STATUS)
> > @@ -455,8 +458,9 @@ static int tcpci_init(struct tcpci *tcpci, struct t=
cpci_data *data)
> >  static void max_tcpci_check_contaminant(struct tcpci *tcpci, struct tc=
pci_data *tdata)
> >  {
> >       struct max_tcpci_chip *chip =3D tdata_to_max_tcpci(tdata);
> > +     bool cc_handled;
> >
> > -     if (!max_contaminant_is_contaminant(chip, true))
> > +     if (!max_contaminant_is_contaminant(chip, true, &cc_handled))
> >               tcpm_port_clean(chip->port);
> >  }
>
> thanks,
>
> --
> heikki

Thanks,
Badhri

