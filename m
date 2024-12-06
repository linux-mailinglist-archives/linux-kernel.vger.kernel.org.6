Return-Path: <linux-kernel+bounces-434277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00C09E644A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85701168C01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121317B418;
	Fri,  6 Dec 2024 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHNRCVGt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335214D433
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452714; cv=none; b=gMVTropMC+fA98Mq9aMShkGLyDRlHR2Vn0ybtc5yQEin2PY5IuxY29jUw2x830oFsmtEQb547R4pvIfwS2vZ9ZakJ384YJgUCi6FbcKf9zFzK7KPYXbFf6v8VI1kZe/xULpHIv2FFnYV1AtAivJi194BMYFku+I+XwzseB7FZ20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452714; c=relaxed/simple;
	bh=wNgTPz8AgRVXV6HrZhY9Nb41hj2wBW/WH3xQZRZYaMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eqH8KNE1CnRrCFQqSlF3ttKagzHnAcm4IfeJ2UOQ7v/WnzeDfoZAbd+CorwuLq/TdpjGvI2ssdBZ983o0aDKpO+l/akgP8Id7cq1+bPaofE6/3aCp2/Ca4g5CWYsd++UrhefJtlc0SDpw3DjQgsaf8zdVR3k6fqgLvSG71IdYKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHNRCVGt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733452709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nT0DV9JByo+6iUSRQFf0u5MMGCTCWwzLaVplVJHUzA=;
	b=YHNRCVGtTCOrs5MIaarewlJsBpArRaX6LXRoLIorj8QeSPaoaXFdQ4S06Lq2j0GZH1QWQU
	4ojlm76CW5q5e09Ym9Wmi/JEmkJfskLlYWZrkmfHoyMgoaBJYS80So6y14gSS/U0TtXum5
	/o8vvc50/ndGOUV5xqMejIZ0UQ2qh38=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-HbTOODgINJmoImFslz3C1A-1; Thu, 05 Dec 2024 21:38:28 -0500
X-MC-Unique: HbTOODgINJmoImFslz3C1A-1
X-Mimecast-MFC-AGG-ID: HbTOODgINJmoImFslz3C1A
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee8cdb4c40so1560343a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 18:38:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733452707; x=1734057507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nT0DV9JByo+6iUSRQFf0u5MMGCTCWwzLaVplVJHUzA=;
        b=bLQlKOaxgtLfeGePnS9jda/gdSxuqWa6Y/83v35SPV0Yon2WhOOshesVAq3yRx7vC4
         vn/N+0z7gtZ4QTgRT7Vi/kWKDdYF8sJBqPwx4Fs74kOnBMo33EmSdnrA2zeGuAqmDKUe
         vd5WwevZ1VuAuVfKZWOWZgQcB5o+BctEUXf9nM30iB/9iY++AbPoKseeYu471iywre5U
         824yqFc87dgkr0e1A3ul87W2mnjqeaE193JzZseU+ik7sv5hIme0kycev05zbbR7V74+
         scLLpxr7iMt5w2Ca+rzvCTijiwlqV8cCDH7zG6Oe8focoN02qAhheoOdG/3PPHI9uHP5
         mp1g==
X-Forwarded-Encrypted: i=1; AJvYcCWDKdfzIPcsKMIO7OMHK0HOmlliVf2x1B6nZ2q/q2HZcSyfdaxRBmRWCiAsMPrI0iXyKL4ADFtRGkaZH84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5mk+YocBW8wYLdKUzkpjM/5xrF84tp4t3xJhuCiYgFItEh45
	WY1OwuYly2wpqjh4HglFfiN1LRc2KS4gx56ca3xkUpofVpt98SuJ/cknKH5ky4ZMdmQt2x2jwxW
	KwMsmgLFbONyJxLhGazsaaQGr2Hmj7VmxfMv3uvtVPILOy/f8AOprpuUaSKeZeALhi/VkGo3FCE
	Z6yfIxvP937wYO94SjHQ28WfprRAh7VMRDR2mq
X-Gm-Gg: ASbGncutg1Xlck5nrXR/wYdlWi+bkSgnx9kDkGcZIl+gMWbChaCENVAN9tkgpQz3bdr
	ZbrLhUrhS+j99fUymXMYdYjw8UMG4XPPcFg==
X-Received: by 2002:a17:90b:3a48:b0:2ee:c9d8:d01a with SMTP id 98e67ed59e1d1-2ef69e12847mr2282969a91.11.1733452707514;
        Thu, 05 Dec 2024 18:38:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxVsjXZwpAnmXEbhbW5Xn3qF8C7Ogv9ErnhY0q29NJY1JfEkb/9EFOVWWxh5R9GTjTFyGFd6YK0d2Wj4RnD0o=
X-Received: by 2002:a17:90b:3a48:b0:2ee:c9d8:d01a with SMTP id
 98e67ed59e1d1-2ef69e12847mr2282945a91.11.1733452707116; Thu, 05 Dec 2024
 18:38:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121134002.990285-1-sthotton@marvell.com> <20241121134002.990285-4-sthotton@marvell.com>
In-Reply-To: <20241121134002.990285-4-sthotton@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:38:15 +0800
Message-ID: <CACGkMEtydc4q5Dc1wwN52na37uWLf24e-Tmp6rYmKyg0TDgXUg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] vdpa/octeon_ep: add interrupt handler for virtio
 crypto device
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, dan.carpenter@linaro.org, 
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com, 
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Satha Rao <skoteshwar@marvell.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:43=E2=80=AFPM Shijith Thotton <sthotton@marvell.c=
om> wrote:
>
> Introduced an interrupt handler for the virtio crypto device, as its
> queue usage differs from that of network devices. While virtio network
> device receives packets only on even-indexed queues, virtio crypto
> device utilize all available queues for processing data.

I'm not sure I will get here but the recent kernel depends heavily on
the tx interrupt for skb post processing as well.

>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 52 +++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octe=
on_ep/octep_vdpa_main.c
> index d674b9678428..1bdf7a8111ce 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -44,7 +44,35 @@ static struct octep_hw *vdpa_to_octep_hw(struct vdpa_d=
evice *vdpa_dev)
>         return oct_vdpa->oct_hw;
>  }
>
> -static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
> +static irqreturn_t octep_vdpa_crypto_irq_handler(int irq, void *data)
> +{
> +       struct octep_hw *oct_hw =3D data;
> +       int i;
> +
> +       /* Each device interrupt (nb_irqs) maps to specific receive rings
> +        * (nr_vring) in a round-robin fashion.
> +        *
> +        * For example, if nb_irqs =3D 8 and nr_vring =3D 64:
> +        * 0 -> 0, 8, 16, 24, 32, 40, 48, 56;
> +        * 1 -> 1, 9, 17, 25, 33, 41, 49, 57;
> +        * ...
> +        * 7 -> 7, 15, 23, 31, 39, 47, 55, 63;
> +        */

So this algorithm is mandated by the device?

I'm asking since it's better to not have type specific policy in the
vDPA layer. As the behaviour of the guest might change.

For example, for networking devices, in the future we may switch to
use a single interrupt/NAPI to handle both RX and TX. And note that
this is only the behaviour of Linux, not other drivers like DPDK or
other OSes.

> +       for (i =3D irq - oct_hw->irqs[0]; i < oct_hw->nr_vring; i +=3D oc=
t_hw->nb_irqs) {
> +               if (ioread32(oct_hw->vqs[i].cb_notify_addr)) {
> +                       /* Acknowledge the per ring notification to the d=
evice */
> +                       iowrite32(0, oct_hw->vqs[i].cb_notify_addr);
> +
> +                       if (likely(oct_hw->vqs[i].cb.callback))
> +                               oct_hw->vqs[i].cb.callback(oct_hw->vqs[i]=
.cb.private);
> +                       break;
> +               }
> +       }

Thanks


