Return-Path: <linux-kernel+bounces-186616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A18CC65E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950D41C212A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B270145FF6;
	Wed, 22 May 2024 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAQURosu"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055C1419BC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402833; cv=none; b=Sc6wrEekWVyUh8TzIiK2w7treFL98KSPVuKHBR1y+Fiwv/mlsrg8balFiFMlkh5MchyAMWVL6kGm93c7eTc3JqatwCEleBlIGyFgSnt5jO8ck8zj1dNefRSCxLlJMaEDcq7eClg5aqR101aEg6bacTQhVImTIKhLkgeFFNk6fGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402833; c=relaxed/simple;
	bh=jnEBtkTj6abvY8mxMmaxe+8NYxHaAdanWXFKxYwaKy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erXTkGFqpKqTZ5AUjVEBPiP6RP1feyECo4USzZl2CTXffMOWZtIielZr85ZsrzqP/FyqfPWZyG86QIvLzbbhdKUtbJmBcg9HElI2sLwoH0Zzkj+mPq1gTgOboKIhG9kpVc7CP9sedHbu6B8Y0EAKQ0q4D+iciNbCwN9zXB5Xcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAQURosu; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed0710c74so4407558276.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716402831; x=1717007631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EbhQWdOoh78Q/g/fDhY/dpoBbFrko5oWqLo7rk8/U0=;
        b=iAQURosuJKIEGwWLqugJ/0GW5yZsg9VxKsQhWA7Qqc6+rFSFLDbtWEo8q7xiItLTJM
         XUHgmeYz5TJu4SvfIMhmil5K8APXmbv6Rps1zGMTLMOsG/rf9VYotCuZPF3k8+Pop2o3
         DTQDy6bJRzBV/QGKkGpkGmnRjO4Aki0E+bVL/JyRPPzDtmfXWphXnw0Fvxe/mWXPps+S
         GT9mYrB/cg9cGeEpXs4GZEmttMMczSg4edIYQz8ES6x44RG7+tRLgJRfl1yxr/O7DwkJ
         vu3pRO5r8vyT7rEzFqfcS7iIQG0KyaAsCc13F4T8rbsgiihS0qzuGHxerq7/BYNUSD5E
         yp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716402831; x=1717007631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EbhQWdOoh78Q/g/fDhY/dpoBbFrko5oWqLo7rk8/U0=;
        b=EdUohfE9xRtgcCnFKEpSIjf2Asl4ycy6xt0fWFNjObOMJ6AANd5Q4uGTzaB2GGgKNH
         Amztn9V2GkmqHApYqwA2VIVnaBEoZk14RIRJ8P3/Ok6TMoN3Sb7M1i1RXHf3g8Ljc9W9
         g4UKB+8FllNjNXQ+B9BuPmxux/Q/+m6wdj8nq4gJPUUqeihXUHFT3T/+8w06+N0Iu1wO
         xos4N68mM7RG2kWtzIETo8L2qvvVKNeqbvonc52qsoF7ZjRE/1UeSvwj4g5JOrdvnQb3
         23nUvHHKY6TUZWUHIf9fQO48TVECjAfyTgjLIGJLCgGTki3n1VRRxdS4p4EocUdlb3RK
         JE1g==
X-Forwarded-Encrypted: i=1; AJvYcCV+lMI46Y+rhzYR4dYWVjX4A76Du+tvlOCU0m7jFTZP5+F5MQiia29zFd/eXVbAgRmz8uTUMD2QeTayZ+2g56OU2mbF7I5Z+IoUe1c4
X-Gm-Message-State: AOJu0YwiIHV0PrfcCEKiyc7Om16eKBqoTbCVtdqwtQ7ke8r/715fIvjx
	19b2wmKeMBVd/y3jlor8HPWMH8zqk/Ooddvo8fsW6WmG6zDOS1h/TdgZfy0KNslbpiusx5p2tDr
	2hPbnFBA1bNG35SiQeBJDKXgbu4BOu5vYa0S9
X-Google-Smtp-Source: AGHT+IGN47Nmo4f4RGiZUu/PPp/jTEE3uqbIMeUgnJAorz3ApRFTFuY2uRHKB4JKQhH3PzXLlW1bM1uS2dJXihd38dY=
X-Received: by 2002:a25:a2c4:0:b0:de5:51a1:d47a with SMTP id
 3f1490d57ef6-df4e0c1d0dbmr2686142276.28.1716402830630; Wed, 22 May 2024
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522181308.841686-1-pchelkin@ispras.ru>
In-Reply-To: <20240522181308.841686-1-pchelkin@ispras.ru>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 22 May 2024 11:33:38 -0700
Message-ID: <CABdmKX2qdT0HvkX0B6kcxALwxZsLFOtgPsOP_rY0AXM1eAtAtA@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: handle testing kthreads creation failure
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Chris Wilson <chris@chris-wilson.co.uk>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:14=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru=
> wrote:
>
> kthread creation may possibly fail inside race_signal_callback(). In
> such a case stop the already started threads, put the already taken
> references to them and return with error code.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 2989f6451084 ("dma-buf: Add selftests for dma-fence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
> ---
> v2: use kthread_stop_put() to actually put the last reference as
>     T.J. Mercier noticed;
>     link to v1: https://lore.kernel.org/lkml/20240522122326.696928-1-pche=
lkin@ispras.ru/
>
>  drivers/dma-buf/st-dma-fence.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fenc=
e.c
> index b7c6f7ea9e0c..6a1bfcd0cc21 100644
> --- a/drivers/dma-buf/st-dma-fence.c
> +++ b/drivers/dma-buf/st-dma-fence.c
> @@ -540,6 +540,12 @@ static int race_signal_callback(void *arg)
>                         t[i].before =3D pass;
>                         t[i].task =3D kthread_run(thread_signal_callback,=
 &t[i],
>                                                 "dma-fence:%d", i);
> +                       if (IS_ERR(t[i].task)) {
> +                               ret =3D PTR_ERR(t[i].task);
> +                               while (--i >=3D 0)
> +                                       kthread_stop_put(t[i].task);
> +                               return ret;
> +                       }
>                         get_task_struct(t[i].task);
>                 }
>
> --
> 2.39.2
>

