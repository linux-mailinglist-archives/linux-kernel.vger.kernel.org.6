Return-Path: <linux-kernel+bounces-532840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05E0A452C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01E07A2176
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EA6215777;
	Wed, 26 Feb 2025 02:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbgNZCi6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01147212B3E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 02:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535654; cv=none; b=Idgnp4Z1YjvJhVfY65AXDEQj/6M/ZL7p2hp7nzCzyOFBCYzBnn5uBS+Cu+ntA+IyUGgMz/TdMPF2szqN7qAyr7sWFKkYOz1wkiIjEAtttH8VMCHB86qunFaot5O3gTQ128mCEDVZIIYJITjs767tXG5NEADl68AcaXqi1DRJzrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535654; c=relaxed/simple;
	bh=lSp7J4bxnrv7M1UxxUHsdiSDi1QdR8v1dtenvN5jK84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxfpA/iuP1pLJiGgDuTrtBx0owD7wGTaE40w6y49+r0MtlaRDzaaFZvILcMXeRk3sSyxtWXAF6C6Xy7DvozrWgWOLYm8LOCqCTxRsxGNsS/gxcILEr0831yJczkSzVoPMl0Gz6m5HbgRx6vt2br8ik8HcPFM0CkqtGEA140z12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbgNZCi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740535651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JG7Q+eL4jM7YBZuG2KXqZpdxl9mhVQuXYuw+FZgBGk=;
	b=fbgNZCi6NdF4UqkFjDhxc4ym7pYMvtvY2j22xrWBrlySuFGSaDv9xI0GNakaodLoW4l8BF
	RTj64sBFJhVCpDwCTn8fodgo7en0uk9yoOccZt4eu359vOZKxY473obJRm2MqcxRnbdlkC
	JLhcTARMxcDWw5oH29RJowyc2IGFnQI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-ExR8LHcjPfiucCgDNSDPhg-1; Tue, 25 Feb 2025 21:07:29 -0500
X-MC-Unique: ExR8LHcjPfiucCgDNSDPhg-1
X-Mimecast-MFC-AGG-ID: ExR8LHcjPfiucCgDNSDPhg_1740535648
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-abba4c6d9ddso698706166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740535648; x=1741140448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2JG7Q+eL4jM7YBZuG2KXqZpdxl9mhVQuXYuw+FZgBGk=;
        b=RsXw2nkpZUdvFWP6QAAqGeABRyFGFnbCgcryDcgqMYCYlV7cVfhh9jYOOPv1rffHhM
         ufLyPDXK39zUUcD7kEdS81JmeKqAy7s/2hMGrGAaOvqnt342UDZyT/7ld8wYlK3HO6vx
         NnnQRmNRDxe3epyh/pLQMBWadlJssMX/cGL4cOGN+gNzkZbJ5yBZtXcxIJSXi8wwp9uC
         hshQCFg3F5DGgH0sLFCDAKx7B41eB3zoWuFesRjB8ks7PQpsrvU7aeIjNlmv1gyNXNUE
         1ITZobPDReX0CfRkC8WIRPUcEXjkDyxt0mZedQq2jnPLs4hWgJtaSJq0pTntfEhHEdJ9
         vXZg==
X-Forwarded-Encrypted: i=1; AJvYcCWvuP74zFK3Tiv3tLlZgAyWZMBS66xz82IAB6d9YFoPtWhvEofyh76d/bI++9fWbP0cM1zJX98iZ5tLl6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAQnAaqvWGsx9F2ltWYgap6zUOISy2dI6PLjBRhj06l9xFYQib
	TRuy5squ6QZ//ekT67iAv03839TE+AZLyIZfLLb+yzH81r+NVDB1n4i4IoBc6uucsbE8rJpBXC3
	e5pF+geaL/Eti+Qs98GSLrPy6rFnQwT5damkC9XENXKrISJb6hpDlpqjU6Pf48a7zIl3eSzegXq
	xRApL4i3XntcnpTl0OjOJRsfzFcCnSF0jYmg7c
X-Gm-Gg: ASbGncuKl7keFbq8fyQVg9w+JxJIa5ErsVH/OXdQsko3SH9Q0sd3RNcU7drDbCHzMbK
	DvwOXMQTzNAMGjpId9EEJyJEn0+JXnoVVOJqv/IULJhvTj7zuGWeRjgDDmrO88DNGE0o78p8veQ
	==
X-Received: by 2002:a17:907:7e96:b0:ab2:f8e9:723c with SMTP id a640c23a62f3a-abc0d994fb7mr1982520466b.5.1740535648249;
        Tue, 25 Feb 2025 18:07:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE06+V6MjE76MmuEALVfNcGLanur2ISnMZXbkd39Ri9ZvMgwTKtf1MsCh05cwTaiqtezYlZ0ZvUXh0OxB4JO18=
X-Received: by 2002:a17:907:7e96:b0:ab2:f8e9:723c with SMTP id
 a640c23a62f3a-abc0d994fb7mr1982518966b.5.1740535647842; Tue, 25 Feb 2025
 18:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223154042.556001-1-lulu@redhat.com> <20250223154042.556001-5-lulu@redhat.com>
 <CACGkMEvhiq2FWKZwPmemCMq-tcS=HG1MCs8Yyoj_EdOdPBQBHQ@mail.gmail.com>
In-Reply-To: <CACGkMEvhiq2FWKZwPmemCMq-tcS=HG1MCs8Yyoj_EdOdPBQBHQ@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 26 Feb 2025 10:06:50 +0800
X-Gm-Features: AQ5f1Jod8Ea3w_1lg2TzVLpjVF0QiKSzoPlbIDdJIw0Ujqgir6VSrq8jml5tSZY
Message-ID: <CACLfguVoCMpTtf_pNdwHV6xho2V_armxWnLsN4p_S3pM6o7LYA@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] vhost: introduce worker ops to support multiple
 thread models
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, michael.christie@oracle.com, sgarzare@redhat.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:45=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sun, Feb 23, 2025 at 11:41=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >
> > This commit restores the previously removed functions kthread_wakeup an=
d
> > kthread_stop, and introduces a new ops structure to handle worker wakeu=
p,
> > stop, and creation. The function vhost_worker_create initializes these
> > ops pointers based on the inherit_owner value.
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
>
> Patch looks good but I have some some nits:
>
> It might be better to have a separate patch to introduce the ops then
> doing the kthread stuff on top.
>
sure, will do
thanks
cindy
> > ---
> >  drivers/vhost/vhost.c | 115 +++++++++++++++++++++++++++++++++++-------
> >  drivers/vhost/vhost.h |  12 +++++
> >  2 files changed, 110 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index adbb957c8b5f..d8c0ea118bb1 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -243,7 +243,7 @@ static void vhost_worker_queue(struct vhost_worker =
*worker,
> >                  * test_and_set_bit() implies a memory barrier.
> >                  */
> >                 llist_add(&work->node, &worker->work_list);
> > -               vhost_task_wake(worker->vtsk);
> > +               worker->ops->wakeup(worker);
> >         }
> >  }
> >
> > @@ -697,7 +697,7 @@ static void vhost_worker_destroy(struct vhost_dev *=
dev,
> >
> >         WARN_ON(!llist_empty(&worker->work_list));
> >         xa_erase(&dev->worker_xa, worker->id);
> > -       vhost_task_stop(worker->vtsk);
> > +       worker->ops->stop(worker);
> >         kfree(worker);
> >  }
> >
> > @@ -720,42 +720,123 @@ static void vhost_workers_free(struct vhost_dev =
*dev)
> >         xa_destroy(&dev->worker_xa);
> >  }
> >
> > +static void vhost_task_wakeup_fn(struct vhost_worker *worker)
> > +{
> > +       return vhost_task_wake(worker->vtsk);
> > +}
> > +
> > +static void vhost_kthread_wakeup_fn(struct vhost_worker *worker)
> > +{
> > +       wake_up_process(worker->kthread_task);
> > +}
> > +
> > +static void vhost_task_stop_fn(struct vhost_worker *worker)
> > +{
> > +       return vhost_task_stop(worker->vtsk);
> > +}
> > +
> > +static void vhost_kthread_stop_fn(struct vhost_worker *worker)
> > +{
> > +       kthread_stop(worker->kthread_task);
> > +}
> > +
> > +static int vhost_task_worker_create_fn(struct vhost_worker *worker,
> > +                                      struct vhost_dev *dev, const cha=
r *name)
> > +{
> > +       struct vhost_task *vtsk;
> > +       u32 id;
> > +       int ret;
> > +
> > +       vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_ki=
lled,
> > +                                worker, name);
> > +       if (!vtsk)
> > +               return -ENOMEM;
> > +
> > +       worker->vtsk =3D vtsk;
> > +       vhost_task_start(vtsk);
> > +       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > +       if (ret < 0) {
> > +               vhost_task_stop_fn(worker);
> > +               return ret;
> > +       }
> > +       worker->id =3D id;
> > +       return 0;
> > +}
> > +
> > +static int kthread_worker_create_fn(struct vhost_worker *worker,
>
> Let's have a consistent name, e.g vhost_kthread_worker_create.
>
> > +                                   struct vhost_dev *dev, const char *=
name)
> > +{
> > +       struct task_struct *task;
> > +       u32 id;
> > +       int ret;
> > +
> > +       task =3D kthread_create(vhost_run_work_kthread_list, worker, "%=
s", name);
> > +       if (IS_ERR(task))
> > +               return PTR_ERR(task);
> > +
> > +       worker->kthread_task =3D task;
> > +       wake_up_process(task);
> > +       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > +       if (ret < 0)
> > +               goto stop_worker;
> > +
> > +       ret =3D vhost_attach_task_to_cgroups(worker);
> > +       if (ret)
> > +               goto stop_worker;
> > +
> > +       worker->id =3D id;
> > +       return 0;
> > +
> > +stop_worker:
> > +       vhost_kthread_stop_fn(worker);
> > +       return ret;
> > +}
> > +
> > +static const struct vhost_worker_ops vhost_task_ops =3D {
> > +       .create =3D vhost_task_worker_create_fn,
>
> I think we can get rid of the fn suffix as "fn".
>
sure, will do
thanks
Cindy
> > +       .stop =3D vhost_task_stop_fn,
> > +       .wakeup =3D vhost_task_wakeup_fn,
> > +};
> > +
> > +static const struct vhost_worker_ops kthread_ops =3D {
> > +       .create =3D kthread_worker_create_fn,
> > +       .stop =3D vhost_kthread_stop_fn,
> > +       .wakeup =3D vhost_kthread_wakeup_fn,
> > +};
> > +
> >  static struct vhost_worker *vhost_worker_create(struct vhost_dev *dev)
> >  {
> >         struct vhost_worker *worker;
> > -       struct vhost_task *vtsk;
> >         char name[TASK_COMM_LEN];
> >         int ret;
> > -       u32 id;
> > +       const struct vhost_worker_ops *ops =3D
> > +               dev->inherit_owner ? &vhost_task_ops : &kthread_ops;
> >
> >         worker =3D kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> >         if (!worker)
> >                 return NULL;
> >
> >         worker->dev =3D dev;
> > +       worker->ops =3D ops;
> >         snprintf(name, sizeof(name), "vhost-%d", current->pid);
> >
> > -       vtsk =3D vhost_task_create(vhost_run_work_list, vhost_worker_ki=
lled,
> > -                                worker, name);
> > -       if (!vtsk)
> > -               goto free_worker;
> > -
> >         mutex_init(&worker->mutex);
> >         init_llist_head(&worker->work_list);
> >         worker->kcov_handle =3D kcov_common_handle();
> > -       worker->vtsk =3D vtsk;
> > -
> > -       vhost_task_start(vtsk);
> > +       /*
> > +        * If inherit_owner is true we use vhost_tasks to create
> > +        * the worker so all settings/limits like cgroups, NPROC,
> > +        * scheduler, etc are inherited from the owner. If false,
> > +        * we use kthreads and only attach to the same cgroups
> > +        * as the owner for compat with older kernels.
> > +        */
>
> Is this better to move this to the definition of the inherit_owner?
>
sure will do
Thanks
cindy
> >
> > -       ret =3D xa_alloc(&dev->worker_xa, &id, worker, xa_limit_32b, GF=
P_KERNEL);
> > +       ret =3D ops->create(worker, dev, name);
> >         if (ret < 0)
> > -               goto stop_worker;
> > -       worker->id =3D id;
> > +               goto free_worker;
> >
> >         return worker;
> >
> > -stop_worker:
> > -       vhost_task_stop(vtsk);
> >  free_worker:
> >         kfree(worker);
> >         return NULL;
> > diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> > index c650c4506c70..029c203147be 100644
> > --- a/drivers/vhost/vhost.h
> > +++ b/drivers/vhost/vhost.h
> > @@ -26,7 +26,18 @@ struct vhost_work {
> >         unsigned long           flags;
> >  };
> >
> > +struct vhost_worker;
> > +struct vhost_dev;
> > +
> > +struct vhost_worker_ops {
> > +       int (*create)(struct vhost_worker *worker, struct vhost_dev *de=
v,
> > +                     const char *name);
> > +       void (*stop)(struct vhost_worker *worker);
> > +       void (*wakeup)(struct vhost_worker *worker);
> > +};
> > +
> >  struct vhost_worker {
> > +       struct task_struct *kthread_task;
> >         struct vhost_task       *vtsk;
> >         struct vhost_dev        *dev;
> >         /* Used to serialize device wide flushing with worker swapping.=
 */
> > @@ -36,6 +47,7 @@ struct vhost_worker {
> >         u32                     id;
> >         int                     attachment_cnt;
> >         bool                    killed;
> > +       const struct vhost_worker_ops *ops;
> >  };
> >
> >  /* Poll a file (eventfd or socket) */
> > --
> > 2.45.0
> >
>
> Thanks
>


