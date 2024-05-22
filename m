Return-Path: <linux-kernel+bounces-185730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9338CB9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5659B21141
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CC274BE0;
	Wed, 22 May 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcUJboQP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13D560BBE
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716349270; cv=none; b=DihfZUezuRVgqs2PYeh5wHEMc0YS2oDs2GwuJIWKu8awXAQiLwJ7dwKv+ABC1DMsdvxVtgDzUb9iOjmgouMeFmqm+LLHc0tWaFDSXgL6a+yaO/pq4tIkz4l8J7aT/QD31m5B4DEwBGVfl1e3ZBO3EfuwNksqqeOAkAw0X5Veil4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716349270; c=relaxed/simple;
	bh=fAjHmMPI9BjcKrbZj23D72c/rUSBc/IAX+hDIpozsB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lees4Mr6QLg7s10C4tjAzBkHl0gxjNjp9ITdwhnj9353GtWFViPOLVSrEjV6ECxAtXxIsBfDYT4x3JQWCLlLuzdYOwyOpUFGSY2632EdNbEZTAAs13TfeA0Idu7s1+4640cJNQ/j3N7b8yS17LzIuR8OcprVppSD06mHqZ8FrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QcUJboQP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716349263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8S3Gid4+HHyOby23oKkItTJxpdYfB0tmiZc2RtKlOLQ=;
	b=QcUJboQP/0+KWyMu2WFuLlzkEyAe9MINSnSodaMYlZYzKnCcia6btcpDorP7UOxfPNMkY+
	8/+L8HERmMuDj0VG+yEFMtCEQOJk3NhQFEh1pt+6rP3XEzIcU3d/vrHorXiizvWd89OkBG
	JK8DG/5fi5ZdFuFnfuqYVtpFtoYcAnk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-whn6WNbKODaL6fNwPcPxFA-1; Tue, 21 May 2024 23:41:02 -0400
X-MC-Unique: whn6WNbKODaL6fNwPcPxFA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2b34facb83aso12949101a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 20:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716349261; x=1716954061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8S3Gid4+HHyOby23oKkItTJxpdYfB0tmiZc2RtKlOLQ=;
        b=MWv3UlZjEvyworAeCVDeFZKe1YzpeRo/XgWOleVVew2wfs4KmyZs9aYdGIb3PJMgeG
         DoTYzVHH9RF1+hPyj+huj2ddpC978d6iYozS6NJ3U72lR7DqO5nnPXoWKQ8hQX5ClJEr
         7Rt6PAgGmnLg2Hr0MaVFQ60LJDjkIgJC3XiaDlh2S7DiFqR8p+Tpfo01AwkcotMrv5n+
         ZA2b2wJRHUKxJ2Bi+NG+llkTsvb3wmhnTT/vW97Miacs8Lfvr9qJzkI99NMAmLa1koeR
         TlWHbOl+gnG5TwbgxUg3aGvKTc70ZX4IPTldR3vxRUVxLWyRdtg4+U/SGftWadKEtqAP
         96HQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3LlrU6NI5hOpkz6vVV+9GN4xsR/4KQRPXZGgEnM29if+NxSD0hWFb7l+RIQYijyTd9BvrK/Iqc35Bah8G9aDkFCLy0liqkt3pT4fh
X-Gm-Message-State: AOJu0YwjdD0BoUSOcR0RUy79bP919C7nTRxhWtFPnBYMbDsv1aWHhZAi
	3HMB77Stl6L5Io15jDodA/x9Vj0o58UEF1F1ErH0T9yXEjv+3QFMlfs/U45pVdzuEhWB3cEP0Vk
	WSir3pYDiPBPwzX9z4ZQsJzEb3KorAPNgYHXZ4f03EzBU2jms2Ry6D1FWssdJEA+ihAH7ZZV+2o
	E1ZXfmAiUYC7CEnf/ob1KVBwPaY5peiIwl6p95
X-Received: by 2002:a17:90a:d608:b0:2b4:32ae:9932 with SMTP id 98e67ed59e1d1-2bd9f489a59mr924138a91.17.1716349260999;
        Tue, 21 May 2024 20:41:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyGlRV9Te14odh1WiHeDE1DeZgFbjBkjl9hPq8vAGxQEAtuBhP/TUWMA2lvNVxJdKHHffm6JzFMhfzwA8FnWY=
X-Received: by 2002:a17:90a:d608:b0:2b4:32ae:9932 with SMTP id
 98e67ed59e1d1-2bd9f489a59mr924124a91.17.1716349260637; Tue, 21 May 2024
 20:41:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1716218462-84587-1-git-send-email-steven.sistare@oracle.com>
 <1716218462-84587-3-git-send-email-steven.sistare@oracle.com>
 <CACGkMEtfjHzdBBwgUWgRHDc5opekvgTuXp-_z4ku6L5cqOeAJA@mail.gmail.com> <b55cccfc-67b0-4f21-9070-127af6fd07a7@oracle.com>
In-Reply-To: <b55cccfc-67b0-4f21-9070-127af6fd07a7@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 22 May 2024 11:40:49 +0800
Message-ID: <CACGkMEu4WZnqcTPyq566X5aWL-mL1KSR7XWoTKq5AU0mSsB9_A@mail.gmail.com>
Subject: Re: [PATCH V3 2/3] vduse: suspend
To: Steven Sistare <steven.sistare@oracle.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Eugenio Perez Martin <eperezma@redhat.com>, Xie Yongji <xieyongji@bytedance.com>, 
	Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 9:39=E2=80=AFPM Steven Sistare
<steven.sistare@oracle.com> wrote:
>
> On 5/20/2024 10:30 PM, Jason Wang wrote:
> > On Mon, May 20, 2024 at 11:21=E2=80=AFPM Steve Sistare
> > <steven.sistare@oracle.com> wrote:
> >>
> >> Support the suspend operation.  There is little to do, except flush to
> >> guarantee no workers are running when suspend returns.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>   drivers/vdpa/vdpa_user/vduse_dev.c | 24 ++++++++++++++++++++++++
> >>   1 file changed, 24 insertions(+)
> >>
> >> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_us=
er/vduse_dev.c
> >> index 73c89701fc9d..7dc46f771f12 100644
> >> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> >> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> >> @@ -472,6 +472,18 @@ static void vduse_dev_reset(struct vduse_dev *dev=
)
> >>          up_write(&dev->rwsem);
> >>   }
> >>
> >> +static void vduse_flush_work(struct vduse_dev *dev)
> >> +{
> >> +       flush_work(&dev->inject);
> >> +
> >> +       for (int i =3D 0; i < dev->vq_num; i++) {
> >> +               struct vduse_virtqueue *vq =3D dev->vqs[i];
> >> +
> >> +               flush_work(&vq->inject);
> >> +               flush_work(&vq->kick);
> >> +       }
> >> +}
> >> +
> >>   static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 i=
dx,
> >>                                  u64 desc_area, u64 driver_area,
> >>                                  u64 device_area)
> >> @@ -724,6 +736,17 @@ static int vduse_vdpa_reset(struct vdpa_device *v=
dpa)
> >>          return ret;
> >>   }
> >>
> >> +static int vduse_vdpa_suspend(struct vdpa_device *vdpa)
> >> +{
> >> +       struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >> +
> >> +       down_write(&dev->rwsem);
> >> +       vduse_flush_work(dev);
> >> +       up_write(&dev->rwsem);
> >
> > Can this forbid the new work to be scheduled?
>
> Are you suggesting I return an error below if the dev is suspended?
> I can do that.

I mean the irq injection work can still be scheduled after vduse_vdpa_suspe=
nd().

>
> However, I now suspect this implementation of vduse_vdpa_suspend is not
> complete in other ways, so I withdraw this patch pending future work.
> Thanks for looking at it.

Ok.

Thanks

>
> - Steve
>
> > static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> >                                      struct work_struct *irq_work,
> >                                      int irq_effective_cpu)
> > {
> >          int ret =3D -EINVAL;
> >
> >          down_read(&dev->rwsem);
> >          if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> >                  goto unlock;
> >
> >          ret =3D 0;
> >          if (irq_effective_cpu =3D=3D IRQ_UNBOUND)
> >                  queue_work(vduse_irq_wq, irq_work);
> >          else
> >                  queue_work_on(irq_effective_cpu,
> >                        vduse_irq_bound_wq, irq_work);
> > unlock:
> >          up_read(&dev->rwsem);
> >
> >          return ret;
> > }
> >
> > Thanks
> >
> >> +
> >> +       return 0;
> >> +}
> >> +
> >>   static u32 vduse_vdpa_get_generation(struct vdpa_device *vdpa)
> >>   {
> >>          struct vduse_dev *dev =3D vdpa_to_vduse(vdpa);
> >> @@ -806,6 +829,7 @@ static const struct vdpa_config_ops vduse_vdpa_con=
fig_ops =3D {
> >>          .set_vq_affinity        =3D vduse_vdpa_set_vq_affinity,
> >>          .get_vq_affinity        =3D vduse_vdpa_get_vq_affinity,
> >>          .reset                  =3D vduse_vdpa_reset,
> >> +       .suspend                =3D vduse_vdpa_suspend,
> >>          .set_map                =3D vduse_vdpa_set_map,
> >>          .free                   =3D vduse_vdpa_free,
> >>   };
> >> --
> >> 2.39.3
> >>
> >
>


