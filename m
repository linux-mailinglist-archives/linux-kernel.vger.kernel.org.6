Return-Path: <linux-kernel+bounces-209465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029229035F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF421C249A6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E16175543;
	Tue, 11 Jun 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lkhatxar"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BC4174EC6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094176; cv=none; b=B065pZ2nQBruQAyxDCGmkk3P4RaHW/dpV0LBsZnlCm5jqK2oY0kI/AFKvLCMqAkV4RpVSpJFQ4LekIyRKXwHfUF6vGCmOiHOoBqX3xXEMRnrivLVncVx/pAFgCFw8wH+DF+ZC5dinta7YZlmll5S6+ePmhq/LXugqThz5qDWWTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094176; c=relaxed/simple;
	bh=2XAFiadYrV3QUNrS4ge3SZ4AfiKx6M85T5QxAY2S2vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6KOWsZaAqENMOGKQEL5FDYJzOMnyTRys6FBTXP3MK8NTVEaKux6hEfCVHAubztIJkOppxDFtbLpN3LX0TwVwA1BwlhDn6kkcNvIqvkDst0n1txQpN/9MD6sORJK1t/jhvxSn3DNTj1P9hQxiQ32iziDwNkuO5NA8rrM+pogN8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lkhatxar; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c9034860dso1560943e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718094171; x=1718698971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NwKyuq+nR/2yqMTGVhsfCBfUIKD3cD0xRRIgm5IZyDs=;
        b=lkhatxarcHoCwK6/XibpQaLekwyC4JPrHgf9wQGrJGGPQamnoY7P3ojEpvWj77YotP
         IFikZktRUfgA3nYsWAnKP1pZgR0qN00wWZy57QahNCydN+vjQh3Ahs2L1VkVJUM2tlKP
         v/ZORLbjq69gF3mB2g/fsVVf1GYcvbelDSEXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094171; x=1718698971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwKyuq+nR/2yqMTGVhsfCBfUIKD3cD0xRRIgm5IZyDs=;
        b=jzi4Ix2+pfmdd3jv9vovn2ET295kfLvSNf3BVGXj8jxaiIc8YGolUDAVn8m83/MtXS
         KMly0s7RChKybMxqyiPbRL7Zr1fRGsm8szR1Tidf1u/c37EeKOML++J++MPrl87+ufTr
         xKIY9SNM8fr5IYXti/JQFzs4R0tLxRM3tEpC26h5jiR0oD/UG9ORI4KAfpDbWtGnKDMt
         /548k4geCJy7Id/OuxjrUJpsRDYZa6f6/iA5cUky3hfWKNAsWsyVlUT9zTR3u+yABXZR
         qmG16k0wopLMzdNvRW2Z6obcoxh0OCEZ0fGL892h1Oq4Y1BXwXvQr92BXjeLGcdKRk/N
         xwLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFVFDCkZaRwWt+J3s76MqjKIpIhDkwzJNWtmscSB2X72wctXkxQFWvyYp1HQdtzgRuuj6Wsb83jT7ghuWqilzlS65koLZBDlnAe2z
X-Gm-Message-State: AOJu0YwlQd4aeePwfrspKDXK5JjAA0EyPnOoTEQZZOcGSgd6PpG7JiBH
	TX2tB0NU8wT3glh+6hUkeN/ORB7ichb9wPSuY6DaBREGeMv+t8QaS610H9akbDmyyrAliDx8Xr/
	qJgbP
X-Google-Smtp-Source: AGHT+IHxpjxWUHzGcbJHDHEj4rZLr9vn64Yn2OcOUtCJv6OXDXkfam/0M8nTvkZeXp2nxuseE9YunQ==
X-Received: by 2002:ac2:596d:0:b0:52b:c33a:aa7c with SMTP id 2adb3069b0e04-52bc33aab89mr6772783e87.65.1718094171585;
        Tue, 11 Jun 2024 01:22:51 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c94146d21sm204817e87.24.2024.06.11.01.22.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 01:22:50 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so105024381fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:22:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDtt1kNiP1Rgpd4OxpW88LxFDUrY7HeIjhBhvZX9yDl45sckcoyLlqPIrmCtabBckgoF6y3BW82+TcDPLlfzvhjouepAYMjcH2oOh1
X-Received: by 2002:ac2:5e67:0:b0:52c:83f6:1141 with SMTP id
 2adb3069b0e04-52c83f61df0mr4769880e87.39.1718094170412; Tue, 11 Jun 2024
 01:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-billion-v1-0-2f7bc0ee2030@chromium.org>
 <20240318-billion-v1-3-2f7bc0ee2030@chromium.org> <20240610141402.GB13744@pendragon.ideasonboard.com>
 <CANiDSCsNdZyKMM82q9SqZ-hQH2Pch24rVCqSs=L6mFL=RbJqQg@mail.gmail.com> <20240610234750.GC31989@pendragon.ideasonboard.com>
In-Reply-To: <20240610234750.GC31989@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 11 Jun 2024 10:22:39 +0200
X-Gmail-Original-Message-ID: <CANiDSCt9N4d889DRtns_6c-66qb9ZSLWsWEhUNNuPBZ4-mY_tQ@mail.gmail.com>
Message-ID: <CANiDSCt9N4d889DRtns_6c-66qb9ZSLWsWEhUNNuPBZ4-mY_tQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] media: uvcvideo: Probe the PLF characteristics
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Tue, 11 Jun 2024 at 01:48, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Mon, Jun 10, 2024 at 11:51:55PM +0200, Ricardo Ribalda wrote:
> > On Mon, 10 Jun 2024 at 16:14, Laurent Pinchart wrote:
> > > On Mon, Mar 18, 2024 at 11:55:25PM +0000, Ricardo Ribalda wrote:
> > > > The UVC 1.5 standard defines 4 values for the PLF control: Off, 50Hz,
> > > > 60Hz and Auto. But it does not clearly define if all the values must be
> > > > implemented or not.
> > > >
> > > > Instead of just using the UVC version to determine what the PLF control
> > > > can do, probe it.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 54 +++++++++++++++++++++++++++++++++++++---
> > > >  1 file changed, 50 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 67522143c6c85..9a0b81aca30d1 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -501,12 +501,58 @@ static int __uvc_ctrl_add_mapping(struct uvc_video_chain *chain,
> > > >  static int uvc_ctrl_add_plf_mapping(struct uvc_video_chain *chain,
> > > >       struct uvc_control *ctrl, const struct uvc_control_mapping *mapping)
> > > >  {
> > > > +     const struct uvc_control_mapping *out_mapping =
> > > > +                                     &uvc_ctrl_power_line_mapping_uvc11;
> > > > +     u8 init_val;
> > > > +     u8 *buf;
> > >
> > >         u8 *buf __free(kfree) = NULL;
> > >
> > > will simplify the exit paths.
> > >
> > > > +     int ret;
> > > > +
> > > > +     buf = kmalloc(sizeof(*buf), GFP_KERNEL);
> > > > +     if (!buf)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     /* Save the default PLF value, so we can restore it. */
> > > > +     ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
> > > > +                          chain->dev->intfnum, ctrl->info.selector,
> > > > +                          buf, sizeof(*buf));
> > >
> > > That's the current value, not the default. Is that intended ?
> >
> > Yes, the driver does not init the other controls to the default value.
> > So I'd rather be consistent.
>
> I'm fine with that, let's update the comment to "Save the current PLF
> value".

done in my tree, if there is a v3 I will fix it, otherwise you are
free to modify it if you want ;)


>
> > > > +     /* If we cannot read the control skip it. */
> > > > +     if (ret) {
> > > > +             kfree(buf);
> > > > +             return ret;
> > > > +     }
> > > > +     init_val = *buf;
> > > > +
> > > > +     /* If PLF value cannot be set to off, it is limited. */
> > > > +     *buf = V4L2_CID_POWER_LINE_FREQUENCY_DISABLED;
> > > > +     ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
> > > > +                          chain->dev->intfnum, ctrl->info.selector,
> > > > +                          buf, sizeof(*buf));
> > > > +     if (ret) {
> > > > +             out_mapping = &uvc_ctrl_power_line_mapping_limited;
> > > > +             goto end;
> > >
> > > If setting the value failed you don't need to restore it, do you ?
> > >
> > > > +     }
> > > > +
> > > > +     /* UVC 1.1 does not define auto, we can exit. */
> > > >       if (chain->dev->uvc_version < 0x150)
> > > > -             return __uvc_ctrl_add_mapping(chain, ctrl,
> > > > -                                           &uvc_ctrl_power_line_mapping_uvc11);
> > > > +             goto end;
> > > > +
> > > > +     /* Check if the device supports auto. */
> > > > +     *buf = V4L2_CID_POWER_LINE_FREQUENCY_AUTO;
> > > > +     ret = uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
> > > > +                          chain->dev->intfnum, ctrl->info.selector,
> > > > +                          buf, sizeof(*buf));
> > >
> > > Now for the real annoying question. I've encountered quite a few devices
> > > that would crash when the driver tried to get/set lots of controls at
> > > probe time. This is why the control cache is populated the first time a
> > > control is queried, and not when the device is probed. I'm always
> > > worried when adding more control accesses at probe time that some
> > > devices will behave improperly.
> >
> > If we encounter a device like that we could quirk it.
>
> Now we could place bets on what is less likely to scale, quirking
> devices that have a bad PLF implementation, or quirking devices whose
> firmware will crash when queried too much at probe time :-)

:)

>
> > > Given the number of UVC users I tend to be on the conservative side, but
> > > obviously, if we were to strictly avoid new access patterns to the
> > > device, the driver wouldn't be able to evolve. I do like patches 4/5 and
> > > 5/5, so I'm tempted to take the risk and revert this series later if
> > > needed. That would likely make some other users unhappy if they rely on
> > > the heuristic.
> > >
> > > Another issue is how to get vendors to implement the power line
> > > frequency control correctly. With the series applied, vendors won't
> > > notice they're doing something wrong. Of course, they probably don't
> > > check the behaviour of their devices with Linux in the first place, so
> > > I'm not sure what we could do.
> >
> > We can add the check to v4l2-compliance....
> >
> > Although I would love to see a uvc-compliance tool. If the tool can be
> > easily run in windows/linux without a driver I guess ISP vendors will
> > run it to validate their code.
>
> *without a driver* is doable with libusb but would be *lots* of work,
> basically duplicating the whole uvcvideo driver in userspace. That's not
> a project I would start, but it would be interesting.
>
> > Right now there is no way to validate a usb camera beyond: it runs in
> > windows and in cheese.
>
> Isn't the USB-IF supposed to have a compliance test suite ? Given all
> the broken devices we hear about, it must either not be very good, or
> not be used by vendors.

At least there is no public compliance test suite, and if third
parties cannot validate the results the test is not very useful.

>
> I think a compliance tool based on top of the uvcvideo kernel driver
> would already be a good step forward.
>
> > > > +     if (!ret)
> > > > +             out_mapping = &uvc_ctrl_power_line_mapping_uvc15;
> > > > +
> > > > +end:
> > > > +     /* Restore initial value and add mapping. */
> > > > +     *buf = init_val;
> > > > +     uvc_query_ctrl(chain->dev, UVC_SET_CUR, ctrl->entity->id,
> > > > +                    chain->dev->intfnum, ctrl->info.selector,
> > > > +                    buf, sizeof(*buf));
> > > >
> > > > -     return __uvc_ctrl_add_mapping(chain, ctrl,
> > > > -                                   &uvc_ctrl_power_line_mapping_uvc15);
> > > > +     kfree(buf);
> > > > +     return __uvc_ctrl_add_mapping(chain, ctrl, out_mapping);
> > > >  }
> > > >
> > > >  static const struct uvc_control_mapping uvc_ctrl_mappings[] = {
>
> --
> Regards,
>
> Laurent Pinchart

Regards!

-- 
Ricardo Ribalda

