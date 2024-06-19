Return-Path: <linux-kernel+bounces-220484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DBC90E247
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BBD284457
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266D641746;
	Wed, 19 Jun 2024 04:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6jeoixM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53105D26A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770782; cv=none; b=csdCg0joQD8HOl7wLhMZy4eHwpUeP9agpUpns3DT4i01R2c4Qwkhfqym3ff+8Pdn92dwqbBazkBjXiivfhToJdPp9g/wnoOncOIYqn9sKzVTxky1RA/Ym2Ih0x28Xvb/T0Kl2auaZ1Y7t1rOzfnHjo2vGhvNbeiK2VnB2v6Yiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770782; c=relaxed/simple;
	bh=JNNn2B9AEY5Fn0RAE7Nv+uvdYfJNN5JRmicXvo3cqmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QqYGMYnCS7RjTY4i0U4fUMcU0gBuku/2kM1sIE5brblasKczIgePa16VwpW+kJwrMqkjjpM6pTe2hWxOO1FeVzkAyCY2tMxFHJ/3wA+ywaYQsYUe06c+9HMUKtVxenNREZw9W1KyxbG+Ibb/wGYf3HB3RbMkfGGOPgPpJiZXT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b6jeoixM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f8ebbd268so81351666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718770778; x=1719375578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U+cxAMgDXTuaBoZjBUZI7zxhscWza7MiDHr3eL9Des=;
        b=b6jeoixM3wmJe2O3iQ5TXT0oMV0SepfJFboW+f5lQv/JJX4EZAWZgJCnoCutr/awza
         m4lu/7/DGiyWR571/al6lEQgA4Hk4YDRkIltASsQJDkibVTjSVune3wClxLGR+jzQynr
         ZUv5jOhXddnlLak4jk24FykjB/V8YvUEHTR8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718770778; x=1719375578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U+cxAMgDXTuaBoZjBUZI7zxhscWza7MiDHr3eL9Des=;
        b=cn/oJg1+0XWkgGB+wYYKoq1573ROWhXNyUiZP2qddnz+WX+bLj4XO2YfofnN3lPDde
         GvvKKcM+BFZLsxIdd2Eght6DaD2KfkhQ0v9nKy/KOqt6BTJSs1LcqaPKBB+t69ty9q1d
         jwrEcjoc/QwoyzERZ60yrg33awjZRvrKRXsxE7359bEnEWYx66Qg/8YIiWI6Qqn/2cQq
         zHQ5fHSBWOsI3L10RxH6E7SFJluMJJZupwIJSlAXPYcxoP6DcNRwVmVDB9kein6CCU4i
         n0T7TxBwU4kiQ8jfLix/2GZdjuuifyDVBvi2WafymBVpBNjNj2i5BJjoUC3FF71rJoqi
         TI6w==
X-Forwarded-Encrypted: i=1; AJvYcCWFIzJEf672Iw76WboirWmpO3fkjGlMuDCcN6ewP29JMhkm8pLvKx386q5rLf20rFDX81dE3wNrmPaO9KgQeGqC6V4QqzbnbRyQ+ncj
X-Gm-Message-State: AOJu0YwjC1s6nEuGYZaJJOXm3Uq+agg1Y0JoHyCz8RCqG89evK2yEHmh
	iQzQ/lsKlWt7G6UNsR+mWt2Ar4s4PiTcXmxCa+lXY71mcmfag+x2QedwR2QiEDS51uSmsLGtzjV
	kZMwJ
X-Google-Smtp-Source: AGHT+IGCeNGgifrCf2nqFcM6uRLq+J8SJp0RyJ7vSXCSa26PeadhgHNd5t0G9SYY4nOx7ehd8SOOng==
X-Received: by 2002:a17:906:dda:b0:a6f:4287:f196 with SMTP id a640c23a62f3a-a6f94c04f1bmr243766166b.2.1718770777876;
        Tue, 18 Jun 2024 21:19:37 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cf709b49dsm1742152a12.49.2024.06.18.21.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 21:19:37 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso80380966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:19:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXty3wDKfuoIU8kVWTmAibHkyBw8y7glfOsIfwpCbDQuCkL8ve4p8MetNCnXxbXb9CQoMv/Ze91IIqw/8bZecn7rBoDcyl+oGtSwq+k
X-Received: by 2002:a17:907:2087:b0:a6f:53eb:dbe0 with SMTP id
 a640c23a62f3a-a6f9506f6f4mr245886666b.26.1718770776170; Tue, 18 Jun 2024
 21:19:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618073004.3420436-1-tao.jiang_2@nxp.com> <CAAFQd5B_RTHsMwMdD59RAAyFne_0Ok_A4ExdkVOgi=G6-UGfRQ@mail.gmail.com>
 <036bf0d7f657cae444d20ea6d279b47e3bf0164e.camel@ndufresne.ca>
In-Reply-To: <036bf0d7f657cae444d20ea6d279b47e3bf0164e.camel@ndufresne.ca>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 19 Jun 2024 13:19:14 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DfbqOkZzPfCNRMGeMgv2NfM6WENWXeLUNsuMgkzeBQKw@mail.gmail.com>
Message-ID: <CAAFQd5DfbqOkZzPfCNRMGeMgv2NfM6WENWXeLUNsuMgkzeBQKw@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: sync caches for dmabuf memory
To: Nicolas Dufresne <nicolas@ndufresne.ca>, m.szyprowski@samsung.com, 
	hverkuil-cisco@xs4all.nl
Cc: TaoJiang <tao.jiang_2@nxp.com>, mchehab@kernel.org, shawnguo@kernel.org, 
	robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com, 
	eagle.zhou@nxp.com, ming.qian@oss.nxp.com, imx@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Ming Qian <ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 1:24=E2=80=AFAM Nicolas Dufresne <nicolas@ndufresne=
.ca> wrote:
>
> Le mardi 18 juin 2024 =C3=A0 16:47 +0900, Tomasz Figa a =C3=A9crit :
> > Hi TaoJiang,
> >
> > On Tue, Jun 18, 2024 at 4:30=E2=80=AFPM TaoJiang <tao.jiang_2@nxp.com> =
wrote:
> > >
> > > From: Ming Qian <ming.qian@nxp.com>
> > >
> > > When the memory type is VB2_MEMORY_DMABUF, the v4l2 device can't know
> > > whether the dma buffer is coherent or synchronized.
> > >
> > > The videobuf2-core will skip cache syncs as it think the DMA exporter
> > > should take care of cache syncs
> > >
> > > But in fact it's likely that the client doesn't
> > > synchronize the dma buf before qbuf() or after dqbuf(). and it's
> > > difficult to find this type of error directly.
> > >
> > > I think it's helpful that videobuf2-core can call
> > > dma_buf_end_cpu_access() and dma_buf_begin_cpu_access() to handle the
> > > cache syncs.
> > >
> > > Signed-off-by: Ming Qian <ming.qian@nxp.com>
> > > Signed-off-by: TaoJiang <tao.jiang_2@nxp.com>
> > > ---
> > >  .../media/common/videobuf2/videobuf2-core.c   | 22 +++++++++++++++++=
++
> > >  1 file changed, 22 insertions(+)
> > >
> >
> > Sorry, that patch is incorrect. I believe you're misunderstanding the
> > way DMA-buf buffers should be managed in the userspace. It's the
> > userspace responsibility to call the DMA_BUF_IOCTL_SYNC ioctl [1] to
> > signal start and end of CPU access to the kernel and imply necessary
> > cache synchronization.
> >
> > [1] https://docs.kernel.org/driver-api/dma-buf.html#dma-buffer-ioctls
> >
> > So, really sorry, but it's a NAK.
>
>
>
> This patch *could* make sense if it was inside UVC Driver as an example, =
as this
> driver can import dmabuf, to CPU memcpy, and does omits the required sync=
 calls
> (unless that got added recently, I can easily have missed it).

Yeah, currently V4L2 drivers don't call the in-kernel
dma_buf_{begin,end}_cpu_access() when they need to access the buffers
from the CPU, while my quick grep [1] reveals that we have 68 files
retrieving plane vaddr by calling vb2_plane_vaddr() (not necessarily a
100% guarantee of CPU access being done, but rather likely so).

I also repeated the same thing with VB2_DMABUF [2] and tried to
attribute both lists to specific drivers (by retaining the path until
the first - or _ [3]; which seemed to be relatively accurate), leading
to the following drivers that claim support for DMABUF while also
retrieving plane vaddr (without proper synchronization - no drivers
currently call any begin/end CPU access):

 i2c/video
 pci/bt8xx/bttv
 pci/cobalt/cobalt
 pci/cx18/cx18
 pci/tw5864/tw5864
 pci/tw686x/tw686x
 platform/allegro
 platform/amphion/vpu
 platform/chips
 platform/intel/pxa
 platform/marvell/mcam
 platform/mediatek/jpeg/mtk
 platform/mediatek/vcodec/decoder/mtk
 platform/mediatek/vcodec/encoder/mtk
 platform/nuvoton/npcm
 platform/nvidia/tegra
 platform/nxp/imx
 platform/renesas/rcar
 platform/renesas/vsp1/vsp1
 platform/rockchip/rkisp1/rkisp1
 platform/samsung/exynos4
 platform/samsung/s5p
 platform/st/sti/delta/delta
 platform/st/sti/hva/hva
 platform/verisilicon/hantro
 usb/au0828/au0828
 usb/cx231xx/cx231xx
 usb/dvb
 usb/em28xx/em28xx
 usb/gspca/gspca.c
 usb/hackrf/hackrf.c
 usb/stk1160/stk1160
 usb/uvc/uvc

which means we potentially have ~30 drivers which likely don't handle
imported DMABUFs correctly (there is still a chance that DMABUF is
advertised for one queue, while vaddr is used for another).

I think we have two options:
1) add vb2_{begin/end}_cpu_access() helpers, carefully audit each
driver and add calls to those
2) take a heavy gun approach and just call vb2_begin_cpu_access()
whenever vb2_plane_vaddr() is called and then vb2_end_cpu_access()
whenever vb2_buffer_done() is called (if begin was called before).

The latter has the disadvantage of drivers not having control over the
timing of the cache sync, so could end up with less than optimal
performance. Also there could be some more complex cases, where the
driver needs to mix DMA and CPU accesses to the buffer, so the fixed
sequence just wouldn't work for them. (But then they just wouldn't
work today either.)

Hans, Marek, do you have any thoughts? (I'd personally just go with 2
and if any driver in the future needs something else, they could call
begin/end CPU access manually.)

[1] git grep vb2_plane_vaddr | cut -d":" -f 1 | sort | uniq
[2] git grep VB2_DMABUF | cut -d":" -f 1 | sort | uniq
[3] by running [1] and [2] through | cut -d"-" -f 1 | cut -d"_" -f 1 | uniq

Best,
Tomasz

>
> But generally speaking, bracketing all driver with CPU access synchroniza=
tion
> does not make sense indeed, so I second the rejection.
>
> Nicolas
>
> >
> > Best regards,
> > Tomasz
> >
> > > diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/driver=
s/media/common/videobuf2/videobuf2-core.c
> > > index 358f1fe42975..4734ff9cf3ce 100644
> > > --- a/drivers/media/common/videobuf2/videobuf2-core.c
> > > +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> > > @@ -340,6 +340,17 @@ static void __vb2_buf_mem_prepare(struct vb2_buf=
fer *vb)
> > >         vb->synced =3D 1;
> > >         for (plane =3D 0; plane < vb->num_planes; ++plane)
> > >                 call_void_memop(vb, prepare, vb->planes[plane].mem_pr=
iv);
> > > +
> > > +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> > > +               return;
> > > +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> > > +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> > > +
> > > +               if (!dbuf)
> > > +                       continue;
> > > +
> > > +               dma_buf_end_cpu_access(dbuf, vb->vb2_queue->dma_dir);
> > > +       }
> > >  }
> > >
> > >  /*
> > > @@ -356,6 +367,17 @@ static void __vb2_buf_mem_finish(struct vb2_buff=
er *vb)
> > >         vb->synced =3D 0;
> > >         for (plane =3D 0; plane < vb->num_planes; ++plane)
> > >                 call_void_memop(vb, finish, vb->planes[plane].mem_pri=
v);
> > > +
> > > +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> > > +               return;
> > > +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> > > +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> > > +
> > > +               if (!dbuf)
> > > +                       continue;
> > > +
> > > +               dma_buf_begin_cpu_access(dbuf, vb->vb2_queue->dma_dir=
);
> > > +       }
> > >  }
> > >
> > >  /*
> > > --
> > > 2.43.0-rc1
> > >
>

