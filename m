Return-Path: <linux-kernel+bounces-576965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ABCA716BA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7231A3AF364
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C61E1E17;
	Wed, 26 Mar 2025 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjwGEkbQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318801C84A3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992293; cv=none; b=UWreqvuyCMda4rg9oJPiDLHBsXoFnR1vmAdoJuJ2tB1E9GhZVtp/rmax8YamSkaoFQATOYLRZ94NInSI1urGaVsZuirfhXp309c+GkIVIHdZdxxQ53+Z4d59G8XQJTo4N/sjg5lgf3j2J3ycU9NOTUrUkduXUykzlxH4GOZJtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992293; c=relaxed/simple;
	bh=t74iHA+M4wl4kWnwqstGGM0qACSyeEe/IR5GMJWVfMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YftqLFX6ew0ldgTiXkSutgEINQfzVhjA7vfUj4GlcZWvWxa/zF9SFrbbo0Dm7iMf2BcmF0ZYy/MGqVjgsaKduerOyiWSsZMcrmDwbtOSJZVwW8E+UaMKFsQ5dqzXLP7I7lzaspaytLwIKtofnd0u3skJh8gclPdaoQQCl4WbNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjwGEkbQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxzZXRNdXQx6t4R5itiH8YDImrhRWKf4Xk6yoiwedLI=;
	b=VjwGEkbQ5OoWlIKPZNyzMSkhrx7dOx9xmpBzGn6BAgPLjvUYi2iso80c+T8ZrIHYLYyofa
	/Pe/1fQCvczgGvZ1ScBbYLglmQiqRkiyugrl8oBkSGn1y9kcZSUC+VZrhRVAh4dnrfoo+8
	cYKUFDkA7Myxt9RLlqAirUBLberxDr0=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-0L9MjgQrMeqTO7BoT4KJRw-1; Wed, 26 Mar 2025 08:31:28 -0400
X-MC-Unique: 0L9MjgQrMeqTO7BoT4KJRw-1
X-Mimecast-MFC-AGG-ID: 0L9MjgQrMeqTO7BoT4KJRw_1742992287
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso18037000a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992287; x=1743597087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxzZXRNdXQx6t4R5itiH8YDImrhRWKf4Xk6yoiwedLI=;
        b=ORyg0JCzo/UF128o4TxspLxW2tfnXbLjeWSbZ7JT8PBhGZsnaIJjYc1tyc5bGsPDdN
         VbHqgZCMnShYArRsLdefuEouOMm+pv36UREvTUmqgTvovGNONhfrO2snl9nCTfzR63kT
         os/O2mj+GuTRvHcvgdC89RbuxgAlYmdsgUtBEWeLJ451sn4kxtYSuuvuhxzmaYYOoMgc
         zvBAR4XFv+RYQb/mvRT0Fm4yhFXblqhOUECGTQpe9Y7NAH3vyEHeQzZE/szWT9GKxIfK
         YTJvvlzPeZt+n3zcWjuaJ2SkfMLkXeI2tRokLVrweKBzRFmdS3MTTM7klrE4zX7Yr/G/
         T+LA==
X-Forwarded-Encrypted: i=1; AJvYcCXCW/Kgse9Dsyqkmb7R7aYUVPxTz/b0hXvyd0Z1EWWFswdD4/jIylPf4Fi7xGhM7OviZbqPcR6afdI9Sek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kDJFbU5nVk2DgWV7Xqdz2v6gdwJJSz6OFEdLcndu8iebMmqc
	HNTM7wDY2v8wYsms7Z3bfulAsE/S4XB00u0GNOZf7GGHxP20wftdc/mruPPiym+Ba0QoxjRFb2A
	BfyucK+FL/HAOKY7w5ECe1o7jmRb4AFdTjpIZ45J4+8EOnTqVSWdEm3r22TJLDfB836aPsr4rRo
	QwfMRhE9bNw3pxQ3QD4aUTOr51NABO/OilY7jF
X-Gm-Gg: ASbGncsrangqPpL9Bmjh+Q2fCwCB1Emm+IztcOFl0GFCxV2siVil82IY4yEvsPPIHM4
	RsEF6YAoeBG9kgVHlgRtrpFTvbfQYkvKww7cE0I3YOC3DWieMYwcDtd9zzvzf4ssrqRlRuII=
X-Received: by 2002:a17:90b:3947:b0:2ee:9d49:3ae6 with SMTP id 98e67ed59e1d1-3030fe8f4cemr34792337a91.10.1742992286599;
        Wed, 26 Mar 2025 05:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQa+dEBw3ucGCR/0q+QuWfL8BtEzdB9rSPV8AV8eO3X1snIMfP4GQqIXxffOzgvCVRbKJR7J+8/tCPfod5dbo=
X-Received: by 2002:a17:90b:3947:b0:2ee:9d49:3ae6 with SMTP id
 98e67ed59e1d1-3030fe8f4cemr34792267a91.10.1742992285996; Wed, 26 Mar 2025
 05:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-11-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-11-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:30:49 +0100
X-Gm-Features: AQ5f1Jqwb1hNU78UMFS7JSyJZVaJiMHV0bnJ1MJ05P9-Npacc4KDXKJyITVgW0s
Message-ID: <CAJaqyWdxAcHT+C4LRY6uq84jSa6C5oem=CUD3GJTHd5+KkXvMw@mail.gmail.com>
Subject: Re: [PATCH 10/19] virtio_ring: switch to use vring_virtqueue for
 disable_cb variants
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

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index af8ce6e9d892..f754da8c2ac6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -869,10 +869,8 @@ static void *virtqueue_get_buf_ctx_split(struct vrin=
g_virtqueue *vq,
>         return ret;
>  }
>
> -static void virtqueue_disable_cb_split(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_split(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))=
 {
>                 vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERR=
UPT;
>
> @@ -888,7 +886,7 @@ static void virtqueue_disable_cb_split(struct virtque=
ue *_vq)
>                         vring_used_event(&vq->split.vring) =3D 0x0;
>                 else
>                         vq->split.vring.avail->flags =3D
> -                               cpu_to_virtio16(_vq->vdev,
> +                               cpu_to_virtio16(vq->vq.vdev,
>                                                 vq->split.avail_flags_sha=
dow);
>         }
>  }
> @@ -1786,10 +1784,8 @@ static void *virtqueue_get_buf_ctx_packed(struct v=
ring_virtqueue *vq,
>         return ret;
>  }
>
> -static void virtqueue_disable_cb_packed(struct virtqueue *_vq)
> +static void virtqueue_disable_cb_packed(struct vring_virtqueue *vq)
>  {
> -       struct vring_virtqueue *vq =3D to_vvq(_vq);
> -
>         if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DI=
SABLE) {
>                 vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG=
_DISABLE;
>
> @@ -2538,9 +2534,9 @@ void virtqueue_disable_cb(struct virtqueue *_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (vq->packed_ring)
> -               virtqueue_disable_cb_packed(_vq);
> +               virtqueue_disable_cb_packed(vq);
>         else
> -               virtqueue_disable_cb_split(_vq);
> +               virtqueue_disable_cb_split(vq);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
>
> --
> 2.42.0
>


