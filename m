Return-Path: <linux-kernel+bounces-576968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6247A716C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1FD1888B87
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0C1E1E14;
	Wed, 26 Mar 2025 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iraJhFXL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE6185920
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992408; cv=none; b=V9Iz1zWUrtvdLl4aXJwloLxf6ReUyeTXYrqne5+i/va8CALGtqYDek6/EessE4pag3XJyYEYmZLWvXPfVwOdt4CXfdIuLk5BF5PJudq5ft/FxH7Bf2Ru73Shczrx1IQYuo1rWSS7iEB5GpdqN8qAUNF5F5gMSl98QuJVpqlBX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992408; c=relaxed/simple;
	bh=N3grN2QV7gu6NVwtY15esedESYw549yVIA9oYYKyqvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocU4uovoHGYkUWfpORnOSvwtzu6wvNAnLhz0WJcBYrG43dwrCoXWgYqKAYhbBc1mh29bY2dIaO6va+nplnTYKNgaRQOezldaXId/U9F0hOVjvx6CF+cjQJxepPNKFcekuQyALxCiPglmUFgtoL64Xsmv3JvuTFvUivWvW/6YdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iraJhFXL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h9zkBtZAENxGAjMf2g3QIo4BYdNbxYuXCOfwd31ChY=;
	b=iraJhFXL0sI9PpAih8EkoSIOUo/y4eLy5qawlrzWVlIRDgphqRjRbcqfKjaaDBcWR3T9ze
	Hu8C4UkQhaEp7NSuXp34BDAxdd0RWp80m8/hZdd77MraoG60Vss5kKv4m5GE8LtL0BvrQ8
	BdczRwuXg2/cS+GgeVSDNm0oxJA0F/Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Fh6h-OyUMdugOhtU5JjWVw-1; Wed, 26 Mar 2025 08:33:22 -0400
X-MC-Unique: Fh6h-OyUMdugOhtU5JjWVw-1
X-Mimecast-MFC-AGG-ID: Fh6h-OyUMdugOhtU5JjWVw_1742992401
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso11874505a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992401; x=1743597201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6h9zkBtZAENxGAjMf2g3QIo4BYdNbxYuXCOfwd31ChY=;
        b=faEUJfQlB0eybaMjJCKiTdvXSYfDONepAGmD5C10pqZAp5Ti8LVSjpmXAB601CJxdg
         d7nFbPOwxTr07jFQS6IlbybV9YIYcDaRrhWdMisSQQOz5H8rRlfq9CaDLHkuDk8CJ1E6
         AY0/RMuEearLi7wOu6QSuDuXcpylK8Mfp/KiJswb+1OEgNIdX35cQ93kHpbvqMFkOP/f
         AGvvdNug7S9nqPorH+rpBjKXQPUdnXUmYRPxDuxfVSNxL8tSbsCFHVTWDO2x79uO2R2v
         ReTHUSczwsNzkEDCcrEdHbNPv8WZ7m36VHwBawrveuP3U341CB3EKZ7mqYq0jOzcMhVZ
         MNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrLmOnFCayxZH/qcYXaMw5N6AZnSVeg4fumkZOwiQgs9F905/douRIW9UbvOKoTFtAvJoz5Br3GGBWhT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+w7iNETtFaKnhvkkq90gs4pgmSOcHukNVnGzG4in9CNQIa3l
	+wuzFpI065ROb9lxdAFXZ9fyhZaynmWYZUHrYEd0Hm3ALpDVuLjqkMGLF5ASc8b25uWkkoq7toa
	RHwjoK1hhwHdiYdbX22NmQdd00E5sqtvjdwQUN2VupE7nNeImttRerguAyuZb/ZyfOvXcQrOzOe
	PKmUtzLNAwQwUcRA9ThA2ogJvKG5k/JCPH16p8
X-Gm-Gg: ASbGnctUmPvZhu7LjC4J09gZSQhjr+dQDfFo6sBemtfQt6NUjJkKaV3cIBaLrewFgYU
	JT7fuJAO53x200pzXUAWZb5ywrio0h1atk00sm/c+8Srnv8I2wOG1lMqE+/AwsEMqIyR8zLA=
X-Received: by 2002:a17:90b:51c1:b0:2ff:58c7:a71f with SMTP id 98e67ed59e1d1-3030ff0dfa8mr26773241a91.32.1742992400977;
        Wed, 26 Mar 2025 05:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkJtrTwIWW7ZQ6nbvOaulTxmv88Dab//R+/xNCwb9ubPeaIKEVomqCDml25dXFpJfuz5Ql/72Ydnzl53UzWtg=
X-Received: by 2002:a17:90b:51c1:b0:2ff:58c7:a71f with SMTP id
 98e67ed59e1d1-3030ff0dfa8mr26773192a91.32.1742992400385; Wed, 26 Mar 2025
 05:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-1-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-1-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:32:44 +0100
X-Gm-Features: AQ5f1JqKF6Qxbf62oUTBAxf2A2BZTLAqOerFJrXaOCoGW8jflzH7dxm2eXZRNOY
Message-ID: <CAJaqyWeCvT0ArsT+K4Of-+kT6uDFAT2v83bKNqKm+OeDBA5kZA@mail.gmail.com>
Subject: Re: [PATCH 13/19] virtio_ring: introduce virtqueue ops
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This patch introduces virtqueue ops which is a set of the callbacks
> that will be called for different queue layout or features. This would
> help to avoid branches for split/packed and will ease the future
> implementation like in order.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 96 +++++++++++++++++++++++++-----------
>  1 file changed, 67 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a2884eae14d9..ce1dc90ee89d 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -159,9 +159,30 @@ struct vring_virtqueue_packed {
>         size_t event_size_in_bytes;
>  };
>
> +struct vring_virtqueue;
> +
> +struct virtqueue_ops {
> +       int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[]=
,
> +                  unsigned int total_sg, unsigned int out_sgs,
> +                  unsigned int in_sgs, void *data,
> +                  void *ctx, bool premapped, gfp_t gfp);
> +       void *(*get)(struct vring_virtqueue *vq, unsigned int *len, void =
**ctx);
> +       bool (*kick_prepare)(struct vring_virtqueue *vq);
> +       void (*disable_cb)(struct vring_virtqueue *vq);
> +       bool (*enable_cb_delayed)(struct vring_virtqueue *vq);
> +       unsigned int (*enable_cb_prepare)(struct vring_virtqueue *vq);
> +       bool (*poll)(const struct vring_virtqueue *vq, u16 last_used_idx)=
;
> +       void *(*detach_unused_buf)(struct vring_virtqueue *vq);
> +       bool (*more_used)(const struct vring_virtqueue *vq);
> +       int (*resize)(struct vring_virtqueue *vq, u32 num);
> +       void (*reset)(struct vring_virtqueue *vq);
> +};
> +
>  struct vring_virtqueue {
>         struct virtqueue vq;
>
> +       struct virtqueue_ops *ops;
> +
>         /* Is this a packed ring? */
>         bool packed_ring;
>
> @@ -1116,6 +1137,8 @@ static int vring_alloc_queue_split(struct vring_vir=
tqueue_split *vring_split,
>         return 0;
>  }
>
> +struct virtqueue_ops split_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>                                                struct vring_virtqueue_spl=
it *vring_split,
>                                                struct virtio_device *vdev=
,
> @@ -1134,6 +1157,7 @@ static struct virtqueue *__vring_new_virtqueue_spli=
t(unsigned int index,
>                 return NULL;
>
>         vq->packed_ring =3D false;
> +       vq->ops =3D &split_ops;
>         vq->vq.callback =3D callback;
>         vq->vq.vdev =3D vdev;
>         vq->vq.name =3D name;
> @@ -2076,6 +2100,8 @@ static void virtqueue_reset_packed(struct vring_vir=
tqueue *vq)
>         virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
>  }
>
> +struct virtqueue_ops packed_ops;
> +
>  static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index=
,
>                                                struct vring_virtqueue_pac=
ked *vring_packed,
>                                                struct virtio_device *vdev=
,
> @@ -2107,6 +2133,7 @@ static struct virtqueue *__vring_new_virtqueue_pack=
ed(unsigned int index,
>         vq->broken =3D false;
>  #endif
>         vq->packed_ring =3D true;
> +       vq->ops =3D &packed_ops;
>         vq->dma_dev =3D dma_dev;
>         vq->use_dma_api =3D vring_use_dma_api(vdev);
>
> @@ -2194,6 +2221,34 @@ static int virtqueue_resize_packed(struct vring_vi=
rtqueue *vq, u32 num)
>         return -ENOMEM;
>  }
>
> +struct virtqueue_ops split_ops =3D {
> +       .add =3D virtqueue_add_split,
> +       .get =3D virtqueue_get_buf_ctx_split,
> +       .kick_prepare =3D virtqueue_kick_prepare_split,
> +       .disable_cb =3D virtqueue_disable_cb_split,
> +       .enable_cb_delayed =3D virtqueue_enable_cb_delayed_split,
> +       .enable_cb_prepare =3D virtqueue_enable_cb_prepare_split,
> +       .poll =3D virtqueue_poll_split,
> +       .detach_unused_buf =3D virtqueue_detach_unused_buf_split,
> +       .more_used =3D more_used_split,
> +       .resize =3D virtqueue_resize_split,
> +       .reset =3D virtqueue_reset_split,
> +};
> +
> +struct virtqueue_ops packed_ops =3D {
> +       .add =3D virtqueue_add_packed,
> +       .get =3D virtqueue_get_buf_ctx_packed,
> +       .kick_prepare =3D virtqueue_kick_prepare_packed,
> +       .disable_cb =3D virtqueue_disable_cb_packed,
> +       .enable_cb_delayed =3D virtqueue_enable_cb_delayed_packed,
> +       .enable_cb_prepare =3D virtqueue_enable_cb_prepare_packed,
> +       .poll =3D virtqueue_poll_packed,
> +       .detach_unused_buf =3D virtqueue_detach_unused_buf_packed,
> +       .more_used =3D more_used_packed,
> +       .resize =3D virtqueue_resize_packed,
> +       .reset =3D virtqueue_reset_packed,
> +};
> +
>  static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
>                                          void (*recycle)(struct virtqueue=
 *vq, void *buf))
>  {
> @@ -2248,10 +2303,8 @@ static inline int virtqueue_add(struct virtqueue *=
_vq,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_add_packed(vq, sgs, total_sg,
> -                                       out_sgs, in_sgs, data, ctx, prema=
pped, gfp) :
> -                                virtqueue_add_split(vq, sgs, total_sg,
> -                                       out_sgs, in_sgs, data, ctx, prema=
pped, gfp);
> +       return vq->ops->add(vq, sgs, total_sg,
> +                           out_sgs, in_sgs, data, ctx, premapped, gfp);
>  }
>
>  /**
> @@ -2437,8 +2490,7 @@ bool virtqueue_kick_prepare(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_kick_prepare_packed(vq) :
> -                                virtqueue_kick_prepare_split(vq);
> +       return vq->ops->kick_prepare(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
>
> @@ -2508,8 +2560,7 @@ void *virtqueue_get_buf_ctx(struct virtqueue *_vq, =
unsigned int *len,
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_get_buf_ctx_packed(vq, len, ct=
x) :
> -                                virtqueue_get_buf_ctx_split(vq, len, ctx=
);
> +       return vq->ops->get(vq, len, ctx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_get_buf_ctx);
>
> @@ -2531,10 +2582,7 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       if (vq->packed_ring)
> -               virtqueue_disable_cb_packed(vq);
> -       else
> -               virtqueue_disable_cb_split(vq);
> +       return vq->ops->disable_cb(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>
> @@ -2557,8 +2605,7 @@ unsigned int virtqueue_enable_cb_prepare(struct vir=
tqueue *_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_prepare_packed(vq) :
> -                                virtqueue_enable_cb_prepare_split(vq);
> +       return vq->ops->enable_cb_prepare(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
>
> @@ -2579,8 +2626,7 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned=
 int last_used_idx)
>                 return false;
>
>         virtio_mb(vq->weak_barriers);
> -       return vq->packed_ring ? virtqueue_poll_packed(vq, last_used_idx)=
 :
> -                                virtqueue_poll_split(vq, last_used_idx);
> +       return vq->ops->poll(vq, last_used_idx);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
>
> @@ -2623,8 +2669,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *=
_vq)
>         if (vq->event_triggered)
>                 vq->event_triggered =3D false;
>
> -       return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(vq) :
> -                                virtqueue_enable_cb_delayed_split(vq);
> +       return vq->ops->enable_cb_delayed(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
>
> @@ -2640,14 +2685,13 @@ void *virtqueue_detach_unused_buf(struct virtqueu=
e *_vq)
>  {
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
> -       return vq->packed_ring ? virtqueue_detach_unused_buf_packed(vq) :
> -                                virtqueue_detach_unused_buf_split(vq);
> +       return vq->ops->detach_unused_buf(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
>
>  static inline bool more_used(const struct vring_virtqueue *vq)
>  {
> -       return vq->packed_ring ? more_used_packed(vq) : more_used_split(v=
q);
> +       return vq->ops->more_used(vq);
>  }
>
>  /**
> @@ -2785,10 +2829,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 nu=
m,
>         if (recycle_done)
>                 recycle_done(_vq);
>
> -       if (vq->packed_ring)
> -               err =3D virtqueue_resize_packed(vq, num);
> -       else
> -               err =3D virtqueue_resize_split(vq, num);
> +       err =3D vq->ops->resize(vq, num);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> @@ -2822,10 +2863,7 @@ int virtqueue_reset(struct virtqueue *_vq,
>         if (recycle_done)
>                 recycle_done(_vq);
>
> -       if (vq->packed_ring)
> -               virtqueue_reset_packed(vq);
> -       else
> -               virtqueue_reset_split(vq);
> +       vq->ops->reset(vq);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> --
> 2.42.0
>


