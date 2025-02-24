Return-Path: <linux-kernel+bounces-528566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90673A41918
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CDEF170D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A224A055;
	Mon, 24 Feb 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D8A4ZQwT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4703243370
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389212; cv=none; b=aDhQcbGDUCTLsTQKnXFxSAjRszgEf2huzgQoLi/wAdKWWVCOPaqwaRhumYKhMhfKiymuAcogWOmSOLhlmRQOqK1g3d+ye8AEw0wAa7eqwBDRhb3dDVP3SBWPLcaKAIKVpq3wTow0yQV3BoVql5PHXQBpZoBKnczEIrBnfpLIOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389212; c=relaxed/simple;
	bh=/ryG12havO6GGoTrPBXBQA1dshzJ3F4G9J8CFEub8VQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QI1uoOIzxRKEkPLLVqOWMH+YVby2m2aD5IEq2sgYFJnJETQEHZafWAQxzirMsXqArJNmr1gpKI7JLZ5pnK+rhO5glLlAzN0AUp7CRiavUOh1hQSgcs1Cub5RH/wD/552rrsJuvLl7dR3/Mav07Ibxe+caB53rHu2X0BVGmKaaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D8A4ZQwT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a04so44301641fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740389209; x=1740994009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R9DwX5H0t5xZGrbvpWDysDlrDfS0kR6OfhPIwAFx6mo=;
        b=D8A4ZQwTKHrnZk01/sUFcZbMWaYs3LeRVXQzesg91XPVVKhO3+TaRs3Aos6f6pSjFO
         BHYh/pCpbfPlhKVSlxBal7PggrN31Z+aj7Lm9d0oQh4UqCOSz44hAk/vU7bQF/LArCHX
         SywYTVIql9ZrYVhdbzLOANGQtKRbNdvRVkkv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740389209; x=1740994009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9DwX5H0t5xZGrbvpWDysDlrDfS0kR6OfhPIwAFx6mo=;
        b=IwsytOlwD44/HlPJJDI1NXBZL8360jO82V1DaNHECLUYUnPcQ//geGaf6Ry19kmYF3
         ZV7FOxvCBbNXA4kR6Vecd/8wdx5/KpLawxMVEQz0D/E3lohWaaCNcLAHp9x6go23/hiu
         EQ/bK3D8j3u/Xe7GDVJcqIS2SMw8eLZagpynf5IywDwg+MVXzc3ry60qrx/fGwNnZonJ
         TLUdxmAcDFR8qIDsLVFZ1CIi63gyU6G8stGCgzEWYR8Q8Day2rhmCRHp0kcUnY2oY0uD
         ca8zCmu2x7aopM0ml4Dv1EZqLvJ2CVnCU6OwvcoMrt8LKfTKvWvVGTEcDg4x5zFnfGq0
         XDjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcr0seYeuYjBEg/K5JnIxStiojwunx5wbQCLABtBOYyCG/d7AGEcHA06CLSCcdQVDVegWOtmXGjpQVZ1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCh0eg2lC7+hMr8wWZiK6bWiKUoFSpo0HsW8OWqpE7UlT97iM1
	sCuXHQ2FtiX0zT0J4Cb+vKWBpVgaCD4s3qZ5wOTJzby/HmgLzq0WVOCTL00iH/WvkMdmoa2izU3
	//A==
X-Gm-Gg: ASbGncs1o5HV1tAOqzofUUiRSgDXgfBpvAtfYFOXv3lt56kiRxX30pTw7lbIov+8Vjg
	R5iuIp9bS2wERVbHPMn/A4Z8UyRK3Xp10HRziH5dJlBD5CT/WhgRNlvNkG2HxzFBpWKr/4/wIfv
	f/YNlhP+0zVBsWbfZxTlo1HFbRr2/33rfuBHnngyiBROqCW0jOIDQcAT05zHGx0KZraZ4EM+ztA
	z0jxaCg/E3y2dL2nOsLe8aJssMJhM+wxRA3Jpj8fI23s4v2uQ9s7pdkIgu4TXu8UkhK7amieDmY
	GCrArT1j+cXuQbTaXhBKXUjd25rUn1MfUfKRgDfJMVuYqP6Vu08p7B1mqBnq+GxuxkrT
X-Google-Smtp-Source: AGHT+IE36OYXxgN5bUd1ISnpCowjzuWl5K41xltZyeWXHnQvgP9Pi2kiIFnlkZEJ2j4ZGq3/QfOa6g==
X-Received: by 2002:a05:6512:1296:b0:545:3034:7b8 with SMTP id 2adb3069b0e04-54839147d71mr5367128e87.23.1740389208581;
        Mon, 24 Feb 2025 01:26:48 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5462c60f99fsm1721093e87.118.2025.02.24.01.26.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 01:26:47 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30613802a04so44301281fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 01:26:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXizL04EIj8IfNBQjEhIgt6U5MFbK+GH2og08ltKkJXFdwhPGnoRidP+h7BRxpkGL1GuNf7VJmuQ0X9OR8=@vger.kernel.org
X-Received: by 2002:a05:6512:3e14:b0:545:576:cbca with SMTP id
 2adb3069b0e04-5483912fcd7mr4198905e87.8.1740389206945; Mon, 24 Feb 2025
 01:26:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111-uvc-eaccess-v4-1-c7759bfd1bd4@chromium.org> <20250223170319.GA2821@pendragon.ideasonboard.com>
In-Reply-To: <20250223170319.GA2821@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 24 Feb 2025 10:26:34 +0100
X-Gmail-Original-Message-ID: <CANiDSCv1HVu82D=PoJFu=XCQ97k_MM1dmYpufkUCiKpSgGRT9w@mail.gmail.com>
X-Gm-Features: AWEUYZmvV4iGze7N3ugwoy0UYAWbTsMtuoDRa1uh5PWbgtlebItM-Je3dCsd9uI
Message-ID: <CANiDSCv1HVu82D=PoJFu=XCQ97k_MM1dmYpufkUCiKpSgGRT9w@mail.gmail.com>
Subject: Re: [PATCH v4] media: uvcvideo: Set V4L2_CTRL_FLAG_DISABLED during
 queryctrl errors
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 18:03, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Sat, Jan 11, 2025 at 09:57:21AM +0000, Ricardo Ribalda wrote:
> > To implement VIDIOC_QUERYCTRL, we need to know the minimum, maximum,
> > step and flags of the control. For some of the controls, this involves
> > querying the actual hardware.
> >
> > Some non-compliant cameras produce errors when we query them. Right now,
> > we populate that error to userspace. When an error happens, the v4l2
> > framework does not copy the v4l2_queryctrl struct to userspace. Also,
> > userspace apps are not ready to handle any other error than -EINVAL.
> >
> > One of the main usecases of VIDIOC_QUERYCTRL is enumerating the controls
> > of a device. This is done using the V4L2_CTRL_FLAG_NEXT_CTRL flag. In
> > that usecase, a non-compliant control will make it almost impossible to
> > enumerate all controls of the device.
> >
> > A control with an invalid max/min/step/flags is better than non being
> > able to enumerate the rest of the controls.
> >
> > This patch makes VIDIOC_QUERYCTRL return 0 in all the error cases
> > different than -EINVAL, introduces a warning in dmesg so we can
> > have a trace of what has happened and sets the V4L2_CTRL_FLAG_DISABLED.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Hi 2*Hans and Laurent!
> >
> > I came around a device that was listing just a couple of controls when
> > it should be listing much more.
> >
> > Some debugging latter I found that the device was returning -EIO when
> > all the focal controls were read.
> >
> > Lots of good arguments in favor/against this patch in the v1. Please
> > check!
> >
> > Without this patch:
> > $ v4l2-ctl --list-ctrls
> >                   auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=3 value=3 (Aperture Priority Mode)
> >          exposure_time_absolute 0x009a0902 (int)    : min=50 max=10000 step=1 default=166 value=166 flags=inactive
> >      exposure_dynamic_framerate 0x009a0903 (bool)   : default=0 value=0
> > region_of_interest_auto_control 0x009a1902 (bitmask): max=0x00000001 default=0x00000001 value=1
> >
> > With this patch:
> > $ v4l2-ctl --list-ctrls
> >                   auto_exposure 0x009a0901 (menu)   : min=0 max=3 default=3 value=3 (Aperture Priority Mode)
> >          exposure_time_absolute 0x009a0902 (int)    : min=50 max=10000 step=1 default=166 value=166 flags=inactive
> >      exposure_dynamic_framerate 0x009a0903 (bool)   : default=0 value=0
> > error 5 getting ext_ctrl Focus, Absolute
> > error 5 getting ext_ctrl Focus, Automatic Continuous
> >    region_of_interest_rectangle 0x009a1901 (unknown): type=107 value=unsupported payload type flags=has-payload
> > region_of_interest_auto_control 0x009a1902 (bitmask): max=0x00000001 default=0x00000001 value=1
> > --
> > ---
> > Changes in v4:
> > - Display control name (Thanks Hans)
> > - Link to v3: https://lore.kernel.org/r/20250107-uvc-eaccess-v3-1-99f3335d5133@chromium.org
> >
> > Changes in v3:
> > - Add a retry mechanism during error.
>
> This needs to be explained in the commit message, including when/why it
> helps, and why the retry count is 2.
>
> > - Set V4L2_CTRL_FLAG_DISABLED flag.
> > - Link to v2: https://lore.kernel.org/r/20241219-uvc-eaccess-v2-1-bf6520c8b86d@chromium.org
> >
> > Changes in v2:
> > - Never return error, even if we are not enumerating the controls
> > - Improve commit message.
> > - Link to v1: https://lore.kernel.org/r/20241213-uvc-eaccess-v1-1-62e0b4fcc634@chromium.org
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 43 ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 35 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 4e58476d305e..9d7812e8572d 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1280,6 +1280,8 @@ static u32 uvc_get_ctrl_bitmap(struct uvc_control *ctrl,
> >       return ~0;
> >  }
> >
> > +#define MAX_QUERY_RETRIES 2
> > +
> >  static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >       struct uvc_control *ctrl,
> >       struct uvc_control_mapping *mapping,
> > @@ -1305,19 +1307,44 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
> >               __uvc_find_control(ctrl->entity, mapping->master_id,
> >                                  &master_map, &master_ctrl, 0);
> >       if (master_ctrl && (master_ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR)) {
> > +             unsigned int retries;
> >               s32 val;
> > -             int ret = __uvc_ctrl_get(chain, master_ctrl, master_map, &val);
> > -             if (ret < 0)
> > -                     return ret;
> > +             int ret;
> >
> > -             if (val != mapping->master_manual)
> > -                             v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> > +             for (retries = 0; retries < MAX_QUERY_RETRIES; retries++) {
> > +                     ret = __uvc_ctrl_get(chain, master_ctrl, master_map,
> > +                                          &val);
> > +                     if (ret >= 0)
> > +                             break;
> > +             }
> > +
> > +             if (ret < 0) {
> > +                     dev_warn_ratelimited(&chain->dev->udev->dev,
> > +                                          "UVC non compliance: Error %d querying master control %x (%s)\n",
> > +                                           ret, master_map->id,
> > +                                           uvc_map_get_name(master_map));
> > +             } else if (val != mapping->master_manual) {
> > +                     v4l2_ctrl->flags |= V4L2_CTRL_FLAG_INACTIVE;
> > +             }
> >       }
> >
> >       if (!ctrl->cached) {
> > -             int ret = uvc_ctrl_populate_cache(chain, ctrl);
> > -             if (ret < 0)
> > -                     return ret;
> > +             unsigned int retries;
> > +             int ret;
> > +
> > +             for (retries = 0; retries < MAX_QUERY_RETRIES; retries++) {
> > +                     ret = uvc_ctrl_populate_cache(chain, ctrl);
> > +                     if (ret >= 0)
> > +                             break;
> > +             }
> > +
> > +             if (ret < 0) {
> > +                     dev_warn_ratelimited(&chain->dev->udev->dev,
> > +                                          "UVC non compliance: Error %d populating cache of control %x (%s)\n",
> > +                                          ret, mapping->id,
> > +                                          uvc_map_get_name(mapping));
> > +                     v4l2_ctrl->flags |= V4L2_CTRL_FLAG_DISABLED;
>
> Can we make the control permanently disabled ?

I'd rather not. In funky hardware the control might work with the
right combination of other controls.

>
> > +             }
> >       }
> >
> >       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_DEF) {
> >
> > ---
> > base-commit: c5aa327e10b194884a9c9001a751f6e4703bc3e3
> > change-id: 20241213-uvc-eaccess-755cc061a360
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

