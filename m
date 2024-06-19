Return-Path: <linux-kernel+bounces-220529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DBB90E32C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D420A1C20EFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18154650;
	Wed, 19 Jun 2024 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5QMhSgJ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672063D0
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718777745; cv=none; b=PO/eK/MWUd8LY9fC9vhplBwGTUJE9QYviCem4vtC2jM8ocT6UjufgbytPKKhB3r9BQh+4d3/M+ob+wwINYarDj3+iLQbGxSMhTCsW3dt1xl16KQW8iX10Tq8b9us1c+rAVVS/NIOURTNrwPkk4yuI1zvq+CtfFcvZrFFZ9wPKQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718777745; c=relaxed/simple;
	bh=E32afqFs5Lu7Y5oNxXL0EzLi11zTM40ymyrgpPSVGoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PM+c9PtoQ7r6b55knAbparGn5P4v6h2Ok5DTISbv+p47CioKzDUMqUr1crWvfVnRfz5s5sjwxU6USpdCw0fqgwVM+xGiLjygnwq+d3GIl1Hfphm+rS2Sqzt8hxvduqbtnWMtl539sRl0OFkDQJdJAoftbmzE3+J8dlNzuFFzDqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O5QMhSgJ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so7556569e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718777739; x=1719382539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1bGbDKaKhkn1mQHGSzAalsmolUgZrz+Gk53FfmEtnk=;
        b=O5QMhSgJD0oGfbivtk9IqlwhJ32IQNQu2By1toZIPPO5lhoobeuVeIPzeFNNJ8UCgy
         7EhjLJIWfMcZnrmWJIArfvQTFXXGKHdHXgfY1BxNcdBO5MfUXYaG66Tt3CmxaPEPR0ET
         HTYlrSvqNUisVGdGMQdUb1/2JWr0bIarfxgC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718777739; x=1719382539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1bGbDKaKhkn1mQHGSzAalsmolUgZrz+Gk53FfmEtnk=;
        b=uPqyfg5uopDNlq2exeSuHMOQRTGw/pixEluEgxTMFZM7a1+K/2V6cP7fDz/OZXKBF7
         Xr5ESmkm8eZJsTl5PzLcy65e1pjXYJdrS1HIe+mNqNHYNPSngJZvQBFclYobmxhGE4OL
         PZWrr0ntsf6BcTer8Y0sgPxw/RH2OtWSJ7gM7EqF1PJ1okqtwchxDtx3zO5qrRVtkFpa
         UEZ7EloDeJmsUyuaGPjvdq1X3YDP0pTgrCHf0Q3dAsphPmN8nEoYRzfZ/P30WxgfNx0f
         3X1XX5CtFC42Esal88hJF65+IbSff4ZzJ6LOSnpnvgNSu6fG0UlFgSk7ncPae8l3wZcq
         7fnA==
X-Forwarded-Encrypted: i=1; AJvYcCVIfp0CxMSkr4xvwLdGH/XIyLEv8/YEZK5hhWTvCat7TDF9uLuRtyfY20HHMJ2zjLkNz2B12UdZWxHtgA9QrpzT7OcX2crp5fHa4dwB
X-Gm-Message-State: AOJu0YwDFq7FToAK0rchKsJ7G5E2X0sm255QC5Be4r+I0+1ed79nJhhk
	Vfu2Tcip3SeGY5vTWj1nV4t6ESDglzbHjIh8r9NcMENsDK8793cnxOHeoTGOOA73+i8i8lfnL1G
	zbvVG
X-Google-Smtp-Source: AGHT+IGKnMbZGFvaA4izwA6ZB3pW6QHzwv1rKOMEAuhGfEmtUaPCL7FPIdxurmJKiQjtrczGS/WOmA==
X-Received: by 2002:a05:6512:2252:b0:52c:8289:e891 with SMTP id 2adb3069b0e04-52ccaa2a86emr1252051e87.6.1718777739474;
        Tue, 18 Jun 2024 23:15:39 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed3658sm650614866b.133.2024.06.18.23.15.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 23:15:38 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f51660223so370216166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:15:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHT3FfxiythJrCWpJ1keRxGlISjL/iybQ2o0SjVpBIlXyjHlXXEJnfASTtP3b93pSN00MUSkGGSBoUxCW3COYAeow5vUb5/74bZsF+
X-Received: by 2002:a50:9359:0:b0:57c:77a1:d1da with SMTP id
 4fb4d7f45d1cf-57d07c37da2mr981271a12.0.1718777737964; Tue, 18 Jun 2024
 23:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718726777.git.soyer@irl.hu> <b062c3ec615a69cbc1b154b1838df3cdc3e1282a.1718726777.git.soyer@irl.hu>
In-Reply-To: <b062c3ec615a69cbc1b154b1838df3cdc3e1282a.1718726777.git.soyer@irl.hu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 19 Jun 2024 08:15:26 +0200
X-Gmail-Original-Message-ID: <CANiDSCs2MLqdNuZtcQEHhE6c8XXc=4AKNcuHNNgqJKnc9da3Hg@mail.gmail.com>
Message-ID: <CANiDSCs2MLqdNuZtcQEHhE6c8XXc=4AKNcuHNNgqJKnc9da3Hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] media: uvcvideo: UVC minimum relative
 pan/tilt/zoom speed fix.
To: Gergo Koteles <soyer@irl.hu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, John Bauer <johnebgood@securitylive.com>, linh.tp.vu@gmail.com, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Gergo

Thanks for your your patch.

On Tue, 18 Jun 2024 at 18:33, Gergo Koteles <soyer@irl.hu> wrote:
>
> From: John Bauer <johnebgood@securitylive.com>
>
> The minimum UVC control value for the relative pan/tilt/zoom speeds
> cannot be probed as the implementation condenses the pan and tilt
> direction and speed into two 16 bit values. The minimum cannot be
> set at probe time because it is probed first and the maximum is not
> yet known. With this fix if a relative speed control is queried
> or set the minimum is set and checked based on the additive inverse of
> the maximum at that time.
>
> Signed-off-by: John Bauer <johnebgood@securitylive.com>
> Signed-off-by: Gergo Koteles <soyer@irl.hu>

Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 38 +++++++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 4b685f883e4d..93ed2462e90b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -441,7 +441,6 @@ static s32 uvc_ctrl_get_rel_speed(struct uvc_control_mapping *mapping,
>                 return (rel == 0) ? 0 : (rel > 0 ? data[first+1]
>                                                  : -data[first+1]);
>         case UVC_GET_MIN:
> -               return -data[first+1];
>         case UVC_GET_MAX:
>         case UVC_GET_RES:
>         case UVC_GET_DEF:
> @@ -1233,6 +1232,17 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
>         return ~0;
>  }
>
> +static bool is_relative_ptz_ctrl(__u32 ctrl_id)
> +{
> +       switch (ctrl_id) {
> +       case V4L2_CID_ZOOM_CONTINUOUS:
> +       case V4L2_CID_PAN_SPEED:
> +       case V4L2_CID_TILT_SPEED:
> +               return true;
> +       }
> +       return false;
> +}
> +
>  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>         struct uvc_control *ctrl,
>         struct uvc_control_mapping *mapping,
> @@ -1322,14 +1332,23 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                 break;
>         }
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
> -               v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
> -                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> -
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
>                 v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
>                                      uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
>
> +       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
> +               /*
> +                * For the relative speed implementation the minimum
> +                * value cannot be probed so it becomes the additive
> +                * inverse of maximum.
> +                */
> +               if (is_relative_ptz_ctrl(v4l2_ctrl->id))
> +                       v4l2_ctrl->minimum = -v4l2_ctrl->maximum;
> +               else
> +                       v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
> +                                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> +       }
> +
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
>                 v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
>                                   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> @@ -1916,6 +1935,15 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>                 max = mapping->get(mapping, UVC_GET_MAX,
>                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +
> +               /*
> +                * For the relative speed implementation the minimum
> +                * value cannot be probed so it becomes the additive
> +                * inverse of maximum.
> +                */
> +               if (is_relative_ptz_ctrl(xctrl->id))
> +                       min = -max;
> +

nit: The following would probably be more correct but less clear:

if  (is_relative_ptz_ctrl(xctrl->id))
    min = -max;
else
    min = mapping->get(mapping, UVC_GET_MIN,...)

So up to you what do you/Laurent what is better ;)

>                 step = mapping->get(mapping, UVC_GET_RES,
>                                     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>                 if (step == 0)
> --
> 2.45.2
>


-- 
Ricardo Ribalda

