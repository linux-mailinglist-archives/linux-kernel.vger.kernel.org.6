Return-Path: <linux-kernel+bounces-437911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C459E9A5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2F8282589
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA7233132;
	Mon,  9 Dec 2024 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BlS1wcdT"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A71B423A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757752; cv=none; b=PPK3Z+MUyTb3Typm9Efm20Wy3aq6/j45SRL8JZUHs00zUWoHB/Db+HViiSuQxxktMQPd173cy3cnDyIW/xlFy98NW1Kr9OYdVJxm/USwNtEaMUbD0H0kpkouyXC9YFm7Yd5a602ILNRt2KLwlYjmnWYhRFgLqM2hGuTI11c3uXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757752; c=relaxed/simple;
	bh=e/7ppiXyE2bFji2DbmrW2m2o9qtifu9hg/k0DBCP/IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlwQYkWU9faWggBs1EifeJcTQhP3TnYvTImjuzE2F4Ge46+03T3+9d2/Mg6+reOMyaxD5IVyN+hq+i5qBRgA/3V2+BY3wr45Fd5LV1EoHlQ8Y0Y1Vp8rfUOVHYWkBN8Smz1g1xYHye5lOrcU0fdAqpc1/TOkrWjyH78G6s8nL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BlS1wcdT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7feb6871730so10033a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733757750; x=1734362550; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k13rlXoGpiagaLgzB2bt6QaSqrl1LnLToosBhhhXPa4=;
        b=BlS1wcdTZY/EWL28y6ExfJJpxJEvC2AL+2BngpZwg0Lyby4E62WXVpwokmCksPiN91
         Fos93YlsfRmrzvCAzCiTmMeBtf0Qrp5KbQosjv//5mtn6Dplhk5tfpTDiAPl1JaPF9/r
         NjZbWD8Lk2mjTydrZ0AFOwrxJFRFknuYLv6aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733757750; x=1734362550;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k13rlXoGpiagaLgzB2bt6QaSqrl1LnLToosBhhhXPa4=;
        b=Mj7fVOAxRP1KIgxoOCMhWxY895URTA6G7/vvR7mIMNQXFUroSaOi064UBcGg9ulWSK
         DZ9WT65KE1INc543faEopKadYXz9fnmZmJGdmLflP6aJHY+EBmg16/0h5Czu/wL98duB
         LfVfKu5RltN8Gmndhb2d0Ci5OKwpWIIyh4pCzKfGObluFT0mstq37q/JjbLF1p28t+Es
         snkkKRNIv9mHL4wehGtOL3+2iwwmeB6oFtxAgEMmO7ZyBinhr3XSjh8pbxcladog55TG
         ZBmUKv97sEOsdqsqTE+RvrkULaXe2qDeiCZegxwleOwAxOti/TMRB2inBwjIUvacpahs
         H7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFeMZrrzFCKxRvhcfp94SZaVtxzGkAVPy/PdLr5XP9EeIomlDgN8BR12e6XGj6n17ogHJ7rgTZqHo/ZuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYhEyxsS2jBc8vjZh6XUzQISV76VNm2PIAJEmJwaf6vRh+ePo
	M/JCZh80yOHwjvP0ZO5mpJ7ytL+/SRudK7S5SLKSeKtNX1u4iyrYRIIbw2Rgy4rRynqQxO6IQDE
	=
X-Gm-Gg: ASbGncvpZl/6gL3lI1A70gU/TLs7xVFlXDagzQqfwUZUbkphBCiQ/QKkUjtQzceEkz7
	rdCHo+AHvtBMOR4Agfj+6zJdWNJ3FjLGfUDBJY789tVIQDQO1XdXVoUCw4XV5s3ICuELJ/ll6bH
	+LwuM8q6pHs2sbDlETW85u7UQFL8P88tduxdpQffkUEC4FEGVpcaZXtzWqgUvZHqnzISbto3MjN
	kLm1xB54ACuVTqbFDSM1KOHCroky/RwR1RUA3D5jJ1NRYsJ6ZvFiEB5A+BHJavlZUrq1LYwvdlW
	eyIX7sTOoU82
X-Google-Smtp-Source: AGHT+IE9WVtsyFocGdlnzyhU5zhu14JXXTbbJQ1HwlHy9Cgiu5VqZ/NCxIszPxgEhz20Afsx/Wt5Nw==
X-Received: by 2002:a17:90b:53ce:b0:2ef:30ec:14c9 with SMTP id 98e67ed59e1d1-2efcf16a492mr1300461a91.18.1733757749692;
        Mon, 09 Dec 2024 07:22:29 -0800 (PST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef2701df43sm10955123a91.30.2024.12.09.07.22.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 07:22:27 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ee709715d9so3238779a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 07:22:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0ORQ0SISPyjpC1jLjTEc8xorf7Qg5ygYugMeYejUTjoNwO3eeDiJy7gQkHOx+ZJxQYgyoDg6CnCiIM/w=@vger.kernel.org
X-Received: by 2002:a17:90b:4d06:b0:2ee:c9b6:c26a with SMTP id
 98e67ed59e1d1-2efcf138420mr1295203a91.11.1733757746400; Mon, 09 Dec 2024
 07:22:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-19-64cfeb56b6f8@chromium.org> <13a3c23e-7a8a-4957-bdd7-d8de2844b904@redhat.com>
In-Reply-To: <13a3c23e-7a8a-4957-bdd7-d8de2844b904@redhat.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 9 Dec 2024 16:22:14 +0100
X-Gmail-Original-Message-ID: <CANiDSCsphbdkHePXManvtR_i4iSUmHkFXQLzZGSc7BJ900c1Hw@mail.gmail.com>
X-Gm-Features: AZHOrDn0N1TZg5Q94fWHeePIo8PqMNl6cI-URvT0Qt10Fcm3cJjtpHyddN1HXmM
Message-ID: <CANiDSCsphbdkHePXManvtR_i4iSUmHkFXQLzZGSc7BJ900c1Hw@mail.gmail.com>
Subject: Re: [PATCH v15 19/19] media: uvcvideo: document UVC v1.5 ROI
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Mon, 9 Dec 2024 at 15:36, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> > From: Yunke Cao <yunkec@google.com>
> >
> > Added documentation of V4L2_CID_UVC_REGION_OF_INTEREST_RECT and
> > V4L2_CID_UVC_REGION_OF_INTEREST_AUTO.
> >
> > An example of a userspace implementing this feature can be found at:
> > https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/release-R121-15699.B/camera/hal/usb/
> >
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Signed-off-by: Yunke Cao <yunkec@google.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > --->  .../userspace-api/media/drivers/uvcvideo.rst       | 64 ++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/media/drivers/uvcvideo.rst b/Documentation/userspace-api/media/drivers/uvcvideo.rst
> > index a290f9fadae9..1cdcd45907a3 100644
> > --- a/Documentation/userspace-api/media/drivers/uvcvideo.rst
> > +++ b/Documentation/userspace-api/media/drivers/uvcvideo.rst
> > @@ -181,6 +181,7 @@ Argument: struct uvc_xu_control_mapping
> >       UVC_CTRL_DATA_TYPE_BOOLEAN      Boolean
> >       UVC_CTRL_DATA_TYPE_ENUM         Enumeration
> >       UVC_CTRL_DATA_TYPE_BITMASK      Bitmask
> > +     UVC_CTRL_DATA_TYPE_RECT         Rectangular area
> >
> >
> >  UVCIOC_CTRL_QUERY - Query a UVC XU control
> > @@ -255,3 +256,66 @@ Argument: struct uvc_xu_control_query
> >       __u8    query           Request code to send to the device
> >       __u16   size            Control data size (in bytes)
> >       __u8    *data           Control value
> > +
> > +
> > +Driver-specific V4L2 controls
> > +-----------------------------
> > +
> > +The uvcvideo driver implements the following UVC-specific controls:
> > +
> > +``V4L2_CID_UVC_REGION_OF_INTEREST_RECT (struct)``
> > +     This control determines the region of interest (ROI). ROI is a
> > +     rectangular area represented by a struct :c:type:`v4l2_rect`. The
> > +     rectangle is in global sensor coordinates and pixel units. It is
>
> Maybe: "The rectangle is in global sensor coordinates using pixel units" ?
>
> being "in pixel units" sounds a bit weird and had me confused for a moment.
>
> > +     independent of the field of view, not impacted by any cropping or
> > +     scaling.
> > +
> > +     Use ``V4L2_CTRL_WHICH_MIN_VAL`` and ``V4L2_CTRL_WHICH_MAX_VAL`` to query
> > +     the range of rectangle sizes.
> > +
> > +     Setting a ROI allows the camera to optimize the capture for the region.
> > +     The value of ``V4L2_CID_REGION_OF_INTEREST_AUTO`` control determines
> > +     the detailed behavior.
> > +
> > +     An example of use of this control, can be found in the:
> > +     `Chrome OS USB camera HAL.
> > +     <https://chromium.googlesource.com/chromiumos/platform2/+/refs/heads/release-R121-15699.B/camera/hal/usb/>`
>
> Hmm, not sure we want this in the API documentation. OTOH why not ? Anyone else
> have an opinion on this ?

Laurent requested this:
https://lore.kernel.org/linux-media/20231218034413.GN5290@pendragon.ideasonboard.com/

>
> > +
> > +
> > +``V4L2_CID_UVC_REGION_OF_INTEREST_AUTO (bitmask)``
> > +     This determines which, if any, on-board features should track to the
> > +     Region of Interest specified by the current value of
> > +     ``V4L2_CID_UVD__REGION_OF_INTEREST_RECT``.
> > +
> > +     Max value is a mask indicating all supported Auto Controls.
> > +
> > +.. flat-table::
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_EXPOSURE``
> > +      - Setting this bit causes automatic exposure to track the region of
> > +     interest instead of the whole image.
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_IRIS``
> > +      - Setting this bit causes automatic iris to track the region of interest
> > +        instead of the whole image.
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_WHITE_BALANCE``
> > +      - Setting this bit causes automatic white balance to track the region
> > +     of interest instead of the whole image.
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_FOCUS``
> > +      - Setting this bit causes automatic focus adjustment to track the region
> > +        of interest instead of the whole image.
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_FACE_DETECT``
> > +      - Setting this bit causes automatic face detection to track the region of
> > +        interest instead of the whole image.
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_DETECT_AND_TRACK``
> > +      - Setting this bit enables automatic face detection and tracking. The
> > +     current value of ``V4L2_CID_REGION_OF_INTEREST_RECT`` may be updated by
> > +     the driver.
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_IMAGE_STABILIZATION``
> > +      - Setting this bit enables automatic image stabilization. The
> > +     current value of ``V4L2_CID_REGION_OF_INTEREST_RECT`` may be updated by
> > +     the driver.
>
> This one I do not understand. Since the ROI is not a crop, I don't see how
> this interacts with image-stabilization. Typically digital image-stabilization
> uses a moving slightly smaller crop of the full sensor rectangle which it moves
> around in realtime to compensate for camera movements.
>
> So I wonder what this is expected to do. Does this set the ROI to the image
> stabilization crop ? I guess that combined with reading back the ROI that might be
> somewhat useful to follow what the image stabilization code is doing.
>
> OTOH this does not seem useful for using as region for AEC / AWB ?

Unfortunately, the standard is not very verbose about this:
https://ibb.co/VppnQ43

What about:

- ``Image Stabilization`` bit from the UVC's bmAutoControls Region of
Interest Control.

?


>
>
> > +    * - ``V4L2_UVC_REGION_OF_INTEREST_AUTO_HIGHER_QUALITY``
> > +      - Setting this bit enables automatically capture the specified region
> > +        with higher quality if possible.
> >
>
> Otherwise this looks good to me. But I would still like to see
> a discussion about using UVC custom ctrls instead of something standardized
> for this. Although I guess maybe that already happened before I got involved ?

Seems like both Hans V and Laurent preferred uvc custom controls:

https://lore.kernel.org/linux-media/a0fe2b49-12b7-8eaf-c3ef-7af1a247e595@xs4all.nl/

>
> Regards,
>
> Hans
>


-- 
Ricardo Ribalda

