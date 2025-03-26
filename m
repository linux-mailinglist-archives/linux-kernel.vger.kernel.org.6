Return-Path: <linux-kernel+bounces-576967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E6A716C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E8C17602A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85F81E1DFE;
	Wed, 26 Mar 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSoCDXij"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910091B6D01
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742992341; cv=none; b=Yz3rrCvo4C9nCl5pkJpg7ZHlpg6B/hr6hSVFkm/c7uAglQRqofQabUmdpeECwSQdTHqre3TINCSdZuVhaHigGoIUl7xmlazdW2WSLe0fsRwqzmiR1JSO8i9ru1qpjL2e3TLZ7692E3Acuk7T/h0p49StW0Jt0D13hhMorndQNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742992341; c=relaxed/simple;
	bh=2TTqg+lX1dQhtProIvhVeWwU3LN5GCVx00xGdLNnELE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bA58xmoCBOTxDZQW48g+y9x1jOqcCxOLRLE9luycNKD+RYgXx61uczElaKrj6qDh/PMFXHmoPV/9bgJejBai6XgNIVpiQz4y2bBLHBPkAUD6TkB6yovieuX3u6BsTuP+ZYZW04lpqAdvsP7AYw+wxq1eym2GOtF6KCr6Jo3Kux0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSoCDXij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742992338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwcA5Ry4ZMsWvxEDjHDWkPrYz/bbKoxfDEYy7G5GMTY=;
	b=HSoCDXijxwA/P1r8BTkM2w0nLUHol4YRYN61tlXUFvkUFsgKkW+aIwfHb0zFTjtRemlgjR
	jfWZEC3aZxWEYP1QkM50Cghm+vNlBIWZzDb36iOFfWZ9yErFjXAJ2nmEkDUjpbnF+fnyyh
	ld9Hnuhbm6aXlzOx6U3qVGdeofeKiLE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-KtBMzp7iMDCxLztv9RkqPg-1; Wed, 26 Mar 2025 08:32:17 -0400
X-MC-Unique: KtBMzp7iMDCxLztv9RkqPg-1
X-Mimecast-MFC-AGG-ID: KtBMzp7iMDCxLztv9RkqPg_1742992336
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3011bee1751so10812110a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 05:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742992336; x=1743597136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwcA5Ry4ZMsWvxEDjHDWkPrYz/bbKoxfDEYy7G5GMTY=;
        b=SYvKB4IYJpoG+0cqXF/qBz+uNGXK23DT93x2SbqAUjzEy2ht1WjTsKC+XQ9lLU9Kme
         hWS/geBqzV0w+ZfeET7n+QrlX3aBozvNaI729W5CLmxirMucsJd8BWdmSCyabE1QVOQR
         CPtDtowSj0R5ItxCzttNjP6gVXs5iKQ8V3Ae8ZA8rX0LZrsHAEiPFgzasosJTNKjAhZ9
         VoWiY4PMmQooOTzReGzO/OeEcFUnud8v4dNbVPp7EWn43y3wWbGHrP4uJrdkW5a40E4G
         8Yr0EC9oMtitiNPpcZ1zWSOjqRDYTP4MwspVjD4Gsvvv1ZdeQa4M7O2KO9a8kwMBkgm3
         Jl/w==
X-Forwarded-Encrypted: i=1; AJvYcCUaRFWQqh9O6Px11L0WWoynUufospbP6ftg7ipK4y2ClcnLRkxZOuC5+btLnlERiLVYeB/jLfRTPa/nOmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySyJ2r+2kazLnC/vbCUElUpo8pdhqrLUYRWqVp5UtwLEXXzlOH
	ZGsPNTXd9wqDdK/brJ3hZSk0KPRhcxllsi7hLaugaKADfcXbtnEYqiL7fzt1KeM43IJm4XQ+Ozn
	xQtzya4HNPIYdkJABT0NnvziZEz+tT4O9Sb+LZ41jVxtNN3hHRNo6LRJ6NzX8z/knVWnhsXIBwv
	VmXqGk1xSHaS5NOq4KIo3OH0KLXHzKCUMaw18TmM+Vbojs
X-Gm-Gg: ASbGncvP8Du77ly9rhgq+TpHc4eN/VLehlnHiIrxxJaMYA56QDSzyRH8gRL/H7LykGe
	iKGIK/FVz60TeKKqPyk6yaBfBZOZfWkhYimYxmXiT2UKolMl3bjgP0J9ug+90hCpUdlOBtt0=
X-Received: by 2002:a17:90b:3bc7:b0:301:1bce:c252 with SMTP id 98e67ed59e1d1-3030fee95d3mr32689243a91.27.1742992335537;
        Wed, 26 Mar 2025 05:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAsjbfru13QMabqyG6unsNqqtxh9L2u1VKTgXAP4lw2AyiaiL/J+8/3kJMAZafGRPNuOL2P5TkzAlcPjkHOW8=
X-Received: by 2002:a17:90b:3bc7:b0:301:1bce:c252 with SMTP id
 98e67ed59e1d1-3030fee95d3mr32689193a91.27.1742992334967; Wed, 26 Mar 2025
 05:32:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324054333.1954-1-jasowang@redhat.com> <20250324054333.1954-13-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-13-jasowang@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 26 Mar 2025 13:31:38 +0100
X-Gm-Features: AQ5f1Jr4PDWFekYrqp6Q4ssDNwRggMV_WQEba50a3Ao5vNGZTJ4WtphM4KqyAic
Message-ID: <CAJaqyWerWJpLgpaMtaAYfBPW4UUWqLO7ja9C7-U7Y5YukLN1Tg@mail.gmail.com>
Subject: Re: [PATCH 12/19] virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 6:44=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> Use u16 for last_used_idx in virtqueue_poll_split() to align with the
> spec.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 19aa24d62d20..a2884eae14d9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -801,7 +801,7 @@ static void detach_buf_split(struct vring_virtqueue *=
vq, unsigned int head,
>  }
>
>  static bool virtqueue_poll_split(const struct vring_virtqueue *vq,
> -                                unsigned int last_used_idx)
> +                                u16 last_used_idx)
>  {
>         return (u16)last_used_idx !=3D virtio16_to_cpu(vq->vq.vdev,

So this cast to u16 is not needed anymore, isn't it?

>                         vq->split.vring.used->idx);
> --
> 2.42.0
>


