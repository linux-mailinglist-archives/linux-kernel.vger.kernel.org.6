Return-Path: <linux-kernel+bounces-538327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3579BA4972F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3104316A9D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDAC25F7BD;
	Fri, 28 Feb 2025 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EJGhoXB1"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAFA25F7AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738358; cv=none; b=gIvImk5XgxkyYgLCmN0B84gHBsXdnapNoUEPHv5dtAPup35e+6uPL69DgLyy3azIeTxczytrsoPFmw52Uk98pDJl4HDHk+n7B67XvIZnj0vVbogLxrMax8cezu4wuIhdd3+LOROnWzeFn/oObiT9ToxpHoa72hAlhGfg8j+5P/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738358; c=relaxed/simple;
	bh=bnYGrNktnSSLWrDFtsq76cPCF2tBeDvXcfc8CAy88ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dho4WoZbyTqUR9yeKkZRhO1id4zfE9ij/fZnS3i9RqCgXHaNYlcD1WxjUMJGjA7Ccw4PxiNQ7pA+q9qkTPzufzYN57wAfHghCG0BFVRGiHXA3z6OruJJNABvHJX5xjmXKTTLa6n5oguOJFmzaQScIF7xFnxZa2OchDDzaEJ5e7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EJGhoXB1; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso3203703a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740738353; x=1741343153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nb9NUQhb3bplKyawSYK7wGLTz8Fx3itEvvEthZZH/DE=;
        b=EJGhoXB1Y9u79VfD5P5ssNMCo/r6iimUk+w5PyYkXg8sXtebkU2a9UIp35zi9l1fCm
         V2SrKq5QI8g0DSs4BY0kz6UM3NDQbNlHgAZ/9D3lBzPsPpmAAUBzz31z/5DI+kWYdsXE
         /Vnd9gZv81jxAb9vDOWWRUCKhL0ggjrm7EXY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738353; x=1741343153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nb9NUQhb3bplKyawSYK7wGLTz8Fx3itEvvEthZZH/DE=;
        b=Z7Bkb5ULi5lSMFr4xG4bpJ6KTGqV0CqrLQ9BFhkgc+LuldME3TPsaayKpPwbWtlBJA
         9viWZnWS2P5BMJuUeymkGRxGMk7TQBj6YU/i0JlfJx4bF+V4fwEDxsfh3Ne8mHNsc6ec
         uo+uDd6J3SJAdvM+HjOB5lgxd442KWpVRNNYUduCNUzBexSEfOPNnUh4W9AVQNooGuOt
         Wk3YXCkPCb+WYPa7v/fELI2gghzfAK5JH2BPwC5hip54m8y/lVn64EMIxx0i15Vm4Wwr
         kjqX1TM/bOmriMad2MJdIJIpWos5iMq1G21dHnNoYBLZfgG5se3QnnBs0xGmhdba8r8n
         gygw==
X-Forwarded-Encrypted: i=1; AJvYcCXIttN1nilqfevDrqzjEiYK7myhcJhDHgfj11ZCOl8EzU08L4SCoTS7f27++lZ2T5NyQ8fxS/sX57FEwsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMM+Da4cG2x4x1lMt3g9Wrn615ScznLtUF1LsW3vtmkAUG6AIr
	fSYjWyBKzGG3MS5NYMmsiNkAQwNDi5l1+EQq5feZPc/ErZ5xHYgIYhtfWEFQAZz2y06JJ0geTLg
	k9g==
X-Gm-Gg: ASbGncv+UIs+8FMrV0LC5XABZHEPfVbb1SzVRGN7sD1lp8EXZTc3QuRy8RXdJqdLryW
	fe5mwrLRshrZEy73hAdnm+poVZCKNhSKXHTe4LVvECizp3XgnIacLrfvU9YRAzvCHKxDlaVzPoj
	wvti+ClOhlTsyDNUOfNhcHLJ9FVhcwamjGCfSUhoiiKGTZM7h41gd1/cFrgTXBBxkdo/zj7covU
	cvnrF5l5u/Gt0eIcHqaQFV6+0dhTh3Glmu9512ZtHpJAn+xbnszvOCuo4ax3QRFtiy0ILVj3uF3
	JN9B8fkFX7VaTXS+m02Y7qgNdFmTJo9YVcIRXQ2pPrPsISI+0Fg4df+ApHThXA==
X-Google-Smtp-Source: AGHT+IEhhFjnVusQggaFgpXWpkmHzSWQwVpsOPadkyJKyzZMwhbhVjQ0sGMyVD0zI7WldnIc3U7Tbg==
X-Received: by 2002:a05:6402:13cd:b0:5e0:815d:4e08 with SMTP id 4fb4d7f45d1cf-5e4d6ac9ea1mr2493275a12.3.1740738353255;
        Fri, 28 Feb 2025 02:25:53 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4af4dsm2298897a12.11.2025.02.28.02.25.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 02:25:51 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e05ac70b61so4639a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:25:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+fkzK2eGnHfDzlr2pDaLL/N8PBV3Z1bxFVeZcVphJmpHx4kn2W34HpMph4IHW2/GYoejA8NUlAprpIKs=@vger.kernel.org
X-Received: by 2002:a50:d7dd:0:b0:5dc:ccb4:cb11 with SMTP id
 4fb4d7f45d1cf-5e4d74dea39mr77472a12.4.1740738351014; Fri, 28 Feb 2025
 02:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128-b4-rkisp-noncoherent-v3-0-baf39c997d2a@gmail.com>
 <20250128-b4-rkisp-noncoherent-v3-1-baf39c997d2a@gmail.com> <25beec7ea929b624d845f5ba4abce6267974ed82.camel@ndufresne.ca>
In-Reply-To: <25beec7ea929b624d845f5ba4abce6267974ed82.camel@ndufresne.ca>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 28 Feb 2025 19:25:33 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A4YOaSCn=xe7OM-hPKcUhqkD5hTiMUo5F9pwhKNFJ2Lg@mail.gmail.com>
X-Gm-Features: AQ5f1JoHaD84fv2X5fHk6A_BWpTZQNcf1bz4WEEDQ8FkApfINlkKzBEV-PkKHU4
Message-ID: <CAAFQd5A4YOaSCn=xe7OM-hPKcUhqkD5hTiMUo5F9pwhKNFJ2Lg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] media: videobuf2: Fix dmabuf cache sync/flush in dma-contig
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Mikhail Rudenko <mike.rudenko@gmail.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 12:30=E2=80=AFPM Nicolas Dufresne <nicolas@ndufresn=
e.ca> wrote:
>
> Le mardi 28 janvier 2025 =C3=A0 23:35 +0300, Mikhail Rudenko a =C3=A9crit=
 :
> > When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
> > commit 129134e5415d ("media: media/v4l2: remove
> > V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
> > vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
> > no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
> > introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
> > V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
> > no-ops, making cache maintenance for non-coherent dmabufs allocated
> > by
> > dma-contig impossible.
> >
> > Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
> > {flush,invalidate}_kernel_vmap_range calls to
> > vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
> > buffers.
> >
> > Fixes: c0acf9cfeee0 ("media: videobuf2: handle
> > V4L2_MEMORY_FLAG_NON_COHERENT flag")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> > ---
> >  .../media/common/videobuf2/videobuf2-dma-contig.c  | 22
> > ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > index
> > bb0b7fa67b539aa73ad5ccf3c3bc318e26f8a4cb..146d7997a0da5989fb081a6f28c
> > e0641fe726e63 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> > @@ -427,6 +427,17 @@ static int
> >  vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
> >                                  enum dma_data_direction
> > direction)
> >  {
> > +     struct vb2_dc_buf *buf =3D dbuf->priv;
> > +     struct sg_table *sgt =3D buf->dma_sgt;
> > +
> > +     if (!buf->non_coherent_mem)
> > +             return 0;
> > +
> > +     if (buf->vaddr)
> > +             invalidate_kernel_vmap_range(buf->vaddr, buf->size);
>
> Am I correct that this is mostly to prevent the kernel from reading
> back old data from the cache after an application or other driver did
> CPU writes ? If so, can't we restrict that to DMA_TO_DEVICE and
> DMA_BIDIRECTIONAL ?

Note that this function must also synchronize between the user-space
and kernel mappings, where the DMA direction doesn't really matter.
Also it's unlikely for it to be called when not needed - why would one
begin a CPU access before the DMA, when the DMA is FROM_DEVICE?

>
> As for pending kernel writes, they should have been flushed before the
> buffer is made available for dequeue.

There is no implicit flushing for imported DMA-bufs. All the flushing
needs to be executed directly by the CPU accessors by surrounding the
access with begin and end CPU access, be it in the kernel or
userspace.

> And any access while a buffer is
> queued is concurrent access, which is expected to have undefined
> behaviour.
>

Correct.

> > +
> > +     dma_sync_sgtable_for_cpu(buf->dev, sgt, buf->dma_dir);
>
> Isn't there a link to make between buf->dma_dir and direcction before
> calling this ? Also, shouldn't we use direction insead of buf->dma_dir
> to possibly limit the scope ?

Oh, yes, that's a good catch. It should be |direction| passed here and
not |buf->dma_dir|, since the former determines what CPU access will
be done.

>
> > +
> >       return 0;
> >  }
> >
> > @@ -434,6 +445,17 @@ static int
> >  vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
> >                                enum dma_data_direction direction)
> >  {
> > +     struct vb2_dc_buf *buf =3D dbuf->priv;
> > +     struct sg_table *sgt =3D buf->dma_sgt;
> > +
> > +     if (!buf->non_coherent_mem)
> > +             return 0;
> > +
> > +     if (buf->vaddr)
> > +             flush_kernel_vmap_range(buf->vaddr, buf->size);
> > +
> > +     dma_sync_sgtable_for_device(buf->dev, sgt, buf->dma_dir);
>
> Similar questions for the end_cpu_access implementation.

Yeah, same here.

>
> Nicolas
>
> > +
> >       return 0;
> >  }
> >
> >
>

