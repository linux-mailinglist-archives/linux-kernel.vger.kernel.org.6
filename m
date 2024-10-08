Return-Path: <linux-kernel+bounces-355307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF6995052
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB491F25338
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355BB1DF279;
	Tue,  8 Oct 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W0TxXB4n"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA617C7C9
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394758; cv=none; b=R/OYNVz9pVlyHEla+NdKm2doFbLQcejrW9KeQJoIAZWlSC87DJrWTEBE3FGtcb+raGj2MR3Q7iHS16Nnz9gnQAklQcwbqoC45Hc9Si0Ngh/bQndcxllY6iVz2BWJ/3BwWqlI6wUvJfhs66+0Cm/g0TehL2g1/97HlSnHFm99tlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394758; c=relaxed/simple;
	bh=Zd3T6bzn7Ojoz7XwXtHF8m0sHj1ztUthQsDB0d8a8yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiH7esu91HggkfeQCstaH8/DtH/IAG1GE8FG/fNXamYmwnZKX14Mwx+JrjTrwjM6RzsQPuXV9LNx7UzbH0KiFxI/dKZCjexmzYMeuc3VvQqlKb+gu/cje+g5emJ+jvaugA3lYZnvyoPntUwJoqwbv+Hb5codpOWPimRurXUCVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W0TxXB4n; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82fa0ccb0cdso202156439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728394755; x=1728999555; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DABtECsaD1JUrTnKgPu7DrIocVWAbQQXo7xCEiHn2xo=;
        b=W0TxXB4nFoR04Fgj3wDAMIQYfoTVHoo2gOFu7XLDQTgMGPTVMVvVU1wIfBelFUm7pl
         gt87xCDlfhoi/VSyDjeddRU4tj5Uc18c5lEuKRw2DJwqJSshLh8uzBnrADoIvJaTQYJY
         RbUBdUu9LHvrOOLEykGjUzpZpuVYhfsfSdmAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394755; x=1728999555;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DABtECsaD1JUrTnKgPu7DrIocVWAbQQXo7xCEiHn2xo=;
        b=mbxnlDoIoxWY0nhJaLJZndYxzRpSz7/GQjzw+ghvK3ASovQNYxfRXXe+6538LLYTEx
         JfPugWELonzTmZ/5tlEHy3aOtNqBOB9bMTQpl28dFOAYsRdRHKfPpEzCDYc+XRAcVyb+
         ItP3IGscql+NexvZGx3LJ3TFukF6qKsg33t+D2revH28A96uF9VvViSLe3XGgtfNtVoi
         /UiGrrPzbVax/64KgwYSKeTEn75tBV2f3dhdxiTIEvn1R07KESMWodoaSwhc+QXhzuQC
         E5ss15IzprFlihdp9o7KhjcWQgUr6ZTnh3DE/93anSev+pYaV6StJvEG3OQJ73UqcEmL
         Mc5A==
X-Forwarded-Encrypted: i=1; AJvYcCXMG5MK4JkR2z6F9+6ugPdhBAKbiFkwvLPwtQuvkug9mpuRyCQgCgFYh8rSI9h5WNM+ySIAFtoCdzQ3QJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCR8npY+ydgTLZK4pd+lABAWWAwMfT0ldW4Jwx4PFUOKnlIZB
	Njo2oO5/rWGmdI1fcaMZneUUjp/mG70AvtyLRjeETDsKt0mniYcsAVPAPdrHLyjYqShbQsV8UHc
	=
X-Google-Smtp-Source: AGHT+IEuQSwTDwLfzC1FYh310ijWBY9tGI+Z/d/huaaH8VphRrCN3lMmwiQCqx0XMZQNdRqMo01rTg==
X-Received: by 2002:a05:6602:388e:b0:82a:418d:b03f with SMTP id ca18e2360f4ac-834f7ce5f66mr1514113239f.8.1728394755560;
        Tue, 08 Oct 2024 06:39:15 -0700 (PDT)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db924c4ad9sm537714173.17.2024.10.08.06.39.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:39:14 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so19305715ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:39:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtZylij/2lR1qFx8KDSFnwRPnVtQT0FJyimLm5ah6iH0ZaAbPLrRNt/YGW8WJFuKZZEydVHSsXz4RMxgQ=@vger.kernel.org
X-Received: by 2002:a05:6e02:180d:b0:3a3:67b1:3080 with SMTP id
 e9e14a558f8ab-3a375997255mr133117215ab.7.1728394753838; Tue, 08 Oct 2024
 06:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-uvc-readless-v1-0-042ac4581f44@chromium.org>
 <20241008-uvc-readless-v1-2-042ac4581f44@chromium.org> <ZwUfD5Kfzv93-46f@valkosipuli.retiisi.eu>
 <CANiDSCu5ho_CFCgRQVdUzaWtfSi_eNk+N7c-DGxcO+6Ks_Vmvg@mail.gmail.com> <ZwU0JyfBPRpkINCu@valkosipuli.retiisi.eu>
In-Reply-To: <ZwU0JyfBPRpkINCu@valkosipuli.retiisi.eu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Oct 2024 21:38:58 +0800
X-Gmail-Original-Message-ID: <CANiDSCs_VXgJ5pV7r_NFTbPfoOfvMGEq_X2woA0GgSx8=8nUeA@mail.gmail.com>
Message-ID: <CANiDSCs_VXgJ5pV7r_NFTbPfoOfvMGEq_X2woA0GgSx8=8nUeA@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: uvcvideo: Refactor uvc_query_ctrl
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 21:31, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> On Tue, Oct 08, 2024 at 09:22:25PM +0800, Ricardo Ribalda wrote:
> > Hi Sakari!
> >
> > On Tue, 8 Oct 2024 at 20:01, Sakari Ailus <sakari.ailus@iki.fi> wrote:
> > >
> > > Hi Ricardo,
> > >
> > > On Tue, Oct 08, 2024 at 07:06:15AM +0000, Ricardo Ribalda wrote:
> > > > Move the query control error logic to its own function.
> > > > There is no functional change introduced by this patch.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 45 ++++++++++++++++++++++-----------------
> > > >  1 file changed, 26 insertions(+), 19 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index 853dfb7b5f7b..a57272a2c9e1 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -67,30 +67,12 @@ static const char *uvc_query_name(u8 query)
> > > >       }
> > > >  }
> > > >
> > > > -int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > > -                     u8 intfnum, u8 cs, void *data, u16 size)
> > > > +static int uvc_query_ctrl_error(struct uvc_device *dev, u8 intfnum, void *data)
> > > >  {
> > > >       int ret;
> > > >       u8 error;
> > > >       u8 tmp;
> > > >
> > > > -     ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> > > > -                             UVC_CTRL_CONTROL_TIMEOUT);
> > > > -     if (likely(ret == size))
> > > > -             return 0;
> > > > -
> > > > -     if (ret > 0 && ret < size) {
> > > > -             memset(data + ret, 0, size - ret);
> > > > -             return 0;
> > > > -     }
> > > > -
> > > > -     if (ret != -EPIPE) {
> > > > -             dev_err(&dev->udev->dev,
> > > > -                     "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> > > > -                     uvc_query_name(query), cs, unit, ret, size);
> > > > -             return ret ? ret : -EPIPE;
> > > > -     }
> > > > -
> > > >       /* Reuse data[0] to request the error code. */
> > > >       tmp = *(u8 *)data;
> > > >
> > > > @@ -135,6 +117,31 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > >       return -EPIPE;
> > > >  }
> > > >
> > > > +int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > > > +                u8 intfnum, u8 cs, void *data, u16 size)
> > > > +{
> > > > +     int ret;
> > > > +
> > > > +     ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> > > > +                            UVC_CTRL_CONTROL_TIMEOUT);
> > > > +     if (likely(ret == size))
> > > > +             return 0;
> > > > +
> > > > +     if (ret == -EPIPE)
> > > > +             return uvc_query_ctrl_error(dev, intfnum, data);
> > > > +
> > > > +     dev_err(&dev->udev->dev,
> > > > +             "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> > > > +             uvc_query_name(query), cs, unit, ret, size);
> > >
> > > This message should probably be printed after the check below.
> >
> > If the device is returning less bytes, the hardware is not behaving
> > according to spec and it is good information, specially if you are
> > bringing up a new device.
> > I could make it  a dev_warn() (or even uvc_debug) if ret <size. WDYT?
>
> What I also came to think whether this is worth an explicit quirk flag.
> There could well be devices that have other bugs that would still fall
> under the same check.

Before https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/media/usb/uvc/uvc_video.c?id=a763b9fb58be869e252a7d33acb0a6390b01c801
we were accepting short reads and showing the error.
We are returning to the old behaviour, plus the memset.

A quirk will be difficult to maintain. If we can find a heuristics
that works I would vote for that.


>
> Either way, there should not be a message every single time this workaround
> is applied. Isn't uvc_query_ctrl() also used in some IOCTLs outside probe?

I have only seen this behaviour for GET_DEF, and that value is cached.
Meaning that the warning will only be shown once per control.

>
> >
> >
> > >
> > > I'd actually move the below check before the ret == -EPIPE check as it's a
> > > successful case (and changing the condition to <= would make the ret ==
> > > size check redundant).
> >
> > something like this?
> >
> > if (ret > 0)  {
> >    if (ret != size) {
> >       print_error();
> >       memcpy();
> >    }
> >    return 0;
> > }
>
> Well, if you think it's reasonable to keep the error message (should be a
> warning in that case IMO), then the original code makes sense.
>
> I wonder what Laurent thinks.
>
> >
> > >
> > > > +
> > > > +     if (ret > 0 && ret < size) {
> > > > +             memset(data + ret, 0, size - ret);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     return ret ? ret : -EPIPE;
> > > > +}
> > > > +
> > > >  static const struct usb_device_id elgato_cam_link_4k = {
> > > >       USB_DEVICE(0x0fd9, 0x0066)
> > > >  };
> > > >
> > >
>
> --
> Kind regards,
>
> Sakari Ailus



--
Ricardo Ribalda

