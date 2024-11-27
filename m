Return-Path: <linux-kernel+bounces-423306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D379DA59C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B09F285B15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E6196DA2;
	Wed, 27 Nov 2024 10:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H5uJhEC+"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F211957E7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732702812; cv=none; b=A4AKekHFFMst94lQL3lBjRw+usUz1/Q/pmabfO2xD1H2XF9JKOxPZSbKCansJPXvSJVdmFgDXNwvZnUwfjHqBirB/xqVaoteetrwEy2gjmMtNcEahEAz1JxH/JZxI+LVG1/tdYolDdHb33BK1ipJl15jZjZpmnC64+qIWi7Lmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732702812; c=relaxed/simple;
	bh=8r5vCCz3A7owBJYWh+nbdral5EKpJhok9PThU26k4nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXJzBbeTcfMsR4UuuscciO+fY2ZgRh+INSqpwgENeIkAfsLadMF2Sd6p//NbF7kFM4w4dov4U6FsCrRLi30BOadaLF7O+s+9Hb4z42r0L9nyU3ABTYjOqlMwoZHneCSJ6Xp/9fKcB2kJP8srCq1TpDhZZeUiFMjqXgTjUFWio/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H5uJhEC+; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-724e113c821so4495236b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732702810; x=1733307610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94aDzij1Sd3lW/XcYirCTixFdk5KYMfgdRn5F74gnPs=;
        b=H5uJhEC+uNZRGVra/ZwGUBsKn8PLAX+IUtbRZF6ZOizHeE6YK0BeKbVGrj0BbXISxa
         SrlFnWYBpaUkVudESEcJb7sBsgJFEartH3T0D98DY+0IvogAGt/pnj8+Hhe+nz0v9vY5
         kqbV6B6XtDjHdV0+EVoOitC/qxnUopjUNCBL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732702810; x=1733307610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94aDzij1Sd3lW/XcYirCTixFdk5KYMfgdRn5F74gnPs=;
        b=aGkbP0LwRu/7fghDYUAVcIcanc6kt5UYMEz1l8QwRaPCRvWAxpUp0AKZ6y4gqsjtnu
         ocLpTJ3cIlRLr1zsQTMYIX0mWWs2WWITF80v8ZLJlJkQUMKxAYeGgP+2cm5Be+jaXXjp
         b5sP27scgVvQJ902WH3Ek7YjmFDOScoshyCDiabaWrv9TD9ioOV/2oUc+RzCE3ESxx0p
         BrHcAnyndk6MUQQ4gVLrh9ldjIPUYBsYQ7TeYsvAvzRZhN9moqUBerQ45e0I31t3SwJT
         UJF85ufl7OPxCZb1kJy4Sn/y1wVqC4GRqk/yopKttI6yUSacS5EGxKH0oa9ooROiGuq7
         PyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFoRbzZTH5Zp+u+wqyZQ2+8QvzSgPAeBpyL5KRLjGlYsKR6paxWQR3HeZBjzuqLc5TA9mrzIkoJETkwVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZKMjxmllOC4wGuHn/D7aq5sA1ePTAi+1i1GP22ZzLciqyqgCk
	kVIgGDsY0Kx/3elW/Y4CniQh9eiWs4GlkfOo9oV0vrSY7YLVCi71jUbOOqBvsShdya+tlSZC29I
	=
X-Gm-Gg: ASbGncsP1mCibKMup6jplYvpgRYPtFwOVJPK5WlfKAlBpXx2D+NwXKcOwk3uT6rei+8
	4OC06O+BGLnNyz33AhJnURo4cx/m/oc6RD7AmRtAh8qwV0z5sO+CGQaFi+Ie0wswY3HTic+4kh6
	U0L5fpI5U5hAROekhUpeJusz0JC3gHcHMHN0UxmD2JYMEuWMkm4o3btS1jR4oLvOcT4C9qHEV+X
	RYcWqprxPf7G+ULJusrFkpreWXrV6552zQIIg8TBaFx92SbyGl4llFGsbGONJqbNc6PXY70GeKp
	KzPeBfUCx42dfQV5
X-Google-Smtp-Source: AGHT+IGiTiiczaf1RN6Zn6zjYgMzzvqD+ATpQtcw8HT7rJ/mSWCMbuILxLN2F/mBPLv0Q9LS2ESIww==
X-Received: by 2002:a05:6a00:181b:b0:71e:6a13:9bac with SMTP id d2e1a72fcca58-7252fe112c6mr3230840b3a.0.1732702809413;
        Wed, 27 Nov 2024 02:20:09 -0800 (PST)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com. [209.85.210.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724ec041406sm8646686b3a.79.2024.11.27.02.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 02:20:08 -0800 (PST)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724f41d550cso2654936b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:20:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkh3cIplH4c/kqPD1coeeI/poXKMCO/+CKnJ/Ol0cItgQAN7qonh9i3yu9ZEG9m0nSlsqZmXV+C+shrDQ=@vger.kernel.org
X-Received: by 2002:a05:6a00:1396:b0:724:62b3:58da with SMTP id
 d2e1a72fcca58-72530043fe3mr3288577b3a.6.1732702807121; Wed, 27 Nov 2024
 02:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
 <20241127-uvc-fix-async-v1-1-eb8722531b8c@chromium.org> <20241127091153.GA31095@pendragon.ideasonboard.com>
 <CANiDSCs36Ndyjz52aYA0SHef8JVQc=FvtDNk8xQwR=30m652Gg@mail.gmail.com> <20241127094212.GF31095@pendragon.ideasonboard.com>
In-Reply-To: <20241127094212.GF31095@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 11:19:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCuukO7kQw=VHyHS3ir3y4mCERbnRoUTTTSoRHZkMpLBdg@mail.gmail.com>
Message-ID: <CANiDSCuukO7kQw=VHyHS3ir3y4mCERbnRoUTTTSoRHZkMpLBdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: Do not set an async control owned by
 other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 10:42, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Nov 27, 2024 at 10:25:48AM +0100, Ricardo Ribalda wrote:
> > On Wed, 27 Nov 2024 at 10:12, Laurent Pinchart wrote:
> > > On Wed, Nov 27, 2024 at 07:46:10AM +0000, Ricardo Ribalda wrote:
> > > > If a file handle is waiting for a response from an async control, avoid
> > > > that other file handle operate with it.
> > > >
> > > > Without this patch, the first file handle will never get the event
> > > > associated to that operation.
> > >
> > > Please explain why that is an issue (both for the commit message and for
> > > me, as I'm not sure what you're fixing here).
> >
> > What about something like this:
> >
> > Without this patch, the first file handle will never get the event
> > associated with that operation, which can lead to endless loops in
> > applications. Eg:
> > If an application A wants to change the zoom and to know when the
> > operation has completed:
> > it will open the video node, subscribe to the zoom event, change the
> > control and wait for zoom to finish.
> > If before the zoom operation finishes, another application B changes
> > the zoom, the first app A will loop forever.
>
> So it's related to the userspace-visible behaviour, there are no issues
> with this inside the kernel ?

It is also required by the granular PM patchset.


>
> Applications should in any case implement timeouts, as UVC devices are
> fairly unreliable. What bothers me with this patch is that if the device
> doesn't generate the event, ctrl->handle will never be reset to NULL,
> and the control will never be settable again. I think the current
> behaviour is a lesser evil.

The same app can set the control as many times as it wants, and if
that app closes the next patch will clean out the handle.
Maybe I should invert the patches?


>
> > > What may be an issue is that ctrl->handle seem to be accessed from
> > > different contexts without proper locking :-S
> >
> > Isn't it always protected by ctrl_mutex?
>
> Not that I can tell. At least uvc_ctrl_status_event_async() isn't called
> with that lock held. uvc_ctrl_set() seems OK (a lockedep assert at the
> beginning of the function wouldn't hurt).

ctrl->handle = NULL in uvc_ctrl_status_event_async() is completely redundant.

The only place we set the value of the handle is in uvc_ctrl_set, and
that can only happen for controls with mappings.
I am sending another patch to remove that set to make it clear.

>
> As uvc_ctrl_status_event_async() is the URB completion handler, a
> spinlock would be nicer than a mutex to protect ctrl->handle.
>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > index 4fe26e82e3d1..5d3a28edf7f0 100644
> > > > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > > @@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> > > >       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> > > >               return -EACCES;
> > > >
> > > > +     /* Other file handle is waiting a response from this async control. */
> > > > +     if (ctrl->handle && ctrl->handle != handle)
> > > > +             return -EBUSY;
> > > > +
> > > >       /* Clamp out of range values. */
> > > >       switch (mapping->v4l2_type) {
> > > >       case V4L2_CTRL_TYPE_INTEGER:
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

