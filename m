Return-Path: <linux-kernel+bounces-259511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BFF939771
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 02:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41CD1C219A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BCED52F;
	Tue, 23 Jul 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxtnSO5y"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDB3BA40
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721694160; cv=none; b=Dxf1wkRAqvWK/uz/RC9pKWIjIbMFABzABNg5e5IK5IaiYSoJTwjp/7KEKH1BdlFENshZ7vu2AGCb/XSxPqizRpkjO7J0cx2tLLdGSeBpIw7TfGVJkNokJU0+ZVK83jZGodl2dL/CEapXKJEzGt9LApz0sXH83R5wVjWZQVjc61w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721694160; c=relaxed/simple;
	bh=BQAsstNaY98LpugMIXbs/w69p6OSEb14pikfDJtB/mI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F9KZiGGvtVCbtUIfamsHN1ucq76SB+P9Lg5lLtopLgKTQT6apl6P59d8KafL3yjsJpig+6q+fHNuTTmRBt8ruo2et4Zx4n+G938E/bVwNW6cS70fTKDL0+pyKIbelefIGUxYB8rB2LVLtZ9mijttpb9IXE2n1wQ7Vid4f/B/McY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxtnSO5y; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7a91cdcc78so4995766b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721694157; x=1722298957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IDnbLkQQtMQ6kQyTxGOcLjUBXyXI0SK/keZnMNe+rY=;
        b=UxtnSO5yl1mh98lJtr4k7TYxm+VvxNtyrVbuUr1wdxEacSg8G85YwfDtHPp9VeWNie
         VzpMKNHe7qcAxXXafCfdWRayY3O9bvQj5O+jlmK2Z/i2bhX75jm9VwBcZ8fLtrYo7ZGO
         4c1pQcGFrQHvuBh+kCs1umExXRydr7gjAuqCE5HjJURAY2OKxliTpe5DRj399wE9wOaC
         CzWYEs0cvPLU4WKhxuQ8Ao5nXiJPPG1kb2D4vhMB8hW92oJKnlptqqyEF4mv/hpa6ve7
         zKDM6HKq8uycQ3R39rsl+MddGxCzoNDCaBMl0OzyHYDZ5bUbh84hBQWHqU+ptiObLPEH
         c80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721694157; x=1722298957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IDnbLkQQtMQ6kQyTxGOcLjUBXyXI0SK/keZnMNe+rY=;
        b=m8JlgmrRDNdNwt/76UctW2G/KZleOBDtbVC3jxRNvhFvmJzrWldjyH219lRnpWMxRx
         swrIf/2bxcZ+7OJybzH+3jVuRCgMEgWYmNbwMmZb2IqrZ+5kmaLT6lYIo3oOB8TOFmuC
         KCIs6pI2rNMU128F+v3a2o0Tj27qJaMaL0XE5EhYlJHF7N3mZ8xC8QQhwQTHbypWtJSh
         2zKmCmgAY+azHU3gWowxvg/X3zphcctRnYPUEfpvAPP3hlLRzSZRg2QYCjDhdeIn1rmR
         NEnhdfi5lt5tNSUJBNGlt0GUBK9ZBE118znfIUmRjDgdeejwSbg6oKauIpg2nuqGEF18
         vgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGMiYos0jKlhEBGwHYVmdFksCQ/ju2ejWodcMog+89NBg+n9eRm1o9ZQgy9IzyqELNFMAl0AotCX2ZRhiuc0DU/hLGVUjnKAsyXBv0
X-Gm-Message-State: AOJu0YzlPbAegcC/E01WbQyOmMujyA4F1tpcooBEQAPmoEAoaBj0f8La
	HG6ej3rDyExq/oD5qyrNMktvnfwlen0ebP1hLI/tTyKB/V8wDupRRo9bNJRep868yhUDIkLCzP0
	9LqHRvschv55bCV8B9U8DqZZdUnc=
X-Google-Smtp-Source: AGHT+IHRrV30Umrj2invF+QgSSaiARUTcgai0f2Y+fcs8EmS40cP4uj1AShQIHt7CW3NCZhxGUnRtzIoM7WD9qX3i4I=
X-Received: by 2002:a05:6402:3553:b0:5a0:d004:60c6 with SMTP id
 4fb4d7f45d1cf-5a479b6fdd6mr6010217a12.18.1721694156778; Mon, 22 Jul 2024
 17:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714205502.3409718-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20240714205502.3409718-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 22 Jul 2024 17:22:24 -0700
Message-ID: <CAF6AEGtcfUUBwYy29y2_mZ=Ej_hTRyY-9w5ApEJKkUumeNuZ7g@mail.gmail.com>
Subject: Re: [PATCH v1] drm/virtio: Add DRM capset definition
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 1:55=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Define DRM native context capset in the VirtIO-GPU protocol header.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  include/uapi/linux/virtio_gpu.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_=
gpu.h
> index 0e21f3998108..bf2c9cabd207 100644
> --- a/include/uapi/linux/virtio_gpu.h
> +++ b/include/uapi/linux/virtio_gpu.h
> @@ -311,6 +311,7 @@ struct virtio_gpu_cmd_submit {
>  #define VIRTIO_GPU_CAPSET_VIRGL2 2
>  /* 3 is reserved for gfxstream */
>  #define VIRTIO_GPU_CAPSET_VENUS 4
> +#define VIRTIO_GPU_CAPSET_DRM 6
>
>  /* VIRTIO_GPU_CMD_GET_CAPSET_INFO */
>  struct virtio_gpu_get_capset_info {
> --
> 2.45.2
>

