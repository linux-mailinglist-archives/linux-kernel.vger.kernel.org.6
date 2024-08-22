Return-Path: <linux-kernel+bounces-296399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC8495AA91
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B152878CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C356111CA1;
	Thu, 22 Aug 2024 01:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OQrs07Df"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5C13B2B2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724290190; cv=none; b=GC2VOtKnNhy0Mmo7GS1v4zxfIt8UoecOZK17Fl2I32LD9bTX+yFSCTSaOhYB4cn175LeFWpjm327is5X4WqCuRTOWTucNgBjn2hVGkEOY1ldMC8PqMPSoAcT751VM92PjIn//4EJqJyHp/T54T9mfZ7ez+aIhxmjo21/vNHz5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724290190; c=relaxed/simple;
	bh=0oWc0iUZ17RkFlmB0A+xW+F2PdfzvCN94nx69eQ07wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TlMNQozuWix94jqf5V62zLLM+M6hpOyG5UFVVrkvVhwF1FGhuBsBkgm7jgCs1mv+1oUgszi0HsTPPnLV9PWfqwfS0sAXUlLKwA6ol9K5XduTRx6qGmpuJyIIPWVcs+/DnSDU+Kstn4YLXl4DzGzyHSvUzP4NHuCGOK+5tLerAMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OQrs07Df; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a501dd544eso20026185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724290187; x=1724894987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkGym0+NINJviqEk2ORbY7KcAB/aBXVsRZojgi0XtMY=;
        b=OQrs07Dfz2Ip+8ZDyiLp3UV+j7liuwkmCBhyID0EMjt4N4wfGNSTll1s3JZl0Dzdpy
         cGa2zECB5By2lPNPNIfiwo5O6GD2P7wGdHfRAtj3aw+XJ5/uCT398JVqdqI2qNegKKkr
         KVf45AqwNfYCLzpzxAVPGgi4hoOfd46gAX8tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724290187; x=1724894987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkGym0+NINJviqEk2ORbY7KcAB/aBXVsRZojgi0XtMY=;
        b=ZUGgs1wtXF/84B79HXEQAGuCrOPDGPDxDaoc4aMC02D2luOmwVIQBJM8GPX71GN+MF
         gnuTaIDU5MYm+fmPbJl67AOOCJM9u3xH92UBW51nk/rXveTuln28NinjJEdAS1esiSqg
         ERcGV0VnVZyW1igO3V5nV1nX8OE1JlZ/zAtCMufPQtIRAX6Arr0nsiw/b/ROwpV/msgo
         fq0jW7sCHRVk3/mZPDDq5alPfRIf9AO9/AKXy2oTnBDKfC606unWHdj17oQ6J21RscAK
         sl0UjmvTXLtprC6H58vut0KXbJSQcye4OcW709W0o+sTfz15Td0mi5CmbeFO6ZtVFQdo
         OSQw==
X-Forwarded-Encrypted: i=1; AJvYcCW7oPIGcRkQRYstgPY2BVScGVqnKtzrY/0Pd8Q/8sLE26Yq/TKVkI6JET9JN3zPb7idh0/XrHyo429LRCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkF7lj/0LsD1vLwv4ck3wlwpar6ZLj940e9V2c0nzlQrxF1Hbq
	bVF40WlKYTbB/Qa5uelSwqed0wz+XKjbIw0ZP21EfKyu0cuqYbwqdJ2DlJq5qxEKCpz/2hqEZFP
	jtA==
X-Google-Smtp-Source: AGHT+IH2H2E9zOv5+bJJoRi7lO94qiPWivBMIRmK1uki+V0gZlib323V8siDKFUPNGZrPlftzm8LSw==
X-Received: by 2002:a05:620a:4688:b0:7a3:49dc:e4c8 with SMTP id af79cd13be357-7a680a7515cmr25439385a.31.1724290187112;
        Wed, 21 Aug 2024 18:29:47 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f31b2e0sm19328785a.16.2024.08.21.18.29.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 18:29:46 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-454b1e08393so165961cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 18:29:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQNcdf9hc05RUNnye0kjL2zWYECz/0lA4Wlkr9Fnfekck3q1p9BJ8/ypxCOCuaiQtLgkAx6IHd/MXExhs=@vger.kernel.org
X-Received: by 2002:a05:622a:5285:b0:447:e8bd:2fbe with SMTP id
 d75a77b69052e-454fd6ccbaamr1099211cf.1.1724290185907; Wed, 21 Aug 2024
 18:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
 <20240314153226.197445-3-benjamin.gaignard@collabora.com> <20240821232819.GA18600@pendragon.ideasonboard.com>
In-Reply-To: <20240821232819.GA18600@pendragon.ideasonboard.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 22 Aug 2024 10:29:29 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AQTZa2epfkJnfn_6kpnaNRMzjZ=FjYjf1DM+ZxE0YkZQ@mail.gmail.com>
Message-ID: <CAAFQd5AQTZa2epfkJnfn_6kpnaNRMzjZ=FjYjf1DM+ZxE0YkZQ@mail.gmail.com>
Subject: Re: [PATCH v21 2/9] videobuf2: Add min_reqbufs_allocation field to
 vb2_queue structure
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, hverkuil-cisco@xs4all.nl
Cc: mchehab@kernel.org, m.szyprowski@samsung.com, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, nicolas@ndufresne.ca, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 8:28=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Benjamin,
>
> On Thu, Mar 14, 2024 at 04:32:19PM +0100, Benjamin Gaignard wrote:
> > Add 'min_reqbufs_allocation' field in the vb2_queue structure so driver=
s
> > can specify the minimum number of buffers to allocate when calling
> > VIDIOC_REQBUFS.
> > When initializing the queue, v4l2 core makes sure that the following
> > constraints are respected:
> > - the minimum number of buffers to allocate must be at least 2 because
> > one buffer is used by the hardware while the other is being processed
> > by userspace.
>
> This breaks userspace for the Renesas vsp1 driver :-( Unit tests fail,
> as some of them rely on operation with a single buffer.
>
> The vsp1 is a memory-to-memory processing engine, so operating with a
> single buffer is fine in some use cases. I would argue that for live
> capture devices there are valid use cases to operate with a single
> buffer too. Changing this by default will break use cases.
>
> How can we relax this check ? Should I simply submit a patch that lowers
> the minimum to one buffer ?
>

Uhm, I didn't notice this when reading this series. (Actually if I
recall correctly, originally it didn't have this restriction.)

Indeed, I don't see what's wrong with just having 1 buffer. If
performance is not a concern, it's okay to just serialize the
operation on 1 buffer.

If you would be so nice to send it, I think a patch that changes
min_reqbufs_allocation to max(max(1, min_reqbufs_allocation),
min_queued_buffers)) would be good.

That said, Benjamin, Hans, are we missing something by any chance? :)

Best,
Tomasz

> > -if the driver needs 'min_queued_buffers' in the queue before calling
> > start_streaming(), then the minimum requirement is 'min_queued_buffers =
+ 1'
> > to keep at least one buffer available for userspace.
> >
> > Simplify __vb2_init_fileio() by using 'min_reqbufs_allocation' directly
> > to avoid duplicating the minimum number of buffers to allocate computat=
ion.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-core.c   | 38 +++++++++++--------
> >  include/media/videobuf2-core.h                | 15 +++++++-
> >  2 files changed, 37 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/=
media/common/videobuf2/videobuf2-core.c
> > index d8b3c04cb3b5..58c495b253ce 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > @@ -866,7 +866,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_=
memory memory,
> >       /*
> >        * Make sure the requested values and current defaults are sane.
> >        */
> > -     num_buffers =3D max_t(unsigned int, *count, q->min_queued_buffers=
);
> > +     num_buffers =3D max_t(unsigned int, *count, q->min_reqbufs_alloca=
tion);
> >       num_buffers =3D min_t(unsigned int, num_buffers, q->max_num_buffe=
rs);
> >       memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
> >       /*
> > @@ -918,7 +918,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_=
memory memory,
> >        * There is no point in continuing if we can't allocate the minim=
um
> >        * number of buffers needed by this vb2_queue.
> >        */
> > -     if (allocated_buffers < q->min_queued_buffers)
> > +     if (allocated_buffers < q->min_reqbufs_allocation)
> >               ret =3D -ENOMEM;
> >
> >       /*
> > @@ -2524,6 +2524,25 @@ int vb2_core_queue_init(struct vb2_queue *q)
> >       if (WARN_ON(q->supports_requests && q->min_queued_buffers))
> >               return -EINVAL;
> >
> > +     /*
> > +      * The minimum requirement is 2: one buffer is used
> > +      * by the hardware while the other is being processed by userspac=
e.
> > +      */
> > +     if (q->min_reqbufs_allocation < 2)
> > +             q->min_reqbufs_allocation =3D 2;
> > +
> > +     /*
> > +      * If the driver needs 'min_queued_buffers' in the queue before
> > +      * calling start_streaming() then the minimum requirement is
> > +      * 'min_queued_buffers + 1' to keep at least one buffer available
> > +      * for userspace.
> > +      */
> > +     if (q->min_reqbufs_allocation < q->min_queued_buffers + 1)
> > +             q->min_reqbufs_allocation =3D q->min_queued_buffers + 1;
> > +
> > +     if (WARN_ON(q->min_reqbufs_allocation > q->max_num_buffers))
> > +             return -EINVAL;
> > +
> >       INIT_LIST_HEAD(&q->queued_list);
> >       INIT_LIST_HEAD(&q->done_list);
> >       spin_lock_init(&q->done_lock);
> > @@ -2717,7 +2736,6 @@ static int __vb2_init_fileio(struct vb2_queue *q,=
 int read)
> >       struct vb2_fileio_data *fileio;
> >       struct vb2_buffer *vb;
> >       int i, ret;
> > -     unsigned int count =3D 0;
> >
> >       /*
> >        * Sanity check
> > @@ -2738,18 +2756,8 @@ static int __vb2_init_fileio(struct vb2_queue *q=
, int read)
> >       if (q->streaming || vb2_get_num_buffers(q) > 0)
> >               return -EBUSY;
> >
> > -     /*
> > -      * Start with q->min_queued_buffers + 1, driver can increase it i=
n
> > -      * queue_setup()
> > -      *
> > -      * 'min_queued_buffers' buffers need to be queued up before you
> > -      * can start streaming, plus 1 for userspace (or in this case,
> > -      * kernelspace) processing.
> > -      */
> > -     count =3D max(2, q->min_queued_buffers + 1);
> > -
> >       dprintk(q, 3, "setting up file io: mode %s, count %d, read_once %=
d, write_immediately %d\n",
> > -             (read) ? "read" : "write", count, q->fileio_read_once,
> > +             (read) ? "read" : "write", q->min_reqbufs_allocation, q->=
fileio_read_once,
> >               q->fileio_write_immediately);
> >
> >       fileio =3D kzalloc(sizeof(*fileio), GFP_KERNEL);
> > @@ -2763,7 +2771,7 @@ static int __vb2_init_fileio(struct vb2_queue *q,=
 int read)
> >        * Request buffers and use MMAP type to force driver
> >        * to allocate buffers by itself.
> >        */
> > -     fileio->count =3D count;
> > +     fileio->count =3D q->min_reqbufs_allocation;
> >       fileio->memory =3D VB2_MEMORY_MMAP;
> >       fileio->type =3D q->type;
> >       q->fileio =3D fileio;
> > diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-c=
ore.h
> > index 667bf9ee1101..4a8b9135cec8 100644
> > --- a/include/media/videobuf2-core.h
> > +++ b/include/media/videobuf2-core.h
> > @@ -549,9 +549,21 @@ struct vb2_buf_ops {
> >   *           @start_streaming can be called. Used when a DMA engine
> >   *           cannot be started unless at least this number of buffers
> >   *           have been queued into the driver.
> > - *           VIDIOC_REQBUFS will ensure at least @min_queued_buffers
> > + *           VIDIOC_REQBUFS will ensure at least @min_queued_buffers +=
 1
> >   *           buffers will be allocated. Note that VIDIOC_CREATE_BUFS w=
ill not
> >   *           modify the requested buffer count.
> > + * @min_reqbufs_allocation: the minimum number of buffers to be alloca=
ted when
> > + *           calling VIDIOC_REQBUFS. Note that VIDIOC_CREATE_BUFS will=
 *not*
> > + *           modify the requested buffer count and does not use this f=
ield.
> > + *           Drivers can set this if there has to be a certain number =
of
> > + *           buffers available for the hardware to work effectively.
> > + *           This allows calling VIDIOC_REQBUFS with a buffer count of=
 1 and
> > + *           it will be automatically adjusted to a workable buffer co=
unt.
> > + *           If set, then @min_reqbufs_allocation must be larger than
> > + *           @min_queued_buffers + 1.
> > + *           If this field is > 3, then it is highly recommended that =
the
> > + *           driver implements the V4L2_CID_MIN_BUFFERS_FOR_CAPTURE/OU=
TPUT
> > + *           control.
> >   * @alloc_devs:      &struct device memory type/allocator-specific per=
-plane device
> >   */
> >  /*
> > @@ -622,6 +634,7 @@ struct vb2_queue {
> >       u32                             timestamp_flags;
> >       gfp_t                           gfp_flags;
> >       u32                             min_queued_buffers;
> > +     u32                             min_reqbufs_allocation;
> >
> >       struct device                   *alloc_devs[VB2_MAX_PLANES];
> >
>
> --
> Regards,
>
> Laurent Pinchart

