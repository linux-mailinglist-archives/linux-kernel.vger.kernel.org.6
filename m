Return-Path: <linux-kernel+bounces-273612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86B946B78
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 01:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ABE1C21474
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 23:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B48136320;
	Sat,  3 Aug 2024 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdvhh2Om"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAE14A84;
	Sat,  3 Aug 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722727502; cv=none; b=ISUxyVT8S8ZpBNCvX+tmR+m2k7ps1pJw38Xm/+FkmQ+Vthr0rURFReu6KDjBHY0YwtFISj0BDpb+Zg8xv0TVa8XIFBSBMdMO+/5dlszRVLz2yzYLOav5hIO/I+GUpzP6avAQiRyiL+YC0qnAfsBqs114/Ed3aQ8+6jhArF7LzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722727502; c=relaxed/simple;
	bh=5HJds0XuSWC/RR7g2Yt4gppQ+qNvJ2JfNHEgPsUeGCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/2BVQGU/9nBMlFXOGuqmWgmLcKzqw3pT2qWMkMBlCAJeSyV40KMa+0lW9JFxE6hOj1FCsBiohGtTiLfGNfajIQoupKm5v6Nwh3wZKymC8U8upB82x2ZkREZopVW3XwL4AEV5f2j0pjEijiKnc9e4hEzwZCiEcCGbVVOT+x9EKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdvhh2Om; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so63499775e9.0;
        Sat, 03 Aug 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722727499; x=1723332299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wYw4vgyQd9FmR8y/MNIX/QpE8cteb0ILlv0AaWcpJA=;
        b=Tdvhh2OmKvEBJLWkOdB4nfn2F+Re1bEp5inStfk/AMtH2+AxqPO2cI5SZWg0rvexF8
         OzTL7LQzwVbUp5fTuSAkZdw1MJC4Vfmg0GdtBiAzAWxh9if7V5XgYKNd7qv4kseZaoCr
         w7HrMZsZJ8qK8L8kyHhMClL92vHc6VC2xrNsaxg3L5J+9hQ3CLa30Bsz7W13BgUdisX3
         PLcJqWzA5Iu88koGOGveEP/nn9GnMDjLISDToQdE6QW+3dF5VqhjS8QDgGYGnoSkn/9W
         PfhegP6dwB0BcMUCPQ94F0AYrTFGIR5ly+eUlYAQ4bEAdSLjNHz5G5VC4OZbbTuEgkMb
         58ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722727499; x=1723332299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wYw4vgyQd9FmR8y/MNIX/QpE8cteb0ILlv0AaWcpJA=;
        b=quS8gVKqmbbSG13vXKcRLJro8qNeThx2In8ftGhmmy6/6iyiFeoOX2HwOuIrL8fshf
         H7/ITKfXgX7DZNuFO6Iv52PdZCNW9jbyRO0e4uuksaj0f0aL2zKGIUF+Q54gkyTVm1v3
         v8P1fRfI6lUlA6+4bVvH/xFEAX7psOi0DJWN+jLN+sDUMnb2nC3jTMaJKnqXSjy8RWCf
         zSE95v/61L4ahXKXufhaz9GXekEou6cvPcaGyjuqBPtRNyqhfyDdfKTTpEwq7L8Bwrbj
         xczlagj1TTgfV2TZ8kbEISKf5MgVR4gCcY8DSLciDJXOd77nc1b9WDaGFyoV1GkumE2S
         GcPg==
X-Forwarded-Encrypted: i=1; AJvYcCXWo7qOYWxN8dE64oZk7nWYqIZt0DaD9b3CJ67OZf68CFvZT/8hujaTcXfaykhD5M6r0Wv1LH8tFz7qK2JDqaExaLHjHrAw02uVDVm4
X-Gm-Message-State: AOJu0Yy1y5MpcKd+RMNfQ38a3mz0xJv7wflUuSw3wOvkSpNrDi0vnIon
	foy0Dp+p4zM9G0FX6gzNMF8n5FZZcq7PGBl77vK4m6eWfZqmUvL7s6Eil2r8VDCoiyTLb6LexZs
	BNFIHOSP/g1UU/tG9aDGwZjTWvQI=
X-Google-Smtp-Source: AGHT+IGRSprGd1ruWtv9PJjOClFcAuJQzNHwT+Pz7lnQR4KqdM1oGf/1EagdMOVfivbXrXdSLsN4enel/GKWaMsR/EU=
X-Received: by 2002:a05:6000:128b:b0:368:7f4f:9ead with SMTP id
 ffacd0b85a97d-36bbc0b4f07mr4655693f8f.7.1722727498581; Sat, 03 Aug 2024
 16:24:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803155215.2746444-2-crwulff@gmail.com> <df07951e-36fb-4642-8135-385b430cfa5c@quicinc.com>
In-Reply-To: <df07951e-36fb-4642-8135-385b430cfa5c@quicinc.com>
From: Chris Wulff <crwulff@gmail.com>
Date: Sat, 3 Aug 2024 19:24:47 -0400
Message-ID: <CAB0kiB+P=E_t_gWJPSAubKESkHGSD2_8xpOChncN4wJaHD22oA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_uac1: Change volume name and remove alt names
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Lee Jones <lee@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Perr Zhang <perr@usb7.net>, 
	Pavel Hofman <pavel.hofman@ivitera.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 1:23=E2=80=AFPM Krishna Kurapati PSSNV
<quic_kriskura@quicinc.com> wrote:
>
>
>
> On 8/3/2024 9:22 PM, crwulff@gmail.com wrote:
> > From: Chris Wulff <crwulff@gmail.com>
> >
> > This changes the UAPI to align with disussion of alt settings work.
> >
> > fu_name is renamed to fu_vol_name, and alt settings mode names
> > are removed for now in favor of future work where they will be
> > settable in subdirectories for each alt mode.
> >
>
> Just a nit.
>
> It would be good to keep the discussion thread link inside commit text
> rather than below the SoB. It would give more context when the patch is
> applied.

Ok, I can move it. I wasn't sure if it was appropriate to include in the co=
mmit
message or not.

  -- Chris

>
> Regards,
> Krishna,
>
> > Signed-off-by: Chris Wulff <crwulff@gmail.com>
> > ---
> > discussion thread for api changes for alt mode settings:
> > https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@=
ivitera.com/T/
> > ---
> >   .../ABI/testing/configfs-usb-gadget-uac1      |  8 ++---
> >   Documentation/usb/gadget-testing.rst          |  8 ++---
> >   drivers/usb/gadget/function/f_uac1.c          | 36 +++++++-----------=
-
> >   drivers/usb/gadget/function/u_uac1.h          |  8 ++---
> >   4 files changed, 18 insertions(+), 42 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Docum=
entation/ABI/testing/configfs-usb-gadget-uac1
> > index cf93b98b274d..64188a85592b 100644
> > --- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
> > +++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
> > @@ -33,13 +33,9 @@ Description:
> >               p_it_name               playback input terminal name
> >               p_it_ch_name            playback channels name
> >               p_ot_name               playback output terminal name
> > -             p_fu_name               playback functional unit name
> > -             p_alt0_name             playback alt mode 0 name
> > -             p_alt1_name             playback alt mode 1 name
> > +             p_fu_vol_name           playback mute/volume functional u=
nit name
> >               c_it_name               capture input terminal name
> >               c_it_ch_name            capture channels name
> >               c_ot_name               capture output terminal name
> > -             c_fu_name               capture functional unit name
> > -             c_alt0_name             capture alt mode 0 name
> > -             c_alt1_name             capture alt mode 1 name
> > +             c_fu_vol_name           capture mute/volume functional un=
it name
> >               =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/g=
adget-testing.rst
> > index a89b49e639c3..7a94490fb2fd 100644
> > --- a/Documentation/usb/gadget-testing.rst
> > +++ b/Documentation/usb/gadget-testing.rst
> > @@ -960,15 +960,11 @@ The uac1 function provides these attributes in it=
s function directory:
> >       p_it_name        playback input terminal name
> >       p_it_ch_name     playback channels name
> >       p_ot_name        playback output terminal name
> > -     p_fu_name        playback functional unit name
> > -     p_alt0_name      playback alt mode 0 name
> > -     p_alt1_name      playback alt mode 1 name
> > +     p_fu_vol_name    playback mute/volume functional unit name
> >       c_it_name        capture input terminal name
> >       c_it_ch_name     capture channels name
> >       c_ot_name        capture output terminal name
> > -     c_fu_name        capture functional unit name
> > -     c_alt0_name      capture alt mode 0 name
> > -     c_alt1_name      capture alt mode 1 name
> > +     c_fu_vol_name    capture mute/volume functional unit name
> >       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >   The attributes have sane default values.
> > diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/=
function/f_uac1.c
> > index 06a220fb7a87..bb36ce2be569 100644
> > --- a/drivers/usb/gadget/function/f_uac1.c
> > +++ b/drivers/usb/gadget/function/f_uac1.c
> > @@ -1254,16 +1254,16 @@ static int f_audio_bind(struct usb_configuratio=
n *c, struct usb_function *f)
> >       strings_uac1[STR_USB_OUT_IT].s =3D audio_opts->p_it_name;
> >       strings_uac1[STR_USB_OUT_IT_CH_NAMES].s =3D audio_opts->p_it_ch_n=
ame;
> >       strings_uac1[STR_IO_OUT_OT].s =3D audio_opts->p_ot_name;
> > -     strings_uac1[STR_FU_OUT].s =3D audio_opts->p_fu_name;
> > -     strings_uac1[STR_AS_OUT_IF_ALT0].s =3D audio_opts->p_alt0_name;
> > -     strings_uac1[STR_AS_OUT_IF_ALT1].s =3D audio_opts->p_alt1_name;
> > +     strings_uac1[STR_FU_OUT].s =3D audio_opts->p_fu_vol_name;
> > +     strings_uac1[STR_AS_OUT_IF_ALT0].s =3D "Playback Inactive";
> > +     strings_uac1[STR_AS_OUT_IF_ALT1].s =3D "Playback Active";
> >
> >       strings_uac1[STR_IO_IN_IT].s =3D audio_opts->c_it_name;
> >       strings_uac1[STR_IO_IN_IT_CH_NAMES].s =3D audio_opts->c_it_ch_nam=
e;
> >       strings_uac1[STR_USB_IN_OT].s =3D audio_opts->c_ot_name;
> > -     strings_uac1[STR_FU_IN].s =3D audio_opts->c_fu_name;
> > -     strings_uac1[STR_AS_IN_IF_ALT0].s =3D audio_opts->c_alt0_name;
> > -     strings_uac1[STR_AS_IN_IF_ALT1].s =3D audio_opts->c_alt1_name;
> > +     strings_uac1[STR_FU_IN].s =3D audio_opts->c_fu_vol_name;
> > +     strings_uac1[STR_AS_IN_IF_ALT0].s =3D "Capture Inactive";
> > +     strings_uac1[STR_AS_IN_IF_ALT1].s =3D "Capture Active";
> >
> >       us =3D usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings=
_uac1));
> >       if (IS_ERR(us))
> > @@ -1687,16 +1687,12 @@ UAC1_ATTRIBUTE_STRING(function_name);
> >   UAC1_ATTRIBUTE_STRING(p_it_name);
> >   UAC1_ATTRIBUTE_STRING(p_it_ch_name);
> >   UAC1_ATTRIBUTE_STRING(p_ot_name);
> > -UAC1_ATTRIBUTE_STRING(p_fu_name);
> > -UAC1_ATTRIBUTE_STRING(p_alt0_name);
> > -UAC1_ATTRIBUTE_STRING(p_alt1_name);
> > +UAC1_ATTRIBUTE_STRING(p_fu_vol_name);
> >
> >   UAC1_ATTRIBUTE_STRING(c_it_name);
> >   UAC1_ATTRIBUTE_STRING(c_it_ch_name);
> >   UAC1_ATTRIBUTE_STRING(c_ot_name);
> > -UAC1_ATTRIBUTE_STRING(c_fu_name);
> > -UAC1_ATTRIBUTE_STRING(c_alt0_name);
> > -UAC1_ATTRIBUTE_STRING(c_alt1_name);
> > +UAC1_ATTRIBUTE_STRING(c_fu_vol_name);
> >
> >   static struct configfs_attribute *f_uac1_attrs[] =3D {
> >       &f_uac1_opts_attr_c_chmask,
> > @@ -1724,16 +1720,12 @@ static struct configfs_attribute *f_uac1_attrs[=
] =3D {
> >       &f_uac1_opts_attr_p_it_name,
> >       &f_uac1_opts_attr_p_it_ch_name,
> >       &f_uac1_opts_attr_p_ot_name,
> > -     &f_uac1_opts_attr_p_fu_name,
> > -     &f_uac1_opts_attr_p_alt0_name,
> > -     &f_uac1_opts_attr_p_alt1_name,
> > +     &f_uac1_opts_attr_p_fu_vol_name,
> >
> >       &f_uac1_opts_attr_c_it_name,
> >       &f_uac1_opts_attr_c_it_ch_name,
> >       &f_uac1_opts_attr_c_ot_name,
> > -     &f_uac1_opts_attr_c_fu_name,
> > -     &f_uac1_opts_attr_c_alt0_name,
> > -     &f_uac1_opts_attr_c_alt1_name,
> > +     &f_uac1_opts_attr_c_fu_vol_name,
> >
> >       NULL,
> >   };
> > @@ -1792,16 +1784,12 @@ static struct usb_function_instance *f_audio_al=
loc_inst(void)
> >       scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Playback Inp=
ut terminal");
> >       scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Playba=
ck Channels");
> >       scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Playback Out=
put terminal");
> > -     scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Vol=
ume");
> > -     scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback=
 Inactive");
> > -     scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback=
 Active");
> > +     scnprintf(opts->p_fu_vol_name, sizeof(opts->p_fu_vol_name), "Play=
back Volume");
> >
> >       scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "Capture Inpu=
t terminal");
> >       scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Captur=
e Channels");
> >       scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Capture Outp=
ut terminal");
> > -     scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volu=
me");
> > -     scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture =
Inactive");
> > -     scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture =
Active");
> > +     scnprintf(opts->c_fu_vol_name, sizeof(opts->c_fu_vol_name), "Capt=
ure Volume");
> >
> >       return &opts->func_inst;
> >   }
> > diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/=
function/u_uac1.h
> > index 67784de9782b..feb6eb76462f 100644
> > --- a/drivers/usb/gadget/function/u_uac1.h
> > +++ b/drivers/usb/gadget/function/u_uac1.h
> > @@ -57,16 +57,12 @@ struct f_uac1_opts {
> >       char                    p_it_name[USB_MAX_STRING_LEN];
> >       char                    p_it_ch_name[USB_MAX_STRING_LEN];
> >       char                    p_ot_name[USB_MAX_STRING_LEN];
> > -     char                    p_fu_name[USB_MAX_STRING_LEN];
> > -     char                    p_alt0_name[USB_MAX_STRING_LEN];
> > -     char                    p_alt1_name[USB_MAX_STRING_LEN];
> > +     char                    p_fu_vol_name[USB_MAX_STRING_LEN];
> >
> >       char                    c_it_name[USB_MAX_STRING_LEN];
> >       char                    c_it_ch_name[USB_MAX_STRING_LEN];
> >       char                    c_ot_name[USB_MAX_STRING_LEN];
> > -     char                    c_fu_name[USB_MAX_STRING_LEN];
> > -     char                    c_alt0_name[USB_MAX_STRING_LEN];
> > -     char                    c_alt1_name[USB_MAX_STRING_LEN];
> > +     char                    c_fu_vol_name[USB_MAX_STRING_LEN];
> >
> >       struct mutex                    lock;
> >       int                             refcnt;

