Return-Path: <linux-kernel+bounces-538406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39048A49838
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA07B1897584
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71AB261585;
	Fri, 28 Feb 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JImUHD7b"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EE7849C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740741590; cv=none; b=SdudmFE0MHnfxHBJqmzKKXAmmeosaxK32A24YXHCBh3+sPloxfVrItQWEjQNMDVdCd8zb4U/RnY8z56m/J7gOjU8/Qr7ihwIJlwvtCtXiwOxzvxvy/2EQky3fRu0hmqmmnu8baemnkWs+3H7LStYY9kgnSuuQS8+NUQALcz1cVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740741590; c=relaxed/simple;
	bh=OsXYM8ePl9dRXaykIjugDeDQ+GWuufEIdXvrBWmNtGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8Dy3PvBr1NzpNg7JeUtOf3VWutvcANpANyzeiMQhkiZgossd5p5qnqFcbfWWRt8kp4/tAHetW5+XyNZqaUYWLXsgSmiwxrVZRijyjRX/PZugVEmq/BR+1BwVUka8fLa2uSYk94TNljW0XVQIS2NRvvQ3WqgUy80M6KIKMf0tzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JImUHD7b; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso3027502a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740741586; x=1741346386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OsXYM8ePl9dRXaykIjugDeDQ+GWuufEIdXvrBWmNtGQ=;
        b=JImUHD7buniz3XJOc8kjpXlwGFnz4zfYTje7pJJLKTXFPbWPU5nlV1WcmJPSxLBbKk
         rIUPCsIXHldoiLO0P2FM8tujUbi02hyizvKej6RWxpWksP1W5p6GKCXhyijni8yax+ci
         9iICzn9Oyq7G1zk0UdKepFhQFpkfEjwtRU+jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740741586; x=1741346386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OsXYM8ePl9dRXaykIjugDeDQ+GWuufEIdXvrBWmNtGQ=;
        b=KHMJdxnBwJam3r50os7ZDTDe1O8SGG+7GHPbiGD6HbgBntotuO8jPMv9X0Y4HPqXk8
         IRNk6A5XHiOCmnIk73m3/kji93yHSRO0VAHXcHvkfQh2HhKeY8MES7i77YyN1Yk3Kftl
         SwhWCoO2zKGDkCpEn7GfrqWLwBtnn01nTj7rfs7i1equzpz0fFZOumb/vaPoUr2nfXkn
         ZppCzu7h7q4DluWtcUqqoXod8ns2smCtaXKxN/4duIJ/i2da7F/czaFLDq4aV0LIQJXV
         9XHdBGXH28ePRBSElBt+DEOh8w92w8NQPQdw/9dSvBsvCnFNGftabwOqDVOEY5X5sF81
         RFvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1/FxriHxCDEF/jXoBljwsHL8udgDb/EsfHEvTUW/jScvwpt1J8IE7jVPptCObT9eYsM+67kMR3EDlR1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrz72ssKATFzzF+uTuOGw/99nW5B17SfDT/0sFh6y5NuXut9wY
	pWCV15cAcU7II3RBKZEkApFMSxB2BepGaYH6b0PwH+L11Swdg969fNkuK7hDE5silfLabcBOOfB
	UPg==
X-Gm-Gg: ASbGnctHTBd7K7tmKSa1QYtIXVOhMsyzM2CKdo+Anvn2OGTaKAYL5KDR93Dql6IhBpf
	j9JeFftZj+HXk4VuR/MPFnVVXE1S6+LBt5aH5/WvTuc37t/SY4wXtioITFwphpS9wx6yjSbKeO+
	Xr/BHFSmWPi31h9fMx7DLRk38XHw/AmxlQecThKmeJkHY8Rfo38nV6gkYVd+9oijQZqL1ETsY2j
	C9pUhniUZFPajlDH/2psyicab0X5mJZn7XAtgMPijDbYEu9FK7DRKOGLHdaVztsJjdAZs1p4Sds
	W0uW8y0zMCuG0BTttGWz9qhOMKu9+RrEsk+29w34TvhVr8+P5bCeJeYkhzJGXQ==
X-Google-Smtp-Source: AGHT+IF7QgwKNgZ4dxv8jw3Ir14n3e/kmnj4IQbPIxQ8WxV0lM/1VqgHN63UhT6xSnMSD44nYCwCtA==
X-Received: by 2002:a05:6402:2692:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5e4d6b4baabmr4583541a12.23.1740741585695;
        Fri, 28 Feb 2025 03:19:45 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf17fa4a4asm231728566b.92.2025.02.28.03.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 03:19:45 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ded4a3bf0bso10130a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:19:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8k/YfgWsc/OxTw9Kfba+ZfsQaeNgS+ywOlDY0aVGnAWvZCa6t+pqfHxaMQY6YyVkat8BYBO2DSvaJ+6w=@vger.kernel.org
X-Received: by 2002:aa7:c593:0:b0:5dc:5ae8:7e1 with SMTP id
 4fb4d7f45d1cf-5e4d74de7ecmr78282a12.6.1740741584369; Fri, 28 Feb 2025
 03:19:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102-b4-rkisp-noncoherent-v1-1-bba164f7132c@gmail.com>
 <20250103152326.GP554@pendragon.ideasonboard.com> <87bjw9s4s3.fsf@gmail.com>
 <dtfv2slbtj3ar2wvlcnd74p3xtlvggebkk3fj5ocm3eil7kyqw@al3brwf4y5dw>
 <CAAFQd5DS2x3sX59EdkTEMuO=eXc=Q0jD44EUwMisP6ocWz11qg@mail.gmail.com>
 <bgnkzjpegpmif7gohoijt42rku6jruovjsxscg75dprdz5ek2i@ntfh2yyjyiry>
 <CAAFQd5BihpFYgqvKta7ULMAVSMTy3kd6iR6Mo4ea9Ci935EFMA@mail.gmail.com> <aw6hhc5x7lycbmckbc57ke5whksem5lasfkufcxrcuou5vhoyo@ylggg6tdzcnq>
In-Reply-To: <aw6hhc5x7lycbmckbc57ke5whksem5lasfkufcxrcuou5vhoyo@ylggg6tdzcnq>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 28 Feb 2025 20:19:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BEu_i8JeKkFSCqCNDEs75k3=vOjnAYzSBv9yhPJNvCsA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo4iuYuE-WQ5kGFMC-K7_2dFm6wcUIvZdWnUkigr4hSv-4tmouuVXKBwk8
Message-ID: <CAAFQd5BEu_i8JeKkFSCqCNDEs75k3=vOjnAYzSBv9yhPJNvCsA@mail.gmail.com>
Subject: Re: [PATCH] media: rkisp1: allow non-coherent video capture buffers
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 7:48=E2=80=AFPM Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Tomasz
>
> On Fri, Feb 28, 2025 at 07:28:43PM +0900, Tomasz Figa wrote:
> > On Fri, Feb 28, 2025 at 7:18=E2=80=AFPM Jacopo Mondi
> > <jacopo.mondi@ideasonboard.com> wrote:
> > >
> > > Hi Tomasz
> > >
> > > On Fri, Feb 28, 2025 at 07:00:57PM +0900, Tomasz Figa wrote:
> > > > Hi Jacopo,
> > > >
> > > > On Fri, Feb 28, 2025 at 2:11=E2=80=AFAM Jacopo Mondi
> > > > <jacopo.mondi@ideasonboard.com> wrote:
> > > > >
> > > > > Hi Mikhail
> > > > >
> > > > > On Tue, Jan 14, 2025 at 07:00:39PM +0300, Mikhail Rudenko wrote:
> > > > > >
> > > > > > Hi Laurent,
> > > > > >
> > > > > > On 2025-01-03 at 17:23 +02, Laurent Pinchart <laurent.pinchart@=
ideasonboard.com> wrote:
> > > > > >
> > > > > > > On Thu, Jan 02, 2025 at 06:35:00PM +0300, Mikhail Rudenko wro=
te:
> > > > > > >> Currently, the rkisp1 driver always uses coherent DMA alloca=
tions for
> > > > > > >> video capture buffers. However, on some platforms, using non=
-coherent
> > > > > > >> buffers can improve performance, especially when CPU process=
ing of
> > > > > > >> MMAP'ed video buffers is required.
> > > > > > >>
> > > > > > >> For example, on the Rockchip RK3399 running at maximum CPU f=
requency,
> > > > > > >> the time to memcpy a frame from a 1280x720 XRGB32 MMAP'ed bu=
ffer to a
> > > > > > >> malloc'ed userspace buffer decreases from 7.7 ms to 1.1 ms w=
hen using
> > > > > > >> non-coherent DMA allocation. CPU usage also decreases accord=
ingly.
> > > > > > >
> > > > > > > What's the time taken by the cache management operations ?
> > > > > >
> > > > > > Sorry for the late reply, your question turned out a little mor=
e
> > > > > > interesting than I expected initially. :)
> > > > > >
> > > > > > When capturing using Yavta with MMAP buffers under the conditio=
ns mentioned
> > > > > > in the commit message, ftrace gives 437.6 +- 1.1 us for
> > > > > > dma_sync_sgtable_for_cpu and 409 +- 14 us for
> > > > > > dma_sync_sgtable_for_device. Thus, it looks like using non-cohe=
rent
> > > > > > buffers in this case is more CPU-efficient even when considerin=
g cache
> > > > > > management overhead.
> > > > > >
> > > > > > When trying to do the same measurements with libcamera, I faile=
d. In a
> > > > > > typical libcamera use case when MMAP buffers are allocated from=
 a
> > > > > > device, exported as dmabufs and then used for capture on the sa=
me device
> > > > > > with DMABUF memory type, cache management in kernel is skipped =
[1]
> > > > > > [2]. Also, vb2_dc_dmabuf_ops_{begin,end}_cpu_access are no-ops =
[3], so
> > > > > > DMA_BUF_IOCTL_SYNC from userspace does not work either.
> > > > > >
> > > > > > So it looks like to make this change really useful, the above i=
ssue of
> > > > > > cache management for libcamera/DMABUF/videobuf2-dma-contig has =
to be
> > > > > > solved. I'm not an expert in this area, so any advice is kindly=
 welcome. :)
> > > > >
> > > > > It would be shame if we let this discussion drop dead.. cache
> > > > > management policies are relevant for performances, specifically f=
or
> > > > > cpu access, and your above 7.7ms vs 1.1 ms test clearly shows tha=
t.
> > > > >
> > > > > >
> > > > > > [1] https://git.linuxtv.org/media.git/tree/drivers/media/common=
/videobuf2/videobuf2-core.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c437d#n=
411
> > > > >
> > > > > I would like to know from Hans if the decision to disallow cache-=
hints
> > > > > for dmabuf importers is a design choice or is deeply rooted in ot=
her
> > > > > reasons I might be missing.
> > > >
> > > > When DMA-buf is used, the responsibility for cache management is
> > > > solely on the CPU users' side, so cache-hints don't really apply. I=
t's
> > > > the exporter (=3Dallocator) who determines the mapping policy of th=
e
> > > > buffer and provides necessary DMA_BUF_SYNC operations (can be no-op=
 if
> > > > the buffer is coherent).
> > >
> > > This all makes sense.
> > >
> > > I take it as, for libcamera, users of the FrameBufferAllocator helper
> > > (which first exports MMAP buffers from the video device and the
> > > imports them back as DMABUF) won't be able to control the cache
> > > policies.
> > >
> > > Now, in the long term, we want FrameBufferAllocator to go away and
> > > have either buffers exported by the consumer (likely DRM) or by a
> > > system wide buffer allocator (when we'll have one) and have the video
> > > devices operate as pure importers. But for the time being the
> > > "first export then import" use case is possibile and valid so I wonde=
r
> > > if we should consider measures to allow controlling caching policies
> > > for this use case too.
> >
> > Hmm, I may be missing something, but if FrameBufferAllocator does the
> > allocation internally in libcamera, why couldn't it use the
> > V4L2_MEMORY_FLAG_NON_COHERENT REQBUFS/CREATE_BUFS flag?
>
> -I- might be missing something, but reading the below links that
> Mikhail reported in a previous email
> [1] https://git.linuxtv.org/media.git/tree/drivers/media/common/videobuf2=
/videobuf2-core.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c437d#n411
> [2] https://git.linuxtv.org/media.git/tree/drivers/media/common/videobuf2=
/videobuf2-core.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c437d#n829
>
> it seems to me that yes, when first exporting you can hint to tell
> vb2 to allocate from non-coherent/non-contiguous memory, but then when
> switching the device to importer mode (and import the same buffers it
> previously exported) the cache sync point would then
> be skipped, leading to possible synchronization issues between the cpu
> consumer and the device.

Yeah, and that is 100% expected. As I said in my previous reply, in
the DMA-buf world, it's the responsibility of the users doing the CPU
accesses to ensure the correct synchronization (aka explicit sync).

>
> >
> > Note that however, once the buffer is allocated and mapped once, on
> > many architectures it must keep the same mapping attributes across the
> > different mappings, due to how the memory hierarchy works. (Not sure
> > if this is what you are asking for here, though.)
> >
> > >
> > > >
> > > > Best regards,
> > > > Tomasz
> > > >
> > > > >
> > > > > I'm asking because the idea is for libcamera to act solely as dma=
-buf
> > > > > importer, the current alloc-export-then-import trick is an helper=
 for
> > > > > applications to work around the absence of a system allocator.
> > > > >
> > > > > If the requirement to disable cache-hints for importers cannot be
> > > > > lifted, for libcamera it means we would not be able to use it.
> > > > >
> > > > >
> > > > > > [2] https://git.linuxtv.org/media.git/tree/drivers/media/common=
/videobuf2/videobuf2-core.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c437d#n=
829
> > > > > > [3] https://git.linuxtv.org/media.git/tree/drivers/media/common=
/videobuf2/videobuf2-dma-contig.c?id=3D94794b5ce4d90ab134b0b101a02fddf6e74c=
437d#n426
> > > > > >
> > > > > > --
> > > > > > Best regards,
> > > > > > Mikhail Rudenko
> > > > > >
> > > > >

