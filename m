Return-Path: <linux-kernel+bounces-576960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B026BA716B8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A61175BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020AD1E5202;
	Wed, 26 Mar 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icxa8fG4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702A1E1E08
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992208; cv=none; b=YI+m/DcldYlQQLMMk/JgHiTneWWsX5do05aBwvJFB25U5123vL27TKD11JJQiAEsRGzhanTCnPpZF9kgKFh0nvHnpphszn6DgomjbvN1SM+NlyaK/KtaTBkyamdG4cdPs3X+JFMy8qV5us1aHCeI9/c2AXnXo3wiRSOdzzYHAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992208; c=relaxed/simple;
	bh=d3AdQbX6+21yO9I0lZEWLjA8CqykrpbhEOYrbgYWDXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TcqqZ2XBeGK6uKS7UWVqPs7OZuKQa7zJJXK/ip8WY58x1taZuf7rR4kJq/QIRLPEtRxs8GXQghtLHG4OGSVp0Tk+unWtLXCGrsFY2vdD2b2zq2NBZla/xL5+7CFjjK3yhYCdkxZ1avThLa4rMKZIjA9Phq8gdogApDDlucS6tA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icxa8fG4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKrPdf2nzn9LCA7q7bksrLyi2C1TjMNZM33BA9TF6fI=;
	b=icxa8fG47lPnqttm0X0B7Xtvoqly1x2sHBgW2uh0VgWAlr4ibWkcX2dMaaCIe+4mKJoZ/3
	k3IPIfuvbveWzoQxvjpav0LKueyE9deuc48CuEyPBaQ9ffFguqsmUYpuZu0+AKi4S95Vmh
	AAeZHm/WfgWWk+sCPW1s5BLlLx//xaA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-rogLdDGhONe1wCn56Q9zsw-1; Wed, 26 Mar 2025 08:30:04 -0400
X-MC-Unique: rogLdDGhONe1wCn56Q9zsw-1
X-Mimecast-MFC-AGG-ID: rogLdDGhONe1wCn56Q9zsw_1742992203
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so11631494a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992203; x=1743597003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKrPdf2nzn9LCA7q7bksrLyi2C1TjMNZM33BA9TF6fI=;
        b=dw6rBSeWGke63oYc7jEzcrRUN1smn69u85QP+DSFEvT1pXA/JiWa+pUQ9c9MAUuhQg
         dYosI5dzUGuhgtEXvi5NploLXIsPvWWJkPNns+4Lpo7ax7fg92M9sJR17jZOiupICCtP
         fszoG8WLFeTuKVJCz1JBz4WHQ3Xrh+U8X4CeHMY2OXFdFwog7QqtzkTuhtTJ4i/NjFoH
         mP34PnYZczsxlgbEocqwtGp3Xk3Uaj2QCFUXf3YfaF1AFDloQ3WB57qhW3YMt1s0H3Kv
         sN8HVU50EBIiMSUaxSFTk2TV1pn1lnePQZq91IOYlEDYDse+8rd2nkHSbzp8pASM5673
         OvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaXQE1T62O0IuVxeyMcJxqYNOIAEoFGXErfAOfoDqpK22m3vMucM+8c1lgprGmb35kKDm4xzaZazwfveU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdxZNqJ596dPPBApVJGv9XaqeEVW3/lmRGvIlx+Xq9+anzwynh
	mY55W6pUjvIdMKNME7/8xhmyMMmr6qQykLWlkJNZa8a4LD9+lUiFQlHPfMeA1Wa+5RnuN3DI75p
	gQgOKgySBawj90xlT5EMV1SZFrUWP7eWHAt+80iip5YJRr1Cs3O7VWDbVeqZ4Z5vNbQqHzIG1wY
	wVJdhx45Vk+GCAg8ZCKumd1fNhzGNvyQE6Et93
X-Gm-Gg: ASbGnctxl2iTlXRDAl3h90SzynA79siIIGWRrYSE3kRJ6SjpwWwaI5WcGolQ8Jg/Vs5
	t4cS4V9uDV/VB1dT4rHdyWxWi5tZLvS8m8hwHpjxnBvUxBUDprX7jFeUsY38sZ4sKx6IdGLs=
X-Received: by 2002:a17:90b:3c05:b0:2fe:99cf:f566 with SMTP id 98e67ed59e1d1-3030fe942bbmr30995249a91.13.1742992202775;
        Wed, 26 Mar 2025 05:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu3cHxPcatuuTyqBCWGB3gzPe/fhmRdkU7i14jGqyFMfRIpt5USxNqs6aDQz2tnygSegRETNiozfuDkTsXBLM=
X-Received: by 2002:a17:90b:3c05:b0:2fe:99cf:f566 with SMTP id
 98e67ed59e1d1-3030fe942bbmr30995177a91.13.1742992202219; Wed, 26 Mar 2025
 05:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-6-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-6-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:29:24 +0100
X-Gm-Features: AQ5f1JqA5rnmUJvxpY2lTSb7DtsHpn-R_THV-oHmmvfjcTfm35K1wGa3qO_Bi3M
Message-ID: <CAJaqyWehLxjOhPtXjDJUV7JrC2v40s-FqmtgsO_Ae1YkLHrQiA@mail.gmail.com>
Subject: Re: [PATCH 05/19] virtio_ring: switch to use vring_virtqueue for
 virtqueue_kick_prepare variants
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Those variants are used internally so let's switch to use
> vring_virtqueue as parameter to be consistent with other internal
> virtqueue helpers.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 94ce711963e6..cf3ab6404698 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -713,9 +713,8 @@ static inline int virtqueue_add_split(struct virtqueu=
e *_vq,
>         return -ENOMEM;
>  }
>
> -static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 new, old;
>         bool needs_kick;
>
> @@ -732,12 +731,12 @@ static bool virtqueue_kick_prepare_split(struct vir=
tqueue *_vq)
>         LAST_ADD_TIME_INVALID(vq);
>
>         if (vq->event) {
> -               needs_kick =3D vring_need_event(virtio16_to_cpu(_vq->vdev=
,
> +               needs_kick =3D vring_need_event(virtio16_to_cpu(vq->vq.vd=
ev,
>                                         vring_avail_event(&vq->split.vrin=
g)),
>                                               new, old);
>         } else {
>                 needs_kick =3D !(vq->split.vring.used->flags &
> -                                       cpu_to_virtio16(_vq->vdev,
> +                                       cpu_to_virtio16(vq->vq.vdev,
>                                                 VRING_USED_F_NO_NOTIFY));
>         }
>         END_USE(vq);
> @@ -1597,9 +1596,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>         return -EIO;
>  }
>
> -static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
> +static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
>         u16 new, old, off_wrap, flags, wrap_counter, event_idx;
>         bool needs_kick;
>         union {
> @@ -2454,8 +2452,8 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_kick_prepare_packed(_vq) :
> -                                virtqueue_kick_prepare_split(_vq);
> +       return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> +                                virtqueue_kick_prepare_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>
> --
> 2.42.0
>


