Return-Path: <linux-kernel+bounces-425623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CB9DE7E0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BA91623DD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB2519F116;
	Fri, 29 Nov 2024 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kzUSN6yE"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB619CCEC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732887729; cv=none; b=Wawtcc5OZLIQsqzJ1p3kKdNlq1YyLwnu2soq9COijiFHq33ptWoRRVz8MkwpkTDoJmx9BTeAKCX57AKJCdHHSflRowqf0YgstepdSm97NvXdLRmX0iyxggUSWLA/t/4E+klyxoKQ/S2iHCUg72lD615xCHc3uhWZnQG4nin03eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732887729; c=relaxed/simple;
	bh=sVgv3ksXvpteRZEYd8JPzQOo44HSIW5lgB3anwK3PPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfAkxDB7sgK8uOQ8KQdfHjHEsEpcnOIJb6dnzj91RxuU383zkvweoekgsQxf3Q+WYtw/87ZuPlFtX9hLws5khRwOBXzkVTVqfvC1ELyy8uT4BQ2sT7arWBapidoUzK3Tmp1wmAtAjx3R58ArLkKjgoOn0crPAUFaGHgnYEaS8fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kzUSN6yE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc88476a02so1624541a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732887726; x=1733492526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kSFitEdT2rCfLfdfH1IWUyxop2r79Nc9DFx17hzOekQ=;
        b=kzUSN6yEhc6W9jumWzeaFKwEaXt6MOCpTC5pLXz6kellRhiIs5HL5Q4OvTqAbIg6ZP
         eMfYrlQzw5JPxnQ+LFlt4P0Ae1l8kVMKDb107mb5dhd8vBwUaOCp+cLMh3Iof7NbzR8b
         fkf1SMbxqPQGbcQOvYWNNg8pjR0lU9S5QuF4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732887726; x=1733492526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kSFitEdT2rCfLfdfH1IWUyxop2r79Nc9DFx17hzOekQ=;
        b=Wzn4c997+uK4IMTVMl2b43Dc4BphjBYwGUkpGVO5gLRcUATWouL5MBThITo/ajg2jw
         Q2LcxuqbenY1I49eQMn/pIpj0CDucVmZ/YNJaLmvLBxIgLzuqrAv+vvzQnYKAaiZ3KrJ
         xvhpbOGSsFWTw3jr94DYbWJGkv10m49wdi87hfc71JRo9iiUJjDrAKUGhrU2OygqJZIN
         E7Hb4X7f0eHurQBDqfHhkrN8DuR5YvG1JmH5s7BnUIv0qSkaPM2SAxW4HdUvYXRO+ZTQ
         2HuwgFFPorLpyuh2WlJtQSRkHiHW/jgATIODeKZgaJOYgOs3YZzjCAXVgSPNgueh+rvD
         uyPA==
X-Forwarded-Encrypted: i=1; AJvYcCXruxN8YEAmwKD8szbSeewimksKsGaFRw6+rkXGYfqRtbIvI0h0deEFTzjm5lnAHXXZWQ0pSIQbNnGf94Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAMrHjDGOMPXwmEIITw224udJEXlGeGEN4APiRs10+pCfQVSZQ
	Nk3n9wGseHIRymVKYrcM3SDLX5VyBF1YfqWfohhASGWCweeMGt7yAdAyRbNtd0PVhMrZDRk2txc
	=
X-Gm-Gg: ASbGncuTMXUU+J3Vmi4EMB2ecJ9M3MVMWaJEjQJ8puIFe/WaJkSdnmWGa7bgcAAzrJO
	pTvmJYuU4LdDbmU6OJhOQG86NteAAIjR2xFnH2TTT7rbRI0rC3V0jQWBMZlDwW4kWjvtD85F5uN
	snndz7qnVT5NxCVYXCOvbOocpkDsr0JFwvs6dM9r8OTYtFKhlGXc7CAOYta2GBX6IIJ4eSgbdxX
	vvmTqqdbw0Rjr4S0sLusBfyFysvvgr5VxI0dXdcEgXTf+PEO1ZBk9VPJwiw0NL+7MveVGlEHwlz
	ZTuxuEnHKKRn
X-Google-Smtp-Source: AGHT+IHRjJD92mrs53TFK6/S5VIAEY7o2gacFg/x5QQjKFal/UjgKZ+ZitgLgYWlDkdgy5rkkjLfyQ==
X-Received: by 2002:a05:6a20:9144:b0:1e0:c50c:9838 with SMTP id adf61e73a8af0-1e0e0aa73f8mr17278663637.6.1732887726149;
        Fri, 29 Nov 2024 05:42:06 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541848d8bsm3543438b3a.184.2024.11.29.05.42.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:42:05 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee4f78493aso622344a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:42:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWj1A3wNqjBiwUhRbxgFC7cT13ZjC0j0rJO/qu9lSKnLDnlklUtZaOzgainPxIL/L07n2pjKEEuwjppblE=@vger.kernel.org
X-Received: by 2002:a17:90b:35cb:b0:2ea:6f19:180b with SMTP id
 98e67ed59e1d1-2ee097cf0d5mr12912335a91.36.1732887724820; Fri, 29 Nov 2024
 05:42:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org> <20241128222232.GF25731@pendragon.ideasonboard.com>
 <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
 <20241128223343.GH25731@pendragon.ideasonboard.com> <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
 <20241129110640.GB4108@pendragon.ideasonboard.com> <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
 <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl>
In-Reply-To: <e95b7d74-2c56-4f5a-a2f2-9c460d52fdb4@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 14:41:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
Message-ID: <CANiDSCvj4VVAcQOpR-u-BcnKA+2ifcuq_8ZML=BNOHT_55fBog@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 14:13, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 29/11/2024 12:54, Ricardo Ribalda wrote:
> > On Fri, 29 Nov 2024 at 12:06, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> >>
> >> On Fri, Nov 29, 2024 at 11:59:27AM +0100, Ricardo Ribalda wrote:
> >>> On Fri, 29 Nov 2024 at 11:36, Hans Verkuil wrote:
> >>>> On 28/11/2024 23:33, Laurent Pinchart wrote:
> >>>>> On Thu, Nov 28, 2024 at 11:28:29PM +0100, Ricardo Ribalda wrote:
> >>>>>> On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart wrote:
> >>>>>>>
> >>>>>>> Hi Ricardo,
> >>>>>>>
> >>>>>>> (CC'ing Hans Verkuil)
> >>>>>>>
> >>>>>>> Thank you for the patch.
> >>>>>>>
> >>>>>>> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> >>>>>>>> If a file handle is waiting for a response from an async control, avoid
> >>>>>>>> that other file handle operate with it.
> >>>>>>>>
> >>>>>>>> Without this patch, the first file handle will never get the event
> >>>>>>>> associated with that operation, which can lead to endless loops in
> >>>>>>>> applications. Eg:
> >>>>>>>> If an application A wants to change the zoom and to know when the
> >>>>>>>> operation has completed:
> >>>>>>>> it will open the video node, subscribe to the zoom event, change the
> >>>>>>>> control and wait for zoom to finish.
> >>>>>>>> If before the zoom operation finishes, another application B changes
> >>>>>>>> the zoom, the first app A will loop forever.
> >>>>>>>
> >>>>>>> Hans, the V4L2 specification isn't very clear on this. I see pros and
> >>>>>>> cons for both behaviours, with a preference for the current behaviour,
> >>>>>>> as with this patch the control will remain busy until the file handle is
> >>>>>>> closed if the device doesn't send the control event for any reason. What
> >>>>>>> do you think ?
> >>>>>>
> >>>>>> Just one small clarification. The same file handler can change the
> >>>>>> value of the async control as many times as it wants, even if the
> >>>>>> operation has not finished.
> >>>>>>
> >>>>>> It will be other file handles that will get -EBUSY if they try to use
> >>>>>> an async control with an unfinished operation started by another fh.
> >>>>>
> >>>>> Yes, I should have been more precised. If the device doesn't send the
> >>>>> control event, then all other file handles will be prevented from
> >>>>> setting the control until the file handle that set it first gets closed.
> >>>>
> >>>> I think I need a bit more background here:
> >>>>
> >>>> First of all, what is an asynchronous control in UVC? I think that means
> >>>> you can set it, but it takes time for that operation to finish, so you
> >>>> get an event later when the operation is done. So zoom and similar operations
> >>>> are examples of that.
> >>>>
> >>>> And only when the operation finishes will the control event be sent, correct?
> >>>
> >>> You are correct.  This diagrams from the spec is more or less clear:
> >>> https://ibb.co/MDGn7F3
> >>>
> >>>> While the operation is ongoing, if you query the control value, is that reporting
> >>>> the current position or the final position?
> >>>
> >>> I'd expect hardware will return either the current position, the start
> >>> position or the final position. I could not find anything in the spec
> >>> that points in one direction or the others.
> >>
> >> Figure 2-21 in UVC 1.5 indicates that the device should STALL the
> >> GET_CUR and SET_CUR requests if a state change is in progress.
> >>
> >>> And in the driver I believe that we might have a bug handling this
> >>> case (will send a patch if I can confirm it)
> >>> the zoom is at 0 and you set it 10
> >>> if you read the value 2 times before the camera reaches value 10:
> >>> - First value will come from the hardware and the response will be cached
> >>
> >> Only if the control doesn't have the auto-update flag set, so it will be
> >> device-dependent. As GET_CUR should stall that's not really relevant,
> >> except for the fact that devices may not stall the request.
> >
> > I missed that the device will likely stall during async operations.
> >
> > What do you think of something like this? I believe it can work with
> > compliant and non compliant devices.
> > Note that the event will be received by the device that originated the
> > operation, not to the second one that might receive an error during
> > write/read.
> >
> >
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index 4fe26e82e3d1..9a86c912e7a2 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1826,14 +1826,15 @@ static int uvc_ctrl_commit_entity(struct
> > uvc_device *dev,
> >                         continue;
> >
> >                 /*
> > -                * Reset the loaded flag for auto-update controls that were
> > +                * Reset the loaded flag for auto-update controls and for
> > +                * asynchronous controls with pending operations, that were
> >                  * marked as loaded in uvc_ctrl_get/uvc_ctrl_set to prevent
> >                  * uvc_ctrl_get from using the cached value, and for write-only
> >                  * controls to prevent uvc_ctrl_set from setting bits not
> >                  * explicitly set by the user.
> >                  */
> >                 if (ctrl->info.flags & UVC_CTRL_FLAG_AUTO_UPDATE ||
> > -                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
> > +                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) || ctrl->handle)
> >                         ctrl->loaded = 0;
> >
> >                 if (!ctrl->dirty)
> > @@ -2046,8 +2047,18 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >         mapping->set(mapping, value,
> >                 uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
> >
> > -       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
> > -               ctrl->handle = handle;
> > +       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
> > +               /*
> > +                * Other file handle is waiting for an operation on
> > +                * this asynchronous control. If the device is compliant
> > +                * this operation will fail.
> > +                *
> > +                * Do not replace the handle pointer, so the original file
> > +                * descriptor will get the completion event.
> > +                */
> > +               if (!ctrl->handle)
> > +                       ctrl->handle = handle;
>
> I don't think this is right: you want the completion event for async
> controls to go to all filehandles that are subscribed to that control.
>
> Which is what happens if handle == NULL (as I understand the code).
>
> Regards,

The code is correct, but the comment is not :). It should say:
 * Do not replace the handle pointer, or the originator of
 * the operation will receive an event.

The originar should NOT receive the event.
From uvc_ctrl_send_event():
/*
 * Send control change events to all subscribers for the @ctrl control. By
 * default the subscriber that generated the event, as identified by @handle,
 * is not notified unless it has set the V4L2_EVENT_SUB_FL_ALLOW_FEEDBACK flag.
 * @handle can be NULL for asynchronous events related to auto-update controls,
 * in which case all subscribers are notified.
 */



>
>         Hans
>
> > +       }
> >
> >         ctrl->dirty = 1;
> >         ctrl->modified = 1;
> >
> >>
> >>> - Second value will be the cached one
> >>>
> >>> now the camera  is at zoom 10
> >>> If you read the value, you will read the cached value
> >>>
> >>>> E.g.: the zoom control is at value 0 and I set it to 10, then I poll the zoom control
> >>>> value: will that report the intermediate values until it reaches 10? And when it is
> >>>> at 10, the control event is sent?
> >>>>
> >>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> >>>>>>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>>>>>>> ---
> >>>>>>>>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >>>>>>>>  1 file changed, 4 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>>> index b6af4ff92cbd..3f8ae35cb3bc 100644
> >>>>>>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>>>>>> @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >>>>>>>>       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >>>>>>>>               return -EACCES;
> >>>>>>>>
> >>>>>>>> +     /* Other file handle is waiting a response from this async control. */
> >>>>>>>> +     if (ctrl->handle && ctrl->handle != handle)
> >>>>>>>> +             return -EBUSY;
> >>>>>>>> +
> >>>>>>>>       /* Clamp out of range values. */
> >>>>>>>>       switch (mapping->v4l2_type) {
> >>>>>>>>       case V4L2_CTRL_TYPE_INTEGER:
> >>
> >> --
> >> Regards,
> >>
> >> Laurent Pinchart
> >
> >
> >
>


-- 
Ricardo Ribalda

