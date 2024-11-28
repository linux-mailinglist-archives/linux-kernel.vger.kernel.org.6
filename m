Return-Path: <linux-kernel+bounces-425051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3049DBCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCAFB281AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE41C3043;
	Thu, 28 Nov 2024 20:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nFLw4cu+"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257CF1C2454
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825676; cv=none; b=nslgvcf+I6usz0BZs/Xkv+eTfFeKGylhqQSddTGNM/KXqeXwbJfFqeZWDD/QbDEJQ8UCT8CW9hPOfvvP61Dd5CMSiyWE0THZ6GMaxiCwgFJN0TffqaEK8xaN01QgNDTbqctbHiPc2AyIpSBZ8XtjWNXDu5WEwV8MJhedy9z/RLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825676; c=relaxed/simple;
	bh=I7glvZHjF9TTVhZGOGVc/Rgi0rtXsVuj7LRmzGAMbpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdHYgAKKsGH9xWZyf+rZ9fmfvFP4ICk3gCTOukb3jmCHLAYCNhOQ0KKotpaGfwSmjcA0kkat+VWxZxqF+a0uq8uHCrPaDiCtdBnd7EGYqbPiLLjKF03dDA4xBaV4XCnN8eBiuQ1CHnwmE1WLXBbdCx/zYpgWwMbvKft7/3IY/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nFLw4cu+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2120f9ec28eso9254635ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732825674; x=1733430474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p+04Qv/OKsSuOF5+aWL1QlX/6qTCLUpVUdnG7/8jyjU=;
        b=nFLw4cu+lAR8VrYl3dfi7fN1YU2bdC782KzD5zUgN7IkTTE18ILsSxjWFvUzLekeyY
         VZVR8I5M5JcB3ZGMnYx3qr4zTqVQ45KD2mlZKtk6Tgx28bAISzs+lNcRBoRzL4TW7pjm
         QxWkwMx9JiIPd/InsEMaWUexnq56m0UX5Dg6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732825674; x=1733430474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+04Qv/OKsSuOF5+aWL1QlX/6qTCLUpVUdnG7/8jyjU=;
        b=EKbvSXCh+zYtv+6Sc7aJQlXcLHVyG0D2we8p9S6zGQ5SU2jMpjlfrSeIlA8dKN9JMJ
         Ssmkrg8Kj6UO8QSHwtRnC1UjvvmGnRXSzHRNztY7OzjhehblPR28l51LWmV5E4DPbpsI
         GCKiCqOQDJgts2UnsaHzTPOkKgZjiU8v6nf+FQA1ey0mLrTWI3mdnmcXjj4s1v3jlvYc
         xCN1pEJUL/NCPsCQnTuK0x9BOSpnMWOR1b/qXMdBIn8iR6z9CUXmrOKHbUr492/W/8vd
         hWmc+uHZ64ASK9XZt5N5yMyyB8bTYBtExd/pPIJ4bbOaXHKChfw5wFBbnv55PWuu5RwH
         NGrw==
X-Forwarded-Encrypted: i=1; AJvYcCW8AzksNXnu3PPGuvyXxfDxMQzbrEHk9cAxAU9TSsI5yDKAQwFGJLP8jRTFHSVcEtHMQ/q6EoyBTlrQAC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8fN4uzO6sFMsyMFoM1XDRbHmjl096tJuheZb3vlGBUuAHDw2a
	kz8SkIqX4ASASalpDPEHv7js8JVVO9EtVS6CQgp7AWA8dSBfOnfmt+oe7zrBMD1zjU1q2Ke2WmY
	=
X-Gm-Gg: ASbGncswQ2/ZN24hITguTU3nY88lQFkAcJk+PI3jQrGfnMpOioF3RdZSsQGVGsEOe0k
	TGZDweRQ/pCtG45OKKV/6hhBFkhvSZxtH4Jhe8k/ZaMqw6Vzgd5CSaV4n6V2CjqopZ/N4/BlB1i
	LRuUSirzDRZxArD90FbsBo6ho+KQnN32pSQUTVNjitxcOhCuVgMxnLxb4bzeM5zWJpBhAOT8ayJ
	bi6f5zCTYiCiAFB8/YJcwE5rf6eRJLCRIjtEu4HW8hJ+tXPzMyt3OXDii0GFqAQAKN+8G0UB1GA
	h8+UUld211yW3W1c
X-Google-Smtp-Source: AGHT+IECczQFJWw8w+VUxT9U66HBmyynNC3JF4XZAeM0FZj+hGjQMKWK71OCLmMRG3rUWmDKrgKhUA==
X-Received: by 2002:a17:902:ce05:b0:20c:c18f:c39e with SMTP id d9443c01a7336-2151d863497mr83213265ad.21.1732825674142;
        Thu, 28 Nov 2024 12:27:54 -0800 (PST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com. [209.85.210.181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215218f6513sm17736815ad.30.2024.11.28.12.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 12:27:53 -0800 (PST)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7250906bc63so854379b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:27:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVU9nnBG7sX59Xn2vDvMIsHrIBcMrnTZbTNyLwdriKzk2raNORDUO/4LlIZMLiVfbXC63C0M5/uLKaxuk4=@vger.kernel.org
X-Received: by 2002:a05:6a00:84c:b0:724:db17:f975 with SMTP id
 d2e1a72fcca58-7253f369c37mr7692058b3a.12.1732825672148; Thu, 28 Nov 2024
 12:27:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-dup-cap-out-v1-1-1bdcad2dabb0@chromium.org> <20241128202442.GC13852@pendragon.ideasonboard.com>
In-Reply-To: <20241128202442.GC13852@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 21:27:39 +0100
X-Gmail-Original-Message-ID: <CANiDSCvDoWf56bpejAgY0Cm_yrctPZzomG1SHF1kUyLRtn4dCg@mail.gmail.com>
Message-ID: <CANiDSCvDoWf56bpejAgY0Cm_yrctPZzomG1SHF1kUyLRtn4dCg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Remove duplicated cap/out code
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 21:24, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Nov 27, 2024 at 07:31:29AM +0000, Ricardo Ribalda wrote:
> > The *_vid_cap and *_vid_out helpers seem to be identical. Remove all the
> > duplicated code.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Unless I miss something, cap and out helpers are identical. So there is
> > no need to duplicate code
> > ---
> >  drivers/media/usb/uvc/uvc_v4l2.c | 112 ++++++++-------------------------------
> >  1 file changed, 22 insertions(+), 90 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 97c5407f6603..11ccdaf0269f 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -361,9 +361,11 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
> >       return ret;
> >  }
> >
> > -static int uvc_v4l2_get_format(struct uvc_streaming *stream,
> > -     struct v4l2_format *fmt)
> > +static int uvc_ioctl_g_fmt(struct file *file, void *fh,
> > +                        struct v4l2_format *fmt)
> >  {
> > +     struct uvc_fh *handle = fh;
> > +     struct uvc_streaming *stream = handle->stream;
> >       const struct uvc_format *format;
> >       const struct uvc_frame *frame;
> >       int ret = 0;
> > @@ -395,9 +397,11 @@ static int uvc_v4l2_get_format(struct uvc_streaming *stream,
> >       return ret;
> >  }
> >
> > -static int uvc_v4l2_set_format(struct uvc_streaming *stream,
> > -     struct v4l2_format *fmt)
> > +static int uvc_ioctl_s_fmt(struct file *file, void *fh,
> > +                        struct v4l2_format *fmt)
> >  {
> > +     struct uvc_fh *handle = fh;
> > +     struct uvc_streaming *stream = handle->stream;
> >       struct uvc_streaming_control probe;
> >       const struct uvc_format *format;
> >       const struct uvc_frame *frame;
> > @@ -685,11 +689,13 @@ static int uvc_ioctl_querycap(struct file *file, void *fh,
> >       return 0;
> >  }
> >
> > -static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
> > +static int uvc_ioctl_enum_fmt(struct file *file, void *fh,
> >                             struct v4l2_fmtdesc *fmt)
> >  {
> > -     const struct uvc_format *format;
> > +     struct uvc_fh *handle = fh;
> > +     struct uvc_streaming *stream = handle->stream;
> >       enum v4l2_buf_type type = fmt->type;
> > +     const struct uvc_format *format;
> >       u32 index = fmt->index;
> >
> >       if (fmt->type != stream->type || fmt->index >= stream->nformats)
> > @@ -707,82 +713,8 @@ static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
> >       return 0;
> >  }
> >
> > -static int uvc_ioctl_enum_fmt_vid_cap(struct file *file, void *fh,
> > -                                   struct v4l2_fmtdesc *fmt)
> > -{
> > -     struct uvc_fh *handle = fh;
> > -     struct uvc_streaming *stream = handle->stream;
> > -
> > -     return uvc_ioctl_enum_fmt(stream, fmt);
> > -}
> > -
> > -static int uvc_ioctl_enum_fmt_vid_out(struct file *file, void *fh,
> > -                                   struct v4l2_fmtdesc *fmt)
> > -{
> > -     struct uvc_fh *handle = fh;
> > -     struct uvc_streaming *stream = handle->stream;
> > -
> > -     return uvc_ioctl_enum_fmt(stream, fmt);
> > -}
> > -
> > -static int uvc_ioctl_g_fmt_vid_cap(struct file *file, void *fh,
> > -                                struct v4l2_format *fmt)
> > -{
> > -     struct uvc_fh *handle = fh;
> > -     struct uvc_streaming *stream = handle->stream;
> > -
> > -     return uvc_v4l2_get_format(stream, fmt);
> > -}
> > -
> > -static int uvc_ioctl_g_fmt_vid_out(struct file *file, void *fh,
> > -                                struct v4l2_format *fmt)
> > -{
> > -     struct uvc_fh *handle = fh;
> > -     struct uvc_streaming *stream = handle->stream;
> > -
> > -     return uvc_v4l2_get_format(stream, fmt);
> > -}
> > -
> > -static int uvc_ioctl_s_fmt_vid_cap(struct file *file, void *fh,
> > -                                struct v4l2_format *fmt)
> > -{
> > -     struct uvc_fh *handle = fh;
> > -     struct uvc_streaming *stream = handle->stream;
> > -     int ret;
> > -
> > -     ret = uvc_acquire_privileges(handle);
> > -     if (ret < 0)
> > -             return ret;
>
> Has this now silently disappeared ?

My bad, I guess I got excited pressing the delete key :).

Good catch. I will resend.

>
> > -
> > -     return uvc_v4l2_set_format(stream, fmt);
> > -}
> > -
> > -static int uvc_ioctl_s_fmt_vid_out(struct file *file, void *fh,
> > -                                struct v4l2_format *fmt)
> > -{
> > -     struct uvc_fh *handle = fh;
> > -     struct uvc_streaming *stream = handle->stream;
> > -     int ret;
> > -
> > -     ret = uvc_acquire_privileges(handle);
> > -     if (ret < 0)
> > -             return ret;
> > -
> > -     return uvc_v4l2_set_format(stream, fmt);
> > -}
> > -
> > -static int uvc_ioctl_try_fmt_vid_cap(struct file *file, void *fh,
> > -                                  struct v4l2_format *fmt)
> > -{
> > -     struct uvc_fh *handle = fh;
> > -     struct uvc_streaming *stream = handle->stream;
> > -     struct uvc_streaming_control probe;
> > -
> > -     return uvc_v4l2_try_format(stream, fmt, &probe, NULL, NULL);
> > -}
> > -
> > -static int uvc_ioctl_try_fmt_vid_out(struct file *file, void *fh,
> > -                                  struct v4l2_format *fmt)
> > +static int uvc_ioctl_try_fmt(struct file *file, void *fh,
> > +                          struct v4l2_format *fmt)
> >  {
> >       struct uvc_fh *handle = fh;
> >       struct uvc_streaming *stream = handle->stream;
> > @@ -1544,14 +1476,14 @@ static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
> >
> >  const struct v4l2_ioctl_ops uvc_ioctl_ops = {
> >       .vidioc_querycap = uvc_ioctl_querycap,
> > -     .vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt_vid_cap,
> > -     .vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt_vid_out,
> > -     .vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt_vid_cap,
> > -     .vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt_vid_out,
> > -     .vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt_vid_cap,
> > -     .vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt_vid_out,
> > -     .vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt_vid_cap,
> > -     .vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt_vid_out,
> > +     .vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt,
> > +     .vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt,
> > +     .vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt,
> > +     .vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt,
> > +     .vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt,
> > +     .vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt,
> > +     .vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt,
> > +     .vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt,
> >       .vidioc_reqbufs = uvc_ioctl_reqbufs,
> >       .vidioc_querybuf = uvc_ioctl_querybuf,
> >       .vidioc_qbuf = uvc_ioctl_qbuf,
> >
> > ---
> > base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
> > change-id: 20241127-uvc-dup-cap-out-6a03c01e30a3
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

