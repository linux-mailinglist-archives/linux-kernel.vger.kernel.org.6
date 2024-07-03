Return-Path: <linux-kernel+bounces-239801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B7926582
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D7FB23640
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AFE181D00;
	Wed,  3 Jul 2024 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2UkmPbZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AC181CEB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022562; cv=none; b=gWIth2kFNMsroAZxU7btEF+z3qjZKQutkcek51GN6eVPIcDKIs1gANgvSrnNLQBxGfDDIedMiWmNI4XR6yra77r2PB8VwzVc+z9rjY7nytuIj987Na0q+M9+/NlFy9p8SEAgiPZYfTH00jx9U/HShebLVJji1QdZxqsEuspnmAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022562; c=relaxed/simple;
	bh=6L9NY57jmpj8sQ+NfzV23lGrMZsexvRx3xhnQCcLgdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWMm1O2lpg7+zJmcziUZDUBhl8zcFvdJDpOaimn8fWMeMlCSCS8tggpCYJZ5jtfUorQ3c1I/ucjCptzK9q65FeghftJVk4VNpuAeFJAFLgngxK5qrzwoGs48k31YN1V/hNZN/6vLlnKv5wGQ455B+YuqaPBvHfa4qtviGgCgZCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2UkmPbZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720022559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cZYZWG6Pe+QgIPXlNlnU44T2JexrvRdPhkV7V2BNno=;
	b=T2UkmPbZIrq6w5FiSE/UjxBQW0A4DuO+ddQs7ZOYo5S7LVTwz6tgaumFbPitSn8l9lwDZB
	+O+UWNtKS7E39gryeEoaYq98C9l51jGOo2n5dtGUsyh58L1DCY0KX4voX8Ntn0/bqhblPX
	X5PteRCkV3znHZvSuKg1g7Vpx9boCmI=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-krB-Cv2WMr-H4kJBj1TMbg-1; Wed, 03 Jul 2024 12:02:38 -0400
X-MC-Unique: krB-Cv2WMr-H4kJBj1TMbg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6501bac2d6aso9199707b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720022557; x=1720627357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cZYZWG6Pe+QgIPXlNlnU44T2JexrvRdPhkV7V2BNno=;
        b=NW9NHDSB2yprdbtsXZJlDzYWCyfvfPWALzJJxp3KtkyZOd0SQtdIQD9m2JUbMxmhnj
         SMspf/8UOv+r0H3M6cD06X1/RgX7v4SE3Boktuk00xsow59i7NcFCWNlMZRbT4P/ZV8n
         8fOG8Z25UeiDSSdIJswtOsS2Oq+yOZnx4Cbu48Erg7ry4SFEnnou4IBY4vXkjVynTQHq
         xZcqlpPDzS79QacFMBzXmpWDr+OR0RCFV2oe62mbtPIxHFxBST7UPJema0G02fkTmETG
         1gkD/7bzYtaK6w221bWUrL9KmV40OxESBeBtMf6FDySgchD87Gz0Lxq4NblMzWFpsIV2
         OSoA==
X-Forwarded-Encrypted: i=1; AJvYcCUh3fZ/1vJrRw9iGOtpUZlTsWCmbaMi0Otawu7/fCkLX200pYt2ycx7qe1sxToBlGF/jKnBbgDwRTYDQsi9tzi95PEgAguRSmd/gfaL
X-Gm-Message-State: AOJu0YzgeA9fjxhlInIkSfPf8f5rfak5ujm8ECo7m7fOJzPSKx7Oy9Vk
	wUON1XwGQnYgkAuIOx+HEQLGpl1MlFEhHq9RIZh45A/Q34VyOfEsKFEIkymxvvPS0x26mvDZM9U
	KkE8nkybJT2S7iC86XHJheYH68+MW37ReAcBwro5mRyS64ecQOa5OgtvxgxLPMm/uEGLBfgz57G
	KwQQqlUZVLC4HMjpwEgAJg44BSc7PyxJm0rf0z
X-Received: by 2002:a05:690c:680f:b0:651:ee07:76c with SMTP id 00721157ae682-651ee07079bmr10340117b3.15.1720022555404;
        Wed, 03 Jul 2024 09:02:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJEOD0j6Fdz3pMKQ3JW6XMwPwyu8ibTc12rO5h2L/BNg/OImtMoNq9K9CCxxA4ZFtP+3+hN3kt2OxZI51fJeQ=
X-Received: by 2002:a05:690c:680f:b0:651:ee07:76c with SMTP id
 00721157ae682-651ee07079bmr10339557b3.15.1720022554801; Wed, 03 Jul 2024
 09:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
 <20240617-stage-vdpa-vq-precreate-v1-20-8c0483f0ca2a@nvidia.com>
 <CAJaqyWd3yiPUMaGEmzgHF-8u+HcqjUxBNB3=Xg6Lon-zYNVCow@mail.gmail.com> <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
In-Reply-To: <308f90bb505d12e899e3f4515c4abc93c39cfbd5.camel@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:01:58 +0200
Message-ID: <CAJaqyWeHDD0drkAZQqEP_ZfbUPscOmM7T8zXRie5Q14nfAV0sg@mail.gmail.com>
Subject: Re: [PATCH vhost 20/23] vdpa/mlx5: Pre-create hardware VQs at vdpa
 .dev_add time
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, Tariq Toukan <tariqt@nvidia.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, 
	"si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"mst@redhat.com" <mst@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "leon@kernel.org" <leon@kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 11:27=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> On Wed, 2024-06-19 at 17:54 +0200, Eugenio Perez Martin wrote:
> > On Mon, Jun 17, 2024 at 5:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia=
.com> wrote:
> > >
> > > Currently, hardware VQs are created right when the vdpa device gets i=
nto
> > > DRIVER_OK state. That is easier because most of the VQ state is known=
 by
> > > then.
> > >
> > > This patch switches to creating all VQs and their associated resource=
s
> > > at device creation time. The motivation is to reduce the vdpa device
> > > live migration downtime by moving the expensive operation of creating
> > > all the hardware VQs and their associated resources out of downtime o=
n
> > > the destination VM.
> > >
> > > The VQs are now created in a blank state. The VQ configuration will
> > > happen later, on DRIVER_OK. Then the configuration will be applied wh=
en
> > > the VQs are moved to the Ready state.
> > >
> > > When .set_vq_ready() is called on a VQ before DRIVER_OK, special care=
 is
> > > needed: now that the VQ is already created a resume_vq() will be
> > > triggered too early when no mr has been configured yet. Skip calling
> > > resume_vq() in this case, let it be handled during DRIVER_OK.
> > >
> > > For virtio-vdpa, the device configuration is done earlier during
> > > .vdpa_dev_add() by vdpa_register_device(). Avoid calling
> > > setup_vq_resources() a second time in that case.
> > >
> >
> > I guess this happens if virtio_vdpa is already loaded, but I cannot
> > see how this is different here. Apart from the IOTLB, what else does
> > it change from the mlx5_vdpa POV?
> >
> I don't understand your question, could you rephrase or provide more cont=
ext
> please?
>

My main point is that the vdpa parent driver should not be able to
tell the difference between vhost_vdpa and virtio_vdpa. The only
difference I can think of is because of the vhost IOTLB handling.

Do you also observe this behavior if you add the device with "vdpa
add" without the virtio_vdpa module loaded, and then modprobe
virtio_vdpa?

At least the comment should be something in the line of "If we have
all the information to initialize the device, pre-warm it here" or
similar.

> Thanks,
> Dragos
>
> > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 37 +++++++++++++++++++++++++++++=
+++-----
> > >  1 file changed, 32 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/ne=
t/mlx5_vnet.c
> > > index 249b5afbe34a..b2836fd3d1dd 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -2444,7 +2444,7 @@ static void mlx5_vdpa_set_vq_ready(struct vdpa_=
device *vdev, u16 idx, bool ready
> > >         mvq =3D &ndev->vqs[idx];
> > >         if (!ready) {
> > >                 suspend_vq(ndev, mvq);
> > > -       } else {
> > > +       } else if (mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) {
> > >                 if (resume_vq(ndev, mvq))
> > >                         ready =3D false;
> > >         }
> > > @@ -3078,10 +3078,18 @@ static void mlx5_vdpa_set_status(struct vdpa_=
device *vdev, u8 status)
> > >                                 goto err_setup;
> > >                         }
> > >                         register_link_notifier(ndev);
> > > -                       err =3D setup_vq_resources(ndev, true);
> > > -                       if (err) {
> > > -                               mlx5_vdpa_warn(mvdev, "failed to setu=
p driver\n");
> > > -                               goto err_driver;
> > > +                       if (ndev->setup) {
> > > +                               err =3D resume_vqs(ndev);
> > > +                               if (err) {
> > > +                                       mlx5_vdpa_warn(mvdev, "failed=
 to resume VQs\n");
> > > +                                       goto err_driver;
> > > +                               }
> > > +                       } else {
> > > +                               err =3D setup_vq_resources(ndev, true=
);
> > > +                               if (err) {
> > > +                                       mlx5_vdpa_warn(mvdev, "failed=
 to setup driver\n");
> > > +                                       goto err_driver;
> > > +                               }
> > >                         }
> > >                 } else {
> > >                         mlx5_vdpa_warn(mvdev, "did not expect DRIVER_=
OK to be cleared\n");
> > > @@ -3142,6 +3150,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_d=
evice *vdev, u32 flags)
> > >                 if (mlx5_vdpa_create_dma_mr(mvdev))
> > >                         mlx5_vdpa_warn(mvdev, "create MR failed\n");
> > >         }
> > > +       setup_vq_resources(ndev, false);
> > >         up_write(&ndev->reslock);
> > >
> > >         return 0;
> > > @@ -3836,8 +3845,21 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_=
dev *v_mdev, const char *name,
> > >                 goto err_reg;
> > >
> > >         mgtdev->ndev =3D ndev;
> > > +
> > > +       /* For virtio-vdpa, the device was set up during device regis=
ter. */
> > > +       if (ndev->setup)
> > > +               return 0;
> > > +
> > > +       down_write(&ndev->reslock);
> > > +       err =3D setup_vq_resources(ndev, false);
> > > +       up_write(&ndev->reslock);
> > > +       if (err)
> > > +               goto err_setup_vq_res;
> > > +
> > >         return 0;
> > >
> > > +err_setup_vq_res:
> > > +       _vdpa_unregister_device(&mvdev->vdev);
> > >  err_reg:
> > >         destroy_workqueue(mvdev->wq);
> > >  err_res2:
> > > @@ -3863,6 +3885,11 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt=
_dev *v_mdev, struct vdpa_device *
> > >
> > >         unregister_link_notifier(ndev);
> > >         _vdpa_unregister_device(dev);
> > > +
> > > +       down_write(&ndev->reslock);
> > > +       teardown_vq_resources(ndev);
> > > +       up_write(&ndev->reslock);
> > > +
> > >         wq =3D mvdev->wq;
> > >         mvdev->wq =3D NULL;
> > >         destroy_workqueue(wq);
> > >
> > > --
> > > 2.45.1
> > >
> >
>


