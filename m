Return-Path: <linux-kernel+bounces-246936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA4A92C910
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B0BB22749
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7632B9DD;
	Wed, 10 Jul 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFyAuImh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5D24A08
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581820; cv=none; b=dDGyRODDtzK8hYJUV2YrwYkRudFhxh6j6otKoJ+L5gnalMqIFV47buPvKDht9WGpT54EewqdWTnBtweL94WQiUR0L24TTRDxrvyBQ35Snbd8dzyIuc2sq1TuU/hqae4hM7q56Y9Wi3cdGOLY2UHLRNpCXnqW1Po8WsFPxhipWr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581820; c=relaxed/simple;
	bh=e60a2asA9Ve1N4Z1JddmItByU/gQ1qB3RGuVGW7iM1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrazIvgLgfY9w/B2qryat8RVQhi075cO3BzZbO7LqlhkluYl+HJvVQmxgwkTyPziFzJ6mwnvdA+8QiLOOID1MgFC0zWBSbTIJnB41cPXtx0cDzlt6+LUvm0yCPfV3m3088++pvCjdni/P/WccU2HO/9frjE2fpgZagMr+ffNLM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFyAuImh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720581817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DZswbjLB1y8lw7MUcnotzFxNVGtfWvLFPzmA3BKP3mY=;
	b=XFyAuImhsZZy3O5BjmveGFVwRKL9leSVzy3rreU+enzfl+UuJ+dISPmqGEmoqLC0inzCg6
	QEtGli62XAo6YJPgo+mLyLC61B6KWB/qjQi9ycGAZRrH9CNmQ0Da/IRcvPAVWtiJg3OgfG
	ZVYBR+lV4hWyDt6Z5koZ3xSeU2IPXUA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-ZSkWDXT7OaOqIa4rspBxcw-1; Tue, 09 Jul 2024 23:23:35 -0400
X-MC-Unique: ZSkWDXT7OaOqIa4rspBxcw-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3d929d7a90bso2791071b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 20:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581815; x=1721186615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZswbjLB1y8lw7MUcnotzFxNVGtfWvLFPzmA3BKP3mY=;
        b=M6wPK+G/jDgR/gnIEOiCbbCFrZ1fJToEngTT1hX6zeThtaZ764ahgBo8rM2mQqTEy8
         WEHTGYX7Eo2ay6/HVCQQuW85fKty8xJL0mPm3Nnq83VdMhqDxpjDFGNmXjkeFWh19oXT
         cdCkkLVS0zM5VO6VJJDqn0ZOdJmwji135s9AfIqFblIUUG1crbYRvGfQpis26Ly1nfdA
         DUq/qdzDMJUgcSf679OyeM6AYui0WtVqSKggOI2hAKfTAkLfNrTofjsodUPhuUiltX5u
         bkHY5xPZdy8Dm8QTyA3tcrRVBEaNvJ1gC1R3oFumBZ6u1s5/F3WuZJnoIiqV4EXF9A1o
         PpmQ==
X-Gm-Message-State: AOJu0Yx7juj5c+xCGM9PhtrZwaQc4D+U6KKTlBRN53m/zUvBtZympFp+
	o1obcocBQstYNJBjUpSZ6ccvPIckW0JxpbV65porlPkbMLXPJPQKMfTbwg6AYSZ8/WbHsAynBFg
	3SlzCunIl82PkJ46Q6oTVpB3xHU+rvg/XIEc99ggaWjW1xWl5M+SNiPgYMbOdaHy+/xOgYlfBAT
	Vn7KCp6t9QhICpdG2S3a9tv48k5+sBO12jcToZ
X-Received: by 2002:a05:6808:1206:b0:3d9:26ad:dad0 with SMTP id 5614622812f47-3d93c10b44amr4356483b6e.57.1720581814709;
        Tue, 09 Jul 2024 20:23:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE32zqWgi+EMG3PGXtiSEfre0Nfibo0rJwV8l+r+oMHEMd8b/xBj0gNNkQMlOQ2EwwZHEb7fC5I6r3y5AIPyHI=
X-Received: by 2002:a05:6808:1206:b0:3d9:26ad:dad0 with SMTP id
 5614622812f47-3d93c10b44amr4356470b6e.57.1720581814359; Tue, 09 Jul 2024
 20:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720173841.git.mst@redhat.com> <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
In-Reply-To: <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 10 Jul 2024 11:23:20 +0800
Message-ID: <CACGkMEtszy1YNB1KAtXVdYFkythWDfrYR+w6CSBAQWV1NCc3hA@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 6:09=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> QEMU implemented the configuration
>         VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
> incorrectly: it then uses vq3 for reporting, spec says it is always 4.
>
> This is masked by a corresponding bug in driver:
> add a work around as I'm going to try and fix the driver bug.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 9a61febbd2f7..7dc3fcd56238 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
>
>         err =3D virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>                               callbacks, names, NULL);
> -       if (err)
> -               return err;
> +       if (err) {
> +               /*
> +                * Try to work around QEMU bug which since 2020 confused =
vq numbers
> +                * when VIRTIO_BALLOON_F_REPORTING but not
> +                * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> +                */
> +               if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTI=
NG) &&
> +                   !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_P=
AGE_HINT)) {
> +                       names[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D "reporting=
_vq";
> +                       callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] =3D balloo=
n_ack;
> +                       err =3D virtio_find_vqs(vb->vdev,
> +                                             VIRTIO_BALLOON_VQ_REPORTING=
, vqs, callbacks, names, NULL);
> +               }
> +
> +               if (err)
> +                       return err;
> +       }
>
>         vb->inflate_vq =3D vqs[VIRTIO_BALLOON_VQ_INFLATE];
>         vb->deflate_vq =3D vqs[VIRTIO_BALLOON_VQ_DEFLATE];
> --
> MST
>

Acked-by: Jason Wang <jasowang@redhat.com>

Do we need a spec to say this is something that needs to be considered
by the driver?

Thanks


