Return-Path: <linux-kernel+bounces-425093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B29DBD5F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B251649D9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2141C4609;
	Thu, 28 Nov 2024 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nHdSaYp7"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092014E2C0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732830578; cv=none; b=prS66oJw7h/pudGG4WViIiZxiKdQfkssu8+9Z7gmhDnB09EDGOCRKfFuLyJbRgSVgtKMzOcrGJZW0jBr5eKpa6wGFhvcp5DFDrVv/C0/d/j4vrj5EaWS8pjWwK/38GXq+//UqwfeoIlMV7sWuC5BtO+ooRJWdRRV89iEMMSZnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732830578; c=relaxed/simple;
	bh=USiD9t55PxHTOJGMocZenoFCJFXblvsqYmzbtsQ8V1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYOiL4MOPO7ibp4CkkjZo6Epevg4o9jSjHFIp42PbmXsgBKC5jcZ5yAEkuL4Wvhgqj2F7dAn6RsFUUVDIqbnMiWhy0nuUXiQI6hbXMM3f/2hYlZ/GSc9N6bqts1aPVGRQGIPkI1wR0U6539VUeU0ueesvWw3arrymu618D0pnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nHdSaYp7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21288402a26so9458905ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732830575; x=1733435375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDBginDxuBSRjj7TI1uec63Bxogn5cmMPw/VXGr+his=;
        b=nHdSaYp7h32szCCrF/v3gFoqGJx4/KsFVzVd33vbpoAtNm0STyIof29wLzITnB/utg
         16baxwHL9NzY/FIOz1gFfiOTpf55JvNnt8sPJYh+w8q9P2j5OnyUdcYOBc2mZSWBjwgd
         QsJPAPa0u2lD/GUaiqy6KS3a3s61qazZjniNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732830575; x=1733435375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDBginDxuBSRjj7TI1uec63Bxogn5cmMPw/VXGr+his=;
        b=kcW686lD906PAlxPbmQ9Ce3rvM2fW0ms9vM9eBtPVRlbTwyvEgZuwlaGCDjBEu1xtK
         sUaN/pSOaULKi70DA+VoIQZcLA8gKSCGHA4MUJC5yTgaKqjGhyBfMBOnhbfF8pyFQRT0
         ti3QaAJEugibvqnVLHAjJDUNvSE7sUUfXT2Irz0wj98sRcOlheGh6NynNrz7iWbw3KSD
         BtfPBiqhsbdQLcAv/RpWpHKPautqhJ1g9OR5aFWOr4BOj88BBweO3j2IvKvG6kxx6Cd1
         tNbs2fj8fj6eIqJwgNQENLjtcG8DleTMWG1DxiZ43hfUtnM8P7FeIYZfLQYuO8w8Ejli
         i+sA==
X-Forwarded-Encrypted: i=1; AJvYcCW1tlx5lDh+PozXXXFWWJcXAjV0U0xGOj7ox1krQtpL0gcCOtYPs5YG8qc8HQko1FWEoQ+cngpqPiGKeTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYxfBGoxFg3VP/EzY1uCXjOkdswn8OCGC3qDNXBMU0TMkS1xg
	Sgt2IqnUV8Olf02+SehQX8iZmmgH3GTzJlwOSQ0OgtIvjNeCa0A1lMOYhhwM5PlyxM0zicWdzGQ
	=
X-Gm-Gg: ASbGncsD+iIFkoA3moNiK9ARLvSS8zFyGN0WLeVIFz4iz7KGsAb4HQAArgOys28vICo
	XqNNfFdzVGRbJrQCetuBTWXAqBDJ0JM01PiqeEJ41kfQTBNYDfEtY1TZvhpJLDeQ/nWAEJ9NdJk
	SNGBQXKZWVRLDc0/sQ8H8nsrrOECnM4xi3s9TTj/Y78/9VKVC2UumMhbpJce6QEiMY3iDro4Vrd
	3EhCmiTOATQXwbeSsb5kSaFfaDDzuTxOw6RYixQ0q/98dFl7uzvT0RFWHFzpw1ys3xwVH2F9xzF
	EjoNd3g0dPyJ
X-Google-Smtp-Source: AGHT+IF2c872CQDzZzrz6AvRduJSuTkVEFOCESjWJygz7OF04GW1PVwpIqSUix/bWWECj9flK+F4xQ==
X-Received: by 2002:a17:902:ce87:b0:20c:6bff:fca1 with SMTP id d9443c01a7336-21501570717mr108549815ad.23.1732830574728;
        Thu, 28 Nov 2024 13:49:34 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219c9b32sm18325145ad.263.2024.11.28.13.49.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 13:49:34 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea39f39666so886244a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:49:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXO2cdzXu22eLgvd1wqbPlWGiAxX7zQfES3T4KED3w7RRnJ8A1Ho6SbA6YuV7iJacx1X4W2HnMQnzmVU/4=@vger.kernel.org
X-Received: by 2002:a17:90b:548f:b0:2ea:2a8d:dd2a with SMTP id
 98e67ed59e1d1-2ee095bff07mr10313522a91.27.1732830573104; Thu, 28 Nov 2024
 13:49:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-dup-cap-out-v1-1-1bdcad2dabb0@chromium.org>
 <20241128202442.GC13852@pendragon.ideasonboard.com> <20241128203127.GD13852@pendragon.ideasonboard.com>
 <CANiDSCt69HXfRmWHKGELWoUE45bZeWUgVc3C7=aAvykUYZBUzQ@mail.gmail.com> <20241128204619.GB25731@pendragon.ideasonboard.com>
In-Reply-To: <20241128204619.GB25731@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 22:49:20 +0100
X-Gmail-Original-Message-ID: <CANiDSCvKfNSdUb35AibcNg0d5NerpzeOB2SVss7+-4wy27BaCg@mail.gmail.com>
Message-ID: <CANiDSCvKfNSdUb35AibcNg0d5NerpzeOB2SVss7+-4wy27BaCg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Remove duplicated cap/out code
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 21:46, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Nov 28, 2024 at 09:36:06PM +0100, Ricardo Ribalda wrote:
> > On Thu, 28 Nov 2024 at 21:31, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > >
> > > On Thu, Nov 28, 2024 at 10:24:42PM +0200, Laurent Pinchart wrote:
> > > > Hi Ricardo,
> > > >
> > > > Thank you for the patch.
> > > >
> > > > On Wed, Nov 27, 2024 at 07:31:29AM +0000, Ricardo Ribalda wrote:
> > > > > The *_vid_cap and *_vid_out helpers seem to be identical. Remove all the
> > > > > duplicated code.
> > > > >
> > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > ---
> > > > > Unless I miss something, cap and out helpers are identical. So there is
> > > > > no need to duplicate code
> > > > > ---
> > > > >  drivers/media/usb/uvc/uvc_v4l2.c | 112 ++++++++-------------------------------
> > > > >  1 file changed, 22 insertions(+), 90 deletions(-)
> > > > >
> > > > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > index 97c5407f6603..11ccdaf0269f 100644
> > > > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > > > @@ -361,9 +361,11 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
> > > > >     return ret;
> > > > >  }
> > > > >
> > > > > -static int uvc_v4l2_get_format(struct uvc_streaming *stream,
> > > > > -   struct v4l2_format *fmt)
> > > > > +static int uvc_ioctl_g_fmt(struct file *file, void *fh,
> > > > > +                      struct v4l2_format *fmt)
> > > > >  {
> > > > > +   struct uvc_fh *handle = fh;
> > > > > +   struct uvc_streaming *stream = handle->stream;
> > > > >     const struct uvc_format *format;
> > > > >     const struct uvc_frame *frame;
> > > > >     int ret = 0;
> > > > > @@ -395,9 +397,11 @@ static int uvc_v4l2_get_format(struct uvc_streaming *stream,
> > > > >     return ret;
> > > > >  }
> > > > >
> > > > > -static int uvc_v4l2_set_format(struct uvc_streaming *stream,
> > > > > -   struct v4l2_format *fmt)
> > > > > +static int uvc_ioctl_s_fmt(struct file *file, void *fh,
> > > > > +                      struct v4l2_format *fmt)
> > > > >  {
> > > > > +   struct uvc_fh *handle = fh;
> > > > > +   struct uvc_streaming *stream = handle->stream;
> > > > >     struct uvc_streaming_control probe;
> > > > >     const struct uvc_format *format;
> > > > >     const struct uvc_frame *frame;
> > > > > @@ -685,11 +689,13 @@ static int uvc_ioctl_querycap(struct file *file, void *fh,
> > > > >     return 0;
> > > > >  }
> > > > >
> > > > > -static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
> > > > > +static int uvc_ioctl_enum_fmt(struct file *file, void *fh,
> > > > >                           struct v4l2_fmtdesc *fmt)
> > > > >  {
> > > > > -   const struct uvc_format *format;
> > > > > +   struct uvc_fh *handle = fh;
> > > > > +   struct uvc_streaming *stream = handle->stream;
> > > > >     enum v4l2_buf_type type = fmt->type;
> > > > > +   const struct uvc_format *format;
> > > > >     u32 index = fmt->index;
> > > > >
> > > > >     if (fmt->type != stream->type || fmt->index >= stream->nformats)
> > > > > @@ -707,82 +713,8 @@ static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
> > > > >     return 0;
> > > > >  }
> > > > >
> > > > > -static int uvc_ioctl_enum_fmt_vid_cap(struct file *file, void *fh,
> > > > > -                                 struct v4l2_fmtdesc *fmt)
> > > > > -{
> > > > > -   struct uvc_fh *handle = fh;
> > > > > -   struct uvc_streaming *stream = handle->stream;
> > > > > -
> > > > > -   return uvc_ioctl_enum_fmt(stream, fmt);
> > > > > -}
> > > > > -
> > > > > -static int uvc_ioctl_enum_fmt_vid_out(struct file *file, void *fh,
> > > > > -                                 struct v4l2_fmtdesc *fmt)
> > > > > -{
> > > > > -   struct uvc_fh *handle = fh;
> > > > > -   struct uvc_streaming *stream = handle->stream;
> > > > > -
> > > > > -   return uvc_ioctl_enum_fmt(stream, fmt);
> > > > > -}
> > > > > -
> > > > > -static int uvc_ioctl_g_fmt_vid_cap(struct file *file, void *fh,
> > > > > -                              struct v4l2_format *fmt)
> > > > > -{
> > > > > -   struct uvc_fh *handle = fh;
> > > > > -   struct uvc_streaming *stream = handle->stream;
> > > > > -
> > > > > -   return uvc_v4l2_get_format(stream, fmt);
> > > > > -}
> > > > > -
> > > > > -static int uvc_ioctl_g_fmt_vid_out(struct file *file, void *fh,
> > > > > -                              struct v4l2_format *fmt)
> > > > > -{
> > > > > -   struct uvc_fh *handle = fh;
> > > > > -   struct uvc_streaming *stream = handle->stream;
> > > > > -
> > > > > -   return uvc_v4l2_get_format(stream, fmt);
> > > > > -}
> > > > > -
> > > > > -static int uvc_ioctl_s_fmt_vid_cap(struct file *file, void *fh,
> > > > > -                              struct v4l2_format *fmt)
> > > > > -{
> > > > > -   struct uvc_fh *handle = fh;
> > > > > -   struct uvc_streaming *stream = handle->stream;
> > > > > -   int ret;
> > > > > -
> > > > > -   ret = uvc_acquire_privileges(handle);
> > > > > -   if (ret < 0)
> > > > > -           return ret;
> > > >
> > > > Has this now silently disappeared ?
> > > >
> > > > > -
> > > > > -   return uvc_v4l2_set_format(stream, fmt);
> > > > > -}
> > > > > -
> > > > > -static int uvc_ioctl_s_fmt_vid_out(struct file *file, void *fh,
> > > > > -                              struct v4l2_format *fmt)
> > > > > -{
> > > > > -   struct uvc_fh *handle = fh;
> > > > > -   struct uvc_streaming *stream = handle->stream;
> > > > > -   int ret;
> > > > > -
> > > > > -   ret = uvc_acquire_privileges(handle);
> > > > > -   if (ret < 0)
> > > > > -           return ret;
> > > > > -
> > > > > -   return uvc_v4l2_set_format(stream, fmt);
> > > > > -}
> > > > > -
> > > > > -static int uvc_ioctl_try_fmt_vid_cap(struct file *file, void *fh,
> > > > > -                                struct v4l2_format *fmt)
> > > > > -{
> > > > > -   struct uvc_fh *handle = fh;
> > > > > -   struct uvc_streaming *stream = handle->stream;
> > > > > -   struct uvc_streaming_control probe;
> > > > > -
> > > > > -   return uvc_v4l2_try_format(stream, fmt, &probe, NULL, NULL);
> > > > > -}
> > > > > -
> > > > > -static int uvc_ioctl_try_fmt_vid_out(struct file *file, void *fh,
> > > > > -                                struct v4l2_format *fmt)
> > > > > +static int uvc_ioctl_try_fmt(struct file *file, void *fh,
> > > > > +                        struct v4l2_format *fmt)
> > > > >  {
> > > > >     struct uvc_fh *handle = fh;
> > > > >     struct uvc_streaming *stream = handle->stream;
> > > > > @@ -1544,14 +1476,14 @@ static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
> > > > >
> > > > >  const struct v4l2_ioctl_ops uvc_ioctl_ops = {
> > > > >     .vidioc_querycap = uvc_ioctl_querycap,
> > > > > -   .vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt_vid_cap,
> > > > > -   .vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt_vid_out,
> > > > > -   .vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt_vid_cap,
> > > > > -   .vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt_vid_out,
> > > > > -   .vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt_vid_cap,
> > > > > -   .vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt_vid_out,
> > > > > -   .vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt_vid_cap,
> > > > > -   .vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt_vid_out,
> > > > > +   .vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt,
> > > > > +   .vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt,
> > > > > +   .vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt,
> > > > > +   .vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt,
> > > > > +   .vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt,
> > > > > +   .vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt,
> > > > > +   .vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt,
> > > > > +   .vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt,
> > >
> > > Also, if you're removing wrapper, let's do the same for
> > > uvc_ioctl_g_parm() and uvc_ioctl_s_parm(). Furthermore, please try to
> > > preserve the order of the function definitions, sorting them as in the
> > > ioctl_ops structure.
> >
> > Do you want the reorder in a different patch to ease the review or in the same?
>
> The same is fine with me.

I tried reordering the functions and that patch will make future
stable cherry-picks a hell:
https://gitlab.freedesktop.org/linux-media/users/ribalda/-/commit/bdcc5b6a87f1046711d9d8b6ff68c3951c1a12f8

I am reordering the callbacks in uvc_ioctl_ops instead. You do not
seem to follow any particular order there, so I guess it is fine.

Please let me know otherwise


>
> > > > >     .vidioc_reqbufs = uvc_ioctl_reqbufs,
> > > > >     .vidioc_querybuf = uvc_ioctl_querybuf,
> > > > >     .vidioc_qbuf = uvc_ioctl_qbuf,
> > > > >
> > > > > ---
> > > > > base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
> > > > > change-id: 20241127-uvc-dup-cap-out-6a03c01e30a3
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

