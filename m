Return-Path: <linux-kernel+bounces-248954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D54A92E45D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1691F224F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D3E158A29;
	Thu, 11 Jul 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nbOSJ1xF"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899C158878
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693212; cv=none; b=d0OOJg0e3yqtjreV5znjqzSeYDhqwWDboZCmlQTMxvKfM2GZwci6oWX7xLwNI6jzrDmZswU0TCyyZLIgHnUlGEzG9Ugj+VeNNYrgBkELkca0+Ws87YU8FIfsDR9YxXyaZiXHzrdLNeBEJSRTrE2XbtZXa6qC+zPX56mUZOIIJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693212; c=relaxed/simple;
	bh=ia3wSdShWzabjtDv3342ycjfQe9yOGzqDVhoscZXAc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PiGL0EJ3ZCVPUdB4KHDvWm60cTY0I5/lqkHuXfoUGuIwcgcIrf08XITl/e2thhQZZTeCUZV3FtA5XeFYHEfyTvrgjDw9zGnYLh+8SvhHgnZflH0iyQyO9QzzDtR24S5Vrep5vLh9k8kR+slqQlQ+PEGDl5ZcekcrswLe2x1ZmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nbOSJ1xF; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso87102666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720693207; x=1721298007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4pKxsdxjVBHn5/3r7YaaRkxW/WuW1rZwIMp/JW62Xo=;
        b=nbOSJ1xF+ffUSapaSw0sSF/B0mw1jJKo9eajoXP4ohLOOlwR2YF9CPhXJQCjdScIfj
         2rBKS75VSbMOl09Y4ULE/clxrzl8FlUlk0gwvpAp5zGnoovR3aY+Bmbxy4ghTguLKQho
         VrxKxeq1DB3JvwyYqh3qfb7sy3CzbE7rsgCSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720693207; x=1721298007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4pKxsdxjVBHn5/3r7YaaRkxW/WuW1rZwIMp/JW62Xo=;
        b=PmuvUB20OisUvMNuRxUeCZRNn2kL+6lH0s5YB9wftpiPKRijNwdIWx5TFwafoAQjWw
         xeFlPBSCL2eyF1obP7zX3OEPwlYqgBsN4OFakuWm1n1eCc3SQGm9sEp5Qp+j2PG0+Svp
         Ay/gTKGzZA8sO17v/SMRH0HC1hx+KdI0lTxMuUybIG0/ZSBAzaaxgSfjmBzSfrIDuD6x
         wd11djwtRB5szwrVr7MYcUwboSPt3J++PptBOtI9ccmthNS5i4im9NiexEV8VmgqD1w4
         WP3rJDZ/nw+ip3nFVSFDr3S3FSV9bT3EJ9uylG03eU5+472IdGNMQ2FpY0lnfPcqxd9C
         aEtA==
X-Forwarded-Encrypted: i=1; AJvYcCUU1MFf0Z2CDUObrs3s1mFqUHumlPyA8Hxrt3/OPQqywWOvbvsXtx9ooeLnRgLU5/2McmtAFVIHrh4RWVl2hxA/NbDjAB76Uadg2OaS
X-Gm-Message-State: AOJu0YyvIAsNMNQEyDmzX8U08NvhYASOsX/IMr8WheAdKktz+31EOFaH
	Rvtp5M14HpwCxfUH4s+PCLxKJ4NYbG4xueYdm1tJ3UTmthqxICla21qRyi2kU6OsroFpGNYO1Xb
	CPQ==
X-Google-Smtp-Source: AGHT+IFdV2MAaYpkEJSU6EB+PhJdaA0hR0QdLi/X4T7/K7EIcwtWVMH0RTbIOboxg7AHTr9zHuzzJQ==
X-Received: by 2002:a17:906:30d2:b0:a77:d7f1:42ea with SMTP id a640c23a62f3a-a780b70541fmr529020966b.45.1720693207573;
        Thu, 11 Jul 2024 03:20:07 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a854352sm243909866b.148.2024.07.11.03.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 03:20:07 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77e7420697so103229966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 03:20:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeJSiOXnJvosCHInk+TuTGe4HzGFSCv9Tqf6aYIKnShAuDZg+XPSDAGZsXCyUL76Cmylordwy1OCP1f+Mx9EEsEx6QyL1/LTimNTbS
X-Received: by 2002:a17:907:608d:b0:a6e:f7ee:b1fa with SMTP id
 a640c23a62f3a-a780b89cbb7mr555703466b.72.1720693206473; Thu, 11 Jul 2024
 03:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618073004.3420436-1-tao.jiang_2@nxp.com> <CAAFQd5B_RTHsMwMdD59RAAyFne_0Ok_A4ExdkVOgi=G6-UGfRQ@mail.gmail.com>
 <036bf0d7f657cae444d20ea6d279b47e3bf0164e.camel@ndufresne.ca>
 <CAAFQd5DfbqOkZzPfCNRMGeMgv2NfM6WENWXeLUNsuMgkzeBQKw@mail.gmail.com> <443d109f-c817-4f47-9368-ff8b09a9a49e@xs4all.nl>
In-Reply-To: <443d109f-c817-4f47-9368-ff8b09a9a49e@xs4all.nl>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 11 Jul 2024 19:19:39 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Am5jBev5P1HmsdeHoJfROZat3bi1W=UsN7wpVqw-XUQQ@mail.gmail.com>
Message-ID: <CAAFQd5Am5jBev5P1HmsdeHoJfROZat3bi1W=UsN7wpVqw-XUQQ@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: sync caches for dmabuf memory
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Nicolas Dufresne <nicolas@ndufresne.ca>, m.szyprowski@samsung.com, 
	TaoJiang <tao.jiang_2@nxp.com>, mchehab@kernel.org, shawnguo@kernel.org, 
	robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-imx@nxp.com, xiahong.bao@nxp.com, 
	eagle.zhou@nxp.com, ming.qian@oss.nxp.com, imx@lists.linux.dev, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Ming Qian <ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 3:52=E2=80=AFPM Hans Verkuil <hverkuil-cisco@xs4all=
.nl> wrote:
>
> On 19/06/2024 06:19, Tomasz Figa wrote:
> > On Wed, Jun 19, 2024 at 1:24=E2=80=AFAM Nicolas Dufresne <nicolas@ndufr=
esne.ca> wrote:
> >>
> >> Le mardi 18 juin 2024 =C3=A0 16:47 +0900, Tomasz Figa a =C3=A9crit :
> >>> Hi TaoJiang,
> >>>
> >>> On Tue, Jun 18, 2024 at 4:30=E2=80=AFPM TaoJiang <tao.jiang_2@nxp.com=
> wrote:
> >>>>
> >>>> From: Ming Qian <ming.qian@nxp.com>
> >>>>
> >>>> When the memory type is VB2_MEMORY_DMABUF, the v4l2 device can't kno=
w
> >>>> whether the dma buffer is coherent or synchronized.
> >>>>
> >>>> The videobuf2-core will skip cache syncs as it think the DMA exporte=
r
> >>>> should take care of cache syncs
> >>>>
> >>>> But in fact it's likely that the client doesn't
> >>>> synchronize the dma buf before qbuf() or after dqbuf(). and it's
> >>>> difficult to find this type of error directly.
> >>>>
> >>>> I think it's helpful that videobuf2-core can call
> >>>> dma_buf_end_cpu_access() and dma_buf_begin_cpu_access() to handle th=
e
> >>>> cache syncs.
> >>>>
> >>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> >>>> Signed-off-by: TaoJiang <tao.jiang_2@nxp.com>
> >>>> ---
> >>>>  .../media/common/videobuf2/videobuf2-core.c   | 22 ++++++++++++++++=
+++
> >>>>  1 file changed, 22 insertions(+)
> >>>>
> >>>
> >>> Sorry, that patch is incorrect. I believe you're misunderstanding the
> >>> way DMA-buf buffers should be managed in the userspace. It's the
> >>> userspace responsibility to call the DMA_BUF_IOCTL_SYNC ioctl [1] to
> >>> signal start and end of CPU access to the kernel and imply necessary
> >>> cache synchronization.
> >>>
> >>> [1] https://docs.kernel.org/driver-api/dma-buf.html#dma-buffer-ioctls
> >>>
> >>> So, really sorry, but it's a NAK.
> >>
> >>
> >>
> >> This patch *could* make sense if it was inside UVC Driver as an exampl=
e, as this
> >> driver can import dmabuf, to CPU memcpy, and does omits the required s=
ync calls
> >> (unless that got added recently, I can easily have missed it).
> >
> > Yeah, currently V4L2 drivers don't call the in-kernel
> > dma_buf_{begin,end}_cpu_access() when they need to access the buffers
> > from the CPU, while my quick grep [1] reveals that we have 68 files
> > retrieving plane vaddr by calling vb2_plane_vaddr() (not necessarily a
> > 100% guarantee of CPU access being done, but rather likely so).
> >
> > I also repeated the same thing with VB2_DMABUF [2] and tried to
> > attribute both lists to specific drivers (by retaining the path until
> > the first - or _ [3]; which seemed to be relatively accurate), leading
> > to the following drivers that claim support for DMABUF while also
> > retrieving plane vaddr (without proper synchronization - no drivers
> > currently call any begin/end CPU access):
> >
> >  i2c/video
> >  pci/bt8xx/bttv
> >  pci/cobalt/cobalt
> >  pci/cx18/cx18
> >  pci/tw5864/tw5864
> >  pci/tw686x/tw686x
> >  platform/allegro
> >  platform/amphion/vpu
> >  platform/chips
> >  platform/intel/pxa
> >  platform/marvell/mcam
> >  platform/mediatek/jpeg/mtk
> >  platform/mediatek/vcodec/decoder/mtk
> >  platform/mediatek/vcodec/encoder/mtk
> >  platform/nuvoton/npcm
> >  platform/nvidia/tegra
> >  platform/nxp/imx
> >  platform/renesas/rcar
> >  platform/renesas/vsp1/vsp1
> >  platform/rockchip/rkisp1/rkisp1
> >  platform/samsung/exynos4
> >  platform/samsung/s5p
> >  platform/st/sti/delta/delta
> >  platform/st/sti/hva/hva
> >  platform/verisilicon/hantro
> >  usb/au0828/au0828
> >  usb/cx231xx/cx231xx
> >  usb/dvb
> >  usb/em28xx/em28xx
> >  usb/gspca/gspca.c
> >  usb/hackrf/hackrf.c
> >  usb/stk1160/stk1160
> >  usb/uvc/uvc
> >
> > which means we potentially have ~30 drivers which likely don't handle
> > imported DMABUFs correctly (there is still a chance that DMABUF is
> > advertised for one queue, while vaddr is used for another).
> >
> > I think we have two options:
> > 1) add vb2_{begin/end}_cpu_access() helpers, carefully audit each
> > driver and add calls to those
>
> I actually started on that 9 (!) years ago:
>
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=3Dvb2-cpu-access
>
> If memory serves, the main problem was that there were some drivers where
> it wasn't clear what should be done. In the end I never continued this
> work since nobody complained about it.
>
> This patch series adds vb2_plane_begin/end_cpu_access() functions,
> replaces all calls to vb2_plane_vaddr() in drivers to the new functions,
> and at the end removes vb2_plane_vaddr() altogether.
>
> > 2) take a heavy gun approach and just call vb2_begin_cpu_access()
> > whenever vb2_plane_vaddr() is called and then vb2_end_cpu_access()
> > whenever vb2_buffer_done() is called (if begin was called before).
> >
> > The latter has the disadvantage of drivers not having control over the
> > timing of the cache sync, so could end up with less than optimal
> > performance. Also there could be some more complex cases, where the
> > driver needs to mix DMA and CPU accesses to the buffer, so the fixed
> > sequence just wouldn't work for them. (But then they just wouldn't
> > work today either.)
> >
> > Hans, Marek, do you have any thoughts? (I'd personally just go with 2
> > and if any driver in the future needs something else, they could call
> > begin/end CPU access manually.)
>
> I prefer 1. If nothing else, that makes it easy to identify drivers
> that do such things.
>
> But perhaps a mix is possible: if a VB2 flag is set by the driver, then
> approach 2 is used. That might help with the drivers where it isn't clear
> what they should do. Although perhaps this can all be done in the driver
> itself: instead of vb2_plane_vaddr they call vb2_begin_cpu_access for the
> whole buffer, and at buffer_done time they call vb2_end_cpu_access. Shoul=
d
> work just as well for the very few drivers that need this.

That's a good point. I guess we don't really need to dig so much into
those drivers in this case. Just mechanically do the same for all of
them (+/- maybe checking for some obvious corner cases which don't
need the extra calls). Let me see if I can give it a stab.

Best,
Tomasz

>
> Regards,
>
>         Hans
>
> >
> > [1] git grep vb2_plane_vaddr | cut -d":" -f 1 | sort | uniq
> > [2] git grep VB2_DMABUF | cut -d":" -f 1 | sort | uniq
> > [3] by running [1] and [2] through | cut -d"-" -f 1 | cut -d"_" -f 1 | =
uniq
> >
> > Best,
> > Tomasz
> >
> >>
> >> But generally speaking, bracketing all driver with CPU access synchron=
ization
> >> does not make sense indeed, so I second the rejection.
> >>
> >> Nicolas
> >>
> >>>
> >>> Best regards,
> >>> Tomasz
> >>>
> >>>> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drive=
rs/media/common/videobuf2/videobuf2-core.c
> >>>> index 358f1fe42975..4734ff9cf3ce 100644
> >>>> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >>>> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >>>> @@ -340,6 +340,17 @@ static void __vb2_buf_mem_prepare(struct vb2_bu=
ffer *vb)
> >>>>         vb->synced =3D 1;
> >>>>         for (plane =3D 0; plane < vb->num_planes; ++plane)
> >>>>                 call_void_memop(vb, prepare, vb->planes[plane].mem_p=
riv);
> >>>> +
> >>>> +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> >>>> +               return;
> >>>> +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> >>>> +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> >>>> +
> >>>> +               if (!dbuf)
> >>>> +                       continue;
> >>>> +
> >>>> +               dma_buf_end_cpu_access(dbuf, vb->vb2_queue->dma_dir)=
;
> >>>> +       }
> >>>>  }
> >>>>
> >>>>  /*
> >>>> @@ -356,6 +367,17 @@ static void __vb2_buf_mem_finish(struct vb2_buf=
fer *vb)
> >>>>         vb->synced =3D 0;
> >>>>         for (plane =3D 0; plane < vb->num_planes; ++plane)
> >>>>                 call_void_memop(vb, finish, vb->planes[plane].mem_pr=
iv);
> >>>> +
> >>>> +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> >>>> +               return;
> >>>> +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> >>>> +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> >>>> +
> >>>> +               if (!dbuf)
> >>>> +                       continue;
> >>>> +
> >>>> +               dma_buf_begin_cpu_access(dbuf, vb->vb2_queue->dma_di=
r);
> >>>> +       }
> >>>>  }
> >>>>
> >>>>  /*
> >>>> --
> >>>> 2.43.0-rc1
> >>>>
> >>
> >
>

