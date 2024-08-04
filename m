Return-Path: <linux-kernel+bounces-273618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C7946B8E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECCB1F2148C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAE123D0;
	Sun,  4 Aug 2024 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In3hWyi/"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C65DEC5;
	Sun,  4 Aug 2024 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722731004; cv=none; b=YW+dsYWCxq2Cww1mDeudBj1QV2L9VsfQu4tjvclSrKQpbR67V5lUwpu+ehrlsDpNbctzVJTY1NptNSgwF2yMBew6mEiQtt7f4llMru0RKJA3wU5b6Aa6iCvc9oTDpR2VUYANxtqzDF9Fiig7PrwVvHZ+f9TBdtFmAHqhfXjYI64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722731004; c=relaxed/simple;
	bh=lZj8h77mrM1pl0ZdrfmwKTiHqursXvc1gsqORiXOtJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoaPcDgJlZ+6KGyXl74p7q4+Sxy8/ER3JrgHjlxdqxUIqiaZmJEs9sGH7w5LX6GCHNWiUZTeysycXQHKCXEdFmWuFpBqtOZDD08B/dMUItdtW9gPuH4Ts3w6oh510iQliWCE7QbH8NnAvIujTsmwOK9D4gDIb9GXk25ngmGPcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=In3hWyi/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-367963ea053so6108047f8f.2;
        Sat, 03 Aug 2024 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722731000; x=1723335800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSAG/u3sY54xUN4xbntEq10oQnmxfuAyYjqopUt/Dw4=;
        b=In3hWyi/ziaeNVUGB4r9h8Kbw/A5HH6oZ8Pr0axfGaYgLjus3pekq+fSWzPkOGrl1H
         OPHiktFKBOenLW7aPHGE6KCNiJcXbeHFwmVUp6iw8Gt55m0iNfxg7PUARvD7P80PbxQX
         zWDncrD7c0ejmWdZNCdF1qJAb4P9DbGmt3H59LvztJZYekhPU+ZAG0EMRXNHnBIldXpx
         DzaRH+KlvKh3y4zE57RlfqorZtGoFg6gOY1wq8fHXiG1i1DQuU7zpX5dsvOds6hlZnsn
         0LpeFWtck5td4NAPukzf81tLd/BndH5xUsNhnRSajm4m7DPsWyLDsoYtFBVHWVJjhGd4
         jIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722731000; x=1723335800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSAG/u3sY54xUN4xbntEq10oQnmxfuAyYjqopUt/Dw4=;
        b=Kjos2X5Yy7yrQSgk1WdlbdqGRpkCei4H1I/mfO5y67ROzf6fgM8YuPELojw2STnyYp
         aJJXeGw+egeLAKZwITnXUQAOdIRIDMjSIUMzueFUVjxRdFEe8/ktc6xLXnDkQzY8a7Oz
         5VKYyigkeOzh/r58hQHZEPJKPSu3X93P6oTT5jV7QJKyICQpZ67Z2Wd7bBzO1J2CiZX/
         gO5C4Yp34ZLaekv0JQsmImDCYEo0o9+/9Ilr2b+J8wmwDRtbcI/4txYuEj2alMLIz0sd
         vZtjxBV8l5UbEuiE3ZB9wywBR19ityfnYkiH+ZP18oh+nTMLYuMONfV7B81Z5wT/22L0
         h6Xw==
X-Forwarded-Encrypted: i=1; AJvYcCX9teLaKl/ghx51hK98kg4bfz7KGO1yN5C22eCHuCIaiIlrD/wzfcXIOTYIiHJLsZypB7xNr5tgDEFp1ychCCwfwKiymOZMnooRMGB5
X-Gm-Message-State: AOJu0YwDM+b0vLPz3gt1NhmLYPNO1cv+saC5OTzoWXxsVTBT89y2MCW6
	YnzBatQ6C3zC0utTafsIKhzG2KnNaNE+LYmm93TkyqqYZZa7jhAxjZKYUllkIWLYtjdu34oqvOL
	ieaO3wz9/o1Lg+fN5Bz16ZdcXATaerA==
X-Google-Smtp-Source: AGHT+IEEOX3ARaE1wTZ4dZrATqOFRna0SUWAX8l5smNOKnt6sXOJpo+kovumNkFtrk1HX+qrUN+S1ntQpBYGBq3KRBE=
X-Received: by 2002:a5d:4590:0:b0:366:f04d:676f with SMTP id
 ffacd0b85a97d-36bbc0e09f9mr6017778f8f.12.1722731000356; Sat, 03 Aug 2024
 17:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803232722.3220995-2-crwulff@gmail.com>
In-Reply-To: <20240803232722.3220995-2-crwulff@gmail.com>
From: Chris Wulff <crwulff@gmail.com>
Date: Sat, 3 Aug 2024 20:23:09 -0400
Message-ID: <CAB0kiBJiK=fQ_g0bjUkVTLzisQT+A5i-X9fxvM5Lvr1efpkYCA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: f_uac1: Change volume name and remove alt names
To: linux-usb@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, Perr Zhang <perr@usb7.net>, 
	Pavel Hofman <pavel.hofman@ivitera.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just realized the name semantics are backwards in the original patch as w=
ell.
(c_/p_ are device centric semantics and I made them host centric)
I will update that and send out a new version.

  -- Chris Wulff

On Sat, Aug 3, 2024 at 7:27=E2=80=AFPM <crwulff@gmail.com> wrote:
>
> From: Chris Wulff <crwulff@gmail.com>
>
> This changes the UAPI to align with disussion of alt settings work.
>
> fu_name is renamed to fu_vol_name, and alt settings mode names
> are removed for now in favor of future work where they will be
> settable in subdirectories for each alt mode.
>
> discussion thread for api changes for alt mode settings:
> https://lore.kernel.org/linux-usb/35be4668-58d3-894a-72cf-de1afaacae45@iv=
itera.com/T/
>
> Signed-off-by: Chris Wulff <crwulff@gmail.com>
> ---
> v2: Moved discussion thread tidbit into commit message
> v1: https://lore.kernel.org/all/20240803155215.2746444-2-crwulff@gmail.co=
m/
> ---
>  .../ABI/testing/configfs-usb-gadget-uac1      |  8 ++---
>  Documentation/usb/gadget-testing.rst          |  8 ++---
>  drivers/usb/gadget/function/f_uac1.c          | 36 +++++++------------
>  drivers/usb/gadget/function/u_uac1.h          |  8 ++---
>  4 files changed, 18 insertions(+), 42 deletions(-)
>
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uac1 b/Documen=
tation/ABI/testing/configfs-usb-gadget-uac1
> index cf93b98b274d..64188a85592b 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uac1
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uac1
> @@ -33,13 +33,9 @@ Description:
>                 p_it_name               playback input terminal name
>                 p_it_ch_name            playback channels name
>                 p_ot_name               playback output terminal name
> -               p_fu_name               playback functional unit name
> -               p_alt0_name             playback alt mode 0 name
> -               p_alt1_name             playback alt mode 1 name
> +               p_fu_vol_name           playback mute/volume functional u=
nit name
>                 c_it_name               capture input terminal name
>                 c_it_ch_name            capture channels name
>                 c_ot_name               capture output terminal name
> -               c_fu_name               capture functional unit name
> -               c_alt0_name             capture alt mode 0 name
> -               c_alt1_name             capture alt mode 1 name
> +               c_fu_vol_name           capture mute/volume functional un=
it name
>                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gad=
get-testing.rst
> index a89b49e639c3..7a94490fb2fd 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -960,15 +960,11 @@ The uac1 function provides these attributes in its =
function directory:
>         p_it_name        playback input terminal name
>         p_it_ch_name     playback channels name
>         p_ot_name        playback output terminal name
> -       p_fu_name        playback functional unit name
> -       p_alt0_name      playback alt mode 0 name
> -       p_alt1_name      playback alt mode 1 name
> +       p_fu_vol_name    playback mute/volume functional unit name
>         c_it_name        capture input terminal name
>         c_it_ch_name     capture channels name
>         c_ot_name        capture output terminal name
> -       c_fu_name        capture functional unit name
> -       c_alt0_name      capture alt mode 0 name
> -       c_alt1_name      capture alt mode 1 name
> +       c_fu_vol_name    capture mute/volume functional unit name
>         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>  The attributes have sane default values.
> diff --git a/drivers/usb/gadget/function/f_uac1.c b/drivers/usb/gadget/fu=
nction/f_uac1.c
> index 06a220fb7a87..bb36ce2be569 100644
> --- a/drivers/usb/gadget/function/f_uac1.c
> +++ b/drivers/usb/gadget/function/f_uac1.c
> @@ -1254,16 +1254,16 @@ static int f_audio_bind(struct usb_configuration =
*c, struct usb_function *f)
>         strings_uac1[STR_USB_OUT_IT].s =3D audio_opts->p_it_name;
>         strings_uac1[STR_USB_OUT_IT_CH_NAMES].s =3D audio_opts->p_it_ch_n=
ame;
>         strings_uac1[STR_IO_OUT_OT].s =3D audio_opts->p_ot_name;
> -       strings_uac1[STR_FU_OUT].s =3D audio_opts->p_fu_name;
> -       strings_uac1[STR_AS_OUT_IF_ALT0].s =3D audio_opts->p_alt0_name;
> -       strings_uac1[STR_AS_OUT_IF_ALT1].s =3D audio_opts->p_alt1_name;
> +       strings_uac1[STR_FU_OUT].s =3D audio_opts->p_fu_vol_name;
> +       strings_uac1[STR_AS_OUT_IF_ALT0].s =3D "Playback Inactive";
> +       strings_uac1[STR_AS_OUT_IF_ALT1].s =3D "Playback Active";
>
>         strings_uac1[STR_IO_IN_IT].s =3D audio_opts->c_it_name;
>         strings_uac1[STR_IO_IN_IT_CH_NAMES].s =3D audio_opts->c_it_ch_nam=
e;
>         strings_uac1[STR_USB_IN_OT].s =3D audio_opts->c_ot_name;
> -       strings_uac1[STR_FU_IN].s =3D audio_opts->c_fu_name;
> -       strings_uac1[STR_AS_IN_IF_ALT0].s =3D audio_opts->c_alt0_name;
> -       strings_uac1[STR_AS_IN_IF_ALT1].s =3D audio_opts->c_alt1_name;
> +       strings_uac1[STR_FU_IN].s =3D audio_opts->c_fu_vol_name;
> +       strings_uac1[STR_AS_IN_IF_ALT0].s =3D "Capture Inactive";
> +       strings_uac1[STR_AS_IN_IF_ALT1].s =3D "Capture Active";
>
>         us =3D usb_gstrings_attach(cdev, uac1_strings, ARRAY_SIZE(strings=
_uac1));
>         if (IS_ERR(us))
> @@ -1687,16 +1687,12 @@ UAC1_ATTRIBUTE_STRING(function_name);
>  UAC1_ATTRIBUTE_STRING(p_it_name);
>  UAC1_ATTRIBUTE_STRING(p_it_ch_name);
>  UAC1_ATTRIBUTE_STRING(p_ot_name);
> -UAC1_ATTRIBUTE_STRING(p_fu_name);
> -UAC1_ATTRIBUTE_STRING(p_alt0_name);
> -UAC1_ATTRIBUTE_STRING(p_alt1_name);
> +UAC1_ATTRIBUTE_STRING(p_fu_vol_name);
>
>  UAC1_ATTRIBUTE_STRING(c_it_name);
>  UAC1_ATTRIBUTE_STRING(c_it_ch_name);
>  UAC1_ATTRIBUTE_STRING(c_ot_name);
> -UAC1_ATTRIBUTE_STRING(c_fu_name);
> -UAC1_ATTRIBUTE_STRING(c_alt0_name);
> -UAC1_ATTRIBUTE_STRING(c_alt1_name);
> +UAC1_ATTRIBUTE_STRING(c_fu_vol_name);
>
>  static struct configfs_attribute *f_uac1_attrs[] =3D {
>         &f_uac1_opts_attr_c_chmask,
> @@ -1724,16 +1720,12 @@ static struct configfs_attribute *f_uac1_attrs[] =
=3D {
>         &f_uac1_opts_attr_p_it_name,
>         &f_uac1_opts_attr_p_it_ch_name,
>         &f_uac1_opts_attr_p_ot_name,
> -       &f_uac1_opts_attr_p_fu_name,
> -       &f_uac1_opts_attr_p_alt0_name,
> -       &f_uac1_opts_attr_p_alt1_name,
> +       &f_uac1_opts_attr_p_fu_vol_name,
>
>         &f_uac1_opts_attr_c_it_name,
>         &f_uac1_opts_attr_c_it_ch_name,
>         &f_uac1_opts_attr_c_ot_name,
> -       &f_uac1_opts_attr_c_fu_name,
> -       &f_uac1_opts_attr_c_alt0_name,
> -       &f_uac1_opts_attr_c_alt1_name,
> +       &f_uac1_opts_attr_c_fu_vol_name,
>
>         NULL,
>  };
> @@ -1792,16 +1784,12 @@ static struct usb_function_instance *f_audio_allo=
c_inst(void)
>         scnprintf(opts->p_it_name, sizeof(opts->p_it_name), "Playback Inp=
ut terminal");
>         scnprintf(opts->p_it_ch_name, sizeof(opts->p_it_ch_name), "Playba=
ck Channels");
>         scnprintf(opts->p_ot_name, sizeof(opts->p_ot_name), "Playback Out=
put terminal");
> -       scnprintf(opts->p_fu_name, sizeof(opts->p_fu_name), "Playback Vol=
ume");
> -       scnprintf(opts->p_alt0_name, sizeof(opts->p_alt0_name), "Playback=
 Inactive");
> -       scnprintf(opts->p_alt1_name, sizeof(opts->p_alt1_name), "Playback=
 Active");
> +       scnprintf(opts->p_fu_vol_name, sizeof(opts->p_fu_vol_name), "Play=
back Volume");
>
>         scnprintf(opts->c_it_name, sizeof(opts->c_it_name), "Capture Inpu=
t terminal");
>         scnprintf(opts->c_it_ch_name, sizeof(opts->c_it_ch_name), "Captur=
e Channels");
>         scnprintf(opts->c_ot_name, sizeof(opts->c_ot_name), "Capture Outp=
ut terminal");
> -       scnprintf(opts->c_fu_name, sizeof(opts->c_fu_name), "Capture Volu=
me");
> -       scnprintf(opts->c_alt0_name, sizeof(opts->c_alt0_name), "Capture =
Inactive");
> -       scnprintf(opts->c_alt1_name, sizeof(opts->c_alt1_name), "Capture =
Active");
> +       scnprintf(opts->c_fu_vol_name, sizeof(opts->c_fu_vol_name), "Capt=
ure Volume");
>
>         return &opts->func_inst;
>  }
> diff --git a/drivers/usb/gadget/function/u_uac1.h b/drivers/usb/gadget/fu=
nction/u_uac1.h
> index 67784de9782b..feb6eb76462f 100644
> --- a/drivers/usb/gadget/function/u_uac1.h
> +++ b/drivers/usb/gadget/function/u_uac1.h
> @@ -57,16 +57,12 @@ struct f_uac1_opts {
>         char                    p_it_name[USB_MAX_STRING_LEN];
>         char                    p_it_ch_name[USB_MAX_STRING_LEN];
>         char                    p_ot_name[USB_MAX_STRING_LEN];
> -       char                    p_fu_name[USB_MAX_STRING_LEN];
> -       char                    p_alt0_name[USB_MAX_STRING_LEN];
> -       char                    p_alt1_name[USB_MAX_STRING_LEN];
> +       char                    p_fu_vol_name[USB_MAX_STRING_LEN];
>
>         char                    c_it_name[USB_MAX_STRING_LEN];
>         char                    c_it_ch_name[USB_MAX_STRING_LEN];
>         char                    c_ot_name[USB_MAX_STRING_LEN];
> -       char                    c_fu_name[USB_MAX_STRING_LEN];
> -       char                    c_alt0_name[USB_MAX_STRING_LEN];
> -       char                    c_alt1_name[USB_MAX_STRING_LEN];
> +       char                    c_fu_vol_name[USB_MAX_STRING_LEN];
>
>         struct mutex                    lock;
>         int                             refcnt;
> --
> 2.43.0
>

