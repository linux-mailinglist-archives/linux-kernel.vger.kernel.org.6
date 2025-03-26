Return-Path: <linux-kernel+bounces-577073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A428A71802
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ACA176710
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DA1E5B7D;
	Wed, 26 Mar 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+Bq1Igj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4B1B0435
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997736; cv=none; b=Mlixqa8GYHydzrMQk7CB1+h1UCXgxjlbstzDYJdfI0BE/XHgBeP1/HvkbwNTHcKVYT1L3PzZtxq8vON903sQEwNzeezOGf7Xz59q0FVuoiSwwazzw+L0t+6NezMrqvWzqC1PdYSXNR0eT6lqAIKmhKJkilFlDA7DrAHdLUknFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997736; c=relaxed/simple;
	bh=ExKHiY1vfFVJz9ncN9p+ELlmMZ6mdwDNgLovj/LRhmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFE9PtjLVpHXTA+1R8dF/T+TLnVsA0dv1APt6vmxl6BFhHmeHL8SmIyY31EaIZ1bBt9IXczSvsilYi9sCe2JraT8iRMbgxR1QRPoaRRTQdLkW1U4mWRcLxodPa32Zm/63bU015IXv4YZavH71rmyXjWGIiufwTjmTLfAxOMcRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N+Bq1Igj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6A4QtKmG1cSlqlEKr2nCjS1PIqtKpWV2z+HY5iuQ8E=;
	b=N+Bq1Igj2RcWVYONhz5wRWMUtvPZwr6AVxxICm+5JykXw6Pdil9ojIWzrD4VIU3krjYouD
	Fsdie/MpOwIe6FWjYSIGnTpGrgfI6YK9alHdRtz92LQXd/YyvTca2l4YzbtSW4c51BOgQZ
	oC/6VMSCge70ZYRgqKxmYon1epPUef4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-3LjeKo47P-6lk3kaIHLPug-1; Wed, 26 Mar 2025 10:02:12 -0400
X-MC-Unique: 3LjeKo47P-6lk3kaIHLPug-1
X-Mimecast-MFC-AGG-ID: 3LjeKo47P-6lk3kaIHLPug_1742997731
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3978ef9a284so2765774f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997730; x=1743602530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6A4QtKmG1cSlqlEKr2nCjS1PIqtKpWV2z+HY5iuQ8E=;
        b=Y0RgkMT5SjH1YuuYj/fDWlSGk+9G0n/JP0HJpr7eQGBcLfDoTGma+Rp1cBd3BnlR/f
         uogD9KXxZTHM8kSGaG7UwwsA71NweFgqtGqzdA4QsZAH+hGMZO7DjFVkvePhn4T9d46K
         LKxhjXMoDDUGkmgoVQZVU4DL5vj+12vKF7QOm1t8zGpO1sYA8c2JKpOvZAdBoFx/H0a1
         e1ge7u7zwtszGLiv70l2+XsOV4+ly2UGi8rbBitUX4qh/3PIvidOUyrCqICg858Uzr4t
         9CMqpssXv3myw8iZLogE8w0uk2E9uK1zvdoJR/TQOIfhRH3DTBSEFj7zuFfmg3+KUenL
         fzmA==
X-Forwarded-Encrypted: i=1; AJvYcCVq1Ekz1ZOMuDWAYOgAOCmUB46J1f/Q6j5U8axaGEcpEUzpl+vAbGOmkYgHodaot60Gls4a9hi02XIabAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQGRUqq1yTTLWxZw5rlHdrVgxnTJQXybU8epJ6FAQAvDYufsD
	IWb/vVZ4ohA7DNl8ud6PSteohwey9ZLju1KRb4QOPp1kTz8QIsMwew5opOR00eE8mmrovrWbQFT
	MOFV2qtmx2rR4hZ9QLy5Gp75mYnk/RFn6aTW7H15BHJxvEBWVIjoDX3dh3t820+yKVlbAmGymsi
	cBeYPfsoIu0TEjwI1EIpfPBXoPZhkbzsoTycYpzX0lMc43/TY=
X-Gm-Gg: ASbGncvE0FrkqamJVqsm7lSk/0gzyB2En73PBqSbpqYmBydX5ANNLD06expGVjf4jTh
	3Ny+osuX+z6LLBtOeaAeP90C2IpJ9F93AIvoRiUTcKdx4muzI5oeTdat5JMCqwF93+wH3/eI=
X-Received: by 2002:a05:6000:184e:b0:39a:c6c1:3408 with SMTP id ffacd0b85a97d-39ac6c13529mr6773887f8f.37.1742997730214;
        Wed, 26 Mar 2025 07:02:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVqs4eXb7WYajBzH07dwOO7LIznq7DcBXdw3fZ7amxqvEjWOZDPtljFddcq4377XdEC6+XOg2IYsIt0Cbo6MQ=
X-Received: by 2002:a05:6000:184e:b0:39a:c6c1:3408 with SMTP id
 ffacd0b85a97d-39ac6c13529mr6773793f8f.37.1742997729380; Wed, 26 Mar 2025
 07:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-5-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-5-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 15:01:30 +0100
X-Gm-Features: AQ5f1JpZuY-R1mOa9Psg6wH6oBtdE7eDiRjlK41MnQiXsLSO1qS2bJZXvZEj_3Q
Message-ID: <CAJaqyWfzRDa5vn0nJiaPdy2=Qoi40jgUQbbAspm25zM7OfUyHg@mail.gmail.com>
Subject: Re: [PATCH 17/19] virtio_ring: move next_avail_idx to vring_virtqueue
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> This variable is used by packed virtqueue now, moving it to
> vring_virtqueue to make it possible to be reused by split virtqueue
> in-order implementation.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index bd4faf04862c..a1a8cd931052 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -138,9 +138,6 @@ struct vring_virtqueue_packed {
>         /* Avail used flags. */
>         u16 avail_used_flags;
>
> -       /* Index of the next avail descriptor. */
> -       u16 next_avail_idx;
> -
>         /*
>          * Last written value to driver->flags in
>          * guest byte order.
> @@ -214,6 +211,9 @@ struct vring_virtqueue {
>          */
>         u16 last_used_idx;
>
> +       /* Index of the next avail descriptor. */
> +       u16 next_avail_idx;
> +
>         /* Hint for event idx: already triggered no need to disable. */
>         bool event_triggered;
>
> @@ -448,6 +448,7 @@ static void virtqueue_init(struct vring_virtqueue *vq=
, u32 num)
>         else
>                 vq->last_used_idx =3D 0;
>
> +       vq->next_avail_idx =3D 0;
>         vq->event_triggered =3D false;
>         vq->num_added =3D 0;
>
> @@ -1350,7 +1351,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>         u16 head, id;
>         dma_addr_t addr;
>
> -       head =3D vq->packed.next_avail_idx;
> +       head =3D vq->next_avail_idx;
>         desc =3D alloc_indirect_packed(total_sg, gfp);
>         if (!desc)
>                 return -ENOMEM;
> @@ -1431,7 +1432,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                                 1 << VRING_PACKED_DESC_F_AVAIL |
>                                 1 << VRING_PACKED_DESC_F_USED;
>         }
> -       vq->packed.next_avail_idx =3D n;
> +       vq->next_avail_idx =3D n;
>         vq->free_head =3D vq->packed.desc_extra[id].next;
>
>         /* Store token and indirect buffer state. */
> @@ -1501,7 +1502,7 @@ static inline int virtqueue_add_packed(struct vring=
_virtqueue *vq,
>                 /* fall back on direct */
>         }
>
> -       head =3D vq->packed.next_avail_idx;
> +       head =3D vq->next_avail_idx;
>         avail_used_flags =3D vq->packed.avail_used_flags;
>
>         WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
> @@ -1569,7 +1570,7 @@ static inline int virtqueue_add_packed(struct vring=
_virtqueue *vq,
>         vq->vq.num_free -=3D descs_used;
>
>         /* Update free pointer */
> -       vq->packed.next_avail_idx =3D i;
> +       vq->next_avail_idx =3D i;
>         vq->free_head =3D curr;
>
>         /* Store token. */
> @@ -1633,8 +1634,8 @@ static bool virtqueue_kick_prepare_packed(struct vr=
ing_virtqueue *vq)
>          */
>         virtio_mb(vq->weak_barriers);
>
> -       old =3D vq->packed.next_avail_idx - vq->num_added;
> -       new =3D vq->packed.next_avail_idx;
> +       old =3D vq->next_avail_idx - vq->num_added;
> +       new =3D vq->next_avail_idx;
>         vq->num_added =3D 0;
>
>         snapshot.u32 =3D *(u32 *)vq->packed.vring.device;
> @@ -2083,7 +2084,6 @@ static int vring_alloc_state_extra_packed(struct vr=
ing_virtqueue_packed *vring_p
>  static void virtqueue_vring_init_packed(struct vring_virtqueue_packed *v=
ring_packed,
>                                         bool callback)
>  {
> -       vring_packed->next_avail_idx =3D 0;
>         vring_packed->avail_wrap_counter =3D 1;
>         vring_packed->event_flags_shadow =3D 0;
>         vring_packed->avail_used_flags =3D 1 << VRING_PACKED_DESC_F_AVAIL=
;
> @@ -2977,7 +2977,7 @@ u32 vring_notification_data(struct virtqueue *_vq)
>         u16 next;
>
>         if (vq->packed_ring)
> -               next =3D (vq->packed.next_avail_idx &
> +               next =3D (vq->next_avail_idx &
>                                 ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR)))=
 |
>                         vq->packed.avail_wrap_counter <<
>                                 VRING_PACKED_EVENT_F_WRAP_CTR;
> --
> 2.42.0
>


