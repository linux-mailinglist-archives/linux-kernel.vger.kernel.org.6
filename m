Return-Path: <linux-kernel+bounces-437378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038219E9274
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170F0188652A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDD223717;
	Mon,  9 Dec 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eoXzMUnb"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F27422370B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743897; cv=none; b=gjNRhHLjNkS1rsJHs/bxhDVcjJgnO1OMCvhHBJOze9QXE1MiJ+i/cOlhiKJk0XmYTbmuYxfyxWVnEuYr0CFVGU645AmPLU39ilYLMiXYaAtUaV8n1SGfQksVtY0kZoolXqI7UaX3o0n6LFt1uyNPgWEqogdvFdmj7JRge1xYYVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743897; c=relaxed/simple;
	bh=hi/gPHGp3GRpPNQ/sIelAR0TJU62VtzESITi0QHtWMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRBQ7u0G+rka08RVK3Z3MW7RdbsHAS9venAvu4mCEUCrWKM0b4T+NmDkFZzNKUQ3C/mGXzQQaVmxCmV5YQxI6aocy2T6zklt8AE2Nvze0twVS5CpatsgQBHud6OksgJ7CbbBdAnGMvNRM8ED+prg17t0Gxl/HZqhQNtXTP1yqNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eoXzMUnb; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2164b662090so7179225ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733743894; x=1734348694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ym/ckWiJiSsbCHqxkCn87G8/HMB8USxigf1ElOERRM=;
        b=eoXzMUnbclIz5qHetlO56DtOaUEV8U8OXV9Roo+wNti0ligoMobwl8rmDKNWW4+10B
         JsfbdurJHIKn804HhB+NPGSTA46Q9RB5e3pqv8Vu6CKSk6CqyYhNvT2uyhm8+VkHLs10
         TDZ1s1MRwrPNQZQ4U9wWoqZMRSQITr4HrCFic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743894; x=1734348694;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ym/ckWiJiSsbCHqxkCn87G8/HMB8USxigf1ElOERRM=;
        b=a/u9gTF3w1D8yMAhDJcPcx9/bp+1TJoyl36zn5Uoc4HSgjoVDLv3GrRFWP9K94CvLs
         czI4yxncpIlIovwil207c7lFJwavz7RdEIqEGC8Zmi4zyBTo8VMpB1A1/BWo8+RT9925
         UTtI6o2+x4wWfCqR+P3hrdW1d8ZI/qa9+l3XMBpV0duHjdPzyXWJ4EmS2dEVd1a9UV0N
         w/Ha452/7+xOjtjAULZeYjKO5YaPjx/ffYUwZnB06/vBsGbEUcGU9gbra8gorg8fpw+f
         rP2/7EYwnNNbnMkeYRGngNxwrJ0PgXNM/SiQCDrdmuaclhgj66SKvoasYVzXEeLtctMq
         7Zhw==
X-Forwarded-Encrypted: i=1; AJvYcCWpGxQpIO5PfoRube8j3F4fDbF0ZirrV9qzk54vmxDBDusrcMoQ0apsuqls8UukmAr7XkPV5G9CvmZlwZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+CwZucXJCqUE8frgk9B9k5w8dz2bUvVrMWhHMdwfmKypvczX
	5C4tiGDhLDSHnmaJ4/1B9+852D/yKj5psYZwJqOq95+K6CDT+l2bUp05cd/qz/8Hz/Pgf/7LuvY
	=
X-Gm-Gg: ASbGncszEHHaKLF1RcNWrVsL2HanY4nBjxN/o4sZ920CPqSuwaOBtWetpgmDBSiIm9y
	Usbqx2Sn8HfT1/NAX8I04/R/4OxeaB/dK2LzdP10VSbo2uVsgVgMHE0XcvxuEBcy70ya+bhK/DF
	1mYBz7eiv7uHGThFch59vviUHWVp9cE9enMvDEM/+dSiMnqpFvt0bz+6Lox3Usgu9aZH9QhEuZy
	4utR6KHOEN2WZ5zg6awSJHRQyIPINPuiQILI8q41f7BVVHrj9ousFY6FG8E4Wq6RP+L4tM6PWZ+
	AbyPEXzwgAaEu7H0
X-Google-Smtp-Source: AGHT+IGeFwLSwU5dZwfk6G7U3VxYmDuxKrxHiOILOSCOF9uo/BaAIoFGTS/Ag2c1QsmGwIdb871a5g==
X-Received: by 2002:a17:902:e5cd:b0:215:9ea1:e95e with SMTP id d9443c01a7336-21614d442b6mr203018815ad.13.1733743894664;
        Mon, 09 Dec 2024 03:31:34 -0800 (PST)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631bd2c2dsm35179155ad.263.2024.12.09.03.31.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:31:32 -0800 (PST)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd10cd5b1aso2932728a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:31:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVfAv9JgicjqCvIGs45Zw82OQzpC8Y6CBwrg85tBebn5gWsOsSY/xCs87HVRdRnVgeg8ChjSSw1yM8IHhg=@vger.kernel.org
X-Received: by 2002:a17:90b:3f45:b0:2ee:dd79:e046 with SMTP id
 98e67ed59e1d1-2ef69f0b093mr18851318a91.13.1733743892060; Mon, 09 Dec 2024
 03:31:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
 <20241203-uvc-fix-async-v6-5-26c867231118@chromium.org> <02a89566-a6f7-4feb-84c3-079795c98a46@redhat.com>
In-Reply-To: <02a89566-a6f7-4feb-84c3-079795c98a46@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Dec 2024 12:31:19 +0100
X-Gmail-Original-Message-ID: <CANiDSCuPM1qeerMUBFx+RfqBD35CcfhQeO5hYVHh-ZeQ-4t9Sw@mail.gmail.com>
X-Gm-Features: AZHOrDl6MbSwc6Ip8YcLcxTT-qOq-bKVsjHj9biGhFd-T_bgQFW7J-G_3ijpnYY
Message-ID: <CANiDSCuPM1qeerMUBFx+RfqBD35CcfhQeO5hYVHh-ZeQ-4t9Sw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] media: uvcvideo: Flush the control cache when we
 get an event
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Mon, 9 Dec 2024 at 12:03, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ricardo,
>
> On 3-Dec-24 10:20 PM, Ricardo Ribalda wrote:
> > Asynchronous controls trigger an event when they have completed their
> > operation.
> >
> > This can make that the control cached value does not match the value in
> > the device.
> >
> > Let's flush the cache to be on the safe side.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Thank you for your patch.
>
> It seems that you have missed Laurent's reply asking to improve the commit message:
>
> "Conceptually this change looks fine, but the commit message needs to
> explain why this is safe to do without protecting ctrl->loaded with a
> lock."
>
> https://lore.kernel.org/linux-media/20241203203748.GD5196@pendragon.ideasonboard.com/
>
> Or maybe the posting of this v6 and that reply have crossed each other.

In this v6 I moved loaded=0 from uvc_ctrl_status_event_async() to
uvc_ctrl_status_event()

Now setting loaded=0 is just after mutex_lock(&chain->ctrl_mutex);

Do we need a new version?

>
> Either way please post a new version addressing this comment.
>
> Thanks & Regards,
>
> Hans
>
>
>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 3dc9b7a49f64..db29e0e8bfd4 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1622,6 +1622,9 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
> >
> >       mutex_lock(&chain->ctrl_mutex);
> >
> > +     /* Flush the control cache, the data might have changed. */
> > +     ctrl->loaded = 0;
> > +
> >       handle = ctrl->handle;
> >       if (handle)
> >               uvc_ctrl_set_handle(handle, ctrl, NULL);
> >
>


-- 
Ricardo Ribalda

