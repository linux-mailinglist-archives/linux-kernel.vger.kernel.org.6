Return-Path: <linux-kernel+bounces-339109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D32986069
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6C71F26ACD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782F18FC86;
	Wed, 25 Sep 2024 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NL3OQ/Dx"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CBE15B12B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268830; cv=none; b=s5yJuOcZfs2uuqMI3db2nu9enWms9+5T5xzlXWLw4fNArqz+SmuNgDj5r9pXMxLhQV4/dKqqcJCXBYMEzKFmPrmlIR2HUI/RWxykGJQew9xkRVJfzi+ySaIqz1bVefXz2keDk19KnT7WnyJqgSc9yX1eV1zUqgJLne6xFFfNRI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268830; c=relaxed/simple;
	bh=mT33v1BcdCHSqsM4CQRybDcheK6N+x0YaItl1abb8dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFonImnMkJvEAKt/XguOsgcNXEVze8SNIGW3hiNMsRtVMXCAeHV7DNdQ3J6UAgufbNXAsjz0Lrdxu1W0KcgQTEmmi4R1svflL/C7pzYzaciJb93CX9FvnsopWkGCx9XYei/Miv5lVCULX0H3K/jdg7P19WK6Bl5jsf4On9OAMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NL3OQ/Dx; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277f19ee2a2so3341222fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727268827; x=1727873627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3P64Nuj8GlT9wDKZ+1u3zuMiJRKJGP8MnD/jd+llEk=;
        b=NL3OQ/Dxp5tOsuIXl0Jx13baOoqlyTbWUA1iuGNJmxvl3dkW0/bqoi1Nb654LPToTG
         2zH+GZ6rcVQk1KmDwPZWBDmFTyMmPLFqyzDTYLiae1fcx2fzCbtGZ2TBo/M1bPqpQlPY
         vvLr1uXuP0YrWRh4uWjcRRh5dia/uswGKRHKHZLaYtYorl/IS6djuH1oe0+4OE+pDbeH
         WwwpeuLZx43+mlc0Ly2aRYrFtrGBzJmD5QqRsQVVK36h+VppUxnJY0RTIgPFXoex6W5b
         snJXtFaEdFZUOBUVC5cGKGMxIowuqPhEiQ7ld8vGrFFL3SiuSQtYEZCddwv3ftvg+uyO
         dR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268827; x=1727873627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3P64Nuj8GlT9wDKZ+1u3zuMiJRKJGP8MnD/jd+llEk=;
        b=N4tU0j7CqSzbgxFlcSyJjGE+NDqoFlEoAaKuZhGiUU20/EhpSmVrr6IhzxqGaXHf1t
         cOWj7PRkvBS8BvboqLEj+Od2MMFxwT/GxtiMoB2aqlv1GVfdYjg5n7VsntcOdlIIdPq7
         TlNMvxJqDdKJ0WUGVcOxobHHx7HUGVY+5F9CkicXIV1ki2xnRHoT00Srcu2kwAiDFidl
         c89beG5AB4XCz+TAjO2uhsGLVuDXbauJ7v2x7BSIXsrj79aBNg2RCuOJ2GyCjqjLN1+8
         U9qtU6YOfWjFX0n/tqKyZA6GntONlpvHlfy+s1gJT2wE7cdFafMT05SWaJGz/UElI9EI
         GqRQ==
X-Gm-Message-State: AOJu0YxqBlWOo940oGC61snn6XTQztwPCkrm1r1mwYOnQMEftk239oeh
	/K0tC/FhR3bLRPpCgchhu+UZTmPEYFFFKPioR+ylNkB2GNWT/WvKVAO/WZGPiovLEoyz2iBr0go
	LE6xw1ILszSEHpomYMP6N9srlxbccM6I42uKYBg==
X-Google-Smtp-Source: AGHT+IHSJDI5zJNXgia6m+wvn3Z88Lm1Gqvx0KTAh7NQ/EUXrFKHeoOj7pRQGL8LyhcvQBz8DCABmsPEnqj7Sd60oPU=
X-Received: by 2002:a05:6870:5487:b0:277:f329:f111 with SMTP id
 586e51a60fabf-286e141f056mr1950128fac.22.1727268826783; Wed, 25 Sep 2024
 05:53:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830070351.2855919-1-jens.wiklander@linaro.org>
 <dhxvyshwi4qmcmwceokhqey2ww4azjcs6qrpnkgivdj7tv5cke@r36srvvbof6q>
 <20240925071504.GA3519798@rayden> <bktt4yanmfn4gjljy2wxmigj6mncpga237oxyf4g4h2vxu2a3q@asnsn7smi4u2>
In-Reply-To: <bktt4yanmfn4gjljy2wxmigj6mncpga237oxyf4g4h2vxu2a3q@asnsn7smi4u2>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 25 Sep 2024 14:53:34 +0200
Message-ID: <CAHUa44EvgcUg0QFvwsgU6BSs_BtZg6bO_5rx3CJbyCUPbiQZXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Linaro restricted heap
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:41=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, Sep 25, 2024 at 09:15:04AM GMT, Jens Wiklander wrote:
> > On Mon, Sep 23, 2024 at 09:33:29AM +0300, Dmitry Baryshkov wrote:
> > > Hi,
> > >
> > > On Fri, Aug 30, 2024 at 09:03:47AM GMT, Jens Wiklander wrote:
> > > > Hi,
> > > >
> > > > This patch set is based on top of Yong Wu's restricted heap patch s=
et [1].
> > > > It's also a continuation on Olivier's Add dma-buf secure-heap patch=
 set [2].
> > > >
> > > > The Linaro restricted heap uses genalloc in the kernel to manage th=
e heap
> > > > carvout. This is a difference from the Mediatek restricted heap whi=
ch
> > > > relies on the secure world to manage the carveout.
> > > >
> > > > I've tried to adress the comments on [2], but [1] introduces change=
s so I'm
> > > > afraid I've had to skip some comments.
> > >
> > > I know I have raised the same question during LPC (in connection to
> > > Qualcomm's dma-heap implementation). Is there any reason why we are
> > > using generic heaps instead of allocating the dma-bufs on the device
> > > side?
> > >
> > > In your case you already have TEE device, you can use it to allocate =
and
> > > export dma-bufs, which then get imported by the V4L and DRM drivers.
> > >
> > > I have a feeling (I might be completely wrong here) that by using
> > > generic dma-buf heaps we can easily end up in a situation when the
> > > userspace depends heavily on the actual platform being used (to map t=
he
> > > platform to heap names). I think we should instead depend on the
> > > existing devices (e.g. if there is a TEE device, use an IOCTL to
> > > allocate secured DMA BUF from it, otherwise check for QTEE device,
> > > otherwise check for some other vendor device).
> >
> > That makes sense, it's similar to what we do with TEE_IOC_SHM_ALLOC
> > where we allocate from a carveout reserverd for shared memory with the
> > secure world. It was even based on dma-buf until commit dfd0743f1d9e
> > ("tee: handle lookup of shm with reference count 0").
> >
> > We should use a new TEE_IOC_*_ALLOC for these new dma-bufs to avoid
> > confusion and to have more freedom when designing the interface.
> >
> > >
> > > The mental experiment to check if the API is correct is really simple=
:
> > > Can you use exactly the same rootfs on several devices without
> > > any additional tuning (e.g. your QEMU, HiKey, a Mediatek board, Qualc=
omm
> > > laptop, etc)?
> >
> > No, I don't think so.
>
> Then the API needs to be modified.

I don't think that is enough. I would have answered no even without
the secure data path in mind. Communication with the secure world is
still too fragmented.

>
> Or the userspace needs to be modified in the way similar to Vulkan /
> OpenCL / glvnd / VA / VDPU: platform-specific backends, coexisting on a
> single rootfs.

Yes, that's likely a needed step. But the first step is to have
something to relate to upstream, without that there's only an
ever-changing downstream ABI.

>
> It is more or less fine to have platform-specific rootfs when we are
> talking about the embedded, resource-limited devices. But for the
> end-user devices we must be able to install a generic distro with no
> device-specific packages being selected.

I'm not sure we can solve that problem here. But we should of course
not make matters worse. In the restricted heap patch set which this
patchset builds on we define a way to allocate memory from a
restricted heap, but we leave the problem of finding the right heap to
userspace.

Thanks,
Jens

>
> >
> > >
> > > >
> > > > This can be tested on QEMU with the following steps:
> > > > repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_=
v8.xml \
> > > >         -b prototype/sdp-v1
> > > > repo sync -j8
> > > > cd build
> > > > make toolchains -j4
> > > > make all -j$(nproc)
> > > > make run-only
> > > > # login and at the prompt:
> > > > xtest --sdp-basic
> > > >
> > > > https://optee.readthedocs.io/en/latest/building/prerequisites.html
> > > > list dependencies needed to build the above.
> > > >
> > > > The tests are pretty basic, mostly checking that a Trusted Applicat=
ion in
> > > > the secure world can access and manipulate the memory.
> > >
> > > - Can we test that the system doesn't crash badly if user provides
> > >   non-secured memory to the users which expect a secure buffer?
> > >
> > > - At the same time corresponding entities shouldn't decode data to th=
e
> > >   buffers accessible to the rest of the sytem.
> >
> > I'll a few tests along that.
> >
> > Thanks,
> > Jens
> >
> > >
> > > >
> > > > Cheers,
> > > > Jens
> > > >
> > > > [1] https://lore.kernel.org/dri-devel/20240515112308.10171-1-yong.w=
u@mediatek.com/
> > > > [2] https://lore.kernel.org/lkml/20220805135330.970-1-olivier.masse=
@nxp.com/
> > > >
> > > > Changes since Olivier's post [2]:
> > > > * Based on Yong Wu's post [1] where much of dma-buf handling is don=
e in
> > > >   the generic restricted heap
> > > > * Simplifications and cleanup
> > > > * New commit message for "dma-buf: heaps: add Linaro restricted dma=
buf heap
> > > >   support"
> > > > * Replaced the word "secure" with "restricted" where applicable
> > > >
> > > > Etienne Carriere (1):
> > > >   tee: new ioctl to a register tee_shm from a dmabuf file descripto=
r
> > > >
> > > > Jens Wiklander (2):
> > > >   dma-buf: heaps: restricted_heap: add no_map attribute
> > > >   dma-buf: heaps: add Linaro restricted dmabuf heap support
> > > >
> > > > Olivier Masse (1):
> > > >   dt-bindings: reserved-memory: add linaro,restricted-heap
> > > >
> > > >  .../linaro,restricted-heap.yaml               |  56 ++++++
> > > >  drivers/dma-buf/heaps/Kconfig                 |  10 ++
> > > >  drivers/dma-buf/heaps/Makefile                |   1 +
> > > >  drivers/dma-buf/heaps/restricted_heap.c       |  17 +-
> > > >  drivers/dma-buf/heaps/restricted_heap.h       |   2 +
> > > >  .../dma-buf/heaps/restricted_heap_linaro.c    | 165 ++++++++++++++=
++++
> > > >  drivers/tee/tee_core.c                        |  38 ++++
> > > >  drivers/tee/tee_shm.c                         | 104 ++++++++++-
> > > >  include/linux/tee_drv.h                       |  11 ++
> > > >  include/uapi/linux/tee.h                      |  29 +++
> > > >  10 files changed, 426 insertions(+), 7 deletions(-)
> > > >  create mode 100644 Documentation/devicetree/bindings/reserved-memo=
ry/linaro,restricted-heap.yaml
> > > >  create mode 100644 drivers/dma-buf/heaps/restricted_heap_linaro.c
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > --
> > > With best wishes
> > > Dmitry
>
> --
> With best wishes
> Dmitry

