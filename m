Return-Path: <linux-kernel+bounces-437002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69859E8DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8D4280E9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B521571F;
	Mon,  9 Dec 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QpAVRAwS"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9F3142903
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734295; cv=none; b=iPDizifGG0UmLJk2nhHj7M2BF5HpO+rvqNnA0B/LJuG5vdrMKMlEYGpf7PvUIuE2dfHjDmQoNi6GHnOamxMTJwGR56Wlii2Fm9e4uhfR+vQ5ZqmFpYdMdKiWPQBHkegvopAtMv2ylMOhc3VqKgvYSc4MZRkuRD/C6sK24Nz+c7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734295; c=relaxed/simple;
	bh=Jj73nYyzkbAdYDJh5sbZFwiVxL9xxq3WC9X1epagEeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=St1WElhhI/CUFtvYZNFa7XUoolxQJxzJqHKS02yvELp/iC3RosE7TiVBDJWWuxFa12Ea+7d7fbNSConj/hiyfaxKakbY52pdCCcjHLprB073Iljo9ZtmulrZXTtwkNa8rtA/qYYUwCBjOU1jtEiIMQFkj4Qk5gw6/tzdF7Hhg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QpAVRAwS; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef7f8acc33so31983227b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733734293; x=1734339093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qZ/3IZ2C3DzWrkrLVi+8AtjnaFX1g2jC3ZeApxgqB8=;
        b=QpAVRAwSDIMzAyjE0JNG3gCKqXYHuxrVHMST+FhMyOO1KmGZWsa8GSSvwPYLWmpWgH
         oJr/kMoQyxmGUoEy42uYFz6LbJyZTONpj/ynn+on8pd+iMXCJ/GneGF1PsZQO9tm5eZ+
         zCEOUg+KcbNmPcJmFQon5++47gIgPWg8NeuwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734293; x=1734339093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qZ/3IZ2C3DzWrkrLVi+8AtjnaFX1g2jC3ZeApxgqB8=;
        b=d+b+shTpg8HbCTon8ykyVXUWzhqeFG2NdK0Z8YhtqMMU9vx6KNmpf7PtUe8HKcWfz0
         6qcUBf27HaglAkzEGnPWWbDVIjf6BJbudtUKIIlNqu/waehySSKkEB6rz5RWgg2oY5wM
         LqMNAJ1j5eytI3i3j4J8L5Osnn8635EhbzmoeWnpIIJIeGw4Ff0Am54Q9VsIUhLk/OaJ
         yQF3+PCRTQJbirlkbaDYd1VziTZ2QschLNBmhkqUFha+43cp6RoedUG6ag+5XO7xvkUm
         StFUlimePWAPQcplZDfNzPUe0c0XOVDWxHwczxZyo7VQBnjVcCH+ugTFcuObNOHvfxzm
         Ygbw==
X-Forwarded-Encrypted: i=1; AJvYcCVjcXmIhuMtvio285FQXw0GehUXPz3eTI+l468crjCWgR+vz5A7JKbYRxx3HpobU7gMs8Gb3O11/dM2rss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NcptNpgQwayiUcIBD3hDpjel9FfVygv2IeXoM0X63x5wMYSY
	KfGB9JR2xXIwXo9fNp7TLcOHzua4REqVotJtUfvpX2/Xu4GfwhwDhP7txzaJSJLZo3l2iGdAaKT
	uaztHIk1oMl4qakcy5rbNwuZjQJFyTzcmgnZ0
X-Gm-Gg: ASbGncuUxAZMqZfDTIHB5q3OTfFVIpwZzXdMAJ/dJYVQW4OphxiKuUoORBTm2h4Zc3d
	ZlaXI/ZYgzt6OXOh94nsCH5iJ1tAMdhM=
X-Google-Smtp-Source: AGHT+IHw9vA9SksR0OS9GB3BSgh57DZ0gNDUwZuFwDld7/g9YwNOY4H79XWFOom/ycSlEqa0QjPCnyvW+B9k+1pGqYQ=
X-Received: by 2002:a05:690c:586:b0:6e5:a431:af41 with SMTP id
 00721157ae682-6efe3deb3a3mr97548967b3.38.1733734293126; Mon, 09 Dec 2024
 00:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org> <20241114-uvc-roi-v15-16-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-16-64cfeb56b6f8@chromium.org>
From: Yunke Cao <yunkec@chromium.org>
Date: Mon, 9 Dec 2024 17:51:22 +0900
Message-ID: <CAEDqmY6wUV_MmtXReRyrkeE+WamdxchW8ReZ7S+jHgFA29i6mw@mail.gmail.com>
Subject: Re: [PATCH v15 16/19] media: uvcvideo: Introduce uvc_mapping_v4l2_size
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
> Centralize the calculation for the v4l2_size of a mapping.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc=
_ctrl.c
> index 1bc019138995..f262e05ad3a8 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1463,6 +1463,14 @@ static int __uvc_queryctrl_boundaries(struct uvc_v=
ideo_chain *chain,
>         return 0;
>  }
>
> +static size_t uvc_mapping_v4l2_size(struct uvc_control_mapping *mapping)
> +{
> +       if (uvc_ctrl_mapping_is_compound(mapping))
> +               return DIV_ROUND_UP(mapping->size, 8);
> +
> +       return sizeof(s32);
> +}
> +
>  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                                  struct uvc_control *ctrl,
>                                  struct uvc_control_mapping *mapping,
> @@ -1504,7 +1512,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_c=
hain *chain,
>                         v4l2_ctrl->flags |=3D V4L2_CTRL_FLAG_INACTIVE;
>         }
>
> -       v4l2_ctrl->elem_size =3D sizeof(s32);
> +       v4l2_ctrl->elem_size =3D uvc_mapping_v4l2_size(mapping);
>         v4l2_ctrl->elems =3D 1;
>
>         if (v4l2_ctrl->type >=3D V4L2_CTRL_COMPOUND_TYPES) {
> @@ -2093,7 +2101,7 @@ static int uvc_mapping_get_xctrl_compound(struct uv=
c_video_chain *chain,
>                 return -EINVAL;
>         }
>
> -       size =3D DIV_ROUND_UP(mapping->size, 8);
> +       size =3D uvc_mapping_v4l2_size(mapping);
>         if (xctrl->size < size) {
>                 xctrl->size =3D size;
>                 return -ENOSPC;
> @@ -2271,9 +2279,8 @@ static int uvc_mapping_set_xctrl_compound(struct uv=
c_control *ctrl,
>                                           struct v4l2_ext_control *xctrl)
>  {
>         u8 *data __free(kfree) =3D NULL;
> -       size_t size;
> +       size_t size =3D uvc_mapping_v4l2_size(mapping);
>
> -       size =3D DIV_ROUND_UP(mapping->size, 8);
>         if (xctrl->size !=3D size)
>                 return -EINVAL;
>
>
> --
> 2.47.0.338.g60cca15819-goog
>

