Return-Path: <linux-kernel+bounces-202091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 307218FC7BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41B52808DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC90A18FC6F;
	Wed,  5 Jun 2024 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/P1LCHk"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E070200CD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579527; cv=none; b=EHvXPY3SHGneeHmmtoxbmZRaHRmRrbwf7eiE2rWXmBXhQICooV7M6/7kIhhtoMxIJq3oXd0n2OyJrm1rLYG3ONMicRTPVlDUeBnZRc9tqjhiWTqyC7i7XE9Dxrht95l6KmAqTijRk+MxLUg6w6UztjzjBezUgPYKWEK7Fk0dJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579527; c=relaxed/simple;
	bh=jDIMASg0bbSoa59nEMmcvY5ZQPMiGKrt21tWciEt5bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDHaROiNvGaBYNvy7x53BNc3nOBl0l71zWV0eYvRJ/ROFpnHnT3lNVvqv99b7JU1OJNLFz5yMwtsUzmtN/TGXDPQoHOBg0a030dYkAImtHfmjDjhACEqUIwqlS/2Q9KW0ywpvbm5s5PaDhvWUU4/vG+3Wo7YFCKFWro09iycYNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F/P1LCHk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a6985ab58so1710291a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717579523; x=1718184323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoJWhO/kN/nIDMel5oucInBCEkvezehjU4YBYZFp3Zg=;
        b=F/P1LCHk0wJMEW2LFzaxw6AYQPJWyEM4G27vsBD/rcfdTLk90iSH7KjdPqZSAU0fRp
         Ib0BQgQmywaOI9OzqmXD7W7gEW0d4Ypr5G7GAYFmpGim250B93t6QHCN4IzYyioxI41k
         W0jKttazCsbX28q6S4Q6t2Fka1v5IZ61zAHWVLDQ4lYx1fj00OnEu/adafn2jCXY6B/N
         4FuxGB7koP/iSyyXbKHrqCTUIh71flTAwXGLdL6Vue2mE65zaKhkjBrfPYYlxLS/ugqu
         WAh9zkLjGP5zqofN8iWiKUt3s1psGgqfyRiTSsskucxOWtYoObfwGWc7uUr9DKjCI1Db
         vJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717579523; x=1718184323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EoJWhO/kN/nIDMel5oucInBCEkvezehjU4YBYZFp3Zg=;
        b=UAGIfocEsXLB2ybjTwojNG9yNc6rOaEmyVJxH6jdyW97YQnKGInHoZtHW5Zc3Hg2m8
         eigSTwt9RS7ZUWSEibrL+7uaEr4/heMCL1qIFZIfZPMdkTXZrnf+/hEl6uKWHx14tmq7
         GYBqV/iOqkFBAqJM8cnGBVogHxL8/Bevg6m4RMRbG9o0oaaDT+cL5XYtYJUEMNI4UdtJ
         FWdo3mhaJkAW375GxgPcrnbrtBRlZNHXjf+dXgXLlfKaP1+Zz6JZ++HFllMHDepnkoUe
         iVRhcmhwvtqEaqsQgTxnoaCEWgbWb85ydPhguxlXEfCLBcoyXmclogj+UBGc0xkqkbqV
         nHxg==
X-Forwarded-Encrypted: i=1; AJvYcCWTen5WCyyCsv90yRI7cPV52gS2w+0p8Z6MF+ZVAS5VhfdjibVAGx81lwXJNPagMs/0egF902p7RmOC9hNZZY856zFjor9T4kdS8sE9
X-Gm-Message-State: AOJu0Yw7dYalK1FfXREjh5XRNme7FlK66xYTt8Qzr1g/Gg1WnDXpFP4D
	pK8p5BxXgaBV177zaaEfRmUry2xQSstvJg/hGJ+cek0LrpUBgsc6LGRx3X397xinnOBpZ3TVrZW
	J0iTXC+sGzp56TQUZPTuCJvnO3s8cVwPC9YVIuw==
X-Google-Smtp-Source: AGHT+IFiP2ByR690BX/p3xTWlgJRgSVR/t1BSJlG5eKWmT1URJ9DvEySnKdhmO6+OqTKFLDZLb8znMZmfpCG8k6SisY=
X-Received: by 2002:a50:ab56:0:b0:57a:9159:df05 with SMTP id
 4fb4d7f45d1cf-57a9159df5fmr1279266a12.36.1717579522861; Wed, 05 Jun 2024
 02:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605012605.5341-1-21cnbao@gmail.com>
In-Reply-To: <20240605012605.5341-1-21cnbao@gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 5 Jun 2024 14:55:11 +0530
Message-ID: <CAO_48GFq0Cd6rkWidN-=irT4kW9pEOqu_YxY9vd2nRRKcEy-tw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: align fd_flags and heap_flags with dma_heap_allocation_data
To: Barry Song <21cnbao@gmail.com>
Cc: linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, 
	Brian.Starkey@arm.com, benjamin.gaignard@collabora.com, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, jstultz@google.com, 
	linux-kernel@vger.kernel.org, tjmercier@google.com, v-songbaohua@oppo.com, 
	hailong.liu@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Barry,


On Wed, 5 Jun 2024 at 06:56, Barry Song <21cnbao@gmail.com> wrote:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> dma_heap_allocation_data defines the UAPI as follows:
>
>  struct dma_heap_allocation_data {
>         __u64 len;
>         __u32 fd;
>         __u32 fd_flags;
>         __u64 heap_flags;
>  };
>
> However, dma_heap_buffer_alloc() casts both fd_flags and heap_flags
> into unsigned int. We're inconsistent with types in the non UAPI
> arguments. This patch fixes it.

Thank you for your patch; I've pushed it to drm-misc-next.

Best,
Sumit.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Acked-by: John Stultz <jstultz@google.com>
> ---
>  -v2:
>  collect ack of John, thanks!
>  refine commit message;
>
>  drivers/dma-buf/dma-heap.c    | 4 ++--
>  include/uapi/linux/dma-heap.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 84ae708fafe7..2298ca5e112e 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -50,8 +50,8 @@ static struct class *dma_heap_class;
>  static DEFINE_XARRAY_ALLOC(dma_heap_minors);
>
>  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> -                                unsigned int fd_flags,
> -                                unsigned int heap_flags)
> +                                u32 fd_flags,
> +                                u64 heap_flags)
>  {
>         struct dma_buf *dmabuf;
>         int fd;
> diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.=
h
> index 6f84fa08e074..a4cf716a49fa 100644
> --- a/include/uapi/linux/dma-heap.h
> +++ b/include/uapi/linux/dma-heap.h
> @@ -19,7 +19,7 @@
>  #define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
>
>  /* Currently no heap flags */
> -#define DMA_HEAP_VALID_HEAP_FLAGS (0)
> +#define DMA_HEAP_VALID_HEAP_FLAGS (0ULL)
>
>  /**
>   * struct dma_heap_allocation_data - metadata passed from userspace for
> --
> 2.34.1
>


--=20
Thanks and regards,

Sumit Semwal (he / him)
Tech Lead - LCG, Vertical Technologies
Linaro.org =E2=94=82 Open source software for ARM SoCs

