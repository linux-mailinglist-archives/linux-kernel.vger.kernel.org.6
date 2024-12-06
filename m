Return-Path: <linux-kernel+bounces-435793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683AE9E7C70
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD46284D3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FBB206279;
	Fri,  6 Dec 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yPpoFFjy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5564213E75
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733527811; cv=none; b=ri9/+tYBjh2v0fFjh9jKA3+j+ahky0PlYPnhE1OLFfMTU+co0gEPP66GCpUINShKfQwSkgXuZyrLBwhI+VhiBlv8IA2t/UkIPItLYH3S4aT7cKOV5y0n3FXVaj31qlo2Mwkok5UPMftrk4sOgKXOkmTxW5t5VUBq26W5Xz1k9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733527811; c=relaxed/simple;
	bh=S4f7HH5HaQvygEntbVvl2LxgjkwEwI49grhkV0+WRu8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=lamNc57RmFQvUllduzlkGXqX8aSLb7DGyEaXt0NV0Mdw+PNdniqJiP4C999ETi6AcBgMvw9a8g1vNHM40s93z4u6kDTWjpERJZ9QjZ4BeMfbuciCOnuja1QCR09vbdEh5JF5elJ6ShdVdJBczjQ2Xo1IqTFGN+W7g1gnjW9/75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yPpoFFjy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53de92be287so2591883e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 15:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733527807; x=1734132607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c6EzaHsGuzaOqYRIY7U3ixl/0nrSAyH+uZa3EUAXIdU=;
        b=yPpoFFjyxtfa8mq5n0CoHRw2GPl492sw0OumOQ0NlERzUVJoAHoJAvoecVjuZkNw6F
         qn4rjX20vZuNz7r613Kcs+cGeWlQNly+Oj2RfxnPFj6KabAOyqqL8MWIt1NwX7TZYyDT
         vCbF/txJzYbWg+iXbfkF1x3RrPAnFVMqdj/IYU7gXyJaKpEnBaq1EulZk7Upp4Q/O0Ks
         U/C15ObmbMjkqa61KD6MIPYIl6XbNnceofKdnksMSuAU3qbQZoy+/jzIZp71AvMv6iky
         3tIeXFQukVpSnEg0eV4fcMgUMJGBDLlcLJL3vbLt1Y02iF+b8yaYv8phy1bFFFvW4m0O
         R/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733527807; x=1734132607;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6EzaHsGuzaOqYRIY7U3ixl/0nrSAyH+uZa3EUAXIdU=;
        b=p8UQ8pBGu0ejQ4iYEkhBc+q6kaPzwiTRPFKwMrGweWYBtY9N0MK7UjQ6PiijS0SxH0
         GmYsjXv9cUUexAL80E1Sj5hQ+6iNoNiTru3xq3eeXGsTeItG6LA2Wj4/Zwa0zmLoK2SY
         BnQyk1AImMRDM6qQkmaRYF62JpdsXCxM+cEGH2u6u7xzctjAcmjD7HWQmR2s9t3Oqg/j
         qJYC1+5X1BAuZimm55NyqD9ECVJ9cLicfKdMcsrdTmmY08bYTViP3ArjCX4PbJS4fT1K
         /QN2Q85wD2g7QvNwTKDxpBti3Ufisr14HPdGL5uwomEz4DLX7h2Xjut0bM/2jv2IbS/z
         jawQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzYQsJAMw2bn6YJFrJx3nKtr22WNt/w2iHBOK/03dhmnDk7FjKiBsON0nLBDPVaSyzRVsWCsyqUJ5ICqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5UTPwCTkujaOyf5RCtQaKWpANoACJhWQwILOkf7ZlPxmV4Wm
	i2T1tqpMINnNhJ0Fwv3XAfv48YJSNib/EoXbipwC2nwWCXQn7lH0/Fu09VCALzc=
X-Gm-Gg: ASbGncv7yGv9jWLTsjfURZqSVDmk5xIXoqosOiGSsXTs6rs1nnWzwg/RIF5boxkOjy/
	8aL8ZtnTFRqncbRgEcPLiHhzPX2hNq7n4WhWUGHpQKVvBVmqMYLbVDNN3glpVUE4KiExWfwag0Z
	t7CCVGONhBU3KxVYk3okt5NTgkkwIb1dGgGTMPzs80rQaHRUcPMwBp5IgIJ+PmI+bVqxTLdWuSO
	P7ltWbEv0Kqe38fvjowEhnnyb+qBynCdXdpHMqdlV4N5eP7gVJIjFy92KoJ8sHg2lbMOLGo5w/x
	S2JUyupINXZbWUjlOw==
X-Google-Smtp-Source: AGHT+IGHndVgDgZB9la+5uc60+m3GbgtnmL02jaAQtpNSjyoQwKsbrutQV8WIqcTziTQQ2oE9J1QTA==
X-Received: by 2002:a05:6512:12c8:b0:53e:368c:ac43 with SMTP id 2adb3069b0e04-53e368cac87mr1264587e87.5.1733527806718;
        Fri, 06 Dec 2024 15:30:06 -0800 (PST)
Received: from [127.0.0.1] (85-76-115-145-nat.elisa-mobile.fi. [85.76.115.145])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca4b7sm637367e87.271.2024.12.06.15.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 15:30:04 -0800 (PST)
Date: Sat, 07 Dec 2024 01:30:01 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
CC: heikki.krogerus@linux.intel.com, tzungbi@kernel.org,
 linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev,
 jthies@google.com, akuchynski@google.com, pmalani@chromium.org,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_6/7=5D_platform/chrome=3A?=
 =?US-ASCII?Q?_cros=5Fec=5Ftypec=3A_Thunderbolt_support?=
User-Agent: Thunderbird for Android
In-Reply-To: <CANFp7mWi2WXTSNeEmXcnzxJV=QuKj_=Y+f6Q_gbSj9v4a6Pt4w@mail.gmail.com>
References: <20241107193021.2690050-1-abhishekpandit@chromium.org> <20241107112955.v3.6.Ic61ced3cdfb5d6776435356061f12307da719829@changeid> <zbtwtfywopvuh5b6skzxf53if7s7lxf53x6uxqnenpe3mipsdg@zdk7wfp7mqbg> <CANFp7mVDpi_g=9LiDZ1mu+GHwkmLVXf7_MnOewFs-Zvu9gqLUQ@mail.gmail.com> <lxu6yktosg57g4qpjua7kfqcg6x27qbojftozkeuzc2wmpsxjb@mgid32lssihf> <CANFp7mWi2WXTSNeEmXcnzxJV=QuKj_=Y+f6Q_gbSj9v4a6Pt4w@mail.gmail.com>
Message-ID: <198817C7-7933-4867-88D3-062AF71BF5C9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7 December 2024 00:23:42 EET, Abhishek Pandit-Subedi <abhishekpandit@chr=
omium=2Eorg> wrote:
>On Thu, Nov 14, 2024 at 2:55=E2=80=AFAM Dmitry Baryshkov
><dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>>
>> On Wed, Nov 13, 2024 at 08:01:57PM -0800, Abhishek Pandit-Subedi wrote:
>> > On Fri, Nov 8, 2024 at 10:41=E2=80=AFPM Dmitry Baryshkov
>> > <dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>> > >
>> > > On Thu, Nov 07, 2024 at 11:29:59AM -0800, Abhishek Pandit-Subedi wr=
ote:
>> > > > Add support for entering and exiting Thunderbolt alt-mode using A=
P
>> > > > driven alt-mode=2E
>> > > >
>> > > > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium=2E=
org>
>> > > > ---
>> > > >
>> > > > Changes in v3:
>> > > > - Fix usage of TBT sid and mode=2E
>> > > > - Removed unused vdm operations during altmode registration
>> > > >
>> > > > Changes in v2:
>> > > > - Refactored thunderbolt support into cros_typec_altmode=2Ec
>> > > >
>> > > >  drivers/platform/chrome/Makefile             |  3 +
>> > > >  drivers/platform/chrome/cros_ec_typec=2Ec      | 23 +++---
>> > > >  drivers/platform/chrome/cros_typec_altmode=2Ec | 85 ++++++++++++=
++++++++
>> > > >  drivers/platform/chrome/cros_typec_altmode=2Eh | 14 ++++
>> > > >  4 files changed, 114 insertions(+), 11 deletions(-)
>> > > >
>> > > > diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/=
chrome/Makefile
>> > > > index 2f90d4db8099=2E=2Eb9b1281de063 100644
>> > > > --- a/drivers/platform/chrome/Makefile
>> > > > +++ b/drivers/platform/chrome/Makefile
>> > > > @@ -21,6 +21,9 @@ cros-ec-typec-objs                  :=3D cros_e=
c_typec=2Eo cros_typec_vdm=2Eo
>> > > >  ifneq ($(CONFIG_TYPEC_DP_ALTMODE),)
>> > > >       cros-ec-typec-objs              +=3D cros_typec_altmode=2Eo
>> > > >  endif
>> > > > +ifneq ($(CONFIG_TYPEC_TBT_ALTMODE),)
>> > > > +     cros-ec-typec-objs              +=3D cros_typec_altmode=2Eo
>> > > > +endif
>> > >
>> > > Doesn't this also result in the object file being included twice an=
d
>> > > thus in a duplicate symbols declaration?
>> >
>> > I was trying to figure out how to add this file if either of those
>> > config options existed in
>> > https://docs=2Ekernel=2Eorg/kbuild/makefiles=2Ehtml#built-in-object-g=
oals-obj-y
>> > and it says, "Duplicates in the lists are allowed: the first instance
>> > will be linked into built-in=2Ea and succeeding instances will be
>> > ignored=2E"
>> >
>> > Is there a preferred way of doing the following in the Makefile:
>> >     if (defined(CONFIG_TYPEC_TBT_ALTMODE) ||
>> > defined(CONFIG_TYPEC_DP_ALTMODE)) {=2E=2E=2E}
>> >
>> > I briefly considered the following and dropped it because it is
>> > terrible readability-wise:
>> >   ifneq ($(CONFIG_TYPEC_TBT_ALTMODE)$(CONFIG_TYPEC_DP_ALTMODE),)
>>
>> The usual way would to define new Kconfig symbol:
>>
>> config CROS_EC_TYPEC_ALTMODES
>>         bool # Note, no description here, don't show in menuconfig
>>         help
>>           Selectable symbol to enable altmodes
>>
>> config CROS_EC_TYPEC
>>         =2E=2E=2E
>>         select CROS_EC_TYPEC_ALTMODES if CONFIG_TYPEC_DP_ALTMODE
>>         select CROS_EC_TYPEC_ALTMODES if CONFIG_TYPEC_TBT_ALTMODE
>>         =2E=2E=2E
>>
>> ----
>>
>> cros-ec-typec-$(CONFIG_CROS_EC_TYPEC_ALTMODES) +=3D cros_typec_altmode=
=2Eo
>>
>> >
>> > >
>> > > >  obj-$(CONFIG_CROS_EC_TYPEC)          +=3D cros-ec-typec=2Eo
>> > > >
>> > > >  obj-$(CONFIG_CROS_EC_LPC)            +=3D cros_ec_lpcs=2Eo
>> > > > diff --git a/drivers/platform/chrome/cros_ec_typec=2Ec b/drivers/=
platform/chrome/cros_ec_typec=2Ec
>> > > > index 3a6f5f2717b9=2E=2E558b618df63c 100644
>> > > > --- a/drivers/platform/chrome/cros_ec_typec=2Ec
>> > > > +++ b/drivers/platform/chrome/cros_ec_typec=2Ec
>> > > > @@ -302,18 +302,19 @@ static int cros_typec_register_port_altmode=
s(struct cros_typec_data *typec,
>> > > >
>> > > >       /*
>> > > >        * Register TBT compatibility alt mode=2E The EC will not e=
nter the mode
>> > > > -      * if it doesn't support it, so it's safe to register it un=
conditionally
>> > > > -      * here for now=2E
>> > > > +      * if it doesn't support it and it will not enter automatic=
ally by
>> > > > +      * design so we can use the |ap_driven_altmode| feature to =
check if we
>> > > > +      * should register it=2E
>> > > >        */
>> > > > -     memset(&desc, 0, sizeof(desc));
>> > > > -     desc=2Esvid =3D USB_TYPEC_TBT_SID;
>> > > > -     desc=2Emode =3D TYPEC_ANY_MODE;
>> > > > -     amode =3D typec_port_register_altmode(port->port, &desc);
>> > > > -     if (IS_ERR(amode))
>> > > > -             return PTR_ERR(amode);
>> > > > -     port->port_altmode[CROS_EC_ALTMODE_TBT] =3D amode;
>> > > > -     typec_altmode_set_drvdata(amode, port);
>> > > > -     amode->ops =3D &port_amode_ops;
>> > > > +     if (typec->ap_driven_altmode) {
>> > > > +             memset(&desc, 0, sizeof(desc));
>> > > > +             desc=2Esvid =3D USB_TYPEC_TBT_SID;
>> > > > +             desc=2Emode =3D TBT_MODE;
>> > > > +             amode =3D cros_typec_register_thunderbolt(port, &de=
sc);
>> > > > +             if (IS_ERR(amode))
>> > > > +                     return PTR_ERR(amode);
>> > > > +             port->port_altmode[CROS_EC_ALTMODE_TBT] =3D amode;
>> > > > +     }
>> > > >
>> > > >       port->state=2Ealt =3D NULL;
>> > > >       port->state=2Emode =3D TYPEC_STATE_USB;
>> > > > diff --git a/drivers/platform/chrome/cros_typec_altmode=2Ec b/dri=
vers/platform/chrome/cros_typec_altmode=2Ec
>> > > > index 3598b8a6ceee=2E=2E9cf2cef6c277 100644
>> > > > --- a/drivers/platform/chrome/cros_typec_altmode=2Ec
>> > > > +++ b/drivers/platform/chrome/cros_typec_altmode=2Ec
>> > > > @@ -8,6 +8,7 @@
>> > > >  #include "cros_ec_typec=2Eh"
>> > > >
>> > > >  #include <linux/usb/typec_dp=2Eh>
>> > > > +#include <linux/usb/typec_tbt=2Eh>
>> > > >  #include <linux/usb/pd_vdo=2Eh>
>> > > >
>> > > >  #include "cros_typec_altmode=2Eh"
>> > > > @@ -67,6 +68,8 @@ static int cros_typec_altmode_enter(struct type=
c_altmode *alt, u32 *vdo)
>> > > >
>> > > >       if (data->sid =3D=3D USB_TYPEC_DP_SID)
>> > > >               req=2Emode_to_enter =3D CROS_EC_ALTMODE_DP;
>> > > > +     else if (data->sid =3D=3D USB_TYPEC_TBT_SID)
>> > > > +             req=2Emode_to_enter =3D CROS_EC_ALTMODE_TBT;
>> > > >       else
>> > > >               return -EOPNOTSUPP;
>> > > >
>> > > > @@ -196,6 +199,53 @@ static int cros_typec_displayport_vdm(struct=
 typec_altmode *alt, u32 header,
>> > > >       return 0;
>> > > >  }
>> > > >
>> > > > +static int cros_typec_thunderbolt_vdm(struct typec_altmode *alt,=
 u32 header,
>> > > > +                                   const u32 *data, int count)
>> > > > +{
>> > > > +     struct cros_typec_altmode_data *adata =3D typec_altmode_get=
_drvdata(alt);
>> > > > +
>> > > > +     int cmd_type =3D PD_VDO_CMDT(header);
>> > > > +     int cmd =3D PD_VDO_CMD(header);
>> > > > +     int svdm_version;
>> > >
>> > > I suppose that with the current approach this misses the ap_mode_en=
try
>> > > check=2E If it gets moved to cros_typec_altmode_vdm(), then it shou=
ld be
>> > > okay=2E
>> >
>> > We don't register the thunderbolt port driver if ap_mode_entry is
>> > false so it's an unnecessary check=2E
>>
>> Why don't you register it? It would allow userspace to understand, what
>> is happening, e=2Eg=2E that the Type-C has switched to the TBT mode=2E
>
>Cros-EC does not support automatic entry of Thunderbolt/USB4 (i=2Ee=2E al=
l
>firmware that supports TBT/USB4 MUST set ap_mode_entry)=2E

Then this definitely looks like something that should also be handled by b=
oltctl=2E Please consider patching it=2E


>
>>
>> >
>> > >
>> > > > +
>> > > > +     svdm_version =3D typec_altmode_get_svdm_version(alt);
>> > > > +     if (svdm_version < 0)
>> > > > +             return svdm_version;
>> > > > +
>> > > > +     switch (cmd_type) {
>> > > > +     case CMDT_INIT:
>> > > > +             if (PD_VDO_SVDM_VER(header) < svdm_version) {
>> > > > +                     typec_partner_set_svdm_version(adata->port-=
>partner,
>> > > > +                                                    PD_VDO_SVDM_=
VER(header));
>> > > > +                     svdm_version =3D PD_VDO_SVDM_VER(header);
>> > > > +             }
>> > > > +
>> > > > +             adata->header =3D VDO(adata->sid, 1, svdm_version, =
cmd);
>> > > > +             adata->header |=3D VDO_OPOS(adata->mode);
>> > > > +
>> > > > +             switch (cmd) {
>> > > > +             case CMD_ENTER_MODE:
>> > > > +                     /* Don't respond to the enter mode vdm beca=
use it
>> > > > +                      * triggers mux configuration=2E This is ha=
ndled directly
>> > > > +                      * by the cros_ec_typec driver so the Thund=
erbolt driver
>> > > > +                      * doesn't need to be involved=2E
>> > > > +                      */
>> > > > +                     break;
>> > > > +             default:
>> > > > +                     adata->header |=3D VDO_CMDT(CMDT_RSP_ACK);
>> > > > +                     schedule_work(&adata->work);
>> > > > +                     break;
>> > > > +             }
>> > > > +
>> > > > +             break;
>> > > > +     default:
>> > > > +             break;
>> > > > +     }
>> > > > +
>> > > > +     return 0;
>> > > > +}
>> > > > +
>> > > > +
>> > > >  static int cros_typec_altmode_vdm(struct typec_altmode *alt, u32=
 header,
>> > > >                                     const u32 *data, int count)
>> > > >  {
>> > > > @@ -204,6 +254,9 @@ static int cros_typec_altmode_vdm(struct type=
c_altmode *alt, u32 header,
>> > > >       if (adata->sid =3D=3D USB_TYPEC_DP_SID)
>> > > >               return cros_typec_displayport_vdm(alt, header, data=
, count);
>> > > >
>> > > > +     if (adata->sid =3D=3D USB_TYPEC_TBT_SID)
>> > > > +             return cros_typec_thunderbolt_vdm(alt, header, data=
, count);
>> > > > +
>> > > >       return -EINVAL;
>> > > >  }
>> > > >
>> > > > @@ -273,3 +326,35 @@ cros_typec_register_displayport(struct cros_=
typec_port *port,
>> > > >       return alt;
>> > > >  }
>> > > >  #endif
>> > > > +
>> > > > +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
>> > > > +struct typec_altmode *
>> > > > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
>> > > > +                             struct typec_altmode_desc *desc)
>> > > > +{
>> > > > +     struct typec_altmode *alt;
>> > > > +     struct cros_typec_altmode_data *data;
>> > > > +
>> > > > +     alt =3D typec_port_register_altmode(port->port, desc);
>> > > > +     if (IS_ERR(alt))
>> > > > +             return alt;
>> > > > +
>> > > > +     data =3D devm_kzalloc(&alt->dev, sizeof(*data), GFP_KERNEL)=
;
>> > > > +     if (!data) {
>> > > > +             typec_unregister_altmode(alt);
>> > > > +             return ERR_PTR(-ENOMEM);
>> > > > +     }
>> > > > +
>> > > > +     INIT_WORK(&data->work, cros_typec_altmode_work);
>> > > > +     data->alt =3D alt;
>> > > > +     data->port =3D port;
>> > > > +     data->ap_mode_entry =3D true;
>> > > > +     data->sid =3D desc->svid;
>> > > > +     data->mode =3D desc->mode;
>> > > > +
>> > > > +     typec_altmode_set_ops(alt, &cros_typec_altmode_ops);
>> > > > +     typec_altmode_set_drvdata(alt, data);
>> > > > +
>> > > > +     return alt;
>> > > > +}
>> > > > +#endif
>> > > > diff --git a/drivers/platform/chrome/cros_typec_altmode=2Eh b/dri=
vers/platform/chrome/cros_typec_altmode=2Eh
>> > > > index c6f8fb02c99c=2E=2E810b553ddcd8 100644
>> > > > --- a/drivers/platform/chrome/cros_typec_altmode=2Eh
>> > > > +++ b/drivers/platform/chrome/cros_typec_altmode=2Eh
>> > > > @@ -31,4 +31,18 @@ static inline int cros_typec_displayport_statu=
s_update(struct typec_altmode *alt
>> > > >       return 0;
>> > > >  }
>> > > >  #endif
>> > > > +
>> > > > +#if IS_ENABLED(CONFIG_TYPEC_TBT_ALTMODE)
>> > > > +struct typec_altmode *
>> > > > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
>> > > > +                             struct typec_altmode_desc *desc);
>> > > > +#else
>> > > > +static inline struct typec_altmode *
>> > > > +cros_typec_register_thunderbolt(struct cros_typec_port *port,
>> > > > +                             struct typec_altmode_desc *desc)
>> > > > +{
>> > > > +     return typec_port_register_altmode(port->port, desc);
>> > > > +}
>> > > > +#endif
>> > > > +
>> > > >  #endif /* __CROS_TYPEC_ALTMODE_H__ */
>> > > > --
>> > > > 2=2E47=2E0=2E277=2Eg8800431eea-goog
>> > > >
>> > >
>> > > --
>> > > With best wishes
>> > > Dmitry
>>
>> --
>> With best wishes
>> Dmitry


