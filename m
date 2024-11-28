Return-Path: <linux-kernel+bounces-425105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8439DBD86
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 23:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9945EB22134
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16771C4A0A;
	Thu, 28 Nov 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ElrmuM1z"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1B1C2DAE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732832926; cv=none; b=PD5JuQmZmL083g97iZVD86854qGH16HFt2j2qjP9HgE2seQhpcJhWhKwbVEQPlLhIjslNggXQuserA9OD4e5GbVwHroHBo0Osu5msAq/GU5/pZV+AexOJEY8GZcrp82fORk9IjPMVHgFute725ypvfF0ovk232a+RXs9GB3DQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732832926; c=relaxed/simple;
	bh=8lq5+GM4KnxEtuVXVOGIdvmiEazYybHaFmVLqIFcr8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHWTzug4XbdtOZeTITtktg49s9t69ca4FTbwt+Pbrgy3FYjxLZEztnVA4Bwsk837u17f/5klPnFuwJGz2eJ7ZfzT5PfWCHjU3ge9XsUmkdld2cb3dQrgAZTBfNbavp9WKV0hAV8s0AgayxEiXlzltRVHbFSLqQsGOV77L41e5Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ElrmuM1z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21260209c68so15681635ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732832924; x=1733437724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6YHsdk6gFEBYCcBAXe7bD6v4I0e45HlFShaBv7kWeI4=;
        b=ElrmuM1z5quPTdnVr36T6WABEzJO/y2HM6Bfrm0YIyCSpS9tqO6eEFPywtrOFt8h5j
         05dE5BSo99KUOh0oxD0Znwh8b3m4DYtqIkhRnsndFABMETo3BWrZNZbZ/WJoyiukpVuF
         DMcTu8v6Qh0rZ/k1cqGiiEzs600NhqPbhVZDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732832924; x=1733437724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YHsdk6gFEBYCcBAXe7bD6v4I0e45HlFShaBv7kWeI4=;
        b=E/NbEw9QDzUA9STwmkSeoXj4bwp+QI5IomDJAR4eLbK2WXe7c5JADFQhCfG4mtzeze
         DkM1B8hFMHpfvq/LpiHJPvJAIBAq5TMBleUmMHvQlcPyii6vNeHJRo8oUtXZyDQ/pVKI
         hfq3fGjfZSXcg+ArwNXyaYdi8FGMStPlxWKKDAhAI6Z9aK7L0uiFydpnyiQXDDz3tZ52
         c+rhK/0cT/SGqqi4mSwyCJrs+KfS+DExRIfs5NH8WyuBzW1tQQ1L4aS6O11aVgUzWfuj
         TOESbciOZJND30L8tHuYliAb1j9iItoiYuI7rJ6lKbpOhwf+0YxI3D8c89QO1P+F4yEn
         54Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXkLItRERLbpgSn34dkqcFt2jda5N7hpC0zTPUcsa6MwcFNff2IUEFpUfR+DmeOm367bTMmhQmPty2bT5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYyyAbjJ4OzXV+GiUY4D9liPFBWZpik3YHVKU94GNJRUfloBiu
	OIpqKDp6aHVBfj1+xvfLudzsed58io330Rdsf5cZbIXbJoNmfmjd7PtKGDEGbJzyqBFszI2p3PM
	=
X-Gm-Gg: ASbGncufgnp240XDnVMByE33v3W65/uV7904eizfmTeAw5rJXyOinzDvsaBH3mgHi88
	HVGUYXdx0qrNg9Jb/HGx4NVbvMTx3hMutZ3w002l9xkC4n4BgFsi0cjf4E03MrdXaFugJzm5tmZ
	0zHU8LuEOMqba6lamW10V0IRWdIOvyilUhqbXmY3/WZ/lawNxt9BvdSBmvvxmlFLI9CuHxy0NLM
	jDcg6cFkng1VRxwGnDV8vT7SbRa1xYWSCeRTh79kPtjsQo/wt3LeZdgg+ek1LZ8XTMZD6012BD0
	72blbFmJD3r5uAUB
X-Google-Smtp-Source: AGHT+IH3pqiM9FIDNyGXpC3ri6tGASCcM7+QrhOGTaYTh8IXvfFxUx9neTF/tiDXg4aAVNhwCY4/Fw==
X-Received: by 2002:a17:902:fc4d:b0:212:38d7:78ea with SMTP id d9443c01a7336-2151d861ac3mr82334475ad.25.1732832923830;
        Thu, 28 Nov 2024 14:28:43 -0800 (PST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com. [209.85.210.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530d2073esm11202875ad.73.2024.11.28.14.28.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 14:28:42 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7251ace8bc0so1668674b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:28:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNIYsssxCpsJsIH2rRSNvkE8Perbef1P7nfpYjuGmISYslW9CeZM2AJ92AI/1H9fSZpgV/GOt/+Jp7BvM=@vger.kernel.org
X-Received: by 2002:a17:90a:9f93:b0:2ea:5658:9ed6 with SMTP id
 98e67ed59e1d1-2ee25b38db4mr7346429a91.12.1732832921898; Thu, 28 Nov 2024
 14:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
 <20241127-uvc-fix-async-v2-2-510aab9570dd@chromium.org> <20241128222232.GF25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128222232.GF25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 23:28:29 +0100
X-Gmail-Original-Message-ID: <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
Message-ID: <CANiDSCvyMbAffdyi7_TrA0tpjbHe3V_D_VkTKiW-fNDnwQfpGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] media: uvcvideo: Do not set an async control owned
 by other fh
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, 
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 23:22, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> (CC'ing Hans Verkuil)
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 12:14:50PM +0000, Ricardo Ribalda wrote:
> > If a file handle is waiting for a response from an async control, avoid
> > that other file handle operate with it.
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
> Hans, the V4L2 specification isn't very clear on this. I see pros and
> cons for both behaviours, with a preference for the current behaviour,
> as with this patch the control will remain busy until the file handle is
> closed if the device doesn't send the control event for any reason. What
> do you think ?

Just one small clarification. The same file handler can change the
value of the async control as many times as it wants, even if the
operation has not finished.

It will be other file handles that will get -EBUSY if they try to use
an async control with an unfinished operation started by another fh.

>
> > Cc: stable@vger.kernel.org
> > Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> > index b6af4ff92cbd..3f8ae35cb3bc 100644
> > --- a/drivers/media/usb/uvc/uvc_ctrl.c
> > +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> > @@ -1955,6 +1955,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
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

