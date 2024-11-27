Return-Path: <linux-kernel+bounces-423232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B76969DA4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7707B28343B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B5192D80;
	Wed, 27 Nov 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MFou832I"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF222192B66
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 09:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699566; cv=none; b=cm5c0n4pWzFd5aF0hTaYMhpS8ZObJqcxAC7UYAbQzuDiAusIjKZkpDdVO5HaRKYX9fltsCciXEv2X607zN1aFeom6PgGR0c0k8IjC22ozwxKP2pM4qSnQb4Qmw1GIdRjBO0x8giYaznIHAeIY1jQ4CqHTJZNiSMRUYp0y5fYhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699566; c=relaxed/simple;
	bh=Pr2w9P5YgFGcloq41dky7oHk7tvapxV8DUhchBmh8oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJEU/7OJNOucmRP66FqN+Fi6Qy8IVFOtv11B1o0yTXoA2flYqqVrYYzXM6xj97wwCQMFLm69BfzHn0nkt81GiKbe+7SUFDjPmBrKvY5Qcmb4tBR4am6eZx4oOihE7whCRq8ae7PJl2PsHohEoZ1frwK6nMNzh5fiMvKY/Z+KfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MFou832I; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7251731d2b9so435691b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732699564; x=1733304364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ef33Q45NDhtM2JikV+GQsfJKYqlaYSgoxUTe9Gy8DDA=;
        b=MFou832Ii1fivH589K5mp7zVZ6yEesSM1/nxVnQnBDuMTDcelZs7iz4S6kgTmLFwqe
         ylQvONBGQ58HNlexVjcyn6swg8lEsqZlp04+baGDSLeG36/13c3W8M/a4E//eYsD9hPJ
         G22CcyZzvS9BqDLsqSSMhBq3FPZy0LoKPDNa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732699564; x=1733304364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ef33Q45NDhtM2JikV+GQsfJKYqlaYSgoxUTe9Gy8DDA=;
        b=XB2JykeB6nf57/prvjjbj7y+z3zug1GQvR0RlC8r9XM6Ab7M0v9ayJPXvVTAMR0rRx
         trP1jZpAclUn1+VzdAOvdN44/oEWxRTYLLglJ0g4wA5m/KZBJPJdtjY1reEYqLl7wNEJ
         OWvuoShNgzCgh47qdKyr6z7ZCW7U/R4khH4rgEhjTuA4R9yDYtJOeK7CwonH71LQFrPW
         D1uNjHLIC4fRKOXa2kpbsHDHjzDnYugzGYQmpPve/ypwVMuLKfwG0us5WP2eq7Ci81rG
         T5Pn3fU7obX+5YG/Njkf/g/UxoX8VPCxnxm4lgvGNViITCezMB2mHAOF0GvcKPzO24pe
         5CeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKNpDjq7ngjyHXhSAmru1W9TSfVtVqmKkJ9Z6FXRyE87hAV8bwnT622/OPHoULW4iXtznR9IHiSfX4s7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGr+s2eyrSmC8/BU26mUHYfDAQeX3wqdwN3pgfu9TdOGo9/bm
	HZCWPSAZjTp3knLGgdU1fZqfPmW/TlhdMitpA4A3SBeWKenIjH5WykTyLvMelXmhNg6sCQUg1As
	=
X-Gm-Gg: ASbGncua4MwVRj4FjsuGzb3B216R1y7nfXU+aTWTvsI2ZH2Fsw2+gp9NVC1rEGqnNEK
	KlUiQk5hv4y6NB/EN3Nq6yN8zFppldRzIORGpMKNnOidcunvVQwuc9vPx66bOQmCvM/mkgKQWXm
	CRoVhmJ4nwoBV8a5JCIN472G7WakrHksDHUmM/IdCsDw2UNW8wynF/L3dNgXttZb/jkC1+EQhCL
	/zjjfgnhNxPpBy/H7l0sboK0dgMi+0bbIt7LPB6wdd3lgnZSZjM50SyGCkR2OW6DwhVxNNxtX3y
	w5v3c/B9UYDGaD7P
X-Google-Smtp-Source: AGHT+IFLDn8HuNev+1nJ6WZ7y/J8mnMEdlubIn6C9zLfH/YuTDz44zJqyck6KWEUb7qj73taJB/T0A==
X-Received: by 2002:a05:6a00:2d93:b0:724:f8fd:f154 with SMTP id d2e1a72fcca58-7252fbf5ee8mr3231324b3a.10.1732699563860;
        Wed, 27 Nov 2024 01:26:03 -0800 (PST)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com. [209.85.210.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de559763sm9782835b3a.162.2024.11.27.01.26.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 01:26:01 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7252b5d7b1dso463121b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 01:26:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEzqqjqsmtK/p32auxr/iMkoTRv5Qs3sRjinVo9VMEg3wHD+zD2PjmEbEGzuNR296vAYHykvIX3ClRI6g=@vger.kernel.org
X-Received: by 2002:a05:6a00:3014:b0:725:37a4:8827 with SMTP id
 d2e1a72fcca58-72537a489f6mr1060353b3a.3.1732699560596; Wed, 27 Nov 2024
 01:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org>
 <20241127-uvc-fix-async-v1-1-eb8722531b8c@chromium.org> <20241127091153.GA31095@pendragon.ideasonboard.com>
In-Reply-To: <20241127091153.GA31095@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 10:25:48 +0100
X-Gmail-Original-Message-ID: <CANiDSCs36Ndyjz52aYA0SHef8JVQc=FvtDNk8xQwR=30m652Gg@mail.gmail.com>
Message-ID: <CANiDSCs36Ndyjz52aYA0SHef8JVQc=FvtDNk8xQwR=30m652Gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: Do not set an async control owned by
 other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Nov 2024 at 10:12, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 07:46:10AM +0000, Ricardo Ribalda wrote:
> > If a file handle is waiting for a response from an async control, avoid
> > that other file handle operate with it.
> >
> > Without this patch, the first file handle will never get the event
> > associated to that operation.
>
> Please explain why that is an issue (both for the commit message and for
> me, as I'm not sure what you're fixing here).

What about something like this:

Without this patch, the first file handle will never get the event
associated with that operation, which can lead to endless loops in
applications. Eg:
If an application A wants to change the zoom and to know when the
operation has completed:
it will open the video node, subscribe to the zoom event, change the
control and wait for zoom to finish.
If before the zoom operation finishes, another application B changes
the zoom, the first app A will loop forever.

>
> What may be an issue is that ctrl->handle seem to be accessed from
> different contexts without proper locking :-S

Isn't it always protected by ctrl_mutex?

>
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 4fe26e82e3d1..5d3a28edf7f0 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >               return -EACCES;
> >
> > +     /* Other file handle is waiting a response from this async control. */
> > +     if (ctrl->handle && ctrl->handle != handle)
> > +             return -EBUSY;
> > +
> >       /* Clamp out of range values. */
> >       switch (mapping->v4l2_type) {
> >       case V4L2_CTRL_TYPE_INTEGER:
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

