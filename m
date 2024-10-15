Return-Path: <linux-kernel+bounces-365427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C335C99E221
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B37284001
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4391D5AB4;
	Tue, 15 Oct 2024 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQtherG5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA701CF2B6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728983071; cv=none; b=anNQMq4snqPXUPCmVN9sTqrHFCS268NhFzY9Of8CBalKRy0udAV/iPFVCyKj9XF7EwuMn+VQS6aZFE6Cun5eD8Xz0K9OVV6rtlECFJcVmHKcjtn7sOI13n3quHYKRWrY++q5fyKzUxTwNV8sf9qU2oX6juUr4MM1o3iqriFBfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728983071; c=relaxed/simple;
	bh=7fMVbDZrXTcbhw9XihCX+Md2qAZQzyvDBBbiJB2EPk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsr3KDaecLuvNJeKbt7tWaQupc8BhmYWRcI4SoOfKdkuPKqMtcJktLkqQG/adpjRftrHVUqNSYML2G8phP1MjNQdxZLaQZ0fjbJS6v9UPkPUgiUALDccuu249Qcb6/eBMIR6Ub02P/uXcyoYW/bhPL/P1xVD/tzo5lEopGQz3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQtherG5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728983069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPZWp2QENGOV9PvuYQ/gAGVXqsAfZLS4ikjAsuIINLk=;
	b=JQtherG5n9UuqPcmoqnNa4EpVR29+qSCLiNaGhzOVDwAUN2NYg8GiNirhiMA8BoMvZNMn0
	x9p47KbBVwSrK5emLb5z7QlwzfuNBl+CX6srL6/4M7YBRLUj+sSPZ1DP5FmsyrLGMr7An/
	T9XBvGVtU/rJynEk6y93JjE3oYe3rcs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-6QYffNnQOXSi3QCd48VRgQ-1; Tue, 15 Oct 2024 05:04:27 -0400
X-MC-Unique: 6QYffNnQOXSi3QCd48VRgQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1b872d8bso88978166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728983066; x=1729587866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPZWp2QENGOV9PvuYQ/gAGVXqsAfZLS4ikjAsuIINLk=;
        b=MKUSToFjZzr+o78ISMCclElFvBX4NxrjIROIk3G7+L2loCEP63R1UTHYgmv17+IKSX
         qNW5UWQfSKkG7LwMOdT5UBIC4+97Snh7yF/CQffZibVOO2h/4hVxoDhoDHVUx1s4P1vJ
         0lPrSDepNgnnpD20djvwBq0hhV6munWCnlYSNfdlrP636nuQHlA7fyILf2//8G6TinNw
         A82gbBfQVoUTe5S2pFpW0gMo0/5eWkTrVukB5VmNxMSNsaKpta4qLM/E/M/nPms0iqzu
         KQSvt/XvLIoCOYuiEaZDiH064J85lhjctdZoqL8dThdZTXYqRixDVbmhgJB4yd2yUYD9
         2xOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbDDh8nZuD/Hlyo9VXfvJF0jgnx9c+U/vTo01eb+IHYFwDK9LfuYFBPnzHCjyTt1fR26Nc1Rj/KauZFwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywFvD9qTQ8E0ddTMwxWLbKM7RdxAO5wvvhAGWNmWR+bdWAOfKl
	Nvzl7f+kjmvqIXtN7n76wxLQ7rPkrVNUcmIUgO7ZbGZAGDzmVkpU4fitIcCsGFVBsGxmvjwuvtd
	9OaguZ8aLxfh7r+s43AmzTvG1/YRcIxUooI/Qoyxy4zGFzzvQbMYVy6IKAwdBcvFpw+xz6joVsw
	+3GSmL85woIDeCTBXmRHPPMgwtjBFKDGKN1QvC
X-Received: by 2002:a17:907:d24:b0:a9a:6ab:c93b with SMTP id a640c23a62f3a-a9a06abcce7mr616542466b.62.1728983065808;
        Tue, 15 Oct 2024 02:04:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWjbz9r9M+/Ac/E+vPMTxas+1oH2xSN088iR867d/PS9LzToNr3uZfixPxdwXnafTcGC+TKwWE1WtUmHZt0Lo=
X-Received: by 2002:a17:907:d24:b0:a9a:6ab:c93b with SMTP id
 a640c23a62f3a-a9a06abcce7mr616539866b.62.1728983065368; Tue, 15 Oct 2024
 02:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004015937.2286459-1-lulu@redhat.com> <20241004015937.2286459-5-lulu@redhat.com>
 <dd03e6d2-54e6-487c-8aa8-8a760213a42a@oracle.com>
In-Reply-To: <dd03e6d2-54e6-487c-8aa8-8a760213a42a@oracle.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 15 Oct 2024 17:03:47 +0800
Message-ID: <CACLfguX-pHYpwQZA3QjT+P5Ev-7bPFede=7sBZJzZkE-QsPKxg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] vhost: Add the vhost_worker to support kthread
To: Mike Christie <michael.christie@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Oct 2024 at 06:56, Mike Christie <michael.christie@oracle.com> w=
rote:
>
> On 10/3/24 8:58 PM, Cindy Lu wrote:
> > Add back the previously removed vhost_worker function to support the kt=
hread
> > and rename it vhost_run_work_kthread_list.
> >
> > The old function vhost_worker was change to support task in
> > commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
> > change to xarray in
> > commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray"=
)
> >
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
> >  drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> >
> > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > index fed6671c1ffb..349499139f4f 100644
> > --- a/drivers/vhost/vhost.c
> > +++ b/drivers/vhost/vhost.c
> > @@ -418,6 +418,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> >       __vhost_vq_meta_reset(vq);
> >  }
> >
> > +static int vhost_run_work_kthread_list(void *data)
> > +{
> > +     struct vhost_worker *worker =3D data;
> > +     struct vhost_work *work, *work_next;
> > +     struct vhost_dev *dev =3D worker->dev;
> > +     struct llist_node *node;
> > +
> > +     kthread_use_mm(dev->mm);
> > +
> > +     for (;;) {
> > +             /* mb paired w/ kthread_stop */
> > +             set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +             if (kthread_should_stop()) {
> > +                     __set_current_state(TASK_RUNNING);
> > +                     break;
> > +             }
> > +             node =3D llist_del_all(&worker->work_list);
> > +             if (!node)
> > +                     schedule();
> > +
> > +             node =3D llist_reverse_order(node);
> > +             /* make sure flag is seen after deletion */
> > +             smp_wmb();
> > +             llist_for_each_entry_safe(work, work_next, node, node) {
> > +                     clear_bit(VHOST_WORK_QUEUED, &work->flags);
> > +                     __set_current_state(TASK_RUNNING);
> > +                     kcov_remote_start_common(worker->kcov_handle);
> > +                     work->fn(work);
> > +                     kcov_remote_stop();
> > +                     cond_resched();
> > +             }
> > +     }
> > +     kthread_unuse_mm(dev->mm);
> > +
> > +     return 0;
> > +}
> I think there is a lot of unneeded code duplication where in the function=
s
> you are adding there's only 1-3 lines different. To fix this I think we
> could:
>
Thank you mike=EF=BC=8C I will try this and provide a new version
thanks
cindy
>
> 1. Go really invasive and modify copy_process and its helpers so they tak=
e
> a task_struct instead of using "current". We can then just pass in "curre=
nt"
> or kthreadd. We can then use most of the existing vhost code. We just
> need a per vhost_worker check/field for the mm and cgroup use like:
>
> vhost_task_fn():
> {
> ...
>         /* The mm would be passed in during creation for the kthread case=
 */
>         if (vtsk->mm)
>                 kthread_use_mm(vtsk->mm);
>
> Or
>
> 2. Go hacky and in the vhost code, when we get a VHOST_SET_OWNER call cre=
ate
> a tmp kthread. The tmp kthread would then call the existing vhost_worker_=
create
> function. The resulting vhost_task would inherit the kthreadd settings li=
ke we
> want. We then just need a per vhost_worker check/field for the mm and cgr=
oup use
> like above.
>
> Or
>
> 3. There doesn't seem to be a lot of differences in the functions you are
> adding. In the function above the only differences are the mm calls and k=
thread
> should stop. In the destroy functions it's kthread_stop. In the queue fun=
ction its
> wake_up_process. In create its kthread_create, stop and the cgroup functi=
ons.
>
> I think we could add just some callouts on the vhost_task or vhost_worker=
 for stop,
> wakeup and use mm. For create we would do something like
>
> vhost_worker_create()
> ....
>         worker =3D kzalloc();
>
>         if (inherit from caller) {
>                 worker->stop =3D vhost_task_stop;
>                 worker->wakeup =3D vhost_task_wakeup;
>
>                 worker->vtsk =3D vhost_task_create();
>         } else {
>                 worker->stop =3D vhost_kthread_stop;
>                 worker->wakeup =3D vhost_kthread_wakeup;
>
>                 worker->tsk =3D kthread->create();
>                 vhost_kthread_setup_cgroups();
>         }
> ...
> }
>
> vhost_worker_destroy()
> {
>         if (!worker)
>                 return;
>
>         WARN_ON(!llist_empty(&worker->work_list));
>         xa_erase(&dev->worker_xa, worker->id);
>         worker->stop(worker);
>         kfree(worker);
> }
>
>


