Return-Path: <linux-kernel+bounces-289269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D5954402
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A9D1F232D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F999139D0B;
	Fri, 16 Aug 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YCfEYCcm"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA814138490
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796464; cv=none; b=oea4g99NSfRWP3ukV8VXoa8dKxjN2cNRj8gvQR5RnpcISlz+7sT5jniSCOOcs5MOrH/6jJocEyB+lPJudlR1P1wy81nyMVcOg/4P4nfzJtgP45XNNvK8hNfp4fxkRb6V8Jk+XPj3EzlFw6mTFSsjgFOldzCSVSLHAxpBdjoGcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796464; c=relaxed/simple;
	bh=pjR5Rw759ocubFmIOUn73J03NLut28Juca+Qkhn2W0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBSVOAHwc/ugtKT4znvuRFG5cUQR0FD4hexWcq2k9PWAmXKRRgC4WSB/34c9Jat0F48IVsCLfEfkbgAcDU7o5/9AGDcIW6uVdus54e5JXwBw3vMVYMxsUPy4dN0JMSzwl2vgFcnfho398Hwy6EzjTyHoAUl4b4ic2RFCOVmxKTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YCfEYCcm; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5becd359800so495391a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723796461; x=1724401261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GnJ6TsYoSud9MApn7rwl8Z23Mz2pLw066Z6s9uY0Fr4=;
        b=YCfEYCcm0FgI9msQ6XNKSUZ4HTgErKbfSllRIAdvJGalaPLENchqTtiyrNO+de/hqz
         TbkAWDy6QJUmQOPuxO94lHj7cO15b+DwzHK9YyoH/BX3BO1+fNfA+r9ipXugRb1RaXpx
         LeUvkht9S4r46/4V4kdMI/vAkvbfmck6IBMAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796461; x=1724401261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnJ6TsYoSud9MApn7rwl8Z23Mz2pLw066Z6s9uY0Fr4=;
        b=G+vNhGp9cwScTaU/UP0+0bKCUi6OJIqgT8/UL93XXwWyA5KP3HODRV713mR6LuPGMT
         YrGOj/SQDr7PLT5spUHGnDtBdi6TpEO19pZqQ6v7csgjo0MMCj3q6xHCqo7AeG5h9Lix
         xX8O7YO6/pWdbKX8aUk5EuQTlqI7pC+aOQFKGIhVEy0azgaaiMg3ZmbvXVztcBqqlvhb
         +6QdGJfbINOca+0GIK2ch9/2JASokpSzRPj41Rv7h6ZcUH1aMYfT4xSlXwo8P4ZvmqLw
         UO8PYjBZ9cq3/uiqWm3SKUWxCYYMX3C09Dj6wlwVbJGQsZ6rxXMX8EQTz5PRKG786Km8
         X9lA==
X-Forwarded-Encrypted: i=1; AJvYcCWFRcmIbntc2kF3zoRRy3IYTryoDOlWupVigQ3NSkVVwKNnogP1mEdkqW+Wayfu1RSQinmjdJr4SrXBHto=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQvFwjBNSRXwvFlcS0i+FAMOcSHryyPKtWhayMxV6LxdPDhod
	souMxvOUunC4iGXooQXxidHImMX7vjjNNXPf+2M08ooVIMcSNYtXjH0iPq1J1daOXaqNaTXHLXc
	=
X-Google-Smtp-Source: AGHT+IHkrQ4hcWyTUF+v7M0UR77PIW5dJZDJcM2K7cCJjwb1m667B83ICpydTxF2aoGW+HuVBB6inw==
X-Received: by 2002:a17:906:f595:b0:a77:dd1c:6273 with SMTP id a640c23a62f3a-a83928a9930mr145305666b.12.1723796460808;
        Fri, 16 Aug 2024 01:21:00 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396cddfsm218981966b.199.2024.08.16.01.20.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 01:20:59 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a80eab3945eso196177666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:20:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWV+dk9gGqVXYpcS4N7pBv6Pgv8WUNE14uRdB1oNlEbvuNDfG+EuJH09zeBfhWHNhXhCyo0Th5RE+k1ENI=@vger.kernel.org
X-Received: by 2002:a17:907:86a4:b0:a7d:34bf:600e with SMTP id
 a640c23a62f3a-a8392a4a586mr121120766b.60.1723796459189; Fri, 16 Aug 2024
 01:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-coccinelle-followup-v2-0-88b4e4a9af56@chromium.org>
 <20240814-coccinelle-followup-v2-2-88b4e4a9af56@chromium.org> <20240816101642.5ef4e461@foz.lan>
In-Reply-To: <20240816101642.5ef4e461@foz.lan>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 16 Aug 2024 10:20:47 +0200
X-Gmail-Original-Message-ID: <CANiDSCtk=_Qb4aC15otZiUrdysV2h82ihbA2eP2kWyQSovq=MQ@mail.gmail.com>
Message-ID: <CANiDSCtk=_Qb4aC15otZiUrdysV2h82ihbA2eP2kWyQSovq=MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] media: drivers/media/dvb-core: Refactor
 dvb_frontend_open locking
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi Mauro

On Fri, 16 Aug 2024 at 10:17, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Wed, 14 Aug 2024 14:10:23 +0000
> Ricardo Ribalda <ribalda@chromium.org> escreveu:
>
> > Split out the wait function, and introduce some new toys: guard and
> > lockdep.
> >
> > This fixes the following cocci warnings:
> > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2776
> > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2786
> > drivers/media/dvb-core/dvb_frontend.c:2897:1-7: preceding lock on line 2809
>
> Hi Ricardo,

Hi Mauro

>
> Every time someone tries to fix this lock, we end having regression reports,
> because of the diversity of devices, and the way they registers there.
>
> That's specially true for devices with multiple frontends and custom
> zigzag methods.
>
> On what devices have you tested this patch?

I do not have access to any device, it is just "compiled tested".

I think that the patch is mainly a refactor, it does not really change
how the lock is handled.

Regards!


>
> Regards,
> Mauro
>
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/dvb-core/dvb_frontend.c | 58 ++++++++++++++++++++++-------------
> >  1 file changed, 37 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
> > index e81b9996530e..7f5d0c297464 100644
> > --- a/drivers/media/dvb-core/dvb_frontend.c
> > +++ b/drivers/media/dvb-core/dvb_frontend.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/ktime.h>
> >  #include <linux/compat.h>
> > +#include <linux/lockdep.h>
> >  #include <asm/processor.h>
> >
> >  #include <media/dvb_frontend.h>
> > @@ -2826,6 +2827,34 @@ static int __dvb_frontend_open(struct inode *inode, struct file *file)
> >       return ret;
> >  }
> >
> > +static int wait_dvb_frontend(struct dvb_adapter *adapter,
> > +                          struct dvb_device *mfedev)
> > +{
> > +     struct dvb_frontend *mfe = mfedev->priv;
> > +     struct dvb_frontend_private *mfepriv = mfe->frontend_priv;
> > +     int mferetry = (dvb_mfe_wait_time << 1);
> > +     int ret = 0;
> > +
> > +     lockdep_assert_held(&adapter->mfe_lock);
> > +
> > +     if (mfedev->users == -1 && !mfepriv->thread)
> > +             return 0;
> > +
> > +     mutex_unlock(&adapter->mfe_lock);
> > +
> > +     while (mferetry-- && (mfedev->users != -1 || mfepriv->thread)) {
> > +             if (msleep_interruptible(500))
> > +                     if (signal_pending(current)) {
> > +                             ret = -EINTR;
> > +                             break;
> > +                     }
> > +     }
> > +
> > +     mutex_lock(&adapter->mfe_lock);
> > +
> > +     return ret;
> > +}
> > +
> >  static int dvb_frontend_open(struct inode *inode, struct file *file)
> >  {
> >       struct dvb_device *dvbdev = file->private_data;
> > @@ -2840,19 +2869,16 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
> >       if (!adapter->mfe_shared)
> >               return __dvb_frontend_open(inode, file);
> >
> > +     guard(mutex)(&adapter->mfe_lock);
> > +
> >       if (adapter->mfe_shared == 2) {
> > -             mutex_lock(&adapter->mfe_lock);
> >               if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
> >                       if (adapter->mfe_dvbdev &&
> > -                         !adapter->mfe_dvbdev->writers) {
> > -                             mutex_unlock(&adapter->mfe_lock);
> > +                         !adapter->mfe_dvbdev->writers)
> >                               return -EBUSY;
> > -                     }
> >                       adapter->mfe_dvbdev = dvbdev;
> >               }
> >       } else {
> > -             mutex_lock(&adapter->mfe_lock);
> > -
> >               if (!adapter->mfe_dvbdev) {
> >                       adapter->mfe_dvbdev = dvbdev;
> >               } else if (adapter->mfe_dvbdev != dvbdev) {
> > @@ -2862,34 +2888,24 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
> >                               *mfe = mfedev->priv;
> >                       struct dvb_frontend_private
> >                               *mfepriv = mfe->frontend_priv;
> > -                     int mferetry = (dvb_mfe_wait_time << 1);
> > -
> > -                     mutex_unlock(&adapter->mfe_lock);
> > -                     while (mferetry-- && (mfedev->users != -1 ||
> > -                                           mfepriv->thread)) {
> > -                             if (msleep_interruptible(500)) {
> > -                                     if (signal_pending(current))
> > -                                             return -EINTR;
> > -                             }
> > -                     }
> >
> > -                     mutex_lock(&adapter->mfe_lock);
> > +                     ret = wait_dvb_frontend(adapter, mfedev);
> > +                     if (ret)
> > +                             return ret;
> > +
> >                       if (adapter->mfe_dvbdev != dvbdev) {
> >                               mfedev = adapter->mfe_dvbdev;
> >                               mfe = mfedev->priv;
> >                               mfepriv = mfe->frontend_priv;
> >                               if (mfedev->users != -1 ||
> > -                                 mfepriv->thread) {
> > -                                     mutex_unlock(&adapter->mfe_lock);
> > +                                 mfepriv->thread)
> >                                       return -EBUSY;
> > -                             }
> >                               adapter->mfe_dvbdev = dvbdev;
> >                       }
> >               }
> >       }
> >
> >       ret = __dvb_frontend_open(inode, file);
> > -     mutex_unlock(&adapter->mfe_lock);
> >
> >       return ret;
> >  }
> >
>
>
>
> Thanks,
> Mauro



-- 
Ricardo Ribalda

