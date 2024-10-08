Return-Path: <linux-kernel+bounces-355270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A496C994F0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D66C51C257A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2741DF96F;
	Tue,  8 Oct 2024 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JCKXnkcg"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689CF1DF263
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393766; cv=none; b=AAtyBIjC666QesEMIp5/nfuAUCOUzERYWBLW4IxEC9BsRbOLvGa8gKvuLbtOniDRF2EuP+Pb63p8jIqG5OVRzOD76xNMODJ0k/iJsVBq2JbGYbhfIrG/0g04Vfh0+kpLdDS7FB66YOyKkL0Zrh5m1xnS6jY0I2jPdKsxg7IAWlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393766; c=relaxed/simple;
	bh=IaSxTJVH8rLiGz+Akwwe7esOk3xEGpN0J/uq/JOdPeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLjXxLKpReG+EITUjcnWRG140F/4xp/hEn7WB8F/ovO2dSOHdcYZHrOgmtE6DopkFqXwVgP79u8lLW7kJHH7DoxbnRFKq0KlhOMkxfTXlkYWYq8WURWnqYuYMbmhJK6cL4v8b01aDX+PWMJ5Tl1J4ZVJHDuE9bxtT7yQ1MI3DRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JCKXnkcg; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-207115e3056so51534935ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728393763; x=1728998563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0cPHVOjNUekqHlnnGcgVTBAAITQgOdA1jICMR0w+xYg=;
        b=JCKXnkcgkuB4U5fErieerDuXJOTWkJG/Lm9adFDgMujXsIRtTWTLhxV5PDgHwWJtRa
         s5Rkm1KfxFgMF6BjMJ4cHq4/bxoLJveBxv20/jegR5vSbbOYsJjVEgMLReT/1zbYpJaj
         kPR9Mnqnlf6E+u1fdick/mqaq/LJApfthvoNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728393763; x=1728998563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cPHVOjNUekqHlnnGcgVTBAAITQgOdA1jICMR0w+xYg=;
        b=Sa5Mr5kmMEH0UAxjwKXJWfhb1aKzEy2L2uqA0tk2NLXsG2qAbH/AK7USLJ9x/IYbym
         Xu+0RQyBHjGIJRPVgFD5pWEUDcYWPBg5uL35AsU4JHm2odB9WmUBY9V3vH5iIOOeigKF
         tBkUZrS9xCf+Gwb607NMn6diA68IjWw/ZBfaafqyLf07CbBX+Wx0ydDe0MDFqxNtp1lc
         tkFLvtPl5XME0GQ84jp+NJ39T4QqPJfQZxrYV04qynHAeITaN7jeKAHkhPyx7AaQHXO3
         Jsz9n6N/F23qTeIVju2/f3GR5iZuOGFnrEEmf4prgp+0ox1+FlRSHxnei6O4twX9IckV
         7wdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcFWjX46RIPqeo4iKO8zxu56Vc7rQ6GPzPwdKnjoctudGdRDKXEwuFwmqqbNQtzanXwxmloCsbZNq96cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9HCEU9t5HeOqw+O7nN3JUVJfRi4Q+UB0v+krGENP4ZONqzueQ
	n45zPL0YZLLoIyJJyT7jHXpP2DWNxlXez7M60gdwI896rz0ZjJNYr1vjdVSDL1Im9KJ4+3MX870
	=
X-Google-Smtp-Source: AGHT+IF0otMr1vdatoLRE1owIPaiibCGP6jcf0eziLpCeAhf+Cqf9iTtnJGthsQoz6JeoI2UXB90kQ==
X-Received: by 2002:a17:902:db0e:b0:20b:a5b5:b89 with SMTP id d9443c01a7336-20bfe495d34mr223121065ad.35.1728393763370;
        Tue, 08 Oct 2024 06:22:43 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af9f7sm55614315ad.13.2024.10.08.06.22.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 06:22:41 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e221a7e7baso1830301a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 06:22:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXduISbRZyKZ4vQ8Oro3pVpi94TAJrdwhU6q5drBNWgVPUXzGcJRchLgWuIwd+OXydKPbQ+Cdq2fu4rzo=@vger.kernel.org
X-Received: by 2002:a17:90a:70ce:b0:2e2:8744:716 with SMTP id
 98e67ed59e1d1-2e287440979mr2627293a91.3.1728393760730; Tue, 08 Oct 2024
 06:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-uvc-readless-v1-0-042ac4581f44@chromium.org>
 <20241008-uvc-readless-v1-2-042ac4581f44@chromium.org> <ZwUfD5Kfzv93-46f@valkosipuli.retiisi.eu>
In-Reply-To: <ZwUfD5Kfzv93-46f@valkosipuli.retiisi.eu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 8 Oct 2024 21:22:25 +0800
X-Gmail-Original-Message-ID: <CANiDSCu5ho_CFCgRQVdUzaWtfSi_eNk+N7c-DGxcO+6Ks_Vmvg@mail.gmail.com>
Message-ID: <CANiDSCu5ho_CFCgRQVdUzaWtfSi_eNk+N7c-DGxcO+6Ks_Vmvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: uvcvideo: Refactor uvc_query_ctrl
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sakari!

On Tue, 8 Oct 2024 at 20:01, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Ricardo,
>
> On Tue, Oct 08, 2024 at 07:06:15AM +0000, Ricardo Ribalda wrote:
> > Move the query control error logic to its own function.
> > There is no functional change introduced by this patch.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 45 ++++++++++++++++++++++-----------------
> >  1 file changed, 26 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 853dfb7b5f7b..a57272a2c9e1 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -67,30 +67,12 @@ static const char *uvc_query_name(u8 query)
> >       }
> >  }
> >
> > -int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > -                     u8 intfnum, u8 cs, void *data, u16 size)
> > +static int uvc_query_ctrl_error(struct uvc_device *dev, u8 intfnum, void *data)
> >  {
> >       int ret;
> >       u8 error;
> >       u8 tmp;
> >
> > -     ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> > -                             UVC_CTRL_CONTROL_TIMEOUT);
> > -     if (likely(ret == size))
> > -             return 0;
> > -
> > -     if (ret > 0 && ret < size) {
> > -             memset(data + ret, 0, size - ret);
> > -             return 0;
> > -     }
> > -
> > -     if (ret != -EPIPE) {
> > -             dev_err(&dev->udev->dev,
> > -                     "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> > -                     uvc_query_name(query), cs, unit, ret, size);
> > -             return ret ? ret : -EPIPE;
> > -     }
> > -
> >       /* Reuse data[0] to request the error code. */
> >       tmp = *(u8 *)data;
> >
> > @@ -135,6 +117,31 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> >       return -EPIPE;
> >  }
> >
> > +int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
> > +                u8 intfnum, u8 cs, void *data, u16 size)
> > +{
> > +     int ret;
> > +
> > +     ret = __uvc_query_ctrl(dev, query, unit, intfnum, cs, data, size,
> > +                            UVC_CTRL_CONTROL_TIMEOUT);
> > +     if (likely(ret == size))
> > +             return 0;
> > +
> > +     if (ret == -EPIPE)
> > +             return uvc_query_ctrl_error(dev, intfnum, data);
> > +
> > +     dev_err(&dev->udev->dev,
> > +             "Failed to query (%s) UVC control %u on unit %u: %d (exp. %u).\n",
> > +             uvc_query_name(query), cs, unit, ret, size);
>
> This message should probably be printed after the check below.

If the device is returning less bytes, the hardware is not behaving
according to spec and it is good information, specially if you are
bringing up a new device.
I could make it  a dev_warn() (or even uvc_debug) if ret <size. WDYT?


>
> I'd actually move the below check before the ret == -EPIPE check as it's a
> successful case (and changing the condition to <= would make the ret ==
> size check redundant).

something like this?

if (ret > 0)  {
   if (ret != size) {
      print_error();
      memcpy();
   }
   return 0;
}

>
> > +
> > +     if (ret > 0 && ret < size) {
> > +             memset(data + ret, 0, size - ret);
> > +             return 0;
> > +     }
> > +
> > +     return ret ? ret : -EPIPE;
> > +}
> > +
> >  static const struct usb_device_id elgato_cam_link_4k = {
> >       USB_DEVICE(0x0fd9, 0x0066)
> >  };
> >
>
> --
> Kind regards,
>
> Sakari Ailus



-- 
Ricardo Ribalda

