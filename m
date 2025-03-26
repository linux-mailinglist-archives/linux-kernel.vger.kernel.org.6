Return-Path: <linux-kernel+bounces-577067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AC6A717F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12043AC185
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1361EFFBC;
	Wed, 26 Mar 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPEFLLDV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62A5189919
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997579; cv=none; b=h66v0bYZZq4eLaR/rq566w+2JgovfcawvoWA82vfnArhcgZqKNneft3my/DH7IIA2mAPwWSmRuParJ1ZQKzO7Tzl9mHOXGIbUXhaYOt2jTZ3NrRzvPntvIONPHVamPrBPvHvaA+CPW59gzHHZkDs5/ZsbI4tFSxZO1/xjXoRkGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997579; c=relaxed/simple;
	bh=F7lPxs2XY9HKXK5i6zefE89hoDi9pRJmmFXocmfF4ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzO6BIFJBG/g7Rr8kxr7hlNR5kVV1242rjE4qrdNLS5IyUJIdoykLYaDapGDZCueFGREJ+bA1Vg6FnJN8dvS04GIqn6bq/x+O/qMV5a5vkzaJx8sigW48vDYt5cxZ1pUm7b8RP8YODP4jKcuFANmFqslgGNmHn+KEKoPefEwMhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPEFLLDV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cc8bRhEtT8in2D0KI4jdlRnEForc3n5J0jJsbqWmeEE=;
	b=dPEFLLDVM7VMdzcDm0UtL4HC2XY5//QAx8cgroBEUeTTE8WJ9i2uzGnpHW65rH3THeukTu
	FElKux/WVGMZPy7YMEnVI98s+hUPtlJjMJFZfZHSrwOWwde+oRp6LrkMYy5BmZtoPiHe+t
	OkdIUwYko7wOzSQfM9rrhYBNoydfa2Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-nm4lWxz8PFqPdtEKpl1JCg-1; Wed, 26 Mar 2025 09:59:32 -0400
X-MC-Unique: nm4lWxz8PFqPdtEKpl1JCg-1
X-Mimecast-MFC-AGG-ID: nm4lWxz8PFqPdtEKpl1JCg_1742997571
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5d9682f6eso6469010a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997571; x=1743602371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cc8bRhEtT8in2D0KI4jdlRnEForc3n5J0jJsbqWmeEE=;
        b=VYxxrDdc+4E4NdAm00ekBTG342tJAhiV7BZcPXFl5KFhcmil+rlCFDKpBS1a33YFSI
         NMLyxJB2BZhPAur9b477C9WOkPL1bJ0jvRzC1AVglxjAJDkIJT9p9atBlLe93M6YTGJx
         yj9DTeI73wwcyZUkpt4/x3+7EamUrP/cTnRVed9uxlFMOTRaquJ1khyLkhKrDy4ezNM9
         bEgqSXO9RDlJLAUtXgWqlCaR3vZnQXVpO5dB2FHcY3nCtDOBBt7HOk6OpK+URCPar8Nx
         LG3Mnv9mVp30H5gZSxkN7XOvrhy+AYel+OIW7DWRuXg8jGTQvU6e2mDv+iK7wWvuwOs/
         Yl+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUayz5gTx9LWSG/iKnczeFToRSVEFPDcjADvdrlK2kIOvI5MMkXUU9Oml9kJFaD8UXgFnQtYO2rTqiKIYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJQ9yeGPwgMhcjs7qlm9tGt1u9DTZtXv073tQ3PnHMgEqgw95
	s87cpgV+TDrFS9QJSbYtWWFZHugieEzabibm7IBA96+kCNe2xPjmkrxG899NCZuAI7MPWbMbCOX
	rQru8anFyC2H5xiQ0Sj3H2OPvPHwIl4FIUXDuBvpRgZuWvqrMflUGqU+YNiBq6Nomft3xCREP+e
	zj+Q3IFVKhoejxLqRERJ4PNCa1DjdNnRzCtuzF
X-Gm-Gg: ASbGncuz73+bFYL89d/Aj4WnGmNGuKp9B7AyhpRobI11UAIdTGdAtVN1HvTySyQlk7P
	9KkGcqvCAaalkESouZuhgDyp8eh4fqyCyYC0AtFnod/OJbV52aJFo2KCstb1O9NypJIfhGZc=
X-Received: by 2002:a05:6402:510b:b0:5e6:13bf:2c7c with SMTP id 4fb4d7f45d1cf-5ebcd429dccmr19421047a12.9.1742997570578;
        Wed, 26 Mar 2025 06:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtQhnoDSXCdaIb9VxZA1Q+j1d8ajlR55bECEyQZ4aW+jmA9eDNiaAAMGGCVRDU+yYA/Kuf18qRobOYnsVT4LM=
X-Received: by 2002:a05:6402:510b:b0:5e6:13bf:2c7c with SMTP id
 4fb4d7f45d1cf-5ebcd429dccmr19421026a12.9.1742997570138; Wed, 26 Mar 2025
 06:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-2-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 14:58:35 +0100
X-Gm-Features: AQ5f1JpncU-FFKWRIsRDp1aiOhQu7k5rjdTJWx-XjBKEocYsCXNTfaNMxggVo8M
Message-ID: <CAJaqyWf_-us5TergphezFyVLor-uY3DxWMjF3NbP7kknuNWXrw@mail.gmail.com>
Subject: Re: [PATCH 14/19] virtio_ring: determine descriptor flags at one time
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Let's determine the last descriptor by counting the number of sg. This
> would be consistent with packed virtqueue implementation and ease the
> future in-order implementation.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index ce1dc90ee89d..31aa4a935c27 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -561,7 +561,7 @@ static inline int virtqueue_add_split(struct vring_vi=
rtqueue *vq,
>         struct vring_desc_extra *extra;
>         struct scatterlist *sg;
>         struct vring_desc *desc;
> -       unsigned int i, n, avail, descs_used, prev, err_idx;
> +       unsigned int i, n, c, avail, descs_used, err_idx;
>         int head;
>         bool indirect;
>
> @@ -617,46 +617,47 @@ static inline int virtqueue_add_split(struct vring_=
virtqueue *vq,
>                 return -ENOSPC;
>         }
>
> +       c =3D 0;
>         for (n =3D 0; n < out_sgs; n++) {
> +               sg =3D sgs[n];
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
>                         dma_addr_t addr;
>                         u32 len;
> +                       u16 flags =3D 0;
>
>                         if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr=
, &len, premapped))
>                                 goto unmap_release;
>
> -                       prev =3D i;
> +                       if (++c !=3D total_sg)
> +                               flags =3D VRING_DESC_F_NEXT;
> +
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
>                         i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> -                                                    VRING_DESC_F_NEXT,
> +                                                    flags,
>                                                      premapped);
>                 }
>         }
>         for (; n < (out_sgs + in_sgs); n++) {
>                 for (sg =3D sgs[n]; sg; sg =3D sg_next(sg)) {
> +                       u16 flags =3D VRING_DESC_F_WRITE;
>                         dma_addr_t addr;
>                         u32 len;
>
>                         if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &ad=
dr, &len, premapped))
>                                 goto unmap_release;
>
> -                       prev =3D i;
> +                       if (++c !=3D total_sg)
> +                               flags |=3D VRING_DESC_F_NEXT;
> +
>                         /* Note that we trust indirect descriptor
>                          * table since it use stream DMA mapping.
>                          */
>                         i =3D virtqueue_add_desc_split(vq, desc, extra, i=
, addr, len,
> -                                                    VRING_DESC_F_NEXT |
> -                                                    VRING_DESC_F_WRITE,
> -                                                    premapped);
> +                                                    flags, premapped);
>                 }
>         }
> -       /* Last one doesn't continue. */
> -       desc[prev].flags &=3D cpu_to_virtio16(vq->vq.vdev, ~VRING_DESC_F_=
NEXT);
> -       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
> -               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].fl=
ags &=3D
> -                       ~VRING_DESC_F_NEXT;
>
>         if (indirect) {
>                 /* Now that the indirect table is filled in, map it. */
> --
> 2.42.0
>


