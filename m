Return-Path: <linux-kernel+bounces-289647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76269548BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7371C23295
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3664C1B86C0;
	Fri, 16 Aug 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eaE3qJFd"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B74196D80
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811434; cv=none; b=Z9s37XK1H3Rtc1Z7bgpZUQIXdSkzyjxWNVd1pPUlFjKsjGM0FdVKDwLgRRATvG7HcuDjey97PjYw009qcG4DuVTkYrjcVichFpD7/BQD44uDrpO7AOx5mJEk3Ex2JXZ9z4aR0Uz3D8Dbevqomd1lyCJRMDNB+dTCGxcokjGHdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811434; c=relaxed/simple;
	bh=2GSzoiyKMiwuW/RfJJ5i8kkgbzhghA4P1g2K4QpBjLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZscARAHALNUKBsaR+DR7H0EqVNnaQ2j9g/20Vhzp0BOdAoduOqzG4QBHX7pdTbNCodY2mH+XoTkA15aabMA0U4n6mD41lc0M8ic4td+/yewjvtY+VquIm4RBKYdoBksJjmhWfpJ9dg234r13JlxEx4b2M0FTSTf4wKi6XkcjEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eaE3qJFd; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so433303a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723811430; x=1724416230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/zsQ2AT0Bnh8gAvOcK04FWb59JsFbwO7jWLVExppFh0=;
        b=eaE3qJFdesj1pC+Y5cJWfcv0dbu5oS+CJ2VNvC8m5yGEsJasnHCL77MM3P4Varo+fN
         rj9Mke18Gc5fMRs3MHYUM5CszM3AMOxWpybuJrHoGQqA6I+jmcJRc91c33hxowtfhDIM
         IpvCDTZXxoQbR38sgfnZjCVXZRI4ln+kXiBCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811430; x=1724416230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zsQ2AT0Bnh8gAvOcK04FWb59JsFbwO7jWLVExppFh0=;
        b=qLZlL6N10uCINKmysTfA9BHYzZDdFHVz4pi6SxmXhQLlToJPYOzJb/SMlfUk4/EmTi
         IWEvm/FQT2YpZh75Ef5NaMsQM2H+c3Iph1EfmUUy6U/1k2OTT0BHlGXk2yGdyrYIYxol
         rHqrjMnYmbumEPwwpJ0nIwIhOhFKa8H22v2fcNR6e5beoJJ3VP93fPD+LtQRpEybs9zj
         1YSHVy+zVAvbamafPBvr9+1XHM/XojV0VOJwnMumUnhbbeHVefI0RjHJCVU/04EmzufH
         fy6mGhR2lkkNjCtKY/PlSpDrsqbltYQeeBA6uZc7CQGLga49HlE/xqUXKFhXxaidg8SK
         bHbg==
X-Forwarded-Encrypted: i=1; AJvYcCW2mMI1bpd7GV+n7OZn9MMA6xp4kKHcFRdz0L7tyPYKYIJstjZRLhmFooLlsguU97WOxrvGSEKvANJBAuEERVusVDLinXYP5lruapNc
X-Gm-Message-State: AOJu0YwPiisDwZ1w1mY/o3dMu+823rGeR/XpzqQzLUMaVJ0/OTPE4TKa
	WrBay/EY0F1skxqT6K1Y6w1bMuIZ70DuXX/wc/F/JtnsVr2DNJ+rz39G8NbesxuCYtdVQJPme5Y
	AWg==
X-Google-Smtp-Source: AGHT+IGpErvoAmtKdS5runhft5+ASZYK2TX8zBM8o04jqSGgv09mBUYaCF1XVq5Iw5jyjixfaxxNHw==
X-Received: by 2002:a17:907:efe0:b0:a7a:aa35:409a with SMTP id a640c23a62f3a-a8392a4b317mr191946266b.68.1723811430091;
        Fri, 16 Aug 2024 05:30:30 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6b07sm249259966b.30.2024.08.16.05.30.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 05:30:29 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5becc379f3fso783381a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:30:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1+wdxxnWiuvrgJtYTGQlmLrxo5rXyjWFwzA3FaMnitPqbAaekcn+fKQuQetvI9e/YTcqMlF9/knsW1IUdED699DLwmZLTifPZwuZv
X-Received: by 2002:a17:907:da2:b0:a7a:bbbb:6243 with SMTP id
 a640c23a62f3a-a8392a15b4bmr192355066b.51.1723811428946; Fri, 16 Aug 2024
 05:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-coccinelle-followup-v2-0-88b4e4a9af56@chromium.org> <20240814-coccinelle-followup-v2-1-88b4e4a9af56@chromium.org>
In-Reply-To: <20240814-coccinelle-followup-v2-1-88b4e4a9af56@chromium.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 16 Aug 2024 14:30:16 +0200
X-Gmail-Original-Message-ID: <CANiDSCuOmE32Hhw6QC7jfO+gPauxOrPZis-4NhDL8eXO1a_JWg@mail.gmail.com>
Message-ID: <CANiDSCuOmE32Hhw6QC7jfO+gPauxOrPZis-4NhDL8eXO1a_JWg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: drivers/media/dvb-core: Split dvb_frontend_open()
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, 14 Aug 2024 at 16:10, Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Move the actual opening to its own function.
>
> Not intended code change. This is a preparation for the next patch.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/dvb-core/dvb_frontend.c | 143 +++++++++++++++++-----------------
>  1 file changed, 70 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
> index 4f78f30b3646..e81b9996530e 100644
> --- a/drivers/media/dvb-core/dvb_frontend.c
> +++ b/drivers/media/dvb-core/dvb_frontend.c
> @@ -2760,80 +2760,13 @@ static __poll_t dvb_frontend_poll(struct file *file, struct poll_table_struct *w
>         return 0;
>  }
>
> -static int dvb_frontend_open(struct inode *inode, struct file *file)
> +static int __dvb_frontend_open(struct inode *inode, struct file *file)
>  {
>         struct dvb_device *dvbdev = file->private_data;
>         struct dvb_frontend *fe = dvbdev->priv;
>         struct dvb_frontend_private *fepriv = fe->frontend_priv;
> -       struct dvb_adapter *adapter = fe->dvb;
>         int ret;
>
> -       dev_dbg(fe->dvb->device, "%s:\n", __func__);
> -       if (fe->exit == DVB_FE_DEVICE_REMOVED)
> -               return -ENODEV;
> -
> -       if (adapter->mfe_shared == 2) {
> -               mutex_lock(&adapter->mfe_lock);
> -               if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
> -                       if (adapter->mfe_dvbdev &&
> -                           !adapter->mfe_dvbdev->writers) {
> -                               mutex_unlock(&adapter->mfe_lock);
> -                               return -EBUSY;
> -                       }
> -                       adapter->mfe_dvbdev = dvbdev;
> -               }
> -       } else if (adapter->mfe_shared) {
> -               mutex_lock(&adapter->mfe_lock);
> -
> -               if (!adapter->mfe_dvbdev)
> -                       adapter->mfe_dvbdev = dvbdev;
> -
> -               else if (adapter->mfe_dvbdev != dvbdev) {
> -                       struct dvb_device
> -                               *mfedev = adapter->mfe_dvbdev;
> -                       struct dvb_frontend
> -                               *mfe = mfedev->priv;
> -                       struct dvb_frontend_private
> -                               *mfepriv = mfe->frontend_priv;
> -                       int mferetry = (dvb_mfe_wait_time << 1);
> -
> -                       mutex_unlock(&adapter->mfe_lock);
> -                       while (mferetry-- && (mfedev->users != -1 ||
> -                                             mfepriv->thread)) {
> -                               if (msleep_interruptible(500)) {
> -                                       if (signal_pending(current))
> -                                               return -EINTR;
> -                               }
> -                       }
> -
> -                       mutex_lock(&adapter->mfe_lock);
> -                       if (adapter->mfe_dvbdev != dvbdev) {
> -                               mfedev = adapter->mfe_dvbdev;
> -                               mfe = mfedev->priv;
> -                               mfepriv = mfe->frontend_priv;
> -                               if (mfedev->users != -1 ||
> -                                   mfepriv->thread) {
> -                                       mutex_unlock(&adapter->mfe_lock);
> -                                       return -EBUSY;
> -                               }
> -                               adapter->mfe_dvbdev = dvbdev;
> -                       }
> -               }
> -       }
> -
> -       if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl) {
> -               if ((ret = fe->ops.ts_bus_ctrl(fe, 1)) < 0)
> -                       goto err0;
> -
> -               /* If we took control of the bus, we need to force
> -                  reinitialization.  This is because many ts_bus_ctrl()
> -                  functions strobe the RESET pin on the demod, and if the
> -                  frontend thread already exists then the dvb_init() routine
> -                  won't get called (which is what usually does initial
> -                  register configuration). */
> -               fepriv->reinitialise = 1;
> -       }

This branch was missing in the patch. I will send a new version.

Hopefuly someone with access to the hardware can test it?


> -
>         if ((ret = dvb_generic_open(inode, file)) < 0)
>                 goto err1;
>
> @@ -2871,8 +2804,6 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
>
>         dvb_frontend_get(fe);
>
> -       if (adapter->mfe_shared)
> -               mutex_unlock(&adapter->mfe_lock);
>         return ret;
>
>  err3:
> @@ -2891,9 +2822,75 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
>  err1:
>         if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl)
>                 fe->ops.ts_bus_ctrl(fe, 0);
> -err0:
> -       if (adapter->mfe_shared)
> -               mutex_unlock(&adapter->mfe_lock);
> +
> +       return ret;
> +}
> +
> +static int dvb_frontend_open(struct inode *inode, struct file *file)
> +{
> +       struct dvb_device *dvbdev = file->private_data;
> +       struct dvb_frontend *fe = dvbdev->priv;
> +       struct dvb_adapter *adapter = fe->dvb;
> +       int ret;
> +
> +       dev_dbg(fe->dvb->device, "%s:\n", __func__);
> +       if (fe->exit == DVB_FE_DEVICE_REMOVED)
> +               return -ENODEV;
> +
> +       if (!adapter->mfe_shared)
> +               return __dvb_frontend_open(inode, file);
> +
> +       if (adapter->mfe_shared == 2) {
> +               mutex_lock(&adapter->mfe_lock);
> +               if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
> +                       if (adapter->mfe_dvbdev &&
> +                           !adapter->mfe_dvbdev->writers) {
> +                               mutex_unlock(&adapter->mfe_lock);
> +                               return -EBUSY;
> +                       }
> +                       adapter->mfe_dvbdev = dvbdev;
> +               }
> +       } else {
> +               mutex_lock(&adapter->mfe_lock);
> +
> +               if (!adapter->mfe_dvbdev) {
> +                       adapter->mfe_dvbdev = dvbdev;
> +               } else if (adapter->mfe_dvbdev != dvbdev) {
> +                       struct dvb_device
> +                               *mfedev = adapter->mfe_dvbdev;
> +                       struct dvb_frontend
> +                               *mfe = mfedev->priv;
> +                       struct dvb_frontend_private
> +                               *mfepriv = mfe->frontend_priv;
> +                       int mferetry = (dvb_mfe_wait_time << 1);
> +
> +                       mutex_unlock(&adapter->mfe_lock);
> +                       while (mferetry-- && (mfedev->users != -1 ||
> +                                             mfepriv->thread)) {
> +                               if (msleep_interruptible(500)) {
> +                                       if (signal_pending(current))
> +                                               return -EINTR;
> +                               }
> +                       }
> +
> +                       mutex_lock(&adapter->mfe_lock);
> +                       if (adapter->mfe_dvbdev != dvbdev) {
> +                               mfedev = adapter->mfe_dvbdev;
> +                               mfe = mfedev->priv;
> +                               mfepriv = mfe->frontend_priv;
> +                               if (mfedev->users != -1 ||
> +                                   mfepriv->thread) {
> +                                       mutex_unlock(&adapter->mfe_lock);
> +                                       return -EBUSY;
> +                               }
> +                               adapter->mfe_dvbdev = dvbdev;
> +                       }
> +               }
> +       }
> +
> +       ret = __dvb_frontend_open(inode, file);
> +       mutex_unlock(&adapter->mfe_lock);
> +
>         return ret;
>  }
>
>
> --
> 2.46.0.76.ge559c4bf1a-goog
>


-- 
Ricardo Ribalda

