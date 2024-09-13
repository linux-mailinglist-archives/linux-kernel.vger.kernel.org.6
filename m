Return-Path: <linux-kernel+bounces-327546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D914C97775D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90BAC1F21403
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C291B12EC;
	Fri, 13 Sep 2024 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTqaQixu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B001B9858
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198212; cv=none; b=SgPP1QD9xhHQ0+QSRtHQTPEKEj6Yak7kW3j+ZqpW7+0GTg0Z3QkeZgtmHBmYU947GpV2VtLnswoC/Bwv+glRls3gDu/ogTmXS2LBJ2NrgwIy0m+pCXpKLJEIjnWkQ6KJrSbaV4LegLMMh/hjuX4vtUvSKfnsnue2q9Ifh9uooHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198212; c=relaxed/simple;
	bh=OL4txjngX0hT+S/KBLWICruauN0kZ8rNOinNr4Tp62c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4HBvw3VVp99z7LcYSW4PKGocSZV27xviiWXLxuyIEHojrPSEIV9vTFU9TACJsqBcra4fVwKZ5iIbulFHQNHKaAGKBNCa88jHNAcGSNCMZpjVhAnqiqzyckBHbNhYkA37HcXe3Z3AP2pW0W95fD1tK38vXB0h7RkZY9mJ7QhM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTqaQixu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726198209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XraFOFlvfYSvbfoE38xm/7jtb+aNLJtE6pDAodi5bkw=;
	b=JTqaQixuqFDYjW8UxETFa7+squvLaK4Y0yS75QMELx3jRF+kDbTBsFBBkiXB/sd9+UbMMI
	E1ip0yy7bU5rBLDrtLmjlii8TlNw/6CtBp+Wt5NLsmnbM7KMDdU6HVNS81Q4QmQDZ+p4pa
	jBNy1nMYytPzZAzS/rw6NxjKeTB/+cM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-y1isF-nHOwyO9RWcr7qs8Q-1; Thu, 12 Sep 2024 23:30:08 -0400
X-MC-Unique: y1isF-nHOwyO9RWcr7qs8Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2d8b3af9e61so1902379a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726198207; x=1726803007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XraFOFlvfYSvbfoE38xm/7jtb+aNLJtE6pDAodi5bkw=;
        b=f0ziuk6PyuP8WYDYOlXvFysLFh/vs1R8FUtHqrsLWya8qE2kdtgfC7ZdojdMG29U3D
         tvlC4LUL7mX69LCH5gecgdjtWP7ziolLKpsLj/n41H6y9r+71iDRXWXMLPoZFoizxo1N
         gJvkKzs9HCjA1lqp0v5MkVD0QNNS2v4jA85dnKbN12BiJbqvVyy1xPbe+RRvDpqW1INp
         w+z9MX/CBB1ekx6jCusnV+lMLpswMbu4Cxoxud4PEIGFE6iTqc0Yycd4RUVZsm+DU+aA
         DpDQVpnoutVP8qFF94HIohT6X/7zFuVOUe3jauS6J8gBaQmpfsP9whlYD2g2qWWzzLWF
         juYg==
X-Gm-Message-State: AOJu0YzLT8HGoqEJ0RepLkPLN/MUK7cLKkCrXT+AwkKS/m0K8uliBYw6
	PMg7SXo0jiDn5q7DKngtloe48UecxFjIvqqXfQlCorxhP3ifXX6uPdzmLY2a4949xww/z28TS36
	nZE+wnWALFAlm3b5Y2LJWjnxUPA9LL40gtIXld7LsSOHrBpzR0A3wlUOPv/euotJG8XiCX4ofFG
	deLRp1DmUm1e+FXV4clHwsqBZoBmNLvjXUOzNeC7/PPhbKbmukyg==
X-Received: by 2002:a17:90b:4a4a:b0:2d3:d398:3c1e with SMTP id 98e67ed59e1d1-2dba0082fb8mr5578475a91.36.1726198207280;
        Thu, 12 Sep 2024 20:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRZzFvOmQNd8g2fspnJxJ33CmSRTluvH8Y3uUA+IrHrqGqU1UmVozYb4PHruoASxZty+uXKxg2ellHQ112yfo=
X-Received: by 2002:a17:90b:4a4a:b0:2d3:d398:3c1e with SMTP id
 98e67ed59e1d1-2dba0082fb8mr5578447a91.36.1726198206776; Thu, 12 Sep 2024
 20:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
In-Reply-To: <6bdd771a4fb7625a9227971b3cf4745c34c31a32.1726153334.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 13 Sep 2024 11:29:53 +0800
Message-ID: <CACGkMEt1VOBTQiWaupqbGPH6WM+KytdwPf0AzHRcOAkZG9DH+w@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: tag event_triggered as racy for KCSAN
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>, 
	syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:02=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> Setting event_triggered from the interrupt handler
> is fundamentally racy. There are races of 2 types:
> 1. vq processing can read false value while interrupt
>    triggered and set it to true.
>    result will be a bit of extra work when disabling cbs, no big deal.
>
> 1. vq processing can set false value then interrupt
>    immediately sets true value
>    since interrupt then triggers a callback which will
>    process buffers, this is also not an issue.
>
> However, looks like KCSAN can not figure all this out, and warns about
> the race between the write and the read.  Tag the access data_racy for
> now.  We should probably look at ways to make this more
> straight-forwardly correct.
>
> Cc: Marco Elver <elver@google.com>
> Reported-by: syzbot+8a02104389c2e0ef5049@syzkaller.appspotmail.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..98374ed7c577 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2588,7 +2588,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>
>         /* Just a hint for performance: so it's ok that this can be racy!=
 */
>         if (vq->event)
> -               vq->event_triggered =3D true;
> +               data_race(vq->event_triggered =3D true);
>
>         pr_debug("virtqueue callback for %p (%p)\n", vq, vq->vq.callback)=
;
>         if (vq->vq.callback)
> --
> MST
>

Acked-by: Jason Wang <jasowang@redhat.com>

It might be worth testing if event_triggered can really help for
performance or not.

Thanks


