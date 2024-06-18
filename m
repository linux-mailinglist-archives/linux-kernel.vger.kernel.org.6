Return-Path: <linux-kernel+bounces-218808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD84F90C65C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0AE51C217C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E53178CE7;
	Tue, 18 Jun 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCoLP7pr"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857AF13C3F2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696906; cv=none; b=pIZnamZO2lZlZYABtvr5J3KSxU/ptfyZlkcFK+N8wOsDvAM5S+KJG/+aVvQwlg/T8ZK9JnvFcKunWaXIa6+5qtPW+qDX3sGlwcw94gBg6AUbBECB3DvPY9Jfxd96ziilNvYD2e0TngQZS7zCCL9Ao16gh2U0qGG77ISer+BUu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696906; c=relaxed/simple;
	bh=+i2usPNZNgsyG7GktfYMCH5Ks0ugtDc9juyqEc/9YzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjrO4q8qNuEcvl++2qAOetoFOc9hCMu8l2o+DlUpsrUNgwOrsOv5fN2nIRq7E/Mskxnayi5br5XEQQnPep+zXHpbSgXgKf28K02t+BLRZm29pIEfSngQcUBpLvS939reWGCD+33KI83vAs9aOpuphq+3NzLQESuaiqgeDJtVgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oCoLP7pr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6efae34c83so628589466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718696901; x=1719301701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCxa0N6a/etTSTm358fxjAycnT2MNf/L62aewqr2SjQ=;
        b=oCoLP7preiduLiZUSmEIU0D9PNWQdD3yaKWarnveFckNSTypHuBLHGGF2JVIQRiYRG
         LnDKJat3Mvf9U96C3jiSERM9wcjtR8o6REaC17p8wtjVPFsd+F0VNDAbNDmrWkSCxZMk
         h2J54ZFBXbiFGTARopi4NHQVOHdwHAMEIO8qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696901; x=1719301701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCxa0N6a/etTSTm358fxjAycnT2MNf/L62aewqr2SjQ=;
        b=EdzdDjfmkqnouB5qB7HVCebNXm63pmHgFWfpkD1116B2mG9sjBxD8XYycj+w/+53Xb
         /YsZreUscGQBvpzxWUI02X/p4GHLcvbimtkk+0m9g2mP9FXXH5bHeKTdQ1p18RZJptoh
         gYCeGz9fpJ7WqN3vk7W6MIySZZsMtFbZU723bPKtfAko/Uh6hhPjjmdUCjPncIjZdiiP
         zPX8q7ssGJCls4Lcva3ZFxDJ7fQxWkxpO66+jQC6Uw6UBXvxzFBUNvOMcf1yru6rKEnR
         xlBjPmep/qp9VS1ECLOLie2dSCg5kBvEWwMCcefjhHjhKy7AUW8/23cvg7wLjnTRjIk8
         pxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSnA8oEdq2DWHyZBz6tE0bNgLtT8Chta71WXVuUEz2DllfFr4qyqNhjDuQAtmQAMouDO8ggAWa7FcQSZ1dt/3trmsWLSo6x7rJaz7u
X-Gm-Message-State: AOJu0YyaQakn7GhFN40bJCrjYov0/tKc6i1zTa7mibmO1mgahbtDBfiY
	0K3kTPk2LBPFa5H/quFfxfWh9boLYtWK+ILMVQWIYers8NnMjOMjI1t1DbAEbLHHyIrXi+iA6S7
	1tP89
X-Google-Smtp-Source: AGHT+IFr0AQaO8k0jU9duljuTIPFfLkvBMm5kku2vUXgzS8MIJ0+tpttm4TqmpLjoB1u66TK6PrFaw==
X-Received: by 2002:a17:907:1608:b0:a6f:6b6a:e8cf with SMTP id a640c23a62f3a-a6f6b6aec22mr733515666b.2.1718696901556;
        Tue, 18 Jun 2024 00:48:21 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f9e05fa34sm9678266b.15.2024.06.18.00.48.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:48:20 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6f1c4800easo622942866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQAHMZlqKplMLtEFa5LKRuJFzk3xaj6kGiAHlTTWxGrA/9MnHBeqh4gMc2E3fVpKILoW2BsRNHrpnpO5F+WKlcwHNUe78VaozQbG1N
X-Received: by 2002:a17:906:ca0d:b0:a6f:fbc:b3f3 with SMTP id
 a640c23a62f3a-a6f60dc89cbmr680235166b.47.1718696899670; Tue, 18 Jun 2024
 00:48:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618073004.3420436-1-tao.jiang_2@nxp.com>
In-Reply-To: <20240618073004.3420436-1-tao.jiang_2@nxp.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 18 Jun 2024 16:47:45 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B_RTHsMwMdD59RAAyFne_0Ok_A4ExdkVOgi=G6-UGfRQ@mail.gmail.com>
Message-ID: <CAAFQd5B_RTHsMwMdD59RAAyFne_0Ok_A4ExdkVOgi=G6-UGfRQ@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: sync caches for dmabuf memory
To: TaoJiang <tao.jiang_2@nxp.com>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca, 
	shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
	xiahong.bao@nxp.com, eagle.zhou@nxp.com, ming.qian@oss.nxp.com, 
	imx@lists.linux.dev, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	Ming Qian <ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi TaoJiang,

On Tue, Jun 18, 2024 at 4:30=E2=80=AFPM TaoJiang <tao.jiang_2@nxp.com> wrot=
e:
>
> From: Ming Qian <ming.qian@nxp.com>
>
> When the memory type is VB2_MEMORY_DMABUF, the v4l2 device can't know
> whether the dma buffer is coherent or synchronized.
>
> The videobuf2-core will skip cache syncs as it think the DMA exporter
> should take care of cache syncs
>
> But in fact it's likely that the client doesn't
> synchronize the dma buf before qbuf() or after dqbuf(). and it's
> difficult to find this type of error directly.
>
> I think it's helpful that videobuf2-core can call
> dma_buf_end_cpu_access() and dma_buf_begin_cpu_access() to handle the
> cache syncs.
>
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: TaoJiang <tao.jiang_2@nxp.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>

Sorry, that patch is incorrect. I believe you're misunderstanding the
way DMA-buf buffers should be managed in the userspace. It's the
userspace responsibility to call the DMA_BUF_IOCTL_SYNC ioctl [1] to
signal start and end of CPU access to the kernel and imply necessary
cache synchronization.

[1] https://docs.kernel.org/driver-api/dma-buf.html#dma-buffer-ioctls

So, really sorry, but it's a NAK.

Best regards,
Tomasz

> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/me=
dia/common/videobuf2/videobuf2-core.c
> index 358f1fe42975..4734ff9cf3ce 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -340,6 +340,17 @@ static void __vb2_buf_mem_prepare(struct vb2_buffer =
*vb)
>         vb->synced =3D 1;
>         for (plane =3D 0; plane < vb->num_planes; ++plane)
>                 call_void_memop(vb, prepare, vb->planes[plane].mem_priv);
> +
> +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> +               return;
> +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> +
> +               if (!dbuf)
> +                       continue;
> +
> +               dma_buf_end_cpu_access(dbuf, vb->vb2_queue->dma_dir);
> +       }
>  }
>
>  /*
> @@ -356,6 +367,17 @@ static void __vb2_buf_mem_finish(struct vb2_buffer *=
vb)
>         vb->synced =3D 0;
>         for (plane =3D 0; plane < vb->num_planes; ++plane)
>                 call_void_memop(vb, finish, vb->planes[plane].mem_priv);
> +
> +       if (vb->memory !=3D VB2_MEMORY_DMABUF)
> +               return;
> +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> +               struct dma_buf *dbuf =3D vb->planes[plane].dbuf;
> +
> +               if (!dbuf)
> +                       continue;
> +
> +               dma_buf_begin_cpu_access(dbuf, vb->vb2_queue->dma_dir);
> +       }
>  }
>
>  /*
> --
> 2.43.0-rc1
>

