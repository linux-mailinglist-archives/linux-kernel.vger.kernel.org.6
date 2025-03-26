Return-Path: <linux-kernel+bounces-577068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AB7A717F9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B0C188F9FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD951EFFBE;
	Wed, 26 Mar 2025 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNu0z+cH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99187189919
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742997597; cv=none; b=oGrlDLxrY8UcW7u4NTCTzJVGhKYHtPCS9iMnbUAH40VE6z4xXkuOvmESvT0eDySFcDSLgA5wn+AMbXlsCRFoLPzxRgNV7l/5VFvAEAvxrbGp6Qxhrf0Qx93p7Kx/1PjMjfJN2BC15JTBZWXDjHiMV4cnu8R4nM7JHfVRzA8xUxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742997597; c=relaxed/simple;
	bh=naBbMN+Z/QrCKhz1hprq5AA2OwjE/1RWZqyCZLewyKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RSfwfcVNb9fKLADqtrtdhBLEZfpBLWaZdlXeoZuergdb0XWwaxJlvOYzZksfA5kJy2We05ZeTcfLTJbNuchMIt4DrXQ3JjSDQC6DW7wqWseBS/XcQaZR+5TpYndqKybBegZDnRF5WyhRg2IcvO67JfCOm2u/j3cTjSIKhDVkvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNu0z+cH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742997593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ac9lR/a3T+g4DECgHB+aeJUFPmg8S1RQjX/Rd9g8lZQ=;
	b=dNu0z+cHc3Lcb/Us30fQ1zNrgpKP3t+uBZ5L13Bw1/owTw/oSzfg2SfECVgxd3FRjohmKv
	AqE8iy9OQuTXekYGy36KYM4J//B/Lc7HbFpA4mIk9Bu1l3100qcfkDnNz+DMklkwGqRiC/
	k53HZ//0+JnNONSgOv4/Gjw+jIdQwzU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-ac46gYCaMrW9K6rgEAxwlw-1; Wed, 26 Mar 2025 09:59:51 -0400
X-MC-Unique: ac46gYCaMrW9K6rgEAxwlw-1
X-Mimecast-MFC-AGG-ID: ac46gYCaMrW9K6rgEAxwlw_1742997590
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5e5b65cda33so6383991a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742997590; x=1743602390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac9lR/a3T+g4DECgHB+aeJUFPmg8S1RQjX/Rd9g8lZQ=;
        b=Cel5AMv5ItwsNeCttJ9rTgTrKZK5CbKDrnMC67RBqmOBb/DDwQM8GY3mhQEbd6A01W
         BP/siXtyWortXqHG2UnjRXKwUWK+vkz+c8iWt87jph6kPkY0mH7sc2FD6NCxFZgd3puP
         CXGp8g4p7wG9iZouWeTdhnpzCm4BPB4sDgRscgUArzBhDjNEV/3LnG+STUkEtwYUvFWz
         cU4G2GF8RKnsLf1SJn+F/NkS+RslQcdPwN7JzFGVG+LmSDvFVSrUpMOEbl6hDKrHX57z
         kEr1Fx8lgEPrwSPL1TJNXIX5fF4dtPxoxecAJFwyaeNuU7T8P0G5mOilpKLFKLjDnM5c
         jS7w==
X-Forwarded-Encrypted: i=1; AJvYcCVVed03aZKdA6ni1oXHLSylTRPufPJjRldcIwVgYYEy/M2ZKL+OklUdpNUuwxTFtz3jfDxf2akINLe1xBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyObUUGxlZJQZ4xiConuZU9aOPz5s6RUUFwx23GYQJOMXYz/8CU
	70mVZ/vlXRgg+tn4BajLAAEB7ViimMG/I3IIJB4VjdUavMOzG1EgX8YjpxjsARhGEX55YChuzvZ
	tRFA75laaLogiHBhVhhRf95iydoXbDrVIX5VtC5iHTO4WnB6yK0Sb2zSP5T95T67tQEnfQZYQgK
	+Sh805dYXAXKmPqxE5qUaTTPn0mZ9vjKWOHPrw
X-Gm-Gg: ASbGncviWkX/xxPlssPQiIzWMYNS4pOUHIfrGbReEs/9qhkhqqFmph+hp6fVET1QJwI
	3dzt3upxikuANgYHTlQuB26y8Uyljbzj8Cxq442G6O3Wz9MhWQ36xzmukBKhDmsCF52gFVos=
X-Received: by 2002:a05:6402:26c5:b0:5eb:9673:183f with SMTP id 4fb4d7f45d1cf-5ebcd5079bamr18661042a12.20.1742997589708;
        Wed, 26 Mar 2025 06:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOQ6NUckS+xXBnunIYqJLGGk/ys0rYj6s3e6MMC3qIrPaq6ehNhf5XM99eBkVg8YzGPe9eVNrniA8BKLnkbsA=
X-Received: by 2002:a05:6402:26c5:b0:5eb:9673:183f with SMTP id
 4fb4d7f45d1cf-5ebcd5079bamr18661021a12.20.1742997589325; Wed, 26 Mar 2025
 06:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324060127.2358-3-jasowang@redhat.com>
In-Reply-To: <20250324060127.2358-3-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 14:59:11 +0100
X-Gm-Features: AQ5f1Jp6GIhtHCW2n8iLMhVMu4dYdPe7ajIlwNK2G4GZTDXvWLYRK_4k0enRSL0
Message-ID: <CAJaqyWewrOB3bQnL4=2FF-jhK8FhS_eU9TVKRZ0AG-ZY674ffQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] virtio_ring: factor out core logic of buffer detaching
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:01=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Factor out core logic of buffer detaching and leave the id population
> to the caller so in order can just call the core logic.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 31aa4a935c27..fe3e6f3d0f96 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1661,8 +1661,8 @@ static bool virtqueue_kick_prepare_packed(struct vr=
ing_virtqueue *vq)
>         return needs_kick;
>  }
>
> -static void detach_buf_packed(struct vring_virtqueue *vq,
> -                             unsigned int id, void **ctx)
> +static void __detach_buf_packed(struct vring_virtqueue *vq,
> +                               unsigned int id, void **ctx)
>  {
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
> @@ -1673,8 +1673,6 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         /* Clear data ptr. */
>         state->data =3D NULL;
>
> -       vq->packed.desc_extra[state->last].next =3D vq->free_head;
> -       vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
>         if (unlikely(vq->use_dma_api)) {
> @@ -1711,6 +1709,17 @@ static void detach_buf_packed(struct vring_virtque=
ue *vq,
>         }
>  }
>
> +static void detach_buf_packed(struct vring_virtqueue *vq,
> +                             unsigned int id, void **ctx)
> +{
> +       struct vring_desc_state_packed *state =3D &vq->packed.desc_state[=
id];
> +
> +       vq->packed.desc_extra[state->last].next =3D vq->free_head;
> +       vq->free_head =3D id;
> +
> +       return __detach_buf_packed(vq, id, ctx);
> +}
> +
>  static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>                                        u16 idx, bool used_wrap_counter)
>  {
> --
> 2.42.0
>


