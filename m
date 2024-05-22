Return-Path: <linux-kernel+bounces-186566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7D8CC5BC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9AA285BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95EE5142E9C;
	Wed, 22 May 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Va+DFblz"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27E1422DA
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399654; cv=none; b=iUlGwbBF8bvanj7eIv8doMbC2+Os8OJ3lYFa6Px+YMzEaiHCHYkIgQ8lWtOVIKTqT0KQ5BOOApcJQ20bToyhcvTgDZZ/1AaMrpc2lR1qyj7d+3Wu3i9b1Vx0hYuvBGjT5waGfr8kQ+B4asxAhy4NLUiNuvWmbbBTwvds8Ivjsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399654; c=relaxed/simple;
	bh=9Sf2fhKuvu8tkTp39Symjm4BKM51pxxuc1V5R+6KeU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=On2kJ3yE4xeNqvQ2hr0cSH6br8RkhVwen5l4Emoq1foatihFofC5LFJftiaAwlndmC7AmeD2b9o9ydz8YwN2swXMo+qipVzjp7TlG/WCwVFee7uqVVEFVDLg5MCEg7XxU0lHw8Ny4aBXFOlhxGJ3b4OOw6tqFkYHDO6e9LF2o84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Va+DFblz; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de607ab52f4so5248340276.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716399652; x=1717004452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+KExuXY6x2RNXAGihFUdQFtzxyzRd1UAydMgLYyZeM=;
        b=Va+DFblzR94AUco0PnOXQeIFm052mEU6OAf0V6XRaBsIhEp7Apsmt3WCtZi3hkyoSz
         CBvSGAU4iL2P/Raf4ex7hjqEz0/nf+4gzlI3WIRZ2REfbGsZ+Akc/pPK4DxJOQH+77pe
         iUeFdronwjetQ3leoyFqrH76tJBP51RjNcmZZ5lx77EFli2PBcGgAVWX7NTe2CLcoJeN
         oMVM2OJ9eAB4Utv7eH7YO2GCWx0fxW8wi9idWOjvpQYHJgOAGVo60aeUrxtBE87wtCFF
         v9edRbQLiAluaRL+8RdKE5rBUQw4uuqTF+p1dcxsZST/OeYJKLvZ2kA0HmrTQ6SHxo8U
         wkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399652; x=1717004452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+KExuXY6x2RNXAGihFUdQFtzxyzRd1UAydMgLYyZeM=;
        b=bece/S+EVR2KRyiq0bK7DGp+kA2FjMFGCjCdUQr4hOnsG4TCl5v/Vtbm898Dy2hn5P
         yM4bBqMMSwISTLjzjYebsPLpkmGhUjbi2UECWDdv9zc3l81Z6ZEtTkCFBzAKIOG7VWqD
         CR1Oz+gEccK2HkA7aHB8j5l6riCPCzDTApFnuah1BnMIRte5C9fqq0kJXUjyS51sfcfO
         XOcvw/nJbixVqDVsZ4Dt2JD/OcXbnl0RvpfpVPj3j8sUG5xqsTGBd/m1Z+DK4DVcxHi8
         phDaWRqSXk9H9ePA3NZASPRIObheosbH7WQP0WTLdBtMvCn1jz8EeYwQeRH2RUYIqHdW
         PJoA==
X-Forwarded-Encrypted: i=1; AJvYcCUxp9Wq74gHNlFfcH4HS+KBdWoIX4HhzGfEZ3PYesu3OtPwPMIZ6UzpuqKuhy0GmKGBFhc8YssLJDqxk0gvXgL9ffpfKOcdTZFGSGkE
X-Gm-Message-State: AOJu0YxYJtQMwTrw4Lo4olNUiuG3yymPTXU9q3juBQJjjW8fByWxZRjG
	lkMq9tuyClUUk8WWbDTK3xG/BT5TEK69d+WeFTwc/XU/e7xMgzhN62q7QtZULH71hnya89YRNfO
	K6xYXn4mdukoM8eNjAXygR65c63OdUH6VgZ0Z
X-Google-Smtp-Source: AGHT+IFEar4omGEdEg7p1pIeJHpqJdxEZysSMoFwL4CvUt49f3bponvnO1J/Gp3qNrH1hFjfFb/lUdHwXQMMQUkAlvw=
X-Received: by 2002:a25:e08c:0:b0:de4:5d85:6928 with SMTP id
 3f1490d57ef6-df4e0bc6db1mr3041714276.31.1716399651838; Wed, 22 May 2024
 10:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522122326.696928-1-pchelkin@ispras.ru>
In-Reply-To: <20240522122326.696928-1-pchelkin@ispras.ru>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 22 May 2024 10:40:39 -0700
Message-ID: <CABdmKX2tb_Vn8sF_hXVOMZ7HV9cU9KMwu_WyKrJuoeNjWF85bQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: handle testing kthreads creation failure
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Chris Wilson <chris@chris-wilson.co.uk>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 5:24=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> kthread creation may possibly fail inside race_signal_callback(). In
> such case stop the already started threads and return with error code.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 2989f6451084 ("dma-buf: Add selftests for dma-fence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/dma-buf/st-dma-fence.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fenc=
e.c
> index b7c6f7ea9e0c..ab1ec4631578 100644
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
> +                                       kthread_stop(t[i].task);

This looks like it needs to be kthread_stop_put since get_task_struct
was called for previous successful kthread_run calls.

> +                               return ret;
> +                       }
>                         get_task_struct(t[i].task);
>                 }
>
> --
> 2.39.2
>

