Return-Path: <linux-kernel+bounces-576938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13BA71646
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02843A1CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20B11DF74B;
	Wed, 26 Mar 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxSE5vxx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED214D2A0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990978; cv=none; b=FJtLI9cPKM6nOzXz7C8ikEtz7wdjBolhjCiXoTxN+VG5crVNAPngckWmZs1BbESzrDuH0R8OjchN1YdY+BfJQTXjolARBZaNRGuiQ8aU62pVHAtgUnQK1r+LjV6SqMpeBwMetp/h/0Ap7uOMnXet1dO4tkS47/KCaG3SevkLg+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990978; c=relaxed/simple;
	bh=/XWouKMbD2oQnq+am6VXLfECTMKaj5hCa9hjtsLparA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FA+feUkE4hpqDfK0Wr+hRIOfDwKXTKgCgy3BvlLvKCxs5v60wXjf1273z8w/+03g6yznFAkY/U+9GKUc2ovtgcsVadb0UBXhwpsmLVQFXYygyC5uKTaPpqrWdYfyJ/hkuLPwcgUbVRJjbuxT9mzRR4Jx2f0m82h0SS8FSjLS6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxSE5vxx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742990975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TCTBGWYiVmEwl6WMzGfDrfo/qCoag28PGkVkZQCdvC0=;
	b=YxSE5vxxE7P6lA8uRVPk4HBuTK+a4BZI5PQP6XwHALDW4tQE39TyCThuhC7c6gO1GgzoGH
	i2PQqE5cp8CqgIPK8tDjfyDWmrSQxBENkdNQmggd5taUQ3YUJwDnPU/zinGxHFqNiuj6CD
	V1iuvSmBjMkpmqMpqfeHij7pWAkvrP8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-y-G3bTApOK-vcAL9zSuaqg-1; Wed, 26 Mar 2025 08:09:28 -0400
X-MC-Unique: y-G3bTApOK-vcAL9zSuaqg-1
X-Mimecast-MFC-AGG-ID: y-G3bTApOK-vcAL9zSuaqg_1742990966
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so1749490a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742990965; x=1743595765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCTBGWYiVmEwl6WMzGfDrfo/qCoag28PGkVkZQCdvC0=;
        b=DvQ9vvHwl64WNqo+hRYEvejrYqz+b8tAefgT7TNouc/vWkeEtafoy282Wx7fQtvUN/
         lw0Y9QozjqkSTzfgku7/ehJc3y+6hY4oTv8hq+Qb1ntltA1GqqEUkF+/dGcSCYx4XrWH
         KoF5J5yfJer4gBB0hyIdSLORciLRoKodSmUplzad5TUPDRrei4MmK1HlusV8PXNtRr4s
         CkiVDlUkILyXdO1RpgbRYhQoy7SLiBlnMydyUN9RoSJMGhE7DZ4Y+gidi+v/pLVCsP/L
         WOBOITdDLQElH2xQt3k1mjIdY31nvHlFJRhgXHLRBEqkD5J7QyDsGDZCStX/TGcZH3gV
         rpng==
X-Forwarded-Encrypted: i=1; AJvYcCW2YGFbOTr0hfvcLk8c+Sx/e1li8Hrta3K7zTvrJ/HL/eP/l4CmwBDBxht5LqyPsj+Lvi18XQG3aYbCzd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0MCXpgZ0YEtzezNta/HgpNV1n/GGMFzKSB53s4lc1JnsS8BaP
	zBFwtHLAQ5PsLrvacFFJZkV5ETfTh4mf0xoWcP7ccL8JPJ8JsKW+UKrTvVfQklwuwgvMG/nNJZG
	mwt52BA3R54x7ZXhf87l60N0vSEjKLVss1WKMbc9p+7UYC/TlajVLQKkglhn/x16Sw7eymV2eKT
	nD270/e87ILO6VcUiBRa02Qi2v8DcuoYBauNq0QjFnc1Lyi0M=
X-Gm-Gg: ASbGncvpMDqI1S17OB40T/tFQmy1SGWVsQShGZNIh8Ca51Cxol9tFdWg5qcHD3XqI8e
	7MSpXzFx9j2jIz5Zkp2GYIhauWQvRwQoK+lWgUiTRN4xcQH0rsTGI2YbuV6KCGLRTUH3HzLY=
X-Received: by 2002:a17:90b:54c4:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-303788c2685mr5612925a91.1.1742990965384;
        Wed, 26 Mar 2025 05:09:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF08/xQUBw1qW6H7aLUt4LlzOG2QAjL0z5ddqYDq1gJyhsrwBfoOpE9/miJp0mJcZwfCL0bkXJyElu25CxqUpA=
X-Received: by 2002:a17:90b:54c4:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-303788c2685mr5612880a91.1.1742990964861; Wed, 26 Mar 2025
 05:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-2-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-2-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:08:48 +0100
X-Gm-Features: AQ5f1Jrv63LkXsP4PD_7nrO0YIAGYmDZjtrgpSHFpXGUIqckHLvcEGNJAhPgi6A
Message-ID: <CAJaqyWeX0V2esyyWct3OnnDtCzGdJJamSjphSVz6KEFomYr0DQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:43=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> To be consistent with virtqueue_reset().
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fdd2d2b07b5a..1bdfd5d617a7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1005,7 +1005,7 @@ static void virtqueue_vring_init_split(struct vring=
_virtqueue_split *vring_split
>         }
>  }
>
> -static void virtqueue_reinit_split(struct vring_virtqueue *vq)
> +static void virtqueue_reset_split(struct vring_virtqueue *vq)
>  {
>         int num;
>
> @@ -1248,7 +1248,7 @@ static int virtqueue_resize_split(struct virtqueue =
*_vq, u32 num)
>  err_state_extra:
>         vring_free_split(&vring_split, vdev, vring_dma_dev(vq));
>  err:
> -       virtqueue_reinit_split(vq);
> +       virtqueue_reset_split(vq);
>         return -ENOMEM;
>  }
>
> @@ -2092,7 +2092,7 @@ static void virtqueue_vring_attach_packed(struct vr=
ing_virtqueue *vq,
>         vq->free_head =3D 0;
>  }
>
> -static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
> +static void virtqueue_reset_packed(struct vring_virtqueue *vq)
>  {
>         memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes=
);
>         memset(vq->packed.vring.driver, 0, vq->packed.event_size_in_bytes=
);
> @@ -2219,7 +2219,7 @@ static int virtqueue_resize_packed(struct virtqueue=
 *_vq, u32 num)
>  err_state_extra:
>         vring_free_packed(&vring_packed, vdev, vring_dma_dev(vq));
>  err_ring:
> -       virtqueue_reinit_packed(vq);
> +       virtqueue_reset_packed(vq);
>         return -ENOMEM;
>  }
>
> @@ -2852,9 +2852,9 @@ int virtqueue_reset(struct virtqueue *_vq,
>                 recycle_done(_vq);
>
>         if (vq->packed_ring)
> -               virtqueue_reinit_packed(vq);
> +               virtqueue_reset_packed(vq);
>         else
> -               virtqueue_reinit_split(vq);
> +               virtqueue_reset_split(vq);
>
>         return virtqueue_enable_after_reset(_vq);
>  }
> --
> 2.42.0
>


