Return-Path: <linux-kernel+bounces-176456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5298C3028
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBB01F22A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A99912E7E;
	Sat, 11 May 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+0mO1Z3"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F2FBE8
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413685; cv=none; b=a0qM3f3Pz368i7oQ+mxOSU2MZGX9SUmBZQFLPDOlknoaq9DyKNBl5D3DRSpX93louVPp45nNvPgHusbAeSt0876UXUlIJXsDjA3J5ut14UpWk70h6s3no2af9e2CpVyzgobLpDsSUSokVaOZuiHIxmzE0SPImTMnSXRqCnDZjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413685; c=relaxed/simple;
	bh=meEYPUOj/04dXwOusDQMM9xj3Jdxdafr9sQJyUHw6mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJIrsgXL5k1xtW469c3GxTw373CEEJcKMEWydMrMha6rIys/U559/aTZNpBIXL/dZsosZGEVQcBxvg3nLIIFaKdrna+YeXVR6M+cdTg+XFXnnV8AnFDh+AeZ93pgwyXCeIwFgMtSxZF1kBQI1yWCX1UFdp/W/1UwM3DYM09bUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z+0mO1Z3; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792ba098eccso209502585a.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715413681; x=1716018481; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3jrMWE928Q6BhVEHep/QBR94dnpPtsG7+6WCG1J7Ms=;
        b=Z+0mO1Z3EV9/NLnjERPm+2uU9Te7K9r6557Zzk+HU+ZIQxpuHzh3vPNV3g6TkvN040
         tSI6p241QpyNDhLM+X4VEOAYNs5oCRTmyDYOsaQwPnb919kZHG74yENP6zTLmiMwdl+7
         3+YPAbKcWc8AhUg6rBuK/VnaE80/lFQou1roI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715413681; x=1716018481;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3jrMWE928Q6BhVEHep/QBR94dnpPtsG7+6WCG1J7Ms=;
        b=NQ6Og1vqvAJ11Vo2R8VYZwu94L7pfrhAocZCcupa2M+CXYdRPDegMrHncGwh8YzVyr
         42f6+/gYTLrBj9vzVWnXIJx5Ferg+9DCjEyT94drUDmBCAtPlak0GZn478QJUE+d5gxB
         N5iCLQp4BYCnpltcEKoPJDPylUTFQHe9eHkvvod+gVZJHyDLp/mQNykc4NVVu8GEJery
         ENeYe9Kq+OAOTre2VlFro58aj/ElldIHa6snRD5gZ4uRbhTeYN+knrJZTTGpaE6zpcI/
         A3bzpAVfG5ATcATHeFOuOZkX5SyHgFCVEJJNBvhfClDa5bBi6y+cfynY7ra8V0sQdrHk
         JSlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSFYhj+ADYuKQvanA8uwXunfIOtwlw8eECuiDAwHZsnzwqq3tTMpJnfKnUJo7AlVfDSWzIL7FitWa4F7KzvH3uvP7FUUnGKSZsDV+J
X-Gm-Message-State: AOJu0YxJyYJRx07OppdGIw9W2zOlrX6JFhqz9h5n0dut27cD4tFQKsy/
	hv+n+twtc/hqnQNxFf584HjBV1XtdsD7S4W6cpKyUnriPG/3oDcN3hV5vbha5NU7MGmwBICahI4
	=
X-Google-Smtp-Source: AGHT+IHAFj3xZEIXHiJT9gOcF1tz/+Suqh0TIm0oQL7Bwfg96gtsHnkYNVFjiPfJWyXyEd8/SxY11w==
X-Received: by 2002:a05:620a:815:b0:792:b91b:3588 with SMTP id af79cd13be357-792c75763a5mr504323985a.7.1715413680923;
        Sat, 11 May 2024 00:48:00 -0700 (PDT)
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com. [209.85.219.47])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a401bsm254997585a.71.2024.05.11.00.47.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 00:48:00 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6a073f10e8eso12766456d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 00:47:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxgMDnbDjK/XlHFzJEcOEQpBUL9jYrtJ4bIebMOVtEIb6hTremQ+rCl0L5LBqVjJkbDYvhoVBmtQBjA55V/g/pqrBJef87Z8YjQwe+
X-Received: by 2002:a05:6214:398f:b0:6a0:ada7:1ffa with SMTP id
 6a1803df08f44-6a16815f8eamr48583366d6.17.1715413679256; Sat, 11 May 2024
 00:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509-fix-hi846-v1-1-1e19dc517be1@chromium.org> <20240509193900.GA32013@pendragon.ideasonboard.com>
In-Reply-To: <20240509193900.GA32013@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 11 May 2024 09:47:47 +0200
X-Gmail-Original-Message-ID: <CANiDSCsv8S68x7z+aV1PhbZ+5Ktr=86nYUXaNpb1w4q4y1v38Q@mail.gmail.com>
Message-ID: <CANiDSCsv8S68x7z+aV1PhbZ+5Ktr=86nYUXaNpb1w4q4y1v38Q@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: hi846: Fix V4L2_SUBDEV_FORMAT_TRY get_selection()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Martin Kepplinger <martink@posteo.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Thu, 9 May 2024 at 21:39, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Thu, May 09, 2024 at 05:05:55PM +0000, Ricardo Ribalda wrote:
> > The current code does not return anything to the user.
> >
> > Although the code looks a bit dangerous (using a pointer without
> > checking if it is valid), it should be fine. The code validates that
>
> I think you meant s/code/core/

Yes, sorry, fatty fingers :)

If you are planning to send a v5 of this
https://patchwork.linuxtv.org/project/linux-media/patch/20240508214045.24716-4-laurent.pinchart+renesas@ideasonboard.com/

Maybe you could include this patch there?

I found the issue when the CI tested your series (eventhough it is not
caused by your series)

Regards!

>
> > sel->pad has a valid value.
> >
> > Fix the following smatch error:
> > drivers/media/i2c/hi846.c:1854 hi846_get_selection() warn: statement has no effect 31
> >
> > Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> > While running media-ci on the last patches there was a new sparse
> > warning:
> > https://gitlab.freedesktop.org/linux-media/users/patchwork/-/jobs/58524338/artifacts/external_file/junit/test-smatch.log.txt
> > ---
> >  drivers/media/i2c/hi846.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
> > index 9c565ec033d4..52d9ca68a86c 100644
> > --- a/drivers/media/i2c/hi846.c
> > +++ b/drivers/media/i2c/hi846.c
> > @@ -1851,7 +1851,7 @@ static int hi846_get_selection(struct v4l2_subdev *sd,
> >               mutex_lock(&hi846->mutex);
> >               switch (sel->which) {
> >               case V4L2_SUBDEV_FORMAT_TRY:
> > -                     v4l2_subdev_state_get_crop(sd_state, sel->pad);
> > +                     sel->r = *v4l2_subdev_state_get_crop(sd_state, sel->pad);
> >                       break;
> >               case V4L2_SUBDEV_FORMAT_ACTIVE:
> >                       sel->r = hi846->cur_mode->crop;
> >
> > ---
> > base-commit: 48259b90973718d2277db27b5e510f0fe957eaa0
> > change-id: 20240509-fix-hi846-c3d77768622e
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

