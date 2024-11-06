Return-Path: <linux-kernel+bounces-399054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 264099BFA45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 00:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9AC283394
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 23:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46836201029;
	Wed,  6 Nov 2024 23:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T+YlYY5N"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD02022C1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936510; cv=none; b=ddIJWslJvHbQ4cIfcHUZyJujLh4xGNleebaZCsekWuyWbYgLvfd4cruEdKNWCFl4USi9AbTiWCr/i6Zednd9uOeZfIA9AZABblFlNy3OQc5JRz2gmLpEWKNwUyWrS+5Yr5NxcnTqmbXp9fzfLNx2/4F0xO6L6+8oB2oeEuwyIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936510; c=relaxed/simple;
	bh=Jb8BAyvd4oz2mGslbPXUUxqw+BIR393RplBHuFXMRjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUATxtYbaIka5wi7Ktwjv/MBb84nP4/5DIG/ZyhTuEfCa9kprXT54xejfnKMQwNnruEN9ta7Ad3WYH7fb2Ho7hkSlHUkV8Klc/nzK+pJbN33mT7LuESl64qMZ9OFozIr4YJ7n+owHDWxuX0r+gvMaoZxq0SIvD/+K9LNVy95v1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T+YlYY5N; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cf6eea3c0so4316975ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730936508; x=1731541308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUIxV8/idxeTiaY7TjZoSjaAKD90iyIZAKQ4e5QblXw=;
        b=T+YlYY5NE2V/hojWGZ7lXS3Uw3UgGZPq3svoUVwCGJlyL++Pq+VugY0IYuCY2//UNx
         6BZBW7Ktj0LUtTjtxogy3Nk0PYt5LiswrRnJO6uxH3j/jg1TbBlObv1N9AU3/J1I4C0+
         IuyuaBjZ3vS36UhGCcszCSmV08mHYfPgBh7Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730936508; x=1731541308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gUIxV8/idxeTiaY7TjZoSjaAKD90iyIZAKQ4e5QblXw=;
        b=luLxaUenOdvmXTS5qoI9GxEyGLQwnuHXJXz24WhSYWMcRl5mh/uY5/RDByfjcnph30
         ZpGEZOF0DKsfm6DfpG0heocrLg1jT7GqcQUIix+1Q1ARPjTDq0mUU4jwUvvt+op8jt52
         G4VDYykhNA/gcy+FCE46XMJJUYsAM0GFQKs4Vrrl2t1bfkJLJhun2T/8sFdIBTuBwBb4
         TSGJ8xuL0W75895U+G9qNcPJqFfh0G1k+kk4jkdeFb0WSK8vOLD0Rrl3BQp14MRX6Fle
         6yDSfOgmJqZITvlDiC/I+af/3S7DEGkVCiqDrDxfIfqCLh1JFY3HA+ieNovQVc45Humc
         M6kg==
X-Forwarded-Encrypted: i=1; AJvYcCWO3ewX0X6nc8BPA8NSRMd3+/sV+EjlYB838Rbpcy6c4F+UowvkjL+4QggDeK1xBCKdypyKmkA5ANajDco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/uZ9xP+/4IbAk8Fe2f2qJgLnr73QCLfuo00VRr+DpvHonWLj
	3OlysmI+shyivMdhsx1yne9V1yL7hVBBK7DfkW+2Faxrmno69TWpxybCdUQIorUl4ndmBP65W3y
	RCw==
X-Google-Smtp-Source: AGHT+IGWrdVv6ZfvLD9dcMS5x50vLXEhirIq8101xr4d9KlwmfZFSpkLi7wS+MPdPfwCJoWiZpqs9g==
X-Received: by 2002:a17:902:ced2:b0:211:6b31:2f30 with SMTP id d9443c01a7336-2116b312f92mr63696025ad.50.1730936508087;
        Wed, 06 Nov 2024 15:41:48 -0800 (PST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com. [209.85.214.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a4f6cb9sm2217367a91.9.2024.11.06.15.41.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 15:41:46 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c8ac50b79so53905ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 15:41:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7XRPAVo/tFsvwa9yQaUTvEdl9iGsAMVM78ufcO8aVR3uELYdivM2bJ+DfVVueMj9JfEBAanPMT7yBpDY=@vger.kernel.org
X-Received: by 2002:a17:903:2285:b0:1f7:34e4:ebc1 with SMTP id
 d9443c01a7336-211748fa9f8mr1764415ad.5.1730936505431; Wed, 06 Nov 2024
 15:41:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106121802.2939237-1-tudor.ambarus@linaro.org>
In-Reply-To: <20241106121802.2939237-1-tudor.ambarus@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 7 Nov 2024 08:41:24 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B51wa1dD3FzHKxsg4VaA_bHzUrFGmA19q8jUybsMuS0Q@mail.gmail.com>
Message-ID: <CAAFQd5B51wa1dD3FzHKxsg4VaA_bHzUrFGmA19q8jUybsMuS0Q@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2-core: copy vb planes unconditionally
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: m.szyprowski@samsung.com, mchehab@kernel.org, yunkec@chromium.org, 
	hverkuil@xs4all.nl, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, andre.draszik@linaro.org, 
	kernel-team@android.com, willmcvicker@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 9:18=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro.=
org> wrote:
>
> Copy the relevant data from userspace to the vb->planes unconditionally
> as it's possible some of the fields may have changed after the buffer
> has been validated.
>
> Keep the dma_buf_put(planes[plane].dbuf) calls in the first
> `if (!reacquired)` case, in order to be close to the plane validation cod=
e
> where the buffers were got in the first place.
>
> Cc: stable@vger.kernel.org
> Fixes: 95af7c00f35b ("media: videobuf2-core: release all planes first in =
__prepare_dmabuf()")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 28 ++++++++++---------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>

Thanks for the fix.

Acked-by: Tomasz Figa <tfiga@chromium.org>

(We probably need some tests to verify this behavior... It seems like
the way v4l2-compliance is implemented [1] would only trigger the
!reacquired case on most drivers.)

[1] https://git.linuxtv.org/v4l-utils.git/tree/utils/v4l2-compliance/v4l2-t=
est-buffers.cpp#n2071
(just queuing all imported buffers in order and re-queuing them
exactly as they are dequeued [2])
[2] https://git.linuxtv.org/v4l-utils.git/tree/utils/v4l2-compliance/v4l2-t=
est-buffers.cpp#n1299

Best regards,
Tomasz

> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/me=
dia/common/videobuf2/videobuf2-core.c
> index f07dc53a9d06..c0cc441b5164 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -1482,18 +1482,23 @@ static int __prepare_dmabuf(struct vb2_buffer *vb=
)
>                         }
>                         vb->planes[plane].dbuf_mapped =3D 1;
>                 }
> +       } else {
> +               for (plane =3D 0; plane < vb->num_planes; ++plane)
> +                       dma_buf_put(planes[plane].dbuf);
> +       }
>
> -               /*
> -                * Now that everything is in order, copy relevant informa=
tion
> -                * provided by userspace.
> -                */
> -               for (plane =3D 0; plane < vb->num_planes; ++plane) {
> -                       vb->planes[plane].bytesused =3D planes[plane].byt=
esused;
> -                       vb->planes[plane].length =3D planes[plane].length=
;
> -                       vb->planes[plane].m.fd =3D planes[plane].m.fd;
> -                       vb->planes[plane].data_offset =3D planes[plane].d=
ata_offset;
> -               }
> +       /*
> +        * Now that everything is in order, copy relevant information
> +        * provided by userspace.
> +        */
> +       for (plane =3D 0; plane < vb->num_planes; ++plane) {
> +               vb->planes[plane].bytesused =3D planes[plane].bytesused;
> +               vb->planes[plane].length =3D planes[plane].length;
> +               vb->planes[plane].m.fd =3D planes[plane].m.fd;
> +               vb->planes[plane].data_offset =3D planes[plane].data_offs=
et;
> +       }
>
> +       if (reacquired) {
>                 /*
>                  * Call driver-specific initialization on the newly acqui=
red buffer,
>                  * if provided.
> @@ -1503,9 +1508,6 @@ static int __prepare_dmabuf(struct vb2_buffer *vb)
>                         dprintk(q, 1, "buffer initialization failed\n");
>                         goto err_put_vb2_buf;
>                 }
> -       } else {
> -               for (plane =3D 0; plane < vb->num_planes; ++plane)
> -                       dma_buf_put(planes[plane].dbuf);
>         }
>
>         ret =3D call_vb_qop(vb, buf_prepare, vb);
> --
> 2.47.0.199.ga7371fff76-goog
>

