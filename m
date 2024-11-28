Return-Path: <linux-kernel+bounces-425057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCC9DBCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D471648AA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFB21C32E4;
	Thu, 28 Nov 2024 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XpmT6/Vw"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9012C7FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826183; cv=none; b=P7zntFDCytYx/rieE6ElX+y0KboJFwjmLUPordajKeVQhmyYN57EkpHWbmIJ1HtuhBAEulA39/BZtdObFYPAz9MvRrGT0geOwcLn6arrMxEeUu7MIAPBpcS4gph0ZbtBaFGEefB7IZVn2v1URvVI3OT4k5feZxQiLCrmCy9TPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826183; c=relaxed/simple;
	bh=KnKDkO/LxGWDdjT+o3TpUORCbbUXaeZsLJF5S8hD0i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl+2p1xbPicNkU+uIvqiD3aqv1aof8jf0J9uE4L+znbcEK5qXg0qBQB23bj8z0chyH2xgTH5jDrkMl9y5FfS3c2a4IqRk1lnkycAVTWC8fhMuOZ+l1lTeHPpNVxLMgEkPO85WHymHF/RkQ1ev0iS2RlQ53TRPRsfeqbvMUytn4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XpmT6/Vw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2128383b86eso10182045ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732826180; x=1733430980; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SVBbCgwD2fV6O+Mi5PMdfn6J90+s+eCIZngth27HNHE=;
        b=XpmT6/VwjBxU5cJqBb5jhhNSUba/Y5/mYMBkBYXjq0ezO3cFld+wt3mdNd8QPX4VhU
         J2aTcSHqU+uqeIDrmywYdiTwomNarllPWnZc1tQsY83sL0eQ/zERUzR+vgd1Qbwjr6RE
         PwVgjQHSBilUH3cfyp6ySLa5ZqAqlUmFxAbwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732826180; x=1733430980;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVBbCgwD2fV6O+Mi5PMdfn6J90+s+eCIZngth27HNHE=;
        b=T+B/txSEBKTECFmovdTVf4ER6m6ph+vqI2a1d1DLCIerRSm1WNGFf9NUvscRX1VQPh
         f8Mpg2DZ+3h4Tzy97su2vPPjKJ9QnQkVRnbWaO+fNpxjHD5JOc01isrEH1riyA2M/FdE
         gEudsOrcZWblYBGi06EhmfFw6curMHTmusskqs38urhZnKOqih7TgbGgif6AeISPdwnR
         CgTMU6EWxJKxrdXWqsQppbudTnTxMn76sVbuWaM88xanOO89JsMeaCXJ9fB92I2L34yA
         iqGLrogQQM7zEo5SNLuKpL4OrCPr2lLxAS74Qv7OY8rz7aO2+8g40pCYHr/tuivqjH91
         oPkg==
X-Forwarded-Encrypted: i=1; AJvYcCVuj04QyzBxtVTq1r5nkWUCF9PvLoipVHlX4P2ls0hqg5a+aYHnq90R0A+73tjfR37Sb+GO7tyeD0Z/cys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwgRRSwBwfmxuFDmAfGZCP4TeaafciwvE1T//GR8HFVFGz2sB
	FFcv3XGGMVDVCL5/cNqmtA1trKjrjT3eOWAYAKRp0toJd2TiwVfWvZzW6sHXcBnR/zYQ+M6pHA8
	=
X-Gm-Gg: ASbGncu/B2kqPqFVid8JgkOSYYJw0mWk89CCTnU1g+15DLhbhXw12v1t9ZhuW+98zOs
	xtDjloOEgb400QBEC/yEMT+tVmd8YZ/ShUOm8Gc7V7aUO563wdFvjf49EZUMrCmfqAfU0vCL+vg
	I1L667ABW60LUeMQeeRwhr3kCRiWPRiGa9uas7ZiQaJqsa3+MSwsSDU08TtupgJixZnac1613G1
	plBjnMBz5+5CoXg0plERm8Z7CLEszu/0v3HF/mPnH3bcMS1Ms2pOakvX2npjUiF/BORjSoAecf3
	PwDCrLlAylwm
X-Google-Smtp-Source: AGHT+IGgcc479jTU8zOl9CtcKoPcHgC0Lp86Tv94nB1ydJQw8CPoI/mv0j3KialL/d79MQ5ZppDULA==
X-Received: by 2002:a17:902:cccc:b0:215:385e:921c with SMTP id d9443c01a7336-215385e976amr21973985ad.51.1732826180426;
        Thu, 28 Nov 2024 12:36:20 -0800 (PST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com. [209.85.216.45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2d4bc6sm1783238a12.9.2024.11.28.12.36.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 12:36:19 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2eacc4c9164so960115a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:36:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5tXcEuQzrbtU0kWlwF44Tmz4p8fygHwK37E5aIb2o2PYfaWs8RsE67loYKifhqK2aHLBXR72Pi77KBGI=@vger.kernel.org
X-Received: by 2002:a17:90b:1b47:b0:2ea:9bdc:8f96 with SMTP id
 98e67ed59e1d1-2ee097bb2aamr11057592a91.30.1732826179018; Thu, 28 Nov 2024
 12:36:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127-uvc-dup-cap-out-v1-1-1bdcad2dabb0@chromium.org>
 <20241128202442.GC13852@pendragon.ideasonboard.com> <20241128203127.GD13852@pendragon.ideasonboard.com>
In-Reply-To: <20241128203127.GD13852@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 28 Nov 2024 21:36:06 +0100
X-Gmail-Original-Message-ID: <CANiDSCt69HXfRmWHKGELWoUE45bZeWUgVc3C7=aAvykUYZBUzQ@mail.gmail.com>
Message-ID: <CANiDSCt69HXfRmWHKGELWoUE45bZeWUgVc3C7=aAvykUYZBUzQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Remove duplicated cap/out code
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 21:31, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Nov 28, 2024 at 10:24:42PM +0200, Laurent Pinchart wrote:
> > Hi Ricardo,
> >
> > Thank you for the patch.
> >
> > On Wed, Nov 27, 2024 at 07:31:29AM +0000, Ricardo Ribalda wrote:
> > > The *_vid_cap and *_vid_out helpers seem to be identical. Remove all the
> > > duplicated code.
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > > Unless I miss something, cap and out helpers are identical. So there is
> > > no need to duplicate code
> > > ---
> > >  drivers/media/usb/uvc/uvc_v4l2.c | 112 ++++++++-------------------------------
> > >  1 file changed, 22 insertions(+), 90 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > > index 97c5407f6603..11ccdaf0269f 100644
> > > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > > @@ -361,9 +361,11 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
> > >     return ret;
> > >  }
> > >
> > > -static int uvc_v4l2_get_format(struct uvc_streaming *stream,
> > > -   struct v4l2_format *fmt)
> > > +static int uvc_ioctl_g_fmt(struct file *file, void *fh,
> > > +                      struct v4l2_format *fmt)
> > >  {
> > > +   struct uvc_fh *handle = fh;
> > > +   struct uvc_streaming *stream = handle->stream;
> > >     const struct uvc_format *format;
> > >     const struct uvc_frame *frame;
> > >     int ret = 0;
> > > @@ -395,9 +397,11 @@ static int uvc_v4l2_get_format(struct uvc_streaming *stream,
> > >     return ret;
> > >  }
> > >
> > > -static int uvc_v4l2_set_format(struct uvc_streaming *stream,
> > > -   struct v4l2_format *fmt)
> > > +static int uvc_ioctl_s_fmt(struct file *file, void *fh,
> > > +                      struct v4l2_format *fmt)
> > >  {
> > > +   struct uvc_fh *handle = fh;
> > > +   struct uvc_streaming *stream = handle->stream;
> > >     struct uvc_streaming_control probe;
> > >     const struct uvc_format *format;
> > >     const struct uvc_frame *frame;
> > > @@ -685,11 +689,13 @@ static int uvc_ioctl_querycap(struct file *file, void *fh,
> > >     return 0;
> > >  }
> > >
> > > -static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
> > > +static int uvc_ioctl_enum_fmt(struct file *file, void *fh,
> > >                           struct v4l2_fmtdesc *fmt)
> > >  {
> > > -   const struct uvc_format *format;
> > > +   struct uvc_fh *handle = fh;
> > > +   struct uvc_streaming *stream = handle->stream;
> > >     enum v4l2_buf_type type = fmt->type;
> > > +   const struct uvc_format *format;
> > >     u32 index = fmt->index;
> > >
> > >     if (fmt->type != stream->type || fmt->index >= stream->nformats)
> > > @@ -707,82 +713,8 @@ static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
> > >     return 0;
> > >  }
> > >
> > > -static int uvc_ioctl_enum_fmt_vid_cap(struct file *file, void *fh,
> > > -                                 struct v4l2_fmtdesc *fmt)
> > > -{
> > > -   struct uvc_fh *handle = fh;
> > > -   struct uvc_streaming *stream = handle->stream;
> > > -
> > > -   return uvc_ioctl_enum_fmt(stream, fmt);
> > > -}
> > > -
> > > -static int uvc_ioctl_enum_fmt_vid_out(struct file *file, void *fh,
> > > -                                 struct v4l2_fmtdesc *fmt)
> > > -{
> > > -   struct uvc_fh *handle = fh;
> > > -   struct uvc_streaming *stream = handle->stream;
> > > -
> > > -   return uvc_ioctl_enum_fmt(stream, fmt);
> > > -}
> > > -
> > > -static int uvc_ioctl_g_fmt_vid_cap(struct file *file, void *fh,
> > > -                              struct v4l2_format *fmt)
> > > -{
> > > -   struct uvc_fh *handle = fh;
> > > -   struct uvc_streaming *stream = handle->stream;
> > > -
> > > -   return uvc_v4l2_get_format(stream, fmt);
> > > -}
> > > -
> > > -static int uvc_ioctl_g_fmt_vid_out(struct file *file, void *fh,
> > > -                              struct v4l2_format *fmt)
> > > -{
> > > -   struct uvc_fh *handle = fh;
> > > -   struct uvc_streaming *stream = handle->stream;
> > > -
> > > -   return uvc_v4l2_get_format(stream, fmt);
> > > -}
> > > -
> > > -static int uvc_ioctl_s_fmt_vid_cap(struct file *file, void *fh,
> > > -                              struct v4l2_format *fmt)
> > > -{
> > > -   struct uvc_fh *handle = fh;
> > > -   struct uvc_streaming *stream = handle->stream;
> > > -   int ret;
> > > -
> > > -   ret = uvc_acquire_privileges(handle);
> > > -   if (ret < 0)
> > > -           return ret;
> >
> > Has this now silently disappeared ?
> >
> > > -
> > > -   return uvc_v4l2_set_format(stream, fmt);
> > > -}
> > > -
> > > -static int uvc_ioctl_s_fmt_vid_out(struct file *file, void *fh,
> > > -                              struct v4l2_format *fmt)
> > > -{
> > > -   struct uvc_fh *handle = fh;
> > > -   struct uvc_streaming *stream = handle->stream;
> > > -   int ret;
> > > -
> > > -   ret = uvc_acquire_privileges(handle);
> > > -   if (ret < 0)
> > > -           return ret;
> > > -
> > > -   return uvc_v4l2_set_format(stream, fmt);
> > > -}
> > > -
> > > -static int uvc_ioctl_try_fmt_vid_cap(struct file *file, void *fh,
> > > -                                struct v4l2_format *fmt)
> > > -{
> > > -   struct uvc_fh *handle = fh;
> > > -   struct uvc_streaming *stream = handle->stream;
> > > -   struct uvc_streaming_control probe;
> > > -
> > > -   return uvc_v4l2_try_format(stream, fmt, &probe, NULL, NULL);
> > > -}
> > > -
> > > -static int uvc_ioctl_try_fmt_vid_out(struct file *file, void *fh,
> > > -                                struct v4l2_format *fmt)
> > > +static int uvc_ioctl_try_fmt(struct file *file, void *fh,
> > > +                        struct v4l2_format *fmt)
> > >  {
> > >     struct uvc_fh *handle = fh;
> > >     struct uvc_streaming *stream = handle->stream;
> > > @@ -1544,14 +1476,14 @@ static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
> > >
> > >  const struct v4l2_ioctl_ops uvc_ioctl_ops = {
> > >     .vidioc_querycap = uvc_ioctl_querycap,
> > > -   .vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt_vid_cap,
> > > -   .vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt_vid_out,
> > > -   .vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt_vid_cap,
> > > -   .vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt_vid_out,
> > > -   .vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt_vid_cap,
> > > -   .vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt_vid_out,
> > > -   .vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt_vid_cap,
> > > -   .vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt_vid_out,
> > > +   .vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt,
> > > +   .vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt,
> > > +   .vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt,
> > > +   .vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt,
> > > +   .vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt,
> > > +   .vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt,
> > > +   .vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt,
> > > +   .vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt,
>
> Also, if you're removing wrapper, let's do the same for
> uvc_ioctl_g_parm() and uvc_ioctl_s_parm(). Furthermore, please try to
> preserve the order of the function definitions, sorting them as in the
> ioctl_ops structure.

ack.

Do you want the reorder in a different patch to ease the review or in the same?

>
> > >     .vidioc_reqbufs = uvc_ioctl_reqbufs,
> > >     .vidioc_querybuf = uvc_ioctl_querybuf,
> > >     .vidioc_qbuf = uvc_ioctl_qbuf,
> > >
> > > ---
> > > base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
> > > change-id: 20241127-uvc-dup-cap-out-6a03c01e30a3
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

