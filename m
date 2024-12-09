Return-Path: <linux-kernel+bounces-436999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA59E8DD3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7AC161ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB43215711;
	Mon,  9 Dec 2024 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CDSUwvFY"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432821519C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734245; cv=none; b=jPo28mjkn5OrrimoUOS4/IDwNCg0r61fJ4UsD60oU6mEMyapUNDxHER4OLfvdN+I1WjrXOBYSZn2TaRqrs9pi0gk0p+bPBSHNMrsqwdtzw7fY29etjAfl7S4usr3hqGs3NJ25jkpB7CFbgC06jxIk8iecwJQEgV0KEBr0fUnjXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734245; c=relaxed/simple;
	bh=0CnSKW5mh5z1zK8Fctao7D+gl7B3VqHqOZ2nJ7WPLkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/y2aWWNqVca+lHS9it0fNdvbczjgEGmXEspydQ0GYVgylr1irNvHy6RK8bZmomnHg3wzumC2fU6LaM9fy52FEu8xYWERaXLUGqzLUbd0T4bE2/qrLmMxwf/lKo8e1lwU3lgHjsH7BMS+eAwwcWsMDkje7Buvi1F2hauMCWQxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CDSUwvFY; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef66fd2183so36668607b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733734242; x=1734339042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqYIk8AFpShAW12PLaEd8+eoNby3AuBsY18Mk1gxdF0=;
        b=CDSUwvFY+v/6kv2NIMeP7LbBeZM/zEhrv4zpb5nRdUxydKzq13f7UVNE3HQdfhQaAF
         irYGauZfybGBzvrDKZ7LiCAAOOOofjpSC0wdIMxKGFyNZ1FubTC4NsRlVXN2+oo+siTm
         lIiOu68Lx9t2h7NRYn8Olvf0gvioMvCZvo1zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734242; x=1734339042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqYIk8AFpShAW12PLaEd8+eoNby3AuBsY18Mk1gxdF0=;
        b=P3betkM+L51XOF8gjmTM8cSaoKl6jB7KZqx59rLXaFZ9VVd3UP9fJyOUolbaXVTSIH
         WveyJLorY81o/sJJ32gP/PLbrAw+ERowU4sn2AIuca3MB91SJ8+L5hFtJV4Hoq3SuEdM
         5tlKNJWGS/OQbpAhHHo5NskX+0mqTGrmDsPis174K5TdAa+YC8xrI/4vpcONw5Oa0rd5
         HRnFaLhFHbJcTzDWyWdwUl6ZXl0NocOpRAPpUfYuO6iO0GF1Lsw34KHUHo+kS6Atillq
         Mvdnc2JXJNGLUC9PDEfFApqgUiaTOGSNeIGedV73Vd1BAWwioF0tm2VQYwe3XD4ima2T
         vYQw==
X-Forwarded-Encrypted: i=1; AJvYcCVHNkXs4TnGpsw08/veL20WOFYWxNaTPxEky/zbSV2vd93vMBFdDoNPB6zPuY2WiMaU5Lgsl5v9+KWx/zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDMXhdU3Os1LKriVadVCnLCIhmod9kTsEKH4gEPrwYykKeInP
	fCQopcHHSFtARkk2dOE/UMeKW1ELaigifmxhKI7ETXRUigKd2NWoeJpLTJ5XVWmnwPoCU0OJTUa
	rIONG0sI1pFgz45mpgueMN9ZH4rWb/PMZhEGI
X-Gm-Gg: ASbGncu87eRl6dtnD4hpF7XQ2qNhep2BTI+BhGRFIxxqxUVcoLYJOPgLvaeWP9yE3Vp
	PapP4SjNJWEo5B6j1dk0tIW7We07sbms=
X-Google-Smtp-Source: AGHT+IHC1UoQ/MOloCs3wI065OcljyeG2uL/5Z1iWZY7OrxiZ/U4OR3SzAyanwZ0VoVzI8OUyhxFW3airjRUOcsV5HI=
X-Received: by 2002:a05:690c:9b01:b0:6e2:1527:446b with SMTP id
 00721157ae682-6efe3bcf5eemr125496137b3.3.1733734242272; Mon, 09 Dec 2024
 00:50:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org> <20241114-uvc-roi-v15-12-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-12-64cfeb56b6f8@chromium.org>
From: Yunke Cao <yunkec@chromium.org>
Date: Mon, 9 Dec 2024 17:50:31 +0900
Message-ID: <CAEDqmY7+sCpa30cEqoiWN91YBiOxMtfym=8pcc-ODBrfvN+C1Q@mail.gmail.com>
Subject: Re: [PATCH v15 12/19] media: uvcvideo: Factor out query_boundaries
 from query_ctrl
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ricardo Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

This patch looks good to me.

Reviewed-by: Yunke Cao <yunkec@google.com>

Thanks,
Yunke

On Fri, Nov 15, 2024 at 4:10=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> Split the function in two parts. queryctrl_boundaries will be used in
> future patches.
>
> No functional change expected from this patch.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 106 ++++++++++++++++++++++-----------=
------
>  1 file changed, 60 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc=
_ctrl.c
> index e51cd0a2228a..b591d7fddc37 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1367,53 +1367,11 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control=
 *ctrl,
>         return ~0;
>  }
>
> -static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> -       struct uvc_control *ctrl,
> -       struct uvc_control_mapping *mapping,
> -       struct v4l2_queryctrl *v4l2_ctrl)
> +static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
> +                                     struct uvc_control *ctrl,
> +                                     struct uvc_control_mapping *mapping=
,
> +                                     struct v4l2_queryctrl *v4l2_ctrl)
>  {
> -       struct uvc_control_mapping *master_map =3D NULL;
> -       struct uvc_control *master_ctrl =3D NULL;
> -
> -       memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
> -       v4l2_ctrl->id =3D mapping->id;
> -       v4l2_ctrl->type =3D mapping->v4l2_type;
> -       strscpy(v4l2_ctrl->name, uvc_map_get_name(mapping),
> -               sizeof(v4l2_ctrl->name));
> -       v4l2_ctrl->flags =3D 0;
> -
> -       if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> -               v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> -       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> -               v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_READ_ONLY;
> -
> -       if (mapping->master_id)
> -               __uvc_find_control(ctrl->entity, mapping->master_id,
> -                                  &master_map, &master_ctrl, 0, 0);
> -       if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_C=
UR)) {
> -               s32 val;
> -               int ret;
> -
> -               if (WARN_ON(uvc_ctrl_mapping_is_compound(master_map)))
> -                       return -EIO;
> -
> -               ret =3D __uvc_ctrl_get(chain, master_ctrl, master_map, &v=
al);
> -               if (ret < 0)
> -                       return ret;
> -
> -               if (val !=3D mapping->master_manual)
> -                               v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_INAC=
TIVE;
> -       }
> -
> -       if (v4l2_ctrl->type >=3D V4L2_CTRL_COMPOUND_TYPES) {
> -               v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_HAS_PAYLOAD;
> -               v4l2_ctrl->default_value =3D 0;
> -               v4l2_ctrl->minimum =3D 0;
> -               v4l2_ctrl->maximum =3D 0;
> -               v4l2_ctrl->step =3D 0;
> -               return 0;
> -       }
> -
>         if (!ctrl->cached) {
>                 int ret =3D uvc_ctrl_populate_cache(chain, ctrl);
>                 if (ret < 0)
> @@ -1456,18 +1414,74 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video=
_chain *chain,
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
>                 v4l2_ctrl->minimum =3D uvc_mapping_get_s32(mapping, UVC_G=
ET_MIN,
>                                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> +       else
> +               v4l2_ctrl->minimum =3D 0;
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
>                 v4l2_ctrl->maximum =3D uvc_mapping_get_s32(mapping, UVC_G=
ET_MAX,
>                                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +       else
> +               v4l2_ctrl->maximum =3D 0;
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
>                 v4l2_ctrl->step =3D uvc_mapping_get_s32(mapping, UVC_GET_=
RES,
>                                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> +       else
> +               v4l2_ctrl->step =3D 0;
>
>         return 0;
>  }
>
> +static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> +                                struct uvc_control *ctrl,
> +                                struct uvc_control_mapping *mapping,
> +                                struct v4l2_queryctrl *v4l2_ctrl)
> +{
> +       struct uvc_control_mapping *master_map =3D NULL;
> +       struct uvc_control *master_ctrl =3D NULL;
> +
> +       memset(v4l2_ctrl, 0, sizeof(*v4l2_ctrl));
> +       v4l2_ctrl->id =3D mapping->id;
> +       v4l2_ctrl->type =3D mapping->v4l2_type;
> +       strscpy(v4l2_ctrl->name, uvc_map_get_name(mapping),
> +               sizeof(v4l2_ctrl->name));
> +       v4l2_ctrl->flags =3D 0;
> +
> +       if (!(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> +               v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_WRITE_ONLY;
> +       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> +               v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_READ_ONLY;
> +
> +       if (mapping->master_id)
> +               __uvc_find_control(ctrl->entity, mapping->master_id,
> +                                  &master_map, &master_ctrl, 0, 0);
> +       if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_C=
UR)) {
> +               s32 val;
> +               int ret;
> +
> +               if (WARN_ON(uvc_ctrl_mapping_is_compound(master_map)))
> +                       return -EIO;
> +
> +               ret =3D __uvc_ctrl_get(chain, master_ctrl, master_map, &v=
al);
> +               if (ret < 0)
> +                       return ret;
> +
> +               if (val !=3D mapping->master_manual)
> +                       v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_INACTIVE;
> +       }
> +
> +       if (v4l2_ctrl->type >=3D V4L2_CTRL_COMPOUND_TYPES) {
> +               v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_HAS_PAYLOAD;
> +               v4l2_ctrl->default_value =3D 0;
> +               v4l2_ctrl->minimum =3D 0;
> +               v4l2_ctrl->maximum =3D 0;
> +               v4l2_ctrl->step =3D 0;
> +               return 0;
> +       }
> +
> +       return __uvc_queryctrl_boundaries(chain, ctrl, mapping, v4l2_ctrl=
);
> +}
> +
>  int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>         struct v4l2_queryctrl *v4l2_ctrl)
>  {
>
> --
> 2.47.0.338.g60cca15819-goog
>

