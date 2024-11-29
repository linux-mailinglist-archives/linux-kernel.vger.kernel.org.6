Return-Path: <linux-kernel+bounces-425521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB2E9DC324
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 12:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A211B21273
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5365B19AA72;
	Fri, 29 Nov 2024 11:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bKYz5QjW"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD6156F21
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881312; cv=none; b=uyFAlwaH+jmCueBDl2IIpGwMc9feDEHPymDk7T/ORp/5gxM2GFJZd8MGvvmafKthMzskv7+zCquOVi9KN51qvgAAYRrYnEsKDqHFnAp1OrAZGCKe1tIDJvEbk8g6sisdDtx207huXBw4IZILlR3iyHf6QZK83v/byU9VhVgHeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881312; c=relaxed/simple;
	bh=H94fonH0/iS0Ya400lkWzBlZTIYjE5AlSJn+rurzY0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9v7lJMqtVVOSU6Jy2NkFaJZFSOOdWwAw6u+fNpJViH8r6QjXAJhSIesHx5tZ+qws9Tbbiz1TUSne8Or71TekX9b1yjyiYnbcdTmGBj27IGsZ8w4DT9UhuR32lk6QVrnj/t/W5O0VJNT5NYJaTCqofxAiqISqm+0QdpifUGurt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bKYz5QjW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724f74d6457so1756853b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732881310; x=1733486110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=49ZRrxTPw/7ckWBIVJ4Tn6I41BTVjNlZXEsLbt2obgk=;
        b=bKYz5QjWTx3nLi2Ri1XDJH0ElAFmtOxYCl7XMeBnE9bHz6pAuOd/ck3TDGPPsXxWvs
         LR7JUSYJXnqc2g0xEY3rUXe1u7iAn8qBb7yc0JmunrXsQouJfoAwvbOgg0JBW+O4H1rD
         yLSa5F+0uNjsa8ORhuR5W7tbtP1Ac7r9Bk5PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732881310; x=1733486110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49ZRrxTPw/7ckWBIVJ4Tn6I41BTVjNlZXEsLbt2obgk=;
        b=MJs6wQICnIA+SwTsMEWBDuI+YK0v+5EsvFAXBH4YQO3e6ltcxHp10y85QRT8SEjGYP
         hwgU9WePApOdlcdr6R4cXq8NmpPoSrzU/yewWdklMm6EJrB3Hl5aLNMfC/1wKzpDnpfQ
         /OF+blbXjnG1W2foX3/lNDKOGuA3+dMWIUw1UkJldx8EZaRLzJkzK/qrtwWDHNVb+ZRG
         ELKJ/E/BFJDCjhuEjd1QeKWdYJ4U0YMU7rHkrZbE5HtehSwc4zRiB+pQGufenj4JNaV9
         qTtOVAhHKM3ezDe/YHOMViIDeMEazw2QX2zD9JkuSBki4zhHekQ7T0wCeXB9QI1ufk1A
         xHMg==
X-Forwarded-Encrypted: i=1; AJvYcCX7YuvcrARZFO08KyMoLoqJPEvLsMN0VFg/aMaOnm//esZbB3Q3p2Q0Tuz+Y6sjERS7DIt5nSWa+dWELvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIvx/RiK9nKfedMvYIXBcNxOJDSgZneIF7I3NqjgUrfoEVYZw
	5vKWbrVG1l9MF+fna6VbB+fQPilhm0greQx+2VHvzLI11NAGCIQnMJ//a75LrskmPyF+jujpoXQ
	=
X-Gm-Gg: ASbGncuk9vLeNNayfJMOZDPTB2/ooII6cv8wWuWjdEAmEuYijmaG49g6lI+Yq+niFY8
	j5TqP2YIF8PS6BjinRcGQCvBFQiDsFqAHBvDRYzAodXbOavqCvYzXhcj6zdRWSYVEiuoajAimYw
	MzP964rQIbt/6hhQQ9eAI68jzufCvuY2IVNrbyaXlateqQV1AyvKTmPrEYzFSLmo3Jdzc0zGEs1
	91m/WhLx48PVrvITTwNraDpHmDp3dFx7ZT0ezPcJ2den4B1vowQLg8nnu3RIpzwt9QsurAKVLhT
	THjTaE5F4+439GUM
X-Google-Smtp-Source: AGHT+IGsq1o8CDJ4J/9HSWaJFTFawNRf1mU/FmPI3YjD2nMiQxPJa6MZ9XxIcRrV2WjFdmHbuNeBIQ==
X-Received: by 2002:a05:6a00:2344:b0:720:36c5:b53b with SMTP id d2e1a72fcca58-72530149d08mr14750827b3a.17.1732881309723;
        Fri, 29 Nov 2024 03:55:09 -0800 (PST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541849453sm3372861b3a.183.2024.11.29.03.55.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 03:55:07 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-724f0f6300aso1930836b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 03:55:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDcJJFhZ7nkGd5vOaSwkrpWiC8WD/DEqmogz5qawayl+qzpBTaRdbdkgSdCXZyECa4AzfNNjcgeo3tRDo=@vger.kernel.org
X-Received: by 2002:a17:90b:33ce:b0:2ea:6f90:ce09 with SMTP id
 98e67ed59e1d1-2ee094caf5amr12809220a91.27.1732881306860; Fri, 29 Nov 2024
 03:55:06 -0800 (PST)
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
 <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com> <20241129110640.GB4108@pendragon.ideasonboard.com>
In-Reply-To: <20241129110640.GB4108@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 12:54:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
Message-ID: <CANiDSCvdjioy-OgC+dHde2zHAAbyfN2+MAY+YsLNdUSawjQFHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 12:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Fri, Nov 29, 2024 at 11:59:27AM +0100, Ricardo Ribalda wrote:
> > On Fri, 29 Nov 2024 at 11:36, Hans Verkuil wrote:
> > > On 28/11/2024 23:33, Laurent Pinchart wrote:
> > > > On Thu, Nov 28, 2024 at 11:28:29PM +0100, Ricardo Ribalda wrote:
> > > >> On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart wrote:
> > > >>>
> > > >>> Hi Ricardo,
> > > >>>
> > > >>> (CC'ing Hans Verkuil)
> > > >>>
> > > >>> Thank you for the patch.
> > > >>>
> > > >>> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> > > >>>> If a file handle is waiting for a response from an async control, avoid
> > > >>>> that other file handle operate with it.
> > > >>>>
> > > >>>> Without this patch, the first file handle will never get the event
> > > >>>> associated with that operation, which can lead to endless loops in
> > > >>>> applications. Eg:
> > > >>>> If an application A wants to change the zoom and to know when the
> > > >>>> operation has completed:
> > > >>>> it will open the video node, subscribe to the zoom event, change the
> > > >>>> control and wait for zoom to finish.
> > > >>>> If before the zoom operation finishes, another application B changes
> > > >>>> the zoom, the first app A will loop forever.
> > > >>>
> > > >>> Hans, the V4L2 specification isn't very clear on this. I see pros and
> > > >>> cons for both behaviours, with a preference for the current behaviour,
> > > >>> as with this patch the control will remain busy until the file handle is
> > > >>> closed if the device doesn't send the control event for any reason. What
> > > >>> do you think ?
> > > >>
> > > >> Just one small clarification. The same file handler can change the
> > > >> value of the async control as many times as it wants, even if the
> > > >> operation has not finished.
> > > >>
> > > >> It will be other file handles that will get -EBUSY if they try to use
> > > >> an async control with an unfinished operation started by another fh.
> > > >
> > > > Yes, I should have been more precised. If the device doesn't send the
> > > > control event, then all other file handles will be prevented from
> > > > setting the control until the file handle that set it first gets closed.
> > >
> > > I think I need a bit more background here:
> > >
> > > First of all, what is an asynchronous control in UVC? I think that means
> > > you can set it, but it takes time for that operation to finish, so you
> > > get an event later when the operation is done. So zoom and similar operations
> > > are examples of that.
> > >
> > > And only when the operation finishes will the control event be sent, correct?
> >
> > You are correct.  This diagrams from the spec is more or less clear:
> > https://ibb.co/MDGn7F3
> >
> > > While the operation is ongoing, if you query the control value, is that reporting
> > > the current position or the final position?
> >
> > I'd expect hardware will return either the current position, the start
> > position or the final position. I could not find anything in the spec
> > that points in one direction or the others.
>
> Figure 2-21 in UVC 1.5 indicates that the device should STALL the
> GET_CUR and SET_CUR requests if a state change is in progress.
>
> > And in the driver I believe that we might have a bug handling this
> > case (will send a patch if I can confirm it)
> > the zoom is at 0 and you set it 10
> > if you read the value 2 times before the camera reaches value 10:
> > - First value will come from the hardware and the response will be cached
>
> Only if the control doesn't have the auto-update flag set, so it will be
> device-dependent. As GET_CUR should stall that's not really relevant,
> except for the fact that devices may not stall the request.

I missed that the device will likely stall during async operations.

What do you think of something like this? I believe it can work with
compliant and non compliant devices.
Note that the event will be received by the device that originated the
operation, not to the second one that might receive an error during
write/read.



diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..9a86c912e7a2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1826,14 +1826,15 @@ static int uvc_ctrl_commit_entity(struct
uvc_device *dev,
                        continue;

                /*
-                * Reset the loaded flag for auto-update controls that were
+                * Reset the loaded flag for auto-update controls and for
+                * asynchronous controls with pending operations, that were
                 * marked as loaded in uvc_ctrl_get/uvc_ctrl_set to prevent
                 * uvc_ctrl_get from using the cached value, and for write-only
                 * controls to prevent uvc_ctrl_set from setting bits not
                 * explicitly set by the user.
                 */
                if (ctrl->info.flags & UVC_CTRL_FLAG_AUTO_UPDATE ||
-                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR))
+                   !(ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) || ctrl->handle)
                        ctrl->loaded = 0;

                if (!ctrl->dirty)
@@ -2046,8 +2047,18 @@ int uvc_ctrl_set(struct uvc_fh *handle,
        mapping->set(mapping, value,
                uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));

-       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
-               ctrl->handle = handle;
+       if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS) {
+               /*
+                * Other file handle is waiting for an operation on
+                * this asynchronous control. If the device is compliant
+                * this operation will fail.
+                *
+                * Do not replace the handle pointer, so the original file
+                * descriptor will get the completion event.
+                */
+               if (!ctrl->handle)
+                       ctrl->handle = handle;
+       }

        ctrl->dirty = 1;
        ctrl->modified = 1;

>
> > - Second value will be the cached one
> >
> > now the camera  is at zoom 10
> > If you read the value, you will read the cached value
> >
> > > E.g.: the zoom control is at value 0 and I set it to 10, then I poll the zoom control
> > > value: will that report the intermediate values until it reaches 10? And when it is
> > > at 10, the control event is sent?
> > >
> > > >>>> Cc: stable@vger.kernel.org
> > > >>>> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > > >>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > >>>> ---
> > > >>>>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> > > >>>>  1 file changed, 4 insertions(+)
> > > >>>>
> > > >>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > > >>>> index b6af4ff92cbd..3f8ae35cb3bc 100644
> > > >>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > > >>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > > >>>> @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> > > >>>>       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> > > >>>>               return -EACCES;
> > > >>>>
> > > >>>> +     /* Other file handle is waiting a response from this async control. */
> > > >>>> +     if (ctrl->handle && ctrl->handle != handle)
> > > >>>> +             return -EBUSY;
> > > >>>> +
> > > >>>>       /* Clamp out of range values. */
> > > >>>>       switch (mapping->v4l2_type) {
> > > >>>>       case V4L2_CTRL_TYPE_INTEGER:
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

