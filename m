Return-Path: <linux-kernel+bounces-392591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477529B95EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF36C1F21DB1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711A91CACC8;
	Fri,  1 Nov 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L3rx9ciO"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E88A1AC88B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 16:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480010; cv=none; b=nREca0N7+R7p3IFYdVfp2+TtFuo3lIE0cGrqoPRC9mDlP8kQPGthRwKO3/14aiWnQtNy0LidTFyDDPlR8H3nKah+r/Tm1q0eEJKfwsKnoXu9fX1fYOhCDXAXEg2r7MPnn0IOJru1ADp2P1aqQRi3lCmPFxLchJAtD6yzGUDANHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480010; c=relaxed/simple;
	bh=Ufi+EirpxHF3TSrm2RDFRetSaCHdlTKAwnj01Jl20Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohEid0Hn6OdUySYKOldOhrvYNoVIx2yVLzrBjJGtq1HE4MygMaAZNkmB6ZHO2Yrh0E/qVwOnzwnN3mIAwsS5AOo7Of6eIW5eTyeDiB+16dGMpkaxCP3vo+1XqdJ0qQwZJ7df9KP1+K/fY7F50NmWElLorf4J7exQzGjCSk571jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L3rx9ciO; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso2264874276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730480006; x=1731084806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cFxvqyiL9v0JsNOQQhuvM2t8UzauKp6cuL3aW7mXNY=;
        b=L3rx9ciO5LuILwOsXpxUX26Xh8NCM3ehhxBPltvkmIJqZrRdHGG3jdGsFvaa2uulwP
         d1ndIaLUaNnHLeL1BJrbM32CgauAHWpuWboxds9Gb1wpu29/7C06ZQ+pM7bYEnCu6E6j
         4ilV6YYI8JBem1Gz5uiWjPbq2QPpp+gpA6BZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730480006; x=1731084806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cFxvqyiL9v0JsNOQQhuvM2t8UzauKp6cuL3aW7mXNY=;
        b=DktSoUm7MvxR6fwmeS9ZwGB3QPME0i1j9U9ZypMSzg8Qaywj0DjYAwFgXzTNSZO95M
         +qjM60cIO4yb3CEdnDQNba3yRhKRcHmOdRutsd81Es2gR21n/sc1l6Ji0S1rja3Za1eF
         g1O/kVP16KVNUM1Xrddo+EFB2/gBsylV9VMZgnfFn9mPoCnoxLjR+ozjT9dNxczbB9OD
         y4PYmGFW+cWZgNKUT0YocyKhPBimvvjVIBM1Shf4h0EmwneLk15eyzZVruGSwIhEmSts
         KRJ54unr3dyRZ7bsrLKfJVS7UARb+wVlaIvg4MLehNiTUQVwoek45kQ7/CWZqDWqHe/J
         5FwA==
X-Forwarded-Encrypted: i=1; AJvYcCXdCtnsH7U4Wadyn4nXB1SZR8RGE08l4Nl3emxYkrv6I/2Xu+GFmrGQNPZJnFe8YZ2pYFEVT8SG1G9RD0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzwUHKRufdkpnN/GhAmgo4G72xsI4vnOUTEn/yf0NW/JAo5jC0
	64sUWcmgwbBf4+Maj098dQD3L6aqhNRdSNSPalWrUZQ72AjQTTMahorllLt8NghHCjDyvJe3pAr
	vuwe4rpcybJwERj+kxEDVclvBZhGJzoKr9dZ2
X-Google-Smtp-Source: AGHT+IFzApWOAHaMRLiMX928VZb3EEaKQZhz/P+VrQMbvxUftOjxTrNpjkGV033um8Yqj9SuXcwKZI0UTOlzqnKQDdw=
X-Received: by 2002:a05:690c:4b13:b0:6e2:446f:422c with SMTP id
 00721157ae682-6ea64b0f91fmr50088847b3.21.1730480006237; Fri, 01 Nov 2024
 09:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.3.I439cffc7bf76d94f5850eb85980f1197c4f9154c@changeid>
 <ZyOVIKGlrlj7kc9-@kuha.fi.intel.com> <CANFp7mX-DkyFqwoaq_4V1XEDBqK7bj6-nz2aJi7idM=Q2TT49w@mail.gmail.com>
 <ZyTesZ3gCmYDmrA6@kuha.fi.intel.com>
In-Reply-To: <ZyTesZ3gCmYDmrA6@kuha.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 1 Nov 2024 09:53:14 -0700
Message-ID: <CANFp7mWim9VH+KLH3A+RJ5YFuvrVwDUgU2q8_qvDM3=jzYd6xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] usb: typec: Auto enter control for alternate modes
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org, 
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 6:59=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Oct 31, 2024 at 03:48:45PM -0700, Abhishek Pandit-Subedi wrote:
> > On Thu, Oct 31, 2024 at 7:33=E2=80=AFAM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Wed, Oct 30, 2024 at 02:28:34PM -0700, Abhishek Pandit-Subedi wrot=
e:
> > > > Add controls for whether an alternate mode is automatically entered=
 when
> > > > a partner connects. The auto_enter control is only available on por=
ts
> > > > and applies immediately after a partner connects. The default behav=
ior
> > > > is to enable auto enter and drivers must explicitly disable it.
> > > >
> > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  Documentation/ABI/testing/sysfs-bus-typec |  9 +++++++
> > > >  drivers/usb/typec/altmodes/displayport.c  |  6 +++--
> > > >  drivers/usb/typec/altmodes/thunderbolt.c  |  3 ++-
> > > >  drivers/usb/typec/class.c                 | 31 +++++++++++++++++++=
++++
> > > >  include/linux/usb/typec.h                 |  2 ++
> > > >  include/linux/usb/typec_altmode.h         |  2 ++
> > > >  6 files changed, 50 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-bus-typec b/Documentat=
ion/ABI/testing/sysfs-bus-typec
> > > > index 205d9c91e2e1..f09d05727b82 100644
> > > > --- a/Documentation/ABI/testing/sysfs-bus-typec
> > > > +++ b/Documentation/ABI/testing/sysfs-bus-typec
> > > > @@ -12,6 +12,15 @@ Description:
> > > >
> > > >               Valid values are boolean.
> > > >
> > > > +What:                /sys/bus/typec/devices/.../auto_enter
> > > > +Date:                September 2024
> > > > +Contact:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > +Description:
> > > > +             Controls whether a mode will be automatically entered=
 when a partner is
> > > > +             connected.
> > > > +
> > > > +             This field is only valid and displayed on a port. Val=
id values are boolean.
> > >
> > > So, why can't this be controlled with the "active" property of the
> > > port altmode instead? That's why it's there.
> > >
> > > Sorry if I missed something in v1 related to this question.
> >
> > There was a bit of discussion around this in another patch in v1:
> > https://patchwork.kernel.org/project/chrome-platform/patch/202409250925=
05.8.Ic14738918e3d026fa2d85e95fb68f8e07a0828d0@changeid/
> > And this patch is probably a good place to continue that discussion.
> >
> > With the way altmodes drivers currently work, they will auto-enter
> > when probed. So if you have a partner that supports both displayport
> > and thunderbolt, they will both attempt to auto-enter on probe. I
> > think I could use the `active` field instead so that the port altmode
> > blocks entry until userspace enables it -- this would avoid the need
> > to add one more sysfs ABI. I'll actually go ahead and do this for the
> > next patch series I send up.
> >
> > However, the underlying problem I'm trying to solve still exists: how
> > do you choose a specific altmode to enter if there are multiple to
> > choose from? I tried to implement a method that first tries USB4 and
> > then Thunderbolt and then DP but I realized that the altmode drivers
> > don't necessarily bind immediately after a partner altmode is
> > registered so I can't just call `activate` (since no ops are attached
> > to the partner altmode yet). Do you have any thoughts about how to
> > handle multiple modes as well as how to handle fallback mode entry
> > (i.e. thunderbolt fails so you try DPAM next)?
>
> If the user space needs to take over control of the entry order, then
> can't it just de-activate all port alt modes by default, and then
> activate the one that needs to enter? The port driver probable needs
> to implent the "activate" callback for this.
>
> The user space can see when the driver is bound to a device by
> monitoring the uevents, no?

This requires userspace intervention to do the correct thing. Let's
take a real world example:

I have a TBT4 dock that supports DPAM (svid 0xff01), TBT (svid 0x8087)
and also USB4.

* When I plug in the dock, it enumerates and registers the partner
altmodes. The altmode bus matches typec_displayport and
typec_thunderbolt and loads the drivers for them. By default, both
drivers will try to activate their altmode on probe(). Having a
userspace daemon disable the altmode on the ports and enable them on
connection will probably work here.
* If I boot with the dock connected, the same thing happens but my
userspace daemon may not be running yet. What should the default
kernel behavior be to enter alt-modes then? When you throw USB4 into
the mix, this becomes another can of worms since you probably don't
want to downgrade from USB4 to DPAM.

On ChromeOS, prior to this patch series, our userspace daemon (typecd)
could handle all of this in userspace since it could just wait for
`num_alt_modes` to be filled on partner-attach before trying to enter
the right mode (via a side-band channel to the EC). After this change,
typecd will be in a similar bind -- it will have to wait until all
attached partner SVIDs have drivers attached (if available).

Underlying all this, I guess the real need here is for some sort of
signal that says: All partner modes are registered, any necessary
drivers for these modes are bound and you are ready to make a decision
on which mode to enter. Then, we could iteratively try to enter the
best mode (USB4 > TBT > DP) and report failure conditions on why it
couldn't be entered (i.e. Cable speed, partner problem / link
training, etc). This could be done in kernel or userspace depending on
the system.

>
> thanks,
>
> --
> heikki

