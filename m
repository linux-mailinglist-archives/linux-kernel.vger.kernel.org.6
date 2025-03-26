Return-Path: <linux-kernel+bounces-577075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7EA7180B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01DD189D5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A58E1EEA59;
	Wed, 26 Mar 2025 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BD1umF9I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBC2187876
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997780; cv=none; b=rRwTocMxg7fEMNRfmOshLbYDLuzLrURCfnN55hKSG8eGMi04uNaXJ4nvBxzZHj+MGoUU3CRe41L3JXsKJDWY3yP0vmu8uC/LaO8oywil6JHkooWmAh1tGdbJJgnbdA1oYYwU2wrwXfF4TEDGuMgJ7OmQzG3v76bz/SgzpRtvHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997780; c=relaxed/simple;
	bh=3qzzuciwFiHhgnR+NjBWc+rKPxYkw4M3p/jQtmvaWSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIhFsqMXSI0Uu6vGMzzZ1XN8gr2NcRQg1ZHFImfvKwOFn2tu5HJbrquPGwoJg0pYoPYLGtyi1BerXkivDR5mZ+qc+NXX1vu32yhCz0OXDOD59eKBAwXdI15QZWRHYEzw0g6+0QRW3f7dtMZvltBysOWY94CGvzU4N+yax3f2jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BD1umF9I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HnbLFSfaVr4Q22ZcBNrQlalkQrGvDzjjby77ROH2VlI=;
	b=BD1umF9IhPAlJbzO6HQbW1L+vc5rKr/ildrsgpWBDT7ak0XBZSSR31qD+RW1eM7/hLFVz1
	N/tJmixkItiOdELcNbNWEBYwTXEa+4fbxYoIiD6eCTerzVjl7J2Iy5gjAFKmSOfjyZh6u7
	09RN+5WUJ4y1K0Pq9Y0oVRGCJC8HF3Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-EBUzElzfNWqRNprZcCavIA-1; Wed, 26 Mar 2025 10:02:55 -0400
X-MC-Unique: EBUzElzfNWqRNprZcCavIA-1
X-Mimecast-MFC-AGG-ID: EBUzElzfNWqRNprZcCavIA_1742997775
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so5650769a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997775; x=1743602575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnbLFSfaVr4Q22ZcBNrQlalkQrGvDzjjby77ROH2VlI=;
        b=qGqlPZ4WZeV4MN/xdhPfS01AVa3xyIeKXxyxUzxu8tpu6D9ck7ML7x4JXwyv2ahz0G
         esg1vqS2m8w3iNrM1ICxgpoTfVw0cjUJu1ycvFLzZXkd1v/lp/Nr2mOwbWYOe6m/VQIY
         Ly1alI6Uzmp0qiVhvvOoCULcHg2+z6wafkkF7jsO814rKhO8gWo/kEyEAgTzv4dbKU6F
         j4PRW6zvgAhT2hkX+7G930AzdgditjKnv+y9Avott7GW9nCfutGuxZ/RZHb024/CZzQ6
         BKQFibPqqj8UQcPhN1OxwsBWCSdQGsm2rn2ANwgzv1d7gh64B3ii6kr7STQHMzFPO55P
         QOMA==
X-Forwarded-Encrypted: i=1; AJvYcCVY2Qz19AFyWHQjvn1lNQyWm868gphoAtgJXgJhOaMdXeQVD2fRbjSL7aQW0tcCwyW4Q1NAASU0qVJ4Y7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhs4I4xxZKxwB9aSdvpBN57ZDUT3o7OTRwcHNu7RINfk03vlA2
	YKJxbAMJoEUc1U+PPTPgffct5/LS7e5MHbuQ/67rOXHPZv7Fas0e8F0zYats4071cy4SAAjnGX/
	JRIYJZlGNHTt8C3hcpo4njkrFx9QrqWqm3kFhWvyIWcHwvR0Oxc6okE1uWreElFNLo0UC+Fvfrv
	2YRzqY8cIRT3GogpCXxvlBLuaw0jgKhgMrB7Ag
X-Gm-Gg: ASbGncusT+3KBvWCco5wTOgzJnJbh3KWJyo8RNNj7yZ/q5b9nds1rzlfkpioybqG83l
	cZm0ifW/HKNBH/2m/SgH+NXlpm+A+7SFRTK+9dtwRcyyzeLVOYcz5o0RJXumk3dSxalsI2ZQ=
X-Received: by 2002:a05:6402:50ce:b0:5ed:6192:3759 with SMTP id 4fb4d7f45d1cf-5ed61923892mr795741a12.0.1742997772929;
        Wed, 26 Mar 2025 07:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNz4NecBFhHtJh14xuH66vPEkf/EqjvhB0U+5xZoM1iUladqkUX08Zn44oe38tBlmrzjNvm4QWreip61547JM=
X-Received: by 2002:a05:6402:50ce:b0:5ed:6192:3759 with SMTP id
 4fb4d7f45d1cf-5ed61923892mr795482a12.0.1742997770904; Wed, 26 Mar 2025
 07:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-6-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-6-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 15:02:12 +0100
X-Gm-Features: AQ5f1JrzMmqRzjZ2QP_VVFzie1zTkK-Q3AUK4a9ZoX6-xBZKdIqB5CZikFJJcDk
Message-ID: <CAJaqyWeDOjsJ1wv7PvXt86JztEVMuwKSR1-g9NS35DUbopK8ag@mail.gmail.com>
Subject: Re: [PATCH 18/19] virtio_ring: factor out split indirect detaching logic
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:02=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Factor out the split indirect descriptor detaching logic in order to
> make it be reused by the in order support.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++----------------
>  1 file changed, 35 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a1a8cd931052..0fad8e8419c8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -765,11 +765,42 @@ static bool virtqueue_kick_prepare_split(struct vri=
ng_virtqueue *vq)
>         return needs_kick;
>  }
>
> +static void detach_indirect_split(struct vring_virtqueue *vq,
> +                                 unsigned int head)
> +{
> +       struct vring_desc_extra *extra =3D vq->split.desc_extra;
> +       struct vring_desc *indir_desc =3D
> +              vq->split.desc_state[head].indir_desc;
> +       unsigned int j;
> +       u32 len, num;
> +
> +       /* Free the indirect table, if any, now that it's unmapped. */
> +       if (!indir_desc)
> +               return;
> +       len =3D vq->split.desc_extra[head].len;
> +
> +       BUG_ON(!(vq->split.desc_extra[head].flags &
> +                       VRING_DESC_F_INDIRECT));
> +       BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
> +
> +       num =3D len / sizeof(struct vring_desc);
> +
> +       extra =3D (struct vring_desc_extra *)&indir_desc[num];
> +
> +       if (vq->use_dma_api) {
> +               for (j =3D 0; j < num; j++)
> +                       vring_unmap_one_split(vq, &extra[j]);
> +       }
> +
> +       kfree(indir_desc);
> +       vq->split.desc_state[head].indir_desc =3D NULL;
> +}
> +
>  static void detach_buf_split(struct vring_virtqueue *vq, unsigned int he=
ad,
>                              void **ctx)
>  {
>         struct vring_desc_extra *extra;
> -       unsigned int i, j;
> +       unsigned int i;
>         __virtio16 nextflag =3D cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F=
_NEXT);
>
>         /* Clear data ptr. */
> @@ -793,34 +824,10 @@ static void detach_buf_split(struct vring_virtqueue=
 *vq, unsigned int head,
>         /* Plus final descriptor */
>         vq->vq.num_free++;
>
> -       if (vq->indirect) {
> -               struct vring_desc *indir_desc =3D
> -                               vq->split.desc_state[head].indir_desc;
> -               u32 len, num;
> -
> -               /* Free the indirect table, if any, now that it's unmappe=
d. */
> -               if (!indir_desc)
> -                       return;
> -               len =3D vq->split.desc_extra[head].len;
> -
> -               BUG_ON(!(vq->split.desc_extra[head].flags &
> -                               VRING_DESC_F_INDIRECT));
> -               BUG_ON(len =3D=3D 0 || len % sizeof(struct vring_desc));
> -
> -               num =3D len / sizeof(struct vring_desc);
> -
> -               extra =3D (struct vring_desc_extra *)&indir_desc[num];
> -
> -               if (vq->use_dma_api) {
> -                       for (j =3D 0; j < num; j++)
> -                               vring_unmap_one_split(vq, &extra[j]);
> -               }
> -
> -               kfree(indir_desc);
> -               vq->split.desc_state[head].indir_desc =3D NULL;
> -       } else if (ctx) {
> +       if (vq->indirect)
> +               detach_indirect_split(vq, head);
> +       else if (ctx)
>                 *ctx =3D vq->split.desc_state[head].indir_desc;
> -       }
>  }
>
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> --
> 2.42.0
>


