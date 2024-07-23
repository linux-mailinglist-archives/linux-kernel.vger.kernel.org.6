Return-Path: <linux-kernel+bounces-259510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B089193976D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2AA61C219BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB460D2FE;
	Tue, 23 Jul 2024 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPaM2lW7"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2332BE4D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694115; cv=none; b=nDrhj8eOGZ+jSQsp0ZjlNhQ80THOhXaR9gmnrw9jW6D+AAAx3oJswZzl/pGQvz/tAzwzwcv0vcl5/8uC5UMlZUCs7v0YzUGND9hKYsj0NyiLRsHc4V9Hr43U2vmd//HwnDIHqAzpAgGwHqX2SU1iylypjyBCbUxBd9y+88zt1KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694115; c=relaxed/simple;
	bh=cqHdQlPpoKbKPcgf6ZB7Gm59b4GbsA84cAxgPk4M/fA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EF5zdVIjLBwiOAlclF7aWbWsuwkKGaY12eYgIl2dEUgIa3QG25biLjjwu43rKdJwX+FziohdOlbDpwZLRdFl18Nq/HmwWVQwI+StzLwLXYTrrTl8q/CbyxjUwRr6SENnkjlLWoEOz64HEdNSuC4mXTEd3ZGU/zNKlUzWtw++gzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPaM2lW7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1fcb611d9so4031220a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721694112; x=1722298912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxdDwCRz7ozxZHtp57qu+Ykoq2klaLRa7AGSsUAt4yM=;
        b=WPaM2lW7kCspB9zQVWeJkGNVDjMXU+vOsEPRECL6iwLXcV58+8/rZYs5WxatIOTCvS
         vfeOCbuHaWNdHtcfQQ1bJKZrHThZUgDp+FopxQK483YzNJO+2w93WMLUWlxTYNBXZjYx
         Er6HhGlZU0G0CI+2Q0ievh+xjfgYlpIilHYs9OSLkGXoweOMkY8bSbcxcrL0kFJyeJU9
         R4K/GwQJTMJQW6XqFoSMxB7C4JQdow1TdwiJRusQfdnC5epGkiY2l3YNuHm+r/S+Km6m
         gzMDZPwlu/ztVzC4MA3XXNdYRJToySBS7WbF/277SYQiz1l9RMwBZ2lYMbpnsCqydr+8
         EHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721694112; x=1722298912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxdDwCRz7ozxZHtp57qu+Ykoq2klaLRa7AGSsUAt4yM=;
        b=WWhJSF+/b/LrU5HyWhcKP3hDDzvDTqleqrfILlEc7HEq0O+A4mgPsLzBywKX0ncJWQ
         2Zc42VP+UXpCk044tId73GP0ei4NUDZiz+wv8p3qBtJgk1FQem+QFDOrNdFQySfu3Onw
         RSI0hmmcAEPmbY8XsJ5am7a8XjyQZHG98LTgZNaXQ2EFBFSs/u+/EhnpAgFKecU4OkRp
         myjWfPywwuOPnpwtsSgEzKucHYftx5hEKQwVu+25VWu9bXOtSU8GaN/8aDQVj5h6UmgY
         xCSClmu3dfj4vC/085fSnWCcQUt2VtKNB8f3t61/JSPJjfo9isFJ87L/Vw3/c7ELb6iD
         VLYg==
X-Forwarded-Encrypted: i=1; AJvYcCWpzH0fXNaHxRFqcFd3I9xdV/j6p6+mAPLT5liXuW7xX82+GJEccyzbCKxZP9nmBtBJwRqq0aMNQIy++JnnXuRZ9F7dIgHwadw/GBbx
X-Gm-Message-State: AOJu0Yw2Ox0+LzTDCWZMdNV5fj9EITTnQB8QlvKV1II0xUpdBda+E9EU
	0APaAlP+9Hwf6vOn+Ts2yc8z0fVkqjFniQzGozYcPbDnkU8CDFWUb4YvH2u1Hr1Ri6aWf/MB+Ky
	Lgcam0v/sPnoO5pUAgd6kX/D2lTA=
X-Google-Smtp-Source: AGHT+IEZvdBDCMwaoXYKZpcMa7a8A6QNTz7LHwDIsJw9zi/h7TsyJ/jr09fN3E4nOwt5sRiLXagUkoZieuL/S32CgrU=
X-Received: by 2002:a50:a6ce:0:b0:5a1:bda1:3e23 with SMTP id
 4fb4d7f45d1cf-5a477e833e7mr5028885a12.14.1721694111704; Mon, 22 Jul 2024
 17:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714205009.3408298-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20240714205009.3408298-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 22 Jul 2024 17:21:39 -0700
Message-ID: <CAF6AEGutuf_B7fHH-SzBSWC0=tUbCk2MtRo7qWbvGCrqMVTLYg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/virtio: Fix type of dma-fence context variable
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 1:50=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Type of DMA fence context is u64. Fence-waiting code uses u32 for the
> context variable, fix it.
>
> Fixes: e4812ab8e6b1 ("drm/virtio: Refactor and optimize job submission co=
de path")
> Cc: <stable@vger.kernel.org> # v6.4+
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/virtio/virtgpu_submit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/vi=
rtio/virtgpu_submit.c
> index 1c7c7f61a222..7d34cf83f5f2 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_submit.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
> @@ -48,7 +48,7 @@ struct virtio_gpu_submit {
>  static int virtio_gpu_do_fence_wait(struct virtio_gpu_submit *submit,
>                                     struct dma_fence *in_fence)
>  {
> -       u32 context =3D submit->fence_ctx + submit->ring_idx;
> +       u64 context =3D submit->fence_ctx + submit->ring_idx;
>
>         if (dma_fence_match_context(in_fence, context))
>                 return 0;
> --
> 2.45.2
>

