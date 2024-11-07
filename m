Return-Path: <linux-kernel+bounces-400527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF889C0ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7AE1C20D89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A291212D16;
	Thu,  7 Nov 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sd6Vmxrc"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB4212F06
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007330; cv=none; b=ORNRBlWe6v2+l1uHVtqkP2UU4RnjzJ8UwKK1dGXKmMQq/82guLjdJUtUFgjjEeVd84f8WSat9L4Nzm75/Rv5AVYtysxPiYfEbQ2tQEMSz+aK3bKVpDMLoadzNwylACq37kkz0AFbFiD8MqWJ1IT8a7LJQbKOXXCzFSLWVFSKZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007330; c=relaxed/simple;
	bh=lHllXdnMTaRiEQuwv0VmM+6qNhl5A6FpLrqtN0PMpc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hdel9Xt3k1gESrUgVag7aRIOOzUnr2KkvzSUeQq4Wt8gQFt31tJNWrXxYeic443R38bSZESDqgKESDBwZRKZ6ZVniYmnMAjIvtuqndZMFR0bcRfLJ5TUvIk5CRUXICFusQbpqEIZuCHbJwIGDb/GJfkuKRwIdpSfW64MFwiUpuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Sd6Vmxrc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6ea7c26e195so15421557b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731007327; x=1731612127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+faqShlI7kynJRtgKZVj8EqnOs4Ii6V9/l+ThTPZ1Q=;
        b=Sd6VmxrcUMMQEFXSoV+Rbdb1OJlQe0BLfNCt3li/khCcFvzAa1P0Yj43UXZXOcCObM
         1XnhDda/427jFaAPukYa7QiTissfRCmpy9gGzsow89BRCj38SorOIC3t7EmSoxrlW6Sh
         U6pFwnKPFIGijS6BKHsOyhH3u6qyutO9RzjUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007327; x=1731612127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+faqShlI7kynJRtgKZVj8EqnOs4Ii6V9/l+ThTPZ1Q=;
        b=XYzDdf5oMpvAW/UqOZ9jMju1eSNnDeKxUfS2aORTeCeNLSAXBCAL1L23KBLtaa7H+/
         qHHJL+9oY1wRBXbQ9fX0MindRYWLlOghBdE+xxUse0DKYE60MsSX4IloQlN1XPMTcYvX
         klZ3ozKfSrasgVR/iyek0lP5i6TuxFKwUlHxN4xrpQeF24Jb/ANzVrsv0xczBM6yOFac
         E+o+W8A2oOFBdW44rnWsdtsu/MJmEwFPuw/+YZyuLOZkg5yLFrLRbNh3mwi5RsOSJk69
         aHqW+k0DgeD6NCcCO1tg5M10RNQ+6U2B5yXTGPeb7r6hJmljObunL0sBUEiMfXOxTurS
         AWIA==
X-Forwarded-Encrypted: i=1; AJvYcCXGug7UuUHWO/s99itTwq8WQ6olFIEnDQ5FiB3nba9rFBrHF6TmKXRHBrTYhQm9Vg8zfhe/LVm9ppAAqMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNugk0ismWHLcq0xmYPn/QmkEJFB7yIzOy8CGDfS+VNmXCNzu
	3aCDaW3o0C6MWeOe3vF+q5EPyq6GIbYQq0Pky+bcDnlWTcKhsbQwxoNctYIoyXuAuAl39sIK97O
	d4hD0f0pE/3/vKeDJJrO/02WNyewnJa1PY0pT
X-Google-Smtp-Source: AGHT+IH6DUGa1COYHKkwF5Xj6YnLZS0q+LTwcv8vJ0RLcI7oiHZJGYbBbtbQ83R8Z0KMAAEGMkbo1zsUxvFC+RXTDeA=
X-Received: by 2002:a05:690c:650a:b0:6ea:84e9:1612 with SMTP id
 00721157ae682-6eadde44efbmr839947b3.29.1731007327035; Thu, 07 Nov 2024
 11:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030212854.998318-1-abhishekpandit@chromium.org>
 <20241030142833.v2.1.I3080b036e8de0b9957c57c1c3059db7149c5e549@changeid>
 <ZyOQJmF-PcFHgmeq@kuha.fi.intel.com> <CANFp7mXhwMMwyqbKqxe=SgCRPUyXVhKnsJwf0xgJ2LefOvrtjg@mail.gmail.com>
 <ZyTUsOg7cd6xSDhn@kuha.fi.intel.com> <CANFp7mVC1RVLF=OPD-jiv5cQeYaA8uqNA0xB5os3iAKo2DFWoA@mail.gmail.com>
 <Zyja9b2Xt-BEc-mx@kuha.fi.intel.com>
In-Reply-To: <Zyja9b2Xt-BEc-mx@kuha.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Thu, 7 Nov 2024 11:21:54 -0800
Message-ID: <CANFp7mVexEta5fecZ5LaM_Pr6xMigTcuDySz1+65BL_-cY2SOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] usb: typec: Add driver for Thunderbolt 3 Alternate Mode
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: tzungbi@kernel.org, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, dmitry.baryshkov@linaro.org, 
	jthies@google.com, akuchynski@google.com, pmalani@chromium.org, 
	Benson Leung <bleung@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 6:32=E2=80=AFAM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Fri, Nov 01, 2024 at 11:48:07AM -0700, Abhishek Pandit-Subedi wrote:
> > On Fri, Nov 1, 2024 at 6:16=E2=80=AFAM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Thu, Oct 31, 2024 at 04:02:22PM -0700, Abhishek Pandit-Subedi wrot=
e:
> > > > On Thu, Oct 31, 2024 at 7:11=E2=80=AFAM Heikki Krogerus
> > > > <heikki.krogerus@linux.intel.com> wrote:
> > > > >
> > > > > Hi Abhishek,
> > > > >
> > > > > On Wed, Oct 30, 2024 at 02:28:32PM -0700, Abhishek Pandit-Subedi =
wrote:
> > > > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > >
> > > > > > Thunderbolt 3 Alternate Mode entry flow is described in
> > > > > > USB Type-C Specification Release 2.0.
> > > > > >
> > > > > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com=
>
> > > > > > Co-developed-by: Abhishek Pandit-Subedi <abhishekpandit@chromiu=
m.org>
> > > > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.=
org>
> > > > > > ---
> > > > > >
> > > > > > Changes:
> > > > > > * Delay cable + plug checks so that the module doesn't fail to =
probe
> > > > > >   if cable + plug information isn't available by the time the p=
artner
> > > > > >   altmode is registered.
> > > > > > * Remove unncessary brace after if (IS_ERR(plug))
> > > > > >
> > > > > > The rest of this patch should be the same as Heikki's original =
RFC.
> > > > > >
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Use <linux/usb/typec_tbt.h> and add missing TBT_CABLE_ROUNDED
> > > > > > - Pass struct typec_thunderbolt_data to typec_altmode_notify
> > > > > > - Rename TYPEC_TBT_MODE to USB_TYPEC_TBT_MODE
> > > > > > - Use USB_TYPEC_TBT_SID and USB_TYPEC_TBT_MODE for device id
> > > > > > - Change module license to GPL due to checkpatch warning
> > > > > >
> > > > > >  drivers/platform/chrome/cros_ec_typec.c  |   2 +-
> > > > > >  drivers/usb/typec/altmodes/Kconfig       |   9 +
> > > > > >  drivers/usb/typec/altmodes/Makefile      |   2 +
> > > > > >  drivers/usb/typec/altmodes/thunderbolt.c | 308 +++++++++++++++=
++++++++
> > > > > >  include/linux/usb/typec_tbt.h            |   3 +-
> > > > > >  5 files changed, 322 insertions(+), 2 deletions(-)
> > > > > >  create mode 100644 drivers/usb/typec/altmodes/thunderbolt.c
> > > > > >
> > > > > > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/=
platform/chrome/cros_ec_typec.c
> > > > > > index c7781aea0b88..53d93baa36a8 100644
> > > > > > --- a/drivers/platform/chrome/cros_ec_typec.c
> > > > > > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > > > > > @@ -499,7 +499,7 @@ static int cros_typec_enable_tbt(struct cro=
s_typec_data *typec,
> > > > > >       }
> > > > > >
> > > > > >       port->state.data =3D &data;
> > > > > > -     port->state.mode =3D TYPEC_TBT_MODE;
> > > > > > +     port->state.mode =3D USB_TYPEC_TBT_MODE;
> > > > > >
> > > > > >       return typec_mux_set(port->mux, &port->state);
> > > > > >  }
> > > > >
> > > > > The definition should be changed in a separate patch.
> > > >
> > > > Ack -- will pull the rename out into its own patch.
> > > >
> > > > >
> > > > > > +static const struct typec_device_id tbt_typec_id[] =3D {
> > > > > > +     { USB_TYPEC_TBT_SID, USB_TYPEC_TBT_MODE },
> > > > > > +     { }
> > > > > > +};
> > > > > > +MODULE_DEVICE_TABLE(typec, tbt_typec_id);
> > > > >
> > > > > Now the mode would be the same thing as connector state, which is=
 not
> > > > > true. The connector state is supposed to reflect the pin assignme=
nt,
> > > > > and the mode is the mode index used with the actual VDMs. For exa=
mple,
> > > > > DP alt mode has several different states, but only one mode.
> > > > >
> > > > > The TBT3 altmode driver will not work with this patch alone, it w=
ill
> > > > > never bind to the partner TBT3 alt mode because the mode does not
> > > > > match.
> > > > >
> > > > > Can you reorganise this series so that the patch 2/7 comes before=
 this
> > > > > one? Then I think you can just use the SVID unless I'm mistaken:
> > > > >
> > > > >         static const struct typec_device_id tbt_typec_id[] =3D {
> > > > >                 { USB_TYPEC_TBT_SID },
> > > > >                 { }
> > > > >         };
> > > > >         MODULE_DEVICE_TABLE(typec, tbt_typec_id);
> > > > >
> > > > > Alternatively, just leave it to TYPEC_ANY_MODE for now.
> > > > >
> > > >
> > > > Sure, I'll re-order the patches and get rid of the mode. I'm actual=
ly
> > > > a bit confused as to how mode is supposed to be used since typec_dp=
.h
> > > > defines USB_TYPEC_DP_MODE=3D1, typec_tbt.h defines
> > > > USB_TYPEC_TBT_MODE=3DTYPEC_STATE_MODAL and it looks like USB state =
also
> > > > starts from TYPEC_STATE_MODAL and continues.
> > > >
> > > > Is this documented in the spec somewhere? How should this mode valu=
e
> > > > be used and shared between USB and various alt-modes? At least the =
DP
> > > > case seems clear because as you said it describes different pin
> > > > assignments. However, the term "mode" seems to be overloaded since
> > > > it's used in other areas.
> > >
> > > Well, this is confusing, I admit. One problem is that the term "mode"
> > > really means different things depending on the spec. In DP alt mode
> > > specification for example, "mode" basically means the same as pin
> > > assignment, so not the object position like it does in USB PD and
> > > Type-C specifications.
> > >
> > > But the alt modes are in any case meant to be differentiated from the
> > > common USB and accessory modes simply by checking if there is struct
> > > altmode or not.
> > >
> > > So the mux drivers for example can use the "alt" member in struct
> > > typec_mux_state to check is the connector meant to enter alt mode, or
> > > USB or accessory mode.
> > >
> > > I.e. if the "alt" member is there, then it's alt mode, and the "mode"
> > > member value matches whatever is defined for that specific alt mode.
> > >
> > > If "alt" is NULL, then connector is in USB mode or accessory mode, an=
d
> > > the "mode" member is one of the common modes:
> > >
> > > enum {
> > >         TYPEC_MODE_USB2 =3D TYPEC_STATE_MODAL,    /* USB 2.0 mode */
> > >         TYPEC_MODE_USB3,                        /* USB 3.2 mode */
> > >         TYPEC_MODE_USB4,                        /* USB4 mode */
> > >         TYPEC_MODE_AUDIO,                       /* Audio Accessory */
> > >         TYPEC_MODE_DEBUG,                       /* Debug Accessory */
> > > }
> > >
> > > I hope this answers your question. Maybe this needs to be clarified i=
n
> > > this document:
> > > https://docs.kernel.org/driver-api/usb/typec.html#multiplexer-demulti=
plexer-switches
> > >
> > > ..and the code obviously. Maybe the "mode" member struct
> > > typec_mux_state should be renamed to "state"? Though, I'm not sure
> > > that improves the situation.
> > >
> >
> > This does make things clearer -- thank you. Based on the various
> > meanings of mode vs state, I think the following will make things
> > clearer:
> >
> > Let's change |mode| to |mode_index| in `struct typec_altmode_desc`.
> > Looking at the Discover SVIDs and Discover Modes response in PD 3.2
> > spec, the value we are passing here is actually the mode_index since
> > that's what's necessary in the VDM to identify which mode we are
> > trying to enter.
>
> Yes, mode_index sounds better.

Opting not to do this rename for this series -- I tried and it was
touching a lot of drivers so I want to do it in a separate series.

TBT already defined the mode index as |TBT_MODE| in <typec_tbt.h> so I
opted to use that for now.

>
> > |USB_TYPEC_DP_MODE| needs to change to |USB_TYPEC_DP_MODE_INDEX| in typ=
ec_dp.h
> > |USB_TYPEC_TBT_MODE| should also be |USB_TYPEC_TBT_MODE_INDEX| with a
> > value of 1 and we should define a new |TYPEC_TBT_STATE| as an enum
> > with base value of TYPEC_STATE_MODAL.
> >
> > Getting rid of the mode index for altmode matching makes sense for DP
> > and TBT (since both have spec defined standard values) but for
> > non-standard modes which might return >1 modes in Discover Modes the
> > driver will match for all modes and not just the specific mode like it
> > was prior to patch 2 in this series. Do we want to retain that and
> > change the TBT driver to only match on mode_index =3D 1 instead. I have
> > no examples of non-standard mode behavior to decide which is the
> > better option here.
>
> Let's drop it for now. We can always add it back.
>
> thanks,
>
> > > > > > +static struct typec_altmode_driver tbt_altmode_driver =3D {
> > > > > > +     .id_table =3D tbt_typec_id,
> > > > > > +     .probe =3D tbt_altmode_probe,
> > > > > > +     .remove =3D tbt_altmode_remove,
> > > > > > +     .driver =3D {
> > > > > > +             .name =3D "typec-thunderbolt",
> > > > > > +             .owner =3D THIS_MODULE,
> > > > > > +     }
> > > > > > +};
> > > > > > +module_typec_altmode_driver(tbt_altmode_driver);
> > > > > > +
> > > > > > +MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.co=
m>");
> > > > > > +MODULE_LICENSE("GPL");
> > > > > > +MODULE_DESCRIPTION("Thunderbolt3 USB Type-C Alternate Mode");
> > > > > > diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/=
typec_tbt.h
> > > > > > index fa97d7e00f5c..3ff82641f6a0 100644
> > > > > > --- a/include/linux/usb/typec_tbt.h
> > > > > > +++ b/include/linux/usb/typec_tbt.h
> > > > > > @@ -10,7 +10,7 @@
> > > > > >  #define USB_TYPEC_TBT_SID            USB_TYPEC_VENDOR_INTEL
> > > > > >
> > > > > >  /* Connector state for Thunderbolt3 */
> > > > > > -#define TYPEC_TBT_MODE                       TYPEC_STATE_MODAL
> > > > > > +#define USB_TYPEC_TBT_MODE           TYPEC_STATE_MODAL
> > > > >
> > > > > I think USB_TYPEC_STATE_TBT would be better. But please change th=
is in
> > > > > a separate patch in any case.
> > > >
> > > > Same question as above about mode vs state :)
> > >
> > > Well, I was thinking that maybe we should use the term "state" here
> > > with the idea that "state" would be something purely kernel specific,
> > > and "mode" would then be something defined in a specification... But
> > > now I'm not so sure (I don't think it's always clear).
> > >
> > > Maybe USB_TYPEC_TBT_MODE after all. I'll leave the decision to you.
> > >
> > > cheers,
> > >
> > > --
> > > heikki
>
> --
> heikki

