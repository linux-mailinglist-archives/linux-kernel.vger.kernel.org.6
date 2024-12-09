Return-Path: <linux-kernel+bounces-437913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB19E9A61
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF4028071F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158A1BEF9B;
	Mon,  9 Dec 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LUPINeZ7"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24771233132
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757838; cv=none; b=k+fATxEr8c6l3D4Ei5X6KEJwG2RV6v+KlVLoaXnYAj201u+u5fRGoI0cdID8UALrC87JVGLyNuuzei/tyfJQuCLxXcRMx7tUV+qitynfJexMUw+JJcOuhb9wsHGVXvdZaiKzWOcjrh3GvGRReik8cKFhNPY62o0M5KLD7fTA1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757838; c=relaxed/simple;
	bh=r/WPAh4mTeYj8oNYFuvxsKmn2syxCq4/bcxuN8xuYM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDEoA5WIR+0ceT5G6scyVcBSRkxuevFoYbKy7mcHcu/qrOo+jhR7TqM7fkMNXjqj9TqEpj9V9qpmK2RZAF4DMdw9HhrpNmQJ5T6T7kv2FLg28C8DsvSf+xMvREUCnkEJ6bXrVA3KgtQ42QbZK7GmIHVGaYei1nmfS9qgLaR/KGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LUPINeZ7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725dbdf380aso1323706b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733757836; x=1734362636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hictPQbjZ7rJYwMvs0YJZF1b6NrE66ZOdYqbXNzdf8=;
        b=LUPINeZ7grlzz7lJSYLQ2zRwP6EOqbDQtBpskS8y0Nro0+wl1LblkEp2uTCXKGtGDk
         fogXa23IzqWxAI6aEYDPSiso6yUYDd448oKHySig7s20m6fIAh76TuQKZj734xmteM31
         DTAoaJIkzKUXyl/xCH8076AOvmxS+LjCVNzDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733757836; x=1734362636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hictPQbjZ7rJYwMvs0YJZF1b6NrE66ZOdYqbXNzdf8=;
        b=WEOQKfYE21DmZ2cOm4fEMfzAjuJb1gSztDaAYOBZM3KZK/YgTWaNMN33N6FE6NyUpM
         7hDN2hP7YjUjSR+ypjYch45NXiWFcNVXrUFIpUfAQIOiDYvck7knPkm539VoecGxnEOW
         +vyv/TXbHo4eq21MNYrz79xInqoVoRUTwW9k6Tr5EnOL7CMJl2yKk7Qhez4KwUhqoKWl
         nd7sDH6GEWbhQ8/4UMZ+HEGPZ4SyNWwAd/UFBxeybhq1ObYWDdL/yqOenMC99iwTC8M1
         QdYIJrWmVKVQlespsq008tOJoccZE2C1R1CWmzCsOxwSDP0bwIZcZiua2sVqLJv8Hfmr
         qrEw==
X-Forwarded-Encrypted: i=1; AJvYcCW7OAZKgrheupKB/rW8QL4lPgpHppTeauubdT/4/ry3KwEWDYdIXrHMzkIOzQX72xdONpZsNr1jDHNEgEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7suT0+55njIjAYkzlm3+cBpMj+P+N+MuNiUY7cHBDlsan6D7
	tvLf0fCpAFBxY30VyPtUqogFobUrKMoGglSAtow+RdzulLLylCTlvvhPkN1PkdExK5xrVzfuqGU
	=
X-Gm-Gg: ASbGncuBAAwxBRZWB8T/PBkFJV0FjJxStOBaBJx8wmeiTG5vyoGBFeD66z1Dbi2ROZr
	X38x+hMkmk08/c9f3lZHo/74syHl1r5RJ9k1E6tcnbh1OikaSnLZECN+YmS+6KOHV6ZaGAPJAE5
	j8FrKi1+v/eiyAMdKF5HNn42FDmcMSaRj9tC9w35vYtx+CQ3SaBvs9f3udY4FuuHSWxW5Dfo0gn
	LGdhuZnsgGakXpFZhhonEN64p8Q7x2KLWeoT4P0BsS7/Ex/d8/wGvKVcxHEZNgUrEp4jFgXdIlX
	uaoJzNY5KbavAeaW
X-Google-Smtp-Source: AGHT+IEdM35ELlgtxxHYysS8K6rmlAix3Cn2GuNJAMjpD1FWGE60wcCRm5StfanF6YcUnteEcqMaNg==
X-Received: by 2002:a05:6a00:148a:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-7273cba7a89mr1045956b3a.24.1733757836141;
        Mon, 09 Dec 2024 07:23:56 -0800 (PST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725cf238777sm4328915b3a.47.2024.12.09.07.23.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 07:23:54 -0800 (PST)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ee86a1a92dso3247244a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:23:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBb4LrkrbZ2wsFBL/Ft/MEDUFOo9lrRzhtekwbU1cYmbWdgLg2syewRSMAmm7onU9Le2BN/FWZYkGlbsg=@vger.kernel.org
X-Received: by 2002:a17:90b:53d0:b0:2ee:cd83:8fc3 with SMTP id
 98e67ed59e1d1-2efcf26e5e0mr1430809a91.37.1733757834106; Mon, 09 Dec 2024
 07:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-18-64cfeb56b6f8@chromium.org> <2e90c10a-71fe-4e80-9ac3-80393bc8b266@redhat.com>
In-Reply-To: <2e90c10a-71fe-4e80-9ac3-80393bc8b266@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Dec 2024 16:23:42 +0100
X-Gmail-Original-Message-ID: <CANiDSCvO4DvAHfYpkSi_ZMuV6huk0fTA94-jPafeGrUw+6WoZQ@mail.gmail.com>
X-Gm-Features: AZHOrDnQEn1ubToD_yuupv_yBP9syTygw9yT_eMIETW4cv2VIlCnEuhvX1CMggU
Message-ID: <CANiDSCvO4DvAHfYpkSi_ZMuV6huk0fTA94-jPafeGrUw+6WoZQ@mail.gmail.com>
Subject: Re: [PATCH v15 18/19] media: uvcvideo: implement UVC v1.5 ROI
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans

On Mon, 9 Dec 2024 at 15:22, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> > From: Yunke Cao <yunkec@google.com>
> >
> > Implement support for ROI as described in UVC 1.5:
> > 4.2.2.1.20 Digital Region of Interest (ROI) Control
> >
> > ROI control is implemented using V4L2 control API as
> > two UVC-specific controls:
> > V4L2_CID_UVC_REGION_OF_INTEREST_RECT and
> > V4L2_CID_UVC_REGION_OF_INTEREST_AUTO.
> >
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > Signed-off-by: Yunke Cao <yunkec@google.com>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c   | 81 ++++++++++++++++++++++++++++++=
++++++++
> >  drivers/media/usb/uvc/uvcvideo.h   |  7 ++++
> >  include/uapi/linux/usb/video.h     |  1 +
> >  include/uapi/linux/uvcvideo.h      | 13 ++++++
> >  include/uapi/linux/v4l2-controls.h |  9 +++++
> >  5 files changed, 111 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/u=
vc_ctrl.c
> > index f262e05ad3a8..5b619ef40dd3 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -358,6 +358,24 @@ static const struct uvc_control_info uvc_ctrls[] =
=3D {
> >               .flags          =3D UVC_CTRL_FLAG_GET_CUR
> >                               | UVC_CTRL_FLAG_AUTO_UPDATE,
> >       },
> > +     /*
> > +      * UVC_CTRL_FLAG_AUTO_UPDATE is needed because the RoI may get up=
dated
> > +      * by sensors.
> > +      * "This RoI should be the same as specified in most recent SET_C=
UR
> > +      * except in the case where the =E2=80=98Auto Detect and Track=E2=
=80=99 and/or
> > +      * =E2=80=98Image Stabilization=E2=80=99 bit have been set."
> > +      * 4.2.2.1.20 Digital Region of Interest (ROI) Control
> > +      */
> > +     {
> > +             .entity         =3D UVC_GUID_UVC_CAMERA,
> > +             .selector       =3D UVC_CT_REGION_OF_INTEREST_CONTROL,
> > +             .index          =3D 21,
> > +             .size           =3D 10,
> > +             .flags          =3D UVC_CTRL_FLAG_SET_CUR | UVC_CTRL_FLAG=
_GET_CUR
> > +                             | UVC_CTRL_FLAG_GET_MIN | UVC_CTRL_FLAG_G=
ET_MAX
> > +                             | UVC_CTRL_FLAG_GET_DEF
> > +                             | UVC_CTRL_FLAG_AUTO_UPDATE,
> > +     },
> >  };
> >
> >  static const u32 uvc_control_classes[] =3D {
> > @@ -603,6 +621,44 @@ static const struct uvc_control_mapping *uvc_ctrl_=
filter_plf_mapping(
> >       return out_mapping;
> >  }
> >
> > +static int uvc_get_rect(struct uvc_control_mapping *mapping, u8 query,
> > +                     const void *uvc_in, size_t v4l2_size, void *v4l2_=
out)
> > +{
> > +     const struct uvc_rect *uvc_rect =3D uvc_in;
> > +     struct v4l2_rect *v4l2_rect =3D v4l2_out;
> > +
> > +     if (WARN_ON(v4l2_size !=3D sizeof(struct v4l2_rect)))
> > +             return -EINVAL;
> > +
> > +     if (uvc_rect->left > uvc_rect->right ||
> > +         uvc_rect->top > uvc_rect->bottom)
> > +             return -EIO;
> > +
> > +     v4l2_rect->top =3D uvc_rect->top;
> > +     v4l2_rect->left =3D uvc_rect->left;
> > +     v4l2_rect->height =3D uvc_rect->bottom - uvc_rect->top + 1;
> > +     v4l2_rect->width =3D uvc_rect->right - uvc_rect->left + 1;
> > +
> > +     return 0;
> > +}
> > +
> > +static int uvc_set_rect(struct uvc_control_mapping *mapping, size_t v4=
l2_size,
> > +                     const void *v4l2_in, void *uvc_out)
> > +{
> > +     struct uvc_rect *uvc_rect =3D uvc_out;
> > +     const struct v4l2_rect *v4l2_rect =3D v4l2_in;
> > +
> > +     if (WARN_ON(v4l2_size !=3D sizeof(struct v4l2_rect)))
> > +             return -EINVAL;
> > +
> > +     uvc_rect->top =3D max(0xffff, v4l2_rect->top);
> > +     uvc_rect->left =3D max(0xffff, v4l2_rect->left);
> > +     uvc_rect->bottom =3D max(0xffff, v4l2_rect->height + v4l2_rect->t=
op - 1);
> > +     uvc_rect->right =3D max(0xffff, v4l2_rect->width + v4l2_rect->lef=
t - 1);
>
> As already remarked all 4 lines should be min() not max()
>
> Also this might just be me, but I have a preference for writing top + hei=
ght
> for the bottom rather then writing height + top, since the window starts =
with
> skippig top pixels and then has height pixels filled in. And same for
> calculating rect->width. IOW I have a preference for writing this as:
>
>         uvc_rect->bottom =3D min(0xffff, v4l2_rect->top + v4l2_rect->heig=
ht - 1);
>         uvc_rect->right =3D min(0xffff, v4l2_rect->left + v4l2_rect->widt=
h - 1);
>
> As I said this might just be me, but to me the above reads more naturally=
.
>
>
>
>
> > +
> > +     return 0;
> > +}
> > +
> >  static const struct uvc_control_mapping uvc_ctrl_mappings[] =3D {
> >       {
> >               .id             =3D V4L2_CID_BRIGHTNESS,
> > @@ -897,6 +953,28 @@ static const struct uvc_control_mapping uvc_ctrl_m=
appings[] =3D {
> >               .selector       =3D UVC_PU_POWER_LINE_FREQUENCY_CONTROL,
> >               .filter_mapping =3D uvc_ctrl_filter_plf_mapping,
> >       },
> > +     {
> > +             .id             =3D V4L2_CID_UVC_REGION_OF_INTEREST_RECT,
> > +             .entity         =3D UVC_GUID_UVC_CAMERA,
> > +             .selector       =3D UVC_CT_REGION_OF_INTEREST_CONTROL,
> > +             .size           =3D sizeof(struct uvc_rect) * 8,
> > +             .offset         =3D 0,
> > +             .v4l2_type      =3D V4L2_CTRL_TYPE_RECT,
> > +             .data_type      =3D UVC_CTRL_DATA_TYPE_RECT,
> > +             .get            =3D uvc_get_rect,
> > +             .set            =3D uvc_set_rect,
> > +             .name           =3D "Region Of Interest Rectangle",
> > +     },
> > +     {
> > +             .id             =3D V4L2_CID_UVC_REGION_OF_INTEREST_AUTO,
> > +             .entity         =3D UVC_GUID_UVC_CAMERA,
> > +             .selector       =3D UVC_CT_REGION_OF_INTEREST_CONTROL,
> > +             .size           =3D 16,
> > +             .offset         =3D 64,
> > +             .v4l2_type      =3D V4L2_CTRL_TYPE_BITMASK,
> > +             .data_type      =3D UVC_CTRL_DATA_TYPE_BITMASK,
> > +             .name           =3D "Region Of Interest Auto Controls",
> > +     },
> >  };
> >
> >  /* -------------------------------------------------------------------=
-----
> > @@ -1465,6 +1543,9 @@ static int __uvc_queryctrl_boundaries(struct uvc_=
video_chain *chain,
> >
> >  static size_t uvc_mapping_v4l2_size(struct uvc_control_mapping *mappin=
g)
> >  {
> > +     if (mapping->v4l2_type =3D=3D V4L2_CTRL_TYPE_RECT)
> > +             return sizeof(struct v4l2_rect);
> > +
> >       if (uvc_ctrl_mapping_is_compound(mapping))
> >               return DIV_ROUND_UP(mapping->size, 8);
> >
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/u=
vcvideo.h
> > index 8aca1a2fe587..d910a5e5b514 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -294,6 +294,13 @@ struct uvc_streaming_header {
> >       u8 bTriggerUsage;
> >  };
> >
> > +struct uvc_rect {
> > +     u16 top;
> > +     u16 left;
> > +     u16 bottom;
> > +     u16 right;
> > +} __packed;
> > +
>
> This should probably be grouped togather with uvc_status_* structs which =
are
> also marked __packed because they represent hw API rather then just host
> in memory structures.
>
> >  enum uvc_buffer_state {
> >       UVC_BUF_STATE_IDLE      =3D 0,
> >       UVC_BUF_STATE_QUEUED    =3D 1,
> > diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/vi=
deo.h
> > index 2ff0e8a3a683..2afb4420e6c4 100644
> > --- a/include/uapi/linux/usb/video.h
> > +++ b/include/uapi/linux/usb/video.h
> > @@ -104,6 +104,7 @@
> >  #define UVC_CT_ROLL_ABSOLUTE_CONTROL                 0x0f
> >  #define UVC_CT_ROLL_RELATIVE_CONTROL                 0x10
> >  #define UVC_CT_PRIVACY_CONTROL                               0x11
> > +#define UVC_CT_REGION_OF_INTEREST_CONTROL            0x14
> >
> >  /* A.9.5. Processing Unit Control Selectors */
> >  #define UVC_PU_CONTROL_UNDEFINED                     0x00
> > diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvide=
o.h
> > index f86185456dc5..cbe15bca9569 100644
> > --- a/include/uapi/linux/uvcvideo.h
> > +++ b/include/uapi/linux/uvcvideo.h
> > @@ -16,6 +16,7 @@
> >  #define UVC_CTRL_DATA_TYPE_BOOLEAN   3
> >  #define UVC_CTRL_DATA_TYPE_ENUM              4
> >  #define UVC_CTRL_DATA_TYPE_BITMASK   5
> > +#define UVC_CTRL_DATA_TYPE_RECT              6
> >
> >  /* Control flags */
> >  #define UVC_CTRL_FLAG_SET_CUR                (1 << 0)
> > @@ -38,6 +39,18 @@
> >
> >  #define UVC_MENU_NAME_LEN 32
> >
> > +/* V4L2 driver-specific controls */
> > +#define V4L2_CID_UVC_REGION_OF_INTEREST_RECT (V4L2_CID_USER_UVC_BASE +=
 1)
> > +#define V4L2_CID_UVC_REGION_OF_INTEREST_AUTO (V4L2_CID_USER_UVC_BASE +=
 2)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_EXPOSURE            (1 << 0)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IRIS                        (=
1 << 1)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_WHITE_BALANCE               (=
1 << 2)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FOCUS                       (=
1 << 3)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FACE_DETECT         (1 << 4)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_DETECT_AND_TRACK    (1 << 5)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IMAGE_STABILIZATION (1 << 6)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_HIGHER_QUALITY              (=
1 << 7)
> > +
>
> Hmm, shoudn't these be standardized. At least the ROI rect control seems =
like
> something which could be standardized ?

I believe that back in 2022 we deciced to go with custom controls:
https://lore.kernel.org/linux-media/a0fe2b49-12b7-8eaf-c3ef-7af1a247e595@xs=
4all.nl/

>
> Was using driver specific CIDs for this discussed with Hans Verkuil ?
>
> >  struct uvc_menu_info {
> >       __u32 value;
> >       __u8 name[UVC_MENU_NAME_LEN];
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index 974fd254e573..6c91d6fa4708 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -215,6 +215,13 @@ enum v4l2_colorfx {
> >   */
> >  #define V4L2_CID_USER_THP7312_BASE           (V4L2_CID_USER_BASE + 0x1=
1c0)
> >
> > +/*
> > + * The base for the uvc driver controls.
> > + * See linux/uvcvideo.h for the list of controls.
> > + * We reserve 64 controls for this driver.
> > + */
> > +#define V4L2_CID_USER_UVC_BASE                       (V4L2_CID_USER_BA=
SE + 0x11e0)
> > +
> >  /* MPEG-class control IDs */
> >  /* The MPEG controls are applicable to all codec controls
> >   * and the 'MPEG' part of the define is historical */
> > @@ -1089,6 +1096,8 @@ enum v4l2_auto_focus_range {
> >
> >  #define V4L2_CID_HDR_SENSOR_MODE             (V4L2_CID_CAMERA_CLASS_BA=
SE+36)
> >
> > +/* CAMERA-class private control IDs */
> > +
> >  /* FM Modulator class control IDs */
> >
> >  #define V4L2_CID_FM_TX_CLASS_BASE            (V4L2_CTRL_CLASS_FM_TX | =
0x900)
> >
>
>
> Regards,
>
> Hans
>
>


--=20
Ricardo Ribalda

