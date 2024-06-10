Return-Path: <linux-kernel+bounces-208949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F4902AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442B8287677
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F312F5B6;
	Mon, 10 Jun 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D8dJ4tPW"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86601879
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056337; cv=none; b=uZe0/h+bO6mcwlUZAGkI0Mr2Dgw7MYAzYsivlbfVKetZSJmMTZI14FTaiQy6vTVFC+6z2FG9j8HiB/s/Xlrhggo1gCuRBZiACA4UBXNUyEofur3CrY1aPa4AVuMXuJalX67OpdQDSWwffSBwgPRehpTCJ/H5htv/LZ4h07LRzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056337; c=relaxed/simple;
	bh=gmcqo4mZQVYUP8msDqMkp5FlW36i1BK9aU0wcAftSSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM+sTxeUMddctypo4we+WDuZSBizl9ldFDtMPtGaK6JpzhONhp0vHHYj8ZN7qTVkCWegLrQlsNDUvWiL2oBUAAc+jWmbbNNwHIZYgZL/8zuLiyiX6KfzDqJROecX3ynP07A1f+FhISF4DusYqlxRcnEELrSG7a4+igrimRMf1EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D8dJ4tPW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6f0e153eddso269026866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718056334; x=1718661134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MeA9AyChYLDPZo5d1TS51emX8dw5ttciiCSkWSyJMyg=;
        b=D8dJ4tPW9t3i0xJSvsf3Feb+fo+d//aH+B02Dw0MLdWmxOnWGmbJGFGUeVEoU1xnCw
         1oHcJAaqpBBTqQzdnf+T1Zw9r8LVGEqJC2defRnDDyDBhqrhyd4mgPxhdqfrOXHIf5zn
         gmhozjFxZsXa4m3rb9D1yCgGYHJoIphlDZEZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718056334; x=1718661134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeA9AyChYLDPZo5d1TS51emX8dw5ttciiCSkWSyJMyg=;
        b=c+mxKMTTp35b6YqTzCY5keHzGV9O0uOUN3uy5RE4lmojT/MFa/bm69WHC51qBipwT2
         Zq9keyq2/We/6VKNHOM0l9UA7yNDPSt2IBKlaVaiCm3WL+anGXAXZq++sESzVbeclibM
         1LC1qljiyAMazT5N/6TpJOa5eq7jgGOwlvSAKfxAJ+qhg1pLQV1a/ItreuqKBdtb4iTp
         sIpFBBCH7gvBcRM14uJ67tMykd701YJ37BmWErzR3DC+w4qJOAx+pPY1I2Gv1ReaJRk+
         EWTTsSw9AfUxiopZFAAGalucys1Cs4M8JfphcnMgr2WcfpMna2W0DgLeTuhse7Q9l4Re
         dFlg==
X-Forwarded-Encrypted: i=1; AJvYcCWwC30vRBVSXVVCbb/fLVJb8YE/atedCJnvsBhNlIKt1moDnnq2qUGLZTOWqLZ/sfjZeIsWNHu3SkOyBPnPt/KzpE7UU1FnAWGDI42m
X-Gm-Message-State: AOJu0YxRdczCKPozPwsr2OHYzK+xOgV/6wjczM+oUHYBXif1tOId/SK2
	kBSP3fMQ9G1EK44ws720frtNE57xTn+Pj0UFxfk1o2bWacYTslPEV3wffgBX2ofbPXjQvA2XZZE
	oX28z
X-Google-Smtp-Source: AGHT+IGxNlduPw4N8RobNZbRIqbzT3VJWeSoF5fQdrgHcfqBFoIJRqNGvcA6i2AM+kCf5NUruB/I+w==
X-Received: by 2002:a17:907:7211:b0:a6e:a97c:fc9a with SMTP id a640c23a62f3a-a6ea97cfd20mr755106466b.8.1718056333661;
        Mon, 10 Jun 2024 14:52:13 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0b5371d2sm362082366b.39.2024.06.10.14.52.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 14:52:13 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6f09eaf420so242012366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:52:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkt5rl7buBfN4nrUuqZbG2jqe5zTQ6JwHa+y0OI7wEL2/4R22rj+opmo5zqA4TDQL87Cug/0UQVl3NCU41uJKDgGUFR73djObKUQ+9
X-Received: by 2002:a17:907:1006:b0:a6e:f52a:c34f with SMTP id
 a640c23a62f3a-a6ef52ac3fbmr547977766b.18.1718056332086; Mon, 10 Jun 2024
 14:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
 <20240318-billion-v1-3-2f7bc0ee2030@chromium.org> <20240610141402.GB13744@pendragon.ideasonboard.com>
In-Reply-To: <20240610141402.GB13744@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 10 Jun 2024 23:51:55 +0200
X-Gmail-Original-Message-ID: <CANiDSCsNdZyKMM82q9SqZ-hQH2Pch24rVCqSs=L6mFL=RbJqQg@mail.gmail.com>
Message-ID: <CANiDSCsNdZyKMM82q9SqZ-hQH2Pch24rVCqSs=L6mFL=RbJqQg@mail.gmail.com>
Subject: Re: [PATCH 3/5] media: uvcvideo: Probe the PLF characteristics
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Mon, 10 Jun 2024 at 16:14, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, Mar 18, 2024 at 11:55:25PM +0000, Ricardo Ribalda wrote:
> > The UVC 1.5 standard defines 4 values for the PLF control: Off, 50Hz,
> > 60Hz and Auto. But it does not clearly define if all the values must be
> > implemented or not.
> >
> > Instead of just using the UVC version to determine what the PLF control
> > can do, probe it.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 54 +++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 50 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 67522143c6c85..9a0b81aca30d1 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -501,12 +501,58 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
> >  static int uvc_ctrl_add_plf_mapping(struct uvc_video_chain *chain,
> >       struct uvc_control *ctrl, const struct uvc_control_mapping *mapping)
> >  {
> > +     const struct uvc_control_mapping *out_mapping =
> > +                                     &uvc_ctrl_power_line_mapping_uvc11;
> > +     u8 init_val;
> > +     u8 *buf;
>
>         u8 *buf __free(kfree) = NULL;
>
> will simplify the exit paths.
>
> > +     int ret;
> > +
> > +     buf = kmalloc(sizeof(*buf), GFP_KERNEL);
> > +     if (!buf)
> > +             return -ENOMEM;
> > +
> > +     /* Save the default PLF value, so we can restore it. */
> > +     ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
> > +                          chain->dev->intfnum, ctrl->info.selector,
> > +                          buf, sizeof(*buf));
>
> That's the current value, not the default. Is that intended ?

Yes, the driver does not init the other controls to the default value.
So I'd rather be consistent.

>
> > +     /* If we cannot read the control skip it. */
> > +     if (ret) {
> > +             kfree(buf);
> > +             return ret;
> > +     }
> > +     init_val = *buf;
> > +
> > +     /* If PLF value cannot be set to off, it is limited. */
> > +     *buf = V4L2_CID_POWER_LINE_FREQUENCY_DISABLED;
> > +     ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
> > +                          chain->dev->intfnum, ctrl->info.selector,
> > +                          buf, sizeof(*buf));
> > +     if (ret) {
> > +             out_mapping = &uvc_ctrl_power_line_mapping_limited;
> > +             goto end;
>
> If setting the value failed you don't need to restore it, do you ?
>
> > +     }
> > +
> > +     /* UVC 1.1 does not define auto, we can exit. */
> >       if (chain->dev->uvc_version < 0x150)
> > -             return __uvc_ctrl_add_mapping(chain, ctrl,
> > -                                           &uvc_ctrl_power_line_mapping_uvc11);
> > +             goto end;
> > +
> > +     /* Check if the device supports auto. */
> > +     *buf = V4L2_CID_POWER_LINE_FREQUENCY_AUTO;
> > +     ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
> > +                          chain->dev->intfnum, ctrl->info.selector,
> > +                          buf, sizeof(*buf));
>
> Now for the real annoying question. I've encountered quite a few devices
> that would crash when the driver tried to get/set lots of controls at
> probe time. This is why the control cache is populated the first time a
> control is queried, and not when the device is probed. I'm always
> worried when adding more control accesses at probe time that some
> devices will behave improperly.

If we encounter a device like that we could quirk it.

>
> Given the number of UVC users I tend to be on the conservative side, but
> obviously, if we were to strictly avoid new access patterns to the
> device, the driver wouldn't be able to evolve. I do like patches 4/5 and
> 5/5, so I'm tempted to take the risk and revert this series later if
> needed. That would likely make some other users unhappy if they rely on
> the heuristic.
>
> Another issue is how to get vendors to implement the power line
> frequency control correctly. With the series applied, vendors won't
> notice they're doing something wrong. Of course, they probably don't
> check the behaviour of their devices with Linux in the first place, so
> I'm not sure what we could do.

We can add the check to v4l2-compliance....

Although I would love to see a uvc-compliance tool. If the tool can be
easily run in windows/linux without a driver I guess ISP vendors will
run it to validate their code.
Right now there is no way to validate a usb camera beyond: it runs in
windows and in cheese.

>
> > +     if (!ret)
> > +             out_mapping = &uvc_ctrl_power_line_mapping_uvc15;
> > +
> > +end:
> > +     /* Restore initial value and add mapping. */
> > +     *buf = init_val;
> > +     uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
> > +                    chain->dev->intfnum, ctrl->info.selector,
> > +                    buf, sizeof(*buf));
> >
> > -     return __uvc_ctrl_add_mapping(chain, ctrl,
> > -                                   &uvc_ctrl_power_line_mapping_uvc15);
> > +     kfree(buf);
> > +     return __uvc_ctrl_add_mapping(chain, ctrl, out_mapping);
> >  }
> >
> >  static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

