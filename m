Return-Path: <linux-kernel+bounces-427130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB9D9DFD0B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB25281D4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058E1FA26C;
	Mon,  2 Dec 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rorjag6q"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D21FA160
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733131589; cv=none; b=hlSDzigUL2yUQwNKwBInUbAfKTt6RErz3V2IUny3QEcixnTZ0Ajj8m3jyMW00C+8EHCNSQ8v/vbomzUmmQoFwg7x1uNk76Aj2N8tQhmnGPSDJt0g1sdJeR+L7d+EbRjCfhdO96sRexaq8M/t85iQv+ZMFLAbXKtrEqYEMGvyE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733131589; c=relaxed/simple;
	bh=r9cYLSmBXLNISePRM6MZyEP6Az5SStlNGJTRxbLVSCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg7zEsOb10Uewjc6FhluGkQbr4lcDR935KNnVq2gh62QoQoD+MtbujRhd/QVMbp9izr4A2qldzCyUKdLWuSsaeHDy8I0WCnsJrBbRjsHr1JkCwFbGkW2us4oEKtqTva/cDyV/qKyuEHjsMr1U2mNk8rQc6in7gLq8hhIoHQYC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rorjag6q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7250c199602so3267641b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733131587; x=1733736387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKScqxNmeJweUdnYkdvjKwl5NOq5sz+lX2p9egBtJis=;
        b=Rorjag6q+xe3tINfkZXSIcTPToYVmffSwYyEX+0OAEoNhjBOlN1A+cYTO4LuCRNdQp
         J1zbE5JwuDseLKGjspeikSgfnDQ8CZlLRrpPg9zKiZwbQ9HE37gqGZQJyDH/K9fhSY/P
         2XUwefsfj9Bf6c7HhY5pddy+ANsTj4jlciZ8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733131587; x=1733736387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKScqxNmeJweUdnYkdvjKwl5NOq5sz+lX2p9egBtJis=;
        b=M2D9/evqK9ui8KXECGV3L+yjsh5uMx0GSQjLGdt9BXxcvOlvUELLLS+vFAxIVQxoE5
         rYLU60xmUKyn+UR5pw7OUoQyYEgriOsj+1Yy27Y22vA9tar6nnL0QObaA5AbnsJdZYgm
         3CdVd2ttP/nE5xaJWIEi4JNA0DIbMGOaZTPza/za2DY4SPMW9tBhBVsnx/krwHRd8vMO
         XNMlnty+HHE6AexZMUqAi0+KjM1w/QDz24zBUvumlGMZCFgA5M+H70w0NO6XfudqPhJH
         PGkcZPS6QgUKXSEKefo9zm1EYmrh6DUBKyL+xMSq6rMoI6mCqClRZmY2TkeJrBhNw+tA
         083Q==
X-Forwarded-Encrypted: i=1; AJvYcCWO6yVNCBy4oZtbrtvhVLUucXiTMRJW15EfwsWMUfIRiKb+P1sB05l9ZZr9YC1JFD4eawEkJ6Ux4KCg4g0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/fth1t09CnCEl2ti9sWJUltRCy3McMO4s9dYa+uneN1Z17eSt
	bIbj5hEN9anJBkc6+DGkFMa31gjvq8IZU8x858X265ZIgSfMWVKWxr4fSmBxwsyTO52511K4F94
	=
X-Gm-Gg: ASbGncvgToSx2zHIBdGrVkW8oYX+UN2KsIIyddC4aiAGxKJAe92cnM5ELjFPMBMN4Zy
	dutiLUanLF5hfz8uemZ8LEMC0zCweOi6hOOQyID1V2QcZjWru1AD26jPL0BPgEno6EbumW5pf0p
	+GtnR1z7EuEtE24NTWxz/lrJqMztRpNd9j+Ng3ByQogyKevXSMtXwlzuAh8/JcjuHtGLpylhAo2
	7POjaACRhMbvBV/A/Ca3/+vIdMEGM/GQA/tOj+mZs/qrJdLdicyt5Es4J01xW/Wh2b/5B3Pre2U
	0bDiUFL1l8QJ
X-Google-Smtp-Source: AGHT+IH5oFQ1NekAR4V4p31RUauq5kWEgjEprlfzadONqPrtlQMAp003gWLWYw4L5fXP0a8nFxWtrw==
X-Received: by 2002:a05:6a00:4f88:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-72530101fb9mr31811223b3a.20.1733131586841;
        Mon, 02 Dec 2024 01:26:26 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbacdsm7997999b3a.95.2024.12.02.01.26.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 01:26:23 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2eed82ca5b4so361592a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:26:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNBQYo+3L1mjSSpMsktxOyTgtMxIM2p3PTtynHjFEdj4hhhhclpzJrccVn7GGR/Qeh2tiR5p0LQodjwBE=@vger.kernel.org
X-Received: by 2002:a17:90b:17d0:b0:2ee:8abd:7254 with SMTP id
 98e67ed59e1d1-2ee8abd742amr9556792a91.36.1733131582873; Mon, 02 Dec 2024
 01:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-18-64cfeb56b6f8@chromium.org> <CANqU6Fdu2dg+1RADfOFG=3M6sLDgMuQZJMv1Vb46pnhLbR1ttA@mail.gmail.com>
In-Reply-To: <CANqU6Fdu2dg+1RADfOFG=3M6sLDgMuQZJMv1Vb46pnhLbR1ttA@mail.gmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 2 Dec 2024 10:26:10 +0100
X-Gmail-Original-Message-ID: <CANiDSCtQXrgRx-uoSMynN8Os0TA_FFY8zDwnharyzP-cXSjVKA@mail.gmail.com>
Message-ID: <CANiDSCtQXrgRx-uoSMynN8Os0TA_FFY8zDwnharyzP-cXSjVKA@mail.gmail.com>
Subject: Re: [PATCH v15 18/19] media: uvcvideo: implement UVC v1.5 ROI
To: Yunke Cao <yunkec@google.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ricardo Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Dec 2024 at 09:02, Yunke Cao <yunkec@google.com> wrote:
>
> Hi Ricardo,
>
> Thanks for the new version!!
>
> On Fri, Nov 15, 2024 at 4:11=E2=80=AFAM Ricardo Ribalda <ribalda@chromium=
.org> wrote:
> >
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
> >                 .flags          =3D UVC_CTRL_FLAG_GET_CUR
> >                                 | UVC_CTRL_FLAG_AUTO_UPDATE,
> >         },
> > +       /*
> > +        * UVC_CTRL_FLAG_AUTO_UPDATE is needed because the RoI may get =
updated
> > +        * by sensors.
> > +        * "This RoI should be the same as specified in most recent SET=
_CUR
> > +        * except in the case where the =E2=80=98Auto Detect and Track=
=E2=80=99 and/or
> > +        * =E2=80=98Image Stabilization=E2=80=99 bit have been set."
> > +        * 4.2.2.1.20 Digital Region of Interest (ROI) Control
> > +        */
> > +       {
> > +               .entity         =3D UVC_GUID_UVC_CAMERA,
> > +               .selector       =3D UVC_CT_REGION_OF_INTEREST_CONTROL,
> > +               .index          =3D 21,
> > +               .size           =3D 10,
> > +               .flags          =3D UVC_CTRL_FLAG_SET_CUR | UVC_CTRL_FL=
AG_GET_CUR
> > +                               | UVC_CTRL_FLAG_GET_MIN | UVC_CTRL_FLAG=
_GET_MAX
> > +                               | UVC_CTRL_FLAG_GET_DEF
> > +                               | UVC_CTRL_FLAG_AUTO_UPDATE,
> > +       },
> >  };
> >
> >  static const u32 uvc_control_classes[] =3D {
> > @@ -603,6 +621,44 @@ static const struct uvc_control_mapping *uvc_ctrl_=
filter_plf_mapping(
> >         return out_mapping;
> >  }
> >
> > +static int uvc_get_rect(struct uvc_control_mapping *mapping, u8 query,
> > +                       const void *uvc_in, size_t v4l2_size, void *v4l=
2_out)
> > +{
> > +       const struct uvc_rect *uvc_rect =3D uvc_in;
> > +       struct v4l2_rect *v4l2_rect =3D v4l2_out;
> > +
> > +       if (WARN_ON(v4l2_size !=3D sizeof(struct v4l2_rect)))
> > +               return -EINVAL;
> > +
> > +       if (uvc_rect->left > uvc_rect->right ||
> > +           uvc_rect->top > uvc_rect->bottom)
> > +               return -EIO;
> > +
> > +       v4l2_rect->top =3D uvc_rect->top;
> > +       v4l2_rect->left =3D uvc_rect->left;
> > +       v4l2_rect->height =3D uvc_rect->bottom - uvc_rect->top + 1;
> > +       v4l2_rect->width =3D uvc_rect->right - uvc_rect->left + 1;
> > +
> > +       return 0;
> > +}
> > +
> > +static int uvc_set_rect(struct uvc_control_mapping *mapping, size_t v4=
l2_size,
> > +                       const void *v4l2_in, void *uvc_out)
> > +{
> > +       struct uvc_rect *uvc_rect =3D uvc_out;
> > +       const struct v4l2_rect *v4l2_rect =3D v4l2_in;
> > +
> > +       if (WARN_ON(v4l2_size !=3D sizeof(struct v4l2_rect)))
> > +               return -EINVAL;
> > +
> > +       uvc_rect->top =3D max(0xffff, v4l2_rect->top);
> > +       uvc_rect->left =3D max(0xffff, v4l2_rect->left);
> > +       uvc_rect->bottom =3D max(0xffff, v4l2_rect->height + v4l2_rect-=
>top - 1);
> > +       uvc_rect->right =3D max(0xffff, v4l2_rect->width + v4l2_rect->l=
eft - 1);
>
> Should these be min()?

Ups :).

Fixed in the next version.

Thanks!

>
> >
> > +
> > +       return 0;
> > +}
> > +
> >  static const struct uvc_control_mapping uvc_ctrl_mappings[] =3D {
> >         {
> >                 .id             =3D V4L2_CID_BRIGHTNESS,
> > @@ -897,6 +953,28 @@ static const struct uvc_control_mapping uvc_ctrl_m=
appings[] =3D {
> >                 .selector       =3D UVC_PU_POWER_LINE_FREQUENCY_CONTROL=
,
> >                 .filter_mapping =3D uvc_ctrl_filter_plf_mapping,
> >         },
> > +       {
> > +               .id             =3D V4L2_CID_UVC_REGION_OF_INTEREST_REC=
T,
> > +               .entity         =3D UVC_GUID_UVC_CAMERA,
> > +               .selector       =3D UVC_CT_REGION_OF_INTEREST_CONTROL,
> > +               .size           =3D sizeof(struct uvc_rect) * 8,
> > +               .offset         =3D 0,
> > +               .v4l2_type      =3D V4L2_CTRL_TYPE_RECT,
> > +               .data_type      =3D UVC_CTRL_DATA_TYPE_RECT,
> > +               .get            =3D uvc_get_rect,
> > +               .set            =3D uvc_set_rect,
> > +               .name           =3D "Region Of Interest Rectangle",
> > +       },
> > +       {
> > +               .id             =3D V4L2_CID_UVC_REGION_OF_INTEREST_AUT=
O,
> > +               .entity         =3D UVC_GUID_UVC_CAMERA,
> > +               .selector       =3D UVC_CT_REGION_OF_INTEREST_CONTROL,
> > +               .size           =3D 16,
> > +               .offset         =3D 64,
> > +               .v4l2_type      =3D V4L2_CTRL_TYPE_BITMASK,
> > +               .data_type      =3D UVC_CTRL_DATA_TYPE_BITMASK,
> > +               .name           =3D "Region Of Interest Auto Controls",
> > +       },
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
> > +       if (mapping->v4l2_type =3D=3D V4L2_CTRL_TYPE_RECT)
> > +               return sizeof(struct v4l2_rect);
> > +
> >         if (uvc_ctrl_mapping_is_compound(mapping))
> >                 return DIV_ROUND_UP(mapping->size, 8);
> >
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/u=
vcvideo.h
> > index 8aca1a2fe587..d910a5e5b514 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -294,6 +294,13 @@ struct uvc_streaming_header {
> >         u8 bTriggerUsage;
> >  };
> >
> > +struct uvc_rect {
> > +       u16 top;
> > +       u16 left;
> > +       u16 bottom;
> > +       u16 right;
> > +} __packed;
> > +
> >  enum uvc_buffer_state {
> >         UVC_BUF_STATE_IDLE      =3D 0,
> >         UVC_BUF_STATE_QUEUED    =3D 1,
> > diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/vi=
deo.h
> > index 2ff0e8a3a683..2afb4420e6c4 100644
> > --- a/include/uapi/linux/usb/video.h
> > +++ b/include/uapi/linux/usb/video.h
> > @@ -104,6 +104,7 @@
> >  #define UVC_CT_ROLL_ABSOLUTE_CONTROL                   0x0f
> >  #define UVC_CT_ROLL_RELATIVE_CONTROL                   0x10
> >  #define UVC_CT_PRIVACY_CONTROL                         0x11
> > +#define UVC_CT_REGION_OF_INTEREST_CONTROL              0x14
> >
> >  /* A.9.5. Processing Unit Control Selectors */
> >  #define UVC_PU_CONTROL_UNDEFINED                       0x00
> > diff --git a/include/uapi/linux/uvcvideo.h b/include/uapi/linux/uvcvide=
o.h
> > index f86185456dc5..cbe15bca9569 100644
> > --- a/include/uapi/linux/uvcvideo.h
> > +++ b/include/uapi/linux/uvcvideo.h
> > @@ -16,6 +16,7 @@
> >  #define UVC_CTRL_DATA_TYPE_BOOLEAN     3
> >  #define UVC_CTRL_DATA_TYPE_ENUM                4
> >  #define UVC_CTRL_DATA_TYPE_BITMASK     5
> > +#define UVC_CTRL_DATA_TYPE_RECT                6
> >
> >  /* Control flags */
> >  #define UVC_CTRL_FLAG_SET_CUR          (1 << 0)
> > @@ -38,6 +39,18 @@
> >
> >  #define UVC_MENU_NAME_LEN 32
> >
> > +/* V4L2 driver-specific controls */
> > +#define V4L2_CID_UVC_REGION_OF_INTEREST_RECT   (V4L2_CID_USER_UVC_BASE=
 + 1)
> > +#define V4L2_CID_UVC_REGION_OF_INTEREST_AUTO   (V4L2_CID_USER_UVC_BASE=
 + 2)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_EXPOSURE              (1 << 0=
)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IRIS                  (1 << 1=
)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_WHITE_BALANCE         (1 << 2=
)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FOCUS                 (1 << 3=
)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_FACE_DETECT           (1 << 4=
)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_DETECT_AND_TRACK      (1 << 5=
)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_IMAGE_STABILIZATION   (1 << 6=
)
> > +#define V4L2_UVC_REGION_OF_INTEREST_AUTO_HIGHER_QUALITY               =
 (1 << 7)
> > +
> >  struct uvc_menu_info {
> >         __u32 value;
> >         __u8 name[UVC_MENU_NAME_LEN];
> > diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4=
l2-controls.h
> > index 974fd254e573..6c91d6fa4708 100644
> > --- a/include/uapi/linux/v4l2-controls.h
> > +++ b/include/uapi/linux/v4l2-controls.h
> > @@ -215,6 +215,13 @@ enum v4l2_colorfx {
> >   */
> >  #define V4L2_CID_USER_THP7312_BASE             (V4L2_CID_USER_BASE + 0=
x11c0)
> >
> > +/*
> > + * The base for the uvc driver controls.
> > + * See linux/uvcvideo.h for the list of controls.
> > + * We reserve 64 controls for this driver.
> > + */
> > +#define V4L2_CID_USER_UVC_BASE                 (V4L2_CID_USER_BASE + 0=
x11e0)
> > +
> >  /* MPEG-class control IDs */
> >  /* The MPEG controls are applicable to all codec controls
> >   * and the 'MPEG' part of the define is historical */
> > @@ -1089,6 +1096,8 @@ enum v4l2_auto_focus_range {
> >
> >  #define V4L2_CID_HDR_SENSOR_MODE               (V4L2_CID_CAMERA_CLASS_=
BASE+36)
> >
> > +/* CAMERA-class private control IDs */
> > +
>
> Do we still need this comment?
>
> Best,
> Yunke
>
> >  /* FM Modulator class control IDs */
> >
> >  #define V4L2_CID_FM_TX_CLASS_BASE              (V4L2_CTRL_CLASS_FM_TX =
| 0x900)
> >
> > --
> > 2.47.0.338.g60cca15819-goog
> >



--=20
Ricardo Ribalda

