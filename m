Return-Path: <linux-kernel+bounces-221376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A676790F2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A711F27674
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C17D156256;
	Wed, 19 Jun 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOdrZtS6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21E15217F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811763; cv=none; b=fgPf+1SsaJgKkG6NdGDeTj75OTUcbeVF0jADcCRNwZYEN7PsZn70guLa8lmiCCiJHrzyc4j16SYpnFvFbY9krKkce6nDZ79fRThRYoceHm2vREPjzUjpqIDVkjCcbydQcDMQi/6PTtqN8lJdShyemtLv5Jrm+4/BacjLinhXCIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811763; c=relaxed/simple;
	bh=r3S0o9Uy+b0Ct4Au4E+urxDBNo11gsW0f6e+kbvt6Lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4SFwDBL1mzvM5FrcueA1fNEAsxyt6qJkWZGOYwnAJbBDcuZx309YtIkOeXuFoHEn95r0B1dvAFKK6/9jA57nsirXHLVr4nCpxIx85j433y+dkP1pAlEeo1r+ziNccWCSXveBLXAes7W5HbntG8J7pv7HyD8eZNHr3eOs8VNRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FOdrZtS6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718811757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWeCp7im8c0vN79ATol7MWl+xsx12ADLqXIpUJMFdcQ=;
	b=FOdrZtS6OhNjn9zh1pR1htx96kLiM4LEQGmiEdLud0YmgThFBmpWjrwsZbsE2kSsmrSuEp
	JB8UWW91QI1VfXchE7SIS5hPBwopCZkJf8kExjE2C+d0SwTs5gst2Up3vlKdEyJ49ATq5c
	zlCh6AiWzHvU+tvV02nT5Upm+whZUXI=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-2pMIWkYwN--l0qQ_pXV9zg-1; Wed, 19 Jun 2024 11:42:36 -0400
X-MC-Unique: 2pMIWkYwN--l0qQ_pXV9zg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-63bca8ce79eso2376337b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718811755; x=1719416555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mWeCp7im8c0vN79ATol7MWl+xsx12ADLqXIpUJMFdcQ=;
        b=CjFy8ogsb3qGvN0Bhheto/gf3teYl6iOqxc8vjkQh6e5Q3HOiVmHNdUolKZRBA7/8I
         jj9ce5RBb2uRsSo0D4E2W/QTu664O2dLHmaWMbpGzg0/TR8RtCH06TctFZvHmXBHKscZ
         g69cR4GzE9V0Sx2VfKz4xS7iXz4ZyjfmAfYMPu5pdNdlx6uxWZwc18nDLv64uuFBVqql
         a86EyEYZD8GRmIsWV0eBAjhXG3/uXaJUaRWNB6dEx0RnXzto31VD6L3i3/Dw+NpKVdwP
         i8Vw/VslczlSfAXczVcCqZQG2JajNqL2GSZ5g/nwBw2AHAZFT+UPJFq7ZwsIfQhMC8Ae
         iDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVL/lztIK8EEmiExDMsg/ZOE+3PZt4QGSLZsLKzmg0iE/sMn1gWJbd2mYE9H5xpaC6UoCf3xjBjh8uTRWi2t7By72oy5wVp/B3n6Eid
X-Gm-Message-State: AOJu0YzbBTUWWkmyL7vxFh5/VczUJ9kRO+VhuCRaUAQWQKYVv2UUiKsj
	o97iJ317XZNbV0lSQJQyACmXuve6wmqFXOvtxbDep97JQwoBnA1/yFY6WlKFAPsS7e9XkkytOpL
	qf6ckAqTF+dmPEEvd8iLzPCDtMZjRk5/d0bwpczT3ZKnonXiAEkivCDGyHNFWxS4znrmBxlf1nN
	tZnRkqI2SGCnixCGgaR9Hc3FJ0CHWoYVPg87RG
X-Received: by 2002:a25:5f48:0:b0:dfa:e6fc:f4f with SMTP id 3f1490d57ef6-e02be0ff385mr3237930276.3.1718811755577;
        Wed, 19 Jun 2024 08:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYFnJHqbL6C9lWb1iUUgLw7ce3DxBh86jcwt8SSK5e/nf2ez29b1wrV7XJN9GS5D+7kcL73Lq48K7ceY8ocnE=
X-Received: by 2002:a25:5f48:0:b0:dfa:e6fc:f4f with SMTP id
 3f1490d57ef6-e02be0ff385mr3237912276.3.1718811755205; Wed, 19 Jun 2024
 08:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com> <20240617-stage-vdpa-vq-precreate-v1-16-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-16-8c0483f0ca2a@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 19 Jun 2024 17:41:58 +0200
Message-ID: <CAJaqyWeoX8iPahvJutHi=r6UyB-z6gqp0QaYUyJz4GxNiORnfg@mail.gmail.com>
Subject: Re: [PATCH vhost 16/23] vdpa/mlx5: Add error code for suspend/resume VQ
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Instead of blindly calling suspend/resume_vqs(), make then return error
> codes.
>
> To keep compatibility, keep suspending or resuming VQs on error and
> return the last error code. The assumption here is that the error code
> would be the same.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 77 +++++++++++++++++++++++++++------=
------
>  1 file changed, 54 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index e4d68d2d0bb4..e3a82c43b44e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1526,71 +1526,102 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
>         return err;
>  }
>
> -static void suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virt=
queue *mvq)
> +static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
>  {
>         struct mlx5_virtq_attr attr;
> +       int err;
>
>         if (!mvq->initialized)
> -               return;
> +               return 0;
>
>         if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
> -               return;
> +               return 0;
>
> -       if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_SUSPEND))
> -               mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed\n"=
);
> +       err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJEC=
T_STATE_SUSPEND);
> +       if (err) {
> +               mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed, e=
rr: %d\n", err);
> +               return err;
> +       }
>
> -       if (query_virtqueue(ndev, mvq, &attr)) {
> -               mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue\n=
");
> -               return;
> +       err =3D query_virtqueue(ndev, mvq, &attr);
> +       if (err) {
> +               mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue, =
err: %d\n", err);
> +               return err;
>         }
> +
>         mvq->avail_idx =3D attr.available_index;
>         mvq->used_idx =3D attr.used_index;
> +
> +       return 0;
>  }
>
> -static void suspend_vqs(struct mlx5_vdpa_net *ndev)
> +static int suspend_vqs(struct mlx5_vdpa_net *ndev)
>  {
> +       int err =3D 0;
>         int i;
>
> -       for (i =3D 0; i < ndev->cur_num_vqs; i++)
> -               suspend_vq(ndev, &ndev->vqs[i]);
> +       for (i =3D 0; i < ndev->cur_num_vqs; i++) {
> +               int local_err =3D suspend_vq(ndev, &ndev->vqs[i]);
> +
> +               err =3D local_err ? local_err : err;
> +       }
> +
> +       return err;
>  }
>
> -static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
> +static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqu=
eue *mvq)
>  {
> +       int err;
> +
>         if (!mvq->initialized)
> -               return;
> +               return 0;
>
>         switch (mvq->fw_state) {
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
>                 /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
>                  * This should be fixed soon. After that, a single comman=
d can be used.
>                  */
> -               if (modify_virtqueue(ndev, mvq, 0))
> +               err =3D modify_virtqueue(ndev, mvq, 0);
> +               if (err) {
>                         mlx5_vdpa_warn(&ndev->mvdev,
> -                               "modify vq properties failed for vq %u\n"=
, mvq->index);
> +                               "modify vq properties failed for vq %u, e=
rr: %d\n",
> +                               mvq->index, err);
> +                       return err;
> +               }
>                 break;
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
>                 if (!is_resumable(ndev)) {
>                         mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resuma=
ble\n", mvq->index);
> -                       return;
> +                       return -EINVAL;
>                 }
>                 break;
>         case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
> -               return;
> +               return 0;
>         default:
>                 mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from ba=
d state %d\n",
>                                mvq->index, mvq->fw_state);
> -               return;
> +               return -EINVAL;
>         }
>
> -       if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_RDY))
> -               mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for=
 vq %u\n", mvq->index);
> +       err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJEC=
T_STATE_RDY);
> +       if (err)
> +               mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for=
 vq %u, err: %d\n",
> +                              mvq->index, err);
> +
> +       return err;
>  }
>
> -static void resume_vqs(struct mlx5_vdpa_net *ndev)
> +static int resume_vqs(struct mlx5_vdpa_net *ndev)
>  {
> -       for (int i =3D 0; i < ndev->cur_num_vqs; i++)
> -               resume_vq(ndev, &ndev->vqs[i]);
> +       int err =3D 0;
> +
> +       for (int i =3D 0; i < ndev->cur_num_vqs; i++) {
> +               int local_err =3D resume_vq(ndev, &ndev->vqs[i]);
> +
> +               err =3D local_err ? local_err : err;
> +       }
> +
> +       return err;
>  }
>
>  static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_vir=
tqueue *mvq)
>
> --
> 2.45.1
>


