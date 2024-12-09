Return-Path: <linux-kernel+bounces-437000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A4A9E8DD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985BD1885A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03417215714;
	Mon,  9 Dec 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LiOqzItb"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3862156EA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734273; cv=none; b=ukiYb/uKFvStEVZMDMpV4s7KcATPs/R11Th7b+erydkKJ87VQLhbApMMW2UCMerOgY63eTS1tXyrIJ/5yYZ7nJwm9V7+ln0l/d8vk/uybxWoqtwagTyOV8q/XlgJaMQ/t0Ja7xmudQgCep15w2S1b8/vw8zLaP9bK5UWb2m0wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734273; c=relaxed/simple;
	bh=IZ8TNQx115YZjDiFvZz+KZVY0KhjteJAHCDNpTdm59w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSHzh1GB8RxpfWj7AfOhzLJutUARex5aRkUV+lCxsDpV6FPqDR1qEWfv0CDJ/9/U6CR7kYFNL6ulWLWHQBGelnju+DCF7Uqx0zdq9ZT7Oi4zucTCmWcgtjc5nipwfxHH583/sqbyXbGvDT2sENu+iL4EyDJMdg04Xxy34LFsYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LiOqzItb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6efa1e49ef0so41233737b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733734270; x=1734339070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzl+agxdMg/fk7KqOoxkegzdlvsNwATlU9E73Ir35Uc=;
        b=LiOqzItbgWUWR2EffzRYPtO49ZGP+8hV7PHvJGWiZ54ZIcQHIQY6jVGoGKcS05vv73
         t1bcjmIeBuXTfhpmf+MLJjwvFxfkRsGDW1DAHVgaiXtaLQTZnZ0Pg0aK7a57FZHoFIza
         7WiwJf5KKa01KMrV29oUmXxMKfilmRKcACWW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734270; x=1734339070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzl+agxdMg/fk7KqOoxkegzdlvsNwATlU9E73Ir35Uc=;
        b=kJFwnVAcjy0ukK3mLdnw/1AdTtcUBKAt7wj0OZmWyw5DQjuRTZd9QdH5hnw4ncmOMZ
         WerDmPbEu+HwQqa3M9r7n1iIBuW0+seqYFYZeDr9anAgZwfSbt/L7syWFrItFzCEekpp
         1KKy85y2AHRfz6h/voVUF8k4QDHLl6cUq3nXIXOgo6rokUhFcSqKpp+Ekl/HQDjxzaKX
         kqxU37FyRZUDOvPYQvvMlTWxD1rjODzGByl8unbuuMMB0vEMVoJju1MI5iaYDc+YQjNx
         q8MgUlduhu+95on6i4BNza3BFh4w/6lclZ+HLKOKxxjXny07MdVUvQt8GV01y7rbhlDL
         FeZg==
X-Forwarded-Encrypted: i=1; AJvYcCVzIUtj9ICYs97v/exGHxjrvWdBIh8JfLFLnNVJCmindz4toT4XUM0e+RkIw+JNCu/HRaZ8DUuQaF/QrD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQTwudBFzR+SRob07il22fYlKMo+vsxrFVBiw4WfizKR8UKS7
	sbal93DSwoZMFZ5sVpFkFYnTlU8knm7qUg57yBm0iyqR5gP8nXUCGgIGe5K5G0xI68EQnwpb+aF
	qVr6CuvcTceyW09bLz0hI8CMwecatQpcmqMPG
X-Gm-Gg: ASbGnctAc4cemr50LIG0SZcclgbqzVdQnqiaDkShFbnswwFnSxmHhcePjhYsuFOG5N+
	mOevl8Qi6DefaVfmSR4UY9x19J8V1L6o=
X-Google-Smtp-Source: AGHT+IGBrSS0ksF1bzMvsSnWHPwgJkSajo6uO8fM8MWWhPPIP7Kz1aeGg8rOoFOb0E6ssQgwXTAACpeoEMKt3Ir+W7c=
X-Received: by 2002:a05:690c:708f:b0:6ef:6ba2:e84d with SMTP id
 00721157ae682-6efe3bfafedmr103449647b3.17.1733734270450; Mon, 09 Dec 2024
 00:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org> <20241114-uvc-roi-v15-15-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-15-64cfeb56b6f8@chromium.org>
From: Yunke Cao <yunkec@chromium.org>
Date: Mon, 9 Dec 2024 17:50:59 +0900
Message-ID: <CAEDqmY6Do8n=sdn8N=4Oc8cJwtQWUHMxxX37dgCv6GZDEgZy7A@mail.gmail.com>
Subject: Re: [PATCH v15 15/19] media: uvcvideo: let v4l2_query_v4l2_ctrl()
 work with v4l2_query_ext_ctrl
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

On Fri, Nov 15, 2024 at 4:11=E2=80=AFAM Ricardo Ribalda <ribalda@chromium.o=
rg> wrote:
>
> v4l2_query_ext_ctrl contains information that is missing in
> v4l2_queryctrl, like elem_size and elems.
>
> With this change we can handle all the element_size information inside
> uvc_ctrl.c.
>
> Now that we are at it, remove the memset of the reserved fields, the
> v4l2 ioctl handler should do that for us.
>
> There is no functional change expected from this change.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 24 ++++++++++++++----------
>  drivers/media/usb/uvc/uvc_v4l2.c | 35 +++++++++++++++-------------------=
-
>  drivers/media/usb/uvc/uvcvideo.h |  2 +-
>  3 files changed, 30 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc=
_ctrl.c
> index 72ed7dc9cfc1..1bc019138995 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1252,7 +1252,8 @@ static int __uvc_query_v4l2_class(struct uvc_video_=
chain *chain, u32 req_id,
>  }
>
>  static int uvc_query_v4l2_class(struct uvc_video_chain *chain, u32 req_i=
d,
> -                               u32 found_id, struct v4l2_queryctrl *v4l2=
_ctrl)
> +                               u32 found_id,
> +                               struct v4l2_query_ext_ctrl *v4l2_ctrl)
>  {
>         int idx;
>
> @@ -1400,7 +1401,7 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *=
ctrl,
>  static int __uvc_queryctrl_boundaries(struct uvc_video_chain *chain,
>                                       struct uvc_control *ctrl,
>                                       struct uvc_control_mapping *mapping=
,
> -                                     struct v4l2_queryctrl *v4l2_ctrl)
> +                                     struct v4l2_query_ext_ctrl *v4l2_ct=
rl)
>  {
>         if (!ctrl->cached) {
>                 int ret =3D uvc_ctrl_populate_cache(chain, ctrl);
> @@ -1465,7 +1466,7 @@ static int __uvc_queryctrl_boundaries(struct uvc_vi=
deo_chain *chain,
>  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                                  struct uvc_control *ctrl,
>                                  struct uvc_control_mapping *mapping,
> -                                struct v4l2_queryctrl *v4l2_ctrl)
> +                                struct v4l2_query_ext_ctrl *v4l2_ctrl)
>  {
>         struct uvc_control_mapping *master_map =3D NULL;
>         struct uvc_control *master_ctrl =3D NULL;
> @@ -1503,6 +1504,9 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_c=
hain *chain,
>                         v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_INACTIVE;
>         }
>
> +       v4l2_ctrl->elem_size =3D sizeof(s32);
> +       v4l2_ctrl->elems =3D 1;
> +
>         if (v4l2_ctrl->type >=3D V4L2_CTRL_COMPOUND_TYPES) {
>                 v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_HAS_PAYLOAD;
>                 v4l2_ctrl->default_value =3D 0;
> @@ -1516,7 +1520,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_c=
hain *chain,
>  }
>
>  int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> -       struct v4l2_queryctrl *v4l2_ctrl)
> +                       struct v4l2_query_ext_ctrl *v4l2_ctrl)
>  {
>         struct uvc_control *ctrl;
>         struct uvc_control_mapping *mapping;
> @@ -1642,7 +1646,7 @@ static void uvc_ctrl_fill_event(struct uvc_video_ch=
ain *chain,
>         struct uvc_control_mapping *mapping,
>         s32 value, u32 changes)
>  {
> -       struct v4l2_queryctrl v4l2_ctrl;
> +       struct v4l2_query_ext_ctrl v4l2_ctrl;
>
>         __uvc_query_v4l2_ctrl(chain, ctrl, mapping, &v4l2_ctrl);
>
> @@ -2119,7 +2123,7 @@ static int uvc_mapping_get_xctrl_std(struct uvc_vid=
eo_chain *chain,
>                                      struct uvc_control_mapping *mapping,
>                                      u32 which, struct v4l2_ext_control *=
xctrl)
>  {
> -       struct v4l2_queryctrl qc;
> +       struct v4l2_query_ext_ctrl qec;
>         int ret;
>
>         switch (which) {
> @@ -2133,19 +2137,19 @@ static int uvc_mapping_get_xctrl_std(struct uvc_v=
ideo_chain *chain,
>                 return -EINVAL;
>         }
>
> -       ret =3D __uvc_queryctrl_boundaries(chain, ctrl, mapping, &qc);
> +       ret =3D __uvc_queryctrl_boundaries(chain, ctrl, mapping, &qec);
>         if (ret < 0)
>                 return ret;
>
>         switch (which) {
>         case V4L2_CTRL_WHICH_DEF_VAL:
> -               xctrl->value =3D qc.default_value;
> +               xctrl->value =3D qec.default_value;
>                 break;
>         case V4L2_CTRL_WHICH_MIN_VAL:
> -               xctrl->value =3D qc.minimum;
> +               xctrl->value =3D qec.minimum;
>                 break;
>         case V4L2_CTRL_WHICH_MAX_VAL:
> -               xctrl->value =3D qc.maximum;
> +               xctrl->value =3D qec.maximum;
>                 break;
>         }
>
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc=
_v4l2.c
> index 7e284770149d..5000c74271e0 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1014,40 +1014,35 @@ static int uvc_ioctl_s_input(struct file *file, v=
oid *fh, unsigned int input)
>         return ret;
>  }
>
> -static int uvc_ioctl_queryctrl(struct file *file, void *fh,
> -                              struct v4l2_queryctrl *qc)
> +static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> +                                   struct v4l2_query_ext_ctrl *qec)
>  {
>         struct uvc_fh *handle =3D fh;
>         struct uvc_video_chain *chain =3D handle->chain;
>
> -       return uvc_query_v4l2_ctrl(chain, qc);
> +       return uvc_query_v4l2_ctrl(chain, qec);
>  }
>
> -static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
> -                                   struct v4l2_query_ext_ctrl *qec)
> +static int uvc_ioctl_queryctrl(struct file *file, void *fh,
> +                              struct v4l2_queryctrl *qc)
>  {
>         struct uvc_fh *handle =3D fh;
>         struct uvc_video_chain *chain =3D handle->chain;
> -       struct v4l2_queryctrl qc =3D { qec->id };
> +       struct v4l2_query_ext_ctrl qec =3D { qc->id };
>         int ret;
>
> -       ret =3D uvc_query_v4l2_ctrl(chain, &qc);
> +       ret =3D uvc_query_v4l2_ctrl(chain, &qec);
>         if (ret)
>                 return ret;
>
> -       qec->id =3D qc.id;
> -       qec->type =3D qc.type;
> -       strscpy(qec->name, qc.name, sizeof(qec->name));
> -       qec->minimum =3D qc.minimum;
> -       qec->maximum =3D qc.maximum;
> -       qec->step =3D qc.step;
> -       qec->default_value =3D qc.default_value;
> -       qec->flags =3D qc.flags;
> -       qec->elem_size =3D 4;
> -       qec->elems =3D 1;
> -       qec->nr_of_dims =3D 0;
> -       memset(qec->dims, 0, sizeof(qec->dims));
> -       memset(qec->reserved, 0, sizeof(qec->reserved));
> +       qc->id =3D qec.id;
> +       qc->type =3D qec.type;
> +       strscpy(qc->name, qec.name, sizeof(qc->name));
> +       qc->minimum =3D qec.minimum;
> +       qc->maximum =3D qec.maximum;
> +       qc->step =3D qec.step;
> +       qc->default_value =3D qec.default_value;
> +       qc->flags =3D qec.flags;
>
>         return 0;
>  }
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvc=
video.h
> index f429f325433b..8aca1a2fe587 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -766,7 +766,7 @@ void uvc_status_put(struct uvc_device *dev);
>  extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
>
>  int uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> -                       struct v4l2_queryctrl *v4l2_ctrl);
> +                       struct v4l2_query_ext_ctrl *v4l2_ctrl);
>  int uvc_query_v4l2_menu(struct uvc_video_chain *chain,
>                         struct v4l2_querymenu *query_menu);
>
>
> --
> 2.47.0.338.g60cca15819-goog
>

