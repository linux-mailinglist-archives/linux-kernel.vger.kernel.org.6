Return-Path: <linux-kernel+bounces-400130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3D19C0956
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E11C23853
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAECF212F0E;
	Thu,  7 Nov 2024 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crhZTEyD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E3212EE0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991153; cv=none; b=XqXQgi2Dw5xJGBUOWyPL8QgaBZ0Nao7Li+cBZIQwEKDSnkuBnjLMIslJ7XnP6dH1Uroyts2gRtLrhDrt7RoKqpF8Yc7d8Duqfi9hzX3LumYo/NDChkZzm5xw4a2P0/yCY9diwIkofI1m2PKGZTyWxIydG0A5MoJjfp0jbAc8ZIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991153; c=relaxed/simple;
	bh=XVF/x0LDlBb9yXRs1bVbTtLmrXmFrENkF+22J4yL8ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQylKlfR9ezK2N/fr9Odo/tVUnd7cbvOvp08BjxqCY3m0hTo6o2I/gs5Wi39j3H2bMyxQ4q/Q2MCUn0fDjj8wCsUbtyHad5ZfCwTReMDPh7uGZkOJCQBzJPwS74v4PdAfP4o/Zmyzm+VeFeqquGW2X1TwtXnV5O/MYej9Hb7H0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crhZTEyD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730991150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Ff04YcLV8SPdoJxeVSiu4v58xp2P44LYVgJtEbYZ2A=;
	b=crhZTEyDa69Fh/WYoVhBGAteI5MYHphmFLkJ9/w8Np02X8Z3H4gn+9qP7CbfxVS6uuzGWt
	T0AVz/QZSaGwQtyGRSKuBW2zyFf/F6+GNn6oBK1nSt5sumemd3e8CETzTokX43wjb2Uq04
	kOo1RCFhskEe/5oqYsIYS9JJcBy6yhs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-nkuz38ClMAe2vJ0b-6ZDCA-1; Thu, 07 Nov 2024 09:52:29 -0500
X-MC-Unique: nkuz38ClMAe2vJ0b-6ZDCA-1
X-Mimecast-MFC-AGG-ID: nkuz38ClMAe2vJ0b-6ZDCA
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-6eac7417627so19047717b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:52:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730991149; x=1731595949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ff04YcLV8SPdoJxeVSiu4v58xp2P44LYVgJtEbYZ2A=;
        b=Nq7lHi0CZEw7EA708MNoKT6cN7R2JRK2avpURO9CYzRy94M3ftBzZcOkh1Gk6Y8xvy
         zm9rzplg5ARSMo8DcWuTAjYlqsTy6RJ1bCXODRNJJ7wGnpJu8GjiyAAmEYqNtSlE3wW/
         wkP5cZvB2qRE1PVn54sSBluPwxzDVDBcZVIlhIIiNL1304EVBAOnTIebntST0aEAmlpF
         lUffwyvTZBH+r2BZCFh8/LGaxTF4A3PoZyjy2SDNkvSSUPousoENNyedvLx+9m+TlkzM
         H38Hjo3X/9I4vkv5A57uWd9EQy4XmW2DRCkZSUWdsA9jwNIbENxYd8LXYTkjGIPjpeKU
         /zsg==
X-Forwarded-Encrypted: i=1; AJvYcCXe6iW+z0cC/cVRKIo5t2dk+amzrWua3kTnE+Ru3MnLT7CNMDffC2a78g0PTcJbbBAGdxPmx8Ia+9zFQPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIi7uYCpwi4OArKoEv+GXfEXGeHRpcCSEaSdtlNYVTg+5gSn2B
	6KQO7pPGLzFrc/WnEq1h5w4h8LevOU5rFrjCuysy/EC1efU2ZiYiEGjU+A4asdGm7oQMhG9NM+x
	iz39//bbIQprWr43bAkiu+GtY/JIJ3ruJgNsl6mLsylvD74TOYk2FV4sk32iXHRkO8h8FAIqdCI
	ztq38IskKxKNiK7CQ+1Pt6nyqMpV5cAWTEWVU+
X-Received: by 2002:a05:690c:460e:b0:6e2:c13e:20e9 with SMTP id 00721157ae682-6e9d8b056ddmr313422987b3.38.1730991148932;
        Thu, 07 Nov 2024 06:52:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYqvt7/lT13XxcBmf4h4l8ghmjNiRZf2d8+XdMbFjM2u7ezJTrQtXi3YGHHMc7lpnFy6cI9XHQYWgxd3fJnwI=
X-Received: by 2002:a05:690c:460e:b0:6e2:c13e:20e9 with SMTP id
 00721157ae682-6e9d8b056ddmr313422887b3.38.1730991148691; Thu, 07 Nov 2024
 06:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107132114.22188-1-colin.i.king@gmail.com>
In-Reply-To: <20241107132114.22188-1-colin.i.king@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Nov 2024 15:51:52 +0100
Message-ID: <CAJaqyWcp2kbm9uwzqPXi-M3AUT3P54az8SLHv0Ex7HpM7zHHhA@mail.gmail.com>
Subject: Re: [PATCH][next] virtio_vdpa: remove redundant check on desc
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtualization@lists.linux.dev, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:21=E2=80=AFPM Colin Ian King <colin.i.king@gmail.c=
om> wrote:
>
> The boolean variable has_affinity is true when desc is non-null and
> ops->set_vq_affinity is non-null. Hence the call to create_affinity_masks
> does not need to check for desc being non-null is redundant when
> has_affinity is true, so it can be removed as well as the now unused
> default_affd.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 7364bd53e38d..1f60c9d5cb18 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -364,14 +364,13 @@ static int virtio_vdpa_find_vqs(struct virtio_devic=
e *vdev, unsigned int nvqs,
>         struct virtio_vdpa_device *vd_dev =3D to_virtio_vdpa_device(vdev)=
;
>         struct vdpa_device *vdpa =3D vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops =3D vdpa->config;
> -       struct irq_affinity default_affd =3D { 0 };
>         struct cpumask *masks;
>         struct vdpa_callback cb;
>         bool has_affinity =3D desc && ops->set_vq_affinity;
>         int i, err, queue_idx =3D 0;
>
>         if (has_affinity) {
> -               masks =3D create_affinity_masks(nvqs, desc ? desc : &defa=
ult_affd);
> +               masks =3D create_affinity_masks(nvqs, desc);
>                 if (!masks)
>                         return -ENOMEM;
>         }
> --
> 2.39.5
>


