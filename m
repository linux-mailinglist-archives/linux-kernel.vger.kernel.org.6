Return-Path: <linux-kernel+bounces-542160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0A3A4C65C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FE61895460
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159E622AE6B;
	Mon,  3 Mar 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aujA5M7S"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2970D215058
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017925; cv=none; b=l6c/Eqlkpz7ivpJEJAuCgP0pTkb2Rh6UXhvWamzJ+CRSO1FeGmb32ySbswvR4MP3jQh5IzNRRvV2T8p5dOnfy33wLqzpOyJiylzTGFJ9gJEI+wut88gcHGYIU4pPhQSjsgU8wgISpToTaZbyFmJppkCcL6O/KVOq8/b/b/tg5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017925; c=relaxed/simple;
	bh=MCSgs5xxxCulYRnvfdyGYNbtARDHIyZ/TyhT0KMm5+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DVmiMeN3ddeu+cNXpojB3p0ruC6duGqLP91E2qAotxSQAi6RGAEPLnIfz+5fRmfrxY3cjuVI0tsOnX9tmZOh1tsYs6VykghGhhVQKfOrKFHk5zsGyF+ZB9uSu/htGwb7ILienLyuljGArhOVgVOtPjY4F0iAsaA+Wi6+ox68buk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aujA5M7S; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5495e926364so1694224e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741017921; x=1741622721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdWLGQeqT4YHMMCFuHzXq23B1R2g7aEmE8i8MWclk2s=;
        b=aujA5M7SMz5ojq35jwUdMWfpbXMzLyDhc5pKNrZAZkcyyLPeF8mqYhM3+ptLtA96to
         /8F1isgKTNROzUqDNJJT2llRL6dps5mo6GxowAMRyc60yNShOw6SzDpcVPF/wzW+tXCW
         lozUIPHhUF6qlAQwgxHFGmH5VqWEBYN7m3Kys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741017921; x=1741622721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdWLGQeqT4YHMMCFuHzXq23B1R2g7aEmE8i8MWclk2s=;
        b=swi2/fH4uW1uK7P+YeRMBay1eW5rADEiolye5jrldz624iSerdomeGs1iPjtlBEL2I
         rHxTEpEcpkMkpHWdHCq8UBO7T/1iDR3yZFYkzN7sJ2QJRu+KY2IoUF9PLwqSXdRngCZr
         rj9TGnAPDQMPlezMk3+qZYnGsRgm5AQnyJrDe7xCkXtjY1mWBoBINIpCzHM72wPcEU7l
         cwOyHsnLjHb7QLOn91CtbqGRT+3AGkHN5S7Bx/EC6b9EWUrzDfNKr5+JGRzhJkUfTy87
         qM4N1JZAF+i8X2Q2XHnpKrQj8a2NM6zWhgyA5sn8YcQCj89D3y3PDY3w9PTbM8O+0YOF
         yEaA==
X-Forwarded-Encrypted: i=1; AJvYcCXgkdKCxVt7FlF7G91iq35nkSlrnS9zA2lu1/fsTHLLrTlveSBaH+LJ6MCs6CBwc6+KgQC6YTgWA6NDFqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWqK+oYwZglrfwH+j9MrS9tKWGC3570Mmi5tnlIBy5R8sf3fY
	XnxAwsI2rjpLsm0l10vrHSS603i/CAJwfVq+l7uXybAzo4YqOCtghe54GjIdf4NFuMjFEIqbCDc
	=
X-Gm-Gg: ASbGnctFJ/Kl17SzS9nf/50sz8A0fumYdFHlYHODPUZAxdSIRCyaciRZi3xYSl9EJAg
	/NCzqCL9U+VMNCSwbB8APC5gco3XHd7bTvpfHBeF/xNJ6Exo2O3mxD4u8EGgRZWlrHmF9r/ZWvI
	QIezRkqTTXtMMBpAzYP1w3PMIEZDnZkOc6S/WtxLwkS6kixlcpWPmlPDauV8vKbZP8/MIwC1ZIM
	oTsSl/Ng5Ay9xcvEgg8gzUW4klvlXIBMpejExBPQ91O1rmHdx+cdUvTBFncnpTl6iftlMm+HLAK
	y5Sw6EOa/98jkv4w23xJT5Xii+++eZPk4heOEFdxB56gHkKI1W2byWlmfIsMqM1MAPB3eLoD6uK
	raZlIYHkrfec=
X-Google-Smtp-Source: AGHT+IFmI4ubGv9bO6JaEUvdzdUEtFrnfC3IlZX9ajERp6CjuUYd+o5hLCfoOSGbD4rf/cddppc1Aw==
X-Received: by 2002:a05:6512:3a90:b0:549:4b8f:8b77 with SMTP id 2adb3069b0e04-5494c118963mr6226400e87.20.1741017920884;
        Mon, 03 Mar 2025 08:05:20 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5495b4eca8asm720731e87.82.2025.03.03.08.05.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:05:20 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30ba92c846eso19731481fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:05:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVuXd8eER4t6cZ+aWNe8Z7KCa1nuuXiHcO4pdu5ICrKYFRZy9SnmB1FZc7BqnSIosz/R2/gycrVrYhcP2g=@vger.kernel.org
X-Received: by 2002:a2e:bc1d:0:b0:30b:c83e:720a with SMTP id
 38308e7fff4ca-30bc83e77demr4968111fa.1.1741017919544; Mon, 03 Mar 2025
 08:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111-uvc-eaccess-v4-1-c7759bfd1bd4@chromium.org>
 <20250223170319.GA2821@pendragon.ideasonboard.com> <CANiDSCv1HVu82D=PoJFu=XCQ97k_MM1dmYpufkUCiKpSgGRT9w@mail.gmail.com>
 <20250303151603.GD32048@pendragon.ideasonboard.com>
In-Reply-To: <20250303151603.GD32048@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 3 Mar 2025 17:05:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCvQ2evpdfg5FYKBRB9ZNQ5Lfa8Sk-EJ4yNiQwB4OfFnKg@mail.gmail.com>
X-Gm-Features: AQ5f1JovEf4lTEvpCMXxm8mI2dt3ScgsdnXXPBeAg94ewbVqW4zQUL8EN1Bhg_Y
Message-ID: <CANiDSCvQ2evpdfg5FYKBRB9ZNQ5Lfa8Sk-EJ4yNiQwB4OfFnKg@mail.gmail.com>
Subject: Re: [PATCH v4] media: uvcvideo: Set V4L2_CTRL_FLAG_DISABLED during
 queryctrl errors
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 16:16, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Feb 24, 2025 at 10:26:34AM +0100, Ricardo Ribalda wrote:
> > On Sun, 23 Feb 2025 at 18:03, Laurent Pinchart wrote:
> > > On Sat, Jan 11, 2025 at 09:57:21AM +0000, Ricardo Ribalda wrote:
> > > > To implement VIDIOC_QUERYCTRL, we need to know the minimum, maximum,
> > > > step and flags of the control. For some of the controls, this involves
> > > > querying the actual hardware.
> > > >
> > > > Some non-compliant cameras produce errors when we query them. Right now,
> > > > we populate that error to userspace. When an error happens, the v4l2
> > > > framework does not copy the v4l2_queryctrl struct to userspace. Also,
> > > > userspace apps are not ready to handle any other error than -EINVAL.
> > > >
> > > > One of the main usecases of VIDIOC_QUERYCTRL is enumerating the controls
> > > > of a device. This is done using the V4L2_CTRL_FLAG_NEXT_CTRL flag. In
> > > > that usecase, a non-compliant control will make it almost impossible to
> > > > enumerate all controls of the device.
> > > >
> > > > A control with an invalid max/min/step/flags is better than non being
> > > > able to enumerate the rest of the controls.
> > > >
> > > > This patch makes VIDIOC_QUERYCTRL return 0 in all the error cases
> > > > different than -EINVAL, introduces a warning in dmesg so we can
> > > > have a trace of what has happened and sets the V4L2_CTRL_FLAG_DISABLED.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > Hi 2*Hans and Laurent!
> > > >
> > > > I came around a device that was listing just a couple of controls when
> > > > it should be listing much more.
> > > >
> > > > Some debugging latter I found that the device was returning -EIO when
> > > > all the focal controls were read.
> > > >
> > > > Lots of good arguments in favor/against this patch in the v1. Please
> > > > check!
> > > >
> > > > Without this patch:
> > > > $ v4l2-ctl --list-ctrls
> > > >                   auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=3 value=3 (Aperture Priority Mode)
> > > >          exposure_time_absolute 0x009a0902 (int)    : min=50 max=10000 step=1 default=166 value=166 flags=inactive
> > > >      exposure_dynamic_framerate 0x009a0903 (bool)   : default=0 value=0
> > > > region_of_interest_auto_control 0x009a1902 (bitmask): max=0x00000001 default=0x00000001 value=1
> > > >
> > > > With this patch:
> > > > $ v4l2-ctl --list-ctrls
> > > >                   auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=3 value=3 (Aperture Priority Mode)
> > > >          exposure_time_absolute 0x009a0902 (int)    : min=50 max=10000 step=1 default=166 value=166 flags=inactive
> > > >      exposure_dynamic_framerate 0x009a0903 (bool)   : default=0 value=0
> > > > error 5 getting ext_ctrl Focus, Absolute
> > > > error 5 getting ext_ctrl Focus, Automatic Continuous
> > > >    region_of_interest_rectangle 0x009a1901 (unknown): type=107 value=unsupported payload type flags=has-payload
> > > > region_of_interest_auto_control 0x009a1902 (bitmask): max=0x00000001 default=0x00000001 value=1
> > > > --
> > > > ---
> > > > Changes in v4:
> > > > - Display control name (Thanks Hans)
> > > > - Link to v3: https://lore.kernel.org/r/20250107-uvc-eaccess-v3-1-99f3335d5133@chromium.org
> > > >
> > > > Changes in v3:
> > > > - Add a retry mechanism during error.
> > >
> > > This needs to be explained in the commit message, including when/why it
> > > helps, and why the retry count is 2.
> > >
> > > > - Set V4L2_CTRL_FLAG_DISABLED flag.
> > > > - Link to v2: https://lore.kernel.org/r/20241219-uvc-eaccess-v2-1-bf6520c8b86d@chromium.org
> > > >
> > > > Changes in v2:
> > > > - Never return error, even if we are not enumerating the controls
> > > > - Improve commit message.
> > > > - Link to v1: https://lore.kernel.org/r/20241213-uvc-eaccess-v1-1-62e0b4fcc634@chromium.org
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 43 ++++++++++++++++++++++++++++++++--------
> > > >  1 file changed, 35 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 4e58476d305e..9d7812e8572d 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -1280,6 +1280,8 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
> > > >       return ~0;
> > > >  }
> > > >
> > > > +#define MAX_QUERY_RETRIES 2
> > > > +
> > > >  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> > > >       struct uvc_control *ctrl,
> > > >       struct uvc_control_mapping *mapping,
> > > > @@ -1305,19 +1307,44 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> > > >               __uvc_find_control(ctrl->entity, mapping->master_id,
> > > >                                  &master_map, &master_ctrl, 0);
> > > >       if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
> > > > +             unsigned int retries;
> > > >               s32 val;
> > > > -             int ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> > > > -             if (ret < 0)
> > > > -                     return ret;
> > > > +             int ret;
> > > >
> > > > -             if (val != mapping->master_manual)
> > > > -                             v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> > > > +             for (retries = 0; retries < MAX_QUERY_RETRIES; retries++) {
> > > > +                     ret = __uvc_ctrl_get(chain, master_ctrl, master_map,
> > > > +                                          &val);
> > > > +                     if (ret >= 0)
> > > > +                             break;
> > > > +             }
> > > > +
> > > > +             if (ret < 0) {
> > > > +                     dev_warn_ratelimited(&chain->dev->udev->dev,
> > > > +                                          "UVC non compliance: Error %d querying master control %x (%s)\n",
> > > > +                                           ret, master_map->id,
> > > > +                                           uvc_map_get_name(master_map));
> > > > +             } else if (val != mapping->master_manual) {
> > > > +                     v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> > > > +             }
> > > >       }
> > > >
> > > >       if (!ctrl->cached) {
> > > > -             int ret = uvc_ctrl_populate_cache(chain, ctrl);
> > > > -             if (ret < 0)
> > > > -                     return ret;
> > > > +             unsigned int retries;
> > > > +             int ret;
> > > > +
> > > > +             for (retries = 0; retries < MAX_QUERY_RETRIES; retries++) {
> > > > +                     ret = uvc_ctrl_populate_cache(chain, ctrl);
> > > > +                     if (ret >= 0)
> > > > +                             break;
> > > > +             }
> > > > +
> > > > +             if (ret < 0) {
> > > > +                     dev_warn_ratelimited(&chain->dev->udev->dev,
> > > > +                                          "UVC non compliance: Error %d populating cache of control %x (%s)\n",
> > > > +                                          ret, mapping->id,
> > > > +                                          uvc_map_get_name(mapping));
> > > > +                     v4l2_ctrl->flags |= V4L2_CTRL_FLAG_DISABLED;
> > >
> > > Can we make the control permanently disabled ?
> >
> > I'd rather not. In funky hardware the control might work with the
> > right combination of other controls.
>
> That makes the behaviour random and therefore very confusing for
> userspace. All of a sudden a control will start being available, even if
> it was marked as disabled during enumeration.

Random weird hardware will have random behaviour. I think this is kind
of expected.

Also there are probably lots of cameras in the field that cannot
enumerate properly but are used by custom apps. We are going to break
userspace if we enforce this.

Hans V. What do you think?

>
> > > > +             }
> > > >       }
> > > >
> > > >       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
> > > >
> > > > ---
> > > > base-commit: c5aa327e10b194884a9c9001a751f6e4703bc3e3
> > > > change-id: 20241213-uvc-eaccess-755cc061a360
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

