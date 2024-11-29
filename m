Return-Path: <linux-kernel+bounces-425464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7449DC271
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF4C281B26
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD119884C;
	Fri, 29 Nov 2024 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LQGrFcDl"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A491C198E6F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877985; cv=none; b=Xjp+IwsnPp5IXO1ASQy9xyOb0lIuJK5saGRoFfF9r8u9QdgfolWq44Luh/fQVrOhEkL3ctrCsP3DJB4Pj9nQGYX2YHQ4vrQ/l2OkS/Jk2/zuZcYf6U2z02yxcFpTEDZlmtNZbJYmD0uKIRR8CA2Ah+Lb4UKHJrE/51mFGxLmdLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877985; c=relaxed/simple;
	bh=LvK9ek1qytL/0nRFg8sPALh26iCrGrpMHaJkB3WI40c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpf4e1k8v1qO+Jak8p3hj6fpNEAjLeACLGzTnMqp3U9GOrWbuXeH4ucN1k/aXH2uEOiUAn/P7t8p0geQ2TZL6YLEGEoV9n9Y7wiQTHY8XWVPOVGaAIGq1a7WVbaknKu5QTyCd0Sgb4VydBmwCM5wIpyVPeCWvp0n7zLo3EtJeg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LQGrFcDl; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21207f0d949so15205835ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732877983; x=1733482783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDjy0MV4148joBtQzxlgNjU2q8U1MtS3upsI0Kv1yqg=;
        b=LQGrFcDlWYsH/MgL8SV1L0/4FXIaJSmwz5TulESfoo2ED4IH7xb6gFR9iAeDoMOcSa
         HmJXWHcFEO1IhZ1NxbewUH+9DBWc7jIdndW0O+7Djf0SMx59s/rJs+rbiIu0j2FKova0
         TY9Yw9aNdX9nS9k8sukBRHARwh5yncBrT2ECU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732877983; x=1733482783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDjy0MV4148joBtQzxlgNjU2q8U1MtS3upsI0Kv1yqg=;
        b=MQsL3frwmGD4Q7BIGbTIjAaHczLGw0dXWOjVfoAH21Xo/kFFhNfDRzzPSxNwtaN1gB
         +4FJVkiENx3XBQoBZN0UbESyzC5KmbQ8sJ1I+ynMejOV1lUw2IipRVZvVkvbTrhQcaxE
         d2qELhvb4jAIYiNVg4nT0xgWJFVwrS+kukqdrZnVoL4EYDKCnjqdfNcYYi3SbeD6+7BW
         JhBxoWPZeodql+1Ho7T8yFIteKBIsJfHIaHZgTbUmnJd0bDUOna6Z3XstBnuqUllGdG1
         HlR4ksbQqagAn+F0INqT4E/0KyRewy4IumKMtd0XI6b7tRZ2NyNAsj6l8nVT9NzTKAi9
         97Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVBS1W4+3eFO+zI/dkth9G9Bkp0OM3PKzxhuAVjdAbbAYp2Z0J5/JSVjpXchDYyWppVjaP6ofVja3Sn4HY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PTl+sKx4lHi6OkiRUQe/f4rXimz2dc0Z5AX5dVK7YRe7BGiX
	lP614oSw9HvqKmiY4WipDS1thh4QVJ06xn/106nppcFtKypOxFCg23ECFhysWZIih2JKSjZL4cs
	=
X-Gm-Gg: ASbGncui2xSUwnE7TCvO5eN5AoJNgJ3CEqsdNIvkTGgnbSipinFS33zNrRl6vJV2CWH
	aE1KrUucvAGbplDwc3SAzlhlIpSu2EMsMgDCNw7ML/9sP2w/VBpktJ5ORLfcfV+dxy8WWEUCsxO
	bpY7vPFSMcDg2UmYfkGa+oAnG0l+NkMUUO9+A3vj8frkc4/osfpt8VM01UAFRWgzSt/q4CrV1we
	dHwSL1v6TyWAU8qQlfbltZIveD3rsRLuGvj21WBlqIHg0jWfL8mhMBFFqUNfjHgNTgO9mqC3S9P
	w6125BT0dWxS
X-Google-Smtp-Source: AGHT+IFlXz8Q6b/IE61LEEL7SicSQGv0RxVhIrreZCQNafioPMheGH0ITzk0y/6InZEWntvC4ymgtw==
X-Received: by 2002:a17:902:e5cb:b0:20c:79bf:6793 with SMTP id d9443c01a7336-215010854cbmr120342815ad.3.1732877982836;
        Fri, 29 Nov 2024 02:59:42 -0800 (PST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219cc8efsm28020815ad.262.2024.11.29.02.59.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 02:59:42 -0800 (PST)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee69fc0507so158793a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:59:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVkjNB2ehZIrLJhIc+84kP4rneq5bTX7WivHw1OOcvaVaJCDqLWaMoOpUZNdVGt2cv1CTnHA/MM1IrjUK4=@vger.kernel.org
X-Received: by 2002:a17:90b:38cd:b0:2ea:addc:9f51 with SMTP id
 98e67ed59e1d1-2ee08e5e3e0mr13083763a91.2.1732877979790; Fri, 29 Nov 2024
 02:59:39 -0800 (PST)
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
In-Reply-To: <7eeab6bd-ce02-41a6-bcc1-7c2750ce0359@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 11:59:27 +0100
X-Gmail-Original-Message-ID: <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
Message-ID: <CANiDSCseF3fsufMc-Ovoy-bQH85PqfKDM+zmfoisLw+Kq1biAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Nov 2024 at 11:36, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> Hi Laurent, Ricardo,
>
> On 28/11/2024 23:33, Laurent Pinchart wrote:
> > On Thu, Nov 28, 2024 at 11:28:29PM +0100, Ricardo Ribalda wrote:
> >> On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart wrote:
> >>>
> >>> Hi Ricardo,
> >>>
> >>> (CC'ing Hans Verkuil)
> >>>
> >>> Thank you for the patch.
> >>>
> >>> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> >>>> If a file handle is waiting for a response from an async control, avoid
> >>>> that other file handle operate with it.
> >>>>
> >>>> Without this patch, the first file handle will never get the event
> >>>> associated with that operation, which can lead to endless loops in
> >>>> applications. Eg:
> >>>> If an application A wants to change the zoom and to know when the
> >>>> operation has completed:
> >>>> it will open the video node, subscribe to the zoom event, change the
> >>>> control and wait for zoom to finish.
> >>>> If before the zoom operation finishes, another application B changes
> >>>> the zoom, the first app A will loop forever.
> >>>
> >>> Hans, the V4L2 specification isn't very clear on this. I see pros and
> >>> cons for both behaviours, with a preference for the current behaviour,
> >>> as with this patch the control will remain busy until the file handle is
> >>> closed if the device doesn't send the control event for any reason. What
> >>> do you think ?
> >>
> >> Just one small clarification. The same file handler can change the
> >> value of the async control as many times as it wants, even if the
> >> operation has not finished.
> >>
> >> It will be other file handles that will get -EBUSY if they try to use
> >> an async control with an unfinished operation started by another fh.
> >
> > Yes, I should have been more precised. If the device doesn't send the
> > control event, then all other file handles will be prevented from
> > setting the control until the file handle that set it first gets closed.
>
> I think I need a bit more background here:
>
> First of all, what is an asynchronous control in UVC? I think that means
> you can set it, but it takes time for that operation to finish, so you
> get an event later when the operation is done. So zoom and similar operations
> are examples of that.
>
> And only when the operation finishes will the control event be sent, correct?

You are correct.  This diagrams from the spec is more or less clear:
https://ibb.co/MDGn7F3

>
> While the operation is ongoing, if you query the control value, is that reporting
> the current position or the final position?

I'd expect hardware will return either the current position, the start
position or the final position. I could not find anything in the spec
that points in one direction or the others.

And in the driver I believe that we might have a bug handling this
case (will send a patch if I can confirm it)
the zoom is at 0 and you set it 10
if you read the value 2 times before the camera reaches value 10:
- First value will come from the hardware and the response will be cached
- Second value will be the cached one

now the camera  is at zoom 10
If you read the value, you will read the cached value


>
> E.g.: the zoom control is at value 0 and I set it to 10, then I poll the zoom control
> value: will that report the intermediate values until it reaches 10? And when it is
> at 10, the control event is sent?
>
> Regards,
>
>         Hans
>
> >
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> >>>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>>> ---
> >>>>  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >>>>  1 file changed, 4 insertions(+)
> >>>>
> >>>> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> index b6af4ff92cbd..3f8ae35cb3bc 100644
> >>>> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> >>>> @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
> >>>>       if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
> >>>>               return -EACCES;
> >>>>
> >>>> +     /* Other file handle is waiting a response from this async control. */
> >>>> +     if (ctrl->handle && ctrl->handle != handle)
> >>>> +             return -EBUSY;
> >>>> +
> >>>>       /* Clamp out of range values. */
> >>>>       switch (mapping->v4l2_type) {
> >>>>       case V4L2_CTRL_TYPE_INTEGER:
> >
>


-- 
Ricardo Ribalda

